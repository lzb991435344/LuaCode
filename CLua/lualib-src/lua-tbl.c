#include <stdio.h>

static int lecho(lua_State* L){
	const char* str = lua_tostring(L, -1);
	fprintf(stdout, "%s\n", str);
	return 0;
}

static const luaL_Reg l[] = {
	{"echo", lecho},
	{NULL, NULL},
};


int luaopen_tbl_c(lua_State* L){
	luaL_newlib(L, l);
	return 1;
}

