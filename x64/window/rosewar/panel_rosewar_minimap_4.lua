function PaGlobal_RoseWarMiniMap:makeMiniMapMarker()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local totalIndex = 0
  self._miniMapMarkerList = {}
  for index = 0, self._miniMapMarkerPoolCount - 1 do
    local controlId = "Static_Minimap_MarkerIcon_" .. tostring(totalIndex)
    local newControl = UI.createControl(__ePAUIControl_Static, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\167\136\236\187\164 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetSize(0, 0)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.MARKER_ICON)
    local markerIconData = {
      _control = newControl,
      _originalSize = float2(0, 0),
      _adjustRatio = float2(0, 0),
      _index = index,
      _eventType = __eRoseWarCommandEventType_Count,
      _lastCalcPosRate = float2(0, 0),
      _isSet = false
    }
    self._miniMapMarkerList[index] = markerIconData
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarMiniMap:exepandMiniMapMarkerPool()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local exepandCount = self._eExpandPoolCount.MINIMAP_MARKER
  local currentPoolCount = self._miniMapMarkerPoolCount
  local newPoolCount = currentPoolCount + exepandCount
  local totalIndex = currentPoolCount
  for index = currentPoolCount, newPoolCount - 1 do
    local controlId = "Static_Minimap_MarkerIcon_" .. tostring(totalIndex)
    local newControl = UI.createControl(__ePAUIControl_Static, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\167\136\236\187\164 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetSize(0, 0)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.MARKER_ICON)
    local markerIconData = {
      _control = newControl,
      _originalSize = float2(0, 0),
      _adjustRatio = float2(0, 0),
      _index = index,
      _eventType = __eRoseWarCommandEventType_Count,
      _lastCalcPosRate = float2(0, 0),
      _isSet = false
    }
    self._miniMapMarkerList[index] = markerIconData
    totalIndex = totalIndex + 1
  end
  self._miniMapMarkerPoolCount = newPoolCount
end
function PaGlobal_RoseWarMiniMap:setMarkerIconData(markerIconData, eventType, lastCalcPosRate, isSet)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if markerIconData == nil then
    return
  end
  markerIconData._eventType = eventType
  markerIconData._lastCalcPosRate = lastCalcPosRate
  markerIconData._isSet = isSet
  markerIconData._control:SetShow(isSet)
  if isSet == true then
    markerIconData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMiniMap_ClickedMarkerIcon(" .. tostring(markerIconData._index) .. ")")
    markerIconData._control:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMiniMap_OnOutMarkerIcon(true," .. tostring(markerIconData._index) .. ")")
    markerIconData._control:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMiniMap_OnOutMarkerIcon(false," .. tostring(markerIconData._index) .. ")")
  else
    markerIconData._control:addInputEvent("Mouse_LUp", "")
    markerIconData._control:addInputEvent("Mouse_On", "")
    markerIconData._control:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_RoseWarMiniMap:addPingAndMarker(commandEventType, worldPosition)
  if Panel_RoseWar_MiniMap == nil or commandEventType == nil or worldPosition == nil then
    return
  end
  local color = float4(1, 1, 1, 1)
  local bgColor = float4(0.6, 0.6, 0.6, 0.3)
  local beamColor = float4(0.4, 0.4, 0.4, 1)
  local pingType
  local groupNo = 4
  if commandEventType == __eRoseWarCommandEventType_RequestAttackSupport then
  elseif commandEventType == __eRoseWarCommandEventType_RequestDefenceSupport then
  elseif commandEventType == __eRoseWarCommandEventType_FightingNow then
  elseif commandEventType == __eRoseWarCommandEventType_SafePosition then
  elseif commandEventType == __eRoseWarCommandEventType_Move then
  elseif commandEventType == __eRoseWarCommandEventType_Ping_Red then
    color = float4(1, 0.1, 0.1, 1)
    bgColor = float4(0.6, 0.1, 0.1, 0.3)
    beamColor = float4(0.4, 0.1, 0.1, 1)
    pingType = __eNotifyPingTypeBDO_RoseWar_Red
  elseif commandEventType == __eRoseWarCommandEventType_Ping_Blue then
    color = float4(0.1, 0.1, 1, 1)
    bgColor = float4(0.1, 0.1, 0.6, 0.3)
    beamColor = float4(0.1, 0.1, 0.4, 1)
    pingType = __eNotifyPingTypeBDO_RoseWar_Blue
  elseif commandEventType == __eRoseWarCommandEventType_Ping_Green then
    color = float4(0.1, 1, 0.1, 1)
    bgColor = float4(0.1, 0.6, 0.1, 0.3)
    beamColor = float4(0.1, 0.4, 0.1, 1)
    pingType = __eNotifyPingTypeBDO_RoseWar_Green
  elseif commandEventType == __eRoseWarCommandEventType_Ping_Yellow then
    color = float4(1, 1, 0.1, 1)
    bgColor = float4(0.6, 0.6, 0.1, 0.3)
    beamColor = float4(0.4, 0.4, 0.1, 1)
    pingType = __eNotifyPingTypeBDO_RoseWar_Yellow
  end
  local guideParam = NavigationGuideParam()
  guideParam._color = color
  guideParam._bgColor = bgColor
  guideParam._beamColor = beamColor
  guideParam._groupNo = groupNo
  guideParam._isAutoErase = false
  guideParam._pingType = pingType
  self:removePingAndMarkerByPingType(pingType)
  local beamKey = ToClient_AddNavigationBeam(worldPosition, guideParam, true)
  local pingAndMarkerData = {
    _isUseMarker = ToClient_IsUsePingAndMarkerRoseWarCommandEventType(commandEventType),
    _markerIndex = nil,
    _beamKey = beamKey,
    _pingType = pingType
  }
  if pingAndMarkerData._isUseMarker == true then
    pingAndMarkerData._markerIndex = self:activateMarkerIcon(commandEventType, worldPosition)
  end
  if self._pingAndMarkerDataList == nil then
    self._pingAndMarkerDataList = Array.new()
  end
  if Panel_RoseWar_MiniMap:GetShow() == true then
    audioPostEvent_SystemUi(35, 9)
    _AudioPostEvent_SystemUiForXBOX(35, 9)
  end
  self._pingAndMarkerDataList:push_back(pingAndMarkerData)
