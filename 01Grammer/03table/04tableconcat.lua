--接受一个字符串数组，返回这些字符串连接后的结果
--table.concat( tablename, ", ", start_index, end_index )
--参数1：表名
--参数2：指定查到字符串之间的分隔符
--参数3：指定第一个和最后一个连接的字符串索引
function rconcat( l )

    --不是表直接返回
    if type(l) ~= "table" then 
          return l
    end
    
    local res = {}
    --table.concat的扩展,处理嵌套的字符串数组
    --对于每个元素，rconcat都递归调用自己，用来连接所有嵌套的字符串数组
    for i = 1, #l do
        --存整个串的value
       res[i] = rconcat(l[i])
    end

    return table.concat(res)
end

print(rconcat{{"a", {"nice"}} , "and", {{"long"},{"list"}}})

--打印结果 aniceandlonglist