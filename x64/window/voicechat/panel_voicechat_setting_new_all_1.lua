function PaGlobal_VoiceChat_Setting_New:initialize()
  if true == PaGlobal_VoiceChat_Setting_New._initialize then
    return
  end
  self._ui._stc_insideBG = UI.getChildControl(Panel_VoiceChat_Setting_New, "Static_InsideBg")
  self._ui._combo_channel = UI.getChildControl(self._ui._stc_insideBG, "Combobox_Channel")
  self._ui._combo_channel_List = UI.getChildControl(self._ui._combo_channel, "Combobox_List")
  self._ui._chk_speakerOnOff = UI.getChildControl(self._ui._stc_insideBG, "CheckButton_SpeakerOnOff")
  self._ui._chk_MICOnOff = UI.getChildControl(self._ui._stc_insideBG, "CheckButton_MICOnOff")
  self._ui._chk_pushToTalk = UI.getChildControl(self._ui._stc_insideBG, "CheckButton_ClickToTalk")
  self._ui._slider_speaker = UI.getChildControl(self._ui._stc_insideBG, "Slider_Speaker")
  self._ui._slider_speaker_Text = UI.getChildControl(self._ui._slider_speaker, "StaticText_Value")
  self._ui._slider_speaker_Btn = UI.getChildControl(self._ui._slider_speaker, "Slider_Button")
  self._ui._slider_speaker_PadBtn = UI.getChildControl(self._ui._slider_speaker, "Slider_DisplayButton")
  self._ui._slider_MIC = UI.getChildControl(self._ui._stc_insideBG, "Slider_MIC")
  self._ui._slider_MIC_Text = UI.getChildControl(self._ui._slider_MIC, "StaticText_Value")
  self._ui._slider_MIC_Btn = UI.getChildControl(self._ui._slider_MIC, "Slider_Button")
  self._ui._slider_MIC_PadBtn = UI.getChildControl(self._ui._slider_MIC, "Slider_DisplayButton")
  self._ui._slider_MICSense = UI.getChildControl(self._ui._stc_insideBG, "Slider_MICSence")
  self._ui._slider_MICSense_Text = UI.getChildControl(self._ui._slider_MICSense, "StaticText_Value")
  self._ui._slider_MICSense_Btn = UI.getChildControl(self._ui._slider_MICSense, "Slider_Button")
  self._ui._slider_MICSense_PadBtn = UI.getChildControl(self._ui._slider_MICSense, "Slider_DisplayButton")
  self._ui._btn_confirm = UI.getChildControl(Panel_VoiceChat_Setting_New, "Button_Confirm")
  self._ui._btn_cancel = UI.getChildControl(Panel_VoiceChat_Setting_New, "Button_Cancel")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_VoiceChat_Setting_New, "Static_KeyGuide_Console")
  self._ui._txt_keyGuideY = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_Confirm_Console")
  self._ui._txt_keyGuideA = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_Select_Console")
  self._ui._txt_keyGuideB = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_Close_Console")
  local panelTitle = UI.getChildControl(Panel_VoiceChat_Setting_New, "StaticText_SetVoiceChatTitle")
  self._ui._btn_close = UI.getChildControl(panelTitle, "Button_WinClose")
  self._isPadMode = _ContentsGroup_UsePadSnapping
  if self._isPadMode == true then
    self._ui._btn_confirm:SetShow(false)
    self._ui._btn_cancel:SetShow(false)
    self._ui._stc_keyGuide:SetShow(true)
  end
  PaGlobal_VoiceChat_Setting_New:registEventHandler()
  PaGlobal_VoiceChat_Setting_New:validate()
  PaGlobal_VoiceChat_Setting_New._initialize = true
