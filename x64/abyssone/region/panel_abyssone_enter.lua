PaGlobal_EnterAbyssOne = {
  _ui = {
    _stc_mainBg = nil,
    _stc_regionName = nil,
    _stc_regionDesc = nil
  },
  _accDeltaTimeSec = 0,
  _hideTimeSec = 6,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_Enter_1.lua")
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_Enter_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnterAbyssOneInit")
function FromClient_EnterAbyssOneInit()
  PaGlobal_EnterAbyssOne:initialize()
end
