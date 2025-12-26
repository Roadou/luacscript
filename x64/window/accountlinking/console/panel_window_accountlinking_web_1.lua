function PaGlobal_AccountLinking_Web:initialize()
  if _ContentsGroup_UsingPMAPI == false then
    return
  end
  if PaGlobal_AccountLinking_Web._initialize == true or Panel_Window_AccountLinking_Web == nil then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_Window_AccountLinking_Web, "StaticText_Title")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_Title, "StaticText_TitleIcon")
  self._ui.btn_Refresh = UI.getChildControl(Panel_Window_AccountLinking_Web, "Button_Refresh")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_AccountLinking_Web, "Button_Close")
  self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_AccountLinking_Web, "WebControl_AccountLinking")
  self._ui.stc_webControl:SetShow(true)
  self._ui.stc_webControl:SetSize(self._webSizeX, self._webSizeY)
  self._ui.stc_webControl:SetHorizonCenter()
  self._ui.stc_webControl:SetVerticalTop()
  self._ui.stc_webControl:SetSpanSize(0, 60)
  self._ui.stc_webControl:ComputePos()
  self._ui.stc_webControl:ResetUrl()
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_AccountLinking_Web:webInput(\"D_UP\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_AccountLinking_Web:webInput(\"D_DOWN\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobal_AccountLinking_Web:webInput(\"D_LEFT\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobal_AccountLinking_Web:webInput(\"D_RIGHT\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_AccountLinking_Web:webInput(\"A\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AccountLinking_Web:webInput(\"X\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_AccountLinking_Web:webInput(\"Y\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_AccountLinking_Web:webInput(\"LT\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_AccountLinking_Web:webInput(\"RT\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_AccountLinking_Web:webInput(\"LB\")")
  Panel_Window_AccountLinking_Web:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_AccountLinking_Web:webInput(\"RB\")")
  self:validate()
  self:registEventHandler()
  self._ui.btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._initialize = true
end
function PaGlobal_AccountLinking_Web:registEventHandler()
  Panel_Window_AccountLinking_Web:SetShow(false, false)
  Panel_Window_AccountLinking_Web:ActiveMouseEventEffect(true)
  Panel_Window_AccountLinking_Web:setGlassBackground(true)
  Panel_Window_AccountLinking_Web:RegisterShowEventFunc(true, "PaGlobalFunc_AccountLinking_Web_ShowAni()")
  Panel_Window_AccountLinking_Web:RegisterShowEventFunc(false, "PaGlobalFunc_AccountLinking_Web_HideAni()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_AccountLinking_Web_Close()")
  PaGlobal_Util_RegistWebResetControl(self._ui.btn_Refresh)
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForAccountLinking_Web")
end
function PaGlobal_AccountLinking_Web:prepareOpen()
  if nil == Panel_Window_AccountLinking_Web then
    return
  end
  local isEmpty = function(value)
    return value == "" or value == nil
  end
  FGlobal_SetCandidate()
  local tag = ToClient_getURLAlphaTag()
  local cultureCode = ToClient_GetWebCultureCode()
  local baseUrl = "https://" .. tostring(tag) .. "account.pearlabyss.com/" .. tostring(cultureCode) .. "/Member/Linking"
  local _loginId = ""
  local _accountNo = ""
  local _region = ""
  local _platform = ""
  if ToClient_isPS() == true then
    _loginId = ToClient_getPSAccountId()
    _accountNo = ToClient_getUserIDforPSAccountLink()
    _region = ToClient_getPSServerInfoKeyArea()
    _platform = "PS5"
  elseif ToClient_isXBox() == true then
    _loginId = ToClient_getUserPairwiseId()
    _accountNo = ToClient_getUserIDforXBAccountLink()
    _region = ToClient_getGeoIDByXboxDefaultLocale()
    _platform = "XBOX"
  end
  local _userNo = getSelfPlayer():get():getUserNo()
  local gameToken = tostring(_loginId) .. "|" .. tostring(_accountNo) .. "|" .. tostring(_userNo) .. "|" .. tostring(_region) .. "|" .. tostring(_platform)
  baseUrl = baseUrl .. "?_gameToken=" .. tostring(gameToken)
  self._ui.stc_webControl:SetUrl(self._webSizeX, self._webSizeY, baseUrl, false, true)
  self._ui.stc_webControl:SetIME(true)
  PaGlobal_AccountLinking_Web:open()
  Panel_Window_AccountLinking_Web:ComputePos()
end
function PaGlobal_AccountLinking_Web:open()
  if nil == Panel_Window_AccountLinking_Web then
    return
  end
  Panel_Window_AccountLinking_Web:SetShow(true)
end
function PaGlobal_AccountLinking_Web:prepareClose()
  if nil == Panel_Window_AccountLinking_Web then
    return
  end
  FGlobal_ClearCandidate()
  self._ui.stc_webControl:ResetUrl()
  PaGlobal_AccountLinking_Web:close()
end
function PaGlobal_AccountLinking_Web:close()
  if Panel_Window_AccountLinking_Web == nil then
    return
  end
  Panel_Window_AccountLinking_Web:SetShow(false)
end
function PaGlobal_AccountLinking_Web:validate()
  self._ui.stc_Title:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
end
function PaGlobal_AccountLinking_Web:webInput(key)
  self._ui.stc_webControl:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function PaGlobal_AccountLinking_Web:showEditBox()
  return
end
