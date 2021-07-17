

local room = {

}


local _users = {
  {money=40000,confInfo={topLimit=40000,baseScore=20}, continueFail = 0, continueWin = 0, totalPlayCount = 0, dayCount = 0},
  {money=22000,confInfo={topLimit=40000,baseScore=20}, continueFail = 0, continueWin = 0, totalPlayCount = 0, dayCount = 0},
  {money=20000,confInfo={topLimit=40000,baseScore=20}, continueFail = 0, continueWin = 0, totalPlayCount = 0, dayCount = 0}
}
    

local g = {
  dzSid = 1,
  szCoef = {10000,5000,5000},
  seats = {{true} , {false}, {false}},
  szUidCoef = {10000,5000,5000},
  szSpringCount = 0,
  szMultiple ={{1},{1},{1}},
  szWinCoin ={{0},{0},{0}}
}


--打印表操作
function ttostring(t)
    if not t then
        return "nil"
    end

	if type(t)~="table" then
		return tostring(t)
	end

	local function ser_table(tbl)
		local tmp = {}
		for k,v in pairs(tbl) do
			local key = type(k)=="number" and "["..k.."]" or k
			local tp = type(v)
			if tp=="table" then
				table.insert(tmp, key.."="..ser_table(v))
			else
				if tp=="string" then
					table.insert(tmp, key.."="..string.format("%q",v))
				elseif tp=="boolean" then
					table.insert(tmp, key.."="..tostring(v))
                elseif tp=="function" then
                    --函数不打印
				else
					table.insert(tmp, key.."="..v)
				end
			end
		end
		return "{"..table.concat(tmp,",").."}"
	end

	return ser_table(t)
end


