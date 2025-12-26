function PaGlobal_HardCoreCompass:initialize()
  if PaGlobal_HardCoreCompass._initialize == true then
    return
  end
  self._ui._stc_line = UI.getChildControl(Panel_Widget_Compass_Hardcore, "Static_Line")
  self._ui._stc_direction[self.DirectionType.NORTH] = UI.getChildControl(self._ui._stc_line, "Static_Notrh")
  self._ui._stc_direction[self.DirectionType.EAST] = UI.getChildControl(self._ui._stc_line, "Static_East")
  self._ui._stc_direction[self.DirectionType.SOUTH] = UI.getChildControl(self._ui._stc_line, "Static_South")
  self._ui._stc_direction[self.DirectionType.WEST] = UI.getChildControl(self._ui._stc_line, "Static_West")
  local bossTemplete = UI.getChildControl(self._ui._stc_line, "Static_Boss")
  local rankerTemplete = UI.getChildControl(self._ui._stc_line, "Static_RankerTemplate")
  local npcTemplete = UI.getChildControl(self._ui._stc_line, "Static_Npc")
  for ii = self._rankerMax - 1, 0, -1 do
    local rankerData = {
      _isValid = false,
      _position = float3(0, 0, 0)
    }
    self._rankerData[ii] = rankerData
    self._rankerIcon[ii] = UI.cloneControl(rankerTemplete, self._ui._stc_line, "Ranker_" .. tostring(ii))
    self._rankerIcon[ii]:ChangeTextureInfoTextureIDAsync("Combine_Etc_HardcoreServer_MiniIcon_Ranking" .. ii + 1)
    self._rankerIcon[ii]:setRenderTexture(self._rankerIcon[ii]:getBaseTexture())
  end
  self._npcMax = ToClient_getHardCoreMaxRandomNpcCount()
  for ii = 0, self._npcMax - 1 do
    local npcData = {
      _isValid = false,
      _position = float3(0, 0, 0)
    }
    self._npcData[ii] = npcData
    self._npcIcon[ii] = UI.cloneControl(npcTemplete, self._ui._stc_line, "Npc_" .. tostring(ii))
  end
  self._bossMax = ToClient_getHardCoreMaxBossCount()
  for ii = 0, self._bossMax - 1 do
    local bossData = {
      _isValid = false,
      _position = float3(0, 0, 0)
    }
    self._bossData[ii] = bossData
    self._bossIcon[ii] = UI.cloneControl(bossTemplete, self._ui._stc_line, "Boss_" .. tostring(ii))
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreCompass:registEventHandler()
  PaGlobal_HardCoreCompass:validate()
  self._lineSize = self._ui._stc_line:GetSizeX()
  PaGlobal_HardCoreCompass._initialize = true
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    self:updateRankerData()
    self:updateBossData()
    Panel_Widget_Compass_Hardcore:SetShow(true)
    Panel_Widget_Compass_Hardcore:RegisterUpdateFunc("PaGlobal_HardCoreCompass_UpdatePerFrame")
  else
    Panel_Widget_Compass_Hardcore:SetShow(false)
  end
end
function PaGlobal_HardCoreCompass:registEventHandler()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  registerEvent("FromClient_UpdateHardCoreBossListUI", "PaGlobal_HardCoreCompass_BossData")
  registerEvent("FromClient_HardCoreUpdateHighRankerPosition", "PaGlobal_HardCoreCompass_RankerData")
end
function PaGlobal_HardCoreCompass:validate()
  self._ui._stc_line:isValidate()
  self._ui._stc_direction[self.DirectionType.NORTH]:isValidate()
  self._ui._stc_direction[self.DirectionType.EAST]:isValidate()
  self._ui._stc_direction[self.DirectionType.SOUTH]:isValidate()
  self._ui._stc_direction[self.DirectionType.WEST]:isValidate()
end
function PaGlobal_HardCoreCompass:prepareOpen()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  self:updateDegree()
  self:open()
