function PaGlobalFunc_RoseWarMissionAccept_Update(deltaTime)
  local self = PaGlobal_RoseWarMissionAccept
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_RoseWarMissionAccept_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWarMissionAccept
  if self == nil then
    return
  end
  if state == __eRoseWar_Stop then
    self:prepareClose()
  end
end
function FromClient_RoseWarMissionAccept_ReceivedNewRoseWarMission(missionKey)
  local self = PaGlobal_RoseWarMissionAccept
  if self == nil then
    return
  end
  self:prepareOpen(missionKey)
end
