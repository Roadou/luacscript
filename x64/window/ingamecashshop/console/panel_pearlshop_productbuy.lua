local pearlShopProductBuy = {
  _init = false,
  _panel = Panel_PearlShop_ProductBuy,
  _productNoRaw = 0,
  _amount = 1,
  _ui = {
    TopBg = nil,
    _frame = nil,
    _content = nil,
    _vScroll = nil,
    BtmBg = nil,
    _moneyBG = nil,
    _titleControl = nil,
    _descControl = nil,
    _subItemTitle = nil,
    _subItemSlotTemplateControl = nil,
    _itemSlotBgControl = nil,
    _noticeControl = nil,
    _amountControl = nil,
    _pearlControl = nil,
    _mileageControl = nil,
    _silverControl = nil,
    _pearlOriginControl = nil,
    _mileageOriginControl = nil,
    _rdoMoneyByMe = nil,
    _txtSilverInInven = nil,
    _subItemSlotControlListSize = 20,
    _subItemSlotControlListCountPerLine = 8,
    _subItemSlotControlList = {},
    _bottomControl = nil,
    _bottomKeyGuideA = nil,
    _bottomKeyGuideB = nil,
    _bottomKeyGuideY = nil,
    _bottomKeyGuideScroll = nil,
    _bottomKeyGuideRateView = nil
  },
  _titleSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _subSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _slotGapX = 7,
  _mainSlot = nil,
  _slotList = {},
  _keyGuideAlign = {},
  _selectedCouponIdx = nil,
  _isAvailableCoupon = false,
  _isPayInSilverWarehouse = false,
  _price = 0,
  _isOpenMoonBlessing = false,
  _noticeSizeY = 0,
  _originDescContorlPosY = 0,
  _originPanelSizeY = 0,
  _originBottomContorlPosY = 0
}
local territoryKeyToWaypointKey = {
  [0] = 1,
  [1] = 301,
  [2] = 601,
  [3] = 1101,
  [4] = 1301,
  [6] = 1623,
  [5] = 1395,
  [7] = 1649,
  [8] = 1691
}
local isJapanConsole = true == ToClient_isConsole() and CppEnums.ServiceResourceType.eServiceResourceType_JP == ToClient_getResourceType()
function pearlShopProductBuy:initialize()
  if self._init then
    return
  end
  self._init = true
  self._originPanelSizeY = self._panel:GetSizeY()
  self._ui.TopBg = UI.getChildControl(self._panel, "Static_TopBg")
  self._ui._frame = UI.getChildControl(self._ui.TopBg, "Frame_Tooltip")
  self._ui._content = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._vScroll = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._titleControl = UI.getChildControl(self._ui._content, "StaticText_ProductName")
  self._ui._descControl = UI.getChildControl(self._ui._content, "StaticText_ProductDesc")
  self._ui._descControl:SetTextMode(__eTextMode_AutoWrap)
  self._originDescContorlPosY = self._ui._descControl:GetPosY()
  self._ui._noticeControl = UI.getChildControl(self._ui._content, "StaticText_Notice")
  if true == isJapanConsole then
    self._ui._noticeControl:SetShow(true)
    self._ui._noticeControl:SetTextMode(__eTextMode_AutoWrap)
    self._noticeSizeY = self._ui._noticeControl:GetSizeY()
  else
    self._ui._noticeControl:SetShow(false)
  end
  self._ui._itemSlotBgControl = UI.getChildControl(self._ui._content, "Static_MainItemSlotBg")
  local slot = {}
  SlotItem.new(slot, "MainSlot", 0, self._ui._itemSlotBgControl, self._titleSlotConfig)
  slot:createChild()
  self._mainSlot = slot
  self._ui._subItemTitle = UI.getChildControl(self._ui._content, "StaticText_SubItemTitle")
  self._ui._subItemSlotTemplateControl = UI.getChildControl(self._ui._content, "Static_SubItemSlotBg")
  self._ui._subItemSlotTemplateControl:SetShow(false)
  for i = 0, self._ui._subItemSlotControlListSize - 1 do
    local subItemSlotControl = UI.cloneControl(self._ui._subItemSlotTemplateControl, self._ui._content, "Static_SubItemSlot" .. i)
    self._ui._subItemSlotControlList[i] = subItemSlotControl
    local slot = {}
    SlotItem.new(slot, "Slot" .. i, i, subItemSlotControl, self._subSlotConfig)
    slot:createChild()
    self._slotList[i] = slot
  end
  self._ui.BtmBg = UI.getChildControl(self._panel, "Static_BtmBg")
  self._ui._couponTitle = UI.getChildControl(self._ui.BtmBg, "StaticText_CouponTitle")
  self._ui._couponControl = UI.getChildControl(self._ui.BtmBg, "StaticText_Coupon")
  self._ui._couponControl:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_CouponBG = UI.getChildControl(self._ui._couponControl, "StaticText_SelectCoupon")
  self._ui._list2_Coupon = UI.getChildControl(self._ui._txt_CouponBG, "List2_Coupon")
  self._ui._list2_Coupon:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PearlShopProductBuy_CreateCouponList")
  self._ui._list2_Coupon:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._countTitle = UI.getChildControl(self._ui.BtmBg, "StaticText_CountTitle")
  self._ui._amountControl = UI.getChildControl(self._ui.BtmBg, "StaticText_Count")
  self._ui._leftButtonControl = UI.getChildControl(self._ui.BtmBg, "Static_Left")
  self._ui._rightButtonControl = UI.getChildControl(self._ui.BtmBg, "Static_Right")
  self._ui._priceTitle = UI.getChildControl(self._ui.BtmBg, "StaticText_PriceTitle")
  self._ui._pearlControl = UI.getChildControl(self._ui.BtmBg, "StaticText_Pearl")
  self._ui._mileageControl = UI.getChildControl(self._ui.BtmBg, "StaticText_Mileage")
  self._ui._pearlOriginControl = UI.getChildControl(self._ui.BtmBg, "StaticText_PearlOrigin")
  self._ui._pearlOriginControl:SetLineRender(true)
  self._ui._mileageOriginControl = UI.getChildControl(self._ui.BtmBg, "StaticText_MileageOrigin")
  self._ui._mileageOriginControl:SetLineRender(true)
  self._ui._silverControl = UI.getChildControl(self._ui.BtmBg, "StaticText_Silver")
  self._ui._moneyBG = UI.getChildControl(self._panel, "Static_MoneyBG")
  self._ui._rdoMoneyByMe = UI.getChildControl(self._ui._moneyBG, "RadioButton_Me")
  self._ui._rdoMoneyByMe:SetCheck(false == self._isPayInSilverWarehouse)
  self._ui._rdoMoneyByMe:addInputEvent("Mouse_On", "HandleEventOn_PearlShop_SilverPay(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui._txtSilverInInven = UI.getChildControl(self._ui._rdoMoneyByMe, "StaticText_SilverInInven")
  self._ui._bottomControl = UI.getChildControl(self._panel, "Static_BottomSite")
  self._originBottomContorlPosY = self._ui._bottomControl:GetPosY()
  self._ui._bottomKeyGuideA = UI.getChildControl(self._ui._bottomControl, "StaticText_Confirm_ConsoleUI")
  self._ui._bottomKeyGuideB = UI.getChildControl(self._ui._bottomControl, "StaticText_XboxClose_ConsoleUI")
  self._ui._bottomKeyGuideY = UI.getChildControl(self._ui._bottomControl, "StaticText_Coupon_ConsoleUI")
  self._ui._bottomKeyGuideScroll = UI.getChildControl(self._ui._bottomControl, "StaticText_XboxScroll_ConsoleUI")
  self._ui._bottomKeyGuideRateView = UI.getChildControl(self._ui._bottomControl, "StaticText_LBX_ConsoleUI")
  local rateViewChildKeyGuide = UI.getChildControl(self._ui._bottomKeyGuideRateView, "StaticText_KeyGuide_Delete_1")
  local rateViewSpanX = 10 + rateViewChildKeyGuide:GetSizeX() + rateViewChildKeyGuide:GetTextSizeX() + self._ui._bottomKeyGuideRateView:GetTextSizeX()
  self._ui._bottomKeyGuideRateView:SetSpanSize(rateViewSpanX, self._ui._bottomKeyGuideRateView:GetSpanSize().y)
  self._ui._bottomKeyGuideRateView:ComputePos()
  pearlShopProductBuy:SetAlignKeyGuide(false)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_PearlShopProductBuyDown()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_PearlShopProductBuyUp()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PearlShopProductBuyBuy()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "PaGlobalFunc_Util_OpenRateView()")
  self._panel:ignorePadSnapMoveToOtherPanel()
