function PaGlobalRoseWarTeamBuff_Open()
  local self = PaGlobal_RoseWarTeamBuff
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalRoseWarTeamBuff_UpdateBuffDataList()
  local self = PaGlobal_RoseWarTeamBuff
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  self:makeBuffDataList()
  self:updateBuffIcon()
end
