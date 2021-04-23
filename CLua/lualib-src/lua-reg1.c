#include <stdio.h>
#include <lualib.h>

static int lecho(lua_State* L){
	lua_Integer n = lua_tointeger(L, lua_upvalueindex(1));
	n++;
	const char* str = lua_tostring(L, -1);
	fprintf(stdout, "[n = %ld]----%s\n", n, str);
	lua_pushinteger(L, n);
	lua_replace(L, lua_upvalueindex(1));
	return 0;
}

static const luaL_Reg[] = {
	{"echo", lecho},
	{NULL,NULL},
};

int luaopen_uv_c(lua_State* L){
	luaL_newlibtable(L, l);	//1
	lua_pushinteger(L, 0);	//2
	luaL_setfuncs(L, l, 1);	//上值

	return 1;
}

int luaopen_reg1_c(lua_State* L){
	
	if(lua_getfield(L, LUA_REGISTYINDEX, "mk.reg.c") == LUA_TNIL){
		lua_createtable(L, 2, 0);
		lua_pushinteger(L, 1000);
		lua_rawseti(L, -2, 1);
		lua_pushinteger(L, 2000);
		lua_rawseti(L, -2, 2);
		lua_setfield(L, LUA_REGISTYINDEX, "mk.reg.c");
		fprintf(stdout, "luaopen_reg1_c register mk.reg.c\n");
	}
	luaL_newlib(L, l);
	return 1;
}


