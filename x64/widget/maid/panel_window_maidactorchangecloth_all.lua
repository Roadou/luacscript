PaGlobal_MaidActorChangeCloth = {
  _ui = {
    stc_titleBg = nil,
    btn_close = nil,
    lst_item = nil,
    stc_emptyList = nil,
    stc_descBg = nil,
    stc_needItemSlotIcon = nil,
    txt_needItemName = nil,
    txt_needItemCount = nil,
    btn_change = nil,
    stc_guideBg = nil,
    txt_guide_01 = nil,
    txt_guide_02 = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideX = nil,
    stc_keyGuideY = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnchant = true,
    createDuplicatedForDuel = true,
    createOriginalForDuel = true,
    isTranslation = true
  },
  _console_overSlot_whereType = nil,
  _console_overSlot_slotNo = nil,
  _fromWhereType = nil,
  _fromSlotNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorChangeCloth_All_1.lua")
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorChangeCloth_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MaidActorChangeClothInit")
function FromClient_MaidActorChangeClothInit()
  PaGlobal_MaidActorChangeCloth:initialize()
end
