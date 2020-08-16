

Shape = { area = 0}


--基础类方法 new
function Shape:new(o, side)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	side = side or 0
	self.area = side * side

	return o
end


function Shape:printArea()
	print("面积是：", self.area)
end


myshape = Shape:new(nil, 10)

myshape:printArea()

--面积是：	100