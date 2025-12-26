function PaGlobal_ExchangeCoin_All:initialize()
  if _ContentsGroup_ExchangeCoinSystem == false then
    return
  end
  if self._initialize == true then
    return
  end
  self._isConsole = ToClient_isUsePadSnapping()
  self:initControl()
  self:createSelectedCoinSlot()
  self:registEventHandler()
  self._isToggleFilter = false
  self._isToggleLineUp = false
  self._coinControlList = {}
  self:sortBookmarkedCoin()
  self:selectTab(0)
  self:createFrameControl()
  self:toggleSearchButton(false)
  self:validate()
  self._initialize = true
end
function PaGlobal_ExchangeCoin_All:initControl()
  self._ui.stc_static1 = UI.getChildControl(Panel_ExchangeCoin_All, "Static_1")
  self._ui.stc_sizeFix = UI.getChildControl(Panel_ExchangeCoin_All, "Static_SizeFix")
  self._ui.stc_listArea = UI.getChildControl(self._ui.stc_sizeFix, "Static_ListArea")
  self._ui.stc_tabArea = UI.getChildControl(self._ui.stc_listArea, "Static_TabArea")
  self._ui.rdo_tabMenu = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_Tab1")
  self._ui.rdo_tabSeason = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_Tab2")
  self._ui.rdo_tabEvent = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_Tab3")
  self._ui.rdo_tabContents = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_Tab4")
  self._ui.rdo_tabBossReward = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_Tab5")
  self._ui.rdo_tabBookmark = UI.getChildControl(self._ui.stc_tabArea, "RadioButton_TabBookmark")
  self._ui.btn_toggleFilter = UI.getChildControl(self._ui.stc_tabArea, "CheckButton_Filter")
  self._ui.btn_toggleLineUp = UI.getChildControl(self._ui.stc_tabArea, "CheckButton_LineUp")
  self._ui.stc_keyGuide_LB = UI.getChildControl(self._ui.stc_tabArea, "Static_KeyGuide_LB_ConsoleUI")
  self._ui.stc_keyGuide_RB = UI.getChildControl(self._ui.stc_tabArea, "Static_KeyGuide_RB_ConsoleUI")
  self._ui.stc_keyGuide_LSClick = UI.getChildControl(self._ui.stc_tabArea, "Static_KeyGuide_LSClick_ConsoleUI")
  self._ui.stc_keyGuide_RSClick = UI.getChildControl(self._ui.stc_tabArea, "Static_KeyGuide_RSClick_ConsoleUI")
  self._ui.stc_filterBG = UI.getChildControl(self._ui.stc_listArea, "Static_BG")
  self._ui.stc_tabSelect = UI.getChildControl(self._ui.stc_listArea, "Static_TabSelect")
  self._ui.stc_tabName = UI.getChildControl(self._ui.stc_listArea, "StaticText_1")
  self._ui.list2_moneyList = UI.getChildControl(self._ui.stc_listArea, "List2_MoneyList")
  self._ui.scroll_vertical = UI.getChildControl(self._ui.list2_moneyList, "List2_VerticalScroll")
  self._ui.scroll_horizontal = UI.getChildControl(self._ui.list2_moneyList, "List2_1_HorizontalScroll")
  self._ui.edit_searchText = UI.getChildControl(self._ui.stc_listArea, "Edit_SearchText")
  self._ui.btn_search = UI.getChildControl(self._ui.edit_searchText, "Button_Search")
  self._ui.stc_LT_X = UI.getChildControl(self._ui.edit_searchText, "StaticText_LT_X_ConsoleUI")
  self._ui.btn_reset = UI.getChildControl(self._ui.edit_searchText, "Button_Reset")
  self._ui.stc_infoArea = UI.getChildControl(self._ui.stc_sizeFix, "Static_InfoArea")
  self._ui.stc_itemBG = UI.getChildControl(self._ui.stc_infoArea, "Static_ItemBG")
  self._ui.stc_item = UI.getChildControl(self._ui.stc_itemBG, "Static_Item")
  self._ui.txt_itemName = UI.getChildControl(self._ui.stc_infoArea, "StaticText_ItemName")
  self._ui.txt_hasCount = UI.getChildControl(self._ui.stc_infoArea, "StaticText_HasItemCount")
  self._ui.txt_itemDesc = UI.getChildControl(self._ui.stc_infoArea, "StaticText_ItemDesc")
  self._ui.txt_exchangeTitle = UI.getChildControl(self._ui.stc_infoArea, "StaticText_ExchangeTitle")
  self._ui.stc_lineDeco_t = UI.getChildControl(self._ui.stc_infoArea, "Static_LineDeco_T")
  self._ui.stc_lineDeco_b = UI.getChildControl(self._ui.stc_infoArea, "Static_LineDeco_B")
  self._ui.frame_exchangeList = UI.getChildControl(self._ui.stc_infoArea, "Frame_ExchangeList")
  self._ui.frame_1_content = UI.getChildControl(self._ui.frame_exchangeList, "Frame_1_Content")
  self._ui.stc_familyExchange = UI.getChildControl(self._ui.frame_1_content, "Static_FamilyExchange")
  self._ui.stc_weeklyExchange = UI.getChildControl(self._ui.frame_1_content, "Static_WeeklyExchange")
  self._ui.stc_dailyExchange = UI.getChildControl(self._ui.frame_1_content, "Static_DailyExchange")
  self._ui.stc_alwaysExchange = UI.getChildControl(self._ui.frame_1_content, "Static_AlwaysExchange")
  self._ui.stc_template = UI.getChildControl(self._ui.frame_1_content, "Static_Template")
  self._ui.frame_1_verticalScroll = UI.getChildControl(self._ui.frame_exchangeList, "Frame_1_VerticalScroll")
  self._ui.frame_1_horizontalScroll = UI.getChildControl(self._ui.frame_exchangeList, "Frame_1_HorizontalScroll")
  self._ui.stc_KeyGuide_Console = UI.getChildControl(self._ui.stc_infoArea, "Static_KeyGuide_ConsoleUI_Import")
  self._ui.stc_consoleB = UI.getChildControl(self._ui.stc_KeyGuide_Console, "StaticText_B_ConsoleUI")
  self._ui.stc_consoleA = UI.getChildControl(self._ui.stc_KeyGuide_Console, "StaticText_A_ConsoleUI")
  self._ui.stc_consoleX = UI.getChildControl(self._ui.stc_KeyGuide_Console, "StaticText_X_ConsoleUI")
  self._ui.stc_consoleY = UI.getChildControl(self._ui.stc_KeyGuide_Console, "StaticText_Y_ConsoleUI")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_sizeFix, "Button_Close")
  self._ui.stc_template:SetShow(false)
  self._ui.btn_reset:SetShow(false)
  local list2Content = UI.getChildControl(self._ui.list2_moneyList, "List2_1_Content")
  local rdoBtn_1 = UI.getChildControl(list2Content, "Radiobutton_MoneyBG_1")
  local itemBG_1 = UI.getChildControl(rdoBtn_1, "Static_ItemBG")
  local item_1 = UI.getChildControl(itemBG_1, "Static_Item")
  local itemSlot = {}
  SlotItem.new(itemSlot, "CoinItemSlot", 0, item_1, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetSize(item_1:GetSizeX(), item_1:GetSizeY())
  local rdoBtn_2 = UI.getChildControl(list2Content, "Radiobutton_MoneyBG_2")
  local itemBG_2 = UI.getChildControl(rdoBtn_2, "Static_ItemBG")
  local item_2 = UI.getChildControl(itemBG_2, "Static_Item")
  local itemSlot = {}
  SlotItem.new(itemSlot, "CoinItemSlot", 0, item_2, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetSize(item_1:GetSizeX(), item_1:GetSizeY())
  local rdoBtn_3 = UI.getChildControl(list2Content, "Radiobutton_MoneyBG_3")
  local itemBG_3 = UI.getChildControl(rdoBtn_3, "Static_ItemBG")
  local item_3 = UI.getChildControl(itemBG_3, "Static_Item")
  local itemSlot = {}
  SlotItem.new(itemSlot, "CoinItemSlot", 0, item_3, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetSize(item_1:GetSizeX(), item_1:GetSizeY())
  if self._isConsole == true then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_search:SetShow(false)
    self._ui.stc_LT_X:SetShow(true)
    self._ui.stc_KeyGuide_Console:SetShow(true)
    self._ui.stc_consoleX:SetShow(true)
    self._ui.stc_consoleA:SetShow(true)
    self._ui.stc_consoleB:SetShow(true)
    self._ui.stc_consoleY:SetShow(true)
    self._ui.stc_keyGuide_LB:SetShow(true)
    self._ui.stc_keyGuide_RB:SetShow(true)
    self._ui.stc_keyGuide_LSClick:SetShow(true)
    self._ui.stc_keyGuide_RSClick:SetShow(true)
    self._ui.rdo_tabMenu:SetSpanSize(53, 0)
    self._ui.rdo_tabSeason:SetSpanSize(101, 0)
    self._ui.rdo_tabEvent:SetSpanSize(149, 0)
    self._ui.rdo_tabContents:SetSpanSize(197, 0)
    self._ui.rdo_tabBossReward:SetSpanSize(245, 0)
    self._ui.rdo_tabBookmark:SetSpanSize(293, 0)
    self._ui.btn_toggleFilter:SetSpanSize(100, 0)
    self._ui.btn_toggleLineUp:SetSpanSize(149, 0)
    self._ui.stc_filterBG:SetSpanSize(40, 0)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_search:SetShow(true)
    self._ui.stc_LT_X:SetShow(false)
    self._ui.stc_KeyGuide_Console:SetShow(false)
    self._ui.stc_consoleX:SetShow(false)
    self._ui.stc_consoleA:SetShow(false)
    self._ui.stc_consoleB:SetShow(false)
    self._ui.stc_consoleY:SetShow(false)
    self._ui.stc_keyGuide_LB:SetShow(false)
    self._ui.stc_keyGuide_RB:SetShow(false)
  end
  if _ContentsGroup_MorningLandTierParty == false then
    self._ui.rdo_tabBossReward:SetShow(false)
    self._ui.rdo_tabBookmark:SetSpanSize(245, 0)
    self._eCatergoryTabOrder.BOOKMARK = 4
    self._eCatergoryTabOrder.COUNT = 5
    self._eCatergoryTabOrder.BOSSREWARD = -1
  end
end
function PaGlobal_ExchangeCoin_All:validate()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  self._ui.stc_sizeFix:isValidate()
  self._ui.stc_listArea:isValidate()
  self._ui.stc_tabArea:isValidate()
  self._ui.rdo_tabMenu:isValidate()
  self._ui.rdo_tabSeason:isValidate()
  self._ui.rdo_tabEvent:isValidate()
  self._ui.rdo_tabContents:isValidate()
  self._ui.rdo_tabBossReward:isValidate()
  self._ui.rdo_tabBookmark:isValidate()
  self._ui.stc_keyGuide_LB:isValidate()
  self._ui.stc_keyGuide_RB:isValidate()
  self._ui.stc_tabSelect:isValidate()
  self._ui.list2_moneyList:isValidate()
  self._ui.scroll_vertical:isValidate()
  self._ui.scroll_horizontal:isValidate()
  self._ui.stc_infoArea:isValidate()
  self._ui.stc_itemBG:isValidate()
  self._ui.stc_item:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.txt_hasCount:isValidate()
  self._ui.txt_itemDesc:isValidate()
  self._ui.txt_exchangeTitle:isValidate()
  self._ui.edit_searchText:isValidate()
  self._ui.btn_search:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.stc_lineDeco_t:isValidate()
  self._ui.stc_lineDeco_b:isValidate()
  self._ui.frame_exchangeList:isValidate()
  self._ui.frame_1_content:isValidate()
  self._ui.stc_familyExchange:isValidate()
  self._ui.stc_weeklyExchange:isValidate()
  self._ui.stc_template:isValidate()
  self._ui.frame_1_verticalScroll:isValidate()
  self._ui.frame_1_horizontalScroll:isValidate()
  self._ui.stc_KeyGuide_Console:isValidate()
  self._ui.stc_consoleB:isValidate()
  self._ui.stc_consoleA:isValidate()
  self._ui.stc_consoleX:isValidate()
  self._ui.stc_consoleY:isValidate()
  self._ui.btn_close:isValidate()
end
function PaGlobal_ExchangeCoin_All:registEventHandler()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  registerEvent("FromClient_PadSnapChangeTarget", "PaGlobal_ExchangeCoin_All:hideTooltip()")
  registerEvent("FromClient_UpdateCoinAndHistory", "FromClient_UpdateCoinAndHistory")
  registerEvent("FromClient_ExchangeRewardSuccess", "FromClient_ExchangeRewardSuccess")
  registerEvent("onScreenResize", "PaGlobalFunc_ExchangeCoin_All_OnScreenResize()")
  self._ui.list2_moneyList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Exchange_All_CoinList2Update")
  self._ui.list2_moneyList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.rdo_tabMenu:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.ALL .. ")")
  self._ui.rdo_tabMenu:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.ALL .. ", true)")
  self._ui.rdo_tabMenu:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.ALL .. ", false)")
  self._ui.rdo_tabSeason:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.SEASON .. ")")
  self._ui.rdo_tabSeason:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.SEASON .. ", true)")
  self._ui.rdo_tabSeason:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.SEASON .. ", false)")
  self._ui.rdo_tabEvent:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.EVENT .. ")")
  self._ui.rdo_tabEvent:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.EVENT .. ", true)")
  self._ui.rdo_tabEvent:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.EVENT .. ", false)")
  self._ui.rdo_tabContents:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.CONTENTS .. ")")
  self._ui.rdo_tabContents:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.CONTENTS .. ", true)")
  self._ui.rdo_tabContents:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.CONTENTS .. ", false)")
  self._ui.rdo_tabBookmark:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.BOOKMARK .. ")")
  self._ui.rdo_tabBookmark:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.BOOKMARK .. ", true)")
  self._ui.rdo_tabBookmark:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.BOOKMARK .. ", false)")
  self._ui.rdo_tabBossReward:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:selectTab(" .. self._eCatergoryTabOrder.BOSSREWARD .. ")")
  self._ui.rdo_tabBossReward:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.BOSSREWARD .. ", true)")
  self._ui.rdo_tabBossReward:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.BOSSREWARD .. ", false)")
  self._ui.btn_toggleLineUp:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_ToggleLineUp()")
  self._ui.btn_toggleFilter:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_ToggleFilter()")
  self._ui.btn_toggleFilter:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.FILTER .. ", true)")
  self._ui.btn_toggleFilter:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.FILTER .. ", false)")
  self._ui.btn_toggleLineUp:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.LINEUP .. ", true)")
  self._ui.btn_toggleLineUp:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_Category_Tooltip(" .. self._eCatergoryTabOrder.LINEUP .. ", false)")
  self._ui.edit_searchText:addInputEvent("Mouse_LUp", "HandleEventMLUp_ExchangeCoin_SetFoucsEdit()")
  self._ui.edit_searchText:RegistReturnKeyEvent("HandleEventLDown_ExchangeCoin_SearchRewards()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "HandleEventLDown_ExchangeCoin_SearchRewards()")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeCoin_All:resetSearch()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExchangeCoin_All_Close()")
  if self._isConsole == true then
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBDown_ExchangeCoin_SelectTab()")
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventRBDown_ExchangeCoin_SelectTab()")
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventMLUp_ExchangeCoin_SetFoucsEdit()")
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLSClick_ExchangeCoin_ToggleLineUp()")
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventRSClick_ExchangeCoin_ToggleFilter()")
    Panel_ExchangeCoin_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobal_ExchangeCoin_All:DpadRightEvent()")
    self._ui.edit_searchText:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ExchangeCoin_All_setSearchText_Console")
    self._ui.edit_searchText:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLDown_ExchangeCoin_SearchRewards()")
  end
