function PaGlobal_ChatSubMenu:initialize()
  if self._initialize == true then
    return
  end
  self._ui._staticBg = UI.getChildControl(Panel_Chat_SubMenu, "Static_SubMenu")
  self._ui._buttonWhisper = UI.getChildControl(Panel_Chat_SubMenu, "Button_Whisper")
  self._ui._buttonAddFriend = UI.getChildControl(Panel_Chat_SubMenu, "Button_AddFriend")
  self._ui._buttonInviteParty = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteParty")
  self._ui._buttonInviteLargeParty = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteLargeParty")
  self._ui._buttonInviteGuild = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteGuild")
  self._ui._buttonInviteCompetition = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteCompetition")
  self._ui._buttonInviteVolunteer = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteVolunteer")
  self._ui._buttonBlock = UI.getChildControl(Panel_Chat_SubMenu, "Button_Block")
  self._ui._buttonBlockVote = UI.getChildControl(Panel_Chat_SubMenu, "Button_BlockVote")
  self._ui._buttonReportChat = UI.getChildControl(Panel_Chat_SubMenu, "Button_ReportChat")
  self._ui._buttonIntroduce = UI.getChildControl(Panel_Chat_SubMenu, "Button_ShowIntroduce")
  self._ui._buttonWinClose = UI.getChildControl(Panel_Chat_SubMenu, "Button_WinClose")
  self._ui._buttonRecommand = UI.getChildControl(Panel_Chat_SubMenu, "Button_Recommand")
  self._ui._buttonInviteMiniGameYacht = UI.getChildControl(Panel_Chat_SubMenu, "Button_InviteYachtMiniGame")
  self._ui._buttonIntroduce:SetShow(false)
  self._ui._staticBg:SetIgnore(false)
  self:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ChatSubMenu:registEventHandler()
  if Panel_Chat_SubMenu == nil then
    return
  end
  self._ui._staticBg:addInputEvent("Mouse_On", "HandleEventOn_ChattingSubMenu()")
  self._ui._buttonWhisper:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuSendWhisper()")
  self._ui._buttonAddFriend:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuAddFriend()")
  self._ui._buttonInviteParty:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteParty()")
  self._ui._buttonInviteLargeParty:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteLargeParty()")
  self._ui._buttonInviteGuild:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteGuild()")
  self._ui._buttonInviteCompetition:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteCompetition()")
  self._ui._buttonInviteVolunteer:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuInviteVolunteer()")
  self._ui._buttonWinClose:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuClose()")
  self._ui._buttonBlock:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuBlock()")
  self._ui._buttonBlockVote:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuBlockVoteRenew()")
  self._ui._buttonReportChat:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatSubMenuReportChat()")
  self._ui._buttonRecommand:addInputEvent("Mouse_LUp", "HandleEventLUp_Recommand()")
  self._ui._buttonInviteMiniGameYacht:addInputEvent("Mouse_LUp", "HandleEventLUp_InviteMiniGameYacht()")
  registerEvent("FromClient_requestInviteGuildByChatSubMenu", "FromClient_requestInviteGuildByChatSubMenu")
  registerEvent("FromClient_ResetThumbsUpVoteCount", "FromClient_ResetThumbsUpVoteCount")
end
function PaGlobal_ChatSubMenu:validate()
  if Panel_Chat_SubMenu == nil then
    return
  end
  self._ui._staticBg:isValidate()
  self._ui._buttonWhisper:isValidate()
  self._ui._buttonAddFriend:isValidate()
  self._ui._buttonInviteParty:isValidate()
  self._ui._buttonInviteLargeParty:isValidate()
  self._ui._buttonInviteGuild:isValidate()
  self._ui._buttonInviteCompetition:isValidate()
  self._ui._buttonInviteVolunteer:isValidate()
  self._ui._buttonBlock:isValidate()
  self._ui._buttonBlockVote:isValidate()
  self._ui._buttonIntroduce:isValidate()
  self._ui._buttonWinClose:isValidate()
  self._ui._buttonRecommand:isValidate()
  self._ui._buttonInviteMiniGameYacht:isValidate()
