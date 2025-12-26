function PaGlobal_Inventory_All:changeMileageIcon()
  if false == _ContentsGroup_OceanCurrent then
    self._ui.stc_oceanIcon:SetShow(false)
    self._ui.txt_oceanValue:SetShow(false)
    self._ui.stc_bottom_OceanIcon:SetShow(false)
    self._ui.txt_bottom_OceanValue:SetShow(false)
  end
  if false == _ContentsGroup_MileageShop then
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
    self._ui.stc_bottom_MileageIcon:SetShow(false)
    self._ui.txt_bottom_MileageValue:SetShow(false)
  else
    self:setMileageImage()
    self._ui.stc_mileageIcon:setRenderTexture(self._ui.stc_mileageIcon:getBaseTexture())
    self._ui.stc_mileageIcon:ComputePos()
    self._ui.stc_bottom_MileageIcon:setRenderTexture(self._ui.stc_bottom_MileageIcon:getBaseTexture())
    self._ui.stc_bottom_MileageIcon:ComputePos()
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    self._ui.stc_hardCoreIcon:SetShow(true)
    self._ui.txt_hardCoreValue:SetShow(true)
    self._ui.stc_bottom_hardCoreIcon:SetShow(true)
    self._ui.txt_bottom_hardCoreValue:SetShow(true)
    self._ui.stc_oceanIcon:SetShow(false)
    self._ui.txt_oceanValue:SetShow(false)
    self._ui.stc_bottom_OceanIcon:SetShow(false)
    self._ui.txt_bottom_OceanValue:SetShow(false)
  else
    self._ui.stc_hardCoreIcon:SetShow(false)
    self._ui.txt_hardCoreValue:SetShow(false)
    self._ui.stc_bottom_hardCoreIcon:SetShow(false)
    self._ui.txt_bottom_hardCoreValue:SetShow(false)
  end
  self:updateMileageValue()
end
function PaGlobal_Inventory_All:setMileageImage()
  local contorl = self._ui.stc_mileageIcon
  if _ContentsGroup_InvenCategory == true then
    contorl = self._ui.stc_bottom_MileageIcon
  end
  contorl:ChangeTextureInfoNameAsync("Combine/Icon/Combine_Cashshop_Icon_00.dds")
  if isGameTypeNA() or isGameTypeID() then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 24, 1, 46, 23)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif isGameTypeTR() then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 47, 1, 69, 23)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif _ContentsOption_CH_Help == true then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 70, 1, 91, 23)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
  else
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 1, 1, 23, 23)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_Inventory_All:updateMileageValue()
  local mileageValue = Defines.s64_const.s64_0
  local mileagelItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
  if nil ~= mileagelItemWrapper then
    mileageValue = mileagelItemWrapper:get():getCount_s64()
  end
  self._ui.txt_mileageValue:SetText(makeDotMoney(mileageValue))
  self._ui.txt_bottom_MileageValue:SetText(makeDotMoney(mileageValue))
  if true == _ContentsGroup_OceanCurrent then
    mileageValue = Defines.s64_const.s64_0
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
    if nil ~= priceItemWrapper then
      mileageValue = priceItemWrapper:get():getCount_s64()
    end
    self._ui.txt_oceanValue:SetText(makeDotMoney(mileageValue))
    self._ui.txt_bottom_OceanValue:SetText(makeDotMoney(mileageValue))
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    local hardCoreCoinValue = Defines.s64_const.s64_0
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_HardCore)
    if nil ~= priceItemWrapper then
      hardCoreCoinValue = priceItemWrapper:get():getCount_s64()
    end
    self._ui.txt_hardCoreValue:SetText(makeDotMoney(hardCoreCoinValue))
    self._ui.txt_bottom_hardCoreValue:SetText(makeDotMoney(hardCoreCoinValue))
  end
