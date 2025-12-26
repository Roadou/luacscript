PaGlobal_GuildBossField_Enter_All = {
  _ui = {_stc_blackBG = nil},
  _curEffectTime = 0,
  _maxEffectTime = 3,
  _isShowEffect = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_GuildBossField_Enter_All_1.lua")
runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_GuildBossField_Enter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildBossField_Enter_All_Init")
function FromClient_GuildBossField_Enter_All_Init()
  PaGlobal_GuildBossField_Enter_All:initialize()
end
