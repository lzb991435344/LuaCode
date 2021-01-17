
--寻访界面信息
function mh_client:C2S_VisitInfo()
    local data = {}
    data = self.visit:getVisitInfo()
    self:log("SendVisitInfo = "..tablex.tostring(data))
    self:send("S2C_VISIT_INFO", data)
end

--下发单独寻访的信息
function mh_client:C2S_SingleVisitInfo()
    local data = {}
    data = self.visit:singleVisit()
    self:log("SendSingleVisitInfo = "..tablex.tostring(data))
    self:send("S2C_SINGLEVISIT_INFO", data)
end





--下发一键寻访的信息
function mh_client:C2S_AllleVisitInfo()
    local data = {}
    data = self.visit:visitAll()
    self:log("SendAllVisitInfo = "..tablex.tostring(data))
    self:send("S2C_ALLVISIT_INFO", data)
end

--下发运势界面信息
function mh_client:C2S_FateInfo()
    local data = {}
    data = self.visit:getPrayMsg()
    self:log("SendFateInfo = "..tablex.tostring(data))
    self:send("S2C_FATE_INFO", data)
end

--下发玩家时装信息
function mh_client:C2S_WorkShipInfo()
    local data = self.visit:getUsersWorkShip()
    self:log("SendUsersWorkShip"..tablex.tostring(data))
    self:send("S2C_WORSHIP_INFO",data)
end

--设置自动祈福数值
function mh_client:C2S_PrayInfo(t)
    self.visit:dealPrayTypeAndMinFate(t)
    self:log("DealPrayTypeAndMinFate")
end

--下发自动祈福信息
function mh_client:C2S_ManualPray()
    local data = self.visit:getPrayMsg()
    self:log("DealPrayTypeAndMinFate"..tablex.tostring(data))
    self:seng("S2C_MANUAL_PRAY",data)
end