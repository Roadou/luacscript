PaGlobal_AbyssOneInfo = {
  _ui = {
    _stc_decoLine = nil,
    _stc_titleText = nil,
    _stc_descText = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_RegionInfo_1.lua")
runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_RegionInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOneInfoInit")
function FromClient_AbyssOneInfoInit()
  PaGlobal_AbyssOneInfo:initialize()
end
