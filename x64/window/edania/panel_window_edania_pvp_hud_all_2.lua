function PaGlobal_Edania_PVP_HUD_Open()
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_Edania_PVP_HUD_Close()
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Edania_PVP_HUD_IsOpen()
  return Panel_Window_Edania_PVP_HUD:GetShow() == true
end
function FromClient_UpdateEdaniaInstanceField(mode)
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  if mode == __eEdaniaInstanceContentsMode_Challenger then
    PaGlobal_Edania_PVP_Challenger_Open()
  elseif mode == __eEdaniaInstanceContentsMode_Edana then
    PaGlobal_Edania_PVP_HUD_Open()
  end
end
function FromClient_Edania_PVP_HUD_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  local state = ToClient_GetEdanaInstanceFieldState()
  local roundState = ToClient_GetEdanaInstanceFieldRoundState()
  if state == __eEdaniaInstanceContentsState_Play then
    if roundState == __eEdaniaInstanceContentsRoundState_Ready then
      local remainTime = ToClient_GetInstanceFieldNextStateRemainTime()
      self._ui._txt_CenterTime:SetText(convertSecondsToClockTime(remainTime))
      if remainTime > 0 and remainTime <= 5 and PaGlobalFunc_EdaniaCountDown_GetShow() == false then
        PaGlobalFunc_EdaniaCountDown_Open(remainTime)
      end
    elseif roundState == __eEdaniaInstanceContentsRoundState_Play then
      local remainTime = ToClient_GetInstanceFieldNextStateRemainTime()
      self._ui._txt_CenterTime:SetText(convertSecondsToClockTime(remainTime))
    elseif roundState == __eEdaniaInstanceContentsRoundState_End then
    end
  end
end
function FromClient_UpdateEdaniaInstanceFieldEdanaHp(teamNo, leftPercent)
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  self:updateUserHp(teamNo, leftPercent)
end
function FromClient_UpdateEdaniaInstanceFieldRoundResult(winState)
  local self = PaGlobal_Edania_PVP_HUD
  if self == nil then
    return
  end
  self:updateResult(winState)
end
