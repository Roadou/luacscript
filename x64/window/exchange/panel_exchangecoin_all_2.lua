function PaGlobalFunc_ExchangeCoin_All_Open()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  if PaGlobal_ExchangeCoin_All == nil then
    return
  end
  PaGlobal_ExchangeCoin_All:prepareOpen()
end
function PaGlobalFunc_ExchangeCoin_All_Close()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ExchangeCoin_All_ExchangeCoinWithReward()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if _ContentsGroup_ExchangeCoinSystem == false then
    return
  end
  if self._msgBoxExchangeCount == nil then
    self._msgBoxExchangeCount = 1
  end
  ToClient_ExchangeCoinWithRewardItem(self._msgBoxCoinItemKey, Int64toInt32(self._msgBoxExchangeNo), self._msgBoxExchangeCount)
  if self._isConsole == true then
    ToClient_padSnapSetTargetGroup(self._ui.frame_exchangeList)
  end
end
function PaGlobalFunc_ExchangeCoin_All_ClearMsgBoxVariables()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  self._msgBoxCoinItemKey = nil
  self._msgBoxExchangeNo = nil
  self._msgBoxExchangeCount = nil
  if self._isConsole == true then
    ToClient_padSnapSetTargetGroup(self._ui.frame_exchangeList)
  end
end
function PaGlobalFunc_ExchangeCoin_All_PadSnapToSelectedCoin()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if self._selectedCoinItemKey == nil then
    return
  end
  for index = 1, #self._finalSortedCoinList do
    if self._finalSortedCoinList[index]:getItemKey() == self._selectedCoinItemKey then
      local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
      local colIdx = index - self._config.COIN_GRID_COLUMN * rowIdx
      local list2Size = self._ui.list2_moneyList:getChildContentListSize()
      local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
      local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
      ToClient_padSnapChangeToTarget(rdoBG)
      return
    end
  end
  ToClient_padSnapSetTargetGroup(self._ui.list2_moneyList)
end
function PaGlobalFunc_ExchangeCoin_All_OnScreenResize()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  if Panel_ExchangeCoin_All:GetShow() == true then
    PaGlobalFunc_ExchangeCoin_All_Close()
    PaGlobalFunc_ExchangeCoin_All_Open()
  end
end
function PaGlobalFunc_ExchangeCoin_All_setSearchText_Console(str)
  PaGlobal_ExchangeCoin_All._ui.edit_searchText:SetEditText(str)
  ClearFocusEdit()
  HandleEventLDown_ExchangeCoin_SearchRewards()
