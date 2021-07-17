--[[local t1 = {a = 1, b= 2};
local t2 = {c = 3, d =4};

local t = {}

for i = 1, 2 do
    if i == 1 then
        table.insert(t, t1)
    else
        table.insert(t, t2)
    end
end

for k,v in pairs (t) do
    if type(v) == "table" then
            for p,q in pairs(v) do
                print(p,q)
            end
        end
end]]
--local t = {1=2}

s = {
    eventList = {
        [1] = {
            isOpen = false,
            awards = {[1] = {itermid = 2, value = 6000}},
            id = 5,
            onlyId = 85,
            etime = 0,
            trueChoice = {[1] = 9, [2] = 2}
        },
        [2] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            id = 17,
            onlyId = 86,
            isOpen = false,
            trueChoice = {[1] = 33, [2] = 2}
        },
        [3] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            id = 5,
            onlyId = 87,
            isOpen = false,
            trueChoice = {[1] = 9, [2] = 2}
        }
    }
}
t = {
    eventList = {
        [1] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            id = 12,
            onlyId = 88,
            isOpen = false,
            trueChoice = {[1] = 23, [2] = 1}
        },
        [2] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            id = 8,
            onlyId = 89,
            isOpen = false,
            trueChoice = {[1] = 15, [2] = 2}
        }
    }
}

tt = {
    eventList = {
        [1] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            trueChoice = {[1] = 23, [2] = 1},
            onlyId = 88,
            id = 12,
            isOpen = true,
            etime = 1610787469
        },
        [2] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            trueChoice = {[1] = 15, [2] = 2},
            onlyId = 89,
            id = 8,
            isOpen = false,
            etime = 0
        },
        [3] = {
            awards = {[1] = {itermid = 2, value = 6000}},
            trueChoice = {[1] = 25, [2] = 2},
            onlyId = 90,
            id = 13,
            isOpen = false,
            etime = 0
        }
    }
}
