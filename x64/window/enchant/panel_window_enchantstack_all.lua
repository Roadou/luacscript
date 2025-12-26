PaGlobal_EnchantStack_All = {
  _ui = {
    stc_titleArea = nil,
    btn_question = nil,
    btn_close = nil,
    stc_radioButtonBg = nil,
    stc_radioButton_stack = nil,
    stc_radioButton_valksCry = nil,
    stc_selectBar = nil,
    stc_mainBg = nil,
    txt_normalStack = nil,
    stc_normalArrow = nil,
    txt_bonusStack = nil,
    stc_bonusArrow = nil,
    txt_selectStack = nil,
    txt_selectRate = nil,
    txt_probability = nil,
    txt_successRate = nil,
    btn_othersChoice = nil,
    stc_listArea = nil,
    frame_itemList = nil,
    frame_content = nil,
    stc_listGroup = nil,
    stc_slot = nil,
    stc_select = nil,
    stc_subSelectBG = nil,
    stc_titleBG = nil,
    stc_title = nil,
    btn_selectListClose = nil,
    list2_selectList = nil,
    btn_apply = nil,
    stc_keyGuide = nil,
    txt_guideIconB = nil
  },
  _listItemSlots = {},
  _categoryList = {},
  _isConsole = false,
  COLUMN_PER_ROW = 8,
  CONTENT_MIN_HEIGHT = 160,
  SLOT_OFFSET = 15,
  CATEGORY_OFFSET = 15,
  SLOT_SIZE = 52,
  _targetEnchantStackIndex = 0,
  _triedStack = nil,
  _valksAdviceEffectPos = 0,
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  }
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStack_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStack_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantStack_All_Init")
function FromClient_EnchantStack_All_Init()
  PaGlobal_EnchantStack_All:initialize()
end
