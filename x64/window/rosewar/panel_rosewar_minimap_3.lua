function PaGlobal_RoseWarMiniMap:makeActorIcon()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local totalIndex = 0
  self._miniMapActorIconList = {}
  local actorIconControl_Template = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_ActorIcon_Template")
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local controlId = "Static_Minimap_ActorIcon_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(actorIconControl_Template, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\149\161\237\132\176 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local actorIcon = UI.getChildControl(newControl, "Static_ActorIcon")
    actorIcon:SetShow(true)
    actorIcon:SetIgnore(false)
    actorIcon:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local selectedControl = UI.getChildControl(newControl, "Static_SelectedActorIcon")
    selectedControl:SetShow(false)
    selectedControl:SetIgnore(true)
    selectedControl:SetDepth(self._eRenderOrder.ACTOR_SELECT_ICON)
    local isSelfControl = UI.getChildControl(newControl, "Static_Me")
    isSelfControl:SetShow(false)
    isSelfControl:SetIgnore(true)
    isSelfControl:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local actorIconData = {
      _control = newControl,
      _actorIcon = actorIcon,
      _selectedControl = selectedControl,
      _isSelfIcon = isSelfControl,
      _userNo_s64 = toInt64(0, 0),
      _lastCalcPosRate = float2(0, 0),
      _isSelected = false,
      _isSet = false
    }
    self._miniMapActorIconList[index] = actorIconData
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarMiniMap:exepandActorIconPool()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local exepandCount = self._eExpandPoolCount.ACTOR_ICON
  local currentPoolCount = self._miniMapActorIconPoolCount
  local newPoolCount = currentPoolCount + exepandCount
  local totalIndex = currentPoolCount
  local actorIconControl_Template = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_ActorIcon_Template")
  for index = currentPoolCount, newPoolCount - 1 do
    local controlId = "Static_Minimap_ActorIcon_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(actorIconControl_Template, self._ui._stc_miniMapBg, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\149\161\237\132\176 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    newControl:SetPosX(0)
    newControl:SetPosY(0)
    newControl:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local actorIcon = UI.getChildControl(newControl, "Static_ActorIcon")
    actorIcon:SetShow(true)
    actorIcon:SetIgnore(false)
    actorIcon:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local selectedControl = UI.getChildControl(newControl, "Static_SelectedActorIcon")
    selectedControl:SetDepth(self._eRenderOrder.ACTOR_SELECT_ICON)
    local isSelfControl = UI.getChildControl(newControl, "Static_Me")
    isSelfControl:SetShow(false)
    isSelfControl:SetIgnore(true)
    isSelfControl:SetDepth(self._eRenderOrder.ACTOR_ICON)
    local actorIconData = {
      _control = newControl,
      _actorIcon = actorIcon,
      _selectedControl = selectedControl,
      _isSelfIcon = isSelfControl,
      _userNo_s64 = toInt64(0, 0),
      _lastCalcPosRate = float2(0, 0),
      _isSelected = false,
      _isSet = false
    }
    self._miniMapActorIconList[index] = actorIconData
    totalIndex = totalIndex + 1
  end
  self._miniMapActorIconPoolCount = newPoolCount
end
function PaGlobal_RoseWarMiniMap:setActorIconData(actorIconData, userNo64, lastCalcPosRate, isSet)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if actorIconData == nil then
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
  local selfPlayerUserNo = selfPlayer:getUserNo()
  actorIconData._userNo_s64 = userNo64
  actorIconData._lastCalcPosRate = lastCalcPosRate
  actorIconData._isSelected = false
  actorIconData._isSet = isSet
  actorIconData._control:SetShow(isSet)
  actorIconData._selectedControl:SetShow(false)
  actorIconData._isSelfIcon:SetShow(selfPlayerUserNo == userNo64)
  if isSet == true then
    actorIconData._actorIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMiniMap_ClickedActorIcon(" .. tostring(userNo64) .. ")")
    actorIconData._actorIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarMiniMap_OnOutActorIcon(true," .. tostring(userNo64) .. ")")
    actorIconData._actorIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarMiniMap_OnOutActorIcon(false," .. tostring(userNo64) .. ")")
  else
    actorIconData._actorIcon:addInputEvent("Mouse_LUp", "")
    actorIconData._actorIcon:addInputEvent("Mouse_On", "")
    actorIconData._actorIcon:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_RoseWarMiniMap:getActorIconDataByUserNo(userNo32)
  if Panel_RoseWar_MiniMap == nil then
    return nil
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._userNo_s64 == toInt64(0, userNo32) then
      return actorIconData
    end
  end
  return nil
