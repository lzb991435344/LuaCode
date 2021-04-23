LUA_CLIB_PATH ?= luaclib
LUA_CLIB_SRC ?= lualib-src
LUA_CLIB = tbl
LUA_INC ?= lua/src 
SHARED := fPIC -dynamiclib -Wl 
CFLAGS = -g -O2 -Wall -I(LUA_INC)
CC ?= gcc


all : \
	$(foreach v, $(LUA_CLIB),$(LUA_CLIB_PATH))

$(LUA_CLIB_PATH) :
	mkdir -p $(LUA_CLIB_PATH)
$(LUA_CLIB_PATH)/tbl.so : $(LUA_CLIB_SRC) /
	$(CC) $(CFLAGS) $(SHARED) $^ -o $@ 

clean:
	rm -rf $(LUA_CLIB_PATH)/*.so
