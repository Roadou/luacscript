function HandleEventLUp_YachtDice_MatchConfirm()
  local self = PaGlobal_YachtDice_MatchConfirm
  if self == nil then
    return
  end
  if self._isReq == true then
    return
  else
    self._isReq = true
  end
  local isRequested = ToClient_RequestYachtDiceMatchConfirm(true)
  if isRequested == true then
    Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetEnable(false)
    Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetMonoTone(true)
  else
    UI.ASSERT_NAME(false, "\236\152\164\235\165\152 \235\176\156\236\131\157! \236\160\156\235\179\180 \235\176\148\235\158\140!", "\236\157\180\236\163\188")
    self:prepareClose()
  end
end
function HandleEventLUp_YachtDice_MatchRefuse()
  local self = PaGlobal_YachtDice_MatchConfirm
  if self == nil then
    return
  end
  if self._isReq == true then
    return
  else
    self._isReq = true
  end
  local isRequested = ToClient_RequestYachtDiceMatchConfirm(false)
  if isRequested == true then
    Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetEnable(false)
    Panel_Widget_MiniGame_YachtDice_MatchConfirm:SetMonoTone(true)
  else
    UI.ASSERT_NAME(false, "\236\152\164\235\165\152 \235\176\156\236\131\157! \236\160\156\235\179\180 \235\176\148\235\158\140!", "\236\157\180\236\163\188")
    self:prepareClose()
  end
end
function PaGlobalFunc_YachtDice_MatchConfirm_Update(deltaTime)
  local self = PaGlobal_YachtDice_MatchConfirm
  if self == nil then
    return
  end
  self._deltaTime = self._deltaTime + deltaTime
  local remainSecond = math.floor(self._waitTimeSecond - self._deltaTime)
  local doAutoRefush = false
  if remainSecond > 0 then
    self._ui._txt_Confirm:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_TIMELEFT", "time", tostring(remainSecond)))
    local rate = remainSecond / self._waitTimeSecond * 100
    self._ui._stc_ProgressBar:SetProgressRate(rate)
    if rate < 1 then
      doAutoRefush = true
    end
  else
    doAutoRefush = true
  end
  if doAutoRefush == true then
    Panel_Widget_MiniGame_YachtDice_MatchConfirm:ClearUpdateLuaFunc()
    HandleEventLUp_YachtDice_MatchRefuse()
    return
  end
end
function FromClient_YachtDice_MatchConfirm_ChangeMatchState(matchState)
  local self = PaGlobal_YachtDice_MatchConfirm
  if self == nil then
    return
  end
  if matchState == __eYachtDiceMatchState_MatchingComplete then
    self:prepareOpen()
  else
    self:prepareClose()
  end
end
function PaGlobalFunc_YachtDice_MatchConfirm_IsShow()
  local panel = Panel_Widget_MiniGame_YachtDice_MatchConfirm
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
