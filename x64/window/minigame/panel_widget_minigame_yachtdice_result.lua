PaGlobal_MiniGame_YachtDice_Result = {
  _ui = {
    _stc_MainBg = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Static_BG"),
    _stc_win = nil,
    _stc_lose = nil,
    _stc_tie = nil,
    _stc_reward = nil,
    _btn_exit = nil,
    _btn_retry = nil,
    _console_bg = nil
  },
  _hostPoint = 0,
  _acceptorPoint = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_YachtDice_Result_Init")
function FromClient_PaGlobal_MiniGame_YachtDice_Result_Init()
  PaGlobal_MiniGame_YachtDice_Result:initialize()
end
