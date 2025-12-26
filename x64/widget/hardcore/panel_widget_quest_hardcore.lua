PaGlobal_HardCoreQuest = {
  _ui = {
    _txt_ScoreValue = nil,
    _stc_CoinPointProgress = nil,
    _stc_RankPointProgress = nil,
    _questUI = {},
    _stc_MyRank = nil,
    _stc_HighRankerBg = nil,
    _stc_HighRanker = {}
  },
  _initialize = false,
  _questCountMax = 2,
  _questData = {},
  _rankControlMargin = 5
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Quest_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Quest_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreQuest_Init")
function FromClient_HardCoreQuest_Init()
  PaGlobal_HardCoreQuest:initialize()
end
