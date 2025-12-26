PaGlobal_GuildActivityFunds_Option_All = {
  _ui = {
    txt_Fund = nil,
    edit_Point = {},
    edit_Fund = {},
    edit_PointConsole = {},
    edit_FundConsole = {},
    btn_UnLimit = {}
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
  _settingList = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_Option_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_Option_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildActivityFunds_Option_AllInit")
function FromClient_GuildActivityFunds_Option_AllInit()
  PaGlobal_GuildActivityFunds_Option_All:initialize()
end
