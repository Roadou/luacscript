local _panel = Panel_Window_MarketPlace_Main
local _mainBg = UI.getChildControl(_panel, "Static_MarketPlace")
local UI_color = Defines.Color
local ItemMarket = {
  _ui = {
    stc_LeftBg = UI.getChildControl(_mainBg, "Static_LeftBg"),
    stc_SearchBg = UI.getChildControl(_mainBg, "Static_SearchBg"),
    stc_MainBg = UI.getChildControl(_mainBg, "Static_Main"),
    stc_List2_ItemSearchList = UI.getChildControl(_mainBg, "List2_ItemSearch"),
    txt_NoSerchResult = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _itemListType = {
    categoryList = 1,
    detailListByCategory = 2,
    detailListByKey = 3,
    hotListByCategory = 4,
    waitListByCategory = 5
  },
  _tooltipType = {
    main = 0,
    detail = 1,
    selected = 2,
    hot = 3,
    wait = 4
  },
  _specialCategory = {
    saleList = 999,
    hotList = 9999,
    servantList = 9998,
    waitList = 8999
  },
  _searchTypeConfig = {
    all = __eWorldMarketSearchType_All,
    part = __eWorldMarketSearchType_Part,
    hot = __eWorldMarketSearchType_Hot,
    count = __eWorldMarketSearchType_Count
  },
  _hotListType = {down = 1, up = 2},
  _servantTypeStr = {
    [0] = "\235\167\144"
  },
  _servantMainKey = 99,
  _categoryIdxMap = {},
  _selectedMainKey = -1,
  _selectedSubKey = -1,
  _currentListType = 4,
  _prevIndex = 0,
  _isSelectItem = false,
  _sellInfoItemEnchantKeyRaw = 0,
  _categoryTexture = {},
  _isItemListSort = false,
  _isRegistCountUpperSort = false,
  _isBasicPriceUpperSort = false,
  _isGradeUpperSort = false,
  _searchType = __eWorldMarketSearchType_All,
  _isSearch = false,
  _selectIdx = -1,
  _isEnchantLevelUpperSort = true,
  _isFromEquipmentOpen = false,
  _isDirectOpen = false,
  _isOpenedMileageFunction = false,
  _listShowMaxCount = 0,
  _listOriginPosX = 0,
  _listOriginPosY = 0,
  _listOriginSizeY = 0,
  _currentItemSearchIdx = -1,
  _currentItemSearchListSize = 0,
  _searchListBtnOrigSizeX = 0,
  _searchListCompareSize = 0
}
local isSearch = false
local showResult = false
local timer = 0
local pressTimer = 0
local editText, searchText
local searchTextlen = 0
function ItemMarket:clearEnchantLevelUpper()
  self._isEnchantLevelUpperSort = true
  self._ui.checkButton_SortEnchantLevel:SetCheck(true)
end
function PaGlobalFunc_ItemMarket_SetSearchType()
  local self = ItemMarket
  local iconType = 0
  if true == self._ui.checkBtn_SerchType:IsCheck() then
    self._searchType = self._searchTypeConfig.all
    self._ui.checkBtn_SerchType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_SEARCH_ALL"))
    iconType = 6
  else
    self._searchType = self._searchTypeConfig.part
    self._ui.checkBtn_SerchType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_SEARCH_PART"))
    iconType = 7
  end
  if true == self._ui.checkBtn_SerchType:IsLimitText() then
    self._ui.checkBtn_SerchType:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowSearchTypeTooltip(true)")
    self._ui.checkBtn_SerchType:addInputEvent("Mouse_Out", "PaGlobalFunc_ItemMarket_ShowSearchTypeTooltip(false)")
  end
end
function PaGlobalFunc_ItemMarket_SearchResultClose()
  local self = ItemMarket
  self._ui.txt_NoSerchResult:SetShow(false)
end
function PaGlobalFunc_ItemMarket_Get()
  return ItemMarket
end
function PaGlobalFunc_ItemMarket_IsSubListOpen()
  local self = ItemMarket
  return self._ui.list_MarketItemList_Sub:GetShow()
end
function ItemMarket:categoryIconInit()
  local isArtifactItem = ToClient_IsContentsGroupOpen("1796")
  if false == isArtifactItem then
    self._categoryTexture = {
      [1] = {
        [0] = {
          2,
          83,
          27,
          108
        }
      },
      [5] = {
        [0] = {
          29,
          83,
          54,
          108
        }
      },
      [10] = {
        [0] = {
          56,
          83,
          81,
          108
        }
      },
      [15] = {
        [0] = {
          83,
          83,
          108,
          108
        }
      },
      [20] = {
        [0] = {
          110,
          83,
          135,
          108
        }
      },
      [25] = {
        [0] = {
          137,
          83,
          162,
          108
        }
      },
      [30] = {
        [0] = {
          164,
          83,
          189,
          108
        }
      },
      [55] = {
        [0] = {
          29,
          110,
          54,
          135
        }
      },
      [35] = {
        [0] = {
          191,
          83,
          216,
          108
        }
      },
      [40] = {
        [0] = {
          218,
          83,
          243,
          108
        }
      },
      [45] = {
        [0] = {
          110,
          110,
          135,
          135
        }
      },
      [50] = {
        [0] = {
          2,
          110,
          27,
          135
        }
      },
      [60] = {
        [0] = {
          56,
          110,
          81,
          135
        }
      },
      [65] = {
        [0] = {
          83,
          110,
          108,
          135
        }
      },
      [70] = {
        [0] = {
          137,
          110,
          162,
          135
        }
      },
      [75] = {
        [0] = {
          164,
          110,
          189,
          135
        }
      },
      [80] = {
        [0] = {
          191,
          110,
          216,
          135
        }
      },
      [999] = {
        [0] = {
          218,
          110,
          243,
          135
        }
      },
      [9999] = {
        [0] = {
          218,
          110,
          243,
          135
        }
      }
    }
  else
    self._categoryTexture = {
      [1] = {
        [0] = {
          2,
          83,
          27,
          108
        }
      },
      [5] = {
        [0] = {
          29,
          83,
          54,
          108
        }
      },
      [10] = {
        [0] = {
          56,
          83,
          81,
          108
        }
      },
      [15] = {
        [0] = {
          83,
          83,
          108,
          108
        }
      },
      [20] = {
        [0] = {
          110,
          83,
          135,
          108
        }
      },
      [25] = {
        [0] = {
          137,
          83,
          162,
          108
        }
      },
      [30] = {
        [0] = {
          164,
          83,
          189,
          108
        }
      },
      [55] = {
        [0] = {
          29,
          110,
          54,
          135
        }
      },
      [35] = {
        [0] = {
          191,
          83,
          216,
          108
        }
      },
      [40] = {
        [0] = {
          218,
          83,
          243,
          108
        }
      },
      [45] = {
        [0] = {
          110,
          110,
          135,
          135
        }
      },
      [50] = {
        [0] = {
          2,
          110,
          27,
          135
        }
      },
      [60] = {
        [0] = {
          56,
          110,
          81,
          135
        }
      },
      [65] = {
        [0] = {
          83,
          110,
          108,
          135
        }
      },
      [70] = {
        [0] = {
          137,
          110,
          162,
          135
        }
      },
      [75] = {
        [0] = {
          164,
          110,
          189,
          135
        }
      },
      [80] = {
        [0] = {
          191,
          110,
          216,
          135
        }
      },
      [85] = {
        [0] = {
          83,
          137,
          108,
          162
        }
      },
      [999] = {
        [0] = {
          218,
          110,
          243,
          135
        }
      },
      [9999] = {
        [0] = {
          218,
          110,
          243,
          135
        }
      }
    }
  end
end
function PaGlobalFunc_ItemMarket_Init()
  local self = ItemMarket
  self._isOpenedMileageFunction = true == _ContentsGroup_OldMoonSmelting
  self:initControl()
  self:initEvent()
  self:categoryIconInit()
  if self._isOpenedMileageFunction == true and self._ui.txt_MarketTaxBonus:GetShow() == true then
    self._ui.txt_MarketTaxBonus:SetPosX(self._ui.txt_MarketTaxBonus:GetPosX() - 15)
  end
end
function ItemMarket:initControl()
  self._ui.stc_WalletStatBg = UI.getChildControl(self._ui.stc_LeftBg, "Static_WalletStatBg")
  self._ui.txt_MarketInvenMoneyValue = UI.getChildControl(self._ui.stc_WalletStatBg, "StaticText_MarketInvenValue")
  self._ui.txt_MarketInvenWeightValue = UI.getChildControl(self._ui.stc_WalletStatBg, "StaticText_MarketWeightValue")
  self._ui.txt_MarketTaxBonus = UI.getChildControl(self._ui.stc_WalletStatBg, "StaticText_TaxBonus")
  self._ui.txt_MileageValue = UI.getChildControl(self._ui.stc_WalletStatBg, "StaticText_Tax_CH")
  self._ui.stc_CategoryListBg = UI.getChildControl(self._ui.stc_LeftBg, "Static_CategoryListBg")
  self._ui.list_ItemCategory = UI.getChildControl(self._ui.stc_CategoryListBg, "List2_ItemMarket_Category")
  self._ui.edit_ItemName = UI.getChildControl(self._ui.stc_SearchBg, "Edit_ItemName")
  self._ui.list2_ItemSearchContent = UI.getChildControl(self._ui.stc_List2_ItemSearchList, "List2_2_Content")
  self._ui.stc_List2_ItemSearchListScroll = UI.getChildControl(self._ui.stc_List2_ItemSearchList, "List2_2_VerticalScroll")
  self._ui.btn_Search = UI.getChildControl(self._ui.edit_ItemName, "Button_Search")
  self._ui.list_search = UI.getChildControl(self._ui.edit_ItemName, "List2_searchList")
  self._ui.checkBtn_FavoriteOnOff = UI.getChildControl(self._ui.stc_SearchBg, "Button_FavoriteOnOff")
  self._ui.btn_InMarketRegist = UI.getChildControl(self._ui.stc_SearchBg, "Button_InMarketRegist")
  self._ui.checkBtn_SerchType = UI.getChildControl(self._ui.stc_SearchBg, "CheckButton_SearchType")
  self._ui.btn_SortRegistItemCount = UI.getChildControl(self._ui.stc_MainBg, "Button_SortRegistItemCount")
  self._ui.checkBtn_SortBasicPrice = UI.getChildControl(self._ui.stc_MainBg, "CheckButton_SortAverageTradePrice")
  self._ui.CheckButton_SortGrade = UI.getChildControl(self._ui.stc_MainBg, "CheckButton_SortGrade")
  self._ui.checkButton_SortEnchantLevel = UI.getChildControl(self._ui.stc_MainBg, "CheckButton_SortEnchantLevel")
  self._ui.list_MarketItemList = UI.getChildControl(self._ui.stc_MainBg, "List2_ItemMarket_Main")
  self._ui.btn_BackPage = UI.getChildControl(self._ui.stc_MainBg, "Button_BackPage")
  self._ui.btn_SetRegistAlarm = UI.getChildControl(self._ui.stc_MainBg, "Button_SetRegistAlarm")
  self._ui.stc_SelectedItemBg = UI.getChildControl(self._ui.stc_MainBg, "Static_SelectedItemBg")
  self._ui.btn_ItemList = UI.getChildControl(self._ui.stc_SelectedItemBg, "Button_ItemList")
  self._ui.stc_SlotBg = UI.getChildControl(self._ui.stc_SelectedItemBg, "Static_SlotBG")
  self._ui.stc_Slot = UI.getChildControl(self._ui.stc_SelectedItemBg, "Static_Slot")
  self._ui.txt_ItemName = UI.getChildControl(self._ui.stc_SelectedItemBg, "Template_StaticText_ItemName")
  self._ui.txt_BasePriceValue = UI.getChildControl(self._ui.stc_SelectedItemBg, "StaticText_BasePriceValue")
  self._ui.txt_CountValue = UI.getChildControl(self._ui.stc_SelectedItemBg, "StaticText_CountValue")
  self._ui.list_MarketItemList_Sub = UI.getChildControl(self._ui.stc_MainBg, "List2_ItemMarket_Sub")
  self._ui.txt_NoSerchResult = UI.getChildControl(_mainBg, "StaticText_NoSearchResult")
  self._ui.txt_MileageValue:SetShow(self._isOpenedMileageFunction)
  self._ui.txt_MarketTaxBonus:SetShow(not self._isOpenedMileageFunction)
  local list2_Content = UI.getChildControl(self._ui.list_MarketItemList, "List2_1_Content")
  local slot = {}
  local list2_ItemSlot = UI.getChildControl(list2_Content, "Template_Static_Slot")
  SlotItem.new(slot, "ItemList", 0, list2_ItemSlot, self._slotConfig)
  slot:createChild()
  list2_Content = UI.getChildControl(self._ui.list_MarketItemList_Sub, "List2_1_Content")
  slot = {}
  list2_ItemSlot = UI.getChildControl(list2_Content, "Template_Static_Slot")
  SlotItem.new(slot, "ItemListSub", 0, list2_ItemSlot, self._slotConfig)
  slot:createChild()
  slot = {}
  list2_ItemSlot = UI.getChildControl(self._ui.stc_SelectedItemBg, "Static_Slot")
  SlotItem.new(slot, "SelectItem", 0, list2_ItemSlot, self._slotConfig)
  slot:createChild()
  self._ui.edit_ItemName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_ITEMMARKET_SEARCH_DEFAULT"), false)
  self._listShowMaxCount = math.floor(self._ui.stc_List2_ItemSearchList:GetSizeY() / self._ui.list2_ItemSearchContent:GetSizeY())
  self._listOriginPosX = self._ui.stc_List2_ItemSearchList:GetPosX()
  self._listOriginPosY = self._ui.stc_List2_ItemSearchList:GetPosY()
  self._listOriginSizeY = self._ui.stc_List2_ItemSearchList:GetSizeY()
  self._searchListBtnOrigSizeX = self._ui.list2_ItemSearchContent:GetSizeX()
end
function ItemMarket:initEvent()
  self._ui.btn_InMarketRegist:addInputEvent("Mouse_LUp", "InputMLUp_MarketPlace_SubWallet_TabToggle()")
  self._ui.btn_ItemList:addInputEvent("Mouse_RUp", "PaGlobalFunc_ItemMarket_BackPage()")
  self._ui.btn_BackPage:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_BackPage()")
  self._ui.list_ItemCategory:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ItemMarket_CreateControlCategoryList")
  self._ui.list_ItemCategory:createChildContent(__ePAUIList2ElementManagerType_Tree)
  self._ui.list_MarketItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ItemMarket_CreateControlMarketItemList")
  self._ui.list_MarketItemList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_MarketItemList_Sub:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ItemMarket_CreateControlMarketItemSubList")
  self._ui.list_MarketItemList_Sub:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_MarketItemList:setMinScrollBtnSize(float2(4, 50))
  self._ui.list_MarketItemList_Sub:setMinScrollBtnSize(float2(4, 50))
  self._ui.btn_SortRegistItemCount:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_RegistCountSort()")
  self._ui.btn_SortRegistItemCount:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowIconToolTip(true, " .. 12 .. ")")
  self._ui.btn_SortRegistItemCount:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.checkBtn_SortBasicPrice:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_SortBasicPrice()")
  self._ui.checkBtn_SortBasicPrice:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowIconToolTip(true, " .. 13 .. ")")
  self._ui.checkBtn_SortBasicPrice:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.CheckButton_SortGrade:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowIconToolTip(true, " .. 16 .. ")")
  self._ui.CheckButton_SortGrade:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.CheckButton_SortGrade:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_GradeSort()")
  self._ui.checkButton_SortEnchantLevel:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowIconToolTip(true, " .. 17 .. ")")
  self._ui.checkButton_SortEnchantLevel:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.checkButton_SortEnchantLevel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_EnchantLevelSort()")
  self._ui.checkBtn_FavoriteOnOff:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_FavoriteCheckOnOff()")
  self._ui.edit_ItemName:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_EditItemNameClear()")
  self._ui.checkBtn_SerchType:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_SetSearchType()")
  self._ui.checkBtn_SerchType:SetTextMode(__eTextMode_LimitText)
  self._ui.checkBtn_SerchType:SetText(self._ui.checkBtn_SerchType:GetText())
  self._ui.txt_MarketTaxBonus:addInputEvent("Mouse_On", "PaGlobal_MarketPlace_Itemmarket_TaxTooltip(true)")
  self._ui.txt_MarketTaxBonus:addInputEvent("Mouse_Out", "PaGlobal_MarketPlace_Itemmarket_TaxTooltip(false)")
  if true == self._ui.checkBtn_SerchType:IsLimitText() then
    self._ui.checkBtn_SerchType:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowSearchTypeTooltip(true)")
    self._ui.checkBtn_SerchType:addInputEvent("Mouse_Out", "PaGlobalFunc_ItemMarket_ShowSearchTypeTooltip(false)")
  end
  self._ui.edit_ItemName:RegistReturnKeyEvent("PaGlobalFunc_ItemMarket_FindItemRequest()")
  self._ui.btn_Search:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_FindItemRequest()")
  self._ui.list_search:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ItemMarket_CreateControlMarketSearchList")
  self._ui.list_search:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_responseHotListByWorldMarket", "FromClient_responseHotListByWorldMarket")
  registerEvent("FromClient_responseWaitListByWorldMarket", "FromClient_responseWaitListByWorldMarket")
  registerEvent("FromClient_responseListByWorldMarket", "FromClient_ItemMarket_ResponseList")
  registerEvent("FromClient_responseDetailListByWorldMarketByGroupNo", "FromClient_ItemMarket_ResponseDetailListByCategory")
  registerEvent("FromClient_responseDetailListByWorldMarketByMainKey", "FromClient_ItemMarket_ResponseDetailListByKey")
  registerEvent("FromClient_responseDetailListByWorldMarketByItemKeyWithEnchantSort", "FromClient_responseDetailListByWorldMarketByItemKeyWithEnchantSort")
  registerEvent("FromClient_NotifyCompleteWorldMarketSearchList", "FromClient_NotifyCompleteWorldMarketSearchList")
  registerEvent("FromClient_NotifyCashPushError", "FromClient_NotifyCashPushError")
  registerEvent("FromClient_NotifyPriceGroupSellError", "FromClient_NotifyPriceGroupSellError")
  if true == self._isOpenedMileageFunction then
    self._ui.txt_MarketTaxBonus:removeInputEvent("Mouse_On")
    self._ui.txt_MarketTaxBonus:removeInputEvent("Mouse_Out")
  end
  self._ui.stc_List2_ItemSearchList:changeAnimationSpeed(100)
  self._ui.stc_List2_ItemSearchList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ItemMarket_UpdateItemSearchList")
  self._ui.stc_List2_ItemSearchList:createChildContent(__ePAUIList2ElementManagerType_List)
  local resourceType = getGameServiceType()
  if resourceType ~= CppEnums.GameServiceType.eGameServiceType_GT_REAL and resourceType ~= CppEnums.GameServiceType.eGameServiceType_GT_ALPHA then
    registerEvent("FromClient_SetItemSearchResultInItemShop", "FromClient_SetItemSearchResultInItemShop")
    _panel:RegisterUpdateFunc("Update_CheckItemMarketSearchItemCondition")
  end
end
function Update_CheckItemMarketSearchItemCondition(deltaTime)
  local self = ItemMarket
  if isSearch == false then
    editText = tostring(self._ui.edit_ItemName:GetEditText())
    editTextLength = string.len(editText)
    if editTextLength > 0 then
      isSearch = true
      showResult = false
      timer = 0
      searchText = tostring(self._ui.edit_ItemName:GetEditText())
    else
      editTextLength = 0
      if showResult == true then
        EditItemNameInput_ClearSearchList()
      end
    end
  elseif isSearch == true then
    if editTextLength ~= string.len(editText) then
      timer = 0
      isSearch = false
      showResult = false
      editTextLength = 0
    end
    if searchText ~= tostring(self._ui.edit_ItemName:GetEditText()) then
      timer = 0
      isSearch = false
      showResult = false
      editTextLength = 0
    end
    if timer > 0.1 then
      if showResult == false then
        searchTextlen = string.len(searchText)
        PaGlobalFunc_SearchItemByName(searchText, searchTextlen, 1)
        showResult = true
      end
    else
      timer = timer + deltaTime
    end
  end
  if self._ui.stc_List2_ItemSearchList:GetShow() == true then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_HOME) then
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
      self._currentItemSearchIdx = 0
      self._ui.stc_List2_ItemSearchList:setCurrenttoIndex(self._currentItemSearchIdx)
      self._ui.stc_List2_ItemSearchList:moveTopIndex()
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
    elseif isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_END) then
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
      self._currentItemSearchIdx = self._currentItemSearchListSize - 1
      self._ui.stc_List2_ItemSearchList:moveBottomIndex()
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
    elseif isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_UP) then
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
      self._currentItemSearchIdx = self._currentItemSearchIdx - 1
      if 1 > self._currentItemSearchIdx then
        self._currentItemSearchIdx = 0
      end
      pressTimer = 0
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
      if self._currentItemSearchIdx == 0 then
        self._ui.stc_List2_ItemSearchList:moveTopIndex()
        return
      end
      local currentIndex = self._ui.stc_List2_ItemSearchList:getCurrenttoIndex()
      if currentIndex ~= 0 and 0 < currentIndex % self._currentItemSearchIdx and 1 > currentIndex % self._currentItemSearchIdx then
        currentIndex = currentIndex + 1
      end
      local isForceUpScroll = math.floor(currentIndex) - 1 >= self._currentItemSearchIdx
      if isForceUpScroll == true then
        if self._currentItemSearchIdx == 0 then
          self._ui.stc_List2_ItemSearchList:moveTopIndex()
        else
          self._ui.stc_List2_ItemSearchList:MouseUpScroll(self._ui.stc_List2_ItemSearchList)
        end
      end
    elseif isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_DOWN) then
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
      self._currentItemSearchIdx = self._currentItemSearchIdx + 1
      if self._currentItemSearchListSize - 1 < self._currentItemSearchIdx then
        self._currentItemSearchIdx = self._currentItemSearchListSize - 1
      end
      pressTimer = 0
      PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
      if self._currentItemSearchIdx + 1 == self._currentItemSearchListSize then
        self._ui.stc_List2_ItemSearchList:moveBottomIndex()
        return
      end
      local currentIndex = self._ui.stc_List2_ItemSearchList:getCurrenttoIndex()
      if currentIndex ~= 0 and 0 < (currentIndex + self._listShowMaxCount) % self._currentItemSearchIdx and 1 > (currentIndex + self._listShowMaxCount) % self._currentItemSearchIdx then
        currentIndex = currentIndex + 1
      end
      local isForceDownScroll = math.floor(currentIndex) + self._listShowMaxCount <= self._currentItemSearchIdx
      if isForceDownScroll == true then
        if self._currentItemSearchIdx + 1 == self._currentItemSearchListSize then
          self._ui.stc_List2_ItemSearchList:moveBottomIndex()
        else
          self._ui.stc_List2_ItemSearchList:MouseDownScroll(self._ui.stc_List2_ItemSearchList)
        end
      end
    elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_DOWN) then
      if pressTimer > 0.3 then
        pressTimer = 0.25
        PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
        self._currentItemSearchIdx = self._currentItemSearchIdx + 1
        if self._currentItemSearchListSize - 1 < self._currentItemSearchIdx then
          self._currentItemSearchIdx = self._currentItemSearchListSize - 1
        end
        PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
        if self._currentItemSearchIdx + 1 == self._currentItemSearchListSize then
          self._ui.stc_List2_ItemSearchList:moveBottomIndex()
          return
        end
        local currentIndex = self._ui.stc_List2_ItemSearchList:getCurrenttoIndex()
        if currentIndex ~= 0 and 0 < (currentIndex + self._listShowMaxCount) % self._currentItemSearchIdx and 1 > (currentIndex + self._listShowMaxCount) % self._currentItemSearchIdx then
          currentIndex = currentIndex + 1
        end
        local isForceDownScroll = math.floor(currentIndex) + self._listShowMaxCount <= self._currentItemSearchIdx
        if self._currentItemSearchIdx + 1 == self._currentItemSearchListSize then
          self._ui.stc_List2_ItemSearchList:moveBottomIndex()
        end
        if isForceDownScroll == true then
          if self._currentItemSearchIdx + 1 == self._currentItemSearchListSize then
            self._ui.stc_List2_ItemSearchList:moveBottomIndex()
          else
            self._ui.stc_List2_ItemSearchList:MouseDownScroll(self._ui.stc_List2_ItemSearchList)
          end
        end
      else
        pressTimer = pressTimer + deltaTime
      end
    elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_UP) then
      if pressTimer > 0.3 then
        pressTimer = 0.25
        PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, false, 1)
        self._currentItemSearchIdx = self._currentItemSearchIdx - 1
        if 1 > self._currentItemSearchIdx then
          self._currentItemSearchIdx = 0
        end
        PaGlobalFunc_ShowSearchItemPanelItemMarket(self._currentItemSearchIdx, true, 1)
        if self._currentItemSearchIdx == 0 then
          self._ui.stc_List2_ItemSearchList:moveTopIndex()
          return
        end
        local currentIndex = self._ui.stc_List2_ItemSearchList:getCurrenttoIndex()
        if currentIndex ~= 0 and 0 < currentIndex % self._currentItemSearchIdx and 1 > currentIndex % self._currentItemSearchIdx then
          currentIndex = currentIndex + 1
        end
        local isForceUpScroll = math.floor(currentIndex) - 1 == self._currentItemSearchIdx
        if isForceUpScroll == true then
          if self._currentItemSearchIdx == 0 then
            self._ui.stc_List2_ItemSearchList:moveTopIndex()
          else
            self._ui.stc_List2_ItemSearchList:MouseUpScroll(self._ui.stc_List2_ItemSearchList)
          end
        end
      else
        pressTimer = pressTimer + deltaTime
      end
    end
  end
