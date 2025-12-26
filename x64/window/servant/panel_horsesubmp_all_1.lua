function PaGlobal_HorseSubMp_All:initialize()
  if true == PaGlobal_HorseSubMp_All._initialize then
    return
  end
  self._ui._stc_gaugeProgress = UI.getChildControl(Panel_HorseSubMp_All, "HorseGaugeBar")
  self._ui._txt_gauge = UI.getChildControl(Panel_HorseSubMp_All, "StaticText_Gauge")
  self._ui._txt_gauge:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_HorseSubMp_All:validate()
  if nil == Panel_HorseSubMp_All then
    return
  end
  self._ui._stc_gaugeProgress:isValidate()
  self._ui._txt_gauge:isValidate()
end
function PaGlobal_HorseSubMp_All:registEventHandler()
  if nil == Panel_HorseSubMp_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_HorseSubMp_All_ResizePanel")
  registerEvent("FromClient_UpdateWaterRunGauge", "FromClient_HorseSubMp_All_UpdateWaterRunGauge")
  registerEvent("FromClient_UpdateGuildShipBoostGauge", "FromClient_UpdateGuildShipBoostGauge")
end
function PaGlobal_HorseSubMp_All:prepareOpen()
  if nil == Panel_HorseSubMp_All then
    return
  end
  if nil ~= Panel_WorldMap and true == Panel_WorldMap:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local servantInfoWrapper = getServantInfoFromActorKey(self._vehicleActorKey)
  if nil == servantInfoWrapper then
    return
  end
  local vehicleProxyWrapper = getVehicleActor(self._vehicleActorKey)
  if nil == vehicleProxyWrapper then
    return
  end
  local vehicleProxy = vehicleProxyWrapper:get()
  if nil == vehicleProxy then
    return
  end
  if vehicleProxy:isUseWaterRunGauge() == false and vehicleProxy:isUseGroundRunGauge() == false and vehicleProxy:isUseAirRunGauge() == false and vehicleProxy:isUseGuildShipBoostGauge() == false then
    return
  end
  self._ui._stc_gaugeProgress:addInputEvent("Mouse_On", "")
  self._ui._stc_gaugeProgress:addInputEvent("Mouse_Out", "")
  local maxGauge = 0
  local curGauge = 0
  if vehicleProxy:isUseWaterRunGauge() == true then
    self._ui._stc_gaugeProgress:ChangeTextureInfoTextureIDAsync("Combine_Progress_DreamDine_Gauge_Blue")
    self._ui._stc_gaugeProgress:setRenderTexture(self._ui._stc_gaugeProgress:getBaseTexture())
    Panel_HorseSubMp_All:ChangeTextureInfoTextureIDAsync("Combine_Progress_DreamDine_Gauge_Black")
    Panel_HorseSubMp_All:setRenderTexture(Panel_HorseSubMp_All:getBaseTexture())
    maxGauge = servantInfoWrapper:getMaxServantStatParam(__eServantStatParamType_WaterRunGauge)
    curGauge = servantInfoWrapper:getServantStatParam(__eServantStatParamType_WaterRunGauge)
    self._ui._stc_gaugeProgress:addInputEvent("Mouse_On", "HandleMouseOnOut_HorseSubMP_Show_Tooptip(true)")
    self._ui._stc_gaugeProgress:addInputEvent("Mouse_Out", "HandleMouseOnOut_HorseSubMP_Show_Tooptip(false)")
  elseif vehicleProxy:isUseGroundRunGauge() == true then
    return
  elseif vehicleProxy:isUseAirRunGauge() == true then
    return
  elseif vehicleProxy:isUseGuildShipBoostGauge() == true then
    self._ui._stc_gaugeProgress:ChangeTextureInfoTextureIDAsync("Combine_Progress_MiniGame_16_Gauge")
    self._ui._stc_gaugeProgress:setRenderTexture(self._ui._stc_gaugeProgress:getBaseTexture())
    Panel_HorseSubMp_All:ChangeTextureInfoTextureIDAsync("Combine_Progress_MiniGame_16_Gauge_Black")
    Panel_HorseSubMp_All:setRenderTexture(Panel_HorseSubMp_All:getBaseTexture())
    maxGauge = vehicleProxy:getMaxGuildShipBoostGauge()
    curGauge = vehicleProxy:getGuildShipBoostGauge()
  end
  PaGlobal_HorseSubMp_All:updateStat(curGauge, maxGauge)
  if nil ~= HorseMP_UpdateCarrotPosBySubMpBar then
    HorseMP_UpdateCarrotPosBySubMpBar(true)
  end
  if _ContentsGroup_RenewUI then
    Panel_HorseSubMp_All:SetPosY(Panel_HorseMp:GetPosY() + Panel_HorseSubMp_All:GetSizeY() + 10)
  end
  PaGlobal_HorseSubMp_All:open()
end
function PaGlobal_HorseSubMp_All:open()
  if nil == Panel_HorseSubMp_All then
    return
  end
  Panel_HorseSubMp_All:SetShow(true)
end
function PaGlobal_HorseSubMp_All:prepareClose()
  if nil == Panel_HorseSubMp_All then
    return
  end
  if nil ~= HorseMP_UpdateCarrotPosBySubMpBar then
    HorseMP_UpdateCarrotPosBySubMpBar(false)
  end
  PaGlobal_HorseSubMp_All:close()
end
function PaGlobal_HorseSubMp_All:close()
  if nil == Panel_HorseSubMp_All or false == Panel_HorseSubMp_All:GetShow() then
    return
  end
  Panel_HorseSubMp_All:SetShow(false)
end
function PaGlobal_HorseSubMp_All:setVehicleActorKey(actorKeyRaw)
  if Panel_HorseSubMp_All == nil then
    return
  end
  self._vehicleActorKey = actorKeyRaw
end
function PaGlobal_HorseSubMp_All:updateStat(curGauge, maxGauge)
  if nil == Panel_HorseSubMp_All then
    return
  end
  if 0 == maxGauge then
    return
  end
  local Rate = 0
  if nil ~= curGauge and nil ~= maxGauge and maxGauge > 0 then
    Rate = 100 * curGauge / maxGauge
  end
  self._ui._stc_gaugeProgress:SetProgressRate(Rate)
  self._ui._txt_gauge:SetText(tostring(curGauge) .. " / " .. tostring(maxGauge))
end
