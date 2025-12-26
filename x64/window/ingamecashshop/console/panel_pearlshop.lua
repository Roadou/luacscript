local pearlShop = {
  _init = false,
  _panel = Panel_PearlShop,
  _productInfoOffset = 0,
  _frameContentOffset = 0,
  _productControlOffset = 0,
  _showingDescIndex = -1,
  _showingSubProductIndex = -1,
  _showingChooseProductIndex = -1,
  _scrollContentSize = 0,
  _productControlSmallSize = 70,
  _ui = {
    _productControlList = {},
    _productControlListSize = 0,
    _subProductNameControlListSize = 16,
    _subProductNameControlList = {},
    _chooseProductListSize = 10,
    _chooseProductList = {},
    _chooseProductClickList = {},
    _subItemControlListSize = 20,
    _subItemControlList = {},
    _categoryTitleControl = nil,
    _frameControl = nil,
    _frameContentControl = nil,
    _bgControl = nil,
    _scrollControl = nil,
    _pearlPriceControl = nil,
    _mileagePriceControl = nil,
    _buttonSelectClass = nil,
    _classFilter = nil,
    _classBG = nil,
    _list_characterSelect = nil,
    _btn_buyHitoryDesc = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _listItemGapY = 3,
  _infoListSize = 0,
  _classCount = 0,
  _currentClass = -1,
  _list = {},
  _keyGuideAlign = nil,
  _itemSlotGapX = 0,
  _defaultPearlPriceControlSpanSize = nil,
  _defaultPearlPriceControlTextSpanSize = nil,
  _defaultSilverPriceControlSpanSize = nil,
  _defaultSilverPriceControlTextSpanSize = nil,
  _isKeyGuideShow = false,
  _isBuyHistroy = false
}
function PaGlobalFunc_PearlShopOpen(showPanel, productNo, isOpenBuyHistory)
  pearlShop:open(showPanel, productNo, isOpenBuyHistory)
end
function pearlShop:classFilterReveal()
  self._ui._buttonSelectClass:SetShow(true)
end
function PaGlobalFunc_PearlShop_ClassFilter_Reveal()
  pearlShop:classFilterReveal()
end
function pearlShop:classFilterHidden()
  self._ui._buttonSelectClass:SetShow(false)
end
function PaGlobalFunc_PearlShop_ClassFilter_Hidden()
  pearlShop:classFilterHidden()
end
function PaGlobalFunc_PearlShop_ClassFilterMenu_Open()
  pearlShop:classFilterMenuOpen()
end
function pearlShop:classFilterMenuOpen()
  self:setClassInfo()
  self:hideDesc()
  self._classFilter:SetShow(true)
end
function PaGlobalFunc_PearlShop_ClassFilterMenu_Close()
  pearlShop:classFilterMenuClose()
end
function pearlShop:classFilterMenuClose()
  self._classFilter:SetShow(false)
end
function pearlShop:updateKeyGuideAlign()
  if self._keyGuideAlign == nil then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._bottomKeyGuideBg:SetSpanSize(self._ui._bottomKeyGuideBg:GetSpanSize().x, 0)
  self._ui._bottomKeyGuideBg:ComputePos()
end
function pearlShop:initialize()
  if ToClient_isConsole() == false then
    return
  end
  if self._init == true then
    return
  end
  self._init = true
  local topMenuControl = UI.getChildControl(self._panel, "Static_TopMenu")
  self._ui._categoryTitleControl = UI.getChildControl(topMenuControl, "StaticText_CategoryTitle")
  self._ui._btn_buyHitoryDesc = UI.getChildControl(topMenuControl, "Button_CancelInfo")
  self._ui._buttonSelectClass = UI.getChildControl(topMenuControl, "Button_SelectClass")
  self._ui._classValueControl = UI.getChildControl(self._ui._buttonSelectClass, "StaticText_ClassValue")
  self._ui._classIconControl = UI.getChildControl(self._ui._buttonSelectClass, "Static_SelectClassIcon")
  if _ContentsGroup_RefundCashProduct == true then
    self._ui._btn_buyHitoryDesc:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShop_ShowBuyHistoryDesc()")
  end
  topMenuControl:ComputePos()
  topMenuControl:SetShow(true)
  self._ui._categoryTitleControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopBack()")
  self._ui._buttonSelectClass:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShop_ClassFilterMenu_Open()")
  self._ui._buttonSelectClass:SetShow(true)
  self._ui._classValueControl:SetShow(true)
  self._ui._classIconControl:SetShow(true)
  self._ui._bottomKeyGuide = UI.getChildControl(self._panel, "Static_BottomBg")
  self._ui._bottomKeyGuideBg = UI.getChildControl(self._ui._bottomKeyGuide, "Static_KeyGuide_Bg")
  self._ui._bottomKeyGuideY = UI.getChildControl(self._ui._bottomKeyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui._bottomKeyGuideA = UI.getChildControl(self._ui._bottomKeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui._bottomKeyGuideB = UI.getChildControl(self._ui._bottomKeyGuideBg, "StaticText_B_ConsoleUI")
  self._ui._bottomKeyGuideLBX = UI.getChildControl(self._ui._bottomKeyGuideBg, "StaticText_LBX_ConsoleUI")
  self._keyGuideAlign = Array.new()
  self._keyGuideAlign:push_back(self._ui._bottomKeyGuideLBX)
  self._keyGuideAlign:push_back(self._ui._bottomKeyGuideY)
  self._keyGuideAlign:push_back(self._ui._bottomKeyGuideA)
  self._keyGuideAlign:push_back(self._ui._bottomKeyGuideB)
  self:updateKeyGuideAlign()
  self._ui._frameControl = UI.getChildControl(self._panel, "Panel_PearlShop_ProductListFrame")
  self._ui._frameContentControl = UI.getChildControl(self._ui._frameControl, "Panel_PearlShop_ProductListFrameContent")
  self._ui._bgControl = UI.getChildControl(self._ui._frameContentControl, "Static_MainBG")
  self._ui._scrollControl = UI.getChildControl(self._ui._frameControl, "Panel_PearlShop_ProductListFrameVerticalScroll")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_PearlShopDisplayController_ChangeWeather()")
  self._classCount = getPossibleClassCount()
  self._classFilter = UI.getChildControl(self._panel, "Static_ClassSelectBG")
  self._classBG = UI.getChildControl(self._classFilter, "Static_ClassSelectBG1")
  self._list_characterSelect = UI.getChildControl(self._classBG, "List2_ClassSelect")
  self._list_characterSelect:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PearlShop_UpdateListContent")
  self._list_characterSelect:createChildContent(__ePAUIList2ElementManagerType_List)
  local stc_classSelectTitle = UI.getChildControl(self._classFilter, "StaticText_ClassSelectTitle")
  stc_classSelectTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_CLASSBASE"))
  self._classFilter:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "ToClient_padSnapIgnoreGroupMove()")
  local productControlTemplate = UI.getChildControl(self._ui._bgControl, "Button_ProductClick")
  self:hideDescXXXXX(productControlTemplate)
  UI.getChildControl(productControlTemplate, "StaticText_ProductDesc"):SetTextMode(__eTextMode_AutoWrap)
  productControlTemplate:SetShow(false)
  local pearlPriceControl = UI.getChildControl(productControlTemplate, "StaticText_ProductPearlPrice")
  self._defaultPearlPriceControlSpanSize = pearlPriceControl:GetSpanSize()
  self._defaultPearlPriceControlTextSpanSize = pearlPriceControl:GetTextSpan()
  local silverPriceControl = UI.getChildControl(productControlTemplate, "StaticText_ProductSilverPrice")
  self._defaultSilverPriceControlSpanSize = silverPriceControl:GetSpanSize()
  self._defaultSilverPriceControlTextSpanSize = silverPriceControl:GetTextSpan()
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_PearlShopDisplayController_LBInput(true)")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_PearlShopDisplayController_LBInput(false)")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "PaGlobalFunc_Util_OpenRateView()")
  local size = math.floor(self._ui._frameControl:GetSizeY() / productControlTemplate:GetSizeY()) + 2
  for i = 0, size - 1 do
    local productControl = UI.cloneControl(productControlTemplate, self._ui._bgControl, "Button_ProductClick" .. i)
    self._ui._productControlList[i] = productControl
    self._ui._productControlListSize = self._ui._productControlListSize + 1
    productControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PearlShopSelect(" .. i .. ")")
    productControl:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_PearlShopChangeSubProduct(-1," .. i .. ")")
    productControl:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_PearlShopChangeSubProduct(1," .. i .. ")")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LTPress_DpadLeft, "PaGlobalFunc_PearlShopChangeChooseProductCount(" .. i .. ",false)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LTPress_DpadRight, "PaGlobalFunc_PearlShopChangeChooseProductCount(" .. i .. ",true)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_PearlShopShowDetailChooseProduct(" .. i .. ")")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LBPress_A, "PaGlobalFunc_PearlShopDisplayController_ExcuteOutfitFunction()")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LBPress_DpadLeft, "PaGlobalFunc_PearlShopDisplayController_ChangeOutfitButtonIndex(-1)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LBPress_DpadRight, "PaGlobalFunc_PearlShopDisplayController_ChangeOutfitButtonIndex(1)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LBPress_RStickLeft, "PaGlobalFunc_PearlShopDisplayController_OutfitDurabilityControl(-3)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_LBPress_RStickRight, "PaGlobalFunc_PearlShopDisplayController_OutfitDurabilityControl(3)")
    productControl:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_PearlShopDisplayController_InputPetLookChange(true)")
    local nameControl = UI.getChildControl(productControl, "StaticText_ProductName")
    nameControl:SetTextMode(__eTextMode_Limit_AutoWrap)
    local buttombg = UI.getChildControl(productControl, "Static_ConsoleBottomBg")
    local detailButtonControl = UI.getChildControl(buttombg, "Button_XboxProductSelect_ConsoleUI")
    detailButtonControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopShowDetail()")
    local buyButtonControl = UI.getChildControl(productControl, "Button_Buy")
    buyButtonControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopBuy(" .. i .. ")")
    local subProductNameControlBase = UI.getChildControl(productControl, "StaticText_SubProductName")
    for j = 0, self._ui._subProductNameControlListSize - 1 do
      local subProductNameControl = UI.cloneControl(subProductNameControlBase, productControl, "StaticText_SubProductName" .. j)
      subProductNameControl:SetTextMode(__eTextMode_Limit_AutoWrap)
      subProductNameControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopSelectSubProduct(" .. j .. ")")
    end
    local chooseProductControlBase = UI.getChildControl(productControl, "Static_PackageBanner01")
    self._ui._chooseProductList[i] = {}
    for j = 0, self._ui._chooseProductListSize - 1 do
      self._ui._chooseProductList[i][j] = {}
      local chooseProductControl = UI.cloneControl(chooseProductControlBase, productControl, "StaticText_ChooseProductBanner" .. j)
      local countBG = UI.getChildControl(chooseProductControl, "Static_CountBG")
      self._ui._chooseProductList[i][j].textControl = UI.getChildControl(countBG, "StaticText_Count")
    end
    local subItemControlTemplate = UI.getChildControl(productControl, "Static_ItemSlotBG")
    for j = 0, self._ui._subItemControlListSize - 1 do
      local subItemControl = UI.cloneControl(subItemControlTemplate, productControl, "Static_ItemSlotBG" .. j)
    end
    local subItemControlTemplate = UI.getChildControl(productControl, "Static_ItemSlot")
    for j = 0, self._ui._subItemControlListSize - 1 do
      local subItemControl = UI.cloneControl(subItemControlTemplate, productControl, "Static_ItemSlot" .. j)
    end
    self:hideDescXXX(i)
    productControl:SetPosY(productControlTemplate:GetSizeY() * i)
  end
  for ii = 0, self._ui._chooseProductListSize - 1 do
    self._ui._chooseProductClickList[ii] = 0
  end
  local bottomMenuControl = UI.getChildControl(self._panel, "Static_BottomMenu")
  local pearlBgControl = UI.getChildControl(bottomMenuControl, "Static_MoneyType2BG")
  self._ui._pearlPriceControl = UI.getChildControl(pearlBgControl, "StaticText_MoneyType_Price1")
  local mileageBgControl = UI.getChildControl(bottomMenuControl, "Static_MoneyType3BG")
  self._ui._mileagePriceControl = UI.getChildControl(mileageBgControl, "StaticText_MoneyType_Price1")
  self._itemSlotGapX = UI.getChildControl(productControlTemplate, "Static_ItemSlot"):GetSizeX() + 5
  self._panel:ignorePadSnapMoveToOtherPanel()
  self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PearlShopShowDetail()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_PearlShopCoupon_Open()")
  self._panel:RegisterUpdateFunc("PaGlobalFunc_PearlShopProductListPerFrameUpdate")
