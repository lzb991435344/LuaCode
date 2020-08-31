



local room = {

}
--[[
local _users = {
		sidIsTopLimit = {false, false, false},
		sidIsBankrupt = {false, false, false},
		szFullWin = {false, false, false},
		szWinCoinFull = {false, false, false},
		szWinGameBeans ={4000, 2000, 3000},
		confInfo = {
			topLimit = 2000,
			baseScore = 1
		},
		
}
]]


--3人
---2222222

local _users = {
  {money=3643,confInfo={topLimit=10000,baseScore=20}},
  {money=3435,confInfo={topLimit=10000,baseScore=20}},
  {money=71000,confInfo={topLimit=10000,baseScore=20}}
}
    

local g = {
  dzSid = 1,
  --szCoef = {11520,5760,5760}
  szCoef = {540, 180, 360}
}



--333333 不封顶
--[[
local _users = {
  {money=10000,confInfo={topLimit=3000,baseScore=100}},
  {money=4000,confInfo={topLimit=3000,baseScore=100}},
  {money=20000,confInfo={topLimit=3000,baseScore=100}}
}
    

local g = {
  dzSid = 1,
  --szCoef = {11520,5760,5760}
  szCoef = {8640, 2280, 8640} 
}
]]

--[[
local _users = {
  {money=5000,confInfo={topLimit=3000,baseScore=100}},
  {money=4000,confInfo={topLimit=3000,baseScore=100}},
  {money=5000,confInfo={topLimit=3000,baseScore=100}}
}
    

local g = {
  dzSid = 1,
  --szCoef = {11520,5760,5760}
  szCoef = {8640, 8640, 2880} 
}
]]
---4444测试完成
--[[
local _users = {
  {money=5000,confInfo={topLimit=0,baseScore=100}},
  {money=3000,confInfo={topLimit=0,baseScore=100}},
  {money=3000,confInfo={topLimit=0,baseScore=100}}
}
    

local g = {
  dzSid = 1,
  --szCoef = {11520,5760,5760}
  szCoef = {8640, 8640, 2880}
}
]]

---5555
--[[
local _users = {
  {money=10000,confInfo={topLimit=0,baseScore=100}},
  {money=20000,confInfo={topLimit=0,baseScore=100}}, --money 改为500
  {money=20000,confInfo={topLimit=0,baseScore=100}}
}
    

local g = {
  dzSid = 1,
  --szCoef = {11520,5760,5760}
  szCoef = {8640, 8640, 2880}
}
]]

--4人
--[[
local _users = {
  {money=30000,confInfo={topLimit=0,baseScore=20}},
  {money=5000,confInfo={topLimit=0,baseScore=20}},
  {money=4000,confInfo={topLimit=0,baseScore=20}},
  {money=4000,confInfo={topLimit=0,baseScore=20}},
}
    

local g = {
  dzSid = 1,
  szCoef = {1440, 2880, 8660, 2880}
}
]]


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
<<<<<<< HEAD
			if tp == "table" then
				table.insert(tmp, key.."="..ser_table(v))
			else
				if tp == "string" then
					table.insert(tmp, key.."="..string.format("%q",v))
				elseif tp=="boolean" then
					table.insert(tmp, key.."="..tostring(v))
                elseif tp == "function" then
=======
			if tp=="table" then
				table.insert(tmp, key.."="..ser_table(v))
			else
				if tp=="string" then
					table.insert(tmp, key.."="..string.format("%q",v))
				elseif tp=="boolean" then
					table.insert(tmp, key.."="..tostring(v))
                elseif tp=="function" then
