PaGlobal_YachtDice_MatchConfirm = {
  _ui = {
    _txt_Confirm = nil,
    _stc_ProgressBar = nil,
    _stc_member = {}
  },
  _ui_pc = {_btn_Confrim = nil, _btn_Cancel = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _deltaTime = 0,
  _waitTimeSecond = 30,
  _isReq = false,
  _currentRemainTime = 0,
  _waitTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_YachtDice_MatchConfirm_Init")
function FromClient_YachtDice_MatchConfirm_Init()
  PaGlobal_YachtDice_MatchConfirm:initialize()
end
