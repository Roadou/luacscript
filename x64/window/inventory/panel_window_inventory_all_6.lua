function PaGlobal_Inventory_All:categoryCntrolInit()
  if _ContentsGroup_InvenCategory == false then
    return
  end
  self._ui.stc_categoryBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_CategorySlotBG")
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
  self._ui.stc_categoryGroup:SetShow(false)
  self._ui.txt_noItem:SetShow(false)
  for categoryType = 0, __eInvenCategoryType_Count - 1 do
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_categoryContent, "Static_Group", self._ui.frame_categoryContent, "CategoryGroup_" .. categoryType)
    if tempContent ~= nil then
      local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. categoryType)
      local tempWeight = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "Static_Weight", tempContent, "StaticText_GroupWeight_" .. categoryType)
      local tempWeightTxt = UI.createAndCopyBasePropertyControl(self._ui.txt_categoryWeight, "StaticText_Weight", tempContent, "StaticText_GroupWeightTxt_" .. categoryType)
      local tempDeco = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "Static_DecoLine", tempContent, "StaticText_GroupDeco_" .. categoryType)
      self._ui.categoryList[categoryType] = {}
      self._ui.categoryList[categoryType].content = tempContent
      self._ui.categoryList[categoryType].titleName = tempTitleName
      self._ui.categoryList[categoryType].weight = tempWeight
      self._ui.categoryList[categoryType].weightTxt = tempWeightTxt
      self._ui.categoryList[categoryType].deco = tempDeco
      self._ui.categoryList[categoryType].titleName:SetText(ToClient_getCategoryNameByType(categoryType))
      self._ui.categoryList[categoryType].weightTxt:SetText(0)
      self._ui.categoryList[categoryType].content:SetShow(false)
      self._ui.categoryList[categoryType].titleName:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_02_Inventory_Category_" .. tostring(categoryType))
      self._ui.categoryList[categoryType].titleName:setRenderTexture(self._ui.categoryList[categoryType].titleName:getBaseTexture())
    end
  end
  for index = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local slotBg = {}
    slotBg.empty = UI.createControl(__ePAUIControl_Static, self._ui.frame_categoryContent, "Inventory_CategorySlot_Base_" .. index)
    slotBg.lock = UI.createControl(__ePAUIControl_Static, self._ui.frame_categoryContent, "Inventory_Slot_Lock_" .. index)
    CopyBaseProperty(self._ui.stc_tempBgSlot, slotBg.empty)
    CopyBaseProperty(self._ui.template_lockSlot, slotBg.lock)
    slotBg.empty:SetShow(false)
    slotBg.lock:SetShow(false)
    self._ui.categorySlotBgList[index] = slotBg
    local slot = {}
    SlotItem.new(slot, "CategoryItemIcon_" .. index, index, self._ui.frame_categoryContent, self.slotConfig)
    slot:createChild()
    slot:clearItem(true)
    slot.icon:SetEnable(true)
    slot.icon:SetIgnore(false)
    slot.icon:SetMonoTone(true)
    slot.isEmpty = true
    slot.icon:EraseAllEffect()
    slot.bagIcon:SetShow(false)
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_RUpEvent(" .. index .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_LUpEvent(" .. index .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_IconTooltip(true, " .. index .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_IconTooltip(false, " .. index .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "HandleEventLDown_Inventory_All_SlotLClick(" .. index .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_Inventory_All_PressMoveEvent(" .. index .. ")")
    slot.icon:SetAutoDisableTime(0.2)
    slot.icon:SetEnableDragAndDrop(false)
    slot.isEmpty = true
    Panel_Tooltip_Item_SetPosition(index, slot, "categoryInventory")
    slot.background = UI.createControl(__ePAUIControl_Static, self._ui.frame_categoryContent, "CategoryItemIcon_BG_" .. index)
    CopyBaseProperty(self._ui.stc_tempSlot, slot.background)
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
    slot.delete = UI.createControl(__ePAUIControl_Static, slot.icon, "CategoryItemIcon_DeleteFilter_" .. index)
    CopyBaseProperty(self._ui.template_delete, slot.delete)
    slot.delete:SetPosX(0)
    slot.delete:SetPosY(0)
    self._ui.categorySlotList[index] = slot
  end
  PaGlobal_Inventory_All:clearCategoryAndSlot()
end
function PaGlobal_Inventory_All:categoryShow(isShow)
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  self._ui.stc_categoryBG:SetShow(isShow)
  self._ui.stc_mainSlotBG:SetShow(not isShow)
  for ii = 0, self.config.slotCount - 1 do
    local slotBG = self._slotsBackground[ii]
    slotBG.empty:SetShow(false)
    slotBG.lock:SetShow(false)
    slotBG.plus:SetShow(false)
    slotBG.onlyPlus:SetShow(false)
    slotBG.olympic:SetShow(false)
    self.slots[ii].icon:SetShow(not isShow)
    self.slots[ii]:clearItem(true)
  end
  if isShow == false then
    PaGlobal_Inventory_All:clearCategoryAndSlot()
  end
end
function PaGlobal_Inventory_All:isCategoryShow()
  if _ContentsGroup_InvenCategory == false then
    return false
  end
  return self._ui.btn_sortList:IsCheck()
end
function PaGlobal_Inventory_All:categoryScrollTop()
  if _ContentsGroup_InvenCategory == false then
    return
  end
  self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  self._ui.frame_categoryVerticalScroll:SetControlTop()
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
end
function PaGlobal_Inventory_All:createItemSlotAndShowCategory(currentWhereType)
  if _ContentsGroup_InvenCategory == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local playerLevel = selfPlayer:getLevel()
  local classType = selfPlayerWrapper:getClassType()
  PaGlobal_Inventory_All:clearCategoryAndSlot()
  local noItem = true
  local categoryStartPosY = 0
  local curCategoryType = __eInvenCategoryType_Count
  local groupItemSlotIndex = 0
  local itemSlotIndex = 0
  local itemStartPosY = self.config.slotStartY - 20
  local categorySizeY = 50
  local categoryWeight = 0
  local sortType = PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.Inventory)
  local currentOpenSlotCount = ToClient_getInventoryOpenedSlotCountBySortType(sortType)
  local sortedList = {}
  for slotNo = 0, PaGlobal_Inventory_All.INVEN_MAX_COUNT - 1 do
    local realSlotNo = selfPlayer:getRealInventorySlotNoNew(sortType, slotNo)
    local itemWrapper = getInventoryItemByType(currentWhereType, realSlotNo)
    if nil ~= itemWrapper then
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
    self._ui.txt_noItem:SetShow(true)
    return
  end
  for showIndex = 0, __eInvenCategoryType_Count - 1 do
    if sortedList[showIndex] ~= nil then
      local categoryType = sortedList[showIndex]._categoryType
      self._ui.categoryList[categoryType].content:SetShow(true)
      self._ui.categoryList[categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
      groupItemSlotIndex = 0
      categoryWeight = 0
      local showCategoryWeight = sortType ~= __eInventorySortWhereType_CashInventoryForCharacter and sortType ~= __eInventorySortWhereType_EnchantInventory
      self._ui.categoryList[categoryType].weight:SetShow(showCategoryWeight)
      self._ui.categoryList[categoryType].weightTxt:SetShow(showCategoryWeight)
      for index, realSlotNo in ipairs(sortedList[showIndex]) do
        local itemWrapper = getInventoryItemByType(currentWhereType, realSlotNo)
        if itemWrapper ~= nil then
          local slotBg = self._ui.categorySlotBgList[realSlotNo]
          slotBg.empty:SetShow(true)
          local slot = self._ui.categorySlotList[realSlotNo]
          slot:clearItem(true)
          slot.icon:EraseAllEffect()
          slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
          slot:setItem(itemWrapper, realSlotNo)
          slot.isEmpty = false
          slot._isLockedItem = false
          local row = math.floor(groupItemSlotIndex / self.config.slotCols)
          local col = groupItemSlotIndex % self.config.slotCols
          local itemPosY = self._ui.categoryList[categoryType].content:GetPosY() + categorySizeY
          slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
          slot.icon:SetPosY(itemPosY + self.config.slotGapY * row)
          slot.icon:SetEnableDragAndDrop(true)
          slot.icon:SetShow(true)
          slotBg.empty:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
          slotBg.empty:SetPosY(itemPosY + self.config.slotGapY * row)
          slotBg.lock:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
          slotBg.lock:SetPosY(itemPosY + self.config.slotGapY * row)
          local isFiltered = false
          if nil ~= PaGlobal_Inventory_All.filterFunc then
            isFiltered = PaGlobal_Inventory_All.filterFunc(realSlotNo, itemWrapper, currentWhereType)
            if isFiltered == false and realSlotNo >= currentOpenSlotCount then
              isFiltered = true
            end
          end
          local isFilteredSequenceItem = ToClient_SequenceItemConditionCheck(currentWhereType, realSlotNo)
          if isFilteredSequenceItem == true then
            isFiltered = true
          end
          slot.icon:SetEnable(not isFiltered)
          slot.icon:SetMonoTone(isFiltered)
          slot.icon:SetIgnore(isFiltered)
          if isFiltered == true then
            slot.icon:SetAlpha(0.5)
            slot.icon:EraseAllEffect()
          elseif PaGlobal_Inventory_All.filterFunc ~= nil and PaGlobal_Inventory_All.filterFunc ~= PaGlobal_Inventory_All_CheckDeletableItem then
            slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
          end
          local isUseSequenceOnlyItem = itemWrapper:getStaticStatus():isSequenceOnlyItem()
          local allowClickOrDragSequenceItem = PaGlobal_Inventory_All.filterFunc == PaGlobal_Inventory_All_CheckDeletableItem or PaGlobal_Inventory_All.filterFunc == nil
          if isUseSequenceOnlyItem == true and isFilteredSequenceItem == true and allowClickOrDragSequenceItem == true then
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          end
          local itemSSW = itemWrapper:getStaticStatus()
          local itemEnchantKey = itemWrapper:get():getKey()
          local itemKey = itemEnchantKey:getItemKey()
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
          self._ui.categoryList[categoryType].weightTxt:SetText(tostring(weight) .. " LT")
          self._ui.categoryList[categoryType].weight:SetSpanSize(self._ui.categoryList[categoryType].weightTxt:GetTextSizeX(), -2)
          self._ui.categoryList[categoryType].weightTxt:SetSpanSize(self._ui.categoryList[categoryType].weightTxt:GetTextSizeX() + 10, -2)
          for iii = 0, PaGlobal_Inventory_All._exchangeIndex do
            if Panel_Window_Exchange:GetShow() and realSlotNo == PaGlobal_Inventory_All._exchangeSlotNo[iii] then
              if true == _ContentsGroup_ChinaFontColor then
                slot.icon:SetColor(Defines.Color.C_FF6195BD)
              else
                slot.icon:SetColor(Defines.Color.C_FFD20000)
              end
            elseif realSlotNo == PaGlobal_Inventory_All._exchangeSlotNo[iii] and nil == PaGlobal_Inventory_All._exchangeSlotNo[iii] then
              slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
            end
          end
          local itemBindType = itemSSW:get()._vestedType:getItemKey()
          if Panel_Window_Exchange:GetShow() and itemBindType > 0 then
            if true == _ContentsGroup_ChinaFontColor then
              slot.icon:SetColor(Defines.Color.C_FF6195BD)
            else
              slot.icon:SetColor(Defines.Color.C_FFD20000)
            end
          end
          PaGlobal_TutorialManager:handleUpdateInventorySlotData(slot, itemKey)
          if true == itemSSW:isEquipable() then
            local offencePoint = 0
            local defencePoint = 0
            local equipOffencePoint = 0
            local equipDefencePoint = 0
            local matchEquip = false
            local isAccessory = false
            offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = PaGlobalFunc_Inventory_All_CompareSpec(currentWhereType, realSlotNo, isAccessory)
            local currentEndurance = itemWrapper:get():getEndurance()
            local isUsableServant = itemSSW:isUsableServant()
            if not isUsableServant and not Panel_Window_Exchange:GetShow() then
              if nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and true == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
                slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
                local equipPos = itemWrapper:getStaticStatus():getEquipSlotNo()
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
            if isUsableServant == false and itemSSW:isEquipRestrictedFilterOn(classType) == true or false == isUsableServant and false == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) then
              if true == _ContentsGroup_ChinaFontColor then
                slot.icon:SetColor(Defines.Color.C_FF6195BD)
              else
                slot.icon:SetColor(Defines.Color.C_FFD20000)
              end
            end
          elseif true == itemSSW:get():isPushableToSocket() then
            PaGlobal_Inventory_All._hasSocketItem = true
          elseif itemWrapper:isSoulCollector() then
            local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
            local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
            local itemIconPath = itemWrapper:getStaticStatus():getIconPath()
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
            PaGlobal_Inventory_All:addEffectBlackStoneCategorySlot(realSlotNo, isFiltered, realSlotNo)
            PaGlobal_Inventory_All:potionAutoSetPosition(playerLevel, itemKey, currentWhereType, realSlotNo)
            if true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() and not PaGlobalFunc_Inventory_All_IsFirstSummonItemUse() and (42000 == itemKey or 42001 == itemKey or 41607 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey or 42269 == itemKey or 42270 == itemKey or 42002 == itemKey or 42271 == itemKey or 42276 == itemKey or 42277 == itemKey or 42034 == itemKey or 42277 == itemKey or 42003 == itemKey or 42035 == itemKey or 42009 == itemKey or 41675 == itemKey or 42511 == itemKey or 42038 == itemKey or 42054 == itemKey or 41610 == itemKey or 42037 == itemKey or 42036 == itemKey or 42008 == itemKey or 42271 == itemKey or 42039 == itemKey or 42007 == itemKey) then
              slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
            if 42405 == itemKey and questList_hasProgressQuest(4015, 6) then
              slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
            if true == PaGlobal_ValuePackageTutorial_Manager:isDoingValuePackageTutorial() and not PaGlobalFunc_Inventory_All_IsValuePackageItemUse() and (290033 == itemKey or 290034 == itemKey or 290035 == itemKey or 290036 == itemKey or 290037 == itemKey or 290038 == itemKey or 290039 == itemKey or 290040 == itemKey or 290041 == itemKey) then
              slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
          end
          if realSlotNo >= currentOpenSlotCount then
            slot._isLockedItem = true
            slot.icon:SetAlpha(0.5)
            slot.icon:SetMonoTone(true)
            slot.icon:EraseAllEffect()
            slotBg.lock:SetShow(true)
          end
          slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_RUpEvent(" .. realSlotNo .. ")")
          slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_LUpEvent(" .. realSlotNo .. ")")
          slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_IconTooltip(true, " .. realSlotNo .. ")")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_IconTooltip(false, " .. realSlotNo .. ")")
          groupItemSlotIndex = groupItemSlotIndex + 1
          itemStartPosY = slot.icon:GetPosY()
          categoryStartPosY = itemStartPosY + categorySizeY
        end
      end
    end
  end
  self._ui.frame_categoryContent:SetSize(self._ui.frame_categoryContent:GetSizeX(), categoryStartPosY + 10)
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
  if categoryStartPosY > self._ui.frame_category:GetSizeY() then
    self._ui.frame_categoryVerticalScroll:SetShow(true)
    self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  end
  if Panel_Window_ItemMoveSet ~= nil and Panel_Window_ItemMoveSet:GetShow() == true then
    PaGlobal_Inventory_All_ChangeInventoryItemSlotRUpEvent(true)
  end
