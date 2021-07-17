//获取其他玩家的角色信息
//@id:22
message get_other_player_msg_c2s {
    uint64 userid  = 1;//玩家的uid
}

//@id:23
message hero_info {
   uint64 hero_id    = 1;//id
   uint32 hero_level = 2;//等级
   uint32 hero_start = 3;//星级
}


//@id:24
message get_other_player_msg_s2c {
    uint64 userid     = 1;//其他玩家的id
    uint64 avatar_id  = 2;//头像Id
    string name       = 3;//昵称
    uint32 camp       = 4;//玩家阵营
    uint32 level      = 5;//玩家等级
    uint32 level_vip  = 6;//vip等级
    uint64 power      = 7;//玩家战力
    uint32 city_level = 8;//主城的等级
    uint32 knighthoodlevel = 9;//当前爵位
    uint32 office     = 10;//玩家的官职
    uint32 industy_num      = 11;//玩家的产业数量
    repeated hero_info info = 12;//英雄信息
}