function PaGlobal_ColorPalette_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.stc_paletteAllBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Select_Bg")
  self._ui.stc_paletteBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Palette_BG")
  self._ui.stc_palette = UI.getChildControl(self._ui.stc_paletteBG, "Static_Color0")
  self._ui.stc_paletteCursor = UI.getChildControl(self._ui.stc_palette, "Static_Cursor")
  self._ui.stc_brightBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Bright_BG")
  self._ui.stc_bright = UI.getChildControl(self._ui.stc_brightBG, "Static_Color1")
  self._ui.stc_brightSlider = UI.getChildControl(self._ui.stc_brightBG, "Static_Slider")
  local stc_selectColorBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Select_Color_BG")
  self._ui.stc_selectColor = UI.getChildControl(stc_selectColorBG, "Static_SelectColor")
  local stc_colorInfoBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_ColorInfo_Select")
  self._ui.txt_textInfoR = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_R")
  self._ui.txt_textInfoG = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_G")
  self._ui.txt_textInfoB = UI.getChildControl(stc_colorInfoBG, "StaticText_Info_B")
  local stc_editNumberBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Edit_BG")
  self._ui.edit_numberR = UI.getChildControl(stc_editNumberBG, "Edit_R")
  self._ui.edit_numberG = UI.getChildControl(stc_editNumberBG, "Edit_G")
  self._ui.edit_numberB = UI.getChildControl(stc_editNumberBG, "Edit_B")
  self._ui.txt_textTitleR = UI.getChildControl(stc_editNumberBG, "StaticText_Title_R")
  self._ui.txt_textTitleG = UI.getChildControl(stc_editNumberBG, "StaticText_Title_G")
  self._ui.txt_textTitleB = UI.getChildControl(stc_editNumberBG, "StaticText_Title_B")
  self._ui.btn_color_select = UI.getChildControl(Panel_Window_ColorPalette_All, "Button_Color_Select")
  self._ui.edit_numberR:SetNumberMode(true)
  self._ui.edit_numberG:SetNumberMode(true)
  self._ui.edit_numberB:SetNumberMode(true)
  self._ui.stc_weaponColorChoice = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_WeaponColorChoice")
  self._ui.txt_keyguide = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyguideY = UI.getChildControl(Panel_Window_ColorPalette_All, "StaticText_KeyGuide_ConsoleUI_Y")
  self._ui.txt_keyguideLB = UI.getChildControl(self._ui.stc_weaponColorChoice, "Static_KeyGuide_ConsoleUI_LB")
  self._ui.txt_keyguideRB = UI.getChildControl(self._ui.stc_weaponColorChoice, "Static_KeyGuide_ConsoleUI_RB")
  self._ui.stc_saveColorBG = UI.getChildControl(Panel_Window_ColorPalette_All, "Static_Save_Color")
  self._ui.btn_savePresetColor = UI.getChildControl(self._ui.stc_saveColorBG, "Button_Color_Save")
  self._ui.txt_keyguideX = UI.getChildControl(self._ui.stc_saveColorBG, "StaticText_KeyGuide_ConsoleUI_X")
  self:keyGuidePosition()
  self:createControl()
  self:loadColorPresetRadioButtonList()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ColorPalette_All:loadColorPresetRadioButtonList()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if 14 ~= __eColorPalettePresetCount then
    _PA_ASSERT_NAME(false, "\237\148\132\235\166\172\236\133\139 \234\176\156\236\136\152 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. __eColorPalettePresetCount \234\180\128\235\160\168\235\144\156 \234\179\179 \237\153\149\236\157\184\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  end
  local colorPresetListBG = UI.getChildControl(self._ui.stc_saveColorBG, "Static_Color")
  for index = 1, __eColorPalettePresetCount do
    if index < 10 then
      self._ui.radiobtn_colorPresetList[index] = UI.getChildControl(colorPresetListBG, "RadioButton_Part_0" .. index)
    else
      self._ui.radiobtn_colorPresetList[index] = UI.getChildControl(colorPresetListBG, "RadioButton_Part_" .. index)
    end
    self._ui.radiobtn_colorPresetList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_LoadColorPreset(" .. index .. ")")
    self._ui.radiobtn_colorPresetList[index]:addInputEvent("Mouse_On", "HandleEventLUp_ColorPalette_All_ColorPresetFocused(" .. index .. ")")
    self._ui.radiobtn_colorPresetList[index]:addInputEvent("Mouse_Out", "HandleEventLUp_ColorPalette_All_ColorPresetUnFocused(" .. index .. ")")
    self._ui.stc_selectedBorderUIList[index] = UI.getChildControl(self._ui.radiobtn_colorPresetList[index], "Static_Chosen")
    local hslInfo = ToClient_getColorPresetInformation(index - 1)
    local hue, saturation, lightness = self:dwordToByte3(hslInfo)
    if nil ~= hue then
      local red, green, blue = self:hslToRgb(hue, saturation, lightness)
      self._ui.radiobtn_colorPresetList[index]:SetColor(self:byte3ToDword(red, green, blue))
      local xImage = UI.getChildControl(self._ui.radiobtn_colorPresetList[index], "Static_XMark")
      xImage:SetShow(false)
    end
  end
end
function PaGlobal_ColorPalette_All:keyGuidePosition()
  local gap = 5
  local keyguideClose = UI.getChildControl(self._ui.txt_keyguide, "StaticText_Close")
  local keyguideSelectDescription = UI.getChildControl(self._ui.txt_keyguide, "StaticText_ColorPallet_Select")
  local keyguideShadowSelect = UI.getChildControl(self._ui.txt_keyguide, "StaticText_Shadow_Select")
  local keyguideCloseXSize = keyguideClose:GetTextSpan().x + keyguideClose:GetTextSizeX()
  local keyguideShadowSelectXSize = keyguideShadowSelect:GetTextSpan().x + keyguideShadowSelect:GetTextSizeX()
  local keyguideSelectDescriptionXSize = keyguideSelectDescription:GetTextSpan().x + keyguideSelectDescription:GetTextSizeX()
  local keyguideBGSizeY = self._ui.txt_keyguide:GetSizeY()
  keyguideClose:SetPosX(self._ui.txt_keyguide:GetSizeX() - keyguideCloseXSize - gap)
  if gap > keyguideClose:GetPosX() - keyguideShadowSelectXSize then
    keyguideShadowSelect:SetPosX(self._ui.txt_keyguide:GetSizeX() - keyguideShadowSelectXSize - gap)
    keyguideShadowSelect:SetPosY(self._ui.txt_keyguide:GetSizeY())
    self._ui.txt_keyguide:SetSize(self._ui.txt_keyguide:GetSizeX(), self._ui.txt_keyguide:GetSizeY() + keyguideBGSizeY)
  else
    keyguideShadowSelect:SetPosX(keyguideClose:GetPosX() - keyguideShadowSelectXSize - gap)
  end
  if gap > keyguideShadowSelect:GetPosX() - keyguideSelectDescriptionXSize then
    keyguideSelectDescription:SetPosX(self._ui.txt_keyguide:GetSizeX() - keyguideSelectDescriptionXSize - gap)
    keyguideSelectDescription:SetPosY(self._ui.txt_keyguide:GetSizeY())
    self._ui.txt_keyguide:SetSize(self._ui.txt_keyguide:GetSizeX(), self._ui.txt_keyguide:GetSizeY() + keyguideBGSizeY)
  else
    keyguideSelectDescription:SetPosX(keyguideShadowSelect:GetPosX() - keyguideSelectDescriptionXSize - gap)
    keyguideSelectDescription:SetPosY(keyguideShadowSelect:GetPosY())
  end
end
function PaGlobal_ColorPalette_All:colorPalettePressedInConsoleMode()
  self._isPanelPressedInConsole = true
end
function PaGlobal_ColorPalette_All:colorPaletteReleasedInConsoleMode()
  self._isPanelPressedInConsole = false
end
function PaGlobal_ColorPalette_All:createControl()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if self._config.lightnessLevelCount < 1 then
    return
  end
  local lightnessLevelYSize = self._ui.stc_bright:GetSizeY() / self._config.lightnessLevelCount
  for index = 0, self._config.lightnessLevelCount - 1 do
    self._ui.lightnessLevel[index] = UI.cloneControl(self._ui.stc_bright, self._ui.stc_brightBG, "Static_lightnessLevel_" .. index)
    self._ui.lightnessLevel[index]:SetPosX(self._ui.stc_bright:GetPosX())
    self._ui.lightnessLevel[index]:SetPosY(self._ui.stc_bright:GetPosY() + lightnessLevelYSize * index)
    self._ui.lightnessLevel[index]:SetSize(self._ui.stc_bright:GetSizeX(), lightnessLevelYSize)
    self._ui.lightnessLevel[index]:SetIgnore(true)
  end
end
function PaGlobal_ColorPalette_All:registEventHandler()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ColorPalette_All_ReSizePanel")
  registerEvent("FromClient_EventRGBInfoCleared", "FromClient_ColorPalette_All_EventRGBInfoCleared")
  registerEvent("FromClient_EventRGBHistoryApplied", "FromClient_ColorPalette_All_EventRGBHistoryApplied")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ColorPalette_All_Close()")
  self._ui.stc_palette:addInputEvent("Mouse_LDown", "HandleEventLDown_ColorPalette_All_PanelClicked(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_palette:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_palette:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_paletteCursor:addInputEvent("Mouse_LDown", "HandleEventLDown_ColorPalette_All_PanelClicked(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_paletteCursor:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_paletteCursor:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.hueSaturation .. ")")
  self._ui.stc_bright:addInputEvent("Mouse_LDown", "HandleEventLDown_ColorPalette_All_PanelClicked(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_bright:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_bright:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.lightness .. ")")
  self._ui.stc_brightSlider:addInputEvent("Mouse_LDown", "HandleEventLDown_ColorPalette_All_PanelClicked(" .. self._palettePanelType.lightnessSlider .. ")")
  self._ui.stc_brightSlider:addInputEvent("Mouse_LPress", "HandleEventLPress_ColorPalette_All_PanelPressed(" .. self._palettePanelType.lightnessSlider .. ")")
  self._ui.stc_brightSlider:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_PanelReleased(" .. self._palettePanelType.lightnessSlider .. ")")
  self._ui.edit_numberR:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.red .. ")")
  self._ui.edit_numberG:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.green .. ")")
  self._ui.edit_numberB:RegistAllKeyEvent("FromClient_ColorPalette_All_EditBoxChanged(" .. self._rgbType.blue .. ")")
  self._ui.edit_numberR:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyRGBToTarget()")
  self._ui.edit_numberG:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyRGBToTarget()")
  self._ui.edit_numberB:RegistReturnKeyEvent("HandleEventKey_ColorPalette_All_ApplyRGBToTarget()")
  self._ui.btn_color_select:addInputEvent("Mouse_LUp", "HandleEventKey_ColorPalette_All_ApplyRGBToTarget()")
  self._ui.edit_numberR:addInputEvent("Mouse_LUp", "HandleEventLDown_ColorPalette_All_FocusEditBox(" .. self._rgbType.red .. ")")
  self._ui.edit_numberG:addInputEvent("Mouse_LUp", "HandleEventLDown_ColorPalette_All_FocusEditBox(" .. self._rgbType.green .. ")")
  self._ui.edit_numberB:addInputEvent("Mouse_LUp", "HandleEventLDown_ColorPalette_All_FocusEditBox(" .. self._rgbType.blue .. ")")
  for ii = 1, self._config.paletteTypeCount do
    local radioBtn = UI.getChildControl(self._ui.stc_weaponColorChoice, "RadioButton_Material_" .. ii)
    radioBtn:addInputEvent("Mouse_LUp", "HandleEventLPress_ColorPalette_All_SelectPaletteType(" .. ii .. ")")
    radioBtn:addInputEvent("Mouse_On", "HandleEventOnOut_ColorPalette_All_SelectPaletteType( true, " .. ii .. ")")
    radioBtn:addInputEvent("Mouse_Out", "HandleEventOnOut_ColorPalette_All_SelectPaletteType( false, " .. ii .. ")")
  end
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_ColorPalette_All_ChangeTarget(-1)")
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_ColorPalette_All_ChangeTarget(1)")
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventKey_ColorPalette_All_ApplyRGBToTarget()")
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_ColorPalette_All_SaveColorPreset()")
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLTDown_ColorPalette_All_ColorPalettePressed()")
    Panel_Window_ColorPalette_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLTUp_ColorPalette_All_ColorPaletteReleased()")
  end
  self._ui.btn_savePresetColor:addInputEvent("Mouse_LUp", "HandleEventLUp_ColorPalette_All_SaveColorPreset()")
