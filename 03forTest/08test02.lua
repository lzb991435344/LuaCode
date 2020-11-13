



local flag = 1
for i = 1,2 do
    local money = 8
    local cur = 7
    if  flag == 1 then
         cur = 3
         money =  money + cur
         print("flag==1",i,money)
         flag = 0
    else
        money =  money + cur
        print("flag==0",i,money)
    end
end