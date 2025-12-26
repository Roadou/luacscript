PaGlobal_Widget_HardCoreBlackField_Enter_All = {
  _ui = {_stc_blackBG = nil, _stc_enterEffect = nil},
  _curEffectTime = 0,
  _maxEffectTime = 3,
  _initialize = false
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter_All_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_HardCoreBlackField_Enter_All_Init")
function FromClient_Widget_HardCoreBlackField_Enter_All_Init()
  PaGlobal_Widget_HardCoreBlackField_Enter_All:initialize()
end