end
function PaGlobal_Inventory_All:clearCategoryAndSlot()
  self._ui.txt_noItem:SetShow(false)
  self._ui.frame_categoryVerticalScroll:SetShow(false)
  for ii = 0, __eInvenCategoryType_Count - 1 do
    if self._ui.categoryList[ii] ~= nil then
      self._ui.categoryList[ii].content:SetShow(false)
    end
  end
  for index = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    if self._ui.categorySlotList[index] ~= nil then
      self._ui.categorySlotList[index].icon:SetShow(false)
      self._ui.categorySlotList[index]:clearItem(true)
      self._ui.categorySlotList[index].icon:SetEnable(true)
      self._ui.categorySlotList[index].icon:SetIgnore(false)
      self._ui.categorySlotList[index].icon:SetMonoTone(true)
      self._ui.categorySlotList[index].isEmpty = true
      self._ui.categorySlotList[index].icon:EraseAllEffect()
      self._ui.categorySlotBgList[index].empty:SetShow(false)
      self._ui.categorySlotBgList[index].lock:SetShow(false)
    end
  end
end
function PaGlobal_Inventory_All:categoryIconTooltip(isShow, index)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == isShow then
    if nil ~= self.slotOverEffect then
      self._ui.categorySlotList[index].icon:EraseEffect(self.slotOverEffect)
    end
    self._tooltipWhereType = nil
    self._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", false, false)
    TooltipSimple_Hide()
    return
  end
  if index < self.INVEN_MAX_SLOTNO then
    if nil ~= self.effectScene.searchItem[index] then
      self.searchItemEffectOff[index] = true
      self._ui.categorySlotList[index].icon:EraseEffect(self.effectScene.searchItem[index])
      self.effectScene.searchItem[index] = nil
    end
    if nil ~= self.effectScene.newItem[index] then
      if self._ui.rdo_normalInven:IsChecked() == true then
        self.newItemData[index] = nil
      elseif self._ui.rdo_pearlInven:IsChecked() == true then
        self.newPearlItemData[index] = nil
      elseif self._ui.rdo_enchantMaterialInven:IsChecked() == true then
        self.newEnchantMaterial[index] = nil
      end
      self._ui.categorySlotList[index].icon:EraseEffect(self.effectScene.newItem[index])
      self.effectScene.newItem[index] = nil
      self:setNewPearlTabEffect()
    end
  end
  if nil ~= self.slotOverEffect then
    self._ui.categorySlotList[index].icon:EraseEffect(self.slotOverEffect)
  end
  self.slotOverEffect = self._ui.categorySlotList[index].icon:AddEffect("UI_Inventory_EmptySlot", false, 0, 0)
  self._tooltipWhereType = Inventory_GetCurrentInventoryType()
  self._tooltipSlotNo = index
  Panel_Tooltip_Item_Show_GeneralNormal(index, "categoryInventory", true, false)