end
function PaGlobal_ChatSubMenu:SetShow(isShow, isInviteParty, isInviteGuild, isInviteCompetition, isGameManager, isRecommand, clickedName, clickedUserNickName, isPearlAppUser)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatSubMenu:SetShow isShow nil", "\236\178\156\235\167\140\234\184\176")
  if isShow == false then
    Panel_Chat_SubMenu:SetShow(false)
    return
  end
  UI.ASSERT_NAME(nil ~= isInviteParty, "PaGlobal_ChatSubMenu:SetShow isInviteParty nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isInviteGuild, "PaGlobal_ChatSubMenu:SetShow isInviteGuild nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isInviteCompetition, "PaGlobal_ChatSubMenu:SetShow isInviteCompetition nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isGameManager, "PaGlobal_ChatSubMenu:SetShow isGameManager nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedName, "PaGlobal_ChatSubMenu:SetShow clickedName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedUserNickName, "PaGlobal_ChatSubMenu:SetShow clickedUserNickName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isPearlAppUser, "PaGlobal_ChatSubMenu:SetShow isPearlAppUser nil", "\236\139\160\236\138\185\234\182\140")
  if Panel_Chat_SubMenu == nil then
    return
  end
  if _ContentsOption_CH_Report == true then
    isGameManager = false
  end
  local bgSizeY = 165
  local buttonPosY = 160
  local gapY = 35
  local isCountryShow = true
  local isCountryOpen = _ContentsGroup_ChatBlock
  if isGameTypeJapan() == true then
    isCountryShow = false
  elseif isGameTypeNA() == true then
    isCountryShow = false
  end
  ToClient_updateAddFriendAllowed()
  if self._originBlockButtonPosY < 0 then
    self._originBlockButtonPosY = self._ui._buttonBlock:GetPosY()
  end
  if isPearlAppUser == true then
    self._ui._buttonWhisper:SetShow(false)
    self._ui._buttonAddFriend:SetShow(false)
    self._ui._buttonInviteParty:SetShow(false)
    self._ui._buttonInviteLargeParty:SetShow(false)
    self._ui._buttonInviteGuild:SetShow(false)
    self._ui._buttonInviteCompetition:SetShow(false)
    self._ui._buttonInviteVolunteer:SetShow(false)
    self._ui._buttonWinClose:SetShow(true)
    self._ui._buttonBlock:SetShow(true)
    self._ui._buttonBlockVote:SetShow(false)
    self._ui._buttonRecommand:SetShow(false)
    self._ui._buttonInviteMiniGameYacht:SetShow(false)
    bgSizeY = 100
    self._ui._buttonBlock:SetPosY(50)
    buttonPosY = 50 + gapY
  else
    self._ui._buttonWhisper:SetShow(true)
    self._ui._buttonAddFriend:SetShow(true)
    self._ui._buttonInviteParty:SetShow(true)
    self._ui._buttonInviteLargeParty:SetShow(true)
    self._ui._buttonInviteGuild:SetShow(true)
    self._ui._buttonInviteCompetition:SetShow(true)
    self._ui._buttonInviteVolunteer:SetShow(true)
    self._ui._buttonWinClose:SetShow(true)
    self._ui._buttonBlock:SetShow(true)
    self._ui._buttonBlockVote:SetShow(true)
    self._ui._buttonInviteMiniGameYacht:SetShow(_ContentsGroup_MiniGame_YachtDice_Match)
    self._ui._buttonBlock:SetPosY(self._originBlockButtonPosY)
    bgSizeY = 165
    if isGameManager == true then
      self._ui._buttonBlockVote:SetShow(false)
      self._ui._buttonRecommand:SetShow(false)
      self._ui._buttonReportChat:SetShow(false)
    else
      self._ui._buttonBlockVote:SetShow(isCountryShow)
      self._ui._buttonBlockVote:SetIgnore(not isCountryOpen)
      self._ui._buttonBlockVote:SetMonoTone(not isCountryOpen)
      self._ui._buttonRecommand:SetShow(isRecommand)
      self._ui._buttonReportChat:SetShow(true)
    end
    self._ui._buttonInviteParty:SetShow(isInviteParty)
    self._ui._buttonInviteGuild:SetShow(isInviteGuild)
    self._ui._buttonInviteCompetition:SetShow(isInviteCompetition)
    self._ui._buttonInviteParty:SetShow(false)
    self._ui._buttonInviteLargeParty:SetShow(false)
    local isEmptyParty = ToClient_IsPartyEmpty()
    if isEmptyParty == true then
      self._ui._buttonInviteParty:SetShow(true)
      if self.isLargePartyOpen then
        self._ui._buttonInviteLargeParty:SetShow(true)
      else
        self._ui._buttonInviteLargeParty:SetShow(false)
      end
    else
      local isPartyType = ToClient_GetPartyType()
      if false == self.isLargePartyOpen then
        isPartyType = 0
        self._ui._buttonInviteLargeParty:SetShow(false)
      end
      if 0 == isPartyType then
        self._ui._buttonInviteParty:SetShow(isInviteParty)
        self._ui._buttonInviteLargeParty:SetShow(false)
      elseif 1 == isPartyType then
        self._ui._buttonInviteLargeParty:SetShow(true)
        self._ui._buttonInviteParty:SetShow(false)
      end
    end
  end
  if self._ui._buttonBlockVote:GetShow() then
    self._ui._buttonBlockVote:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonInviteParty:GetShow() then
    self._ui._buttonInviteParty:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonInviteLargeParty:GetShow() then
    self._ui._buttonInviteLargeParty:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonInviteGuild:GetShow() then
    self._ui._buttonInviteGuild:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonInviteCompetition:GetShow() then
    self._ui._buttonInviteCompetition:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonInviteVolunteer:GetShow() then
    local isRightInviteVolunteer = false
    if _ContentsGroup_GuildAuthoritySeparation == true then
      isRightInviteVolunteer = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Volunteer)
    else
      isRightInviteVolunteer = PaGlobalFunc_ChatSubMenu_RightCheck(__eGuildRightType_Volunteer)
    end
    if true == _ContentsGroup_BattleFieldVolunteer and true == isRightInviteVolunteer then
      self._ui._buttonInviteVolunteer:SetPosY(buttonPosY)
      buttonPosY = buttonPosY + gapY
      bgSizeY = bgSizeY + gapY
    else
      self._ui._buttonInviteVolunteer:SetShow(false)
    end
  end
  if self._ui._buttonRecommand:GetShow() then
    self._ui._buttonRecommand:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
    self._ui._buttonRecommand:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_THUMBSUP_VOTECOUNT", "currentVoteCount", ToClient_GetThumbsUpVoteCount(), "maxVoteCount", ToClient_getMaxThumbsUpVoteCount()))
  end
  if self._ui._buttonInviteMiniGameYacht:GetShow() == true then
    self._ui._buttonInviteMiniGameYacht:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if self._ui._buttonReportChat:GetShow() == true then
    self._ui._buttonReportChat:SetPosY(buttonPosY)
    buttonPosY = buttonPosY + gapY
    bgSizeY = bgSizeY + gapY
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    self._ui._staticBg:SetText("\n" .. clickedUserNickName)
  else
    self._ui._staticBg:SetText(clickedUserNickName .. "\n" .. clickedName)
  end
  self._ui._staticBg:SetSize(self._ui._staticBg:GetSizeX(), bgSizeY)
  Panel_Chat_SubMenu:SetShow(true)