end
function PaGlobalFunc_PearlShop_SetClassInfo()
  pearlShop:setClassInfo()
end
local classFilterAllString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKETNEW_FILTER_ALL")
function pearlShop:setClassInfo()
  if self._panel == nil then
    return
  end
  local moveKey
  self._list_characterSelect:getElementManager():clearKey()
  for classType = 0, __eClassType_Count - 1 do
    if PaGlobalFunc_Util_PearlShopClassTypeButtonOpenCheck(classType) == true then
      self._list_characterSelect:getElementManager():pushKey(toInt64(0, classType))
      if moveKey == nil then
        moveKey = toInt64(0, classType)
      end
    end
  end
  self._list_characterSelect:getElementManager():pushKey(toInt64(0, __eClassType_Count))
  if moveKey == nil then
    moveKey = toInt64(0, __eClassType_Count)
  end
  local moveContent = self._list_characterSelect:GetContentByKey(moveKey)
  if moveContent ~= nil then
    local btn_class = UI.getChildControl(moveContent, "Button_Class")
    if btn_class ~= nil then
      ToClient_padSnapChangeToTarget(btn_class)
    end
  end
end
function pearlShop:updateListContent(content, key)
  if self._panel == nil then
    return
  end
  if content == nil then
    return
  end
  local classType = Int64toInt32(key)
  local btn_class = UI.getChildControl(content, "Button_Class")
  btn_class:SetShow(true)
  if classType == __eClassType_Count then
    btn_class:SetText(classFilterAllString)
    btn_class:addInputEvent("Mouse_LUp", "PaGlobalFunc_setClassFilter(" .. -1 .. ")")
  else
    local classTypeName = NewClassData.newClass_String[classType]._classType2String
    if classTypeName == nil then
      classTypeName = ""
    end
    btn_class:SetText(classTypeName)
    btn_class:addInputEvent("Mouse_LUp", "PaGlobalFunc_setClassFilter(" .. classType .. ")")
  end
end
function PaGlobalFunc_setClassFilter(classType)
  pearlShop:setClassFilter(classType)
  pearlShop:hideDesc()
  pearlShop:update()
  local self = pearlShop
  local classString = NewClassData.newClass_String[classType]._classType2String
  if -1 == classType then
    self._ui._classValueControl:SetText(classFilterAllString)
  else
    self._ui._classValueControl:SetText(classString)
  end
  PaGlobalFunc_PearlShopOpen()
end
function pearlShop:setClassFilter(classType)
  self._currentClass = classType
end
function PaGlobalFunc_getClassFilter()
  return pearlShop._currentClass
end
function PaGlobalFunc_PearlShop_CameraInput()
  pearlShop:cameraInput()
end
function pearlShop:cameraInput()
  if Panel_PearlShop_ProductInfo:GetShow() == true then
    return
  end
  if Panel_PearlShop_ProductBuy:GetShow() == true then
    return
  end
  if not PaGlobalFunc_WebControl_GetShow() and not PaGlobalFunc_PearlShopDisplayController_GetOutfitLBDown() then
    if isPadPressed(__eJoyPadInputType_RightStick_Up) then
      self:cameraControl_Rotate("Up")
    elseif isPadPressed(__eJoyPadInputType_RightStick_Down) then
      self:cameraControl_Rotate("Down")
    end
    if isPadPressed(__eJoyPadInputType_RightStick_Left) then
      self:cameraControl_Rotate("Left")
    elseif isPadPressed(__eJoyPadInputType_RightStick_Right) then
      self:cameraControl_Rotate("Right")
    end
  end
  if isPadPressed(__eJoyPadInputType_X) then
    if isPadPressed(__eJoyPadInputType_DPad_Up) then
      self:cameraControl_Move("Up")
    elseif isPadPressed(__eJoyPadInputType_DPad_Down) then
      self:cameraControl_Move("Down")
    elseif isPadPressed(__eJoyPadInputType_DPad_Left) then
      self:cameraControl_Move("Left")
    elseif isPadPressed(__eJoyPadInputType_DPad_Right) then
      self:cameraControl_Move("Right")
    end
  end
  if isPadUp(__eJoyPadInputType_RightTrigger) then
    self:cameraControl_doAction()
  end
end
function pearlShop:cameraControl_doAction()
  if 0 < getIngameCashMall():getCharacterActionCount() then
    local randValue = math.random(0, getIngameCashMall():getCharacterActionCount() - 1)
    getIngameCashMall():setCharacterActionKey(randValue, 0)
  end
end
function pearlShop:cameraControl_Zoom(strDir)
  local upValue = 0
  if strDir == "Up" then
    upValue = -30
  elseif strDir == "Down" then
    upValue = 30
  end
  getIngameCashMall():varyCameraZoom(upValue)
end
function PaGlobalFunc_PearlShop_CamraControl_Zoom(strDir)
  pearlShop:cameraControl_Zoom(strDir)
end
function pearlShop:cameraControl_Rotate(strDir)
  if true == isPadPressed(__eJoyPadInputType_LeftTrigger) then
    self:cameraControl_Zoom(strDir)
    return
  end
  local radianAngle = 0
  local cameraPitch = 0
  if strDir == "Up" then
    cameraPitch = -0.1
  elseif strDir == "Down" then
    cameraPitch = 0.1
  elseif strDir == "Left" then
    radianAngle = 0.1
  elseif strDir == "Right" then
    radianAngle = -0.1
  end
  getIngameCashMall():rotateViewCharacter(radianAngle)
  getIngameCashMall():varyCameraPitch(cameraPitch)
end
function PaGlobalFunc_PearlShop_CamraControl_Rotate(strDir)
  pearlShop:cameraControl_Rotate(strDir)
end
function pearlShop:cameraControl_Move(strDir)
  local radianAngle = 0
  local cameraPitch = 0
  if strDir == "Up" then
    cameraPitch = 1
  elseif strDir == "Down" then
    cameraPitch = -1
  elseif strDir == "Left" then
    radianAngle = -1
  elseif strDir == "Right" then
    radianAngle = 1
  end
  getIngameCashMall():varyCameraPositionByUpAndRightVector(radianAngle, cameraPitch)
end
function PaGlobalFunc_PearlShop_CamraControl_Move(strDir)
  pearlShop:cameraControl_Move(strDir)
end
function PaGlobalFunc_PearlShopCheckShow()
  return pearlShop:checkShow()
end
function PaGlobalFunc_PearlShopUpdate()
  pearlShop:update()
end
function pearlShop:checkShow()
  return self._panel:GetShow()
end
function PaGlobalFunc_PearlShopBack()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  if pearlShop:back() then
    return pearlShop:update()
  end
end
function pearlShop:back()
  if nil ~= Panel_IngameCashSHop_ReturnBack and true == Panel_IngameCashSHop_ReturnBack:GetShow() then
    PaGlobal_IngameCashSHop_ReturnBack_Close()
    return false
  end
  if nil ~= Panel_PearlShop_Coupon and true == Panel_PearlShop_Coupon:GetShow() then
    PaGlobal_PearlShopCoupon_Close()
    return false
  end
  if true == self._classFilter:GetShow() then
    self:classFilterMenuClose()
    return true
  end
  if true == _ContentsGroup_CashShopEventCart then
    if nil ~= Panel_IngameCashShop_BuyOrGift and true == Panel_IngameCashShop_BuyOrGift:GetShow() then
      InGameShopBuy_Close(false)
      return false
    end
    if nil ~= Panel_IngameCashShop_EventCart and true == Panel_IngameCashShop_EventCart:GetShow() then
      IngameCashShopEventCart_Close()
      return false
    end
  end
  if self:hideDesc() then
    return true
  end
  PaGlobalFunc_PearlShopCategoryOpen(false)
  self:close()
end
function pearlShop:open(showPanel, productNo, isOpenBuyHistory)
  if nil ~= Panel_Window_DailyStamp_All and Panel_Window_DailyStamp_All:GetShow() then
    PaGlobalFunc_PearlShopCategory_CheckDailyStampOpened(true)
    PaGlobalFunc_DailyStamp_All_Close()
    Panel_Tooltip_Item_hideTooltip()
    TooltipSimple_Hide()
  end
  if nil ~= Panel_ConsoleKeyGuide and false == Panel_ConsoleKeyGuide:GetShow() then
    self._isKeyGuideShow = true
    Panel_ConsoleKeyGuide:SetShow(true)
  end
  local categoryTitle = PaGlobalFunc_PearlShopCategoryGetCurrentCategoryTitle()
  if _ContentsGroup_RefundCashProduct == true and (nil == categoryTitle or "" == categoryTitle) then
    categoryTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_HISTORY_TAB_TITLE")
  end
  self._ui._bottomKeyGuide:SetSize(getScreenSizeX(), self._ui._bottomKeyGuide:GetSizeY())
  self._ui._bottomKeyGuide:ComputePos()
  self._ui._categoryTitleControl:SetText(categoryTitle)
  self._ui._categoryTitleControl:SetShow(true)
  self._productInfoOffset = 0
  self._frameContentOffset = 0
  self._productControlOffset = 0
  self._showingDescIndex = -1
  self._showingSubProductIndex = -1
  getIngameCashMall():setSearchText("")
  getIngameCashMall():setCurrentClass(self._currentClass)
  getIngameCashMall():setCurrentSort(-1)
  getIngameCashMall():setCurrentSubFilter(-1)
  getIngameCashMall():setCashProductNoRawFilterList()
  if _ContentsGroup_RefundCashProduct == true and isOpenBuyHistory ~= nil and isOpenBuyHistory == true then
    self._infoListSize = ToClient_GetPurchaseItemCount()
    self._isBuyHistroy = true
    self._ui._btn_buyHitoryDesc:SetShow(true)
  else
    self._infoListSize = getIngameCashMall():getCashProductFilterListCount()
    self._ui._btn_buyHitoryDesc:SetShow(false)
  end
  self._list = {}
  for i = 0, self._infoListSize - 1 do
    table.insert(self._list, i)
  end
  local contentSizeY = (self._productControlSmallSize + self._listItemGapY) * self._infoListSize
  self:initContentSize(contentSizeY)
  PaGlobalFunc_PearlShopDisplayController_Open()
  getIngameCashMall():clearEquipViewList()
  getIngameCashMall():changeViewMyCharacter()
  getIngameCashMall():hide()
  getIngameCashMall():show()
  PaGlobalFunc_ConsoleKeyGuide_SetGuide(Defines.ConsoleKeyGuideType.pearlShop)
  PaGlobalFunc_PearlShopSetBKeyGuide()
  if false ~= showPanel then
    self._panel:SetShow(true)
    if _ContentsGroup_RefundCashProduct == true and isOpenBuyHistory ~= nil and isOpenBuyHistory == true then
      ToClient_padSnapChangeToTarget(self._ui._btn_buyHitoryDesc)
    end
  end
  if nil ~= productNo then
    local index
    index = self:getIndexByProductNo(productNo)
    if nil ~= index then
      local controlIndex = self:getControlIndexByIndex(index)
      local control = self:getProductControlByControlIndex(controlIndex)
      PaGlobalFunc_PearlShopSelect(controlIndex)
      ToClient_padSnapChangeToTarget(control)
      return
    end
  end
  if nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  self:update()
