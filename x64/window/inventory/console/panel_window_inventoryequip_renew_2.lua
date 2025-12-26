local _panel = Panel_Window_Inventory
local UPPER_TAB_TYPE = {
  UNDEFINED = 0,
  EQUIPMENT_TAB = 1,
  COSTUME_TAB = 2,
  SERVANT_TAB = 3
}
function PaGlobal_Inventory_All_ForConsole:categoryControlInit()
  self._ui.btn_slotView = UI.getChildControl(self._ui.stc_invenSortArea, "RadioButton_Slot")
  self._ui.btn_categoryView = UI.getChildControl(self._ui.stc_invenSortArea, "RadioButton_List")
  self._ui.btn_slotView:SetShow(_ContentsGroup_InvenCategory)
  self._ui.btn_categoryView:SetShow(_ContentsGroup_InvenCategory)
  local ui_invenGroup = UI.getChildControl(Panel_Window_Inventory, "Static_InvenGroup")
  self._ui.stc_categoryBG = UI.getChildControl(ui_invenGroup, "Static_CategorySlotBG")
  self._ui.stc_categoryBG:SetShow(false)
  self._ui.frame_category = UI.getChildControl(self._ui.stc_categoryBG, "Frame_Category")
  self._ui.frame_categoryContent = UI.getChildControl(self._ui.frame_category, "Frame_1_Content")
  self._ui.frame_categoryVerticalScroll = UI.getChildControl(self._ui.frame_category, "Frame_1_VerticalScroll")
  self._ui.stc_categoryGroup = UI.getChildControl(self._ui.frame_categoryContent, "Static_Group")
  self._ui.txt_categoryTitle = UI.getChildControl(self._ui.stc_categoryGroup, "StaticText_GroupTitle")
  self._ui.txt_categoryWeight = UI.getChildControl(self._ui.stc_categoryGroup, "Static_Weight")
  self._ui.stc_deco = UI.getChildControl(self._ui.stc_categoryGroup, "Static_DecoLine")
  self._ui.txt_noItem = UI.getChildControl(self._ui.stc_categoryBG, "StaticText_No_Itemlog")
  self._ui.stc_tempSlot = UI.getChildControl(self._ui.stc_categoryBG, "Static_Slot_Temp")
  self._ui.stc_tempBgSlot = UI.getChildControl(self._ui.stc_categoryBG, "Static_SlotBG_Temp")
  self._ui.categoryTitleList = {}
  self._ui.categorySlotList = {}
  self._ui.categorySlotBgList = {}
  self._categorySlotCooltimeList = {}
  self._updateSnappingSlot = false
  self:categoryTitleInit()
  self:categorySlotInit()
  self:categorySlotRegisterEvent()
  PaGlobal_Inventory_All_ForConsole:clearCategoryAndSlot()
end
function PaGlobal_Inventory_All_ForConsole:categoryTitleInit()
  for categoryType = 0, __eInvenCategoryType_Count - 1 do
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_categoryContent, "Static_Group", self._ui.frame_categoryContent, "CategoryGroup_" .. categoryType)
    if tempContent ~= nil then
      local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. categoryType)
      local tempWeight = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "Static_Weight", tempContent, "StaticText_GroupWeight_" .. categoryType)
      local tempWeightTxt = UI.createAndCopyBasePropertyControl(self._ui.txt_categoryWeight, "StaticText_Weight", tempContent, "StaticText_GroupWeightTxt_" .. categoryType)
      local tempDeco = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "Static_DecoLine", tempContent, "StaticText_GroupDeco_" .. categoryType)
      self._ui.categoryTitleList[categoryType] = {}
      self._ui.categoryTitleList[categoryType].content = tempContent
      self._ui.categoryTitleList[categoryType].titleName = tempTitleName
      self._ui.categoryTitleList[categoryType].weight = tempWeight
      self._ui.categoryTitleList[categoryType].weightTxt = tempWeightTxt
      self._ui.categoryTitleList[categoryType].deco = tempDeco
      self._ui.categoryTitleList[categoryType].titleName:SetText(ToClient_getCategoryNameByType(categoryType))
      self._ui.categoryTitleList[categoryType].weightTxt:SetText(0)
      self._ui.categoryTitleList[categoryType].content:SetShow(false)
      self._ui.categoryTitleList[categoryType].titleName:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_02_Inventory_Category_" .. tostring(categoryType))
      self._ui.categoryTitleList[categoryType].titleName:setRenderTexture(self._ui.categoryTitleList[categoryType].titleName:getBaseTexture())
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:categorySlotInit()
  local slotTemplate = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotTemplate")
  for slotNo = 0, __eTEnchantInventorySlotNoMax - 1 do
    self._ui.categorySlotBgList[slotNo] = UI.cloneControl(slotTemplate, self._ui.frame_categoryContent, "InventoryInfo_CategoryInvenSlotBG_" .. slotNo)
    self._ui.categorySlotBgList[slotNo]:SetEnableDragAndDrop(false)
    self._ui.categorySlotList[slotNo] = {}
    SlotItem.new(self._ui.categorySlotList[slotNo], "InvenSlot_" .. slotNo, slotNo, self._ui.categorySlotBgList[slotNo], self._configForInven)
    self._ui.categorySlotList[slotNo]:createChild()
    self._ui.categorySlotList[slotNo].icon:SetIgnore(true)
    self._ui.categorySlotList[slotNo].icon:SetPosXY(1, 1)
    self._ui.categorySlotList[slotNo].icon:SetSize(42, 42)
    self._ui.categorySlotList[slotNo].border:SetSize(44, 44)
    self._ui.categorySlotList[slotNo].count:ComputePos()
    self._ui.categorySlotList[slotNo].lock = UI.createAndCopyBasePropertyControl(_panel, "Static_LockedSlot", self._ui.categorySlotBgList[slotNo], "Static_LockedCategorySlot_" .. slotNo)
    self._ui.categorySlotList[slotNo].lock:SetShow(false)
    local multiSelectControl = UI.getChildControl(self._ui.categorySlotBgList[slotNo], "Static_MultipleSelect")
    multiSelectControl:SetShow(false)
  end
  self._ui.dummySlot = UI.cloneControl(slotTemplate, self._ui.frame_category, "Dummy")
  self._ui.dummySlot:SetEnableDragAndDrop(false)
  self._ui.dummySlot:SetShow(false)
