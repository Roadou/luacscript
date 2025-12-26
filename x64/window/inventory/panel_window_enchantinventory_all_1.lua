function PaGlobal_EnchantInventory_All:initialize()
  if self._initialize == true then
    return
  end
  local topBG = UI.getChildControl(Panel_Window_EnchantInventory_All, "Static_TopItemSortBG")
  self._ui._btn_sortOption = UI.getChildControl(topBG, "Button_Sort_Set")
  self._ui._chkSort = UI.getChildControl(topBG, "CheckButton_ItemSort")
  self._ui._stcCapacity = UI.getChildControl(topBG, "Static_Text_Capacity")
  local stc_mainSlotBG = UI.getChildControl(Panel_Window_EnchantInventory_All, "Static_MainSlotBG")
  self._ui._scroll = UI.getChildControl(stc_mainSlotBG, "Scroll_CashInven")
  self._ui._stc_scrollArea = UI.getChildControl(Panel_Window_EnchantInventory_All, "Scroll_Area")
  local bottomBG = UI.getChildControl(Panel_Window_EnchantInventory_All, "Static_ButtonTypeBG")
  local backBg = UI.getChildControl(Panel_Window_EnchantInventory_All, "Static_1")
  self._maxSlotCount = __eTCashInventorySlotNoMax
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    backBg:SetDepth(1)
    Panel_Window_EnchantInventory_All:SetDepthSort()
    Panel_Window_EnchantInventory_All:SetSpanSize(620, Panel_Window_EnchantInventory_All:GetSpanSize().y)
  end
  backBg:SetShow(_ContentsGroup_changeFamilyInvenOpenAction)
  local slotGapX = 54
  local slotGapY = 54
  self._showSlotCount = math.floor(stc_mainSlotBG:GetSizeY() / slotGapY) * self._slotCols
  self:initSlotControl(stc_mainSlotBG, slotGapX, slotGapY)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantInventory_All:validate()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  self._ui._btn_sortOption:isValidate()
  self._ui._chkSort:isValidate()
  self._ui._stcCapacity:isValidate()
  self._ui._stc_scrollArea:isValidate()
  self._ui._scroll:isValidate()
end
function PaGlobal_EnchantInventory_All:initSlotControl(stc_mainSlotBG, slotGapX, slotGapY)
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
  local slotStartY = 150
  local template_slotBG = UI.getChildControl(stc_mainSlotBG, "Static_SlotBG_Temp")
  local template_slot = UI.getChildControl(stc_mainSlotBG, "Static_Slot_Temp")
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = {}
    slotBG.background = UI.cloneControl(template_slotBG, Panel_Window_EnchantInventory_All, "FInven_Slot_BG_" .. ii)
    local slot = SlotItem.new(slot, "EnchantInventory_" .. ii, ii, Panel_Window_EnchantInventory_All, slotConfig)
    slot:createChild()
    slotBG.empty = UI.cloneControl(template_slot, Panel_Window_EnchantInventory_All, "FInven_Slot_Base_" .. ii)
    local row = math.floor(ii / self._slotCols)
    local col = ii % self._slotCols
    slot.icon:SetPosX(slotStartX + slotGapX * col)
    slot.icon:SetPosY(slotStartY + slotGapY * row)
    slot.icon:SetSize(44, 44)
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
    slot.icon:SetAutoDisableTime(0.2)
    slot.icon:SetEnableDragAndDrop(true)
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_EnchantInventory_SlotRClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "HandleEventLDown_EnchantInventory_SlotLDown(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantInventory_DropHandler(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_EnchantInventory_SlotDrag(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_EnchantInventory_IconTooltip(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_EnchantInventory_IconTooltip(false, " .. ii .. ")")
    UIScroll.InputEventByControl(slotBG.empty, "HandleEventScroll_EnchantInventory_UpdateScroll")
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_EnchantInventory_UpdateScroll")
    Panel_Tooltip_Item_SetPosition(ii, slot, "EnchantInventory")
    self._slots[ii] = slot
    self._slotsBG[ii] = slotBG
  end
end
function PaGlobal_EnchantInventory_All:registEventHandler()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_EnchantInventory_All, "StaticText_Title")
  local btnClose = UI.getChildControl(titleArea, "Button_Win_Close")
  btnClose:addInputEvent("Mouse_LUp", "PaGlobal_EnchantInventory_Close(true)")
  self._ui._btn_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantInventory_ToggleSortOption()")
  UIScroll.InputEvent(self._ui._scroll, "HandleEventScroll_EnchantInventory_UpdateScroll")
  UIScroll.InputEventByControl(self._ui._stc_scrollArea, "HandleEventScroll_EnchantInventory_UpdateScroll")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_EnchantInventory_UpdateEnchantInventory")
  registerEvent("FromClient_EnchantInventoryChanged", "PaGlobal_EnchantInventory_UpdateEnchantInventory")
  if false == _ContentsGroup_changeFamilyInvenOpenAction then
    Panel_Window_EnchantInventory_All:RegisterShowEventFunc(true, "PaGlobal_EnchantInventory_ShowAni()")
    Panel_Window_EnchantInventory_All:RegisterShowEventFunc(false, "PaGlobal_EnchantInventory_HideAni()")
  end
  Panel_Window_EnchantInventory_All:RegisterUpdateFunc("PaGlobalFunc_EnchantInventory_UpdatePerFrame")
