PaGlobal_EnemyAlert_HardCore_All = {
  _ui = {_btn = nil},
  _prevLevel = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_EnemyAlert_HardCore_All_Init")
function PaGlobal_EnemyAlert_HardCore_All_Init()
  PaGlobal_EnemyAlert_HardCore_All:initialize()
end
