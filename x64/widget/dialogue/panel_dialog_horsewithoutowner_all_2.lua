function PaGlobalFunc_Panel_Dialog_HorseWithoutOwner_All_Open()
  PaGlobal_HorseWithoutOwner:prepareOpen()
end
function PaGlobalFunc_Panel_Dialog_HorseWithoutOwner_All_Close()
  PaGlobal_HorseWithoutOwner:prepareClose()
end
function PaGlobalFunc_HorseWithoutOwner_All_CheckMasterlessHorse(characterKey)
  if _ContentsGroup_MasterlessHorse == false then
    return false
  end
  return PaGlobal_HorseWithoutOwner._rentCharacterKeyRaw == characterKey
end
function HandleEventLUp_HorseWithoutOwner_SummonOrReturn()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  if _ContentsGroup_MasterlessHorse == false then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if landVehicleWrapper ~= nil then
    if landVehicleWrapper:getCharacterKeyRaw() ~= PaGlobal_HorseWithoutOwner._rentCharacterKeyRaw then
      PaGlobal_HorseWithoutOwner:prepareClose()
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
    local rideVehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
    if rideVehicleProxy ~= nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
      return
    end
    local rv = ToClient_ReturnMasterLessHorse()
    if rv == 0 then
      PaGlobal_HorseWithoutOwner:prepareClose()
      if HandleEventLUp_VehicleInfo_All_Close ~= nil then
        HandleEventLUp_VehicleInfo_All_Close()
      end
    end
  else
    if Panel_Dialog_HorseWithoutOwner_All:GetShow() == false then
      return
    end
    local rv = ToClient_SummonMasterLessHorse(PaGlobal_HorseWithoutOwner._rentCharacterKeyRaw)
    if rv == 0 then
      PaGlobal_HorseWithoutOwner:prepareClose()
    end
  end
end
function HandleEventLUp_HorseWithoutOwner_Return()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  if _ContentsGroup_MasterlessHorse == false then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if landVehicleWrapper == nil then
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
  local rideVehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
  if rideVehicleProxy ~= nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    return
  end
  local rv = ToClient_ReturnMasterLessHorse()
  if rv == 0 then
    PaGlobal_HorseWithoutOwner:prepareClose()
    if HandleEventLUp_VehicleInfo_All_Close ~= nil then
      HandleEventLUp_VehicleInfo_All_Close()
    end
  end
end
