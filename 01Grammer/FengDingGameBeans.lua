



local room = {
}




local _users = {
  {money=22000,confInfo={topLimit=0,baseScore=100}},
  {money=18000,confInfo={topLimit=0,baseScore=100}},
  {money=10000,confInfo={topLimit=0,baseScore=100}}
}
    

local g = {
  dzSid = 1,
<<<<<<< HEAD
  szCoef = {180,90,90}
=======
  --szCoef = {11520,5760,5760}
  szCoef = {1000,2000,1500}
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
}


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
	
<<<<<<< HEAD
	--初始化以上诸表
	for sid, u in pairs(_users) do 
 		--print(ttostring(u))

 		--print(sid)
=======
	--if GAME.FOUR50 == self._gameType or GAME.FOUR51 == self._gameType or 
	--   GAME.FOUR52 == self._gameType then
	--   	peasantCount = 3
	--end
	--self:log("settlement_compute winSid="..tostring(winSid).."gameType="..tostring(self._gameType))


	local totalSzcoef = 0 
		for sid, v in pairs(g.szCoef) do
			if sid ~= g.dzSid then
				totalSzcoef = totalSzcoef + g.szCoef[sid]
			end
		end

		print("90909909090", totalSzcoef)

	--初始化以上诸表
	for sid,u in pairs(_users) do 
 
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
		sidIsTopLimit[sid] = false
		sidIsBankrupt[sid] = false
		szFullWin[sid] = false
		szWinCoinFull[sid] = 0

<<<<<<< HEAD
=======

>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
		local cInfo = u.confInfo
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

	local totalSzCoef = 0
	for sid, u in pairs() do
		if sid ~= g.dzSid then
			totalSzCoef = totalSzCoef + g.szCoef[sid]
		end	
	end	
 
 	--self:log("szWinGameBeans="..tablex.tostring(szWinGameBeans).."realWinGameBeans="..tablex.tostring(realWinGameBeans))
	if winSid == g.dzSid then
		--地主赢

		--地主本身最大的豆的数量
		local dzMaxCanWin = realWinGameBeans[winSid]
		--赢的那个人实际账户中能抵扣的数量
		local dzCanWin = realWinGameBeans[winSid]
<<<<<<< HEAD
	
 
=======
		--print(dzCanWin)
		--print(ttostring(realWinGameBeans))
		--[[
		--地主的能赢游戏豆 < 农民所有的总和  地主赢封顶
		if dzCanWin < nongMinRealGB then
			--地主赢封顶
			sidIsTopLimit[winSid] = true
		else --地主的能赢游戏豆 >= 农民所有的总和 

			--所有农民实际能输的加起来都不够
			realWinGameBeans[winSid] = nongMinRealGB

			--更新最大能赢的游戏豆
			dzCanWin = nongMinRealGB
		end


		--判断是否赢到该场次的上限
		--能赢的豆子 > 房间的上限豆子,实际上能赢的是房间的上限，更新realWinGameBeans[winSid]的表
		if topLimitValue ~= 0 and dzCanWin > topLimitValue then
			totalIsTopLimit = true
			realWinGameBeans[winSid] = topLimitValue
		end
	
		]]--
		
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
 		--地主赢两倍的封顶
		local doubleTopLimitValue = 2 *  topLimitValue

		if doubleTopLimitValue ~= 0  then 
			if  dzCanWin < nongMinRealGB then 
				--2倍封顶值 < 能赢的豆子 < 农民所有的总和
				if doubleTopLimitValue <= dzCanWin then 
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

	   --地主赢, 地主赢的 > 农民的总量
		if realWinGameBeans[winSid] > nongMinRealGB then
			local nonMinRealLost  = 0

<<<<<<< HEAD
			for sid, u in realWinGameBeans do
				if sid ~= g.dzSid then
					nonMinRealLost = math.floor(nonMinRealLost + realWinGameBeans[sid] * (g.szCoef[sid]/totalSzCoef))
				end	
			end
