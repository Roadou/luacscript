PaGlobal_Widget_SceneEdit_Radar_All = {
  _ui_radar = {_stc_radar = nil},
  _ui_time = {_stc_timeBar = nil},
  _ui = {_btn_hide = nil},
  _config = {
    _dayCycle = 86400,
    _scaleMinValue = 50,
    _scaleMaxValue = 150,
    _constMapRadius = 60,
    _mapRadius = 60,
    _mapRadiusByPixel = 80,
    _bg_imageSize = 256,
    _bg_size = 5
  },
  _glowFont = {
    _region = "SubTitleFont_14",
    _regionNode = "BaseFont_10"
  },
  _background = {
    _mapImage = {},
    _mapValue = {},
    _desertMapImage = {},
    _desertMapValue = {},
    _maxAlphaDesert = 0,
    _worldDistanceToPixelRate = 0,
    _currentRate = 0,
    _currentAlpha = 1,
    _prevMaxAlpha = 0,
    _center = int2(0, 0),
    _currentRadius = 0
  },
  _lastPosition = int3(-1, -1, -1),
  _currentSelfPos = int2(0, 0),
  _pcPosBaseControl = int2(0, 0),
  _radarMap = {},
  _radarOrigSizeX = 0,
  _radarOrigSizeY = 0,
  _radarReciprocalOrigSizeX = 0,
  _radarReciprocalOrigSizeY = 0,
  _beforeIngameTime = -1,
  _isMorningLand = false,
  _isUpdateTexture = false,
  _curEffectTime = 0,
  _maxEffectTime = 1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_SceneEdit_Radar_All_Init")
function FromClient_Widget_SceneEdit_Radar_All_Init()
  PaGlobal_Widget_SceneEdit_Radar_All:initialize()
end
function PaGlobal_Widget_SceneEdit_Radar_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui_radar._stc_radar = UI.getChildControl(Panel_SceneEdit_Radar_All, "Static_Radar")
  self._ui_radar._stc_background = UI.getChildControl(self._ui_radar._stc_radar, "Static_Background")
  self._ui_radar._txt_regionName = UI.getChildControl(self._ui_radar._stc_radar, "StaticText_RegionName")
  self._ui_radar._txt_regionNodeName = UI.getChildControl(self._ui_radar._stc_radar, "StaticText_RegionNodeName")
  self._ui_radar._btn_changeMorningLand = UI.getChildControl(self._ui_radar._stc_radar, "Button_ChangeMorningLand")
  self._ui_radar._btn_sizeControl = UI.getChildControl(self._ui_radar._stc_radar, "Button_SizeControl")
  self._ui_radar._btn_sizeUp = UI.getChildControl(self._ui_radar._stc_radar, "Button_SizeUp")
  self._ui_radar._btn_sizeDown = UI.getChildControl(self._ui_radar._stc_radar, "Button_SizeDown")
  self._ui_radar._stc_alphaSlider = UI.getChildControl(self._ui_radar._stc_radar, "Slider_RadarAlpha")
  self._ui_radar._btn_alphaSliderCtrl = UI.getChildControl(self._ui_radar._stc_alphaSlider, "Button_RadarAlphaCtrl")
  self._ui_radar._btn_alphaPlus = UI.getChildControl(self._ui_radar._stc_alphaSlider, "Button_AlphaPlus")
  self._ui_radar._btn_alphaMinus = UI.getChildControl(self._ui_radar._stc_alphaSlider, "Button_AlphaMinus")
  self._ui_radar._stc_mapSizeSlider = UI.getChildControl(self._ui_radar._stc_radar, "Slider_MapSize")
  self._ui_radar._btn_mapSizeCtrl = UI.getChildControl(self._ui_radar._stc_mapSizeSlider, "Button_MapSizeCtrl")
  self._ui_radar._btn_mapSizePlus = UI.getChildControl(self._ui_radar._stc_mapSizeSlider, "Button_RadarViewModePlus")
  self._ui_radar._btn_mapSizeMinus = UI.getChildControl(self._ui_radar._stc_mapSizeSlider, "Button_RadarViewModeMinus")
  self._ui_radar._stc_selfPlayerIcon = UI.getChildControl(self._ui_radar._stc_radar, "Static_SelfPlayerIcon")
  self._ui_time._stc_timeBar = UI.getChildControl(Panel_SceneEdit_Radar_All, "Static_TimeBar")
  self._ui_time._txt_gameTime = UI.getChildControl(self._ui_time._stc_timeBar, "StaticText_Time")
  self._ui._btn_hide = UI.getChildControl(Panel_SceneEdit_Radar_All, "Button_Hide")
  self._ui._btn_close = UI.getChildControl(Panel_SceneEdit_Radar_All, "Button_Close")
  self:registEventHandler()
  self:ControlAlign()
  self:radarBackgroundInit()
  self:updateScale()
  Panel_SceneEdit_Radar_All:RegisterUpdateFunc("PaGlobalFunc_Widget_SceneEdit_Radar_All_Update")
  self:prepareOpen()
  self._initialize = true
end
function PaGlobal_Widget_SceneEdit_Radar_All:radarBackgroundInit()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local constImageSize = self._config._bg_imageSize
  local constSize = self._config._bg_size
  local reciprocalConstSize = 1 / constSize
  local loopCount = constSize * constSize - 1
  for index = 0, loopCount do
    if self._background._mapImage[index] == nil then
      self._background._mapImage[index] = UI.createControl(__ePAUIControl_Static, self._ui_radar._stc_radar, "Static_minimap_Image_" .. index)
      self._background._mapImage[index]:SetShow(true)
      self._background._mapImage[index]:SetSize(constImageSize, constImageSize)
      self._background._mapImage[index]:SetIgnore(true)
      self._background._mapImage[index]:SetPosX(index % constSize * constImageSize)
      self._background._mapImage[index]:SetPosY(math.floor(index * reciprocalConstSize) * constImageSize)
      self._background._mapImage[index]:SetColor(Defines.Color.C_FFFFFFFF)
      self._background._mapImage[index]:SetDepth(2)
      self._background._mapValue[index] = int2(9999, 9999)
      self._ui_radar._stc_radar:SetChildIndex(self._background._mapImage[index], index)
    end
  end
  for index = 0, loopCount do
    if self._background._mapImage[index] == nil then
      self._background._desertMapImage[index] = UI.createControl(__ePAUIControl_Static, self._ui_radar._stc_radar, "Static_minimap_ImageDesert_" .. index)
      self._background._desertMapImage[index]:SetShow(false)
      self._background._desertMapImage[index]:SetSize(constImageSize, constImageSize)
      self._background._desertMapImage[index]:SetIgnore(true)
      self._background._desertMapImage[index]:SetPosX(index % constSize * constImageSize)
      self._background._desertMapImage[index]:SetPosY(math.floor(index * reciprocalConstSize) * constImageSize)
      self._background._desertMapImage[index]:SetColor(Defines.Color.C_FFFFFFFF)
      self._background._desertMapImage[index]:SetDepth(1)
      self._background._desertMapValue[index] = int2(9999, 9999)
      self._background._desertMapValue[index]:SetAlpha(self._background._maxAlphaDesert)
      self._ui_radar._stc_radar:SetChildIndex(self._background._desertMapImage[index], index + constSize * constSize)
    end
  end
end
function PaGlobal_Widget_SceneEdit_Radar_All:registEventHandler()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_SceneEdit_Radar_All_ResizePanel")
  self._pcPosBaseControl.x = self._ui_radar._stc_selfPlayerIcon:GetPosX() + self._ui_radar._stc_selfPlayerIcon:GetSizeX() / 2
  self._pcPosBaseControl.y = self._ui_radar._stc_selfPlayerIcon:GetPosY() + self._ui_radar._stc_selfPlayerIcon:GetSizeY() / 2
  local radarSizeX = self._ui_radar._stc_radar:GetSizeX()
  local radarSizeY = self._ui_radar._stc_radar:GetSizeY()
  self._radarOrigSizeX = radarSizeX
  self._radarOrigSizeY = radarSizeY
  self._radarReciprocalOrigSizeX = 1 / self._radarOrigSizeX
  self._radarReciprocalOrigSizeY = 1 / self._radarOrigSizeY
  self._ui_radar._stc_background:SetSize(radarSizeX, radarSizeY)
  self._ui_radar._stc_mapSizeSlider:addInputEvent("Mouse_LPress", "PaGlobalFunc_Widget_SceneEdit_Radar_All_UpdateScale()")
  self._ui_radar._btn_mapSizeCtrl:addInputEvent("Mouse_LPress", "PaGlobalFunc_Widget_SceneEdit_Radar_All_UpdateScale()")
  self._ui._btn_hide:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_SceneEdit_Radar_All_SetShowRadar()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_SceneEdit_Radar_All_Close()")
  local control = self._ui._btn_hide
  local x1, y1, x2, y2 = 0, 0, 0, 0
  control:ChangeOnTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 464, 173, 488, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 389, 173, 413, 197)
  end
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 489, 173, 513, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 414, 173, 438, 197)
  end
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:ChangeTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 439, 173, 463, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 364, 173, 388, 197)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_Widget_SceneEdit_Radar_All:resize()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  Panel_SceneEdit_Radar_All:ComputePosAllChild()
end
function PaGlobal_Widget_SceneEdit_Radar_All:prepareOpen()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  if ToClient_IsDevelopment() == false then
    return
  end
  FromClient_Widget_SceneEdit_Radar_All_ResizePanel()
  self._curEffectTime = 0
  Panel_SceneEdit_Radar_All:SetIgnore(true)
  Panel_SceneEdit_Radar_All:setGlassBackground(true)
  self:open()
