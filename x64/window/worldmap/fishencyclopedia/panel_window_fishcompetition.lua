PaGlobal_FishCompetition = {
  _ui = {
    stc_topBg = nil,
    btn_close = nil,
    stc_radioButtonArea = nil,
    list2_fishList = nil,
    btn_Guide = nil,
    stc_rightArea = nil,
    stc_fishInfoArea = nil,
    stc_fishBg = nil,
    stc_fishImage = nil,
    txt_fishName = nil,
    stc_rareBG = nil,
    icons_rate = {},
    stc_averageSizeBg = nil,
    txt_averageSize = nil,
    stc_rankingArea = nil,
    stc_TopBgs = {},
    txt_TopNames = {},
    txt_TopValues = {},
    stc_catchRegion = {},
    txt_rankNames = {},
    txt_rankValues = {},
    stc_myRankArea = nil,
    txt_myRank = nil,
    txt_myValue = nil,
    btn_rewardInfo = nil,
    btn_receive = nil,
    stc_getable = nil,
    stc_KeyGuide_Bg = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil
  },
  _rateIconCount = 6,
  _topCount = 3,
  _rankCount = 10,
  _emptyImagePath = "ui_artwork/encyclopedia/fish_undiscover.dds",
  _fishTypeIndex = 0,
  _initialize = false,
  _isConsole = false,
  _gradeColor = {
    0,
    4284724988,
    4294951744,
    4293815895
  }
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetition_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetition_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FishCompetition_Init")
function FromClient_FishCompetition_Init()
  PaGlobal_FishCompetition:initialize()
end
