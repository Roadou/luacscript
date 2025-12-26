PaGlobal_BarterInfoSearch = {
  _ui = {
    _titleBar = UI.getChildControl(Panel_Window_Barter_Search, "Static_TitleBg"),
    _searchBar = UI.getChildControl(Panel_Window_Barter_Search, "Static_SearchOptionBG"),
    _mainBg = UI.getChildControl(Panel_Window_Barter_Search, "Static_MainBg"),
    _txt_NotFind = UI.getChildControl(Panel_Window_Barter_Search, "StaticText_NoItem"),
    _stc_specialInfoBG = UI.getChildControl(Panel_Window_Barter_Search, "Static_SpecialBarterBG"),
    _stc_middleGroup = UI.getChildControl(Panel_Window_Barter_Search, "Static_MiddleGroup"),
    _stc_checkButtonGroup = UI.getChildControl(Panel_Window_Barter_Search, "Static_CheckButtonGroup"),
    _stc_keyGuideBG = UI.getChildControl(Panel_Window_Barter_Search, "Static_KeyGuide_ConsoleUI")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  },
  _itemGradeText = {
    [__eItemGradeNormal] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_NORMAL"),
    [__eItemGradeMagic] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_GREEN"),
    [__eItemGradeRare] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_BLUE"),
    [__eItemGradeUnique] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_YELLOW"),
    [__eItemGradeEpic] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_ORANGE"),
    [__eItemGradeTypeCount] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_TOTAL")
  },
  _valueLimitText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_3")
  },
  _categoryText = {
    [__eBarterCategory_NormalToLevel1] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_1"),
    [__eBarterCategory_Level1ToLevel2] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_2"),
    [__eBarterCategory_Level2ToLevel3] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_3"),
    [__eBarterCategory_Level3ToLevel4] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_4"),
    [__eBarterCategory_Level4ToLevel5] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_5"),
    [__eBarterCategory_NormalBarter] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_6"),
    [__eBarterCategory_CrowCoin] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_7"),
    [__eBarterCategory_Ocean] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_9"),
    [__eBarterCategory_Count] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_8")
  },
  _selectFilterIndex = nil,
  _selectValueLimitIndex = nil,
  _selectCategoryIndex = nil,
  _selectToItemCountFilter = 0,
  _updateCurrentTime = 0,
  _updatePastTime = 0,
  _originalKeyGuideBgSize = 0,
  _originalPanelPosY = 0,
  _specailBG_DefaultSizeX = nil,
  _isInit = false,
  _isOpenedByCargoLoading = false
}
function FromClient_BarterInfoSearchInit()
  local self = PaGlobal_BarterInfoSearch
  self:init()
end
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_1.lua")
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BarterInfoSearchInit")
registerEvent("FromClient_RefreshBarterList", "FromClient_BarterInfoSearch_RefreshBarterList")
registerEvent("FromClient_RefreshSpecialBarterInfo", "FromClient_BarterInfoSearch_RefreshSpecialBarter")
registerEvent("FromClient_AddBarterExchangeCount", "FromClient_BarterInfoSearch_AddBarterExchangeCount")
registerEvent("FromClient_LoadBarterList", "PaGlobalFunc_BarterInfoSearch_Refresh")
