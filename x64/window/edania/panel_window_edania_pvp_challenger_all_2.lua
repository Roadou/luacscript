function PaGlobal_Edania_PVP_Challenger_Open()
  local self = PaGlobal_Edania_PVP_Challneger
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_Edania_PVP_Challenger_Close()
  local self = PaGlobal_Edania_PVP_Challneger
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Edania_PVP_Challenger_IsOpen()
  return Panel_Window_Edania_PVP_Challenger:GetShow() == true
end
function FromClient_Edania_PVP_Challenger_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Edania_PVP_Challneger
  if self == nil then
    return
  end
  local state = ToClient_GetEdanaInstanceFieldState()
  if state == __eEdaniaInstanceContentsState_Ready then
    local remainTime = ToClient_GetInstanceFieldNextStateRemainTime()
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
    if remainTime > 0 and remainTime <= 5 and PaGlobalFunc_EdaniaCountDown_GetShow() == false then
      PaGlobalFunc_EdaniaCountDown_Open(remainTime)
    end
  elseif state == __eEdaniaInstanceContentsState_Play then
    local remainTime = ToClient_GetInstanceFieldNextStateRemainTime()
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
    self._elapsedTime = self._elapsedTime + deltaTime
    if self._elapsedTime >= 20 then
      self._ui._stc_BuffBG:SetShow(false)
      self._ui._stc_EnemyBuffBoarder:SetShow(false)
      self._ui._stc_Selected:SetShow(false)
      self._ui._stc_Direction:SetShow(false)
      self._ui._stc_Circle:SetShow(false)
      for idx = 1, __eEdanaChallengerCount do
        self._ui._stc_PlayerControl[idx]._control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Edania_PVP_HUD_Candidate_PlayerBG")
      end
      self._elapsedTime = 0
    end
  end
end
function FromClient_UpdateEdaniaInstanceFieldChallengerHp(rankIndex, leftPercent)
  local self = PaGlobal_Edania_PVP_Challneger
  if self == nil then
    return
  end
  self:updateUserHp(rankIndex, leftPercent)
end
function FromClient_UpdateEdaniaInstanceFieldChallengerUI(actorKey)
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == false or ToClient_GetEdanaInstanceFieldMode() ~= __eEdaniaInstanceContentsMode_Challenger then
    return
  end
  local self = PaGlobal_Edania_PVP_Challneger
  local selfPlayerWrapper = getSelfPlayer()
  local playerActor = getPlayerActor(actorKey)
  if self == nil or selfPlayerWrapper == nil or playerActor == nil then
    for buffIcon_idx = 0, self._appliedBuff_UIPool_Last do
      if self._appliedBuff_UIPool[buffIcon_idx] then
        self._appliedBuff_UIPool[buffIcon_idx]:SetShow(false)
      end
    end
    return
  end
  for buffIcon_idx = 0, self._appliedBuff_UIPool_Last do
    if self._appliedBuff_UIPool[buffIcon_idx] then
      self._appliedBuff_UIPool[buffIcon_idx]:SetShow(false)
    end
  end
  local userNo = playerActor:getUserNo()
  self._ui._stc_BuffBG:SetShow(false)
  self._ui._stc_EnemyBuffBoarder:SetShow(false)
  self._ui._stc_Selected:SetShow(false)
  self._ui._stc_Direction:SetShow(false)
  self._ui._stc_Circle:SetShow(false)
  for idx = 1, __eEdanaChallengerCount do
    local playerInfo = self._ui._stc_PlayerControl[idx]
    local control = playerInfo._control
    local challengerUserNo = playerInfo._userNo
    if userNo == challengerUserNo then
      self._ui._stc_BuffBG:SetShow(true)
      self._ui._stc_EnemyBuffBoarder:SetShow(true)
      self._ui._stc_Selected:SetShow(true)
      self._ui._stc_Selected:SetPosXY(control:GetPosX() + (control:GetSizeX() - self._ui._stc_Selected:GetSizeX()) * 0.5, control:GetPosY())
      self._ui._stc_Direction:SetShow(true)
      self._ui._stc_Direction:SetPosXY(control:GetPosX() + (control:GetSizeX() - self._ui._stc_Direction:GetSizeX()) * 0.5, self._ui._stc_Direction:GetPosY())
      self._ui._stc_Circle:SetShow(true)
      self._ui._stc_Circle:SetPosXY(control:GetPosX() + (control:GetSizeX() - self._ui._stc_Circle:GetSizeX()) * 0.5, control:GetPosY())
      self._elapsedTime = 0
      local appliedBuff = playerActor:getAppliedBuffBeginNotSort()
      local appliedBuff_Idx = 0
      while appliedBuff ~= nil do
        local appliedBuffType
        if self._appliedBuff_UIPool[appliedBuff_Idx] == nil then
          local buffIcon = UI.createControl(__ePAUIControl_Static, self._ui._stc_EnemyBuffBoarder, "monsterBuffIcon_" .. appliedBuff_Idx)
          CopyBaseProperty(self._ui._stc_EnemyBuffIcon, buffIcon)
          self._appliedBuff_UIPool[appliedBuff_Idx] = buffIcon
          if appliedBuff_Idx > self._appliedBuff_UIPool_Last then
            self._appliedBuff_UIPool_Last = appliedBuff_Idx
          end
        end
        self._appliedBuff_UIPool[appliedBuff_Idx]:ChangeTextureInfoNameAsync("icon/" .. appliedBuff:getIconName())
        local x1, y1, x2, y2 = setTextureUV_Func(self._appliedBuff_UIPool[appliedBuff_Idx], 0, 0, 32, 32)
        self._appliedBuff_UIPool[appliedBuff_Idx]:getBaseTexture():setUV(x1, y1, x2, y2)
        self._appliedBuff_UIPool[appliedBuff_Idx]:setRenderTexture(self._appliedBuff_UIPool[appliedBuff_Idx]:getBaseTexture())
        self._appliedBuff_UIPool[appliedBuff_Idx]:SetShow(true)
        self._appliedBuff_UIPool[appliedBuff_Idx]:SetSpanSize(self._appliedBuff_UIPool[appliedBuff_Idx]:GetSizeX() * appliedBuff_Idx, self._appliedBuff_UIPool[appliedBuff_Idx]:GetSpanSize().y)
        appliedBuff_Idx = appliedBuff_Idx + 1
        appliedBuff = playerActor:getAppliedBuffNextNotSort()
        self._ui._stc_EnemyBuffBoarder:SetSize(self._ui._stc_EnemyBuffIcon:GetSizeX() * appliedBuff_Idx, self._ui._stc_EnemyBuffBoarder:GetSizeY())
        self._ui._stc_EnemyBuffBoarder:ComputePos()
      end
      local sizeX = math.max(self._challengerCount * (control:GetSizeX() + 30), appliedBuff_Idx * self._ui._stc_EnemyBuffIcon:GetSizeX()) + 100
      self._ui._stc_BuffBG:SetSize(sizeX, self._ui._stc_BuffBG:GetSizeY())
      self._ui._stc_BuffBG:ComputePos()
    end
  end
end
