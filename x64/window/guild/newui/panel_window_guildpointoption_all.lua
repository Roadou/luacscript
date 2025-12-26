PaGlobal_GuildPointOption_All = {
  _ui = {
    edit_Contents = {},
    edit_Point = {},
    edit_PointConsole = {}
  },
  _ui_pc = {
    btn_Close = nil,
    btn_Confirm = nil,
    btn_Cancel = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _editIndex = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointOption_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointOption_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildPointOption_AllInit")
function FromClient_GuildPointOption_AllInit()
  PaGlobal_GuildPointOption_All:initialize()
end
