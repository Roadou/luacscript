PaGlobal_HorseSubMp_All = {
  _ui = {_stc_gaugeProgress = nil, _txt_gauge = nil},
  _vehicleActorKey = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_HorseSubMp_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_HorseSubMp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseSubMp_All_Init")
function FromClient_HorseSubMp_All_Init()
  PaGlobal_HorseSubMp_All:initialize()
end