end
function FromClient_Exchange_All_CoinList2Update(content, key)
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local rowIdx = Int64toInt32(key)
  local drawCount = #self._finalSortedCoinList - self._config.COIN_GRID_COLUMN * (rowIdx - 1)
  if drawCount > 3 then
    drawCount = 3
  end
  for colIdx = 1, self._config.COIN_GRID_COLUMN do
    local rdoBtn = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
    if colIdx <= drawCount then
      local coinListIdx = colIdx + self._config.COIN_GRID_COLUMN * (rowIdx - 1)
      local coinItemEnchantKey = self._finalSortedCoinList[coinListIdx]
      local coinItemKey = coinItemEnchantKey:getItemKey()
      local coinItemSSW = getItemEnchantStaticStatus(coinItemEnchantKey)
      local coinItemGrade = coinItemSSW:getGradeType()
      local coinCount = ToClient_getCoinCount(coinItemKey)
      local coinIsSealed = ToClient_isSealedCoin(coinItemKey)
      local itemBG = UI.getChildControl(rdoBtn, "Static_ItemBG")
      local itemName = UI.getChildControl(rdoBtn, "StaticText_ItemName")
      local checkBox = UI.getChildControl(rdoBtn, "CheckButton_Favorite")
      local item = UI.getChildControl(itemBG, "Static_Item")
      local itemSlot = {}
      SlotItem.reInclude(itemSlot, "CoinItemSlot", 0, item, self._slotConfig)
      itemSlot:clearItem()
      itemSlot:setItemByStaticStatus(coinItemSSW, coinCount)
      itemSlot.icon:SetPosX(0)
      itemSlot.icon:SetPosY(0)
      itemSlot.icon:SetSize(item:GetSizeX(), item:GetSizeY())
      itemSlot.icon:SetShow(true)
      itemSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectCoin(" .. tostring(coinItemKey) .. ")")
      if self._isConsole == true then
        rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_ExchangeCoin_Tooltip(" .. tostring(coinListIdx) .. "," .. tostring(coinItemKey) .. ")")
        rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventYUp_ExchangeCoin_BookmarkCoin(" .. tostring(coinListIdx) .. "," .. tostring(coinItemKey) .. ")")
        rdoBtn:addInputEvent("Mouse_On", "HandleEventMouseOn_ExchangeCoin_LoadInfo(" .. tostring(coinListIdx) .. "," .. tostring(coinItemKey) .. ")")
      else
        itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Tooltip(" .. tostring(coinListIdx) .. "," .. tostring(coinItemKey) .. ",false)")
        itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Tooltip(" .. tostring(coinListIdx) .. "," .. tostring(coinItemKey) .. ",true)")
      end
      checkBox:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_BookmarkCoin(" .. tostring(coinItemKey) .. ")")
      checkBox:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Bookmark_Tooltip(" .. tostring(coinListIdx) .. ", true)")
      checkBox:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Bookmark_Tooltip(" .. tostring(coinListIdx) .. ", false)")
      checkBox:SetCheck(ToClient_isBookmarkCoin(coinItemKey))
      itemName:SetScale(1, 1)
      itemName:SetTextMode(__eTextMode_AutoWrap)
      itemName:setLineCountByLimitAutoWrap(4)
      itemName:SetShow(true)
      itemName:SetText(coinItemSSW:getName())
      PAGlobalFunc_SetItemTextColor(itemName, coinItemSSW)
      itemName:SetScale(self._scale, self._scale)
      rdoBtn:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectCoin(" .. tostring(coinItemKey) .. ")")
      rdoBtn:SetShow(true)
      rdoBtn:SetIgnore(false)
      if coinItemKey == self._selectedCoinItemKey then
        rdoBtn:ChangeTextureInfoTextureIDAsync("Combine_Etc_Goods_Management_ItemList_BG_Select", 0)
      else
        rdoBtn:ChangeTextureInfoTextureIDAsync("Combine_Etc_Goods_Management_ItemList_BG_None", 0)
      end
      rdoBtn:setRenderTexture(rdoBtn:getBaseTexture())
      table.insert(self._coinControlList, rdoBtn)
    else
      rdoBtn:SetShow(false)
    end
  end
end
function FromClient_UpdateCoinAndHistory()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if self._selectedCoinItemKey == nil then
    return
  end
  self._coinListToIndex = self._ui.list2_moneyList:getCurrenttoIndex()
  self:filterCoinList()
  self:reloadCoinList()
  self._ui.list2_moneyList:moveIndex(self._coinListToIndex)
  self._ui.txt_hasCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_HASITEMCOUNT", "count", makeDotMoney(ToClient_getCoinCount(self._selectedCoinItemKey))))
  self:loadExchangeInfo(true)
end
function FromClient_ExchangeRewardSuccess()
end
function RewardList_ScrollEvent(isDown)
  local self = PaGlobal_ExchangeCoin_All
  if isDown then
    self._ui.frame_1_verticalScroll:ControlButtonDown()
  else
    self._ui.frame_1_verticalScroll:ControlButtonUp()
  end
  self._ui.frame_exchangeList:UpdateContentScroll()
end
function HandleEventLUp_ExchangeCoin_DoExchangeReward(coinItemKey, exchangeNo, maxCount)
  Panel_NumberPad_Show(true, toInt64(0, maxCount), coinItemKey, HandleEventLUp_ExchangeCoin_ShowMessageBox, nil, exchangeNo)
