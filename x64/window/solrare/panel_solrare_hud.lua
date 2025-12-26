PaGlobal_Solare_Hud = {
  _ui = {
    _stc_TeamHud = nil,
    _prog2_HPRed = nil,
    _prog2_HPBlue = nil,
    _txt_prog2HPRed = nil,
    _txt_prog2HPBlue = nil,
    _txt_LeftName = nil,
    _txt_RightName = nil,
    _stc_RedPointDot = Array.new(),
    _stc_BluePointDot = Array.new(),
    _txt_Round = nil,
    _txt_LeftTime = nil,
    _stc_countDown = Array.new(),
    _panel_waitOther = nil,
    _txt_waitOtherTime = nil
  },
  _currentRoomState = -1,
  _currentPlayState = -1,
  _currentRoundTime = 0,
  _currentTimeForPerFrame = 0,
  _waitMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_WAITMEMBER"),
  _currentDeltaTime = 0,
  _currentMaxCountDown = -1,
  _maxCountDown = 5,
  _maxRound = 3,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Hud_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Hud_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_Solare_Hud_Init")
function FromClient_Widget_Solare_Hud_Init()
  PaGlobal_Solare_Hud:initialize()
end
