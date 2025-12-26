PaGlobal_StartBranch_All = {
  _ui = {
    _btn_SelectBranch = nil,
    _btn_Cancel = nil,
    _stc_blockBg = nil,
    _btn_Radio = {},
    _stc_update = {},
    _stc_point = {}
  },
  _ui_console = {
    _btn_SelectBranch = nil,
    _btn_Cancel = nil,
    _stc_LB = nil,
    _stc_RB = nil,
    _stc_update = {},
    _stc_point = {}
  },
  _originalSelectButton_PC_spanX = 0,
  _originalSelectButton_Console_spanX = 0,
  _branchListInfo = {},
  _MAX_RADIO_COUNT = 3,
  _selectTab = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_StartBranch_All_Init")
function FromClient_StartBranch_All_Init()
  PaGlobal_StartBranch_All:initialize()
end
FromClient_StartBranch_All_Init()
