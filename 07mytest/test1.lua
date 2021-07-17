local t = {
    [11] = {
        num = 22,
        limit = 33,
    }
}

for k, v in pairs(t) do
    print(k, v.num)
end