end
function pearlShop:initContentSize(size)
  self._ui._frameContentControl:SetSize(self._ui._frameContentControl:GetSizeX(), size)
  self._ui._bgControl:SetSize(self._ui._bgControl:GetSizeX(), size)
  self._ui._frameControl:UpdateContentScroll()
  local scrollAreaSizeY = size - self._ui._frameControl:GetSizeY()
  local scrollUnitSizeY = self._productControlSmallSize + self._listItemGapY
  local scrollInterval = scrollAreaSizeY / scrollUnitSizeY
  if size > self._ui._frameControl:GetSizeY() then
    self._ui._scrollControl:SetShow(true)
  else
    self._ui._scrollControl:SetShow(false)
  end
  self._ui._scrollControl:SetInterval(scrollInterval)
  self._ui._scrollControl:SetControlPos(0)
  self._ui._frameControl:UpdateContentPos()
  self._scrollContentSize = size
end
function pearlShop:addContentSize(sizeOffset)
  if self._isBuyHistroy == true then
    return
  end
  local scrollPos = self._ui._scrollControl:GetControlPos()
  local scrollPosY = scrollPos * self._scrollContentSize
  local nextScrollContentSize = self._scrollContentSize + sizeOffset
  local nextScrollPos = scrollPosY / nextScrollContentSize
  if nextScrollPos > 1 then
    nextScrollPos = 1
  end
  if -1 < self._showingDescIndex then
    local listSize = getIngameCashMall():getCashProductFilterListCount()
    local index = self._productInfoOffset + self._showingDescIndex + 1
    if index > listSize - 4 then
      local scrollpos = index / listSize
      if scrollpos > 1 then
        scrollpos = 1
      end
      self._ui._scrollControl:SetControlPos(scrollpos)
    end
  end
  self._ui._frameContentControl:SetSize(self._ui._frameContentControl:GetSizeX(), nextScrollContentSize)
  self._ui._bgControl:SetSize(self._ui._bgControl:GetSizeX(), nextScrollContentSize)
  self._ui._frameControl:UpdateContentScroll()
  self._ui._frameControl:UpdateContentPos()
  self._ui._frameControl:UpdateContentPosWithSnap()
  self._scrollContentSize = nextScrollContentSize
end
function pearlShop:close()
  self._panel:SetShow(false)
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  FGlobal_Panel_Radar_Show(true, false)
  PaGlobalFunc_Panel_TimeBar_Show(true, false)
  FGlobal_QuestWidget_Open()
  getIngameCashMall():setCurrentClass(-1)
  PaGlobalFunc_PearlShopDisplayController_Close()
  self._currentClass = -1
  if self._isKeyGuideShow then
    self._isKeyGuideShow = false
    Panel_ConsoleKeyGuide:SetShow(false)
  end
  self._isBuyHistroy = false
  buyHistoryCount = 0
end
function PaGlobalFunc_PearlShopClose()
  pearlShop:close()
end
function pearlShop:getProductInfoByIndex(index)
  if index < 0 or index >= self._ui._productControlListSize then
    return nil
  end
  local infoIndex = self._productInfoOffset + index + 1
  if infoIndex > self._infoListSize then
    return nil
  end
  if nil == self._list[infoIndex] then
    return nil
  end
  local productNoRaw = getIngameCashMall():getCashProductNoRawFromFilterList(self._list[infoIndex])
  if nil == productNoRaw then
    return nil
  end
  local productInfo = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  return productInfo
end
function pearlShop:getIndexByProductNo(productNo)
  if nil == productNo then
    return nil
  end
  self:update()
  for index = 0, self._infoListSize - 1 do
    local infoIndex = self._productInfoOffset + index + 1
    if nil ~= self._list[infoIndex] then
      local productNoRaw = getIngameCashMall():getCashProductNoRawFromFilterList(self._list[infoIndex])
      if nil ~= productNoRaw and productNoRaw == productNo then
        return index
      end
    end
  end
  return nil
end
function pearlShop:frameUpdate(delta)
  local frameTop = self._ui._frameControl:GetParentPosY()
  local frameShowingTop = frameTop - self._productControlSmallSize
  local frameBottom = frameTop + self._ui._frameControl:GetSizeY()
  if 0 <= self._showingDescIndex then
    local showingControl = self:getProductControlByIndex(self._showingDescIndex)
    local showingTop = showingControl:GetParentPosY()
    local showingBottom = showingTop + showingControl:GetSizeY()
    if frameBottom < showingTop or frameTop > showingBottom then
      self:hideDesc()
      return true
    end
  end
  local hideIndex = -1
  for i = 0, self._ui._productControlListSize - 1 do
    local control = self:getProductControlByIndex(i)
    local controlBottom = control:GetParentPosY() + control:GetSizeY()
    if frameShowingTop > controlBottom then
      hideIndex = i
      break
    end
  end
  if hideIndex >= 0 then
    local sizeStackToScrollUp = 0
    for i = 0, hideIndex do
      local control = self:getProductControlByIndex(i)
      sizeStackToScrollUp = sizeStackToScrollUp + control:GetSizeY() + self._listItemGapY
    end
    self._frameContentOffset = self._frameContentOffset + sizeStackToScrollUp
    self:addProductInfoOffset(hideIndex + 1)
    return true
  end
  local firstControlTop = self:getProductControlByIndex(0):GetParentPosY()
  if frameShowingTop < firstControlTop then
    local gapSizeY = firstControlTop - frameShowingTop
    local showCount = math.ceil(gapSizeY / (self._productControlSmallSize + self._listItemGapY))
    if showCount > self._productInfoOffset then
      showCount = self._productInfoOffset
    end
    if self:addProductInfoOffset(-1 * showCount) then
      self._frameContentOffset = self._frameContentOffset - showCount * (self._productControlSmallSize + self._listItemGapY)
    end
    return true
  end
  if frameShowingTop > firstControlTop then
    return true
  end
  return false
end
function PaGlobalFunc_PearlShopProductListPerFrameUpdate(delta)
  if pearlShop:frameUpdate(delta) then
    pearlShop:update()
  end
  if nil ~= pearlShop._showingDescIndex and pearlShop._showingDescIndex > -1 and pearlShop:updateControlInfo(pearlShop._showingDescIndex) then
    pearlShop:showDescXXX(pearlShop._showingDescIndex)
  end
end
function pearlShop:changePlatformSpecKey()
  if not self._init then
    return
  end
end
function FromClient_PearlShopInit()
  pearlShop:initialize()
end
function pearlShop:showDesc(index)
  if self._showingDescIndex == index then
    return false
  end
  if self._showingDescIndex >= 0 then
    self:hideDesc()
  end
  local info = self:getProductInfoByIndex(index)
  if nil == info then
    return false
  end
  self._showingDescIndex = index
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if true == info:isChooseCash() then
    self:selectChooseProduct(0)
  elseif subInfoListSize > 1 then
    self:selectSubProduct(0)
  else
    PaGlobalFunc_PearlShopDisplayController_SetProductNoRaw(info:getNoRaw())
  end
  self:update()
  return true
