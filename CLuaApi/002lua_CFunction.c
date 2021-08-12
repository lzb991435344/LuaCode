
//C 函数的类型
typedef int (*lua_CFunction) (lua_State *L);


static int foo(Lua_State *L) {
    int n = lua_gettop(L); //参数的个数
    lua_Number sum = 0.0;
    int i;
    for(i = 1; i < n; ++i) {
        if(!lua_isnumber(L, i)) {
            lua_pushinteger(L, "error param");
            lua_error(L);
        }
        sum += lua_tonumber(L, i);
        lua_pushnumber(L, sum/n);        /* 第一个返回值 */
        lua_pushnumber(L, sum);         /* 第二个返回值 */
        return 2;                   /* 返回值的个数 */
    }
}