end
function HandleEventLUp_ExchangeCoin_Tooltip(index, itemKey, isHide)
  local self = PaGlobal_ExchangeCoin_All
  if isHide == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
  local colIdx = index - 3 * rowIdx
  local list2Size = self._ui.list2_moneyList:getChildContentListSize()
  local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
  local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
  local itemBG = UI.getChildControl(rdoBG, "Static_ItemBG")
  local item = UI.getChildControl(itemBG, "Static_Item")
  local slot = {}
  SlotItem.reInclude(slot, "CoinItemSlot", 0, item, self._slotConfig)
  local itemEnchantKey = ItemEnchantKey(itemKey, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, slot.icon, true, false)
end
function HandleEventLUp_ExchangeCoin_SelectedCoin_Tooltip(itemKey, isShow)
  local self = PaGlobal_ExchangeCoin_All
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemEnchantKey = ItemEnchantKey(itemKey, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, self._selectedCoinSlot.icon, true, false)
end
function HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(sectionIdx, rewardIdx, coinItemKey, isShow)
  local self = PaGlobal_ExchangeCoin_All
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rewardTable, itemWrapper
  if sectionIdx == 0 then
    rewardTable = self._familyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
  elseif sectionIdx == 1 then
    rewardTable = self._weeklyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
  elseif sectionIdx == 2 then
    rewardTable = self._dailyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
  elseif sectionIdx == 3 then
    rewardTable = self._alwaysRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, rewardTable.stc_itemSlot.icon, true, false)
end
function HandleEventLUp_ExchangeCoin_ShowMessageBox(exchangeCount, coinItemKey, rewardExchangeNo)
  local coinItemEnchantKey = ItemEnchantKey(coinItemKey, 0)
  local coinItemSSW = getItemEnchantStaticStatus(coinItemEnchantKey)
  local rewardItemWrapper = ToClient_getRewardItemWrapperByExchangeNo(coinItemKey, rewardExchangeNo)
  local rewardItemEnchantKey = rewardItemWrapper:get():getKey()
  local rewardItemCount = rewardItemWrapper:getCount()
  local coinNeedCount = ToClient_getNeedCoinCountByExchangeNo(coinItemKey, rewardExchangeNo) * tonumber(tostring(exchangeCount))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_POPUP_TITLE"),
    content = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_POPUP_DESC", "coinItemName", tostring(FGlobal_ChangeItemNameColorByGrade(coinItemEnchantKey)), "coinNeedCount", tostring(coinNeedCount), "rewardItemName", tostring(FGlobal_ChangeItemNameColorByGrade(rewardItemEnchantKey)), "exchangeCount", tostring(exchangeCount * rewardItemCount)),
    functionYes = PaGlobalFunc_ExchangeCoin_All_ExchangeCoinWithReward,
    functionNo = PaGlobalFunc_ExchangeCoin_All_ClearMsgBoxVariables,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  PaGlobal_ExchangeCoin_All._msgBoxCoinItemKey = coinItemKey
  PaGlobal_ExchangeCoin_All._msgBoxExchangeNo = rewardExchangeNo
  PaGlobal_ExchangeCoin_All._msgBoxExchangeCount = exchangeCount
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLDown_ExchangeCoin_SearchRewards()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil or self._selectedCoinItemKey == nil then
    return
  end
  if CheckChattingInput() == false then
    ClearFocusEdit()
  end
  self._filterText = self._ui.edit_searchText:GetEditText()
  if self._filterText == "" then
    self:resetSearch()
  else
    self:filterCoinList()
    self:reloadCoinList()
    self:loadExchangeInfo(true)
    self:toggleSearchButton(true)
    if #self._finalSortedCoinList ~= 0 then
      self:selectCoin(self._finalSortedCoinList[1]:getItemKey())
    end
  end
end
function HandleEventMLUp_ExchangeCoin_SetFoucsEdit()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  SetFocusEdit(self._ui.edit_searchText)
  if self._filterText == "" then
    self._ui.edit_searchText:SetEditText("")
  end
