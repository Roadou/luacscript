function PaGlobal_RewardMarket:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_title = UI.getChildControl(Panel_Window_RewardMarket_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Close")
  local stc_rdo = UI.getChildControl(Panel_Window_RewardMarket_All, "Static_RadioButtons")
  self._ui._rdo_petList = UI.getChildControl(stc_rdo, "RadioButton_MyPet")
  self._ui._rdo_itemList = UI.getChildControl(stc_rdo, "RadioButton_MyInven")
  self._ui._stc_selectLine = UI.getChildControl(stc_rdo, "Static_SelctLine")
  self._ui._stc_keyGuideLB = UI.getChildControl(stc_rdo, "Static_SelectLB")
  self._ui._stc_keyGuideRB = UI.getChildControl(stc_rdo, "Static_SelectRB")
  self._ui._lst_myGoods = UI.getChildControl(Panel_Window_RewardMarket_All, "List2_ItemList")
  local list2Content = UI.getChildControl(self._ui._lst_myGoods, "List2_1_Content")
  local chk_goods = UI.getChildControl(list2Content, "CheckButton_Goods")
  local stc_itemGrade = UI.getChildControl(chk_goods, "Static_ItemGrade")
  local stc_itemIcon = UI.getChildControl(stc_itemGrade, "Static_ItemIcon")
  local myGoodsItemSlot = {}
  SlotItem.new(myGoodsItemSlot, "RewardMarket_ItemSlot", 0, stc_itemIcon, self._itemSlotConfing)
  myGoodsItemSlot:createChild()
  local bottomButtonArea = UI.getChildControl(Panel_Window_RewardMarket_All, "Static_BottomButtonArea")
  self._ui._btn_selectAll = UI.getChildControl(bottomButtonArea, "Button_Select_All")
  self._ui._btn_clearSelectAll = UI.getChildControl(bottomButtonArea, "Button_UnSelect_All")
  self._ui._btn_requestSell = UI.getChildControl(bottomButtonArea, "Button_Sell")
  self._ui._stc_rewardArea = UI.getChildControl(Panel_Window_RewardMarket_All, "Static_RewardArea")
  local stc_rewardBg = UI.getChildControl(self._ui._stc_rewardArea, "Static_RewardBg")
  self._ui._frm_reward = UI.getChildControl(stc_rewardBg, "Frame_Reward")
  self._ui._frmContent_reward = UI.getChildControl(self._ui._frm_reward, "Frame_1_Content")
  self._ui._stc_rewardTemplate = UI.getChildControl(self._ui._frmContent_reward, "Static_RewardItemSlot_Template")
  self._ui._btn_close:SetShow(self._isConsole == false)
  self._ui._rdo_petList:SetShow(false)
  self._ui._rdo_itemList:SetShow(false)
  local radioButtonList = Array.new()
  local radioButtonCount = 0
  if _ContentsGroup_RewardMarketOnlyPet == true then
    if self._currentType == nil then
      self._currentType = __eRewardMarketTradeType_PetToItem
    end
    radioButtonList:push_back(self._ui._rdo_petList)
    radioButtonCount = radioButtonCount + 1
  end
  if _ContentsGroup_RewardMarketOnlyItem == true then
    if self._currentType == nil then
      self._currentType = __eRewardMarketTradeType_ItemToItem
    end
    radioButtonList:push_back(self._ui._rdo_itemList)
    radioButtonCount = radioButtonCount + 1
  end
  local onceBtnArea = stc_rdo:GetSizeX() / (radioButtonCount + 1)
  local btnIndex = 1
  for _, btn in pairs(radioButtonList) do
    if btn ~= nil then
      btn:SetShow(true)
      btn:SetSpanSize(onceBtnArea * btnIndex - btn:GetSizeX() / 2, btn:GetSpanSize().y)
      btn:ComputePos()
      btnIndex = btnIndex + 1
    end
  end
  self._ui._stc_keyGuideLB:SetShow(self._isConsole == true and radioButtonCount > 1)
  self._ui._stc_keyGuideRB:SetShow(self._isConsole == true and radioButtonCount > 1)
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_RewardMarket:registEventHandler()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RewardMarket_Close()")
  if self._ui._rdo_petList:GetShow() == true then
    self._ui._rdo_petList:addInputEvent("Mouse_LUp", "HandleEventPadLBRB_RewardMarket_ChangeTab(" .. tostring(__eRewardMarketTradeType_PetToItem) .. ")")
  end
  if self._ui._rdo_itemList:GetShow() == true then
    self._ui._rdo_itemList:addInputEvent("Mouse_LUp", "HandleEventPadLBRB_RewardMarket_ChangeTab(" .. tostring(__eRewardMarketTradeType_ItemToItem) .. ")")
  end
  self._ui._btn_selectAll:addInputEvent("Mouse_LUp", "HandleEventLUp_RewardMarket_OnClickedSelectAll()")
  self._ui._btn_clearSelectAll:addInputEvent("Mouse_LUp", "HandleEventLUp_RewardMarket_OnClickedClearSelectAll()")
  self._ui._btn_requestSell:addInputEvent("Mouse_LUp", "HandleEventLUp_RewardMarket_OnClickedRequestSell()")
  if self._isConsole == true then
    local lValue, rValue
    if _ContentsGroup_RewardMarketOnlyPet == true and _ContentsGroup_RewardMarketOnlyItem == true then
      lValue = __eRewardMarketTradeType_PetToItem
      rValue = __eRewardMarketTradeType_ItemToItem
    elseif _ContentsGroup_RewardMarketOnlyPet == true then
      lValue = __eRewardMarketTradeType_PetToItem
      rValue = __eRewardMarketTradeType_PetToItem
    elseif _ContentsGroup_RewardMarketOnlyItem == true then
      lValue = __eRewardMarketTradeType_ItemToItem
      rValue = __eRewardMarketTradeType_ItemToItem
    end
    Panel_Window_RewardMarket_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadLBRB_RewardMarket_ChangeTab(" .. tostring(lValue) .. ")")
    Panel_Window_RewardMarket_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadLBRB_RewardMarket_ChangeTab(" .. tostring(rValue) .. ")")
  end
  self._ui._lst_myGoods:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RewardMarket_OnCreateMyGoodsListContents")
  self._ui._lst_myGoods:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_ResponseSellToRewardMarket", "FromClient_ResponseSellToRewardMarket")
end
function PaGlobal_RewardMarket:prepareOpen()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  ToClient_SetSelfPlayerRewardMarketData()
  self:selectTab(self._currentType)
  self:open()
end
function PaGlobal_RewardMarket:open()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  Panel_Window_RewardMarket_All:SetShow(true)
end
function PaGlobal_RewardMarket:prepareClose()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  ToClient_ClearSelfPlayerRewardMarketData()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_RewardMarket:close()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  Panel_Window_RewardMarket_All:SetShow(false)
end
function PaGlobal_RewardMarket:selectTab(tabType)
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  if tabType == __eRewardMarketTradeType_PetToItem then
    self._currentType = __eRewardMarketTradeType_PetToItem
    self._ui._rdo_petList:SetCheck(true)
    self._ui._rdo_itemList:SetCheck(false)
    local selectLineSpanX = self._ui._rdo_petList:GetSpanSize().x + self._ui._rdo_petList:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
    self._ui._stc_selectLine:SetSpanSize(selectLineSpanX, self._ui._stc_selectLine:GetSpanSize().y)
    self:updateRewardMarket_petToItem()
  elseif tabType == __eRewardMarketTradeType_ItemToItem then
    self._currentType = __eRewardMarketTradeType_ItemToItem
    self._ui._rdo_petList:SetCheck(false)
    self._ui._rdo_itemList:SetCheck(true)
    local selectLineSpanX = self._ui._rdo_itemList:GetSpanSize().x + self._ui._rdo_itemList:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
    self._ui._stc_selectLine:SetSpanSize(selectLineSpanX, self._ui._stc_selectLine:GetSpanSize().y)
    self:updateRewardMarket_itemToItem()
  else
    UI.ASSERT_NAME(false, "TabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\160\129\236\158\133\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui._stc_selectLine:ComputePos()
  self:unselectAll()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
end
function PaGlobal_RewardMarket:updateRewardMarket_petToItem()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  local listManager = self._ui._lst_myGoods:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local count = ToClient_GetSelfPlayerRewardMarketMaterialPetDataCount()
  for ii = 0, count - 1 do
    local petData = ToClient_GetSelfPlayerRewardMarketMaterialPetDataByIndex(ii)
    if petData ~= nil then
      local tradeKeyRaw = petData:getTradeKeyRaw()
      local tradeSSW = ToClient_GetRewardMarketStaticStatusByKey(tradeKeyRaw)
      if tradeSSW ~= nil then
        listManager:pushKey(toInt64(tradeKeyRaw, ii))
      end
    end
  end
end
function PaGlobal_RewardMarket:updateRewardMarket_itemToItem()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  local listManager = self._ui._lst_myGoods:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local dataCount = ToClient_GetRewardMarketListSize(__eRewardMarketTradeType_ItemToItem)
  for dataIndex = 0, dataCount - 1 do
    local tradeSSW = ToClient_GetRewardMarketStaticStatus(__eRewardMarketTradeType_ItemToItem, dataIndex)
    if tradeSSW ~= nil then
      local tradeKeyRaw = tradeSSW:getKeyRaw()
      local materialCount = ToClient_GetSelfPlayerRewardMarketDataCount(tradeKeyRaw)
      for ii = 0, materialCount - 1 do
        local itemData = ToClient_GetSelfPlayerRewardMarketMaterialItemData(tradeKeyRaw, ii)
        if itemData ~= nil then
          listManager:pushKey(toInt64(tradeKeyRaw, ii))
        end
      end
    end
  end
end
function PaGlobal_RewardMarket:onCreateMyGoodsListContents(content, key)
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  local isSelected = false
  if self._selectGoodsList ~= nil then
    for _, v in pairs(self._selectGoodsList) do
      if v ~= nil and key == v then
        isSelected = true
        break
      end
    end
  end
  local tradeKeyRaw = highFromUint64(key)
  local ii = lowFromUint64(key)
  local chk_goods = UI.getChildControl(content, "CheckButton_Goods")
  local stc_petGradeLine = UI.getChildControl(chk_goods, "Static_PetGradeLine")
  local stc_petIcon = UI.getChildControl(chk_goods, "Static_PetIcon")
  local stc_itemGrade = UI.getChildControl(chk_goods, "Static_ItemGrade")
  local stc_itemIcon = UI.getChildControl(stc_itemGrade, "Static_ItemIcon")
  local stc_checkBg = UI.getChildControl(chk_goods, "Static_CheckBG")
  local stc_name = UI.getChildControl(chk_goods, "StaticText_Name")
  local stc_tierDesc = UI.getChildControl(chk_goods, "StaticText_Pet_Tier")
  local stc_skillDesc = UI.getChildControl(chk_goods, "StaticText_SpecialSkill")
  local stc_leaderIcon = UI.getChildControl(chk_goods, "Static_Leader_Icon")
  local stc_petSkill_0 = UI.getChildControl(chk_goods, "Static_SkillIcon_0")
  local stc_petSkill_1 = UI.getChildControl(chk_goods, "Static_SkillIcon_1")
  local stc_petSkill_2 = UI.getChildControl(chk_goods, "Static_SkillIcon_2")
  local stc_petSkill_3 = UI.getChildControl(chk_goods, "Static_SkillIcon_3")
  local stc_cantSell = UI.getChildControl(content, "StaticText_CantSell")
  local petSkillIconList = Array.new()
  petSkillIconList:push_back(stc_petSkill_0)
  petSkillIconList:push_back(stc_petSkill_1)
  petSkillIconList:push_back(stc_petSkill_2)
  petSkillIconList:push_back(stc_petSkill_3)
  for _, value in pairs(petSkillIconList) do
    if value ~= nil then
      value:SetShow(false)
    end
  end
  content:SetShow(true)
  chk_goods:SetShow(true)
  stc_petGradeLine:SetShow(false)
  stc_petIcon:SetShow(false)
  stc_itemGrade:SetShow(false)
  stc_itemIcon:SetShow(false)
  stc_name:SetShow(false)
  stc_tierDesc:SetShow(false)
  stc_skillDesc:SetShow(false)
  stc_leaderIcon:SetShow(false)
  stc_cantSell:SetShow(false)
  chk_goods:SetCheck(isSelected == true)
  stc_checkBg:SetShow(isSelected == true)
  local isSelectable = true
  if self._currentType == __eRewardMarketTradeType_PetToItem then
    local petData = ToClient_GetSelfPlayerRewardMarketMaterialPetDataByIndex(ii)
    if petData == nil then
      return
    end
    if petData._isUnsealedPet == true or petData._isGroupPet == true then
      stc_cantSell:SetShow(true)
      if self._isConsole == true then
        chk_goods:addInputEvent("Mouse_On", "HandleEventLOnOut_RewardMarket_CantSellTooltip(true," .. tradeKeyRaw .. "," .. ii .. ")")
        chk_goods:addInputEvent("Mouse_Out", "HandleEventLOnOut_RewardMarket_CantSellTooltip(false)")
      else
        stc_cantSell:addInputEvent("Mouse_On", "HandleEventLOnOut_RewardMarket_CantSellTooltip(true," .. tradeKeyRaw .. "," .. ii .. ")")
        stc_cantSell:addInputEvent("Mouse_Out", "HandleEventLOnOut_RewardMarket_CantSellTooltip(false)")
      end
      isSelectable = false
    end
    stc_name:SetText(petData:getPetName())
    stc_name:SetShow(true)
    stc_name:SetFontColor(Defines.Color.C_FFFFFFFF)
    stc_tierDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petData._petTier + 1))
    stc_tierDesc:SetShow(true)
    stc_skillDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(petData._petSkillType)))
    stc_skillDesc:SetShow(true)
    stc_petIcon:ChangeTextureInfoNameAsync(petData:getPetIconPath())
    stc_petIcon:SetShow(true)
    stc_petGradeLine:SetColor(self._gradeColorConfig[petData._petTier])
    stc_petGradeLine:SetShow(true)
    stc_leaderIcon:SetShow(petData._isLeader == true)
    local uiIndex = 1
    local skillMaxCount = ToClient_getPetEquipSkillMax()
    local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(petData._petBaseSkillIndex)
    if skillStaticStatus ~= nil then
      local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
      if skillTypeStaticWrapper ~= nil and petSkillIconList[uiIndex] ~= nil then
        petSkillIconList[uiIndex]:SetShow(true)
        petSkillIconList[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
        if self._isConsole == false then
          petSkillIconList[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_BaseSkill_ShowTooltip_All( " .. petData._petBaseSkillIndex .. ",\"sealPetListSkill\" )")
          petSkillIconList[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_BaseSkill_HideTooltip_All()")
          Panel_SkillTooltip_SetPosition(skillStaticStatus:getSkillNo(), petSkillIconList[uiIndex], "sealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
    for skill_idx = 0, skillMaxCount - 1 do
      local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
      local isLearn = petData:isPetEquipSkillLearned(skill_idx)
      if isLearn == true and skillStaticStatus ~= nil then
        local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
        if skillTypeStaticWrapper ~= nil then
          petSkillIconList[uiIndex]:SetShow(true)
          petSkillIconList[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
          if self._isConsole == false then
            petSkillIconList[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SkillToolTip_All( " .. skill_idx .. ", \"sealPetListSkill\" )")
            petSkillIconList[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_Hide_SkillToolTip_All()")
            Panel_SkillTooltip_SetPosition(skillStaticStatus:getSkillNo(), petSkillIconList[uiIndex], "sealPetListSkill")
          end
          uiIndex = uiIndex + 1
        end
      end
    end
  elseif self._currentType == __eRewardMarketTradeType_ItemToItem then
    local itemData = ToClient_GetSelfPlayerRewardMarketMaterialItemData(tradeKeyRaw, ii)
    if itemData == nil then
      return
    end
    local itemNo_s64 = itemData._itemNo_s64
    local itemWhereType = itemData._itemWhereType
    local slotNo = itemData._slotNo
    local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
    if itemWrapper == nil then
      return
    end
    local item = itemWrapper:get()
    if item == nil then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if itemSSW == nil then
      return
    end
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    local itemName = itemSSW:getName()
    if itemSSW:getItemType() == 1 and enchantLevel > 15 then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemSSW:getName()
    elseif enchantLevel > 0 and itemSSW:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory and (itemSSW:isSpecialEnchantItem() == false or itemSSW:isSpecialAccessory() == true) then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemSSW:getName()
    end
    stc_name:SetText(itemName)
    stc_name:SetShow(true)
    local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    local nameColorGrade = itemSSW:getGradeType()
    if isColorBlindMode ~= nil and isColorBlindMode ~= 0 then
      stc_name:SetFontColor(Defines.Color.C_FFFFFFFF)
    else
      PAGlobalFunc_SetItemTextColor(stc_name, itemSSW)
    end
    stc_itemGrade:SetShow(true)
    stc_itemIcon:SetShow(true)
    local myGoodsItemSlot = {}
    SlotItem.reInclude(myGoodsItemSlot, "RewardMarket_ItemSlot", 0, stc_itemIcon, self._itemSlotConfing)
    myGoodsItemSlot:setItemByStaticStatus(itemSSW, item:getCount_s64(), -1, false)
    myGoodsItemSlot.icon:SetShow(true)
    myGoodsItemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_RewardMarket_ItemTooltip(true," .. tradeKeyRaw .. "," .. ii .. ")")
    myGoodsItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_RewardMarket_ItemTooltip(false)")
  else
    content:SetShow(false)
    return
  end
  if self._isConsole == false then
    chk_goods:SetIgnore(isSelectable == false)
  end
  chk_goods:SetMonoTone(isSelectable == false)
  if isSelectable == true then
    chk_goods:addInputEvent("Mouse_LUp", "HandleEventLUp_RewardMarket_SelectGoolds(" .. tostring(tradeKeyRaw) .. "," .. tostring(ii) .. ")")
  elseif self._isConsole == true then
    chk_goods:addInputEvent("Mouse_LUp", "HandleEventLUp_RewardMarket_UnselectGoolds(" .. tostring(tradeKeyRaw) .. "," .. tostring(ii) .. ")")
  else
    chk_goods:removeInputEvent("Mouse_LUp")
  end
end
function PaGlobal_RewardMarket:onSelectGoodsListContents()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  local listManager = self._ui._lst_myGoods:getElementManager()
  if listManager == nil then
    return
  end
  local listSize = Int64toInt32(listManager:getSize())
  for listIndex = 0, listSize - 1 do
    local contentsKey = self._ui._lst_myGoods:getKeyByIndex(listIndex)
    local content = self._ui._lst_myGoods:GetContentByKey(contentsKey)
    if content ~= nil then
      self:onCreateMyGoodsListContents(content, contentsKey)
    end
  end
  self._rewardItemList = nil
  if self._selectGoodsList == nil then
    self:hideRewardControl()
  else
    self._rewardItemList = Array.new()
    for key, value in pairs(self._selectGoodsList) do
      if value ~= nil then
        local contentsKey = value
        local tradeKeyRaw = highFromUint64(contentsKey)
        local tradeSSW = ToClient_GetRewardMarketStaticStatusByKey(tradeKeyRaw)
        if tradeSSW ~= nil then
          local rewardItemListSize = tradeSSW:getRewardItemListSize()
          for ii = 0, rewardItemListSize - 1 do
            local rewardItemData = {_itemKey = nil, _count_s64 = nil}
            rewardItemData._itemKey = ToClient_GetRewardMarketRewardItemKey(tradeKeyRaw, ii)
            rewardItemData._count_s64 = ToClient_GetRewardMarketRewardItemCount(tradeKeyRaw, ii)
            local rewardItemSSW = getItemEnchantStaticStatus(rewardItemData._itemKey)
            local rewardItemKeyRaw = rewardItemData._itemKey:getItemKey()
            local rewardItemEnchantLevel = rewardItemData._itemKey:getEnchantLevel()
            local isExist = false
            if rewardItemSSW:isStackable() == true then
              for _, v in pairs(self._rewardItemList) do
                if v ~= nil then
                  local valueItemKeyRaw = v._itemKey:getItemKey()
                  local valueItemEnchantLevel = v._itemKey:getEnchantLevel()
                  if valueItemKeyRaw == rewardItemKeyRaw and valueItemEnchantLevel == rewardItemEnchantLevel then
                    v._count_s64 = v._count_s64 + rewardItemData._count_s64
                    isExist = true
                    break
                  end
                end
              end
            end
            if isExist == false then
              self._rewardItemList:push_back(rewardItemData)
            end
          end
        end
      end
    end
    self:showRewardControl()
  end
end
function PaGlobal_RewardMarket:selectGoods(contentsKey, checkToggle)
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  if self._selectGoodsList == nil then
    self._selectGoodsList = Array.new()
  end
  if self._currentType == __eRewardMarketTradeType_PetToItem then
    local ii = lowFromUint64(contentsKey)
    local petData = ToClient_GetSelfPlayerRewardMarketMaterialPetDataByIndex(ii)
    if petData == nil then
      return
    elseif petData._isUnsealedPet == true or petData._isGroupPet == true then
      return
    end
  end
  local isExist = false
  for index = 1, #self._selectGoodsList do
    local value = self._selectGoodsList[index]
    if value ~= nil and value == contentsKey then
      if checkToggle ~= nil and checkToggle == true then
        table.remove(self._selectGoodsList, index)
        return
      else
        isExist = true
        break
      end
    end
  end
  if isExist == false then
    self._selectGoodsList:push_back(contentsKey)
  end
end
function PaGlobal_RewardMarket:selectAll()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  local listManager = self._ui._lst_myGoods:getElementManager()
  if listManager == nil then
    return
  end
  local listSize = Int64toInt32(listManager:getSize())
  for listIndex = 0, listSize - 1 do
    local contentsKey = self._ui._lst_myGoods:getKeyByIndex(listIndex)
    self:selectGoods(contentsKey, false)
  end
  self:onSelectGoodsListContents()
end
function PaGlobal_RewardMarket:unselectAll()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  self._selectGoodsList = nil
  self:onSelectGoodsListContents()
end
function PaGlobal_RewardMarket:showRewardControl()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  if self._rewardItemList == nil or self._rewardItemList:length() == 0 then
    self:hideRewardControl()
    return
  end
  if self._rewardItemSlotList == nil then
    self._rewardItemSlotList = Array.new()
  end
  for _, value in pairs(self._rewardItemSlotList) do
    if value ~= nil then
      value.slotControl:SetShow(false)
      value.itemSlot:clearItem()
      value.itemSlot.icon:addInputEvent("Mouse_On", "")
      value.itemSlot.icon:addInputEvent("Mouse_Out", "")
    end
  end
  local rewardItemSlotIndex = 0
  local lastSpanY = 0
  for key, value in pairs(self._rewardItemList) do
    local rewardItemSSW = getItemEnchantStaticStatus(value._itemKey)
    local rewardItemCount_s64 = value._count_s64
    if self._rewardItemSlotList[rewardItemSlotIndex] == nil then
      self._rewardItemSlotList[rewardItemSlotIndex] = self:makeRewardItemIcon(self._ui._frmContent_reward, "Static_RewardMarket_RewardIcon_" .. rewardItemSlotIndex, rewardItemSlotIndex)
    end
    self._rewardItemSlotList[rewardItemSlotIndex].slotControl:SetShow(true)
    self._rewardItemSlotList[rewardItemSlotIndex].itemSlot:setItemByStaticStatus(rewardItemSSW, rewardItemCount_s64)
    self._rewardItemSlotList[rewardItemSlotIndex].itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_RewardMarket_ItemRewardToolTip(true," .. tostring(key) .. "," .. tostring(rewardItemSlotIndex) .. ")")
    self._rewardItemSlotList[rewardItemSlotIndex].itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_RewardMarket_ItemRewardToolTip(false)")
    lastSpanY = self._rewardItemSlotList[rewardItemSlotIndex].slotControl:GetSpanSize().y
    rewardItemSlotIndex = rewardItemSlotIndex + 1
  end
  local rewardSlotListSizeY = lastSpanY + self._ui._stc_rewardTemplate:GetSizeY() + 5
  self._ui._frmContent_reward:SetSize(self._ui._frmContent_reward:GetSizeX(), rewardSlotListSizeY)
  local frameVScroll = self._ui._frm_reward:GetVScroll()
  frameVScroll:SetControlPos(0)
  self._ui._frm_reward:UpdateContentPos()
  if self._ui._frm_reward:GetSizeY() < self._ui._frmContent_reward:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
  self._ui._stc_rewardArea:SetShow(true)
end
function PaGlobal_RewardMarket:hideRewardControl()
  if Panel_Window_RewardMarket_All == nil then
    return
  end
  self._ui._stc_rewardArea:SetShow(false)
end
function PaGlobal_RewardMarket:makeRewardItemIcon(parent, newIconName, iconIndex)
  if Panel_Window_RewardMarket_All == nil then
    return nil
  end
  local cloneTemplate = UI.cloneControl(self._ui._stc_rewardTemplate, parent, newIconName)
  local newIconData = {slotControl = nil, itemSlot = nil}
  local newItemSlot = {}
  SlotItem.new(newItemSlot, "Icon_ItemSlot_", 0, cloneTemplate, self._itemSlotConfing)
  newItemSlot:createChild()
  newItemSlot:clearItem()
  newItemSlot.icon:SetPosX(0)
  newItemSlot.icon:SetPosY(0)
  newItemSlot.icon:SetSize(44, 44)
  newItemSlot.icon:SetHorizonLeft()
  newItemSlot.icon:SetVerticalTop()
  newIconData.slotControl = cloneTemplate
  newIconData.itemSlot = newItemSlot
  local validRowSizeX = self._ui._frm_reward:GetVScroll():GetPosX()
  local iconRowMaxCount = math.floor(validRowSizeX / self._ui._stc_rewardTemplate:GetSizeX()) - 1
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 10
  local iconTermSpanXY = 5
  newIconData.slotControl:SetSpanSize(beginSpanX + (newIconData.slotControl:GetSizeX() + iconTermSpanXY) * colIndex, self._ui._stc_rewardTemplate:GetSpanSize().y + (newIconData.slotControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