=======
		--print(ttostring(szWinGameBeans))
		--print(ttostring(realWinGameBeans))
		--print("111111",realWinGameBeans[winSid],nongMinRealGB)
		if realWinGameBeans[winSid] <= nongMinRealGB then

			--print("56565656")
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
					for sid, v in pairs(realWinGameBeans) do

						
						--print(ttostring(realWinGameBeans))
						if sid ~= g.dzSid and existUseSid[sid] == nil and 
						   (minLose == 0 or minLose > v) then
							minLose = v
							minSid = sid
						end					
					end


					--print(minSid)

					--找到minSid 
					if minSid > 0 then
						existUseSid[minSid] = false
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44

			if nonMinRealLost >= realWinGameBeans[g.dzSid] then
				pChangeGameBeans[g.dzSid] = realWinGameBeans[g.dzSid]

				for sid, u in pairs(realWinGameBeans) do
					if g.sid ~= dzSid then
						local tmp = math.floor(realWinGameBeans[sid] * (g.szCoef[sid]/totalSzCoef))
						if tmp >= realWinGameBeans[sid] then
							pChangeGameBeans[sid] = realWinGameBeans[sid] 
						else
							pChangeGameBeans[sid] = tmp
						end
					if pChangeGameBeans[sid] >= realWinGameBeans[sid] then
						sidIsBankrupt[sid] = true		
					end	
				end
<<<<<<< HEAD

				szWinCoinFull[g.dzSid] = dzMaxCanWin - pChangeGameBeans[g.dzSid]
				 
			else
				pChangeGameBeans[g.dzSid] = 0
				for sid, u in pairs(realWinGameBeans) do
					if sid ~= g.dzSid then 
						pChangeGameBeans[sid] = math.floor(nonMinRealLost * (g.szCoef[sid]/totalSzCoef))
					end	
					pChangeGameBeans[g.dzSid] = pChangeGameBeans[g.dzSid] + pChangeGameBeans[sid]
				end 

			end	
				 
=======
			 
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
		else

<<<<<<< HEAD
		local nonMinRealLose = 0
		for sid, u in pairs(realWinGameBeans) do
			if sid ~= g.dzSid then
				nonMinRealLose = math.floor(nonMinRealLose + realWinGameBeans[sid] * (g.szCoef[sid]/totalSzCoef))
			end	
		end

		if nonMinRealLose >= realWinGameBeans[g.dz] then
			pChangeGameBeans[g.dzSid] = realWinGameBeans[g.dzSid]

			for sid, u in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then 
					local tmp  =  math.floor(realWinGameBeans[sid] * (g.szCoef[sid]/totalSzCoef))

					if tmp >= realWinGameBeans[sid] then 
						pChangeGameBeans[sid] = realWinGameBeans[sid]
					else
						pChangeGameBeans[sid] = tmp
					end
						
					if  pChangeGameBeans[sid] >= realWinGameBeans[sid] then
						sidIsBankrupt[sid] = true
					end	
				end	
=======
			--地主赢的游戏豆 > 实际上农民有的豆
			pChangeGameBeans[winSid] = nongMinRealGB
			for sid, v in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then
					pChangeGameBeans[sid] = v
				end
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
			end
			if realWinGameBeans[g.dzSid] == pChangeGameBeans[g.dzSid] then
				sidIsTopLimit[g.dzSid] = true
			end	

		else
			pChangeGameBeans[g.dzSid] = 0
			for sid, u in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then 
					pChangeGameBeans[sid] = math.floor(nonMinRealLose * (g.szCoef[sid]/totalSzCoef)) 
				end	
				pChangeGameBeans[g.dzSid] = pChangeGameBeans[g.dzSid] + pChangeGameBeans[sid]
			end
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
<<<<<<< HEAD
			local nonMinRealWin = 0
			for sid, u in pairs(realWinGameBeans) do
				nonMinRealWin = nonMinRealWin + math.floor(nonMinRealLose * (g.szCoef[sid]/totalSzCoef)) 
