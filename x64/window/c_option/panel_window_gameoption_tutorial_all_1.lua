function PaGlobal_GameoptionTutorial_All:initialize()
  if PaGlobal_GameoptionTutorial_All._initialize == true then
    return
  end
  self._ui._soundPage = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Frame_Option")
  self._ui._frameContent = UI.getChildControl(self._ui._soundPage, "Frame_1_Content")
  self._ui._frameScroll = UI.getChildControl(self._ui._soundPage, "Frame_1_VerticalScroll")
  local mainPage = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_MainAreaBG")
  self._ui._soundDesc = UI.getChildControl(mainPage, "Static_Sound_Desc")
  self._ui._graphicDesc = UI.getChildControl(mainPage, "Static_Graphic_Desc")
  self._ui._graphicPage = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_RadioGroup")
  self._ui._rbn_remaster = UI.getChildControl(self._ui._graphicPage, "RadioButton_Remaster")
  self._ui._rbn_normal = UI.getChildControl(self._ui._graphicPage, "RadioButton_Normal")
  local bottomArea = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_BottomAreaBG")
  self._ui._btn_next = UI.getChildControl(bottomArea, "Button_Next")
  local backgroundBlock = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_blockBG")
  backgroundBlock:SetSize(getScreenSizeX(), getScreenSizeY())
  backgroundBlock:ComputePos()
  local stc_title = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_TitleArea")
  local btn_close = UI.getChildControl(stc_title, "Button_Close")
  btn_close:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_GameoptionTutorial_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    local keyGuide = UI.getChildControl(Panel_Window_GameoptionTutorial_All, "Static_KeyGuide_ConsoleUI")
    keyGuide:SetShow(true)
  end
  self:setVoiceLanguage()
  self:createFrame()
  PaGlobal_GameoptionTutorial_All:registEventHandler()
  PaGlobal_GameoptionTutorial_All:validate()
  PaGlobal_GameoptionTutorial_All._initialize = true
end
function PaGlobal_GameoptionTutorial_All:registEventHandler()
  if nil == Panel_Window_GameoptionTutorial_All then
    return
  end
  self._ui._btn_next:addInputEvent("Mouse_LUp", "HandleEventLUp_GameoptionTutorial_All_PressNext()")
  self._ui._rbn_remaster:addInputEvent("Mouse_LUp", "HandleEventLUp_GameoptionTutorial_All_GraphicSettings(true)")
  self._ui._rbn_normal:addInputEvent("Mouse_LUp", "HandleEventLUp_GameoptionTutorial_All_GraphicSettings(false)")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_GameoptionTutorial_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_GameoptionTutorial_All_PressNext()")
  end
end
function PaGlobal_GameoptionTutorial_All:prepareOpen()
  if Panel_Window_GameoptionTutorial_All == nil then
    return
  end
  self._currentPage = 1
  self:openPage()
  PaGlobal_GameoptionTutorial_All:open()
end
function PaGlobal_GameoptionTutorial_All:open()
  if Panel_Window_GameoptionTutorial_All == nil then
    return
  end
  Panel_Window_GameoptionTutorial_All:SetShow(true)
end
function PaGlobal_GameoptionTutorial_All:prepareClose()
  if Panel_Window_GameoptionTutorial_All == nil then
    return
  end
  PaGlobal_GameoptionTutorial_All:close()
end
function PaGlobal_GameoptionTutorial_All:close()
  if nil == Panel_Window_GameoptionTutorial_All then
    return
  end
  Panel_Window_GameoptionTutorial_All:SetShow(false)
end
function PaGlobal_GameoptionTutorial_All:update()
  if nil == Panel_Window_GameoptionTutorial_All then
    return
  end
