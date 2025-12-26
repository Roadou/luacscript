function PaGlobal_LocalWarVoiceChat:initialize()
  if true == PaGlobal_LocalWarVoiceChat._initialize then
    return
  end
  local titleBar = UI.getChildControl(Panel_LocalWarTeam_SetVoiceChat_All, "StaticText_SetVoiceChatTitle")
  self._ui._btn_Close = UI.getChildControl(titleBar, "Button_WinClose")
  self._ui._listening_Volume = UI.getChildControl(Panel_LocalWarTeam_SetVoiceChat_All, "Static_Listening_VolumeBG")
  self._ui._listening_VolumeSlider = UI.getChildControl(self._ui._listening_Volume, "Slider_ListeningVolume")
  self._ui._listening_VolumeSliderBtn = UI.getChildControl(self._ui._listening_VolumeSlider, "Slider_MicVol_Button")
  self._ui._listening_VolumeClose = UI.getChildControl(self._ui._listening_Volume, "Button_VolumeSetClose")
  self._ui._listening_VolumeButton = UI.getChildControl(self._ui._listening_Volume, "Checkbox_SpeakerIcon")
  self._ui._listening_VolumeValue = UI.getChildControl(self._ui._listening_Volume, "StaticText_SpeakerVolumeValue")
  self._ui._arr_Teammate_Info = {}
  local original = {}
  local temp_control = UI.getChildControl(Panel_LocalWarTeam_SetVoiceChat_All, "Static_Teammate_Origin")
  local startSpanX = temp_control:GetSpanSize().x
  local startSpanY = temp_control:GetSpanSize().y
  local originSizeX = temp_control:GetSizeX()
  local originSizeY = temp_control:GetSizeY()
  original._userNo = -1
  original._control = temp_control
  original._stc_name = UI.getChildControl(temp_control, "StaticText_Name")
  original._icon_speaker = UI.getChildControl(temp_control, "Static_Spearker_Icon")
  original._chk_button = UI.getChildControl(temp_control, "CheckButton_1")
  self._ui._arr_Teammate_Info[0] = original
  for ii = 1, 29 do
    local info = {}
    info._userNo = -1
    info._control = UI.cloneControl(temp_control, Panel_LocalWarTeam_SetVoiceChat_All, "Static_Teammate_" .. tostring(ii))
    info._stc_name = UI.getChildControl(info._control, "StaticText_Name")
    info._icon_speaker = UI.getChildControl(info._control, "Static_Spearker_Icon")
    info._chk_button = UI.getChildControl(info._control, "CheckButton_1")
    local col = math.floor(ii / 10)
    local row = ii % 10
    info._control:SetSpanSize(startSpanX + col * originSizeX, startSpanY + row * originSizeY)
    info._control:SetShow(true)
    info._stc_name:SetText(tostring)
    self._ui._arr_Teammate_Info[ii] = info
  end
  PaGlobal_LocalWarVoiceChat:registEventHandler()
  PaGlobal_LocalWarVoiceChat:validate()
  PaGlobal_LocalWarVoiceChat._initialize = true
end
function PaGlobal_LocalWarVoiceChat:updatePerFrame(deltaTime)
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
  if Panel_LocalWarTeam_SetVoiceChat_All:GetShow() == false then
    return
  end
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  for ii = 0, memberCount - 1 do
    local info = ToClient_getVoiceChatRoomMemberInfo(ii)
    if info ~= nil then
      self._ui._arr_Teammate_Info[ii]._control:SetShow(info:isSpeaking())
    end
  end
end
function PaGlobal_LocalWarVoiceChat:registEventHandler()
  if nil == Panel_LocalWarTeam_SetVoiceChat_All then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarVoiceChat_Close()")
  self._ui._listening_VolumeClose:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarVoiceChat:closeVolume()")
  Panel_LocalWarTeam_SetVoiceChat_All:RegisterUpdateFunc("PaGlobal_LocalWarVoiceChat_Update")
  registerEvent("FromClient_EnterVoiceChatRoom", "FromClient_EnterVoiceChatRoom")
