function PaGlobalFunc_Solrare_PlayerStatus_Open()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_Solrare_PlayerStatus_Close()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_Solrare_PlayerStatus_CameraControl(teamNo)
  ToClient_ForceChangeScreenModeActor(toInt64(0, teamNo))
end
function PaGlobalFunc_Solrare_PlayerStatus_Create()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self:resize()
  if ToClient_IsPlayingReplay() == true then
    return
  end
  self:createTeamUi_Round()
end
function PaGlobalFunc_Solrare_PlayerStatus_Resize()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self:resize()
end
function FromClient_Solrare_PlayerStatus_DeadHP(killPlayer, deadPlayer)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  local userSlot
  local isRedTeam = false
  local targetActorKey = -1
  for idx = 1, #self._redTeamUserInfo do
    if tostring(deadPlayer) == self._redTeamUserInfo[idx]._userInfo:getName() then
      isRedTeam = true
      targetActorKey = self._redTeamUserInfo[idx]._userInfo:getActorKeyRaw()
      break
    end
  end
  if targetActorKey == -1 then
    for idx = 1, #self._blueTeamUserInfo do
      if tostring(deadPlayer) == self._blueTeamUserInfo[idx]._userInfo:getName() then
        targetActorKey = self._blueTeamUserInfo[idx]._userInfo:getActorKeyRaw()
        break
      end
    end
  end
  if targetActorKey == -1 then
    return
  end
  if isRedTeam == true then
    for idx = 1, #self._redTeamMemberUI do
      if self._redTeamMemberUI[idx] ~= nil and self._redTeamMemberUI[idx]._actorKeyRaw == targetActorKey then
        userSlot = self._redTeamMemberUI[idx]
        break
      end
    end
  else
    for idx = 1, #self._blueTeamMemberUI do
      if self._blueTeamMemberUI[idx] ~= nil and self._blueTeamMemberUI[idx]._actorKeyRaw == targetActorKey then
        userSlot = self._blueTeamMemberUI[idx]
        break
      end
    end
  end
  if userSlot == nil then
    return
  end
  userSlot._progress:SetProgressRate(0)
  userSlot._percent:SetText("0%")
  userSlot._name:SetMonoTone(true, true)
end
function FromClient_Solrare_PlayerStatus_UpdateUserHP(teamNo, userNo, currentHp, maxHp, leftPercent)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self:updateUserHP_Round(teamNo, userNo, currentHp, maxHp, leftPercent)
end
function FromClient_Solare_SetPlayerStatus()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self._redTeamUserInfo = Array.new()
  self._blueTeamUserInfo = Array.new()
  self._redTeamSettedCount = 1
  self._blueTeamSettedCount = 1
  local playerCount = ToClient_GetSolareInGameInfoCount()
  if playerCount == 0 then
    return
  end
  for index = 0, playerCount - 1 do
    local userInfo = ToClient_GetSolareInGameInfoByIndex(index)
    if userInfo ~= nil then
      local teamNo = userInfo:getTeamNo()
      local tempTable = {_userInfo = userInfo, _index = index}
      if teamNo == __eSolareTeamNo_Red then
        self._redTeamUserInfo:push_back(tempTable)
      elseif teamNo == __eSolareTeamNo_Blue then
        self._blueTeamUserInfo:push_back(tempTable)
      end
    end
  end
  if #self._redTeamUserInfo == 0 and #self._blueTeamUserInfo == 0 then
    return
  end
  for idx = 1, #self._redTeamUserInfo do
    if self._redTeamUserInfo[idx] ~= nil then
      self:setting_Round(self._redTeamUserInfo[idx]._userInfo, self._redTeamUserInfo[idx]._index)
    end
  end
  for idx = 1, #self._blueTeamUserInfo do
    if self._blueTeamUserInfo[idx] ~= nil then
      self:setting_Round(self._blueTeamUserInfo[idx]._userInfo, self._blueTeamUserInfo[idx]._index)
    end
  end
  PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
  self:prepareOpen()
