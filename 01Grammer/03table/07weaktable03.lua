--[[
 table的默认值，默认值技术
1.弱引用table,将每个table与默认值关联起来
2.对每种不同的的默认值使用不同的元表，有重复的默认值就使用同样的元表
]]--

local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t)
	return defaults[t]
end}

function setDefault(t, d)
	defaults[t] = d
	setmetatable(t, mt)
end

--如果defaults没有弱引用key,它就会使所有具有默认值的
--table保持下去


--例子2：对每种不同的默认值使用不同的元表
--这里使用到了弱引用的value,metas在不使用时就被回收了
local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault(t, d)
	local mt = metas[d]
	if nill == mt then
       mt = {__index = function ()
       	return d
       end}
       metas[d] = mt
    end
    setmetatable(t, mt)
end