end
function PaGlobal_Inventory_All:addEffectBlackStoneCategorySlot(index, isFiltered, slotNo)
  local slot = self._ui.categorySlotList[index]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if 16001 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura01", true, 0, 0)
    end
    self._hasWeaponBlackStone = true
  elseif 16002 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura02", true, 0, 0)
    end
    self._hasArmorBlackStone = true
  end
end
function PaGlobal_Inventory_All:setNewItemEffectCategorySlot()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local sortWhereType = PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.Inventory)
  for slotNo = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
    if nil ~= itemWrapper then
      local slot = self._ui.categorySlotList[slotNo]
      if nil ~= slot and slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO then
        local itemEnchantKey = itemWrapper:get():getKey()
        if PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newItemData[slotNo] then
          if itemEnchantKey:get() == PaGlobal_Inventory_All.newItemData[slotNo] then
            local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
          end
        elseif PaGlobal_Inventory_All._ui.rdo_pearlInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newPearlItemData[slotNo] then
          if itemEnchantKey:get() == PaGlobal_Inventory_All.newPearlItemData[slotNo] then
            local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
          end
        elseif PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newEnchantMaterial[slotNo] and itemEnchantKey:get() == PaGlobal_Inventory_All.newEnchantMaterial[slotNo] then
          local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
          PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
        end
      end
    end
  end
