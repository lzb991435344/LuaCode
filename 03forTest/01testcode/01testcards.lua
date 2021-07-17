
local cards = {
     21,22
	--31,32,33
	--51,52,53,31
	--51,52,53,31,32
	--51,52,53,54,31,32
}

--cards当前玩家打出的手牌
function handlecards(cards)
	

	local equalcount = 0 --相等牌型的最大数量
	local tmp = 0
	local maxcount = 0 --牌型中最大的数量
	for i, card in pairs(cards) do
		local value = math.floor(card / 10)
		--print(value)


		if tmp == 0 or tmp == value then 
			equalcount = equalcount + 1
			if equalcount > maxcount then 
				maxcount = equalcount
			end

		else
			if equalcount > maxcount then 
				maxcount = equalcount
			end	

			equalcount = 1
		end
		tmp = value		
	end	
	print(maxcount)

	if maxcount == 3 and #cards == 4 then 
		print("3带1")
	elseif maxcount == 3 and #cards == 5 then 
		print("3带2")
	elseif maxcount == 4 and #cards == 6 then 
		print("4带2")	
	end	
end

--print(#cards)
--handlecards(cards)


print(1 > 2 and 1 > 0 and 1> 0)
print(0 and 1 and 1)
print(0 and 0 and 1)
print(0 and 0 and 0)