end
function PaGlobal_HardCoreCompass:open()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  Panel_Widget_Compass_Hardcore:SetShow(true)
end
function PaGlobal_HardCoreCompass:prepareClose()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreCompass:close()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  Panel_Widget_Compass_Hardcore:SetShow(false)
end
function PaGlobal_HardCoreCompass:updateDegree()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local cameraYaw = getCameraRotation()
  local cameraYawDegree = cameraYaw * 180 / math.pi
  local diffAngleDegree = {
    [self.DirectionType.NORTH] = ToClient_getEulerAngleDist(cameraYaw, math.pi) * 180 / math.pi,
    [self.DirectionType.EAST] = ToClient_getEulerAngleDist(cameraYaw, math.pi * -0.5) * 180 / math.pi,
    [self.DirectionType.SOUTH] = ToClient_getEulerAngleDist(cameraYaw, 0) * 180 / math.pi,
    [self.DirectionType.WEST] = ToClient_getEulerAngleDist(cameraYaw, math.pi * 0.5) * 180 / math.pi
  }
  local halfPiDegree = 90
  for ii = 0, self.DirectionType.COUNT - 1 do
    if math.abs(diffAngleDegree[ii]) > self._hideAngle then
      self._ui._stc_direction[ii]:SetShow(false)
    elseif halfPiDegree < math.abs(diffAngleDegree[ii]) then
      self._ui._stc_direction[ii]:SetShow(true)
      if diffAngleDegree[ii] < 0 then
        self._ui._stc_direction[ii]:SetPosX(0)
      else
        self._ui._stc_direction[ii]:SetPosX(self._lineSize)
      end
    else
      self._ui._stc_direction[ii]:SetShow(true)
      local startPosX = self._lineSize * 0.5
      local maxPosX = 0
      local posRatio = math.abs(diffAngleDegree[ii]) / halfPiDegree
      if diffAngleDegree[ii] < 0 then
        varyPosX = -self._lineSize * 0.5
      else
        varyPosX = self._lineSize * 0.5
      end
      self._ui._stc_direction[ii]:SetPosX(startPosX + varyPosX * posRatio)
    end
  end
end
function PaGlobal_HardCoreCompass:updateBossData()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  for ii = 0, self._bossMax - 1 do
    self._bossData[ii]._isValid = ToClient_getHardCoreBossPositionValidByIndex(ii)
    if self._bossData[ii]._isValid == true then
      self._bossData[ii]._position = ToClient_getHardCoreBossPositionIndex(ii)
      self._bossData[ii]._position.y = 0
    else
      self._bossData[ii]._position.x = 0
      self._bossData[ii]._position.y = 0
      self._bossData[ii]._position.z = 0
    end
  end
end
function PaGlobal_HardCoreCompass:updateBossDegree()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local cameraPosition = getCameraPosition()
  cameraPosition.y = 0
  local cameraYaw = getCameraRotation()
  local cameraYawDegree = cameraYaw * 180 / math.pi
  local halfPiDegree = 90
  for ii = 0, self._bossMax - 1 do
    if self._bossData[ii]._isValid == false then
      self._bossIcon[ii]:SetShow(false)
    else
      local positionTarget = self._bossData[ii]._position
      local diffYawDegree = ToClient_getTargetDiffYawFromCamera(positionTarget) * 180 / math.pi
      local lengthMeter = ToClient_getHorizontalLengthFromSelf(positionTarget) / 100
      local lengthText = string.format("%dm", lengthMeter)
      if math.abs(diffYawDegree) > self._hideAngle then
        self._bossIcon[ii]:SetShow(false)
      elseif halfPiDegree < math.abs(diffYawDegree) then
        self._bossIcon[ii]:SetShow(true)
        self._bossIcon[ii]:SetText(lengthText)
        if 0 > math.abs(diffYawDegree) then
          self._bossIcon[ii]:SetPosX(0)
        else
          self._bossIcon[ii]:SetPosX(self._lineSize)
        end
      else
        self._bossIcon[ii]:SetShow(true)
        self._bossIcon[ii]:SetText(lengthText)
        local startPosX = self._lineSize * 0.5
        local maxPosX = 0
        local posRatio = math.abs(diffYawDegree) / halfPiDegree
        if diffYawDegree < 0 then
          varyPosX = -self._lineSize * 0.5
        else
          varyPosX = self._lineSize * 0.5
        end
        self._bossIcon[ii]:SetPosX(startPosX + varyPosX * posRatio)
      end
    end
  end
end
function PaGlobal_HardCoreCompass:updateNpcData()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  for ii = 0, self._npcMax - 1 do
    self._npcData[ii]._isValid = ToClient_getHardCoreRandomNpcPositionValidByIndex(ii)
    if self._npcData[ii]._isValid == true then
      self._npcData[ii]._position = ToClient_getHardCoreRandomNpcPositionIndex(ii)
      self._npcData[ii]._position.y = 0
    else
      self._npcData[ii]._position.x = 0
      self._npcData[ii]._position.y = 0
      self._npcData[ii]._position.z = 0
    end
  end
