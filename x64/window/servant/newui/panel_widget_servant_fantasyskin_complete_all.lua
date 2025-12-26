PaGlobal_CompleteChangeFormFantasyServant = {
  _ui = {_stc_horseEffectBg = nil, _stc_descBg = nil},
  _openParam = "",
  _currentServantNo = nil,
  _changeTargetFormIndexRaw = nil,
  _currentServantCharacterKeyRaw = nil,
  _isSuccessFlag = false,
  _state = 0,
  _accTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CompleteChangeFormFantasyServant")
function FromClient_CompleteChangeFormFantasyServant()
  PaGlobal_CompleteChangeFormFantasyServant:initialize()
end
