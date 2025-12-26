function PaGlobalFunc_OldMoonSmelting_Open()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_OldMoonSmelting_Close()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_OldMoonSmelting_OnCreateListContent(content, key)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:createSmeltableItemContent(content, key)
end
function PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(isShow, slotNo, isEquipedItem)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
  else
    local itemWraaper
    if true == isEquipedItem then
      itemWraaper = ToClient_getEquipmentItem(slotNo)
    else
      itemWraaper = getInventoryItem(slotNo)
    end
    if nil == itemWraaper then
      return
    end
    Panel_Tooltip_Item_Show(itemWraaper, panel, false, true)
  end
end
function PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(isShow)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
  else
    local materialItemSSW = ToClient_getOldMoonSmeltingMaterialItemSSW()
    if nil == materialItemSSW then
      return
    end
    Panel_Tooltip_Item_Show(materialItemSSW, panel, true, false)
  end
end
function PaGlobalFunc_OldMoonSmelting_ShowSelectedItemTooltip(isShow)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if -1 == self._currentSelectedSlotNoIndex then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
  else
    local realSlotNo = self._listInfo._slotNoList[self._currentSelectedSlotNoIndex]
    local itemWraaper = getInventoryItem(realSlotNo)
    if nil == itemWraaper then
      return
    end
    Panel_Tooltip_Item_Show(itemWraaper, panel, false, true)
  end
end
function PaGlobalFunc_OldMoonSmelting_ClearTargetItemSlot()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if true == self._isPlayingSmeltingAnimation then
    return
  end
  self:clearSmeltingTargetItem()
  self:clearMaterialItem()
end
function PaGlobalFunc_OldMoonSmelting_ClearMaterialItemSlot()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if true == self._isPlayingSmeltingAnimation then
    return
  end
  self:clearMaterialItem()
end
function PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(slotNoIndex, isEquipedItem)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:clearMaterialItem()
  if true == isEquipedItem then
    self:releaseEquipItem(slotNoIndex)
  else
    self:selectItem(slotNoIndex)
  end
end
function PaGlobalFunc_OldMoonSmelting_OnClickedDoSmeltingButton()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  if true == self._isPlayingSmeltingAnimation then
    self._ui._stc_smeltingEffect:EraseAllEffect()
    self:cancelSmelting()
  else
    self:doSmelting()
  end
end
function PaGlobalFunc_OldMoonSmelting_OnClickedMaterialItemButton()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:inputMaterialItem()
end
function PaGlobalFunc_OldMoonSmelting_OnInputedMaterialCount(inputNumber, slotNo)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:fillMaterialItem(inputNumber)
end
function PaGlobalFunc_OldMoonSmelting_Update(deltaTime)
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:update(deltaTime)
end
function FromClient_OldMoonSmelting_UpdateItemList()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false, nil, nil)
  self:updateSmeltableItemList()
end
function FromClient_OldMoonSmelting_Result()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local self = PaGlobal_OldMoonSmelting
  if nil == self then
    return
  end
  self:cancelSmelting()
  self:clearMaterialItem()
  self:refreshMaterialItemIcon()
  self:refreshSmeltingProgressInfo()
  self:refreshListSelectedContent()
end
