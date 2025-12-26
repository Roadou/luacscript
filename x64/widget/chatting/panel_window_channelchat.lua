PaGlobal_ChannelChat = {
  _ui = {
    stc_title = nil,
    stc_bg = nil,
    btn_title = {},
    stc_title = {},
    stc_desc = {},
    btn_radio = {},
    btn_bg = {},
    scrol_list = nil,
    btn_scrolUp = nil,
    btn_scrolDown = nil,
    btn_ScrolCtrl = nil,
    stc_bottomDescBG = nil,
    stc_txt_bottomDesc = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_confirm = nil,
    btn_cancel = nil
  },
  _ui_console = {
    stc_bottomBg = nil,
    stc_TextA = nil,
    stc_TextB = nil
  },
  _config = {_slotCount = 4, _slotCols = 2},
  _userType = {
    None = 0,
    Return = 1,
    Newbie = 2,
    Count = 3
  },
  _currentIndex = -1,
  _selectIndex = -1,
  _selectTitleString = nil,
  _maxListCount = 35,
  _serverListCount = 35,
  _defaultChatRoomNo = 28,
  _roomNoIndexTable = {},
  channelIndexToTextureIndex = {
    [0] = 0,
    [1] = 3,
    [2] = 4,
    [3] = 1,
    [4] = 2
  },
  _startItemIndex = 0,
  _isFirstLogin = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat_1.lua")
runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ChannelChatInit")
function FromClient_ChannelChatInit()
  PaGlobal_ChannelChat:initialize()
end
