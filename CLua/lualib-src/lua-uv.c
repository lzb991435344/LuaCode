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


