function HandleEventLUp_EnchantInventory_ToggleMoveMode()
  PaGlobal_EnchantInventory_All:ToggleMoveMode()
end
function HandleEventRUp_EnchantInventory_SlotRClick(slotIndex)
  local slotNo = PaGlobal_EnchantInventory_All:getRealSlotNo(slotIndex)
  PaGlobal_EnchantInventory_All:slotRClick_MoveMode(slotNo)
end
function HandleEventRUp_EnchantInventory_InvenSlotRClick(slotNo)
  if nil == Panel_Window_EnchantInventory_All or false == Panel_Window_EnchantInventory_All:GetShow() then
    return
  end
  PaGlobal_EnchantInventory_All:slotRClick_Inventory(slotNo)
end
function HandleEventOnOut_EnchantInventory_IconTooltip(isShow, index)
  if false == isShow then
    PaGlobal_EnchantInventory_All._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "EnchantInventory", false, false)
    TooltipSimple_Hide()
    return
  end
  local slotNo = PaGlobal_EnchantInventory_All:getRealSlotNo(index)
  PaGlobal_EnchantInventory_All._tooltipSlotNo = slotNo
  Panel_Tooltip_Item_Show_GeneralNormal(index, "EnchantInventory", true, false)
end
function HandleEventLDown_EnchantInventory_SlotLDown(slotIndex)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventoryType = CppEnums.ItemWhereType.eEnchantInventory
  local slotNo = PaGlobal_EnchantInventory_All:getRealSlotNo(slotIndex)
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      return
    end
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
    if nil ~= itemWrapper then
      ProductNote_Item_ShowToggle(itemWrapper:get():getKey():getItemKey())
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
    end
    return
  end
end
function HandleEventLUp_EnchantInventory_DropHandler(slotIndex)
  if nil == DragManager.dragStartPanel then
    return false
  end
  local slotNo = PaGlobal_EnchantInventory_All:getRealSlotNo(slotIndex)
  if true == PaGlobal_Inventory_All_NoDragItem() then
    DragManager:clearInfo()
    return true
  end
  if Panel_Window_EnchantInventory_All == DragManager.dragStartPanel then
    inventory_swapItem(CppEnums.ItemWhereType.eEnchantInventory, DragManager.dragSlotInfo, slotNo)
    DragManager:clearInfo()
  else
    DragManager:itemDragMove(CppEnums.MoveItemToType.Type_EnchantInventory, getSelfPlayer():getActorKey())
  end
  return true
end
function HandleEventPressMove_EnchantInventory_SlotDrag(slotIndex)
  if MessageBoxGetShow() then
    return
  end
  if true == Panel_Window_Extraction_Caphras_All:GetShow() then
    return
  end
  local slotNo = PaGlobal_EnchantInventory_All:getRealSlotNo(slotIndex)
  local whereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  DragManager:setDragInfo(Panel_Window_EnchantInventory_All, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobalFunc_Inventory_All_GroundClick, getSelfPlayer():getActorKey())
  if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() or true == isEquip then
    QuickSlot_ShowBackGround()
  end
  Item_Move_Sound(itemWrapper)
  FGlobal_PopupMoveItem_Init(whereType, slotNo, CppEnums.MoveItemToType.Type_EnchantInventory, getSelfPlayer():getActorKey())
end
function EnchantInventory_updateSlotData()
  local self = PaGlobal_EnchantInventory_All
  if self == nil then
    return
  end
  self:updateSlots()
end
function HandleEventLUp_EnchantInventory_ToggleSortOption()
  if PaGlobal_Inventory_All == nil then
    return
  end
  PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.EnchantInventory)
end
function HandleEventScroll_EnchantInventory_UpdateScroll(isUp)
  local self = PaGlobal_EnchantInventory_All
  local prevSlotIndex = PaGlobal_Inventory_All._showStartSlot
  local maxShowSlotCount = __eTInventorySlotNoMax - __eTInventorySlotNoUseStart
  local intervalSlotIndex = maxShowSlotCount - self._showSlotCount
  local slotRows = self._showSlotCount / self._slotCols
  self._showStartSlot = UIScroll.ScrollEvent(self._ui._scroll, isUp, slotRows, maxShowSlotCount, self._showStartSlot, self._slotCols)
  if prevSlotIndex == self._showStartSlot then
    return
  end
  self:updateSlots()
