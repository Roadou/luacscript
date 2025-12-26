PaGlobal_HardCoreRanking = {
  _ui = {
    _txt_TitleName = nil,
    _txt_CharacterName = nil,
    _txt_MyRank = nil,
    _txt_KillDeathCount = nil,
    _stc_TierListBtn = nil,
    _stc_TierList = nil,
    _stc_ProfileIcon = nil,
    _tierControlList = {},
    _stc_MyRankIcon = nil,
    _txt_MyRankName = nil,
    _txt_MyRankPoint = nil,
    _highRankerList = {},
    _rankFrame = nil,
    _frameContent = nil,
    _frameScroll = nil,
    _btn_Exit = nil,
    _btn_Guide = nil
  },
  _initialize = false,
  _selfPlayer = nil,
  _topRankerCount = 3,
  _totalGradeCount = 10,
  _scrollIdx = 0,
  _highRankerMaxCount = 0,
  _gap = 2
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Ranking_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Ranking_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreRanking_Init")
function FromClient_HardCoreRanking_Init()
  PaGlobal_HardCoreRanking:initialize()
end