end
function PaGlobalFunc_ItemMarket_SelectIndex()
  local self = ItemMarket
  if self._ui.stc_List2_ItemSearchList:GetShow() == false then
    return
  end
  local currentIndex = self._ui.stc_List2_ItemSearchList:getCurrenttoIndex()
  local contentIndex = 0
  if self._currentItemSearchIdx ~= 0 then
    contentIndex = self._currentItemSearchIdx % (self._listShowMaxCount + 2)
  end
  if currentIndex > self._currentItemSearchIdx then
    contentIndex = -1
  end
  if currentIndex + self._listShowMaxCount < self._currentItemSearchIdx then
    contentIndex = -1
  end
  for index = 0, self._listShowMaxCount + 1 do
    local itemSearchContent = UI.getChildControl(self._ui.stc_List2_ItemSearchList, "List2_ItemSearch_Content_" .. tostring(index))
    if itemSearchContent ~= nil then
      local radioBtn = UI.getChildControl(itemSearchContent, "RadioButton_ItemName")
      local x1, y1, x2, y2 = 0, 0, 0, 0
      radioBtn:ChangeTextureInfoNameAsync("combine/btn/combine_btn_00.dds")
      if contentIndex == index then
        x1, y1, x2, y2 = setTextureUV_Func(radioBtn, 411, 42, 451, 82)
      else
        x1, y1, x2, y2 = setTextureUV_Func(radioBtn, 370, 42, 410, 82)
      end
      radioBtn:getBaseTexture():setUV(x1, y1, x2, y2)
      radioBtn:setRenderTexture(radioBtn:getBaseTexture())
    end
  end
