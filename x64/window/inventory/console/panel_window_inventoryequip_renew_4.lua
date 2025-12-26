local _panel = Panel_Window_Inventory
function PaGlobal_Inventory_All_ForConsole:initEnchantInventory_category()
  self._ui.btn_enchantInvenSlotView = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "RadioButton_Slot")
  self._ui.btn_enchantInvenCategoryView = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "RadioButton_List")
  self._ui.btn_enchantInvenSlotView:SetShow(_ContentsGroup_InvenCategory)
  self._ui.btn_enchantInvenCategoryView:SetShow(_ContentsGroup_InvenCategory)
  local ui_enchantInvenGroup = UI.getChildControl(Panel_Window_Inventory, "Static_EnchantInvenGroup")
  self._ui.stc_enchantInvenCategoryBG = UI.getChildControl(ui_enchantInvenGroup, "Static_CategorySlotBG")
  self._ui.frame_enchantInvenCategory = UI.getChildControl(self._ui.stc_enchantInvenCategoryBG, "Frame_Category")
  self._ui.frame_enchantInvenCategoryContent = UI.getChildControl(self._ui.frame_enchantInvenCategory, "Frame_1_Content")
  self._ui.frame_enchantInvenCategoryVerticalScroll = UI.getChildControl(self._ui.frame_enchantInvenCategory, "Frame_1_VerticalScroll")
  self._ui.stc_enchantInvenCategoryGroup = UI.getChildControl(self._ui.frame_enchantInvenCategoryContent, "Static_Group")
  self._ui.txt_enchantInvenCategoryTitle = UI.getChildControl(self._ui.stc_enchantInvenCategoryGroup, "StaticText_GroupTitle")
  self._ui.stc_enchantInvenDeco = UI.getChildControl(self._ui.stc_enchantInvenCategoryGroup, "Static_DecoLine")
  self._ui.txt_enchantInvenNoItem = UI.getChildControl(self._ui.stc_enchantInvenCategoryBG, "StaticText_No_Itemlog")
  self._ui.stc_enchantInvenTempSlot = UI.getChildControl(self._ui.stc_enchantInvenCategoryBG, "Static_Slot_Temp")
  self._ui.stc_enchantInvenTempBgSlot = UI.getChildControl(self._ui.stc_enchantInvenCategoryBG, "Static_SlotBG_Temp")
  self._ui.enchantInvenCategoryTitleList = {}
  self._ui.enchantInvenCategorySlotList = {}
  self._ui.enchantInvenCategorySlotBgList = {}
  self:enchantInvenCategoryTitleInit()
  self:enchantInvenCategorySlotInit()
  self:enchantInvenCategorySlotRegisterEvent()
  self:enchantInvenClearCategoryAndSlot()
