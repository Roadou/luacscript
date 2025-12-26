function PaGlobalFunc_CombineBag_Open()
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_CombineBag_Close()
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_CombineBag_DropHandler(slotNo)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if DragManager:isDragging() == false then
    return
  end
  if self._isConsole == false and PaGlobal_Inventory_All_NoDragItem() == true then
    DragManager:clearInfo()
    return true
  end
  local fromSlotNo = DragManager:getDraggedItemSlotNo()
  if DragManager.dragStartPanel == Panel_Window_Inventory_All then
    self:setSlotItem(fromSlotNo, slotNo)
    DragManager:clearInfo()
    Inventory_updateSlotData()
  elseif DragManager.dragStartPanel == Panel_Window_CombineBag then
    self:swapSlotItemPosition(fromSlotNo, slotNo)
    DragManager:clearInfo()
  else
    return
  end
  self:findPuzzle()
  return true
end
function HandleEventPressMove_CombineBag_SlotDrag(slotNo)
  if MessageBoxGetShow() then
    return
  end
  DragManager:cancelInfo()
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  local slot = self._slots[slotNo]
  if slot._invenSlotNo == nil then
    return
  end
  local pressedInvenSlotNo = slot._invenSlotNo
  local whereType = CppEnums.ItemWhereType.eInventory
  local itemWrapper = getInventoryItemByType(whereType, pressedInvenSlotNo)
  DragManager:setDragInfo(Panel_Window_CombineBag, nil, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobalFunc_CombineBag_GroundClick, getSelfPlayer():getActorKey())
  Item_Move_Sound(itemWrapper)
end
function HandleEventRUp_CombineBag_SlotRClick(slotNo)
  if MessageBoxGetShow() then
    return
  end
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if self._slots[slotNo]._invenSlotNo == nil then
    return
  end
  self:clearSlotItem(slotNo)
  self:findPuzzle()
  Inventory_updateSlotData()
end
function HandleEventLUp_CombineBag_MakePuzzle(slotNo)
  local maxCount = ToClient_getMaxCountMakePuzzle(slotNo)
  if maxCount > 20 then
    maxCount = 20
  end
  if maxCount > 1 then
    Panel_NumberPad_Show_MaxCount(true, toInt64(0, maxCount), slotNo, PaGlobalFunc_CombineBag_MakePuzzle)
  else
    for ii = 0, PaGlobal_CombineBag._config.slotCount - 1 do
      if isSlotUsedInPuzzle(slotNo, ii) then
        PaGlobal_CombineBag:clearSlotItem(ii)
      end
    end
    requestMakePuzzleFromCombine(slotNo, 1)
    PaGlobal_CombineBag:findPuzzle()
    Inventory_updateSlotData()
  end
end
function PaGlobalFunc_CombineBag_MakePuzzle(s64_resultCount, slotNo)
  local s32_resultCount = Int64toInt32(s64_resultCount)
  if s32_resultCount == 0 then
    return
  end
  for ii = 0, PaGlobal_CombineBag._config.slotCount - 1 do
    if s32_resultCount ~= 1 or isSlotUsedInPuzzle(slotNo, ii) then
      PaGlobal_CombineBag:clearSlotItem(ii)
    end
  end
  requestMakePuzzleFromCombine(slotNo, s32_resultCount)
  PaGlobal_CombineBag:findPuzzle()
  Inventory_updateSlotData()
end
function PaGlobalFunc_CombineBag_GroundClick(whereType, slotNo)
  if MessageBoxGetShow() then
    return
  end
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if self:isShowPanel() == false or self._slots[slotNo]._invenSlotNo == nil then
    return
  end
  DragManager:clearInfo()
  self:clearSlotItem(slotNo)
  self:findPuzzle()
  Inventory_updateSlotData()
end
function PaGlobal_CombineBag_Filter(slotNo, itemWrapper, inventoryType)
  local self = PaGlobal_CombineBag
  if self == nil then
    return true
  end
  if inventoryType ~= __eItemWhereTypeInventory then
    return true
  end
  if self:isCanEnrollEnoughItem(slotNo) == false then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:get():isPuzzleItem() == true then
    return false
  end
  return true
end
function PaGlobal_CombineBag_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  local fromSlotNo = DragManager:getDraggedItemSlotNo()
  if fromSlotNo ~= nil and fromSlotNo == slotNo then
    DragManager:cancelInfo()
  end
  local s32_itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
  local canEnrollItemCount = s32_itemCount
  local emptySlotCount = 0
  for ii = 0, self._config.slotCount - 1 do
    if self._slots[ii] ~= nil then
      if self._slots[ii]._invenSlotNo == nil then
        emptySlotCount = emptySlotCount + 1
      elseif self._slots[ii]._invenSlotNo == slotNo then
        canEnrollItemCount = canEnrollItemCount - 1
      end
    end
  end
  canEnrollItemCount = math.min(emptySlotCount, canEnrollItemCount)
  if canEnrollItemCount == 0 then
    return
  end
  if canEnrollItemCount > 1 then
    Panel_NumberPad_Show_MaxCount(true, toInt64(0, canEnrollItemCount), slotNo, PaGlobal_CombineBag_EnrollItemInvenToCombineBag)
  else
    PaGlobal_CombineBag_EnrollItemInvenToCombineBag(toInt64(0, 1), slotNo)
  end
