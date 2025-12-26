PaGlobal_EnterSceneEffect = {
  _ui = {_stc_effect = nil},
  _accTimeSec = 0,
  _hideTimeSec = 10,
  _isUseFadeAni = false,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_EnterSceneEffect_1.lua")
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_EnterSceneEffect_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnterSceneEffectInit")
function FromClient_EnterSceneEffectInit()
  PaGlobal_EnterSceneEffect:initialize()
end
