PaGlobal_EnchantMessage_All = {
  _ui = {stc_nakMessage = nil},
  _isConsole = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantMessage_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantMessage_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantMessage_All_Init")
function FromClient_EnchantMessage_All_Init()
  PaGlobal_EnchantMessage_All:initialize()
end
