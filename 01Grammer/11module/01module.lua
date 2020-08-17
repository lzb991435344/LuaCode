module = {}

module.constant = " const variable"

function module.func1()
	io.write("public function")
end

local  function func2()
	print("private function")
end


--fun2为私有函数，只能通过公有函数来进行访问
function module.func3()
	func2()
end

return module