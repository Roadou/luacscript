PaGlobal_RoseWarRegion = {
  _ui = {
    _stc_regionName = UI.getChildControl(Panel_RoseWar_Region, "RegionText"),
    _stc_regionPlace = UI.getChildControl(Panel_RoseWar_Region, "StaticText_Regiontext"),
    _stc_line_L = UI.getChildControl(Panel_RoseWar_Region, "Static_L_Line"),
    _stc_line_R = UI.getChildControl(Panel_RoseWar_Region, "Static_R_Line")
  },
  _deltaTime = 0,
  _showTime = 5,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Region_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Region_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FromClient_RoseWarRegionInit")
function FromClient_FromClient_RoseWarRegionInit()
  PaGlobal_RoseWarRegion:initialize()
end