end
function PaGlobal_Inventory_All_ForConsole:enchantInvenCategoryTitleInit()
  for categoryType = 0, __eInvenCategoryType_Count - 1 do
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_enchantInvenCategoryContent, "Static_Group", self._ui.frame_enchantInvenCategoryContent, "CategoryGroup_" .. categoryType)
    if tempContent ~= nil then
      local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_enchantInvenCategoryGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. categoryType)
      local tempDeco = UI.createAndCopyBasePropertyControl(self._ui.stc_enchantInvenCategoryGroup, "Static_DecoLine", tempContent, "StaticText_GroupDeco_" .. categoryType)
      self._ui.enchantInvenCategoryTitleList[categoryType] = {}
      self._ui.enchantInvenCategoryTitleList[categoryType].content = tempContent
      self._ui.enchantInvenCategoryTitleList[categoryType].titleName = tempTitleName
      self._ui.enchantInvenCategoryTitleList[categoryType].deco = tempDeco
      self._ui.enchantInvenCategoryTitleList[categoryType].titleName:SetText(ToClient_getCategoryNameByType(categoryType))
      self._ui.enchantInvenCategoryTitleList[categoryType].content:SetShow(true)
      self._ui.enchantInvenCategoryTitleList[categoryType].titleName:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_02_Inventory_Category_" .. tostring(categoryType))
      self._ui.enchantInvenCategoryTitleList[categoryType].titleName:setRenderTexture(self._ui.enchantInvenCategoryTitleList[categoryType].titleName:getBaseTexture())
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:enchantInvenCategorySlotInit()
  local slotTemplate = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotTemplate")
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
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.enchantInvenCategorySlotBgList[slotNo] = UI.cloneControl(slotTemplate, self._ui.frame_enchantInvenCategoryContent, "InventoryInfo_CategoryInvenSlotBG_" .. slotNo)
    self._ui.enchantInvenCategorySlotBgList[slotNo]:SetEnableDragAndDrop(false)
    self._ui.enchantInvenCategorySlotBgList[slotNo]:SetShow(true)
    self._ui.enchantInvenCategorySlotList[slotNo] = {}
    SlotItem.new(self._ui.enchantInvenCategorySlotList[slotNo], "InvenSlot_" .. slotNo, slotNo, self._ui.enchantInvenCategorySlotBgList[slotNo], slotConfig)
    self._ui.enchantInvenCategorySlotList[slotNo]:createChild()
    self._ui.enchantInvenCategorySlotList[slotNo].icon:SetIgnore(true)
    self._ui.enchantInvenCategorySlotList[slotNo].icon:SetPosXY(1, 1)
    self._ui.enchantInvenCategorySlotList[slotNo].icon:SetSize(42, 42)
    self._ui.enchantInvenCategorySlotList[slotNo].border:SetSize(44, 44)
    self._ui.enchantInvenCategorySlotList[slotNo].count:ComputePos()
    self._ui.enchantInvenCategorySlotList[slotNo].lock = UI.createAndCopyBasePropertyControl(_panel, "Static_LockedSlot", self._ui.enchantInvenCategorySlotBgList[slotNo], "Static_LockedCategorySlot_" .. slotNo)
    self._ui.enchantInvenCategorySlotList[slotNo].lock:SetShow(false)
    local multiSelectControl = UI.getChildControl(self._ui.enchantInvenCategorySlotBgList[slotNo], "Static_MultipleSelect")
    multiSelectControl:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:enchantInvenCategorySlotRegisterEvent()
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.enchantInvenCategorySlotBgList[slotNo]:addInputEvent("Mouse_On", "InputMOnOut_Inventory_All_ForConsole_CategoryEnchantInvenShowTooltip(" .. slotNo .. ", true)")
    self._ui.enchantInvenCategorySlotBgList[slotNo]:addInputEvent("Mouse_Out", "InputMOnOut_Inventory_All_ForConsole_CategoryEnchantInvenShowTooltip(" .. slotNo .. ", false)")
    self._ui.enchantInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PadEventRSClick_Inventory_All_ForConsole_OpenCraftNote(" .. slotNo .. ", true)")
    self._ui.enchantInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PadEventUpA_Inventory_All_ForConsole_EnchantInvenSlotUseItem(" .. slotNo .. ")")
    self._ui.enchantInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PadEventY_Inventory_All_ForConsole_MoveItemFromEnchantInventory(" .. slotNo .. ")")
    if _ContentsGroup_RenewUI_Tooltip == true then
      self._ui.enchantInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PadEventUpX_Inventory_All_ForConsole_CategoryEnchantInvenToggleTooltip(" .. slotNo .. ")")
    else
      Panel_Tooltip_Item_SetPosition(slotNo, self._ui.enchantInvenCategorySlotList[slotNo], "EnchantCategoryInventory")
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:enchantInvenCategoryShow(isShow)
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  self._ui.stc_enchantInvenSlotArea:SetShow(not isShow)
  self._ui.stc_enchantInvenCategoryBG:SetShow(isShow)
  if isShow == true then
    self:updateEnchantInvenCategorySlots()
  end
