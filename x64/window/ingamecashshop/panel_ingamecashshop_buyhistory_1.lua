function PaGlobal_CashShopBuyHistory:initialize()
  if true == self._initialize then
    return
  end
  self._ui._historyTemplate = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "TemplateHistory_Static_GoodsBG")
  self._ui._historyTemplate:SetShow(false)
  self._ui._scroll = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "Scroll_IngameCashHistory")
  self._ui._btn_scrollUp = UI.getChildControl(self._ui._scroll, "Scroll_UpButton")
  self._ui._btn_scrollDown = UI.getChildControl(self._ui._scroll, "Scroll_DownButton")
  self._ui._btn_scroll = UI.getChildControl(self._ui._scroll, "Scroll_CtrlButton")
  self._ui._stc_pearBox = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "Static_PearlBox")
  self._ui._stc_pearIcon = UI.getChildControl(self._ui._stc_pearBox, "Static_NowPearlIcon")
  self._ui._txt_totalCount = UI.getChildControl(self._ui._stc_pearBox, "StaticText_TotalCount")
  self._ui._txt_nowCount = UI.getChildControl(self._ui._stc_pearBox, "StaticText_NowPearlCount")
  self._ui._stc_topDescBG = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "Static_TopDescBG")
  self._ui._frame = UI.getChildControl(self._ui._stc_topDescBG, "Frame_1")
  local frameContent = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._frameScroll = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._stc_topDes = UI.getChildControl(frameContent, "StaticText_2")
  self._ui._stc_topDes:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_topDes:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_CANCEL_TOP_DESC"))
  self._ui._stc_topDes:SetSize(self._ui._stc_topDes:GetSizeX(), self._ui._stc_topDes:GetTextSizeY())
  frameContent:SetSize(frameContent:GetSizeX(), self._ui._stc_topDes:GetSizeY())
  frameContent:ComputePos()
  self._ui._frame:UpdateContentScroll()
  self._ui._frame:UpdateContentPos()
  self._ui._frameScroll:SetControlTop()
  self._ui._txt_refundCount = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "StaticText_1")
  self._ui._btn_refundInfo = UI.getChildControl(Panel_IngameCashShop_BuyHistory, "Button_CancelInfo")
  local infoText = UI.getChildControl(self._ui._btn_refundInfo, "StaticText_2")
  local gabX = infoText:GetTextSizeX() - infoText:GetSizeX()
  if gabX > 0 then
    self._ui._btn_refundInfo:SetSize(self._ui._btn_refundInfo:GetSizeX() + gabX, self._ui._btn_refundInfo:GetSizeY())
    infoText:SetSize(infoText:GetTextSizeX(), infoText:GetSizeY())
    infoText:ComputePos()
  end
  local refundText = UI.getChildControl(self._ui._historyTemplate, "TemplateHistory_Button_BackAll")
  refundText:SetText(refundText:GetText())
  gabX = refundText:GetTextSizeX() - (refundText:GetSizeX() - 40)
  if gabX > 0 then
    refundText:SetSize(refundText:GetTextSizeX() + 40, refundText:GetSizeY())
    refundText:ComputePos()
  end
  self._ui._stc_pearBox:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CashShopBuyHistory:registEventHandler()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  Panel_IngameCashShop_BuyHistory:SetChildIndex(self._ui._scroll, 9999)
  Panel_IngameCashShop_BuyHistory:addInputEvent("Mouse_UpScroll", "HandleEvent_CashShopBuyHistory_Scroll( -1 )")
  Panel_IngameCashShop_BuyHistory:addInputEvent("Mouse_DownScroll", "HandleEvent_CashShopBuyHistory_Scroll(  1 )")
  self._ui._btn_refundInfo:addInputEvent("Mouse_LUp", "HandleEvent_CashShopBuyHistory_OpenRefundInfo()")
  UIScroll.InputEvent(self._ui._scroll, "HandleEventLPress_ICashShopBuyHistory_ScrollBtn")
  registerEvent("FromClient_NotifyPurchaseCashProductListCount", "FromClient_CashShopBuyHistory_NotifyHistory")
  registerEvent("FromClient_NotifyRefundCompleteIndex", "FromClient_CashShopBuyHistory_NotifyRefundCompleteIndex")