end
function PaGlobal_ChatSubMenu:SetPos(x, y)
  if Panel_Chat_SubMenu == nil then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if screenSizeX <= x + self._ui._staticBg:GetSizeX() then
    x = screenSizeX - self._ui._staticBg:GetSizeX()
  end
  if screenSizeY <= y + self._ui._staticBg:GetSizeY() then
    y = screenSizeY - self._ui._staticBg:GetSizeY()
  end
  Panel_Chat_SubMenu:SetPosX(x)
  Panel_Chat_SubMenu:SetPosY(y)
end
function PaGlobal_ChatSubMenuSetClickedInfoInit()
  local self = PaGlobal_ChatSubMenu
  if self == nil then
    return
  end
  self._currentPoolIndex = nil
  self._clickedMessageIndex = nil
  self._clickedName = nil
  self._clickedUserNickName = nil
  self._clickedMsg = nil
  self._senderUserNo = nil
  self._chatRoomNo = nil
  self._chatType = nil
  self._chatSendTime = nil
  self._chatSendServerTime = nil
  self._clickedUserId = nil
end
function PaGlobal_ChatSubMenuSetClickedInfo(currentPoolIndex, clickedMessageIndex, clickedName, clickedUserNickName, clickedMsg, senderUserNo, chatRoomNo, chatType, chatSendTime, chatSendServerTime, clickedUserId)
  local self = PaGlobal_ChatSubMenu
  if self == nil then
    return
  end
  UI.ASSERT_NAME(nil ~= currentPoolIndex, "PaGlobal_ChatSubMenuSetClickedInfo currentPoolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedMessageIndex, "PaGlobal_ChatSubMenuSetClickedInfo clickedMessageIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedName, "PaGlobal_ChatSubMenuSetClickedInfo clickedName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedUserNickName, "PaGlobal_ChatSubMenuSetClickedInfo clickedUserNickName nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= clickedMsg, "PaGlobal_ChatSubMenuSetClickedInfo clickedMsg nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= senderUserNo, "PaGlobal_ChatSubMenuSetClickedInfo senderUserNo nil", "\234\185\128\236\167\128\237\152\129")
  UI.ASSERT_NAME(nil ~= chatRoomNo, "PaGlobal_ChatSubMenuSetClickedInfo chatRoomNo nil", "\234\185\128\236\167\128\237\152\129")
  if chatType == nil or chatSendTime == nil or chatSendServerTime == nil then
    return
  end
  self._currentPoolIndex = currentPoolIndex
  self._clickedMessageIndex = clickedMessageIndex
  self._clickedName = clickedName
  self._clickedUserNickName = clickedUserNickName
  self._clickedMsg = clickedMsg
  self._senderUserNo = senderUserNo
  self._chatRoomNo = chatRoomNo
  self._chatType = chatType
  self._chatSendTime = chatSendTime
  self._chatSendServerTime = chatSendServerTime
  self._clickedUserId = clickedUserId
end