end
function pearlShop:showDescXXX(index)
  local control = self:getProductControlByIndex(index)
  if control == nil then
    return
  end
  local beforeSizeY = control:GetSizeY()
  UI.getChildControl(control, "Static_BG1"):SetShow(true)
  UI.getChildControl(control, "StaticText_SubProductName"):SetShow(false)
  UI.getChildControl(control, "Static_PackageBanner01"):SetShow(false)
  UI.getChildControl(control, "StaticText_ProductDesc"):SetShow(true)
  UI.getChildControl(control, "Static_ItemSlot"):SetShow(false)
  UI.getChildControl(control, "Static_ItemSlotBG"):SetShow(false)
  local buttombg = UI.getChildControl(control, "Static_ConsoleBottomBg")
  local keyGuideBuy = UI.getChildControl(buttombg, "Button_XboxBuy_ConsoleUI")
  local keyGuideDetail = UI.getChildControl(buttombg, "Button_XboxProductSelect_ConsoleUI")
  local keyGuideAddEventCart = UI.getChildControl(buttombg, "Static_Console_AddCart_LS")
  keyGuideBuy:SetShow(true)
  keyGuideDetail:SetShow(true)
  keyGuideAddEventCart:SetShow(false)
  UI.getChildControl(control, "Static_BG2"):SetShow(true)
  local keyGuideChooseDetail = UI.getChildControl(buttombg, "Static_Xbox_ChooseDetail_ConsoleUI")
  local keyGuideChooseCount = UI.getChildControl(buttombg, "Static_Xbox_Count_UPDOWN")
  local topPosY = -1
  local bottomPosY = -1
  local info = self:getProductInfoByIndex(index)
  if nil == info then
    return
  end
  local chooseProduct = info:isChooseCash()
  if true == chooseProduct then
    keyGuideChooseDetail:SetShow(true)
    keyGuideChooseCount:SetShow(true)
    local chooseProductCount = info:chooseCashCount()
    local chooseProductBaseControl = UI.getChildControl(control, "Static_PackageBanner01")
    if nil ~= chooseProductBaseControl then
      for i = 0, self._ui._chooseProductListSize - 1 do
        local chooseBannerControl = UI.getChildControl(control, "StaticText_ChooseProductBanner" .. i)
        chooseBannerControl:SetPosX(chooseProductBaseControl:GetPosX() + (chooseProductBaseControl:GetSizeX() + 10) * (i % 3))
        chooseBannerControl:SetPosY(chooseProductBaseControl:GetPosY() + (chooseProductBaseControl:GetSizeY() + 10) * math.floor(i / 3))
        if i < chooseProductCount then
          chooseBannerControl:SetShow(true)
          if topPosY < 0 then
            topPosY = chooseBannerControl:GetPosY()
          end
          bottomPosY = chooseBannerControl:GetPosY() + chooseBannerControl:GetSizeY()
        end
      end
    end
  else
    keyGuideChooseDetail:SetShow(false)
    keyGuideChooseCount:SetShow(false)
    local subProductNameBaseControl = UI.getChildControl(control, "StaticText_SubProductName")
    for i = 0, self._ui._subProductNameControlListSize - 1 do
      local subControl = UI.getChildControl(control, "StaticText_SubProductName" .. i)
      subControl:SetPosX(subProductNameBaseControl:GetPosX() + 255 * (i % 3))
      subControl:SetPosY(subProductNameBaseControl:GetPosY() + 35 * math.floor(i / 3))
      if 0 < string.len(subControl:GetText()) then
        subControl:SetShow(true)
        if topPosY < 0 then
          topPosY = subControl:GetPosY()
        end
        bottomPosY = subControl:GetPosY() + subControl:GetSizeY()
      end
    end
  end
  local showSubProductFlag = topPosY > 0 and bottomPosY > 0
  UI.getChildControl(control, "StaticText_ProductSubSetName"):SetShow(showSubProductFlag)
  if false == PaGlobalFunc_PearlShopDisplayController_GetOutfitLBDown() then
    UI.getChildControl(control, "Static_ProductSubSetLeftIcon"):SetShow(showSubProductFlag)
    UI.getChildControl(control, "Static_ProductSubSetRightIcon"):SetShow(showSubProductFlag)
  end
  local subProductBgControl = UI.getChildControl(control, "Static_BG2")
  subProductBgControl:SetShow(showSubProductFlag)
  local descPosY = -1
  if showSubProductFlag then
    subProductBgControl:SetSize(subProductBgControl:GetSizeX(), bottomPosY - topPosY + 20)
    local bottomLineControl = UI.getChildControl(subProductBgControl, "Static_HorizontalLine2")
    bottomLineControl:SetPosY(subProductBgControl:GetSizeY())
    descPosY = subProductBgControl:GetPosY() + subProductBgControl:GetSizeY() + 10
  else
    subProductBgControl:SetSize(subProductBgControl:GetSizeX(), 0)
    descPosY = UI.getChildControl(control, "Static_ProductSubSetLeftIcon"):GetPosY()
  end
  local descControl = UI.getChildControl(control, "StaticText_ProductDesc")
  descControl:SetPosY(descPosY)
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  local subInfo
  if 0 > self._showingSubProductIndex then
    descControl:SetText(info:getDescription())
  elseif 0 <= self._showingSubProductIndex and subInfoListSize > self._showingSubProductIndex then
    subInfo = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, self._showingSubProductIndex)
    if nil ~= subInfo then
      descControl:SetText(subInfo:getDescription())
    end
  end
  local subItemPosY = descControl:GetPosY() + descControl:GetTextSizeY() + 10
  local subItemBgControl = UI.getChildControl(control, "Static_ItemSlot")
  subItemBgControl:SetPosY(subItemPosY)
  local subItemBaseControl = UI.getChildControl(control, "Static_ItemSlotBG")
  subItemBaseControl:SetPosY(subItemPosY)
  local subItemCount = info:getItemListCount()
  local aditionalSubItemCount = info:getSubItemListCount()
  if nil ~= subInfo then
    subItemCount = subInfo:getItemListCount()
    aditionalSubItemCount = subInfo:getSubItemListCount()
  end
  local currentCategoryIndex = PaGlobalFunc_PearlShopCategory_GetMainCategoryIndex()
  for i = 0, self._ui._subItemControlListSize - 1 do
    local subControl = UI.getChildControl(control, "Static_ItemSlot" .. i)
    local subControlBG = UI.getChildControl(control, "Static_ItemSlotBG" .. i)
    local showFlag = i < subItemCount
    subControl:SetShow(showFlag)
    subControlBG:SetShow(showFlag)
    if showFlag then
      local itemInfo = info:getItemByIndex(i)
      if nil ~= subInfo then
        itemInfo = subInfo:getItemByIndex(i)
      end
      subControl:SetPosX(subItemBgControl:GetPosX() + i * self._itemSlotGapX + 1)
      subControl:SetPosY(subItemPosY + 11)
      subControl:ChangeTextureInfoNameAsync("icon/" .. itemInfo:getIconPath())
      subControlBG:SetPosX(subItemBaseControl:GetPosX() + i * self._itemSlotGapX)
      subControlBG:SetPosY(subItemPosY + 10)
    end
  end
  for i = 0, aditionalSubItemCount - 1 do
    local controlIndex = i + subItemCount
    local subControl = UI.getChildControl(control, "Static_ItemSlot" .. controlIndex)
    local subControlBG = UI.getChildControl(control, "Static_ItemSlotBG" .. controlIndex)
    subControl:SetShow(true)
    subControlBG:SetShow(true)
    local itemInfo = info:getSubItemByIndex(i)
    if nil ~= subInfo then
      itemInfo = subInfo:getSubItemByIndex(i)
    end
    subControl:SetPosX(subItemBgControl:GetPosX() + controlIndex * self._itemSlotGapX)
    subControl:SetPosY(subItemPosY + 10)
    subControl:ChangeTextureInfoNameAsync("icon/" .. itemInfo:getIconPath())
    subControlBG:SetPosX(subItemBaseControl:GetPosX() + controlIndex * self._itemSlotGapX + 1)
    subControlBG:SetPosY(subItemPosY + 12)
  end
  local bgPosY = subItemBaseControl:GetPosY() + 15
  if subItemCount > 0 then
    bgPosY = bgPosY + subItemBaseControl:GetSizeY()
  else
    UI.getChildControl(buttombg, "Button_XboxProductSelect_ConsoleUI"):SetShow(false)
  end
  local staticText_LimitDesc = UI.getChildControl(control, "StaticText_LimitDesc")
  staticText_LimitDesc:SetShow(false)
  if true == _ContentsGroup_CashShopEventCart then
    local eventIcon = UI.getChildControl(control, "Static_EventIcon")
    local isEventItem = pearlShop:isEventCartItem(info, currentCategoryIndex, index) and true == _ContentsGroup_CashShopEventCart
    if true == isEventItem then
      control:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobalFunc_PearlShop_AddToEventCart(" .. index .. ")")
    else
      control:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
    end
    eventIcon:SetShow(isEventItem)
    keyGuideAddEventCart:SetShow(isEventItem)
  end
  local limitType = info:getCashPurchaseLimitType()
  if CppEnums.CashPurchaseLimitType.None ~= limitType then
    local limitCount = info:getCashPurchaseCount()
    local mylimitCount = getIngameCashMall():getRemainingLimitCount(info:getNoRaw())
    local typeString = ""
    if CppEnums.CashPurchaseLimitType.AtCharacter == limitType then
      typeString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_CHARACTER")
    elseif CppEnums.CashPurchaseLimitType.AtAccount == limitType then
      typeString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_FAMILY")
    end
    staticText_LimitDesc:SetTextMode(__eTextMode_AutoWrap)
    staticText_LimitDesc:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_PURCHASELIMIT", "typeString", typeString, "limitCount", limitCount, "mylimitCount", mylimitCount) .. " (" .. info:getLimitedTypeDesc() .. ")")
    staticText_LimitDesc:SetFontColor(Defines.Color.C_FFF26A6A)
    staticText_LimitDesc:SetShow(true)
    staticText_LimitDesc:SetPosY(bgPosY)
    bgPosY = bgPosY + staticText_LimitDesc:GetTextSizeY()
  end
  local buttombg = UI.getChildControl(control, "Static_ConsoleBottomBg")
  local keyGuideSizeY = pearlShop:alignProductKeyGuide(buttombg, bgPosY)
  bgPosY = bgPosY + keyGuideSizeY + 10
  local bgControl = UI.getChildControl(control, "Static_BG1")
  bgControl:SetSize(bgControl:GetSizeX(), bgPosY - bgControl:GetPosY() - 3)
  control:SetSize(control:GetSizeX(), bgPosY)
  local diffSizeY = control:GetSizeY() - beforeSizeY
  return diffSizeY
end
function pearlShop:hideDescXXXXX(control)
  local beforeSizeY = control:GetSizeY()
  UI.getChildControl(control, "Static_BG1"):SetShow(false)
  UI.getChildControl(control, "StaticText_ProductSubSetName"):SetShow(false)
  UI.getChildControl(control, "Static_ProductSubSetLeftIcon"):SetShow(false)
  UI.getChildControl(control, "Static_ProductSubSetRightIcon"):SetShow(false)
  UI.getChildControl(control, "StaticText_SubProductName"):SetShow(false)
  UI.getChildControl(control, "Static_PackageBanner01"):SetShow(false)
  UI.getChildControl(control, "StaticText_ProductDesc"):SetShow(false)
  UI.getChildControl(control, "Static_ItemSlot"):SetShow(false)
  UI.getChildControl(control, "Static_ItemSlotBG"):SetShow(false)
  UI.getChildControl(control, "Button_Buy"):SetShow(false)
  UI.getChildControl(control, "Button_Gift"):SetShow(false)
  UI.getChildControl(control, "Button_Cart"):SetShow(false)
  local buttombg = UI.getChildControl(control, "Static_ConsoleBottomBg")
  UI.getChildControl(buttombg, "Button_XboxBuy_ConsoleUI"):SetShow(false)
  UI.getChildControl(buttombg, "Button_XboxGift_ConsoleUI"):SetShow(false)
  UI.getChildControl(buttombg, "Button_XboxProductSelect_ConsoleUI"):SetShow(false)
  UI.getChildControl(buttombg, "Static_Xbox_ChooseDetail_ConsoleUI"):SetShow(false)
  UI.getChildControl(buttombg, "Static_Xbox_Count_UPDOWN"):SetShow(false)
  UI.getChildControl(control, "Static_BG2"):SetShow(false)
  UI.getChildControl(control, "StaticText_LimitDesc"):SetShow(false)
  UI.getChildControl(control, "StaticText_PolicyDesc"):SetShow(false)
  for i = 0, self._ui._subProductNameControlListSize - 1 do
    local subControl = UI.getChildControlNoneAssert(control, "StaticText_SubProductName" .. i)
    if nil ~= subControl then
      subControl:SetShow(false)
    end
  end
  for i = 0, self._ui._chooseProductListSize - 1 do
    local subControl = UI.getChildControlNoneAssert(control, "StaticText_ChooseProductBanner" .. i)
    if nil ~= subControl then
      subControl:SetShow(false)
    end
  end
  for i = 0, self._ui._subItemControlListSize - 1 do
    local subbgControl = UI.getChildControlNoneAssert(control, "Static_ItemSlot" .. i)
    if nil ~= subbgControl then
      subbgControl:SetShow(false)
    end
  end
  for i = 0, self._ui._subItemControlListSize - 1 do
    local subControl = UI.getChildControlNoneAssert(control, "Static_ItemSlotBG" .. i)
    if nil ~= subControl then
      subControl:SetShow(false)
    end
  end
  control:SetSize(control:GetSizeX(), self._productControlSmallSize)
  local diffSizeY = control:GetSizeY() - beforeSizeY
  return
end
function pearlShop:hideDescXXX(index)
  local control = self:getProductControlByIndex(index)
  if control == nil then
    return
  end
  local beforeSizeY = control:GetSizeY()
  self:hideDescXXXXX(control)
  local diffSizeY = control:GetSizeY() - beforeSizeY
  return diffSizeY
end
function pearlShop:hideDesc()
  if self._showingDescIndex < 0 then
    return false
  end
  self._showingDescIndex = -1
  self._showingSubProductIndex = -1
  self._ui._bottomKeyGuideA:SetShow(true)
  self:updateKeyGuideAlign()
  self:update()
  return true
