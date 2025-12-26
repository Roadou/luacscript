PaGlobal_Common_CountDown = {
  _ui = {
    _stc_countDown = Array.new()
  },
  _getRemainTimeFunc = nil,
  _isCountDownEndFunc = nil,
  _remainTimeSecond = 0,
  _maxCountDown = 10,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Widget_Common_Countdown_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Widget_Common_Countdown_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Common_CountDown_Init")
function PaGlobal_Common_CountDown_Init()
  PaGlobal_Common_CountDown:initialize()
end