end
function HandleEventLUp_ExchangeCoin_Category_Tooltip(index, isShow)
  local self = PaGlobal_ExchangeCoin_All
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local uiControl
  local name = ""
  local desc = ""
  if index == self._eCatergoryTabOrder.ALL then
    uiControl = self._ui.rdo_tabMenu
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_ALL")
  elseif index == self._eCatergoryTabOrder.SEASON then
    uiControl = self._ui.rdo_tabSeason
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_SEASON")
  elseif index == self._eCatergoryTabOrder.EVENT then
    uiControl = self._ui.rdo_tabEvent
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_EVENT")
  elseif index == self._eCatergoryTabOrder.CONTENTS then
    uiControl = self._ui.rdo_tabContents
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_CONTENTS")
  elseif index == self._eCatergoryTabOrder.BOOKMARK then
    uiControl = self._ui.rdo_tabBookmark
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_BOOKMARK")
  elseif index == self._eCatergoryTabOrder.BOSSREWARD then
    uiControl = self._ui.rdo_tabBossReward
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_BOSSREWARD")
  elseif index == self._eCatergoryTabOrder.LINEUP then
    uiControl = self._ui.btn_toggleLineUp
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_LINEUP")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_LINEUP_DESC")
  elseif index == self._eCatergoryTabOrder.FILTER then
    uiControl = self._ui.btn_toggleFilter
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_FILTER")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_FILTER_DESC")
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventLBDown_ExchangeCoin_SelectTab()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if self._selectedCategoryIndex == self._eCatergoryTabOrder.ALL then
    PaGlobal_ExchangeCoin_All:selectTab(self._eCatergoryTabOrder.BOOKMARK)
  else
    PaGlobal_ExchangeCoin_All:selectTab(self._selectedCategoryIndex - 1)
  end
end
function HandleEventRBDown_ExchangeCoin_SelectTab()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if self._selectedCategoryIndex == self._eCatergoryTabOrder.BOOKMARK then
    PaGlobal_ExchangeCoin_All:selectTab(self._eCatergoryTabOrder.ALL)
  else
    PaGlobal_ExchangeCoin_All:selectTab(self._selectedCategoryIndex + 1)
  end
end
function HandleEventXUp_ExchangeCoin_ToggleRewardToolTipConsole(sectionIdx, rewardIdx, coinItemKey)
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if Panel_Widget_Tooltip_Renew:GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rewardTable, itemWrapper
  if sectionIdx == 0 then
    rewardTable = self._familyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
  elseif sectionIdx == 1 then
    rewardTable = self._weeklyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
  elseif sectionIdx == 2 then
    rewardTable = self._dailyRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
  elseif sectionIdx == 3 then
    rewardTable = self._alwaysRewardControl[coinItemKey][rewardIdx]
    itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, rewardTable.stc_itemSlot.icon, true, false)
  end
end
function HandleEventXUp_ExchangeCoin_Tooltip(index, itemKey)
  local self = PaGlobal_ExchangeCoin_All
  if Panel_Widget_Tooltip_Renew:GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
  local colIdx = index - 3 * rowIdx
  local list2Size = self._ui.list2_moneyList:getChildContentListSize()
  local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
  local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
  local itemBG = UI.getChildControl(rdoBG, "Static_ItemBG")
  local item = UI.getChildControl(itemBG, "Static_Item")
  local slot = {}
  SlotItem.reInclude(slot, "CoinItemSlot", 0, item, self._slotConfig)
  local itemEnchantKey = ItemEnchantKey(itemKey, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, slot.icon, true, false)
  end
end
function HandleEventLUp_ExchangeCoin_BookmarkCoin(itemKey)
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  if ToClient_isBookmarkCoin(itemKey) == true then
    ToClient_deleteBookmarkCoin(itemKey)
  else
    ToClient_insertBookmarkCoin(itemKey)
  end
  PaGlobal_ExchangeCoin_All:sortBookmarkedCoin()
