PaGlobal_Solare_Custom = {
  _ui = {
    _stc_MapImage = nil,
    _txt_MapName = nil,
    _frame_Chat = nil,
    _frame_ChatContent = nil,
    _stc_frameVScroll = nil,
    _txt_ChatTemplate = nil,
    _edit_Chat = nil,
    _list_WaitMember = nil,
    _stc_FloatBtnBg = nil,
    _btn_KickOut = nil,
    _btn_MoveToWait = nil,
    _btn_MoveToRed = nil,
    _btn_MoveToBlue = nil,
    _btn_Close = nil,
    _btn_Guide = nil,
    _btn_MapLeft = nil,
    _btn_MapRight = nil,
    _pc = {_btn_Start = nil, _btn_Exit = nil},
    _console = {
      _keyGuideBg = nil,
      _txt_InputChat = nil,
      _txt_Close = nil,
      _txt_Select = nil,
      _txt_Start = nil,
      _txt_prevCharacter = nil,
      _txt_nextCharacter = nil,
      _txt_MapLeft = nil,
      _txt_MapRight = nil
    }
  },
  _selectedTeamType = nil,
  _selectedMemberIndex = nil,
  _blueTeamMemberUI = Array.new(),
  _redTeamMemberUI = Array.new(),
  _chatMessagePool = nil,
  _chatMessageMaxCount = 50,
  _chatMessageAccCount = 0,
  _isRoomLeader = false,
  _originFloatBtnBgSizeY = 0,
  _originFrameChatContentSizeY = 0,
  _originChatDataSizeX = 0,
  _originChatDataSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SolareCustomInit")
function FromClient_SolareCustomInit()
  PaGlobal_Solare_Custom:initialize()
end