end
function PaGlobal_ExchangeCoin_All:prepareOpen()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  if _ContentsGroup_ExchangeCoinSystem == false then
    return
  end
  if ToClient_isPremiumCharacter() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseContentsPremiumCharacter"))
    return
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if Panel_Window_Dye_Palette_All ~= nil and Panel_Window_Dye_Palette_All:GetShow() == true then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif Panel_DyePalette ~= nil and Panel_DyePalette:GetShow() == true then
    FGlobal_DyePalette_Close()
  end
  if _ContentsGroup_StaticSlot == true then
    if Panel_Window_NewbieInventory_StaticSlot_All ~= nil and Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
      PaGlobalFunc_NewbieInventory_Close()
    end
  elseif Panel_Window_NewbieInventory_All ~= nil and Panel_Window_NewbieInventory_All:GetShow() == true then
    PaGlobalFunc_NewbieInventory_Close()
  end
  if self._selectedCategoryIndex == nil then
    self._selectedCategoryIndex = 0
  end
  self:resize()
  self:selectTab(self._selectedCategoryIndex)
  self:loadExchangeInfo(false)
  self:toggleSearchButton(false)
  self._ui.list2_moneyList:registEvent(__ePAUIList2EventType_LuaChangeContent, "")
  if #self._finalSortedCoinList ~= 0 then
    if self._selectedCoinItemKey ~= nil then
      self:selectCoin(self._selectedCoinItemKey)
    else
      self:selectCoin(self._finalSortedCoinList[1]:getItemKey())
    end
    if self._isConsole == true then
      local keyGuideList = Array.new()
      keyGuideList:push_back(self._ui.stc_consoleX)
      keyGuideList:push_back(self._ui.stc_consoleA)
      keyGuideList:push_back(self._ui.stc_consoleB)
      keyGuideList:push_back(self._ui.stc_consoleY)
      for key, control in pairs(keyGuideList) do
        if control ~= nil then
          control:SetShow(true)
        end
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_KeyGuide_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
      PaGlobalFunc_ExchangeCoin_All_PadSnapToSelectedCoin()
    end
  else
    if self._selectedCoinItemKey ~= nil then
      self:selectCoin(self._selectedCoinItemKey)
    end
    self._ui.frame_1_verticalScroll:SetShow(false)
  end
  self._ui.list2_moneyList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Exchange_All_CoinList2Update")
  self:open()