end
function PaGlobal_RoseWarMiniMap:removePingAndMarkerByPingType(pingType)
  if self._pingAndMarkerDataList == nil then
    return
  end
  local count = self._pingAndMarkerDataList:length()
  for index = 0, count do
    local value = self._pingAndMarkerDataList[index]
    if value ~= nil and value._pingType == pingType then
      self:deactivateMarkerIcon(value._markerIndex)
      ToClient_DeleteNaviGuide(value._beamKey)
      table.remove(self._pingAndMarkerDataList, index)
    end
  end
end
function PaGlobal_RoseWarMiniMap:activateMarkerIcon(eventType, worldPosition)
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  for index = 0, self._miniMapMarkerPoolCount - 1 do
    local markerIconData = self._miniMapMarkerList[index]
    if markerIconData ~= nil and markerIconData._isSet == false then
      local isSuccess = self:setMarkerIconTexture(markerIconData, eventType)
      if isSuccess == nil or isSuccess == false then
        self:setMarkerIconData(markerIconData, __eRoseWarCommandEventType_Count, float2(0, 0), false)
        return nil
      end
      local posRate = self:calcWorldPositionToMiniMapPosRate(worldPosition)
      if 0 > posRate.x or 1 < posRate.x or 0 > posRate.y or 1 < posRate.y then
        self:setMarkerIconData(markerIconData, __eRoseWarCommandEventType_Count, float2(0, 0), false)
        return nil
      elseif markerIconData._lastCalcPosRate.x == posRate.x and markerIconData._lastCalcPosRate.y == posRate.y then
        self:setMarkerIconData(markerIconData, __eRoseWarCommandEventType_Count, float2(0, 0), false)
        return nil
      else
        markerIconData._lastCalcPosRate = posRate
        self:updateMarkerIconSize(markerIconData)
        self:updateMarkerIconPosition(markerIconData)
      end
      self:setMarkerIconData(markerIconData, eventType, posRate, true)
      return index
    end
  end
  self:exepandMiniMapMarkerPool()
  return self:activateMarkerIcon(eventType, worldPosition)
end
function PaGlobal_RoseWarMiniMap:deactivateMarkerIcon(index)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._miniMapMarkerList == nil then
    return
  end
  local markerIconData = self._miniMapMarkerList[index]
  if markerIconData == nil then
    return
  end
  markerIconData._control:EraseAllEffect()
  self:setMarkerIconData(markerIconData, __eRoseWarCommandEventType_Count, float2(0, 0), false)
