function PaGlobal_NewbieInventory:initialize()
  self._isPadMode = _ContentsGroup_UsePadSnapping
  UI.getChildControl(Panel_Window_NewbieInventory_All, "StaticText_Title")
  self._ui._stc_body = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_1")
  self._ui._arrowEffect = UI.getChildControl(self._ui._stc_body, "Button_1")
  self._ui._stc_title = UI.getChildControl(Panel_Window_NewbieInventory_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close")
  self._ui._stc_topItemSortBG = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_TopItemSortBG")
  self._ui._btn_sort_set = UI.getChildControl(self._ui._stc_topItemSortBG, "Button_Sort_Set")
  self._ui._chk_itemSort = UI.getChildControl(self._ui._stc_topItemSortBG, "CheckButton_ItemSort")
  self._ui._stc_capacity = UI.getChildControl(self._ui._stc_topItemSortBG, "Static_Text_Capacity")
  self._ui._stc_mainSlotBG = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_MainSlotBG")
  self._ui._scroll = UI.getChildControl(self._ui._stc_mainSlotBG, "Scroll_CashInven")
  self._ui._stc_scrollArea = UI.getChildControl(Panel_Window_NewbieInventory_All, "Scroll_Area")
  self._ui._stc_WeightArea = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_Texture_Weight_Background")
  self._ui._txt_Weight = UI.getChildControl(self._ui._stc_WeightArea, "StaticText_Weight")
  self._ui._btn_moveItem = UI.getChildControl(self._ui._stc_WeightArea, "Button_Move")
  self._ui._stc_block = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_Block")
  self._ui._btn_send = UI.getChildControl(self._ui._stc_block, "Button_Send")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_Window_NewbieInventory_All, "Static_Key_Guide")
  local slotGapX = 54
  local slotGapY = 54
  self._showSlotCount = 50
  self._restrictOpen = false
  self:initSlotControl(self._ui._stc_mainSlotBG, slotGapX, slotGapY)
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_NewbieInventory:registerEvent()
  Panel_Window_NewbieInventory_All:RegisterShowEventFunc(true, "PaGlobalFunc_NewbieInventory_All_ShowAni()")
  Panel_Window_NewbieInventory_All:RegisterShowEventFunc(false, "PaGlobalFunc_NewbieInventory_All_HideAni()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_NewbieInventory_Close()")
  self._ui._btn_sort_set:addInputEvent("Mouse_LUp", "HandleEventLUp_NewbieInventory_All_ShowSortOption()")
  self._ui._btn_send:addInputEvent("Mouse_LUp", "HandleEventLUp_NewbieInventory_All_SendWarehouse()")
  self._ui._btn_moveItem:addInputEvent("Mouse_LUp", "HandleEventLUp_NewbieInventory_All_MoveItem()")
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_NewbieInventory_UpdateInventory")
end
function PaGlobal_NewbieInventory:validate()
end
function PaGlobal_NewbieInventory:prepareOpen()
  if ToClient_isShowBlackSpiritInventory() == false then
    return
  end
  if self._isPadMode == true then
    if Panel_Window_Inventory == nil or Panel_Window_Inventory:GetShow() == false then
      return
    end
    if Panel_Window_StackExtraction_All ~= nil and Panel_Window_StackExtraction_All:GetShow() == true then
      return
    end
    local invenPosY = Panel_Window_Inventory:GetPosY()
    local invenPosX = Panel_Window_Inventory:GetPosX()
    if _ContentsGroup_RenewUI == true then
      Panel_Window_NewbieInventory_All:SetPosX(invenPosX - self._ui._stc_body:GetSizeX() + self._ui._arrowEffect:GetSizeX() + self._ui._arrowEffect:GetSpanSize().x)
      self._ui._arrowEffect:SetShow(false)
    else
      Panel_Window_NewbieInventory_All:SetPosX(invenPosX - self._ui._stc_body:GetSizeX())
      self._ui._arrowEffect:SetShow(true)
    end
    Panel_Window_NewbieInventory_All:SetPosY(invenPosY + Panel_Window_Inventory:GetSizeY() / 2 - Panel_Window_NewbieInventory_All:GetSizeY() / 2)
    self._ui._stc_body:SetShow(true)
    self._ui._stc_keyGuide:SetShow(true)
    self._ui._stc_WeightArea:SetSize(400, 5)
    self._ui._txt_Weight:ComputePos()
    self._ui._btn_moveItem:SetShow(false)
    Inventory_SetFunctor(PaGlobalFunc_NewbieInvnetory_IsMoveableItem, HandleEventRUp_NewbieInventory_InvenSlotRClick, nil, nil)
    self._canMoveItem = true
  else
    local equipPosX = Panel_Window_Equipment_All:GetPosX() - Panel_Window_NewbieInventory_All:GetSizeX() - 5
    local equipPosY = Panel_Window_Equipment_All:GetPosY()
    if Panel_Window_Equipment_All:IsUISubApp() == true then
      equipPosX = getScreenSizeX() / 2 - Panel_Window_NewbieInventory_All:GetSizeX() / 2
      equipPosY = getScreenSizeY() / 2 - Panel_Window_NewbieInventory_All:GetSizeY() / 2
    end
    Panel_Window_NewbieInventory_All:SetPosX(equipPosX)
    Panel_Window_NewbieInventory_All:SetPosY(equipPosY)
    self._ui._stc_body:SetShow(false)
    self._ui._stc_keyGuide:SetShow(false)
    PaGlobal_Inventory_All:deleteMode_setShow(false)
    self._ui._stc_WeightArea:SetSize(275, 5)
    self._ui._txt_Weight:ComputePos()
    self._ui._btn_moveItem:SetShow(true)
    Inventory_SetFunctor(nil, nil, nil, nil)
    self._canMoveItem = false
  end
  self:update()
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.NewbieInventory, Panel_Window_NewbieInventory_All, self._ui._btn_sort_set, self._ui._chk_itemSort, nil, nil)
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.NewbieInventory)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper ~= nil then
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    if userType == __eEAdmissionSpeedChannelType_Newbie then
      self._ui._stc_block:SetShow(false)
    else
      self._ui._stc_block:SetShow(true)
    end
  end
  self:open()