--结算游戏豆计算
function room:settlement_compute(winSid)
	--local g = self._game
	local szWinGameBeans = {}     --所有农民根据倍数输或者赢的游戏豆
	local realWinGameBeans = {}	  --所有农民实际输或者赢的游戏豆  --或地主
	local nongMinRealGB = 0  	  --所有农民实际输或者赢的游戏豆的总和
	local totalIsTopLimit = false --输赢是否超过限制的封顶
	local sidIsTopLimit = {}   	  --每个玩家是否达到封顶
	local sidIsBankrupt = {}      --每个玩家是否破产
	local peasantCount = 2        --农民的数量
	local pChangeGameBeans ={}    --农民赢或者输改变游戏豆的变化 
	local szFullWin = {}          --是否赢不够,也就是农民或者地主不够输
	local szWinCoinFull = {}      --赢不够的时候,除了已经给的那些，还需要补偿多少
	local topLimitValue = 0
	
	--if GAME.FOUR50 == self._gameType or GAME.FOUR51 == self._gameType or 
	--   GAME.FOUR52 == self._gameType then
	--   	peasantCount = 3
	--end
	--self:log("settlement_compute winSid="..tostring(winSid).."gameType="..tostring(self._gameType))



   --print(ttostring(_users))

	--初始化以上诸表
	for sid,u in pairs(_users) do 
 		--print(ttostring(u))

 		--print(sid)
		sidIsTopLimit[sid] = false
		sidIsBankrupt[sid] = false
		szFullWin[sid] = false
		szWinCoinFull[sid] = 0

		--print(ttostring(u))
		--print(next(cInfo))
		local cInfo = u.confInfo
		--print(ttostring(u.confInfo))
		topLimitValue =  cInfo.topLimit
	
		


		--根据倍数算出实际的输赢
    	szWinGameBeans[sid] = g.szCoef[sid] * cInfo.baseScore
    	--szWinGameBeans[sid] = g.szCoef[sid] * 1 --baseScore



    	--确定玩家实际能赢或者输的游戏豆 
    	--和实际账户中的money比较
    	if szWinGameBeans[sid] > u.money then
    		realWinGameBeans[sid] = u.money
    	else
    		realWinGameBeans[sid] = szWinGameBeans[sid]
    	end



    	--计算所有农民实际能赢或者输的游戏豆
    	if sid ~= g.dzSid then
    		--农民所有的游戏豆
    		nongMinRealGB = nongMinRealGB + realWinGameBeans[sid]
    	end
	end


 
 	--self:log("szWinGameBeans="..tablex.tostring(szWinGameBeans).."realWinGameBeans="..tablex.tostring(realWinGameBeans))
	if winSid == g.dzSid then
		--地主赢

		--地主本身最大的豆的数量
		local dzMaxCanWin = realWinGameBeans[winSid]
		--local u = self._users[winSid]

		--赢的那个人实际账户中能抵扣的数量
		local dzCanWin = realWinGameBeans[winSid]


		

 		--地主赢两倍的封顶
		local doubleTopLimitValue = 2 *  topLimitValue

		if doubleTopLimitValue ~= 0 then 
			if  dzCanWin < nongMinRealGB then 
				
				--2倍封顶值 < 能赢的豆子 < 农民所有的总和
				if doubleTopLimitValue < dzCanWin then 
					totalIsTopLimit = true
					
					realWinGameBeans[winSid] = doubleTopLimitValue
				else

					--自身豆子值的限制，赢封顶，设置标志位
					realWinGameBeans[winSid] = dzCanWin

					sidIsTopLimit[winSid] = true
				end
			else
				
				--2倍封顶值 > 农民所有的总和    地主能赢的值 > 农民所有的总和
			   	if doubleTopLimitValue > nongMinRealGB then
			   		realWinGameBeans[winSid] = nongMinRealGB
					
			   	else --2倍封顶值 < 农民所有的总和
			   		realWinGameBeans[winSid] = doubleTopLimitValue
			   	end	
			end
		end
	

		--新逻辑增加代码
		--if topLimitValue ~= 0 and dzCanWin >= 2 * topLimitValue then 
		--	totalIsTopLimit = true
		--	realWinGameBeans[winSid] = 2 * topLimitValue	
		--end

	


		--向下取整数 floor地板   ceil 天花板
		local averageWin = math.floor(realWinGameBeans[winSid]/peasantCount)
		if realWinGameBeans[winSid] % peasantCount == 0 then
			averageWin = averageWin + 1
		end



		if realWinGameBeans[winSid] < nongMinRealGB then
			--地主赢封顶	
			szFullWin[winSid] = true
			--表中改变的游戏豆的值
			pChangeGameBeans[winSid] = realWinGameBeans[winSid]
			local existUseSid = {}
			local useLose = 0



			for i = 1, peasantCount do
				local minLose = 0
				local minSid = 0
				--先获取最小的那个玩家
				for sid,v in pairs(realWinGameBeans) do
					--print(ttostring(realWinGameBeans))
					if sid ~= g.dzSid and existUseSid[sid] == nil and 
					   (minLose == 0 or minLose > v) then
						minLose = v
						minSid = sid
					end
				end

				--找到minSid 
				if minSid > 0 then
					existUseSid[minSid] = false

					--最少游戏豆的玩家 > 输掉游戏豆的平均值
					if averageWin < minLose then
						--改变的游戏豆值为平均值
						pChangeGameBeans[minSid] = averageWin
					else
						--平均值较大，最少游戏豆的玩家破产

						sidIsBankrupt[minSid] = true  --破产标志位
						pChangeGameBeans[minSid] = minLose  --更新改变的游戏豆大小
						useLose = useLose + minLose  


						--除去最小的玩家后,剩下的再继续平分一下
						if peasantCount - i > 1 then
							local sDZWinGameBeans = realWinGameBeans[winSid] - useLose
							averageWin= math.floor(sDZWinGameBeans / (peasantCount - i))
						else 
							averageWin = realWinGameBeans[winSid] - useLose
						end
					end
				end
			end 
		else
			--print("1",realWinGameBeans[winSid],nongMinRealGB)

			--地主赢的游戏豆 > 实际上农民有的豆
			pChangeGameBeans[winSid] = nongMinRealGB
			for sid,v in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then
					pChangeGameBeans[sid] = v

					--new code
					if averageWin >= realWinGameBeans[sid] then 
						sidIsBankrupt[sid] = true
					end	
				end
			end

			--需要补偿的值
			--地主的实际值减去农民总共的值
			szWinCoinFull[winSid] = dzMaxCanWin - nongMinRealGB
		end
	else
		--农民赢
		if topLimitValue ~= 0 and nongMinRealGB > topLimitValue and 
		   realWinGameBeans[g.dzSid] > topLimitValue then
		    --农民在该场赢到了封顶
			totalIsTopLimit = true
			nongMinRealGB = topLimitValue
			realWinGameBeans[g.dzSid] = topLimitValue
		end

		--农民实际的总和 > 地主所有的游戏豆的总和
		if nongMinRealGB >= realWinGameBeans[g.dzSid] then
			--地主不够输
			--农民能赢的金币大于地主能输的金币,地主破产
			if nongMinRealGB > realWinGameBeans[g.dzSid] then

				--破产标志位
				sidIsBankrupt[g.dzSid] = true	
			end


			pChangeGameBeans[g.dzSid] = realWinGameBeans[g.dzSid]

			--平均分配
			local averageWin = math.floor(realWinGameBeans[g.dzSid] / peasantCount)

			--向上取整，能平均
			if realWinGameBeans[g.dzSid] % peasantCount == 0 then
				averageWin = averageWin + 1
			end

			--无法平均分配，即有余数
            local existUseSid = {}
			local useLose = 0
			for i = 1, peasantCount do
				local minLose = 0
				local minSid = 0
				--先获取最小的那个玩家，记录实际的游戏豆和索引值
				for sid,v in pairs(realWinGameBeans) do
					if sid ~= g.dzSid and existUseSid[sid] == nil and 
					   (minLose==0 or minLose > v) then
						minLose = v
						minSid = sid
					end
				end
				--找到有效的下标值
				if minSid > 0 then
					existUseSid[minSid] = false
					if averageWin < minLose then --平均值较小，农民未赢封顶
						pChangeGameBeans[minSid] = averageWin

						--需要补充的豆子数
						szWinCoinFull[minSid] = minLose - averageWin
					else  --平均值较大，农民个人赢封顶
						
						szFullWin[minSid] = true
						--农民个人封顶
						sidIsTopLimit[minSid] = true

						--改变的数量是实际上有的豆子数
						pChangeGameBeans[minSid] = minLose
						useLose = useLose + minLose
						--除去最小的玩家后,剩下的再继续平分一下

						if peasantCount - i > 1 then --当斗地主人数大于3人的时候

							local sDZWinGameBeans = realWinGameBeans[g.dzSid] - useLose
							
							averageWin= math.floor(sDZWinGameBeans/(peasantCount - i))
						else 
							--3人的斗地主
							averageWin = realWinGameBeans[g.dzSid] - useLose
						end
					end
				end
			end
		else
			--农民实际上赢的 < 地主拥有的
			--农民赢的
			pChangeGameBeans[g.dzSid] = nongMinRealGB
			for sid,v in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then
					--赋值游戏豆变化的实际值，{sid1 = xxx, sid2 = xxx}
					pChangeGameBeans[sid] = v
				end
			end 
		end
	end
	return pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull
