PaGlobal_GuildMatchCountDown = {
  _ui = {
    _stc_countDown = Array.new()
  },
  _remainTimeDelta = nil,
  _remainTimeSecond = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_CountDown_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_CountDown_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMatchCountDownInit")
function FromClient_GuildMatchCountDownInit()
  PaGlobal_GuildMatchCountDown:initialize()
end
