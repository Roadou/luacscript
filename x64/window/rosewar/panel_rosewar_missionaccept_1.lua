function PaGlobal_RoseWarMissionAccept:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarMissionAccept:registEventHandler()
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarMissionAccept_ChangeRoseWarState")
  registerEvent("FromClient_ReceivedNewRoseWarMission", "FromClient_RoseWarMissionAccept_ReceivedNewRoseWarMission")
end
function PaGlobal_RoseWarMissionAccept:validate()
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  self._ui._txt_missionName:isValidate()
end
function PaGlobal_RoseWarMissionAccept:prepareOpen(missionKey)
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(missionKey)
  if missionDataWrapper == nil then
    return
  end
  local missionNameString
  local missionType = missionDataWrapper:getMissionType()
  if missionType == __eRoseWarMissionType_FierceAttack then
    local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ATTACK", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 49)
      _AudioPostEvent_SystemUiForXBOX(36, 49)
    end
  elseif missionType == __eRoseWarMissionType_FierceDefence then
    local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_DEFENSE", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 70)
      _AudioPostEvent_SystemUiForXBOX(36, 70)
    end
  elseif missionType == __eRoseWarMissionType_Kill then
    missionNameString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_KILL", "current", missionDataWrapper:getCondition(), "max", missionDataWrapper:getMaxCondition())
    audioPostEvent_SystemUi(36, 48)
    _AudioPostEvent_SystemUiForXBOX(36, 48)
  elseif missionType == __eRoseWarMissionType_CastleAttack then
    missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_ATTACK")
    audioPostEvent_SystemUi(35, 14)
    _AudioPostEvent_SystemUiForXBOX(35, 14)
  elseif missionType == __eRoseWarMissionType_CastleDefence then
    missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_DEFENSE")
    audioPostEvent_SystemUi(35, 14)
    _AudioPostEvent_SystemUiForXBOX(35, 14)
  elseif missionType == __eRoseWarMissionType_GimmikAttack then
    local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ACTIVE", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 50)
      _AudioPostEvent_SystemUiForXBOX(36, 50)
    end
  else
    return
  end
  if missionNameString == nil then
    return
  end
  self._timeAcc = 0
  self._ui._txt_missionName:SetText(missionNameString)
  self:open()
end
function PaGlobal_RoseWarMissionAccept:open()
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  Panel_RoseWar_MissionAccept:AddEffect("fUI_RoseWar_Nak_Arrow_01A", true, 0, 0)
  Panel_RoseWar_MissionAccept:RegisterUpdateFunc("PaGlobalFunc_RoseWarMissionAccept_Update")
  Panel_RoseWar_MissionAccept:ComputePos()
  Panel_RoseWar_MissionAccept:SetShow(true)
end
function PaGlobal_RoseWarMissionAccept:prepareClose()
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarMissionAccept:close()
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  Panel_RoseWar_MissionAccept:EraseAllEffect()
  Panel_RoseWar_MissionAccept:ClearUpdateLuaFunc()
  Panel_RoseWar_MissionAccept:SetShow(false)
end
function PaGlobal_RoseWarMissionAccept:update(deltaTime)
  if Panel_RoseWar_MissionAccept == nil then
    return
  end
  self._timeAcc = self._timeAcc + deltaTime
  if self._showTime <= self._timeAcc then
    self._timeAcc = 0
    self:prepareClose()
    return
  end
end
