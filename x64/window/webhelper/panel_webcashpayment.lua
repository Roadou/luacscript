local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
PaGlobal_WebCashPayment = {
  web_control = nil,
  _ui = {
    _txt_Title = nil,
    _btn_Close = nil,
    _btn_Refresh = nil
  },
  _webSizeX = 1090,
  _webSizeY = 645
}
local countryType = ""
local isIME = false
if isGameTypeTaiwan() then
  countryType = "_TW"
  isIME = true
elseif isGameTypeTR() then
  countryType = "_TR"
  isIME = true
elseif isGameTypeTH() then
  countryType = "_TH"
  isIME = true
elseif isGameTypeID() then
  countryType = "_ID"
  isIME = true
elseif isGameTypeSA() then
  if CppEnums.ServiceResourceType.eServiceResourceType_SA == getGameServiceResType() then
    countryType = "_SA"
  elseif CppEnums.ServiceResourceType.eServiceResourceType_PT == getGameServiceResType() then
    countryType = "_PT"
  end
elseif isGameTypeRussia() then
  countryType = "_RU"
elseif isGameTypeJapan() then
  countryType = "_JP"
elseif isGameTypeNA() then
  countryType = "_NA"
end
function FGlobal_WebCashPayment_Show(url)
  if Panel_WebCashPayment:IsShow() then
    Panel_WebCashPayment:SetShow(false, true)
    TooltipSimple_Hide()
    PaGlobal_WebCashPayment.web_control:ResetUrl()
    return false
  else
    Panel_WebCashPayment:SetShow(true, true)
    PaGlobal_WebCashPayment:takeAndShow(url)
    return true
  end
end
function FGlobal_WebCashPayment_ForceClose()
  if Panel_WebCashPayment:IsShow() then
    Panel_WebCashPayment:SetShow(false, true)
    PaGlobal_WebCashPayment.web_control:ResetUrl()
    TooltipSimple_Hide()
    return
  end
end
function Panel_WebCashPayment_ShowAni()
  UIAni.fadeInSCR_Down(Panel_WebCashPayment)
  local aniInfo1 = Panel_WebCashPayment:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_WebCashPayment:GetSizeX() / 2
  aniInfo1.AxisY = Panel_WebCashPayment:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_WebCashPayment:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_WebCashPayment:GetSizeX() / 2
  aniInfo2.AxisY = Panel_WebCashPayment:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_WebCashPayment_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_WebCashPayment:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_WebCashPayment, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_WebCashPayment:initialize()
  if nil == Panel_WebCashPayment then
    return
  end
  Panel_WebCashPayment:SetShow(false, false)
  self._ui._txt_Title = UI.getChildControl(Panel_WebCashPayment, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._txt_Title, "Button_Close")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._txt_Title, "Button_Refresh")
  self.web_control = UI.createControl(__ePAUIControl_WebControl, Panel_WebCashPayment, "WebCashPayment_Help_CharInfo")
  self.web_control:SetSize(self._webSizeX, self._webSizeY)
  self.web_control:SetHorizonCenter()
  self.web_control:SetVerticalTop()
  self.web_control:ResetUrl()
  self.web_control:SetSpanSize(0, 60)
  self.web_control:ComputePos()
  self.web_control:SetShow(false)
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self:registerEventHandler()
  self:validate()
end
function PaGlobal_WebCashPayment:registerEventHandler()
  if nil == Panel_WebCashPayment then
    return
  end
  Panel_WebCashPayment:RegisterShowEventFunc(true, "Panel_WebCashPayment_ShowAni()")
  Panel_WebCashPayment:RegisterShowEventFunc(false, "Panel_WebCashPayment_HideAni()")
  Panel_WebCashPayment:setGlassBackground(true)
  Panel_WebCashPayment:ActiveMouseEventEffect(true)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "FGlobal_WebCashPayment_Show()")
end
function PaGlobal_WebCashPayment:validate()
  if nil == Panel_WebCashPayment then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Refresh:isValidate()
end
function PaGlobal_WebCashPayment:takeAndShow(url)
  Panel_WebCashPayment:SetShow(true, true)
  Panel_WebCashPayment:ComputePos()
  PaGlobal_WebCashPayment.web_control:SetHorizonCenter()
  PaGlobal_WebCashPayment.web_control:SetVerticalTop()
  PaGlobal_WebCashPayment.web_control:SetSpanSize(0, 60)
  PaGlobal_WebCashPayment.web_control:ComputePos()
  PaGlobal_WebCashPayment.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
  if isGameTypeTaiwan() or isGameTypeNA() or isGameTypeKorea() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameTypeRussia() or isGameTypeJapan() or isGameTypeASIA() then
    PaGlobal_WebCashPayment.web_control:SetIME(true)
  end
  PaGlobal_WebCashPayment.web_control:SetSize(self._webSizeX, self._webSizeY)
  PaGlobal_WebCashPayment.web_control:SetHorizonCenter()
  PaGlobal_WebCashPayment.web_control:SetVerticalTop()
  PaGlobal_WebCashPayment.web_control:SetSpanSize(0, 60)
  PaGlobal_WebCashPayment.web_control:ComputePos()
  PaGlobal_WebCashPayment.web_control:SetShow(true)
end
function FromClient_resetCoherentUIForWebCashPayment()
  if Panel_WebCashPayment:GetShow() then
    TooltipSimple_Hide()
    FGlobal_WebCashPayment_ForceClose()
  end
end
function FromClient_WebCashPayment_Initialize()
  PaGlobal_WebCashPayment:initialize()
end
function FromClient_OpenPayUrlMidas(url)
  FGlobal_WebCashPayment_Show(url)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_WebCashPayment_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForWebCashPayment")
registerEvent("FromClient_OpenPayUrlMidas", "FromClient_OpenPayUrlMidas")
