PaGlobal_FishCompetitionRewardInfo = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_contentsArea = nil,
    stc_tierBg = {},
    txt_rank = {},
    stc_gradeSlot = {}
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _singleRankCount = 3,
  _rewardCount = 6,
  _startGrade = 2,
  _endGrade = 4,
  _rewardItemKeyList = {},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionRewardInfo_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionRewardInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FishCompetitionRewardInfo_Init")
function FromClient_FishCompetitionRewardInfo_Init()
  PaGlobal_FishCompetitionRewardInfo:initialize()
end
