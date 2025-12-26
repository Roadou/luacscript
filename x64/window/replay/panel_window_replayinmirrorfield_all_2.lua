function PaGloabalFunc_ReplayInMirrorField_Close()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self:prepareClose()
end
function FromClient_ReplayInMirrorField_PlaySolareReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self:prepareOpen(__eReplayRecordType_Solare)
end
function FromClient_ReplayInMirrorField_PlayGuildMatchReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self:prepareOpen(__eReplayRecordType_GuildMatch)
end
function FromClient_ReplayInMirrorField_PlaySnowBoardReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self:prepareOpen(__eReplayRecordType_SnowBoard)
end
function FromClient_ReplayInMirrorField_LoadReplay(replayLength)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  local prevReplayLength = self._replayLength
  self._replayLength = Uint64toUint32(replayLength)
  if prevReplayLength == 0 then
    self._ui._stc_timeLineBar:SetControlPos(0)
    self._ui._txt_replayTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  else
    local elepsedTimePercent = self._currentTime / Uint64toUint32(replayLength / toUint64(0, 1000)) * 100
    self._ui._stc_timeLineBar:SetControlPos(elepsedTimePercent)
    self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(self._currentTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  end
  if self._isFinishLoadReplay == false then
    self._isFinishLoadReplay = true
  end
end
function FromClient_ReplayInMirrorField_EndReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  PaGloabalFunc_ReplayInMirrorField_Close()
end
function FromClient_ReplayInMirrorField_SetProgress(elepsedTimePercent)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  local elepsedTime = math.ceil(self._replayLength * elepsedTimePercent / 100)
  self._currentTime = elepsedTime
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._ui._stc_timeLineBar:SetControlPos(elepsedTimePercent)
end
function FromClient_ReplayInMirrorField_SetChangePlayButton()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(true)
end
function FromClient_ReplayInMirrorField_SetReplayName(replayName)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._txt_replayName:SetText(replayName)
  self._ui._txt_replayName:SetSize(self._ui._txt_replayName:GetTextSizeX(), self._ui._txt_replayName:GetTextSizeY())
  self._ui._txt_replayName:SetPosX(self._ui._stc_timeLineBar:GetPosX() - self._ui._txt_replayName:GetSizeX() - 15)
  self._ui._txt_replayName:SetPosY(self._ui._stc_timeLineBar:GetPosY() - self._ui._txt_replayName:GetSizeY() / 2)
end
function FromClient_ReplayInMirrorField_SetReplayTime(startTime)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  ToClient_ReadyReplay(startTime, 0)
  self._ui._cbx_play:SetCheck(false)
  startTime = Uint64toUint32(startTime)
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(startTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  if self._replayLength ~= 0 and startTime < self._replayLength then
    self._ui._stc_timeLineBar:SetControlPos(startTime / self._replayLength * 100)
  end
  ToClient_PlayReplay(true)
end
function FromClient_ReplayInMirrorField_PlayReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  ReplayInMirrorField_PlayOrPauseReplay(true)
end
function ReplayInMirrorField_PauseReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(false)
  ToClient_PauseReplay()
end
function ReplayInMirrorField_ReadyReplayUseTime()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(true)
  ToClient_ReadyReplayUseTime(self._ui._stc_timeLineBar:GetControlPos())
  ToClient_PlayReplay(false)
end
function ReplayInMirrorField_PlayReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(true)
  ToClient_PlayReplay(false)
end
function ReplayInMirrorField_ResetReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(false)
  self._currentTime = 0
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(0) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._ui._stc_timeLineBar:SetControlPos(0)
  ToClient_ReadyReplayUseTime(self._ui._stc_timeLineBar:GetControlPos())
end
function ReplayInMirrorField_UpdateWhenClickSlideButton()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  self._ui._cbx_play:SetCheck(false)
  local elepsedTime = math.ceil(self._replayLength * self._ui._stc_timeLineBar:GetControlPos())
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  ToClient_ReadyReplayUseTime(self._ui._stc_timeLineBar:GetControlPos())
  ToClient_PlayReplay(true)
  ToClient_PauseReplay()
end
function ReplayInMirrorField_PlayOrPauseReplay(isHotKey)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  if isHotKey ~= nil then
    if self._ui._cbx_play:IsCheck() == true then
      self._ui._cbx_play:SetCheck(false)
    else
      self._ui._cbx_play:SetCheck(true)
    end
  end
  if self._ui._cbx_play:IsCheck() == true then
    ReplayInMirrorField_PlayReplay()
  else
    ReplayInMirrorField_PauseReplay()
  end
end
function ReplayInMirrorField_ToggleGuideUI()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  if Panel_Window_ReplayInMirrorField_All:GetShow() == false then
    return
  end
  self._ui._stc_commandBg:SetShow(not self._ui._stc_commandBg:GetShow())
end
function ReplayInMirrorField_StopReplay()
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  local requestStopReplay = function()
    PaGlobal_ReplayControllerInMirrorField._ui._txt_replayTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(PaGlobal_ReplayControllerInMirrorField._replayLength))
    PaGlobal_ReplayControllerInMirrorField._ui._cbx_play:SetCheck(false)
    PaGlobal_ReplayControllerInMirrorField._ui._stc_timeLineBar:SetControlPos(0)
    ToClient_StopReplayInMirrorField()
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_STOPREPLAY"),
    functionYes = requestStopReplay,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function ReplayInMirrorField_ClickRightOrLeftButton(sign)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  local isPause = ToClient_IsPauseReplay()
  local elepsedTime = self._currentTime
  local editTime = 5
  local moveTime = editTime * 1000 * sign
  elepsedTime = elepsedTime + moveTime
  if elepsedTime < 0 then
    elepsedTime = 0
  end
  if elepsedTime > self._replayLength then
    elepsedTime = self._replayLength
  end
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._ui._stc_timeLineBar:SetControlPos(elepsedTime / self._replayLength * 100)
  ToClient_ReadyReplayUseTime(self._ui._stc_timeLineBar:GetControlPos())
  if isPause == true then
    self._currentTime = elepsedTime
  else
    ReplayInMirrorField_PlayReplay()
  end
end
function HandleEventOnOut_ReplayInMirrorField_ToggleTimeEventToolTip(isShow, index)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._stc_timeLineEventPool[index]
  if control == nil then
    return
  end
  local timeLineEventWrapper = ToClient_GetInstanceContentsReplayTimeLineInfo(index - 1)
  if timeLineEventWrapper == nil then
    return
  end
  local name, desc
  local eventType = timeLineEventWrapper:getEventType()
  if eventType == __eReplayInstanceContentsTimeLineEventType_Kill then
    local killPlayerName = timeLineEventWrapper:getEventOwnerNameForLua()
    local deadPlayerName = timeLineEventWrapper:getTargetOwnerNameForLua()
    local killTeamNo = timeLineEventWrapper:getParam()
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_TIMEEVENT_KILL_TITLE")
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_TIMEEVENT_KILL_DESC", "attacker", killPlayerName, "attackTarget", deadPlayerName)
  elseif eventType == __eReplayInstanceContentsTimeLineEventType_RoundStart then
    local roundNum = timeLineEventWrapper:getParam()
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_TIMEEVENT_ROUND_START", "param", roundNum)
  elseif eventType == __eReplayInstanceContentsTimeLineEventType_RoundFinish then
    local roundNum = timeLineEventWrapper:getParam()
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_TIMEEVENT_ROUND_FINISH", "param", roundNum)
  elseif eventType == __eReplayInstanceContentsTimeLineEventType_EndGame then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INSTANCE_CONTENTS_REPLAY_TIMEEVENT_ENDGAME")
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \237\131\128\236\158\132\235\157\188\236\157\184 \236\157\180\235\178\164\237\138\184 \237\131\128\236\158\133\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ReplayInMirrorField_MoveTimeEvent(index)
  local self = PaGlobal_ReplayControllerInMirrorField
  if self == nil then
    return
  end
  local timeLineEventWrapper = ToClient_GetInstanceContentsReplayTimeLineInfo(index - 1)
  if timeLineEventWrapper == nil then
    return
  end
  local eventTime = Uint64toUint32(timeLineEventWrapper:getEventTime())
  if timeLineEventWrapper:getEventType() == __eReplayInstanceContentsTimeLineEventType_Kill then
    eventTime = eventTime - 5000
  end
  if eventTime < 0 then
    eventTime = 0
  end
  if eventTime > self._replayLength then
    eventTime = self._replayLength
  end
  self._ui._txt_replayTime:SetText(convertMilliSecondsToClockTime(eventTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  local controlPosPercent = eventTime / self._replayLength * 100
  self._ui._stc_timeLineBar:SetControlPos(controlPosPercent)
  local isPause = ToClient_IsPauseReplay()
  ToClient_ReadyReplayUseTime(self._ui._stc_timeLineBar:GetControlPos())
  if isPause == true then
    self._currentTime = eventTime
  else
    ReplayInMirrorField_PlayReplay()
  end
end
