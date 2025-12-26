PaGlobal_RoseWarNakTeleport = {
  _ui = {
    _stc_normalBG = nil,
    _txt_normalTime = nil,
    _stc_vehicleBG = nil,
    _txt_vehicleTime = nil
  },
  _accumulatedDeltaTime = nil,
  _showTimeSec = nil,
  _remainTimeSec = nil,
  _targetFierceBattleKeyRaw = nil,
  _isVehicleMode = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_Teleport_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_Teleport_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarNakTeleportInit")
function FromClient_RoseWarNakTeleportInit()
  PaGlobal_RoseWarNakTeleport:initialize()
end
