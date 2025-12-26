PaGlobal_Solrare_Ranking = {
  _ui = {
    _btn_Close = nil,
    _btn_TierList = nil,
    _stc_TierListBg = nil,
    _frame_RankingBg = nil,
    _frame_Content = nil,
    _big_RecordTemp = nil,
    _frame_Scroll = nil,
    _small_RecordTemp = nil,
    _mostDetailTemp = nil,
    _txt_NoRank = nil,
    _stc_changeModeBg = nil,
    _btn_changeMode = nil,
    _classFilter = nil,
    _classTypeList = {},
    _consoleUI = nil,
    _consoleKeyX = nil,
    _consoleKeyB = nil,
    _consoleKeyA = nil
  },
  _recordControl = Array.new(),
  _recordInfo = Array.new(),
  _frameControlSize = 0,
  _maxShowingRecordCount = 100,
  _currentRecordCount = 0,
  _scrollIndex = 0,
  _normalBgSize = 0,
  _detailBgSize = 0,
  _currentSelectMode = __ePVPArenaMode_SOLARE3vs3,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Ranking_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Ranking_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_All_Init")
function FromClient_Solrare_All_Init()
  PaGlobal_Solrare_Ranking:initialize()
end