end
function PaGlobal_CashShopBuyHistory:updateList(count)
  self._realHistoryCount = count
  self._historyCount = count
  for ii = 1, #self._historyList do
    if nil ~= self._historyList[ii] then
      self._historyList[ii]._iconBG:SetShow(false)
      self._historyList[ii]._icon:SetShow(false)
      self._historyList[ii]._name:SetShow(false)
      self._historyList[ii]._date:SetShow(false)
      self._historyList[ii]._originPrice:SetShow(false)
      self._historyList[ii]._realPrice:SetShow(false)
      self._historyList[ii]._pearIcon:SetShow(false)
      self._historyList[ii]._reason:SetShow(false)
      self._historyList[ii]._saleIcon:SetShow(false)
      self._historyList[ii]._refund:SetShow(false)
      self._historyList[ii]._bg:SetMonoTone(false)
      self._historyList[ii]._bg:SetIgnore(true)
    end
  end
  local totalPearls = 0
  local totalUsePearls = 0
  local eventCartNoList = {}
  local posY = self._ui._historyTemplate:GetSpanSize().y
  local eventCount = 1
  local controlIndex = 1
  local removeCount = 0
  for ii = 1, count do
    local productNo = ToClient_GetPurchaseItemCashProdcutNoByIndex(ii - 1)
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
    if nil ~= cashProduct then
      local addAble = true
      local eventCartNo = ToClient_GetPurchaseEventCartNoByIndex(ii - 1)
      if 0 ~= eventCartNo then
        for jj = 1, #eventCartNoList do
          if eventCartNo == eventCartNoList[jj].eventCartNo then
            addAble = false
            eventCartNoList[jj].count = eventCartNoList[jj].count + 1
            eventCartNoList[jj].totalCost = eventCartNoList[jj].totalCost + Int64toInt32(ToClient_GetPurchaseOriginalPearByIndex(ii - 1))
            removeCount = removeCount + 1
          end
        end
      end
      if addAble == true then
        if self._historyList[controlIndex] == nil then
          local history = self:createSlot(controlIndex)
          self._historyList[controlIndex] = history
        end
        local originalPearl = Int64toInt32(ToClient_GetPurchaseOriginalPearByIndex(ii - 1))
        local usePearl = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(ii - 1))
        if 0 ~= eventCartNo then
          local temp = {
            eventCartNo = 0,
            controlIndex = 0,
            count = 0,
            totalCost = 0
          }
          temp.eventCartNo = eventCartNo
          temp.controlIndex = controlIndex
          temp.totalCost = temp.totalCost + originalPearl
          eventCartNoList[eventCount] = temp
          eventCount = eventCount + 1
        end
        self._historyList[controlIndex]._bg:SetShow(true)
        self._historyList[controlIndex]._iconBG:SetShow(true)
        self._historyList[controlIndex]._icon:SetShow(true)
        self._historyList[controlIndex]._name:SetShow(true)
        self._historyList[controlIndex]._date:SetShow(true)
        self._historyList[controlIndex]._realPrice:SetShow(true)
        self._historyList[controlIndex]._pearIcon:SetShow(true)
        self._historyList[controlIndex]._reason:SetShow(false)
        self._historyList[controlIndex]._saleIcon:SetShow(false)
        self._historyList[controlIndex]._refund:SetShow(false)
        self._historyList[controlIndex]._bg:SetMonoTone(false)
        if eventCartNo ~= 0 then
          self._historyList[controlIndex]._saleIcon:SetShow(true)
        end
        self._historyList[controlIndex]._bg:SetSpanSize(self._historyList[controlIndex]._bg:GetSpanSize().x, posY)
        posY = posY + self._historyList[controlIndex]._bg:GetSizeY() + 5
        self._historyList[controlIndex]._icon:ChangeTextureInfoNameAsync("icon/" .. cashProduct:getIconPath())
        self._historyList[controlIndex]._icon:addInputEvent("Mouse_On", "HandleEventOnOut_CashShopBuyHistory_ShowToolTip(true," .. controlIndex .. ", " .. productNo .. ")")
        self._historyList[controlIndex]._icon:addInputEvent("Mouse_Out", "HandleEventOnOut_CashShopBuyHistory_ShowToolTip(false," .. controlIndex .. "," .. productNo .. ")")
        local BuyCount = ToClient_GetPurchaseBuyCountByIndex(ii - 1)
        if BuyCount > 1 then
          local countText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. " " .. BuyCount
          self._historyList[controlIndex]._name:SetText(cashProduct:getDisplayName() .. " (" .. countText .. ")")
        else
          self._historyList[controlIndex]._name:SetText(cashProduct:getDisplayName())
        end
        self._historyList[controlIndex]._name:SetSize(295, self._historyList[controlIndex]._name:GetSizeY())
        self._historyList[controlIndex]._name:SetText(self._historyList[controlIndex]._name:GetText())
        self._historyList[controlIndex]._name:SetIgnore(true)
        UI.setLimitTextAndAddTooltip(self._historyList[controlIndex]._name)
        local buyDate = ToClient_GetPurchaseDateByIndex(ii - 1)
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
        self._historyList[controlIndex]._date:SetText(registerDate)
        self._historyList[controlIndex]._reason:SetShow(false)
        local couponName = ToClient_GetPurchaseCouponNameByIndex(ii - 1)
        if couponName ~= "" or couponName ~= nil then
          self._historyList[controlIndex]._reason:SetShow(true)
          self._historyList[controlIndex]._reason:SetText(couponName)
          self._historyList[controlIndex]._reason:SetSize(200, self._historyList[controlIndex]._reason:GetSizeY())
        end
        self._historyList[controlIndex]._refund:SetIgnore(true)
        local refundAble = ToClient_CheckRefundAbleCashProductByIndex(ii - 1, false)
        if PaGlobal_CashShopBuyHistory._dontUseRefund == true then
          refundAble = false
        end
        self._historyList[controlIndex]._bg:SetMonoTone(not refundAble)
        self._historyList[controlIndex]._bg:SetIgnore(not refundAble)
        if false == refundAble then
          self._historyList[controlIndex]._reason:SetShow(true)
          if true == ToClient_IsAlreadyRefundCashProduct(ii - 1) then
            self._historyList[controlIndex]._reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_HASRETURN"))
          else
            self._historyList[controlIndex]._reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_NORETURN"))
            local currentTime = getServerUtc64()
            if ToClient_isGiftCashProductByIndex(ii - 1) == false then
              if Int64toInt32(currentTime) < Int64toInt32(buyDate) + 604800 then
                self._historyList[controlIndex]._bg:SetMonoTone(false)
                self._historyList[controlIndex]._reason:SetShow(false)
                if couponName ~= "" or couponName ~= nil then
                  self._historyList[controlIndex]._reason:SetText(couponName)
                  self._historyList[controlIndex]._reason:SetShow(true)
                end
              end
            else
              self._historyList[controlIndex]._reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GIFTPRODUCT_DESC"))
            end
          end
        else
          self._historyList[controlIndex]._bg:addInputEvent("Mouse_LUp", "HandleEventLUp_CashShopBuyHistory_RequestRefund(" .. ii - 1 .. "," .. controlIndex .. "," .. eventCartNo .. ")")
          self._historyList[controlIndex]._bg:addInputEvent("Mouse_On", "HandleEvent_CashShopBuyHistory_ShowRefundButton(true," .. controlIndex .. ")")
          self._historyList[controlIndex]._bg:addInputEvent("Mouse_Out", "HandleEvent_CashShopBuyHistory_ShowRefundButton(false," .. controlIndex .. ")")
        end
        if PaGlobal_CashShopBuyHistory._dontUseRefund == true then
          self._historyList[controlIndex]._bg:SetMonoTone(false)
          self._historyList[controlIndex]._reason:SetShow(false)
        end
        if ToClient_isStepUpProductByIndex(ii - 1) == true then
          self._historyList[controlIndex]._reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_NORETURN"))
          self._historyList[controlIndex]._bg:SetMonoTone(true)
          self._historyList[controlIndex]._reason:SetShow(true)
        end
        if self._historyList[controlIndex]._reason:GetTextSizeX() < self._historyList[controlIndex]._reason:GetSizeX() then
          self._historyList[controlIndex]._reason:SetIgnore(true)
        else
          self._historyList[controlIndex]._reason:SetIgnore(false)
        end
        UI.setLimitTextAndAddTooltip(self._historyList[controlIndex]._reason)
        totalUsePearls = totalUsePearls + usePearl
        totalPearls = totalPearls + originalPearl
        if originalPearl == usePearl then
          self._historyList[controlIndex]._originPrice:SetShow(false)
          self._historyList[controlIndex]._realPrice:SetText(usePearl)
        else
          self._historyList[controlIndex]._originPrice:SetShow(true)
          self._historyList[controlIndex]._originPrice:SetMonoTone(true)
          self._historyList[controlIndex]._originPrice:SetFontColor(Defines.Color.C_FF888888)
          self._historyList[controlIndex]._originPrice:SetText(originalPearl .. " -> ")
          self._historyList[controlIndex]._realPrice:SetText(usePearl)
        end
        self._historyList[controlIndex]._originPrice:SetSize(self._historyList[controlIndex]._originPrice:GetTextSizeX(), self._historyList[controlIndex]._originPrice:GetSizeY())
        self._historyList[controlIndex]._originPrice:ComputePos()
        self._historyList[controlIndex]._realPrice:SetSize(self._historyList[controlIndex]._realPrice:GetTextSizeX(), self._historyList[controlIndex]._realPrice:GetSizeY())
        self._historyList[controlIndex]._realPrice:ComputePos()
        if true == self._historyList[controlIndex]._originPrice:GetShow() then
          self._historyList[controlIndex]._originPrice:SetSpanSize(self._historyList[controlIndex]._realPrice:GetSizeX() + 10, self._historyList[controlIndex]._originPrice:GetSpanSize().y)
          self._historyList[controlIndex]._pearIcon:SetSpanSize(self._historyList[controlIndex]._originPrice:GetSizeX() + self._historyList[controlIndex]._realPrice:GetSizeX() + 10, self._historyList[controlIndex]._pearIcon:GetSpanSize().y)
        else
          self._historyList[controlIndex]._pearIcon:SetSpanSize(self._historyList[controlIndex]._realPrice:GetSizeX() + 10, self._historyList[controlIndex]._pearIcon:GetSpanSize().y)
        end
        self._historyList[controlIndex]._saleIcon:SetSpanSize(self._historyList[controlIndex]._pearIcon:GetSpanSize().x + self._historyList[controlIndex]._pearIcon:GetSizeX(), self._historyList[controlIndex]._saleIcon:GetSpanSize().y)
        if true == self._historyList[controlIndex]._reason:GetShow() then
          if true == self._historyList[controlIndex]._saleIcon:GetShow() then
            self._historyList[controlIndex]._reason:SetSpanSize(self._historyList[controlIndex]._saleIcon:GetSpanSize().x + self._historyList[controlIndex]._saleIcon:GetSizeX(), self._historyList[controlIndex]._saleIcon:GetSpanSize().y)
          else
            self._historyList[controlIndex]._reason:SetSpanSize(self._historyList[controlIndex]._pearIcon:GetSpanSize().x + self._historyList[controlIndex]._pearIcon:GetSizeX(), self._historyList[controlIndex]._pearIcon:GetSpanSize().y)
          end
        end
        self._historyList[controlIndex]._icon:addInputEvent("Mouse_UpScroll", "HandleEvent_CashShopBuyHistory_Scroll( -1 )")
        self._historyList[controlIndex]._icon:addInputEvent("Mouse_DownScroll", "HandleEvent_CashShopBuyHistory_Scroll(  1 )")
        self._historyList[controlIndex]._bg:addInputEvent("Mouse_UpScroll", "HandleEvent_CashShopBuyHistory_Scroll( -1 )")
        self._historyList[controlIndex]._bg:addInputEvent("Mouse_DownScroll", "HandleEvent_CashShopBuyHistory_Scroll(  1 )")
        controlIndex = controlIndex + 1
      end
    end
  end
  for jj = 1, #eventCartNoList do
    local targetControl = self._historyList[eventCartNoList[jj].controlIndex]
    if targetControl ~= nil then
      local count = ""
      if eventCartNoList[jj].count ~= 0 then
        count = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_EVENTCART_RETURN_COUNT", "count", eventCartNoList[jj].count)
      end
      targetControl._name:SetText(targetControl._name:GetText() .. " " .. count)
      UI.setLimitTextAndAddTooltip(targetControl._name)
      targetControl._originPrice:SetText(eventCartNoList[jj].totalCost .. " -> ")
      targetControl._originPrice:SetSize(targetControl._originPrice:GetTextSizeX(), targetControl._originPrice:GetSizeY())
      targetControl._originPrice:ComputePos()
      targetControl._originPrice:SetSpanSize(targetControl._realPrice:GetSizeX() + 10, targetControl._originPrice:GetSpanSize().y)
      targetControl._pearIcon:SetSpanSize(targetControl._originPrice:GetSizeX() + targetControl._realPrice:GetSizeX() + 10, targetControl._pearIcon:GetSpanSize().y)
      targetControl._saleIcon:SetSpanSize(targetControl._pearIcon:GetSpanSize().x + targetControl._pearIcon:GetSizeX(), targetControl._saleIcon:GetSpanSize().y)
      if true == targetControl._reason:GetShow() then
        if true == targetControl._saleIcon:GetShow() then
          targetControl._reason:SetSpanSize(targetControl._saleIcon:GetSpanSize().x + targetControl._saleIcon:GetSizeX(), targetControl._saleIcon:GetSpanSize().y)
        else
          targetControl._reason:SetSpanSize(targetControl._pearIcon:GetSpanSize().x + targetControl._pearIcon:GetSizeX(), targetControl._pearIcon:GetSpanSize().y)
        end
      end
    end
  end
  self._historyCount = self._historyCount - removeCount