end
function PaGlobal_Inventory_All:updateMoney()
  local money = Defines.s64_const.s64_0
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, getMoneySlotNo())
  if nil ~= moneyItemWrapper then
    money = moneyItemWrapper:get():getCount_s64()
  end
  local pearl = Defines.s64_const.s64_0
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  if nil ~= pearlItemWrapper then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  PaGlobal_Inventory_All._ui.txt_moneyValue:SetText(makeDotMoney(money))
  PaGlobal_Inventory_All._ui.txt_pearlValue:SetText(makeDotMoney(pearl))
  PaGlobal_Inventory_All._ui.txt_bottom_MoneyValue:SetText(makeDotMoney(money))
  PaGlobal_Inventory_All._ui.txt_bottom_PearlValue:SetText(makeDotMoney(pearl))
  PaGlobal_Inventory_All:changeSilverIcon(money)
end
function PaGlobal_Inventory_All:updateCapacity()
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  if inventory == nil then
    return
  end
  local invenUseSize = inventory:size()
  local freeCount = inventory:getFreeCount()
  local fontColor
  local leftCountPercent = (invenUseSize - freeCount - useStartSlot) / (invenUseSize - useStartSlot) * 100
  if leftCountPercent >= 100 then
    if true == _ContentsGroup_ChinaFontColor then
      fontColor = "<PAColor0xFFF5B327>"
    else
      fontColor = "<PAColor0xFFF03838>"
    end
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  PaGlobal_Inventory_All._ui.prog_bottom_Slot:SetProgressRate(Int64toInt32(leftCountPercent))
  PaGlobal_Inventory_All._ui.txt_bottom_SlotCount:SetText(fontColor .. tostring(invenUseSize - freeCount - useStartSlot) .. "/" .. tostring(invenUseSize - useStartSlot) .. "<PAOldColor>")
  PaGlobal_Inventory_All._ui.txt_capacity:SetText(fontColor .. tostring(invenUseSize - freeCount - useStartSlot) .. "/" .. tostring(invenUseSize - useStartSlot) .. "<PAOldColor>")
end
function PaGlobal_Inventory_All:updateSelectBar()
  local offset = (self._ui.rdo_normalInven:GetSizeX() - self._ui.stc_selectbar:GetSizeX()) * 0.5
  if true == self._ui.rdo_normalInven:IsChecked() then
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_normalInven:GetPosX() + offset, self._ui.stc_selectbar:GetSpanSize().y)
  elseif true == self._ui.rdo_familyInven:IsChecked() then
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_familyInven:GetPosX() + offset, self._ui.stc_selectbar:GetSpanSize().y)
  elseif true == self._ui.rdo_enchantMaterialInven:IsChecked() then
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_enchantMaterialInven:GetPosX() + offset, self._ui.stc_selectbar:GetSpanSize().y)
  elseif true == self._ui.rdo_pearlInven:IsChecked() then
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_pearlInven:GetPosX() + offset, self._ui.stc_selectbar:GetSpanSize().y)
  end
end
function PaGlobal_Inventory_All:changeSilverIcon(money)
  local contorl = self._ui.stc_moneyIcon
  if _ContentsGroup_InvenCategory == true then
    contorl = self._ui.stc_bottom_MoneyIcon
  end
  contorl:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Icon_00.dds")
  contorl:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Icon_00.dds")
  contorl:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Icon_00.dds")
  if money >= toInt64(0, 100000) then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 258, 124, 288, 154)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(contorl, 261, 155, 291, 185)
    contorl:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(contorl, 261, 155, 291, 185)
    contorl:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  elseif money >= toInt64(0, 20000) then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 227, 124, 257, 154)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(contorl, 230, 155, 260, 185)
    contorl:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(contorl, 230, 155, 260, 185)
    contorl:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  elseif money >= toInt64(0, 5000) then
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 196, 124, 226, 154)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(contorl, 199, 155, 229, 185)
    contorl:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(contorl, 199, 155, 229, 185)
    contorl:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  else
    local x1, y1, x2, y2 = setTextureUV_Func(contorl, 165, 124, 195, 154)
    contorl:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(contorl, 168, 155, 198, 185)
    contorl:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(contorl, 168, 155, 198, 185)
    contorl:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  end
  contorl:setRenderTexture(contorl:getBaseTexture())
  contorl:setRenderTexture(contorl:getOnTexture())
  contorl:setRenderTexture(contorl:getClickTexture())
end
function PaGlobal_Inventory_All:selectTabSound()
  if PaGlobal_Inventory_All._isFirstTab == true then
    PaGlobal_Inventory_All._isFirstTab = false
  else
    audioPostEvent_SystemUi(0, 0)
  end