end
function PaGlobal_CombineBag_EnrollItemInvenToCombineBag(s64_insertCount, slotNo)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  for inserCount = 1, Int64toInt32(s64_insertCount) do
    for ii = 0, self._config.slotCount - 1 do
      if self._slots[ii]._invenSlotNo == nil then
        self:setSlotItem(slotNo, ii)
        break
      end
    end
  end
  self:findPuzzle()
  Inventory_updateSlotData()
end
function HandleEventOnOut_CombineBag_Slot(isOn, index)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  CombineBag_ShowItemTooltip(isOn, index)
  if isOn == true then
    if self._slots[index] ~= nil and self._slots[index]._invenSlotNo ~= nil then
      self:changePadSnapState(PaGlobal_CombineBag._PAD_SNAP_STATE.OnItem)
    else
      self:changePadSnapState(PaGlobal_CombineBag._PAD_SNAP_STATE.Default)
    end
  else
    self:changePadSnapState(PaGlobal_CombineBag._PAD_SNAP_STATE.Default)
  end
end
function HandleEventOnOut_CombineBag_PuzzleButton(isOn, index)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  CombineBag_ShowPuzzleTooltip(isOn, index)
  if isOn == true then
    self:changePadSnapState(PaGlobal_CombineBag._PAD_SNAP_STATE.OnPuzzleBtn)
  else
    self:changePadSnapState(PaGlobal_CombineBag._PAD_SNAP_STATE.Default)
  end
end
function CombineBag_ShowItemTooltip(isShow, index)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if isShow == false then
    PaGlobal_CombineBag._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CombineBag", false, false)
    TooltipSimple_Hide()
    return
  end
  if self._slots[index] == nil or self._slots[index]._invenSlotNo == nil then
    return
  end
  self._tooltipSlotNo = self._slots[index]._invenSlotNo
  if _ContentsGroup_RenewUI_Tooltip == false then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CombineBag", true, false)
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._slots[index]._invenSlotNo)
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.CombineBag, nil, "Inventory")
  end
end
function CombineBag_ShowPuzzleTooltip(isShow, index)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if isShow == false then
    self._ui.txt_puzzleNoticeText:SetShow(false)
    self._ui.stc_puzzleNotice:SetShow(false)
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self._ui.txt_puzzleNoticeText:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_puzzleNoticeText:SetAutoResize(true)
  self._ui.txt_puzzleNoticeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DOPUZZLE"))
  local slot = self._slots[index]
  self._ui.stc_puzzleNotice:SetPosX(slot.icon:GetPosX() - self._ui.stc_puzzleNotice:GetSizeX())
  self._ui.stc_puzzleNotice:SetPosY(slot.icon:GetPosY() + self._ui.stc_titleBox:GetSizeY() + self._ui.stc_noticeBox:GetSizeY())
  self._ui.stc_puzzleNotice:SetSize(self._ui.txt_puzzleNoticeText:GetSizeX() + 20, self._ui.txt_puzzleNoticeText:GetTextSizeY() + 20)
  self._ui.stc_puzzleNotice:SetColor(Defines.Color.C_FF000000)
  self._ui.stc_puzzleNotice:SetShow(true)
  self._ui.txt_puzzleNoticeText:SetShow(true)
end
function PaGlobal_CombineBag_GetToolTipItem()
  if PaGlobal_CombineBag._tooltipSlotNo == nil then
    return nil
  end
  return getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_CombineBag._tooltipSlotNo)
end
function PaGlobal_CombineBag_ShowTooltip(index)
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if self._slots[index] == nil or self._slots[index]._invenSlotNo == nil then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._slots[index]._invenSlotNo), Defines.TooltipTargetType.Item, Panel_Window_CombineBag:GetPosX() - 4, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function FromClient_PaGlobalFunc_CombineBag_UpdateInventory()
  local self = PaGlobal_CombineBag
  if self == nil then
    return
  end
  if Panel_Window_CombineBag:GetShow() == false then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  for index = 0, temporaryWrapper:getChangedInventorySlotCount() - 1 do
    local slotNo = temporaryWrapper:getChangedInventorySlotNo(index)
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if itemWrapper == nil then
      for ii = 0, self._config.slotCount - 1 do
        if self._slots[ii]._invenSlotNo == slotNo then
          self:clearSlotItem(ii)
        end
      end
    end
  end
  self:findPuzzle()
end