end
function PaGlobal_CashShopBuyHistory:createSlot(index)
  local history = {
    _bg = nil,
    _iconBG = nil,
    _icon = nil,
    _name = nil,
    _date = nil,
    _originPrice = nil,
    _realPrice = nil,
    _pearIcon = nil,
    _reason = nil,
    _saleIcon = nil,
    _refund = nil
  }
  history._bg = UI.cloneControl(self._ui._historyTemplate, Panel_IngameCashShop_BuyHistory, "TemplateHistory_Static_GoodsBG_" .. index)
  history._iconBG = UI.getChildControl(history._bg, "TemplateHistory_Static_SlotBG")
  history._icon = UI.getChildControl(history._iconBG, "TemplateHistory_Static_Slot")
  history._name = UI.getChildControl(history._bg, "TemplateHistory_StaticText_ItemName")
  history._date = UI.getChildControl(history._bg, "TemplateHistory_StaticText_BuyDate")
  history._originPrice = UI.getChildControl(history._bg, "TemplateHistory_StaticText_ItemPrice1")
  history._realPrice = UI.getChildControl(history._bg, "TemplateHistory_StaticText_ItemPrice2")
  history._pearIcon = UI.getChildControl(history._bg, "TemplateHistory_Static_PearlIcon")
  history._reason = UI.getChildControl(history._bg, "TemplateHistory_StaticText_Reason")
  history._saleIcon = UI.getChildControl(history._bg, "TemplateHistory_Static_SaleCateogory")
  history._refund = UI.getChildControl(history._bg, "TemplateHistory_Button_BackAll")
  return history
