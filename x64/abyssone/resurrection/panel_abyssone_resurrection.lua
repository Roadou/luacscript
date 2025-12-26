PaGlobal_AbyssOneResurrection = {
  _ui = {
    _btn_retry = nil,
    _btn_returnMagnus = nil,
    _btn_exit = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Resurrection/Panel_AbyssOne_Resurrection_1.lua")
runLua("UI_Data/Script/AbyssOne/Resurrection/Panel_AbyssOne_Resurrection_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOneResurrectionInit")
function FromClient_AbyssOneResurrectionInit()
  PaGlobal_AbyssOneResurrection:initialize()
end