end
function PaGlobal_RoseWarMiniMap:activateActorIcon(userNo64, gradeType, isSelf)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == false then
      local isSuccess = self:setActorIconTexture(actorIconData._actorIcon, actorIconData._selectedControl, gradeType, isSelf)
      if isSuccess == nil or isSuccess == false then
        self:setActorIconData(actorIconData, toInt64(0, 0), float2(0, 0), false)
        return
      end
      self:setActorIconData(actorIconData, userNo64, float2(0, 0), true)
      self:updateActorIconSize(actorIconData)
      local isFromServer = IsSelfPlayerRoseWarGrade_Commander() == true or IsSelfPlayerRoseWarGrade_SubCommander() == true
      if isSelf == true and isFromServer == true then
        self:calculateActorIconPosition(index, true)
        self:aniationMoveMiniMap(userNo64)
      end
      return
    end
  end
  self:exepandActorIconPool()
  self:activateActorIcon(userNo64, gradeType, isSelf)
end
function PaGlobal_RoseWarMiniMap:deactivateActorIcon(userNo64)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._userNo_s64 == userNo64 then
      self:setActorIconData(actorIconData, toInt64(0, 0), float2(0, 0), false)
      break
    end
  end
end
function PaGlobal_RoseWarMiniMap:setActorIconTexture(icon, selectedIcon, gradeType, isSelf)
  if Panel_RoseWar_MiniMap == nil then
    return false
  end
  if icon == nil or selectedIcon == nil or gradeType == nil or isSelf == nil then
    return false
  end
  local textureKey, selectedTextureKey
  if isSelf == true then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_White_Unit"
  elseif gradeType == __eRoseWarPlayerGradeType_Commander or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_GuildMember or gradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or gradeType == __eRoseWarPlayerGradeType_Mercenary then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Blue_Unit"
    selectedTextureKey = "Combine_Etc_RoseWar_Command_Icon_Map_Blue_Unit_Drag_Yellow"
  elseif gradeType == __eRoseWarPlayerGradeType_EnemyCommander or gradeType == __eRoseWarPlayerGradeType_EnemySubCommander or gradeType == __eRoseWarPlayerGradeType_EnemyGuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_EnemyGuildMember or gradeType == __eRoseWarPlayerGradeType_EnemyMercenaryPartyLeader or gradeType == __eRoseWarPlayerGradeType_EnemyMercenary then
    textureKey = "Combine_Etc_RoseWar_Command_Icon_Map_N_Red_Unit"
  else
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\149\161\237\132\176 \236\149\132\236\157\180\236\189\152 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return false
  end
  if textureKey == nil then
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \236\149\161\237\132\176 \236\149\132\236\157\180\236\189\152 \237\133\141\236\138\164\236\179\144 \237\130\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  icon:ChangeTextureInfoTextureIDAsync(textureKey)
  icon:setRenderTexture(icon:getBaseTexture())
  if selectedTextureKey ~= nil then
    selectedIcon:ChangeTextureInfoTextureIDAsync(selectedTextureKey)
    selectedIcon:setRenderTexture(selectedIcon:getBaseTexture())
  end
  return true
