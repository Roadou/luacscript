function PaGlobalFunc_SeasonPassAndRoadMap_IsOpenedCotentsOption()
  if isGameTypeGT() == true then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164! \237\153\149\236\157\184 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164! \237\153\149\236\157\184 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return false
  end
  return selfPlayer:isSeasonCharacter()
end
function PaGlobalFunc_SeasonPassAndRoadMap_Open()
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  if PaGlobalFunc_SeasonPassAndRoadMap_IsOpenedCotentsOption() == false then
    return
  end
  if ToClient_isAllSeasonPassLoaded() == false then
    return false
  end
  self:prepareOpen()
end
function PaGlobalFunc_SeasonPassAndRoadMap_OpenAndClose()
  if PaGlobalFunc_SeasonPassAndRoadMap_GetShow ~= nil and PaGlobalFunc_SeasonPassAndRoadMap_GetShow() == true then
    PaGlobalFunc_SeasonPassAndRoadMap_Close(false)
  else
    PaGlobalFunc_SeasonPassAndRoadMap_Open()
  end
end
function PaGlobalFunc_SeasonPassAndRoadMap_Close(isSeasonPassDontHideAnimation)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self:prepareClose(isSeasonPassDontHideAnimation)
end
function PaGlobalFunc_SeasonPassAndRoadMap_GetShow()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  return Panel_Window_BeginnerRoadmap:GetShow()
end
function PaGlobalFunc_SeasonPassAndRoadMap_ShowEvent()
  local panel = Panel_Window_BeginnerRoadmap
  if panel == nil then
    return
  end
  local resizedRatioX = 0
  local resizedRatioY = 0
  if ToClient_isConsole() == true then
    local uioffset = ToClient_GetConsoleUIOffset()
    resizedRatioX = getScreenSizeX() * uioffset
    resizedRatioY = getScreenSizeY() * uioffset
  end
  local blackSpiritArea = UI.getChildControl(panel, "Static_BlackspiritPass")
  local blackSpiritAreaSizeX = blackSpiritArea:GetSizeX()
  local showMoveAni = panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showMoveAni:SetStartPosition(-blackSpiritAreaSizeX, resizedRatioY)
  showMoveAni:SetEndPosition(resizedRatioX, resizedRatioY)
  showMoveAni.IsChangeChild = true
  panel:CalcUIAniPos(showMoveAni)
  showMoveAni:SetDisableWhileAni(true)
  showMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_SeasonPassAndRoadMap_HideEvent()
  local panel = Panel_Window_BeginnerRoadmap
  if panel == nil then
    return
  end
  local resizedRatioX = 0
  local resizedRatioY = 0
  if ToClient_isConsole() == true then
    local uioffset = ToClient_GetConsoleUIOffset()
    resizedRatioX = getScreenSizeX() * uioffset
    resizedRatioY = getScreenSizeY() * uioffset
  end
  local blackSpiritArea = UI.getChildControl(panel, "Static_BlackspiritPass")
  local blackSpiritAreaSizeX = blackSpiritArea:GetSizeX()
  local hideMoveAni = panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  hideMoveAni:SetStartPosition(resizedRatioX, resizedRatioY)
  hideMoveAni:SetEndPosition(-blackSpiritAreaSizeX, resizedRatioY)
  hideMoveAni.IsChangeChild = true
  panel:CalcUIAniPos(hideMoveAni)
  hideMoveAni:SetDisableWhileAni(true)
  hideMoveAni:SetHideAtEnd(true)
  hideMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_BeginnerRoadMap_Open(isFullScreenMode)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self:roadMap_open(isFullScreenMode)
end
function PaGlobalFunc_BeginnerRoadMap_Close()
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self:roadMap_close()
end
function PaGlobalFunc_BeginnerRoadMap_GetShow()
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return false
  end
  return self._ui._stc_roadMapMain:GetShow()
end
function HandleEventLUp_RoadMap_HelpChat()
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  if _ContentsGroup_ChannelChat == false then
    UI.ASSERT_NAME(false, "\235\140\128\237\153\148 \234\183\184\235\163\185 \236\187\168\237\133\144\236\184\160 \236\152\181\236\133\152\236\157\180 \235\139\171\237\152\128\236\158\136\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentChatRoomInfo = ToClient_getMyChannelChatRoom(__eChannelChatRoomType_System)
  if currentChatRoomInfo == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\134\141\237\149\156 \235\140\128\237\153\148\234\183\184\235\163\185 \236\160\149\235\179\180\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isAlreadySelectChatRoom = false
  local targetChatRoomName = PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELCHAT_ROOM_NAME_01")
  if targetChatRoomName == currentChatRoomInfo:getRoomName() then
    isAlreadySelectChatRoom = true
  else
    isAlreadySelectChatRoom = false
  end
  local function roadMapHelpChatFunc_yse()
    HandleEventMsgBoxYes_RoadMap_HelpChat(isAlreadySelectChatRoom)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_PLAYROADMAP_HELP"),
    content = nil,
    functionYes = roadMapHelpChatFunc_yse,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if isAlreadySelectChatRoom == true then
    messageBoxData.content = PAGetString(Defines.StringSheet_GAME, "LUA_ROADMAP_CHAT_MSG_0")
  else
    messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROADMAP_CHAT_MSG_1", "chatgroup", currentChatRoomInfo:getRoomName())
  end
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventMsgBoxYes_RoadMap_HelpChat(isAlreadySelect)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil or isAlreadySelect == nil then
    return
  end
  PaGlobalFunc_SeasonPassAndRoadMap_Close()
  if isAlreadySelect == true then
    Process_UIMode_CommonWindow_Chatting()
    ChatInput_ChangeChatType_Immediately(CppEnums.ChatType.Channel)
  else
    PaGlobalFunc_ChannelChat_OpenBySelect(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELCHAT_ROOM_NAME_01"))
  end
end
function HandleEventLUp_RoadMap_ShowDetailTolltip(index)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self:updateDetailToolip(index)
end
function HandleEventLUp_RoadMap_ClickEventButtom(index)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self:processRoadMapEvent(index)
end
function HandleEventLUp_RoadMap_ClickAdventureNote(index)
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  local dataKey = ToClient_getBeginnerRoadMapDataKey(index)
  local dataSSW = ToClient_getBeginnerRoadMapStaticStatusWrapper(dataKey)
  if dataSSW == nil then
    return
  end
  local noteUrl = dataSSW:getAdventureNoteURL()
  if noteUrl == nil or noteUrl == "" then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  InputMLUp_ExpirienceWiki_All_Close()
  PaGlobal_ExpirienceWiki_All_SetDirectLink(noteUrl)
  PaGlobal_ExpirienceWiki_All_Open()
end
function FromClient_BlackspiritPassAndRoadMap_ResizePanel()
  local panel = Panel_Window_BeginnerRoadmap
  if panel == nil then
    return
  end
  panel:SetSize(getScreenSizeX(), getScreenSizeY())
  panel:ComputePos()
  FromClient_BlackspiritPass_ResizePanel()
  FromClient_RoadMap_ResizePanel()
end
function FromClient_RoadMap_ResizePanel()
  local self = PaGlobal_BeginnerRoadMap
  if self == nil then
    return
  end
  self._originalRoadMapSizeX = getScreenSizeX() - PaGlobal_BlackspiritPass._ui._stc_blackSpiritPassMain:GetSizeX()
  self._originalRoadMapSizeY = getScreenSizeY()
end