end
function HandleEventYUp_ExchangeCoin_BookmarkCoin(index, itemKey)
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local isBookmark = ToClient_isBookmarkCoin(itemKey)
  if isBookmark == true then
    ToClient_deleteBookmarkCoin(itemKey)
  else
    ToClient_insertBookmarkCoin(itemKey)
  end
  PaGlobal_ExchangeCoin_All:sortBookmarkedCoin()
  local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
  local colIdx = index - 3 * rowIdx
  local list2Size = self._ui.list2_moneyList:getChildContentListSize()
  local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
  if content == nil then
    return
  end
  local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
  if rdoBG == nil then
    return
  end
  local uiControl = UI.getChildControl(rdoBG, "CheckButton_Favorite")
  if uiControl == nil then
    return
  end
  uiControl:SetCheck(not isBookmark)
end
function HandleEventLUp_ExchangeCoin_Bookmark_Tooltip(index, isShow)
  local self = PaGlobal_ExchangeCoin_All
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
  local colIdx = index - 3 * rowIdx
  local list2Size = self._ui.list2_moneyList:getChildContentListSize()
  local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
  if content == nil then
    return
  end
  local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
  if rdoBG == nil then
    return
  end
  local uiControl = UI.getChildControl(rdoBG, "CheckButton_Favorite")
  if uiControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_BOOKMARK")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_FAVORITE_TOOLTIP_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventMouseOn_ExchangeCoin_LoadInfo(index, coinItemKey)
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local rowIdx = math.floor((index - 1) / self._config.COIN_GRID_COLUMN)
  local colIdx = index - 3 * rowIdx
  local list2Size = self._ui.list2_moneyList:getChildContentListSize()
  local content = UI.getChildControl(self._ui.list2_moneyList, "List2_MoneyList_Content_" .. tostring(rowIdx % list2Size))
  if content == nil then
    return
  end
  local rdoBG = UI.getChildControl(content, "Radiobutton_MoneyBG_" .. tostring(colIdx))
  if rdoBG == nil then
    return
  end
  local uiControl = UI.getChildControl(rdoBG, "CheckButton_Favorite")
  if uiControl == nil then
    return
  end
  uiControl:SetCheck(ToClient_isBookmarkCoin(coinItemKey))
end
function PaGlobalFunc_ExchangeCoin_All_ToggleLineUp()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local isLineUpChecked = self._ui.btn_toggleLineUp:IsCheck()
  self._isToggleLineUp = isLineUpChecked
  PaGlobal_ExchangeCoin_All:filterCoinList()
  PaGlobal_ExchangeCoin_All:reloadCoinList()
end
function PaGlobalFunc_ExchangeCoin_All_ToggleFilter()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local isFilterChecked = self._ui.btn_toggleFilter:IsCheck()
  self._isToggleFilter = isFilterChecked
  PaGlobal_ExchangeCoin_All:filterCoinList()
  PaGlobal_ExchangeCoin_All:reloadCoinList()
end
function HandleEventLUp_ExchangeCoin_ToggleLineUp()
  PaGlobalFunc_ExchangeCoin_All_ToggleLineUp()
end
function HandleEventLUp_ExchangeCoin_ToggleFilter()
  PaGlobalFunc_ExchangeCoin_All_ToggleFilter()
end
function HandleEventLSClick_ExchangeCoin_ToggleLineUp()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local isChecked = self._ui.btn_toggleLineUp:IsCheck()
  self._ui.btn_toggleLineUp:SetCheck(not isChecked)
  PaGlobalFunc_ExchangeCoin_All_ToggleLineUp()
end
function HandleEventRSClick_ExchangeCoin_ToggleFilter()
  local self = PaGlobal_ExchangeCoin_All
  if self == nil then
    return
  end
  local isChecked = self._ui.btn_toggleFilter:IsCheck()
  self._ui.btn_toggleFilter:SetCheck(not isChecked)
  PaGlobalFunc_ExchangeCoin_All_ToggleFilter()
end
