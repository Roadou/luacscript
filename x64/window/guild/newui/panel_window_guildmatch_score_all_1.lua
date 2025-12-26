function PaGlobal_GuildMatchScore:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_result = UI.getChildControl(Panel_Window_GuildMatchScore_All, "Static_Result")
  self._ui._stc_resultBg = UI.getChildControl(self._ui._stc_result, "Static_ResultBg_WinLose")
  self._ui._stc_win = UI.getChildControl(self._ui._stc_result, "Static_Win")
  self._ui._txt_win_prevScore = UI.getChildControl(self._ui._stc_win, "StaticText_BeforeScore")
  self._ui._txt_win_afterScore = UI.getChildControl(self._ui._stc_win, "StaticText_AfterScore")
  self._ui._btn_win_leave = UI.getChildControl(self._ui._stc_win, "Button_Leave")
  self._ui._stc_lose = UI.getChildControl(self._ui._stc_result, "Static_Lose")
  self._ui._txt_lose_prevScore = UI.getChildControl(self._ui._stc_lose, "StaticText_BeforeScore")
  self._ui._txt_lose_afterScore = UI.getChildControl(self._ui._stc_lose, "StaticText_AfterScore")
  self._ui._btn_lose_leave = UI.getChildControl(self._ui._stc_lose, "Button_Leave")
  local scoreBg = UI.getChildControl(Panel_Window_GuildMatchScore_All, "Static_ScoreArea")
  self._ui._txt_myGuildName = UI.getChildControl(scoreBg, "StaticText_MyGuildName")
  self._ui._txt_enemyGuildName = UI.getChildControl(scoreBg, "StaticText_EnemyGuildName")
  self._ui._txt_timeLine = UI.getChildControl(scoreBg, "StaticText_TimeLine")
  self._ui._txt_myGuildScore = UI.getChildControl(scoreBg, "StaticText_MyGuildScore")
  self._ui._txt_enemyGuildScore = UI.getChildControl(scoreBg, "StaticText_EnemyGuildScore")
  self._ui._stc_timerBg = UI.getChildControl(Panel_Window_GuildMatchScore_All, "Static_TimerBg")
  self._ui._txt_timerLeftTime = UI.getChildControl(self._ui._stc_timerBg, "StaticText_LeftTime")
  self:registEventHandler()
  self:validate()
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    PaGlobalFunc_GuildMatchScore_Open()
  end
  self._initialize = true
end
function PaGlobal_GuildMatchScore:registEventHandler()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._ui._btn_win_leave:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchScore_OnClickedLeave()")
  self._ui._btn_lose_leave:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchScore_OnClickedLeave()")
  registerEvent("FromClient_checkShowGuildMatchScoreUI", "PaGlobalFunc_GuildMatchScore_checkShowGuildMatchScoreUI")
  registerEvent("FromClient_responseGuildMatchCurrentState", "PaGlobalFunc_GuildMatchScore_updateGuildMatchCurrentState")
  registerEvent("FromClient_updateGuildMatchGuildName", "PaGlobalFunc_GuildMatchScore_updateGuildMatchGuildName")
  registerEvent("FromClient_responseGuildMatchTeamPoint", "PaGlobalFunc_GuildMatchScore_updateGuildMatchTeamPoint")
  registerEvent("FromClient_refreshGuildMatchTeamPoint", "PaGlobalFunc_GuildMatchScore_refreshGuildMatchTeamPoint")
  registerEvent("FromClient_responseGuildMatchResult", "PaGlobalFunc_GuildMatchScore_showResult")
  registerEvent("onScreenResize", "PaGlobalFunc_GuildMatchScore_OnScreenResize")
end
function PaGlobal_GuildMatchScore:validate()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._ui._stc_result:isValidate()
  self._ui._stc_resultBg:isValidate()
  self._ui._stc_win:isValidate()
  self._ui._txt_win_prevScore:isValidate()
  self._ui._txt_win_afterScore:isValidate()
  self._ui._btn_win_leave:isValidate()
  self._ui._stc_lose:isValidate()
  self._ui._txt_lose_prevScore:isValidate()
  self._ui._txt_lose_afterScore:isValidate()
  self._ui._btn_lose_leave:isValidate()
  self._ui._txt_myGuildName:isValidate()
  self._ui._txt_enemyGuildName:isValidate()
  self._ui._txt_timeLine:isValidate()
  self._ui._txt_myGuildScore:isValidate()
  self._ui._txt_enemyGuildScore:isValidate()
  self._ui._stc_timerBg:isValidate()
  self._ui._txt_timerLeftTime:isValidate()
