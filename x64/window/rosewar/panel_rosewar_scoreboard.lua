PaGlobal_RoseWarScoreBoard = {
  _ui = {
    _btn_close = nil,
    _rdo_guild = nil,
    _rdo_mercenary = nil,
    _stc_selectLine = nil,
    _btn_reload = nil,
    _stc_name = nil,
    _stc_rank = nil,
    _stc_kill = nil,
    _stc_death = nil,
    _lst_record = nil
  },
  _eTabType = {
    GUILD = 0,
    MERCENARY = 1,
    COUNT = 2
  },
  _lastSelectedTabType = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_ScoreBoard_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_ScoreBoard_2.lua")
