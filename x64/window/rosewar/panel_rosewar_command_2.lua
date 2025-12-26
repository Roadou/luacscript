function PaGlobalFunc_RoseWarCommand_Open(openPlayerGradeType)
  local self = PaGlobal_RoseWarCommand
  if self == nil then
    return
  end
  if openPlayerGradeType ~= __eRoseWarPlayerGradeType_Commander then
    return
  end
  if self._lastPosXY_gameScene == nil then
    local posX = Panel_Radar:GetPosX() - Panel_RoseWar_Command:GetSizeX() - 20
    local posY = Panel_Radar:GetPosY() + 100
    self._lastPosXY_gameScene = float2(posX, posY)
  end
  self._openWorldPosition = float3(0, 0, 0)
  self._openByMiniMap = false
  self:prepareOpen(openPlayerGradeType, self._lastPosXY_gameScene.x, self._lastPosXY_gameScene.y)
end
function PaGlobalFunc_RoseWarCommand_OpenByMiniMap(openPlayerGradeType, worldPosition)
  local self = PaGlobal_RoseWarCommand
  if self == nil then
    return
  end
  if openPlayerGradeType ~= __eRoseWarPlayerGradeType_Commander then
    return
  end
  local posX = getMousePosX()
  local posY = getMousePosY()
  if self._openByMiniMap == false then
    self._lastPosXY_gameScene = float2(Panel_RoseWar_Command:GetPosX(), Panel_RoseWar_Command:GetPosY())
  end
  self._openWorldPosition = worldPosition
  self._openByMiniMap = true
  self:prepareOpen(openPlayerGradeType, posX, posY)
end
function PaGlobalFunc_RoseWarCommand_Close()
  local self = PaGlobal_RoseWarCommand
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarCommand_IsShow()
  if Panel_RoseWar_Command == nil then
    return false
  end
  return Panel_RoseWar_Command:GetShow()
end
function HandleEventLUp_RoseWarCommand_ProcessCommand(commandEventType)
  local self = PaGlobal_RoseWarCommand
  if self == nil or commandEventType == nil then
    return
  end
  if self._openByMiniMap == false then
    self._openWorldPosition = getSelfPlayer():get3DPos()
  end
  ToClient_ProcessRoseWarCommandEvent(commandEventType, self._openWorldPosition, true)
  if self._openByMiniMap == true then
    self:prepareClose()
  end
end
function FromClient_RoseWarCommand_ReceivedRoseWarCommand(fromUserNo, commandEventType, worldPosition)
  local self = PaGlobal_RoseWarCommand
  if self == nil or fromUserNo == nil or commandEventType == nil or worldPosition == nil then
    return
  end
  if commandEventType == __eRoseWarCommandEventType_RequestAttackSupport or commandEventType == __eRoseWarCommandEventType_RequestDefenceSupport or commandEventType == __eRoseWarCommandEventType_FightingNow or commandEventType == __eRoseWarCommandEventType_SafePosition or commandEventType == __eRoseWarCommandEventType_Ping_Red or commandEventType == __eRoseWarCommandEventType_Ping_Blue or commandEventType == __eRoseWarCommandEventType_Ping_Green or commandEventType == __eRoseWarCommandEventType_Ping_Yellow then
    PaGlobalFunc_RoseWarMiniMap_AddPingAndMarker(commandEventType, worldPosition)
  elseif commandEventType == __eRoseWarCommandEventType_Move then
    RoseWarMiniMap_SetNavigation(fromUserNo, worldPosition)
  else
    UI.ASSERT_NAME(false, "RoseWarCommandEventType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function FromClient_RoseWarCommand_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWarCommand
  if self == nil or state == nil then
    return
  end
  if IsSelfPlayerRoseWarGrade_SubCommander() == false then
    return
  end
  if state == __eRoseWar_Start then
    PaGlobalFunc_RoseWarCommand_Open(__eRoseWarPlayerGradeType_SubCommander)
  else
    PaGlobalFunc_RoseWarCommand_Close()
  end
end