end
function PaGlobalFunc_ItemMarket_UpdateItemSearchList(control, key)
  if nil == key then
    _PA_ASSERT_NAME(false, "PaGlobalFunc_ItemMarket_UpdateItemSearchList key\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\152\164\236\131\129\235\175\188")
    return
  end
  local self = ItemMarket
  local btn_Dialog = UI.getChildControl(control, "RadioButton_ItemName")
  local stc_CategoryIcon = UI.getChildControl(btn_Dialog, "Static_CategoryIcon")
  local index = Int64toInt32(key)
  local searchType = 1
  btn_Dialog:addInputEvent("Mouse_On", "PaGlobalFunc_ShowSearchItemPanelItemMarket(" .. index .. ", true, " .. searchType .. ")")
  btn_Dialog:addInputEvent("Mouse_Out", "PaGlobalFunc_ShowSearchItemPanelItemMarket(" .. index .. ", false, " .. searchType .. ")")
  btn_Dialog:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_FindItemRequest()")
  if ItemMarket._searchListCompareSize > 0 then
    btn_Dialog:SetSize(ItemMarket._searchListCompareSize, btn_Dialog:GetSizeY())
  end
  local SearchingItemWrapper = ToClient_GetSearchingItemInfoByIndex(index, 1)
  if SearchingItemWrapper == nil then
    return
  end
  local itemName = SearchingItemWrapper:getName()
  local itemSSW = getItemEnchantStaticStatus(SearchingItemWrapper:getKey())
  local categoryNo = itemSSW:get():getItemMarketMainCategoryNo()
  stc_CategoryIcon:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_ItemMarket_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(stc_CategoryIcon, self._categoryTexture[categoryNo][0][1], self._categoryTexture[categoryNo][0][2], self._categoryTexture[categoryNo][0][3], self._categoryTexture[categoryNo][0][4])
  stc_CategoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_CategoryIcon:setRenderTexture(stc_CategoryIcon:getBaseTexture())
  btn_Dialog:SetText(itemName)
  btn_Dialog:SetCheck(false)
  btn_Dialog:setNotImpactScrollEvent(true)
  PaGlobalFunc_ItemMarket_SelectIndex()
end
function PaGlobalFunc_ShowSearchItemPanelItemMarket(index, isOpen, searchType)
  local self = ItemMarket
  self._currentItemSearchIdx = index
  PaGlobalFunc_ItemMarket_SelectIndex()
  PaGlobalFunc_ShowSearchItemPanel(index, isOpen, searchType, self._ui.stc_List2_ItemSearchList)
end
function FromClient_SetItemSearchResultInItemShop(size)
  local listSize = size
  ItemMarket._currentItemSearchListSize = size
  ItemMarket._currentItemSearchIdx = -1
  if listSize < 1 then
    EditItemNameInput_ClearSearchList()
    return
  end
  if GetFocusEdit() == nil then
    return
  end
  ItemMarket._ui.stc_List2_ItemSearchList:SetShow(true)
  ItemMarket._ui.stc_List2_ItemSearchList:getElementManager():clearKey()
  local maxSizeTextIndex = ToClient_GetSearchingItemMaxSizeTextIndex()
  local SearchingItemWrapper = ToClient_GetSearchingItemInfoByIndex(maxSizeTextIndex, 1)
  if SearchingItemWrapper == nil then
    return
  end
  local itemName = SearchingItemWrapper:getName()
  local templateRadioBtn = UI.getChildControl(ItemMarket._ui.list2_ItemSearchContent, "RadioButton_ItemName")
  local stc_CategoryIcon = UI.getChildControl(templateRadioBtn, "Static_CategoryIcon")
  templateRadioBtn:SetSize(ItemMarket._searchListBtnOrigSizeX, templateRadioBtn:GetSizeY())
  templateRadioBtn:SetTextMode(__eTextMode_None)
  templateRadioBtn:SetText(itemName)
  local maxSizeX = templateRadioBtn:GetTextSizeX() + stc_CategoryIcon:GetSizeY()
  if maxSizeX >= ItemMarket._searchListBtnOrigSizeX then
    ItemMarket._searchListCompareSize = maxSizeX + ItemMarket._ui.stc_List2_ItemSearchListScroll:GetSizeX()
  else
    ItemMarket._searchListCompareSize = ItemMarket._searchListBtnOrigSizeX + ItemMarket._ui.stc_List2_ItemSearchListScroll:GetSizeX()
  end
  local limitSizeX = ItemMarket._ui.stc_SearchBg:GetSizeX() - ItemMarket._ui.checkBtn_SerchType:GetSizeX() - ItemMarket._ui.stc_List2_ItemSearchListScroll:GetSizeX() * 3
  if limitSizeX < ItemMarket._searchListCompareSize then
    ItemMarket._searchListCompareSize = limitSizeX
  end
  for index = 0, listSize - 1 do
    ItemMarket._ui.stc_List2_ItemSearchList:getElementManager():pushKey(toInt64(0, index))
  end
  if listSize <= ItemMarket._listShowMaxCount then
    local listContentSizeY = ItemMarket._ui.list2_ItemSearchContent:GetSizeY()
    local minusY = listContentSizeY * (ItemMarket._listShowMaxCount - listSize)
    local sizeX = ItemMarket._searchListCompareSize + ItemMarket._ui.stc_List2_ItemSearchListScroll:GetSizeX()
    ItemMarket._ui.stc_List2_ItemSearchList:SetSize(sizeX, ItemMarket._listOriginSizeY - minusY)
    ItemMarket._ui.stc_List2_ItemSearchListScroll:SetShow(false)
  else
    local sizeX = ItemMarket._searchListCompareSize + ItemMarket._ui.stc_List2_ItemSearchListScroll:GetSizeX() * 2
    ItemMarket._ui.stc_List2_ItemSearchList:SetSize(sizeX, ItemMarket._listOriginSizeY)
    ItemMarket._ui.stc_List2_ItemSearchListScroll:SetShow(true)
  end
  PaGlobalFunc_ItemMarket_SelectIndex()