end
function PaGlobal_VoiceChat_Setting_New:registEventHandler()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
  self._ui._chk_speakerOnOff:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New:setSpeakerOnOff()")
  self._ui._chk_MICOnOff:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New:setMICOnOff()")
  self._ui._chk_pushToTalk:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New:setPushToTalkOnOff()")
  self._ui._combo_channel:GetListControl():AddSelectEvent("HandleEventLUp_VoiceChat_Setting_New_SelectList()")
  self._ui._combo_channel:addInputEvent("Mouse_LUp", "HandleEventLUp_VoiceChat_Setting_New_ToggleList()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New_Close()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New_Close()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New_Close()")
  self._ui._slider_MIC:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateMICVolume()")
  self._ui._slider_MIC_Btn:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateMICVolume()")
  self._ui._slider_MICSense:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateMICSenseVolume()")
  self._ui._slider_MICSense_Btn:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateMICSenseVolume()")
  self._ui._slider_speaker:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateSpeakerVolume()")
  self._ui._slider_speaker_Btn:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_Setting_New:updateSpeakerVolume()")
  registerEvent("FromClient_EnterPAVoiceChat", "FromClient_EnterPAVoiceChat_VoiceChat_Setting")
  registerEvent("FromClient_SpeakOnOffPAVoiceChat", "FromClient_SpeakOnOffPAVoiceChat_VoiceChat_Setting")
  registerEvent("FromClient_ListenOnOffPAVoiceChat", "FromClient_ListenOnOffPAVoiceChat_VoiceChat_Setting")
  if self._isPadMode == true then
    Panel_VoiceChat_Setting_New:SetSize(Panel_VoiceChat_Setting_New:GetSizeX(), 560)
    Panel_VoiceChat_Setting_New:ComputePosAllChild()
    self._ui._stc_insideBG:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_VoiceChat_Setting_New_Close()")
    self._ui._stc_insideBG:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_VoiceChat_Setting_New_Close()")
  else
    Panel_VoiceChat_Setting_New:SetSize(Panel_VoiceChat_Setting_New:GetSizeX(), 625)
    Panel_VoiceChat_Setting_New:ComputePosAllChild()
  end
end
function PaGlobal_VoiceChat_Setting_New:prepareOpen()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
  if _ContentsGroup_VoiceChat == false then
    return
  end
  if Panel_VoiceChat_Setting_New:GetShow() == true then
    return
  end
  self._ui._chk_MICOnOff:SetCheck(ToClient_isVoiceChatMic())
  self._ui._chk_speakerOnOff:SetCheck(ToClient_isVoiceChatListen())
  self._ui._chk_pushToTalk:SetCheck(ToClient_isVoiceChatPushToTalk())
  local MICVolume = math.ceil(ToClient_getMicVolume())
  local speakerVolume = math.ceil(ToClient_getSpeakerVolume())
  local MICSensitivity = math.ceil(ToClient_getMicSensitivity())
  self._ui._slider_MIC:SetControlPos(MICVolume)
  self._ui._slider_MICSense:SetControlPos(MICSensitivity)
  self._ui._slider_speaker:SetControlPos(speakerVolume)
  self._ui._slider_speaker_Text:SetText(tostring(speakerVolume))
  self._ui._slider_MIC_Text:SetText(tostring(MICVolume))
  self._ui._slider_MICSense_Text:SetText(tostring(MICSensitivity))
  self._ui._combo_channel:DeleteAllItem(0)
  self._ui._combo_channel:setListTextHorizonCenter()
  PaGlobal_VoiceChat_Setting_New:updateComboList()
  self._isSetUpPTT = true
  local keyCustomStr = keyCustom_GetString_ActionKey(49)
  if keyCustomStr == nil or keyCustomStr == "" then
    keyCustomStr = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHATT_PUSHTOTALK")
    self._isSetUpPTT = false
  end
  self._ui._chk_pushToTalk:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VOICECHAT_PUSHTOTALK", "pushtotalk", keyCustomStr))
  if self._isPadMode == true then
    self:setAlignKeyGuide()
    Panel_VoiceChat_Setting_New:ignorePadSnapMoveToOtherPanel()
  end
  PaGlobal_VoiceChat_Setting_New:open()
end
function PaGlobal_VoiceChat_Setting_New:open()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
  Panel_VoiceChat_Setting_New:SetShow(true)
end
function PaGlobal_VoiceChat_Setting_New:prepareClose()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
  if true == self._ui._combo_channel:isClicked() then
    self._ui._combo_channel:ToggleListbox()
    return
  end
  PaGlobal_VoiceChat_Setting_New:close()
end
function PaGlobal_VoiceChat_Setting_New:close()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
  Panel_VoiceChat_Setting_New:SetShow(false)
end
function PaGlobal_VoiceChat_Setting_New:update()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
end
function PaGlobal_VoiceChat_Setting_New:validate()
  if nil == Panel_VoiceChat_Setting_New then
    return
  end
