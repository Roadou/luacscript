PaGlobal_GuildMatchScore = {
  _ui = {
    _stc_result = nil,
    _stc_resultBg = nil,
    _stc_win = nil,
    _stc_lose = nil,
    _txt_win_prevScore = nil,
    _txt_win_afterScore = nil,
    _btn_win_leave = nil,
    _txt_lose_prevScore = nil,
    _txt_lose_afterScore = nil,
    _btn_lose_leave = nil,
    _txt_myGuildName = nil,
    _txt_enemyGuildName = nil,
    _txt_timeLine = nil,
    _txt_myGuildScore = nil,
    _txt_enemyGuildScore = nil,
    _stc_timerBg = nil,
    _txt_timerLeftTime = nil
  },
  _currentMatchState = __eGuildMatchState_Count,
  _deltaTime = 0,
  _resultInfo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Score_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Score_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMatchScoreInit")
function FromClient_GuildMatchScoreInit()
  PaGlobal_GuildMatchScore:initialize()
end