end
function PaGlobal_GuildMatchScore:prepareOpen()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self:hideResult()
  self:updateCurrentState()
  self:updateGuildName()
  self:updateScore()
  self:onScreenResize()
  self:open()
end
function PaGlobal_GuildMatchScore:open()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  Panel_Window_GuildMatchScore_All:RegisterUpdateFunc("PaGlobalFunc_GuildMatchScore_PerFrameUpdate")
  Panel_Window_GuildMatchScore_All:SetShow(true)
end
function PaGlobal_GuildMatchScore:prepareClose()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self:close()
end
function PaGlobal_GuildMatchScore:close()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  Panel_Window_GuildMatchScore_All:ClearUpdateLuaFunc()
  Panel_Window_GuildMatchScore_All:SetShow(false)
end
function PaGlobal_GuildMatchScore:close()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  Panel_Window_GuildMatchScore_All:SetShow(false)
end
function PaGlobal_GuildMatchScore:update(deltaTime)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self:updateTimeLine(deltaTime)
  self:updateResultScoreAnimation(deltaTime)
end
function PaGlobal_GuildMatchScore:onScreenResize()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  self._ui._stc_result:SetSize(screenX, screenY)
  self._ui._stc_resultBg:SetSize(screenX, screenY)
  self._ui._stc_win:SetSize(screenX, screenY)
  self._ui._stc_lose:SetSize(screenX, screenY)
  Panel_Window_GuildMatchScore_All:SetSize(screenX, screenY)
  Panel_Window_GuildMatchScore_All:ComputePosAllChild()
end
function PaGlobal_GuildMatchScore:updateGuildName(myGuildName, enemyGuildName)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  if myGuildName == nil and enemyGuildName == nil then
    self._ui._txt_myGuildName:SetText(ToClient_getGuildMatchMyGuildName())
    local playVariableInfo = ToClient_GetGuildMatchPlayVariableInfo()
    if playVariableInfo ~= nil then
      self._ui._txt_enemyGuildName:SetText(playVariableInfo:getEnemyGuildName())
    else
      self._ui._txt_enemyGuildName:SetText("")
    end
  else
    self._ui._txt_myGuildName:SetText(myGuildName)
    self._ui._txt_enemyGuildName:SetText(enemyGuildName)
  end
end
function PaGlobal_GuildMatchScore:updateTimeLine(deltaTime)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  if self._currentMatchState == __eGuildMatchState_Count then
    return
  end
  self._deltaTime = self._deltaTime + deltaTime
  if self._deltaTime < 1 then
    return
  end
  self._deltaTime = 0
  local remainTime = 0
  if self._currentMatchState == __eGuildMatchState_Playing then
    self._ui._stc_timerBg:SetShow(false)
    remainTime = ToClient_GetGuildMatchPlayingRemainTime()
    self._ui._txt_timeLine:SetText(convertSecondsToClockTime(remainTime))
  else
    self._ui._stc_timerBg:SetShow(true)
    local noticeString
    if self._currentMatchState == __eGuildMatchState_Ready then
      remainTime = ToClient_GetGuildMatchWaitRemainTime()
      noticeString = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_DELIVERY_INFORMATIONVIEW_BTN_READY")
    elseif self._currentMatchState == __eGuildMatchState_Exit then
      remainTime = ToClient_GetGuildMatchExitRemainTime()
      noticeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_END")
    end
    if self._currentMatchState == __eGuildMatchState_Ready and remainTime <= 10 and PaGlobalFunc_GuildMatchCountDown_GetShow() == false then
      PaGlobalFunc_GuildMatchCountDown_Open(remainTime)
    end
    if self._currentMatchState < __eGuildMatchState_End then
      self._ui._txt_timerLeftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_LEFTTIME", "time", convertSecondsToClockTime(remainTime)))
    else
      self._ui._txt_timerLeftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_LEAVETIME", "time", convertSecondsToClockTime(remainTime)))
    end
    if noticeString ~= nil then
      self._ui._txt_timeLine:SetText(noticeString)
    end
  end
