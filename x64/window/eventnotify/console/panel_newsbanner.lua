local _panel = Panel_NewsBanner
local NewsBanner = {
  _ui = {},
  _currentBannerPage = 1,
  _bannerIsReady = {}
}
if _ContentsGroup_RenewUI == true then
  NewsBanner._ui = {
    stc_bannerArea = UI.getChildControl(_panel, "Static_BannerArea"),
    stc_keyguideBG = UI.getChildControl(_panel, "Static_KeyguideBG")
  }
else
  NewsBanner._ui = {
    stc_bannerArea = UI.getChildControl(_panel, "Static_BannerArea"),
    stc_keyguideBG = UI.getChildControl(_panel, "Static_KeyGuide_ConsoleUI_Import"),
    btn_close = UI.getChildControl(UI.getChildControl(_panel, "StaticText_TitleBg"), "Button_Close"),
    txt_close = UI.getChildControl(_panel, "StaticText_Close")
  }
end
local screenX = getScreenSizeX()
local screenY = getScreenSizeY()
local self = NewsBanner
function NewsBanner:init()
  if _ContentsGroup_RenewUI == true or _ContentsGroup_UsePadSnapping == true then
    self._ui.stc_keyguideB = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_B_ConsoleUI")
    self._ui.stc_keyguideA = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_A_ConsoleUI")
    if _ContentsGroup_RenewUI == false then
      self._ui.stc_keyguideX = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_X_ConsoleUI")
    end
    local keyGuides = {}
    if _ContentsGroup_RenewUI == true then
      keyGuides = {
        self._ui.stc_keyguideA,
        self._ui.stc_keyguideB
      }
    else
      keyGuides = {
        self._ui.stc_keyguideX,
        self._ui.stc_keyguideA,
        self._ui.stc_keyguideB
      }
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui.stc_keyguideBG:SetShow(false)
  end
  if _ContentsGroup_Console_WebBanner == false then
    self._ui.stc_bannerArea:SetShow(false)
    return
  end
  self._ui.stc_bannerArea:SetShow(true)
  self._ui.stc_bannerBGs = {
    [0] = UI.getChildControl(self._ui.stc_bannerArea, "Static_TopBanner"),
    [1] = UI.getChildControl(self._ui.stc_bannerArea, "Static_MidBanner"),
    [2] = UI.getChildControl(self._ui.stc_bannerArea, "Static_BottomBanner")
  }
  if _ContentsGroup_RenewUI == false then
    self._ui.stc_bannerBGs[3] = UI.getChildControl(self._ui.stc_bannerArea, "Static_DailyReward")
    self._ui.stc_bannerBGs[4] = UI.getChildControl(self._ui.stc_bannerArea, "Static_NewbieReturn")
    if _ContentsGroup_UsePadSnapping == false then
      self._ui.txt_close:addInputEvent("Mouse_LUp", "PaGlobal_Recommend_PopUp_Check_NoShowToday()")
      self._ui.txt_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMEBANNER_TODAYNOSHOW"))
      self._ui.txt_close:SetShow(true)
    else
      self._ui.txt_close:SetShow(false)
    end
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_NewsBanner_Close()")
  end
  self._ui.web_banners = {}
  for ii = 0, #self._ui.stc_bannerBGs do
    self._ui.web_banners[ii] = UI.createControl(__ePAUIControl_WebControl, self._ui.stc_bannerBGs[ii], "web_topBanner" .. ii)
    self._ui.web_banners[ii]:ResetUrl()
    self._ui.web_banners[ii]:SetSize(self._ui.stc_bannerBGs[ii]:GetSizeX() - 20, self._ui.stc_bannerBGs[ii]:GetSizeY() - 20)
    self._ui.web_banners[ii]:SetHorizonCenter()
    self._ui.web_banners[ii]:SetVerticalMiddle()
    if _ContentsGroup_RenewUI == true or _ContentsGroup_UsePadSnapping == true then
      self._ui.web_banners[ii]:addInputEvent("Mouse_On", "InputMOn_NewsBanner_OverWebBanner_KeyGuide(true)")
      self._ui.web_banners[ii]:addInputEvent("Mouse_Out", "InputMOn_NewsBanner_OverWebBanner_KeyGuide(false)")
      self._ui.stc_bannerBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_LB, "Input_NewsBanner_ToWebBanner(\"LB\", " .. ii .. ")")
      self._ui.stc_bannerBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_RB, "Input_NewsBanner_ToWebBanner(\"RB\", " .. ii .. ")")
      self._ui.stc_bannerBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "Input_NewsBanner_ToWebBanner(\"A\", " .. ii .. ")")
      if _ContentsGroup_RenewUI == false then
        self._ui.web_banners[ii]:addInputEvent("Mouse_On", "InputMOn_NewsBanner_OverWebBanner_PC(true, " .. ii .. ")")
        self._ui.web_banners[ii]:addInputEvent("Mouse_Out", "InputMOn_NewsBanner_OverWebBanner_PC(false, " .. ii .. ")")
        self._ui.stc_bannerBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Recommend_PopUp_Check_NoShowToday()")
        if ii == 3 then
          self._ui.stc_bannerBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_EventGuide_Total_Open()")
        end
      end
    else
      self._ui.web_banners[ii]:addInputEvent("Mouse_On", "InputMOn_NewsBanner_OverWebBanner_PC(true, " .. ii .. ")")
      self._ui.web_banners[ii]:addInputEvent("Mouse_Out", "InputMOn_NewsBanner_OverWebBanner_PC(false, " .. ii .. ")")
      if ii == 3 then
        self._ui.web_banners[ii]:addInputEvent("Mouse_LUp", "PaGlobalFunc_EventGuide_Total_Open()")
      end
    end
  end
  local keyGuideLB = UI.getChildControl(self._ui.stc_bannerBGs[1], "StaticText_KeyGuideLB")
  local keyGuideRB = UI.getChildControl(self._ui.stc_bannerBGs[1], "StaticText_KeyGuideRB")
  if _ContentsGroup_RenewUI == true or _ContentsGroup_UsePadSnapping == true then
    self._ui.stc_bannerBGs[1]:SetChildIndex(keyGuideLB, self._ui.stc_bannerBGs[1]:GetChildSize())
    self._ui.stc_bannerBGs[1]:SetChildIndex(keyGuideRB, self._ui.stc_bannerBGs[1]:GetChildSize())
    keyGuideLB:SetShow(true)
    keyGuideRB:SetShow(true)
  else
    keyGuideLB:SetShow(false)
    keyGuideRB:SetShow(false)
  end
  self:registEventHandler()