end
function PaGlobal_Widget_SceneEdit_Radar_All:open()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  Panel_SceneEdit_Radar_All:SetShow(true)
end
function PaGlobal_Widget_SceneEdit_Radar_All:prepareClose()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  Panel_SceneEdit_Radar_All:ClearUpdateLuaFunc()
  self._curEffectTime = 0
  self:close()
end
function PaGlobal_Widget_SceneEdit_Radar_All:close()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  Panel_SceneEdit_Radar_All:SetShow(false)
end
function PaGlobal_Widget_SceneEdit_Radar_All:ControlAlign()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  self._radarMap.scaleRateWidth = self._ui_radar._stc_radar:GetSizeX() * self._radarReciprocalOrigSizeX
  self._radarMap.scaleRateHeight = self._ui_radar._stc_radar:GetSizeY() * self._radarReciprocalOrigSizeY
  local alphaScrlScaleY = self._radarMap.scaleRateHeight + (self._radarMap.scaleRateHeight - 1) * 0.5
  self._ui_radar._stc_alphaSlider:SetScale(1, alphaScrlScaleY)
  self._ui_radar._txt_regionName:SetHorizonCenter()
  self._ui_radar._txt_regionNodeName:ComputePos()
  self._ui_radar._btn_mapSizePlus:ComputePos()
  self._ui_radar._btn_mapSizeMinus:ComputePos()
  self._ui_radar._stc_mapSizeSlider:SetVerticalBottom()
  self._ui_radar._stc_alphaSlider:SetPosY(self._ui_radar._btn_mapSizeMinus:GetPosY() + self._ui_radar._btn_mapSizeMinus:GetSizeY() + 10)
  self._ui_radar._btn_changeMorningLand:SetPosX(self._ui_radar._btn_mapSizePlus:GetPosX() + 2)
  self._ui_radar._btn_changeMorningLand:SetPosY(self._ui_radar._btn_mapSizePlus:GetPosY() - self._ui_radar._btn_changeMorningLand:GetSizeY() - 5)
  local timeBarSizeX = 65
  local timeBarSizeY = self._ui_radar._stc_radar:GetSizeY() - 10 * self._radarMap.scaleRateHeight + 23
  local timeBarGapX = 6 + self._ui._btn_hide:GetSizeX()
  self._ui_time._stc_timeBar:SetSize(timeBarSizeX, 22)
  self._ui_time._stc_timeBar:SetPosX(self._ui_radar._stc_radar:GetPosX() + 10 * self._radarMap.scaleRateWidth - timeBarGapX)
  self._ui_radar._stc_mapSizeSlider:SetPosX(self._ui_radar._stc_mapSizeSlider:GetPosX() + 10 * self._radarMap.scaleRateWidth)
  self._ui_radar._stc_mapSizeSlider:SetPosY(self._ui_radar._stc_mapSizeSlider:GetPosY() - 10 * self._radarMap.scaleRateHeight)
  self:UpdatePosition()
