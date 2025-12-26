PaGlobal_GameModeSettingNotice_All = {
  _ui = {
    btn_close = nil,
    stc_changeBg = nil,
    txt_changeMain = nil,
    txt_changeDesc = nil,
    txt_changeRemasterDesc = nil,
    stc_subBg = nil,
    stc_textureBg = nil,
    stc_screenBg = nil,
    stc_AntiAliBg = nil,
    stc_textureGauges = {},
    stc_screenGauges = {},
    stc_antiGauges = {},
    btn_apply = nil,
    stc_consoleGuideBg = nil
  },
  _selectSpecType = nil,
  _specSettingOption = nil,
  _textureGaugeCount = 3,
  _screenGaugeCount = 7,
  _antiGaugeCount = 3,
  _isUsePadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameModeSettingNotice_All_1.lua")
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameModeSettingNotice_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GameModeSettingNotice_Init")
function FromClient_GameModeSettingNotice_Init()
  PaGlobal_GameModeSettingNotice_All:initialize()
end