end
function PaGlobal_Inventory_All_ForConsole:categorySlotRegisterEvent()
  for slotNo = 0, __eTEnchantInventorySlotNoMax - 1 do
    self._ui.categorySlotBgList[slotNo]:addInputEvent("Mouse_Out", "InputMOut_Inventory_All_ForConsole_categoryInvenHideTooltip(" .. slotNo .. ")")
    self._ui.categorySlotBgList[slotNo]:addInputEvent("Mouse_On", "InputMOn_Inventory_All_ForConsole_categoryInvenShowTooltip(" .. slotNo .. ")")
    self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PadEventRSClick_Inventory_All_ForConsole_OpenCraftNote(" .. slotNo .. ", false)")
    self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PadEventUpA_Inventory_All_ForConsole_InvenSlot(" .. slotNo .. ")")
    self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PadEventLTPressX_Inventory_All_ForConsole_categoryInvenItemLock(" .. slotNo .. ")")
    self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PadEventLTPressY_Inventory_All_ForConsole_categoryInvenItemDelete(" .. slotNo .. ")")
    if _ContentsGroup_RenewUI_Tooltip == true then
      self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PadEventUpX_Inventory_All_ForConsole_categoryInvenToggleTooltip(" .. slotNo .. ")")
    end
    if _ContentsGroup_FamilyInventory == true then
      self._ui.categorySlotBgList[slotNo]:registerPadEvent(__eConsoleUIPadEvent_Y, "InputMRUp_InventoryInfo_MoveItemToFamilyOrEnchantInventory(" .. slotNo .. ")")
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:updateCategorySlots()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  PaGlobal_Inventory_All_ForConsole:clearCategoryAndSlot()
  local playerLevel = selfPlayer:getLevel()
  local classType = selfPlayerWrapper:getClassType()
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local noItem = true
  local sortedList = {}
  local sortType = PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ColsoleInventory)
  local currentOpenSlotCount = ToClient_getInventoryOpenedSlotCountBySortType(sortType)
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
    ToClient_padSnapIgnoreMoveToThisControl(self._ui.stc_invenGroup, true)
    self._ui.txt_noItem:SetShow(true)
    self._ui.frame_category:SetShow(false)
    return
  else
    ToClient_padSnapIgnoreMoveToThisControl(self._ui.stc_invenGroup, false)
    self._ui.txt_noItem:SetShow(false)
    self._ui.frame_category:SetShow(true)
  end
  local categoryStartPosY = 0
  for showIndex = 0, __eInvenCategoryType_Count - 1 do
    if sortedList[showIndex] ~= nil then
      local categoryType = sortedList[showIndex]._categoryType
      self._ui.categoryTitleList[categoryType].content:SetShow(true)
      self._ui.categoryTitleList[categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
      categoryStartPosY = self._ui.categoryTitleList[categoryType].content:GetPosY() + self._ui.categoryTitleList[categoryType].content:GetSizeY()
      local showCategoryWeight = sortType ~= __eInventorySortWhereType_CashInventoryForCharacter and sortType ~= __eInventorySortWhereType_EnchantInventory
      self._ui.categoryTitleList[categoryType].weight:SetShow(showCategoryWeight)
      self._ui.categoryTitleList[categoryType].weightTxt:SetShow(showCategoryWeight)
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
          local slotBg = self._ui.categorySlotBgList[realSlotNo]
          local slot = self._ui.categorySlotList[realSlotNo]
          slot:clearItem()
          slot.icon:EraseAllEffect()
          slotBg:SetPosX(slotPosStartX + groupItemSlotIndex % columnMax * slotSizeX)
          slotBg:SetPosY(slotPosStartY + math.floor(groupItemSlotIndex / columnMax) * slotSizeY)
          slotBg:SetShow(true)
          if self._updateSnappingSlot == true then
            self._updateSnappingSlot = false
            self._ui.frame_categoryVerticalScroll:SetControlTop()
            self._ui.dummySlot:SetPosX(slotPosStartX + groupItemSlotIndex % columnMax * slotSizeX)
            self._ui.dummySlot:SetPosY(slotPosStartY + math.floor(groupItemSlotIndex / columnMax) * slotSizeY)
            ToClient_padSnapChangeToTarget(self._ui.dummySlot)
          end
          slot._isLockedItem = false
          groupItemSlotIndex = groupItemSlotIndex + 1
          local itemSSW = itemWrapper:getStaticStatus()
          local itemKey = itemWrapper:get():getKey():getItemKey()
          local needLoadBackEnd = PaGlobal_Inventory_All_ForConsole:saveBackendInfo(itemSSW, itemKey, self._lowerTabData[self._currentLowerTab].whereType, realSlotNo, slot)
          if needLoadBackEnd == true then
            slot:setItemWhileLoad(itemSSW)
          else
            slot:setItem(itemWrapper, realSlotNo)
            local isFiltered = false
            if self._filterFunc ~= nil and "function" == type(self._filterFunc) then
              isFiltered = self._filterFunc(realSlotNo, itemWrapper, currentWhereType)
            end
            local isFilteredSequenceItem = ToClient_SequenceItemConditionCheck(currentWhereType, realSlotNo)
            if isFilteredSequenceItem == true then
              isFiltered = true
            end
            slot.icon:SetEnable(not isFiltered)
            slot.icon:SetMonoTone(isFiltered)
            if isFiltered == true then
              slot.icon:SetAlpha(0.5)
              slot.icon:EraseAllEffect()
            elseif self._filterFunc ~= nil and "function" == type(self._filterFunc) then
              slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            end
            local isUseSequenceOnlyItem = itemWrapper:getStaticStatus():isSequenceOnlyItem()
            local allowClickOrDragSequenceItem = self.filterFunc == PaGlobal_Inventory_All_CheckDeletableItem or self.filterFunc == nil
            if isUseSequenceOnlyItem == true and isFilteredSequenceItem == true and allowClickOrDragSequenceItem == true then
              slot.icon:SetEnable(true)
              slot.icon:SetIgnore(false)
            end
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
            self._ui.categoryTitleList[categoryType].weightTxt:SetText(tostring(weight) .. " LT")
            self._ui.categoryTitleList[categoryType].weight:SetSpanSize(self._ui.categoryTitleList[categoryType].weightTxt:GetTextSizeX(), -2)
            self._ui.categoryTitleList[categoryType].weightTxt:SetSpanSize(self._ui.categoryTitleList[categoryType].weightTxt:GetTextSizeX() + 10, -2)
            PaGlobal_TutorialManager:handleUpdateInventorySlotData(slot, itemKey, currentWhereType)
            if realSlotNo < self._invenSlotCount and true == self._newItemAtSlot[realSlotNo] then
              local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
              self.effectScene.newItem[realSlotNo] = newItemEffectSceneId
            end
            if true == itemSSW:isEquipable() then
              local offencePoint = 0
              local defencePoint = 0
              local equipOffencePoint = 0
              local equipDefencePoint = 0
              local matchEquip = false
              local isAccessory = false
              local isUsableServant = itemSSW:isUsableServant()
              offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = self:compareSpec(currentWhereType, realSlotNo, isAccessory)
              local currentEndurance = itemWrapper:get():getEndurance()
              if not isUsableServant and not Panel_Window_Exchange:GetShow() then
                if nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
                  slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
                  local equipPos = itemSSW:getEquipSlotNo()
                  if false == _ContentsGroup_RemasterUI_Main_Alert then
                    Panel_NewEquip_Update(equipPos)
                  end
                  if false == isAccessory then
                    PaGlobal_TutorialManager:handleNewEquipInInventory(slot)
                  end
                end
                if true == itemSSW:get():isArtifact() and currentEndurance > 0 and true == isEmptyArtifact then
                  slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
                end
              end
              if (itemSSW:get():isWeapon() or itemSSW:get():isSubWeapon() or itemSSW:get():isAwakenWeapon()) and false == itemSSW:get()._usableClassType:isOn(classType) then
                slot.icon:SetColor(Defines.Color.C_FFD20000)
              end
            elseif true == itemSSW:get():isPushableToSocket() then
              Panel_Inventory_isSocketItem = true
            elseif itemWrapper:isSoulCollector() then
              local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
              local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
              local itemIconPath = itemSSW:getIconPath()
              if isCurrentSoulCount == 0 then
                slot.icon:ChangeTextureInfoNameAsync("icon/" .. itemIconPath)
              elseif isCurrentSoulCount > 0 and isCurrentSoulCount < isMaxSoulCount then
                slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
              else
                slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
              end
              local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
              slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
              slot.icon:setRenderTexture(slot.icon:getBaseTexture())
            else
              if isFiltered == false then
                self:addEffectBlackStone_ForCategoryView(slot, realSlotNo)
              end
              self:autoSetPotion(playerLevel, itemKey, currentWhereType, realSlotNo)
              if false == _ContentsGroup_RenewUI_Tutorial and true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() and not FGlobal_FirstSummonItemUse() and (42000 == itemKey or 42001 == itemKey or 41607 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey) then
                slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
              end
              if itemKey == 42405 and questList_hasProgressQuest(4015, 6) then
                slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
              end
            end
            local itemBindType = itemSSW:get()._vestedType:getItemKey()
            if Panel_Window_Exchange:GetShow() and itemBindType > 0 then
              slot.icon:SetColor(Defines.Color.C_FFD20000)
            end
          end
          if realSlotNo >= currentOpenSlotCount then
            slot._isLockedItem = true
            slot.icon:SetAlpha(0.5)
            slot.icon:SetMonoTone(true)
            slot.icon:EraseAllEffect()
            slot.lock:SetShow(true)
          else
            slot._isLockedItem = false
            slot.lock:SetShow(false)
          end
        end
      end
      categoryStartPosY = slotPosStartY + (math.floor((groupItemSlotIndex - 1) / columnMax) + 1) * slotSizeY
    end
  end
  self._ui.frame_categoryContent:SetSize(self._ui.frame_categoryContent:GetSizeX(), categoryStartPosY + 10)
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
  if categoryStartPosY > self._ui.frame_category:GetSizeY() then
    self._ui.frame_categoryVerticalScroll:SetShow(true)
    self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  end
end
function PaGlobal_Inventory_All_ForConsole:addEffectBlackStone_ForCategoryView(slot, slotNo)
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  if itemWrapper == nil then
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if itemKey == 16001 then
    slot.icon:AddEffect("fUI_DarkstoneAura01", true, 0, 0)
  elseif itemKey == 16002 then
    slot.icon:AddEffect("fUI_DarkstoneAura02", true, 0, 0)
  end
end
function PaGlobal_Inventory_All_ForConsole:categoryShow(isShow)
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  self._ui.stc_invenBG:SetShow(not isShow)
  self._ui.stc_categoryBG:SetShow(isShow)
  ToClient_padSnapIgnoreMoveToThisControl(self._ui.stc_invenGroup, false)
  if isShow == true then
    self:updateCategorySlots()
  end
end
function PaGlobal_Inventory_All_ForConsole:clearCategoryAndSlot()
  self._ui.txt_noItem:SetShow(false)
  self._ui.frame_categoryVerticalScroll:SetShow(false)
  for ii = 0, __eInvenCategoryType_Count - 1 do
    self._ui.categoryTitleList[ii].content:SetShow(false)
  end
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    self._ui.categorySlotBgList[slotNo]:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:isCategoryShow()
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  return self._ui.btn_categoryView:IsCheck()
end
function PaGlobal_Inventory_All_ForConsole:categoryScrollTop()
  if _ContentsGroup_InvenCategory == false then
    return
  end
  self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  self._ui.frame_categoryVerticalScroll:SetControlTop()
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
end
function PaGlobal_Inventory_All_ForConsole:moveInvenItemToServantInven(slotNo)
  local inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if servantWrapper == nil or itemWrapper == nil then
    return
  end
  FGlobal_PopupMoveItem_Init(inventoryType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
end
function PaGlobal_Inventory_All_ForConsole:onPadEventUpACategoryInven(slotNo)
  if self._ui.categorySlotList[slotNo] == nil then
    return
  end
  local inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local slot = self._ui.categorySlotList[slotNo]
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil == itemStatic then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local itemConnectUi = itemEnchantWrapper:getConnectUi()
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  if nil ~= itemWrapper and slot.icon:IsEnable() then
    if false == slot.icon:IsEnable() then
      return
    end
    if selfProxy:doRideMyVehicle() and itemStatic:isUseToVehicle() and (nil == self._rClickFunc or 50823 ~= itemWrapper:get():getKey():getItemKey()) then
      inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
      return
    end
    if nil ~= self._rClickFunc then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
      self._rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    if PaGlobalFunc_CampWarehouse_All_GetShow() then
      self._servantActorKeyRaw[1] = self._campActorProxy
    end
    if nil ~= self._servantActorKeyRaw and nil ~= self._servantActorKeyRaw[1] then
      local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
      if nil == servantWrapper then
        return
      end
      local vehicleType = servantWrapper:getVehicleType()
      if CppEnums.VehicleType.Type_CampingTent == vehicleType and UPPER_TAB_TYPE.SERVANT_TAB == self._currentUpperTab and false == Panel_Window_CampWarehouse_All:GetShow() then
        inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
        return
      end
    end
    if UPPER_TAB_TYPE.SERVANT_TAB == self._currentUpperTab and nil ~= self._servantActorKeyRaw and #self._servantActorKeyRaw > 0 then
      self:moveInvenItemToServantInven(slotNo)
      return
    end
    PaGlobal_TutorialManager:handleInventorySlotRClick(itemWrapper:get():getKey():getItemKey())
    PaGlobal_TutorialManager:handleInventorySlotRClickgetSlotNo(slotNo)
    if nil ~= Panel_Auction_Regist_Popup and Panel_Auction_Regist_Popup:GetShow() then
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Auction_RegisterItemFromInventory)
      else
        Auction_RegisterItemFromInventory(1, slotNo)
      end
      return
    elseif nil ~= Panel_Window_FairySetting and Panel_Window_FairySetting:GetShow() then
      PaGlobal_FairySetting_SetPortion(itemWrapper:get():getKey())
    elseif nil ~= Panel_FairyInfo and Panel_Window_FairyUpgrade:GetShow() then
      if true == itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobal_FairyUpgrade_RClickItemByNumberPad, false, itemWrapper:get():getKey())
      else
        PaGlobal_FairyUpgrade_RClickItem(itemWrapper:get():getKey(), slotNo, 1)
      end
    elseif true == PaGlobalFunc_DialogMain_All_GetAuctionState() then
      return
    elseif 2 == itemEnchantWrapper:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local function bindingItemUse()
        Inventory_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local messageContent
      if itemEnchantWrapper:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = bindingItemUse,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", false, false)
      if eConnectUiType.eConnectUi_Letter == itemConnectUi then
        ConnectLetterUI(itemWrapper:get():getKey():getItemKey())
      else
        ConnectUI(itemConnectUi, itemWrapper:get():getKey():getItemKey())
      end
    elseif itemWrapper:getStaticStatus():getItemType() == 8 then
      return
    elseif true == _ContentsGroup_HopeGauge and true == itemStatic:isItemCollectionScroll() then
      Panel_Tooltip_Item_hideTooltip()
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
      PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(inventoryType, slotNo, itemEnchantWrapper:getGradeType())
    elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox or itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
      if ToClient_CheckAndNotifyNecessarySlotForOpenItemBox(inventoryType, slotNo, 1) ~= 0 then
        return
      end
      self._multiUseCount_s64 = itemWrapper:getCount()
      self._multiUseInventoryType = inventoryType
      self._multiUseSlotNo = slotNo
      if itemEnchantWrapper:getContentsEventParam2() == __eBoxItemUiType_NotUseMultiBoxItem then
        self._multiUseCount_s64 = toInt64(0, 1)
      elseif itemEnchantWrapper:isStackable() == false and itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox then
        self._multiUseCount_s64 = ToClient_InventoryFindSlotListSize(inventoryType, itemWrapper:get():getKey())
      end
      if itemEnchantWrapper:isPopupItem() == true then
        Panel_Tooltip_Item_hideTooltip()
        if true == _ContentsGroup_RenewUI_Tooltip then
          PaGlobalFunc_TooltipInfo_Close()
          PaGlobalFunc_FloatingTooltip_Close()
        end
        if itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
        else
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo, HandleClicked_Inventory_All_UseMultiBoxes)
        end
        return
      elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
        Inventory_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
        return
      end
      HandleClicked_Inventory_All_UseMultiBoxes()
    elseif itemEnchantWrapper:isPopupItem() then
      Panel_Tooltip_Item_hideTooltip()
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
      PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
    elseif _ContentsGroup_RepeatCollect == true and itemWrapper:getStaticStatus():get():getContentsEventType() == __eContentsType_CollectByTool then
      local invenPopupConfig = {
        [1] = {
          func = HandleClickedUseItem,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ONCE_USE"),
          enable = true
        },
        [2] = {
          func = HandleClickedRepeatUseItem,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CONTINUITY_USE"),
          enable = true
        }
      }
      if not PaGlobalFunc_MultiButtonPopup_IsOpened() then
        PaGlobalFunc_MultiButtonPopup_Open(invenPopupConfig, getMousePosX(), getMousePosY())
      else
        PaGlobalFunc_MultiButtonPopup_Close()
      end
      return
    elseif itemEnchantWrapper:isExchangeItemNPC() or itemWrapper:isSoulCollector() or 17 == itemWrapper:getStaticStatus():getItemType() then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if nil == itemKey then
        return
      end
      local invenPopupConfig = {
        [1] = {
          func = HandleClickedWidget,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
          enable = true
        },
        [2] = {
          func = HandleClickedWayPoint,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHENCYCLOPEDIA_BTN_FISHLOCATION"),
          enable = true
        }
      }
      if 17 == itemWrapper:getStaticStatus():getItemType() and false == itemEnchantWrapper:isExchangeItemNPC() then
        invenPopupConfig = {
          [1] = {
            func = HandleClickedWidget,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
            enable = true
          },
          [2] = {
            func = FindNearestNPCShop,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_USELESSITEM_WAYPOINT_BTN"),
            enable = true
          }
        }
      end
      if true == itemWrapper:isSoulCollector() then
        invenPopupConfig = {
          [1] = {
            func = HandleClickedWidget,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
            enable = true
          }
        }
      end
      if true == whereUseItem_isSameItem(itemKey) then
        invenPopupConfig[1] = {
          func = WhereUseItemDirectionClose,
          param = nil,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_0"),
          enable = true
        }
      end
      if not PaGlobalFunc_MultiButtonPopup_IsOpened() then
        PaGlobalFunc_MultiButtonPopup_Open(invenPopupConfig, getMousePosX(), getMousePosY())
      else
        PaGlobalFunc_MultiButtonPopup_Close()
      end
    elseif not itemStatic:isUseToVehicle() then
      local function useTradeItem()
        Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
      end
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      if 2 == item_type and true == itemSSW:get():isForJustTrade() then
        local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_CONTENT")
        local messageboxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_TITLE"),
          content = messageContent,
          functionYes = useTradeItem,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      else
        if true == itemSSW:get():isEquipable() and false == itemSSW:isUsableServant() and false == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) then
          PaGlobalFunc_MessageBox_SeasonItem_All_Open()
        end
        local equipType = itemWrapper:getStaticStatus():getEquipType()
        if 16 == equipType or 17 == equipType then
          local accSlotNo = FGlobal_AccSlotNo(itemWrapper, true)
          Inventory_UseItemTargetSelf(inventoryType, slotNo, accSlotNo)
        else
          Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
        end
      end
    end
  end