end
function PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  local redTotalPercent = 0
  local blueTotalPercent = 0
  local redTeamMember = 0
  for idx = 1, #self._redTeamMemberUI do
    if self._redTeamMemberUI ~= nil then
      if self._redTeamMemberUI[idx]._isLogin == true then
        self._redTeamMemberUI[idx]._hpPercent = 100
        self._redTeamMemberUI[idx]._name:SetMonoTone(false, false)
        redTeamMember = redTeamMember + 1
      else
        self._redTeamMemberUI[idx]._hpPercent = 0
        self._redTeamMemberUI[idx]._name:SetMonoTone(true, true)
      end
      self._redTeamMemberUI[idx]._percent:SetText(string.format("%d", self._redTeamMemberUI[idx]._hpPercent) .. "%")
      self._redTeamMemberUI[idx]._progress:SetProgressRate(self._redTeamMemberUI[idx]._hpPercent)
      redTotalPercent = redTotalPercent + self._redTeamMemberUI[idx]._hpPercent
    end
  end
  if redTeamMember > 0 then
    redTotalPercent = redTotalPercent / redTeamMember
  end
  local blueTeamMember = 0
  for idx = 1, #self._blueTeamMemberUI do
    if self._blueTeamMemberUI ~= nil then
      if self._blueTeamMemberUI[idx]._isLogin == true then
        self._blueTeamMemberUI[idx]._hpPercent = 100
        self._blueTeamMemberUI[idx]._name:SetMonoTone(false, false)
        blueTeamMember = blueTeamMember + 1
      else
        self._blueTeamMemberUI[idx]._hpPercent = 0
        self._blueTeamMemberUI[idx]._name:SetMonoTone(true, true)
      end
      self._blueTeamMemberUI[idx]._progress:SetProgressRate(self._blueTeamMemberUI[idx]._hpPercent)
      self._blueTeamMemberUI[idx]._percent:SetText(string.format("%d", self._blueTeamMemberUI[idx]._hpPercent) .. "%")
      blueTotalPercent = blueTotalPercent + self._blueTeamMemberUI[idx]._hpPercent
    end
  end
  if blueTeamMember > 0 then
    blueTotalPercent = blueTotalPercent / blueTeamMember
  end
  if PaGlobalFunc_SolareHud_SetHPProgressBar ~= nil then
    PaGlobalFunc_SolareHud_SetHPProgressBar(true, redTotalPercent)
    PaGlobalFunc_SolareHud_SetHPProgressBar(false, blueTotalPercent)
  end
end
function PaGlobalFunc_Solrare_PlayerStatus_VoiceOnOff(isVoiceListen)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self._ui.stc_VoiceListen:SetShow(isVoiceListen)
end
function PaGlobalFunc_Solrare_PlayerStatus_SpeakOnOff(isSpeakerOnOff)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  self._ui.stc_MICOnOff:SetShow(isSpeakerOnOff)
end
function PaGlobalFunc_Solrare_PlayerStatus_VoiceLClick()
  if Panel_VoiceChat_List_New == nil then
    return
  end
  if Panel_VoiceChat_List_New:GetShow() == true then
    PaGlobal_VoiceChat_List_New_Close()
    return
  end
  PaGlobalFunc_Widget_FunctionButton_HandleLClick(Widget_Function_Type.SetVoice)
end
function FromClient_SolareUnJoinAck(teamNo, userNo64)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  local userNo32 = Int64toInt32(userNo64)
  if teamNo == __eSolareTeamNo_Red then
    for idx = 1, #self._redTeamMemberUI do
      if self._redTeamMemberUI[idx] ~= nil and self._redTeamMemberUI[idx]._userNo == userNo32 then
        self._redTeamMemberUI[idx]._isLogin = false
      end
    end
  elseif teamNo == __eSolareTeamNo_Blue then
    for idx = 1, #self._blueTeamMemberUI do
      if self._blueTeamMemberUI[idx] ~= nil and self._blueTeamMemberUI[idx]._userNo == userNo32 then
        self._blueTeamMemberUI[idx]._isLogin = false
      end
    end
  end
  Proc_NoticeAlert_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_ESCAPE_MSG"), CppEnums.EChatNoticeType.ActionNakAll, 0)
  PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
