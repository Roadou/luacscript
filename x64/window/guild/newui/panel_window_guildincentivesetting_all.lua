PaGlobal_GuildIncentiveSetting_All = {
  _ui = {
    txt_GuildFund = nil,
    txt_IncentiveFund = nil,
    edit_Fund = nil,
    btn_Fund = {},
    txt_Grade = {},
    txt_Fund = {},
    edit_Point = {},
    edit_PointConsole = {},
    btn_Confirm = nil,
    btn_Cancel = nil
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
  _selectPercent = 0,
  _editIndex = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildIncentiveSetting_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildIncentiveSetting_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIncentiveSetting_AllInit")
function FromClient_GuildIncentiveSetting_AllInit()
  PaGlobal_GuildIncentiveSetting_All:initialize()
end
