function PaGlobal_VoiceChat_List_New:initialize()
  if true == PaGlobal_VoiceChat_List_New._initialize then
    return
  end
  local channelBg = UI.getChildControl(Panel_VoiceChat_List_New, "Static_Channel_BG")
  self._ui._stc_channelBG = channelBg
  self._ui._txt_channelName = UI.getChildControl(channelBg, "StaticText_ChannelName")
  self._ui._txt_myName = UI.getChildControl(channelBg, "StaticText_MyIcon_BG")
  self._ui._txt_myNameTalk = UI.getChildControl(channelBg, "StaticText_MyIcon_BG_Talk")
  self._ui._stc_myClassType = UI.getChildControl(self._ui._txt_myName, "Static_ClassIcon")
  self._ui._chk_myMic = UI.getChildControl(channelBg, "CheckButton_Mic")
  self._ui._chk_myListen = UI.getChildControl(channelBg, "CheckButton_Speaker")
  self._ui._btn_setting = UI.getChildControl(channelBg, "Button_Setting")
  self._ui._list2_memberList = UI.getChildControl(Panel_VoiceChat_List_New, "List2_1")
  local voiceChatTitle = UI.getChildControl(Panel_VoiceChat_List_New, "StaticText_SetVoiceChatTitle")
  self._ui._chk_sticker = UI.getChildControl(voiceChatTitle, "Checkbox_Sticker")
  self._ui._btn_close = UI.getChildControl(voiceChatTitle, "Button_WinClose")
  self._ui._mulTxt_noBody = UI.getChildControl(Panel_VoiceChat_List_New, "MultilineText_Nobody")
  self._ui._slider_personalVolume_BG = UI.getChildControl(Panel_VoiceChat_List_New, "Static_PersonalSetting_BG")
  self._ui._slider_personalVolume = UI.getChildControl(self._ui._slider_personalVolume_BG, "Slider_1")
  self._ui._slider_personalVolume_BTN = UI.getChildControl(self._ui._slider_personalVolume, "Slider_1_Button")
  self._ui._slider_personalVolume_TXT = UI.getChildControl(self._ui._slider_personalVolume_BG, "StaticText_Value")
  self._ui._slider_personalVolume_EXIT = UI.getChildControl(self._ui._slider_personalVolume_BG, "Button_Close_PCUI")
  self._ui._stc_subMenu_BG = UI.getChildControl(Panel_VoiceChat_List_New, "Static_SubMenu_BG")
  self._ui._btn_mute = UI.getChildControl(self._ui._stc_subMenu_BG, "Button_Mute")
  self._ui._btn_whisper = UI.getChildControl(self._ui._stc_subMenu_BG, "Button_Whisper")
  self._ui._btn_party = UI.getChildControl(self._ui._stc_subMenu_BG, "Button_Invite")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_VoiceChat_List_New, "Static_KeyGuide_Console")
  self._ui._btn_padY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Confirm_Console")
  self._ui._btn_padA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Select_Console")
  self._ui._btn_padB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Close_Console")
  self._ui._btn_padLB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_SpeakerOnOff_Console")
  self._ui._btn_padRB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_MICOnOff_Console")
  PaGlobal_VoiceChat_List_New:validate()
  self._isPadMode = _ContentsGroup_UsePadSnapping
  if self._isPadMode == true then
    PaGlobal_VoiceChat_List_New:setAlignKeyGuide()
  end
  PaGlobal_VoiceChat_List_New:registEventHandler()
  PaGlobal_VoiceChat_List_New._initialize = true
