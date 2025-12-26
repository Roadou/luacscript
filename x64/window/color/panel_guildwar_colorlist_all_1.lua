function PaGlobal_GuildWarColorList_All:initialize()
  if PaGlobal_GuildWarColorList_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local staticMainTitle = UI.getChildControl(Panel_GuildWar_ColorList, "Static_Main_Title")
  self._ui._btn_close = UI.getChildControl(staticMainTitle, "Button_Close")
  self._ui._stc_mainBg = UI.getChildControl(Panel_GuildWar_ColorList, "Static_mainBg")
  local staticColorBg = UI.getChildControl(self._ui._stc_mainBg, "Static_Color_Bg")
  local staticBtnBg = UI.getChildControl(staticColorBg, "Static_Color")
  local colorButton = UI.getChildControl(staticColorBg, "RadioButton_ColorSelector")
  for index = 0, self._colorMaxIndex do
    local colorSelector = {btnBg, radioBtn}
    colorSelector.btnBg = UI.createControl(__ePAUIControl_Static, staticColorBg, "stc_Color_" .. index)
    colorSelector.radioBtn = UI.createControl(__ePAUIControl_RadioButton, staticColorBg, "RadioButton_ColorSelector_" .. index)
    CopyBaseProperty(staticBtnBg, colorSelector.btnBg)
    CopyBaseProperty(colorButton, colorSelector.radioBtn)
    colorSelector.btnBg:SetPosX(colorSelector.btnBg:GetPosX() + colorSelector.btnBg:GetSizeX() * (index % 10))
    colorSelector.btnBg:SetPosY(colorSelector.btnBg:GetPosY() + colorSelector.btnBg:GetSizeY() * math.floor(index / 10))
    colorSelector.btnBg:SetColor(self._colorValue[index])
    colorSelector.radioBtn:SetPosX(colorSelector.radioBtn:GetPosX() + colorSelector.radioBtn:GetSizeX() * (index % 10))
    colorSelector.radioBtn:SetPosY(colorSelector.radioBtn:GetPosY() + colorSelector.radioBtn:GetSizeY() * math.floor(index / 10))
    self._ui._btn_color_list[index] = colorSelector
  end
  self._ui._stc_ButtonBG = UI.getChildControl(self._ui._stc_mainBg, "Static_BTN_Bg")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_ButtonBG, "Button_Confirm")
  self._ui._btn_allSet = UI.getChildControl(self._ui._stc_ButtonBG, "Button_AllSet")
  self._ui._btn_cancel = UI.getChildControl(self._ui._stc_ButtonBG, "Button_Cancel")
  self._ui._btn_reset = UI.getChildControl(self._ui._stc_ButtonBG, "Button_Reset")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_GuildWar_ColorList, "Static_KeyGuide_Console")
  self._ui._txt_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_Console")
  self._ui._txt_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_Console")
  self._ui._txt_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_Console")
  self._ui._txt_keyGuide_LT_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LT_Y_Console")
  self._ui._txt_keyGuide_LT_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LT_X_Console")
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_GuildWarColorList_All:validate()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._stc_ButtonBG:isValidate()
  for index = 0, self._colorMaxIndex do
    self._ui._btn_color_list[index].btnBg:isValidate()
    self._ui._btn_color_list[index].radioBtn:isValidate()
  end
  self._ui._stc_ButtonBG:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_allSet:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_reset:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._txt_keyGuide_A:isValidate()
  self._ui._txt_keyGuide_B:isValidate()
  self._ui._txt_keyGuide_Y:isValidate()
  self._ui._txt_keyGuide_LT_Y:isValidate()
  self._ui._txt_keyGuide_LT_X:isValidate()
end
function PaGlobal_GuildWarColorList_All:registEventHandler()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildWarColorList_All_Resize")
  for index = 0, self._colorMaxIndex do
    self._ui._btn_color_list[index].radioBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColorList_All_SelectColor(" .. tostring(index) .. ")")
  end
  self._ui._stc_ButtonBG:SetShow(not self._isConsole)
  self._ui._stc_keyGuideBG:SetShow(self._isConsole)
  if self._isConsole == false then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarColorList_All_Close()")
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColorList_All_Confirm()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarColorList_All_Close()")
    self._ui._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColorList_All_Reset()")
    self._ui._btn_allSet:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColorList_All_SetAllGuildColor()")
  else
    Panel_GuildWar_ColorList:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildWarColorList_All_Confirm()")
    Panel_GuildWar_ColorList:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_GuildWarColorList_All_Reset()")
    Panel_GuildWar_ColorList:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_GuildWarColorList_All_SetAllGuildColor()")
  end
  self._panelBaseSizeY = Panel_GuildWar_ColorList:GetSizeY()
  self._mainBGBaseSizeY = self._ui._stc_mainBg:GetSizeY()
