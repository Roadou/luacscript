local _panel = Panel_Window_Inventory
function PaGlobal_Inventory_All_ForConsole:initFamilyInventory_category()
  self._ui.btn_familyInvenSlotView = UI.getChildControl(self._ui.stc_familyInvenSortArea, "RadioButton_Slot")
  self._ui.btn_familyInvenCategoryView = UI.getChildControl(self._ui.stc_familyInvenSortArea, "RadioButton_List")
  self._ui.btn_familyInvenSlotView:SetShow(_ContentsGroup_InvenCategory)
  self._ui.btn_familyInvenCategoryView:SetShow(_ContentsGroup_InvenCategory)
  local ui_familyInvenGroup = UI.getChildControl(Panel_Window_Inventory, "Static_FamilyInvenGroup")
  self._ui.stc_familyInvenCategoryBG = UI.getChildControl(ui_familyInvenGroup, "Static_CategorySlotBG")
  self._ui.frame_familyInvenCategory = UI.getChildControl(self._ui.stc_familyInvenCategoryBG, "Frame_Category")
  self._ui.frame_familyInvenCategoryContent = UI.getChildControl(self._ui.frame_familyInvenCategory, "Frame_1_Content")
  self._ui.frame_familyInvenCategoryVerticalScroll = UI.getChildControl(self._ui.frame_familyInvenCategory, "Frame_1_VerticalScroll")
  self._ui.stc_familyInvenCategoryGroup = UI.getChildControl(self._ui.frame_familyInvenCategoryContent, "Static_Group")
  self._ui.txt_familyInvenCategoryTitle = UI.getChildControl(self._ui.stc_familyInvenCategoryGroup, "StaticText_GroupTitle")
  self._ui.txt_familyInvenCategoryWeight = UI.getChildControl(self._ui.stc_familyInvenCategoryGroup, "Static_Weight")
  self._ui.stc_familyInvenDeco = UI.getChildControl(self._ui.stc_familyInvenCategoryGroup, "Static_DecoLine")
  self._ui.txt_familyInvenNoItem = UI.getChildControl(self._ui.stc_familyInvenCategoryBG, "StaticText_No_Itemlog")
  self._ui.stc_familyInvenTempSlot = UI.getChildControl(self._ui.stc_familyInvenCategoryBG, "Static_Slot_Temp")
  self._ui.stc_familyInvenTempBgSlot = UI.getChildControl(self._ui.stc_familyInvenCategoryBG, "Static_SlotBG_Temp")
  self._ui.familyInvenCategoryTitleList = {}
  self._ui.familyInvenCategorySlotList = {}
  self._ui.familyInvenCategorySlotBgList = {}
  self:familyInvenCategoryTitleInit()
  self:familyInvenCategorySlotInit()
  self:familyInvenCategorySlotRegisterEvent()
  self:familyInvenClearCategoryAndSlot()
