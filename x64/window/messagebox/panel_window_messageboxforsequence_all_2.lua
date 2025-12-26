function PaGlobalFunc_MessageBoxForSequence_All_Open(elementalBossKey)
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  self:prepareOpen(elementalBossKey)
end
function PaGlobalFunc_MessageBoxForSequence_All_Close()
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_MessageBoxForSequence_All_IsOpen()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  return Panel_Window_MessageBoxForSequence_All:GetShow() == true
end
function PaGlobalFunc_MessageBoxForSequence_All_Enter()
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  self:answerMorningLandBossParty(true, false)
end
function PaGlobalFunc_MessageBoxForSequence_All_Refuse()
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  if self._isAcceptInvite == true then
    return
  end
  self:answerMorningLandBossParty(false, false)
end
function FromClient_OpenMessageBoxForSequence(elementalBossKey, isHelpUser)
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  self:prepareOpen(elementalBossKey, isHelpUser)
end
function FromClient_CloseMorningLandBossEnter()
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function FromClient_WaitTeleportMoringBossEnter(elementalBossKey)
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  local selfIsPartyLeader = RequestParty_isLeader()
  if selfIsPartyLeader == true then
    self:prepareClose()
  else
    Panel_Window_MessageBoxForSequence_All:ClearUpdateLuaFunc()
    local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(elementalBossKey)
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(elementalBossKey)
    local bossName = characterStaticStatusWarpper:getName()
    local difficulty = PAGetString(Defines.StringSheet_RESOURCE, self._difficultList[morningBossSSW:getLevel()])
    local messageboxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_TELEPORTING", "bossname", bossName, "difficulty", difficulty)
    self._ui._multilineText_content:SetText(messageboxMemo)
  end
end
function FromClient_WithdrawPartyMemberMorningBossEnter(withdrawType, actorKey, isMe, isLeaderLogout)
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  if Panel_Window_MessageBoxForSequence_All:GetShow() == false then
    return
  end
  if isLeaderLogout == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPartyLeaderIsNotLogined"))
    self:prepareClose()
  end
end
function FromClient_RefuseMorningLandBossEnter(userNo, userNickName, refuseType, symbol)
  local self = PaGlobal_Window_MessageBoxForSequence_All
  if self == nil then
    return
  end
  local nakString = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictInstanceField")
  if refuseType == 0 then
    local selfUserNo = getSelfPlayer():get():getUserNo()
    if selfUserNo == userNo then
      return
    end
    nakString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_ENTER_FAIL", "characterName", userNickName)
  elseif refuseType == 1 then
    nakString = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedFivePartyMember")
  elseif refuseType == 2 then
    local selfUserNo = getSelfPlayer():get():getUserNo()
    if selfUserNo == userNo then
      nakString = PAGetStringSymNo(rv)
    else
      nakString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_ENTER_FAIL", "characterName", userNickName)
    end
  else
    if refuseType == 3 then
      nakString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_ENTER_FAIL_TIMEOUT")
    else
    end
  end
  self:prepareClose()
  Proc_ShowMessage_Ack(nakString)
end
function FromClient_MessageBoxForSequence_UpdatePerFrame(deltaTime)
  PaGlobal_Window_MessageBoxForSequence_All._messageDeltaTime = PaGlobal_Window_MessageBoxForSequence_All._messageDeltaTime + deltaTime
  local rate = PaGlobal_Window_MessageBoxForSequence_All._messageDeltaTime / PaGlobal_Window_MessageBoxForSequence_All._MESSAGEBOX_CLOSETIME
  rate = (1 - rate) * 100
  PaGlobal_Window_MessageBoxForSequence_All._ui._stc_progressBar:SetProgressRate(rate)
  if PaGlobal_Window_MessageBoxForSequence_All._messageDeltaTime >= PaGlobal_Window_MessageBoxForSequence_All._MESSAGEBOX_CLOSETIME then
    Panel_Window_MessageBoxForSequence_All:ClearUpdateLuaFunc()
    PaGlobal_Window_MessageBoxForSequence_All:answerMorningLandBossParty(false, true)
  end
end
function PaGloabl_Window_MessageBoxForSequence_All_ShowAni()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
end
function PaGloabl_Window_MessageBoxForSequence_All_HideAni()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
end
