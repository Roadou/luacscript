PaGlobal_EnchantMaterial_All = {
  _ui = {
    stc_mainBg = nil,
    list_itemList = nil,
    list_content = nil,
    rdo_radioButton1 = nil,
    stc_equipSlotBG = nil,
    stc_equipSlot = nil,
    btn_apply = nil,
    stc_titleBar = nil,
    btn_close = nil,
    stc_keyGuide = nil,
    txt_guideIconB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = false,
    createCash = true,
    createEnduranceIcon = true
  },
  _currentIndex = 0,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Material_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Material_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantMaterial_All_Init")
function FromClient_EnchantMaterial_All_Init()
  PaGlobal_EnchantMaterial_All:initialize()
end