end
function PaGlobal_ColorPalette_All:clear()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._colorValue.hue = 0
  self._colorValue.saturation = 0
  self._colorValue.lightness = self:round(__eRgbColorLimitationHSLRange / 2)
  self._colorValue.red = 255
  self._colorValue.green = 255
  self._colorValue.blue = 255
  self._colorValue.paletteType = 1
  self._callerInfo.classType = nil
  self._callerInfo.paramType = nil
  self._callerInfo.paramIndex = nil
  self._lastAppliedColorPerPartList = {}
  self._isPanelPressed = false
  self._isPanelPressedInConsole = false
  self._pressCount = 0
  self._isColorChanged = false
  self._pressedPanelType = nil
  self._colorValue.lastAppliedHue = -1
  self._colorValue.lastAppliedSaturation = -1
  self._colorValue.lastAppliedLightness = -1
  self._isSlotChanged = false
  self._isTypeChanged = false
  self._updateTime = 0
  self._rStickPressTime = 0
  self._accelSpeed = 0
  self._focusedEditControlIdx = 2
  ClearFocusEdit()
  self._targetPresetSlot = 1
end
function PaGlobal_ColorPalette_All:InputMOnOut_Dye_CategoryTooltip(isOn, buttonIdx)
  local name = ""
  local desc, control
  if true == isOn then
    control = UI.getChildControl(self._ui.stc_weaponColorChoice, "RadioButton_Material_" .. buttonIdx)
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_" .. buttonIdx - 1)
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_DESC_" .. buttonIdx - 1)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_ColorPalette_All:prepareOpen(openType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._initialize then
    self:initialize()
  end
  if true == Panel_Window_ColorPalette_All:IsShow() then
    return
  end
  self._openType = openType
  self:clear()
  self:setPanelView()
  self:update()
  Panel_Window_ColorPalette_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  Panel_Window_ColorPalette_All:RegisterUpdateFunc("PaGlobal_ColorPalette_All_UpdatePerFrame")
  PaGlobal_ColorPalette_All:open()