end
function PaGlobal_Inventory_All_ForConsole:familyInvenCategoryTitleInit()
  for categoryType = 0, __eInvenCategoryType_Count - 1 do
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_familyInvenCategoryContent, "Static_Group", self._ui.frame_familyInvenCategoryContent, "CategoryGroup_" .. categoryType)
    if tempContent ~= nil then
      local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_familyInvenCategoryGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. categoryType)
      local tempWeight = UI.createAndCopyBasePropertyControl(self._ui.stc_familyInvenCategoryGroup, "Static_Weight", tempContent, "StaticText_GroupWeight_" .. categoryType)
      local tempWeightTxt = UI.createAndCopyBasePropertyControl(self._ui.txt_familyInvenCategoryWeight, "StaticText_Weight", tempContent, "StaticText_GroupWeightTxt_" .. categoryType)
      local tempDeco = UI.createAndCopyBasePropertyControl(self._ui.stc_familyInvenCategoryGroup, "Static_DecoLine", tempContent, "StaticText_GroupDeco_" .. categoryType)
      self._ui.familyInvenCategoryTitleList[categoryType] = {}
      self._ui.familyInvenCategoryTitleList[categoryType].content = tempContent
      self._ui.familyInvenCategoryTitleList[categoryType].titleName = tempTitleName
      self._ui.familyInvenCategoryTitleList[categoryType].weight = tempWeight
      self._ui.familyInvenCategoryTitleList[categoryType].weightTxt = tempWeightTxt
      self._ui.familyInvenCategoryTitleList[categoryType].deco = tempDeco
      self._ui.familyInvenCategoryTitleList[categoryType].titleName:SetText(ToClient_getCategoryNameByType(categoryType))
      self._ui.familyInvenCategoryTitleList[categoryType].weightTxt:SetText(0)
      self._ui.familyInvenCategoryTitleList[categoryType].content:SetShow(true)
      self._ui.familyInvenCategoryTitleList[categoryType].titleName:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_02_Inventory_Category_" .. tostring(categoryType))
      self._ui.familyInvenCategoryTitleList[categoryType].titleName:setRenderTexture(self._ui.familyInvenCategoryTitleList[categoryType].titleName:getBaseTexture())
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:familyInvenCategorySlotInit()
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
    self._ui.familyInvenCategorySlotBgList[slotNo] = UI.cloneControl(slotTemplate, self._ui.frame_familyInvenCategoryContent, "InventoryInfo_CategoryInvenSlotBG_" .. slotNo)
    self._ui.familyInvenCategorySlotBgList[slotNo]:SetEnableDragAndDrop(false)
    self._ui.familyInvenCategorySlotBgList[slotNo]:SetShow(true)
    self._ui.familyInvenCategorySlotList[slotNo] = {}
    SlotItem.new(self._ui.familyInvenCategorySlotList[slotNo], "InvenSlot_" .. slotNo, slotNo, self._ui.familyInvenCategorySlotBgList[slotNo], slotConfig)
    self._ui.familyInvenCategorySlotList[slotNo]:createChild()
    self._ui.familyInvenCategorySlotList[slotNo].icon:SetIgnore(true)
    self._ui.familyInvenCategorySlotList[slotNo].icon:SetPosXY(1, 1)
    self._ui.familyInvenCategorySlotList[slotNo].icon:SetSize(42, 42)
    self._ui.familyInvenCategorySlotList[slotNo].border:SetSize(44, 44)
    self._ui.familyInvenCategorySlotList[slotNo].count:ComputePos()
    self._ui.familyInvenCategorySlotList[slotNo].lock = UI.createAndCopyBasePropertyControl(_panel, "Static_LockedSlot", self._ui.familyInvenCategorySlotBgList[slotNo], "Static_LockedCategorySlot_" .. slotNo)
    self._ui.familyInvenCategorySlotList[slotNo].lock:SetShow(false)
    local multiSelectControl = UI.getChildControl(self._ui.familyInvenCategorySlotBgList[slotNo], "Static_MultipleSelect")
    multiSelectControl:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:familyInvenCategorySlotRegisterEvent()
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.familyInvenCategorySlotBgList[slotNo]:addInputEvent("Mouse_On", "InputMOnOut_Inventory_All_ForConsole_categoryFamilyInvenShowTooltip(" .. slotNo .. ", true)")
    self._ui.familyInvenCategorySlotBgList[slotNo]:addInputEvent("Mouse_Out", "InputMOnOut_Inventory_All_ForConsole_categoryFamilyInvenShowTooltip(" .. slotNo .. ", false)")
    self._ui.familyInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PadEventRSClick_Inventory_All_ForConsole_OpenCraftNote(" .. slotNo .. ", true)")
    self._ui.familyInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PadEventUpA_Inventory_All_ForConsole_FamilyInvenSlotUseItem(" .. slotNo .. ")")
    self._ui.familyInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PadEventY_Inventory_All_ForConsole_MoveItemFromFamilyInventory(" .. slotNo .. ")")
    if _ContentsGroup_RenewUI_Tooltip == true then
      self._ui.familyInvenCategorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PadEventUpX_Inventory_All_ForConsole_categoryFamilyInvenToggleTooltip(" .. slotNo .. ")")
    else
      Panel_Tooltip_Item_SetPosition(slotNo, self._ui.familyInvenCategorySlotList[slotNo], "FamilyCategoryInventory")
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:familyInvenCategoryShow(isShow)
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  self._ui.stc_FamilyinvenSlotArea:SetShow(not isShow)
  self._ui.stc_familyInvenCategoryBG:SetShow(isShow)
  if isShow == true then
    self:updateFamilyInvenCategorySlots()
  end
