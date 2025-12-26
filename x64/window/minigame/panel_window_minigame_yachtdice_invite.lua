Window_YachtDice_Invite_OpenMode = {
  InviteMode = 0,
  AcceptMode = 1,
  Count = 2
}
PaGlobal_YachtDice_Invite = {
  _ui = {
    _stc_mainBg = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Main_BG"),
    _btn_close = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Button_Close"),
    _stc_selectArea = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Select_BG"),
    _btn_left = nil,
    _btn_right = nil,
    _stc_mainBoardArea = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Main_Board"),
    _stc_mainBoard = nil,
    _lst_handRankList = nil,
    _txt_inputTitle = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "StaticText_Name_Search_Title"),
    _stc_inputArea = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Search_Group"),
    _edt_searchText = nil,
    _btn_invite = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Button_Invite"),
    _txt_matchingTitle = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "StaticText_MatchingRecord_Title"),
    _txt_matchingDesc = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "StaticText_MatchingRecord_Desc"),
    _btn_matching = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Button_Matching"),
    _console_keyGuideX = nil,
    _console_keyGuideLB = nil,
    _console_keyGuideRB = nil,
    _console_keyGuideRS = nil,
    _console_keyGuideY = nil,
    _console_keyGuideB = nil
  },
  _currentLeftIconIndex = 0,
  _gameBoardIconShowCountMax = 9,
  _gameBoardIconTotalCount = 0,
  _gameBoardIconList = {},
  _defaultSearchText = nil,
  _selectedGameBoardKey = nil,
  _gameBoardInitIndex = 0,
  _currentOpenMode = Window_YachtDice_Invite_OpenMode.InviteMode,
  _isConsole = false,
  _isPadMode = false,
  _isOpenMatching = _ContentsGroup_MiniGame_YachtDice_Match,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Invite_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Invite_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitializeYachtDiceInvitePanel")
function FromClient_InitializeYachtDiceInvitePanel()
  PaGlobal_YachtDice_Invite:initialize()
end
