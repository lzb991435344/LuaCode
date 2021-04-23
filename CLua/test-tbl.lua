package "luaclib/?.so"


local so = require "tbl.c"
--在lua层中调用C函数， 新的虚拟栈
so.echo("hello world!")
so.echo("hello world1!")
so.echo("hello world2!")
--不需要重新编译