end
function PaGlobal_VoiceChat_Setting_New:setAlignKeyGuide()
  local keyGuides = {
    self._ui._txt_keyGuideY,
    self._ui._txt_keyGuideA,
    self._ui._txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_VoiceChat_Setting_New:setMICOnOff()
  local isCheck = self._ui._chk_MICOnOff:IsCheck()
  if ToClient_IsConnectedMic() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MICROPHONE_CONNECTION_NOTIFY"))
    self._ui._chk_MICOnOff:SetCheck(not isCheck)
    return
  end
  if ToClient_isLoggedInVoiceChatServer() == false or ToClient_getCurrentPAVoiceChatRoom() == __ePAVoiceChatType_eCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
    self._ui._chk_MICOnOff:SetCheck(not isCheck)
    return
  end
  ToClient_setMicOnOff(isCheck)
end
function PaGlobal_VoiceChat_Setting_New:setPushToTalkOnOff()
  local doYes = function()
    PaGlobal_GameOption_All:Open()
    PaGlobal_GameOption_All:GoCategory("Interface", "Function")
  end
  local isCheck = self._ui._chk_pushToTalk:IsCheck()
  if self._isSetUpPTT == false then
    self._ui._chk_pushToTalk:SetCheck(not isCheck)
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHATT_PUSHTOTALK_POPUP")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxMemo,
      functionYes = doYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "top")
    self:prepareClose()
    return
  end
  ToClient_setPushToTalkOnOff(isCheck)
end
function PaGlobal_VoiceChat_Setting_New:setSpeakerOnOff()
  local isCheck = self._ui._chk_speakerOnOff:IsCheck()
  if ToClient_isLoggedInVoiceChatServer() == false or ToClient_getCurrentPAVoiceChatRoom() == __ePAVoiceChatType_eCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
    self._ui._chk_speakerOnOff:SetCheck(not isCheck)
    return
  end
  ToClient_setSpeakerOnOff(isCheck)
end
function PaGlobal_VoiceChat_Setting_New:updateComboList()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local currentType = ToClient_getCurrentPAVoiceChatRoom()
  if currentType == __ePAVoiceChatType_eGuild then
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_GUILD") .. " : " .. tostring(selfPlayer:getGuildName()))
  elseif currentType == __ePAVoiceChatType_eRedBattleFieldOccupy then
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_REDBATTLE"))
  elseif currentType == __ePAVoiceChatType_eSolrare then
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_SOLRARE"))
  elseif currentType == __ePAVoiceChatType_eParty then
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_PARTY"))
  elseif currentType == __ePAVoiceChatType_eAlliance then
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE") .. " : " .. tostring(selfPlayer:getGuildAllianceName()))
  else
    self._ui._combo_channel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_AFFILIATEDTERRITORY"))
  end
  self._arr_comboListValue = {}
  local idx = 0
  local myGuild = ToClient_GetMyGuildInfoWrapper()
  if myGuild ~= nil then
    self._ui._combo_channel:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_GUILD") .. " : " .. tostring(selfPlayer:getGuildName()))
    self._arr_comboListValue[idx] = __ePAVoiceChatType_eGuild
    idx = idx + 1
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    self._ui._combo_channel:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_SOLRARE"))
    self._arr_comboListValue[idx] = __ePAVoiceChatType_eSolrare
    idx = idx + 1
  end
  if ToClient_IsOccupationModeInRedBattleField() == true then
    self._ui._combo_channel:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_REDBATTLE"))
    self._arr_comboListValue[idx] = __ePAVoiceChatType_eRedBattleFieldOccupy
    idx = idx + 1
  end
  local myAlliance = ToClient_GetMyGuildAllianceWrapper()
  if myAlliance ~= nil then
    self._ui._combo_channel:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE") .. " : " .. tostring(selfPlayer:getGuildAllianceName()))
    self._arr_comboListValue[idx] = __ePAVoiceChatType_eAlliance
    idx = idx + 1
  end
  if selfPlayer:get():hasParty() == true then
    self._ui._combo_channel:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_PARTY"))
    self._arr_comboListValue[idx] = __ePAVoiceChatType_eParty
    idx = idx + 1
  end
end
function PaGlobal_VoiceChat_Setting_New:updateMICVolume()
  local posPercent = self._ui._slider_MIC:GetControlPos() * 100
  local volume = math.ceil(posPercent)
  self._ui._slider_MIC_Text:SetText(volume)
  ToClient_setMicVolume(posPercent)
end
function PaGlobal_VoiceChat_Setting_New:updateMICSenseVolume()
  local posPercent = self._ui._slider_MICSense:GetControlPos() * 100
  local volume = math.ceil(posPercent)
  self._ui._slider_MICSense_Text:SetText(volume)
  ToClient_setMicSensitivity(posPercent)
end
function PaGlobal_VoiceChat_Setting_New:updateSpeakerVolume()
  local posPercent = self._ui._slider_speaker:GetControlPos() * 100
  local volume = math.ceil(posPercent)
  self._ui._slider_speaker_Text:SetText(volume)
  ToClient_setSpeakerVolume(posPercent)
end