end
function PaGlobal_Inventory_All:findSearchItemCategorySlot(isSearch)
  local isEmptyText = nil == self._filterText or "" == self._filterText or self._filterText:len() <= 0
  if false == isSearch and true == isEmptyText then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return false
  end
  local inventory = Inventory_GetCurrentInventory()
  if nil == inventory then
    return false
  end
  if true == isSearch then
    self.searchItemEffectOff = {}
    self.newItemData = {}
    self.newPearlItemData = {}
    self.newEnchantMaterial = {}
    if true == isEmptyText then
      self._ui.txt_searchDefaultText:SetShow(true)
      self._ui.btn_search:SetShow(true)
      self._ui.btn_searchReset:SetShow(false)
    else
      self._ui.btn_search:SetShow(false)
      self._ui.btn_searchReset:SetShow(true)
    end
  end
  self._findResultSlots = {}
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local isSearchFind = false
  for slotNo = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local slot = self._ui.categorySlotList[slotNo]
    if nil ~= slot and nil ~= slot.icon then
      if true == isEmptyText then
        if true == isSearch then
          if nil ~= self.effectScene.searchItem[slotNo] then
            slot.icon:EraseEffect(self.effectScene.searchItem[slotNo])
            self.effectScene.searchItem[slotNo] = nil
          end
          if nil ~= self.effectScene.noOutItem[slotNo] then
            slot.icon:EraseEffect(self.effectScene.noOutItem[slotNo])
            self.effectScene.noOutItem[slotNo] = nil
          end
          local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
          if nil ~= itemWrapper then
            local isFiltered = false
            if nil ~= self.filterFunc then
              isFiltered = self.filterFunc(slotNo, itemWrapper, currentWhereType)
              if isFiltered == false and slot._isLockedItem == true then
                isFiltered = true
              end
            end
            if false == isFiltered then
              if self.filterFunc ~= nil and self.filterFunc ~= PaGlobal_Inventory_All_CheckDeletableItem then
                self.effectScene.noOutItem[slotNo] = slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
              end
              slot.icon:SetAlpha(1)
            end
          end
        end
      else
        slot.icon:EraseAllEffect()
        local isEffectOn = false
        if nil == self.searchItemEffectOff[slotNo] then
          local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
          if nil ~= itemWrapper then
            local isFiltered = false
            if nil ~= self.filterFunc then
              isFiltered = self.filterFunc(slotNo, itemWrapper, currentWhereType)
            end
            if false == isFiltered then
              local itemSSW = itemWrapper:getStaticStatus()
              if nil ~= itemSSW then
                local itemName = itemSSW:getName()
                if true == stringSearch(itemName, self._filterText) then
                  isEffectOn = true
                end
              end
            end
          end
        end
        if true == isEffectOn then
          self.effectScene.searchItem[slotNo] = slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
          slot.icon:SetAlpha(1)
          isSearchFind = true
          table.insert(self._findResultSlots, slot)
        elseif true == self.searchItemEffectOff[slotNo] then
          slot.icon:SetAlpha(1)
          isSearchFind = true
        else
          self.searchItemEffectOff[slotNo] = false
          slot.icon:SetAlpha(0.5)
        end
      end
    end
    if isEmptyText == true and slot._isLockedItem == true then
      slot.icon:SetAlpha(0.5)
      slot.icon:SetMonoTone(true)
      slot.icon:EraseAllEffect()
    end
  end
  if self._findResultSlots[1] ~= nil then
    local slot = self._findResultSlots[1]
    local posY = (slot.icon:GetPosY() + self.config.slotGapY) / self._ui.frame_categoryContent:GetSizeY()
    self._ui.frame_categoryVerticalScroll:SetControlPos(posY)
    self._ui.frame_category:UpdateContentScroll()
    self._ui.frame_category:UpdateContentPos()
  end
  if true == isSearch and false == isEmptyText and false == isSearchFind then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
    return false
  end
  return false