end
function PaGlobal_Widget_SceneEdit_Radar_All:UpdatePosition()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  self._ui_time._txt_gameTime:ComputePos()
  self._ui_radar._txt_regionName:ComputePos()
  self._ui_radar._txt_regionNodeName:ComputePos()
  self._ui_radar._stc_radar:ComputePos()
end
function PaGlobal_Widget_SceneEdit_Radar_All:update(deltaTime)
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  self._curEffectTime = self._curEffectTime + deltaTime
  if self._curEffectTime < self._maxEffectTime then
    return
  end
  self:updateTime()
  if self._ui_radar._stc_radar:GetShow() == false then
    return
  end
  local isMorningLand = ToClient_IsMorningLand()
  if isMorningLand ~= self._isMorningLand then
    self._isMorningLand = isMorningLand
    self._isUpdateTexture = true
  end
  self._ui_radar._txt_regionName:SetShow(not isMorningLand)
  self:updateRegionName()
  self:updateMapImage(deltaTime)
end
function PaGlobal_Widget_SceneEdit_Radar_All:updateTime()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local ingameTime = getIngameTime_variableSecondforLua()
  if ingameTime < 0 then
    return
  end
  if ingameTime > self._config._dayCycle then
    ingameTime = ingameTime % self._config._dayCycle
  end
  if ingameTime ~= self._beforeIngameTime then
    self._beforeIngameTime = ingameTime
    local minute = math.floor(ingameTime / 60) % 60
    local hour = math.floor(ingameTime / 3600)
    local calcMinute = "00"
    if minute < 10 then
      calcMinute = "0" .. minute
    else
      calcMinute = tostring(minute)
    end
    if hour == 12 then
      self._ui_time._txt_gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_AFTERNOON") .. " " .. tostring(hour) .. " : " .. calcMinute)
    elseif hour == 0 then
      local calcHour = hour + 12
      self._ui_time._txt_gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. tostring(calcHour) .. " : " .. calcMinute)
    elseif hour == 24 then
      local calcHour = hour
      self._ui_time._txt_gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. "0" .. " : " .. calcMinute)
    elseif hour > 11 then
      local calcHour = hour - 12
      self._ui_time._txt_gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_AFTERNOON") .. " " .. tostring(calcHour) .. " : " .. calcMinute)
    else
      self._ui_time._txt_gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. tostring(hour) .. " : " .. calcMinute)
    end
  end
