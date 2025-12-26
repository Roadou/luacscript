__eDamageLogUiType_Damage = 0
__eDamageLogUiType_DPS = 1
__eDamageLogUiType_Undefined2 = 2
__eDamageLogUiType_Count = 3
PaGlobal_DamageLog = {
  _ui = {
    _stc_titleBg = UI.getChildControl(Panel_Window_DamageLog, "Static_TitleBg"),
    _stc_mainBg = UI.getChildControl(Panel_Window_DamageLog, "Static_MainBg")
  },
  _typeString = {
    [__eDamageLogUiType_Damage] = "\235\141\176\235\175\184\236\167\128",
    [__eDamageLogUiType_DPS] = "DPS",
    [__eDamageLogUiType_Undefined2] = ""
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Log/Panel_Window_DamageLog_1.lua")
runLua("UI_Data/Script/Window/Log/Panel_Window_DamageLog_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_DamageLog_Init")
function FromClient_PaGlobal_DamageLog_Init()
  PaGlobal_DamageLog:initialize()
end