end
function PaGlobal_HardCoreCompass:updateNpcDegree()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local cameraPosition = getCameraPosition()
  cameraPosition.y = 0
  local cameraYaw = getCameraRotation()
  local cameraYawDegree = cameraYaw * 180 / math.pi
  local halfPiDegree = 90
  for ii = 0, self._bossMax - 1 do
    if self._npcData[ii]._isValid == false then
      self._npcIcon[ii]:SetShow(false)
    else
      local positionTarget = self._npcData[ii]._position
      local diffYawDegree = ToClient_getTargetDiffYawFromCamera(positionTarget) * 180 / math.pi
      local lengthMeter = ToClient_getHorizontalLengthFromSelf(positionTarget) / 100
      local lengthText = string.format("%dm", lengthMeter)
      if math.abs(diffYawDegree) > self._hideAngle then
        self._npcIcon[ii]:SetShow(false)
      elseif halfPiDegree < math.abs(diffYawDegree) then
        self._npcIcon[ii]:SetShow(true)
        self._npcIcon[ii]:SetText(lengthText)
        if 0 > math.abs(diffYawDegree) then
          self._npcIcon[ii]:SetPosX(0)
        else
          self._npcIcon[ii]:SetPosX(self._lineSize)
        end
      else
        self._npcIcon[ii]:SetShow(true)
        self._npcIcon[ii]:SetText(lengthText)
        local startPosX = self._lineSize * 0.5
        local maxPosX = 0
        local posRatio = math.abs(diffYawDegree) / halfPiDegree
        if diffYawDegree < 0 then
          varyPosX = -self._lineSize * 0.5
        else
          varyPosX = self._lineSize * 0.5
        end
        self._npcIcon[ii]:SetPosX(startPosX + varyPosX * posRatio)
      end
      if lengthMeter > self._npcDistanceHide then
        self._npcIcon[ii]:SetShow(false)
      end
    end
  end
end
function PaGlobal_HardCoreCompass:updateRankerData()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local myRank = ToClient_getHardCoreMyRank()
  for ii = 0, self._rankerMax - 1 do
    self._rankerData[ii]._isValid = ToClient_getHardCoreHighRankerPositionValidByIndex(ii)
    if myRank ~= 0 and ii == myRank - 1 then
      self._rankerData[ii]._isValid = false
    end
    if self._rankerData[ii]._isValid == true then
      self._rankerData[ii]._position = ToClient_getHardCoreHighRankerPositionIndex(ii)
      self._rankerData[ii]._position.y = 0
    else
      self._rankerData[ii]._position.x = 0
      self._rankerData[ii]._position.y = 0
      self._rankerData[ii]._position.z = 0
    end
    if ii >= self._rankerVisibleMax then
      self._rankerData[ii]._isValid = false
    end
  end
end
function PaGlobal_HardCoreCompass:updateRankerDegree()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local cameraPosition = getCameraPosition()
  cameraPosition.y = 0
  local cameraYaw = getCameraRotation()
  local cameraYawDegree = cameraYaw * 180 / math.pi
  local halfPiDegree = 90
  for ii = 0, self._rankerMax - 1 do
    if self._rankerData[ii]._isValid == false then
      self._rankerIcon[ii]:SetShow(false)
    else
      local positionTarget = self._rankerData[ii]._position
      local diffYawDegree = ToClient_getTargetDiffYawFromCamera(positionTarget) * 180 / math.pi
      local lengthMeter = ToClient_getHorizontalLengthFromSelf(positionTarget) / 100
      local lengthText = string.format("%dm", lengthMeter)
      if math.abs(diffYawDegree) > self._hideAngle then
        self._rankerIcon[ii]:SetShow(false)
      elseif halfPiDegree < math.abs(diffYawDegree) then
        self._rankerIcon[ii]:SetShow(true)
        self._rankerIcon[ii]:SetText(lengthText)
        if 0 > math.abs(diffYawDegree) then
          self._rankerIcon[ii]:SetPosX(0)
        else
          self._rankerIcon[ii]:SetPosX(self._lineSize)
        end
      else
        self._rankerIcon[ii]:SetShow(true)
        self._rankerIcon[ii]:SetText(lengthText)
        local startPosX = self._lineSize * 0.5
        local maxPosX = 0
        local posRatio = math.abs(diffYawDegree) / halfPiDegree
        if diffYawDegree < 0 then
          varyPosX = -self._lineSize * 0.5
        else
          varyPosX = self._lineSize * 0.5
        end
        self._rankerIcon[ii]:SetPosX(startPosX + varyPosX * posRatio)
      end
    end
  end
end
function PaGlobal_HardCoreCompass:updatePerframe()
  if Panel_Widget_Compass_Hardcore == nil then
    return
  end
  local cameraPosition = getCameraPosition()
  cameraPosition.y = 0
  local cameraYaw = getCameraRotation()
  self:updateDegree()
  self:updateBossDegree()
  self:updateRankerDegree()
end
