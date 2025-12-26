function PaGlobal_GameModeSettingNotice_All:initialize()
  if true == PaGlobal_GameModeSettingNotice_All._initialize or nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  self._ui.btn_close = UI.getChildControl(Panel_Window_GameModeSettingNotice_All, "Button_Close")
  self._ui.stc_changeBg = UI.getChildControl(Panel_Window_GameModeSettingNotice_All, "Static_Change_BG")
  self._ui.txt_changeMain = UI.getChildControl(self._ui.stc_changeBg, "StaticText_Main_Message")
  self._ui.txt_changeDesc = UI.getChildControl(self._ui.stc_changeBg, "StaticText_Desc")
  self._ui.txt_changeRemasterDesc = UI.getChildControl(self._ui.stc_changeBg, "StaticText_RemasterMode")
  self._ui.stc_subBg = UI.getChildControl(Panel_Window_GameModeSettingNotice_All, "Static_Sub_BG")
  self._ui.stc_textureBg = UI.getChildControl(self._ui.stc_subBg, "Static_Texture")
  self._ui.stc_screenBg = UI.getChildControl(self._ui.stc_subBg, "Static_Screen")
  self._ui.stc_AntiAliBg = UI.getChildControl(self._ui.stc_subBg, "Static_AntiAli")
  for ii = 0, self._textureGaugeCount - 1 do
    self._ui.stc_textureGauges[ii] = {}
    self._ui.stc_textureGauges[ii].main = UI.getChildControl(self._ui.stc_textureBg, "Static_GaugeBar_" .. tostring(ii + 1))
    self._ui.stc_textureGauges[ii].on = UI.getChildControl(self._ui.stc_textureGauges[ii].main, "Static_1")
    self._ui.stc_textureGauges[ii].text = UI.getChildControl(self._ui.stc_textureGauges[ii].main, "StaticText_1")
  end
  for ii = 0, self._screenGaugeCount - 1 do
    self._ui.stc_screenGauges[ii] = {}
    self._ui.stc_screenGauges[ii].main = UI.getChildControl(self._ui.stc_screenBg, "Static_GaugeBar_" .. tostring(ii + 1))
    self._ui.stc_screenGauges[ii].on = UI.getChildControl(self._ui.stc_screenGauges[ii].main, "Static_1")
    self._ui.stc_screenGauges[ii].text = UI.getChildControl(self._ui.stc_screenGauges[ii].main, "MultilineText_1")
  end
  self._ui.stc_antiGauges[0] = {}
  self._ui.stc_antiGauges[0].main = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_UnApply")
  self._ui.stc_antiGauges[0].on = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_UnApply_On")
  self._ui.stc_antiGauges[1] = {}
  self._ui.stc_antiGauges[1].main = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_Fxaa")
  self._ui.stc_antiGauges[1].on = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_Fxaa_On")
  self._ui.stc_antiGauges[2] = {}
  self._ui.stc_antiGauges[2].main = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_Taa")
  self._ui.stc_antiGauges[2].on = UI.getChildControl(self._ui.stc_AntiAliBg, "StaticText_Taa_On")
  self._ui.btn_apply = UI.getChildControl(Panel_Window_GameModeSettingNotice_All, "Button_Apply")
  self._ui.stc_consoleGuideBg = UI.getChildControl(Panel_Window_GameModeSettingNotice_All, "Static_KeyGuide_ConsoleUI")
  self._isUsePadSnapping = _ContentsGroup_UsePadSnapping
  PaGlobal_GameModeSettingNotice_All:validate()
  PaGlobal_GameModeSettingNotice_All:registEventHandler()
  PaGlobal_GameModeSettingNotice_All:swichPlatform(self._isUsePadSnapping)
  PaGlobal_GameModeSettingNotice_All._initialize = true
end
function PaGlobal_GameModeSettingNotice_All:swichPlatform(isConsole)
  if true == isConsole then
    self._ui.stc_consoleGuideBg:SetShow(true)
    self._ui.btn_apply:SetShow(false)
    self._ui.btn_close:SetShow(false)
    local consoleGuideA = UI.getChildControl(self._ui.stc_consoleGuideBg, "StaticText_A_ConsoleUI")
    local consoleGuideB = UI.getChildControl(self._ui.stc_consoleGuideBg, "StaticText_B_ConsoleUI")
    local tempBtnGroup = {consoleGuideA, consoleGuideB}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_consoleGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui.stc_consoleGuideBg:SetShow(false)
    self._ui.btn_apply:SetShow(true)
    self._ui.btn_close:SetShow(true)
  end
