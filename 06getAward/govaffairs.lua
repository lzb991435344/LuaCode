--政务系统
require "class"
local skynet = require "skynet"
local tablex = require "tablex"
local time = require "time"
local timer = require "timer"
local redis = require "redis"
require "class_common_sql"
local norfunc = require "normal_functions"
require "TcGovAffairs"
local cfg = require "TcLvUpgradeCfg"
local bag = require "bag"
local svid = tonumber(skynet.getenv("svid")) or 0

local govaffairs = class()

function govaffairs:ctor(player)
    self.player = player
    self._dayDealTimes = 0
    self.updateAffairNumTimer = timer.new()
    local iterm = self.player.bag:getItem()
    self._totalCommercial = iterm[2]
    self._totalAgricultural = iterm[3]
    self._totalPolicy = iterm[4]
    self._affairsRestCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
    self.player.eventRecord = {
        current_event_id = norfunc.random_xy(1, 30), --当前时事件ID
        specialTimes = 0, --特殊事件的次数
        before_event_id = 0, --上一件事件ID
        times = 1, --已处理的事件的次数
        dayMaxTimes = 10, --每天处理的上限
        lastFleshTime = time:get_yesterday() --上次刷新的时间，判断跨天处理使用
    }
end

--获取当前等级对应的处理上限
function govaffairs:getTotalAffairNum()
    local lv = self.player.lv
    local totalAffairsCount = 0
    if cfg then
        for _, v in pairs(cfg) do
            if lv == v.lv then
                totalAffairsCount = v.gov_event_times
                break
            end
        end
    end
    return totalAffairsCount
end

--获取普通事件和特殊事件ID
function govaffairs:getCommonSpecialEventId()
    local commonCfg = {}
    local specialCfg = {}
    local acfg = TcGovAffairs
    if acfg then
        for k, v in pairs(acfg.govEvent) do
            if v.id >= 1000 and #v.next_id > 0 then
                --table.insert(specialCfg, v.id)
                table.insert(specialCfg, v.next_id[1])
                table.insert(specialCfg, v.next_id[2])
            else
                table.insert(commonCfg, v.id)
            end
        end
    end
    skynet.error("---------"..tablex.tostring(specialCfg))
    return commonCfg, specialCfg
end

--下发界面信息
function govaffairs:sendGovAffairsInfo()
    local data = {}
    local acfg = TcGovAffairs
    local totalAffairsCount = self:getTotalAffairNum()

    --TODO：先设置为30s
    local cooltime = 0
    if self._affairsRestCount < totalAffairsCount then
        --cooltime = acfg.cooltime
        cooltime = 30
    end

    if self._affairsRestCount < totalAffairsCount then
        self:updateGovAffairTimes()
    end
    local currentAffairsCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
    --local index = self.player.eventRecord.current_event_id
    local index = norfunc.random_xy(1, 30)

    skynet.error("----index---" .. index)
    skynet.error("----index111---" .. index)
    local itermid = self:getEventMesageById(index)
    local firstReward = self:getCommonEventReward(itermid, 1, 1)
    local secondReward = self:getCommonEventReward(itermid, 2)
    skynet.error("111111111111111")
    data = {
        currentAffairsID = index,
        currentAffairsCount = currentAffairsCount,
        totalAffairsCount = totalAffairsCount,
        firstReward = {firstReward},
        secondReward = {secondReward},
        time = cooltime
    }

    return data
end

