PaGlobal_RoseWarMenu = {
  _ui = {
    _stc_mainBG = nil,
    _stc_dimmed = nil,
    _stc_symbolSword = nil,
    _stc_symbolGuildChoice = nil,
    _stc_symbolMercenaryChoice = nil,
    _stc_symbolRoseWar = nil,
    _stc_leaderBox = nil,
    _stc_kamaFlag = nil,
    _stc_odilFlag = nil,
    _stc_kamasylviaCamp = nil,
    _stc_odyllitaCamp = nil,
    _stc_leaderBoxKamaGuildName = nil,
    _stc_leaderBoxOdilGuildName = nil,
    _stc_mainDesc = nil,
    _btn_appoint = nil,
    _stc_appointDone = nil,
    _stc_commanderName = nil,
    _applyGuild = {
      _btn_applyGuildArea = nil,
      _stc_title = nil,
      _stc_date = nil,
      _btn_applyGuild = nil,
      _btn_returnMoney = nil,
      _btn_cancelApply = nil,
      _stc_dateOver = nil,
      _stc_leaderBox = nil,
      _stc_kama = nil,
      _stc_kamaCommander = nil,
      _stc_odil = nil,
      _stc_odilCommander = nil,
      _stc_unAppointCommander = nil
    },
    _applyMercenary = {
      _btn_applyMercenaryArea = nil,
      _stc_title = nil,
      _stc_date = nil,
      _btn_applyMercenary = nil,
      _btn_returnMoney = nil,
      _btn_cancelApply = nil,
      _stc_dateOver = nil,
      _stc_campKama = nil,
      _stc_campOdil = nil
    },
    _readyRoseWar = {
      _btn_readyRoseWarArea = nil,
      _stc_title = nil,
      _stc_date = nil,
      _btn_roseWarLive = nil,
      _btn_campList = nil,
      _stc_dateOver = nil
    },
    _stc_preSeasonGuide = nil,
    _stc_bottomButtonArea = nil,
    _btn_roseWarReward = nil,
    _btn_roseWarRule = nil,
    _btn_roseWarHistory = nil,
    _btn_roseWarObserveMode = nil,
    _btn_roseWarTeamScoreBoard = nil
  },
  _prevUIMode = nil,
  _renderMode = nil,
  _initialize = false,
  _selectedMenuIndex = nil,
  _applyGuildMenu = 0,
  _applyMercenaryMenu = 1,
  _readyRoseWarMenu = 2,
  _eApplyTimeType = {
    GUILD_APPLY_START = 0,
    GUILD_APPLY_END = 1,
    MERCENARY_APPLY_START = 2,
    MERCENARY_APPLY_END = 3,
    COUNT = 4
  }
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Menu_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Menu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarMenuInit")
function FromClient_RoseWarMenuInit()
  PaGlobal_RoseWarMenu:initialize()
end
