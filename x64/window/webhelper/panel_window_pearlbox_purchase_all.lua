local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
PaGlobal_Window_PearlBox_Purchase_All = {
  web_control = nil,
  _ui = {
    _txt_Title = nil,
    _btn_Close = nil,
    _btn_Refresh = nil,
    _btn_PurchaseRefresh = nil,
    _stc_bg = nil
  },
  _webSizeX = 1350,
  _webSizeY = 720,
  _panelOriginalSize = 0,
  _bgOriginalSize = 0
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
function FGlobal_Window_PearlBox_Purchase_All_Show(url, restoreCount)
  if Panel_Window_PearlBox_Purchase_All:IsShow() then
    Panel_Window_PearlBox_Purchase_All:SetShow(false, true)
    TooltipSimple_Hide()
    PaGlobal_Window_PearlBox_Purchase_All.web_control:ResetUrl()
    return false
  else
    PaGlobal_Window_PearlBox_Purchase_All._ui._static_Construction:SetShow(true)
    Panel_Window_PearlBox_Purchase_All:SetShow(true, true)
    PaGlobal_Window_PearlBox_Purchase_All:takeAndShow(url, restoreCount)
    return true
  end
end
function FGlobal_Window_PearlBox_Purchase_All_ForceClose()
  if Panel_Window_PearlBox_Purchase_All:IsShow() then
    Panel_Window_PearlBox_Purchase_All:SetShow(false, true)
    PaGlobal_Window_PearlBox_Purchase_All.web_control:ResetUrl()
    TooltipSimple_Hide()
    return
  end
end
function Panel_Window_PearlBox_Purchase_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_PearlBox_Purchase_All)
  local aniInfo1 = Panel_Window_PearlBox_Purchase_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_PearlBox_Purchase_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_PearlBox_Purchase_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_PearlBox_Purchase_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_PearlBox_Purchase_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_PearlBox_Purchase_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_Window_PearlBox_Purchase_All_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_PearlBox_Purchase_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_PearlBox_Purchase_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_Window_PearlBox_Purchase_All:initialize()
  if nil == Panel_Window_PearlBox_Purchase_All then
    return
  end
  Panel_Window_PearlBox_Purchase_All:SetShow(false, false)
  self._ui._txt_Title = UI.getChildControl(Panel_Window_PearlBox_Purchase_All, "StaticText_Title")
  self._ui._btn_PurchaseRefresh = UI.getChildControl(Panel_Window_PearlBox_Purchase_All, "Button_Refresh")
  self._ui._static_Construction = UI.getChildControl(Panel_Window_PearlBox_Purchase_All, "Static_Construction")
  self._ui._btn_Close = UI.getChildControl(self._ui._txt_Title, "Button_Close")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._txt_Title, "Button_Refresh")
  self._ui._stc_bg = UI.getChildControl(Panel_Window_PearlBox_Purchase_All, "Static_1")
  local compareSizeX = Panel_Window_PearlBox_Purchase_All:GetSizeX() - self._webSizeX
  local compareSizeY = Panel_Window_PearlBox_Purchase_All:GetSizeY() - self._webSizeY
  self.web_control = UI.createControl(__ePAUIControl_WebControl, Panel_Window_PearlBox_Purchase_All, "WebCashPayment_Help_CharInfo")
  self.web_control:SetSize(self._webSizeX, self._webSizeY)
  self.web_control:SetHorizonCenter()
  self.web_control:SetVerticalTop()
  self.web_control:ResetUrl()
  self.web_control:SetSpanSize(0, 60)
  self.web_control:ComputePos()
  self.web_control:SetShow(false)
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._panelOriginalSize = Panel_Window_PearlBox_Purchase_All:GetSizeY()
  self._bgOriginalSize = self._ui._stc_bg:GetSizeY()
  self._ui._btn_PurchaseRefresh:SetShow(false)
  self:registerEventHandler()
  self:validate()
end
function PaGlobal_Window_PearlBox_Purchase_All:registerEventHandler()
  if nil == Panel_Window_PearlBox_Purchase_All then
    return
  end
  Panel_Window_PearlBox_Purchase_All:RegisterShowEventFunc(true, "Panel_Window_PearlBox_Purchase_All_ShowAni()")
  Panel_Window_PearlBox_Purchase_All:RegisterShowEventFunc(false, "Panel_Window_PearlBox_Purchase_All_HideAni()")
  Panel_Window_PearlBox_Purchase_All:setGlassBackground(true)
  Panel_Window_PearlBox_Purchase_All:ActiveMouseEventEffect(true)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "FGlobal_Window_PearlBox_Purchase_All_Show()")
  self._ui._btn_PurchaseRefresh:addInputEvent("Mouse_LUp", "FGlobal_Window_PearlBox_Purchase_Restore()")