end
function InputMOn_Inventory_All_ForConsole_categoryInvenShowTooltip(slotNo)
  PaGlobal_UseItem_All_NotifyInventorySlotChanged(0)
  local self = PaGlobal_Inventory_All_ForConsole
  local slot = self._ui.categorySlotList[slotNo]
  if slot == nil then
    return
  end
  self._newItemAtSlot[slotNo] = false
  if self.effectScene.newItem[slotNo] ~= nil then
    self._ui.categorySlotList[slotNo].icon:EraseEffect(self.effectScene.newItem[slotNo])
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
  self._tooltipWhereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  self._tooltipSlotNo = slotNo
  if itemWrapper ~= nil then
    PaGlobal_UseItem_All_NotifyInventorySlotChanged(itemWrapper:getStaticStatus():getItemKey())
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNote, self._ui.categorySlotBgList[slotNo], "Inventory")
      setPositionFloatingTooltip(self)
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_SetPosition(slotNo, self._ui.categorySlotList[slotNo], "categoryInventory")
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", true, false, _panel:GetPosX(), 20)
    end
  elseif true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
  if self:isSnappedOn("InventoryInfo_CategoryInvenSlotBG_") == true then
    self:setKeyGuide("InventoryInfo_CategoryInvenSlotBG_")
  elseif _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InputMOut_Inventory_All_ForConsole_categoryInvenHideTooltip(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  self._tooltipWhereType = nil
  self._tooltipSlotNo = nil
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  elseif _ContentsGroup_NewUI_Tooltip_All == true or Panel_Tooltip_Item ~= nil and Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
  TooltipSimple_Hide()
end
function PadEventUpX_Inventory_All_ForConsole_categoryInvenToggleTooltip(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(self._lowerTabData[self._currentLowerTab].whereType, slotNo), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function PadEventRSClick_Inventory_All_ForConsole_OpenCraftNote(slotNo, isFamilyInven)
  local self = PaGlobal_Inventory_All_ForConsole
  local inventoryType = CppEnums.ItemWhereType.eInventory
  if false == isFamilyInven then
    inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  else
    inventoryType = CppEnums.ItemWhereType.eFamilyInventory
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if itemWrapper ~= nil then
    Note_On(itemWrapper:get():getKey():getItemKey())
  end
end
function PadEventLTPressX_Inventory_All_ForConsole_categoryInvenItemLock(slotNo)
  PaGlobalFunc_NewbieInventory_SetRestrictOpen(true)
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if itemWrapper == nil then
    return
  end
  if PaGlobalFunc_InventoryInfo_IsItemlockable() == false then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  if itemWrapper:getStaticStatus():isStackable() == false and itemWrapper:isSoulCollector() == false then
    if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
      ToClient_Inventory_RemoveItemLock(slotNo, whereType)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
    else
      ToClient_Inventory_InsertItemLock(slotNo, whereType)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMLOCK"))
    end
  elseif ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    ToClient_Inventory_RemoveItemLock(slotNo, whereType)
    Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANNOT_ITEMLOCK"))
  end
  Inventory_updateSlotData()
  InputMOn_Inventory_All_ForConsole_categoryInvenShowTooltip(slotNo)
end
function PadEventLTPressY_Inventory_All_ForConsole_categoryInvenItemDelete(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if self._filterFunc ~= nil or self._rClickFunc ~= nil then
    return
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if itemWrapper == nil then
    return
  end
  if isPadPressed(__eJoyPadInputType_A) then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    Inventory_ItemDelete_Check(Defines.s64_const.s64_1, slotNo, whereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, Inventory_ItemDelete_Check, nil, whereType)
  end
end
function PadEventUpA_Inventory_All_ForConsole_InvenSlot(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if Panel_Gacha_Roulette ~= nil and Panel_Gacha_Roulette:GetShow() == true then
    return
  end
  if Defines.UIMode.eUIMode_Repair == GetUIMode() then
    local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if itemWrapper ~= nil and Panel_Dialog_Repair_Function_All:GetShow() == true then
      PaGlobalFunc_RepairFunc_All_InvenRClick(slotNo, itemWrapper, nil, whereType)
    end
  else
    self:onPadEventUpACategoryInven(slotNo)
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_FloatingTooltip_Close()
    PaGlobalFunc_TooltipInfo_Close()
  elseif Panel_Tooltip_Item ~= nil and Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "categoryInventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PadEventUpA_Inventory_All_ForConsole_AutoInsertSetException(slotNo)
  if _ContentsGroup_ItemMove == false then
    return
  end
  local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[PaGlobal_Inventory_All_ForConsole._currentLowerTab].whereType
  if PaGlobal_ItemMoveSet_BasicItemFilter(slotNo, nil, whereType) == false then
    PaGlobal_ItemMoveSet:setExceptionItemKey(whereType, slotNo)
  end
end
function PaGlobal_Inventory_All_ForConsole_CategoryShow(isShow)
  PaGlobal_Inventory_All_ForConsole:categoryShow(isShow)
end
function PaGlobal_Inventory_All_ForConsole_IsCategoryShow()
  return PaGlobal_Inventory_All_ForConsole:isCategoryShow()
end
function PaGlobal_Inventory_All_ForConsole_CategoryInvenSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self:getSnappedControlsIndex()
  if self._ui.categorySlotList[slotNo] == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
  local selectable = itemWrapper ~= nil
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideA2:SetShow(false)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
  self._ui.txt_keyGuideLTY:SetShow(selectable)
end
function PaGlobal_Inventory_All_ForConsole_CategoryInvenAutoInsertRegisterEvent(isPanelOpen)
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local slotBG = PaGlobal_Inventory_All_ForConsole._ui.categorySlotBgList[slotNo]
    if isPanelOpen == true then
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PadEventUpA_Inventory_All_ForConsole_AutoInsertSetException(" .. slotNo .. ")")
    else
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PadEventUpA_Inventory_All_ForConsole_InvenSlot(" .. slotNo .. ")")
    end
  end
end
function PaGlobal_Inventory_All_ForConsole_categoryInvenSearchCooltimeItems()
  local self = PaGlobal_Inventory_All_ForConsole
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local remainCooltime = getItemCooltime(Inventory_GetCurrentInventoryType(), slotNo)
    if remainCooltime > 0 then
      self._categorySlotCooltimeList[slotNo] = true
    else
      self._categorySlotCooltimeList[slotNo] = false
      if self._ui.categorySlotList[slotNo].cooltime:GetShow() == true then
        PaGlobal_Inventory_All_ForConsole_categoryInvenCoolTimeEnd(slotNo)
      end
    end
  end
end
function PaGlobal_Inventory_All_ForConsole_categoryInvenPerFrameUpdate(deltaTime)
  local self = PaGlobal_Inventory_All_ForConsole
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    if self._categorySlotCooltimeList[slotNo] == true then
      local remainCooltime = getItemCooltime(Inventory_GetCurrentInventoryType(), slotNo)
      local slot = self._ui.categorySlotList[slotNo]
      if remainCooltime > 0 then
        if slot.cooltime:GetShow() == false then
          slot.cooltime:SetShow(true)
        end
        slot.cooltime:UpdateCoolTime(remainCooltime)
        local itemReuseTime = getItemReuseCycle(Inventory_GetCurrentInventoryType(), slotNo)
        local realRemainTime = remainCooltime * itemReuseTime
        local intRemainTime = realRemainTime - realRemainTime % 1 + 1
        if itemReuseTime >= intRemainTime then
          slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if slot.cooltimeText:GetShow() == false then
            slot.cooltimeText:SetShow(true)
          end
        else
          slot.cooltimeText:SetShow(false)
        end
      else
        self._categorySlotCooltimeList[slotNo] = false
      end
    end
  end
end
function PaGlobal_Inventory_All_ForConsole_categoryInvenCoolTimeEnd(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  local slot = self._ui.categorySlotList[slotNo]
  local slotBG = self._ui.categorySlotBgList[slotNo]
  slot.cooltime:SetShow(false)
  slot.cooltimeText:SetShow(false)
  local frameSizeY = self._ui.frame_category:GetSizeY()
  local contentPosY = self._ui.frame_categoryContent:GetPosY()
  local IconPosY = slotBG:GetPosY()
  local effectPosY = contentPosY + IconPosY
  if (effectPosY >= 0 and frameSizeY >= effectPosY) == false then
    return
  end
  local skillSlotItemPosX = slot.cooltime:GetParentPosX()
  local skillSlotItemPosY = slot.cooltime:GetParentPosY()
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
  Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
  _AudioPostEvent_SystemUiForXBOX(2, 1)
end
function PaGlobal_Inventory_All_ForConsole_cashProductRestoreBgOpen()
  if _ContentsGroup_PearlBoxWebBuy == true and PaGlobal_Inventory_All_ForConsole._isCashProductBlockOpenChcked == false then
    if ToClient_getWebCashRestoreCount() > 0 then
      if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == false then
        for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
          local slot = PaGlobal_Inventory_All_ForConsole._ui.slot_inven[slotNo]
          local slotBG = PaGlobal_Inventory_All_ForConsole._ui.stc_invenSlotBG[slotNo]
          if slot ~= nil then
            slot.icon:SetShow(false)
            slot.icon:SetIgnore(true)
          end
          if slotBG ~= nil then
            slotBG:SetShow(false)
            slotBG:SetIgnore(true)
          end
        end
      else
        for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
          local slot = PaGlobal_Inventory_All_ForConsole._ui.categorySlotList[slotNo]
          local slotBG = PaGlobal_Inventory_All_ForConsole._ui.categorySlotBgList[slotNo]
          if slot ~= nil then
            slot.icon:SetShow(false)
            slot.icon:SetIgnore(true)
          end
          if slotBG ~= nil then
            slotBG:SetShow(false)
            slotBG:SetIgnore(true)
          end
        end
      end
      PaGlobal_Inventory_All_ForConsole._ui.stc_cashProductBg:SetShow(true)
      ToClient_padSnapChangeToTarget(PaGlobal_Inventory_All_ForConsole._ui.btn_restoreProduct)
    else
      HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
    end
  end
end
function HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
  if PaGlobal_Inventory_All_ForConsole._ui.stc_cashProductBg ~= nil and PaGlobal_Inventory_All_ForConsole._ui.stc_cashProductBg:GetShow() == false then
    return
  end
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local slot = PaGlobal_Inventory_All_ForConsole._ui.slot_inven[slotNo]
    local slotBG = PaGlobal_Inventory_All_ForConsole._ui.stc_invenSlotBG[slotNo]
    if slot ~= nil then
      slot.icon:SetShow(true)
      slot.icon:SetIgnore(false)
    end
    if slotBG ~= nil then
      slotBG:SetShow(true)
      slotBG:SetIgnore(false)
    end
  end
  for slotNo = __eTInventorySlotNoUseStart, __eTInventorySlotNoMax - 1 do
    local slot = PaGlobal_Inventory_All_ForConsole._ui.categorySlotList[slotNo]
    local slotBG = PaGlobal_Inventory_All_ForConsole._ui.categorySlotBgList[slotNo]
    if slot ~= nil then
      slot.icon:SetShow(true)
      slot.icon:SetIgnore(false)
    end
    if slotBG ~= nil then
      slotBG:SetShow(true)
      slotBG:SetIgnore(false)
    end
  end
  PaGlobal_Inventory_All_ForConsole._ui.stc_cashProductBg:SetShow(false)
  PaGlobal_Inventory_All_ForConsole._isCashProductBlockOpenChcked = true
  FromClient_InventoryInfo_updateInvenSlot()
end