end
function NewsBanner:initBanners()
  local domainURL = ""
  if nil ~= ToClient_getWebBannerURL then
    domainURL = ToClient_getWebBannerURL()
  end
  if _ContentsGroup_UsingPMAPI == true then
    if nil == domainURL or "" == domainURL then
      domainURL = "https://dev-game-portal.xbox.playblackdesert.com/Banner?bannerType=0"
    else
      local cultureCode = ToClient_GetWebCultureCode()
      domainURL = "https://" .. domainURL .. "/Console/" .. cultureCode .. "/Game/InGame/PositionBanner?bannerType=0"
    end
    if _ContentsGroup_isXBOXUI == true then
      domainURL = domainURL .. "&gameRegion=" .. tostring(ToClient_getGeoIDByXboxDefaultLocale())
    elseif _ContentsGroup_isPS4UI == true then
      domainURL = domainURL .. "&gameRegion=" .. tostring(ToClient_getPSServerInfoKeyArea())
    else
      _PA_ASSERT(false, "\236\158\152\235\170\187\235\144\156 Region Code \236\158\133\235\139\136\235\139\164.")
      return
    end
    domainURL = domainURL .. "&bannerPosition="
  elseif _ContentsGroup_RenewUI == true then
    if nil == domainURL or "" == domainURL then
      domainURL = "https://dev-game-portal.xbox.playblackdesert.com/Banner?bannerType="
    else
      domainURL = "https://" .. domainURL .. "/Ingame/Banner?bannerType="
    end
    domainURL = domainURL .. "0&bannerPosition="
  end
  if _ContentsOption_CH_GameType == true then
    self._ui.web_banners[0]:SetUrl(self._ui.web_banners[0]:GetSizeX(), self._ui.web_banners[0]:GetSizeY(), domainURL .. "right_top.html", false, true)
    self._ui.web_banners[1]:SetUrl(self._ui.web_banners[1]:GetSizeX(), self._ui.web_banners[1]:GetSizeY(), domainURL .. "left.html", false, true)
    self._ui.web_banners[2]:SetUrl(self._ui.web_banners[2]:GetSizeX(), self._ui.web_banners[2]:GetSizeY(), domainURL .. "right_middle.html", false, true)
    self._ui.web_banners[3]:SetUrl(self._ui.web_banners[3]:GetSizeX(), self._ui.web_banners[3]:GetSizeY(), domainURL .. "right_down.html", false, true)
    self._ui.web_banners[4]:SetUrl(self._ui.web_banners[4]:GetSizeX(), self._ui.web_banners[4]:GetSizeY(), domainURL .. "down.html", false, true)
  else
    for ii = 0, #self._ui.stc_bannerBGs do
      local finalDomain = domainURL .. tostring(ii)
      self._ui.web_banners[ii]:ResetUrl()
      if isGameTypeASIA() == true then
        finalDomain = finalDomain .. "&gameRegion=ASIA"
      end
      self._ui.web_banners[ii]:SetUrl(self._ui.web_banners[ii]:GetSizeX(), self._ui.web_banners[ii]:GetSizeY(), finalDomain, false, true)
    end
  end
