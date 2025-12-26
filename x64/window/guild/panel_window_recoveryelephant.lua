PaGlobal_RecoveryElephant = {
  _ui = {
    _stc_servantCountText = nil,
    _lst_servantList = nil,
    _stc_consoleKeyguidArea = nil,
    _stc_noServant = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_RecoveryElephant_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_RecoveryElephant_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RecoveryElephantInit")
function FromClient_RecoveryElephantInit()
  PaGlobal_RecoveryElephant:initialize()
end
