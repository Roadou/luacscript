function HandleEventLUp_SetSailControl()
  if true == PaGlobal_SailControl._isFoldable then
    local isSpread = ToClient_GetRideShipSpread()
    ToClient_SetSailSpread(not isSpread)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_CANT_FOLDSAIL"))
  end
  if _ContentsGroup_EmployeeAutoFishing == true then
    PaGlobal_SailControl:updateCheckSail()
  end
end
function HandleEventOn_SetSailControlTooltip(isSpread)
  local self = PaGlobal_SailControl
  if self == nil then
    return
  end
  if isSpread == nil then
    isSpread = ToClient_GetRideShipSpread()
  end
  local control
  if _ContentsGroup_EmployeeAutoFishing == true then
    control = self._ui.chk_button
  else
    control = self._ui.btn_SailControl
  end
  if true == isSpread then
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_BOOST_DESC")
    TooltipSimple_Show(control, title, desc)
  else
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_BOOST_DESC")
    TooltipSimple_Show(control, title, desc)
  end
  if ToClient_GetRideShipSpread() == true then
    self._ui.chk_button:ChangeTextureInfoTextureIDAsync("Combine_Etc_Big_Sail_On_Over", 0)
    self._ui.chk_button:setRenderTexture(self._ui.chk_button:getBaseTexture())
  end
end
function HandleEventOn_SetSailControlTooltipOff()
  local self = PaGlobal_SailControl
  if self == nil then
    return
  end
  TooltipSimple_Hide()
  if ToClient_GetRideShipSpread() == true then
    self._ui.chk_button:ChangeTextureInfoTextureIDAsync("Combine_Etc_Big_Sail_On_Nomal", 0)
    self._ui.chk_button:setRenderTexture(self._ui.chk_button:getBaseTexture())
  end
end
function FromClient_SailControl_PlayerRideOn(actorKeyRaw)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if actorKeyRaw == nil then
    actorKeyRaw = selfPlayer:get():getRideVehicleActorKeyRaw()
  end
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if vehicleActor == nil then
    return
  end
  local servantType = vehicleActor:get():getServantType()
  if __eServantTypeShip ~= servantType then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  if seatPosition ~= 0 then
    return
  end
  PaGlobal_SailControl._actorKeyRaw = actorKeyRaw
  PaGlobal_SailControl:reposition()
  Panel_Widget_SailControl:SetShow(true)
  PaGlobal_SailControl._isFoldable = vehicleActor:isOceanShip()
  PaGlobal_SailControl:updateCheckSail()
end
function FromClient_SailControl_PlayerRideOff()
  PaGlobal_SailControl:BubbleHelp(false)
  Panel_Widget_SailControl:SetShow(false)
end
function FromClient_SetSailControl(isSpread)
  PaGlobal_SailControl:updateCheckSail()
  if true == Panel_Tooltip_SimpleText:GetShow() then
    HandleEventOn_SetSailControlTooltip(isSpread)
  end
  if isSpread == true then
    ToClient_RequestNakMessageRenewel(__eNakMessage_SailControlSet)
  else
    ToClient_RequestNakMessageRenewel(__eNakMessage_SailControlFold)
  end
  PaGlobalFunc_SailControl_BubbleHelp()
  if true == ToClient_isConsole() then
    PaGlobalFunc_ConsoleKeyGuide_SetRideShipKeyGuide()
  end
end
function FromClient_SailControl_OnScreenResize()
  PaGlobal_SailControl:reposition()
end
registerEvent("FromClient_SetSailControl", "FromClient_SetSailControl")
function PaGlobalFunc_SailControl_BubbleHelp()
  local isSpread = ToClient_GetRideShipSpread()
  local isFlowValue = tonumber(PaGlobalFunc_OceanGuide_FlowValueReturn())
  if isFlowValue == nil then
    PaGlobal_SailControl:BubbleHelp(false)
    return
  end
  if isSpread == true and isFlowValue >= 250 and PaGlobal_SailControl._isFoldable == true then
    PaGlobal_SailControl:BubbleHelp(true)
  else
    PaGlobal_SailControl:BubbleHelp(false)
  end
end
function FromClient_SailControl_UpdateOceanCurrent(oceanCurrent)
  local self = PaGlobal_SailControl
  if self == nil then
    return
  end
  if Panel_Widget_SailControl == nil then
    return
  end
  if Panel_Widget_SailControl:GetShow() == false then
    return
  end
  local isShow = false
  if oceanCurrent.w >= 1.7 then
    isShow = true
  end
  if self._isShowOkiyluaBless == isShow then
    return
  end
  self._isShowOkiyluaBless = isShow
  self._ui.stc_okiyluaBlessBG:SetShow(isShow)
  if isShow == true then
    self._ui.stc_okiyluaBlessBG:AddEffect("fUI_Okylua_Water_01B", true, 0, 0)
  else
    self._ui.stc_okiyluaBlessBG:EraseAllEffect()
  end
end
function UpdateFunc_SailControl_UpdateSpeedGauge(deltaTime)
  local self = PaGlobal_SailControl
  if self == nil then
    return
  end
  if Panel_Widget_SailControl == nil then
    return
  end
  if Panel_Widget_SailControl:GetShow() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  if selfProxy == nil then
    return
  end
  local currentSpeedRate = selfProxy:getCurrentSpeedRate()
  local progressRate = self._ui.stc_progressBar:GetProgressRate()
  local updateRate = (currentSpeedRate - progressRate) * deltaTime * self._progressMoveSpeed
  self._ui.stc_progressBar:SetProgressRate(progressRate + updateRate)
end
function FromClient_SailControl_FinishAutoFishingByEmployee(isSuccess)
  local self = PaGlobal_SailControl
  if self == nil then
    return
  end
  if Panel_Widget_SailControl == nil then
    return
  end
  self._ui.stc_okiyluaBlessBG:EraseAllEffect()
end
