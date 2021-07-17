g = {
   dzSid = 1,
   szCoef ={
   	[1] = 1,
   	[2] = 1,
   	[3] = 1
   }
}

print(g.dzSid)
print(g.szCoef[1])

for k,v in pairs(g) do
	if type(v) == "table" then 
		for p,s in pairs(v) do
			print(p, s)
		end
	end
end


--for k,v in pairs(g.szCoef) do
 --  print(k,v)
--end

--for k,v in pairs(g) do
--  for p,s in pairs(v.szCoef) do
--      print(s)
--   end
--end