end
function PaGlobal_ColorPalette_All:colorPaletteUpdatePerFrame(deltaTime)
  local VCK = CppEnums.VirtualKeyCode
  if true == isKeyDown_Once(VCK.KeyCode_TAB) then
    self._focusedEditControlIdx = (self._focusedEditControlIdx + 1) % 3
    if self._rgbType.red == self._focusedEditControlIdx then
      SetFocusEdit(self._ui.edit_numberR)
    elseif self._rgbType.green == self._focusedEditControlIdx then
      SetFocusEdit(self._ui.edit_numberG)
    else
      SetFocusEdit(self._ui.edit_numberB)
    end
  end
  self._updateTime = self._updateTime + deltaTime
  if self._updateTime < self._config.updateFrequency then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    local rStickX = getPadRightStickMoveX()
    local rStickY = getPadRightStickMoveY()
    if rStickX > -self._config.rStickSesitivityLimit and rStickX < self._config.rStickSesitivityLimit and rStickY > -self._config.rStickSesitivityLimit and rStickY < self._config.rStickSesitivityLimit then
      if true == self._isColorChanged then
        self:applyColorToTarget()
        self._isColorChanged = false
        self._pressCount = 0
      end
      self._rStickPressTime = 0
      self._accelSpeed = 0
      return
    end
    self._rStickPressTime = self._rStickPressTime + self._updateTime
    if self._config.accelStartTime < self._rStickPressTime then
      self._accelSpeed = self._accelSpeed + deltaTime
      if self._config.limitAccelSpeed < self._accelSpeed then
        self._accelSpeed = self._config.limitAccelSpeed
      end
    end
    local originalHue, originalSaturation, originalLightness = self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness
    if false == self._isPanelPressedInConsole then
      local lightnessPosition = self:hslToMousePosition(self._hslType.lightness, self._colorValue.lightness)
      lightnessPosition = self:rStickSpeedCalculator(lightnessPosition, rStickY, self._accelSpeed * self._updateTime)
      self._colorValue.lightness = self:mousePositionToHsl(self._hslType.lightness, lightnessPosition)
    else
      local huePosition = self:hslToMousePosition(self._hslType.hue, self._colorValue.hue)
      if rStickX > self._config.rStickSesitivityLimit or rStickX < -self._config.rStickSesitivityLimit then
        huePosition = self:rStickSpeedCalculator(huePosition, rStickX, self._accelSpeed * self._updateTime)
      end
      self._colorValue.hue = self:mousePositionToHsl(self._hslType.hue, huePosition)
      local saturationPosition = self:hslToMousePosition(self._hslType.saturation, self._colorValue.saturation)
      if rStickY > self._config.rStickSesitivityLimit or rStickY < -self._config.rStickSesitivityLimit then
        saturationPosition = self:rStickSpeedCalculator(saturationPosition, rStickY, self._accelSpeed * self._updateTime)
      end
      self._colorValue.saturation = self:mousePositionToHsl(self._hslType.saturation, saturationPosition)
    end
    if originalHue ~= self._colorValue.hue or originalSaturation ~= self._colorValue.saturation or originalLightness ~= self._colorValue.lightness then
      self._isColorChanged = true
    end
    if false == self._isColorChanged then
      return
    end
    self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
    if self._config.pressUpdateFrequency < self._pressCount then
      self:applyColorToTarget()
      self._pressCount = 0
    else
      self._pressCount = self._pressCount + 1
    end
    self:update()
  end
  self._updateTime = 0
end
function PaGlobal_ColorPalette_All:rStickSpeedCalculator(mousePosition, rStickPosition, accelSpeed)
  if rStickPosition < 0 then
    mousePosition = mousePosition - 1 / __eRgbColorLimitationHSLRange
  else
    mousePosition = mousePosition + 1 / __eRgbColorLimitationHSLRange
  end
  mousePosition = mousePosition + rStickPosition * accelSpeed
  if mousePosition > 1 then
    mousePosition = 1
  elseif mousePosition < 0 then
    mousePosition = 0
  end
  return mousePosition
end
function PaGlobal_ColorPalette_All:changeWeaponType(value)
  if __eRGBPaletteTypeItem ~= self._openType then
    return
  end
  local paletteType = self._colorValue.paletteType + value
  if paletteType < 1 then
    paletteType = 1
  elseif paletteType > self._config.paletteTypeCount then
    paletteType = self._config.paletteTypeCount
  end
  local panelType = self._pressedPanelType
  HandleEventLPress_ColorPalette_All_SelectPaletteType(paletteType)
  self:updateColorTypeIcon()