end
function SolareReplay_PlayerStatus_Open()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetShow(true)
end
function SolareReplay_PlayerStatus_Close()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetShow(false)
end
function SolareReplay_PlayerStatus_SetReplayData()
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  if self._redTeamMemberUI ~= nil then
    for key, value in pairs(self._redTeamMemberUI) do
      if value ~= nil then
        value._memberBg:SetShow(false)
      end
    end
  end
  if self._blueTeamMemberUI ~= nil then
    for key, value in pairs(self._blueTeamMemberUI) do
      if value ~= nil then
        value._memberBg:SetShow(false)
      end
    end
  end
  self._redTeamUserInfo = Array.new()
  self._blueTeamUserInfo = Array.new()
  self._redTeamSettedCount = 1
  self._blueTeamSettedCount = 1
  local redTeamPlayerCount = ToClient_GetSolareReplayRecordInfoCount(__eSolareTeamNo_Red)
  local blueTeamPlayerCount = ToClient_GetSolareReplayRecordInfoCount(__eSolareTeamNo_Blue)
  if redTeamPlayerCount + blueTeamPlayerCount == 0 then
    return
  end
  for index = 0, redTeamPlayerCount - 1 do
    local userInfo = ToClient_GetSolareReplayRecordInfo(__eSolareTeamNo_Red, index)
    if userInfo ~= nil then
      local teamNo = userInfo:getTeamNo()
      local tempTable = {_userInfo = userInfo, _index = index}
      if teamNo == __eSolareTeamNo_Red then
        self._redTeamUserInfo:push_back(tempTable)
      else
        UI.ASSERT_NAME(false, "\236\134\148\235\157\188\235\160\136 \234\184\176\235\161\157 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. TeamNo\234\176\128 0\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164!", "\236\157\180\236\163\188")
      end
    end
  end
  for index = 0, blueTeamPlayerCount - 1 do
    local userInfo = ToClient_GetSolareReplayRecordInfo(__eSolareTeamNo_Blue, index)
    if userInfo ~= nil then
      local teamNo = userInfo:getTeamNo()
      local tempTable = {_userInfo = userInfo, _index = index}
      if teamNo == __eSolareTeamNo_Blue then
        self._blueTeamUserInfo:push_back(tempTable)
      else
        UI.ASSERT_NAME(false, "\236\134\148\235\157\188\235\160\136 \234\184\176\235\161\157 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. TeamNo\234\176\128 1\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164!", "\236\157\180\236\163\188")
      end
    end
  end
  if #self._redTeamUserInfo == 0 and #self._blueTeamUserInfo == 0 then
    return
  end
  for idx = 1, #self._redTeamUserInfo do
    if self._redTeamUserInfo[idx] ~= nil then
      self:setting_Round(self._redTeamUserInfo[idx]._userInfo, self._redTeamUserInfo[idx]._index)
    end
  end
  for idx = 1, #self._blueTeamUserInfo do
    if self._blueTeamUserInfo[idx] ~= nil then
      self:setting_Round(self._blueTeamUserInfo[idx]._userInfo, self._blueTeamUserInfo[idx]._index)
    end
  end
  PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
  self._ui.stc_VoiceIcon:SetShow(false)
end
function SolareReplay_PlayerStatus_ChangeCameraTarget(s32_targetUserNo)
  local self = PaGlobal_Solrare_PlayerStatus
  if self == nil then
    return
  end
  if s32_targetUserNo == nil then
    return
  end
  ToClient_ChangeInstanceContentsReplayCameraTarget(toInt64(0, s32_targetUserNo))
end
