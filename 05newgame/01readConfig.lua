
--征收系统配置文件
lenvcfg = {
    oneKeyOptLevel = 5, --一键经营的要求等级
    optLevelTimes = {  --等级对应的经营次数
        [1] = 3,
        [2] = 4,
        [3] = 5,
        [4] = 6,
        [5] = 7,
        [6] = 8,
        [7] = 9,
        [8] = 10,
        [9] = 11,
        [10] = 12,
        [11] = 13,
        [12] = 14,
        [13] = 15,
        [14] = 16,
        [15] = 17,
        [16] = 18,
        [17] = 19,
        [18] = 20,
    },
}

--local cfg = lenvcfg

for k,v in pairs (lenvcfg.optLevelTimes) do
      print(k,v)
end