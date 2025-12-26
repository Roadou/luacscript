function PaGlobalFunc_RoseWarMissionWidget_Open()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RoseWarMissionWidget_Close()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarMissionWidget_IsShow()
  local panel = Panel_RoseWar_MissionWidget
  if panel == nil then
    return false
  end
  return Panel_RoseWar_MissionWidget:GetShow()
end
function PaGlobalFunc_RoseWarMissionWidget_Update(deltaTime)
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  self:updateResultTimer(deltaTime)
  self:updateTimer(deltaTime)
end
function FromClient_RoseWarMissionWidget_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil or state == nil then
    return
  end
  if state == __eRoseWar_Start then
    if ToClient_IsRoseWarObserveMode() == true then
      return
    end
    if ToClient_IsParticipateInRoseWar() == false then
      return
    end
    self:hideQuestWidget(true)
    PaGlobalFunc_RoseWarScoreBoardWidget_Open()
    if IsSelfPlayerRoseWarGrade_MercenaryPartyLeader() == true or IsSelfPlayerRoseWarGrade_Mercenary() == true then
      PaGlobalFunc_RoseWarMissionWidget_Open()
    end
  else
    PaGlobalFunc_RoseWarScoreBoardWidget_Close()
    PaGlobalFunc_RoseWarMissionWidget_Close()
  end
end
function FromClient_RoseWarMissionWidget_CreateMission(missionKey)
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMissionWidget_IsShow() == false then
    if ToClient_IsParticipateInRoseWar() == false then
      return
    end
    PaGlobalFunc_RoseWarScoreBoardWidget_Open()
    if IsSelfPlayerRoseWarGrade_MercenaryPartyLeader() == true or IsSelfPlayerRoseWarGrade_Mercenary() == true then
      PaGlobalFunc_RoseWarMissionWidget_Open()
    end
  end
  self:setProgressMission(missionKey)
end
function FromClient_RoseWarMissionWidget_CompleteMission()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMissionWidget_IsShow() == false then
    return
  end
  self:showResult(self._eResultType.COMPLTE)
  self:missionComplete()
end
function FromClient_RoseWarMissionWidget_FailedMission()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMissionWidget_IsShow() == false then
    return
  end
  self:showResult(self._eResultType.FAIL)
  self:missionFail()
end
function FromClient_RoseWarMissionWidget_UpdateMissionCondition()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMissionWidget_IsShow() == false then
    return
  end
  self:updateCondition()
end
function FromClient_RoseWarMissionWidget_UpdateSelfPlayerRoseWarState()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarMissionWidget_IsShow() == true then
    return
  end
  if ToClient_IsParticipateInRoseWar() == true then
    FromClient_RoseWarMissionWidget_ChangeRoseWarState(ToClient_GetRoseWarState())
    FromClient_RoseWarMissionWidget_CreateMission(ToClient_GetCurrentProgressRoseWarMissionKey())
  end
end
function FromClient_RoseWarMissionWidget_OnScreenResize()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  self:onScreenResize()
end
function HandleEventLUp_RoseWarMissionWidget_FindNavi()
  local self = PaGlobal_RoseWarMissionWidget
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(self._currentProgressMissionKey)
  if missionDataWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  local missionType = missionDataWrapper:getMissionType()
  if missionType == __eRoseWarMissionType_FierceAttack or missionType == __eRoseWarMissionType_FierceDefence or missionType == __eRoseWarMissionType_GimmikAttack then
    local fierceBattleKeyRaw = missionDataWrapper:getTargetFierceBattleKeyRaw()
    local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
    if fierceBattleObjectInfoWrapper == nil then
      return
    end
    RoseWarMiniMap_SetNavigationWithoutFromUserNo(fierceBattleObjectInfoWrapper:getPosition(), true)
  elseif missionType == __eRoseWarMissionType_CastleAttack then
    local enemyTeamNo
    if selfPlayerTeamNo == __eRoseWarTeam_Kamasylvia then
      enemyTeamNo = __eRoseWarTeam_Odyllita
    elseif selfPlayerTeamNo == __eRoseWarTeam_Odyllita then
      enemyTeamNo = __eRoseWarTeam_Kamasylvia
    end
    if enemyTeamNo == nil then
      return
    end
    local enemyBossInfo = ToClient_GetRoseWarBossInfoXXX(enemyTeamNo)
    if enemyBossInfo == nil then
      return
    end
    RoseWarMiniMap_SetNavigationWithoutFromUserNo(enemyBossInfo._position, true)
  elseif missionType == __eRoseWarMissionType_CastleDefence then
    local bossInfo = ToClient_GetRoseWarBossInfoXXX(selfPlayerTeamNo)
    if bossInfo == nil then
      return
    end
    RoseWarMiniMap_SetNavigationWithoutFromUserNo(bossInfo._position, true)
  end
end
