PaGlobal_GuildMatch = {
  _ui = {
    _stc_tabBg = nil,
    _rdo_tabBtn = nil,
    _btn_currentTab = nil,
    _txt_subGroupPointDesc = nil,
    _txt_record = nil,
    _txt_rankPoint = nil,
    _txt_mainState = nil,
    _txt_subState = nil,
    _btn_desc = nil,
    _stc_descArea = nil,
    _btn_gameRecord = nil,
    _btn_gameRanking = nil,
    _btn_join = nil,
    _btn_enter = nil,
    _btn_exit = nil,
    _stc_penalty = nil,
    _stc_rewardIcon = nil,
    _stc_tooltipBg = nil,
    _stc_myGuildMark = nil,
    _txt_myGuildName = nil,
    _stc_enemyGuildMark = nil,
    _txt_enemyGuildName = nil,
    _frm_desc = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _currentMatchingType = __eGuildMatchMatchingType_Main,
  _penaltyCount = nil,
  _penaltyTime = nil,
  _isAppliedPenalty = false,
  _lastRequestServerTickCount = 0,
  _serverDataUpdateTimeSec = 30,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMatchInit")
function FromClient_GuildMatchInit()
  PaGlobal_GuildMatch:initialize()
end