end
function pearlShop:alignProductKeyGuide(bottomBG, defaultPosY)
  if nil == bottomBG then
    return
  end
  local keyGuideBuy = UI.getChildControl(bottomBG, "Button_XboxBuy_ConsoleUI")
  local keyGuideDetail = UI.getChildControl(bottomBG, "Button_XboxProductSelect_ConsoleUI")
  local keyGuideChooseDetail = UI.getChildControl(bottomBG, "Static_Xbox_ChooseDetail_ConsoleUI")
  local keyGuideChooseCount = UI.getChildControl(bottomBG, "Static_Xbox_Count_UPDOWN")
  local keyGuideAddEventCart = UI.getChildControl(bottomBG, "Static_Console_AddCart_LS")
  if nil == keyGuideBuy or nil == keyGuideDetail or nil == keyGuideChooseDetail or nil == keyGuideChooseCount or nil == keyGuideAddEventCart then
    return
  end
  local bgSizeX = bottomBG:GetSizeX()
  local keyGuideSizeY = keyGuideBuy:GetSizeY()
  local keyGuides = {
    keyGuideAddEventCart,
    keyGuideDetail,
    keyGuideChooseDetail,
    keyGuideChooseCount,
    keyGuideBuy
  }
  local lineCount = 1
  local prevKeyGuideIndex = -1
  for index = 1, #keyGuides do
    local currentKeyGuide = keyGuides[index]
    if nil ~= currentKeyGuide and true == currentKeyGuide:GetShow() then
      if prevKeyGuideIndex < 0 then
        currentKeyGuide:SetPosX(0)
        currentKeyGuide:SetPosY(defaultPosY)
      else
        local prevKeyGuide = keyGuides[prevKeyGuideIndex]
        if nil ~= prevKeyGuide then
          local currentKeyGuideStartPos = prevKeyGuide:GetPosX() + prevKeyGuide:GetSizeX() + prevKeyGuide:GetTextSizeX() + 20
          local curruentKeyGuideSize = currentKeyGuide:GetSizeX() + currentKeyGuide:GetTextSizeX()
          if bgSizeX < currentKeyGuideStartPos + curruentKeyGuideSize then
            currentKeyGuide:SetPosX(0)
            currentKeyGuide:SetPosY(defaultPosY + keyGuideSizeY * lineCount)
            lineCount = lineCount + 1
          else
            currentKeyGuide:SetPosX(currentKeyGuideStartPos)
            currentKeyGuide:SetPosY(prevKeyGuide:GetPosY())
          end
        end
      end
      prevKeyGuideIndex = index
    end
  end
  return lineCount * keyGuideSizeY
end
function pearlShop:select(controlIndex)
  local index = self:getIndexByControlIndex(controlIndex)
  if self._showingDescIndex == index then
    self:buy(controlIndex)
    return false
  end
  self._showingSubProductIndex = -1
  self._showingChooseProductIndex = -1
  getIngameCashMall():clearChooseProductCount()
  local prevControlIndex = pearlShop:getControlIndexByIndex(pearlShop._showingDescIndex)
  for ii = 0, self._ui._chooseProductListSize - 1 do
    if nil ~= self._ui._chooseProductClickList[ii] then
      self._ui._chooseProductClickList[ii] = 0
    end
    if prevControlIndex >= 0 then
      local productData = self._ui._chooseProductList[prevControlIndex][ii]
      if nil ~= productData then
        productData.textControl:SetText(0)
      end
    end
  end
  return self:showDesc(index)
end
function PaGlobalFunc_PearlShopSelect(controlIndex)
  if controlIndex < 0 or controlIndex == nil then
    return
  end
  if pearlShop._isBuyHistroy == true then
    controlIndex = pearlShop:getRealIndexByControlIndex(pearlShop:getIndexByControlIndex(controlIndex))
    local refundAble = ToClient_CheckRefundAbleCashProductByIndex(controlIndex, true)
    if refundAble == false then
      return
    end
    local eventCartNo = ToClient_GetPurchaseEventCartNoByIndex(controlIndex)
    PaGlobal_IngameCashSHop_ReturnBack_Open(controlIndex, controlIndex, eventCartNo)
    return
  end
  pearlShop._ui._bottomKeyGuideA:SetShow(false)
  pearlShop:updateKeyGuideAlign()
  if pearlShop:select(controlIndex) then
    pearlShop:update()
  end
end
function PaGlobalFunc_PearlShopItemToEventCart()
  if false == _ContentsGroup_CashShopEventCart then
    return
  end
  local index = self:getIndexByControlIndex(controlIndex)
  if self._showingDescIndex == index then
    return
  end
end
function pearlShop:showDetail()
  if self._showingDescIndex < 0 then
    return
  end
  local info = self:getProductInfoByIndex(self._showingDescIndex)
  if nil == info then
    return
  end
  if 0 >= info:getItemListCount() then
    return
  end
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if 0 <= self._showingSubProductIndex and subInfoListSize > self._showingSubProductIndex then
    info = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, self._showingSubProductIndex)
  end
  self._ui._bottomKeyGuideB:SetShow(false)
  self._ui._bottomKeyGuideLBX:SetShow(false)
  self._ui._bottomKeyGuideY:SetShow(false)
  self:updateKeyGuideAlign()
  PaGlobalFunc_PearlShopProductInfoOpen(info, false)
  PaGlobalFunc_PearlShopDisplayController_LBInput(false)
end
function PaGlobalFunc_PearlShopShowDetail()
  return pearlShop:showDetail()
end
function PaGlobalFunc_PearlShopShowDetailChooseProduct(controlIndex)
  local index = pearlShop:getIndexByControlIndex(controlIndex)
  if pearlShop._showingDescIndex ~= index then
    return
  end
  local info = pearlShop:getProductInfoByIndex(pearlShop._showingDescIndex)
  if nil == info then
    return
  end
  local isChooseCash = info:isChooseCash()
  if false == isChooseCash then
    return
  end
  local chooseCashProduct = info:getChooseCashByIndex(pearlShop._showingChooseProductIndex)
  if nil == chooseCashProduct then
    return
  end
  pearlShop._ui._bottomKeyGuideB:SetShow(false)
  pearlShop._ui._bottomKeyGuideLBX:SetShow(false)
  pearlShop._ui._bottomKeyGuideY:SetShow(false)
  pearlShop:updateKeyGuideAlign()
  PaGlobalFunc_PearlShopProductInfoOpen(chooseCashProduct, true)
  PaGlobalFunc_PearlShopDisplayController_LBInput(false)
end
function pearlShop:selectSubProduct(index)
  local info = self:getProductInfoByIndex(self._showingDescIndex)
  if nil == info then
    return
  end
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if index >= subInfoListSize then
    return
  end
  local subInfo = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, index)
  if not subInfo then
    return
  end
  PaGlobalFunc_PearlShopDisplayController_SetProductNoRaw(subInfo:getNoRaw())
  self._showingSubProductIndex = index
  return true
end
function pearlShop:selectChooseProduct(index)
  local info = self:getProductInfoByIndex(self._showingDescIndex)
  if nil == info then
    return
  end
  local chooseCashProductCount = info:chooseCashCount()
  if index >= chooseCashProductCount then
    return
  end
  local chooseCashProduct = info:getChooseCashByIndex(index)
  if nil == chooseCashProduct then
    return
  end
  PaGlobalFunc_PearlShopDisplayController_SetProductNoRaw(chooseCashProduct:getNoRaw())
  self._showingChooseProductIndex = index
  return true
end
function PaGlobalFunc_PearlShopSelectSubProduct(index)
  if pearlShop:selectSubProduct(index) then
    return pearlShop:update()
  end
end
function pearlShop:changeSubProduct(diffIndex)
  if self._showingSubProductIndex < 0 then
    return
  end
  local index = self._showingSubProductIndex + diffIndex
  if index < 0 then
    return
  end
  local info = self:getProductInfoByIndex(self._showingDescIndex)
  if nil == info then
    return
  end
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if index >= subInfoListSize then
    return
  end
  return self:selectSubProduct(index)
end
function pearlShop:changeChooseProduct(diffIndex)
  if self._showingChooseProductIndex < 0 then
    return
  end
  local index = self._showingChooseProductIndex + diffIndex
  if index < 0 then
    return
  end
  local info = self:getProductInfoByIndex(self._showingDescIndex)
  if nil == info then
    return
  end
  local chooseProductCount = info:chooseCashCount()
  if index >= chooseProductCount then
    return
  end
  return self:selectChooseProduct(index)
end
function PaGlobalFunc_PearlShopSetBKeyGuide()
  local self = pearlShop
  self._ui._bottomKeyGuideB:SetShow(true)
  self._ui._bottomKeyGuideLBX:SetShow(true)
  self._ui._bottomKeyGuideY:SetShow(true)
  self:updateKeyGuideAlign()
end
function PaGlobalFunc_PearlShopChangeSubProduct(diffIndex, controlIndex)
  local info = pearlShop:getProductInfoByIndex(pearlShop._showingDescIndex)
  if nil == info then
    return
  end
  local isChooseCash = info:isChooseCash()
  if true == isChooseCash then
    local index = pearlShop:getIndexByControlIndex(controlIndex)
    if pearlShop._showingDescIndex ~= index then
      return
    end
    if false == pearlShop:changeChooseProduct(diffIndex) then
      return
    end
  elseif false == pearlShop:changeSubProduct(diffIndex) then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  return pearlShop:update()
end
function PaGlobalFunc_PearlShopChangeChooseProductCount(controlIndex, isUp)
  local index = pearlShop:getIndexByControlIndex(controlIndex)
  if pearlShop._showingDescIndex ~= index then
    return
  end
  local info = pearlShop:getProductInfoByIndex(pearlShop._showingDescIndex)
  if nil == info then
    return
  end
  local isChooseCash = info:isChooseCash()
  if false == isChooseCash then
    return
  end
  local validChooseCount = info:chooseCashCount()
  local mustChooseCount = info:mustChooseCount()
  local isChooseDuplicate = info:isChooseDuplicaite()
  local checkCount = 0
  local isEnable = false
  for ii = 0, validChooseCount - 1 do
    if nil ~= pearlShop._ui._chooseProductClickList[ii] then
      checkCount = checkCount + pearlShop._ui._chooseProductClickList[ii]
    end
  end
  local chooseIndex = pearlShop._showingChooseProductIndex
  if -1 == chooseIndex then
    return
  end
  if nil == pearlShop._ui._chooseProductClickList[chooseIndex] then
    return
  end
  if checkCount == mustChooseCount and true == isUp then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_CHOOSECOUNTOVER"))
    return
  else
    if true == isUp then
      if false == isChooseDuplicate and 1 == pearlShop._ui._chooseProductClickList[chooseIndex] then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_CHOOSECOUNTDUPLICATE"))
        return
      end
      pearlShop._ui._chooseProductClickList[chooseIndex] = pearlShop._ui._chooseProductClickList[chooseIndex] + 1
    else
      if 0 == pearlShop._ui._chooseProductClickList[chooseIndex] then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_CHOOSECOUNTMINIMUM"))
        return
      end
      pearlShop._ui._chooseProductClickList[chooseIndex] = pearlShop._ui._chooseProductClickList[chooseIndex] - 1
    end
    local controlIndex = pearlShop:getControlIndexByIndex(pearlShop._showingDescIndex)
    local productData = pearlShop._ui._chooseProductList[controlIndex][chooseIndex]
    if nil == productData then
      return
    end
    productData.textControl:SetText(pearlShop._ui._chooseProductClickList[chooseIndex])
  end
  getIngameCashMall():setChooseProductCount(chooseIndex, isUp)
end
function pearlShop:buy(controlIndex)
  local index = self:getIndexByControlIndex(controlIndex)
  local info = self:getProductInfoByIndex(index)
  if nil == info then
    return
  end
  local checkNickItem = PaGlobal_PearlShop_CheckNickNameItem(info:getNoRaw())
  if true == checkNickItem then
    return
  end
  if true == info:isChooseCash() then
    local returnValue = self:checkChooseItemBuy(controlIndex)
    if false == returnValue then
      return
    end
  end
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if 0 <= self._showingSubProductIndex and subInfoListSize > self._showingSubProductIndex then
    info = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, self._showingSubProductIndex)
  end
  self._ui._bottomKeyGuideB:SetShow(false)
  self._ui._bottomKeyGuideLBX:SetShow(false)
  self._ui._bottomKeyGuideY:SetShow(false)
  self:updateKeyGuideAlign()
  PaGlobalFunc_PearlShopProductBuyOpen(info)
end
function PaGlobalFunc_PearlShopBuy(controlIndex)
  return pearlShop:buy(controlIndex)