end
function PaGlobalFunc_PearlShopProductBuyCheckShow()
  return pearlShopProductBuy:checkShow()
end
function pearlShopProductBuy:checkShow()
  return self._panel:GetShow()
end
function PaGlobalFunc_PearlShopProductBuyBack()
  pearlShopProductBuy:back()
end
function pearlShopProductBuy:back()
  self:close()
end
function PaGlobalFunc_PearlShopProductBuyUp()
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  pearlShopProductBuy:changeAmount(1)
end
function PaGlobalFunc_PearlShopProductBuyDown()
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  pearlShopProductBuy:changeAmount(-1)
end
function pearlShopProductBuy:cashProductMaxCountByPrice(cashProduct)
  if nil == cashProduct then
    return Defines.s64_const.s64_0
  end
  local priceType = cashProduct:getProductPriceType()
  local currentMoney = Defines.s64_const.s64_0
  if __ePriceType_Cash == priceType then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local selfProxy = selfPlayer:get()
      if nil ~= selfProxy then
        currentMoney = selfProxy:getCash()
      end
    end
  elseif __ePriceType_Pearl == priceType then
    local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
    if nil ~= pearlItemWrapper then
      currentMoney = pearlItemWrapper:get():getCount_s64()
    end
  elseif __ePriceType_Sliver == priceType then
    if true == self._ui._rdoMoneyByMe:IsCheck() then
      local selfPlayer = getSelfPlayer()
      if nil ~= selfPlayer then
        local selfProxy = selfPlayer:get()
        if nil ~= selfProxy then
          currentMoney = selfProxy:getMoneyInventory():getMoney_s64()
        end
      end
    else
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
      local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
      local warehouseWrapper = warehouse_get(waypointKey)
      if nil ~= warehouseWrapper then
        currentMoney = warehouseWrapper:getMoney_s64()
      end
    end
  elseif __ePriceType_Mileage == priceType then
    local mileageItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
    if nil ~= mileageItemWrapper then
      currentMoney = mileageItemWrapper:get():getCount_s64()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MATHCLASS"))
    return Defines.s64_const.s64_0
  end
  if Defines.s64_const.s64_0 == currentMoney then
    return Defines.s64_const.s64_0
  end
  local price = cashProduct:getPrice()
  if Defines.s64_const.s64_0 == price then
    return Defines.s64_const.s64_0
  end
  local maxCountPerPrice = currentMoney / price
  return maxCountPerPrice
