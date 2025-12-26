local _socialActionLineCount = 15
local _optionPresetCount = 6
local _weatherRecommend = 15
local _vignettingCount = 4
function PaGlobal_PhotoMode:initialize()
  if self._initialize == true then
    return
  end
  Panel_PhotoMode_CenterFunction:SetSize(getScreenSizeX(), Panel_PhotoMode_CenterFunction:GetSizeY())
  Panel_PhotoMode_CenterFunction:ComputePos()
  self._ui.keyGuideArea = UI.getChildControl(Panel_PhotoMode_Main, "Static_KeyGuideArea")
  self._ui.keyGuideArea:SetIgnore(false)
  self._ui.txt_keyGuide = UI.getChildControl(self._ui.keyGuideArea, "Static_KeyGuideText_Temp")
  for idx = 1, self._keyGuideCount do
    self._keyGuideList[idx]._keyList = self:insertKeyCombination(self._keyGuideList[idx]._keyCombination)
  end
  local sourceControl = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_GuideText")
  for idx = 1, self._keyGuideCount do
    self._keyGuideList[idx]._keyGuideName = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_Option_" .. tostring(idx))
    CopyBaseProperty(sourceControl, self._keyGuideList[idx]._keyGuideName)
    self._keyGuideList[idx]._keyGuideName:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[idx]._keyOptionName))
    self._keyGuideList[idx]._keyGuideName:SetShow(true)
    self._keyGuideList[idx]._keyGuideName:SetTextMode(__eTextMode_LimitText)
    self._keyGuideList[idx]._keyGuideName:addInputEvent("Mouse_LUp", "HandleEventLUp_KeyGuideOptionName( " .. idx .. " )")
    if _photoModeOption.help == idx or _photoModeOption.optionPreset == idx then
      self._keyGuideList[idx]._keyGuideName:SetFontColor(Defines.Color.C_FFF5BA3A)
    end
  end
  self._ui.horizon = UI.getChildControl(self._ui.keyGuideArea, "Static_HorizonLine_Temp")
  for horizonIndex, value in pairs(self._horizonIndex) do
    local targetControl = UI.createControl(__ePAUIControl_Static, self._ui.keyGuideArea, "Static_horizon_" .. tostring(value))
    CopyBaseProperty(self._ui.horizon, targetControl)
  end
  self._ui.activateKeyOption = UI.getChildControl(self._ui.txt_keyGuide, "Static_Activate")
  self._ui.bottomSetting = UI.getChildControl(Panel_PhotoMode_Main, "Static_BottomSetting")
  self._ui.btn_reset = UI.getChildControl(self._ui.bottomSetting, "Button_Preset_Reset")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_ResetOption()")
  self._ui.btn_save = UI.getChildControl(self._ui.bottomSetting, "Button_Preset_Save")
  self._ui.btn_save:addInputEvent("Mouse_LUp", "HandleEventLUp_SaveOption()")
  for idx = 1, _optionPresetCount do
    self._optionPresetButton[idx] = UI.getChildControl(self._ui.bottomSetting, "Button_Preset_" .. idx)
    self._optionPresetButton[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectOptionPreset( " .. idx .. " )")
  end
  local CenterTitle = UI.getChildControl(Panel_PhotoMode_CenterFunction, "StaticText_CenterTitle")
  local SliderArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_Time_Area")
  local SliderAreaDec = UI.getChildControl(SliderArea, "StaticText_TimeDesc")
  local SliderBG = UI.getChildControl(SliderArea, "Static_SliderBG")
  local SliderProgress = UI.getChildControl(SliderArea, "Progress2_Time")
  local SliderProgressHead = UI.getChildControl(SliderProgress, "Progress2_1_Bar_Head")
  local Slider = UI.getChildControl(SliderArea, "Slider_Time")
  local SliderBtn = UI.getChildControl(Slider, "Slider_1_Button")
  local SliderMin = UI.getChildControl(SliderArea, "StaticText_Time_0")
  local SliderCurrent = UI.getChildControl(SliderArea, "StaticText_Time_Current")
  local SliderMax = UI.getChildControl(SliderArea, "StaticText_Time_24")
  local SliderMoon1 = UI.getChildControl(SliderArea, "Static_Moon1")
  local SliderMoon2 = UI.getChildControl(SliderArea, "Static_Moon2")
  local SliderSun = UI.getChildControl(SliderArea, "Static_Sun")
  self._ui.txt_socialCenterTitle = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_SocialAction_CenterTitle")
  CopyBaseProperty(CenterTitle, self._ui.txt_socialCenterTitle)
  self._ui.txt_socialCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[_photoModeOption.socialAction]._keyOptionName))
  self._ui.txt_socialCenterTitle:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_socialCenterTitle:SetShow(false)
  self._ui.txt_socialCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PHOTOMODE_KEYGUIDE_SOCIALACTION"))
  table.insert(self._keyGuideList[_photoModeOption.socialAction]._modeList, self._ui.txt_socialCenterTitle)
  self._ui.txt_socialSubTitle = UI.getChildControl(Panel_PhotoMode_CenterFunction, "StaticText_CenterSubTitle")
  table.insert(self._keyGuideList[_photoModeOption.socialAction]._modeList, self._ui.txt_socialSubTitle)
  self._ui.txt_actionArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_SocialAction_Area")
  table.insert(self._keyGuideList[_photoModeOption.socialAction]._modeList, self._ui.txt_actionArea)
  local socialIcon = UI.getChildControl(self._ui.txt_actionArea, "Static_SocialIcon_Temp")
  local socialIconCount = ToClient_getSocialActionInfoList()
  for index = 0, socialIconCount do
    self._socialIconSlot[index] = UI.createControl(__ePAUIControl_Static, self._ui.txt_actionArea, "Static_SocialIconSlot_" .. index)
    CopyBaseProperty(socialIcon, self._socialIconSlot[index])
    self._socialIconSlot[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectSocialIcon( " .. index .. " )")
  end
  self._ui.socialIconSelect = UI.getChildControl(self._ui.txt_actionArea, "Static_IconSelect")
  self._ui.socialIconSelect:SetShow(true)
  self._ui.btn_leftArrow = UI.getChildControl(self._ui.txt_actionArea, "Button_LeftArrow")
  self._ui.btn_rightArrow = UI.getChildControl(self._ui.txt_actionArea, "Button_RightArrow")
  self._ui.rdo_socialCharacter = UI.getChildControl(self._ui.txt_actionArea, "RadioButton_Character")
  self._ui.rdo_socialMaid = UI.getChildControl(self._ui.txt_actionArea, "RadioButton_Maid")
  self._ui.rdo_socialTogether = UI.getChildControl(self._ui.txt_actionArea, "RadioButton_Together")
  self._ui.btn_leftArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_PhotoModeSocialIcon(true)")
  self._ui.btn_rightArrow:addInputEvent("Mouse_LUp", "HandleEventLUp_PhotoModeSocialIcon(false)")
  self._ui.rdo_socialCharacter:SetShow(true)
  self._ui.rdo_socialMaid:SetShow(_ContentsGroup_MaidActorSystem == true)
  self._ui.rdo_socialTogether:SetShow(_ContentsGroup_MaidActorSystem == true)
  if _ContentsGroup_MaidActorSystem == true then
    self._ui.rdo_socialCharacter:addInputEvent("Mouse_LUp", "HandleEventLUp_PhotoMode_ChangeSocialActionTarget(" .. __eMaidActorSocialActionType_SelfPlayer .. ")")
    self._ui.rdo_socialMaid:addInputEvent("Mouse_LUp", "HandleEventLUp_PhotoMode_ChangeSocialActionTarget(" .. __eMaidActorSocialActionType_MaidActor .. ")")
    self._ui.rdo_socialTogether:addInputEvent("Mouse_LUp", "HandleEventLUp_PhotoMode_ChangeSocialActionTarget(" .. __eMaidActorSocialActionType_Together .. ")")
  end
  self._ui.txt_weatherCenterTitle = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_Weather_CenterTitle")
  CopyBaseProperty(CenterTitle, self._ui.txt_weatherCenterTitle)
  self._ui.txt_weatherCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[_photoModeOption.weather]._keyOptionName))
  self._ui.txt_weatherCenterTitle:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_weatherCenterTitle:SetShow(false)
  table.insert(self._keyGuideList[_photoModeOption.weather]._modeList, self._ui.txt_weatherCenterTitle)
  self._ui.txt_weatherArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_Weather_Area")
  table.insert(self._keyGuideList[_photoModeOption.weather]._modeList, self._ui.txt_weatherArea)
  self._ui.btn_weatherLeft = UI.getChildControl(self._ui.txt_weatherArea, "Button_Left")
  self._ui.btn_weatherLeft:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeWeatherIndex(false)")
  self._ui.btn_weatherRight = UI.getChildControl(self._ui.txt_weatherArea, "Button_Right")
  self._ui.btn_weatherRight:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeWeatherIndex(true)")
  self._ui.txt_weatherName = UI.getChildControl(self._ui.txt_weatherArea, "StaticText_Weather")
  self._ui.weatherSelect = UI.getChildControl(self._ui.txt_weatherArea, "Static_WeatherImageSelect")
  for index = 1, _weatherRecommend do
    self._weatherRecommend[index] = UI.getChildControl(self._ui.txt_weatherArea, "Static_WeatherImage_" .. index)
    self._weatherRecommend[index]:SetIgnore(false)
    self._weatherRecommend[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectWeatherRecommend(" .. index .. ")")
  end
  self._ui.txt_timeWeatherCenterTitle = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_TimeWeather_CenterTitle")
  CopyBaseProperty(CenterTitle, self._ui.txt_timeWeatherCenterTitle)
  self._ui.txt_timeWeatherCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[_photoModeOption.timeWeather]._keyOptionName))
  self._ui.txt_timeWeatherCenterTitle:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_timeWeatherCenterTitle:SetShow(false)
  table.insert(self._keyGuideList[_photoModeOption.timeWeather]._modeList, self._ui.txt_timeWeatherCenterTitle)
  self._ui.txt_timeWeatherArea = UI.createControl(__ePAUIControl_Static, Panel_PhotoMode_CenterFunction, "Static_TimeWeather_Area")
  CopyBaseProperty(SliderArea, self._ui.txt_timeWeatherArea)
  table.insert(self._keyGuideList[_photoModeOption.timeWeather]._modeList, self._ui.txt_timeWeatherArea)
  self._ui.txt_timeWeatherDesc = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_timeWeatherArea, "Static_TimeWeather_Desc")
  CopyBaseProperty(SliderAreaDec, self._ui.txt_timeWeatherDesc)
  self._ui.txt_timeWeatherDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_TIME_SETTING"))
  self._ui.slider_timeWeatherBG = UI.createControl(__ePAUIControl_Static, self._ui.txt_timeWeatherArea, "Static_TimeWeather_BG")
  CopyBaseProperty(SliderBG, self._ui.slider_timeWeatherBG)
  self._ui.slider_timeWeatherProgress = UI.createControl(__ePAUIControl_Progress2, self._ui.txt_timeWeatherArea, "Static_TimeWeather_Progress2")
  CopyBaseProperty(SliderProgress, self._ui.slider_timeWeatherProgress)
  self._ui.slider_timeWeatherProgress:SetShow(false)
  self._ui.slider_timeWeather = UI.createControl(__ePAUIControl_Slider, self._ui.txt_timeWeatherArea, "Slider_TimeWeather")
  CopyBaseProperty(Slider, self._ui.slider_timeWeather)
  self._ui.slider_timeWeather:SetEnable(true)
  self._ui.slider_timeWeather:addInputEvent("Mouse_LDown", "HandleEventLDown_ChangeTimeWeather()")
  self._ui.slider_timeWeather:addInputEvent("Mouse_LPress", "HandleEventLPress_ChangeTimeWeather()")
  self._ui.slider_timeWeather:SetInterval(160)
  self._ui.btn_timeWeatherSlider = UI.getChildControl(self._ui.slider_timeWeather, "_Button")
  self._ui.btn_timeWeatherSlider:addInputEvent("Mouse_LDown", "HandleEventLDown_ChangeTimeWeather()")
  self._ui.btn_timeWeatherSlider:addInputEvent("Mouse_LPress", "HandleEventLPress_ChangeTimeWeather()")
  self._ui.txt_timeWeatherMin = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Min")
  CopyBaseProperty(SliderMin, self._ui.txt_timeWeatherMin)
  self._ui.txt_timeWeatherMin:SetText(0)
  self._ui.txt_timeWeatherCurrent = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Current")
  CopyBaseProperty(SliderCurrent, self._ui.txt_timeWeatherCurrent)
  self._ui.txt_timeWeatherMax = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Max")
  CopyBaseProperty(SliderMax, self._ui.txt_timeWeatherMax)
  self._ui.txt_timeWeatherMax:SetText(24)
  self._ui.slider_timeWeatherMoon1 = UI.createControl(__ePAUIControl_Static, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Moon1")
  CopyBaseProperty(SliderMoon1, self._ui.slider_timeWeatherMoon1)
  self._ui.slider_timeWeatherMoon1:SetShow(true)
  self._ui.slider_timeWeatherMoon2 = UI.createControl(__ePAUIControl_Static, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Moon2")
  CopyBaseProperty(SliderMoon2, self._ui.slider_timeWeatherMoon2)
  self._ui.slider_timeWeatherMoon2:SetShow(true)
  self._ui.slider_timeWeatherSun = UI.createControl(__ePAUIControl_Static, self._ui.txt_timeWeatherArea, "Slider_TimeWeather_Sun")
  CopyBaseProperty(SliderSun, self._ui.slider_timeWeatherSun)
  self._ui.slider_timeWeatherSun:SetShow(true)
  self:CreateSlider()
  self._ui.txt_filterCenterTitle = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_Filter_CenterTitle")
  CopyBaseProperty(CenterTitle, self._ui.txt_filterCenterTitle)
  self._ui.txt_filterCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[_photoModeOption.filterChange]._keyOptionName))
  self._ui.txt_filterCenterTitle:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_filterCenterTitle:SetShow(false)
  table.insert(self._keyGuideList[_photoModeOption.filterChange]._modeList, self._ui.txt_filterCenterTitle)
  self._ui.filterArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_Filter_Area")
  table.insert(self._keyGuideList[_photoModeOption.filterChange]._modeList, self._ui.filterArea)
  self._ui.txt_filterDesc = UI.createControl(__ePAUIControl_StaticText, self._ui.filterArea, "Static_FilterChange_Desc")
  CopyBaseProperty(SliderAreaDec, self._ui.txt_filterDesc)
  self._ui.txt_filterDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_FILTERCHANGE"))
  self._ui.btn_leftFilterArrow = UI.getChildControl(self._ui.filterArea, "Button_Left")
  self._ui.btn_leftFilterArrow:addInputEvent("Mouse_LDown", "HandleEventLUp_ChangeFilterDown()")
  self._ui.btn_rightFilterArrow = UI.getChildControl(self._ui.filterArea, "Button_Right")
  self._ui.btn_rightFilterArrow:addInputEvent("Mouse_LDown", "HandleEventLUp_ChangeFilterUp()")
  self._ui.txt_filterName = UI.getChildControl(self._ui.filterArea, "StaticText_FilterValue")
  self._ui.txt_vignettingCenterTitle = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_Vignetting_CenterTitle")
  CopyBaseProperty(CenterTitle, self._ui.txt_vignettingCenterTitle)
  self._ui.txt_vignettingCenterTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[_photoModeOption.noiseVignetting]._keyOptionName))
  self._ui.txt_vignettingCenterTitle:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.txt_vignettingCenterTitle:SetShow(false)
  table.insert(self._keyGuideList[_photoModeOption.noiseVignetting]._modeList, self._ui.txt_vignettingCenterTitle)
  self._ui.vignettingArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_Vignetting_Area")
  table.insert(self._keyGuideList[_photoModeOption.noiseVignetting]._modeList, self._ui.vignettingArea)
  if _ContentsGroup_ChinaOnly == true then
    local vignettingBtn1 = UI.getChildControl(self._ui.vignettingArea, "Button_Vignetting1")
    local vignettingBtn2 = UI.getChildControl(self._ui.vignettingArea, "Button_Vignetting2")
    local vignettingBtn3 = UI.getChildControl(self._ui.vignettingArea, "Button_Vignetting3")
    local vignettingBtn4 = UI.getChildControl(self._ui.vignettingArea, "Button_Vignetting4")
    vignettingBtn1:SetTextMode(__eTextMode_LimitText)
    vignettingBtn2:SetTextMode(__eTextMode_LimitText)
    vignettingBtn3:SetTextMode(__eTextMode_LimitText)
    vignettingBtn4:SetTextMode(__eTextMode_LimitText)
    vignettingBtn1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOT_ENGLISHNAME_ALLOFF"))
    vignettingBtn2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOT_ENGLISHNAME_FIRMGRAIN"))
    vignettingBtn3:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOT_ENGLISHNAME_VIGNETTING"))
    vignettingBtn4:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOT_ENGLISHNAME_ALLON"))
  end
  self._ui.txt_vignetingDesc = UI.createControl(__ePAUIControl_StaticText, self._ui.vignettingArea, "Static_Vignetting_Desc")
  CopyBaseProperty(SliderAreaDec, self._ui.txt_vignetingDesc)
  self._ui.txt_vignetingDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_NOISE"))
  for index = 1, _vignettingCount do
    self._vignettingButton[index] = UI.getChildControl(self._ui.vignettingArea, "Button_Vignetting" .. index)
    self._vignettingButton[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectVignetting( " .. index .. " )")
    local texturePath = "Combine/Etc/Combine_Etc_ScreenShotMode.dds"
    self._vignettingButton[index]:ChangeTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(self._vignettingButton[index], 1, 142, 51, 192)
    self._vignettingButton[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._vignettingButton[index]:ChangeOnTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(self._vignettingButton[index], 52, 142, 102, 192)
    self._vignettingButton[index]:getOnTexture():setUV(x1, y1, x2, y2)
    self._vignettingButton[index]:ChangeClickTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(self._vignettingButton[index], 103, 142, 153, 192)
    self._vignettingButton[index]:getClickTexture():setUV(x1, y1, x2, y2)
  end
  local savePanelArea = UI.getChildControl(Panel_PhotoMode_Preset, "Static_TitleArea")
  self._ui.btn_winClose = UI.getChildControl(savePanelArea, "Button_Win_Close")
  self._ui.btn_winClose:addInputEvent("Mouse_LUp", "HandleEventLUp_SavePanelClose()")
  self._ui.btn_save = UI.getChildControl(Panel_PhotoMode_Preset, "Button_Save")
  self._ui.btn_save:addInputEvent("Mouse_LUp", "HandleEventLUp_SaveOptionPreset()")
  self._ui.btn_close = UI.getChildControl(Panel_PhotoMode_Preset, "Button_Close")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_CloseOptionPreset()")
  local savePaelBG = UI.getChildControl(Panel_PhotoMode_Preset, "Static_BG")
  for index = 1, _optionPresetCount do
    self._saveButton[index] = UI.getChildControl(savePaelBG, "RadioButton_" .. index)
    self._saveButton[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_SelectSaveOptionIndex(" .. index .. ")")
  end
  CenterTitle:SetShow(false)
  SliderArea:SetShow(false)
  PaGlobal_PhotoMode:validate()
  self._initialize = true
  ToClient_InsertPhotoModePanel(Panel_PhotoMode_Main)
  ToClient_InsertPhotoModePanel(Panel_PhotoMode_CenterFunction)
  ToClient_InsertPhotoModePanel(Panel_PhotoMode_Preset)
  ToClient_InsertPhotoModePanel(Panel_Window_MessageBox_All)
end
function PaGlobal_PhotoMode:prepareOpen()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  self._currentSocialActionWindowIndex = 0
  self._filterIndex = 0
  self._blurMessageBox = false
  self._contrastMessageBox = false
  self._messageBoxOpen = false
  self:selectVignetting(1)
  for optionIndex, value in pairs(PaGlobal_PhotoMode._optionPresetButton) do
    value:SetCheck(false)
  end
  self:ComputePos()
  self:RefreshWeatherRecommend(1, "LUA_PHOTOMODE_WEATHER_DEFAULT")
  ToClient_isPhotoModeOpenFromPhotoGallery()
  self._ui.activateKeyOption:SetPosX(self._keyGuideList[1]._keyGuideName:GetPosX() + 20)
  self._ui.activateKeyOption:SetPosY(self._keyGuideList[1]._keyGuideName:GetPosY())
  self._isFirstOpen = true
  PaGlobal_PhotoMode:open()
end
function PaGlobal_PhotoMode:open()
  Panel_PhotoMode_Main:SetShow(true)
  Panel_PhotoMode_CenterFunction:SetShow(true)
  Panel_PhotoMode_Preset:SetShow(false)
end
function PaGlobal_PhotoMode:prePareClose()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  for idx = 1, self._keyGuideCount do
    local modeList = self._keyGuideList[idx]._modeList
    for modeIndex, modeValue in pairs(modeList) do
      modeValue:SetShow(false)
    end
  end
  if _ContentsGroup_ChinaOnly == true then
    self._ui.txt_filterName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOT_ENGLISHNAME_NONE"))
  else
    self._ui.txt_filterName:SetText("None")
  end
  self._isFirstOpen = false
  messageBox_NoButtonUp()
  PaGlobal_PhotoMode:close()
end
function PaGlobal_PhotoMode:close()
  Panel_PhotoMode_Main:SetShow(false)
  Panel_PhotoMode_CenterFunction:SetShow(false)
  Panel_PhotoMode_Preset:SetShow(false)
end
function PaGlobal_PhotoMode:insertKeyCombination(...)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local keyList = {}
  for index, value in pairs(...) do
    local key, targetControl
    if value == "Enter" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Enter")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "PrintScreen" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_PrintScreen")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "LeftArrow" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Arrow_Left")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      local iconControl = UI.getChildControl(key, "Static_Icon")
      local copyIconControl = UI.createControl(__ePAUIControl_Static, targetControl, "Static_photoModeKeyIcon_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      CopyBaseProperty(iconControl, copyIconControl)
    elseif value == "UpArrow" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Arrow_Up")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      local iconControl = UI.getChildControl(key, "Static_Icon")
      local copyIconControl = UI.createControl(__ePAUIControl_Static, targetControl, "Static_photoModeKeyIcon_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      CopyBaseProperty(iconControl, copyIconControl)
    elseif value == "RightArrow" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Arrow_Right")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      local iconControl = UI.getChildControl(key, "Static_Icon")
      local copyIconControl = UI.createControl(__ePAUIControl_Static, targetControl, "Static_photoModeKeyIcon_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      CopyBaseProperty(iconControl, copyIconControl)
    elseif value == "DownArrow" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Arrow_Down")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      local iconControl = UI.getChildControl(key, "Static_Icon")
      local copyIconControl = UI.createControl(__ePAUIControl_Static, targetControl, "Static_photoModeKeyIcon_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      CopyBaseProperty(iconControl, copyIconControl)
    elseif value == "Ctrl" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Ctrl")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "Shift" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Shift")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "Alt" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Alt")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "PageUp" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "MultilineText_Page")
      targetControl = UI.createControl(__ePAUIControl_MultiLineText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText([[
Page
Up]])
    elseif value == "PageDown" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "MultilineText_Page")
      targetControl = UI.createControl(__ePAUIControl_MultiLineText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText([[
Page
Down]])
    elseif value == "Home" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Normal_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText(value)
      targetControl:SetSize(40, 25)
      targetControl:SetEnableArea(40, 25)
    elseif value == "End" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Normal_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText(value)
      targetControl:SetSize(40, 25)
      targetControl:SetEnableArea(40, 25)
    elseif value == "or" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Plus_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText(value)
    elseif value == "+" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Plus_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
    elseif value == "wave" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Plus_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText("~")
    elseif value == "Insert" then
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Shift")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText(value)
    else
      key = UI.getChildControl(self._ui.txt_keyGuide, "StaticText_Key_Normal_Temp")
      targetControl = UI.createControl(__ePAUIControl_StaticText, self._ui.txt_keyGuide, "Static_photoModeKey_" .. tostring(self._keyIndex) .. "_" .. tostring(index))
      CopyBaseProperty(key, targetControl)
      targetControl:SetText(value)
    end
    table.insert(keyList, targetControl)
  end
  self._keyIndex = self._keyIndex + 1
  return keyList
end
function PaGlobal_PhotoMode:ComputePos()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  Panel_PhotoMode_Main:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_PhotoMode_CenterFunction:SetSize(getScreenSizeX(), Panel_PhotoMode_CenterFunction:GetSizeY())
  self._ui.keyGuideArea:SetSize(self._ui.keyGuideArea:GetSizeX(), getScreenSizeY())
  Panel_PhotoMode_Main:ComputePos()
  Panel_PhotoMode_CenterFunction:ComputePos()
  self._ui.keyGuideArea:ComputePos()
  self._ui.bottomSetting:ComputePos()
  self._ui.vignettingArea:ComputePos()
  self._ui.txt_socialSubTitle:ComputePos()
  self._ui.txt_actionArea:ComputePos()
  self._ui.filterArea:ComputePos()
  self._ui.txt_weatherCenterTitle:SetPosX((getScreenSizeX() - self._ui.keyGuideArea:GetSizeX()) / 2 - self._ui.txt_weatherCenterTitle:GetSizeX() / 2)
  self._ui.txt_weatherArea:SetPosX((getScreenSizeX() - self._ui.keyGuideArea:GetSizeX()) / 2 - self._ui.txt_weatherArea:GetSizeX() / 2)
  local extra = 20
  local wordWidthInterval = 5
  local wordLengthInterval = 12
  local wordLength = 25
  local pageUpDownFix = 9
  local posY = getScreenSizeY() - self._ui.bottomSetting:GetSizeY() - extra
  for idx = _photoModeOption.optionPreset, 1, -1 do
    local keyList = self._keyGuideList[idx]._keyList
    local keyCount = #keyList
    local posX = -30
    for keyIndex = 1, keyCount do
      local key = keyList[keyIndex]
      key:SetShow(true)
      key:SetPosX(posX)
      key:SetPosY(posY)
      if _photoModeOption.socialAction == idx and (3 == keyIndex or 4 == keyIndex) then
        key:SetPosY(posY - pageUpDownFix)
      end
      posX = posX + key:GetSizeX() + wordWidthInterval
    end
    local optionNameControl = UI.getChildControl(self._ui.txt_keyGuide, "Static_Option_" .. tostring(idx))
    optionNameControl:SetPosY(posY)
    posY = posY - wordLength - wordLengthInterval
    for horizonIndex, value in pairs(self._horizonIndex) do
      if value == idx then
        local horizonControl = UI.getChildControl(self._ui.keyGuideArea, "Static_horizon_" .. tostring(idx))
        horizonControl:SetShow(true)
        horizonControl:SetPosY(posY)
        posY = posY - wordLength - wordLengthInterval
        break
      end
    end
  end
  local socialIconWidthInterval = 5
  local socialIconPosXStart = 55
  local socialIconPosYStart = 80
  self._currentSocialActionWindowIndex = 0
  local socialIconCount = #self._socialIconSlot
  for index = 0, socialIconCount do
    if index ~= socialIconCount then
      local socialActionInfo = ToClient_getSocialActionInfoByIndex(index)
      local sASS = socialActionInfo:getStaticStatus()
      local socialKey = sASS:getKey()
      local posX = socialIconPosXStart + index % _socialActionLineCount * self._socialIconSlot[index]:GetSizeX() + index % _socialActionLineCount * socialIconWidthInterval
      local posY = socialIconPosYStart
      local line = math.floor(index / _socialActionLineCount)
      line = line % 2
      if line == 1 then
        posY = socialIconPosYStart + self._socialIconSlot[index]:GetSizeY() + socialIconWidthInterval
      end
      self._socialIconSlot[index]:SetPosXY(posX, posY)
      self._socialIconSlot[index]:SetShow(false)
      self._socialIconSlot[index]:ChangeTextureInfoNameAsync("Icon/" .. sASS:getIconPath())
      if ToClient_isUsableSocialAction(socialKey, false) == true then
        self._socialIconSlot[index]:SetMonoTone(false)
      else
        self._socialIconSlot[index]:SetMonoTone(true)
      end
    end
  end
  local posX = self._socialIconSlot[_socialActionLineCount]:GetPosX()
  local posY = self._socialIconSlot[_socialActionLineCount]:GetPosY() + self._socialIconSlot[_socialActionLineCount]:GetSizeY() + 10
  self._ui.activateKeyOption:SetPosXY(self._keyGuideList[_photoModeOption.help]._keyGuideName:GetPosX(), self._keyGuideList[_photoModeOption.help]._keyGuideName:GetPosY())
end
function PaGlobal_PhotoMode:findSelectedSocialIcon(socialIconIndex, isFromLua)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(socialIconIndex)
  if nil == socialActionInfo then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if nil == sASS then
    return
  end
  local socialKey = sASS:getKey()
  if ToClient_isUsableSocialAction(socialKey, false) == false then
    return
  end
  local iconSelect = self._ui.socialIconSelect
  if nil == iconSelect then
    return
  end
  iconSelect:SetPosX(self._socialIconSlot[socialIconIndex]:GetPosX() - 2.5)
  iconSelect:SetPosY(self._socialIconSlot[socialIconIndex]:GetPosY() - 2.5)
  iconSelect:SetShow(true)
  self._currentSelectedIconIndex = socialIconIndex
  local name = sASS:getName()
  self._ui.txt_socialSubTitle:SetText(name)
  if true == isFromLua then
    ToClient_requestStartSocialAction(socialKey)
    ToClient_SetPhotoModeSocialActionIndex(socialIconIndex)
  end
end
function PaGlobal_PhotoMode:changeTimeWeather(weatherTime)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local percent = PaGlobal_PhotoMode._ui.slider_timeWeather:GetControlPos()
  local weatherTime = 24 * percent
  PaGlobal_PhotoMode._ui.txt_timeWeatherCurrent:SetText(math.floor(weatherTime))
  ToClient_SetPhotoModeWeatherTime(weatherTime)
end
function PaGlobal_PhotoMode:selectedOptionVisible(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  for idx = 1, PaGlobal_PhotoMode._keyGuideCount do
    local modeList = PaGlobal_PhotoMode._keyGuideList[idx]._modeList
    if idx == index then
      for modeIndex, modeValue in pairs(modeList) do
        modeValue:SetShow(true)
      end
    else
      for modeIndex, modeValue in pairs(modeList) do
        modeValue:SetShow(false)
      end
    end
  end
  PaGlobal_PhotoMode._ui.activateKeyOption:SetPosX(PaGlobal_PhotoMode._keyGuideList[index]._keyGuideName:GetPosX() + 20)
  PaGlobal_PhotoMode._ui.activateKeyOption:SetPosY(PaGlobal_PhotoMode._keyGuideList[index]._keyGuideName:GetPosY())
end
function PaGlobal_PhotoMode:changeSliderOption(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local slider = self._sliderList[index][_sliderState.eSlider]
  local sliderText = self._sliderList[index][_sliderState.eCurrent]
  if nil == slider or nil == sliderText then
    return
  end
  local percent = slider:GetControlPos()
  local realValue = 0
  local min = 0
  local max = 0
  local blurMin = 0
  local blurMax = 0
  if index == _photoModeOption.blurForce then
    min = -20000
    max = 200000
  elseif index == _photoModeOption.blurPosition then
    min = -2.5
    max = 3
    blurMin = -1
    blurMax = 1
    local blurValue = percent * (max - min) + min
    realValue = percent * (max - min) + min
    ToClient_SetPhotoModeOptionValue(index, realValue, -blurValue)
  elseif index == _photoModeOption.gammaControl then
    min = 0.05
    max = 1.95
  elseif index == _photoModeOption.contrastControl then
    min = -1
    max = 1
  elseif index == _photoModeOption.zoomInzoomOut then
    min = -0.261799
    max = 0.349066
  elseif index == _photoModeOption.angleControl then
    min = -1.569228
    max = 1.569228
  end
  realValue = percent * (max - min) + min
  if index ~= _photoModeOption.blurPosition then
    ToClient_SetPhotoModeOptionValue(index, realValue, 0)
  end
  sliderText:SetText(math.floor(percent * 100))
end
function PaGlobal_PhotoMode:selectVignetting(vignettingIndex)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  for index, value in pairs(self._vignettingButton) do
    if vignettingIndex == index then
      value:SetCheck(true)
    else
      value:SetCheck(false)
    end
  end
end
function PaGlobal_PhotoMode:validate()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  self._ui.keyGuideArea:isValidate()
  self._ui.txt_keyGuide:isValidate()
  self._ui.horizon:isValidate()
  self._ui.activateKeyOption:isValidate()
  self._ui.bottomSetting:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.txt_socialCenterTitle:isValidate()
  self._ui.txt_socialSubTitle:isValidate()
  self._ui.txt_actionArea:isValidate()
  self._ui.socialIconSelect:isValidate()
  self._ui.btn_leftArrow:isValidate()
  self._ui.btn_rightArrow:isValidate()
  self._ui.rdo_socialCharacter:isValidate()
  self._ui.rdo_socialMaid:isValidate()
  self._ui.rdo_socialTogether:isValidate()
  self._ui.txt_weatherCenterTitle:isValidate()
  self._ui.txt_weatherArea:isValidate()
  self._ui.btn_weatherLeft:isValidate()
  self._ui.btn_weatherRight:isValidate()
  self._ui.weatherSelect:isValidate()
  self._ui.txt_timeWeatherArea:isValidate()
  self._ui.txt_timeWeatherDesc:isValidate()
  self._ui.slider_timeWeatherBG:isValidate()
  self._ui.slider_timeWeatherProgress:isValidate()
  self._ui.slider_timeWeather:isValidate()
  self._ui.btn_timeWeatherSlider:isValidate()
  self._ui.txt_timeWeatherMin:isValidate()
  self._ui.txt_timeWeatherCurrent:isValidate()
  self._ui.txt_timeWeatherMax:isValidate()
  self._ui.slider_timeWeatherMoon1:isValidate()
  self._ui.slider_timeWeatherMoon2:isValidate()
  self._ui.slider_timeWeatherSun:isValidate()
  self._ui.txt_filterCenterTitle:isValidate()
  self._ui.filterArea:isValidate()
  self._ui.txt_filterDesc:isValidate()
  self._ui.btn_leftFilterArrow:isValidate()
  self._ui.btn_rightFilterArrow:isValidate()
  self._ui.txt_filterName:isValidate()
  self._ui.txt_vignettingCenterTitle:isValidate()
  self._ui.vignettingArea:isValidate()
  self._ui.txt_vignetingDesc:isValidate()
  self._ui.btn_winClose:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_close:isValidate()
end
function PaGlobal_PhotoMode:RefreshWeatherRecommend(index, weatherName)
  local textureInterval = 10
  local weatherTextureSizeX = self._weatherRecommend[1]:GetSizeX()
  local posX = self._ui.txt_weatherArea:GetSizeX() / 2 - 2 * (weatherTextureSizeX + textureInterval) - 0.5 * weatherTextureSizeX
  for presetIndex, value in pairs(self._weatherRecommend) do
    value:SetShow(false)
  end
  local needToShowIndex = {
    index - 2,
    index - 1,
    index,
    index + 1,
    index + 2
  }
  for showIndex, value in pairs(needToShowIndex) do
    if value <= 0 then
      value = value + _weatherRecommend
    end
    if value > _weatherRecommend then
      value = value - _weatherRecommend
    end
    local control = self._weatherRecommend[value]
    control:SetShow(true)
    control:SetPosX(posX)
    posX = posX + control:GetSizeX() + textureInterval
    if 3 == showIndex then
      self._ui.weatherSelect:SetPosXY(control:GetPosX() - 5, control:GetPosY() - 5)
      self._ui.weatherSelect:SetShow(true)
    end
    if 1 == showIndex then
      self._ui.btn_weatherLeft:SetPosX(control:GetPosX() - self._ui.btn_weatherLeft:GetSizeX() - textureInterval)
    end
    if 5 == showIndex then
      self._ui.btn_weatherRight:SetPosX(control:GetPosX() + control:GetSizeX() + textureInterval)
    end
  end
  self._ui.txt_weatherName:SetText(PAGetString(Defines.StringSheet_GAME, weatherName))
end
function FromClient_SetPhotoMode(isPhotoModeOn)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  if true == isPhotoModeOn then
    PaGlobal_PhotoMode:prepareOpen()
  else
    PaGlobal_PhotoMode:prePareClose()
  end
end
function FromClient_PhotoModeUIOnOff(isUIOn)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  if true == isUIOn then
    Panel_PhotoMode_Main:SetShow(true)
    Panel_PhotoMode_CenterFunction:SetShow(true)
  else
    Panel_PhotoMode_Main:SetShow(false)
    Panel_PhotoMode_CenterFunction:SetShow(false)
  end
end
function FromClient_SetSocialActionIndex(socialActionIndex, isSocialActionSelect)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  if true == isSocialActionSelect then
    HandleEventLUp_KeyGuideOptionName(_photoModeOption.socialActionStart)
  else
    HandleEventLUp_KeyGuideOptionName(_photoModeOption.socialAction)
  end
  PaGlobal_PhotoMode:findSelectedSocialIcon(socialActionIndex, false)
  local visibleCountStart = 0
  local visibleCountEnd = 0
  if socialActionIndex >= 0 and socialActionIndex <= 29 then
    PaGlobal_PhotoMode._currentSocialActionWindowIndex = 0
    visibleCountEnd = 29
  elseif socialActionIndex >= 30 and socialActionIndex <= 59 then
    PaGlobal_PhotoMode._currentSocialActionWindowIndex = 1
    visibleCountStart = 30
    visibleCountEnd = 59
  else
    PaGlobal_PhotoMode._currentSocialActionWindowIndex = 2
    visibleCountStart = 60
    visibleCountEnd = #PaGlobal_PhotoMode._socialIconSlot
  end
  for index, value in pairs(PaGlobal_PhotoMode._socialIconSlot) do
    if index >= visibleCountStart and index <= visibleCountEnd then
      value:SetShow(true)
    else
      value:SetShow(false)
    end
  end
  if _ContentsGroup_MaidActorSystem == true and PaGlobal_PhotoMode._ui.txt_actionArea:GetShow() == true then
    local saveCacheNumber = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorSocialActionType)
    if saveCacheNumber == __eMaidActorSocialActionType_SelfPlayer then
      PaGlobal_PhotoMode._ui.rdo_socialCharacter:SetCheck(true)
    elseif saveCacheNumber == __eMaidActorSocialActionType_MaidActor then
      PaGlobal_PhotoMode._ui.rdo_socialMaid:SetCheck(true)
    elseif saveCacheNumber == __eMaidActorSocialActionType_Together then
      PaGlobal_PhotoMode._ui.rdo_socialTogether:SetCheck(true)
    else
      PaGlobal_PhotoMode._ui.rdo_socialCharacter:SetCheck(true)
    end
  else
    PaGlobal_PhotoMode._ui.rdo_socialCharacter:SetCheck(true)
  end
end
function FromClient_SetPhotoModeOption(optionIndex, value)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local sliderlist = PaGlobal_PhotoMode._sliderList[optionIndex]
  if nil == sliderlist then
    return
  end
  local slider = sliderlist[_sliderState.eSlider]
  local sliderText = sliderlist[_sliderState.eCurrent]
  if nil == slider or nil == sliderText then
    return
  end
  local min = 0
  local max = 0
  local percent = 0
  if _photoModeOption.blurForce == optionIndex then
    min = -20000
    max = 200000
  elseif _photoModeOption.blurPosition == optionIndex then
    min = -2.5
    max = 3
  elseif _photoModeOption.gammaControl == optionIndex then
    min = 0.05
    max = 1.95
  elseif _photoModeOption.contrastControl == optionIndex then
    min = -1
    max = 1
  elseif _photoModeOption.zoomInzoomOut == optionIndex then
    min = -0.261799
    max = 0.349066
  elseif _photoModeOption.angleControl == optionIndex then
    min = -1.569228
    max = 1.569228
  end
  percent = (value - min) / (max - min) * 100
  local ceilPercent = math.ceil(percent - 0.5)
  if ceilPercent <= 0 then
    ceilPercent = 0
  end
  if ceilPercent >= 100 then
    ceilPercent = 100
  end
  slider:SetControlPos(ceilPercent)
  sliderText:SetText(ceilPercent)
  HandleEventLUp_KeyGuideOptionName(optionIndex)
end
function FromClient_SetTimeWeather(weatherTime)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local percent = weatherTime * 100 / 24
  PaGlobal_PhotoMode._ui.slider_timeWeather:SetControlPos(percent)
  local weathertimeText = math.ceil(weatherTime - 0.5)
  if weathertimeText <= 0 then
    weathertimeText = 0
  end
  PaGlobal_PhotoMode._ui.txt_timeWeatherCurrent:SetText(weathertimeText)
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.timeWeather)
end
function FromClient_SetSliderValue(vignetting, DOFX, DOFY, DOFZ, gamma, contrast, FOV, roll, weatherTime)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  FromClient_SetPhotoModeOption(_photoModeOption.blurForce, DOFX)
  FromClient_SetPhotoModeOption(_photoModeOption.blurPosition, DOFY)
  FromClient_SetPhotoModeOption(_photoModeOption.gammaControl, gamma)
  FromClient_SetPhotoModeOption(_photoModeOption.contrastControl, contrast)
  FromClient_SetPhotoModeOption(_photoModeOption.zoomInzoomOut, FOV)
  FromClient_SetPhotoModeOption(_photoModeOption.angleControl, roll)
  FromClient_SetTimeWeather(weatherTime)
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.help)
end
function FromClient_SetPhotoModeFilter(filterMode)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.filterChange)
end
function FromClient_SetPhotoModeVignetting(vignettingMode)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.noiseVignetting)
  local vignettingButtonIndex = vignettingMode + 1
  PaGlobal_PhotoMode:selectVignetting(vignettingButtonIndex)
end
function FromClient_SetPhotoModeKeyHighlight(index)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  HandleEventLUp_KeyGuideOptionName(index)
end
function FromClient_SetPhotoModeWeatherPresetIndex(weatherPresetIndex, weatherName)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  if nil == weatherName then
    return
  end
  HandleEventLUp_KeyGuideOptionName(_photoModeOption.weather)
  PaGlobal_PhotoMode:RefreshWeatherRecommend(weatherPresetIndex + 1, weatherName)
end
function FromClient_ClosePhotoModeUI()
  if PaGlobal_PhotoMode._blurMessageBox == true then
    return
  end
  if PaGlobal_PhotoMode._contrastMessageBox == true then
    return
  end
  if PaGlobal_PhotoMode._messageBoxOpen == true then
    PaGlobal_PhotoMode._messageBoxOpen = false
    messageBox_NoButtonUp()
    return
  end
  PaGlobal_PhotoMode._messageBoxOpen = true
  local photoMode_Close = function()
    ToClient_cancelRequestAddToFile()
    ToClient_RequestPhotoModeClose()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
    content = messageBoxMemo,
    functionYes = photoMode_Close,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_isPhotoModeOpenFromPhotoGallery(isOpenFromPhotoGallery)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local keyGuideList = PaGlobal_PhotoMode._keyGuideList[_photoModeOption.screenShot]
  if nil == keyGuideList then
    return
  end
  if true == isOpenFromPhotoGallery then
    keyGuideList._keyGuideName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_SCREENSHOT_GALARY_UPLOAD"))
  else
    keyGuideList._keyGuideName:SetText(PAGetString(Defines.StringSheet_RESOURCE, keyGuideList._keyOptionName))
  end
end
function FromClient_isPhotoModeBlurOptionOn(isBlurOptionOn)
  if PaGlobal_PhotoMode._blurMessageBox == true or isBlurOptionOn == true then
    PaGlobal_PhotoMode:selectedOptionVisible(PaGlobal_PhotoMode._currentSelectedKeyGuide)
    return
  end
  if PaGlobal_PhotoMode._isFirstOpen == false then
    return
  end
  PaGlobal_PhotoMode._blurMessageBox = true
  local RenderDOF = function()
    setDof(true)
    PaGlobal_PhotoMode._blurMessageBox = false
    PaGlobal_PhotoMode:selectedOptionVisible(PaGlobal_PhotoMode._currentSelectedKeyGuide)
  end
  local doNothing = function()
    PaGlobal_PhotoMode._blurMessageBox = false
    PaGlobal_PhotoMode._messageBoxOpen = true
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_DOF_MSG")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"),
    content = messageBoxMemo,
    functionYes = RenderDOF,
    functionNo = doNothing,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_isPhotoModeNonContrastOptionOn(isNonContrastOn)
  if PaGlobal_PhotoMode._contrastMessageBox == true or isNonContrastOn == false then
    PaGlobal_PhotoMode:selectedOptionVisible(PaGlobal_PhotoMode._currentSelectedKeyGuide)
    return
  end
  if PaGlobal_PhotoMode._isFirstOpen == false then
    return
  end
  PaGlobal_PhotoMode._contrastMessageBox = true
  local RenderContrast = function()
    if PaGlobal_GameOption_SetValue ~= nil then
      PaGlobal_GameOption_SetValue("PageButton_LUT", 0, -1)
    end
    PaGlobal_PhotoMode._contrastMessageBox = false
    PaGlobal_PhotoMode:selectedOptionVisible(PaGlobal_PhotoMode._currentSelectedKeyGuide)
  end
  local doNothing = function()
    PaGlobal_PhotoMode._contrastMessageBox = false
    PaGlobal_PhotoMode._messageBoxOpen = true
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_CONTRAST_MSG")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"),
    content = messageBoxMemo,
    functionApply = RenderContrast,
    functionCancel = doNothing,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_photoModePresetDataValid(presetIndex)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local index = presetIndex + 1
  if nil == PaGlobal_PhotoMode._optionPresetButton[index] then
    return
  end
  local presetButton = PaGlobal_PhotoMode._optionPresetButton[index]
  local texturePath = "Combine/Etc/Combine_Etc_ScreenShotMode.dds"
  presetButton:ChangeTextureInfoNameAsync(texturePath)
  x1, y1, x2, y2 = setTextureUV_Func(presetButton, 154, 142, 204, 192)
  presetButton:getBaseTexture():setUV(x1, y1, x2, y2)
  presetButton:setRenderTexture(presetButton:getBaseTexture())
  presetButton:ChangeOnTextureInfoNameAsync(texturePath)
  x1, y1, x2, y2 = setTextureUV_Func(presetButton, 205, 142, 255, 192)
  presetButton:getOnTexture():setUV(x1, y1, x2, y2)
  presetButton:setRenderTexture(presetButton:getOnTexture())
  presetButton:ChangeClickTextureInfoNameAsync(texturePath)
  x1, y1, x2, y2 = setTextureUV_Func(presetButton, 256, 142, 306, 192)
  presetButton:getClickTexture():setUV(x1, y1, x2, y2)
  presetButton:setRenderTexture(presetButton:getClickTexture())
end
function FromClient_isPhotoModeFromObservation(fromObservation)
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  PaGlobal_PhotoMode._isPhotoModeFromObservation = fromObservation
  local disableKeyguideList = {
    _photoModeOption.screenLook,
    _photoModeOption.noiseVignetting,
    _photoModeOption.socialAction,
    _photoModeOption.socialActionStart,
    _photoModeOption.filterChange
  }
  if true == PaGlobal_PhotoMode._isPhotoModeFromObservation then
    for index, key in pairs(disableKeyguideList) do
      PaGlobal_PhotoMode._keyGuideList[key]._keyGuideName:SetFontColor(Defines.Color.C_FF6C6C6C)
      PaGlobal_PhotoMode._keyGuideList[key]._keyGuideName:SetIgnore(true)
    end
  else
    for index, key in pairs(disableKeyguideList) do
      PaGlobal_PhotoMode._keyGuideList[key]._keyGuideName:SetFontColor(Defines.Color.C_FFFFFFFF)
      PaGlobal_PhotoMode._keyGuideList[key]._keyGuideName:SetIgnore(false)
    end
  end
end
function PaGlobal_PhotoMode:CreateSlider()
  if nil == Panel_PhotoMode_Main or nil == Panel_PhotoMode_CenterFunction or nil == Panel_PhotoMode_Preset then
    return
  end
  local CenterTitle = UI.getChildControl(Panel_PhotoMode_CenterFunction, "StaticText_CenterTitle")
  local SliderArea = UI.getChildControl(Panel_PhotoMode_CenterFunction, "Static_Time_Area")
  local SliderAreaDec = UI.getChildControl(SliderArea, "StaticText_TimeDesc")
  local SliderBG = UI.getChildControl(SliderArea, "Static_SliderBG")
  local SliderProgress = UI.getChildControl(SliderArea, "Progress2_Time")
  local Slider = UI.getChildControl(SliderArea, "Slider_Time")
  local SliderBtn = UI.getChildControl(Slider, "Slider_1_Button")
  local SliderMin = UI.getChildControl(SliderArea, "StaticText_Time_0")
  local SliderCurrent = UI.getChildControl(SliderArea, "StaticText_Time_Current")
  local SliderMax = UI.getChildControl(SliderArea, "StaticText_Time_24")
  local SliderMoon1 = UI.getChildControl(SliderArea, "Static_Moon1")
  local SliderMoon2 = UI.getChildControl(SliderArea, "Static_Moon2")
  local SliderSun = UI.getChildControl(SliderArea, "Static_Sun")
  for index = _photoModeOption.blurForce, _photoModeOption.angleControl do
    self._sliderList[index] = {}
    self._sliderList[index][_sliderState.eCenterTitle] = UI.createControl(__ePAUIControl_StaticText, Panel_PhotoMode_CenterFunction, "Static_CenterTitle_" .. index)
    CopyBaseProperty(CenterTitle, self._sliderList[index][_sliderState.eCenterTitle])
    self._sliderList[index][_sliderState.eCenterTitle]:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._keyGuideList[index]._keyOptionName))
    self._sliderList[index][_sliderState.eCenterTitle]:SetFontColor(Defines.Color.C_FFFFEDD4)
    self._sliderList[index][_sliderState.eCenterTitle]:SetShow(false)
    table.insert(self._keyGuideList[index]._modeList, self._sliderList[index][_sliderState.eCenterTitle])
    self._sliderList[index][_sliderState.eArea] = UI.createControl(__ePAUIControl_Static, Panel_PhotoMode_CenterFunction, "Static_Area_" .. index)
    CopyBaseProperty(SliderArea, self._sliderList[index][_sliderState.eArea])
    table.insert(self._keyGuideList[index]._modeList, self._sliderList[index][_sliderState.eArea])
    self._sliderList[index][_sliderState.eDesc] = UI.createControl(__ePAUIControl_StaticText, self._sliderList[index][_sliderState.eArea], "Static_Desc_" .. index)
    CopyBaseProperty(SliderAreaDec, self._sliderList[index][_sliderState.eDesc])
    local descString
    if index == _photoModeOption.noiseVignetting then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_NOISE")
    elseif index == _photoModeOption.blurForce then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_BLUR_FORCE")
    elseif index == _photoModeOption.blurPosition then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_BLUR_POSITION")
    elseif index == _photoModeOption.gammaControl then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_GAMMA")
    elseif index == _photoModeOption.contrastControl then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_CONTRAST")
    elseif index == _photoModeOption.zoomInzoomOut then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_ZOOM")
    elseif index == _photoModeOption.angleControl then
      descString = PAGetString(Defines.StringSheet_GAME, "LUA_PHOTOMODE_KEYGUIDE_ROTATE")
    end
    self._sliderList[index][_sliderState.eDesc]:SetText(descString)
    self._sliderList[index][_sliderState.eBG] = UI.createControl(__ePAUIControl_Static, self._sliderList[index][_sliderState.eArea], "Static_BG_" .. index)
    CopyBaseProperty(SliderBG, self._sliderList[index][_sliderState.eBG])
    self._sliderList[index][_sliderState.eProgress] = UI.createControl(__ePAUIControl_Progress2, self._sliderList[index][_sliderState.eArea], "Static_Progress2_" .. index)
    CopyBaseProperty(SliderProgress, self._sliderList[index][_sliderState.eProgress])
    self._sliderList[index][_sliderState.eProgress]:SetShow(false)
    self._sliderList[index][_sliderState.eSlider] = UI.createControl(__ePAUIControl_Slider, self._sliderList[index][_sliderState.eArea], "Slider_" .. index)
    CopyBaseProperty(Slider, self._sliderList[index][_sliderState.eSlider])
    self._sliderList[index][_sliderState.eSlider]:SetEnable(true)
    self._sliderList[index][_sliderState.eSlider]:addInputEvent("Mouse_LDown", "HandleEventLDown_ChangeSlider( " .. index .. " )")
    self._sliderList[index][_sliderState.eSlider]:addInputEvent("Mouse_LPress", "HandleEventLPress_ChangeSlider( " .. index .. " )")
    self._sliderList[index][_sliderState.eSlider]:SetInterval(160)
    self._sliderList[index][_sliderState.eSldier_btn] = UI.getChildControl(self._sliderList[index][_sliderState.eSlider], "_Button")
    self._sliderList[index][_sliderState.eSldier_btn]:addInputEvent("Mouse_LDown", "HandleEventLDown_ChangeSlider( " .. index .. " )")
    self._sliderList[index][_sliderState.eSldier_btn]:addInputEvent("Mouse_LPress", "HandleEventLPress_ChangeSlider( " .. index .. " )")
    self._sliderList[index][_sliderState.eMin] = UI.createControl(__ePAUIControl_StaticText, self._sliderList[index][_sliderState.eArea], "Slider_Min_" .. index)
    CopyBaseProperty(SliderMin, self._sliderList[index][_sliderState.eMin])
    self._sliderList[index][_sliderState.eMin]:SetText(0)
    self._sliderList[index][_sliderState.eCurrent] = UI.createControl(__ePAUIControl_StaticText, self._sliderList[index][_sliderState.eArea], "Slider_Current_" .. index)
    CopyBaseProperty(SliderCurrent, self._sliderList[index][_sliderState.eCurrent])
    self._sliderList[index][_sliderState.eMax] = UI.createControl(__ePAUIControl_StaticText, self._sliderList[index][_sliderState.eArea], "Slider_Max_" .. index)
    CopyBaseProperty(SliderMax, self._sliderList[index][_sliderState.eMax])
    self._sliderList[index][_sliderState.eMax]:SetText(100)
  end
