function PaGlobal_CouponCode:initialize()
  if true == PaGlobal_CouponCode._initialize or nil == Panel_Window_CouponCode then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_Window_CouponCode, "StaticText_Title")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_Title, "StaticText_TitleIcon")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_CouponCode, "Button_Close")
  self._ui.btn_Qusetion = UI.getChildControl(Panel_Window_CouponCode, "Button_Question")
  self._ui.btn_Refresh = UI.getChildControl(Panel_Window_CouponCode, "Button_Refresh")
  self._ui.edit_CouponCode = UI.getChildControl(Panel_Window_CouponCode, "Edit_SearchText_PCUI_Import")
  if ToClient_isConsole() == true then
    Panel_Window_CouponCode:SetSize(1020, Panel_Window_CouponCode:GetSizeY())
    self._ui.stc_Title:SetSize(1020, self._ui.stc_Title:GetSizeY())
    self._webSizeX = 1000
  end
  self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_CouponCode, "WebControl_CouponCode")
  self._ui.stc_webControl:SetShow(true)
  self._ui.stc_webControl:SetHorizonCenter()
  self._ui.stc_webControl:SetSize(self._webSizeX, self._webSizeY)
  self._ui.stc_webControl:ComputePos()
  self._ui.stc_webControl:SetPosY(self._ui.stc_Title:GetSizeY() + 5)
  self._ui.stc_webControl:ResetUrl()
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_CouponCode:webInput(\"D_UP\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_CouponCode:webInput(\"D_DOWN\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobal_CouponCode:webInput(\"D_LEFT\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobal_CouponCode:webInput(\"D_RIGHT\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_CouponCode:webInput(\"A\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_CouponCode:webInput(\"X\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_CouponCode:webInput(\"Y\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_CouponCode:webInput(\"LT\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_CouponCode:webInput(\"RT\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_CouponCode:webInput(\"LB\")")
  Panel_Window_CouponCode:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_CouponCode:webInput(\"RB\")")
  PaGlobal_CouponCode:validate()
  PaGlobal_CouponCode:registEventHandler()
  self._ui.btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  PaGlobal_CouponCode._initialize = true
end
function PaGlobal_CouponCode:registEventHandler()
  Panel_Window_CouponCode:SetShow(false, false)
  Panel_Window_CouponCode:ActiveMouseEventEffect(true)
  Panel_Window_CouponCode:setGlassBackground(true)
  Panel_Window_CouponCode:RegisterShowEventFunc(true, "PaGlobalFunc_CouponCode_ShowAni()")
  Panel_Window_CouponCode:RegisterShowEventFunc(false, "PaGlobalFunc_CouponCode_HideAni()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CouponCode_Close()")
  PaGlobal_Util_RegistWebResetControl(self._ui.btn_Refresh)
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForCouponCode")
  registerEvent("FromClient_CustomizationAlbum_IsMainView", "FromClient_CouponCode_isMainView")
  registerEvent("FromClient_OpenPearlDirectWeb", "FromClient_OpenPearlDirectWebCoupon")
end
function PaGlobal_CouponCode:prepareOpen(url)
  if nil == Panel_Window_CouponCode then
    return
  end
  FGlobal_SetCandidate()
  local baseUrl = ToClient_getIngameCouponURL()
  if _ContentsGroup_PearlBoxWebBuy == true then
    baseUrl = url
  else
    if getServiceNationType() == 2 then
      baseUrl = string.gsub(baseUrl, "as%-", "asia%-")
    end
    if ToClient_isConsole() == true then
      local cultureCode = ToClient_GetWebCultureCode()
      local tag = ToClient_getURLAlphaTag()
      baseUrl = "https://" .. tostring(tag) .. "store.pearlabyss.com/blackdesert_console/" .. tostring(cultureCode) .. "/IngameCoupon/ConsoleIndex"
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
    else
      local _certKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
      local _userNo = getSelfPlayer():get():getUserNo()
      local _langType = ToClient_getResourceType()
      local _langTypeString = Defines.LanguageTypeToString[_langType]
      if "DV" == _langTypeString then
        _langTypeString = "KR"
      end
      if CppEnums.ServiceResourceType.eServiceResourceType_ID == _langType then
        _langTypeString = "EN"
      end
      baseUrl = baseUrl .. "?certKey=" .. tostring(_certKey) .. "&userNo=" .. tostring(_userNo) .. "&languageType=" .. tostring(_langTypeString)
      if _ContentsGroup_UsingPMAPI == true then
        local _loginId = ""
        if ToClient_isPS() == true then
          _loginId = ToClient_getPSAccountId()
        elseif ToClient_isXBox() == true then
          _loginId = ToClient_getUserPairwiseId()
        end
        baseUrl = baseUrl .. "&loginId=" .. tostring(_loginId)
      end
    end
  end
  self._ui.stc_webControl:SetUrl(self._webSizeX, self._webSizeY, baseUrl, false, true)
  self._ui.stc_webControl:SetIME(true)
  self._isMainView = true
  PaGlobal_CouponCode:open()
  Panel_Window_CouponCode:ComputePos()
end
function PaGlobal_CouponCode:open()
  if nil == Panel_Window_CouponCode then
    return
  end
  Panel_Window_CouponCode:SetShow(true)
end
function PaGlobal_CouponCode:prepareClose()
  if nil == Panel_Window_CouponCode then
    return
  end
  if self._isMainView == false then
    self:webInput("B")
    return
  end
  FGlobal_ClearCandidate()
  self._ui.stc_webControl:ResetUrl()
  PaGlobal_CouponCode:close()
end
function PaGlobal_CouponCode:close()
  if nil == Panel_Window_CouponCode then
    return
  end
  Panel_Window_CouponCode:SetShow(false)
end
function PaGlobal_CouponCode:validate()
  self._ui.stc_Title:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Qusetion:isValidate()
end
function PaGlobal_CouponCode:webInput(key)
  self._ui.stc_webControl:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function PaGlobal_CouponCode:showEditBox()
  self._ui.edit_CouponCode:SetShow(true)
  SetFocusEdit(self._ui.edit_CouponCode)
end