end
function PaGlobal_VoiceChat_List_New:registEventHandler()
  if nil == Panel_VoiceChat_List_New then
    return
  end
  self._ui._list2_memberList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_VoiceChat_List_New_Content_Update")
  self._ui._list2_memberList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._chk_myListen:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:setMyListen()")
  self._ui._chk_myMic:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:setMyMic()")
  self._ui._chk_sticker:addInputEvent("Mouse_LUp", "HandleEventLUp_VoiceChat_List_New_CheckPopupUI()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:prepareClose()")
  self._ui._btn_setting:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_Setting_New_Open()")
  self._ui._slider_personalVolume:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:updatePersonalVolume()")
  self._ui._slider_personalVolume_BTN:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:updatePersonalVolume()")
  self._ui._slider_personalVolume_BTN:addInputEvent("Mouse_LPress", "PaGlobal_VoiceChat_List_New:updatePersonalVolume()")
  self._ui._slider_personalVolume_EXIT:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:personalVolumeClose()")
  self._ui._btn_mute:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:doMute()")
  self._ui._btn_whisper:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:doWhisper()")
  self._ui._btn_party:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:inviteParty()")
  Panel_VoiceChat_List_New:RegisterUpdateFunc("PaGlobal_VoiceChatList_New_Update")
  registerEvent("FromClient_PerposeEnterPAVoiceChatRoom", "FromClient_PerposeEnterPAVoiceChatRoom")
  registerEvent("FromClient_UpdatePAVoiceChat", "FromClient_UpdatePAVoiceChat")
  registerEvent("FromClient_EnterPAVoiceChat", "FromClient_EnterPAVoiceChat")
  registerEvent("FromClient_LeavePAVoiceChat", "FromClient_LeavePAVoiceChat")
  registerEvent("FromClient_SpeakOnOffPAVoiceChat", "FromClient_SpeakOnOffPAVoiceChat_VoiceChat_List")
  registerEvent("FromClient_ListenOnOffPAVoiceChat", "FromClient_ListenOnOffPAVoiceChat_VoiceChat_List")
  if self._isPadMode == true then
    Panel_VoiceChat_List_New:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_VoiceChat_List_New:setMyListen()")
    Panel_VoiceChat_List_New:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_VoiceChat_List_New:setMyMic()")
    Panel_VoiceChat_List_New:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_VoiceChat_Setting_New_Open()")
  end
end
function PaGlobal_VoiceChat_List_New:prepareOpen()
  if nil == Panel_VoiceChat_List_New then
    return
  end
  if _ContentsGroup_VoiceChat == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local classType = selfPlayer:getClassType()
  self._ui._txt_myName:SetText(selfPlayer:getUserNickname())
  self:setClassIcon(self._ui._stc_myClassType, classType)
  local currentType = ToClient_getCurrentPAVoiceChatRoom()
  if currentType == __ePAVoiceChatType_eGuild then
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_GUILD") .. " : " .. tostring(selfPlayer:getGuildName()))
  elseif currentType == __ePAVoiceChatType_eRedBattleFieldOccupy then
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_REDBATTLE"))
  elseif currentType == __ePAVoiceChatType_eSolrare then
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_SOLRARE"))
  elseif currentType == __ePAVoiceChatType_eParty then
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_ROOMTYPE_PARTY"))
  elseif currentType == __ePAVoiceChatType_eAlliance then
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDALLIANCE") .. " : " .. tostring(selfPlayer:getGuildAllianceName()))
  else
    self._ui._txt_channelName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_AFFILIATEDTERRITORY"))
  end
  self._ui._list2_memberList:getElementManager():clearKey()
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  if memberCount <= 0 then
    self._ui._mulTxt_noBody:SetShow(true)
  else
    self._ui._mulTxt_noBody:SetShow(false)
  end
  for index = 0, memberCount - 1 do
    self._ui._list2_memberList:getElementManager():pushKey(index)
  end
  self._ui._chk_myMic:SetCheck(ToClient_isVoiceChatMic())
  self._ui._chk_myListen:SetCheck(ToClient_isVoiceChatListen())
  self._ui._slider_personalVolume_BG:SetShow(false)
  self._ui._stc_subMenu_BG:SetShow(false)
  self._ui._chk_sticker:SetCheck(false)
  PaGlobal_VoiceChat_List_New:open()
end
function PaGlobal_VoiceChat_List_New:open()
  if nil == Panel_VoiceChat_List_New then
    return
  end
  Panel_VoiceChat_List_New:SetShow(true)
end
function PaGlobal_VoiceChat_List_New:prepareClose()
  if nil == Panel_VoiceChat_List_New then
    return
  end
  if Panel_VoiceChat_List_New:IsUISubApp() == true then
    Panel_VoiceChat_List_New:CloseUISubApp()
  end
  PaGlobal_VoiceChat_List_New:close()
end
function PaGlobal_VoiceChat_List_New:close()
  if nil == Panel_VoiceChat_List_New then
    return
  end
  Panel_VoiceChat_List_New:SetShow(false)
end
function PaGlobal_VoiceChat_List_New:update()
  if nil == Panel_VoiceChat_List_New then
    return
  end
end
function PaGlobal_VoiceChat_List_New:validate()
  if nil == Panel_VoiceChat_List_New then
    return
  end
