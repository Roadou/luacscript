PaGlobal_Atoraxion_RegionInfo = {
  _ui = {
    _stc_decoLine = nil,
    _stc_titleText = nil,
    _stc_descText = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_RegionInfo_1.lua")
runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_RegionInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AtoraxionInfoInit")
function FromClient_AtoraxionInfoInit()
  PaGlobal_Atoraxion_RegionInfo:initialize()
end