end


--[[
local pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull = room:settlement_compute(2)




-print("pChangeGameBeans", ttostring(pChangeGameBeans))
print("totalIsTopLimit", totalIsTopLimit)
print("sidIsTopLimit", ttostring(sidIsTopLimit))
print("sidIsBankrupt", ttostring(sidIsBankrupt))
print("szFullWin", ttostring(szFullWin))

print("szWinCoinFull", ttostring(szWinCoinFull))

]]


--**********************************************
--**函数功能:欢乐玩法的结算
--**参数:winSid-赢到座位id,  lastCards-最后打出的一手牌
--**********************************************
--排位赛的结算
--function room:settle_happy_game(winSid,lastCards,lastTzz)
function room:settle_happy_game(winSid)
  --local g           = self._game
  local sidWin      = {false,false,false}      --是否胜利
  local nSidWin     = {-1,-1,-1}     --是否胜利
  --包含负数值
  local sidCoin     = {0,0,0} --本局金币的变化
  local sidBankrupt = {false,false,false}
  local sidCanNext  = {true,true,true} 
  local szGetMaxFJ   = {0,0,0}
  --春天
  local spring = false
  if g.seats[1].spring or g.seats[2].spring or g.seats[3].spring then
     spring = true
     local curCoef = 2
     g.springMultiple = curCoef
     --for sid1,u in pairs(self._users) do
      for sid1,u in pairs(_users) do
         g.szCoef[sid1] = g.szCoef[sid1] * curCoef
         g.szUidCoef[u.uid] = g.szCoef[sid1]
         --skynet.send(u.addr, "lua","update_coef_result",g.szCoef[sid1],curCoef)
     end

     --log当前的倍数表  
     --self:log("settle_happy_game update_coef_result, "..tablex.tostring(g.szCoef))
  end

  --self:update_only_robot_to_rmgr()

  --缓存纪录春天的信息
  --local log = string.format("{8,%d,%s,%s,%s}", os.time()-g.startTime,
  --      g.seats[1].spring, g.seats[2].spring, g.seats[3].spring)
  --插入log表中
  --table.insert(self._logs, log)

  --self:log("settle_happy_game coef="..tablex.tostring(g.szCoef))

  local pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull = self:settlement_compute(winSid)
  local winMoney = 0

  --地主赢的情况
  if winSid == g.dzSid then
    --local u = self._users[winSid]
    local u = _users[winSid]
    u.continueFail = 0
    u.continueWin = u.continueWin + 1
    --统计是否是春天
    if spring then
       g.szSpringCount[winSid] = 1
    end
    sidWin[winSid] = true
    nSidWin[winSid] = 1
    sidCoin[winSid] = pChangeGameBeans[winSid]

    --剩下输掉的两个玩家
    --for sid,u1 in pairs(self._users) do
    for sid,u1 in pairs(_users) do
      --说明已经输了
      if sid ~= winSid then
        u1.continueWin = 0
        u1.continueFail = u1.continueFail + 1
        sidWin[sid] = false
        nSidWin[sid] = -1

        --扣掉输掉的豆子
        sidCoin[sid] = -pChangeGameBeans[sid]
      end
    end

  else
    --地主输
    --local uDz = self._users[g.dzSid]
    local uDz = _users[g.dzSid]
    uDz.continueFail = uDz.continueFail + 1
    uDz.continueWin = 0
    sidWin[g.dzSid] = false
    nSidWin[g.dzSid] = -1
    sidCoin[g.dzSid] = -pChangeGameBeans[g.dzSid]


    --for sid,u in pairs(self._users) do
    for sid,u in pairs(_users) do
      --赢的2位玩家 
      if sid ~= g.dzSid then
        --打出春天的标志位
        if spring then
           g.szSpringCount[sid] = 1
        end

        --增加豆子
        --更新游戏豆，赢的次数，位置赢的标志位 
        sidCoin[sid] = pChangeGameBeans[sid]
        u.continueWin = u.continueWin + 1
        u.continueFail = 0
        sidWin[sid] = true
        nSidWin[sid] = 1
      end
    end
  end

  --self:log("sidCoin="..tablex.tostring(sidCoin))
  --self:log("开始结算, 赢家="..tostring(winSid)..", 地主="..tostring(g.dzSid)..", 倍数="..tablex.tostring(g.szCoef))
  

  --给某个玩家的赋值结算信息
  local t = {seats={}, spring=spring}
  local popType = {}

  for sid,st in pairs(g.seats) do
      local isDZ = false
      local multiple = g.szCoef[sid]

      --地主的位置
      if sid == g.dzSid then
         isDZ = true
      end

      --当前位置的倍数
      g.szMultiple[sid] = multiple

      --统计赢的金币
      if sidCoin[sid] > 0 then
        g.szWinCoin[sid] = sidCoin[sid]
      end  

      --local u = self._users[sid]
      local u = _users[sid]
      u.totalPlayCount = u.totalPlayCount + 1 --接着下一局发牌机制可能用到
      u.dayCount = u.dayCount + 1

      --先扣掉输掉的游戏豆
      u.money = u.money + sidCoin[sid]

      if sidCoin[sid] ~= 0 then
        --全局广播调用消耗的接口
         --self:broadcast(0, "change_coin", u.uid, u.gameType, sidCoin[sid], 2, u.money)
      end

      popType[sid] = 0
      local type,pType,cDoubleCount,cOffsetCount = self:pop_reward(sid,sidWin,sidCoin,szFullWin,szWinCoinFull)
      popType[sid]= pType
      g.cDoubleCount[sid] = cDoubleCount
      g.cOffsetCount[sid] = cOffsetCount
      if type == 1 then
         --翻倍
         sidCoin[sid] = 2 * sidCoin[sid]
      elseif type == 2 then
         --免输
         sidCoin[sid] = 0
      end

      --如果当前的金币少于最少的那一场的最少值的话
      if u.money < self._minHappyRoomConf.minCoin then
         sidCanNext[sid] = false

         --判断是否有破产
         if not(u.noBankrupt) then
            sidBankrupt[sid] = true
         end
      end
  
      local cInfo = u.confInfo
      local basescore = cInfo.baseScore or 150

      table.insert(t.seats, {
        sid=sid, 
        cards=st.handCards, 
        punish=false,
      isDZ=isDZ,
      bankrupt=sidIsBankrupt[sid],
      topLimit=sidIsTopLimit[sid],
      baseScore=basescore,
      multiple=multiple,
      changeCoin=sidCoin[sid],
      coin=u.money,
      name=u.name,
      isWin=sidWin[sid],
      type=type,
      rewardCoin=0,
      head=u.head
    })
  end



  --self:log("cDoubleCount="..tablex.tostring(g.cDoubleCount)..",cOffsetCount="..tablex.tostring(g.cOffsetCount))

  --从大到小排序
 -- table.sort(self._newTaskConfigInfo,

 --   function(a,b) 
 --     return a.taskCount > b.taskCount 
 --   end)

  --local passiveReward = self:passive_luckyBox_info()
  local prepareCount = 0
  for sid,st in pairs(g.seats) do
    --local u = self._users[sid]
    local u = _users[sid]
    local iswin =  sidWin[sid]

    local isDZ = false
    if sid == g.dzSid then
      isDZ = true
    end
    u.auto = false
    if not(u.is_rb) then
       u.prepare = false                  --结束后真实玩家恢复为没有准备状态
    else
       prepareCount = prepareCount +1
    end

    t.isDZ             = isDZ          --是否是地主(true:地主 false:农民)
    t.changeCoin       = sidCoin[sid]  --金币奖励
    t.coin             = u.money       --当前拥有的金币
    t.showBankrupt     = sidBankrupt[sid]
    t.canNext          = sidCanNext[sid]
    t.isRecover        = false
    if totalIsTopLimit then
      t.roomTopLimit = 1
    end
    t.propType  = PROP_TYPE.FIRSTSEE  
    if popType[sid] == 1 and not(iswin) then
       t.propType  = PROP_TYPE.OFFSET
    elseif popType[sid] == 2 and iswin then
       t.propType  = PROP_TYPE.WINMORE
    elseif popType[sid] == 3 and iswin then
       t.propType  = PROP_TYPE.WINEXPECT
    end 
    --t.lastCardsInfo = {lastCards=lastCards,laizi=0,tzz=lastTzz}
    
    local cInfo = u.confInfo or {
      newPlayerCount = 5
    }
    t.isNewPlayer = false
    if cInfo.newPlayerCount > u.totalPlayCount then
        t.isNewPlayer = true
    end

    --[[
    if not(u.is_rb) then
        if cInfo.newPlayerCount == u.totalPlayCount then
            skynet.send(DB_ADDR, "lua", "delorupdata_cards_index", u.uid)
        elseif t.isNewPlayer then
            skynet.send(DB_ADDR, "lua", "delorupdata_cards_index", u.uid,true,u.tUseCardIndex)     
        end
    end
    ]]

    --判断是否满足每日累积玩牌局数到奖励
    local dayRewardLog = {}
    local taskLog = {}
    --local curCount = (u.tDayPlayCount[u.gameType] or 0)+1
    --u.tDayPlayCount[u.gameType] = curCount    
    --if not(u.is_rb) then
    --    local gType = LV_TYPE.C_LEVEL
    --    if u.gameType == GAME.HAPPY11 then
    --        gType = LV_TYPE.Z_LEVEL
    --    elseif u.gameType == GAME.HAPPY12 then
    --        gType = LV_TYPE.G_LEVEL
    --    elseif u.gameType == GAME.HAPPY13 then
    --        gType = LV_TYPE.D_LEVEL
    --    end
    --    
    --    if u.taskType == TASK.NEWTASK then
    --       --新手任务
    --       u.newPlayerCount = u.newPlayerCount +1
    --       for _,v in pairs(self._newTaskConfigInfo) do
    --           if u.newPlayerCount == v.taskCount then
    --              table.insert(t.taskReward.reward,{type=v.rewardType,value=v.reward})
    --              if v.rewardType == 1 then
    --                  --金币
    --                  u.money = u.money + v.reward
    --                  self:broadcast(0, "change_coin", u.uid,u.gameType, v.reward or 0, 3)
    --                  --skynet.send(u.addr, "lua", "change_coin",u.uid,u.gameType, v.reward or 0, 3)
    --              elseif v.rewardType == 2 then
    --                  --福劵
    --                  u.fujuanCount = u.fujuanCount + v.reward
    --                  skynet.send(u.addr, "lua", "change_fujuan",u.gameType, v.reward or 0, 2)
    --              end
    --              --日志数据
    --              table.insert(taskLog,{pfid=u.pfid,usid=u.usid,uid=u.uid,gameType=u.gameType,taskType=u.taskType,
    --              gType=gType,status=1,taskCount=v.taskCount,rewardType=v.rewardType,reward=v.reward})
    --           end
    --       end
    --    end
    --
    --    --拿取最大的局数然后判断是否大于等于当前的局数,如果是,则从结束
    --    for _,v in pairs(self._newTaskConfigInfo) do
    --       if u.newPlayerCount >= v.taskCount then
    --          t.bFinish = true
    --          u.finishNewTask = true
    --          u.taskType = TASK.TASK
    --       end
    --       break
    --    end
    --end  
    
    --t.rScore =0
    --if iswin and self._redpacketActiveInfo ~= nil and next(self._redpacketActiveInfo) ~= nil then
    --   local curDay =tonumber(os.date("%Y%m%d"))
    --   local info = self._redpacketActiveInfo
    --   if curDay >= info.sDate and curDay <= info.eDate then
    --      local curRandom = newRandom.random_xy(1,100)
    --      if  curRandom <= info.fProbability then
    --         t.rScore = info.fScore
    --      elseif curRandom <= (info.fProbability+info.sProbability) then
    --         t.rScore = info.sScore
    --      else
    --         t.rScore = info.tScore
    --      end
    --   end 
    --end

    --计算发牌权值
    local cInfo = u.confInfo
    local baseScore = cInfo.baseScore or 150
    local changeMoney = sidCoin[sid]
    if sidCoin[sid] < 0 then
       changeMoney = -sidCoin[sid]
    end
    local nWeightValue = 0
    local realValue = 0
    --[[
    if not(u.is_rb) then
        nWeightValue,realValue = compute_weight(u.uid,u.wValue,iswin,changeMoney,baseScore,u.continueWin,u.continueFail,self._dealCards_BaseInfo,self._dealCards_WeightInfo)
        local isNewPlayer = false
        if not(u.is_rb) and u.totalPlayCount < cInfo.newPlayerCount then
          isNewPlayer = true
        end
        u.level = self:compute_level(u.uid,nWeightValue,isNewPlayer,u.recharge,u.regression,self._dealCards_BaseInfo,self._dealCards_WeightInfo)
    end
    u.wValue = nWeightValue
	]]--
    local pInfo = {
    	money=u.money,
	    cRememberCardCount=g.cRememberCardCount,
	    cDoubleCount=g.cDoubleCount[sid],
	    cOffsetCount=g.cOffsetCount[sid],
	    cFirstJDZCount=g.cFirstJDZCount,
	    cFirstSeeCount=g.cFirstSeeCount[sid],
	    cSuperDouble=g.cSuperDouble[sid],  
	    newPlayerCount=u.newPlayerCount,
	    finishNewTask=u.finishNewTask,
	    springCount=g.szSpringCount[sid],
	    winCoin=g.szWinCoin[sid],
	    multiple=g.szMultiple[sid],
	    nWeightValue = nWeightValue,
	    evel=u.level,
	    wValue=u.wValue,
	    realValue=realValue,
	    dayCount=u.dayCount,
	    bombCount=g.szBombCount[sid],
	    tOffsetCount=u.tOffsetCount,
	    tWinDoubleCount=u.tWinDoubleCount,
	    isMaxFJ=szGetMaxFJ[sid]
  	}
    
    --local playbackInfo = self:get_playback_info()
    --skynet.send(u.addr, "lua", "happy_end_game",self._gameType,nSidWin[sid],t,pInfo,playbackInfo,taskLog,dayRewardLog)
    --self:log("happy_end_game to "..tostring(u.uid)..",data="..tablex.tostring(t))
  end

  --得到的时间戳 - 开始的时间
  local log = {
  	9, 
  	os.time() - g.startTime
  }

  --尾插倍数和变化的几金币表
  for i=1,3 do
    table.insert(log,  g.szCoef[i])
    table.insert(log, sidCoin[i])
  end

  --廖志标本周工作占比
  --1.斗地主（70%）
  --2.哈局十三张（30%）

  --[[  log表
   log = {
    9,
    时间戳，
    玩家1倍数，
    玩家1变化的金币数，
    玩家2倍数，
    玩家2变化的金币数，
    玩家3倍数，
    玩家3变化的金币数，
   }

  ]]

  --table.insert(self._logs, "{"..table.concat(log, ",").."}")

  local winlogs = {}  --3个玩家的日志
  --for sid,u in pairs(self._users) do
  for sid,u in pairs(_users) do
      if not(u.is_rb) then
          local cInfo = u.confInfo
          local baseScore = cInfo.baseScore
          local fee = cInfo.fee
          local winCount = 0
          local loseCount = 0
          if sidWin[sid] then
             winCount = 1
          else
             loseCount = 1
          end
          local inRoomTime=os.time()-u.inRoomTime
          u.inRoomTime=os.time()
          local t = {
          	pfid=u.pfid, 
          	usid=u.usid, 
          	wlflag=nSidWin[sid],
          	continueWin=0,
          	score=0,
          	changeScore=0,
          	coin=u.money,
            changeCoin=sidCoin[sid],
            star=u.star,
            changeStar=0,
            grade=u.grade,
            subGrade=u.subGrade,
            newGrade=u.grade,
            newSubGrade=u.subGrade,
            gameType=self._gameType,
            confCardsIndex=g.confCardsIndex,
            basebet=baseScore,
      		inRoomTime=inRoomTime,
 		    win=winCount,
			lose=loseCount,
			fee=fee
}
          winlogs[u.uid] = t
      end
  end

  --[[
  skynet.send(DB_ADDR, "lua", "game_log", self._deskid, self._logs, winlogs,g.realPlayer,self._gameType)

  self._ti_robot.cancel()
  skynet.timeout(300, function()
    if self._users ~= nil and next(self._users) ~= nil then
      for sid,u in pairs(self._users) do
        if u.is_rb then
            --机器人退出房间
            self:quit_room(u.uid,sid,u.gameType,true)
        end
      end
    end
  end)
	
  self._isPlaying = false
  self._ti_robot_jh.cancel()
  --启动监测,如果时间到了还没有准备,就把该玩家踢掉
  self._game.stage = STAGE.PREPARE
  self._ti_prepare.start(TIME.PREPARE, 1, function()
      self:monitor_timeout()
  end)
  ]]
end



room:settle_happy_game(1)