end
function PaGlobal_CashShopBuyHistory:prepareOpen()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  if _ContentsGroup_RefundCashProduct == false then
    return
  end
  self._ui._txt_refundCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_CANCELCOUNT", "count", self._leftRefundCount))
  self._dontUseRefund = ToClient_isDontUseRefundCashProduct()
  Panel_IngameCashShop_BuyHistory:SetSize(Panel_IngameCashShop_NewCart:GetSizeX(), Panel_IngameCashShop_NewCart:GetSizeY() + self._ui._stc_topDescBG:GetSizeY())
  Panel_IngameCashShop_BuyHistory:SetPosX(Panel_IngameCashShop_NewCart:GetPosX())
  Panel_IngameCashShop_BuyHistory:SetPosY(Panel_IngameCashShop_NewCart:GetPosY() - self._ui._stc_topDescBG:GetSizeY())
  self._ui._txt_refundCount:ComputePos()
  self._ui._btn_refundInfo:ComputePos()
  local panelSizeY = Panel_IngameCashShop_BuyHistory:GetSizeY() - self._ui._stc_topDescBG:GetSizeY()
  local slotSizeY = self._ui._historyTemplate:GetSizeY()
  local count = panelSizeY / slotSizeY - 1
  for ii = 1, math.floor(count - 1) do
    if self._historyList[ii] == nil then
      local history = self:createSlot(ii)
      self._historyList[ii] = history
    end
  end
  self._maxHistoryCount = math.floor(count - 1) - 1
  local posY = self._ui._historyTemplate:GetSpanSize().y
  for ii = 1, #self._historyList do
    if nil ~= self._historyList[ii] then
      if count >= ii then
        self._historyList[ii]._bg:SetShow(true)
      else
        self._historyList[ii]._bg:SetShow(false)
      end
      self._historyList[ii]._bg:SetSpanSize(self._historyList[ii]._bg:GetSpanSize().x, posY)
      posY = posY + self._historyList[ii]._bg:GetSizeY() + 5
      self._historyList[ii]._iconBG:SetShow(false)
      self._historyList[ii]._icon:SetShow(false)
      self._historyList[ii]._name:SetShow(false)
      self._historyList[ii]._date:SetShow(false)
      self._historyList[ii]._originPrice:SetShow(false)
      self._historyList[ii]._realPrice:SetShow(false)
      self._historyList[ii]._pearIcon:SetShow(false)
      self._historyList[ii]._reason:SetShow(false)
      self._historyList[ii]._saleIcon:SetShow(false)
      self._historyList[ii]._bg:SetIgnore(true)
    end
  end
  self:SetScroll()
  self:Scrolling(0)
  ToClient_RequestPurchaseCashProductList()
  self:open()