end
function PaGlobal_Inventory_All:isRestricted()
  return checkManufactureAction() or checkAlchemyAction()
end
function PaGlobal_Inventory_All:changeWeightIcon(s64_allWeight, s64_maxWeight_div)
  if 80 <= Int64toInt32(s64_allWeight / s64_maxWeight_div) then
    if true == _ContentsGroup_ChinaFontColor then
      self._ui.stc_weightIcon:SetColor(Defines.Color.C_FFF5B327)
      self._ui.stc_bottom_WeightIcon:SetColor(Defines.Color.C_FFF5B327)
    else
      self._ui.stc_weightIcon:SetColor(Defines.Color.C_FFD05D48)
      self._ui.stc_bottom_WeightIcon:SetColor(Defines.Color.C_FFD05D48)
    end
  else
    self._ui.stc_weightIcon:SetColor(Defines.Color.C_FFFFEDD4)
    self._ui.stc_bottom_WeightIcon:SetColor(Defines.Color.C_FFFFEDD4)
  end
end
function PaGlobal_Inventory_All:potionAutoSetPosition(playerLevel, itemKey, currentWhereType, slotNo)
  if playerLevel <= 20 then
    if 502 == itemKey or 513 == itemKey or 514 == itemKey or 517 == itemKey or 518 == itemKey or 519 == itemKey or 524 == itemKey or 525 == itemKey or 528 == itemKey or 529 == itemKey or 530 == itemKey or 538 == itemKey or 551 == itemKey or 552 == itemKey or 553 == itemKey or 554 == itemKey or 555 == itemKey or 17568 == itemKey or 17569 == itemKey or 19932 == itemKey or 19933 == itemKey or 19934 == itemKey or 19935 == itemKey then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 0)
    elseif 503 == itemKey or 515 == itemKey or 516 == itemKey or 520 == itemKey or 521 == itemKey or 522 == itemKey or 526 == itemKey or 527 == itemKey or 531 == itemKey or 532 == itemKey or 533 == itemKey or 540 == itemKey or 561 == itemKey or 562 == itemKey or 563 == itemKey or 564 == itemKey or 565 == itemKey or 17570 == itemKey or 17571 == itemKey or 19936 == itemKey or 19937 == itemKey or 19938 == itemKey then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 1)
    end
  end
end
function PaGlobal_Inventory_All:findPuzzle()
  if PaGlobalFunc_Inventory_All_IsSorted() == true then
    return
  end
  self:hidePuzzleControl()
  local whereType = Inventory_GetCurrentInventoryType()
  if CppEnums.ItemWhereType.eFamilyInventory == whereType then
    return
  end
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    return
  end
  local isFind = findPuzzleAndReadyMake(whereType)
  if false == isFind then
    return
  end
  local count = getPuzzleSlotCount()
  for ii = 0, count - 1 do
    local puzzleSlotNo = getPuzzleSlotAt(ii)
    local showSlotIndex = puzzleSlotNo - 2 - PaGlobal_Inventory_All._startSlotIndex
    if showSlotIndex >= 0 and showSlotIndex < PaGlobal_Inventory_All.config.slotCount - 1 then
      if 0 == ii then
        self.slotEtcData[showSlotIndex].puzzleControl:SetShow(true)
        self._puzzleControlSlotNo = puzzleSlotNo
      end
      self.slots[showSlotIndex].icon:AddEffect("UI_Item_MineCraft", true, 0, 0)
    end
  end
end
function PaGlobal_Inventory_All:hidePuzzleControl()
  if nil ~= self._puzzleControlSlotNo then
    local showSlotIndex = self._puzzleControlSlotNo - 2 - PaGlobal_Inventory_All._startSlotIndex
    if showSlotIndex >= 0 and showSlotIndex < PaGlobal_Inventory_All.config.slotCount - 1 then
      self.slotEtcData[showSlotIndex].puzzleControl:SetShow(false)
    end
    PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(false)
    self._puzzleControlSlotNo = nil
  end