end
function EditItemNameInput_ClearSearchList()
  ItemMarket._ui.stc_List2_ItemSearchList:SetShow(false)
  ItemMarket._ui.stc_List2_ItemSearchList:getElementManager():clearKey()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobalFunc_ItemMarket_ShowIconToolTip(isShow, iconType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local self = ItemMarket
  if 12 == iconType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_SORT_REGISTITEMCOUNT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_SORT_REGISTITEMCOUNT_DESC")
    uiControl = self._ui.btn_SortRegistItemCount
  elseif 13 == iconType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_SORT_AVGTRADEITEM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_SORT_AVGTRADEITEM_DESC")
    uiControl = self._ui.checkBtn_SortBasicPrice
  elseif 16 == iconType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_TOOLTIP_SORT_GRADE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_TOOLTIP_SORT_GRADE_DESC")
    uiControl = self._ui.CheckButton_SortGrade
  elseif 17 == iconType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_MARKETPLACE_TOOLTIP_SORT_ENCHANT_LEVEL_NAME")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "LUA_MARKETPLACE_TOOLTIP_SORT_ENCHANT_LEVEL_DESC")
    uiControl = self._ui.checkButton_SortEnchantLevel
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobalFunc_ItemMarket_isHotCategory()
  local self = ItemMarket
  return __eWorldMarketCategoryType_Hot == self:getCurrentCategoryType()
end
function PaGlobalFunc_ItemMarket_GetCurrentCategory()
  local self = ItemMarket
  return self:getCurrentCategoryType()
end
function PaGlobalFunc_ItemMarket_RegistCountSort()
  local self = ItemMarket
  self._isRegistCountUpperSort = not self._isRegistCountUpperSort
  local isUpper = self._isRegistCountUpperSort
  TooltipSimple_Hide()
  local categoryType = self:getCurrentCategoryType()
  self:changeTextureBySort(self._ui.btn_SortRegistItemCount, isUpper)
  ToClient_RegistCountSortWorldMarketList(isUpper, categoryType)
end
function PaGlobalFunc_ItemMarket_GradeSort()
  local self = ItemMarket
  self._isGradeUpperSort = not self._isGradeUpperSort
  local isUpper = self._isGradeUpperSort
  TooltipSimple_Hide()
  local categoryType = self:getCurrentCategoryType()
  ToClient_GradeSortWorldMarketList(isUpper, categoryType)
end
function PaGlobalFunc_ItemMarket_EnchantLevelSort()
  local self = ItemMarket
  self._isEnchantLevelUpperSort = not self._isEnchantLevelUpperSort
  local isUpper = self._isEnchantLevelUpperSort
  TooltipSimple_Hide()
  local categoryType = self:getCurrentCategoryType()
  ToClient_EnchantLevelSortWorldMarketList(isUpper)
end
function PaGlobalFunc_ItemMarket_SortBasicPrice()
  local self = ItemMarket
  self._isBasicPriceUpperSort = not self._isBasicPriceUpperSort
  local isUpper = self._isBasicPriceUpperSort
  TooltipSimple_Hide()
  local categoryType = self:getCurrentCategoryType()
  ToClient_BasicPriceSortWorldMarketList(isUpper, categoryType)
end
function ItemMarket:getCurrentCategoryType()
  local categoryType = __eWorldMarketCategoryType_Count
  if self._itemListType.categoryList == self._currentListType then
    categoryType = __eWorldMarketCategoryType_Main
  elseif self._itemListType.detailListByKey == self._currentListType then
    categoryType = __eWorldMarketCategoryType_Sub
  elseif self._itemListType.hotListByCategory == self._currentListType then
    categoryType = __eWorldMarketCategoryType_Hot
  elseif self._itemListType.waitListByCategory == self._currentListType then
    categoryType = __eWorldMarketCategoryType_Wait
  end
  return categoryType
end
function ItemMarket:changeTextureBySort(control, isUpper)
  local uv = {
    [0] = {
      [0] = {
        137,
        61,
        204,
        90
      },
      [1] = {
        137,
        175,
        204,
        204
      }
    },
    [1] = {
      [0] = {
        137,
        1,
        204,
        30
      },
      [1] = {
        137,
        31,
        204,
        60
      }
    }
  }
  local x1, y1, x2, y2
  if true == isUpper then
    x1, y1, x2, y2 = setTextureUV_Func(control, uv[0][0][1], uv[0][0][2], uv[0][0][3], uv[0][0][4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(control, uv[0][1][1], uv[0][1][2], uv[0][1][3], uv[0][1][4])
    control:getOnTexture():setUV(x1, y1, x2, y2)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, uv[1][0][1], uv[1][0][2], uv[1][0][3], uv[1][0][4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(control, uv[1][1][1], uv[1][1][2], uv[1][1][3], uv[1][1][4])
    control:getOnTexture():setUV(x1, y1, x2, y2)
  end
  control:setRenderTexture(control:getBaseTexture())
end
function FGlobal_FavoriteItem_Search_World(text, enchantKey)
  local self = ItemMarket
  self._isSelectItem = false
  PaGlobalFunc_ItemMarket_FindItemName(text)
  PaGlobalFunc_ItemMarket_FindItemRequest()
  self._ui.checkBtn_SerchType:SetCheck(true)
  PaGlobalFunc_ItemMarket_SetSearchType()
  ToClient_searchWorldMarketItem(text, self._searchTypeConfig.all)
end
function _itemMarket_FavoriteItemRegist_World()
  local self = ItemMarket
  local text = ""
  if true == self._isSelectItem then
    text = self._ui.txt_ItemName:GetText()
    self._ui.edit_ItemName:SetEditText(text)
    local clickItem_SSW = getItemEnchantStaticStatus(ItemEnchantKey(self._sellInfoItemEnchantKeyRaw))
    FGlobal_ItemMarket_FavoriteItem_Regist(text, self._sellInfoItemEnchantKeyRaw)
    self._isSelectItem = false
    return
  elseif true == self._ui.edit_ItemName:GetShow() then
    text = self._ui.edit_ItemName:GetEditText()
    local itemMarketSummaryCount = ToClient_getSearchWorldMarketItemListSize()
    if itemMarketSummaryCount > 0 then
      FGlobal_ItemMarket_FavoriteItem_Regist(text, nil)
      self._isSelectItem = false
    end
  end
  if nil == text or "" == text or PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_ITEMMARKET_SEARCH_DEFAULT") == text then
    return
  end
end
function FGlobal_ItemMarket_FavoriteItemRegiste_World()
  _itemMarket_FavoriteItemRegist_World()
end
function PaGlobalFunc_ItemMarket_FavoriteBtn_CheckOff()
  local self = ItemMarket
end
function PaGlobalFunc_ItemMarket_FavoriteCheckOnOff()
  local self = ItemMarket
  if false == Panel_Window_ItemMarket_Favorite:GetShow() then
    FGlobal_ItemMarket_FavoriteItem_Open()
  else
    FGlobal_ItemMarket_FavoriteItem_Close()
  end
end
function PaGlobalFunc_ItemMarket_SearchIsFocused()
  local self = ItemMarket
  local bool = self._ui.edit_ItemName:GetFocusEdit()
  return bool
end
function PaGlobalFunc_ItemMarket_BackPage()
  local self = ItemMarket
  local bool = self._ui.btn_BackPage:GetShow()
  if false == bool or true == Panel_Window_MarketPlace_BuyManagement:GetShow() then
    return
  end
  self._selectedSubKey = -1
  ToClient_MarketPlaceBackPage()
  self._ui.list_MarketItemList:moveIndex(self._prevIndex)
  self._prevIndex = 0
  self._ui.checkButton_SortEnchantLevel:SetShow(false)
end
function PaGlobalFunc_ItemMarket_CreateControlMarketItemSubList(contents, key)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local idx = Int64toInt32(key)
  local bg_ItemSlot = UI.getChildControl(contents, "Template_Static_Slot")
  local slot = {}
  SlotItem.reInclude(slot, "ItemListSub", 0, bg_ItemSlot, self._slotConfig)
  slot.icon:EraseAllEffect()
  local txt_ItemName = UI.getChildControl(contents, "Template_StaticText_ItemName")
  local btn_ButtonBg = UI.getChildControl(contents, "Template_Button_ItemList")
  local txt_ItemBasePrice = UI.getChildControl(contents, "Template_StaticText_BasePriceValue")
  local txt_ItemCount = UI.getChildControl(contents, "Template_StaticText_CountValue")
  local stcText_BasePriceTitle = UI.getChildControl(contents, "Template_StaticText_BasePriceTitle")
  local stcText_CountTitle = UI.getChildControl(contents, "Template_StaticText_CountTitle")
  local arrowUp = UI.getChildControl(contents, "Template_Static_ArrowUp")
  local arrowDown = UI.getChildControl(contents, "Template_Static_ArrowDown")
  local changeValue = UI.getChildControl(contents, "Template_StaticText_ChangeValue")
  stcText_BasePriceTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_STANDARDPRICE_TITLE"))
  stcText_CountTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_MAIN_REGIST_COUNT"))
  slot.icon:addInputEvent("Mouse_On", "")
  slot.icon:addInputEvent("Mouse_Out", "")
  btn_ButtonBg:addInputEvent("Mouse_LUp", "")
  arrowUp:SetShow(false)
  arrowDown:SetShow(false)
  changeValue:SetShow(false)
  stcText_BasePriceTitle:SetShow(true)
  local itemInfo
  if self._itemListType.detailListByKey == self._currentListType then
    itemInfo = getWorldMarketDetailListByIdx(idx)
  elseif self._itemListType.hotListByCategory == self._currentListType then
    itemInfo = getWorldMarketHotListByIdx(idx)
  elseif self._itemListType.waitListByCategory == self._currentListType then
    itemInfo = getWorldMarketWaitListByIdx(idx)
  end
  if nil == itemInfo then
    _PA_ASSERT(false, "\236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : getWorldMarketDetailListByIdx( idx ) or getWorldMarketHotListByIdx( idx ) or getWorldMarketWaitListByIdx( idx )")
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey(), itemInfo:getSubKey()))
  if nil == itemSSW then
    return
  end
  btn_ButtonBg:SetColor(Defines.Color.C_FFFFFFFF)
  self:setListButtonTextureDefault(btn_ButtonBg)
  local itemCount
  local itemNameStr = self:setNameAndEnchantLevel(itemSSW:get()._key:getEnchantLevel(), itemSSW:getItemType(), itemSSW:getName(), itemSSW:getItemClassify(), itemSSW:isSpecialEnchantItem(), itemSSW:isSpecialAccessory())
  local upDown = ""
  if self._itemListType.hotListByCategory == self._currentListType then
    arrowDown:SetShow(self._hotListType.down == itemInfo:getFluctuationType())
    changeValue:SetShow(true)
    if self._hotListType.down == itemInfo:getFluctuationType() then
      self:setHotListButtonTexture(btn_ButtonBg, false)
      upDown = "-"
    elseif self._hotListType.up == itemInfo:getFluctuationType() then
      self:setHotListButtonTexture(btn_ButtonBg, true)
      upDown = "+"
    end
    local changedValue = itemInfo:getPriceChange()
    changeValue:SetText("(" .. upDown .. makeDotMoney(changedValue) .. ")")
    local basePriceTitle_TextSizeX = stcText_BasePriceTitle:GetTextSizeX()
    local basePriceTitle_SizeX = stcText_BasePriceTitle:GetSizeX()
    local basePriceTitle_PosX = stcText_BasePriceTitle:GetPosX()
    local changeValue_TextSizeX = changeValue:GetTextSizeX()
    local changeValue_SizeX = changeValue:GetSizeX()
    local changeValue_PosX = changeValue:GetPosX()
    local titleLenght = basePriceTitle_TextSizeX - basePriceTitle_SizeX + basePriceTitle_SizeX / 2
    local valueLenght = changeValue_TextSizeX - changeValue_SizeX + changeValue_SizeX / 2
    local title_CheckPos = basePriceTitle_PosX + titleLenght
    local value_CheckPos = changeValue_PosX - valueLenght
    if title_CheckPos > value_CheckPos then
      stcText_BasePriceTitle:SetShow(false)
    end
    itemCount = tostring(itemInfo:getStockCount())
    local maxEnchantLevel = itemInfo:getMaxSubKey()
    local minEnchantLevel = itemInfo:getMinSubKey()
    if minEnchantLevel ~= maxEnchantLevel then
      itemNameStr = itemNameStr .. "( +" .. minEnchantLevel .. " ~ +" .. maxEnchantLevel .. " ) "
    end
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowToolTip( " .. idx .. ", 3 )")
  elseif self._itemListType.waitListByCategory == self._currentListType then
    local waitTime = itemInfo:getWaitEndTime()
    local waitTimeStr
    if nil == waitTime or waitTime <= toInt64(0, 0) then
      waitTimeStr = "-"
    else
      waitTimeStr = os.date("%m-%d %H:%M", Int64toInt32(waitTime))
    end
    itemCount = tostring(waitTimeStr)
    stcText_BasePriceTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_REGISTERPRICE_TITLE"))
    stcText_CountTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_REGISTERTIME_TITLE"))
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowToolTip( " .. idx .. ", 4 )")
  else
    itemCount = tostring(itemInfo:getStockCount())
    local maxEnchantLevel = itemInfo:getMaxSubKey()
    local minEnchantLevel = itemInfo:getMinSubKey()
    if minEnchantLevel ~= maxEnchantLevel then
      itemNameStr = itemNameStr .. "( +" .. minEnchantLevel .. " ~ +" .. maxEnchantLevel .. " ) "
    end
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowToolTip( " .. idx .. ", 1 )")
  end
  txt_ItemName:SetFontColor(self:setNameColor(itemSSW:getGradeType()))
  txt_ItemName:SetTextMode(__eTextMode_AutoWrap)
  txt_ItemName:SetText(itemNameStr)
  txt_ItemBasePrice:SetText(makeDotMoney(itemInfo:getPricePerOne()))
  txt_ItemCount:SetText(itemCount)
  slot:setItemByStaticStatus(itemSSW, 0, -1, false, nil, false, 0, 0, nil)
  slot.isEmpty = false
  slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  btn_ButtonBg:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_RequestBiddingList(" .. idx .. ")")
end
function ItemMarket:setListButtonTextureDefault(control)
  local x1, y1, x2, y2
  control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
  x1, y1, x2, y2 = setTextureUV_Func(control, 279, 65, 318, 104)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  control:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
  x1, y1, x2, y2 = setTextureUV_Func(control, 239, 65, 278, 104)
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
  x1, y1, x2, y2 = setTextureUV_Func(control, 279, 65, 318, 104)
  control:getClickTexture():setUV(x1, y1, x2, y2)
end
function ItemMarket:setHotListButtonTexture(control, isUp)
  local x1, y1, x2, y2
  if true == isUp then
    control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 78, 373, 117)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 118, 373, 157)
    control:getOnTexture():setUV(x1, y1, x2, y2)
    control:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 158, 373, 197)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  else
    control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 198, 373, 237)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 238, 373, 277)
    control:getOnTexture():setUV(x1, y1, x2, y2)
    control:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(control, 334, 278, 373, 317)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobalFunc_ItemMarket_CreateControlMarketSearchList(contents, key)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local idx = Int64toInt32(key)
  local txt_ItemName = UI.getChildControl(contents, "StaticText_RecommandWord")
  local itemNameStr = ToClient_getSearchWorldMarketItemName(idx)
  txt_ItemName:SetTextMode(__eTextMode_LimitText)
  txt_ItemName:SetText(itemNameStr)
  txt_ItemName:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_SearchItemList(" .. idx .. ")")
  UI.setLimitTextAndAddTooltip(txt_ItemName)
