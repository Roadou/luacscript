function PaGlobal_AbyssOne_Inventory_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_MainBg = UI.getChildControl(Panel_AbyssOne_EquipPresetList, "Static_MainBG")
  self._ui.stc_InvenBg = UI.getChildControl(self._ui.stc_MainBg, "Static_Group_Inven")
  self._ui.stc_mainSlotBG = UI.getChildControl(self._ui.stc_InvenBg, "Static_BagSlotBG")
  self._ui.scroll_inven = UI.getChildControl(self._ui.stc_mainSlotBG, "Scroll_CashInven")
  self._ui.template_slotBG = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_Slot_Temp")
  self._ui.template_slot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_SlotBG_Temp")
  self:createSlot()
  self:setData()
  self:registEventHandler()
  self:validate()
  self._ui.scroll_inven:SetShow(false)
  self:reset()
  self._initialize = true
end
function PaGlobal_AbyssOne_Inventory_All:registEventHandler()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  UIScroll.InputEvent(self._ui.scroll_inven, "HandleEventScroll_AbyssOne_Inventory_All_UpdateScroll")
  Panel_AbyssOne_EquipPresetList:RegisterUpdateFunc("PaGlobalFunc_AbyssOne_Inventory_All_UpdatePerFrame")
  registerEvent("EventAddItemToInventory", "FromClient_AbyssOneInventory_All_AddItem")
  registerEvent("EventInventorySetShowWithFilter", "PaGlobal_AbyssOne_Inventory_All_SetShowWithFilter")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl")
end
function PaGlobal_AbyssOne_Inventory_All:prepareOpen()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._startSlotIndex = 0
  self._ui.scroll_inven:SetControlTop()
  PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl()
  ToClient_UpdateOpenUICondition(__eCheckOpenUIType_AbyssOneInventory)
  self:open()
end
function PaGlobal_AbyssOne_Inventory_All:open()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.scroll_inven:SetShow(true)
  Panel_AbyssOne_EquipPresetList:SetShow(true)
end
function PaGlobal_AbyssOne_Inventory_All:SetScrolShow(isShow)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.scroll_inven:SetShow(isShow)
end
function PaGlobal_AbyssOne_Inventory_All:prepareClose()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self:reset()
  self:close()
