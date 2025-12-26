PaGlobal_Window_LootingItemReport_Main_All = {
  _ui = {
    _stc_titleBG = nil,
    _stc_titleBG_TitleIcon = nil,
    _stc_titleBG_TitleDeco = nil,
    _stc_titleBG_Close = nil,
    _stc_topGroup = nil,
    _stc_topGroup_classIcon = nil,
    _txt_topGroup_levelName = nil,
    _txt_topGroup_class = nil,
    _stc_topGroup_skillTypeIcon = nil,
    _stc_topGroup_awaken = nil,
    _stc_topGroup_succession = nil,
    _stc_topGroup_valueBG = nil,
    _stc_topGroup_faceIcon = nil,
    _stc_topGroup_faceIconBg = nil,
    _txt_topGroup_mainWeaponValue = nil,
    _txt_topGroup_arousalWeaponValue = nil,
    _txt_topGroup_defenseValue = nil,
    _chk_topGroup_statType = nil,
    _stc_middleGroup = nil,
    _txt_middleGroup_fieldInfo = nil,
    _txt_middleGroup_time = nil,
    _txt_middleGroup_date = nil,
    _txt_middleGroup_killCount = nil,
    _chk_middleGroup_pin = nil,
    _stc_bottomGroup = nil,
    _stc_bottomGroup_lootItemBG = nil,
    _txt_bottomGroup_lootItemTitle = nil,
    _stc_bottomGroup_itemListBg = nil,
    _itemSlotList = Array.new(),
    _chk_bottomGroup_arrow = nil,
    _stc_bottomGroup_lootingRecordGroup = nil,
    _stc_bottomGroup_columnNameGroup = nil,
    _list2_bottomGroup_recordList = nil,
    _stc_bottomGroup_guideDescBG = nil,
    _txt_bottomGroup_guideDesc = nil,
    _stc_bottomBg_consoleUI = nil,
    _txt_bottomBg_keyGuide_a_confirn = nil,
    _txt_bottomBg_keyGuide_b_close = nil,
    _txt_bottomBg_keyGuide_y_daily = nil,
    _txt_bottomBg_keyGuide_x_detail = nil,
    _stc_loadingBg = nil,
    _stc_loadingAni = nil,
    _stc_emptyMessageBg = nil
  },
  _fieldIndex = 0,
  _recordIndex = 0,
  _recordCount = 0,
  _panelSizeY = 0,
  _bottomBgSizeY = 0,
  _bottomDescSpanY = 0,
  _bottomRecordListSizeY = 0,
  _itemSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Looting//Panel_Window_LootingItemReport_Main_All_1.lua")
runLua("UI_Data/Script/Window/Looting//Panel_Window_LootingItemReport_Main_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_LootingItemReport_Main_All_Init")
registerEvent("FromClient_UpdateLootingItemRecordList", "FromClient_UpdateLootingItemRecordList")
function FromClient_Window_LootingItemReport_Main_All_Init()
  PaGlobal_Window_LootingItemReport_Main_All:initialize()
end