end
function PaGlobal_Inventory_All:findExchangeItemNPCbySlotNo(slotNo)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  if not inventory:empty(slotNo) then
    local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    PaGlobal_Inventory_All:findExchangeItemNPC(itemSSW)
  end
end
function PaGlobal_Inventory_All:findExchangeItemNPC(itemSSW)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local selfPosition = float3(selfProxy:getPositionX(), selfProxy:getPositionY(), selfProxy:getPositionZ())
  local itemKey = itemSSW:get()._key:get()
  ToClient_FindClosestNPC(itemKey)
  audioPostEvent_SystemUi(0, 14)
  selfProxy:setCurrentFindExchangeItemEnchantKey(itemKey)
end
function PaGlobal_Inventory_All:addEffectBlackStone(index, isFiltered, slotNo)
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    PaGlobal_Inventory_All:addEffectBlackStoneCategorySlot(index, isFiltered, slotNo)
    return
  end
  local slot = self.slots[index]
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
function PaGlobal_Inventory_All:addEffectMapea(index, slotNo)
  local slot = self.slots[index]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  if GetUIMode() == Defines.UIMode.eUIMode_Stable and not PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper) then
    slot.icon:AddEffect("fUI_HorseNameCard01", true, 0, 0)
  end
end
function PaGlobal_Inventory_All:getClassAttackType(classType)
  return NewClassData.newClass_CategoryType[classType]._attackType
end
function PaGlobal_Inventory_All:setNewPearlTabEffect()
  PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:EraseAllEffect()
  for ii = 0, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO do
    if nil ~= PaGlobal_Inventory_All.newPearlItemData[ii] then
      itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, ii)
      if nil == itemWrapper then
        PaGlobal_Inventory_All.newPearlItemData[ii] = nil
      else
        PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:AddEffect("fUI_NewItem_PearlTab_01A", true, 0, 0)
        return true
      end
    end
  end
  return false
end
function PaGlobal_Inventory_All:setNewItemEffect()
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    PaGlobal_Inventory_All:setNewItemEffectCategorySlot()
    return
  else
    for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
      local slotNo = ii + 2 + PaGlobal_Inventory_All._startSlotIndex
      local isSorted = PaGlobalFunc_Inventory_All_IsSorted()
      local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
      if true == isSorted then
        local selfPlayerWrapper = getSelfPlayer()
        if nil == selfPlayerWrapper then
          return
        end
        local selfPlayer = selfPlayerWrapper:get()
        slotNo = selfPlayer:getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.Inventory), ii + PaGlobal_Inventory_All._startSlotIndex)
      end
      local currentWhereType = Inventory_GetCurrentInventoryType()
      local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
      if nil ~= itemWrapper then
        local slot = PaGlobal_Inventory_All.slots[ii]
        local itemEnchantKey = itemWrapper:get():getKey()
        if nil ~= slot and slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO then
          if PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newItemData[slotNo] then
            if itemEnchantKey:get() == PaGlobal_Inventory_All.newItemData[slotNo] then
              if nil ~= PaGlobal_Inventory_All.effectScene.newItem[slotNo] then
                slot.icon:EraseEffect(PaGlobal_Inventory_All.effectScene.newItem[slotNo])
              end
              local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
              PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
            end
          elseif PaGlobal_Inventory_All._ui.rdo_pearlInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newPearlItemData[slotNo] then
            if itemEnchantKey:get() == PaGlobal_Inventory_All.newPearlItemData[slotNo] then
              if nil ~= PaGlobal_Inventory_All.effectScene.newItem[slotNo] then
                slot.icon:EraseEffect(PaGlobal_Inventory_All.effectScene.newItem[slotNo])
              end
              local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
              PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
            end
          elseif PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:IsChecked() == true and nil ~= PaGlobal_Inventory_All.newEnchantMaterial[slotNo] and itemEnchantKey:get() == PaGlobal_Inventory_All.newEnchantMaterial[slotNo] then
            if nil ~= PaGlobal_Inventory_All.effectScene.newItem[slotNo] then
              slot.icon:EraseEffect(PaGlobal_Inventory_All.effectScene.newItem[slotNo])
            end
            local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
          end
        end
      end
    end
  end