end
function PaGlobal_GuildMatchScore:updateResultScoreAnimation(deltaTime)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  if self._resultInfo == nil then
    return
  end
  self._resultInfo._deltaTime = self._resultInfo._deltaTime + deltaTime
  if self._resultInfo._deltaTime < 1 then
    return
  end
  self._resultInfo._addVar = self._resultInfo._addVar + deltaTime
  local isEnd = false
  local var = self._resultInfo._afterScore - self._resultInfo._prevScore
  if var == 0 then
    self._resultInfo = nil
    return
  elseif var > 0 then
    self._resultInfo._tempScore = math.floor(self._resultInfo._tempScore + self._resultInfo._addVar)
    if self._resultInfo._afterScore <= self._resultInfo._tempScore then
      self._resultInfo._tempScore = self._resultInfo._afterScore
      isEnd = true
    end
  else
    self._resultInfo._tempScore = math.floor(self._resultInfo._tempScore - self._resultInfo._addVar)
    if self._resultInfo._tempScore <= self._resultInfo._afterScore then
      self._resultInfo._tempScore = self._resultInfo._afterScore
      isEnd = true
    end
  end
  if self._resultInfo._isWin == true then
    self._ui._txt_win_afterScore:SetText(self._resultInfo._tempScore)
  else
    self._ui._txt_lose_afterScore:SetText(self._resultInfo._tempScore)
  end
  if isEnd == true then
    self._resultInfo = nil
  end
end
function PaGlobal_GuildMatchScore:updateScore()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._ui._txt_myGuildScore:SetText(ToClient_getGuildMatchMyGuildScore())
  self._ui._txt_enemyGuildScore:SetText(ToClient_getGuildMatchEnemyGuildScore())
end
function PaGlobal_GuildMatchScore:updateCurrentState()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._currentMatchState = ToClient_getCurrentGuildMatchState()
end
function PaGlobal_GuildMatchScore:setGuildMatchCurrentState(currentState)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._currentMatchState = currentState
  local noticeString
  if self._currentMatchState == __eGuildMatchState_Ready then
    noticeString = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_DELIVERY_INFORMATIONVIEW_BTN_READY")
    self._ui._stc_timerBg:SetShow(true)
  elseif self._currentMatchState == __eGuildMatchState_Exit then
    noticeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_END")
    self._ui._stc_timerBg:SetShow(true)
  else
    self._ui._stc_timerBg:SetShow(false)
  end
  if noticeString ~= nil then
    self._ui._txt_timeLine:SetText(noticeString)
  end
end
function PaGlobal_GuildMatchScore:updateGuildMatchTeamPoint(killerTeam, killerTeamPoint, enemyTeam, enemyTeamPoint, isKillerMyTeam)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  if isKillerMyTeam == true then
    self._ui._txt_myGuildScore:SetText(killerTeamPoint)
  else
    self._ui._txt_enemyGuildScore:SetText(killerTeamPoint)
  end
end
function PaGlobal_GuildMatchScore:showResult(isWin, prevScore, afterScore)
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._ui._stc_result:SetShow(true)
  self._ui._stc_resultBg:SetShow(true)
  self._ui._stc_win:SetShow(isWin)
  self._ui._stc_lose:SetShow(isWin == false)
  if isWin == true then
    self._ui._txt_win_prevScore:SetText(prevScore)
    self._ui._txt_win_afterScore:SetText(prevScore)
  else
    self._ui._txt_lose_prevScore:SetText(prevScore)
    self._ui._txt_lose_afterScore:SetText(prevScore)
  end
  self._ui._stc_result:SetAlpha(0)
  local anim = self._ui._stc_result:addColorAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  anim:SetStartColor(Defines.Color.C_00FFFFFF)
  anim:SetEndColor(Defines.Color.C_FFFFFFFF)
  anim.IsChangeChild = true
  local resultInfo = {
    _isWin = isWin,
    _prevScore = prevScore,
    _afterScore = afterScore,
    _tempScore = prevScore,
    _deltaTime = 0,
    _addVar = 0
  }
  self._resultInfo = resultInfo
end
function PaGlobal_GuildMatchScore:hideResult()
  if Panel_Window_GuildMatchScore_All == nil then
    return
  end
  self._ui._stc_result:SetShow(false)
  self._resultInfo = nil
end
