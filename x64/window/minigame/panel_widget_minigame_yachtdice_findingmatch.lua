PaGlobal_YachtDice_FindingMatch = {
  _ui = {
    _stc_matchingBg = nil,
    _txt_matchingState = nil,
    _btn_cancel = nil,
    _txt_matchingElapsedTime = nil
  },
  _currentElapsedTime = 0,
  _currentDeltaTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_YachtDice_FindingMatch_Init")
function FromClient_YachtDice_FindingMatch_Init()
  PaGlobal_YachtDice_FindingMatch:initialize()
end
