PaGlobal_EnchantProtector_All = {
  _ui = {
    stc_titlebar = nil,
    btn_close = nil,
    stc_mainBg = nil,
    btn_apply = nil,
    list2_protectorList = nil,
    stc_keyGuide = nil,
    txt_guideIconB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = false,
    createClassEquipBG = true,
    createCash = true
  },
  _contentList = {},
  _currentIndex = 0,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantProtector_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantProtector_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantProtector_All_Init")
function FromClient_EnchantProtector_All_Init()
  PaGlobal_EnchantProtector_All:initialize()
end