end
function PaGlobal_GuildWarColorList_All:setAlignKeyGuide()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local keyGuides = {
    self._ui._txt_keyGuide_Y,
    self._ui._txt_keyGuide_A,
    self._ui._txt_keyGuide_B,
    self._ui._txt_keyGuide_LT_Y,
    self._ui._txt_keyGuide_LT_X
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_GuildWarColorList_All:resize()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  if Panel_GuildWar_Color ~= nil then
    local gapX = 10
    Panel_GuildWar_ColorList:SetPosX(Panel_GuildWar_Color:GetPosX() + Panel_GuildWar_Color:GetSizeX() + gapX)
    Panel_GuildWar_ColorList:SetPosY(Panel_GuildWar_Color:GetPosY())
  end
  if self._isConsole == true then
    Panel_GuildWar_ColorList:SetSize(Panel_GuildWar_ColorList:GetSizeX(), self._panelBaseSizeY - self._ui._stc_ButtonBG:GetSizeY())
    self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBGBaseSizeY - self._ui._stc_ButtonBG:GetSizeY())
  else
    Panel_GuildWar_ColorList:SetSize(Panel_GuildWar_ColorList:GetSizeX(), self._panelBaseSizeY)
    self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBGBaseSizeY)
  end
  self:setAlignKeyGuide()
end
function PaGlobal_GuildWarColorList_All:prepareOpen()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  if _ContentsGroup_EditGuildColor == false then
    return
  end
  if Panel_GuildWar_Color == nil then
    return
  end
  self:resize()
  self._selectedColor = nil
  if PaGlobalFunc_GuildWarColor_All_GetSelectedColor ~= nil then
    local selectColor = PaGlobalFunc_GuildWarColor_All_GetSelectedColor()
    for index = 0, self._colorMaxIndex do
      if self._colorValue[index] ~= nil and self._ui._btn_color_list[index] ~= nil and self._ui._btn_color_list[index].radioBtn ~= nil then
        local isSelectColor = self._colorValue[index] == selectColor
        if isSelectColor == true then
          self._selectedColor = self._colorValue[index]
        end
        self._ui._btn_color_list[index].radioBtn:SetCheck(isSelectColor)
      end
    end
  end
  self:setAlignKeyGuide()
  self:open()
end
function PaGlobal_GuildWarColorList_All:open()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  Panel_GuildWar_ColorList:SetShow(true)
end
function PaGlobal_GuildWarColorList_All:prepareClose()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  self._selectedColor = nil
  self:close()
end
function PaGlobal_GuildWarColorList_All:close()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  Panel_GuildWar_ColorList:SetShow(false)
end
function PaGlobal_GuildWarColorList_All:confirmGuildColor()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  if self._selectedColor == nil or self._selectedColor == self._baseColor then
    return
  end
  if PaGlobalFunc_GuildWarColor_All_SetSelectGuildColor ~= nil then
    PaGlobalFunc_GuildWarColor_All_SetSelectGuildColor(self._selectedColor)
  end
end
function PaGlobal_GuildWarColorList_All:setAllGuildColor()
  if Panel_GuildWar_ColorList == nil then
    return
  end
  if self._selectedColor == nil or self._selectedColor == self._baseColor then
    return
  end
  if PaGlobalFunc_GuildWarColor_All_SetAllGuildColor ~= nil then
    PaGlobalFunc_GuildWarColor_All_SetAllGuildColor(self._selectedColor)
  end
end
function PaGlobal_GuildWarColorList_All:setSelectedIndex(index)
  if index == nil or self._colorValue[index] == nil then
    return
  end
  self._selectedColor = self._colorValue[index]
  if PaGlobalFunc_GuildWarColor_All_SetNameColor ~= nil then
    PaGlobalFunc_GuildWarColor_All_SetNameColor(self._selectedColor)
  end
end