end
function PaGlobal_Inventory_All_ForConsole:updateFamilyInvenCategorySlots()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  self:familyInvenClearCategoryAndSlot()
  local noItem = true
  local sortedList = {}
  local sortType = PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ColsoleFamilyInventory)
  local currentWhereType = CppEnums.ItemWhereType.eFamilyInventory
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
    self._ui.txt_familyInvenNoItem:SetShow(true)
    self._ui.frame_familyInvenCategory:SetShow(false)
    return
  else
    self._ui.txt_familyInvenNoItem:SetShow(false)
    self._ui.frame_familyInvenCategory:SetShow(true)
  end
  local categoryStartPosY = 0
  for showIndex = 0, __eInvenCategoryType_Count - 1 do
    if sortedList[showIndex] ~= nil then
      local categoryType = sortedList[showIndex]._categoryType
      self._ui.familyInvenCategoryTitleList[categoryType].content:SetShow(true)
      self._ui.familyInvenCategoryTitleList[categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
      categoryStartPosY = self._ui.familyInvenCategoryTitleList[categoryType].content:GetPosY() + self._ui.familyInvenCategoryTitleList[categoryType].content:GetSizeY()
      local groupItemSlotIndex = 0
      local categoryWeight = 0
      local slotPosStartX = 10
      local slotPosStartY = 5 + categoryStartPosY
      local slotSizeX = self._defaultXGap - 3
      local slotSizeY = self._defaultYGap - 3
      local columnMax = self._invenSlotColumnMax
      for _, realSlotNo in ipairs(sortedList[showIndex]) do
        local itemWrapper = getInventoryItemByType(currentWhereType, realSlotNo)
        if itemWrapper ~= nil then
          local slot = self._ui.familyInvenCategorySlotList[realSlotNo]
          local slotBg = self._ui.familyInvenCategorySlotBgList[realSlotNo]
          slot:setItem(itemWrapper, slotNo)
          slot.icon:EraseAllEffect()
          slot.cooltime:SetShow(false)
          slot.cooltimeText:SetShow(false)
          slotBg:SetPosX(slotPosStartX + groupItemSlotIndex % columnMax * slotSizeX)
          slotBg:SetPosY(slotPosStartY + math.floor(groupItemSlotIndex / columnMax) * slotSizeY)
          slotBg:SetShow(true)
          groupItemSlotIndex = groupItemSlotIndex + 1
          local itemSSW = itemWrapper:getStaticStatus()
          local itemWeight = Int64toInt32(itemSSW:get()._weight) * Int64toInt32(itemWrapper:get():getCount_s64())
          if itemSSW:get():getContentsEventType() == CppEnums.ContentsEventType.ContentsType_InventoryBag then
            local bagSize = itemSSW:getContentsEventParam2()
            for index = 0, bagSize - 1 do
              local bagItemWrapper = getInventoryBagItemByType(currentWhereType, realSlotNo, index)
              if bagItemWrapper ~= nil then
                local bagItemSSW = bagItemWrapper:getStaticStatus()
                itemWeight = itemWeight + Int64toInt32(bagItemSSW:get()._weight) * Int64toInt32(bagItemWrapper:get():getCount_s64())
              end
            end
          end
          categoryWeight = categoryWeight + itemWeight
          local weight = categoryWeight
          weight = weight / 10000
          weight = math.floor(weight * 100) / 100
          self._ui.familyInvenCategoryTitleList[categoryType].weightTxt:SetText(tostring(weight) .. " LT")
          self._ui.familyInvenCategoryTitleList[categoryType].weight:SetSpanSize(self._ui.familyInvenCategoryTitleList[categoryType].weightTxt:GetTextSizeX(), -2)
          self._ui.familyInvenCategoryTitleList[categoryType].weightTxt:SetSpanSize(self._ui.familyInvenCategoryTitleList[categoryType].weightTxt:GetTextSizeX() + 10, -2)
        end
      end
      categoryStartPosY = slotPosStartY + (math.floor((groupItemSlotIndex - 1) / columnMax) + 1) * slotSizeY
    end
  end
  self._ui.frame_familyInvenCategoryContent:SetSize(self._ui.frame_familyInvenCategoryContent:GetSizeX(), categoryStartPosY + 10)
  self._ui.frame_familyInvenCategory:UpdateContentScroll()
  self._ui.frame_familyInvenCategory:UpdateContentPos()
  if categoryStartPosY > self._ui.frame_familyInvenCategory:GetSizeY() then
    self._ui.frame_familyInvenCategoryVerticalScroll:SetShow(true)
    self._ui.frame_familyInvenCategoryVerticalScroll:SetInterval(self._ui.frame_familyInvenCategoryContent:GetSizeY() * 0.01 * 1.1)
  end
end
function PaGlobal_Inventory_All_ForConsole:familyInvenClearCategoryAndSlot()
  self._ui.txt_familyInvenNoItem:SetShow(false)
  self._ui.frame_familyInvenCategoryVerticalScroll:SetShow(false)
  for ii = 0, __eInvenCategoryType_Count - 1 do
    self._ui.familyInvenCategoryTitleList[ii].content:SetShow(false)
  end
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.familyInvenCategorySlotBgList[slotNo]:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:isFamilyInvenCategoryShow()
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  return self._ui.btn_familyInvenCategoryView:IsCheck()
end
function InputMOnOut_Inventory_All_ForConsole_categoryFamilyInvenShowTooltip(slotNo, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if isShow == false then
    self._familyInventoryTooltipSlotNo = nil
  else
    self._familyInventoryTooltipSlotNo = slotNo
  end
  if self._familyInventoryTooltipSlotNo == nil then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "FamilyCategoryInventory", false, false)
      TooltipSimple_Hide()
    else
      PaGlobalFunc_FloatingTooltip_Close()
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "FamilyCategoryInventory", true, false, _panel:GetPosX(), 20)
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, PaGlobal_Inventory_All_ForConsole._familyInventoryTooltipSlotNo)
    if itemWrapper ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNoteNoLock, self._ui.stc_familyInvenSlotBG[index], "Inventory")
    end
  end
end
function PadEventUpA_Inventory_All_ForConsole_FamilyInvenSlotUseItem(slotNo)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
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
function PadEventUpX_Inventory_All_ForConsole_categoryFamilyInvenToggleTooltip(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, slotNo), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function PadEventY_Inventory_All_ForConsole_MoveItemFromFamilyInventory(slotNo)
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(1, slotNo)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory)
  end
end
function PaGlobal_Inventory_All_ForConsole_FamilyInvenCategoryShow(isShow)
  PaGlobal_Inventory_All_ForConsole:familyInvenCategoryShow(isShow)
end
function PaGlobal_Inventory_All_ForConsole_IsFamilyInvenCategoryShow()
  return PaGlobal_Inventory_All_ForConsole:isFamilyInvenCategoryShow()
end
function PaGlobal_Inventory_All_ForConsole_categoryFamilyInvenPerFrameUpdate(deltaTime)
  local self = PaGlobal_Inventory_All_ForConsole
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local slot = self._ui.familyInvenCategorySlotList[slotNo]
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    remainTime = getItemCooltime(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
    if remainTime > 0 then
      itemReuseTime = getItemReuseCycle(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
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
