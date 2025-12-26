function PaGlobal_HorseSubMp_All_Open()
  if Panel_HorseSubMp_All == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfProxy = selfPlayerWrapper:get()
  if selfProxy == nil then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if actorKeyRaw == nil or actorKeyRaw == 0 then
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
  local vehicleType = vehicleProxy:getVehicleType()
  if selfProxy:isVehicleDriver() == false and ToClient_IsVehiclePaddleSeatIndex(vehicleType, selfProxy:getVehicleSeatIndex()) == false then
    return
  end
  PaGlobal_HorseSubMp_All:setVehicleActorKey(actorKeyRaw)
  PaGlobal_HorseSubMp_All:prepareOpen()
end
function PaGlobal_HorseSubMp_All_OpenByLandVehicle()
  if nil == Panel_HorseSubMp_All then
    return
  end
  PaGlobal_HorseSubMp_All:prepareOpen()
end
function PaGlobal_HorseSubMp_All_Close()
  if nil == Panel_HorseSubMp_All then
    return
  end
  PaGlobal_HorseSubMp_All:prepareClose()
end
function PaGlobal_HorseSubMp_All_SetShowGaugeText(isShow)
  if nil == Panel_HorseSubMp_All then
    return
  end
  PaGlobal_HorseSubMp_All._ui._txt_gauge:SetShow(isShow)
end
function FromClient_HorseSubMp_All_UpdateWaterRunGauge(curGauge, maxGauge)
  if nil == Panel_HorseSubMp_All then
    return
  end
  PaGlobal_HorseSubMp_All:updateStat(curGauge, maxGauge)
end
function FromClient_UpdateGuildShipBoostGauge(curGauge, maxGauge)
  if nil == Panel_HorseSubMp_All then
    return
  end
  PaGlobal_HorseSubMp_All:updateStat(curGauge, maxGauge)
end
function FromClient_HorseSubMp_All_ResizePanel()
  if nil == Panel_HorseSubMp_All then
    return
  end
  Panel_HorseSubMp_All:ComputePosAllChild()
  if _ContentsGroup_RenewUI then
    Panel_HorseSubMp_All:SetPosY(Panel_HorseMp:GetPosY() + Panel_HorseSubMp_All:GetSizeY() + 10)
  end
end
function HandleMouseOnOut_HorseSubMP_Show_Tooptip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(PaGlobal_HorseSubMp_All._ui._stc_gaugeProgress, PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_FANTASYMIX_DINE_GAUGE_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_FANTASYMIX_DINE_GAUGE_DESC"))
end
