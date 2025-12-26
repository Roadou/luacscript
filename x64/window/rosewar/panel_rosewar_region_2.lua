function PaGlobalFunc_RoseWarRegion_Update(deltaTime)
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_RoseWarRegion_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  if state == __eRoseWar_Stop then
    self:prepareClose()
    PaGlobalFunc_Radar_ClearRegionSubNameText()
    PaGlobalFunc_WorldMinimap_ClearRegionSubNameText()
  end
end
function FromClient_RoseWarRegion_ChangeNearRegion(fierceBattleKeyRaw)
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  self:prepareOpen(fierceBattleKeyRaw)
end
function FromClient_RoseWarRegion_FindNearRegion(fierceBattleKeyRaw)
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  self:prepareOpen(fierceBattleKeyRaw)
end
function FromClient_RoseWarRegion_RemoveNearRegion()
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobalFunc_Radar_ClearRegionSubNameText()
  PaGlobalFunc_WorldMinimap_ClearRegionSubNameText()
end