end
function PaGlobal_ExchangeCoin_All:open()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  Panel_ExchangeCoin_All:SetShow(true)
end
function PaGlobal_ExchangeCoin_All:prepareClose()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  self._ui.list2_moneyList:getElementManager():clearKey()
  self._filterText = ""
  PaGlobalFunc_ExchangeCoin_All_ClearMsgBoxVariables()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ExchangeCoin_All:close()
end
function PaGlobal_ExchangeCoin_All:close()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  Panel_ExchangeCoin_All:SetShow(false)
end
local stringMatching = function(dstString, filterString)
  local dstStringLower = string.lower(dstString)
  local filterStringLower = string.lower(filterString)
  return (stringSearch(dstStringLower, filterStringLower))
end
function PaGlobal_ExchangeCoin_All:sortBookmarkedCoin()
  self._bookmarkSortedCoinList = Array.new()
  local coinTotalCount = ToClient_getCountOfCoinList()
  local nonBookmarkedCoinList = Array.new()
  local bmIdx = 0
  for ii = 1, coinTotalCount do
    local coinItemEnchantKey = ToClient_getCoinItemEnchantKeyByIndex(ii - 1)
    local coinItemKey = coinItemEnchantKey:getItemKey()
    if ToClient_isBookmarkCoin(coinItemKey) == true then
      table.insert(self._bookmarkSortedCoinList, {
        key = coinItemEnchantKey,
        index = ii - 1,
        bookmarkOrder = bmIdx,
        isMarked = true
      })
      bmIdx = bmIdx + 1
    else
      table.insert(nonBookmarkedCoinList, {
        key = coinItemEnchantKey,
        index = ii - 1,
        bookmarkOrder = 0,
        isMarked = false
      })
    end
  end
  for ii = 1, #nonBookmarkedCoinList do
    nonBookmarkedCoinList[ii].bookmarkOrder = bmIdx
    self._bookmarkSortedCoinList:push_back(nonBookmarkedCoinList[ii])
    bmIdx = bmIdx + 1
  end
end
function PaGlobal_ExchangeCoin_All:filterCoinList()
  self._finalSortedCoinList = {}
  local coinCountList = {}
  local bookmarkOrderList = {}
  local markedList = {}
  local selectedCategory = 0
  if self._selectedCategoryIndex == self._eCatergoryTabOrder.SEASON then
    selectedCategory = __eExchangeCoinInfoCategory_Season
  elseif self._selectedCategoryIndex == self._eCatergoryTabOrder.EVENT then
    selectedCategory = __eExchangeCoinInfoCategory_Event
  elseif self._selectedCategoryIndex == self._eCatergoryTabOrder.CONTENTS then
    selectedCategory = __eExchangeCoinInfoCategory_Contents
  elseif self._selectedCategoryIndex == self._eCatergoryTabOrder.BOOKMARK then
    selectedCategory = __eExchangeCoinInfoCategory_Bookmark
  elseif self._selectedCategoryIndex == self._eCatergoryTabOrder.BOSSREWARD then
    selectedCategory = __eExchangeCoinInfoCategory_BossReward
  end
  for ii = 1, #self._bookmarkSortedCoinList do
    local coinIndex = self._bookmarkSortedCoinList[ii].index
    local coinItemEnchantKey = self._bookmarkSortedCoinList[ii].key
    local bookmarkOrder = self._bookmarkSortedCoinList[ii].bookmarkOrder
    local coinItemKey = coinItemEnchantKey:getItemKey()
    local coinCategory = ToClient_getCoinInfoCategoryByIndex(coinIndex)
    local rewardCount = ToClient_getCountOfRewardList(coinItemKey)
    local coinCount = ToClient_getCoinCount(coinItemKey)
    local isMatchReward = false
    local isMatchCategory = false
    local hasAnyCoinCount = false
    coinCountList[coinItemEnchantKey] = coinCount
    bookmarkOrderList[coinItemEnchantKey] = bookmarkOrder
    markedList[coinItemEnchantKey] = self._bookmarkSortedCoinList[ii].isMarked
    if self._filterText == "" or self._filterText == nil then
      isMatchReward = true
    else
      for jj = 1, rewardCount do
        local rewardItemWrapper = ToClient_getRewardItemWrapper(coinItemKey, jj - 1)
        local rewardItemEnchantSSW = rewardItemWrapper:getStaticStatus()
        local rewardName = tostring(rewardItemEnchantSSW:getName())
        if stringMatching(rewardName, self._filterText) == true then
          isMatchReward = true
        end
      end
    end
    if self._selectedCategoryIndex == self._eCatergoryTabOrder.ALL or coinCategory == selectedCategory then
      isMatchCategory = true
    elseif selectedCategory == __eExchangeCoinInfoCategory_Bookmark and ToClient_isBookmarkCoin(coinItemKey) == true then
      isMatchCategory = true
    end
    if coinCount > toInt64(0) then
      hasAnyCoinCount = true
    end
    if self._isToggleFilter == true then
      if isMatchReward == true and isMatchCategory == true and hasAnyCoinCount == true then
        table.insert(self._finalSortedCoinList, coinItemEnchantKey)
      end
    elseif isMatchReward == true and isMatchCategory == true then
      table.insert(self._finalSortedCoinList, coinItemEnchantKey)
    end
  end
  local function sortLineUpFunction(a, b)
    local fixedA = Int64toInt32(coinCountList[a])
    local fixedB = Int64toInt32(coinCountList[b])
    if markedList[a] == true then
      fixedA = fixedA + 100000
    end
    if markedList[b] == true then
      fixedB = fixedB + 100000
    end
    return fixedA > fixedB
  end
  if self._isToggleLineUp == true then
    table.sort(self._finalSortedCoinList, sortLineUpFunction)
  end
