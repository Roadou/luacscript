PaGlobal_OceanSiegeReturnToSeaport = {
  _ui = {btn_return = nil},
  _initialize = false
}
runLua("UI_Data/Script/Widget/Siege/Panel_Widget_OceanSiege_ReturnToSeaport_1.lua")
runLua("UI_Data/Script/Widget/Siege/Panel_Widget_OceanSiege_ReturnToSeaport_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_OceanSiegeReturnToSeaportInit")
function FromClient_OceanSiegeReturnToSeaportInit()
  PaGlobal_OceanSiegeReturnToSeaport:initialize()
end