end
function PaGlobal_Inventory_All:deleteMode_updateIconCategorySlot()
  for ii = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    if self._deleteItemList[ii] ~= nil then
      if self._deleteItemList[ii]._checked == true then
        self._ui.categorySlotList[ii].delete:SetShow(true)
      else
        self._ui.categorySlotList[ii].delete:SetShow(false)
        if self._deleteItemListCount == __eDeleteItemMaxCount then
          self._ui.categorySlotList[ii].icon:SetMonoTone(true)
        end
      end
    end
  end
end
function PaGlobal_Inventory_All:updatePerFrameCategorySlot(deltaTime)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local currentWhereType = Inventory_GetCurrentInventoryType()
  for ii = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local slot = self._ui.categorySlotList[ii]
    local slotNo = ii
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    if __eTInventorySlotNoUndefined ~= slotNo then
      remainTime = getItemCooltime(currentWhereType, slotNo)
      itemReuseTime = getItemReuseCycle(currentWhereType, slotNo)
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
function PaGlobal_Inventory_All:changeInventoryCategorySlotRUpEvent(isChange)
  for ii = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local slot = self._ui.categorySlotList[ii]
    if true == isChange then
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_ItemMoveSetExceptionItemKey(" .. ii .. ")")
    else
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_SlotRClick(" .. ii .. ")")
    end
  end
