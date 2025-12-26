function FromClient_ShowRoseWarRecallAlarmUI(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
  local self = PaGlobal_RoseWarNakTeleport
  if self == nil then
    return
  end
  self:prepareOpen(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
end
function PaGlobalFunc_RoseWarNakTeleport_Update(deltaTime)
  local self = PaGlobal_RoseWarNakTeleport
  if self == nil then
    return
  end
  self:update(deltaTime)
end
