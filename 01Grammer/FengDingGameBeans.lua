



local room = {
}




local _users = {
  {money=3000,confInfo={topLimit=0,baseScore=20}},
  {money=3000,confInfo={topLimit=0,baseScore=20}},
  {money=1200,confInfo={topLimit=0,baseScore=20}}
}
    

local g = {
  dzSid = 1,
  szCoef = {180,90,90}
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
	
	--初始化以上诸表
	for sid, u in pairs(_users) do 
 		--print(ttostring(u))

 		--print(sid)
		sidIsTopLimit[sid] = false
		sidIsBankrupt[sid] = false
		szFullWin[sid] = false
		szWinCoinFull[sid] = 0

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

			for sid, u in realWinGameBeans do
				if sid ~= g.dzSid then
					nonMinRealLost = math.floor(nonMinRealLost + realWinGameBeans[sid] * (g.szCoef[sid]/totalSzCoef))
				end	
			end

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
				 
		else

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
			local nonMinRealWin = 0
			for sid, u in pairs(realWinGameBeans) do
				nonMinRealWin = nonMinRealWin + math.floor(nonMinRealLose * (g.szCoef[sid]/totalSzCoef)) 
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

						if pChangeGameBeans[sid] >= realWinGameBeans[sid] then
							sidIsTopLimit[sid] = true
						end	
					end	
				end
				

			else

			end	

		else
			
		end
	end
	return pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull
end


local pChangeGameBeans,totalIsTopLimit,sidIsTopLimit,sidIsBankrupt,szFullWin,szWinCoinFull = room:settlement_compute(1)


print("pChangeGameBeans", ttostring(pChangeGameBeans))
print("totalIsTopLimit", totalIsTopLimit)
print("sidIsTopLimit", ttostring(sidIsTopLimit))
print("sidIsBankrupt", ttostring(sidIsBankrupt))
print("szFullWin", ttostring(szFullWin))

print("szWinCoinFull", ttostring(szWinCoinFull))