end
function PaGlobal_Inventory_All_ForConsole:updateEnchantInvenCategorySlots()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  self:enchantInvenClearCategoryAndSlot()
  local noItem = true
  local sortedList = {}
  local sortType = PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ConsoleEnchantInventory)
  local currentWhereType = CppEnums.ItemWhereType.eEnchantInventory
  for slotNo = 0, __eTInventorySlotNoMax - __eTInventorySlotNoUseStart - 1 do
    local realSlotNo = selfPlayer:getRealInventorySlotNoNew(sortType, slotNo)
    local itemWrapper = getInventoryItemByType(currentWhereType, realSlotNo)
    if itemWrapper ~= nil then
      noItem = false
      local categoryType = itemWrapper:getInventCategoryType()
      local showIndex = ToClient_getCategoryShowIndexByType(categoryType)
      if sortedList[showIndex] == nil then
        sortedList[showIndex] = {}
      end
      sortedList[showIndex][#sortedList[showIndex] + 1] = realSlotNo
      sortedList[showIndex]._categoryType = categoryType
    end
  end
  if noItem == true then
    self._ui.txt_enchantInvenNoItem:SetShow(true)
    self._ui.frame_enchantInvenCategory:SetShow(false)
    return
  else
    self._ui.txt_enchantInvenNoItem:SetShow(false)
    self._ui.frame_enchantInvenCategory:SetShow(true)
  end
  local categoryStartPosY = 0
  for showIndex = 0, __eInvenCategoryType_Count - 1 do
    if sortedList[showIndex] ~= nil then
      local categoryType = sortedList[showIndex]._categoryType
      self._ui.enchantInvenCategoryTitleList[categoryType].content:SetShow(true)
      self._ui.enchantInvenCategoryTitleList[categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
      categoryStartPosY = self._ui.enchantInvenCategoryTitleList[categoryType].content:GetPosY() + self._ui.enchantInvenCategoryTitleList[categoryType].content:GetSizeY()
      local groupItemSlotIndex = 0
      local slotPosStartX = 10
      local slotPosStartY = 5 + categoryStartPosY
      local slotSizeX = self._defaultXGap - 3
      local slotSizeY = self._defaultYGap - 3
      local columnMax = self._invenSlotColumnMax
      for _, realSlotNo in ipairs(sortedList[showIndex]) do
        local itemWrapper = getInventoryItemByType(currentWhereType, realSlotNo)
        if itemWrapper ~= nil then
          local slot = self._ui.enchantInvenCategorySlotList[realSlotNo]
          local slotBg = self._ui.enchantInvenCategorySlotBgList[realSlotNo]
          slot:setItem(itemWrapper, slotNo)
          slot.icon:EraseAllEffect()
          slot.cooltime:SetShow(false)
          slot.cooltimeText:SetShow(false)
          slotBg:SetPosX(slotPosStartX + groupItemSlotIndex % columnMax * slotSizeX)
          slotBg:SetPosY(slotPosStartY + math.floor(groupItemSlotIndex / columnMax) * slotSizeY)
          slotBg:SetShow(true)
          groupItemSlotIndex = groupItemSlotIndex + 1
        end
      end
      categoryStartPosY = slotPosStartY + (math.floor((groupItemSlotIndex - 1) / columnMax) + 1) * slotSizeY
    end
  end
  self._ui.frame_enchantInvenCategoryContent:SetSize(self._ui.frame_enchantInvenCategoryContent:GetSizeX(), categoryStartPosY + 10)
  self._ui.frame_enchantInvenCategory:UpdateContentScroll()
  self._ui.frame_enchantInvenCategory:UpdateContentPos()
  if categoryStartPosY > self._ui.frame_enchantInvenCategory:GetSizeY() then
    self._ui.frame_enchantInvenCategoryVerticalScroll:SetShow(true)
    self._ui.frame_enchantInvenCategoryVerticalScroll:SetInterval(self._ui.frame_enchantInvenCategoryContent:GetSizeY() * 0.01 * 1.1)
  end
end
function PaGlobal_Inventory_All_ForConsole:enchantInvenClearCategoryAndSlot()
  self._ui.txt_enchantInvenNoItem:SetShow(false)
  self._ui.frame_enchantInvenCategoryVerticalScroll:SetShow(false)
  for ii = 0, __eInvenCategoryType_Count - 1 do
    self._ui.enchantInvenCategoryTitleList[ii].content:SetShow(false)
  end
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.enchantInvenCategorySlotBgList[slotNo]:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:isEnchantInvenCategoryShow()
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  return self._ui.btn_enchantInvenCategoryView:IsCheck()
end
function InputMOnOut_Inventory_All_ForConsole_CategoryEnchantInvenShowTooltip(slotNo, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if isShow == false then
    self._enchantInventoryTooltipSlotNo = nil
  else
    self._enchantInventoryTooltipSlotNo = slotNo
  end
  if self._enchantInventoryTooltipSlotNo == nil then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "EnchantCategoryInventory", false, false)
      TooltipSimple_Hide()
    else
      PaGlobalFunc_FloatingTooltip_Close()
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "EnchantCategoryInventory", true, false, _panel:GetPosX(), 20)
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, PaGlobal_Inventory_All_ForConsole._enchantInventoryTooltipSlotNo)
    if itemWrapper ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNoteNoLock, self._ui.stc_enchantInvenSlotBG[index], "Inventory")
    end
  end