end
function PaGlobal_GameModeSettingNotice_All:prepareOpen()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  if nil == self._selectSpecType then
    return
  end
  self._specSettingOption = PaGlobal_GameOption_All_GetSpecSetting(self._selectSpecType)
  if nil == self._specSettingOption then
    return
  end
  PaGlobal_GameModeSettingNotice_All:open()
  PaGlobal_GameModeSettingNotice_All:update()
  PaGlobal_GameModeSettingNotice_All:resize()
end
function PaGlobal_GameModeSettingNotice_All:dataclear()
end
function PaGlobal_GameModeSettingNotice_All:open()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  Panel_Window_GameModeSettingNotice_All:SetShow(true)
end
function PaGlobal_GameModeSettingNotice_All:prepareClose()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  PaGlobal_GameModeSettingNotice_All:close()
end
function PaGlobal_GameModeSettingNotice_All:close()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  Panel_Window_GameModeSettingNotice_All:SetShow(false)
end
function PaGlobal_GameModeSettingNotice_All:update()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  self:updateChangeDesc()
  self:updateTextureSet()
  self:updateGraphicSet()
  self:updateAntiAliSet()
end
function PaGlobal_GameModeSettingNotice_All:updateChangeDesc()
  local specName = PaGlobal_GameOption_All_GetHomeSpecName(self._selectSpecType)
  self._ui.txt_changeMain:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEMODESETTING_NOTICE_TITLE", "mode", specName))
end
function PaGlobal_GameModeSettingNotice_All:updateTextureSet()
  if nil == self._specSettingOption then
    return
  end
  local textureSet = self._specSettingOption.TextureQuality
  for ii = 0, self._textureGaugeCount - 1 do
    self._ui.stc_textureGauges[ii].text:SetFontColor(Defines.Color.C_FF6C6C6C)
    if ii <= textureSet then
      self._ui.stc_textureGauges[ii].on:SetShow(true)
      if ii == textureSet then
        self._ui.stc_textureGauges[ii].text:SetFontColor(Defines.Color.C_FFFFEDD4)
      end
    else
      self._ui.stc_textureGauges[ii].on:SetShow(false)
    end
  end
end
function PaGlobal_GameModeSettingNotice_All:updateGraphicSet()
  if nil == self._specSettingOption then
    return
  end
  local graphicSet = self._specSettingOption.GraphicOption
  if graphicSet >= 6 then
    if 6 == graphicSet then
      graphicSet = -1
    else
      graphicSet = graphicSet - 1
      self._ui.txt_changeRemasterDesc:SetShow(true)
    end
  else
    self._ui.txt_changeRemasterDesc:SetShow(false)
  end
  for ii = 0, self._screenGaugeCount - 1 do
    self._ui.stc_screenGauges[ii].text:SetFontColor(Defines.Color.C_FF6C6C6C)
    if ii <= graphicSet then
      self._ui.stc_screenGauges[ii].on:SetShow(true)
      if ii == graphicSet then
        self._ui.stc_screenGauges[ii].text:SetFontColor(Defines.Color.C_FFFFEDD4)
      end
    else
      self._ui.stc_screenGauges[ii].on:SetShow(false)
    end
  end
end
function PaGlobal_GameModeSettingNotice_All:updateAntiAliSet()
  if nil == self._specSettingOption then
    return
  end
  local isIncrease = self._specSettingOption.isIncrease
  local antiSet
  if true == isIncrease then
    antiSet = self._specSettingOption.AntiAliasing
  else
    antiSet = PaGlobal_GameOption_All:getOptionValue("AntiAliasing")
  end
  for ii = 0, self._antiGaugeCount - 1 do
    if ii == antiSet then
      self._ui.stc_antiGauges[ii].on:SetShow(true)
    else
      self._ui.stc_antiGauges[ii].on:SetShow(false)
    end
  end
end
function PaGlobal_GameModeSettingNotice_All:registEventHandler()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_GameModeSettingNotice_All_OnScreenResize()")
  if true == self._isUsePadSnapping then
    Panel_Window_GameModeSettingNotice_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GameModeSettingNotice_All_Confirm()")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_GameModeSettingNotice_All_Close()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_GameModeSettingNotice_All_Confirm()")
  end
end
function PaGlobal_GameModeSettingNotice_All:validate()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
end
function PaGlobal_GameModeSettingNotice_All:resize()
  if nil == Panel_Window_GameModeSettingNotice_All then
    return
  end
  Panel_Window_GameModeSettingNotice_All:ComputePos()
end
