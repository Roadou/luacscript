function PaGlobal_VoiceChat_Talker_New:initialize()
  if true == PaGlobal_VoiceChat_Talker_New._initialize then
    return
  end
  self._ui._arr_control = {}
  local originalInfo = {}
  local control = UI.getChildControl(Panel_VoiceChat_Talker_New, "Static_Templete")
  local name = UI.getChildControl(control, "StaticText_Name_Other")
  originalInfo._control = control
  originalInfo._stc_name = name
  self._ui._arr_control[0] = originalInfo
  originalInfo._control:SetSpanSize(5, 5)
  local sizeY = originalInfo._control:GetSizeY()
  originalInfo._control:SetShow(false)
  for ii = 1, 9 do
    local info = {}
    info._control = UI.cloneControl(control, Panel_VoiceChat_Talker_New, "Static_Templete_" .. tostring(ii))
    info._stc_name = UI.getChildControl(info._control, "StaticText_Name_Other")
    info._control:SetShow(false)
    info._stc_name:SetText(tostring(ii))
    info._control:SetSpanSize(5, ii * sizeY + 5)
    self._ui._arr_control[ii] = info
  end
  PaGlobal_VoiceChat_Talker_New:registEventHandler()
  PaGlobal_VoiceChat_Talker_New:validate()
  PaGlobal_VoiceChat_Talker_New._initialize = true
end
function PaGlobal_VoiceChat_Talker_New:registEventHandler()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  registerEvent("FromClient_ListenOnOffPAVoiceChat", "PaGlobal_VoiceChat_Talker_New_ListenOnOff")
  registerEvent("FromClient_SpeakOnOffPAVoiceChat", "PaGlobal_VoiceChat_Talker_New_SpeakOnOff")
  registerEvent("FromClient_LeavePAVoiceChat", "PaGlobal_VoiceChat_Talker_New_Close")
  Panel_VoiceChat_Talker_New:RegisterUpdateFunc("PaGlobal_VoiceChat_Talker_New_Update")
end
function PaGlobal_VoiceChat_Talker_New:prepareOpen()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self._selfPlayerUserNickname = selfPlayer:getUserNickname()
  PaGlobal_VoiceChat_Talker_New:open()
end
function PaGlobal_VoiceChat_Talker_New:open()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  Panel_VoiceChat_Talker_New:SetShow(true)
end
function PaGlobal_VoiceChat_Talker_New:prepareClose()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  PaGlobal_VoiceChat_Talker_New:close()
end
function PaGlobal_VoiceChat_Talker_New:close()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
  Panel_VoiceChat_Talker_New:SetShow(false)
end
function PaGlobal_VoiceChat_Talker_New:update()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
end
function PaGlobal_VoiceChat_Talker_New:perFrameUpdate(delta)
  if Panel_VoiceChat_Talker_New == nil then
    return
  end
  if Panel_VoiceChat_Talker_New:GetShow() == false then
    return
  end
  for ii = 0, 9 do
    self._ui._arr_control[ii]._control:SetShow(false)
  end
  local poolIndex = 0
  if ToClient_selfPlayerIsTalking() == true then
    self._ui._arr_control[poolIndex]._stc_name:SetText(self._selfPlayerUserNickname)
    self._ui._arr_control[poolIndex]._stc_name:SetFontColor(Defines.Color.C_FFF5BA3A)
    self._ui._arr_control[poolIndex]._control:SetShow(true)
    poolIndex = poolIndex + 1
  end
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  if memberCount == 0 then
    return
  end
  for ii = 0, memberCount - 1 do
    local info = ToClient_getVoiceChatRoomMemberInfo(ii)
    if info ~= nil and info:isSpeaking() == true then
      self._ui._arr_control[poolIndex]._stc_name:SetText(info:getUserNickName())
      self._ui._arr_control[poolIndex]._stc_name:SetFontColor(Defines.Color.C_FFFFEDD4)
      self._ui._arr_control[poolIndex]._control:SetShow(true)
      poolIndex = poolIndex + 1
      if poolIndex == 10 then
        return
      end
    end
  end
end
function PaGlobal_VoiceChat_Talker_New:validate()
  if nil == Panel_VoiceChat_Talker_New then
    return
  end
end
