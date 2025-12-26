function PaGlobalFunc_SolareHud_SetKillEffect(killerTeamNo)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  if teamNo == __eSolareTeamNo_Red then
    self._ui._prog2_HPBlue:AddEffect("fUI_Solrare_Dir_Red_01", false, 0, 0)
  elseif teamNo == __eSolareTeamNo_Blue then
    self._ui._prog2_HPRed:AddEffect("fUI_Solrare_Dir_Blue_01", false, 0, 0)
  end
end
function PaGlobalFunc_SolareHud_SetWinCountUI(redWinCount, blueWinCount)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  self:setWinCountUI(redWinCount, blueWinCount)
end
function PaGlobalFunc_SolareHud_SetHPProgressBar(isRed, value)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  if isRed == true then
    self._ui._prog2_HPRed:SetProgressRate(value)
    self._ui._txt_prog2HPRed:SetText(value .. "%")
  else
    self._ui._prog2_HPBlue:SetProgressRate(value)
    self._ui._txt_prog2HPBlue:SetText(value .. "%")
  end
end
function FromClient_SolrareHud_Resize()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  Panel_Widget_Solare_Hud:ComputePosAllChild()
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  Panel_Widget_Solare_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_Countdown:ComputePosAllChild()
end
function FromClient_SolareKillLog(killPlayer, deadPlayer, killerTeamNo)
  local color = "<PAColor0xFF2C7BFF>"
  local isAlly = false
  local myTeamNo = ToClient_GetSolareMyTeamType()
  if myTeamNo ~= killerTeamNo then
    color = "<PAColor0xFFC02A2A>"
    isAlly = true
  end
  PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.solrare, killPlayer, deadPlayer, nil, isAlly)
  PaGlobalFunc_SolareHud_SetKillEffect(killerTeamNo)
  local mainMessage = color .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", killPlayer, "deadPlayer", deadPlayer) .. "<PAOldColor>"
  local msg = {
    main = mainMessage,
    sub = "",
    addMsg = ""
  }
  if msg.main ~= nil then
    chatting_sendMessage("", msg.main, CppEnums.ChatType.Battle)
  end
end
function FromClient_SolareJoinAck()
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  self:prepareOpen()
  self:unRenderPanel()
end
function FromClient_SolareChangeStateAck(solareMatchMode, playState, roomState, redMVPUserNo, blueMVPUserNo)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  local currentRound = ToClient_GetSolareCurrentRound()
  self._currentRoomState = ToClient_GetSolareRoomState()
  self._currentPlayState = ToClient_GetSolarePlayState()
  self._ui._txt_Round:SetShow(0 ~= currentRound)
  self._ui._txt_Round:SetText(currentRound)
  if __eInstanceSolareManagerState_Wait ~= self._currentRoomState then
    self:waitOtherBgShow(false)
  end
  local msg = ""
  if __eInstanceSolareManagerState_Wait == self._currentRoomState then
    msg = self._waitMsg
    self._waitMsg = ""
  elseif __eInstanceSolareManagerState_Ready == self._currentRoomState then
    if nil ~= FromClient_Solare_SetPlayerStatus then
      FromClient_Solare_SetPlayerStatus()
    end
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_WAITBATTLE")
  elseif __eInstanceSolareManagerState_Play == self._currentRoomState then
    self:unRenderPanel()
    ToClient_RequestSolareInGameInfo()
    if nil ~= FromClient_Solare_SetPlayerStatus then
      FromClient_Solare_SetPlayerStatus()
    end
    self:prepareOpen()
    if __eSolareRoundState_Ready == self._currentPlayState then
      if nil ~= PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge then
        PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
      end
      self:countDownInit()
      local currentRound = ToClient_GetSolareCurrentRound()
      if 1 == currentRound then
        PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, -1, -1)
      end
    elseif __eSolareRoundState_Duel == self._currentPlayState then
      msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_START", "round", ToClient_GetSolareCurrentRound())
      if true == Panel_Widget_Solare_Countdown:GetShow() then
        self:countDownClose()
      end
    elseif __eSolareRoundState_End == self._currentPlayState then
      self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(0))
    end
  elseif __eInstanceSolareManagerState_Result == self._currentRoomState then
    PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, redMVPUserNo, blueMVPUserNo)
  elseif __eInstanceSolareManagerState_End == self._currentRoomState then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_LEAVE")
    self:prepareClose()
  end
  if "" ~= msg then
    Proc_NoticeAlert_Ack(msg, CppEnums.EChatNoticeType.ActionNakAll, 0)
  end
end
function FromClient_SolareHud_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Duel == self._currentPlayState then
    local remainTime = ToClient_GetSolareRemainTime(false)
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
  elseif __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Ready == self._currentPlayState or __eInstanceSolareManagerState_Ready == self._currentRoomState then
    local remainTime = ToClient_GetSolareRemainTime(true)
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
    if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Ready == self._currentPlayState and remainTime < 6 and self._currentMaxCountDown ~= remainTime then
      self._currentMaxCountDown = remainTime
      if false == Panel_Widget_Solare_Countdown:GetShow() then
        self:countDownOpen()
      end
      self:showCountDown(self._currentMaxCountDown + 1)
    end
    if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Duel == self._currentPlayState then
      self:countDownClose()
    end
  elseif __eInstanceSolareManagerState_Wait == self._currentRoomState then
    if nil == Panel_Widget_Solare_WaitOther then
      return
    end
    if false == Panel_Widget_Solare_WaitOther:GetShow() then
      self:waitOtherBgShow(true)
    end
    local remainTime = ToClient_GetSolarePlayerWaitingTime()
    self._ui._txt_waitOtherTime:SetText(convertSecondsToClockTime(remainTime))
  end
end
function SolareReplay_Hud_Open()
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  self._ui._txt_Round:SetShow(true)
  self._ui._txt_LeftTime:SetShow(true)
  self._ui._txt_Round:SetText("")
  self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(0))
  Panel_Widget_Solare_Hud:ComputePosAllChild()
  Panel_Widget_Solare_Hud:SetShow(true)
end
function SolareReplay_Hud_Close()
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  Panel_Widget_Solare_Hud:SetShow(false)
end
function SolareReplay_Hud_UpdateTeamScore(redTeamWinCount, blueTeamWinCount)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  self:setWinCountUI(redTeamWinCount, blueTeamWinCount)
end
function SolareReplay_Hud_UpdateRoundTime(roundNum, s64_roundTime)
  local self = PaGlobal_Solare_Hud
  if self == nil then
    return
  end
  if roundNum == 0 then
    self._ui._txt_Round:SetText("")
  else
    self._ui._txt_Round:SetText(roundNum)
  end
  local roundTime = Int64toInt32(s64_roundTime)
  self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(roundTime))
end
