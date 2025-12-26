PaGlobal_HardCoreLeftTime = {
  _ui = {
    _stc_TimeValue = nil,
    _stc_BlackBarrier = nil,
    _stc_BlackBarrierLeftPlayersCount = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_LeftTime_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_LeftTime_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreLeftTime_Init")
function FromClient_HardCoreLeftTime_Init()
  PaGlobal_HardCoreLeftTime:initialize()
end
