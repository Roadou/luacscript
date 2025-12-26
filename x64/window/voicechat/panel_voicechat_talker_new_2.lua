function PaGlobal_VoiceChat_Talker_New_Update(delta)
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  if PaGlobal_VoiceChat_Talker_New == nil then
    return
  end
  PaGlobal_VoiceChat_Talker_New:perFrameUpdate(delta)
end
function PaGlobal_VoiceChat_Talker_New_ListenOnOff(flag)
  if PaGlobal_VoiceChat_Talker_New == nil then
    return
  end
  if flag == true then
    PaGlobal_VoiceChat_Talker_New_Open()
  else
    if ToClient_isVoiceChatMic() == true then
      return
    end
    PaGlobal_VoiceChat_Talker_New_Close()
  end
end
function PaGlobal_VoiceChat_Talker_New_SpeakOnOff(flag)
  if PaGlobal_VoiceChat_Talker_New == nil then
    return
  end
  if flag == true then
    PaGlobal_VoiceChat_Talker_New_Open()
  else
    if ToClient_isVoiceChatListen() == true then
      return
    end
    PaGlobal_VoiceChat_Talker_New_Close()
  end
end
function PaGlobal_VoiceChat_Talker_New_Open()
  if PaGlobal_VoiceChat_Talker_New == nil then
    return
  end
  PaGlobal_VoiceChat_Talker_New:prepareOpen()
end
function PaGlobal_VoiceChat_Talker_New_Close()
  if PaGlobal_VoiceChat_Talker_New == nil then
    return
  end
  PaGlobal_VoiceChat_Talker_New:prepareClose()
end
function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
end
function FromClient_VoiceChat_Talker_New()
  if ToClient_isVoiceChatListen() == false and ToClient_isVoiceChatMic() == false then
    return
  end
  PaGlobal_VoiceChat_Talker_New_Open()
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
