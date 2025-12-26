function PaGlobalFunc_MonsterBuffZoneItemRepair_Open()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_OpenByMenu()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  local isInvenOpen = false
  if _ContentsGroup_NewUI_Inventory_All == true then
    isInvenOpen = Panel_Window_Inventory_All:IsShow()
  else
    isInvenOpen = Panel_Window_Inventory:IsShow()
  end
  if isInvenOpen == true then
    InventoryWindow_Close()
  end
  self:prepareOpen()
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_Close()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return false
  end
  return Panel_Window_MonsterBuffZoneItemRepair:GetShow()
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:isMonsterBuffZoneItem() == true then
    return false
  end
  local materialItemSSW = ToClient_GetMonsterBuffZoneMaterialItemSSW()
  if materialItemSSW == nil then
    return true
  end
  if materialItemSSW:get()._key:getItemKey() == itemSSW:get()._key:getItemKey() then
    return false
  end
  return true
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_RClickFunction(slotNo, itemWrapper, s64_count, inventoryType)
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local itemKey = itemSSW:get()._key:getItemKey()
  local itemCount = Int64toInt32(s64_count)
  if itemSSW:isMonsterBuffZoneItem() == true then
    self:fillMonsterBuffZoneItem(slotNo, itemKey, inventoryType)
  else
    local function setMonsterBuffZoneMaterialItem(count_s64)
      local selectCount = Int64toInt32(count_s64)
      if selectCount > 0 then
        self:fillMaterialItem(slotNo, itemKey, selectCount, inventoryType)
      end
      return
    end
    Panel_NumberPad_Show(true, s64_count, nil, setMonsterBuffZoneMaterialItem, false, nil)
  end
end
function PaGlobalFunc_MonsterBuffZoneItemRepair_Update(deltaTime)
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function HandleEventOnOut_MonsterBuffZone_ShowMonsterBuffZoneItemTooltip(isShow)
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if self._selectItemInfo_Dekia == nil then
    return
  end
  local itemWraaper = getInventoryItem(self._selectItemInfo_Dekia._slotNo)
  if itemWraaper == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemWraaper, Panel_Window_MonsterBuffZoneItemRepair, false, true)
end
function HandleEventRUp_MonsterBuffZone_ClearMonsterBuffZoneItemSlot()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self:clearMonsterBuffZoneItem()
end
function HandleEventOnOut_MonsterBuffZone_ShowMaterialItemTooltip(isShow)
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if self._selectItemInfo_Material == nil then
    return
  end
  local materialItemSSW = ToClient_GetMonsterBuffZoneMaterialItemSSW()
  if materialItemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(materialItemSSW, Panel_Window_MonsterBuffZoneItemRepair, true, false)
end
function HandleEventRUp_MonsterBuffZone_ClearMaterialItemSlot()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self:clearMaterialItem()
end
function HandleEventLUp_MonsterBuffZoneRapair_RequestRepair()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  if self._isPlayingAnimation == true then
    self._ui._stc_effectBG:EraseAllEffect()
    self:stopAnimationSound()
    self:cancelRepair()
  else
    self:doRepair()
  end
end
function FromClient_MonsterBuffZoneItemRepair_Result()
  local self = PaGlobal_MonsterBuffZoneItemRepair
  if self == nil then
    return
  end
  self._ui._stc_effectBG:EraseAllEffect()
  self._ui._stc_effectBG:AddEffect("fUI_DekiaLanterns_Charge_01B", false, 0, 0)
  self:playSuccessRepairSound()
  self:cancelRepair()
  self:clearMaterialItem()
  local slotNo = self._selectItemInfo_Dekia._slotNo
  local itemKey = self._selectItemInfo_Dekia._itemKey
  local inventoryType = self._selectItemInfo_Dekia._inventoryType
  self:fillMonsterBuffZoneItem(slotNo, itemKey, inventoryType)
end