--处理普通事件
function govaffairs:dealNorEvent(t)
    local data = {}
    --local itermid = self:getEventMesageById(t.currentAffairsID)
    skynet.error("----current_event_id---" .. t.currentAffairsID)
    local itermid = self:getEventMesageById(t.currentAffairsID)
    --data = self:getCommonEventReward(itermid, t.optType)
    local reward = self:getCommonEventReward(itermid, t.optType, 1)
    local cooltime = 0
    local govCfg = TcGovAffairs
    local errMsg = ""
    if self._affairsRestCount == 0 then
        cooltime = govCfg.cooltime
        errMsg = "处理政务次数不足"
    end

    local nextAffairsID = self:getNextEventId()
    local firstReward = {}
    local secondReward = {}
    local commonIds,specialIds = self:getCommonSpecialEventId()
    if norfunc.is_has(specialIds, nextAffairsID) then
        skynet.error("-------test1----")
        local lastAffairsId = self:getLastSpecialId()
        if norfunc.is_has(lastAffairsId, t.currentAffairsID) then
            nextAffairsID = norfunc.random_xy(1, 30)
        else
            nextAffairsID = nextAffairsID + 1
        end
        --local itermid1 = self:getEventMesageById(nextAffairsID)
        local currentAffairsRestCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
        nextAffairsID,firstReward,secondReward = self:getSpecialEventReward(nextAffairsID, 1)
        ---secondReward = self:getSpecialEventReward(nextAffairsID, 2)

        self:reduceAffairCount()
        data = {
            currentReward = {reward},
            firstReward = {firstReward},
            secondReward = {secondReward},
            currentAffairsRestCount = self._affairsRestCount,
            nextAffairsID = nextAffairsID,
            time = cooltime,
            errMsg = errMsg
        }
        return data
    else
         skynet.error("-------test2----")
        nextAffairsID = self:getID(commonIds)
       local itermid2 = self:getEventMesageById(nextAffairsID)
        firstReward = self:getCommonEventReward(itermid2, 1, 1)
        secondReward = self:getCommonEventReward(itermid2, 2, 1)
    end
    --local nextAffairsID = self.player.eventRecord.current_event_id
    skynet.error("----nextAffairsID---"..tablex.tostring(nextAffairsID))
    self:changeEventMsg(self.player.eventRecord.current_event_id, nextAffairsID)
    if reward.value > 0 then
        self.player.bag:receiveItme(reward.itermid, reward.value)
    end
    self.player.eventRecord.dayMaxTimes = self.player.eventRecord.dayMaxTimes - 1
    if not self.player.eventRecord.dayMaxTimes then
        errMsg = "处理政务次数已达上限"
    end
    self:reduceAffairCount()
    local currentAffairsRestCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
     skynet.error("2222222222222")
    data = {
        currentReward = {reward},
        firstReward = {firstReward},
        secondReward = {secondReward},
        currentAffairsRestCount = self._affairsRestCount,
        nextAffairsID = nextAffairsID,
        time = cooltime,
        errMsg = errMsg
    }
    return data
end

--获取玩家收益率，读取升官配置表
function govaffairs:getProfitRate()
    local lv = self.player.lv

    local profitRate = 0
    if cfg then
        for k, v in pairs(cfg) do
            if lv == v.lv then
                profitRate = v.gov_achievement_rate
                break
            end
        end
    end
    return profitRate
end

--定时更新政务次数
function govaffairs:updateGovAffairTimes()
    local affairsRestKey = "_affairsRest" .. tostring(svid) .. "|" .. tostring(self.player.uid)

    local currentAffairCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
    local totalAffairsCount = self:getTotalAffairNum()

    local changeNum = totalAffairsCount - currentAffairCount
    local govCfg = TcGovAffairs
    --local cooltime = govCfg.cooltime

    --TODO:测试先改为30s
    local cooltime = 30
    if changeNum > 0 and not (self.updateAffairNumTimer.is_started()) then
        self.updateAffairNumTimer.start(
            cooltime,
            changeNum,
            function()
                skynet.send(DB_ADDR, "lua", "addAffairKey", self.player.uid)
                local currentAffairsRestCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
                local ret = {
                    currentAffairsID = 0,
                    currentAffairsCount = currentAffairsRestCount,
                    totalAffairsCount = 0,
                    firstReward = {},
                    secondReward = {},
                    time = 0
                }
                self._affairsRestCount = self._affairsRestCount + 1
                self.player:send("S2C_GOVAFFAIRS_INFO", ret)
            end
        )
    end
end

