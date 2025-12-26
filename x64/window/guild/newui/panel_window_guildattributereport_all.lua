PaGlobal_GuildAttributeReport_All = {
  _ui = {
    stc_GuildMark = nil,
    txt_Title = nil,
    txt_Date = nil,
    leftCount = nil,
    btn_Option = {},
    btn_Confirm = nil,
    btn_Refuse = nil
  },
  _ui_pc = {},
  _ui_console = {},
  _selectIndex = nil,
  _isSendAll = false,
  _selectOption = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildAttributeReport_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildAttributeReport_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAttributeReportAllInit")
function FromClient_GuildAttributeReportAllInit()
  PaGlobal_GuildAttributeReport_All:initialize()
end