end
function PaGlobal_EnchantInventory_ShowAni()
  if nil == Panel_Window_EnchantInventory_All then
    return
  end
  Panel_Window_EnchantInventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_EnchantInventory_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_EnchantInventory_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_EnchantInventory_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_EnchantInventory_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_EnchantInventory_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_EnchantInventory_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobal_EnchantInventory_HideAni()
  if nil == Panel_Window_EnchantInventory_All then
    return
  end
  Panel_Window_EnchantInventory_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_EnchantInventory_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_EnchantInventory_UpdateEnchantInventory()
  if nil == Panel_Window_EnchantInventory_All or false == Panel_Window_EnchantInventory_All:GetShow() then
    return
  end
  PaGlobal_EnchantInventory_All:update()
end
function PaGlobalFunc_EnchantInventory_UpdatePerFrame(deltaTime)
  if deltaTime <= 0 then
    return
  end
  local self = PaGlobal_EnchantInventory_All
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local whereType = CppEnums.ItemWhereType.eEnchantInventory
  for ii = 0, self._showSlotCount - 1 do
    local slot = self._slots[ii]
    local slotNo = self:getRealSlotNo(ii)
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    if __eTInventorySlotNoUndefined ~= slotNo then
      remainTime = getItemCooltime(whereType, slotNo)
      itemReuseTime = getItemReuseCycle(whereType, slotNo)
      realRemainTime = remainTime * itemReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
    end
    if remainTime > 0 then
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if itemReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
    elseif slot.cooltime:GetShow() then
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
      local skillSlotItemPosX = slot.cooltime:GetParentPosX()
      local skillSlotItemPosY = slot.cooltime:GetParentPosY()
      audioPostEvent_SystemUi(2, 1)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
      Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
      Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
    end
  end
end
function PaGlobal_EnchantInventory_Open()
  if nil == Panel_Window_EnchantInventory_All or true == Panel_Window_EnchantInventory_All:GetShow() then
    return
  end
  PaGlobal_EnchantInventory_All:prepareOpen()
end
function PaGlobal_EnchantInventory_Close(isOpenEquip)
  if nil == Panel_Window_EnchantInventory_All or false == Panel_Window_EnchantInventory_All:GetShow() then
    return
  end
  PaGlobal_EnchantInventory_All:prepareClose(isOpenEquip)
end
function PaGlobal_EnchantInventory_IsShow()
  if Panel_Window_EnchantInventory_All == nil then
    return nil
  end
  return Panel_Window_EnchantInventory_All:GetShow()
end
function PaGlobal_EnchantInventoryShowToggle()
  if nil == Panel_Window_EnchantInventory_All then
    return
  end
  if true == Panel_Window_EnchantInventory_All:GetShow() then
    InventoryWindow_Close()
  else
    PaGlobal_EnchantInventory_All:prepareOpen()
  end
end
function PaGlobal_EnchantInventory_IsMoveableItem(idx, itemWrapper)
  if itemWrapper == nil then
    return true
  end
  return itemWrapper:checkPushEnchantInventory() == false
end
function PaGlobal_EnchantInventory_PushItemToEnchantInventory(itemCount, slotNo, itemwhereType)
  if Panel_Window_EnchantInventory_All == nil or Panel_Window_EnchantInventory_All:GetShow() == false then
    return
  end
  ToClient_PushEnchantInventoryFromInventory(itemwhereType, slotNo, itemCount)
end
function PaGlobal_EnchantInventory_PopItemFromEnchantInventory(itemCount, slotNo)
  if Panel_Window_EnchantInventory_All == nil or Panel_Window_EnchantInventory_All:GetShow() == false then
    return
  end
  ToClient_PopEnchantInventoryToInventory(slotNo, itemCount)
end
function PaGlobal_EnchantInventory_GetToopTipItem()
  if nil == PaGlobal_EnchantInventory_All._tooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, PaGlobal_EnchantInventory_All._tooltipSlotNo)
end