function govaffairs:dealSpeEvent(t)
    local data = {}
    local errMsg =""
    local cooltime = 0
    local govCfg = TcGovAffairs
    if self._affairsRestCount == 0 then
        cooltime = govCfg.cooltime
        errMsg = "处理政务次数不足"
    end
    if t.optType == 1 then
        local itermid = self:getEventMesageById(t.currentAffairsID)
        local reward = self:getCommonEventReward(itermid, 1, 1)
        local nextAffairsID,firstReward,secondReward = self:getSpecialEventReward(t.currentAffairsID, t.specialOptType)
        self:reduceAffairCount()
        --local currentAffairCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)

        data = {
        currentReward = {reward},
        firstReward = {firstReward},
        secondReward = {secondReward},
        currentAffairsRestCount = self._affairsRestCount,
        nextAffairsID = nextAffairsID,
        time = cooltime,
        errMsg = errMsg
    }
    elseif t.optType == 2 then
        local itermid = self:getEventMesageById(t.currentAffairsID)
        local reward = self:getCommonEventReward(itermid, 1, 1)
        local nextAffairsID,firstReward,secondReward = self:getSpecialEventReward(t.currentAffairsID, t.specialOptType)

        self:reduceAffairCount()
        --local currentAffairCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
        data = {
        currentReward = {reward},
        firstReward = {firstReward},
        secondReward = {secondReward},
        currentAffairsRestCount = self._affairsRestCount,
        nextAffairsID = nextAffairsID,
        time = cooltime,
        errMsg = errMsg
    }
    end
    return data
end

--获取普通事件奖励
function govaffairs:getCommonEventReward(itermid, option, options)
    local reward = {}
    local changeValue
    local profitRate = self:getProfitRate()
    if option == 1 then --选项一奖励
        if itermid == 2 then
            if not options then
                changeValue = self._totalCommercial
            else
                changeValue = math.floor(self._totalCommercial * profitRate + 5000)
                self._totalCommercial = self._totalCommercial + changeValue
                self.player.bag:receiveItme(itermid, changeValue)
            end
            reward = {itermid = 2, value = changeValue}
        elseif itermid == 3 then
            if not options then
                changeValue = self._totalAgricultural
            else
                changeValue = math.floor(self._totalAgricultural * profitRate + 5000)
                self._totalAgricultural = self._totalAgricultural + changeValue
                self.player.bag:receiveItme(itermid, changeValue)
            end
            reward = {itermid = 3, value = changeValue}
        elseif itermid == 4 then
            if not options then
                changeValue = self._totalPolicy
            else
                changeValue = math.floor(self._totalPolicy * profitRate + 5000)
                self._totalPolicy = self._totalPolicy + changeValue
                self.player.bag:receiveItme(itermid, changeValue)
            end
            reward = {itermid = itermid, value = changeValue}
        elseif (itermid == 205 or itermid == 210 or itermid == 215) then
            reward = {itermid = itermid, value = 1}
            self.player.bag:receiveItme(itermid, 1)
        elseif itermid == 0 then
            reward = {itermid = 0, value = 0}
        elseif itermid == 5 then
            reward = self:getGovAchieveAward()
        end
    elseif option == 2 then --选项二奖励
        reward = self:getGovAchieveAward()
    end
    return reward
end

--下发政绩奖励
function govaffairs:getGovAchieveAward()
    local reward = {}
    local lv = self.player.lv

    local profitChangeValue = 0
    if cfg then
        for k, v in pairs(cfg) do
            if lv == v.lv then
                profitChangeValue = v.gov_achievement
                break
            end
        end
    end
    reward = {itermid = 5, value = profitChangeValue}
    return reward, profitChangeValue
end