end
function PaGlobal_GameoptionTutorial_All:validate()
  if nil == Panel_Window_GameoptionTutorial_All then
    return
  end
  self._ui._soundPage:isValidate()
  self._ui._frameContent:isValidate()
  self._ui._frameScroll:isValidate()
  self._ui._soundDesc:isValidate()
  self._ui._graphicDesc:isValidate()
  self._ui._graphicPage:isValidate()
  self._ui._rbn_remaster:isValidate()
  self._ui._rbn_normal:isValidate()
  self._ui._btn_next:isValidate()
end
function PaGlobal_GameoptionTutorial_All:setVoiceLanguage()
  for index, option in ipairs(self._frames) do
    if option._element._name == "AudioResourceType" then
      if isGameTypeSA() == true or isGameTypeRussia() == true or _ContentsOption_CH_GameType == true then
        option._isShow = false
      end
      local radioMapAudioResource = PaGlobal_GameOption_All:GetRadioButtonMap()
      option._element._radioButtonMapping._count = #radioMapAudioResource + 1
      for index = 0, #radioMapAudioResource do
        local serviceType = PaGlobal_GameOption_All:radioButtonMapping_AudioResourceType(index)
        local text
        if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType then
          text = "LUA_GAMEOPTION_KOREAN"
        elseif CppEnums.ServiceResourceType.eServiceResourceType_EN == serviceType then
          text = "LUA_GAMEOPTION_ENGLISH"
        elseif CppEnums.ServiceResourceType.eServiceResourceType_JP == serviceType then
          text = "LUA_GAMEOPTION_JAPANESE"
        elseif CppEnums.ServiceResourceType.eServiceResourceType_TW == serviceType then
          text = "LUA_GAMEOPTION_TAIWAN"
        end
        option._element._radioButtonMapping[index]._gameString = text
        if text ~= "LUA_GAMEOPTION_KOREAN" then
          option._element._radioButtonMapping[index]._setEnable = false
        end
      end
    end
  end
end
function PaGlobal_GameoptionTutorial_All:createFrame()
  local tempPosY = 20
  for index, option in ipairs(self._frames) do
    if option._element ~= nil and (option._element._isShow == nil or option._element._isShow == true) and (option._contentsOption == nil or option._contentsOption == true) then
      local eventGroup
      if __ePAUIControl_RadioButton == option._element._controlType then
        eventGroup = self:CreateControl_RadioButton(index, option._element)
      elseif __ePAUIControl_Slider == option._element._controlType then
        if option._element._isSubSlider == true then
          eventGroup = self:CreateControl_SubSlider(index, option._element)
        else
          eventGroup = self:CreateControl_Slider(index, option._element)
        end
      else
        if __ePAUIControl_CheckButton == option._element._controlType then
          eventGroup = self:CreateControl_CheckButton(index)
        else
        end
      end
      if eventGroup ~= nil then
        PaGlobal_GameOption_All:SetTitleAndDescription(eventGroup, option._element)
        PaGlobal_GameOption_All:SetPictureToolTip(eventGroup, option._element)
        eventGroup:SetShow(true)
        eventGroup:SetEnable(true)
        eventGroup:SetPosY(tempPosY)
        tempPosY = tempPosY + eventGroup:GetSizeY()
        option._element._eventGroup = eventGroup
        self._controls[index] = option._element
      end
    end
  end
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), tempPosY)
  self._ui._soundPage:UpdateContentScroll()
  self._ui._soundPage:GetVScroll():SetControlTop()
  self._ui._soundPage:UpdateContentPos()
  UIScroll.SetButtonSize(self._ui._frameScroll, self._ui._soundPage:GetSizeY(), tempPosY + 20)
  if _ContentsGroup_UsePadSnapping == true then
    ToClient_padSnapRefreshTarget(self._ui._frameContent)
    ToClient_padSnapSetTargetGroup(self._ui._soundPage)
    ToClient_padSnapResetControl()
  end