end
function PaGlobalFunc_PearlShopEnableKeyGuide(isShow)
  local self = pearlShop
  if true == PaGlobalFunc_PearlShopProductInfoCheckShow() then
    return
  end
  self._ui._bottomKeyGuideA:SetShow(isShow)
  local control = self:getProductControlByIndex(self._showingDescIndex)
  if control == nil then
    return
  end
  UI.getChildControl(control, "Static_ConsoleBottomBg"):SetShow(isShow)
  UI.getChildControl(control, "Static_ProductSubSetLeftIcon"):SetShow(isShow)
  UI.getChildControl(control, "Static_ProductSubSetRightIcon"):SetShow(isShow)
  if true == isShow then
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PearlShopShowDetail()")
  else
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
  self:updateKeyGuideAlign()
end
function pearlShop:addProductInfoOffset(offset)
  if self._productInfoOffset + offset < 0 then
    return false
  end
  self._productInfoOffset = self._productInfoOffset + offset
  self._productControlOffset = (self._productControlOffset + offset) % self._ui._productControlListSize
  if 0 <= self._showingDescIndex then
    self._showingDescIndex = self._showingDescIndex - offset
  end
  return true
end
function pearlShop:getControlIndexByIndex(index)
  local controlIndex = self._productControlOffset + index
  controlIndex = controlIndex % self._ui._productControlListSize
  return controlIndex
end
function pearlShop:getIndexByControlIndex(controlIndex)
  local index = controlIndex - self._productControlOffset
  index = (index + self._ui._productControlListSize) % self._ui._productControlListSize
  return index
end
function pearlShop:getProductControlByIndex(index)
  local controlIndex = self:getControlIndexByIndex(index)
  return self:getProductControlByControlIndex(controlIndex)
end
function pearlShop:getProductControlByControlIndex(index)
  if index >= 0 and index < self._ui._productControlListSize then
    return self._ui._productControlList[index]
  end
  return nil
end
function IngameCashShop_SortCash_Byindex(lhs, rhs)
  local lhsRaw = getIngameCashMall():getCashProductNoRawFromFilterList(lhs)
  local rhsRaw = getIngameCashMall():getCashProductNoRawFromFilterList(rhs)
  if nil == rhsRaw or nil == lhsRaw then
    return false
  end
  return IngameCashShop_SortCash(lhsRaw, rhsRaw)
end
function pearlShop:update()
  if not self._init then
    return
  end
  local pos = self._frameContentOffset
  local diffSizeY = 0
  for i = 0, self._ui._productControlListSize - 1 do
    local control = self:getProductControlByIndex(i)
    if control ~= nil then
      control:SetPosY(pos)
      local updateResult = self:updateControlInfo(i)
      if updateResult ~= nil and updateResult == true then
        if self._showingDescIndex == i then
          diffSizeY = diffSizeY + self:showDescXXX(i)
        else
          diffSizeY = diffSizeY + self:hideDescXXX(i)
        end
        pos = pos + control:GetSizeY() + self._listItemGapY
      else
        control:SetShow(false)
      end
    end
  end
  if diffSizeY ~= 0 then
    self:addContentSize(diffSizeY)
  end
  self:update_pearl()
  self:update_mileage()
end
function pearlShop:update_pearl()
  local pearl = toInt64(0, 0)
  local pearlItem = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  if pearlItem then
    pearl = pearlItem:get():getCount_s64()
  end
  self._ui._pearlPriceControl:SetText(makeDotMoney(pearl))
end
function pearlShop:update_mileage()
  local mileage = toInt64(0, 0)
  local mileageItem = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
  if mileageItem then
    mileage = mileageItem:get():getCount_s64()
  end
  self._ui._mileagePriceControl:SetText(makeDotMoney(mileage))
