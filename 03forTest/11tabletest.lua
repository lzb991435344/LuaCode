

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

    cooltime = {
        [1] = {
            minvalue = 1,
            maxvalue = 10000,
            time = 60,
        },
        [2] = {
            minvalue = 10001,
            maxvalue = 20000,
            time = 120,
        },
        [3] = {
            minvalue = 20001,
            maxvalue = 30000,
            time = 180,
        },
        [4] = {
            minvalue = 30001,
            maxvalue = 40000,
            time = 240,
        },
         [5] = {
            minvalue = 40001,
            maxvalue = 50000,
            time = 300,
        },
        [6] = {
            minvalue = 50001,
            maxvalue = 60000,
            time = 360,
        },
        [7] = {
            minvalue = 60001,
            maxvalue = 70000,
            time = 420,
        },
        [8] = {
            minvalue = 70001,
            maxvalue = 80000,
            time = 480,
        },
         [9] = {
            minvalue = 80001,
            maxvalue = 90000,
            time = 540,
        },
        [10] = {
            minvalue = 90001,
            maxvalue = 100000,
            time = 600,
        },
         [11] = {
            minvalue = 100001,
            maxvalue = 110000,
            time = 660,
        },
        [12] = {
            minvalue = 110001,
            maxvalue = 120000,
            time = 720,
        },
        [13] = {
            minvalue = 120001,
            maxvalue = 130000,
            time = 780,
        },
        [14] = {
            minvalue = 130001,
            maxvalue = 140000,
            time = 840,
        },
         [15] = {
            minvalue = 140001,
            maxvalue = 150000,
            time = 900,
        },
        [16] = {
            minvalue = 150001,
            maxvalue = 160000,
            time = 960,
        },
         [17] = {
            minvalue = 160001,
            maxvalue = 170000,
            time = 1020,
        },
        [18] = {
            minvalue = 170001,
            maxvalue = 180000,
            time = 1080,
        },
        [19] = {
            minvalue = 180001,
            maxvalue = 190000,
            time = 1140,
        },
        [20] = {
            minvalue = 190001,
            maxvalue = 200000,
            time = 1200,
        },
         [21] = {
            minvalue = 200001,
            maxvalue = 210000,
            time = 1260,
        },
        [22] = {
            minvalue = 210001,
            maxvalue = 220000,
            time = 1320,
        },
         [23] = {
            minvalue = 220001,
            maxvalue = 230000,
            time = 1380,
        },
        [24] = {
            minvalue = 230001,
            maxvalue = 240000,
            time = 1440,
        },
        [25] = {
            minvalue = 240001,
            maxvalue = 250000,
            time = 1500,
        },
        [26] = {
            minvalue = 250001,
            maxvalue = 260000,
            time = 1560,
        },
        [27] = {
            minvalue = 260001,
            maxvalue = 270000,
            time = 1620,
        },
        [28] = {
            minvalue = 270001,
            maxvalue = 280000,
            time = 1680,
        },
        [29] = {
            minvalue = 280001,
            maxvalue = 290000,
            time = 1740,
        },
        [30] = {
            minvalue = 290001,
            maxvalue = 300000,
            time = 1800,
        },
    }

}


for k,v in pairs(lenvcfg.optLevelTimes) do
    print(k,v)
end