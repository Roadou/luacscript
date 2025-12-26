function HandleEventLUp_PaGlobal_Event_TicketShop_Draw(drawOrderNo)
  local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(drawOrderNo)
  if drawStaticStatusWrapper == nil then
    return
  end
  local itemStaticStatusWrapper = getItemEnchantStaticStatus(drawStaticStatusWrapper:getItemkey())
  if itemStaticStatusWrapper == nil then
    return
  end
  local function drawEffectOpen()
    local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(drawOrderNo)
    if drawStaticStatusWrapper == nil then
      return
    end
    if ToClient_CheckCanDrawItem(drawStaticStatusWrapper:getIndex()) == false then
      return
    end
    HandleEventLUp_PaGlobal_Event_TicketShop_Unboxing(drawOrderNo)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_TICKETSHOP_POPUP_TITLE"),
    content = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_EVENT_TICKETSHOP_POPUP_DESC", "ticket", drawStaticStatusWrapper:getCoinCount(), "item", FGlobal_ChangeItemNameColorByGrade(drawStaticStatusWrapper:getItemkey()), "coin", drawStaticStatusWrapper:getLoseCoinCount()),
    functionYes = drawEffectOpen,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_PaGlobal_Event_TicketShop_Unboxing(drawOrderNo)
  local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(drawOrderNo)
  if drawStaticStatusWrapper == nil then
    return
  end
  if Panel_Event_TicketShop_Unboxing == nil then
    return
  end
  PaGlobal_Event_TicketShop_SetFocusIndex(drawOrderNo)
  PaGlobal_Event_TicketShop_Unboxing_Open()
end
function HandleEventOnOut_PaGlobal_Event_TicketShop_EnableItemTooltip(drawOrderNo, isShow)
  if false == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  if drawOrderNo == -1 then
    HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(true, isShow)
    return
  elseif drawOrderNo == -2 then
    HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(false, isShow)
    return
  end
  local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(drawOrderNo)
  if drawStaticStatusWrapper == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(drawStaticStatusWrapper:getItemkey())
  if itemSSW == nil then
    return
  end
  if nil == Panel_Event_TicketShop then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Event_TicketShop, true)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_PaGlobal_Event_TicketShop_EnableCoinTooltip(isCoin, isShow)
  if false == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  local drawStaticStatusWrapper = getDrawItemStaticStatusByOrderIndex(0)
  if drawStaticStatusWrapper == nil then
    return
  end
  local itemKey = 0
  if isCoin == true then
    itemKey = drawStaticStatusWrapper:getCoinItemKey()
  else
    itemKey = drawStaticStatusWrapper:getLoseItemKey()
  end
  if itemKey == 0 then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if itemSSW == nil then
    return
  end
  if nil == Panel_Event_TicketShop then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Event_TicketShop, true)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_PaGlobal_Event_TicketShop_ShowItemTooltip()
  if PaGlobal_Event_TicketShop == nil then
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
  HandleEventOnOut_PaGlobal_Event_TicketShop_EnableItemTooltip(PaGlobal_Event_TicketShop._focusDrawOrderNo, true)
end
function PaGlobal_Event_TicketShop_Open()
  PaGlobal_Event_TicketShop:prepareOpen()
end
function PaGlobal_Event_TicketShop_Close()
  PaGlobal_Event_TicketShop:prepareClose()
end
function PaGlobal_Event_TicketShop_Unboxing_Open()
  PaGlobal_Event_TicketShop:prepareOpenUnboxing()
end
function PaGlobal_Event_TicketShop_Unboxing_Close()
  PaGlobal_Event_TicketShop:prepareCloseUnboxing()
end
function PaGlobal_Event_TicketShop_Unboxing_Result_Open(drawIndex, isWin)
  if drawIndex < 0 then
    PaGlobal_Event_TicketShop_Unboxing_Result_Close()
    return
  end
  PaGlobal_Event_TicketShop:prepareOpenUnboxingResult(drawIndex, isWin)
end
function PaGlobal_Event_TicketShop_Unboxing_Result_Close()
  PaGlobal_Event_TicketShop:prepareCloseUnboxingResult()
end
function PaGlobal_Event_TicketShop_OpenDetailLink()
  local linkURL = "https://www.kr.playblackdesert.com/ko-KR/News/Detail?groupContentNo=11256&countryType=ko-KR"
  if ToClient_isConsole() == true then
    local resourceType = ToClient_getResourceType()
    if resourceType == CppEnums.ServiceResourceType.eServiceResourceType_KR then
      linkURL = "https://www.console.playblackdesert.com/News/Notice/Detail?boardNo=20479&countryType=ko-KR&boardType=3&searchType=&searchText=&currentPage=1&progressType=1"
    elseif resourceType == CppEnums.ServiceResourceType.eServiceResourceType_DE then
      linkURL = "https://www.console.playblackdesert.com/news/notice/detail?boardno=20481&countrytype=de-DE&boardtype=3&searchtype=&searchtext=&currentpage=1&progresstype=1"
    elseif resourceType == CppEnums.ServiceResourceType.eServiceResourceType_FR then
      linkURL = "https://www.console.playblackdesert.com/news/notice/detail?boardno=20482&countrytype=fr-FR&boardtype=3&searchtype=&searchtext=&currentpage=1&progresstype=1"
    elseif resourceType == CppEnums.ServiceResourceType.eServiceResourceType_JP then
      linkURL = "https://www.console.playblackdesert.com/news/notice/detail?boardno=20483&countrytype=ja-JP&boardtype=3&searchtype=&searchtext=&currentpage=1&progresstype=1"
    else
      linkURL = "https://www.console.playblackdesert.com/news/notice/detail?boardno=20480&countrytype=en-US&boardtype=3&searchtype=&searchtext=&currentpage=1&progresstype=1"
    end
    PaGlobalFunc_WebControl_Open(linkURL)
  else
    if isGameTypeKorea() == true then
      linkURL = "https://www.kr.playblackdesert.com/ko-KR/News/Detail?groupContentNo=12786&countryType=ko-KR"
    end
    if isGameTypeJapan() == true then
      linkURL = "https://www.jp.playblackdesert.com/ja-JP/News/Detail?groupContentNo=9227&countryType=ja-JP"
    end
    if isGameTypeASIA() == true then
      linkURL = "https://blackdesert.pearlabyss.com/ASIA/News/Notice/Detail?_boardNo=6394"
    end
    if isGameTypeTaiwan() == true then
      linkURL = "https://www.tw.playblackdesert.com/zh-TW/News/Detail?groupContentNo=16534&countryType=zh-TW"
    end
    if isGameTypeRussia() == true then
      linkURL = "https://www.ru.playblackdesert.com/News/Notice/Detail?boardNo=9767&countryType=ru-RU"
    end
    if isGameTypeNA() == true then
      linkURL = "https://www.naeu.playblackdesert.com/News/Detail?groupContentNo=7464"
    end
    if isGameTypeSA() == true then
      linkURL = "https://www.sa.playblackdesert.com/News/Detail?groupContentNo=5100"
    end
    if isGameTypeTR() == true then
      linkURL = "https://www.tr.playblackdesert.com/News/Detail?groupContentNo=10985"
    end
    if _ContentsOption_CH_GameType == true then
      linkURL = "https://bd.qq.com/cp/a20240715gwyqyy/latestcontent.html"
    end
    ToClient_OpenChargeWebPage(linkURL, false)
  end
end