end
function PaGlobal_CashShopBuyHistory:open()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  Panel_IngameCashShop_BuyHistory:SetShow(true)
end
function PaGlobal_CashShopBuyHistory:prepareClose()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack_Close()
  self:close()
end
function PaGlobal_CashShopBuyHistory:close()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  Panel_IngameCashShop_BuyHistory:SetShow(false)
end
function PaGlobal_CashShopBuyHistory:validate()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  self._ui._historyTemplate:isValidate()
  self._ui._scroll:isValidate()
  self._ui._btn_scrollUp:isValidate()
  self._ui._btn_scrollDown:isValidate()
  self._ui._stc_pearBox:isValidate()
  self._ui._stc_pearIcon:isValidate()
  self._ui._txt_totalCount:isValidate()
  self._ui._txt_nowCount:isValidate()
end
function PaGlobal_CashShopBuyHistory:Scrolling(value)
  if self._historyCount < self._maxHistoryCount then
    self._currentSlotIndex = 1
  else
    self._currentSlotIndex = self._currentSlotIndex + value
    if self._currentSlotIndex < 1 then
      self._currentSlotIndex = 1
    elseif self._historyCount <= self._currentSlotIndex + self._maxHistoryCount then
      self._currentSlotIndex = self._historyCount - self._maxHistoryCount
    end
  end
  self:fillSlots()
  local pos = self._currentSlotIndex / (self._historyCount - self._maxHistoryCount)
  if self._currentSlotIndex == 1 then
    self._ui._scroll:SetControlPos(0)
    return
  end
  self._ui._scroll:SetControlPos(pos)