end
function PaGlobal_ExchangeCoin_All:reloadCoinList()
  self._ui.list2_moneyList:getElementManager():clearKey()
  local rowNum = math.ceil(#self._finalSortedCoinList / self._config.COIN_GRID_COLUMN)
  for index = 1, rowNum do
    self._ui.list2_moneyList:getElementManager():pushKey(toInt64(0, index))
  end
  if #self._finalSortedCoinList == 0 and self._filterText ~= "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_SEARCH_NORESULT"))
    self:resetSearch()
  end
end
function PaGlobal_ExchangeCoin_All:loadExchangeInfo(isSearch)
  self._firstRewardControl = {}
  if self._filterText == "" or self._filterText == nil then
    isSearch = false
  end
  for _, coinItemEnchantKey in ipairs(self._finalSortedCoinList) do
    local coinItemKey = coinItemEnchantKey:getItemKey()
    self:loadExchangeInfoPerCoin(isSearch, coinItemKey)
  end
  if self._selectedCoinItemKey ~= nil then
    self:loadExchangeInfoPerCoin(isSearch, self._selectedCoinItemKey)
  end
end
function PaGlobal_ExchangeCoin_All:loadExchangeInfoPerCoin(isSearch, coinItemKey)
  local familyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.FAMILY)
  local weekRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.WEEK)
  local dailyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.DAY)
  local alwaysRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.ALWAYS)
  for rewardIdx = 1, familyRewardCount do
    local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
    local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
    local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
    local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
    local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
    local isLimited = ToClient_isExchangeLimited(coinItemKey, rewardExchangeNo)
    local exchangedCount = ToClient_getExchangedCount(coinItemKey, rewardExchangeNo)
    local rewardItemName = rewardItemEnchantSSW:getName()
    local isStringMatch = false
    local hasItemCount = ToClient_getCoinCount(coinItemKey)
    local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
    if isSearch == true and stringMatching(rewardItemName, self._filterText) == true then
      isStringMatch = true
    end
    self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:EraseAllEffect()
    if isStringMatch == true then
      self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
    self._familyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(false)
    self._familyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(false)
    self._familyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(false)
    self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
    self._familyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
    self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
    self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
    self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
    self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
    if maxExchangeableCount == 0 then
      if isLimited == true then
        self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(0.5)
        self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(true)
        self._familyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 9999)
        self._familyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(true)
        self._familyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(true)
        self._familyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(true)
        self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(true)
        self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_COMPLETE"))
      elseif hasItemCount < toInt64(0, needCount) then
        self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_LACK"))
      end
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(true)
      if self._isConsole == true then
        self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      else
        self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(false)
      end
    else
      if self._firstRewardControl[coinItemKey] == nil then
        self._firstRewardControl[coinItemKey] = self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange
      end
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
      self._familyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
      self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
      self._familyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._familyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
      self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXCHANGECOIN_CANTEXCHANGE_BUTTON_ENABLED"))
    end
    self._familyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_LIMIT_FAMILY", "current", tostring(limitCount - exchangedCount), "max", tostring(limitCount)))
  end
  for rewardIdx = 1, weekRewardCount do
    local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
    local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
    local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
    local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
    local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
    local isLimited = ToClient_isExchangeLimited(coinItemKey, rewardExchangeNo)
    local exchangedCount = ToClient_getExchangedCount(coinItemKey, rewardExchangeNo)
    local rewardItemName = rewardItemEnchantSSW:getName()
    local isStringMatch = false
    local hasItemCount = ToClient_getCoinCount(coinItemKey)
    local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
    if isSearch == true and stringMatching(rewardItemName, self._filterText) == true then
      isStringMatch = true
    end
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:EraseAllEffect()
    if isStringMatch == true then
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
    self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
    self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
    if maxExchangeableCount == 0 then
      if isLimited == true then
        self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(0.5)
        self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(true)
        self._weeklyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 9999)
        self._weeklyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(true)
        self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(true)
        self._weeklyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(true)
        self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(true)
        self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_COMPLETE"))
      elseif hasItemCount < toInt64(0, needCount) then
        self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_LACK"))
      end
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(true)
      if self._isConsole == true then
        self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      else
        self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(false)
      end
    else
      if self._firstRewardControl[coinItemKey] == nil then
        self._firstRewardControl[coinItemKey] = self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange
      end
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._weeklyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
      self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXCHANGECOIN_CANTEXCHANGE_BUTTON_ENABLED"))
    end
    self._weeklyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_LIMIT_MONTHLY", "current", tostring(limitCount - exchangedCount), "max", tostring(limitCount)))
  end
  for rewardIdx = 1, dailyRewardCount do
    local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
    local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
    local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
    local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
    local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
    local isLimited = ToClient_isExchangeLimited(coinItemKey, rewardExchangeNo)
    local exchangedCount = ToClient_getExchangedCount(coinItemKey, rewardExchangeNo)
    local rewardItemName = rewardItemEnchantSSW:getName()
    local isStringMatch = false
    local hasItemCount = ToClient_getCoinCount(coinItemKey)
    local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
    if isSearch == true and stringMatching(rewardItemName, self._filterText) == true then
      isStringMatch = true
    end
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:EraseAllEffect()
    if isStringMatch == true then
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
    self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
    self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
    if maxExchangeableCount == 0 then
      if isLimited == true then
        self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(0.5)
        self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(true)
        self._dailyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 9999)
        self._dailyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetMonoTone(true)
        self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemName:SetMonoTone(true)
        self._dailyRewardControl[coinItemKey][rewardIdx].txt_coinCount:SetMonoTone(true)
        self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(true)
        self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_COMPLETE"))
      elseif hasItemCount < toInt64(0, needCount) then
        self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_LACK"))
      end
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(true)
      if self._isConsole == true then
        self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      else
        self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(false)
      end
    else
      if self._firstRewardControl[coinItemKey] == nil then
        self._firstRewardControl[coinItemKey] = self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange
      end
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._dailyRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
      self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXCHANGECOIN_CANTEXCHANGE_BUTTON_ENABLED"))
    end
    self._dailyRewardControl[coinItemKey][rewardIdx].txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_LIMIT_DAILY", "current", tostring(limitCount - exchangedCount), "max", tostring(limitCount)))
  end
  for rewardIdx = 1, alwaysRewardCount do
    local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
    local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
    local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
    local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
    local rewardItemName = rewardItemEnchantSSW:getName()
    local isStringMatch = false
    local hasItemCount = ToClient_getCoinCount(coinItemKey)
    local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
    if isSearch == true and stringMatching(rewardItemName, self._filterText) == true then
      isStringMatch = true
    end
    self._alwaysRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:EraseAllEffect()
    if isStringMatch == true then
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
    self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXCHANGECOIN_CANTEXCHANGE_BUTTON_ENABLED"))
    if maxExchangeableCount == 0 then
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(true)
      if self._isConsole == true then
        self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      else
        self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(false)
      end
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_EXCHANGE_LACK"))
    else
      if self._firstRewardControl[coinItemKey] == nil then
        self._firstRewardControl[coinItemKey] = self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange
      end
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetMonoTone(false)
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:SetEnable(true)
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:removeInputEvent("Mouse_LUp")
      self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetMonoTone(false)
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_itemSlot.icon:SetAlpha(1)
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_checkIcon:SetShow(false)
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_item:SetChildIndex(self._alwaysRewardControl[coinItemKey][rewardIdx].stc_checkIcon, 0)
    end
  end