end
function PaGlobal_ColorPalette_All:setPanelView()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  local gap = 10
  if __eRGBPaletteTypeCustomization == self._openType then
    self._ui.stc_weaponColorChoice:SetShow(false)
    self._ui.stc_palette:ChangeTextureInfoNameAsync("combine/etc/combine_etc_colorpalette_1.dds")
    Panel_Window_ColorPalette_All:SetPosX(getScreenSizeX() - Panel_Window_ColorPalette_All:GetSizeX() - gap)
    if nil ~= PaGlobal_Panel_Cash_Customization_GetApplyButtonPosY and false == _ContentsGroup_UsePadSnapping then
      local applyButtonPosition = PaGlobal_Panel_Cash_Customization_GetApplyButtonPosY()
      Panel_Window_ColorPalette_All:SetPosY(applyButtonPosition - Panel_Window_ColorPalette_All:GetSizeY() - gap)
    else
      Panel_Window_ColorPalette_All:SetPosY(getScreenSizeY() - Panel_Window_ColorPalette_All:GetSizeY() - 100 - gap)
    end
    local editControlPositionX = self._ui.txt_textTitleR:GetTextSizeX()
    if editControlPositionX < self._ui.txt_textTitleG:GetTextSizeX() then
      editControlPositionX = self._ui.txt_textTitleG:GetTextSizeX()
    end
    if editControlPositionX < self._ui.txt_textTitleB:GetTextSizeX() then
      editControlPositionX = self._ui.txt_textTitleB:GetTextSizeX()
    end
    self._ui.edit_numberR:SetPosX(editControlPositionX + gap)
    self._ui.edit_numberG:SetPosX(editControlPositionX + gap)
    self._ui.edit_numberB:SetPosX(editControlPositionX + gap)
  elseif __eRGBPaletteTypeItem == self._openType then
    Panel_Window_ColorPalette_All:SetSize(Panel_Window_ColorPalette_All:GetSizeX(), Panel_Window_ColorPalette_All:GetSizeY() + self._ui.stc_weaponColorChoice:GetSizeY())
    self._ui.stc_weaponColorChoice:SetPosY(self._ui.stc_paletteAllBG:GetPosY() + self._ui.stc_paletteAllBG:GetSizeY() + 5)
    self._ui.stc_saveColorBG:SetPosY(self._ui.stc_saveColorBG:GetPosY() + self._ui.stc_weaponColorChoice:GetSizeY() + 5)
    Panel_Window_ColorPalette_All:SetPosX(getScreenSizeX() - Panel_Window_ColorPalette_All:GetSizeX() - gap)
    if nil ~= Panel_Widget_Dye_All and nil ~= PaGlobal_Dye_CharacterController then
      Panel_Window_ColorPalette_All:SetPosY(PaGlobal_Dye_CharacterController._ui_pc.btn_Exit:GetPosY() - Panel_Window_ColorPalette_All:GetSizeY() - gap)
    else
      Panel_Window_ColorPalette_All:SetPosY(getScreenSizeY() - Panel_Window_ColorPalette_All:GetSizeY() - 100 - gap)
    end
    local editControlPositionX = self._ui.txt_textTitleR:GetTextSizeX()
    if editControlPositionX < self._ui.txt_textTitleG:GetTextSizeX() then
      editControlPositionX = self._ui.txt_textTitleG:GetTextSizeX()
    end
    if editControlPositionX < self._ui.txt_textTitleB:GetTextSizeX() then
      editControlPositionX = self._ui.txt_textTitleB:GetTextSizeX()
    end
    self._ui.edit_numberR:SetPosX(editControlPositionX + gap)
    self._ui.edit_numberG:SetPosX(editControlPositionX + gap)
    self._ui.edit_numberB:SetPosX(editControlPositionX + gap)
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.txt_keyguide:SetPosY(Panel_Window_ColorPalette_All:GetSizeY())
    Panel_Window_ColorPalette_All:SetPosY(Panel_Window_ColorPalette_All:GetPosY() - self._ui.txt_keyguide:GetSizeY())
    self._ui.btn_color_select:SetShow(false)
    self._ui.txt_keyguide:SetShow(true)
    self._ui.txt_keyguideY:SetShow(true)
    self._ui.txt_keyguideX:SetShow(true)
    self._ui.txt_keyguideLB:SetShow(true)
    self._ui.txt_keyguideRB:SetShow(true)
    self._ui.btn_savePresetColor:SetShow(false)
  end
end
function PaGlobal_ColorPalette_All:resetPanelView()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if __eRGBPaletteTypeCustomization == self._openType then
    self._ui.stc_weaponColorChoice:SetShow(true)
    self._ui.stc_palette:ChangeTextureInfoNameAsync("combine/etc/combine_etc_colorpalette.dds")
  elseif __eRGBPaletteTypeItem == self._openType then
    Panel_Window_ColorPalette_All:SetSize(Panel_Window_ColorPalette_All:GetSizeX(), Panel_Window_ColorPalette_All:GetSizeY() - self._ui.stc_weaponColorChoice:GetSizeY())
    self._ui.stc_saveColorBG:SetPosY(self._ui.stc_saveColorBG:GetPosY() - self._ui.stc_weaponColorChoice:GetSizeY() - 5)
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.btn_color_select:SetShow(true)
    self._ui.txt_keyguide:SetShow(false)
    self._ui.txt_keyguideY:SetShow(false)
    self._ui.txt_keyguideX:SetShow(false)
    self._ui.txt_keyguideLB:SetShow(false)
    self._ui.txt_keyguideRB:SetShow(false)
    self._ui.btn_savePresetColor:SetShow(true)
  end
end
function PaGlobal_ColorPalette_All:open()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  Panel_Window_ColorPalette_All:SetShow(true)
end
function PaGlobal_ColorPalette_All:prepareClose()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self:resetPanelView()
  Panel_Window_ColorPalette_All:ClearUpdateLuaFunc()
  if __eRGBPaletteTypeCustomization == self._openType and true == self._isColorChanged then
    self:addDecorationHistory()
  end
  if true == _ContentsGroup_UsePadSnapping then
    if __eRGBPaletteTypeCustomization == self._openType and nil ~= PaGlobalFunc_Customization_KeyGuideSetShow then
      PaGlobalFunc_Customization_KeyGuideSetShow(true)
    elseif __eRGBPaletteTypeItem == self._openType and nil ~= PaGlobal_Dye_CharacterController_SetKeyGuideShow then
      PaGlobal_Dye_CharacterController_SetKeyGuideShow(true)
    end
  end
  self:clear()
  PaGlobal_ColorPalette_All:close()
end
function PaGlobal_ColorPalette_All:close()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  Panel_Window_ColorPalette_All:SetShow(false)
end
function PaGlobal_ColorPalette_All:updateColorTypeIcon()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  for ii = 1, self._config.paletteTypeCount do
    local radioBtn = UI.getChildControl(self._ui.stc_weaponColorChoice, "RadioButton_Material_" .. ii)
    if self._colorValue.paletteType == ii then
      radioBtn:SetCheck(true)
    else
      radioBtn:SetCheck(false)
    end
  end
end
function PaGlobal_ColorPalette_All:updateRGBText()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if _ContentsOption_CH_GameType == true then
    self._ui.txt_textInfoR:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_COLOR_RED") .. " : " .. self._colorValue.red)
    self._ui.txt_textInfoG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_COLOR_GREEN") .. " : " .. self._colorValue.green)
    self._ui.txt_textInfoB:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_COLOR_BLUE") .. " : " .. self._colorValue.blue)
  else
    self._ui.txt_textInfoR:SetText("R : " .. self._colorValue.red)
    self._ui.txt_textInfoG:SetText("G : " .. self._colorValue.green)
    self._ui.txt_textInfoB:SetText("B : " .. self._colorValue.blue)
  end
  self._ui.edit_numberR:SetEditText(self._colorValue.red)
  self._ui.edit_numberG:SetEditText(self._colorValue.green)
  self._ui.edit_numberB:SetEditText(self._colorValue.blue)
end
function PaGlobal_ColorPalette_All:updateCursor()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._ui.stc_paletteCursor:SetPosX(self._ui.stc_palette:GetSizeX() * self:hslToMousePosition(self._hslType.hue, self._colorValue.hue) - self._ui.stc_paletteCursor:GetSizeX() / 2)
  self._ui.stc_paletteCursor:SetPosY(self._ui.stc_palette:GetSizeY() * (1 - self:hslToMousePosition(self._hslType.saturation, self._colorValue.saturation)) - self._ui.stc_paletteCursor:GetSizeY() / 2)
  self._ui.stc_brightSlider:SetPosY(self._ui.stc_bright:GetSizeY() * (1 - self:hslToMousePosition(self._hslType.lightness, self._colorValue.lightness)) - self._ui.stc_brightSlider:GetSizeY() / 2 + self._ui.stc_bright:GetPosY())
