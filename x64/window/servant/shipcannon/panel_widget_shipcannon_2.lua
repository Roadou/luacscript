function HandleEventUpdate_ShipCannon_GuageUpdateFrame(deltaTime)
  local nowPower = ToClient_getCommonGauge()
  if PaGlobal_ShipCannon.currentPower == nowPower then
    return
  end
  local maxPower = ToClient_getMaxCommonGauge()
  local percent = nowPower / maxPower * 50
  if 50 == math.floor(percent) then
    return
  end
  PaGlobal_ShipCannon:updateGaugeAll(percent)
end
function PaGloabl_ShipCannon_ShowAni()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function PaGloabl_ShipCannon_HideAni()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function FromClient_ShipCannon_PlayerRideOn(actorKeyRaw)
  if nil == Panel_Widget_OceanWind then
    return
  end
  if PaGlobalFunc_OceanGuide_IsShip() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if actorKeyRaw == nil then
    actorKeyRaw = selfPlayer:get():getRideVehicleActorKeyRaw()
  end
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if vehicleActor == nil then
    return
  end
  local characterKey = vehicleActor:getCharacterKeyRaw()
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  if shipStaticStatus == nil then
    return
  end
  if shipStaticStatus:getIsUseCannonByRideShip() == false then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  if seatPosition == 0 then
    PaGlobal_ShipCannon:prepareOpen(PaGlobal_ShipCannon._eCannon.left)
    PaGlobal_ShipCannon:prepareOpen(PaGlobal_ShipCannon._eCannon.right)
  end
end
function FromClient_ShipCannon_PlayerRideOff()
  if nil == Panel_Widget_OceanWind then
    return
  end
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.right)
  if PaGloabl_SailorAutoFishingDiscard_All_Close ~= nil then
    PaGloabl_SailorAutoFishingDiscard_All_Close()
  end
end
function FromClient_UpdateCannonStatCount(cannonStatCount, vehicleType)
  PaGlobal_ShipCannon:updateBulletCount(cannonStatCount)
end
function FromClient_ShipCannon_OnScreenResize()
  PaGlobal_ShipCannon:repositionAll()
end
function FromClient_UpdateCannonCoolTime_Left(gaugeState)
  if false == _ContentsGroup_ManualCannonFire then
    return
  end
  if gaugeState == __eManualCannonFireCoolTimeState_AfterFire then
    PaGloabl_ShipCannon_ActionEventAfterFire_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_One then
    PaGloabl_ShipCannon_ActionEventGaugeOne_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Two then
    PaGloabl_ShipCannon_ActionEventGaugeTwo_Left()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Full then
    PaGloabl_ShipCannon_ActionEventGaugeFull_Left()
  end
end
function FromClient_UpdateCannonCoolTime_Right(gaugeState)
  if false == _ContentsGroup_ManualCannonFire then
    return
  end
  if gaugeState == __eManualCannonFireCoolTimeState_AfterFire then
    PaGloabl_ShipCannon_ActionEventAfterFire_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_One then
    PaGloabl_ShipCannon_ActionEventGaugeOne_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Two then
    PaGloabl_ShipCannon_ActionEventGaugeTwo_Right()
  elseif gaugeState == __eManualCannonFireCoolTimeState_Full then
    PaGloabl_ShipCannon_ActionEventGaugeFull_Right()
  end
end
function PaGloabl_ShipCannon_ActionEventGaugeFull_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.ready)
  PaGlobal_ShipCannon:SetShowGuageAll(true)
end
function PaGloabl_ShipCannon_ActionEventAfterFire_Left()
  PaGlobal_ShipCannon:hideCooltime(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeOne_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.one)
end
function PaGloabl_ShipCannon_ActionEventGaugeTwo_Left()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.left, PaGlobal_ShipCannon._eCooltime.two)
end
function PaGloabl_ShipCannon_ActionEventHideGauge_Left()
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.left)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeFull_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.ready)
  PaGlobal_ShipCannon:SetShowGuageAll(true)
