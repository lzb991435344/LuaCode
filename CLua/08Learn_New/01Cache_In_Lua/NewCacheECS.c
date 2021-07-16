
#include "NewCacheECS.h"
#define CACHE_STEP 7
#define CACHE_COLLIDE 8

/**
从 Lua 表中读入需要的 key/value 对，缓存在 C 结构中。第二次访问 cache 时避免从 Lua 中再次读取。
*/

void
prototype_cacheinit(struct prototype_cache *c) {
    int i;
    for (i=0;i<CACHE_SIZE;i++) {
        c->p[i] = PROTOTYPE_INVALID;
    }
    int stride = 0;
    for (i=0;c->f[i].key;i++) {
        switch (c->f[i].type) {
        case PROTOTYPE_INT:
            stride += sizeof(int);
            break;
        case PROTOTYPE_FLOAT:
            stride += sizeof(float);
            break;
        case PROTOTYPE_BOOLEAN:
            stride += sizeof(int);
            break;
        case PROTOTYPE_STRING:
            stride += sizeof(const char *);
            break;
        }
    }
    if (stride != c->stride) {
        luaL_error(c->lua.L, "Stride mismatch : %d != %d", stride , c->stride);
    }
}

//hash表 key,value结构
static inline int
inthash(type_t p) {
    int h = (2654435761 * p) % CACHE_SIZE;
    return h;
}

static inline int
check_field(struct prototype_cache *c, int index, type_t prototype, const char *key, int ltype) {
    lua_State *L = c->lua.L;
    int t = lua_getfield(L, -1, key);
    if (t != ltype) {
        if (t == LUA_TNIL) {
            c->p[index] = prototype & PROTOTYPE_MASK;
            return 1;
        }
        luaL_error(L, ".%s is not a %s (%s)", key, lua_typename(L, ltype), lua_typename(L, lua_type(L, -1)));
    }
    return 0;
}

static void *
insert_prototype(struct prototype_cache *c, int index, type_t prototype) {
    lua_State *L = c->lua.L;
    struct prototype_field *f = c->f;
    c->p[index] = prototype;
    if (lua_geti(L, c->lua.index, prototype) != LUA_TTABLE) {
        luaL_error(L, "Prototype %d not found", prototype);
    }
    int i;
    char *output = (char *)c->data + c->stride * index;
    void *ret = (void *)output;
    int vd;
    float vf;
    const char *vs;
    for (i=0;f[i].key;i++) {
        switch (f[i].type) {
        case PROTOTYPE_INT:
            if (check_field(c, index, prototype, f[i].key, LUA_TNUMBER))
                return NULL;
            if (!lua_isinteger(L, -1)) {
                luaL_error(L, ".%s is not an integer", f[i].key);
            }
            vd = lua_tointeger(L, -1);
            memcpy(output, &vd, sizeof(int));
            output += sizeof(int);
            break;
        case PROTOTYPE_FLOAT:
            if (check_field(c, index, prototype, f[i].key, LUA_TNUMBER))
                return NULL;
            vf = lua_tonumber(L, -1);
            memcpy(output, &vf, sizeof(float));
            output += sizeof(float);
            break;
        case PROTOTYPE_BOOLEAN:
            if (check_field(c, index, prototype, f[i].key, LUA_TBOOLEAN))
                return NULL;
            vd = lua_toboolean(L, -1);
            memcpy(output, &vf, sizeof(int));
            output += sizeof(int);
            break;
        case PROTOTYPE_STRING:
            if (check_field(c, index, prototype, f[i].key, LUA_TSTRING))
                return NULL;
            vs = lua_tostring(L, -1);
            memcpy(output, &vs, sizeof(const char *));
            output += sizeof(const char *);
            break;
        }
        lua_pop(L, 1);
    }
    return ret;
}

void *
prototype_read(struct prototype_cache *c, type_t prototype) {
    assert(prototype != PROTOTYPE_INVALID);
    int hash = inthash(prototype);
    int h = hash;
    int i;
    for (i=0;i<CACHE_COLLIDE;i++) {
        int cp = c->p[h];
        if (cp == prototype) {
            char * ptr = (char *)c->data + c->stride * h;
            return (void *)ptr;
        } else if (cp == (prototype | PROTOTYPE_MASK)) {
            return NULL;
        } else if (cp == PROTOTYPE_INVALID) {
            return insert_prototype(c, h, prototype);
        } else {
            h += CACHE_STEP;
            if (h >= CACHE_SIZE) {
                h -= CACHE_SIZE;
            }
        }
    }
    // replace prototype in cache
    return insert_prototype(c, hash, prototype);
}



int main(int argc, char *argv[]) {

    //发电机相关的数据结构
    struct burner_prototype {
        float power;
        float efficiency;
        int priority;
    };

    static struct prototype_field burner_s[] = {
        { "power", PROTOTYPE_FLOAT },
        { "efficiency", PROTOTYPE_FLOAT },
        { "priority", PROTOTYPE_INT },
        { NULL, 0 },
    };

    struct prototype_cache burner;
    struct burner_prototype buffer[CACHE_SIZE];

    burner.f = burner_s;
    burner.stride = sizeof(struct burner_prototype);
    burner.data = buffer;
    
    //读取相关的属性
    struct burner_prototype *b = prototype_read(&burner, prototype_id);
}