end
function NewsBanner:registEventHandler()
  registerEvent("FromClient_WebUIBannerEventForXBOX", "FromClient_WebUIBannerEvent_NewsBanner")
  registerEvent("FromClient_WebUIBannerIsReadyForXBOX", "FromClient_WebUIBannerIsReady_NewsBanner")
  registerEvent("FromClient_OpenNewsBanner", "FromClient_OpenNewsBanner")
end
function PaGlobalFunc_NewsBanner_Open()
  if true == ToClient_isPS then
    return
  end
  if _ContentsGroup_RenewUI == false and isGameTypeGT() == true then
    return
  end
  Panel_NewsBanner:SetShow(true)
  self:initBanners()
end
function PaGlobalFunc_NewsBanner_Close()
  for ii = 0, #self._ui.stc_bannerBGs do
    self._ui.web_banners[ii]:ResetUrl()
  end
  Panel_NewsBanner:SetShow(false)
end
function InputMOn_NewsBanner_OverWebBanner_KeyGuide(isOn)
  local self = NewsBanner
  self._ui.stc_keyguideA:SetShow(isOn)
  local keyGuides = {}
  if _ContentsGroup_RenewUI == true then
    keyGuides = {
      self._ui.stc_keyguideA,
      self._ui.stc_keyguideB
    }
  else
    keyGuides = {
      self._ui.stc_keyguideX,
      self._ui.stc_keyguideA,
      self._ui.stc_keyguideB
    }
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function InputMOn_NewsBanner_OverWebBanner_PC(isOn, bannerIndex)
  local self = NewsBanner
  if isOn == true then
    self._ui.stc_bannerBGs[bannerIndex]:setRenderTexture(self._ui.stc_bannerBGs[bannerIndex]:getOnTexture())
  else
    self._ui.stc_bannerBGs[bannerIndex]:setRenderTexture(self._ui.stc_bannerBGs[bannerIndex]:getBaseTexture())
  end
end
function Input_NewsBanner_ToWebBanner(key, bannerIndex)
  local self = NewsBanner
  if key == "A" and not self._bannerIsReady[bannerIndex] then
    MessageBox.showMessageBox({
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WEBCONTROL_PAGE_NOT_READY"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    })
    return
  end
  self._ui.web_banners[bannerIndex]:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function FromClient_WebUIBannerEvent_NewsBanner(linkType, link)
  if false == Panel_NewsBanner:GetShow() then
    return
  end
  if Defines.ConsoleBannerLinkType.InGameWeb == linkType then
    if _ContentsGroup_RenewUI == true then
      PaGlobalFunc_WebControl_Open(link)
    else
      ToClient_OpenChargeWebPage(link, false)
    end
  else
    MessageBox.showMessageBox({
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WEBCONTROL_PAGE_NOT_READY"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    })
  end
end
function FromClient_WebUIBannerIsReady_NewsBanner(bannerType, bannerIndex)
  local self = NewsBanner
  if 0 == bannerType then
    self._bannerIsReady[bannerIndex] = true
  end
end
function PaGlobal_Recommend_PopUp_Check_NoShowToday()
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eNewsBannerShowToday, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  Panel_NewsBanner:SetShow(false, true)
end
function PaGlobal_NewsBanner_Init()
  local self = NewsBanner
  self:init()
end
function PaGlobal_NewsBanner_Init_LateUpdate()
  if isFirstFieldEnterMode() == false then
    FromClient_OpenNewsBanner()
  end
end
function FromClient_OpenNewsBanner()
  if _ContentsGroup_RenewUI == true then
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if regionInfo ~= nil then
    local isSafeZone = regionInfo:get():isSafeZone()
    if isSafeZone == false then
      return
    end
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eNewsBannerShowToday)
  if dayCheck ~= nil then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return
    end
  end
  PaGlobalFunc_NewsBanner_Open()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_NewsBanner_Init")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "PaGlobal_NewsBanner_Init_LateUpdate")