end
function PaGlobal_VoiceChat_List_New:setClassIcon(control, class)
  if PaGlobal_VoiceChat_List_New == nil then
    return
  end
  if control == nil then
    return
  end
  local iconTexture = NewClassData.newClass_Texture_ID[class]._symbolTextureTID
  if iconTexture == nil then
    return
  end
  control:ChangeTextureInfoTextureIDAsync(iconTexture, 0)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_VoiceChat_List_New:contentUpdate(control, key)
  local key32 = Int64toInt32(key)
  local memberInfo = ToClient_getVoiceChatRoomMemberInfo(key32)
  if memberInfo == nil then
    return
  end
  self:setClassIcon(playerClassType, memberInfo:getClassType())
  local playerSlot = UI.getChildControl(control, "Static_PlayerSlot")
  local playerName = UI.getChildControl(playerSlot, "StaticText_ClassIcon_BG")
  local playerClassType = UI.getChildControl(playerName, "Static_ClassIcon")
  local listenSetting = UI.getChildControl(playerSlot, "Button_PersonalSetting")
  playerName:SetText(memberInfo:getUserNickName())
  self:setClassIcon(playerClassType, memberInfo:getClassType())
  listenSetting:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:openPersonalVolume(" .. tostring(key32) .. ")")
  playerSlot:addInputEvent("Mouse_LUp", "PaGlobal_VoiceChat_List_New:openFunction(" .. tostring(key32) .. ")")
end
function PaGlobal_VoiceChat_List_New:setMyListen()
  local isCheck = self._ui._chk_myListen:IsCheck()
  if ToClient_isLoggedInVoiceChatServer() == false or ToClient_getCurrentPAVoiceChatRoom() == __ePAVoiceChatType_eCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
    self._ui._chk_myListen:SetCheck(false)
    return
  end
  if true == self._isPadMode then
    isCheck = not isCheck
    self._ui._chk_myListen:SetCheck(isCheck)
  end
  ToClient_setSpeakerOnOff(isCheck)
end
function PaGlobal_VoiceChat_List_New:setMyMic()
  local isCheck = self._ui._chk_myMic:IsCheck()
  if ToClient_IsConnectedMic() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MICROPHONE_CONNECTION_NOTIFY"))
    self._ui._chk_myMic:SetCheck(false)
    return
  end
  if ToClient_isLoggedInVoiceChatServer() == false or ToClient_getCurrentPAVoiceChatRoom() == __ePAVoiceChatType_eCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
    self._ui._chk_myMic:SetCheck(false)
    return
  end
  if true == self._isPadMode then
    isCheck = not isCheck
    self._ui._chk_myMic:SetCheck(isCheck)
  end
  ToClient_setMicOnOff(isCheck)
end
function PaGlobal_VoiceChat_List_New:openFunction(index)
  local control = self._ui._list2_memberList:GetContentByKey(index)
  if control == nil then
    return
  end
  self._targetFunctionIndex = index
  self._ui._stc_subMenu_BG:SetPosY(165 + control:GetPosY())
  self._ui._stc_subMenu_BG:SetShow(true)
end
function PaGlobal_VoiceChat_List_New:inviteParty()
  local info = ToClient_getVoiceChatRoomMemberInfo(self._targetFunctionIndex)
  if info == nil then
    return
  end
  local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  local userCharacterName = info:getCharacterName()
  if nil ~= userCharacterName and "" ~= userCharacterName then
    local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
    local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
    if isSelfPlayerPlayingPvPMatch == false and isEnterPersonalField == false and isEnterPersonalRelayField == false then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", userCharacterName))
    end
  end
  RequestParty_inviteCharacter(userCharacterName)
  self._ui._stc_subMenu_BG:SetShow(false)
end
function PaGlobal_VoiceChat_List_New:doWhisper()
  local info = ToClient_getVoiceChatRoomMemberInfo(self._targetFunctionIndex)
  if info == nil then
    return
  end
  local userName = info:getUserNickName()
  local characterName = info:getCharacterName()
  PaGlobal_ChattingInput_SendWhisper(characterName, userName)
  self._ui._stc_subMenu_BG:SetShow(false)
end
function PaGlobal_VoiceChat_List_New:doMute()
  local info = ToClient_getVoiceChatRoomMemberInfo(self._targetFunctionIndex)
  if info == nil then
    return
  end
  local control = self._ui._list2_memberList:GetContentByKey(self._targetFunctionIndex)
  if control == nil then
    return
  end
  PaGlobal_VoiceChat_List_New:personalVolumeClose()
  ToClient_VoiceChatChangeVolume(__eVoiceChatType_Localwar, info._userNo, 0)
  self._ui._stc_subMenu_BG:SetShow(false)
  local playerSlot = UI.getChildControl(control, "Static_PlayerSlot")
  local listenSetting = UI.getChildControl(playerSlot, "Button_PersonalSetting")
  listenSetting:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_SoundSetting_Ban", 0)
  listenSetting:setRenderTexture(listenSetting:getBaseTexture())
