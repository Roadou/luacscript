PaGlobal_BossInstance_Dummy = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_BossInstance_Dummy_1.lua")
runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_BossInstance_Dummy_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_BossInstance_Dummy_Init")
function FromClient_PaGlobal_BossInstance_Dummy_Init()
  PaGlobal_BossInstance_Dummy:initialize()
end