end
function pearlShopProductBuy:changeAmount(diff)
  local amount = self._amount + diff
  if amount <= 0 then
    return
  end
  local productInfo = self:getProductInfo()
  if nil == productInfo then
    return
  end
  if diff > 0 then
    if false == getIngameCashMall():checkCashItemBuyMaxCount(self._productNoRaw, toInt64(0, amount)) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_OVER20"))
      return
    end
    local maxBuyCount = self:cashProductMaxCountByPrice(productInfo)
    local limitCount = productInfo:getCashPurchaseCount()
    if limitCount > 0 then
      local mylimitCount = getIngameCashMall():getRemainingLimitCount(self._productNoRaw)
      if mylimitCount <= self._amount then
        return
      end
      if maxBuyCount > toInt64(0, mylimitCount) then
        maxBuyCount = toInt64(0, mylimitCount)
      end
    end
    if amount <= Int64toInt32(maxBuyCount) then
      self._amount = amount
    end
  else
    self._amount = amount
  end
  if nil ~= self._selectedCouponIdx then
    self._selectedCouponIdx = nil
  end
  self:update()
end
function pearlShopProductBuy:open(productInfo)
  if not productInfo then
    return
  end
  self._productNoRaw = productInfo:getNoRaw()
  self._amount = 1
  self._selectedCouponIdx = nil
  self:update()
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  self._panel:SetShow(true)
  if true == _ContentsGroup_PearlShopMileage then
    if true == self._isOpenMoonBlessing then
      PaGlobalFunc_IngameCashShopMoonBlessing_All_OnResize()
    else
      HandleEventLUp_IngameCashShopMoonBlessing_All_Close()
    end
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  if true == _ContentsGroup_PearlShopMoonBlessingRenew then
    if true == self._isOpenMoonBlessing then
      PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_OnResize()
    else
      HandleEventLUp_IngameCashShopMoonBlessing_Renew_All_Close()
    end
    ToClient_padSnapSetTargetPanel(self._panel)
  end
end
function pearlShopProductBuy:getProductInfo()
  if self._productNoRaw then
    return getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  end
end
function PaGlobalFunc_PearlShopProductBuyOpen(productInfo)
  pearlShopProductBuy:open(productInfo)
end
function PaGlobalFunc_PearlShopProductBuyBuy()
  local self = pearlShopProductBuy
  local function SnapReturn()
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  if false == self._ui._txt_CouponBG:GetShow() then
    if true == self._isAvailableCoupon and nil == self._selectedCouponIdx then
      local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_ALERTCOUPON")
      local messageBoxData = {
        title = messageBoxtitle,
        content = messageBoxMemo,
        functionYes = PaGlobalFunc_PearlShopProductBuyYes,
        functionNo = SnapReturn,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, "middle")
      return
    else
      self:buy()
    end
  end
end
function PaGlobalFunc_PearlShopProductBuyYes()
  pearlShopProductBuy:buy()
