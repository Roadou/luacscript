PaGlobal_GuildPointMenu_All = {
  _ui = {
    btn_Management = nil,
    btn_SendAll = nil,
    btn_Option = nil
  },
  _ui_pc = {btn_Close = nil},
  _ui_console = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointMenu_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointMenu_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildPointMenu_AllInit")
function FromClient_GuildPointMenu_AllInit()
  PaGlobal_GuildPointMenu_All:initialize()
end
