function PaGlobal_GalleyMember_All_Open()
  if Panel_Widget_GalleyMember == nil then
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
  PaGlobal_GalleyMember_All:prepareOpen()
end
function PaGlobal_GalleyMember_All_Close()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:prepareClose()
end
function PaGlobal_GalleyMember_All_UpdatePerFrame(deltaTime)
  PaGlobal_GalleyMember_All:UpdatePerFrame(deltaTime)
end
function PaGlobal_GalleyMember_All_Update()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:update()
end
function PaGlobal_GalleyMember_All_UpdateMemberList()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:updateMemberSlotUI()
end
function PaGlobal_GalleyMember_All_ResponseRoundResult(servantNo, userNo, resultType, round)
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:responseRoundResult(servantNo, userNo, resultType, round)
end
function PaGlobal_GalleyMember_All_AddMember(actorKey)
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:addMember(actorKey)
end
function PaGlobal_GalleyMember_All_RemoveMember(actorKey)
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:removeMember(actorKey)
end
function PaGlobal_GalleyMember_All_ResponsePaddleMiniGameStart()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:responsePaddleMiniGameStart()
end
function PaGlobal_GalleyMember_All_GetMiniGamePlayerCount()
  if Panel_Widget_GalleyMember == nil then
    return 0
  end
  return PaGlobal_GalleyMember_All:getMiniGamePlayerCount()
end
function PaGlobal_GalleyMember_All_GetClearedMiniGamePlayerCount()
  if Panel_Widget_GalleyMember == nil then
    return 0
  end
  return PaGlobal_GalleyMember_All:getClearedMiniGamePlayerCount()
end
function PaGlobal_GalleyMember_All_GetPlayerCount()
  if Panel_Widget_GalleyMember == nil then
    return 0
  end
  return PaGlobal_GalleyMember_All:getPlayerCount()
end
function PaGlobal_GalleyMember_All_ResponsePaddleMiniGameEnd()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:responsePaddleMiniGameEnd()
end
function PaGlobal_GalleyMember_All_SimpleOpen()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:open()
end
function PaGlobal_GalleyMember_All_SimpleClose()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  PaGlobal_GalleyMember_All:close()
end
function PaGlobal_GalleyMember_All_IsShow()
  if Panel_Widget_GalleyMember == nil then
    return false
  end
  return Panel_Widget_GalleyMember:GetShow()
end
function FromClient_ActorRideOnVehicle(vehicleActorKey, seatIndex, playerActorKey)
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
  if vehicleActorKey ~= actorKeyRaw then
    return
  end
  local vehicleProxyWrapper = getVehicleActor(vehicleActorKey)
  if vehicleProxyWrapper == nil then
    return
  end
  local vehicleProxy = vehicleProxyWrapper:get()
  if nil == vehicleProxy then
    return
  end
  if vehicleProxy:isUseGuildShipBoostGauge() == true then
    if selfPlayerWrapper:getActorKey() == playerActorKey then
      local vehicleType = vehicleProxy:getVehicleType()
      if selfPlayer:getVehicleSeatIndex() == 0 or ToClient_IsVehiclePaddleSeatIndex(vehicleType, selfPlayer:getVehicleSeatIndex()) == true then
        PaGlobal_GalleyMember_All_Open()
        PaGlobal_GalleyBoost_All_Open()
        return
      end
    end
    PaGlobal_GalleyMember_All_AddMember(playerActorKey)
    PaGlobal_GalleyMember_All_UpdateMemberList()
    PaGlobal_GalleyBoost_All_UpdatePlayMemberCountUI()
  end
end
function FromClient_ActorRideOffVehicle(vehicleActorKey, seatIndex, playerActorKey)
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
  if vehicleActorKey ~= actorKeyRaw then
    return
  end
  PaGlobal_GalleyMember_All_RemoveMember(playerActorKey)
  PaGlobal_GalleyMember_All_UpdateMemberList()
  PaGlobal_GalleyBoost_All_UpdatePlayMemberCountUI()
end
function FromClient_RideOffGalleyMember()
  PaGloabl_MiniGame_GalleyPaddle_All_Close()
end
function FromClient_PaddleMiniGameRoundResult(servantNo, userNo, resultType, round)
  PaGlobal_GalleyMember_All_ResponseRoundResult(servantNo, userNo, resultType, round)
end
