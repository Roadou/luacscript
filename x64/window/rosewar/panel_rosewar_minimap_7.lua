function PaGlobal_RoseWarMiniMap:makeVehicleIcon()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local totalIndex = 0
  self._miniMapVehicleIconList = {}
  local vehicleIconControl_Template = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_VehicleIcon_Template")
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local controlId = "Static_Minimap_VehicleIcon_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(vehicleIconControl_Template, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\179\181\236\132\177\235\179\145\234\184\176 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.VEHICLE_ICON)
    local vehicleIcon = UI.getChildControl(newControl, "Static_VehicleIcon")
    vehicleIcon:SetShow(true)
    vehicleIcon:SetIgnore(false)
    vehicleIcon:SetDepth(self._eRenderOrder.VEHICLE_ICON)
    local vehicleIconData = {
      _control = newControl,
      _vehicleIcon = vehicleIcon,
      _actorKeyRaw = nil,
      _vehicleType = nil,
      _vehicleSubType = nil,
      _teamNo = nil,
      _lastCalcPosRate = float2(0, 0),
      _isSet = false
    }
    self._miniMapVehicleIconList[index] = vehicleIconData
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarMiniMap:exepandVehicleIconPool()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local exepandCount = self._eExpandPoolCount.VEHICLE_ICON
  local currentPoolCount = self._miniMapVehicleIconPoolCount
  local newPoolCount = currentPoolCount + exepandCount
  local totalIndex = currentPoolCount
  local vehicleIconControl_Template = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_VehicleIcon_Template")
  for index = currentPoolCount, newPoolCount - 1 do
    local controlId = "Static_Minimap_VehicleIcon_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(vehicleIconControl_Template, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\179\181\236\132\177\235\179\145\234\184\176 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.VEHICLE_ICON)
    local vehicleIcon = UI.getChildControl(newControl, "Static_VehicleIcon")
    vehicleIcon:SetShow(true)
    vehicleIcon:SetIgnore(false)
    vehicleIcon:SetDepth(self._eRenderOrder.VEHICLE_ICON)
    local vehicleIconData = {
      _control = newControl,
      _vehicleIcon = vehicleIcon,
      _actorKeyRaw = nil,
      _vehicleType = nil,
      _vehicleSubType = nil,
      _teamNo = nil,
      _lastCalcPosRate = float2(0, 0),
      _isSet = false
    }
    self._miniMapVehicleIconList[index] = vehicleIconData
    totalIndex = totalIndex + 1
  end
  self._miniMapVehicleIconPoolCount = newPoolCount