end
function PaGlobal_Inventory_All:findItemCategorySlot(findItemKey)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return nil
  end
  local inventory = Inventory_GetCurrentInventory()
  if inventory == nil then
    return nil
  end
  local currentWhereType = Inventory_GetCurrentInventoryType()
  if currentWhereType == nil then
    return nil
  end
  local useStartSlot = inventorySlotNoUserStart()
  local inventoryMaxSize = inventory:sizeXXX()
  if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
    inventoryMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  end
  local maxSize = inventoryMaxSize - useStartSlot
  local intervalSlotIndex = maxSize - PaGlobal_Inventory_All.INVEN_CURRENTSLOT_COUNT
  local invenUseSize = inventory:size()
  local findMaxSlot = invenUseSize + useStartSlot
  local minSlotIndex = PaGlobal_Inventory_All.config.slotCount - PaGlobal_Inventory_All.config.slotCols * 4
  local maxSlotIndex = intervalSlotIndex + PaGlobal_Inventory_All.config.slotCols * 3
  local startSlot = 0
  local isSorted = PaGlobalFunc_Inventory_All_IsSorted()
  local targetSlotNo, targetControl, scrollInfo
  for ii = PaGlobal_Inventory_All.INVEN_MAX_START, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO - 1 do
    local itemWrapper = getInventoryItemByType(currentWhereType, ii)
    if itemWrapper ~= nil and itemWrapper:get() ~= nil and findItemKey == itemWrapper:get():getKey():getItemKey() then
      targetControl = self._ui.categorySlotList[ii].icon
      scrollInfo = {}
      scrollInfo._isCategory = true
      scrollInfo._pos = (targetControl:GetPosY() + self.config.slotGapY) / self._ui.frame_categoryContent:GetSizeY()
      break
    end
  end
  return targetControl, scrollInfo