end
function PaGlobalFunc_PearlShop_OpenStore()
  if true == isGameServiceTypeConsole() then
    if true == ToClient_isPS() then
      ToClient_openPS4Store()
    else
      ToClient_XboxShowStore()
    end
  end
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:checkHavePearl(cashProduct)
  local function SnapReturn()
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  local pearl = Defines.s64_const.s64_0
  if nil ~= pearlItemWrapper then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  local price = self._price
  if pearl >= price then
    return true
  end
  local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_TITLE")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_DESC")
  local messageBoxData = {
    title = messageBoxtitle,
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_PearlShop_OpenStore,
    functionNo = SnapReturn,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return false
end
function pearlShopProductBuy:buy()
  local productInfo = self:getProductInfo()
  if not productInfo then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local couponKey = 0
  local couponNo = toInt64(0, -1)
  if nil ~= self._selectedCouponIdx then
    local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
    if nil ~= couponWrapper then
      couponKey = couponWrapper:getCouponKey()
      couponNo = couponWrapper:getCouponNo()
    end
  end
  if __ePriceType_Pearl == productInfo:getProductPriceType() and false == self:checkHavePearl(cashProduct) then
    return
  end
  local haveMileage, haveCash = InGameShop_UpdateCash()
  local haveMoney = toInt64(0, 0)
  local wareType = CppEnums.ItemWhereType.eMoneyInventory
  local count = self._ui._amountControl:GetText()
  local isEnoughMoney = false
  if __ePriceType_Pearl == productInfo:getProductPriceType() then
    isEnoughMoney = haveCash >= cashProduct:getPrice() * toInt64(0, count)
  elseif __ePriceType_Mileage == productInfo:getProductPriceType() then
    isEnoughMoney = haveMileage >= cashProduct:getPrice() * toInt64(0, count)
  elseif __ePriceType_Sliver == productInfo:getProductPriceType() then
    local silverInInventory = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
    haveMoney = silverInInventory
    isEnoughMoney = haveMoney >= cashProduct:getPrice() * toInt64(0, count)
  else
    isEnoughMoney = true
  end
  if isEnoughMoney then
    _AudioPostEvent_SystemUiForXBOX(16, 0)
  else
    _AudioPostEvent_SystemUiForXBOX(16, 1)
  end
  self:close()
  ToClient_requestBuyItem(productInfo:getNoRaw(), count, productInfo:getPrice(), false, couponNo, couponKey, wareType, true, CppEnums.ItemWhereType.eCount, __eTInventorySlotNoUndefined)
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:close()
  if true == self._ui._txt_CouponBG:GetShow() then
    self:couponListClsoe()
    return
  end
  if true == _ContentsGroup_PearlShopMileage and true == self._panel:GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
  end
  if nil ~= Panel_IngameCashShop_MoonBlessing_Renew_All and true == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
  end
  self._price = 0
  self._isOpenMoonBlessing = false
  PaGlobalFunc_PearlShopSetBKeyGuide()
  self._panel:SetShow(false)
end
function PaGlobalFunc_PearlShopProductBuyClose()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:addItemSlotControlList(count)
  for i = self._ui._subItemSlotControlListSize, count do
    local subItemSlotControl = UI.cloneControl(self._ui._subItemSlotTemplateControl, self._ui._content, "Static_SubItemSlot" .. i)
    self._ui._subItemSlotControlList[i] = subItemSlotControl
    local slot = {}
    SlotItem.new(slot, "Slot" .. i, i, subItemSlotControl, self._subSlotConfig)
    slot:createChild()
    self._slotList[i] = slot
  end
  self._ui._subItemSlotControlListSize = count
end
function pearlShopProductBuy:update(applyCoupon)
  local productInfo = self:getProductInfo()
  if not productInfo then
    return
  end
  self._isAvailableCoupon = false
  if nil ~= productInfo:getItemByIndex(0) then
    self._mainSlot:setItemByStaticStatus(productInfo:getItemByIndex(0))
    self._mainSlot.icon:SetShow(true)
  else
    self._mainSlot.icon:SetShow(false)
  end
  self._ui._titleControl:SetTextMode(__eTextMode_AutoWrap)
  self._ui._titleControl:SetText(productInfo:getDisplayName())
  local itemListCount = productInfo:getItemListCount()
  local additionalSubItemCount = productInfo:getSubItemListCount()
  local totalItemListCount = itemListCount + additionalSubItemCount
  if totalItemListCount > self._ui._subItemSlotControlListSize then
    self:addItemSlotControlList(totalItemListCount)
  end
  local desc = ""
  for i = 0, self._ui._subItemSlotControlListSize - 1 do
    local control = self._ui._subItemSlotControlList[i]
    control:SetPosX(self._ui._subItemTitle:GetPosX() + (self._ui._subItemSlotTemplateControl:GetSizeX() + 10) * (i % self._ui._subItemSlotControlListCountPerLine))
    control:SetPosY(self._ui._subItemTitle:GetPosY() + self._ui._subItemTitle:GetSizeY() + 20 + math.floor(i / self._ui._subItemSlotControlListCountPerLine) * 54)
    local showFlag = i < itemListCount
    control:SetShow(showFlag)
    if showFlag then
      local itemInfo = productInfo:getItemByIndex(i)
      local itemCount = productInfo:getItemCountByIndex(i)
      if nil ~= itemInfo then
        self._slotList[i]:setItemByStaticStatus(itemInfo, itemCount)
        if 1 < Int64toInt32(itemCount) and itemInfo:get():isStackableXXX() == false then
          self._slotList[i]:updateCount(itemCount)
        end
        if 1 < Int64toInt32(itemCount) then
          desc = desc .. "-" .. " " .. itemInfo:getName() .. " x" .. Int64toInt32(itemCount) .. "\n"
        else
          desc = desc .. "-" .. " " .. itemInfo:getName() .. "\n"
        end
      end
    end
  end
  for i = 0, additionalSubItemCount - 1 do
    local control = self._ui._subItemSlotControlList[i + itemListCount]
    local subItemInfo = productInfo:getSubItemByIndex(i)
    local subItemCount = productInfo:getSubItemCountByIndex(i)
    if nil ~= subItemInfo then
      self._slotList[i + itemListCount]:setItemByStaticStatus(subItemInfo, subItemCount)
      if 1 < Int64toInt32(subItemCount) and subItemInfo:get():isStackableXXX() == false then
        self._slotList[i + itemListCount]:updateCount(subItemCount)
      end
      control:SetShow(true)
      if 1 < Int64toInt32(subItemCount) then
        desc = desc .. "-" .. " " .. subItemInfo:getName() .. " x" .. Int64toInt32(subItemCount) .. "\n"
      else
        desc = desc .. "-" .. " " .. subItemInfo:getName() .. "\n"
      end
    end
  end
  if true == productInfo:isChooseCash() then
    local checklist
    if nil ~= PaGlobalFunc_PearlShopGetChooseProductList then
      checklist = PaGlobalFunc_PearlShopGetChooseProductList()
    end
    if nil ~= checklist then
      local validChooseCashProduct = productInfo:chooseCashCount()
      local chooseCount = 0
      local indexList = {}
      for ll = 0, validChooseCashProduct - 1 do
        if nil ~= checklist[ll] and checklist[ll] > 0 then
          indexList[chooseCount] = {
            [0] = ll,
            [1] = checklist[ll]
          }
          chooseCount = chooseCount + 1
        end
      end
      local prevTotalCount = 0
      for jj = 0, chooseCount - 1 do
        local chooseIndex = indexList[jj][0]
        if nil ~= chooseIndex then
          local chooseCashProduct = productInfo:getChooseCashByIndex(chooseIndex)
          local chooseItemListCount = chooseCashProduct:getItemListCount()
          prevTotalCount = totalItemListCount
          totalItemListCount = totalItemListCount + chooseItemListCount
          if totalItemListCount > self._ui._subItemSlotControlListSize then
            self:addItemSlotControlList(totalItemListCount)
          end
          for ii = 0, chooseItemListCount - 1 do
            local slotNo = prevTotalCount + ii
            local control = self._ui._subItemSlotControlList[slotNo]
            local chooseItemInfo = chooseCashProduct:getItemByIndex(ii)
            local chooseItemCount = chooseCashProduct:getItemCountByIndex(ii)
            if nil ~= chooseItemInfo and nil ~= chooseItemCount then
              chooseItemCount = chooseItemCount * toInt64(0, indexList[jj][1])
              if nil ~= self._slotList[slotNo] and nil ~= control then
                self._slotList[slotNo]:setItemByStaticStatus(chooseItemInfo, chooseItemCount)
                if 1 < Int64toInt32(chooseItemCount) and chooseItemInfo:get():isStackableXXX() == false then
                  self._slotList[slotNo]:updateCount(chooseItemCount)
                end
                control:SetShow(true)
              end
              if 1 < Int64toInt32(chooseItemCount) then
                desc = desc .. "-" .. " " .. chooseItemInfo:getName() .. " x" .. Int64toInt32(chooseItemCount) .. "\n"
              else
                desc = desc .. "-" .. " " .. chooseItemInfo:getName() .. "\n"
              end
            end
          end
        end
      end
    end
  end
  if true == productInfo:isDisplayCashProductPolicy() then
    local policyDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_RELAUNCH")
    desc = desc .. [[

<PAColor0xFFF26A6A>]] .. policyDesc .. "<PAOldColor>"
  end
  self._ui._descControl:SetText(desc)
  local addPosY = 54 * math.floor((totalItemListCount - 1) / self._ui._subItemSlotControlListCountPerLine)
  self._ui._descControl:SetPosY(self._originDescContorlPosY + addPosY)
  self._ui._descControl:SetSize(self._ui._descControl:GetSizeX(), self._ui._descControl:GetTextSizeY())
  if true == isJapanConsole then
    if __ePriceType_Pearl == productInfo:getProductPriceType() then
      local noticeString = ""
      if true == productInfo:isApplySellTimeLimit() then
        local endSellTimeValue = PATime(productInfo:getEndSellTime():get_s64())
        local monthValue = tostring(endSellTimeValue:GetMonth())
        local formattedMonth = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. monthValue)
        local yearValue = endSellTimeValue:GetYear()
        endSellTime = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", tostring(yearValue), "GetMonth", formattedMonth, "GetDay", tostring(endSellTimeValue:GetDay()))
        noticeString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_CONSOLE_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_4", "endSellTime", endSellTime) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
        self._ui._noticeControl:SetText(noticeString)
      else
        noticeString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_CONSOLE_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
      end
      self._ui._noticeControl:SetText(noticeString)
    else
      self._ui._noticeControl:SetText("")
    end
    self._noticeSizeY = self._ui._noticeControl:GetTextSizeY()
    self._ui._noticeControl:SetSize(self._ui._noticeControl:GetSizeX(), self._noticeSizeY)
    self._ui._noticeControl:SetPosY(self._ui._descControl:GetPosY() + self._ui._descControl:GetSizeY())
  end
  local contentSize = self._ui._descControl:GetPosY() + self._ui._descControl:GetSizeY() + self._noticeSizeY + 10
  self._ui._content:SetSize(self._ui._content:GetSizeX(), contentSize)
  self._ui._frame:UpdateContentScroll()
  self._ui._vScroll:SetControlTop()
  self._ui._frame:UpdateContentPos()
  self._ui._amountControl:SetText(tostring(self._amount))
  local usableCouponCount = self:couponListUpdate()
  if usableCouponCount > 0 then
    pearlShopProductBuy:SetAlignKeyGuide(true)
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PearlShopProductBuy_ShowCouponList()")
    self._ui._couponControl:SetFontColor(Defines.Color.C_FFEEEEEE)
    if nil == self._selectedCouponIdx then
      self._ui._couponControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PEARLSHOP_CANUSECOUPON", "couponcount", usableCouponCount))
    else
      local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
      local couponName = couponWrapper:getCouponName()
      self._ui._couponControl:SetText(couponName)
    end
  else
    self._ui._couponControl:SetFontColor(Defines.Color.C_FF76747D)
    self._ui._couponControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PEARLSHOP_NOCOUPON"))
    pearlShopProductBuy:SetAlignKeyGuide(false)
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  self._isOpenMoonBlessing = false
  self._price = toInt64(0, self._amount) * productInfo:getPrice()
  local priceStr = makeDotMoney(self._price)
  local rightgapX = 40
  self._ui._moneyBG:SetShow(false)
  self._panel:SetSize(self._panel:GetSizeX(), self._originPanelSizeY - self._ui._moneyBG:GetSizeY())
  self._ui._bottomControl:SetPosY(self._originBottomContorlPosY - self._ui._moneyBG:GetSizeY())
  self._ui._silverControl:SetShow(false)
  self._ui._mileageControl:SetShow(false)
  if nil == applyCoupon or false == applyCoupon then
    self._ui._pearlOriginControl:SetShow(false)
    if __ePriceType_Pearl == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(true)
      self._ui._mileageControl:SetShow(false)
      self._ui._silverControl:SetShow(false)
      self._ui._pearlControl:SetText(priceStr)
      local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
      self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    elseif __ePriceType_Mileage == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(false)
      self._ui._mileageControl:SetShow(true)
      self._ui._silverControl:SetShow(false)
      self._ui._mileageControl:SetText(priceStr)
      local sizeX = self._ui._mileageControl:GetSizeX() + self._ui._mileageControl:GetTextSizeX() + rightgapX
      self._ui._mileageControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    elseif __ePriceType_Sliver == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(false)
      self._ui._mileageControl:SetShow(false)
      self._ui._silverControl:SetShow(true)
      self._ui._silverControl:SetText(priceStr)
      local sizeX = self._ui._silverControl:GetSizeX() + self._ui._silverControl:GetTextSizeX() + rightgapX
      self._ui._silverControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
      local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
      local warehouseWrapper = warehouse_get(waypointKey)
      local silverInInventory = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
      local silverInWarehouse = toInt64(0, 0)
      if nil ~= warehouseWrapper then
        silverInWarehouse = warehouseWrapper:getMoney_s64()
      end
      self._ui._txtSilverInInven:SetText(makeDotMoney(silverInInventory))
      self._panel:SetSize(self._panel:GetSizeX(), self._originPanelSizeY)
      self._ui._moneyBG:SetShow(true)
      self._ui._bottomControl:SetPosY(self._originBottomContorlPosY)
      self._ui._moneyBG:ComputePos()
    end
  else
    local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
    if nil == couponWrapper then
      return
    end
    local couponName = couponWrapper:getCouponName()
    local couponDiscountRate = couponWrapper:getCouponDisCountRate()
    local couponDiscountPearl = couponWrapper:getCouponDisCountPearl()
    local couponState = couponWrapper:getCouponState()
    local couponCategoryCheck = couponWrapper:checkCategory(productInfo:getMainCategory(), productInfo:getMiddleCategory(), productInfo:getSmallCategory())
    local couponMaxDiscount = couponWrapper:getCouponMaxDisCountPearl()
    local couponMinProductPearl = couponWrapper:getCouponMinProductPearl()
    local isDiscountPearl = couponWrapper:isDisCountPearl()
    if false == couponCategoryCheck then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_UNABLECOUPON"))
      self._ui._pearlControl:SetShow(true)
      self._ui._pearlControl:SetText(priceStr)
      self._ui._pearlOriginControl:SetShow(false)
      local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
      self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
      return
    end
    local couponDiscountValue
    if false == isDiscountPearl then
      self._ui._amountControl:SetText(1)
      couponDiscountValue = productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
      if couponMaxDiscount > toInt64(0, 0) then
        if couponMaxDiscount < couponDiscountValue then
          self._price = productInfo:getPrice() - couponMaxDiscount
          self._ui._pearlControl:SetText(tostring(self._price))
          Proc_ShowMessage_Ack(tostring(couponName) .. PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_LIMITMAXSALE"))
        else
          self._price = productInfo:getPrice() - productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
          self._ui._pearlControl:SetText(tostring(self._price))
        end
      else
        self._price = productInfo:getPrice() - productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
        self._ui._pearlControl:SetText(tostring(self._price))
      end
    else
      local productPrice = productInfo:getPrice() * toInt64(0, self._amount)
      couponDiscountValue = productPrice - couponDiscountPearl
      if couponDiscountValue <= toInt64(0, 0) then
        couponDiscountValue = ToClient_MinCashProductPriceCoupon()
      end
      self._price = couponDiscountValue
      self._ui._pearlControl:SetText(tostring(couponDiscountValue))
    end
    self._ui._pearlOriginControl:SetShow(true)
    self._ui._pearlControl:SetShow(true)
    self._ui._pearlOriginControl:SetText(makeDotMoney(productInfo:getPrice()))
    local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
    self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    local posX = self._ui._pearlControl:GetPosX() - self._ui._pearlOriginControl:GetTextSizeX() - rightgapX
    self._ui._pearlOriginControl:SetPosX(posX)
    self._ui._pearlOriginControl:SetPosY(self._ui._pearlControl:GetPosY())
  end
  if __ePriceType_Pearl == productInfo:getProductPriceType() then
    self._isOpenMoonBlessing = true
  end
  if true == self._isOpenMoonBlessing and true == _ContentsGroup_PearlShopMileage then
    PaGlobal_CashMileage_ChangeConsumePearl(self._price)
  end
  if self._isOpenMoonBlessing == true and _ContentsGroup_PearlShopMoonBlessingRenew == true then
    PaGlobal_MoonBlessing_ChangeConsumePearl(self._price)
  end
end
function pearlShopProductBuy:changePlatformSpecKey()
end
function FromClient_PearlShopProductBuyInit()
  pearlShopProductBuy:initialize()
end
function pearlShopProductBuy:couponListClsoe()
  pearlShopProductBuy:SetAlignKeyGuide(true)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_PearlShopProductBuyDown()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_PearlShopProductBuyUp()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "PaGlobalFunc_Util_OpenRateView()")
  self._ui._txt_CouponBG:SetShow(false)
