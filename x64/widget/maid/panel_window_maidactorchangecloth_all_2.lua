function PaGlobalFunc_MaidActorChangeCloth_Close()
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_MaidActorChangeCloth_IsShow()
  local panel = Panel_Window_MaidActorChangeCloth_All
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function FromClient_MaidActorChangeCloth_Show(fromWhereType, fromSlotNo)
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  self:prepareOpen(fromWhereType, fromSlotNo)
end
function FromClient_MaidActorChangeCloth_Hide()
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  PaGlobalFunc_MaidActorChangeCloth_Close()
end
function HandleListEvent_MaidActorChangeCloth_CreateItemListContent(content, key)
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  self:createItemListContent(content, key)
end
function HandleEventLUp_MaidActorChangeCloth_ToggleFloatingTooltip()
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if PaGlobalFunc_FloatingTooltip_GetShow() == true then
    TooltipSimple_Hide()
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  else
    if self._console_overSlot_whereType == nil or self._console_overSlot_slotNo == nil then
      return
    end
    local itemWrapper = getInventoryItemByType(self._console_overSlot_whereType, self._console_overSlot_slotNo)
    if itemWrapper == nil then
      return
    end
    if _ContentsGroup_RenewUI_Tooltip == true then
      _AudioPostEvent_SystemUiForXBOX(50, 0)
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_MaidActorChangeCloth_All, false, true)
    end
    return
  end
end
function HandleEventLUp_MaidActorChangeCloth_DoChange()
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  local function doChange()
    ToClient_RequestChangeClothForMaidActor(self._fromWhereType, self._fromSlotNo)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDACTOR_CHANGE_CLOTH_MESSAGEBOX_DESC"),
    functionYes = doChange,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if self._isConsole == true then
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  end
end
function HandleEventLOnOut_MaidActorChangeCloth_TooltipItem(isOn, itemWhereType, slotNo)
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  if isOn == true then
    self._console_overSlot_whereType = itemWhereType
    self._console_overSlot_slotNo = slotNo
    TooltipSimple_Hide()
    Panel_Tooltip_Item_hideTooltip()
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_FloatingTooltip_Close()
    end
  else
    self._console_overSlot_whereType = nil
    self._console_overSlot_slotNo = nil
  end
end
function HandleEventLUp_MaidActorChangeCloth_SelectItem(itemWhereType, slotNo)
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  self:selectItem(itemWhereType, slotNo)
end
function HandleEventLOnOut_MaidActorChangeCloth_ItemTooltip(isShow, itemWhereType, slotNo)
  local self = PaGlobal_MaidActorChangeCloth
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_MaidActorChangeCloth_All, false, true)
end