end
function PaGlobal_Widget_SceneEdit_Radar_All:updateRegionName()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local regionInfoWrapper = getRegionInfoByPosition(getCameraPosition())
  if regionInfoWrapper == nil or regionInfoWrapper:get() == nil then
    return
  end
  local isSafetyZone = regionInfoWrapper:get():isSafeZone()
  local regionNameColor = 0
  local glowColor = 0
  if isSafetyZone == true then
    regionNameColor = 4292276981
    glowColor = 4281961144
  else
    regionNameColor = 4294495693
    glowColor = 4286580487
  end
  self._ui_radar._txt_regionName:SetFontColor(regionNameColor)
  self._ui_radar._txt_regionName:useGlowFont(true, self._glowFont._region, glowColor)
  self._ui_radar._txt_regionNodeName:SetFontColor(regionNameColor)
  self._ui_radar._txt_regionNodeName:useGlowFont(true, self._glowFont._regionNode, glowColor)
  self._ui_radar._txt_regionName:ComputePos()
  self._ui_radar._txt_regionName:SetText(regionInfoWrapper:getAreaName())
end
function PaGlobal_Widget_SceneEdit_Radar_All:updateMapImage(deltaTime)
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local position = getCameraPosition()
  local rotation = getCameraRotation()
  self._ui_radar._stc_selfPlayerIcon:SetRotate(rotation)
  if position.x ~= self._lastPosition.x or position.z ~= self._lastPosition.z or self._currentRate ~= self._background._worldDistanceToPixelRate or self._currentSelfPos.x ~= self._pcPosBaseControl.x or self._currentSelfPos.y ~= self._pcPosBaseControl.y or self._background._maxAlphaDesert == self._prevMaxAlpha then
  end
  local regionInfoWrapper = getRegionInfoByPosition(position)
  if regionInfoWrapper == nil then
    return
  end
  self._prevMaxAlpha = self._background._maxAlphaDesert
  local isDesertZone = regionInfoWrapper:isDesert()
  local isOceanZone = regionInfoWrapper:isOcean()
  local desertMapImageContainer = self._background._desertMapImage
  if isDesertZone == true or isOceanZone == true then
    self._background._maxAlphaDesert = self._background._maxAlphaDesert + deltaTime / 2
    if self._background._maxAlphaDesert > 1 then
      self._background._maxAlphaDesert = 1
    end
    local calcAlpha = self._background._maxAlphaDesert * self._background._currentAlpha
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(true)
      value:SetAlpha(calcAlpha)
    end
  elseif self._background._maxAlphaDesert > 0 then
    self._background._maxAlphaDesert = self._background._maxAlphaDesert - deltaTime / 2
    if self._background._maxAlphaDesert < 0 then
      self._background._maxAlphaDesert = 0
    end
    local calcAlpha = self._background._maxAlphaDesert * self._background._currentAlpha
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(true)
      value:SetAlpha(calcAlpha)
    end
  else
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(false)
      value:SetAlpha(0)
    end
  end
  self._currentSelfPos = {
    x = self._pcPosBaseControl.x,
    y = self._pcPosBaseControl.y
  }
  self._currentRate = self._background._worldDistanceToPixelRate
  self._config._bg_imageSize = math.floor(self._currentRate * 256)
  local constImageSize = self._config._bg_imageSize
  local constSize = self._config._bg_size
  local halfConstSize = math.floor(constSize / 2)
  local reciprocalConstSize = 1 / constSize
  self._lastPosition = position
  local currentSector = convertPosToSector(self._lastPosition)
  local inSectorPos = convertPosToInSectorPos(self._lastPosition)
  local startX = math.floor(-(inSectorPos.x * 0.01 * self._currentRate) * 2 - constImageSize * 2 + self._currentSelfPos.x)
  local startY = math.floor(inSectorPos.z * 0.01 * self._currentRate * 2 - constImageSize * 3 + self._currentSelfPos.y)
  local calcAlpha = (1 - self._background._maxAlphaDesert) * self._background._currentAlpha
  local morningLandPath = ""
  if self._isMorningLand == true then
    morningLandPath = "_MorningLand/"
  end
  local radarPath = ToClient_getRadarPath() .. morningLandPath .. "Rader_"
  local loopCount = constSize * constSize - 1
  for index = 0, loopCount do
    local indexModConstSize = index % constSize
    local floorIndexDivConstSize = math.floor(index * reciprocalConstSize)
    local xSector = currentSector.x - halfConstSize + indexModConstSize
    local zSector = currentSector.z + halfConstSize - floorIndexDivConstSize
    local mapImage = self._background._mapImage[index]
    local mapValue = self._background._mapValue[index]
    if mapImage ~= nil and mapValue ~= nil then
      if mapValue.x ~= xSector or mapValue.y ~= zSector or self._isUpdateTexture == true then
        mapValue.x = xSector
        mapValue.y = zSector
        mapImage:ChangeTextureInfoNameForRadarBackground(radarPath .. xSector .. "_" .. zSector .. ".dds")
      end
      mapImage:SetPosX(startX + indexModConstSize * constImageSize)
      mapImage:SetPosY(startY + floorIndexDivConstSize * constImageSize)
      mapImage:SetSize(constImageSize, constImageSize)
      mapImage:SetAlpha(calcAlpha)
      mapImage:SetShow(true)
      local xValue = (currentSector.x + index) % constSize
      local zValue = constSize - (currentSector.z - floorIndexDivConstSize) % constSize - 1
      local currentCenterX = self._lastPosition.x + 12800 * (indexModConstSize - 2)
      local currentCenterZ = self._lastPosition.z + 12800 * (2 - floorIndexDivConstSize)
      local radix = self._background._center.x - currentCenterX
      local radiz = self._background._center.y - currentCenterZ
      if radix * radix + radiz * radiz < self._background._currentRadius * self._background._currentRadius then
        mapImage:SetMonoTone(false)
      elseif self._background._currentRadius ~= 0 then
        mapImage:SetMonoTone(true)
      end
    end
    local desertMapImage = self._background._desertMapImage[index]
    local desertMapValue = self._background._desertMapValue[index]
    if desertMapImage ~= nil and desertMapValue ~= nil then
      if desertMapValue.x ~= xValue or desertMapValue.y ~= zValue or self._background._maxAlphaDesert > 0 and self._background._maxAlphaDesert < 1 or self._isUpdateTexture == true then
        desertMapValue.x = xValue
        desertMapValue.y = zValue
        if isDesertZone == true then
          desertMapImage:ChangeTextureInfoNameForRadarBackground("New_UI_Common_forLua/Widget/Rader/Rader_Desert_" .. xValue .. "_" .. zValue .. ".dds")
        elseif isOceanZone == true then
          desertMapImage:ChangeTextureInfoNameForRadarBackground("New_UI_Common_forLua/Widget/Rader/Rader_Ocean_" .. xValue .. "_" .. zValue .. ".dds")
        end
      end
      desertMapImage:SetPosX(startX + indexModConstSize * constImageSize)
      desertMapImage:SetPosY(startY + floorIndexDivConstSize * constImageSize)
      desertMapImage:SetSize(constImageSize, constImageSize)
    end
  end
  self._isUpdateTexture = false
