function HandleEventLUp_VoiceChat_Setting_New_ToggleList()
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  PaGlobal_VoiceChat_Setting_New._ui._combo_channel:ToggleListbox()
end
function HandleEventLUp_VoiceChat_Setting_New_SelectList()
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  local curFilterIdx = PaGlobal_VoiceChat_Setting_New._ui._combo_channel:GetSelectIndex()
  if PaGlobal_VoiceChat_Setting_New._arr_comboListValue[curFilterIdx] == nil then
    return
  end
  ToClient_EnterPAVoiceChat(PaGlobal_VoiceChat_Setting_New._arr_comboListValue[curFilterIdx])
end
function PaGlobal_VoiceChat_Setting_New_Close()
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  PaGlobal_VoiceChat_Setting_New:prepareClose()
end
function PaGlobal_VoiceChat_Setting_New_Open()
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  PaGlobal_VoiceChat_Setting_New:prepareOpen()
end
function FromClient_EnterPAVoiceChat_VoiceChat_Setting()
  if Panel_VoiceChat_Setting_New:GetShow() == false then
    return
  end
  PaGlobal_VoiceChat_Setting_New_Open()
end
function FromClient_SpeakOnOffPAVoiceChat_VoiceChat_Setting(bFlag)
  if Panel_VoiceChat_Setting_New:GetShow() == false then
    return
  end
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  PaGlobal_VoiceChat_Setting_New._ui._chk_MICOnOff:SetCheck(bFlag)
  if Panel_VoiceChat_List_New:GetShow() == false then
    if bFlag == true then
      audioPostEvent_SystemUi(0, 26)
    else
      audioPostEvent_SystemUi(0, 27)
    end
  end
end
function FromClient_ListenOnOffPAVoiceChat_VoiceChat_Setting(bFlag)
  if Panel_VoiceChat_Setting_New:GetShow() == false then
    return
  end
  if PaGlobal_VoiceChat_Setting_New == nil then
    return
  end
  PaGlobal_VoiceChat_Setting_New._ui._chk_speakerOnOff:SetCheck(bFlag)
  if Panel_VoiceChat_List_New:GetShow() == false then
    if bFlag == true then
      audioPostEvent_SystemUi(0, 26)
    else
      audioPostEvent_SystemUi(0, 27)
    end
  end
end
