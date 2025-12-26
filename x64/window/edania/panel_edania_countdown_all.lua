PaGlobal_EdaniaCountDown = {
  _ui = {
    _stc_CountDown = Array.new()
  },
  _remainTimeDelta = nil,
  _remainTimeSecond = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Edania/Panel_Edania_CountDown_All_1.lua")
runLua("UI_Data/Script/Window/Edania/Panel_Edania_CountDown_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EdaniaCountDownInit")
function FromClient_EdaniaCountDownInit()
  PaGlobal_EdaniaCountDown:initialize()
end