end
function PaGlobal_VoiceChat_List_New:openPersonalVolume(index)
  local memberInfo = ToClient_getVoiceChatRoomMemberInfo(index)
  if memberInfo == nil then
    return
  end
  self._personalVolumeTargetUserNo = memberInfo._userNo
  self._personalVolumeTargetIndex = index
  local volume = ToClient_VoiceChatGetVolume(self._personalVolumeTargetUserNo)
  self._ui._slider_personalVolume:SetControlPos(volume)
  local volumeValue = math.ceil(volume)
  volumeValue = math.max(volumeValue, 0)
  volumeValue = math.min(volumeValue, 100)
  self._ui._slider_personalVolume_TXT:SetText(tostring(volumeValue))
  local control = self._ui._list2_memberList:GetContentByKey(index)
  if Panel_VoiceChat_List_New:IsUISubApp() == true then
    self._ui._slider_personalVolume_BG:SetPosY(165 + control:GetPosY())
    self._ui._slider_personalVolume_BG:SetPosX(155 + control:GetPosX())
  else
    self._ui._slider_personalVolume_BG:SetPosY(165 + control:GetPosY())
    self._ui._slider_personalVolume_BG:SetPosX(390 + control:GetPosX())
  end
  self._ui._slider_personalVolume_BG:SetShow(true)
end
function PaGlobal_VoiceChat_List_New:updatePersonalVolume()
  local posPercent = self._ui._slider_personalVolume:GetControlPos() * 100
  local volume = math.ceil(posPercent)
  volume = math.max(volume, 0)
  volume = math.min(volume, 100)
  self._ui._slider_personalVolume_TXT:SetText(volume)
  ToClient_VoiceChatChangeVolume(__eVoiceChatType_Localwar, self._personalVolumeTargetUserNo, volume)
  local control = self._ui._list2_memberList:GetContentByKey(self._personalVolumeTargetIndex)
  if control == nil then
    return
  end
  local playerSlot = UI.getChildControl(control, "Static_PlayerSlot")
  local listenSetting = UI.getChildControl(playerSlot, "Button_PersonalSetting")
  if volume <= 0 then
    listenSetting:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_SoundSetting_Ban", 0)
    listenSetting:setRenderTexture(listenSetting:getBaseTexture())
  else
    listenSetting:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_SoundSetting_On", 0)
    listenSetting:setRenderTexture(listenSetting:getBaseTexture())
  end
end
function PaGlobal_VoiceChat_List_New:updateMember()
  self._ui._list2_memberList:getElementManager():clearKey()
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  if memberCount <= 0 then
    self._ui._mulTxt_noBody:SetShow(true)
  else
    self._ui._mulTxt_noBody:SetShow(false)
  end
  for index = 0, memberCount - 1 do
    self._ui._list2_memberList:getElementManager():pushKey(index)
  end
end
function PaGlobal_VoiceChat_List_New:updatePerFrame(deltaTime)
  if Panel_VoiceChat_List_New == nil then
    return
  end
  if Panel_VoiceChat_List_New:GetShow() == false then
    return
  end
  self._ui._txt_myNameTalk:SetShow(ToClient_selfPlayerIsTalking())
  local memberCount = ToClient_getVoiceChatRoomMemberCount()
  for ii = 0, memberCount - 1 do
    local info = ToClient_getVoiceChatRoomMemberInfo(ii)
    if info ~= nil then
      local control = self._ui._list2_memberList:GetContentByKey(ii)
      if control ~= nil then
        if info:isSpeaking() == true then
          local playerSlot = UI.getChildControl(control, "Static_PlayerSlot")
          local talkBG = UI.getChildControl(playerSlot, "StaticText_ClassIcon_BG_Talk")
          local playerName = UI.getChildControl(playerSlot, "StaticText_ClassIcon_BG")
          playerName:SetFontColor(Defines.Color.C_FFFFEDD4)
          talkBG:SetShow(true)
        else
          local playerSlot = UI.getChildControl(control, "Static_PlayerSlot")
          local talkBG = UI.getChildControl(playerSlot, "StaticText_ClassIcon_BG_Talk")
          local playerName = UI.getChildControl(playerSlot, "StaticText_ClassIcon_BG")
          playerName:SetFontColor(Defines.Color.C_FFDDC39E)
          talkBG:SetShow(false)
        end
      end
    end
  end
end
function PaGlobal_VoiceChat_List_New:personalVolumeClose()
  self._ui._slider_personalVolume_BG:SetShow(false)
end
function PaGlobal_VoiceChat_List_New:setAlignKeyGuide()
  local keyGuides = {
    self._ui._btn_padY,
    self._ui._btn_padA,
    self._ui._btn_padB,
    self._ui._btn_padLB,
    self._ui._btn_padRB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_VoiceChat_List_New._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
