PaGlobal_FishCompetitionMyReward = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_contentsArea = nil,
    list2_myReward = nil,
    txt_noReward = nil,
    btn_receive = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _gradeColor = {
    0,
    4284724988,
    4294951744,
    4293815895
  },
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionMyReward_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionMyReward_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FishCompetitionMyReward_Init")
function FromClient_FishCompetitionMyReward_Init()
  PaGlobal_FishCompetitionMyReward:initialize()
end