end
function PaGlobal_LocalWarVoiceChat:prepareOpen()
  if nil == Panel_LocalWarTeam_SetVoiceChat_All then
    return
  end
  for ii = 0, 29 do
    self._ui._arr_Teammate_Info[ii]._userNo = -1
    self._ui._arr_Teammate_Info[ii]._control:SetShow(false)
    self._ui._arr_Teammate_Info[ii]._control:SetIgnore(false)
  end
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  for ii = 0, memberCount - 1 do
    local info = ToClient_getVoiceChatRoomMemberInfo(ii)
    if info ~= nil then
      self._ui._arr_Teammate_Info[ii]._userNo = info._userNo
      self._ui._arr_Teammate_Info[ii]._stc_name:SetText(info:getCharacterName())
      self._ui._arr_Teammate_Info[ii]._control:SetShow(true)
      self._ui._arr_Teammate_Info[ii]._chk_button:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarVoiceChat:controlVolume(" .. tostring(ii) .. ")")
    end
  end
  self._ui._listening_Volume:SetShow(false)
  PaGlobal_LocalWarVoiceChat:open()
end
function PaGlobal_LocalWarVoiceChat:open()
  if nil == Panel_LocalWarTeam_SetVoiceChat_All then
    return
  end
  Panel_LocalWarTeam_SetVoiceChat_All:SetShow(true)
end
function PaGlobal_LocalWarVoiceChat:prepareClose()
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
  PaGlobal_LocalWarVoiceChat:closeVolume()
  PaGlobal_LocalWarVoiceChat:close()
end
function PaGlobal_LocalWarVoiceChat:close()
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
  Panel_LocalWarTeam_SetVoiceChat_All:SetShow(false)
end
function PaGlobal_LocalWarVoiceChat:update()
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
end
function PaGlobal_LocalWarVoiceChat:resize()
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
end
function PaGlobal_LocalWarVoiceChat:validate()
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
  self._ui._btn_Close:isValidate()
  self._ui._listening_Volume:isValidate()
  self._ui._listening_VolumeSlider:isValidate()
  self._ui._listening_VolumeSliderBtn:isValidate()
  self._ui._listening_VolumeClose:isValidate()
  self._ui._listening_VolumeButton:isValidate()
  self._ui._listening_VolumeValue:isValidate()
end
function PaGlobal_LocalWarVoiceChat:controlVolume(index)
  if Panel_LocalWarTeam_SetVoiceChat_All == nil then
    return
  end
  if self._ui._arr_Teammate_Info[index] == nil then
    return
  end
  if self._ui._arr_Teammate_Info[index]._control == nil then
    return
  end
  local volume = ToClient_VoiceChatGetVolume(self._ui._arr_Teammate_Info[index]._userNo)
  self._ui._listening_VolumeSlider:SetControlPos(volume)
  self._ui._listening_Volume:SetPosX(self._ui._arr_Teammate_Info[index]._control:GetPosX() + self._ui._arr_Teammate_Info[index]._control:GetSizeX() + 20)
  self._ui._listening_Volume:SetPosY(self._ui._arr_Teammate_Info[index]._control:GetPosY())
  self._ui._listening_Volume:SetShow(true)
  self._ui._listening_VolumeSliderBtn:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarVoiceChat:updateVolume(" .. tostring(index) .. ")")
  self._ui._listening_VolumeSliderBtn:addInputEvent("Mouse_LPress", "PaGlobal_LocalWarVoiceChat:updateVolume(" .. tostring(index) .. ")")
end
function PaGlobal_LocalWarVoiceChat:updateVolume(index)
  if nil == Panel_LocalWarTeam_SetVoiceChat_All then
    return
  end
  if self._ui._listening_Volume:GetShow() == false then
    return
  end
  local volume = self._ui._listening_VolumeSlider:GetControlPos()
  volume = math.ceil(volume * 100)
  ToClient_VoiceChatChangeVolume(__eVoiceChatType_Localwar, self._ui._arr_Teammate_Info[index]._userNo, volume)
end
function PaGlobal_LocalWarVoiceChat:closeVolume()
  self._ui._listening_VolumeSliderBtn:addInputEvent("Mouse_LUp", "")
  self._ui._listening_VolumeSliderBtn:addInputEvent("Mouse_LPress", "")
  self._ui._listening_Volume:SetShow(false)
end