end
function PadEventUpA_Inventory_All_ForConsole_EnchantInvenSlotUseItem(slotNo)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil or itemWrapper:empty() == true then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  local itemStatic = itemEnchantWrapper:get()
  if itemStatic ~= nil then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  if selfPlayerWrapper:get():doRideMyVehicle() == true and itemStatic:isUseToVehicle() == true then
    inventoryUseItem(itemWhereType, slotNo, itemEnchantWrapper:getEquipSlotNo(), false)
    return
  end
  if _ContentsGroup_HopeGauge == true and itemStatic:isItemCollectionScroll() == true then
    Panel_Tooltip_Item_hideTooltip()
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_TooltipInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
    PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(itemWhereType, slotNo, itemEnchantWrapper:getGradeType())
  elseif PaGlobal_Inventory_All_ForConsole._rClickFunc ~= nil then
    PaGlobal_Inventory_All_ForConsole._rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), __eItemWhereTypeEnchantInventory)
  elseif itemEnchantWrapper:isPopupItem() == true then
    PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, itemWhereType, slotNo, nil)
  elseif itemWrapper:getStaticStatus():getConnectUi() ~= eConnectUiType.eConnectUi_Undefined then
    ConnectUI(itemWrapper:getStaticStatus():getConnectUi(), itemWrapper:get():getKey():getItemKey())
  elseif itemStatic:isUseToVehicle() == false then
    Inventory_UseItemTargetSelf(itemWhereType, slotNo, nil)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
  end
end
function PadEventUpX_Inventory_All_ForConsole_CategoryEnchantInvenToggleTooltip(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, slotNo), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function PadEventY_Inventory_All_ForConsole_MoveItemFromEnchantInventory(slotNo)
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_EnchantInventory_PopItemFromEnchantInventory(1, slotNo)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_EnchantInventory_PopItemFromEnchantInventory)
  end
end
function PaGlobal_Inventory_All_ForConsole_EnchantInvenCategoryShow(isShow)
  PaGlobal_Inventory_All_ForConsole:enchantInvenCategoryShow(isShow)
end
function PaGlobal_Inventory_All_ForConsole_IsEnchantInvenCategoryShow()
  return PaGlobal_Inventory_All_ForConsole:isEnchantInvenCategoryShow()
end
function PaGlobal_Inventory_All_ForConsole_categoryEnchantInvenPerFrameUpdate(deltaTime)
  local self = PaGlobal_Inventory_All_ForConsole
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local slot = self._ui.enchantInvenCategorySlotList[slotNo]
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    remainTime = getItemCooltime(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
    if remainTime > 0 then
      itemReuseTime = getItemReuseCycle(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
      realRemainTime = remainTime * itemReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if itemReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
    elseif slot.cooltime:GetShow() == true then
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
      local skillSlotItemPosX = slot.cooltime:GetParentPosX()
      local skillSlotItemPosY = slot.cooltime:GetParentPosY()
      if self._isShowCoolTimeEffect == true then
        audioPostEvent_SystemUi(2, 1)
        Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
        Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
        Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
        Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
        Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
      end
    end
  end
end