end
function PaGlobal_ColorPalette_All:updatePaletteColor()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if 1 < self._config.lightnessLevelCount then
    local lightnessLevelSize = 1 / (self._config.lightnessLevelCount - 1)
    for index = 0, self._config.lightnessLevelCount - 1 do
      local red, green, blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, lightnessLevelSize * (self._config.lightnessLevelCount - 1 - index) * __eRgbColorLimitationHSLRange)
      self._ui.lightnessLevel[index]:SetColor(self:byte3ToDword(red, green, blue))
    end
  end
  self._ui.stc_selectColor:SetColor(self:byte3ToDword(self._colorValue.red, self._colorValue.green, self._colorValue.blue))
end
function PaGlobal_ColorPalette_All:updateColorPresetList()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  for index = 1, __eColorPalettePresetCount do
    if index == self._targetPresetSlot then
      self._ui.stc_selectedBorderUIList[index]:SetShow(true)
    else
      self._ui.stc_selectedBorderUIList[index]:SetShow(false)
    end
  end
end
function PaGlobal_ColorPalette_All:update()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self:updatePaletteColor()
  self:updateRGBText()
  self:updateCursor()
  self:updateColorPresetList()
  if __eRGBPaletteTypeItem == self._openType then
    self:updateColorTypeIcon()
  end
end
function PaGlobal_ColorPalette_All:validate()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_paletteBG:isValidate()
  self._ui.stc_brightBG:isValidate()
  self._ui.stc_palette:isValidate()
  self._ui.stc_bright:isValidate()
  self._ui.stc_paletteCursor:isValidate()
  self._ui.stc_brightSlider:isValidate()
  self._ui.txt_textInfoR:isValidate()
  self._ui.txt_textInfoG:isValidate()
  self._ui.txt_textInfoB:isValidate()
  self._ui.edit_numberR:isValidate()
  self._ui.edit_numberG:isValidate()
  self._ui.edit_numberB:isValidate()
  self._ui.txt_textTitleR:isValidate()
  self._ui.txt_textTitleG:isValidate()
  self._ui.txt_textTitleB:isValidate()
  self._ui.btn_color_select:isValidate()
  self._ui.stc_weaponColorChoice:isValidate()
  self._ui.stc_paletteAllBG:isValidate()
  self._ui.txt_keyguide:isValidate()
  self._ui.txt_keyguideY:isValidate()
  self._ui.txt_keyguideX:isValidate()
  self._ui.txt_keyguideLB:isValidate()
  self._ui.txt_keyguideRB:isValidate()
  self._ui.stc_saveColorBG:isValidate()
  self._ui.btn_savePresetColor:isValidate()
  for index = 1, __eColorPalettePresetCount do
    self._ui.radiobtn_colorPresetList[index]:isValidate()
    self._ui.stc_selectedBorderUIList[index]:isValidate()
  end
