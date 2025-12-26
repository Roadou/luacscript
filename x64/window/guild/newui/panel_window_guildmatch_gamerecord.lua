PaGlobal_GuildMatchGameRecord = {
  _ui = {
    _btn_close = nil,
    _cbx_gameList = nil,
    _stc_comboBoxList = nil,
    _txt_MyguildName = nil,
    _txt_TargetGuildName = nil,
    _lst_MyGuildRecord = nil,
    _lst_TargetGuildRecord = nil,
    _stc_myGuild_killDeath = nil,
    _stc_myGuild_heal = nil,
    _stc_myGuild_takeDamage = nil,
    _stc_myGuild_giveDamage = nil,
    _stc_myGuild_ccCount = nil,
    _stc_enemyGuild_killDeath = nil,
    _stc_enemyGuild_heal = nil,
    _stc_enemyGuild_takeDamage = nil,
    _stc_enemyGuild_giveDamage = nil,
    _stc_enemyGuild_ccCount = nil
  },
  _cacheInfo = {_myGuildAceIndex = -1, _enemyGuildAceIndex = -1},
  _currentGameIndex = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_GameRecord_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_GameRecord_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMatchGameRecordInit")
function FromClient_GuildMatchGameRecordInit()
  PaGlobal_GuildMatchGameRecord:initialize()
end
