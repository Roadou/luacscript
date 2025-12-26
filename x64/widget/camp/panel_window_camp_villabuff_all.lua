PaGlobal_BuildingBuff_All = {
  _ui = {
    _stc_Title = nil,
    _btn_Close = nil,
    _stc_SubFrame = nil,
    _stc_BottomGroup = nil,
    _txt_DescBG = nil,
    _stc_MoneyArea = nil,
    _txt_MoneyValue = nil,
    _stc_KeyGuide = nil,
    _stc_TemplateBg = {},
    _stc_DescBg = {},
    _stc_BuffIcon = {},
    _txt_BuffName = {},
    _txt_BuffEffect = {},
    _btn_BuffBuy = {},
    _txt_BuffPrice = {}
  },
  _maxPriceKey = 0,
  _keyCount = {},
  _buffCount = {},
  _totalBuffCount = 0,
  _sortTable = {},
  _sortCount = 0,
  _buffName = {},
  _buffDesc = {},
  _buffTime = {},
  _buffPrice = {},
  _buffIconPath = {
    [0] = "Icon/New_Icon/04_PC_Skill/03_Buff/WisdomOfLife_Up.dds",
    [1] = "Icon/New_Icon/04_PC_Skill/03_Buff/BattlePower_Up.dds",
    [2] = "Icon/New_Icon/04_PC_Skill/03_Buff/SkillAndExp_Up.dds"
  },
  _limitControl = {},
  _limitControlName = {},
  _limitControlDesc = {},
  originPanelSizeY = 0,
  originBottomBGSizeY = 0,
  originDescSizeY = 0,
  originKeyGuidePosY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All_1.lua")
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BuildingBuff_All_luaLoadComplete")
function FromClient_BuildingBuff_All_luaLoadComplete()
  PaGlobal_BuildingBuff_All:initialize()
end
