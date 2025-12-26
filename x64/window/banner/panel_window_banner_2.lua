function HandleEventMLUp_Banner_ClickEvent()
  if PaGlobal_Banner._eBannerType._onAir == PaGlobal_Banner._currentBanner then
    ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesertkr")
  elseif PaGlobal_Banner._eBannerType._blackFriday == PaGlobal_Banner._currentBanner then
    PaGlobal_Banner_GoToPearlShop()
  end
  PaGlobal_Banner:updatePerSkipNextState()
end
function HandleEventMLUp_Banner_NotShowClose()
  PaGlobal_Banner:saveNoShowToDay(PaGlobal_Banner._currentBanner)
  PaGlobal_Banner:updatePerSkipNextState()
end
function FromClient_Banner_luaLoadCompleteLateUdpate()
  PaGlobal_Banner:wholeUpdateBanner()
end
function FromClient_Banner_showOnAirBanner(isOnAir)
  if nil == Panel_Window_Banner then
    return
  end
  if true == isOnAir then
    PaGlobal_Banner:runSingleBanner(PaGlobal_Banner._eBannerType._onAir)
  elseif true == Panel_Window_Banner:GetShow() and PaGlobal_Banner._eBannerType._onAir == PaGlobal_Banner._currentBanner then
    PaGlobal_Banner:updatePerSkipNextState()
  end
end
function PaGloabl_Banner_ShowAni()
  if nil == Panel_Window_Banner then
    return
  end
  local startAniTime = PaGlobal_Banner._startAniTime[PaGlobal_Banner._currentBanner]
  local ImageMoveAni = Panel_Window_Banner:addMoveAnimation(startAniTime._start, startAniTime._end, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - 10)
  ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - Panel_Window_Banner:GetSizeY() - 10)
  ImageMoveAni.IsChangeChild = true
end
function PaGloabl_Banner_HideAni()
  if nil == Panel_Window_Banner then
    return
  end
  local endAniTime = PaGlobal_Banner._endAniTime[PaGlobal_Banner._currentBanner]
  local ImageMoveAni = Panel_Window_Banner:addMoveAnimation(endAniTime._start, endAniTime._end, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY() - Panel_Window_Banner:GetSizeY() - 10)
  ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Window_Banner:GetSizeX() + 10, getScreenSizeY() + 10)
  ImageMoveAni.IsChangeChild = true
  ImageMoveAni:SetHideAtEnd(false)
end
function PaGlobal_Banner_UpdatePerframe(deltaTime)
  if PaGlobal_Banner._eFrameState._bannerView == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_bannerView(deltaTime)
  elseif PaGlobal_Banner._eFrameState._bannerViewEnd == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updateCheckBannerViewEnd()
  elseif PaGlobal_Banner._eFrameState._bannerCheck == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_bannerCheck(deltaTime)
  elseif PaGlobal_Banner._eFrameState._end == PaGlobal_Banner._currentFrame then
    PaGlobal_Banner:updatePerFrame_End(deltaTime)
  end
end
function PaGloabl_Banner_GetOnAirURL()
  if CppEnums.CountryType.KR2_REAL == getGameServiceType() or CppEnums.CountryType.KR2_ALPHA == getGameServiceType() then
    local urlBanner = "https://bd.qq.com/cp/a20240830bd/bottom_on_air_banner.html"
    return urlBanner
  end
  local url = ToClient_getInGamePortalURL() .. "/Banner/BottomBanner"
  return url
end
function PaGloabl_Banner_GetBloodAltarURL()
  local url = ToClient_getInGamePortalURL() .. "/CashShop/Banner/BottomBanner"
  return url
end
function PaGlobal_Banner_GetEventPageMoveURL()
  local url
  if isGameTypeKorea() then
    url = "https://www.kr.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TW_REAL == getGameServiceType() or CppEnums.CountryType.TW_ALPHA == getGameServiceType() then
    url = "https://www.tw.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TR_REAL == getGameServiceType() or CppEnums.CountryType.TR_ALPHA == getGameServiceType() then
    url = "https://www.tr.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.TH_REAL == getGameServiceType() or CppEnums.CountryType.TH_ALPHA == getGameServiceType() then
    url = "https://www.th.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.ID_REAL == getGameServiceType() or CppEnums.CountryType.ID_ALPHA == getGameServiceType() then
    url = "https://www.sea.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.RUS_REAL == getGameServiceType() or CppEnums.CountryType.RUS_ALPHA == getGameServiceType() then
    url = "https://www.ru.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.SA_REAL == getGameServiceType() or CppEnums.CountryType.SA_ALPHA == getGameServiceType() then
    url = "https://www.sa.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.NA_REAL == getGameServiceType() or CppEnums.CountryType.NA_ALPHA == getGameServiceType() then
    url = "https://www.naeu.playblackdesert.com/News/Notice?boardType=3"
  elseif CppEnums.CountryType.JPN_REAL == getGameServiceType() or CppEnums.CountryType.JPN_ALPHA == getGameServiceType() then
    url = "https://www.jp.playblackdesert.com/News/Notice?boardType=3"
  else
    url = ""
  end
  return url
end
function PaGlobal_Banner_GetNewProductURL()
  local parameter = ""
  if PaGlobal_BottomBanner_IsShowNewbieProcuct() == true then
    parameter = "?contentType=11" .. "&targetProductType=1"
  end
  if CppEnums.CountryType.KR2_REAL == getGameServiceType() or CppEnums.CountryType.KR2_ALPHA == getGameServiceType() then
    local urlBanner = "https://bd.qq.com/cp/a20240830bd/bottom_product_banner.html"
    return urlBanner .. parameter
  end
  return ToClient_getInGamePortalURL() .. "/CashShop/Banner/BottomBanner" .. parameter
end
function PaGlobal_Banner_Close()
  if false == Panel_Window_Banner:GetShow() then
    return
  end
  PaGlobal_Banner:updatePerSkipNextState()
end
function PaGlobal_Banner_GoToPearlShop()
  InGameShop_Open()
  InGameShop_TabEvent(1)
  InGameShop_Promotion_Close()
end
function PaGlobal_BottomBanner_CheckForDay()
  HandleEventMLUp_Banner_NotShowClose()
end
function PaGlobal_BottomBanner_IsShowNewbieProcuct()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return false
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if userType ~= 2 then
    return false
  end
  local InGameCashShopWrapper = getIngameCashMall()
  if InGameCashShopWrapper == nil then
    return false
  end
  local productNoRaw = ToClient_GetNewbieCashProductNoRaw()
  if productNoRaw <= 0 then
    return false
  end
  local cashProduct = InGameCashShopWrapper:getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if cashProduct == nil then
    return false
  end
  local limitType = cashProduct:getCashPurchaseLimitType()
  if CppEnums.CashPurchaseLimitType.None == limitType then
    return false
  end
  local limitCount = cashProduct:getCashPurchaseCount()
  if limitCount <= 0 then
    return false
  end
  local mylimitCount = InGameCashShopWrapper:getRemainingLimitCount(cashProduct:getNoRaw())
  if mylimitCount <= 0 then
    return false
  end
  return true
end