end
function PaGlobal_Window_PearlBox_Purchase_All:validate()
  if nil == Panel_Window_PearlBox_Purchase_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Refresh:isValidate()
end
function PaGlobal_Window_PearlBox_Purchase_All:takeAndShow(url, restoreCount)
  Panel_Window_PearlBox_Purchase_All:SetShow(true, true)
  Panel_Window_PearlBox_Purchase_All:ComputePos()
  if restoreCount > 0 then
    PaGlobal_Window_PearlBox_Purchase_All._ui._btn_PurchaseRefresh:SetShow(true)
    Panel_Window_PearlBox_Purchase_All:SetSize(Panel_Window_PearlBox_Purchase_All:GetSizeX(), PaGlobal_Window_PearlBox_Purchase_All._panelOriginalSize + PaGlobal_Window_PearlBox_Purchase_All._ui._btn_PurchaseRefresh:GetSizeY() + 10)
    PaGlobal_Window_PearlBox_Purchase_All._ui._stc_bg:SetSize(PaGlobal_Window_PearlBox_Purchase_All._ui._stc_bg:GetSizeX(), PaGlobal_Window_PearlBox_Purchase_All._bgOriginalSize + 10)
  else
    PaGlobal_Window_PearlBox_Purchase_All._ui._btn_PurchaseRefresh:SetShow(false)
    Panel_Window_PearlBox_Purchase_All:SetSize(Panel_Window_PearlBox_Purchase_All:GetSizeX(), PaGlobal_Window_PearlBox_Purchase_All._panelOriginalSize)
    PaGlobal_Window_PearlBox_Purchase_All._ui._stc_bg:SetSize(PaGlobal_Window_PearlBox_Purchase_All._ui._stc_bg:GetSizeX(), PaGlobal_Window_PearlBox_Purchase_All._bgOriginalSize - PaGlobal_Window_PearlBox_Purchase_All._ui._btn_PurchaseRefresh:GetSizeY())
  end
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetHorizonCenter()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetVerticalTop()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetSpanSize(0, 60)
  PaGlobal_Window_PearlBox_Purchase_All.web_control:ComputePos()
  PaGlobal_Window_PearlBox_Purchase_All._ui._btn_PurchaseRefresh:ComputePos()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetUrl(self._webSizeX, self._webSizeY, url, false, true)
  if isGameTypeTaiwan() or isGameTypeNA() or isGameTypeKorea() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameTypeRussia() or isGameTypeJapan() or isGameTypeASIA() then
    PaGlobal_Window_PearlBox_Purchase_All.web_control:SetIME(true)
  end
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetSize(self._webSizeX, self._webSizeY)
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetHorizonCenter()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetVerticalTop()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetSpanSize(0, 60)
  PaGlobal_Window_PearlBox_Purchase_All.web_control:ComputePos()
  PaGlobal_Window_PearlBox_Purchase_All.web_control:SetShow(true)
end
function FromClient_resetCoherentUIPearlBox_Purchase()
  if Panel_Window_PearlBox_Purchase_All:GetShow() then
    TooltipSimple_Hide()
    FGlobal_Window_PearlBox_Purchase_All_ForceClose()
  end
end
function FromClient_Window_PearlBox_Purchase_All_Initialize()
  PaGlobal_Window_PearlBox_Purchase_All:initialize()
end
function FromClient_GetPurchaseCashProductFromWeb()
  FGlobal_Window_PearlBox_Purchase_All_ForceClose()
end
function FGlobal_Window_PearlBox_Purchase_Restore()
  PaGlobalFunc_WebPurchaseConfirm_All_Open()
end
function FromClinet_WebLoadComplete()
  PaGlobal_Window_PearlBox_Purchase_All._ui._static_Construction:SetShow(false)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_PearlBox_Purchase_All_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIPearlBox_Purchase")
registerEvent("FromClient_GetPurchaseCashProductFromWeb", "FromClient_GetPurchaseCashProductFromWeb")
registerEvent("FromClinet_WebLoadComplete", "FromClinet_WebLoadComplete")
