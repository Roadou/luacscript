PaGlobal_ChatSubMenu = {
  _ui = {
    _staticBg = nil,
    _buttonWhisper = nil,
    _buttonAddFriend = nil,
    _buttonInviteParty = nil,
    _buttonInviteLargeParty = nil,
    _buttonInviteGuild = nil,
    _buttonInviteCompetition = nil,
    _buttonInviteVolunteer = nil,
    _buttonBlock = nil,
    _buttonBlockVote = nil,
    _buttonReportChat = nil,
    _buttonIntroduce = nil,
    _buttonWinClose = nil,
    _buttonRecommand = nil,
    _buttonInviteMiniGameYacht = nil
  },
  _currentPoolIndex = nil,
  _clickedMessageIndex = nil,
  _clickedName = nil,
  _clickedUserNickName = nil,
  _clickedUserId = nil,
  _clickedMsg = nil,
  _senderUserNo = nil,
  _chatType = nil,
  _chatSendTime = nil,
  _chatSendServerTime = nil,
  _chatRoomNo = nil,
  _originBlockButtonPosY = -1,
  isLargePartyOpen = ToClient_IsContentsGroupOpen("286"),
  _initialize = false
}
runLua("UI_Data/Script/Widget/Chatting/ChatSubMenu/Panel_Widget_ChatSubMenu_1.lua")
runLua("UI_Data/Script/Widget/Chatting/ChatSubMenu/Panel_Widget_ChatSubMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ChatSubMenuInit")
function FromClient_ChatSubMenuInit()
  PaGlobal_ChatSubMenu:initialize()
end
