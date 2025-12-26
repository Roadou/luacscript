function PaGlobal_CashShopBuyHistory_Open()
  if Panel_IngameCashShop_BuyHistory == nil then
    return
  end
  if Panel_IngameCashShop_BuyHistory:GetShow() == true then
    return
  end
  PaGlobal_CashShopBuyHistory:prepareOpen()
end
function PaGlobal_CashShopBuyHistory_Close()
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  PaGlobal_CashShopBuyHistory:prepareClose()
end
function PaGlobal_CashShopBuyHistory_ChangeClickTexture(controlIndex, isClick)
  if nil == PaGlobal_CashShopBuyHistory._historyList[controlIndex] then
    return
  end
  if true == isClick then
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG", 0)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG", 1)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG", 2)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:setRenderTexture(PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:getBaseTexture())
  else
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG_Normal", 0)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG_Over", 1)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:ChangeTextureInfoTextureIDAsync("IngameCashShop_CashList_Frame_BG", 2)
    PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:setRenderTexture(PaGlobal_CashShopBuyHistory._historyList[controlIndex]._bg:getBaseTexture())
  end
end
function HandleEvent_CashShopBuyHistory_OpenRefundInfo()
  local eCountryType = CppEnums.CountryType
  local gameServiceType = getGameServiceType()
  if eCountryType.KOR_ALPHA == gameServiceType or eCountryType.KOR_TEST == gameServiceType or eCountryType.DEV == gameServiceType then
    ToClient_OpenChargeWebPage("https://paalphaqa-www.kr.playblackdesert.com/ko-KR/Wiki?wikiNo=291", false)
  elseif eCountryType.JPN_ALPHA == gameServiceType or eCountryType.JPN_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.jp.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif eCountryType.RUS_ALPHA == gameServiceType or eCountryType.RUS_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.ru.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif eCountryType.TW_ALPHA == gameServiceType or eCountryType.TW_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.tw.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif eCountryType.TH_ALPHA == gameServiceType or eCountryType.TH_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.th.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif eCountryType.TR_ALPHA == gameServiceType or eCountryType.TR_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.tr.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif isGameTypeID() == true then
    ToClient_OpenChargeWebPage("https://www.sea.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif eCountryType.KOR_REAL == gameServiceType then
    ToClient_OpenChargeWebPage("https://www.kr.playblackdesert.com/Wiki/Search/self_cancel", false)
  elseif isGameTypeNA() == true then
    ToClient_OpenChargeWebPage("https://www.naeu.playblackdesert.com/Wiki/Search/self_cancel", false)
  end
end
function HandleEvent_CashShopBuyHistory_Scroll(value)
  if false == Panel_IngameCashShop_BuyHistory:IsShow() then
    return
  end
  PaGlobal_CashShopBuyHistory:Scrolling(value)
end
function HandleEventLPress_ICashShopBuyHistory_ScrollBtn(isUp)
  if isUp == true then
    HandleEvent_CashShopBuyHistory_Scroll(-1)
    return
  elseif isUp == false then
    HandleEvent_CashShopBuyHistory_Scroll(1)
    return
  end
  local posByIndex = 1 / (PaGlobal_CashShopBuyHistory._historyCount - PaGlobal_CashShopBuyHistory._maxHistoryCount)
  local currentIndex = math.floor(PaGlobal_CashShopBuyHistory._ui._scroll:GetControlPos() / posByIndex)
  local value1 = currentIndex - PaGlobal_CashShopBuyHistory._currentSlotIndex
  PaGlobal_CashShopBuyHistory:Scrolling(value1)
end
function HandleEventLUp_CashShopBuyHistory_RequestRefund(index, controlIndex, eventCartNo)
  if PaGlobal_CashShopBuyHistory._dontUseRefund == true then
    return
  end
  local refundAble = ToClient_CheckRefundAbleCashProductByIndex(index, false)
  if refundAble == false then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack_Open(index, controlIndex, eventCartNo)
end
function HandleEventOnOut_CashShopBuyHistory_ShowToolTip(isShow, controlIndex, productKeyRaw)
  if PaGlobal_CashShopBuyHistory._historyList[controlIndex] == nil then
    return
  end
  if false == isShow then
    FGlobal_CashShop_GoodsTooltipInfo_Close()
    return
  end
  FGlobal_CashShop_GoodsTooltipInfo_Open(productKeyRaw, PaGlobal_CashShopBuyHistory._historyList[controlIndex]._icon, false)
end
function HandleEvent_CashShopBuyHistory_ShowRefundButton(isShow, controlIndex)
  if PaGlobal_CashShopBuyHistory._historyList[controlIndex] == nil then
    return
  end
  if PaGlobal_CashShopBuyHistory._dontUseRefund == true then
    return
  end
  if true == isShow then
    for ii = 1, #PaGlobal_CashShopBuyHistory._historyList do
      PaGlobal_CashShopBuyHistory._historyList[ii]._refund:SetShow(false)
    end
  end
  PaGlobal_CashShopBuyHistory._historyList[controlIndex]._refund:SetShow(isShow)
end
function FromClient_CashShopBuyHistory_NotifyHistory(count, leftCount)
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  PaGlobal_CashShopBuyHistory:updateList(count)
  PaGlobal_CashShopBuyHistory._currentSlotIndex = 1
  PaGlobal_CashShopBuyHistory:SetScroll()
  PaGlobal_CashShopBuyHistory:Scrolling(0)
  PaGlobal_CashShopBuyHistory._leftRefundCount = leftCount
  PaGlobal_CashShopBuyHistory._ui._txt_refundCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_CANCELCOUNT", "count", PaGlobal_CashShopBuyHistory._leftRefundCount))
end
function FromClient_CashShopBuyHistory_NotifyRefundCompleteIndex(index, symNo)
  if nil == Panel_IngameCashShop_BuyHistory then
    return
  end
  if symNo ~= 0 then
    PaGlobal_IngameCashShop_DescOpen()
    return
  end
  local history = PaGlobal_CashShopBuyHistory._historyList[PaGlobal_IngameCashSHop_ReturnBack._selectControlIndex]
  if history == nil then
    return
  end
  local productName = history._name:GetText()
  local pearlCount = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(index))
  local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURN_CONFIRM_MSG", "product", productName, "pearlCount", pearlCount)
  Proc_ShowMessage_Ack(text)
  PaGlobal_IngameCashSHop_ReturnBack_Close()
  history._reason:SetShow(true)
  history._reason:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURNBACK_HASRETURN"))
  PaGlobal_CashShopBuyHistory._leftRefundCount = PaGlobal_CashShopBuyHistory._leftRefundCount - 1
  if 0 > PaGlobal_CashShopBuyHistory._leftRefundCount then
    PaGlobal_CashShopBuyHistory._leftRefundCount = 0
  end
  PaGlobal_CashShopBuyHistory._ui._txt_refundCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_CANCELCOUNT", "count", PaGlobal_CashShopBuyHistory._leftRefundCount))
  PaGlobal_CashShopBuyHistory:updateList(PaGlobal_CashShopBuyHistory._realHistoryCount)
  HandleEventLPress_ICashShopBuyHistory_ScrollBtn()
end