end
registerEvent("FromClient_SetPhotoMode", "FromClient_SetPhotoMode")
registerEvent("FromClient_PhotoModeUIOnOff", "FromClient_PhotoModeUIOnOff")
registerEvent("FromClient_SetSocialActionIndex", "FromClient_SetSocialActionIndex")
registerEvent("FromClient_SetWeatherPreset", "FromClient_SetWeatherPreset")
registerEvent("FromClient_SetTimeWeather", "FromClient_SetTimeWeather")
registerEvent("FromClient_SetPhotoModeOption", "FromClient_SetPhotoModeOption")
registerEvent("FromClient_SetSliderValue", "FromClient_SetSliderValue")
registerEvent("FromClient_SetPhotoModeFilter", "FromClient_SetPhotoModeFilter")
registerEvent("FromClient_SetPhotoModeVignetting", "FromClient_SetPhotoModeVignetting")
registerEvent("FromClient_SetPhotoModeKeyHighlight", "FromClient_SetPhotoModeKeyHighlight")
registerEvent("FromClient_SetPhotoModeWeatherPresetIndex", "FromClient_SetPhotoModeWeatherPresetIndex")
registerEvent("FromClient_ClosePhotoModeUI", "FromClient_ClosePhotoModeUI")
registerEvent("FromClient_isPhotoModeOpenFromPhotoGallery", "FromClient_isPhotoModeOpenFromPhotoGallery")
registerEvent("FromClient_isPhotoModeBlurOptionOn", "FromClient_isPhotoModeBlurOptionOn")
registerEvent("FromClient_photoModePresetDataValid", "FromClient_photoModePresetDataValid")
registerEvent("FromClient_isPhotoModeFromObservation", "FromClient_isPhotoModeFromObservation")
registerEvent("FromClient_isPhotoModeNonContrastOptionOn", "FromClient_isPhotoModeNonContrastOptionOn")
