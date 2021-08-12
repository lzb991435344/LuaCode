//int lua_next (lua_State *L, int index);
//从栈顶弹出一个键，然后把索引指定的表中的一个键值对压栈 （弹出的键之后的 “下一” 对）。
//如果表中以无更多元素，那么 lua_next 将返回 0 （什么也不压栈)

 /*  表放在索引 't' 处 */
    lua_pushnil(L);  /* 第一个键 */
    while (lua_next(L, t) != 0) {
        /* 使用 '键' （在索引 -2 处） 和 '值' （在索引 -1 处）*/
        printf("%s - %s\n",
            lua_typename(L, lua_type(L, -2)),
            lua_typename(L, lua_type(L, -1)));
       /* 移除 '值' ；保留 '键' 做下一次迭代 */
        lua_pop(L, 1);
    }
    //在遍历一张表的时候，不要直接对键调用lua_tolstring ，除非你知道这个键一定是一个字符串。
    //调用 lua_tolstring 有可能改变给定索引位置的值