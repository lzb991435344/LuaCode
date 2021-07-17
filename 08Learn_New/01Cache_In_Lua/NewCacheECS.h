
// mersenne prime number


/**
 * 缓存在lua中的配置表
 * 场景:数据量以G计算，但是需要把逻辑相关的内存降低，代码平台移植相关
 * 实现：新建一个缓存的结构，存数据，无需考虑异常，考虑内存的有效利用问题
*/

//预留的slot数量
#define CACHE_SIZE 8191
//#define CACHE_SIZE 127

#define PROTOTYPE_INVALID 0xffff
#define PROTOTYPE_MASK 0x8000


//相关的数据类型   缓存的相关数据类型
#define PROTOTYPE_INT 0
#define PROTOTYPE_FLOAT 1
#define PROTOTYPE_BOOLEAN 2
#define PROTOTYPE_STRING 3

struct prototype_field {
    const char *key;
    int type;
};

struct prototype_lua {
    lua_State *L;
    int index;
};

struct prototype_cache {
    struct prototype_lua lua;
    struct prototype_field *f;
    int stride;
    void *data; // sizeof data == CACHE_SIZE * stride
    type_t p[CACHE_SIZE];
};

void prototype_cacheinit(struct prototype_cache *c);
void* prototype_read(struct prototype_cache *c, type_t prototype);