--获取特殊事件的奖励
function govaffairs:getSpecialEventReward(currentAffairsID, specialOptType)
    local data = {}
    local reward = {}
    local errMsg = ""
    local commonIds,specialIds = self:getCommonSpecialEventId()
    local cooltime = 0
    local govCfg = TcGovAffairs
    if self._affairsRestCount == 0 then
        cooltime = govCfg.cooltime
        errMsg = "处理政务次数不足"
    end

    if specialOptType == 1 then
        --当前的奖励
        --判断是否在特殊事件的列表里
        --[[if norfunc.is_has(specialIds, currentAffairsID) then
            --当前的奖励的itermId
            local itermid = 0
            reward = {itermid = 0, value = 0} --空奖励
            local firstReward = {itermid = 0, value = 0}
            local secondReward = {itermid = 0, value = 0}
            --下一个事件的Id
            local nextAffairsID = currentAffairsID + 1 --1001
            self:reduceAffairCount()
            data = {
                currentReward = {reward},
                firstReward = {firstReward},
                secondReward = {secondReward},
                currentAffairsRestCount = self._affairsRestCount,
                nextAffairsID = nextAffairsID,
                time = cooltime
            }
        else]]--
            --1001
            --local itermid = self:getEventMesageById(currentAffairsID)
            --local reward = self:getCommonEventReward(itermid, 1, 1)
            local nextAffairsID
            local lastAffairsId = self:getLastSpecialId()
            skynet.error("------lastAffairsId---"..tablex.tostring(lastAffairsId))
            if norfunc.is_has(lastAffairsId, currentAffairsID) then
                nextAffairsID = norfunc.random_xy(1, 30)
            else
                nextAffairsID = currentAffairsID + 1
            end

            local itermid1 = self:getEventMesageById(nextAffairsID)

            skynet.error("------itermid1---"..itermid1)
            if itermid1 == 0 then
                itermid1 = norfunc.random_xy(2,4)
            end
            local firstReward = self:getCommonEventReward(itermid1, 1, 1)
            local secondReward = self:getCommonEventReward(itermid1, 2, 1)
           --[[ self:reduceAffairCount()
             skynet.error("333333333333333")
            data = {currentReward = {reward},firstReward = {firstReward},secondReward = {secondReward},
                currentAffairsRestCount = self._affairsRestCount,nextAffairsID = nextAffairsID,
                time = cooltime}

            if reward.value > 0 then
                self.player.bag:receiveItme(reward.itermid, reward.value)
            end
            self.player.eventRecord.dayMaxTimes = self.player.eventRecord.dayMaxTimes - 1
            if not self.player.eventRecord.dayMaxTimes then
                errMsg = "处理政务次数已达上限"
            end]]
            return nextAffairsID,firstReward,secondReward
        --end
    elseif specialOptType == 2 then
        --[[if norfunc.is_has(specialIds, currentAffairsID) then
            --当前的奖励的itermId
            local itermid = 0
            reward = {itermid = 0, value = 0} --空奖励
            local firstReward = {itermid = 0, value = 0}
            local secondReward = {itermid = 0, value = 0}
            --下一个事件的Id
            local nextAffairsID = currentAffairsID + 1 --1001
            self:reduceAffairCount()
            data = {
                currentReward = {reward},
                firstReward = {firstReward},
                secondReward = {secondReward},
                currentAffairsRestCount = self._affairsRestCount,
                nextAffairsID = nextAffairsID,
                time = cooltime
            }
        else]]--
            --1001
            local itermid = 5
            local reward = self:getCommonEventReward(itermid, 2, 1)
            local nextAffairsID
            local lastAffairsId = self:getLastSpecialId()
            if norfunc.is_has(lastAffairsId, currentAffairsID) then
                nextAffairsID = norfunc.random_xy(1, 30)
            else
                nextAffairsID = currentAffairsID + 1
            end

            local itermid1 = self:getEventMesageById(nextAffairsID)
            if itermid1 == 0 then
                itermid1 = norfunc.random_xy(2,4)
            end
            local firstReward = self:getCommonEventReward(itermid1, 1, 1)
            local secondReward = self:getCommonEventReward(itermid1, 2, 1)
            --[[self:reduceAffairCount()
             skynet.error("44444444444444")
            data = {
                currentReward = {reward},
                firstReward = {firstReward},
                secondReward = {secondReward},
                currentAffairsRestCount = self._affairsRestCount,
                nextAffairsID = nextAffairsID,
                time = cooltime
            }

            if reward.value > 0 then
                self.player.bag:receiveItme(reward.itermid, reward.value)
            end
            self.player.eventRecord.dayMaxTimes = self.player.eventRecord.dayMaxTimes - 1
            if not self.player.eventRecord.dayMaxTimes then
                errMsg = "处理政务次数已达上限"
            end]]

            return nextAffairsID,firstReward,secondReward
        --end
    end
    --return data
end

