// @module_id:34

syntax = "proto3";
package GameCmd;
//------------------------------------------------------------------------------
//                                     礼包相关协议
//------------------------------------------------------------------------------

message progift_msg {
    string pro_name     = 1;//物品名称
    uint32 pro_quality  = 2;//物品品质
    uint32 pro_num      = 3;//物品数量
    uint32 pro_own      = 4;//当前拥有数量   
}

//客户端请求打开自选道具礼包
//@id:1
message gift_open_giftbag_c2s {
    uint32 giftid = 1; //礼包id
}

//@id:2
message gift_progiftbag_s2c {
    string  gift_name = 1;//礼包名称
    uint32 gift_num   =  2;//礼包数量
    repeated progift_msg  progift  = 3;//物品礼包内容
}

//@id:3
message gift_progiftbag_choose_c2s {
    repeated uint64  ids  = 1; //id数组
}

//选择物品礼包后得到的奖励,用于展示
//@id:4
message gift_progiftbag_choose_s2c {
    repeated uint64  ids  = 1; //数组中的id值，返回数组
}


message herogift_msg {
    string hero_name    = 1;//英雄名称
    uint32 hero_quality = 2;//英雄品质
    uint32 hero_camp    = 3;//英雄阵营
    bool   hero_isexist = 4;//是否存在
    uint32 hero_spieces = 5;//英雄碎片数量
}

//@id:5
message gift_herogiftbag_c2s {
    repeated uint64  ids  = 1; //id数组
}


//@id:6
message gift_herogiftbag_s2c {
    string  gift_name = 1;//礼包名称
    uint32 gift_num   =  2;//礼包数量
    repeated herogift_msg  herogift  = 3;//英雄礼包内容
}


message monstergift_msg {
    string monster_name    = 1;//异兽名称
    uint32 monster_quality = 2;//异兽品质
    uint32 monster_camp    = 3;//异兽阵营
    bool   monster_isexist = 4;//是否存在
    uint32 monster_spieces = 5;//异兽碎片数量
}


//@id:7
message gift_monstergiftbag_c2s {
    repeated uint64  ids  = 1; //id数组
}

//@id:8
message gift_monstergiftbag_s2c {
    string  gift_name = 1;//礼包名称
    uint32 gift_num   =  2;//礼包数量
    repeated monstergift_msg  monstergift  = 3;//物品礼包内容
}


35.gift.proto               module_id:34                礼包相关协议