PaGlobal_StackExtraction_All = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_stackEnchant = nil,
    stc_imageArea = nil,
    stc_extractionImage = nil,
    stc_bookSlot = nil,
    stc_valksAdviceSlot = nil,
    stc_infoArea = nil,
    txt_valksValue = nil,
    txt_stackValue = nil,
    txt_currentStack = nil,
    stc_bottomArea = nil,
    btn_skipAnimation = nil,
    btn_execution = nil,
    stc_keyGuide = nil,
    txt_guideIconB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createOriginalForDuel = true
  },
  _isEnchantAnim = false,
  _animTime = 0,
  _ANIM_LENGTH = 6,
  _bookSlot = {},
  _valksAdviceSlot = {},
  _isConsole = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_StackExtraction_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_StackExtraction_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_StackExtraction_All_Init")
function FromClient_StackExtraction_All_Init()
  PaGlobal_StackExtraction_All:initialize()
end