end
function PaGlobalFunc_ItemMarket_CreateControlMarketItemList(contents, key)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local idx = Int64toInt32(key)
  local bg_ItemSlot = UI.getChildControl(contents, "Template_Static_Slot")
  local slot = {}
  SlotItem.reInclude(slot, "ItemList", 0, bg_ItemSlot, self._slotConfig)
  slot.icon:EraseAllEffect()
  local txt_ItemName = UI.getChildControl(contents, "Template_StaticText_ItemName")
  local btn_ButtonBg = UI.getChildControl(contents, "Template_Button_ItemList")
  local txt_ItemBasePrice = UI.getChildControl(contents, "Template_StaticText_BasePriceValue")
  local txt_ItemCount = UI.getChildControl(contents, "Template_StaticText_CountValue")
  local itemInfo = getWorldMarketListByIdx(idx)
  if nil == itemInfo then
    _PA_ASSERT(false, "\236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : getWorldMarketListByIdx( idx )")
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey()))
  local itemType = itemInfo:getKeyType()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local nameColorGrade = itemSSW:getGradeType()
  local itemCount = itemInfo:getStockCount()
  local standCount = itemInfo:getStandPrice()
  slot:setItemByStaticStatus(itemSSW)
  slot.isEmpty = false
  local nameColor = self:setNameColor(nameColorGrade)
  txt_ItemName:SetFontColor(nameColor)
  txt_ItemName:SetTextMode(__eTextMode_AutoWrap)
  txt_ItemName:SetText(tostring(itemSSW:getName()))
  txt_ItemBasePrice:SetText(makeDotMoney(standCount))
  txt_ItemCount:SetText(tostring(itemCount))
  slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowToolTip( " .. idx .. ", 0 )")
  slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  btn_ButtonBg:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_RequestDetailListByKey(" .. itemInfo:getMainKey() .. ")")
end
function PaGlobalFunc_ItemMarket_ShowToolTip_SelectSlot(itemKey)
  local self = ItemMarket
  slot = self._ui.stc_Slot
  itemInfo = getWorldMarketListByItemKey(itemKey)
  if nil == slot or nil == itemInfo then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey()))
  PaGlobalFunc_MarketPlace_ShowToolTip(itemSSW, slot, true)
end
function PaGlobalFunc_ItemMarket_ShowToolTip(idx, tooltipType)
  local self = ItemMarket
  local list, itemInfo, slot, contents
  if self._tooltipType.main == Int64toInt32(tooltipType) then
    list = self._ui.list_MarketItemList
    itemInfo = getWorldMarketListByIdx(idx)
    contents = list:GetContentByKey(toInt64(0, idx))
    slot = UI.getChildControl(contents, "Template_Static_Slot")
  elseif self._tooltipType.detail == Int64toInt32(tooltipType) then
    list = self._ui.list_MarketItemList_Sub
    itemInfo = getWorldMarketDetailListByIdx(idx)
    contents = list:GetContentByKey(toInt64(0, idx))
    slot = UI.getChildControl(contents, "Template_Static_Slot")
  elseif self._tooltipType.hot == Int64toInt32(tooltipType) then
    list = self._ui.list_MarketItemList_Sub
    itemInfo = getWorldMarketHotListByIdx(idx)
    contents = list:GetContentByKey(toInt64(0, idx))
    slot = UI.getChildControl(contents, "Template_Static_Slot")
  elseif self._tooltipType.wait == Int64toInt32(tooltipType) then
    list = self._ui.list_MarketItemList_Sub
    itemInfo = getWorldMarketWaitListByIdx(idx)
    contents = list:GetContentByKey(toInt64(0, idx))
    slot = UI.getChildControl(contents, "Template_Static_Slot")
  end
  if nil == slot or nil == itemInfo then
    return
  end
  local itemSSW
  if self._tooltipType.main == Int64toInt32(tooltipType) then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey()))
  else
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey(), itemInfo:getSubKey()))
  end
  PaGlobalFunc_MarketPlace_ShowToolTip(itemSSW, slot, true)
