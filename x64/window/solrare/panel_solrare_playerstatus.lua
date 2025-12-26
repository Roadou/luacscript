PaGlobal_Solrare_PlayerStatus = {
  _ui = {
    _leftTeam = {
      stc_mainBg = nil,
      stc_teamNameBg = nil,
      txt_teamName = nil,
      stc_memberTemplate = nil,
      stc_buffList = {},
      stc_MyTeam = nil
    },
    _rightTeam = {
      stc_mainBg = nil,
      stc_teamNameBg = nil,
      txt_teamName = nil,
      stc_memberTemplate = nil,
      stc_buffList = {},
      stc_MyTeam = nil
    },
    stc_VoiceListen = nil,
    stc_HeadPhoneBlink = nil,
    stc_MICOnOff = nil
  },
  _maxControlCount = 3,
  _maxTeamCount = 2,
  _buffMaxCount = 0,
  _redTeamMemberUI = Array.new(),
  _redTeamUserInfo = Array.new(),
  _redTeamSettedCount = 1,
  _blueTeamMemberUI = Array.new(),
  _blueTeamUserInfo = Array.new(),
  _blueTeamSettedCount = 1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_PlayerStatus_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_PlayerStatus_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_PlayerStatus_Init")
function FromClient_Solrare_PlayerStatus_Init()
  PaGlobal_Solrare_PlayerStatus:initialize()
end