end
function PaGlobal_Inventory_All:setFocusSearchText()
  SetFocusEdit(self._ui.edit_search)
  self._ui.txt_searchDefaultText:SetShow(false)
end
function PaGlobal_Inventory_All:clearFocusSearchText()
  ClearFocusEdit()
  TooltipSimple_Hide()
  self._ui.edit_search:SetEditText("")
  self._filterText = ""
  self._ui.txt_searchDefaultText:SetShow(true)
  self._ui.btn_search:SetShow(true)
  self._ui.btn_searchReset:SetShow(false)
  self.searchItemEffectOff = {}
end
function PaGlobal_Inventory_All:clearSearch()
  self:clearFocusSearchText()
  self:findSearchItem(true)
end
function PaGlobal_Inventory_All:searchItem()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  self._filterText = self._ui.edit_search:GetEditText()
  local isReScanSearch = self:findSearchItem(true)
  if true == isReScanSearch then
    self:reScanSearchItem()
  end
end
function PaGlobal_Inventory_All:reScanSearchItem()
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
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
  local inventory = Inventory_GetCurrentInventory()
  if nil == inventory then
    return
  end
  local currentWhereType = Inventory_GetCurrentInventoryType()
  if nil == currentWhereType then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local inventoryMaxSize = inventory:sizeXXX()
  if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
    inventoryMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  end
  local maxSize = inventoryMaxSize - useStartSlot
  local intervalSlotIndex = maxSize - self.INVEN_CURRENTSLOT_COUNT
  local invenUseSize = inventory:size()
  local findMaxSlot = invenUseSize + useStartSlot
  local minSlotIndex = self.config.slotCount - self.config.slotCols * 4
  local maxSlotIndex = intervalSlotIndex + self.config.slotCols * 3
  local startSlot = 0
  local isSorted = PaGlobalFunc_Inventory_All_IsSorted()
  local isSearchFind = false
  for ii = useStartSlot, findMaxSlot - 1 do
    local slotNo = ii
    if true == isSorted then
      slotNo = selfPlayer:getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.Inventory), ii)
    end
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
            if ii <= minSlotIndex then
              startSlot = 0
            elseif ii > maxSlotIndex then
              startSlot = intervalSlotIndex
            else
              startSlot = math.floor((ii - self.config.slotCols * 3) / self.config.slotCols) * self.config.slotCols
            end
            isSearchFind = true
            break
          end
        end
      end
    end
  end
  if true == isSearchFind then
    local curSlotIndex = startSlot / self.config.slotCols
    local maxSlotIndex = intervalSlotIndex / self.config.slotCols
    local scrollPos = math.max(math.min(curSlotIndex / maxSlotIndex, 1), 0)
    self._ui.scroll_inven:SetControlPos(scrollPos)
    self._startSlotIndex = startSlot
    Inventory_updateSlotData()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
  end
end
function PaGlobal_Inventory_All:findSearchItem(isSearch)
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    PaGlobal_Inventory_All:findSearchItemCategorySlot(isSearch)
    return false
  end
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
  local isSorted = PaGlobalFunc_Inventory_All_IsSorted()
  local isSearchFind = false
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = ii + 2 + self._startSlotIndex
    if true == isSorted then
      slotNo = selfPlayer:getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.Inventory), ii + self._startSlotIndex)
    end
    local slot = self.slots[ii]
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
              if isFiltered == false and slot._isLockedItem == true then
                isFiltered = true
              end
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
  if true == isSearch and false == isEmptyText and false == isSearchFind then
    local inventoryMaxSize = inventory:sizeXXX()
    if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
      inventoryMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
    end
    local useStartSlot = inventorySlotNoUserStart()
    local maxSize = inventoryMaxSize - useStartSlot
    if maxSize <= self.INVEN_CURRENTSLOT_COUNT then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
      return false
    else
      return true
    end
  end
  return false
end
function PaGlobal_Inventory_All:deleteMode_toggleShow()
  if self._isDeleteMode == false then
    self:deleteMode_setShow(true)
  else
    self:deleteMode_setShow(false)
  end