end
function PaGlobal_ExchangeCoin_All:createFrameControl()
  self._familyRewardControl = {}
  self._weeklyRewardControl = {}
  self._dailyRewardControl = {}
  self._alwaysRewardControl = {}
  self._totalSizeYList = {}
  local frameBg = self._ui.frame_1_content
  local gap = 5
  for _, coinItemEnchantKey in ipairs(self._finalSortedCoinList) do
    local startPosY = 45
    local coinItemKey = coinItemEnchantKey:getItemKey()
    local coinItemSSW = getItemEnchantStaticStatus(coinItemEnchantKey)
    local coinIconPath = coinItemSSW:getIconPath()
    local coinIsSealed = ToClient_isSealedCoin(coinItemKey)
    self._familyRewardControl[coinItemKey] = {}
    self._weeklyRewardControl[coinItemKey] = {}
    self._dailyRewardControl[coinItemKey] = {}
    self._alwaysRewardControl[coinItemKey] = {}
    self._totalSizeYList[coinItemKey] = {}
    self:decoResize(self._ui.stc_familyExchange)
    local familyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.FAMILY)
    for rewardIdx = 1, familyRewardCount do
      local tempTable = {
        stc_bg = nil,
        stc_item = nil,
        stc_itemSlot = {},
        stc_itemName = nil,
        stc_checkIcon = nil,
        txt_restriction = nil,
        txt_coinCount = nil,
        btn_exchange = nil
      }
      local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
      local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
      local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
      local rewardItemCount = itemWrapper:getCount()
      local rewardNo = tostring(coinItemKey) .. tostring(rewardIdx)
      local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.FAMILY)
      local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
      local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
      local clonedControl = UI.cloneControl(self._ui.stc_template, frameBg, "Static_FamilyReward_" .. tostring(rewardNo))
      tempTable.stc_bg = clonedControl
      tempTable.stc_item = UI.getChildControl(clonedControl, "Static_Item")
      tempTable.stc_itemName = UI.getChildControl(clonedControl, "StaticText_ItemName")
      tempTable.txt_restriction = UI.getChildControl(clonedControl, "StaticText_RestrictionsDesc")
      tempTable.stc_checkIcon = UI.getChildControl(tempTable.stc_item, "Static_CheckIcon")
      tempTable.txt_coinCount = UI.getChildControl(clonedControl, "StaticText_Money")
      tempTable.btn_exchange = UI.getChildControl(clonedControl, "Button_Exchange")
      tempTable.btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      if self._isConsole == true then
        tempTable.btn_exchange:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_ExchangeCoin_ToggleRewardToolTipConsole(0," .. rewardIdx .. "," .. coinItemKey .. ")")
      end
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      tempTable.stc_bg:SetShow(false)
      tempTable.stc_checkIcon:SetShow(false)
      SlotItem.new(tempTable.stc_itemSlot, "ExchangeAll_FamilyRewardSlot_" .. tostring(rewardNo), 0, tempTable.stc_item, self._slotConfig)
      tempTable.stc_itemSlot:createChild()
      tempTable.stc_itemSlot:setItemByStaticStatus(rewardItemEnchantSSW, rewardItemCount)
      tempTable.stc_itemSlot.icon:SetSize(44, 44)
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(0," .. rewardIdx .. "," .. coinItemKey .. ",true)")
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(0," .. rewardIdx .. "," .. coinItemKey .. ",false)")
      if _ContentsGroup_TexFreeRenewal == true and coinIsSealed == true and rewardItemEnchantSSW:isCash() == true and requestIsRegisterItemForItemMarket(rewardItemEnchantSSW:get()._key) == true then
        tempTable.stc_itemSlot:ShowTextFreeIcon()
      end
      tempTable.stc_itemName:SetTextMode(__eTextMode_LimitText)
      tempTable.stc_itemName:SetText(rewardItemEnchantSSW:getName())
      PAGlobalFunc_SetItemTextColor(tempTable.stc_itemName, rewardItemEnchantSSW)
      tempTable.txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_EXCHANGE_HISTORY", "didCount", tostring(limitCount - maxExchangeableCount), "maxCount", tostring(limitCount)))
      tempTable.txt_coinCount:ChangeTextureInfoNameAsync("icon/" .. coinIconPath)
      tempTable.txt_coinCount:SetText("x" .. tostring(needCount))
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
      self._familyRewardControl[coinItemKey][rewardIdx] = tempTable
    end
    if familyRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] = self._ui.stc_familyExchange:GetPosY()
    end
    self:decoResize(self._ui.stc_weeklyExchange)
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] + self._ui.stc_weeklyExchange:GetSizeY() + gap
    local weekRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.WEEK)
    for rewardIdx = 1, weekRewardCount do
      local tempTable = {
        stc_bg = nil,
        stc_item = nil,
        stc_itemSlot = {},
        stc_itemName = nil,
        stc_checkIcon = nil,
        txt_restriction = nil,
        txt_coinCount = nil,
        btn_exchange = nil
      }
      local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
      local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
      local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
      local rewardItemCount = itemWrapper:getCount()
      local rewardNo = tostring(coinItemKey) .. tostring(rewardIdx)
      local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.WEEK)
      local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
      local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
      local clonedControl = UI.cloneControl(self._ui.stc_template, frameBg, "Static_WeekReward_" .. tostring(rewardNo))
      tempTable.stc_bg = clonedControl
      tempTable.stc_item = UI.getChildControl(clonedControl, "Static_Item")
      tempTable.stc_itemName = UI.getChildControl(clonedControl, "StaticText_ItemName")
      tempTable.txt_restriction = UI.getChildControl(clonedControl, "StaticText_RestrictionsDesc")
      tempTable.stc_checkIcon = UI.getChildControl(tempTable.stc_item, "Static_CheckIcon")
      tempTable.txt_coinCount = UI.getChildControl(clonedControl, "StaticText_Money")
      tempTable.btn_exchange = UI.getChildControl(clonedControl, "Button_Exchange")
      tempTable.btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      if self._isConsole == true then
        tempTable.btn_exchange:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_ExchangeCoin_ToggleRewardToolTipConsole(1," .. rewardIdx .. "," .. coinItemKey .. ")")
      end
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      tempTable.stc_checkIcon:SetShow(false)
      SlotItem.new(tempTable.stc_itemSlot, "ExchangeAll_WeekRewardSlot_" .. tostring(rewardNo), 0, tempTable.stc_item, self._slotConfig)
      tempTable.stc_itemSlot:createChild()
      tempTable.stc_itemSlot:setItemByStaticStatus(rewardItemEnchantSSW, rewardItemCount)
      tempTable.stc_itemSlot.icon:SetSize(44, 44)
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(1," .. rewardIdx .. "," .. coinItemKey .. ",true)")
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(1," .. rewardIdx .. "," .. coinItemKey .. ",false)")
      if _ContentsGroup_TexFreeRenewal == true and coinIsSealed == true and rewardItemEnchantSSW:isCash() == true and requestIsRegisterItemForItemMarket(rewardItemEnchantSSW:get()._key) == true then
        tempTable.stc_itemSlot:ShowTextFreeIcon()
      end
      tempTable.stc_itemName:SetTextMode(__eTextMode_LimitText)
      tempTable.stc_itemName:SetText(rewardItemEnchantSSW:getName())
      PAGlobalFunc_SetItemTextColor(tempTable.stc_itemName, rewardItemEnchantSSW)
      tempTable.txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_EXCHANGE_HISTORY", "didCount", tostring(maxExchangeableCount), "maxCount", tostring(limitCount)))
      tempTable.txt_coinCount:ChangeTextureInfoNameAsync("icon/" .. coinIconPath)
      tempTable.txt_coinCount:SetText("x" .. tostring(needCount))
      tempTable.stc_bg:SetShow(false)
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
      self._weeklyRewardControl[coinItemKey][rewardIdx] = tempTable
    end
    if weekRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK]
    end
    self:decoResize(self._ui.stc_dailyExchange)
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] + self._ui.stc_dailyExchange:GetSizeY() + gap
    local dailyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.DAY)
    for rewardIdx = 1, dailyRewardCount do
      local tempTable = {
        stc_bg = nil,
        stc_item = nil,
        stc_itemSlot = {},
        stc_itemName = nil,
        stc_checkIcon = nil,
        txt_restriction = nil,
        txt_coinCount = nil,
        btn_exchange = nil
      }
      local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
      local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
      local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
      local rewardItemCount = itemWrapper:getCount()
      local rewardNo = tostring(coinItemKey) .. tostring(rewardIdx)
      local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.DAY)
      local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
      local limitCount = ToClient_getLimitCountByExchangeNo(coinItemKey, rewardExchangeNo)
      local clonedControl = UI.cloneControl(self._ui.stc_template, frameBg, "Static_DayReward_" .. tostring(rewardNo))
      tempTable.stc_bg = clonedControl
      tempTable.stc_item = UI.getChildControl(clonedControl, "Static_Item")
      tempTable.stc_itemName = UI.getChildControl(clonedControl, "StaticText_ItemName")
      tempTable.txt_restriction = UI.getChildControl(clonedControl, "StaticText_RestrictionsDesc")
      tempTable.stc_checkIcon = UI.getChildControl(tempTable.stc_item, "Static_CheckIcon")
      tempTable.txt_coinCount = UI.getChildControl(clonedControl, "StaticText_Money")
      tempTable.btn_exchange = UI.getChildControl(clonedControl, "Button_Exchange")
      tempTable.btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      if self._isConsole == true then
        tempTable.btn_exchange:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_ExchangeCoin_ToggleRewardToolTipConsole(2," .. rewardIdx .. "," .. coinItemKey .. ")")
      end
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      tempTable.stc_checkIcon:SetShow(false)
      SlotItem.new(tempTable.stc_itemSlot, "ExchangeAll_DayRewardSlot_" .. tostring(rewardNo), 0, tempTable.stc_item, self._slotConfig)
      tempTable.stc_itemSlot:createChild()
      tempTable.stc_itemSlot:setItemByStaticStatus(rewardItemEnchantSSW, rewardItemCount)
      tempTable.stc_itemSlot.icon:SetSize(44, 44)
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(2," .. rewardIdx .. "," .. coinItemKey .. ",true)")
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(2," .. rewardIdx .. "," .. coinItemKey .. ",false)")
      if _ContentsGroup_TexFreeRenewal == true and coinIsSealed == true and rewardItemEnchantSSW:isCash() == true and requestIsRegisterItemForItemMarket(rewardItemEnchantSSW:get()._key) == true then
        tempTable.stc_itemSlot:ShowTextFreeIcon()
      end
      tempTable.stc_itemName:SetTextMode(__eTextMode_LimitText)
      tempTable.stc_itemName:SetText(rewardItemEnchantSSW:getName())
      PAGlobalFunc_SetItemTextColor(tempTable.stc_itemName, rewardItemEnchantSSW)
      tempTable.txt_restriction:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_EXCHANGE_HISTORY", "didCount", tostring(maxExchangeableCount), "maxCount", tostring(limitCount)))
      tempTable.txt_coinCount:ChangeTextureInfoNameAsync("icon/" .. coinIconPath)
      tempTable.txt_coinCount:SetText("x" .. tostring(needCount))
      tempTable.stc_bg:SetShow(false)
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
      self._dailyRewardControl[coinItemKey][rewardIdx] = tempTable
    end
    if dailyRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY]
    end
    self:decoResize(self._ui.stc_alwaysExchange)
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] + self._ui.stc_alwaysExchange:GetSizeY() + gap
    local alwaysRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.ALWAYS)
    for rewardIdx = 1, alwaysRewardCount do
      local tempTable = {
        stc_bg = nil,
        stc_item = nil,
        stc_itemSlot = {},
        stc_itemName = nil,
        stc_checkIcon = nil,
        txt_restriction = nil,
        txt_coinCount = nil,
        btn_exchange = nil
      }
      local itemWrapper = ToClient_getRewardItemWrapperByType(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
      local needCount = ToClient_getNeedCoinCount(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
      local rewardItemEnchantSSW = itemWrapper:getStaticStatus()
      local rewardItemCount = itemWrapper:getCount()
      local rewardNo = tostring(coinItemKey) .. tostring(rewardIdx)
      local rewardExchangeNo = ToClient_getExchangeNo(coinItemKey, rewardIdx - 1, self._exchangeTypeEnum.ALWAYS)
      local maxExchangeableCount = ToClient_getMaxExchangeableReward(coinItemKey, rewardExchangeNo)
      local clonedControl = UI.cloneControl(self._ui.stc_template, frameBg, "Static_AlwaysReward_" .. tostring(rewardNo))
      tempTable.stc_bg = clonedControl
      tempTable.stc_item = UI.getChildControl(clonedControl, "Static_Item")
      tempTable.stc_itemName = UI.getChildControl(clonedControl, "StaticText_ItemName")
      tempTable.txt_restriction = UI.getChildControl(clonedControl, "StaticText_RestrictionsDesc")
      tempTable.stc_checkIcon = UI.getChildControl(tempTable.stc_item, "Static_CheckIcon")
      tempTable.txt_coinCount = UI.getChildControl(clonedControl, "StaticText_Money")
      tempTable.btn_exchange = UI.getChildControl(clonedControl, "Button_Exchange")
      tempTable.btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeCoin_DoExchangeReward(" .. coinItemKey .. "," .. rewardExchangeNo .. "," .. maxExchangeableCount .. ")")
      if self._isConsole == true then
        tempTable.btn_exchange:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventXUp_ExchangeCoin_ToggleRewardToolTipConsole(3," .. rewardIdx .. "," .. coinItemKey .. ")")
      end
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      tempTable.stc_checkIcon:SetShow(false)
      SlotItem.new(tempTable.stc_itemSlot, "ExchangeAll_AlwaysRewardSlot_" .. tostring(rewardNo), 0, tempTable.stc_item, self._slotConfig)
      tempTable.stc_itemSlot:createChild()
      tempTable.stc_itemSlot:setItemByStaticStatus(rewardItemEnchantSSW, rewardItemCount)
      tempTable.stc_itemSlot.icon:SetSize(44, 44)
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(3," .. rewardIdx .. "," .. coinItemKey .. ",true)")
      tempTable.stc_itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_RewardItem_Tooltip(3," .. rewardIdx .. "," .. coinItemKey .. ",false)")
      if _ContentsGroup_TexFreeRenewal == true and coinIsSealed == true and rewardItemEnchantSSW:isCash() == true and requestIsRegisterItemForItemMarket(rewardItemEnchantSSW:get()._key) == true then
        tempTable.stc_itemSlot:ShowTextFreeIcon()
      end
      tempTable.stc_itemName:SetTextMode(__eTextMode_LimitText)
      tempTable.stc_itemName:SetText(rewardItemEnchantSSW:getName())
      PAGlobalFunc_SetItemTextColor(tempTable.stc_itemName, rewardItemEnchantSSW)
      tempTable.txt_restriction:SetShow(false)
      tempTable.txt_coinCount:ChangeTextureInfoNameAsync("icon/" .. coinIconPath)
      tempTable.txt_coinCount:SetText("x" .. tostring(needCount))
      tempTable.stc_bg:SetShow(false)
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.COUNT] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY()
      self._alwaysRewardControl[coinItemKey][rewardIdx] = tempTable
    end
    if alwaysRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.COUNT] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS]
    end
  end
  self._ui.stc_familyExchange:SetShow(false)
  self._ui.stc_weeklyExchange:SetShow(false)
  self._ui.stc_dailyExchange:SetShow(false)
  self._ui.stc_alwaysExchange:SetShow(false)