end
function PaGlobal_Inventory_All_UpdateContentScroll()
  if _ContentsGroup_InvenCategory == false then
    return
  end
  local self = PaGlobal_Inventory_All
  Inventory_updateOnlySlotData()
end
function PaGlobal_Inventory_All_CategoryShow(isShow)
  if isShow == nil then
    return
  end
  PaGlobal_Inventory_All:categoryShow(isShow)
end
function PaGlobal_Inventory_All_IsCategoryShow()
  return PaGlobal_Inventory_All:isCategoryShow()
end
function HandleEventOnOut_Inventory_All_CategoryIconTooltip(isShow, index)
  return PaGlobal_Inventory_All:categoryIconTooltip(isShow, index)
end
function PaGlobal_Inventory_All_cashProductRestoreBgOpen()
  if _ContentsGroup_PearlBoxWebBuy == true and PaGlobal_Inventory_All._isCashProductBlockOpenChcked == false then
    if ToClient_getWebCashRestoreCount() > 0 then
      if PaGlobal_Inventory_All_IsCategoryShow() == false then
        for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
          local slot = PaGlobal_Inventory_All.slots[ii]
          if slot ~= nil then
            slot.icon:SetShow(false)
          end
        end
        for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
          local backgroundSlot = PaGlobal_Inventory_All._slotsBackground[ii]
          if backgroundSlot ~= nil then
            backgroundSlot.empty:SetShow(false)
            backgroundSlot.lock:SetShow(false)
            backgroundSlot.plus:SetShow(false)
            backgroundSlot.onlyPlus:SetShow(false)
            backgroundSlot.olympic:SetShow(false)
          end
        end
      end
      PaGlobal_Inventory_All._ui.stc_cashProductBg:SetShow(true)
    else
      HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
    end
  end
end
function HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
  if PaGlobal_Inventory_All._ui.stc_cashProductBg ~= nil and PaGlobal_Inventory_All._ui.stc_cashProductBg:GetShow() == false then
    return
  end
  PaGlobal_Inventory_All._ui.stc_cashProductBg:SetShow(false)
  PaGlobal_Inventory_All._isCashProductBlockOpenChcked = true
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  local inventoryMaxSize = 0
  if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
    inventoryMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  else
    inventoryMaxSize = inventory:sizeXXX()
  end
  local maxSize = inventoryMaxSize - useStartSlot
  PaGlobal_Inventory_All._startSlotIndex = 0
  local intervalSlotIndex = PaGlobal_Inventory_All.INVEN_MAX_COUNT - PaGlobal_Inventory_All.INVEN_CURRENTSLOT_COUNT
  Inventory_updateSlotData()
end