end
function pearlShop:getRealIndexByControlIndex(index)
  local infoIndex = self._productInfoOffset + index + 1
  if infoIndex > self._infoListSize then
    return nil
  end
  if nil == self._list[infoIndex] then
    UI.ASSERT_NAME(false, "infoIndex\236\151\144 \235\140\128\236\157\145\235\144\152\235\138\148 \236\157\184\235\141\177\236\138\164\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return nil
  end
  return self._list[infoIndex]
end
function pearlShop:updateControlInfo(index)
  local control = self:getProductControlByIndex(index)
  if control == nil then
    UI.ASSERT_NAME(false, "control \236\160\149\235\179\180\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  local info
  if self._isBuyHistroy == true then
    local realIndex = self:getRealIndexByControlIndex(index)
    if realIndex == nil then
      control:SetShow(false)
      UI.ASSERT_NAME(false, "realIndex \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return false
    end
    local productNoRaw = ToClient_GetPurchaseItemCashProdcutNoByIndex(realIndex)
    if productNoRaw == nil then
      control:SetShow(false)
      UI.ASSERT_NAME(false, "productNoRaw \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return false
    end
    info = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  else
    info = self:getProductInfoByIndex(index)
  end
  if info == nil then
    control:SetShow(false)
    return false
  end
  control:SetShow(true)
  local nameControl = UI.getChildControl(control, "StaticText_ProductName")
  nameControl:SetText(info:getDisplayName())
  local subTitleControl = UI.getChildControl(control, "StaticText_ProductSubSetName")
  subTitleControl:SetText(info:getDisplaySubName())
  local tagTexture = {
    [0] = {
      0,
      0,
      0,
      0
    },
    {
      1,
      1,
      230,
      60
    },
    {
      1,
      61,
      230,
      120
    },
    {
      231,
      1,
      460,
      60
    },
    {
      231,
      121,
      460,
      180
    },
    {
      231,
      61,
      460,
      120
    },
    {
      1,
      121,
      230,
      180
    },
    {
      139,
      433,
      373,
      497
    }
  }
  local imageControl = UI.getChildControl(control, "Static_ProductBannerImage")
  if info:getPackageIcon() then
    imageControl:ChangeTextureInfoNameAsync(info:getPackageIcon())
  else
    imageControl:ChangeTextureInfoNameAsync(nil)
  end
  local soldOutTexture = UI.getChildControl(control, "Static_SoldOut")
  control:SetMonoTone(false)
  control:SetEnable(true)
  soldOutTexture:SetShow(false)
  local limitType = info:getCashPurchaseLimitType()
  if CppEnums.CashPurchaseLimitType.None ~= limitType then
    local limitCount = info:getCashPurchaseCount()
    local mylimitCount = getIngameCashMall():getRemainingLimitCount(info:getNoRaw())
    if limitCount > 0 and mylimitCount == 0 then
      control:SetMonoTone(true)
      control:SetEnable(false)
      soldOutTexture:SetShow(true)
    end
  end
  local speedUserType = __eEAdmissionSpeedChannelType_Count
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper ~= nil then
    speedUserType = temporaryWrapper:getMyAdmissionToSpeedServer()
  end
  local cashProductBuySpeedUserType = info:getSpeedUserType(speedUserType)
  local isForSpeedUserCashItem = info:isForSpeedUserCashItem()
  if isForSpeedUserCashItem == true and cashProductBuySpeedUserType == false then
    control:SetMonoTone(true)
    control:SetEnable(false)
    soldOutTexture:SetShow(true)
  end
  local tagControl = UI.getChildControl(control, "Static_ProductBannerSaleType")
  local tagType = info:getTag()
  if 7 == tagType then
    tagControl:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/ingamecashshop/CashShop_04.dds")
  else
    tagControl:ChangeTextureInfoNameAsync("renewal/ETC/Console_ETC_CashShop_00.dds")
  end
  local x1, y1, x2, y2 = setTextureUV_Func(tagControl, tagTexture[tagType][1], tagTexture[tagType][2], tagTexture[tagType][3], tagTexture[tagType][4])
  tagControl:getBaseTexture():setUV(x1, y1, x2, y2)
  tagControl:setRenderTexture(tagControl:getBaseTexture())
  local tagType = info:getTag()
  if (4 == tagType or 5 == tagType) and not info:isApplyDiscount() and info:isDefinedDiscount() then
    tagControl:SetShow(false)
  else
    tagControl:SetShow(true)
  end
  local pearlPriceControl = UI.getChildControl(control, "StaticText_ProductPearlPrice")
  local mileagePriceControl = UI.getChildControl(control, "StaticText_ProductMileagePrice")
  local silverPriceControl = UI.getChildControl(control, "StaticText_ProductSilverPrice")
  local discountControl = UI.getChildControl(control, "StaticText_DiscountPrice")
  local discountIcon = UI.getChildControl(control, "StaticText_DiscountIcon")
  local discountDescControl = UI.getChildControl(control, "StaticText_ProductSaleDate")
  if info:isApplyDiscount() then
    local endDiscountTimeValue = PATime(info:getEndDiscountTime():get_s64())
    local endDiscountTimeStr = ""
    if isGameTypeNA() then
      endDiscountTimeStr = convertStringFromDatetime(info:getRemainDiscountTime())
    else
      endDiscountTimeStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_DISCOUNTTIME", "GetYear", string.sub(tostring(endDiscountTimeValue:GetYear()), 3, 4), "GetMonth", tostring(endDiscountTimeValue:GetMonth()), "GetDay", tostring(endDiscountTimeValue:GetDay())) .. " " .. string.format("%.02d", endDiscountTimeValue:GetHour()) .. ":" .. string.format("%.02d", endDiscountTimeValue:GetMinute())
    end
    discountDescControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_DISCOUNT_SIMPLE", "endDiscountTime", endDiscountTimeStr))
    discountDescControl:SetShow(true)
    discountControl:SetText(makeDotMoney(info:getOriginalPrice()))
    discountControl:SetShow(true)
    local frameTop = self._ui._frameControl:GetParentPosY()
    local frameShowingTop = frameTop - self._productControlSmallSize
    local frameBottom = frameTop + self._ui._frameControl:GetSizeY()
    local discountControlPosY = control:GetParentPosY() + discountControl:GetPosY()
    if frameTop < discountControlPosY and frameBottom > discountControlPosY then
      discountControl:SetLineRender(true)
    else
      discountControl:SetLineRender(false)
    end
    discountIcon:SetShow(0 ~= info:getDiscountPercent())
    discountIcon:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CASHSHOP_DISPLAYPERCET", "percent", info:getDiscountPercent()))
  elseif true == info:isApplySellTimeLimit() then
    discountControl:SetShow(false)
    discountIcon:SetShow(false)
    local endSellTimeValue = PATime(info:getEndSellTime():get_s64())
    local endSellTimeStr = ""
    if true == isGameTypeNA() then
      endSellTimeStr = convertStringFromDatetime(info:getRemainSellTime())
    else
      endSellTimeStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", string.sub(tostring(endSellTimeValue:GetYear()), 3, 4), "GetMonth", tostring(endSellTimeValue:GetMonth()), "GetDay", tostring(endSellTimeValue:GetDay())) .. " " .. string.format("%.02d", endSellTimeValue:GetHour()) .. ":" .. string.format("%.02d", endSellTimeValue:GetMinute())
    end
    discountDescControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SELL_SIMPLE", "endSellTime", endSellTimeStr))
    discountDescControl:SetShow(true)
  else
    discountControl:SetShow(false)
    discountDescControl:SetShow(false)
    discountIcon:SetShow(false)
  end
  pearlPriceControl:SetText(makeDotMoney(info:getProductPrice()))
  pearlPriceControl:SetShow(__ePriceType_Pearl == info:getProductPriceType())
  mileagePriceControl:SetText(makeDotMoney(info:getProductPrice()))
  mileagePriceControl:SetShow(__ePriceType_Mileage == info:getProductPriceType())
  silverPriceControl:SetText(makeDotMoney(info:getProductPrice()))
  silverPriceControl:SetShow(__ePriceType_Sliver == info:getProductPriceType())
  if info:isApplyDiscount() then
    if true == pearlPriceControl:GetShow() then
      pearlPriceControl:SetText(makeDotMoney(info:getDiscountPrice()))
    else
      mileagePriceControl:SetText(makeDotMoney(info:getDiscountPrice()))
    end
  end
  if true == _ContentsGroup_CashShopEventCart then
    local currentCategoryIndex = PaGlobalFunc_PearlShopCategory_GetMainCategoryIndex()
    local eventIcon = UI.getChildControl(control, "Static_EventIcon")
    local isEventItem = pearlShop:isEventCartItem(info, currentCategoryIndex, index) and true == _ContentsGroup_CashShopEventCart
    eventIcon:SetShow(isEventItem)
  end
  if true == info:isChooseCash() then
    for i = 0, self._ui._chooseProductListSize - 1 do
      local subControl = UI.getChildControl(control, "StaticText_ChooseProductBanner" .. i)
      local chooseCashProduct = info:getChooseCashByIndex(i)
      if nil ~= subControl and nil ~= chooseCashProduct then
        local selectedLine = UI.getChildControl(subControl, "Static_SelectedLine")
        if nil ~= selectedLine then
          selectedLine:SetShow(false)
        end
        subControl:ChangeTextureInfoNameAsync(chooseCashProduct:getPackageIcon())
        if i == self._showingChooseProductIndex and index == self._showingDescIndex then
          if nil ~= selectedLine then
            selectedLine:SetShow(true)
          end
          local originalPrice = 0
          originalPrice = makeDotMoney(info:getProductPrice())
          pearlPriceControl:SetText(originalPrice)
          subTitleControl:SetText(chooseCashProduct:getDisplayName())
          local leftIcon = UI.getChildControl(control, "Static_ProductSubSetLeftIcon")
          local rightIcon = UI.getChildControl(control, "Static_ProductSubSetRightIcon")
          if 350 < subTitleControl:GetTextSizeX() then
            leftIcon:SetSpanSize(-300, 0)
            rightIcon:SetSpanSize(300, 0)
          else
            leftIcon:SetSpanSize(-200, 0)
            rightIcon:SetSpanSize(200, 0)
          end
          local tagType = info:getTag()
          local x1, y1, x2, y2 = setTextureUV_Func(tagControl, tagTexture[tagType][1], tagTexture[tagType][2], tagTexture[tagType][3], tagTexture[tagType][4])
          tagControl:getBaseTexture():setUV(x1, y1, x2, y2)
          tagControl:setRenderTexture(tagControl:getBaseTexture())
          if (4 == tagType or 5 == tagType) and not info:isApplyDiscount() and info:isDefinedDiscount() then
            tagControl:SetShow(false)
          else
            tagControl:SetShow(true)
          end
          if info:isApplyDiscount() then
            discountControl:SetText(originalPrice)
            pearlPriceControl:SetText(makeDotMoney(info:getDiscountPrice()))
            discountIcon:SetShow(0 ~= info:getDiscountPercent())
            discountIcon:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CASHSHOP_DISPLAYPERCET", "percent", info:getDiscountPercent()))
            discountControl:SetShow(true)
            discountControl:SetLineRender(true)
          else
            discountControl:SetShow(false)
            discountIcon:SetShow(false)
            discountControl:SetLineRender(false)
          end
        end
      end
      if 0 <= self._showingDescIndex then
        local controlIndex = self:getControlIndexByIndex(self._showingDescIndex)
        local productData = self._ui._chooseProductList[controlIndex][i]
        if nil == productData then
          return false
        end
        productData.textControl:SetText(self._ui._chooseProductClickList[i])
      end
    end
  else
    local groupIndex = info:getOfferGroup()
    local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
    for i = 0, self._ui._subProductNameControlListSize - 1 do
      local subControl = UI.getChildControl(control, "StaticText_SubProductName" .. i)
      local subName = ""
      local subInfo
      if i < subInfoListSize and subInfoListSize > 1 then
        subInfo = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, i)
        subName = subInfo:getDisplaySubName()
        if subInfo:isApplyDiscount() then
          subName = "<PAColor0xfface400>" .. subName
        elseif 5 == subInfo:getTag() then
        end
      end
      subControl:SetText(subName)
      if i == self._showingSubProductIndex and index == self._showingDescIndex then
        subInfo = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, i)
        local originalPrice = 0
        originalPrice = makeDotMoney(subInfo:getProductPrice())
        pearlPriceControl:SetText(originalPrice)
        subTitleControl:SetText(subName)
        subControl:SetText("<PAColor0xffeeeeee>" .. subName)
        local leftIcon = UI.getChildControl(control, "Static_ProductSubSetLeftIcon")
        local rightIcon = UI.getChildControl(control, "Static_ProductSubSetRightIcon")
        if 350 < subTitleControl:GetTextSizeX() then
          leftIcon:SetSpanSize(-300, 0)
          rightIcon:SetSpanSize(300, 0)
        else
          leftIcon:SetSpanSize(-200, 0)
          rightIcon:SetSpanSize(200, 0)
        end
        local tagType = subInfo:getTag()
        local x1, y1, x2, y2 = setTextureUV_Func(tagControl, tagTexture[tagType][1], tagTexture[tagType][2], tagTexture[tagType][3], tagTexture[tagType][4])
        tagControl:getBaseTexture():setUV(x1, y1, x2, y2)
        tagControl:setRenderTexture(tagControl:getBaseTexture())
        if (4 == tagType or 5 == tagType) and not subInfo:isApplyDiscount() and subInfo:isDefinedDiscount() then
          tagControl:SetShow(false)
        else
          tagControl:SetShow(true)
        end
        if subInfo:isApplyDiscount() then
          discountControl:SetText(originalPrice)
          pearlPriceControl:SetText(makeDotMoney(subInfo:getDiscountPrice()))
          discountIcon:SetShow(0 ~= subInfo:getDiscountPercent())
          discountIcon:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CASHSHOP_DISPLAYPERCET", "percent", subInfo:getDiscountPercent()))
          discountControl:SetShow(true)
          discountControl:SetLineRender(true)
        else
          discountControl:SetShow(false)
          discountIcon:SetShow(false)
          discountControl:SetLineRender(false)
        end
      end
    end
  end
  if pearlPriceControl:GetShow() then
    local pearlPriceControlTextSizeX = pearlPriceControl:GetTextSizeX()
    if pearlPriceControlTextSizeX > math.abs(self._defaultPearlPriceControlTextSpanSize.x) then
      pearlPriceControl:SetSpanSize(self._defaultPearlPriceControlSpanSize.x + 10, self._defaultPearlPriceControlSpanSize.y)
      pearlPriceControl:SetTextSpan(self._defaultPearlPriceControlTextSpanSize.x - 10, self._defaultPearlPriceControlTextSpanSize.y)
    else
      pearlPriceControl:SetSpanSize(self._defaultPearlPriceControlSpanSize.x, self._defaultPearlPriceControlSpanSize.y)
      pearlPriceControl:SetTextSpan(self._defaultPearlPriceControlTextSpanSize.x, self._defaultPearlPriceControlTextSpanSize.y)
    end
  end
  if silverPriceControl:GetShow() then
    local silverPriceControlTextSizeX = silverPriceControl:GetTextSizeX()
    local textSpaceX = math.abs(self._defaultSilverPriceControlSpanSize.x) - silverPriceControl:GetSizeX()
    if silverPriceControlTextSizeX > textSpaceX then
      local addSpanX = silverPriceControlTextSizeX - textSpaceX
      silverPriceControl:SetSpanSize(self._defaultSilverPriceControlSpanSize.x + addSpanX, self._defaultSilverPriceControlSpanSize.y)
      silverPriceControl:SetTextSpan(self._defaultSilverPriceControlTextSpanSize.x - addSpanX, self._defaultSilverPriceControlTextSpanSize.y)
    else
      silverPriceControl:SetSpanSize(self._defaultSilverPriceControlSpanSize.x, self._defaultSilverPriceControlSpanSize.y)
      silverPriceControl:SetTextSpan(self._defaultSilverPriceControlTextSpanSize.x, self._defaultSilverPriceControlTextSpanSize.y)
    end
  end
  local reason = UI.getChildControl(control, "StaticText_Reason")
  reason:SetShow(false)
  if self._isBuyHistroy == true and _ContentsGroup_RefundCashProduct == true then
    control:SetIgnore(false)
    control:SetMonoTone(false)
    control:SetEnable(true)
    self:buyHistorySetting(control, index)
  end
  return true
end
function PaGlobalFunc_PearlShopGetChooseProductList()
  if nil == Panel_PearlShop then
    return
  end
  return pearlShop._ui._chooseProductClickList
end
function PaGlobalFunc_PearlShopGetProductControlByIndex(index)
  if nil == Panel_PearlShop then
    return
  end
  return pearlShop:getProductControlByIndex(index)
end
function pearlShop:checkChooseItemBuy(controlIndex)
  local index = self:getIndexByControlIndex(controlIndex)
  local info = self:getProductInfoByIndex(index)
  if nil == info then
    return false
  end
  local checkCount = 0
  local validChooseCashProduct = info:chooseCashCount()
  for ii = 0, validChooseCashProduct - 1 do
    checkCount = checkCount + self._ui._chooseProductClickList[ii]
  end
  if checkCount ~= info:mustChooseCount() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_CHOOSECOUNTDIFFERENT"))
    return false
  end
  return true
end
function pearlShop:handleCompleteBuy()
  if PaGlobalFunc_PearlShopProductBuyCheckShow() then
    PaGlobalFunc_PearlShopProductBuyClose()
  end
  return true
end
function pearlShop:isEventCartItem(mainCategoryInfo, currentMainCategoryIndex, controlIndex)
  if false == _ContentsGroup_CashShopEventCart then
    return false
  end
  if nil == mainCategoryInfo or nil == currentMainCategoryIndex or nil == controlIndex then
    return false
  end
  local eventType = mainCategoryInfo:getEventCartType()
  local mainTabInfo = ToClient_GetMainCategoryStaticStatusWrapperByKeyRaw(currentMainCategoryIndex + 1)
  if nil == mainTabInfo then
    return false
  end
  local isOnListButton = 0 == eventType or 1 == eventType
  local isOnSlotButton = 0 == eventType or 2 == eventType
  local eventListKey = mainTabInfo:getEventKey()
  local eventSlotKey = mainTabInfo:getEventSlotKey()
  local isOpenEventList = IngameCashShop_CheckOpenEventCart(eventListKey)
  local isOpenEventSlot = IngameCashShop_CheckOpenEventCart(eventSlotKey)
  if eventListKey > 0 and true == isOpenEventList and eventSlotKey > 0 and true == isOpenEventSlot then
    return isOnListButton
  elseif eventSlotKey > 0 and true == isOpenEventSlot then
    return false
  elseif eventListKey > 0 and true == isOpenEventList then
    return isOnListButton
  end
  return false
end
function PaGlobalFunc_PearlShopHandleCompleteBuy()
  if pearlShop:handleCompleteBuy() then
    return pearlShop:update()
  end
end
function PaGlobalFunc_PearlShop_AddToEventCart(controlIndex)
  if false == _ContentsGroup_CashShopEventCart then
    return
  end
  if nil == IngameCashShopEventCart_Update then
    return
  end
  local index = pearlShop:getIndexByControlIndex(controlIndex)
  if index ~= pearlShop._showingDescIndex then
    return
  end
  local info = pearlShop:getProductInfoByIndex(index)
  if nil == info then
    return
  end
  if true == info:isChooseCash() then
    local returnValue = pearlShop:checkChooseItemBuy(controlIndex)
    if false == returnValue then
      return
    end
  end
  local groupIndex = info:getOfferGroup()
  local subInfoListSize = getIngameCashMall():getCashProductStaticStatusGroupListCount(groupIndex)
  if 0 <= pearlShop._showingSubProductIndex and subInfoListSize > pearlShop._showingSubProductIndex then
    info = getIngameCashMall():getCashProductStaticStatusGroupByIndex(groupIndex, pearlShop._showingSubProductIndex)
  end
  if nil == info then
    return
  end
  local currentMainCategoryIndex = PaGlobalFunc_PearlShopCategory_GetMainCategoryIndex()
  local mainTabInfo = ToClient_GetMainCategoryStaticStatusWrapperByKeyRaw(currentMainCategoryIndex + 1)
  if nil == mainTabInfo then
    return
  end
  local isEventCartItem = pearlShop:isEventCartItem(info, currentMainCategoryIndex, index)
  if false == isEventCartItem then
    return
  end
  local eventListKey = mainTabInfo:getEventKey()
  local eventSlotKey = mainTabInfo:getEventSlotKey()
  local isOpenEventList = IngameCashShop_CheckOpenEventCart(eventListKey)
  local isOpenEventSlot = IngameCashShop_CheckOpenEventCart(eventSlotKey)
  if false == Panel_IngameCashShop_EventCart:GetShow() then
    IngameCashShopEventCart_Open(eventListKey, eventSlotKey)
  end
  local tabIndex = 0
  if false == isOpenEventList then
    tabIndex = 1
  end
  if true == IngameCashShopEventCart_Update(info:getNoRaw(), tabIndex) then
    ToClient_RequestRecommendList(info:getNoRaw())
  end
end
function PaGlobalFunc_PearlShop_CheckAppliedNickNameChange()
  if nil == Panel_PearlShop then
    return false
  end
  local selfProxyWrapper = getSelfPlayer()
  if nil == selfProxyWrapper then
    return false
  end
  local isAppliedNickNameChange = selfProxyWrapper:isAppliedNickNameChange()
  if false == isAppliedNickNameChange then
    return false
  end
  return true
end
function PaGlobalFunc_PearlShop_isChangeNickItemByCashProduct(cashProduct)
  if nil == Panel_PearlShop then
    return false
  end
  if nil == cashProduct then
    return false
  end
  local cashProductItemCount = cashProduct:getItemListCount()
  if cashProductItemCount <= 0 then
    return false
  end
  local itemEnchantSSW = cashProduct:getItemByIndex(0)
  if nil == itemEnchantSSW then
    return false
  end
  local itemSS = itemEnchantSSW:get()
  if nil == itemSS then
    return false
  end
  local changeNickItemKey1 = 17578
  local changeNickItemKey2 = 17798
  local itemKeyRaw = itemSS._key:getItemKey()
  if changeNickItemKey1 == itemKeyRaw or changeNickItemKey2 == itemKeyRaw then
    return true
  end
  return false
end
function PaGlobal_PearlShop_CheckNickNameItem(productNoRaw)
  if nil == Panel_PearlShop and false == Panel_PearlShop:GetShow() then
    return false
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if nil == cashProduct then
    return false
  end
  local isAppliedNickNameChange = PaGlobalFunc_PearlShop_CheckAppliedNickNameChange()
  if true == isAppliedNickNameChange then
    return false
  end
  local isChangeNickItem = PaGlobalFunc_PearlShop_isChangeNickItemByCashProduct(cashProduct)
  if false == isChangeNickItem then
    return false
  end
  if false == isAppliedNickNameChange and true == isChangeNickItem then
    local yesFunc = function()
      InGameShop_CloseActual()
      if nil ~= PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange then
        PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange()
      end
    end
    local messageBoxTitle = ""
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDCHANGENICKNAME")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = yesFunc,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return true
  end
  return false
end
function FromClient_PearlShop_NotifyHistory(count, leftCount)
  PaGlobalFunc_PearlShopOpen(true, nil, true)
end
function FromClient_PearlShop_NotifyRefundCompleteIndex(index, symNo)
  if symNo ~= 0 then
    PaGlobal_IngameCashShop_DescOpen()
    return
  end
  local history = pearlShop:getProductControlByControlIndex(index)
  if history == nil then
    return
  end
  local nameControl = UI.getChildControl(history, "StaticText_ProductName")
  local productName = nameControl:GetText()
  local pearlCount = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(index))
  local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURN_CONFIRM_MSG", "product", productName, "pearlCount", pearlCount)
  Proc_ShowMessage_Ack(text)
  PaGlobal_IngameCashSHop_ReturnBack_Close()
  PaGlobalFunc_PearlShopUpdate()
end
function PaGlobalFunc_PearlShop_GetMainBgPosSizeX()
  local self = pearlShop
  if self == nil then
    return
  end
  return self._ui._bgControl:GetParentPosX(), self._ui._bgControl:GetSizeX()
end
function pearlShop:buyHistorySetting(control, index)
  if control == nil then
    return
  end
  index = self:getRealIndexByControlIndex(index)
  if index == nil then
    return
  end
  local icon = UI.getChildControl(control, "Static_ProductBannerImage")
  local name = UI.getChildControl(control, "StaticText_ProductName")
  local date = UI.getChildControl(control, "StaticText_ProductSaleDate")
  local price = UI.getChildControl(control, "StaticText_ProductPearlPrice")
  local reason = UI.getChildControl(control, "StaticText_Reason")
  local discountControl = UI.getChildControl(control, "StaticText_DiscountPrice")
  local discountIcon = UI.getChildControl(control, "StaticText_DiscountIcon")
  local saleIcon = UI.getChildControl(control, "Static_SaleCateogory")
  local soldOutTexture = UI.getChildControl(control, "Static_SoldOut")
  icon:SetShow(true)
  name:SetShow(true)
  date:SetShow(true)
  price:SetShow(true)
  reason:SetShow(false)
  discountControl:SetShow(false)
  discountIcon:SetShow(false)
  discountControl:SetLineRender(false)
  saleIcon:SetShow(false)
  soldOutTexture:SetShow(false)
  local totalPearls = 0
  local totalUsePearls = 0
  local originalPearl = Int64toInt32(ToClient_GetPurchaseOriginalPearByIndex(index))
  local usePearl = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(index))
  local productNoRaw = ToClient_GetPurchaseItemCashProdcutNoByIndex(index)
  if productNoRaw == nil then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if cashProduct == nil then
    return
  end
  icon:ChangeTextureInfoNameAsync(cashProduct:getPackageIcon())
  local BuyCount = ToClient_GetPurchaseBuyCountByIndex(index)
  if BuyCount > 1 then
    local countText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. " " .. BuyCount
    name:SetText(cashProduct:getDisplayName() .. " (" .. countText .. ")")
  else
    name:SetText(cashProduct:getDisplayName())
  end
  name:SetText(name:GetText())
  name:SetIgnore(true)
  local buyDate = ToClient_GetPurchaseDateByIndex(index)
  local paTime = PATime(buyDate)
  local month = paTime:GetMonth()
  if month < 10 then
    month = "0" .. tostring(month)
  end
  local day = paTime:GetDay()
  if day < 10 then
    day = "0" .. tostring(day)
  end
  local hour = paTime:GetHour()
  if hour < 10 then
    hour = "0" .. tostring(hour)
  end
  local minute = paTime:GetMinute()
  if minute < 10 then
    minute = "0" .. tostring(minute)
  end
  local second = paTime:GetSecond()
  if second < 10 then
    second = "0" .. tostring(second)
  end
  local registerDate = tostring(paTime:GetYear()) .. "." .. month .. "." .. day .. " " .. hour .. ":" .. minute .. ":" .. second
  date:SetText(registerDate)
  local couponName = ToClient_GetPurchaseCouponNameByIndex(index)
  if couponName ~= "" or couponName ~= nil then
    reason:SetShow(true)
    reason:SetText(couponName)
  end
  local refundAble = ToClient_CheckRefundAbleCashProductByIndex(index, false)
  control:SetMonoTone(not refundAble)
  if refundAble == false then
    reason:SetShow(true)
    if ToClient_IsAlreadyRefundCashProduct(index) == true then
      reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_HASRETURN"))
    else
      reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_NORETURN"))
      local currentTime = getServerUtc64()
      if ToClient_isGiftCashProductByIndex(index) == false then
        if Int64toInt32(currentTime) < Int64toInt32(buyDate) + 604800 then
          reason:SetShow(false)
          if couponName ~= "" or couponName ~= nil then
            reason:SetText(couponName)
            reason:SetShow(true)
          end
        end
      else
        reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GIFTPRODUCT_DESC"))
      end
    end
  else
    if reason:GetTextSizeX() < reason:GetSizeX() then
      reason:SetIgnore(true)
    else
      reason:SetIgnore(false)
    end
    totalUsePearls = totalUsePearls + usePearl
    totalPearls = totalPearls + originalPearl
    if originalPearl == usePearl then
      price:SetText(usePearl)
    else
      price:SetText(originalPearl .. " -> ")
      price:SetText(price:GetText() .. usePearl)
    end
    local priceTextSizeX = price:GetTextSizeX()
    if priceTextSizeX > math.abs(self._defaultPearlPriceControlTextSpanSize.x) then
      local gap = priceTextSizeX - math.abs(self._defaultPearlPriceControlTextSpanSize.x) + 10
      price:SetSpanSize(self._defaultPearlPriceControlSpanSize.x + gap, self._defaultPearlPriceControlSpanSize.y)
      price:SetTextSpan(self._defaultPearlPriceControlTextSpanSize.x - gap, self._defaultPearlPriceControlTextSpanSize.y)
    else
      price:SetSpanSize(self._defaultPearlPriceControlSpanSize.x, self._defaultPearlPriceControlSpanSize.y)
      price:SetTextSpan(self._defaultPearlPriceControlTextSpanSize.x, self._defaultPearlPriceControlTextSpanSize.y)
    end
    saleIcon:SetSpanSize(price:GetSpanSize().x + price:GetSizeX(), saleIcon:GetSpanSize().y)
    if reason:GetShow() == true then
      if saleIcon:GetShow() == true then
        reason:SetSpanSize(saleIcon:GetSpanSize().x + saleIcon:GetSizeX(), saleIcon:GetSpanSize().y)
      else
        reason:SetSpanSize(price:GetSpanSize().x + price:GetSizeX(), price:GetSpanSize().y)
      end
    end
  end
end
function PaGlobalFunc_PearlShop_ShowBuyHistoryDesc()
  local self = pearlShop
  if self == nil then
    return
  end
  if self._isBuyHistroy == false then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_CANCEL_RETURN_BTN"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_CANCEL_TOP_DESC"),
    functionYes = MessageBox_Empty_function,
    functionNo = nil,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_PearlShop_UpdateListContent(content, key)
  pearlShop:updateListContent(content, key)
end
registerEvent("FromClient_NotifyPurchaseCashProductListCount", "FromClient_PearlShop_NotifyHistory")
registerEvent("FromClient_NotifyRefundCompleteIndex", "FromClient_PearlShop_NotifyRefundCompleteIndex")
registerEvent("FromClient_luaLoadComplete", "FromClient_PearlShopInit")
registerEvent("FromClient_UpdateCashShop", "PaGlobalFunc_PearlShopUpdate")
registerEvent("FromClient_UpdateCash", "PaGlobalFunc_PearlShopUpdate")
registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_PearlShopUpdate")
registerEvent("FromClient_NotifyCompleteBuyProduct", "PaGlobalFunc_PearlShopHandleCompleteBuy")