end
function PaGloabl_ShipCannon_ActionEventAfterFire_Right()
  PaGlobal_ShipCannon:hideCooltime(PaGlobal_ShipCannon._eCannon.right)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function PaGloabl_ShipCannon_ActionEventGaugeOne_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.one)
end
function PaGloabl_ShipCannon_ActionEventGaugeTwo_Right()
  PaGlobal_ShipCannon:updateCooltime(PaGlobal_ShipCannon._eCannon.right, PaGlobal_ShipCannon._eCooltime.two)
end
function PaGloabl_ShipCannon_ActionEventHideGauge_Right()
  PaGlobal_ShipCannon:prepareClose(PaGlobal_ShipCannon._eCannon.right)
  PaGlobal_ShipCannon:hideGuageAndCache()
end
function UpdateFunc_ShipCannon_UpdateAutoFishingGauge(deltaTime)
  local self = PaGlobal_ShipCannon
  if self == nil then
    return
  end
  if Panel_Widget_ShipCannon_Right == nil then
    return
  end
  if Panel_Widget_ShipCannon_Right:GetShow() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfProxy = selfPlayer:get()
  if selfProxy == nil then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if actorKeyRaw ~= nil then
    local vehicleProxy = getVehicleActor(actorKeyRaw)
    if vehicleProxy ~= nil then
      local fishingSlotCount = ToClient_getEmployeePresetJobCount(vehicleProxy:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing)
      if fishingSlotCount <= 0 then
        self._ui._stc_autoFishingGauge:SetShow(false)
        return
      end
    end
  end
  self._ui._stc_autoFishingGauge:SetShow(true)
  if ToClient_canShowAutoFishingGauge() == false then
    self._ui._stc_cantAutoFish:SetShow(true)
    self._ui._progress_FishingGauge:SetShow(false)
    if _ContentsGroup_EmployeeAutoFishingDiscard == true then
      self._ui._stc_fishDiscardArrow:SetShow(false)
    end
    return
  else
    self._ui._stc_cantAutoFish:SetShow(false)
    self._ui._progress_FishingGauge:SetShow(true)
    if _ContentsGroup_EmployeeAutoFishingDiscard == true then
      self._ui._stc_fishDiscardArrow:SetShow(true)
    end
    local currentTime = ToClient_getAutoFishingGaugeAccumulateTime()
    local maxTime = ToClient_getEmployeeAutoFishTime()
    local progressRate = currentTime / (maxTime * 0.9) * 100
    local timeRate = currentTime / maxTime * 100
    if progressRate >= 100 then
      self._ui._progress_FishingGauge:ChangeTextureInfoTextureIDAsync("Combine_Etc_Riding_Fishing_Icon")
    else
      self._ui._progress_FishingGauge:ChangeTextureInfoTextureIDAsync("Combine_Etc_Riding_Fishing_Icon_Disable")
      self._ui._progress_FishingGauge:SetProgressRate(progressRate)
    end
    if timeRate >= 100 then
      if self._autoFishingEffectOn == false then
        self._ui._stc_autoFishingGauge:AddEffect("fUI_Okylua_Fish_01A", false, 0, 0)
        self._ui._progress_FishingGauge:AddEffect("fUI_Okylua_Fish_01A", false, 0, 0)
      end
      self._autoFishingEffectOn = true
    else
      self._autoFishingEffectOn = false
    end
  end
end
function PaGloabl_ShipCannon_CantAutoFishingTooltip(isShow)
  local self = PaGlobal_ShipCannon
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  control = self._ui._stc_cantAutoFish
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_DISABLE_DESC")
  TooltipSimple_Show(control, name, desc, false)
end
function PaGloabl_ShipCannon_CanAutoFishingTooltip(isShow)
  local self = PaGlobal_ShipCannon
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  control = self._ui._stc_autoFishingGauge
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_TOOLTIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_POSSIBLE")
  TooltipSimple_Show(control, name, desc, false)
end
