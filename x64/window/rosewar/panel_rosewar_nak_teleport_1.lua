function PaGlobal_RoseWarNakTeleport:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_normalBG = UI.getChildControl(Panel_RoseWar_Nak_Teleport, "Static_RoseWar_Teleport_Normal")
  self._ui._txt_normalTime = UI.getChildControl(self._ui._stc_normalBG, "StaticText_2")
  self._ui._stc_vehicleBG = UI.getChildControl(Panel_RoseWar_Nak_Teleport, "Static_RoseWar_Teleport_Vehicle")
  self._ui._txt_vehicleTime = UI.getChildControl(self._ui._stc_vehicleBG, "StaticText_2")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarNakTeleport:registEventHandler()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  registerEvent("FromClient_ShowRoseWarRecallAlarmUI", "FromClient_ShowRoseWarRecallAlarmUI")
end
function PaGlobal_RoseWarNakTeleport:prepareOpen(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  if ToClient_IsParticipateInRoseWar() == false then
    return
  end
  self._accumulatedDeltaTime = 0
  self._remainTimeSec = 0
  self._showTimeSec = showTimeSec
  self._targetFierceBattleKeyRaw = fierceBattleKeyRaw
  self._isVehicleMode = isVehicleMode
  self._ui._stc_normalBG:SetShow(self._isVehicleMode == false)
  self._ui._stc_vehicleBG:SetShow(self._isVehicleMode == true)
  self:open()
end
function PaGlobal_RoseWarNakTeleport:open()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  Panel_RoseWar_Nak_Teleport:RegisterUpdateFunc("PaGlobalFunc_RoseWarNakTeleport_Update")
  Panel_RoseWar_Nak_Teleport:SetShow(true)
end
function PaGlobal_RoseWarNakTeleport:prepareClose()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  self._accumulatedDeltaTime = 0
  self._showTimeSec = 0
  self:close()
end
function PaGlobal_RoseWarNakTeleport:close()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  Panel_RoseWar_Nak_Teleport:ClearUpdateLuaFunc()
  Panel_RoseWar_Nak_Teleport:SetShow(false)
end
function PaGlobal_RoseWarNakTeleport:validate()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  self._ui._stc_normalBG:isValidate()
  self._ui._txt_normalTime:isValidate()
  self._ui._stc_vehicleBG:isValidate()
  self._ui._txt_vehicleTime:isValidate()
end
function PaGlobal_RoseWarNakTeleport:update(deltaTime)
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  self._accumulatedDeltaTime = self._accumulatedDeltaTime + deltaTime
  if self._showTimeSec <= self._accumulatedDeltaTime then
    self:prepareClose()
    return
  end
  local remainTimeSec = math.floor(self._showTimeSec - self._accumulatedDeltaTime) + 1
  if self._remainTimeSec ~= remainTimeSec then
    self._remainTimeSec = remainTimeSec
    self:updateText()
  end
end
function PaGlobal_RoseWarNakTeleport:updateText()
  if Panel_RoseWar_Nak_Teleport == nil then
    return
  end
  local targetFierceBattleObjectName = ""
  local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(self._targetFierceBattleKeyRaw)
  if targetFierceBattleObjectWrapper ~= nil then
    targetFierceBattleObjectName = targetFierceBattleObjectWrapper:getName()
  end
  if self._isVehicleMode == true then
    self._ui._txt_vehicleTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_TELEPORT_VEHICLE", "second", self._remainTimeSec))
  else
    self._ui._txt_normalTime:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_TELEPORT_NORMAL", "second", self._remainTimeSec, "sanctum", targetFierceBattleObjectName))
  end
end
