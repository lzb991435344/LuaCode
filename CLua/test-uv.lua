package.cpath = "luaclib/?.so"

local so = require "uv.c"

so.echo("hello world")
so.echo("hello world")
so.echo("hello world")


--./lua/src/lua test-uv.lua 创建了几个虚拟机？1个，加载了多个库，共享注册表
