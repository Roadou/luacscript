function PaGlobalFunc_YachtDice_FindingMatch_Update(deltaTime)
  local self = PaGlobal_YachtDice_FindingMatch
  if self == nil then
    return
  end
  self._currentDeltaTime = self._currentDeltaTime + deltaTime
  if self._currentDeltaTime > 1 then
    self._currentElapsedTime = self._currentElapsedTime + 1
    self._currentDeltaTime = 0
    self._ui._txt_matchingElapsedTime:SetText(convertSecondsToClockTime(self._currentElapsedTime))
  end
end
function HandleEventLUp_YachtDice_FindingMatch_Cancel()
  local self = PaGlobal_YachtDice_FindingMatch
  if self == nil then
    return
  end
  ToClient_RequestDisjoinYachtDiceMatching()
end
function FromClient_YachtDice_FindingMatch_ChangeMatchState(matchState)
  local self = PaGlobal_YachtDice_FindingMatch
  if self == nil then
    return
  end
  if matchState == __eYachtDiceMatchState_Matched then
    self:prepareOpen()
  else
    self:prepareClose()
  end
end