end
function PaGlobal_Inventory_All:deleteMode_setShow(isShow)
  if isShow == true then
    self._isDeleteMode = true
    self:deleteMode_showUI()
  else
    self._isDeleteMode = false
    self:deleteMode_hideUI()
  end
  self:deleteMode_clearData()
  if self._isDeleteMode == true then
    Inventory_SetFunctor(PaGlobal_Inventory_All_CheckDeletableItem, nil, nil, nil)
  elseif self.filterFunc == PaGlobal_Inventory_All_CheckDeletableItem then
    Inventory_SetFunctor(nil, nil, nil, nil)
  end
end
function PaGlobal_Inventory_All:deleteMode_hideUI()
  self._ui.stc_moneyBG:SetShow(true)
  self._ui.stc_buttonBG:SetShow(true)
  self._ui.btn_delete:SetShow(false)
  self._ui.btn_restore:SetShow(false)
  self._ui.txt_trashDesc:SetShow(false)
  self._ui.chk_trash:SetCheck(false)
  self._ui.btn_bottom_Trash:SetCheck(false)
  local isStackExtractionOpen = Panel_Window_StackExtraction_All:GetShow() == true
  local isEnchantRemasterPanelOpen = _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true
  if isStackExtractionOpen == false and isEnchantRemasterPanelOpen == false then
    self._ui.stc_moneyBGNew:SetShow(_ContentsGroup_InvenCategory)
    if self._ui.btn_bottom_SellEtcAll:GetShow() == true or self._ui.btn_bottom_AutoMove:GetShow() == true and Panel_Window_Warehouse ~= nil and Panel_Window_Warehouse:GetShow() == true then
      self._ui.stc_btnTypeArea:SetShow(false)
    else
      self._ui.stc_btnTypeArea:SetShow(true)
    end
  end
  self._ui.btn_bottom_Delete:SetShow(false)
  self._ui.btn_bottom_Restore:SetShow(false)
  self._ui.txt_bottom_TrashDesc:SetShow(false)
  PaGlobalFunc_TrashBoxConfirm_All_ClearItemList()
  PaGlobalFunc_TrashBoxConfirm_All_Close()
  self:reloadBottomBgFromMode(self._openedUIMode)
end
function PaGlobal_Inventory_All:deleteMode_showUI()
  self._ui.stc_moneyBG:SetShow(false)
  self._ui.stc_buttonBG:SetShow(false)
  self._ui.btn_delete:SetShow(true)
  self._ui.btn_restore:SetShow(true)
  self._ui.txt_trashDesc:SetShow(true)
  self._ui.stc_moneyBGNew:SetShow(false)
  self._ui.stc_btnTypeArea:SetShow(false)
  self._ui.btn_bottom_Delete:SetShow(true)
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.btn_bottom_Restore:SetShow(false)
  else
    self._ui.btn_bottom_Restore:SetShow(true)
  end
  self._ui.txt_bottom_TrashDesc:SetShow(true)
  self:reloadBottomBgFromMode(self._bottomBG_UIMode.ClickedTrashButton)
end
function PaGlobal_Inventory_All:deleteMode_clearData()
  self._deleteItemListCount = 0
  for slotNo = 0, self.INVEN_MAX_SLOTNO - 1 do
    self._deleteItemList[slotNo] = {}
    self._deleteItemList[slotNo]._invenType = CppEnums.ItemWhereType.eCount
    self._deleteItemList[slotNo]._checked = false
    self._deleteItemList[slotNo]._count = Defines.s64_const.s64_0
  end
end
function PaGlobal_Inventory_All:deleteMode_registerItem(index)
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if itemWrapper == nil then
    return
  end
  if itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true then
    local messagebox = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_COPYITEM_DELETE_MSGDESC"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messagebox)
    return
  end
  if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local bagType = itemWrapper:getStaticStatus():getContentsEventParam1()
    local bagSize = itemWrapper:getStaticStatus():getContentsEventParam2()
    for index = 0, bagSize - 1 do
      local bagItemWrapper = getInventoryBagItemByType(inventoryType, slotNo, index)
      if nil ~= bagItemWrapper then
        if __eInventoryBagType_Cash == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT"))
        elseif __eInventoryBagType_Equipment == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT2"))
        else
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT3"))
        end
        return
      end
    end
  end
  if self._deleteItemList[slotNo]._checked == false and self._deleteItemListCount == __eDeleteItemMaxCount then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_MSG_COUNT", "count", __eDeleteItemMaxCount),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if itemCount == Defines.s64_const.s64_1 then
    PaGlobalFunc_Inventory_All_SetDeleteItemInfo(Defines.s64_const.s64_1, slotNo, inventoryType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_Inventory_All_SetDeleteItemInfo, false, inventoryType)
  end
