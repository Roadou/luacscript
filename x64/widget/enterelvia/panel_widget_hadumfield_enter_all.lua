PaGlobal_Widget_HadumField_Enter_All = {
  _ui = {
    _stc_blackBG = nil,
    _stc_backGroundBG = nil,
    _stc_enterBG = nil,
    _stc_symbol = nil,
    _stc_line = nil,
    _txt_name = nil,
    _txt_desc = nil,
    _btn_enter = nil,
    _btn_exit = nil,
    _txt_keyGuideB = nil,
    _txt_keyGuideY = nil,
    _stc_enterEffect = nil
  },
  _curEffectTime = 0,
  _maxEffectTime = 3,
  _isShowEffect = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/EnterElvia/Panel_Widget_HadumField_Enter_All_1.lua")
runLua("UI_Data/Script/Widget/EnterElvia/Panel_Widget_HadumField_Enter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_HadumField_Enter_All_Init")
function FromClient_Widget_HadumField_Enter_All_Init()
  PaGlobal_Widget_HadumField_Enter_All:initialize()
end
