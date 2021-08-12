
//void lua_call (lua_State *L, int nargs, int nresults);
// a = f("how", t.x, 14)
/*
    (1)调用的函数应该被压入栈
    (2)需要传递给这个函数的参数按正序压栈
    (3)lua_call()
    (4)所有参数和函数本身会出栈，函数返回值压栈，返回值个数是nresults个(LUA_MULTRET为设置多个,返回值被放在栈空间中，
    按正序压栈，最后一个放在栈顶)
*/
lua_getglobal(L, "f"); //函数名入栈
lua_pushinteger(L,"how");//第一个参数
lua_getglobal(L, "t"); //被索引的table
lua_getfield(L, -1, "x") //把结果入栈 t.x
lua_remove(L, -2); //从栈中移除结果
lua_pushinteger(L, 14)//第三个参数入栈
lua_call(L, 3, 1) //3个参数，1个返回值
lua_setglobal(L, "a") //set global a