=======
			--地主不够输
			--农民能赢的金币大于地主能输的金币,地主破产
			print("1res is",nongMinRealGB..realWinGameBeans[g.dzSid])
			if nongMinRealGB > realWinGameBeans[g.dzSid] then
				print("2res is",nongMinRealGB..realWinGameBeans[g.dzSid])
				--破产标志位

				sidIsBankrupt[g.dzSid] = true	
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
			end

			if nonMinRealWin >= realWinGameBeans[g.dzSid] then
				pChangeGameBeans[g.dzSid] = realWinGameBeans[g.dzSid]

				for sid, u in pairs(realWinGameBeans) do
					if sid ~= g.dzSid then
						local tmp = math.floor(realWinGameBeans[g.dzSid] * (g.szCoef[sid]/totalSzCoef))
						if tmp >= realWinGameBeans[sid] then
							pChangeGameBeans[sid] = realWinGameBeans[sid]
						else 
							pChangeGameBeans[sid] = tmp
						end

<<<<<<< HEAD
						if pChangeGameBeans[sid] >= realWinGameBeans[sid] then
							sidIsTopLimit[sid] = true
						end	
					end	
				end
				
=======
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
					if averageWin < minLose then --平均值较小，农民未赢封顶,且都未破产
						pChangeGameBeans[minSid] = averageWin

						--需要补充的豆子数
						szWinCoinFull[minSid] = minLose - averageWin
					else  --平均值较大，农民个人赢封顶
						
						szFullWin[minSid] = true
						--农民个人封顶
						sidIsTopLimit[minSid] = true
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44

			else

			end	

<<<<<<< HEAD
		else
			
		end
	end
=======
							local sDZWinGameBeans = realWinGameBeans[g.dzSid] - useLose
							
							averageWin = math.floor(sDZWinGameBeans/(peasantCount - i))
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
			print("8888888888")
			print(ttostring(realWinGameBeans))
			--pChangeGameBeans[g.dzSid] = nongMinRealGB

			pChangeGameBeans[g.dzSid] = 0
			for sid,v in pairs(realWinGameBeans) do
				if sid ~= g.dzSid then
					--赋值游戏豆变化的实际值，{sid1 = xxx, sid2 = xxx}
					--pChangeGameBeans[sid] = v
					--pChangeGameBeans[sid] = math.floor(v * (g.szCoef[sid] / totalSzcoef))

					--local nongMinCanWin = math.floor(nongMinRealGB * (g.szCoef[sid] / totalSzcoef))



					--pChangeGameBeans[sid] = math.floor(nongMinRealGB * (g.szCoef[sid] / totalSzcoef))

					local nongMinCanWin = math.floor(nongMinRealGB * (g.szCoef[sid] / totalSzcoef))
					--pChangeGameBeans[sid] = v * (g.szCoef[sid] / totalSzcoef)
					if  nongMinCanWin >= realWinGameBeans[sid]  then

						
						pChangeGameBeans[sid] = realWinGameBeans[sid]

					else
						--print("i am here")
					    pChangeGameBeans[sid] = nongMinCanWin
					    realWinGameBeans[sid] = nongMinCanWin	
					end

					--更新实际上地主改变的金币
					pChangeGameBeans[g.dzSid] = pChangeGameBeans[g.dzSid] + realWinGameBeans[sid]
				end

			end 
		end
	end

	--print(ttostring(szWinGameBeans))
	--print(ttostring(realWinGameBeans))
>>>>>>> 529d57e0bfeb3b6f3b12ea0de0faefd8523aad44
	return pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull
end


local pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull = room:settlement_compute(2)


print("pChangeGameBeans", ttostring(pChangeGameBeans))
print("totalIsTopLimit", totalIsTopLimit)
print("sidIsTopLimit", ttostring(sidIsTopLimit))
print("sidIsBankrupt", ttostring(sidIsBankrupt))
print("szFullWin", ttostring(szFullWin))

print("szWinCoinFull", ttostring(szWinCoinFull))