end
function PaGlobal_Widget_SceneEdit_Radar_All:updateWorldMapDistance(mapRadius)
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local radius = math.min(math.max(mapRadius, self._config._scaleMinValue), self._config._scaleMaxValue)
  self._background._worldDistanceToPixelRate = self._config._mapRadiusByPixel / radius
end
function PaGlobal_Widget_SceneEdit_Radar_All:updateScale()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local scaleCtrlPos = self._ui_radar._stc_mapSizeSlider:GetControlPos()
  local scaleSlideValue = 1 - scaleCtrlPos
  local mapRadius = self._config._scaleMinValue + scaleSlideValue * 100
  self:updateWorldMapDistance(mapRadius)
  ToClient_SetRaderScale(scaleCtrlPos)
end
function PaGlobalFunc_Widget_SceneEdit_Radar_All_Update(deltaTime)
  PaGlobal_Widget_SceneEdit_Radar_All:update(deltaTime)
end
function PaGlobalFunc_Widget_SceneEdit_Radar_All_UpdateScale()
  PaGlobal_Widget_SceneEdit_Radar_All:updateScale()
end
function HandleEventLUp_Widget_SceneEdit_Radar_All_SetShowRadar()
  if Panel_SceneEdit_Radar_All == nil then
    return
  end
  local isShow = PaGlobal_Widget_SceneEdit_Radar_All._ui_radar._stc_radar:GetShow() == false
  PaGlobal_Widget_SceneEdit_Radar_All._ui_radar._stc_radar:SetShow(isShow)
  PaGlobal_Widget_SceneEdit_Radar_All._ui_time._stc_timeBar:SetShow(isShow)
  local control = PaGlobal_Widget_SceneEdit_Radar_All._ui._btn_hide
  local x1, y1, x2, y2 = 0, 0, 0, 0
  control:ChangeOnTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 464, 173, 488, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 389, 173, 413, 197)
  end
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 489, 173, 513, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 414, 173, 438, 197)
  end
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:ChangeTextureInfoNameAsync("renewal/function/console_function_00.dds")
  if isShow == true then
    x1, y1, x2, y2 = setTextureUV_Func(control, 439, 173, 463, 197)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 364, 173, 388, 197)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function HandleEventLUp_Widget_SceneEdit_Radar_All_Close()
  PaGlobal_Widget_SceneEdit_Radar_All:prepareClose()
end
function FromClient_Widget_SceneEdit_Radar_All_ResizePanel()
  PaGlobal_Widget_SceneEdit_Radar_All:resize()
end