end
function PaGlobal_ExchangeCoin_All:selectCoin(coinItemKey)
  local gap = 5
  local startPosY = 45
  local coinItemEnchantKey = ItemEnchantKey(coinItemKey, 0)
  local coinItemSSW = getItemEnchantStaticStatus(coinItemEnchantKey)
  local coinItemDesc = splitDescription(coinItemSSW:getDescription())
  self._selectedCoinSlot:setItemByStaticStatus(coinItemSSW)
  self._selectedCoinSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ExchangeCoin_SelectedCoin_Tooltip(" .. tostring(coinItemKey) .. ",true)")
  self._selectedCoinSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_ExchangeCoin_SelectedCoin_Tooltip(" .. tostring(coinItemKey) .. ",false)")
  self._ui.txt_itemName:SetText(coinItemSSW:getName())
  PAGlobalFunc_SetItemTextColor(self._ui.txt_itemName, coinItemSSW)
  self._ui.txt_hasCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_hasCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXCHANGECOIN_HASITEMCOUNT", "count", makeDotMoney(ToClient_getCoinCount(coinItemKey))))
  self._ui.txt_itemDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_itemDesc:SetScale(1, 1)
  self._ui.txt_itemDesc:SetText(coinItemDesc)
  self._ui.txt_itemDesc:SetScale(self._scale, self._scale)
  self:clearRewardItems()
  self:clearRewardControl()
  ClearFocusEdit()
  self._selectedCoinItemKey = coinItemKey
  startPosY = self._ui.stc_familyExchange:GetPosY() + self._ui.stc_familyExchange:GetSizeY() + gap
  local familyRewardCount = #self._familyRewardControl[coinItemKey]
  if familyRewardCount ~= 0 then
    self._ui.stc_familyExchange:SetShow(true)
    for rewardIdx = 1, familyRewardCount do
      self._familyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosX((self._familyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      self._familyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosY(startPosY + (self._familyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._familyRewardControl[coinItemKey][rewardIdx].stc_bg:SetShow(true)
      self:pushRewardControl(rewardIdx - 1, self._familyRewardControl[coinItemKey][rewardIdx].btn_exchange)
    end
    self:newRewardControlRow(familyRewardCount)
  end
  startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] + self._ui.stc_weeklyExchange:GetSizeY() + gap
  local weekRewardCount = #self._weeklyRewardControl[coinItemKey]
  if weekRewardCount ~= 0 then
    self._ui.stc_weeklyExchange:SetPosY(self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK])
    self._ui.stc_weeklyExchange:SetShow(true)
    for rewardIdx = 1, weekRewardCount do
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosX((self._weeklyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosY(startPosY + (self._weeklyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._weeklyRewardControl[coinItemKey][rewardIdx].stc_bg:SetShow(true)
      self:pushRewardControl(rewardIdx - 1, self._weeklyRewardControl[coinItemKey][rewardIdx].btn_exchange)
    end
    self:newRewardControlRow(weekRewardCount)
  end
  startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] + self._ui.stc_dailyExchange:GetSizeY() + gap
  local dayRewardCount = #self._dailyRewardControl[coinItemKey]
  if dayRewardCount ~= 0 then
    self._ui.stc_dailyExchange:SetPosY(self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY])
    self._ui.stc_dailyExchange:SetShow(true)
    for rewardIdx = 1, dayRewardCount do
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosX((self._dailyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosY(startPosY + (self._dailyRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._dailyRewardControl[coinItemKey][rewardIdx].stc_bg:SetShow(true)
      self:pushRewardControl(rewardIdx - 1, self._dailyRewardControl[coinItemKey][rewardIdx].btn_exchange)
    end
    self:newRewardControlRow(dayRewardCount)
  end
  startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] + self._ui.stc_alwaysExchange:GetSizeY() + gap
  local alwaysRewardCount = #self._alwaysRewardControl[coinItemKey]
  if alwaysRewardCount ~= 0 then
    self._ui.stc_alwaysExchange:SetPosY(self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS])
    self._ui.stc_alwaysExchange:SetShow(true)
    for rewardIdx = 1, alwaysRewardCount do
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosX((self._alwaysRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_bg:SetPosY(startPosY + (self._alwaysRewardControl[coinItemKey][rewardIdx].stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._alwaysRewardControl[coinItemKey][rewardIdx].stc_bg:SetShow(true)
      self:pushRewardControl(rewardIdx - 1, self._alwaysRewardControl[coinItemKey][rewardIdx].btn_exchange)
    end
    self:newRewardControlRow(alwaysRewardCount)
  end
  self._ui.frame_1_content:SetSize(self._ui.frame_1_content:GetSizeX(), self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.COUNT])
  if self._ui.frame_exchangeList:GetSizeY() < self._ui.frame_1_content:GetSizeY() then
    self._ui.frame_1_verticalScroll:SetShow(true)
    self._ui.frame_1_content:SetIgnore(false)
    self._ui.frame_1_content:addInputEvent("Mouse_DownScroll", "RewardList_ScrollEvent( true )")
    self._ui.frame_1_content:addInputEvent("Mouse_UpScroll", "RewardList_ScrollEvent( false )")
  else
    self._ui.frame_1_verticalScroll:SetShow(false)
  end
  if self._isConsole == true then
    self._ui.frame_1_verticalScroll:SetInterval((self._ui.stc_template:GetSizeY()))
  else
    self._ui.frame_1_verticalScroll:SetInterval(self._ui.frame_1_content:GetSizeY() / 100 * 1.1)
  end
  self._ui.frame_1_verticalScroll:SetControlTop()
  self._ui.frame_exchangeList:UpdateContentScroll()
  self._ui.frame_exchangeList:UpdateContentPos()
  self._ui.list2_moneyList:requestUpdateVisible()
end
function PaGlobal_ExchangeCoin_All:clearRewardItems()
  if self._selectedCoinItemKey == nil then
    return
  end
  self._ui.stc_familyExchange:SetShow(false)
  self._ui.stc_weeklyExchange:SetShow(false)
  self._ui.stc_dailyExchange:SetShow(false)
  self._ui.stc_alwaysExchange:SetShow(false)
  for rewardIdx = 1, #self._familyRewardControl[self._selectedCoinItemKey] do
    self._familyRewardControl[self._selectedCoinItemKey][rewardIdx].stc_bg:SetShow(false)
  end
  for rewardIdx = 1, #self._weeklyRewardControl[self._selectedCoinItemKey] do
    self._weeklyRewardControl[self._selectedCoinItemKey][rewardIdx].stc_bg:SetShow(false)
  end
  for rewardIdx = 1, #self._dailyRewardControl[self._selectedCoinItemKey] do
    self._dailyRewardControl[self._selectedCoinItemKey][rewardIdx].stc_bg:SetShow(false)
  end
  for rewardIdx = 1, #self._alwaysRewardControl[self._selectedCoinItemKey] do
    self._alwaysRewardControl[self._selectedCoinItemKey][rewardIdx].stc_bg:SetShow(false)
  end
end
function PaGlobal_ExchangeCoin_All:pushRewardControl(index, control)
  local row = math.floor(index / 2)
  local col = index % 2
  if index == 0 then
    self._rewardControlList[self._rewardCtrlRow] = {}
  end
  self._rewardControlList[self._rewardCtrlRow + row][col] = control
  if col == 1 then
    self._rewardControlList[self._rewardCtrlRow + row + 1] = {}
    self._rewardControlList[self._rewardCtrlRow + row + 1][0] = nil
    self._rewardControlList[self._rewardCtrlRow + row + 1][1] = nil
  end
end
function PaGlobal_ExchangeCoin_All:newRewardControlRow(prevRewardCnt)
  local rows = math.ceil(prevRewardCnt / 2)
  self._rewardCtrlRow = self._rewardCtrlRow + rows
  self._rewardControlList[self._rewardCtrlRow] = {}
end
function PaGlobal_ExchangeCoin_All:clearRewardControl()
  self._rewardCtrlRow = 0
  self._rewardControlList = {}
  self._rewardControlList[0] = {}
end
function PaGlobal_ExchangeCoin_All:isShowPanel()
  if Panel_ExchangeCoin_All == nil then
    return false
  end
  return Panel_ExchangeCoin_All:GetShow()
end
function PaGlobal_ExchangeCoin_All:createSelectedCoinSlot()
  self._selectedCoinSlot = {}
  SlotItem.new(self._selectedCoinSlot, "Selected_Coin", 0, self._ui.stc_item, self._selectedSlotConfig)
  self._selectedCoinSlot:createChild()
  self._selectedCoinSlot.icon:SetSize(44, 44)
  self._selectedCoinSlot.icon:SetShow(true)
end
function PaGlobal_ExchangeCoin_All:selectTab(index)
  self._selectedCategoryIndex = index
  local posX = self._ui.stc_tabSelect:GetPosX()
  local tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_ALL")
  if index == self._eCatergoryTabOrder.ALL then
    posX = self._ui.rdo_tabMenu:GetPosX()
  elseif index == self._eCatergoryTabOrder.SEASON then
    posX = self._ui.rdo_tabSeason:GetPosX()
    tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_SEASON")
  elseif index == self._eCatergoryTabOrder.EVENT then
    posX = self._ui.rdo_tabEvent:GetPosX()
    tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_EVENT")
  elseif index == self._eCatergoryTabOrder.CONTENTS then
    posX = self._ui.rdo_tabContents:GetPosX()
    tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_CONTENTS")
  elseif index == self._eCatergoryTabOrder.BOOKMARK then
    posX = self._ui.rdo_tabBookmark:GetPosX()
    tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_BOOKMARK")
  elseif index == self._eCatergoryTabOrder.BOSSREWARD then
    posX = self._ui.rdo_tabBossReward:GetPosX()
    tabName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TAB_BOSSREWARD")
  end
  self._ui.stc_tabSelect:SetPosX(posX - (self._ui.stc_tabSelect:GetSizeX() - self._ui.rdo_tabMenu:GetSizeX()) / 2)
  self._ui.stc_tabName:SetText(tabName)
  self:filterCoinList()
  self:reloadCoinList()
  if #self._finalSortedCoinList ~= 0 and PaGlobal_ExchangeCoin_All:isShowPanel() == true then
    self:selectCoin(self._finalSortedCoinList[1]:getItemKey())
  end
end
function PaGlobal_ExchangeCoin_All:toggleSearchButton(isSearch)
  if self._isConsole == true then
    return
  end
  self._ui.btn_search:SetShow(not isSearch)
  self._ui.btn_search:SetIgnore(isSearch)
  self._ui.btn_reset:SetShow(isSearch)
  self._ui.btn_reset:SetIgnore(not isSearch)
end
function PaGlobal_ExchangeCoin_All:resetSearch()
  if self._selectedCoinItemKey ~= nil then
    self:selectCoin(self._selectedCoinItemKey)
  end
  self._filterText = ""
  self._ui.edit_searchText:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EVENT_EXCHANGELIST_SEARCH"))
  self:toggleSearchButton(false)
  ClearFocusEdit()
  self:filterCoinList()
  self:reloadCoinList()
end
function PaGlobal_ExchangeCoin_All:resize()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  self._ui.stc_static1:SetSize(screenSizeX, screenSizeY)
  self._ui.stc_static1:ComputePos()
  local panelRatio = 0.5625
  local ratioX = screenSizeX / 1920
  local ratioY = screenSizeY / 1080
  if screenSizeY < screenSizeX * panelRatio then
    self._ui.stc_sizeFix:SetScaleChild(ratioY, ratioY)
    self._scale = ratioY
  else
    self._ui.stc_sizeFix:SetScaleChild(ratioX, ratioX)
    self._scale = ratioX
  end
  self:resizeRewards()
end
function PaGlobal_ExchangeCoin_All:resizeRewards()
  local frameBg = self._ui.frame_1_content
  local gap = 5
  for _, coinItemEnchantKey in ipairs(self._finalSortedCoinList) do
    local startPosY = 45
    local coinItemKey = coinItemEnchantKey:getItemKey()
    local familyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.FAMILY)
    startPosY = self._ui.stc_familyExchange:GetSizeY() + gap
    for rewardIdx = 1, familyRewardCount do
      local tempTable = self._familyRewardControl[coinItemKey][rewardIdx]
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
    end
    if familyRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] = self._ui.stc_familyExchange:GetPosY()
    end
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK] + self._ui.stc_weeklyExchange:GetSizeY() + gap
    local weekRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.WEEK)
    for rewardIdx = 1, weekRewardCount do
      local tempTable = self._weeklyRewardControl[coinItemKey][rewardIdx]
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
    end
    if weekRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.WEEK]
    end
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY] + self._ui.stc_dailyExchange:GetSizeY() + gap
    local dailyRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.DAY)
    for rewardIdx = 1, dailyRewardCount do
      local tempTable = self._dailyRewardControl[coinItemKey][rewardIdx]
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY() + gap
    end
    if dailyRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.DAY]
    end
    startPosY = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS] + self._ui.stc_alwaysExchange:GetSizeY() + gap
    local alwaysRewardCount = ToClient_getCountOfRewardListByType(coinItemKey, self._exchangeTypeEnum.ALWAYS)
    for rewardIdx = 1, alwaysRewardCount do
      local tempTable = self._alwaysRewardControl[coinItemKey][rewardIdx]
      tempTable.stc_bg:SetPosX((tempTable.stc_bg:GetSizeX() + gap) * ((rewardIdx - 1) % 2))
      tempTable.stc_bg:SetPosY(startPosY + (tempTable.stc_bg:GetSizeY() + gap) * math.floor((rewardIdx - 1) / 2))
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.COUNT] = tempTable.stc_bg:GetPosY() + tempTable.stc_bg:GetSizeY()
    end
    if alwaysRewardCount == 0 then
      self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.COUNT] = self._totalSizeYList[coinItemKey][self._exchangeTypeEnum.ALWAYS]
    end
  end