end
function PaGlobal_RoseWarMiniMap:setMarkerIconTexture(markerIconData, eventType)
  if Panel_RoseWar_MiniMap == nil then
    return false
  end
  if markerIconData == nil or eventType == nil then
    return false
  end
  local control = markerIconData._control
  if control == nil then
    return false
  end
  local textureKey, effectName
  if eventType == __eRoseWarCommandEventType_RequestAttackSupport then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_SubLeader_Yellow"
    effectName = "fUI_RoseWar_Map_Ping_Yellow_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.95
  elseif eventType == __eRoseWarCommandEventType_RequestDefenceSupport then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_SubLeader_Blue"
    effectName = "fUI_RoseWar_Map_Ping_Blue_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.95
  elseif eventType == __eRoseWarCommandEventType_FightingNow then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_SubLeader_Orange"
    effectName = "fUI_RoseWar_Map_Ping_Orange_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.95
  elseif eventType == __eRoseWarCommandEventType_SafePosition then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_SubLeader_Green"
    effectName = "fUI_RoseWar_Map_Ping_Green_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.95
  elseif eventType == __eRoseWarCommandEventType_Move then
    textureKey = "Combine_Etc_RoseWar_Command_FX_Map_Ping_Oreage"
    effectName = "fUI_RoseWar_Map_Ping_Orange_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.5
  elseif eventType == __eRoseWarCommandEventType_Ping_Red then
    textureKey = "Combine_Etc_RoseWar_Command_FX_Map_Ping_Oreage"
    effectName = "fUI_RoseWar_Map_Ping_Orange_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.925
  elseif eventType == __eRoseWarCommandEventType_Ping_Blue then
    textureKey = "Combine_Etc_RoseWar_Command_FX_Map_Ping_Blue"
    effectName = "fUI_RoseWar_Map_Ping_Blue_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.925
  elseif eventType == __eRoseWarCommandEventType_Ping_Green then
    textureKey = "Combine_Etc_RoseWar_Command_FX_Map_Ping_Green"
    effectName = "fUI_RoseWar_Map_Ping_Green_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.925
  elseif eventType == __eRoseWarCommandEventType_Ping_Yellow then
    textureKey = "Combine_Etc_RoseWar_Command_FX_Map_Ping_Yellow"
    effectName = "fUI_RoseWar_Map_Ping_Yellow_01A"
    markerIconData._adjustRatio.x = 0.5
    markerIconData._adjustRatio.y = 0.925
  else
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\167\136\236\187\164 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return false
  end
  if textureKey == nil then
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\167\136\236\187\164 \237\133\141\236\138\164\236\179\144 \237\130\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  control:setUseScaleRenderEffect(true)
  control:ChangeTextureInfoTextureIDAsync(textureKey)
  control:setRenderTexture(control:getBaseTexture())
  control:AddEffect(effectName, true, 0, 0)
  local textureSize = ToClient_GetTextureSizeByKey(textureKey)
  markerIconData._originalSize.x = textureSize.x
  markerIconData._originalSize.y = textureSize.y
  control:SetSize(markerIconData._originalSize)
  control:SetEnableArea(0, 0, textureSize.x, textureSize.y)
  return true
end
function PaGlobal_RoseWarMiniMap:updateMarkerIconPosition(markerIconData)
  if Panel_RoseWar_MiniMap == nil or markerIconData == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * markerIconData._lastCalcPosRate.x - markerIconData._control:GetSizeX() * markerIconData._adjustRatio.x
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * markerIconData._lastCalcPosRate.y - markerIconData._control:GetSizeY() * markerIconData._adjustRatio.y
  markerIconData._control:SetPosX(newPosX)
  markerIconData._control:SetPosY(newPosY)
end
function PaGlobal_RoseWarMiniMap:updateMarkerIconSize(markerIconData)
  if Panel_RoseWar_MiniMap == nil or markerIconData == nil then
    return
  end
  local newSizeRatio = 1 + (self._miniMapMarkerImageRateMax - 1) * self:getMiniMapScrollRate()
  local newSizeX = markerIconData._originalSize.x * newSizeRatio
  local newSizeY = markerIconData._originalSize.y * newSizeRatio
  markerIconData._control:SetSize(newSizeX, newSizeY)
end
function PaGlobal_RoseWarMiniMap:refreshMiniMapMarkerIconPos(doRefreshSize)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapMarkerPoolCount - 1 do
    local markerIconData = self._miniMapMarkerList[index]
    if markerIconData ~= nil and markerIconData._isSet == true then
      if doRefreshSize ~= nil and doRefreshSize == true then
        self:updateMarkerIconSize(markerIconData)
      end
      self:updateMarkerIconPosition(markerIconData)
    end
  end
end