end
function PaGlobal_EnchantInventory_All:prepareOpen()
  if _ContentsGroup_EnchantRemaster == false then
    return
  end
  if Panel_Window_EnchantInventory_All == nil or Panel_Window_EnchantInventory_All:GetShow() == true then
    return
  end
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.EnchantInventory, Panel_Window_EnchantInventory_All, PaGlobal_EnchantInventory_All._ui._btn_sortOption, PaGlobal_EnchantInventory_All._ui._chkSort, nil, nil)
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.EnchantInventory)
  self._showStartSlot = 0
  self:updateSlots()
  self:updateEnchantInventoryInfo()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == _ContentsGroup_changeFamilyInvenOpenAction then
      InventoryWindow_Show()
      PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(false)
    elseif false == Panel_Window_Inventory_All:GetShow() then
      InventoryWindow_Show()
    end
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and true == Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_DyePalette and true == Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if _ContentsGroup_StaticSlot == true then
    if Panel_Window_NewbieInventory_StaticSlot_All ~= nil and Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
      PaGlobalFunc_NewbieInventory_Close()
    end
  elseif Panel_Window_NewbieInventory_All ~= nil and Panel_Window_NewbieInventory_All:GetShow() == true then
    PaGlobalFunc_NewbieInventory_Close()
  end
  if true == _ContentsGroup_NewUI_Equipment_All then
    PaGlobalFunc_Equipment_All_Close(true)
  else
    HandleClicked_EquipmentWindow_Close()
  end
  Inventory_SetFunctor(PaGlobal_EnchantInventory_IsMoveableItem, HandleEventRUp_EnchantInventory_InvenSlotRClick, nil, nil)
  self:open()
  Inventory_SetBottomButton()
end
function PaGlobal_EnchantInventory_All:open()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  Panel_Window_EnchantInventory_All:SetShow(true, not _ContentsGroup_changeFamilyInvenOpenAction)
end
function PaGlobal_EnchantInventory_All:prepareClose(isOpenEquip)
  if Panel_Window_EnchantInventory_All == nil or Panel_Window_EnchantInventory_All:GetShow() == false then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.EnchantInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  if true == isOpenEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Open(true, 1)
    else
      HandleClicked_EquipmentWindow_Open()
    end
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(true)
  InventoryWindow_Show(true, false, false, false, false, true)
  PaGlobal_EnchantInventory_All:close()
end
function PaGlobal_EnchantInventory_All:close()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  Panel_Window_EnchantInventory_All:SetShow(false, not _ContentsGroup_changeFamilyInvenOpenAction)
end
function PaGlobal_EnchantInventory_All:update()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  self:updateSlots()
  self:updateEnchantInventoryInfo()
end
function PaGlobal_EnchantInventory_All:updateSlots()
  if Panel_Window_EnchantInventory_All == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eEnchantInventory)
  local usableSlotCount = inventory:size()
  for ii = 0, self._showSlotCount - 1 do
    local slotBG = self._slotsBG[ii]
    local slot = self._slots[ii]
    if nil ~= slotBG and nil ~= slot then
      local slotNo = self:getRealSlotNo(ii)
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
      if nil == itemWrapper then
        slot:clearItem(true)
      else
        slot:setItem(itemWrapper, slotNo)
      end
      slotBG.empty:SetShow(usableSlotCount > slotNo)
    end
  end
end
function PaGlobal_EnchantInventory_All:updateEnchantInventoryInfo()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eEnchantInventory)
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
  self._ui._stcCapacity:SetText(fontColor .. tostring(useSlotCount) .. "/" .. tostring(self._capacity) .. "<PAOldColor>")
end
function PaGlobal_EnchantInventory_All:slotRClick_MoveMode(slotNo)
  local itemWhereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_EnchantInventory_PopItemFromEnchantInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_EnchantInventory_PopItemFromEnchantInventory)
  end
end
function PaGlobal_EnchantInventory_All:slotRClick_Inventory(slotNo)
  local itemCount = 0
  local itemWhereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_EnchantInventory_PushItemToEnchantInventory(1, slotNo, itemWhereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_EnchantInventory_PushItemToEnchantInventory, false, itemWhereType)
  end
end
function PaGlobal_EnchantInventory_All:getRealSlotNo(slotIndex)
  if false == PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.EnchantInventory) then
    return slotIndex + self._showStartSlot + __eTInventorySlotNoUseStart
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return __eTInventorySlotNoUndefined
  end
  if self._maxSlotCount <= slotIndex + self._showStartSlot then
    return __eTInventorySlotNoUndefined
  end
  return selfPlayerWrapper:get():getRealInventorySlotNoNew(__eInventorySortWhereType_EnchantInventory, slotIndex + self._showStartSlot)
end
