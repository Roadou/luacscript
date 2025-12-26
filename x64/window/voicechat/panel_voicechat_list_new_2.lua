function HandleEventLUp_ContentsName_updateAppleList()
  if nil == Panel_VoiceChat_List_New then
    return
  end
end
function PaGlobal_VoiceChat_List_New_Content_Update(control, key)
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  PaGlobal_VoiceChat_List_New:contentUpdate(control, key)
end
function PaGlobal_VoiceChat_List_New_Open()
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  PaGlobal_VoiceChat_List_New:prepareOpen()
end
function PaGlobal_VoiceChat_List_New_Close()
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  if PaGlobal_VoiceChat_List_New._ui._slider_personalVolume_BG:GetShow() == true then
    PaGlobal_VoiceChat_List_New._ui._slider_personalVolume_BG:SetShow(false)
    return
  end
  if PaGlobal_VoiceChat_List_New._ui._stc_subMenu_BG:GetShow() == true then
    PaGlobal_VoiceChat_List_New._ui._stc_subMenu_BG:SetShow(false)
    return
  end
  PaGlobal_VoiceChat_List_New:prepareClose()
end
function HandleEventLUp_VoiceChat_List_New_CheckPopupUI()
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  if Panel_VoiceChat_List_New:IsUISubApp() == true then
    Panel_VoiceChat_List_New:CloseUISubApp()
    return
  end
  Panel_VoiceChat_List_New:OpenUISubApp()
end
function FromClient_UpdatePAVoiceChat()
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  if Panel_VoiceChat_List_New == nil then
    return
  end
  if Panel_VoiceChat_List_New:GetShow() == false then
    return
  end
  PaGlobal_VoiceChat_List_New:updateMember()
end
function PaGlobal_VoiceChatList_New_Update(deltaTime)
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  PaGlobal_VoiceChat_List_New:updatePerFrame(deltaTime)
end
function FromClient_PerposeEnterPAVoiceChatRoom(chatType)
  local function doYes()
    ToClient_EnterPAVoiceChat(chatType)
  end
  local chatTypeName = " "
  if chatType == __ePAVoiceChatType_eGuild then
    chatTypeName = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_GUILD")
  elseif chatType == __ePAVoiceChatType_eRedBattleFieldOccupy then
    chatTypeName = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_REDBATTLE")
  elseif chatType == __ePAVoiceChatType_eSolrare then
    chatTypeName = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_SOLRARE")
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PAVOICECHAT_PERPOSE_ENTER_ROOM", "chatType", tostring(chatTypeName))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = doYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function FromClient_EnterPAVoiceChat(chatType)
  if chatType == __ePAVoiceChatType_eRedBattleFieldOccupy or chatType == __ePAVoiceChatType_eSolrare then
    PaGlobal_VoiceChat_List_New_Open()
    return
  end
  if Panel_VoiceChat_List_New:GetShow() == true then
    PaGlobal_VoiceChat_List_New_Open()
  end
end
function FromClient_SpeakOnOffPAVoiceChat_VoiceChat_List(bFlag)
  if Panel_VoiceChat_List_New:GetShow() == false then
    return
  end
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  PaGlobal_VoiceChat_List_New._ui._chk_myMic:SetCheck(bFlag)
  if bFlag == true then
    audioPostEvent_SystemUi(0, 26)
  else
    audioPostEvent_SystemUi(0, 27)
  end
end
function FromClient_ListenOnOffPAVoiceChat_VoiceChat_List(bFlag)
  if Panel_VoiceChat_List_New:GetShow() == false then
    return
  end
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  PaGlobal_VoiceChat_List_New._ui._chk_myListen:SetCheck(bFlag)
  if bFlag == true then
    audioPostEvent_SystemUi(0, 26)
  else
    audioPostEvent_SystemUi(0, 27)
  end
end
