PaGlobal_FarmingTimerReport = {
  _ui = {
    group_TitleGroup = nil,
    txt_Title = nil,
    btn_Close = nil,
    bg_BackImage = nil,
    bg_CharacterStatBg = nil,
    im_CharacterImage = nil,
    txt_BaseInfo = nil,
    txt_MoneyBg = nil,
    txt_PlayTime = nil,
    txt_Revenue = nil,
    txt_Attack = nil,
    txt_Awaken = nil,
    txt_Defence = nil,
    group_ItemGroup = nil,
    btn_GetItemList = nil,
    btn_ConsumeItemList = nil,
    btn_Experience = nil,
    bg_ItemListBg = nil,
    list2_Item = nil,
    list2_1_VerticalScroll = nil,
    list2_1_VerticalScroll_UpButton = nil,
    list2_1_VerticalScroll_DownButton = nil,
    list2_1_VerticalScroll_CtrlButton = nil,
    list2_1_HorizontalScroll = nil,
    list2_1_HorizontalScroll_UpButton = nil,
    list2_1_HorizontalScroll_DownButton = nil,
    list2_1_HorizontalScroll_CtrlButton = nil,
    bg_DescBg = nil,
    txt_Text_Desc = nil
  },
  _slotConfig = {createIcon = true, createCount = true},
  _config = {
    _slotCount = 5,
    _slotCols = 1,
    _slotRows = 0,
    _slotBGStartX = 10,
    _slotBGStartY = 10,
    _slotStartX = 10,
    _slotStartY = 10,
    _slotGapX = 54,
    _slotGapY = 54
  },
  _slotBgBases = nil,
  _slots = nil,
  _defaultBgSize = {x = 0, y = 0},
  _defaultPanelSize = {x = 0, y = 0},
  _startItemIndex = 0,
  _startItemSaveIndex = 0,
  _selectTab = __eFarmingReportTab_FarmingItemList
}
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_1.lua")
runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_FarmingTimerReport_luaLoadComplete")
function PaGlobal_FarmingTimerReport_luaLoadComplete()
  PaGlobal_FarmingTimerReport:initialize()
end