end
function PaGlobal_RoseWarMiniMap:setVehicleIconData(vehicleIconData, actorKeyRaw, lastCalcPosRate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if vehicleIconData == nil then
    return
  end
  if actorKeyRaw == nil then
    vehicleIconData._actorKeyRaw = nil
    vehicleIconData._vehicleType = nil
    vehicleIconData._vehicleSubType = nil
    vehicleIconData._teamNo = nil
    vehicleIconData._lastCalcPosRate = float2(0, 0)
    vehicleIconData._isSet = false
    vehicleIconData._control:SetShow(false)
  else
    local vehicleIconDataWrapper = ToClient_GetRoseWarMiniMapVehicleIconDataWrapper(actorKeyRaw)
    if vehicleIconDataWrapper == nil then
      return
    end
    vehicleIconData._actorKeyRaw = actorKeyRaw
    vehicleIconData._vehicleType = vehicleIconDataWrapper:getVehicleType()
    vehicleIconData._vehicleSubType = vehicleIconDataWrapper:getVehicleSubType()
    vehicleIconData._teamNo = vehicleIconDataWrapper:getTeamNo()
    vehicleIconData._lastCalcPosRate = lastCalcPosRate
    vehicleIconData._isSet = true
    vehicleIconData._control:SetShow(true)
  end
  if vehicleIconData._isSet == true then
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMiniMap_OnOutVehicleIcon(true," .. tostring(actorKeyRaw) .. ")")
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMiniMap_OnOutVehicleIcon(false," .. tostring(actorKeyRaw) .. ")")
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_RUp", "HandleEventRUp_RoseWarMiniMap_VehicleIcon(" .. tostring(actorKeyRaw) .. ")")
  else
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_On", "")
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_Out", "")
    vehicleIconData._vehicleIcon:addInputEvent("Mouse_RUp", "")
  end
end
function PaGlobal_RoseWarMiniMap:setVehicleIconTexture(icon, vehicleType, vehicleSubType, teamNo)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if icon == nil or vehicleType == nil or vehicleSubType == nil or teamNo == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  if ToClient_IsRoseWarObserveMode() == true then
    selfPlayerTeamNo = ToClient_GetRoseObserveTeamNo()
  end
  local textureKey
  if vehicleType == __eVehicleType_Cannon and vehicleSubType == 0 then
    if selfPlayerTeamNo == teamNo then
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Cannon"
    else
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Cannon"
    end
  elseif vehicleType == __eVehicleType_Ballista and vehicleSubType == 0 then
    if selfPlayerTeamNo == teamNo then
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Ballista"
    else
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Ballista"
    end
  elseif vehicleType == __eVehicleType_Tank and vehicleSubType == 0 then
    if selfPlayerTeamNo == teamNo then
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Tank"
    else
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Tank"
    end
  elseif vehicleType == __eVehicleType_MonsterRide and vehicleSubType == 0 then
    if selfPlayerTeamNo == teamNo then
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Troll"
    else
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Troll"
    end
  elseif vehicleType == __eVehicleType_Elephant and vehicleSubType == 0 then
    if selfPlayerTeamNo == teamNo then
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Elephant"
    else
      textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Elephant"
    end
  else
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\179\181\236\132\177\235\179\145\234\184\176 \236\149\132\236\157\180\236\189\152 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164! \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  icon:ChangeTextureInfoTextureIDAsync(textureKey)
  icon:setRenderTexture(icon:getBaseTexture())
end
function PaGlobal_RoseWarMiniMap:activateVehicleIcon(actorKeyRaw)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local vehicleIconData = self._miniMapVehicleIconList[index]
    if vehicleIconData ~= nil and vehicleIconData._isSet == false then
      self:setVehicleIconData(vehicleIconData, actorKeyRaw, float2(0, 0))
      if vehicleIconData._isSet == false then
        return
      end
      self:setVehicleIconTexture(vehicleIconData._vehicleIcon, vehicleIconData._vehicleType, vehicleIconData._vehicleSubType, vehicleIconData._teamNo)
      self:updateVehicleIconSize(vehicleIconData)
      return
    end
  end
  self:exepandVehicleIconPool()
  self:activateVehicleIcon(actorKeyRaw)
end
function PaGlobal_RoseWarMiniMap:deactivateVehicleIcon(actorKeyRaw)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local vehicleIconData = self._miniMapVehicleIconList[index]
    if vehicleIconData ~= nil and vehicleIconData._actorKeyRaw == actorKeyRaw then
      self:setVehicleIconData(vehicleIconData, nil, float2(0, 0))
      break
    end
  end
end
function PaGlobal_RoseWarMiniMap:updateVehicleIconSize(vehicleIconData)
  if Panel_RoseWar_MiniMap == nil or vehicleIconData == nil then
    return
  end
  local newSizeRatio = 1 + (self._miniMapVehicleIconImageRateMax - 1) * self:getMiniMapScrollRate()
  local newSizeX = self._miniMapVehicleIconOriginalSizeX * newSizeRatio
  local newSizeY = self._miniMapVehicleIconOriginalSizeY * newSizeRatio
  vehicleIconData._control:SetSize(newSizeX, newSizeY)
  vehicleIconData._vehicleIcon:SetSize(newSizeX, newSizeY)
  vehicleIconData._control:ComputePosAllChild()
end
function PaGlobal_RoseWarMiniMap:refreshVehicleIcon(isForceUpdate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    self:calculateVehicleIconPosition(index, isForceUpdate)
  end
end
function PaGlobal_RoseWarMiniMap:calculateVehicleIconPosition(index, isForceUpdate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local vehicleIconData = self._miniMapVehicleIconList[index]
  if vehicleIconData == nil then
    return
  end
  if vehicleIconData._isSet == false then
    return
  end
  local vehicleIconDataWrapper = ToClient_GetRoseWarMiniMapVehicleIconDataWrapper(vehicleIconData._actorKeyRaw)
  if vehicleIconDataWrapper == nil then
    return
  end
  local isInMiniMap = self:isVehicleInMiniMapRange(vehicleIconData._actorKeyRaw)
  if isInMiniMap == true then
    local vehiclePosRate = self:calcWorldPositionToMiniMapPosRate(vehicleIconDataWrapper:getPosition())
    if vehiclePosRate.x < 0 or vehiclePosRate.x > 1 or 0 > vehiclePosRate.y or 1 < vehiclePosRate.y then
    elseif isForceUpdate == false and vehicleIconData._lastCalcPosRate.x == vehiclePosRate.x and vehicleIconData._lastCalcPosRate.y == vehiclePosRate.y then
    else
      vehicleIconData._lastCalcPosRate = vehiclePosRate
      self:updateVehicleIconPosition(vehicleIconData)
    end
    vehicleIconData._control:SetShow(true)
  else
    vehicleIconData._control:SetShow(false)
  end
end
function PaGlobal_RoseWarMiniMap:isVehicleInMiniMapRange(actorKeyRaw)
  if Panel_RoseWar_MiniMap == nil or actorKeyRaw == nil then
    return false
  end
  local currentSectorIndex = ToClient_GetRoseWarVehiclePositionToSectorIndex(actorKeyRaw)
  local currentSectorXZ = int2(currentSectorIndex.x, currentSectorIndex.z)
  local comp1 = self._beginSectorIndexXZ.x <= currentSectorXZ.x
  local comp2 = currentSectorXZ.x <= self._endSectorIndexXZ.x
  local comp3 = self._endSectorIndexXZ.y <= currentSectorXZ.y
  local comp4 = currentSectorXZ.y <= self._beginSectorIndexXZ.y
  if comp1 and comp2 and comp3 and comp4 then
    return true
  else
    return false
  end
end
function PaGlobal_RoseWarMiniMap:updateVehicleIconPosition(vehicleIconData)
  if Panel_RoseWar_MiniMap == nil or vehicleIconData == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * vehicleIconData._lastCalcPosRate.x - vehicleIconData._control:GetSizeX() / 2
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * vehicleIconData._lastCalcPosRate.y - vehicleIconData._control:GetSizeY() / 2
  vehicleIconData._control:SetPosX(newPosX)
  vehicleIconData._control:SetPosY(newPosY)
end
function PaGlobal_RoseWarMiniMap:clearVehicleIconList()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local vehicleIconData = self._miniMapVehicleIconList[index]
    if vehicleIconData ~= nil then
      self:setVehicleIconData(vehicleIconData, nil, float2(0, 0))
    end
  end
end
function PaGlobal_RoseWarMiniMap:refreshMiniMapVehicleIconPos(doRefreshSize)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local vehicleIconData = self._miniMapVehicleIconList[index]
    if vehicleIconData ~= nil and vehicleIconData._isSet == true then
      self:updateVehicleIconPosition(vehicleIconData)
      if doRefreshSize ~= nil and doRefreshSize == true then
        self:updateVehicleIconSize(vehicleIconData)
      end
    end
  end
end
function PaGlobal_RoseWarMiniMap:getVehicleIconDataByActorKeyRaw(actorKeyRaw)
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  for index = 0, self._miniMapVehicleIconPoolCount - 1 do
    local vehicleIconData = self._miniMapVehicleIconList[index]
    if vehicleIconData ~= nil and vehicleIconData._actorKeyRaw == actorKeyRaw then
      return vehicleIconData
    end
  end
  return nil
end