end
function pearlShopProductBuy:couponListUpdate()
  local count = ToClient_GetCouponInfoCount()
  local cashProduct
  local main = -1
  local middle = -1
  local small = -1
  local productNoRaw = self._productNoRaw
  local tcount = 0
  if nil ~= productNoRaw then
    cashProduct = self:getProductInfo()
    main = cashProduct:getMainCategory()
    middle = cashProduct:getMiddleCategory()
    small = cashProduct:getSmallCategory()
  else
    return 0
  end
  if __ePriceType_Pearl ~= cashProduct:getProductPriceType() then
    return 0
  end
  self._ui._list2_Coupon:getElementManager():clearKey()
  for i = 0, count - 1 do
    local couponWrapper = ToClient_GetCouponInfoWrapper(i)
    if 0 == couponWrapper:getCouponState() then
      if nil == cashProduct then
        tcount = tcount + 1
        self._ui._list2_Coupon:getElementManager():pushKey(toInt64(0, i))
      else
        cashProductPrice = cashProduct:getPrice() * toInt64(0, self._amount)
        local isDiscountPearl = couponWrapper:isDisCountPearl()
        local minProductPearl = 0
        if isDiscountPearl then
          minProductPearl = couponWrapper:getCouponMinProductPearl()
          if 1 == minProductPearl then
            isDiscountPearl = false
          elseif minProductPearl <= cashProductPrice then
            isDiscountPearl = false
          end
        end
        if true == couponWrapper:checkCategory(main, middle, small) and false == isDiscountPearl then
          tcount = tcount + 1
          self._ui._list2_Coupon:getElementManager():pushKey(toInt64(0, i))
        end
      end
    end
  end
  if tcount > 0 then
    self._isAvailableCoupon = true
  end
  return tcount
