PaGlobal_FishEncyclopedia_Renewal_All = {
  _ui = {
    btn_close = nil,
    edit_fishKeyword = nil,
    stc_categoryTabBackground = nil,
    radiobuttons_category = {},
    stc_leftPage = nil,
    list2_fishList = nil,
    fishSlotList = {},
    txt_progressValue = nil,
    stc_progressBackground = nil,
    progress_complete = nil,
    stc_rightPage = nil,
    stc_fishImage = nil,
    txt_fishName = nil,
    icons_rate = {},
    txt_averageFishSize = nil,
    stc_myFishSizeBackground = nil,
    txt_myFishSize = nil,
    stc_myFishCountBackground = nil,
    txt_myFishCount = nil,
    txt_fishDescription = nil,
    stc_rankingArea = nil,
    txt_rankerName_list = {},
    txt_rankerValue_list = {},
    stc_myRankIcon = nil,
    stc_myRankArea = nil,
    txt_myRankTitle = nil,
    txt_myRankValue = nil,
    stc_gradeBar = nil,
    stc_arrow = nil,
    stc_banner = nil,
    stc_KeyGuide_Bg = nil,
    txt_guideIconA = nil,
    txt_guideIconY = nil,
    txt_guideIconB = nil
  },
  _currentRadioIndex = 1,
  _selectedFishIndex = 0,
  _maxCategoryCount = 4,
  _columnSize = 4,
  _categoryMapping = {
    1,
    2,
    3,
    0
  },
  _rateIconCount = 6,
  _rankerCount = 5,
  _emptyImagePath = "ui_artwork/encyclopedia/fish_undiscover.dds",
  _isConsole = false,
  _initialize = false,
  _gradeColor = {
    4290110555,
    4284724988,
    4294951744,
    4293815895
  },
  _notFoundColor = 4284568643
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_Renewal_All_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_Renewal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FishEncyclopedia_Renewal_All_Init")
function FromClient_FishEncyclopedia_Renewal_All_Init()
  PaGlobal_FishEncyclopedia_Renewal_All:initialize()
end
