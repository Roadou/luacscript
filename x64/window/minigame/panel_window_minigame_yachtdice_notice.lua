PaGlobal_YachtDice_Notice = {
  _ui = {
    _stc_titleArea = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Static_TitleBg"),
    _stc_gameBoardInfoArea = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Static_Dec_Type"),
    _txt_multilineText = nil,
    _txt_gameBoardDesc = nil,
    _txt_gamePlatformIcon = nil,
    _txt_remainTime = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "StaticText_Confirm"),
    _prg_remainTime = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Progress2_1"),
    _btn_ok = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Button_Ok"),
    _btn_cancel = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Button_Cancel"),
    _stc_keyGuides = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Notice, "Static_KeyGuide_ConsoleUI")
  },
  _doCancelProcess = false,
  _panelMoveDeltaTime = 0,
  _isReverseMove = false,
  _isMoveDone = false,
  _cachedExpireTime = 0,
  _remainExpireTime = 0,
  _isExpireRequest = false,
  _lastUpdateTime = 0,
  _keepOpenInfo = {
    _requestUserNickName = nil,
    _expireTime = nil,
    _gameBoardKey = nil,
    _requestUserPlatformId = nil,
    _requestUserPlatformType = nil
  },
  _isConsole = false,
  _cancelProcessTime = 2,
  _expireMaxTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Notice_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Notice_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitializeYachtDiceNoticePanel")
function FromClient_InitializeYachtDiceNoticePanel()
  PaGlobal_YachtDice_Notice:initialize()
end