end
function splitDescription(desc)
  if string.find(desc, "\\n") ~= nil then
    local _start, _end = string.find(desc, "\\n")
    return string.sub(desc, 1, _start - 1)
  elseif string.find(desc, "\n") ~= nil then
    local _start, _end = string.find(desc, "\n")
    return string.sub(desc, 1, _start - 1)
  else
    return desc
  end
end
function PaGlobal_ExchangeCoin_All:hideTooltip()
  if Panel_ExchangeCoin_All == nil then
    return
  end
  if Panel_ExchangeCoin_All:GetShow() == false then
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
end
function PaGlobal_ExchangeCoin_All:decoResize(control)
  local gap = 25
  local text = UI.getChildControl(control, "StaticText_1")
  local decoL = UI.getChildControl(control, "Static_Deco_L")
  local decoR = UI.getChildControl(control, "Static_Deco_R")
  local interval = decoR:GetSpanSize().x - decoL:GetSpanSize().x
  local addPosX = (text:GetTextSizeX() - interval) / 2 + gap
  decoL:SetSpanSize(decoL:GetSpanSize().x - addPosX, 0)
  decoR:SetSpanSize(decoR:GetSpanSize().x + addPosX, 0)
end
function PaGlobal_ExchangeCoin_All:DpadRightEvent()
  local currentControl = ToClient_getSnappedControl()
  if currentControl == nil then
    return
  end
  local coinStr = "MoneyBG"
  local rewardStr = "Button"
  local targetTemp
  local moveToReward = false
  if stringMatching(currentControl:GetID(), coinStr) == true then
    for ii = 1, #self._finalSortedCoinList do
      if currentControl:GetParentPosX() == self._coinControlList[ii]:GetParentPosX() and currentControl:GetParentPosY() == self._coinControlList[ii]:GetParentPosY() then
        if ii == #self._finalSortedCoinList or ii % 3 == 0 then
          moveToReward = true
        elseif ii < #self._finalSortedCoinList and self._coinControlList[ii + 1]:GetShow() == false then
          moveToReward = true
        end
        if moveToReward == true then
          if self._rewardCtrlRow ~= 0 then
            self._ui.frame_1_verticalScroll:SetControlTop()
            self._ui.frame_exchangeList:UpdateContentScroll()
            self._ui.frame_exchangeList:UpdateContentPos()
            ToClient_padSnapChangeToTarget(self._rewardControlList[0][0])
            return
          end
        else
          ToClient_padSnapChangeToTarget(self._coinControlList[ii + 1])
          return
        end
      end
    end
  elseif stringMatching(currentControl:GetID(), rewardStr) == true then
    for row = 0, self._rewardCtrlRow - 1 do
      for col = 0, 1 do
        targetTemp = self._rewardControlList[row][col]
        if targetTemp ~= nil and currentControl:GetParentPosX() == targetTemp:GetParentPosX() and currentControl:GetParentPosY() == targetTemp:GetParentPosY() then
          if col == 1 then
            return
          elseif self._rewardControlList[row][1] ~= nil then
            ToClient_padSnapChangeToTarget(self._rewardControlList[row][1])
            return
          end
        end
      end
    end
  end
end