end
function PaGlobal_Inventory_All:deleteMode_unregisterItem(index)
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  self:deleteMode_unsetData(slotNo)
end
function PaGlobal_Inventory_All:deleteMode_setData(slotNo, count, inventoryType)
  if slotNo >= self.INVEN_MAX_SLOTNO then
    return
  end
  if self._deleteItemList[slotNo]._checked == false then
    if self._deleteItemListCount == __eDeleteItemMaxCount then
      return
    end
    self._deleteItemList[slotNo]._checked = true
    self._deleteItemListCount = self._deleteItemListCount + 1
  end
  self._deleteItemList[slotNo]._invenType = inventoryType
  self._deleteItemList[slotNo]._count = count
  PaGlobalFunc_TrashBoxConfirm_All_PushItem(slotNo)
  Inventory_updateSlotData()
end
function PaGlobal_Inventory_All:deleteMode_unsetData(slotNo)
  if slotNo >= self.INVEN_MAX_SLOTNO then
    return
  end
  if self._deleteItemList[slotNo]._checked == false then
    return
  end
  self._deleteItemListCount = self._deleteItemListCount - 1
  self._deleteItemList[slotNo]._checked = false
  self._deleteItemList[slotNo]._invenType = CppEnums.ItemWhereType.eCount
  self._deleteItemList[slotNo]._count = Defines.s64_const.s64_0
  PaGlobalFunc_TrashBoxConfirm_All_PopItem(slotNo)
  Inventory_updateSlotData()
end
function PaGlobal_Inventory_All:isDeleteMode()
  return self._isDeleteMode
end
function PaGlobal_Inventory_All:deleteMode_slotInfo(slotNo)
  if self._isDeleteMode == false then
    return false, Defines.s64_const.s64_0, CppEnums.ItemWhereType.eCount
  end
  if slotNo == nil or slotNo >= self.INVEN_MAX_SLOTNO then
    return false, Defines.s64_const.s64_0, CppEnums.ItemWhereType.eCount
  end
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  if itemWrapper == nil then
    return false, Defines.s64_const.s64_0, CppEnums.ItemWhereType.eCount
  end
  return self._deleteItemList[slotNo]._checked, self._deleteItemList[slotNo]._count, Inventory_GetCurrentInventoryType()
end
function PaGlobal_Inventory_All:deleteMode_updateIcon()
  if Panel_Window_Inventory_All:GetShow() == false or self._deleteItemList == false then
    return
  end
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    PaGlobal_Inventory_All:deleteMode_updateIconCategorySlot()
    return
  end
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = self.slots[ii]._slotNo
    if self._deleteItemList[slotNo] ~= nil then
      if slotNo ~= nil and self._deleteItemList[slotNo]._checked == true then
        self.slots[ii].delete:SetShow(true)
      else
        self.slots[ii].delete:SetShow(false)
        if self._deleteItemListCount == __eDeleteItemMaxCount then
          self.slots[ii].icon:SetMonoTone(true)
        end
      end
    end
  end
end
function PaGlobal_Inventory_All:deleteMode_sendDeleteItemList()
  ToClient_ClearDeleteItemList()
  local isSucceed = true
  for slotNo, deleteItemInfo in pairs(self._deleteItemList) do
    if deleteItemInfo._checked == true and ToClient_AddDeleteItemList(deleteItemInfo._invenType, slotNo, deleteItemInfo._count) == false then
      isSucceed = false
      break
    end
  end
  return isSucceed
end
function PaGlobal_Inventory_All:deleteMode_requestDelete()
  if self:deleteMode_sendDeleteItemList() == true then
    ToClient_ConfirmDeleteItemList(Inventory_GetCurrentInventoryType())
  end
  ToClient_ClearDeleteItemList()
  self:deleteMode_clearData()
end