end
function PaGlobal_RoseWarMiniMap:refreshActorIcon(isForceUpdate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    self:calculateActorIconPosition(index, isForceUpdate)
  end
end
function PaGlobal_RoseWarMiniMap:calculateActorIconPosition(index, isForceUpdate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  local actorIconData = self._miniMapActorIconList[index]
  if actorIconData == nil then
    return
  end
  if actorIconData._isSet == false then
    return
  end
  local actorIconDataWrapper = ToClient_GetRoseWarMiniMapIconDataWrapperXXX(actorIconData._userNo_s64)
  if actorIconDataWrapper == nil then
    return
  end
  local isInMiniMap = self:isActorInMiniMapRange(actorIconData._userNo_s64)
  if isInMiniMap == true then
    local actorPosRate = self:calcWorldPositionToMiniMapPosRate(actorIconDataWrapper:getPosition())
    if actorPosRate.x < 0 or actorPosRate.x > 1 or 0 > actorPosRate.y or 1 < actorPosRate.y then
    elseif isForceUpdate == false and actorIconData._lastCalcPosRate.x == actorPosRate.x and actorIconData._lastCalcPosRate.y == actorPosRate.y then
    else
      actorIconData._lastCalcPosRate = actorPosRate
      local iconDataPtr = actorIconDataWrapper:getXXX()
      if iconDataPtr ~= nil then
        local viewRange = ToClient_GetRoseWarMiniMapDetectDistanceLimit()
        local centerPos = actorIconDataWrapper:getPosition()
        local leftTopPos = float3(centerPos.x - viewRange, centerPos.y, centerPos.z + viewRange)
        local rightBottomPos = float3(centerPos.x + viewRange, centerPos.y, centerPos.z - viewRange)
        local leftTopPosRate = self:calcWorldPositionToMiniMapPosRate(leftTopPos)
        local rightBottomPosRate = self:calcWorldPositionToMiniMapPosRate(rightBottomPos)
        local iconHalfSizeRateY = 0
        iconDataPtr._fogLeftTopPos.x = leftTopPosRate.x
        iconDataPtr._fogLeftTopPos.y = leftTopPosRate.y - iconHalfSizeRateY
        iconDataPtr._fogRightBottomPos.x = rightBottomPosRate.x
        iconDataPtr._fogRightBottomPos.y = rightBottomPosRate.y - iconHalfSizeRateY
      end
      self:updateActorIconPosition(actorIconData)
    end
    actorIconData._control:SetShow(true)
    actorIconData._selectedControl:SetShow(actorIconData._isSelected)
  else
    actorIconData._control:SetShow(false)
  end
end
function PaGlobal_RoseWarMiniMap:isActorInMiniMapRange(userNo64)
  if Panel_RoseWar_MiniMap == nil or userNo64 == nil then
    return false
  end
  local currentSectorIndex = ToClient_GetRoseWarPlayerPositionToSectorIndex(userNo64)
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
function PaGlobal_RoseWarMiniMap:calcWorldPositionToMiniMapPosRate(position)
  local rv = float2(0, 0)
  if Panel_RoseWar_MiniMap == nil or position == nil then
    return rv
  end
  local leftTopSectorPosX = self._beginSectorIndexXZ.x * self._sectorSizeWithCentiMeterXXX
  local leftTopSectorPosZ = (self._beginSectorIndexXZ.y + 1) * self._sectorSizeWithCentiMeterXXX
  local rightBottomSectorPosX = (self._endSectorIndexXZ.x + 1) * self._sectorSizeWithCentiMeterXXX
  local rightBottomSectorPosZ = self._endSectorIndexXZ.y * self._sectorSizeWithCentiMeterXXX
  local endX = rightBottomSectorPosX - leftTopSectorPosX
  local curX = position.x - leftTopSectorPosX
  local actorPosRateX = math.min(math.max(curX / endX, 0), 1)
  local endZ = leftTopSectorPosZ - rightBottomSectorPosZ
  local curZ = position.z - rightBottomSectorPosZ
  local actorPosRateZ = math.min(math.max(1 - curZ / endZ, 0), 1)
  rv.x = actorPosRateX
  rv.y = actorPosRateZ
  return rv
end
function PaGlobal_RoseWarMiniMap:calcMiniMapPosRateToActorPosition(posRateX, posRateY)
  local rv = float3(0, 0, 0)
  if Panel_RoseWar_MiniMap == nil or posRateX == nil or posRateY == nil then
    return rv
  end
  if posRateX < 0 or posRateX > 1 then
    return rv
  end
  if posRateY < 0 or posRateY > 1 then
    return rv
  end
  local leftTopSectorPosX = self._beginSectorIndexXZ.x * self._sectorSizeWithCentiMeterXXX
  local leftTopSectorPosZ = (self._beginSectorIndexXZ.y + 1) * self._sectorSizeWithCentiMeterXXX
  local rightBottomSectorPosX = (self._endSectorIndexXZ.x + 1) * self._sectorSizeWithCentiMeterXXX
  local rightBottomSectorPosZ = self._endSectorIndexXZ.y * self._sectorSizeWithCentiMeterXXX
  rv.x = posRateX * (rightBottomSectorPosX - leftTopSectorPosX) + leftTopSectorPosX
  rv.y = 0
  rv.z = (posRateY - 1) * -1 * (leftTopSectorPosZ - rightBottomSectorPosZ) + rightBottomSectorPosZ
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper ~= nil then
    rv.y = selfPlayerWrapper:get3DPos().y
  end
  return rv
end
function PaGlobal_RoseWarMiniMap:updateActorIconPosition(actorIconData)
  if Panel_RoseWar_MiniMap == nil or actorIconData == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * actorIconData._lastCalcPosRate.x - actorIconData._control:GetSizeX() / 2
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * actorIconData._lastCalcPosRate.y - actorIconData._control:GetSizeY() / 2
  actorIconData._control:SetPosX(newPosX)
  actorIconData._control:SetPosY(newPosY)
end
function PaGlobal_RoseWarMiniMap:updateActorIconSize(actorIconData)
  if Panel_RoseWar_MiniMap == nil or actorIconData == nil then
    return
  end
  local newSizeRatio = 1 + (self._miniMapActorIconImageRateMax - 1) * self:getMiniMapScrollRate()
  local newSizeX = self._miniMapActorIconOriginalSizeX * newSizeRatio
  local newSizeY = self._miniMapActorIconOriginalSizeY * newSizeRatio
  actorIconData._control:SetSize(newSizeX, newSizeY)
  actorIconData._actorIcon:SetSize(newSizeX, newSizeY)
  local newSelectedSizeX = self._miniMapSelectedActorIconOriginSizeX * newSizeRatio
  local newSelectedSizeY = self._miniMapSelectedActorIconOriginSizeY * newSizeRatio
  actorIconData._selectedControl:SetSize(newSelectedSizeX, newSelectedSizeY)
  actorIconData._selectedControl:SetSpanSize(actorIconData._selectedControl:GetSpanSize().x, actorIconData._control:GetSizeY() * 0.375 * -1)
  if actorIconData._isSelfIcon:GetShow() == true then
    local newSelfIconSizeX = self._miniMapSelfActorIconOriginalSizeX * newSizeRatio
    local newSelfIconSizeY = self._miniMapSelfActorIconOriginalSizeY * newSizeRatio
    actorIconData._isSelfIcon:SetSize(newSelfIconSizeX, newSelfIconSizeY)
    actorIconData._isSelfIcon:SetSpanSize(actorIconData._isSelfIcon:GetSpanSize().x, actorIconData._control:GetSizeY())
  end
  actorIconData._control:ComputePosAllChild()
end
function PaGlobal_RoseWarMiniMap:clearActorIconList()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil then
      self:setActorIconData(actorIconData, toInt64(0, 0), float2(0, 0), false)
    end
  end
end
function PaGlobal_RoseWarMiniMap:refreshMiniMapActorIconPos(doRefreshSize)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true then
      self:updateActorIconPosition(actorIconData)
      if doRefreshSize ~= nil and doRefreshSize == true then
        self:updateActorIconSize(actorIconData)
      end
    end
  end
end
function PaGlobal_RoseWarMiniMap:captrueMiniMapActorIcon(captureArea)
  if captureArea == nil or captureArea.l == nil or captureArea.t == nil or captureArea.r == nil or captureArea.b == nil then
    return
  end
  ToClient_ClearRoseWarSelectIconList()
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true then
      local actorIcon = actorIconData._control
      if actorIconData._control ~= nil and actorIconData._control:GetShow() == true then
        local deltaX = 8
        local deltaY = 8
        local iconPos = {
          l = actorIconData._control:GetParentPosX() + deltaX,
          t = actorIconData._control:GetParentPosY() + deltaY,
          r = actorIconData._control:GetParentPosX() - deltaX + actorIconData._control:GetSizeX(),
          b = actorIconData._control:GetParentPosY() - deltaY + actorIconData._control:GetSizeY()
        }
        if captureArea.r >= iconPos.l and captureArea.l <= iconPos.r and captureArea.b >= iconPos.t and captureArea.t <= iconPos.b then
          local result = ToClient_AddRoseWarSelectIconByUserNo(actorIconData._userNo_s64)
          if result == false then
            break
          end
        end
      end
    end
  end
end
function PaGlobal_RoseWarMiniMap:showSelectedActorIcon(userNo64)
  if Panel_RoseWar_MiniMap == nil or userNo64 == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true and actorIconData._userNo_s64 == userNo64 then
      actorIconData._isSelected = true
      actorIconData._selectedControl:SetShow(true)
      self:refreshActorIcon()
      break
    end
  end
end
function PaGlobal_RoseWarMiniMap:hideSelectedActorIcon()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true and actorIconData._isSelected == true then
      actorIconData._isSelected = false
      actorIconData._selectedControl:SetShow(false)
    end
  end
end
