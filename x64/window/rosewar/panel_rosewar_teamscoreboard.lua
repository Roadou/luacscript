PaGlobal_RoseWarTeamScoreBoard = {
  _ui = {
    _txt_title = nil,
    _btn_close = nil,
    _cbx_team = nil,
    _stc_teamList = nil,
    _btn_guildTab = nil,
    _btn_mercenaryTab = nil,
    _stc_selectBar = nil,
    _btn_reload = nil,
    _stc_name = nil,
    _stc_rank = nil,
    _stc_kill = nil,
    _stc_death = nil,
    _lst_scoreBoard = nil,
    _stc_keyGuide = nil
  },
  _eTabType = {
    GUILD = 0,
    MERCENARY = 1,
    COUNT = 2
  },
  _lastSelectedTeamNo = nil,
  _lastSelectedTabType = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamScoreBoard_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamScoreBoard_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarTeamScoreBoardInit")
function FromClient_RoseWarTeamScoreBoardInit()
  PaGlobal_RoseWarTeamScoreBoard:initialize()
end