end
function PaGlobal_AbyssOne_Inventory_All:close()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  Panel_AbyssOne_EquipPresetList:SetShow(false)
end
function PaGlobal_AbyssOne_Inventory_All:createSlot()
  for ii = 0, self.config.slotCount - 1 do
    local slot = {}
    slot.empty = UI.createControl(__ePAUIControl_Static, Panel_AbyssOne_EquipPresetList, "Inventory_Slot_Base_" .. ii)
    CopyBaseProperty(self._ui.template_slot, slot.empty)
    UIScroll.InputEventByControl(slot.empty, "HandleEventScroll_AbyssOne_Inventory_All_UpdateScroll")
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.empty:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.empty:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.empty:SetShow(false)
    self._slotsBackground[ii] = slot
  end
  local useStartSlot = inventorySlotNoUserStart()
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = ii + useStartSlot
    local slot = {}
    SlotItem.new(slot, "ItemIcon_" .. ii, ii, Panel_AbyssOne_EquipPresetList, self.slotConfig)
    slot:createChildInInstance()
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AbyssOne_Inventory_All_ShowTooltip(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AbyssOne_Inventory_All_ShowTooltip(false, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_AbyssOne_Inventory_All_RUpEvent(" .. ii .. ")")
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_AbyssOne_Inventory_All_UpdateScroll")
    slot.icon:SetAutoDisableTime(0.2)
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.icon:SetEnableDragAndDrop(false)
    slot.isEmpty = true
    slot.background = UI.createControl(__ePAUIControl_Static, Panel_AbyssOne_EquipPresetList, "Inventory_Slot_BG_" .. ii)
    CopyBaseProperty(self._ui.template_slotBG, slot.background)
    slot.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slot.background:SetPosX(slot.icon:GetPosX())
    slot.background:SetPosY(slot.icon:GetPosY())
    slot.background:SetShow(false)
    slot.icon:SetSize(44, 44)
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.cooltime:SetSize(44, 44)
    slot.cooltime:SetPosX(0)
    slot.cooltime:SetPosY(0)
    self.slots[ii] = slot
  end
end
function PaGlobal_AbyssOne_Inventory_All:setData()
  self.config.slotRows = self.config.slotCount / self.config.slotCols
  self._defaultPosX = Panel_AbyssOne_EquipPresetList:GetPosX()
  self._defaultPosY = Panel_AbyssOne_EquipPresetList:GetPosY()
  self._defaultSizeY = Panel_AbyssOne_EquipPresetList:GetSizeY()
end
function PaGlobal_AbyssOne_Inventory_All:updateInvenControl()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if self._initialize == false then
    return
  end
  if Panel_AbyssOne_EquipPresetList:GetShow() == false then
    return
  end
  if PaGlobal_AbyssOne_EquipPreset._eTab._eBag ~= PaGlobal_AbyssOne_EquipPreset._selectedTab then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  PaGlobal_AbyssOne_EquipPreset:moneyUpdate()
  self._ui.stc_mainSlotBG:SetShow(true)
  local selfPlayer = selfPlayerWrapper:get()
  local useStartSlot = inventorySlotNoUserStart()
  local currentWhereType = CppEnums.ItemWhereType.eInstanceInventory
  local inventory = selfPlayer:getInventoryByType(currentWhereType)
  local invenUseSize = inventory:size()
  local invenMaxSize = inventory:sizeXXX()
  UIScroll.SetButtonSize(self._ui.scroll_inven, self.config.slotCount, invenMaxSize - useStartSlot)
  for ii = 0, self.config.slotCount - 1 do
    local slotBG = self._slotsBackground[ii]
    slotBG.empty:SetShow(true)
    local slot = self.slots[ii]
    slot:clearItem(true)
    slot.icon:SetEnable(true)
    slot.icon:SetIgnore(false)
    slot.icon:SetMonoTone(true)
    slot.isEmpty = true
    slot.icon:EraseAllEffect()
    slot.icon:SetShow(true)
    local slotNo = ii + useStartSlot + self._startSlotIndex
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.bagIcon:SetShow(false)
    local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
    if itemWrapper ~= nil then
      slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
      slot:setItem(itemWrapper, slotNo)
      slot._slotNo = slotNo
      slot.isEmpty = false
      local isFiltered = false
      if self._filterFunc ~= nil then
        isFiltered = self._filterFunc(slotNo, itemWrapper, currentWhereType)
      end
      slot.icon:SetEnable(not isFiltered)
      slot.icon:SetMonoTone(isFiltered)
      slot.icon:SetIgnore(isFiltered)
      if isFiltered == true then
        slot.icon:SetAlpha(0.5)
        slot.icon:EraseAllEffect()
      elseif self._filterFunc ~= nil then
        slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
      end
    end
  end
end
function PaGlobal_AbyssOne_Inventory_All:clerPadSnap()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  for ii = 0, self.config.slotCount - 1 do
    local slotBG = self._slotsBackground[ii]
    if slotBG ~= nil and slotBG.empty ~= nil then
      ToClient_padSnapChangeToTarget(slotBG.empty)
      return
    end
  end
end
function PaGlobal_AbyssOne_Inventory_All:reset()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._filterFunc = nil
  self._rClickFunc = nil
  self._otherWindowOpenFunc = nil
  self._effect = nil
  for ii = 0, self.config.slotCount - 1 do
    local slotBG = self._slotsBackground[ii]
    slotBG.empty:SetShow(false)
    local slot = self.slots[ii]
    slot:clearItem(true)
    slot.icon:SetEnable(true)
    slot.icon:SetIgnore(false)
    slot.icon:SetMonoTone(true)
    slot.isEmpty = true
    slot.icon:EraseAllEffect()
    slot.icon:SetShow(false)
  end
end
function PaGlobal_AbyssOne_Inventory_All:validate()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
end