end
function PaGlobal_NewbieInventory:open()
  Panel_Window_NewbieInventory_All:SetShow(true, true)
end
function PaGlobal_NewbieInventory:prepareClose()
  if self._canMoveItem == true then
    Inventory_SetFunctor(nil, nil, nil, nil)
    self._canMoveItem = false
  end
  if true == self._ui._stc_body:GetShow() then
    if true == self._isPadMode then
      self:close()
      return
    end
    self._ui._stc_body:SetShow(false)
  else
    self:close()
    return
  end
  if Panel_Window_Inventory_All ~= nil and Panel_Window_Inventory_All:GetShow() == true then
    PaGlobalFunc_Equipment_All_Open()
  end
  if false == Panel_Window_Inventory_All:GetShow() then
    self:close()
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.NewbieInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
end
function PaGlobal_NewbieInventory:close()
  Panel_Window_NewbieInventory_All:SetShow(false)
end
function PaGlobal_NewbieInventory:initSlotControl(stc_mainSlotBG, slotGapX, slotGapY)
  if nil ~= self._slotsBG then
    return
  end
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    isTranslation = true
  }
  self._slotsBG = Array.new()
  self._slots = Array.new()
  local slotStartX = 15
  local slotStartY = 10
  local template_slotBG = UI.getChildControl(stc_mainSlotBG, "Static_SlotBG_Temp")
  local template_slot = UI.getChildControl(stc_mainSlotBG, "Static_Slot_Temp")
  local template_lockSlot = UI.getChildControl(stc_mainSlotBG, "Static_LockSlot_Temp")
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = {}
    slotBG.background = UI.cloneControl(template_slotBG, self._ui._stc_mainSlotBG, "FInven_Slot_BG_" .. ii)
    local slot = SlotItem.new(slot, "NewbieInventory_" .. ii, ii, self._ui._stc_mainSlotBG, slotConfig)
    CopyBaseProperty(template_slot, slot.icon)
    slot:createChild()
    slotBG.empty = UI.cloneControl(template_slot, self._ui._stc_mainSlotBG, "FInven_Slot_Base_" .. ii)
    slotBG.lock = UI.cloneControl(template_lockSlot, self._ui._stc_mainSlotBG, "FInven_Slot_Lock_" .. ii)
    local row = math.floor(ii / self._slotCols)
    local col = ii % self._slotCols
    slot.icon:SetPosX(slotStartX + slotGapX * col)
    slot.icon:SetPosY(slotStartY + slotGapY * row)
    slot.icon:SetSize(44, 44)
    slot.icon:SetShow(true)
    slot.icon:SetIgnore(false)
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.cooltime:SetSize(44, 44)
    slot.cooltime:SetPosX(0)
    slot.cooltime:SetPosY(0)
    slotBG.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slotBG.background:SetPosX(slot.icon:GetPosX())
    slotBG.background:SetPosY(slot.icon:GetPosY())
    slotBG.background:SetShow(true)
    slotBG.empty:SetPosX(slotStartX + slotGapX * col)
    slotBG.empty:SetPosY(slotStartY + slotGapY * row)
    slotBG.lock:SetPosX(slotStartX + slotGapX * col)
    slotBG.lock:SetPosY(slotStartY + slotGapY * row)
    slot.icon:SetAutoDisableTime(0.2)
    slot.icon:SetEnableDragAndDrop(true)
    if _ContentsGroup_RenewUI == true then
      slot.icon:addInputEvent("Mouse_On", "HandleEventOn_NewbieInventory_All_ItemFloatingToolTip(true, " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_NewbieInventory_All_ItemFloatingToolTip(false, " .. ii .. ")")
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_NewbieInventory_SlotRClick(" .. ii .. ")")
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadX_NewbieInventory_All_ShowItemInfo(true, " .. ii .. ")")
    else
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_NewbieInventory_IconTooltip(true, " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_NewbieInventory_IconTooltip(false, " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_NewbieInventory_SlotRClick(" .. ii .. ")")
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_NewbieInventory_SlotRClick(" .. ii .. ")")
    end
    Panel_Tooltip_Item_SetPosition(ii, slot, "NewbieInventory")
    self._slots[ii] = slot
    self._slotsBG[ii] = slotBG
  end
end
function PaGlobal_NewbieInventory:update()
  self:updateSlots()
  self:updateNewbieInventoryInfo()
end
function PaGlobal_NewbieInventory:updateSlots()
  if false == self._initialize then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eNewbieInventory)
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = self._slotsBG[ii]
    local slot = self._slots[ii]
    if nil ~= slotBG and nil ~= slot then
      local slotNo = self:getRealSlotNo(ii)
      local itemWrapper = getNewbieInventoryItem(slotNo)
      if nil == itemWrapper then
        slot:clearItem(true)
      else
        slot:setItem(itemWrapper, slotNo)
      end
      slotBG.empty:SetShow(true)
    end
  end
end
function PaGlobal_NewbieInventory:updateNewbieInventoryInfo()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eNewbieInventory)
  self._capacity = inventory:size() - __eTInventorySlotNoUseStart
  local freeCount = inventory:getFreeCount()
  local useSlotCount = self._capacity - freeCount
  local leftCountPercent = useSlotCount / self._capacity * 100
  if leftCountPercent >= 100 then
    fontColor = "<PAColor0xFFF03838>"
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  self._ui._stc_capacity:SetText(fontColor .. tostring(useSlotCount) .. "/" .. tostring(self._capacity) .. "<PAOldColor>")
  local weight_s64 = inventory:getWeight_s64()
  local finalWeight = string.format("%.1f", Int64toInt32(weight_s64 / Defines.s64_const.s64_100) / 100)
  self._ui._txt_Weight:SetText(finalWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function PaGlobal_NewbieInventory:getRealSlotNo(slotIndex)
  if false == PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.NewbieInventory) then
    return slotIndex + self._showStartSlot + __eTInventorySlotNoUseStart
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return __eTInventorySlotNoUndefined
  end
  if self._maxSlotCount <= slotIndex + self._showStartSlot then
    return __eTInventorySlotNoUndefined
  end
  return selfPlayerWrapper:get():getRealInventorySlotNoNew(__eInventorySortWhereType_NewbieInventory, slotIndex + self._showStartSlot)
end
function PaGlobal_NewbieInventory:popItem(slotNo)
  local itemWhereType = CppEnums.ItemWhereType.eNewbieInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if itemCount == Defines.s64_const.s64_1 then
    PaGlobalFunc_NewbieInventory_PopItemFromNewbieInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_NewbieInventory_PopItemFromNewbieInventory)
  end
end
function PaGlobal_NewbieInventory:slotRClick_Inventory(slotNo)
  local itemCount = 0
  local itemWhereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  itemCount = itemWrapper:get():getCount_s64()
  if itemCount == Defines.s64_const.s64_1 then
    PaGlobalFunc_NewbieInvnetory_PushItemToNewbieInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_NewbieInvnetory_PushItemToNewbieInventory, false, itemWhereType)
  end
end