end
function PaGlobal_CashShopBuyHistory:fillSlots()
  local uiSlot = 1
  local posY = self._ui._historyTemplate:GetSpanSize().y
  for index = 1, #self._historyList do
    if index < self._currentSlotIndex then
      self._historyList[index]._bg:SetShow(false)
    else
      self._historyList[index]._bg:SetShow(index <= self._maxHistoryCount + self._currentSlotIndex)
      self._historyList[index]._bg:SetSpanSize(self._historyList[index]._bg:GetSpanSize().x, posY)
      posY = posY + self._historyList[index]._bg:GetSizeY() + 5
    end
  end
  if nil == self._historyList[self._currentSlotIndex] then
    return
  end
  self._remainSizeY = Panel_IngameCashShop_BuyHistory:GetSizeY() - (self._historyList[self._currentSlotIndex]._bg:GetSpanSize().y + self._historyList[self._currentSlotIndex]._bg:GetSizeY()) - 10
end
function PaGlobal_CashShopBuyHistory:SetScroll()
  local uiGroup = self._historyList[self._maxHistoryCount - 1]
  if nil ~= uiGroup then
    local uiGroupKey = uiGroup[1]
    if nil ~= uiGroupKey then
      self._ui._scroll:SetSize(self._ui._scroll:GetSizeX(), uiGroupKey._bg:GetSizeY() + uiGroupKey._bg:GetPosY())
    else
      self._ui._scroll:SetSize(self._ui._scroll:GetSizeX(), self._remainSizeY)
    end
  else
    self._ui._scroll:SetSize(self._ui._scroll:GetSizeX(), self._remainSizeY)
  end
  local scrollSizeY = self._ui._scroll:GetSizeY()
  local pagePercent = self._maxHistoryCount / self._historyCount * 100
  local btn_scrollSizeY = scrollSizeY / 100 * pagePercent
  if btn_scrollSizeY < 10 then
    btn_scrollSizeY = 10
  end
  if scrollSizeY <= btn_scrollSizeY then
    btn_scrollSizeY = scrollSizeY * 0.99
  end
  self._ui._btn_scroll:SetSize(self._ui._btn_scroll:GetSizeX(), btn_scrollSizeY)
  if self._maxHistoryCount + 1 < self._historyCount then
    self._ui._scroll:SetShow(true)
  else
    self._ui._scroll:SetShow(false)
  end
  self._ui._scroll:SetInterval(self._historyCount - self._maxHistoryCount - 1)
  self._ui._scroll:SetControlTop()
end
