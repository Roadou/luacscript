function PaGlobalFunc_NewbieInventory_Open()
  local self = PaGlobal_NewbieInventory
  if self == nil then
    return
  end
  if self._isPadMode == true and PaGlobal_Inventory_All_ForConsole._isShowFamilyInven == true then
    return
  end
  if self._isPadMode == true and self._restrictOpen == true then
    self._restrictOpen = false
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_NewbieInventory_Close()
  local self = PaGlobal_NewbieInventory
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_NewbieInventory_SetRestrictOpen(restrictOpen)
  local self = PaGlobal_NewbieInventory
  if self == nil then
    return
  end
  self._restrictOpen = restrictOpen
end
function PaGlobalFunc_NewbieInventory_UpdateSlot()
  if PaGlobal_NewbieInventory == nil then
    return
  end
  PaGlobal_NewbieInventory:updateSlots()
end
function PaGlobalFunc_NewbieInventory_PopItemFromNewbieInventory(itemCount, slotNo)
  if Panel_Window_NewbieInventory_StaticSlot_All == nil or Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == false then
    return
  end
  ToClient_PopBlackSpiritInventoryToInventory(slotNo, itemCount, CppEnums.ItemWhereType.eInventory)
end
function PaGlobalFunc_NewbieInventory_UpdateInventory()
  if Panel_Window_NewbieInventory_StaticSlot_All == nil or Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == false then
    return
  end
  PaGlobal_NewbieInventory:update()
end
function PaGlobalFunc_NewbieInvnetory_IsMoveableItem(idx, itemWrapper)
  if itemWrapper == nil then
    return true
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return true
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if userType ~= __eEAdmissionSpeedChannelType_Newbie then
    return true
  end
  if itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true or itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitDoNotMove) == true or itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter) == true then
    return true
  end
  if Inventory_GetCurrentInventoryType() ~= CppEnums.ItemWhereType.eInventory then
    return true
  end
  if itemWrapper:movableNewbieInventory() == true then
    return false
  end
  return true
end
function PaGlobalFunc_NewbieInvnetory_PushItemToNewbieInventory(itemCount, slotNo, itemwhereType)
  if Panel_Window_NewbieInventory_StaticSlot_All == nil or Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == false then
    return
  end
  ToClient_PushBlackSpiritInventoryFromInventory(itemwhereType, slotNo, itemCount)
end
function HandleEventOnOut_NewbieInventory_IconTooltip(isShow, index)
end
function PaGlobal_NewbieInvnetory_GetToopTipItem()
  if nil == PaGlobal_NewbieInventory._tooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(CppEnums.ItemWhereType.eNewbieInventory, PaGlobal_NewbieInventory._tooltipSlotNo)
end
function HandleEventRUp_NewbieInventory_SlotRClick(slotIndex)
  if Panel_Window_NewbieInventory_StaticSlot_All == nil or Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == false then
    return
  end
  if PaGlobal_NewbieInventory == nil then
    return
  end
  if PaGlobal_NewbieInventory._canMoveItem == false then
    return
  end
  local slotNo = PaGlobal_NewbieInventory:getRealSlotNo(slotIndex)
  PaGlobal_NewbieInventory:popItem(slotNo)
end
function HandleEventRUp_NewbieInventory_InvenSlotRClick(slotNo)
  if Panel_Window_NewbieInventory_StaticSlot_All == nil or Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == false then
    return
  end
  if PaGlobal_NewbieInventory == nil then
    return
  end
  if PaGlobal_NewbieInventory._canMoveItem == false then
    return
  end
  PaGlobal_NewbieInventory:slotRClick_Inventory(slotNo)
end
function HandleEventLUp_NewbieInventory_All_ShowSortOption()
  if PaGlobal_NewbieInventory == nil then
    return
  end
  PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.NewbieInventory)
end
function HandleEventLUp_NewbieInventory_All_SendWarehouse()
  if PaGlobal_NewbieInventory == nil then
    return
  end
  local doYes = function()
    ToClient_moveNewbieInventoryToWarehouse()
    PaGlobalFunc_NewbieInventory_Close()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local _contenet = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWBIEINVEN_MSG_DESC")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = doYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_NewbieInventory_All_MoveItem()
  if PaGlobal_NewbieInventory == nil then
    return
  end
  PaGlobalFunc_Equipment_All_Close(false)
  if false == PaGlobal_NewbieInventory._ui._stc_body:GetShow() then
    PaGlobal_NewbieInventory._ui._stc_body:SetShow(true)
    local invenPosX = Panel_Window_Inventory_All:GetPosX() - PaGlobal_NewbieInventory._ui._stc_body:GetSizeX()
    local invenPosY = Panel_Window_Inventory_All:GetPosY()
    if Panel_Window_Inventory_All:IsUISubApp() == true then
      invenPosX = getScreenSizeX() / 2 - PaGlobal_NewbieInventory._ui._stc_body:GetSizeX() / 2
      invenPosY = getScreenSizeY() / 2 - PaGlobal_NewbieInventory._ui._stc_body:GetSizeY() / 2
    end
    Panel_Window_NewbieInventory_StaticSlot_All:SetPosX(invenPosX)
    Panel_Window_NewbieInventory_StaticSlot_All:SetPosY(invenPosY)
    PaGlobal_Inventory_All:deleteMode_setShow(false)
    PaGlobal_NewbieInventory:update()
    Inventory_SetFunctor(PaGlobalFunc_NewbieInvnetory_IsMoveableItem, HandleEventRUp_NewbieInventory_InvenSlotRClick, nil, nil)
    PaGlobal_NewbieInventory._canMoveItem = true
  else
    PaGlobalFunc_NewbieInventory_Close()
    PaGlobal_NewbieInventory._canMoveItem = false
  end
end
function HandleEventOn_NewbieInventory_All_ItemFloatingToolTip(isShow, slotNo)
  if PaGlobal_NewbieInventory == nil then
    return
  end
end
function HandleEventPadX_NewbieInventory_All_ShowItemInfo(isShow, slotNo)
  if PaGlobal_NewbieInventory == nil then
    return
  end
end
function PaGlobalFunc_NewbieInventory_All_ShowAni()
  Panel_Window_NewbieInventory_StaticSlot_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_NewbieInventory_StaticSlot_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_NewbieInventory_StaticSlot_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_NewbieInventory_StaticSlot_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_NewbieInventory_StaticSlot_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_NewbieInventory_StaticSlot_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_NewbieInventory_StaticSlot_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobalFunc_NewbieInventory_All_HideAni()
  Panel_Window_NewbieInventory_StaticSlot_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_NewbieInventory_StaticSlot_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