--获取itemId
--param:当前的事件ID
function govaffairs:getEventMesageById(currentAffairsId)
    local itemId
    local Govfg = TcGovAffairs
    if Govfg then
        for k, v in pairs(Govfg.govEvent) do
            if v.id == currentAffairsId then
                itemId = v.item_id
                break
            end
        end
    end
    return itemId
end

--随机取到表中的值
function govaffairs:getID(t)
    local nextId
    local index = norfunc.random_xy(1, #t)
    if t then
        for k, v in pairs(t) do
            if k == index then
                nextId = v
                break
            end
        end
    end
    return nextId
end

function govaffairs:reduceAffairCount()
    self._affairsRestCount = self._affairsRestCount - 1
    if self._affairsRestCount <= 0 then
        self._affairsRestCount = 0
    end
    skynet.send(DB_ADDR, "lua", "govaffair_redis", "set", 3, self.player.uid, self._affairsRestCount)
end

--获取特殊事件的第二个id
function govaffairs:getLastSpecialId()
    local lastAffairsId = {}
    local acfg = TcGovAffairs
    local rate
    for k, v in pairs(acfg.govEvent) do
        if #v.next_id > 0 then
            table.insert(lastAffairsId, v.next_id[2])
        end
    end
    return lastAffairsId
end

--获取下一个政务ID
function govaffairs:getNextEventId()
    local nextAffairsId
    local acfg = TcGovAffairs
    local rate
    for k, v in pairs(acfg.govSpecialEventRate) do
        if v.times == self.player.eventRecord.times then
            rate = v.rate
            break
        end
    end
    local commonIds,specialIds = self:getCommonSpecialEventId()
    local isNewDay = time:get_day(time:get_now()) - time:get_day(self.player.eventRecord.lastFleshTime)
    skynet.error("---isNewDay---" .. isNewDay)
    if isNewDay then
        self.player.eventRecord.specialTimes = 0
        self.player.eventRecord.dayMaxTimes = 10
    end

    skynet.error("-----rate----" .. rate)
    if self.player.eventRecord.specialTimes < 5 and norfunc.random_xy(1, 100) <= rate then --选择特殊事件
        self.player.eventRecord.specialTimes = self.player.eventRecord.specialTimes + 1
        nextAffairsId = self:getID(specialIds)
    else --选择普通事件
        nextAffairsId = self:getID(commonIds)
    end
    return nextAffairsId
end

--修改缓存信息
function govaffairs:changeEventMsg(currentAffairsID, nextAffairsId)
    self.player.eventRecord.before_event_id = currentAffairsID
    self.player.eventRecord.current_event_id = nextAffairsId
    local commonIds = self:getCommonSpecialEventId()
    if norfunc.is_has(commonIds, nextAffairsId) then --在普通事件里面
        --times处理过的事件的总数
        self.player.eventRecord.times = self.player.eventRecord.times + 1
        if self.player.eventRecord.times > 5 then
            self.player.eventRecord.times = 1
        end
    else --在特殊事件里面,首次不减去次数
        self.player.eventRecord.before_event_id = currentAffairsID
        self.player.eventRecord.times = 1
    end
end

--使用政务令牌道具
--id:509   cnt:数量
function govaffairs:useGovAffairsToken(id, cnt)
    local data = {changeCount = 0, restCount = 0,isSuccess = false, errMsg = ""}
    local changeCount
    local totalCount = self:getTotalAffairNum()
    if cnt >= totalCount then
        changeCount = totalCount
    else
        changeCount = cnt
    end
    if not self.player.bag:checkItems({[id]=changeCount}) then
        data.errMsg = "政务令不足"
        return data
    end
    self.player.bag:selfUseItemById(id, changeCount)
    self._affairsRestCount = self._affairsRestCount + cnt
    if self._affairsRestCount > totalCount then
        self._affairsRestCount = totalCount
        self.updateAffairNumTimer.cancel()
    end
    skynet.send(DB_ADDR, "lua", "govaffair_redis", "set", 3, self.player.uid, self._affairsRestCount)
    local restCount = skynet.call(DB_ADDR, "lua", "govaffair_redis", "get", 3, self.player.uid)
    data = {changeCount = changeCount,restCount = restCount,isSuccess = true, errMsg = ""}
    return data
end

return govaffairs