end
function pearlShopProductBuy:SetAlignKeyGuide(isShowCouponKeyGuide)
  local state = 1
  local showScrollKeyGuide = self._ui._frame:GetSizeY() < self._ui._content:GetSizeY()
  if isShowCouponKeyGuide == true and showScrollKeyGuide == true then
    state = 1
    self._ui._bottomKeyGuideY:SetShow(true)
    self._ui._bottomKeyGuideScroll:SetShow(true)
    self._ui._bottomKeyGuideRateView:SetShow(true)
    self._ui._vScroll:SetShow(true)
    self._keyGuideAlign = {
      self._ui._bottomKeyGuideScroll,
      self._ui._bottomKeyGuideY,
      self._ui._bottomKeyGuideA,
      self._ui._bottomKeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  elseif isShowCouponKeyGuide == true and showScrollKeyGuide == false then
    state = 2
    self._ui._bottomKeyGuideRateView:SetShow(true)
    self._ui._bottomKeyGuideY:SetShow(true)
    self._ui._bottomKeyGuideScroll:SetShow(false)
    self._ui._vScroll:SetShow(false)
    self._keyGuideAlign = {
      self._ui._bottomKeyGuideY,
      self._ui._bottomKeyGuideA,
      self._ui._bottomKeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  elseif isShowCouponKeyGuide == false and showScrollKeyGuide == true then
    state = 3
    self._ui._bottomKeyGuideY:SetShow(false)
    self._ui._bottomKeyGuideScroll:SetShow(true)
    self._ui._vScroll:SetShow(true)
    self._keyGuideAlign = {
      self._ui._bottomKeyGuideScroll,
      self._ui._bottomKeyGuideA,
      self._ui._bottomKeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  elseif isShowCouponKeyGuide == false and showScrollKeyGuide == false then
    state = 4
    self._ui._bottomKeyGuideRateView:SetShow(true)
    self._ui._bottomKeyGuideY:SetShow(false)
    self._ui._bottomKeyGuideScroll:SetShow(false)
    self._ui._vScroll:SetShow(false)
    self._keyGuideAlign = {
      self._ui._bottomKeyGuideA,
      self._ui._bottomKeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobalFunc_PearlShopProductBuy_ShowCouponList()
  local self = pearlShopProductBuy
  pearlShopProductBuy:SetAlignKeyGuide(false)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "")
  self._ui._txt_CouponBG:SetShow(true)
  local gabX = 20
  if nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
    self._ui._txt_CouponBG:SetSpanSize(self._panel:GetSizeX() - gabX, self._ui._txt_CouponBG:GetSpanSize().y)
  else
    self._ui._txt_CouponBG:SetSpanSize(-1 * self._ui._txt_CouponBG:GetSizeX() - gabX * 2, self._ui._txt_CouponBG:GetSpanSize().y)
  end
  if nil ~= Panel_IngameCashShop_MoonBlessing_Renew_All and true == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
    self._ui._txt_CouponBG:SetSpanSize(self._panel:GetSizeX() - gabX, self._ui._txt_CouponBG:GetSpanSize().y)
  else
    self._ui._txt_CouponBG:SetSpanSize(-1 * self._ui._txt_CouponBG:GetSizeX() - gabX * 2, self._ui._txt_CouponBG:GetSpanSize().y)
  end
  self:couponListUpdate()
  local count = ToClient_GetCouponInfoCount()
  for i = 0, count - 1 do
    local couponWrapper = ToClient_GetCouponInfoWrapper(i)
    if couponWrapper:getCouponState() == 0 then
      local control = self._ui._list2_Coupon:GetContentByKey(toInt64(0, i))
      if control ~= nil then
        local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
        if btn_Coupon ~= nil then
          ToClient_padSnapChangeToTarget(btn_Coupon)
          return
        end
      end
    end
  end
end
function PaGlobalFunc_PearlShopProductBuy_CreateCouponList(control, key64)
  local self = pearlShopProductBuy
  local idx = Int64toInt32(key64)
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  local couponWrapper = ToClient_GetCouponInfoWrapper(idx)
  if nil ~= couponWrapper then
    local couponName = couponWrapper:getCouponName()
    local couponKey = couponWrapper:getCouponKey()
    local couponState = couponWrapper:getCouponState()
    local couponExpirationDate = couponWrapper:getExpirationDateTime()
    local couponRate = couponWrapper:getCouponDisCountRate()
    local couponPearl = couponWrapper:getCouponDisCountPearl()
    local couponMaxDiscount = couponWrapper:getCouponMaxDisCountPearl()
    local couponCategory = couponWrapper:getCouponCategoryExpression()
    local isDiscountPearl = couponWrapper:isDisCountPearl()
    btn_Coupon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopProductBuy_ApplyCoupon(" .. idx .. ")")
    btn_Coupon:addInputEvent("Mouse_On", "PaGlobalFunc_PearlShopProductBuy_FocusOn(" .. idx .. ")")
    btn_Coupon:addInputEvent("Mouse_Out", "PaGlobalFunc_PearlShopProductBuy_FocusOut(" .. idx .. ")")
    txt_Title:SetTextMode(__eTextMode_LimitText)
    txt_Title:SetText(couponName)
    txt_Title:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopProductBuy_ApplyCoupon(" .. idx .. ")")
    txt_Title:addInputEvent("Mouse_On", "PaGlobalFunc_PearlShopProductBuy_FocusOn(" .. idx .. ")")
    txt_Title:addInputEvent("Mouse_Out", "PaGlobalFunc_PearlShopProductBuy_FocusOut(" .. idx .. ")")
    if false == isDiscountPearl then
      txt_Rate:SetText(couponRate / 10000 .. "%")
    else
      txt_Rate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_COUPON_COUPONPEARL", "couponPearl", tostring(couponPearl)))
    end
  end
end
function PaGlobalFunc_PearlShopProductBuy_ApplyCoupon(couponIndex)
  local self = pearlShopProductBuy
  self._selectedCouponIdx = couponIndex
  self:couponListClsoe()
  self:update(true)
  PaGlobalFunc_PearlShopProductBuy_FocusOut(couponIndex)
end
function PaGlobalFunc_PearlShopProductBuy_FocusOn(couponIndex)
  local self = pearlShopProductBuy
  local control = self._ui._list2_Coupon:GetContentByKey(toInt64(0, couponIndex))
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  txt_Title:SetFontColor(Defines.Color.C_FFEEEEEE)
  txt_Rate:SetFontColor(Defines.Color.C_FFFFD691)
end
function PaGlobalFunc_PearlShopProductBuy_FocusOut(couponIndex)
  local self = pearlShopProductBuy
  local control = self._ui._list2_Coupon:GetContentByKey(toInt64(0, couponIndex))
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  txt_Title:SetFontColor(Defines.Color.C_FFB2B9D4)
  txt_Rate:SetFontColor(Defines.Color.C_FFB2B9D4)
  btn_Coupon:setRenderTexture(btn_Coupon:getBaseTexture())
end
function HandleEventOn_PearlShop_SilverPay(whereType)
  if CppEnums.ItemWhereType.eInventory == whereType then
    pearlShopProductBuy._ui._rdoMoneyByMe:SetCheck(true)
    self._isPayInSilverWarehouse = false
  elseif CppEnums.ItemWhereType.eWarehouse == whereType then
    pearlShopProductBuy._ui._rdoMoneyByMe:SetCheck(false)
    self._isPayInSilverWarehouse = true
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PearlShopProductBuyInit")