end
function PaGlobalFunc_ItemMarket_ShowSearchTypeTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local self = ItemMarket
  local name, desc, control
  name = self._ui.checkBtn_SerchType:GetText()
  desc = ""
  control = self._ui.checkBtn_SerchType
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_ItemMarket_CreateControlCategoryList(contents, key)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local idx = Int64toInt32(key)
  local indexMap = self._categoryIdxMap[idx]
  local categoryInfo
  local btn_MainCategory = UI.getChildControl(contents, "Template_RadioButton_CategoryBar")
  local btn_CategoryIcon = UI.getChildControl(contents, "Template_RadioButton_CategoryIcon")
  local btn_SubCategory = UI.getChildControl(contents, "Template_RadioButton_SubCategoryBar")
  local stc_Arrow = UI.getChildControl(btn_SubCategory, "Template_Static_Arrow")
  btn_MainCategory:setNotImpactScrollEvent(true)
  btn_CategoryIcon:setNotImpactScrollEvent(true)
  btn_SubCategory:setNotImpactScrollEvent(true)
  if indexMap._isMain then
    if self._specialCategory.hotList == indexMap._index then
      btn_CategoryIcon:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_ItemMarket_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn_CategoryIcon, self._categoryTexture[self._specialCategory.hotList][0][1], self._categoryTexture[self._specialCategory.hotList][0][2], self._categoryTexture[self._specialCategory.hotList][0][3], self._categoryTexture[self._specialCategory.hotList][0][4])
      btn_CategoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      btn_CategoryIcon:setRenderTexture(btn_CategoryIcon:getBaseTexture())
    elseif self._specialCategory.servantList == indexMap._index and true == _ContentsGroup_ServantWorldMarket then
      btn_CategoryIcon:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_ItemMarket_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn_CategoryIcon, 83, 110, 108, 135)
      btn_CategoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      btn_CategoryIcon:setRenderTexture(btn_CategoryIcon:getBaseTexture())
    elseif self._specialCategory.waitList == indexMap._index then
      btn_CategoryIcon:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_ItemMarket_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn_CategoryIcon, 56, 137, 81, 162)
      btn_CategoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      btn_CategoryIcon:setRenderTexture(btn_CategoryIcon:getBaseTexture())
    else
      btn_CategoryIcon:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_ItemMarket_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn_CategoryIcon, self._categoryTexture[indexMap._categoryNo][0][1], self._categoryTexture[indexMap._categoryNo][0][2], self._categoryTexture[indexMap._categoryNo][0][3], self._categoryTexture[indexMap._categoryNo][0][4])
      btn_CategoryIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      btn_CategoryIcon:setRenderTexture(btn_CategoryIcon:getBaseTexture())
    end
  end
  btn_MainCategory:SetCheck(idx == self._selectedMainKey)
  btn_MainCategory:SetShow(false)
  btn_SubCategory:SetShow(false)
  btn_CategoryIcon:SetShow(false)
  if true == indexMap._isMain then
    if self._specialCategory.hotList == indexMap._index then
      btn_MainCategory:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_HOTLISTTITME"))
      btn_MainCategory:SetShow(true)
      btn_CategoryIcon:SetShow(true)
      btn_MainCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_SpecialCategoryList(" .. self._specialCategory.hotList .. ")")
    elseif self._specialCategory.saleList == indexMap._index then
    elseif self._specialCategory.servantList == indexMap._index and true == _ContentsGroup_ServantWorldMarket then
      btn_MainCategory:SetText("\235\167\136\236\139\156\236\158\165 \236\131\129\237\146\136")
      btn_MainCategory:SetShow(true)
      btn_CategoryIcon:SetShow(true)
      btn_MainCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_MainCategoryList(" .. idx .. ")")
    elseif self._specialCategory.waitList == indexMap._index then
      btn_MainCategory:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_WAITLISTTITME"))
      btn_MainCategory:SetShow(true)
      btn_CategoryIcon:SetShow(true)
      btn_MainCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_SpecialCategoryList(" .. self._specialCategory.waitList .. ")")
    else
      categoryInfo = ToClient_GetItemMarketCategoryAt(indexMap._index)
      local mainValue = categoryInfo:getMainCategoryValue()
      btn_MainCategory:SetText(mainValue:getCategoryName())
      btn_MainCategory:SetShow(true)
      btn_CategoryIcon:SetShow(true)
      btn_MainCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_MainCategoryList(" .. idx .. ")")
    end
    btn_SubCategory:SetCheck(false)
  elseif false == indexMap._isMain then
    if self._specialCategory.servantList == indexMap._index and true == _ContentsGroup_ServantWorldMarket then
      btn_SubCategory:SetText(self._servantTypeStr[indexMap._subIndex])
      btn_SubCategory:SetShow(true)
      btn_SubCategory:SetFontColor(UI_color.C_FF8B7455)
      btn_SubCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_SubCategoryList(" .. idx .. ")")
    else
      categoryInfo = ToClient_GetItemMarketCategoryAt(indexMap._index)
      local subValue = categoryInfo:getSubCategoryAt(indexMap._subIndex)
      btn_SubCategory:SetCheck(idx == self._selectIdx)
      btn_SubCategory:SetText(subValue:getCategoryName())
      btn_SubCategory:SetShow(true)
      btn_SubCategory:SetFontColor(UI_color.C_FF8B7455)
      btn_SubCategory:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_SubCategoryList(" .. idx .. ")")
    end
  end
end
function InputMLUp_ItemMarket_SpecialCategoryList(idx)
  local self = ItemMarket
  local keyElement
  self._sellInfoItemEnchantKeyRaw = 0
  for key, value in pairs(self._categoryIdxMap) do
    if true == value._isMain then
      keyElement = self._ui.list_ItemCategory:getElementManager():getByKey(toInt64(0, key), false)
      if true == keyElement:getIsOpen() then
        self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, key))
      end
    end
  end
  self._isSearch = false
  self._selectedMainKey = idx
  if self._specialCategory.saleList == idx then
  elseif self._specialCategory.hotList == idx then
    self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, 9999))
    ToClient_requestHotListToWorldMarket()
  elseif self._specialCategory.servantList == idx and true == _ContentsGroup_ServantWorldMarket then
    self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, 9998))
  elseif self._specialCategory.waitList == idx then
    self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, 8999))
    ToClient_requestWaitListToWorldMarket()
  end
end
function ItemMarket:setSelectSlot(itemKey)
  local itemInfo = getWorldMarketListByItemKey(itemKey)
  if nil == itemInfo then
    InputMLUp_ItemMarket_SpecialCategoryList(9999)
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey()))
  local itemType = itemInfo:getKeyType()
  local nameColorGrade = itemSSW:getGradeType()
  local itemCount = itemInfo:getStockCount()
  local totalTradeCount = itemInfo:getTotalTradeCount()
  local bg_ItemSlot = self._ui.stc_Slot
  local slot = {}
  SlotItem.reInclude(slot, "SelectItem", 0, bg_ItemSlot, self._slotConfig)
  slot.icon:EraseAllEffect()
  slot:setItemByStaticStatus(itemSSW)
  slot.isEmpty = false
  local nameColor = self:setNameColor(nameColorGrade)
  self._ui.txt_ItemName:SetFontColor(nameColor)
  self._ui.txt_ItemName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_ItemName:SetText(tostring(itemSSW:getName()))
  self._ui.txt_BasePriceValue:SetText(tostring(makeDotMoney(totalTradeCount)))
  self._ui.txt_CountValue:SetText(tostring(itemCount))
  slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ItemMarket_ShowToolTip_SelectSlot( " .. itemKey .. ")")
  slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
end
function PaGlobalFunc_MarketPlace_setNameAndEnchantLevel(enchantLevel, itemType, itemName, itemClassify, isSpecialEnchantItem, isSpecialAccessory)
  return ItemMarket:setNameAndEnchantLevel(enchantLevel, itemType, itemName, itemClassify, isSpecialEnchantItem, isSpecialAccessory)
end
function PaGlobalFunc_ItemMarket_EditItemNameClear()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._ui.edit_ItemName:SetEditText("", true)
  SetFocusEdit(self._ui.edit_ItemName)
  PaGlobalFunc_ItemMarket_SearchItemListClear()
end
function PaGlobalFunc_ItemMarket_FindItemName(str)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local inputKeyword = ""
  if nil == str then
    inputKeyword = self._ui.edit_ItemName:GetEditText()
  else
    inputKeyword = str
    self._ui.edit_ItemName:SetEditText(str)
  end
  if nil == inputKeyword then
    return
  end
  if self._searchType == self._searchTypeConfig.part and self._selectedMainKey == self._specialCategory.hotList and false == self._isSearch then
    self._searchType = self._searchTypeConfig.hot
  end
  if "" ~= inputKeyword and PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_ITEMMARKET_SEARCH_DEFAULT") ~= inputKeyword then
    ToClient_searchWorldMarketItem(inputKeyword, self._searchType)
  else
    PaGlobalFunc_ItemMarket_SearchItemListClear()
    return
  end
end
function PaGlobalFunc_ItemMarket_FindItemRequest()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  if self._currentItemSearchIdx == -1 then
    PaGlobalFunc_ItemMarket_FindItemName()
  else
    local idx = Int64toInt32(self._currentItemSearchIdx)
    local SearchingItemWrapper = ToClient_GetSearchingItemInfoByIndex(idx, 1)
    if SearchingItemWrapper ~= nil then
      local itemName = tostring(SearchingItemWrapper:getName())
      ToClient_searchWorldMarketItem(itemName, self._searchType)
      ItemMarket._ui.edit_ItemName:SetEditText(itemName, true)
      searchText = itemName
    else
      PaGlobalFunc_ItemMarket_FindItemName()
    end
  end
  local inputKeyword = self._ui.edit_ItemName:GetEditText()
  local size = string.len(inputKeyword)
  self._isSearch = true
  if true == self._isDirectOpen then
    PaGlobalFunc_ItemMarket_SetIsDirectOpen(false)
  end
  ToClient_requestSearchListByWorldMarket()
  self._isSelectItem = false
  ClearFocusEdit()
  EditItemNameInput_ClearSearchList()
end
function PaGlobalFunc_ItemMarket_SearchItemListClear()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138i\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._ui.list_search:SetShow(false)
  ToClient_clearSearchWorldMarketItemKey()
  EditItemNameInput_ClearSearchList()
end
function ItemMarket:setNameAndEnchantLevel(enchantLevel, itemType, itemName, itemClassify, isSpecialEnchantItem, isSpecialAccessory)
  local nameStr = itemName
  if 1 == itemType and enchantLevel > 15 then
    nameStr = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
  elseif enchantLevel > 0 and CppEnums.ItemClassifyType.eItemClassify_Accessory == itemClassify then
    nameStr = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
  elseif 0 ~= enchantLevel then
    nameStr = "+" .. enchantLevel .. " " .. itemName
  end
  if isSpecialEnchantItem == true and isSpecialAccessory == false then
    nameStr = itemName
  end
  return nameStr
end
function PaGlobalFunc_MarketPlace_SetNameColor(nameColorGrade)
  return ItemMarket:setNameColor(nameColorGrade)
end
function PaGlobalFunc_MarketPlace_SetNameColor_Desc(nameColorGrade)
  return ItemMarket:setNameColor_Desc(nameColorGrade)
end
function ItemMarket:setNameColor(nameColorGrade)
  local nameColor
  if 0 == nameColorGrade then
    nameColor = UI_color.C_FFC4C4C4
  elseif 1 == nameColorGrade then
    nameColor = UI_color.C_FF83A543
  elseif 2 == nameColorGrade then
    nameColor = UI_color.C_FF438DCC
  elseif 3 == nameColorGrade then
    nameColor = UI_color.C_FFF5BA3A
  elseif 4 == nameColorGrade then
    nameColor = UI_color.C_FFD05D48
  elseif 5 == nameColorGrade then
    nameColor = UI_color.C_FFA070EF
  else
    nameColor = UI_color.C_FFC4C4C4
  end
  return nameColor
end
function ItemMarket:setNameColor_Desc(nameColorGrade)
  local nameColor
  if 0 == nameColorGrade then
    nameColor = "<PAColor0xffc4bebe>"
  elseif 1 == nameColorGrade then
    nameColor = "<PAColor0xFF5DFF70>"
  elseif 2 == nameColorGrade then
    nameColor = "<PAColor0xFF4B97FF>"
  elseif 3 == nameColorGrade then
    nameColor = "<PAColor0xFFFFC832>"
  elseif 4 == nameColorGrade then
    nameColor = "<PAColor0xFFFF6C00>"
  elseif 5 == nameColorGrade then
    nameColor = "<PAColor0xFFA070EF>"
  else
    nameColor = "<PAColor0xffc4bebe>"
  end
  return nameColor
