local drug = require "config_drug"

for id,info in pairs(drug) do
	print(id, info)
	for s,t in pairs(info.reward) do
		print(s,t)
	end
end