end
function PaGlobal_GameoptionTutorial_All:CreateControl_RadioButton(index, option)
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
  local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_RadioButtonGroup" .. tostring(index))
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
  local radioButtonTemplate = UI.getChildControl(groupTemplate, "RadioButton_Template")
  local MaxRadioButton = 20
  local lastYIndex = 0
  for ii = 0, MaxRadioButton do
    if ii < option._radioButtonMapping._count then
      local xIndex = ii % 3
      local yIndex = math.floor(ii / 3)
      lastYIndex = yIndex
      local radioButton = UI.getChildControlNoneAssert(group, "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        radioButton = UI.cloneControl(radioButtonTemplate, group, "RadioButton_" .. tostring(ii))
      end
      local radioButtonSizeX = 220
      local radioButtonSizeY = 50
      local gap = 10
      if 2 == option._radioButtonMapping._count then
        radioButtonSizeX = 335
      end
      radioButton:SetSize(radioButtonSizeX, radioButtonTemplate:GetSizeY())
      radioButton:SetPosX(radioButtonTemplate:GetPosX() + xIndex * (radioButtonSizeX + gap))
      radioButton:SetPosY(radioButtonTemplate:GetPosY() + yIndex * radioButtonSizeY)
      radioButton:SetShow(true)
      if option._radioButtonMapping[ii]._setEnable ~= nil and option._radioButtonMapping[ii]._setEnable == false then
        radioButton:SetMonoTone(true)
        radioButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GameoptionTutorial_All_NotPreparedAudio()")
      else
        radioButton:SetEnable(true)
        radioButton:SetMonoTone(false)
        radioButton:SetIgnore(false)
        radioButton:SetGroup(index)
        radioButton:addInputEvent("Mouse_LUp", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. "," .. tostring(ii) .. ")")
      end
    else
      local radioButton = UI.getChildControlNoneAssert(group, "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        break
      else
        radioButton:SetShow(false)
      end
    end
  end
  group:SetSize(groupTemplate:GetSizeX(), groupTemplate:GetSizeY() + 50 * lastYIndex)
  return group
end
function PaGlobal_GameoptionTutorial_All:CreateControl_Slider(index, option)
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSliderGroup")
  local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_SliderGroup" .. tostring(index))
  group:SetIgnore(false)
  local sliderTemplate = UI.getChildControl(group, "Slider_Template")
  sliderTemplate:addInputEvent("Mouse_LPress", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  local sliderButton = UI.getChildControl(sliderTemplate, "Slider_Button")
  sliderButton:addInputEvent("Mouse_LUp", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  sliderButton:addInputEvent("Mouse_LPress", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  if option._clickSound ~= nil then
    sliderButton:SetClickSound(option._clickSound[0], option._clickSound[1])
  end
  sliderTemplate:SetShow(true)
  return group
end
function PaGlobal_GameoptionTutorial_All:CreateControl_SubSlider(index, option)
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSliderSmallGroup")
  local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_SubSliderGroup" .. tostring(index))
  local sliderTemplate = UI.getChildControl(group, "Slider_Template")
  sliderTemplate:addInputEvent("Mouse_LPress", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  local sliderButton = UI.getChildControl(sliderTemplate, "Slider_Button")
  sliderButton:addInputEvent("Mouse_LUp", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  sliderButton:addInputEvent("Mouse_LPress", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  if option._clickSound ~= nil then
    sliderButton:SetClickSound(option._clickSound[0], option._clickSound[1])
  end
  sliderTemplate:SetShow(true)
  return group
end
function PaGlobal_GameoptionTutorial_All:CreateControl_CheckButton(index)
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateCheckBtnGroup")
  local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_CheckButtonGroup" .. tostring(index))
  local checkButtonTemplate = UI.getChildControl(group, "CheckButton_Template")
  checkButtonTemplate:addInputEvent("Mouse_LUp", "PaGlobal_GameoptionTutorial_All:ChangeControlSetting(" .. tostring(index) .. ")")
  checkButtonTemplate:SetShow(true)
  checkButtonTemplate:SetEnable(true)
  checkButtonTemplate:SetIgnore(false)
  local title = UI.getChildControl(group, "StaticText_Title")
  local desc = UI.getChildControl(group, "StaticText_Desc")
  title:SetMonoTone(false)
  desc:SetMonoTone(false)
  return group
end
function PaGlobal_GameoptionTutorial_All:ChangeControlSetting(index, subIndex)
  local option = self._controls[index]
  if __ePAUIControl_CheckButton == option._controlType then
    local checkButton = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    option._value = checkButton:IsCheck()
  elseif __ePAUIControl_RadioButton == option._controlType then
    option._value = subIndex
  elseif __ePAUIControl_Slider == option._controlType then
    local slider = UI.getChildControl(option._eventGroup, "Slider_Template")
    option._value = slider:GetControlPos()
    local displayValue = PaGlobal_GameOption_All:FromSliderValueToRealValue(option._value, option._sliderValueMin, option._sliderValueMax)
    displayValue = math.floor(displayValue + 0.5)
    local sliderCurrentText = UI.getChildControl(option._eventGroup, "StaticText_Current")
    sliderCurrentText:SetText("<PAColor0xfff5ba3a>" .. displayValue .. "<PAOldColor>")
  end
  HandleEventLUp_GameoptionTutorial_All_Apply()
end
function PaGlobal_GameoptionTutorial_All:SetControlSetting(option, value)
  if __ePAUIControl_CheckButton == option._controlType then
    local checkButton = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    checkButton:SetCheck(value)
  elseif __ePAUIControl_RadioButton == option._controlType then
    for ii = 0, option._radioButtonMapping._count - 1 do
      local radioButton = UI.getChildControl(option._eventGroup, "RadioButton_" .. tostring(ii))
      radioButton:SetCheck(value == ii)
    end
  elseif __ePAUIControl_Slider == option._controlType then
    local slider = UI.getChildControl(option._eventGroup, "Slider_Template")
    slider:SetControlPos(value * 100)
    local displayButton = UI.getChildControl(slider, "Slider_Button")
    displayButton:SetPosX(slider:GetControlButton():GetPosX())
    displayButton:SetPosY(slider:GetControlButton():GetPosY())
    local displayValue = PaGlobal_GameOption_All:FromSliderValueToRealValue(value, option._sliderValueMin, option._sliderValueMax)
    displayValue = math.floor(displayValue + 0.5)
    local sliderCurrentText = UI.getChildControl(option._eventGroup, "StaticText_Current")
    sliderCurrentText:SetText("<PAColor0xfff5ba3a>" .. displayValue .. "<PAOldColor>")
  end
end
function PaGlobal_GameoptionTutorial_All:pressedNextButton()
  self._currentPage = self._currentPage + 1
  if self._currentPage <= self._lastPage then
    self:openPage()
  else
    PaGlobal_GameoptionTutorial_All_Close()
  end
end
function PaGlobal_GameoptionTutorial_All:openPage()
  if self._currentPage == 1 then
    self._ui._soundDesc:SetShow(true)
    self._ui._graphicDesc:SetShow(false)
    self._ui._soundPage:SetShow(true)
    self._ui._graphicPage:SetShow(false)
  elseif self._currentPage == 2 then
    self._remasterMode = true
    self._ui._rbn_remaster:SetCheck(true)
    self._ui._soundDesc:SetShow(false)
    self._ui._graphicDesc:SetShow(true)
    self._ui._soundPage:SetShow(false)
    self._ui._graphicPage:SetShow(true)
  end
  if self._currentPage == self._lastPage then
    self._ui._btn_next:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_SERVERSELECT_NEW_BTN_CHANNEL"))
  end
end
function PaGlobal_GameoptionTutorial_All:setGraphicSettings(check)
  self._remasterMode = check
end