end
function InputMLUp_ItemMarket_MainCategoryList(index)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  for key, value in pairs(self._categoryIdxMap) do
    if true == value._isMain then
      local keyElement = self._ui.list_ItemCategory:getElementManager():getByKey(toInt64(0, key), false)
      keyElement:setIsOpen(false)
    end
  end
  if self._selectedMainKey ~= index then
    self._selectedMainKey = index
    self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, index))
  else
    self._selectedMainKey = -1
  end
  self._ui.list_ItemCategory:getElementManager():refillKeyList()
  local heightIndex = self._ui.list_ItemCategory:getIndexByKey(toInt64(0, index))
  self._ui.list_ItemCategory:moveIndex(heightIndex)
  if self._specialCategory.servantList == index and true == _ContentsGroup_ServantWorldMarket then
    selectMarketCategory(self._servantMainKey, -1)
  else
    local indexMap = self._categoryIdxMap[index]
    local categoryInfo = ToClient_GetItemMarketCategoryAt(indexMap._index)
    local categoryValue = categoryInfo:getMainCategoryValue()
    local filterLineCount = categoryInfo:getFilterListCount(0)
    selectMarketCategory(categoryValue:getCategoryNo(), -1)
  end
  self._ui.list_ItemCategory:requestUpdateByKey(toInt64(0, index))
  if true == self._isDirectOpen then
    PaGlobalFunc_ItemMarket_SetIsDirectOpen(false)
  end
end
function InputMLUp_ItemMarket_SubCategoryList(index)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._selectIdx = index
  self._ui.list_MarketItemList:moveTopIndex()
  local indexMap = self._categoryIdxMap[index]
  if nil == indexMap then
    InputMLUp_ItemMarket_SpecialCategoryList(9999)
    return
  end
  local prevSelectedSubKey = self._selectedSubKey
  self._isSearch = false
  if self._selectedSubKey ~= index then
    self._selectedSubKey = index
  else
    self._selectedSubKey = -1
  end
  if self._specialCategory.servantList == indexMap._index and true == _ContentsGroup_ServantWorldMarket then
    ToClient_requestListByWorldMarket(__eWorldMarketKeyType_Servant, self._servantMainKey, 0)
  else
    local categoryInfo = ToClient_GetItemMarketCategoryAt(indexMap._index)
    local filterLineCount = categoryInfo:getFilterListCount(0)
    local mainCategoryValue = categoryInfo:getMainCategoryValue()
    local subCategoryValue = categoryInfo:getSubCategoryAt(indexMap._subIndex)
    ToClient_requestListByWorldMarket(__eWorldMarketKeyType_Item, mainCategoryValue:getCategoryNo(), subCategoryValue:getCategoryNo())
  end
  if -1 ~= prevSelectedSubKey then
    self._ui.list_ItemCategory:requestUpdateByKey(toInt64(0, prevSelectedSubKey))
  end
  self._ui.list_ItemCategory:requestUpdateByKey(toInt64(0, index))
  self._ui.edit_ItemName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_ITEMMARKET_SEARCH_DEFAULT"), false)
  PaGlobalFunc_ItemMarket_SearchItemListClear()
end
function PaGlobalFunc_ItemMarket_Update()
  local self = ItemMarket
  self._ui.list_ItemCategory:getElementManager():clearKey()
  self._ui.list_MarketItemList:getElementManager():clearKey()
  self._ui.list_MarketItemList_Sub:getElementManager():clearKey()
  self._ui.stc_SelectedItemBg:SetShow(false)
  self._ui.btn_BackPage:SetShow(false)
  self._ui.btn_SetRegistAlarm:SetShow(false)
  self._ui.checkBtn_SortBasicPrice:SetShow(false)
  self._ui.btn_SortRegistItemCount:SetShow(false)
  self._ui.CheckButton_SortGrade:SetShow(false)
  self._ui.txt_NoSerchResult:SetShow(true)
  self._ui.txt_NoSerchResult:ComputePos()
  local mainElement = self._ui.list_ItemCategory:getElementManager():getMainElement()
  self._categoryIdxMap = PaGlobalFunc_getItemMarketCategoryListAndSetUI(mainElement)
  self._ui.list_ItemCategory:getElementManager():refillKeyList()
end
function PaGlobalFunc_ItemMarket_UpdateMyInfo()
  local self = ItemMarket
  if nil == getSelfPlayer() then
    return
  end
  local battleFP = getSelfPlayer():get():getBattleFamilyPoint()
  local lifeFP = getSelfPlayer():get():getLifeFamilyPoint()
  local etcFP = getSelfPlayer():get():getEtcFamilyPoint()
  local isTotalFamilyPoint = battleFP + lifeFP + etcFP
  local isTaxBonus = 0
  local currentWeight = getWorldMarketCurrentWeight()
  local maxWeight = getWorldMarketMaxWeight() + getWorldMarketAddWeight() + PaGlobalFunc_WorldMarket_GetAddWeightByBuff()
  local silverInfo = getWorldMarketSilverInfo()
  local walletItemCount = getWorldMarketMyWalletListCount()
  local _const = Defines.s64_const
  local str_AllWeight = makeWeightString(toInt64(0, currentWeight * 1000), 1)
  local str_MaxWeight = makeWeightString(toInt64(0, maxWeight * 1000), 0)
  self._ui.txt_MarketInvenMoneyValue:SetText(makeDotMoney(silverInfo:getItemCount()))
  self._ui.txt_MarketInvenWeightValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MARKETPLACE_VOLUME_VT_PARAM_NONCOLOR", "Weight", str_AllWeight .. " / " .. str_MaxWeight))
  if self._ui.txt_MileageValue:GetShow() == true and self._isOpenedMileageFunction == true then
    local mileageInfo = getWorldMarketMileageInfo()
    self._ui.txt_MileageValue:SetText(makeDotMoney(mileageInfo:getItemCount()))
  end
  if isTotalFamilyPoint >= 1000 and isTotalFamilyPoint <= 3999 then
    isTaxBonus = 0.5
  elseif isTotalFamilyPoint >= 4000 and isTotalFamilyPoint <= 6999 then
    isTaxBonus = 1
  elseif isTotalFamilyPoint >= 7000 then
    isTaxBonus = 1.5
  end
  local player = getSelfPlayer():get()
  local premium = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  local applyPremium = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  if true == applyPremium then
    isTaxBonus = isTaxBonus + 30
  end
  if self._ui.txt_MarketTaxBonus:GetShow() == true then
    self._ui.txt_MarketTaxBonus:SetText(tostring(isTaxBonus) .. "%")
    self._ui.txt_MarketTaxBonus:SetEnableArea(0, 0, self._ui.txt_MarketTaxBonus:GetSizeX() + self._ui.txt_MarketTaxBonus:GetTextSizeX() + 10, 25)
    if true == self._isOpenedMileageFunction then
      self._ui.txt_MarketTaxBonus:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIL_DETAIL_SILVER_COUNT_TITLE", "value", 100))
    end
  end
