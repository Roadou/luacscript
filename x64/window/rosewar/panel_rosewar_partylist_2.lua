function PaGlobalFunc_RoseWarPartyList_Open()
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  if ToClient_IsRoseWarObserveMode() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RoseWarPartyList_Close()
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarPartyList_IsShow()
  if Panel_RoseWar_PartyList == nil then
    return false
  end
  return Panel_RoseWar_PartyList:GetShow()
end
function HandleEventLUp_RoseWarPartyList_ShowMinify()
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  self:updateSlot()
end
function HandleEventLUp_RoseWarPartyList_SelectCommander(index)
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  self:selectCommanderIndex(index)
end
function HandleEventLUp_RoseWarPartyList_Appoint()
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  self:selectCommander()
end
function HandleEventLUp_RoseWarPartyList_ShowFamilyName()
  local self = PaGlobal_RoseWarPartyList
  if self == nil then
    return
  end
  self:updateSlot()
end
function FromClient_RoseWarPartyList_ChangeRoseWarCommander()
  PaGlobalFunc_RoseWarPartyList_Close()
end