>>>>>>> slave01
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

	local userCoinMoney = {}
	
	--if GAME.FOUR50 == self._gameType or GAME.FOUR51 == self._gameType or 
	--   GAME.FOUR52 == self._gameType then
	--   	peasantCount = 3
	--end
	--self:log("settlement_compute winSid="..tostring(winSid).."gameType="..tostring(self._gameType))


	local totalSzCoef = 0 
	--print(ttostring(g.szCoef))
	--print(next(g.szCoef))

	for sid, v in pairs(g.szCoef) do
		if sid ~= g.dzSid then
			totalSzCoef = totalSzCoef + g.szCoef[sid]
		end
	end
	

    --print(totalSzCoef)


	--初始化以上诸表
	for sid, u in pairs(_users) do 

		sidIsTopLimit[sid] = false
		sidIsBankrupt[sid] = false
		szFullWin[sid] = false
		szWinCoinFull[sid] = 0

		local cInfo = u.confInfo
		topLimitValue =  cInfo.topLimit
	
		userCoinMoney[sid] = u.money

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
    	--print(ttostring(realWinGameBeans))


    	--计算所有农民实际能赢或者输的游戏豆
    	if sid ~= g.dzSid then
    		--农民所有的游戏豆
    		nongMinRealGB = nongMinRealGB + realWinGameBeans[sid]
    	end
	end
	--print(ttostring(userCoinMoney))


 
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

		--new
		if doubleTopLimitValue ~= 0  then 
			if  dzCanWin < nongMinRealGB then 
				--2倍封顶值 < 能赢的豆子 < 农民所有的总和
				if doubleTopLimitValue <= dzCanWin then 
					--totalIsTopLimit = true
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

	    --print(ttostring(realWinGameBeans))
		
		pChangeGameBeans[g.dzSid] = 0
		for sid, u in pairs(realWinGameBeans) do

			
			if sid ~= g.dzSid then
				
				local dzRealWin = math.floor(realWinGameBeans[g.dzSid] * (g.szCoef[sid] / totalSzCoef))

				if dzRealWin >= realWinGameBeans[sid] then 
					pChangeGameBeans[sid] = realWinGameBeans[sid]
				else
					pChangeGameBeans[sid] = dzRealWin	
				end	
			pChangeGameBeans[g.dzSid] = pChangeGameBeans[g.dzSid] + pChangeGameBeans[sid]	
			end
			
			--if pChangeGameBeans[sid] >= realWinGameBeans[sid] then
			if pChangeGameBeans[sid] >= userCoinMoney[sid]	then 
				sidIsBankrupt[sid] = true
			end	
		end
		if pChangeGameBeans[g.dzSid] >= realWinGameBeans[g.dzSid]  then 
			totalIsTopLimit = true
		end	

		szWinCoinFull[g.dzSid] = realWinGameBeans[g.dzSid] - pChangeGameBeans[g.dzSid]
	else

		--农民赢
		if topLimitValue ~= 0 and nongMinRealGB > topLimitValue and 
		   realWinGameBeans[g.dzSid] > topLimitValue then
		    --农民在该场赢到了封顶
			totalIsTopLimit = true
			nongMinRealGB = topLimitValue
			realWinGameBeans[g.dzSid] = topLimitValue
		end

		--print(ttostring(realWinGameBeans))
		pChangeGameBeans[g.dzSid] = 0
		for sid, u in pairs(realWinGameBeans) do
			if sid ~= g.dzSid then 
				--local dzRealLose = math.floor(realWinGameBeans[g.dzSid] * (g.szCoef[sid])/ totalSzCoef)
				--
				local dzRealLose = math.floor(realWinGameBeans[g.dzSid] * (g.szCoef[sid])/ totalSzCoef)
				--print("1111",dzRealLose)
				if dzRealLose >= realWinGameBeans[sid] then 
					pChangeGameBeans[sid] = realWinGameBeans[sid]
				else
					pChangeGameBeans[sid] = dzRealLose	
				end

				--print("5555",pChangeGameBeans[sid],realWinGameBeans[sid])

				--if pChangeGameBeans[sid] >= realWinGameBeans[sid] then 
				if pChangeGameBeans[sid] >= userCoinMoney[sid] then 	
					--print(pChangeGameBeans[sid],realWinGameBeans[sid])
					sidIsTopLimit[sid] = true
				end

				szWinCoinFull[sid] = realWinGameBeans[sid] - pChangeGameBeans[sid]

				--if pChangeGameBeans[sid] >= realWinGameBeans[sid] then 
				if pChangeGameBeans[sid] >= userCoinMoney[sid] then 	
					szFullWin[sid] = true
				end
			 --改
			 	pChangeGameBeans[g.dzSid] = pChangeGameBeans[g.dzSid] + pChangeGameBeans[sid]		
			end

			
	
		end	
		--print("realWinGameBeans[g.dzSid]",realWinGameBeans[g.dzSid])
		--if pChangeGameBeans[g.dzSid] >= realWinGameBeans[g.dzSid] then 
		if pChangeGameBeans[g.dzSid] >= userCoinMoney[g.dzSid] then 	
			sidIsBankrupt[g.dzSid] = true
		end		
	end
	return pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull
end


local pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull = room:settlement_compute(2)



--local time = os.time()
--local day = tonumber(os.date("%Y%m%d", time))
--print(day)




print("pChangeGameBeans", ttostring(pChangeGameBeans))
print("totalIsTopLimit", totalIsTopLimit)
print("sidIsTopLimit", ttostring(sidIsTopLimit))
print("sidIsBankrupt", ttostring(sidIsBankrupt))
print("szFullWin", ttostring(szFullWin))

print("szWinCoinFull", ttostring(szWinCoinFull))






