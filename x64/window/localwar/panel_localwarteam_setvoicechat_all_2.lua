function PaGlobal_LocalWarVoiceChat_updateMember(content, key)
end
function PaGlobal_LocalWarVoiceChat_Close()
  if PaGlobal_LocalWarVoiceChat == nil then
    return
  end
  PaGlobal_LocalWarVoiceChat:prepareClose()
end
function PaGlobal_LocalWarVoiceChat_Open()
  if PaGlobal_LocalWarVoiceChat == nil then
    return
  end
  PaGlobal_LocalWarVoiceChat:prepareOpen()
end
function FromClient_EnterVoiceChatRoom()
  if _ContentsGroup_LocalWarVoiceChat == false or ToClient_IsOccupationModeInRedBattleField() == false then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_VOICE_NOTIFY_DESC"),
    functionYes = PaGlobalFunc_SetVoiceChat_All_Toggle,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_LocalWarVoiceChat_Update(deltaTime)
  if PaGlobal_LocalWarVoiceChat == nil then
    return
  end
  PaGlobal_LocalWarVoiceChat:updatePerFrame(deltaTime)
end
