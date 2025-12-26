function PaGlobal_GalleyBoost_All_Open()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local actorKeyRaw = selfPlayer:getRideVehicleActorKeyRaw()
  if actorKeyRaw == nil then
    return
  end
  local vehicleProxyWrapper = getVehicleActor(actorKeyRaw)
  if vehicleProxyWrapper == nil then
    return
  end
  local vehicleProxy = vehicleProxyWrapper:get()
  if vehicleProxy == nil then
    return
  end
  if vehicleProxy:isUseGuildShipBoostGauge() == false then
    return
  end
  PaGlobal_GalleyBoost_All:prepareOpen()
end
function PaGlobal_GalleyBoost_All_Close()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:prepareClose()
end
function PaGlobal_GalleyBoost_All_UpdatePerFrame(deltaTime)
  PaGlobal_GalleyBoost_All:UpdatePerFrame(deltaTime)
end
function PaGlobal_GalleyBoost_All_Update()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:update()
end
function PaGlobal_GalleyBoost_All_SetState(stateType, isActive)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:setState(stateType, isActive)
end
function PaGlobal_GalleyBoost_All_SetLastStartMiniGameTime(utcTime32)
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:setLastStartMiniGameTime(utcTime32)
end
function PaGlobal_GalleyBoost_All_ToActionChartGalleyShipBoostOn()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:setState(PaGlobal_GalleyBoost_All._stateType.Boost, true)
end
function PaGlobal_GalleyBoost_All_ToActionChartGalleyShipBoostOff()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:setState(PaGlobal_GalleyBoost_All._stateType.Boost, false)
end
function PaGlobal_GalleyBoost_All_UpdatePlayMemberCountUI()
  if Panel_Widget_GalleyBoost == nil then
    return
  end
  PaGlobal_GalleyBoost_All:updatePlayMemberCountUI()
end