end
function PaGlobal_MarketPlace_Itemmarket_TaxTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_TAXBONUS_TOOLTIPS_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_TAXBONUS_TOOLTIPS_DESC")
  control = ItemMarket._ui.txt_MarketTaxBonus
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_ItemMarket_UpdateItemList()
  local self = ItemMarket
  local itemListCount = 0
  local list
  if true == self._isItemListSort then
    self._isItemListSort = false
    PaGlobalFunc_ItemMarket_RegistCountSort()
    return
  end
  self:buttonSetShow()
  local itemInfo = getWorldMarketListByItemKey(self._sellInfoItemEnchantKeyRaw)
  if nil ~= itemInfo and self._itemListType.detailListByKey == self._currentListType then
    local itemStaticStatus = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey())):get()
    if nil ~= itemStaticStatus and true == itemStaticStatus:isEnchantable() and not self._isOpenedMileageFunction then
      self._ui.checkButton_SortEnchantLevel:SetShow(true)
    end
  end
  if self._itemListType.categoryList == self._currentListType then
    itemListCount = getWorldMarketListCount()
    list = self._ui.list_MarketItemList
  elseif self._itemListType.detailListByKey == self._currentListType then
    itemListCount = getWorldMarketDetailListCount()
    if true == self._isDirectOpen then
      self._ui.list_MarketItemList_Sub:SetSpanSize(0, 20)
    else
      self._ui.list_MarketItemList_Sub:SetSpanSize(0, 150)
    end
    self._ui.list_MarketItemList_Sub:SetEnableArea(0, 0, self._ui.list_MarketItemList_Sub:GetSizeX(), 450)
    self._ui.list_MarketItemList_Sub:SetSize(self._ui.list_MarketItemList_Sub:GetSizeX(), 450)
    list = self._ui.list_MarketItemList_Sub
  elseif self._itemListType.detailListByCategory == self._currentListType then
    list = self._ui.list_MarketItemList
  elseif self._itemListType.hotListByCategory == self._currentListType then
    itemListCount = getWorldMarketHotListCount()
    self._ui.list_MarketItemList_Sub:SetSpanSize(0, 70)
    self._ui.list_MarketItemList_Sub:SetEnableArea(0, 0, self._ui.list_MarketItemList_Sub:GetSizeX(), 540)
    self._ui.list_MarketItemList_Sub:SetSize(self._ui.list_MarketItemList_Sub:GetSizeX(), 540)
    list = self._ui.list_MarketItemList_Sub
  elseif self._itemListType.waitListByCategory == self._currentListType then
    itemListCount = getWorldMarketWaitListCount()
    self._ui.list_MarketItemList_Sub:SetSpanSize(0, 70)
    self._ui.list_MarketItemList_Sub:SetEnableArea(0, 0, self._ui.list_MarketItemList_Sub:GetSizeX(), 540)
    self._ui.list_MarketItemList_Sub:SetSize(self._ui.list_MarketItemList_Sub:GetSizeX(), 540)
    list = self._ui.list_MarketItemList_Sub
  end
  if nil == list then
    _PA_ASSERT(false, "\237\131\128\236\158\133\236\151\144 \235\167\158\235\138\148 \235\166\172\236\138\164\237\138\184\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  if itemListCount > 0 then
    list:SetShow(true)
    self._ui.txt_NoSerchResult:SetShow(false)
  else
    list:SetShow(false)
    self._ui.btn_SortRegistItemCount:SetShow(false)
    self._ui.checkBtn_SortBasicPrice:SetShow(false)
    self._ui.CheckButton_SortGrade:SetShow(false)
    self._ui.txt_NoSerchResult:SetShow(true)
    self._ui.txt_NoSerchResult:ComputePos()
  end
  list:getElementManager():clearKey()
  for idx = 0, itemListCount - 1 do
    list:getElementManager():pushKey(toInt64(0, idx))
  end
  list:requestUpdateVisible()
end
function ItemMarket:buttonSetShow()
  self._ui.list_MarketItemList:SetShow(false)
  self._ui.list_MarketItemList_Sub:SetShow(false)
  self._ui.stc_SelectedItemBg:SetShow(false)
  self._ui.btn_BackPage:SetShow(false)
  self._ui.btn_SetRegistAlarm:SetShow(false)
  self._ui.btn_SortRegistItemCount:SetShow(false)
  self._ui.checkBtn_SortBasicPrice:SetShow(false)
  self._ui.CheckButton_SortGrade:SetShow(false)
  self._ui.checkButton_SortEnchantLevel:SetShow(false)
  if self._itemListType.categoryList == self._currentListType then
    self._ui.btn_SortRegistItemCount:SetShow(true)
    self._ui.checkBtn_SortBasicPrice:SetShow(true)
    self._ui.CheckButton_SortGrade:SetShow(true)
  elseif self._itemListType.detailListByKey == self._currentListType then
    if true == self._isDirectOpen then
      self._ui.stc_SelectedItemBg:SetShow(false)
      self._ui.btn_BackPage:SetShow(false)
    else
      self._ui.stc_SelectedItemBg:SetShow(true)
      self._ui.btn_BackPage:SetShow(true)
    end
  elseif self._itemListType.detailListByCategory == self._currentListType then
  elseif self._itemListType.hotListByCategory == self._currentListType then
    self._ui.btn_SortRegistItemCount:SetShow(true)
    self._ui.checkBtn_SortBasicPrice:SetShow(true)
    self._ui.CheckButton_SortGrade:SetShow(true)
  elseif self._itemListType.waitListByCategory == self._currentListType then
  end
end
function FromClient_responseHotListByWorldMarket()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._currentListType = 4
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function FromClient_responseWaitListByWorldMarket()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._currentListType = 5
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function FromClient_ItemMarket_ResponseList()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._currentListType = 1
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function FromClient_ItemMarket_ResponseDetailListByCategory()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  self._currentListType = 2
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function FromClient_ItemMarket_ResponseDetailListByKey()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  if true == self._isDirectOpen then
    self._currentListType = 3
    PaGlobalFunc_ItemMarket_UpdateItemList()
    PaGlobalFunc_ItemMarket_SetIsEquipmentOpen(false)
    return
  end
  self._currentListType = 3
  local itemInfo = getWorldMarketListByItemKey(self._sellInfoItemEnchantKeyRaw)
  if nil ~= itemInfo and self._itemListType.detailListByKey == self._currentListType then
    local itemStaticStatus = getItemEnchantStaticStatus(ItemEnchantKey(itemInfo:getMainKey())):get()
    if nil ~= itemStaticStatus and true == itemStaticStatus:isEnchantable() then
      self:clearEnchantLevelUpper()
      ToClient_EnchantLevelSortWorldMarketList(self._isEnchantLevelUpperSort)
    else
      PaGlobalFunc_ItemMarket_UpdateItemList()
    end
  else
    PaGlobalFunc_ItemMarket_UpdateItemList()
  end
end
function FromClient_responseDetailListByWorldMarketByItemKeyWithEnchantSort()
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function FromClient_NotifyCompleteWorldMarketSearchList()
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local list = self._ui.list_search
  if nil == list then
    _PA_ASSERT(false, "\237\131\128\236\158\133\236\151\144 \235\167\158\235\138\148 \235\166\172\236\138\164\237\138\184\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local listSize = ToClient_getSearchWorldMarketItemListSize()
  list:getElementManager():clearKey()
  for idx = 0, listSize - 1 do
    list:getElementManager():pushKey(toInt64(0, idx))
  end
  list:requestUpdateVisible()
end
function FromClient_NotifyCashPushError()
  local remainTime = ToClient_getCashItemPushWorldMarketRemainTime()
  local restrictionDay = ToClient_getRestrictionDay()
  local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMARKET_CASHITEMERROR_MESSAGE", "AfterDay", tostring(restrictionDay))
  if remainTime >= 0 then
    messageboxMemo = messageboxMemo .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMARKET_CASHITEREMIND_TIME", "Time", tostring(convertSecondsToClockTime(remainTime)))
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageboxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_NotifyPriceGroupSellError()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRowPriceGroupSell"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function InputMLUp_ItemMarket_RequestDetailListByKey(itemKey)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  if true == self._isDirectOpen then
    ToClient_requestDetailListByWorldMarketByMainKey(__eWorldMarketKeyType_Item, itemKey)
    PaGlobalFunc_ItemMarket_SearchItemListClear()
    ToClient_clearSearchWorldMarketItemKey()
    return
  end
  if self._itemListType.hotListByCategory == self._currentListType then
    ToClient_requestHotListToWorldMarket()
  elseif self._itemListType.waitListByCategory == self._currentListType then
    ToClient_requestWaitListToWorldMarket()
  else
    self._prevIndex = self._ui.list_MarketItemList:getCurrenttoIndex()
    self:setSelectSlot(itemKey)
    self._isSelectItem = true
    self._sellInfoItemEnchantKeyRaw = itemKey
    ToClient_requestDetailListByWorldMarketByMainKey(__eWorldMarketKeyType_Item, itemKey)
  end
  PaGlobalFunc_ItemMarket_SearchItemListClear()
  ToClient_clearSearchWorldMarketItemKey()
end
function InputMLUp_ItemMarket_RequestBiddingList(idx)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local itemInfo
  if self._itemListType.detailListByKey == self._currentListType then
    itemInfo = getWorldMarketDetailListByIdx(idx)
  elseif self._itemListType.hotListByCategory == self._currentListType then
    itemInfo = getWorldMarketHotListByIdx(idx)
  elseif self._itemListType.waitListByCategory == self._currentListType then
    itemInfo = getWorldMarketWaitListByIdx(idx)
  end
  if nil == itemInfo then
    _PA_ASSERT(false, "\236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : getWorldMarketDetailListByIdx( idx ) or getWorldMarketHotListByIdx( idx ) or getWorldMarketWaitListByIdx( idx )")
    return
  end
  if self._itemListType.waitListByCategory == self._currentListType then
    ToClient_requestDetailOneItemByWorldMarket(ItemEnchantKey(itemInfo:getMainKey(), itemInfo:getSubKey()), false, false, true)
  else
    ToClient_requestGetBiddingList(itemInfo:getKeyType(), itemInfo:getMainKey(), itemInfo:getSubKey(), true, true, PaGlobalFunc_ItemMarket_GetCurrentCategory())
  end
  PaGlobalFunc_ItemMarket_SearchItemListClear()
end
function InputMLUp_ItemMarket_SearchItemList(idx)
  local self = ItemMarket
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ItemMarket")
    return
  end
  local itemKey = ToClient_getSearchWorldMarketItemKey(idx)
  InputMLUp_ItemMarket_RequestDetailListByKey(itemKey)
end
function ItemMarket:itemSubListOpen()
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function ItemMarket:itemSubListClose()
end
function ItemMarket:itemListOpen()
  PaGlobalFunc_ItemMarket_UpdateItemList()
end
function ItemMarket:itemListClose()
end
function PaGlobalFunc_ItemMarket_OnBuyComplete()
  local self = ItemMarket
  InputMLUp_ItemMarket_RequestDetailListByKey(self._sellInfoItemEnchantKeyRaw)
end
function PaGlobalFunc_ItemMarket_Open()
  local self = ItemMarket
  if false == _panel:GetShow() then
    _PA_ASSERT(false, "\235\169\148\236\157\184 \237\140\168\235\132\144\236\157\180 \236\151\180\235\160\164\236\158\136\236\167\128 \236\149\138\236\157\128\235\141\176 \236\149\132\236\157\180\237\133\156 \235\167\136\236\188\147\236\157\132 \236\151\180\235\160\164\234\179\160 \237\150\136\236\138\181\235\139\136\235\139\164. : \237\140\168\235\132\144 : Panel_Window_MarketPlace_Main")
    return
  end
  ToClient_padSnapResetControl()
  self:open()
end
function PaGlobalFunc_ItemMarket_Close()
  local self = ItemMarket
  if false == _panel:GetShow() then
    _PA_ASSERT(false, "\235\169\148\236\157\184 \237\140\168\235\132\144\236\157\180 \236\151\180\235\160\164\236\158\136\236\167\128 \236\149\138\236\157\128\235\141\176 \236\149\132\236\157\180\237\133\156 \235\167\136\236\188\147\236\157\132 \236\151\180\235\160\164\234\179\160 \237\150\136\236\138\181\235\139\136\235\139\164. : \237\140\168\235\132\144 : Panel_Window_MarketPlace_Main")
    return
  end
  self._ui.txt_NoSerchResult:SetShow(false)
  self._isFromEquipmentOpen = false
  self:close()
  FGlobal_ItemMarket_FavoriteItem_Close()
end
function ItemMarket:open()
  self._selectedMainKey = -1
  self._selectedSubKey = -1
  if false == self._isFromEquipmentOpen then
    self._currentListType = 4
  end
  self._isSearch = false
  _mainBg:SetShow(true)
  self._ui.edit_ItemName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_ITEMMARKET_SEARCH_DEFAULT"), false)
  PaGlobalFunc_ItemMarket_SearchItemListClear()
  PaGlobalFunc_ItemMarket_Update()
  if false == self._isFromEquipmentOpen then
    InputMLUp_ItemMarket_SpecialCategoryList(self._specialCategory.hotList)
  end
  self._ui.checkBtn_SerchType:SetCheck(true)
  PaGlobalFunc_ItemMarket_SetSearchType()
  EditItemNameInput_ClearSearchList()
end
function ItemMarket:close()
  _mainBg:SetShow(false)
end
function PaGlobalFunc_ItemMarket_SetIsEquipmentOpen(set)
  ItemMarket._isFromEquipmentOpen = set
end
function PaGlobalFunc_ItemMarket_UpdateForNotice()
end
function PaGlobal_ItemMarket_GetMainListControl()
  return ItemMarket._ui.list_MarketItemList
end
function PaGlobal_ItemMarket_GetSubListControl()
  return ItemMarket._ui.list_MarketItemList_Sub
end
function PaGlobalFunc_ItemMarket_ResetSelectIndex()
  local self = ItemMarket
  self._selectIdx = -1
end
function PaGlobalFunc_ItemMarket_SetIsDirectOpen(set)
  ItemMarket._isDirectOpen = set
end
function PaGlobalFunc_ItemMarket_GetIsDirectOpen()
  return ItemMarket._isDirectOpen
end
function PaGlobalFunc_ItemMarket_OpenbyBarter(itemEnchantKeyRaw)
  local self = ItemMarket
  PaGlobalFunc_ItemMarket_SetIsEquipmentOpen(true)
  PaGlobalFunc_ItemMarket_SetIsDirectOpen(true)
  PaGlobalFunc_MarketPlace_Open(true, true)
  self._sellInfoItemEnchantKeyRaw = itemEnchantKeyRaw
  local keyElement
  for key, value in pairs(self._categoryIdxMap) do
    if true == value._isMain then
      keyElement = self._ui.list_ItemCategory:getElementManager():getByKey(toInt64(0, key), false)
      if true == keyElement:getIsOpen() then
        self._ui.list_ItemCategory:getElementManager():toggle(toInt64(0, key))
      end
    end
  end
  ToClient_requestDetailListByWorldMarketByMainKey(__eWorldMarketKeyType_Item, itemEnchantKeyRaw)
end
function PaGlobalFunc_FromAlarm_Showmarket()
  if _ContentsOption_CH_CreditPoint == true then
    PaGlobalFunc_MarketPlace_CheckCreditPoint(eCreditPointCheckOpenType.openFromEsc)
  else
    PaGlobalFunc_MarketPlace_OpenForWorldMap(nil, true)
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MarketPlace_Init")