end
function PaGlobal_ColorPalette_All:panelClicked(panelType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._isPanelPressed then
    self._isPanelPressed = true
    self._pressedPanelType = panelType
    local mousePosX = getMousePosX()
    local mousePosY = getMousePosY()
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    local targetPanel
    if self._palettePanelType.hueSaturation == panelType then
      targetPanel = self._ui.stc_palette
    elseif self._palettePanelType.lightness == panelType then
      targetPanel = self._ui.stc_bright
    elseif self._palettePanelType.lightnessSlider == panelType then
      targetPanel = self._ui.stc_brightSlider
    end
    local panelSizeX = targetPanel:GetSizeX()
    local panelSizeY = targetPanel:GetSizeY()
    targetPanel:SetEnableArea(-mousePosX, -mousePosY, panelSizeX + screenSizeX - mousePosX, panelSizeY + screenSizeY - mousePosY)
  end
end
function PaGlobal_ColorPalette_All:panelPressed(panelType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._isPanelPressed then
    return
  end
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = 0
  local panelSizeX = 0
  local panelPosY = 0
  local panelSizeY = 0
  local relativePosX = 0
  local relativePosY = 0
  local targetPanel
  if self._palettePanelType.hueSaturation == panelType then
    targetPanel = self._ui.stc_palette
  elseif self._palettePanelType.lightness == panelType or self._palettePanelType.lightnessSlider == panelType then
    targetPanel = self._ui.stc_bright
  end
  panelPosX = targetPanel:GetParentPosX()
  panelSizeX = targetPanel:GetSizeX()
  panelPosY = targetPanel:GetParentPosY()
  panelSizeY = targetPanel:GetSizeY()
  if 0 == panelSizeX or 0 == panelSizeY then
    _PA_ASSERT_NAME(false, "\237\129\180\235\166\173\237\149\156 panel\236\157\152 \236\130\172\236\157\180\236\166\136\234\176\128 0\236\158\133\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
    return
  end
  if mousePosX < panelPosX then
    relativePosX = 0
  elseif mousePosX > panelPosX + panelSizeX then
    relativePosX = panelSizeX
  else
    relativePosX = mousePosX - panelPosX
  end
  if mousePosY < panelPosY then
    relativePosY = 0
  elseif mousePosY > panelPosY + panelSizeY then
    relativePosY = panelSizeY
  else
    relativePosY = mousePosY - panelPosY
  end
  if self._palettePanelType.hueSaturation == panelType then
    self._colorValue.hue = self:mousePositionToHsl(self._hslType.hue, relativePosX / panelSizeX)
    self._colorValue.saturation = self:mousePositionToHsl(self._hslType.saturation, 1 - relativePosY / panelSizeY)
  elseif self._palettePanelType.lightness == panelType or self._palettePanelType.lightnessSlider == panelType then
    self._colorValue.lightness = self:mousePositionToHsl(self._hslType.lightness, 1 - relativePosY / panelSizeY)
  end
  self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
  if self._pressCount < self._config.pressUpdateFrequency then
    self._pressCount = self._pressCount + 1
  else
    self:applyColorToTarget()
    self._pressCount = 0
  end
  self:update()
end
function PaGlobal_ColorPalette_All:applyColorToTarget()
  if self._colorValue.lastAppliedHue == self._colorValue.hue and self._colorValue.lastAppliedSaturation == self._colorValue.saturation and self._colorValue.lastAppliedLightness == self._colorValue.lightness and false == self._isSlotChanged and false == self._isTypeChanged then
    return
  end
  self._isSlotChanged = false
  self._isTypeChanged = false
  self._colorValue.lastAppliedHue = self._colorValue.hue
  self._colorValue.lastAppliedSaturation = self._colorValue.saturation
  self._colorValue.lastAppliedLightness = self._colorValue.lightness
  if __eRGBPaletteTypeCustomization == self._openType then
    self:setColorToCharacter()
  elseif __eRGBPaletteTypeItem == self._openType then
    self:setColorToItem()
  end
end
function PaGlobal_ColorPalette_All:hslToRgb(hue, saturation, lightness)
  _PA_ASSERT_NAME(hue >= 0 and hue <= __eRgbColorLimitationHSLRange, "hue " .. hue .. " \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(saturation >= 0 and saturation <= __eRgbColorLimitationHSLRange, "saturation" .. saturation .. "  \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(lightness >= 0 and lightness <= __eRgbColorLimitationHSLRange, "lightness" .. lightness .. "  \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  local hsl = self:byte3ToDword(hue, saturation, lightness)
  local rgb = ToClient_requestConvertHslToRgb(hsl)
  local red, green, blue = self:dwordToByte3(rgb)
  if nil == red then
    _PA_ASSERT_NAME(false, "\237\129\180\235\157\188\235\161\156\235\182\128\237\132\176 \236\152\168 hsl \236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. \236\157\188\235\139\168 0, 0, 0\236\157\132 \235\176\152\237\153\152\237\149\169\235\139\136\235\139\164.", "\237\148\132\235\161\156\234\183\184\235\158\168 1\237\140\128 / \234\185\128\237\152\132\235\185\136")
    return 0, 0, 0
  end
  return red, green, blue
end
function PaGlobal_ColorPalette_All:panelReleased(panelType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._isPanelPressed then
    return
  end
  if __eRGBPaletteTypeCustomization == self._openType then
    self:addDecorationHistory()
  end
  local targetPanel
  if self._palettePanelType.hueSaturation == panelType then
    self._ui.stc_palette:SetEnableArea(0, 0, self._ui.stc_palette:GetSizeX(), self._ui.stc_palette:GetSizeY())
  elseif self._palettePanelType.lightness == panelType then
    self._ui.stc_bright:SetEnableArea(0, 0, self._ui.stc_bright:GetSizeX(), self._ui.stc_bright:GetSizeY())
  elseif self._palettePanelType.lightnessSlider == panelType then
    self._ui.stc_brightSlider:SetEnableArea(0, 0, self._ui.stc_brightSlider:GetSizeX(), self._ui.stc_brightSlider:GetSizeY())
  end
  self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
  self:applyColorToTarget()
  self:update()
  self._isPanelPressed = false
  self._pressCount = 0
  self._ui.stc_palette:setOnMouseCursorType(__eMouseCursorType_Default)
end
function PaGlobal_ColorPalette_All:rgbToHsl(red, green, blue)
  _PA_ASSERT_NAME(red >= 0 and red <= 255, "red " .. red .. "\236\157\152 \235\178\148\236\156\132\235\138\148 [0, 255] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(green >= 0 and green <= 255, "green " .. green .. "\236\157\152 \235\178\148\236\156\132\235\138\148 [0, 255] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(blue >= 0 and blue <= 255, "blue " .. blue .. "\236\157\152 \235\178\148\236\156\132\235\138\148 [0, 255] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  local rgb = self:byte3ToDword(red, green, blue)
  local hsl = ToClient_requestConvertRgbToHsl(rgb)
  local validationCheck = false
  if nil == self._callerInfo.paramIndex then
    validationCheck = ToClient_IsHslValidRangeCheck(self._openType, -1, hsl)
  else
    validationCheck = ToClient_IsHslValidRangeCheck(self._openType, self._callerInfo.paramIndex, hsl)
  end
  local hue, saturation, lightness = self:dwordToByte3(hsl)
  if nil == hue then
    _PA_ASSERT_NAME(false, "\237\129\180\235\157\188\235\161\156\235\182\128\237\132\176 \236\152\168 hsl \236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\237\148\132\235\161\156\234\183\184\235\158\168 1\237\140\128 / \234\185\128\237\152\132\235\185\136")
    return
  end
  if false == validationCheck then
    hue, saturation, lightness = self:resetHslToValidInformation(hue, saturation, lightness)
    local copyRed, copyGreen, copyBlue = self:hslToRgb(hue, saturation, lightness)
    if red ~= copyRed or green ~= copyGreen or blue ~= copyBlue then
      return -1, -1, -1
    end
  end
  _PA_ASSERT_NAME(hue >= 0 and hue <= __eRgbColorLimitationHSLRange, "hue " .. hue .. " \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(saturation >= 0 and saturation <= __eRgbColorLimitationHSLRange, "saturation" .. saturation .. "  \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  _PA_ASSERT_NAME(lightness >= 0 and lightness <= __eRgbColorLimitationHSLRange, "lightness" .. lightness .. "  \236\157\152 \235\178\148\236\156\132\235\138\148 [0, " .. __eRgbColorLimitationHSLRange .. "] \236\157\180\236\151\172\236\149\188\237\149\169\235\139\136\235\139\164.", "\234\185\128\237\152\132\235\185\136")
  return hue, saturation, lightness
end
function PaGlobal_ColorPalette_All:round(number)
  return math.floor(number + 0.5)
end
function PaGlobal_ColorPalette_All:byte3ToDword(param1, param2, param3)
  local dword = 255
  dword = dword * 256
  dword = dword + param1
  dword = dword * 256
  dword = dword + param2
  dword = dword * 256
  dword = dword + param3
  return dword
end
function PaGlobal_ColorPalette_All:dwordToByte3(dword)
  local param3 = dword % 256
  dword = (dword - param3) / 256
  local param2 = dword % 256
  dword = (dword - param2) / 256
  local param1 = dword % 256
  dword = (dword - param1) / 256
  local validProof = dword % 256
  if 255 ~= validProof then
    return nil, nil, nil
  end
  return param1, param2, param3
end
function PaGlobal_ColorPalette_All:SetHslInfo(colorType, hslInfo)
  local hue, saturation, lightness = self:dwordToByte3(hslInfo)
  if nil == hue then
    return false
  end
  if 0 == colorType then
    return false
  end
  self._isSlotChanged = true
  self._colorValue.paletteType = colorType
  self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = hue, saturation, lightness
  self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
  self:update()
  return true
end
function PaGlobal_ColorPalette_All:getRGBToolTip()
  return PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COLORPALETTE_RGB_TOOLTIP", "red", self._colorValue.red, "green", self._colorValue.green, "blue", self._colorValue.blue)
end
function PaGlobal_ColorPalette_All:editBoxChanged(colorType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if PaGlobal_ColorPalette_All._rgbType.red == colorType then
    self._colorValue.red = self:overflowCheck(tonumber(self._ui.edit_numberR:GetEditText()))
  elseif PaGlobal_ColorPalette_All._rgbType.green == colorType then
    self._colorValue.green = self:overflowCheck(tonumber(self._ui.edit_numberG:GetEditText()))
  else
    self._colorValue.blue = self:overflowCheck(tonumber(self._ui.edit_numberB:GetEditText()))
  end
  self:update()
end
function PaGlobal_ColorPalette_All:editBoxFocused(colorType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  self._focusedEditControlIdx = colorType
end
function PaGlobal_ColorPalette_All:overflowCheck(number)
  if nil == number or number < 0 then
    return 0
  elseif number > 255 then
    return 255
  else
    return number
  end
end
function PaGlobal_ColorPalette_All:setDecorationPart(classType, paramType, paramIndex)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._initialize then
    return
  end
  if __eRGBPaletteTypeCustomization ~= self._openType then
    return
  end
  if nil == self._lastAppliedColorPerPartList[paramIndex] then
    local partInformation = {}
    partInformation[self._hslType.hue] = self._config.notUsedYet
    partInformation[self._hslType.saturation] = self._config.notUsedYet
    partInformation[self._hslType.lightness] = self._config.notUsedYet
    self._lastAppliedColorPerPartList[paramIndex] = partInformation
  end
  self._callerInfo.classType = classType
  self._callerInfo.paramType = paramType
  self._callerInfo.paramIndex = paramIndex
end
function PaGlobal_ColorPalette_All:setPaletteType(paletteType)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if self._colorValue.paletteType ~= paletteType then
    self._colorValue.paletteType = paletteType
    self._isTypeChanged = true
    self:applyColorToTarget()
  end
end
function PaGlobal_ColorPalette_All:checkHSLInfoDifferentWithLastHistory()
  if nil == Panel_Window_ColorPalette_All then
    return false
  end
  if nil == self._callerInfo.paramIndex then
    return false
  end
  if __eRGBPaletteTypeCustomization ~= self._openType then
    return
  end
  if self._colorValue.hue ~= self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.hue] or self._colorValue.saturation ~= self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.saturation] or self._colorValue.lightness ~= self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.lightness] then
    self._isColorChanged = true
  else
    self._isColorChanged = false
  end
  return self._isColorChanged
end
function PaGlobal_ColorPalette_All:setColorToCharacter()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if __eRGBPaletteTypeCustomization ~= self._openType then
    return
  end
  if nil == setParamByHSL then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  if false == self:isHslInfoValid(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness) then
    return
  end
  local hsl = self:byte3ToDword(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
  setParamByHSL(self._callerInfo.classType, self._callerInfo.paramType, self._callerInfo.paramIndex, hsl)
end
function PaGlobal_ColorPalette_All:setColorToItem()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if __eRGBPaletteTypeItem ~= self._openType then
    return
  end
  if false == _ContentsGroup_RgbUIPickForItem then
    return
  end
  if true == _ContentsGroup_NewUI_Dye_All then
    if nil == PaGlobal_Dye_SelectColor_Renew then
      return
    end
    PaGlobal_Dye_SelectColor_Renew(self._colorValue.paletteType, self:byte3ToDword(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness), PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COLORPALETTE_RGB_TOOLTIP", "red", self._colorValue.red, "green", self._colorValue.green, "blue", self._colorValue.blue))
  else
    if nil == PaGlobal_DeyReNew_Palette_SelectColor_Renew then
      return
    end
    PaGlobal_DeyReNew_Palette_SelectColor_Renew(self._colorValue.paletteType, self:byte3ToDword(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness))
  end
end
function PaGlobal_ColorPalette_All:isHslInfoValid(hue, saturation, lightness)
  if nil == Panel_Window_ColorPalette_All then
    return false
  end
  if nil == self._openType then
    return false
  end
  local hsl = self:byte3ToDword(hue, saturation, lightness)
  if __eRGBPaletteTypeCustomization == self._openType then
    if nil == self._callerInfo.paramIndex then
      return
    end
    return ToClient_IsHslValidRangeCheck(self._openType, self._callerInfo.paramIndex, hsl)
  elseif __eRGBPaletteTypeItem == self._openType then
    return ToClient_IsHslValidRangeCheck(self._openType, -1, hsl)
  end
end
function PaGlobal_ColorPalette_All:addDecorationHistory()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == add_CurrentHistory then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  if __eRGBPaletteTypeCustomization ~= self._openType then
    return
  end
  if false == self:checkHSLInfoDifferentWithLastHistory() then
    return
  end
  self._isColorChanged = false
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.hue] = self._colorValue.hue
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.saturation] = self._colorValue.saturation
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.lightness] = self._colorValue.lightness
  add_CurrentHistory()
end
function PaGlobal_ColorPalette_All:resetHslToValidInformation(hue, saturation, lightness)
  if hue > __eRgbColorLimitationHSLRange then
    hue = __eRgbColorLimitationHSLRange
  elseif hue < 0 then
    hue = 0
  end
  if saturation > __eRgbColorLimitationHSLRange then
    saturation = __eRgbColorLimitationHSLRange
  elseif saturation < 0 then
    saturation = 0
  end
  if lightness > __eRgbColorLimitationHSLRange then
    lightness = __eRgbColorLimitationHSLRange
  elseif lightness < 0 then
    lightness = 0
  end
  if __eRGBPaletteTypeCustomization == self._openType then
    if saturation > __eRgbColorLimitationMaxSaturation then
      saturation = __eRgbColorLimitationMaxSaturation
    end
  elseif __eRGBPaletteTypeitem == self._openType then
  end
  return hue, saturation, lightness
end
function PaGlobal_ColorPalette_All:lastAppliedRGBInformationClear()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  self._isColorChanged = false
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.hue] = self._config.notUsedYet
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.saturation] = self._config.notUsedYet
  self._lastAppliedColorPerPartList[self._callerInfo.paramIndex][self._hslType.lightness] = self._config.notUsedYet
end
function PaGlobal_ColorPalette_All:applyEditBoxRGBToTarget()
  ClearFocusEdit()
  self._focusedEditControlIdx = self._focusedEditControlIdx - 1
  hue, saturation, lightness = self:rgbToHsl(self._colorValue.red, self._colorValue.green, self._colorValue.blue)
  if -1 == hue and -1 == saturation and -1 == lightness then
    local applyLimitationCallBack = function()
      local self = PaGlobal_ColorPalette_All
      self:applyLimitationToColorInformation()
    end
    self:notifyErrorMessage(applyLimitationCallBack)
    return
  elseif nil == hue then
    return
  end
  self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = hue, saturation, lightness
  if __eRGBPaletteTypeCustomization == self._openType then
    red, green, blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
    self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = hue, saturation, lightness
    if true == PaGlobal_ColorPalette_All:checkHSLInfoDifferentWithLastHistory() then
      PaGlobal_ColorPalette_All:applyColorToTarget()
      PaGlobal_ColorPalette_All:addDecorationHistory()
    end
  elseif __eRGBPaletteTypeItem == self._openType then
    self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = hue, saturation, lightness
    PaGlobal_ColorPalette_All:applyColorToTarget()
  end
  self:update()
end
function PaGlobal_ColorPalette_All:notifyErrorMessage(func)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local contentText = PAGetString(Defines.StringSheet_GAME, "LUA_COLORPALETTE_INVALID_AREA")
  local messageBoxData = {
    title = titleText,
    content = contentText,
    functionApply = func,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ColorPalette_All:applyLimitationToColorInformation()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  local rgb = self:byte3ToDword(self._colorValue.red, self._colorValue.green, self._colorValue.blue)
  local hsl = ToClient_requestConvertRgbToHsl(rgb)
  local hue, saturation, lightness = self:dwordToByte3(hsl)
  if nil == hue then
    _PA_ASSERT_NAME(false, "\237\129\180\235\157\188\235\161\156\235\182\128\237\132\176 \236\152\168 hsl \236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\237\148\132\235\161\156\234\183\184\235\158\168 1\237\140\128 / \234\185\128\237\152\132\235\185\136")
    return
  end
  self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = self:resetHslToValidInformation(hue, saturation, lightness)
  self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
  if __eRGBPaletteTypeCustomization == self._openType then
    if true == PaGlobal_ColorPalette_All:checkHSLInfoDifferentWithLastHistory() then
      PaGlobal_ColorPalette_All:applyColorToTarget()
      PaGlobal_ColorPalette_All:addDecorationHistory()
    end
  elseif __eRGBPaletteTypeItem == self._openType then
    PaGlobal_ColorPalette_All:applyColorToTarget()
  end
  self:update()
end
function PaGlobal_ColorPalette_All:colorHistoryApplied(paramIndex, colorInfo)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if nil == self._callerInfo.paramIndex then
    return
  end
  if __eRGBPaletteTypeCustomization ~= self._openType then
    return
  end
  if nil == paramIndex then
    return
  end
  local hue, saturation, lightness = self:dwordToByte3(colorInfo)
  if nil == hue then
    return
  end
  self._isColorChanged = false
  self._lastAppliedColorPerPartList[paramIndex][self._hslType.hue] = hue
  self._lastAppliedColorPerPartList[paramIndex][self._hslType.saturation] = saturation
  self._lastAppliedColorPerPartList[paramIndex][self._hslType.lightness] = lightness
  if paramIndex == self._callerInfo.paramIndex then
    self._colorValue.hue = hue
    self._colorValue.saturation = saturation
    self._colorValue.lightness = lightness
    self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
    self:update()
  end
end
function PaGlobal_ColorPalette_All:hslToMousePosition(hslType, hslValue)
  local mousePosition = 0
  if __eRGBPaletteTypeCustomization == self._openType then
    if self._hslType.hue == hslType then
      mousePosition = (hslValue - __eRgbColorLimitationMinHue) / (__eRgbColorLimitationMaxHue - __eRgbColorLimitationMinHue)
    elseif self._hslType.saturation == hslType then
      mousePosition = (hslValue - __eRgbColorLimitationMinSaturation) / (__eRgbColorLimitationMaxSaturation - __eRgbColorLimitationMinSaturation)
    else
      mousePosition = (hslValue - __eRgbColorLimitationMinLightness) / (__eRgbColorLimitationMaxLightness - __eRgbColorLimitationMinLightness)
    end
  elseif __eRGBPaletteTypeItem == self._openType then
    mousePosition = hslValue / __eRgbColorLimitationHSLRange
  end
  return mousePosition
end
function PaGlobal_ColorPalette_All:mousePositionToHsl(hslType, mousePosition)
  local actualValue = 0
  if __eRGBPaletteTypeCustomization == self._openType then
    if self._hslType.hue == hslType then
      actualValue = (__eRgbColorLimitationMaxHue - __eRgbColorLimitationMinHue) * mousePosition + __eRgbColorLimitationMinHue
    elseif self._hslType.saturation == hslType then
      actualValue = (__eRgbColorLimitationMaxSaturation - __eRgbColorLimitationMinSaturation) * mousePosition + __eRgbColorLimitationMinSaturation
    else
      actualValue = (__eRgbColorLimitationMaxLightness - __eRgbColorLimitationMinLightness) * mousePosition + __eRgbColorLimitationMinLightness
    end
  elseif __eRGBPaletteTypeItem == self._openType then
    actualValue = mousePosition * __eRgbColorLimitationHSLRange
  end
  return self:round(actualValue)
end
function PaGlobal_ColorPalette_All:resizePanel()
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if false == self._initialize then
    return
  end
  if self._config.lightnessLevelCount < 1 then
    return
  end
  Panel_Window_ColorPalette_All:ComputePos()
  local lightnessLevelYSize = self._ui.stc_bright:GetSizeY() / self._config.lightnessLevelCount
  for index = 0, self._config.lightnessLevelCount - 1 do
    self._ui.lightnessLevel[index]:SetPosX(self._ui.stc_bright:GetPosX())
    self._ui.lightnessLevel[index]:SetPosY(self._ui.stc_bright:GetPosY() + lightnessLevelYSize * index)
    self._ui.lightnessLevel[index]:SetSize(self._ui.stc_bright:GetSizeX(), lightnessLevelYSize)
  end
end
function PaGlobal_ColorPalette_All:clickedSlotChanged()
  self._isSlotChanged = true
end
function PaGlobal_ColorPalette_All:clearLastCachedValue()
  self._colorValue.lastAppliedHue = -1
  self._colorValue.lastAppliedSaturation = -1
  self._colorValue.lastAppliedLightness = -1
end
function PaGlobal_ColorPalette_All:saveColorPreset()
  local rgbInfo = self:byte3ToDword(self._colorValue.red, self._colorValue.green, self._colorValue.blue)
  local hslInfo = ToClient_requestConvertRgbToHsl(rgbInfo)
  if false == ToClient_setColorPresetInformation(self._targetPresetSlot - 1, hslInfo) then
    _PA_ASSERT_NAME(false, "\236\131\137\236\131\129 \237\148\132\235\166\172\236\133\139 \236\160\128\236\158\165 \236\139\164\237\140\168", "\234\185\128\237\152\132\235\185\136")
  else
    self._ui.radiobtn_colorPresetList[self._targetPresetSlot]:SetColor(rgbInfo)
    local xImage = UI.getChildControl(self._ui.radiobtn_colorPresetList[self._targetPresetSlot], "Static_XMark")
    xImage:SetShow(false)
  end
end
function PaGlobal_ColorPalette_All:loadColorPreset(index)
  self._ui.stc_selectedBorderUIList[self._targetPresetSlot]:SetShow(false)
  self._targetPresetSlot = index
  local hslInfo = ToClient_getColorPresetInformation(index - 1)
  local hue, saturation, lightness = self:dwordToByte3(hslInfo)
  if nil == hue then
    return
  end
  local validationCheck = false
  if __eRGBPaletteTypeItem == self._openType then
    validationCheck = ToClient_IsHslValidRangeCheck(self._openType, -1, hslInfo)
  elseif __eRGBPaletteTypeCustomization == self._openType then
    validationCheck = ToClient_IsHslValidRangeCheck(self._openType, self._callerInfo.paramIndex, hslInfo)
  end
  local function loadColorPresetCallBack()
    local self = PaGlobal_ColorPalette_All
    self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness = self:resetHslToValidInformation(hue, saturation, lightness)
    self._colorValue.red, self._colorValue.green, self._colorValue.blue = self:hslToRgb(self._colorValue.hue, self._colorValue.saturation, self._colorValue.lightness)
    self:update()
  end
  if false == validationCheck then
    self:notifyErrorMessage(loadColorPresetCallBack)
    return
  end
  loadColorPresetCallBack()
end
function PaGlobal_ColorPalette_All:colorPresetFocused(index)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if index < 1 or index > __eColorPalettePresetCount then
    return
  end
  self._ui.stc_selectedBorderUIList[index]:SetShow(true)
end
function PaGlobal_ColorPalette_All:colorPresetUnFocused(index)
  if nil == Panel_Window_ColorPalette_All then
    return
  end
  if index < 1 or index > __eColorPalettePresetCount then
    return
  end
  if index ~= self._targetPresetSlot then
    self._ui.stc_selectedBorderUIList[index]:SetShow(false)
  end
end
