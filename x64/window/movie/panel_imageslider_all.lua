PaGlobal_ImageSlider_All = {
  _ui = {
    _imageBGSwapChain = {},
    _txt_subTitleUp = nil,
    _txt_subTitleDown = nil,
    _txt_currTimeForDev = nil,
    _txt_currImagePercent = nil,
    _txt_pause = nil
  },
  _curData = nil,
  _nextData = nil,
  _curBGIndex = 0,
  _nextBGIndex = 1,
  _swapChainCount = 2,
  _imageSlideCount = 0,
  _imageSlideKey = -1,
  _curSliderIndex = 0,
  _curLifeTime = 0,
  _lifeTime = 0,
  _curImageUpdateTime = 0,
  _textureWidth = 0,
  _textureHeight = 0,
  _isSetNextImage = false,
  _isSubTitleUpPos = false,
  _curSubTitleIndex = 0,
  _subTitleCount = 0,
  _subTitleStartTime = 0,
  _subTitleEndTime = 0,
  _isSubTitleUpdate = false,
  _audioCount = 0,
  _curAudioStartIndex = 0,
  _curAudioEndIndex = 0,
  _prevUIMode = nil,
  _isStop = false,
  _isConsole = false,
  _initialize = false,
  _curUpdateTime = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ImageCutScene_All_Init")
function FromClient_ImageCutScene_All_Init()
  PaGlobal_ImageSlider_All:initialize()
end
function PaGlobal_ImageSlider_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._imageBGSwapChain[0] = UI.getChildControl(Panel_ImageSlider_All, "Static_ImageSliderBG")
  self._ui._imageBGSwapChain[1] = UI.getChildControl(Panel_ImageSlider_All, "Static_ImageSliderNextBG")
  self._ui._txt_subTitleUp = UI.getChildControl(Panel_ImageSlider_All, "StaticText_SubTitleUp")
  self._ui._txt_subTitleDown = UI.getChildControl(Panel_ImageSlider_All, "StaticText_SubTitleDown")
  self._ui._txt_currTimeForDev = UI.getChildControl(Panel_ImageSlider_All, "StaticText_CurrTime")
  self._ui._txt_currImagePercent = UI.getChildControl(Panel_ImageSlider_All, "StaticText_NextImageChangeTime")
  self._ui._txt_pause = UI.getChildControl(Panel_ImageSlider_All, "StaticText_Pause")
  if ToClient_IsDevelopment() == true then
    self._ui._txt_currTimeForDev:SetShow(true)
    self._ui._txt_currImagePercent:SetShow(true)
  end
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_ImageSlider_All:validate()
  if nil == Panel_ImageSlider_All then
    return
  end
  for ii = 0, self._swapChainCount - 1 do
    self._ui._imageBGSwapChain[ii]:isValidate()
  end
end
function PaGlobal_ImageSlider_All:registEventHandler()
  if nil == Panel_ImageSlider_All then
    return
  end
  self._ui._txt_subTitleUp:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_subTitleDown:SetTextMode(__eTextMode_AutoWrap)
  registerEvent("FromClient_StartImageSlide", "FromClient_ImageSlider_All_StartImageSlide")
  registerEvent("onScreenResize", "FromClient_ImageSlider_All_Resize")
end
function PaGlobal_ImageSlider_All:clear()
  if nil == Panel_ImageSlider_All then
    return
  end
  self._curLifeTime = 0
  self._lifeTime = 0
  self._curImageUpdateTime = 0
  self._curSliderIndex = 0
  self._curBGIndex = 0
  self._nextBGIndex = 1
  self._imageSlideCount = 0
  self._imageSlideKey = -1
  self._curData = nil
  self._nextData = nil
  self._isSetNextImage = false
  for ii = 0, self._swapChainCount - 1 do
    self._ui._imageBGSwapChain[ii]:SetShow(false)
  end
  self._isSubTitleUpPos = false
  self._curSubTitleIndex = 0
  self._subTitleCount = 0
  self._subTitleStartTime = 0
  self._subTitleEndTime = 0
  self._isSubTitleUpdate = false
  self._ui._txt_subTitleUp:SetShow(false)
  self._ui._txt_subTitleDown:SetShow(false)
  self._audioCount = 0
  self._curAudioStartIndex = 0
  self._curAudioEndIndex = 0
  self._isStop = false
  self._curUpdateTime = 0
  self._ui._txt_pause:SetShow(false)
  Panel_ImageSlider_All:ClearUpdateLuaFunc()
end
function PaGlobal_ImageSlider_All:prepareOpen(fileName, imageSlideKey)
  if nil == Panel_ImageSlider_All then
    return
  end
  if nil == fileName or nil == imageSlideKey then
    return
  end
  self:clear()
  self:resize()
  if 0 ~= ToClient_LoadImageSlideData(fileName, imageSlideKey) then
    return
  end
  local imageSlideCount = ToClient_GetImageSlideCount()
  if imageSlideCount <= 0 then
    return
  end
  if nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    PaGlobalFunc_DialogMain_All_Close()
  end
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_Cutscene)
  self._imageSlideKey = imageSlideKey
  self._imageSlideCount = imageSlideCount
  if false == self:updateCurImage() then
    return
  end
  self._subTitleCount = ToClient_GetImageSlideSubTitleCount()
  if 0 < self._subTitleCount and false == self:updateSubTitle() then
    self._subTitleCount = 0
    self._curSubTitleIndex = 0
  end
  self._audioCount = ToClient_GetImageSlideAudioCount()
  ToClient_SetGameSyncForCutscene(__eMuteWorldType_1, __eMuteEnvType_1, __eMuteMusicType_1)
  Panel_ImageSlider_All:RegisterUpdateFunc("PaGlobalFunc_ImageCutScene_All_UpdatePerFrame")
  self:open()
end
function PaGlobal_ImageSlider_All:open()
  if nil == Panel_ImageSlider_All then
    return
  end
  Panel_ImageSlider_All:SetShow(true)
end
function PaGlobal_ImageSlider_All:prepareClose()
  if nil == Panel_ImageSlider_All then
    return
  end
  self:clear()
  ToClient_StopImageSlideAudioAll()
  ToClient_UnloadImageSlideAudioBanksAll()
  ToClient_SetGameSyncForCutscene(__eMuteWorldType_0, __eMuteEnvType_0, __eMuteMusicType_0)
  if nil ~= self._prevUIMode then
    SetUIMode(self._prevUIMode)
  end
  self:close()
end
function PaGlobal_ImageSlider_All:close()
  if nil == Panel_ImageSlider_All then
    return
  end
  Panel_ImageSlider_All:SetShow(false)
end
function PaGlobal_ImageSlider_All:resize()
  if nil == Panel_ImageSlider_All then
    return
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX() / uiScale
  local sizeY = getResolutionSizeY() / uiScale
  Panel_ImageSlider_All:SetPosX(0)
  Panel_ImageSlider_All:SetPosY(0)
  Panel_ImageSlider_All:SetSize(sizeX, sizeY)
  local imageSlideSizeX = sizeX
  local imageSlideSizeY = sizeX * 9 / 21
  local minSizeY = sizeY - 200
  if imageSlideSizeY > minSizeY then
    imageSlideSizeY = minSizeY
    imageSlideSizeX = imageSlideSizeY * 21 / 9
  end
  for ii = 0, self._swapChainCount - 1 do
    self._ui._imageBGSwapChain[ii]:SetSize(imageSlideSizeX, imageSlideSizeY)
  end
  local letterBoxGapY = sizeY - imageSlideSizeY
  self._ui._txt_subTitleUp:SetSpanSize(self._ui._txt_subTitleUp:GetSpanSize().x, letterBoxGapY * 0.25 - self._ui._txt_subTitleUp:GetSizeY() * 0.5)
  self._ui._txt_subTitleDown:SetSpanSize(self._ui._txt_subTitleDown:GetSpanSize().x, letterBoxGapY * 0.25 - self._ui._txt_subTitleDown:GetSizeY() * 0.5)
  Panel_ImageSlider_All:ComputePosAllChild()
end
function PaGlobal_ImageSlider_All:changeImage(control, data)
  if nil == data or nil == control then
    return false
  end
  local imagePath = data:getImagePath()
  if nil == imagePath or "" == imagePath then
    return false
  end
  local pos = data:getPos()
  control:ChangeTextureInfoNameAsync(imagePath)
  local baseTexture = control:getBaseTexture()
  local x1, y1, x2, y2 = setTextureUV_Func(control, pos.x, pos.y, pos.z, pos.w)
  x1 = math.max(x1, 0)
  y1 = math.max(y1, 0)
  x2 = math.min(x2, 1)
  y2 = math.min(y2, 1)
  baseTexture:setUV(x1, y1, x2, y2)
  control:setRenderTexture(baseTexture)
end
function PaGlobal_ImageSlider_All:updateCurImage()
  if nil == Panel_ImageSlider_All then
    return false
  end
  if nil ~= self._nextData then
    self._curData = self._nextData
    if nil == self._curData or self._curData:getImageSlideKey() ~= self._imageSlideKey then
      self._curData = nil
      return false
    end
    if 0 == self._curBGIndex then
      self._curBGIndex = 1
      self._nextBGIndex = 0
    else
      self._curBGIndex = 0
      self._nextBGIndex = 1
    end
  else
    local data = ToClient_GetImageSlideData(self._curSliderIndex)
    if false == self:changeImage(self._ui._imageBGSwapChain[self._curBGIndex], data) then
      self._curData = nil
      return false
    end
    if data:getImageSlideKey() ~= self._imageSlideKey then
      self._curData = nil
      return false
    end
    self._curData = data
  end
  self._textureWidth = self._ui._imageBGSwapChain[self._curBGIndex]:getTextureWidth()
  self._textureHeight = self._ui._imageBGSwapChain[self._curBGIndex]:getTextureHeight()
  self._ui._imageBGSwapChain[self._curBGIndex]:SetShow(true)
  self._lifeTime = self._curData:getLifeTime()
  self._isSetNextImage = false
  return true
end
function PaGlobal_ImageSlider_All:updateNextImage()
  if nil == Panel_ImageSlider_All then
    return false
  end
  local nextIndex = self._curSliderIndex + 1
  self._ui._imageBGSwapChain[self._nextBGIndex]:SetShow(false)
  local data = ToClient_GetImageSlideData(nextIndex)
  if false == self:changeImage(self._ui._imageBGSwapChain[self._nextBGIndex], data) then
    self._nextData = nil
    return false
  end
  if data:getImageSlideKey() ~= self._imageSlideKey then
    self._nextData = nil
    return false
  end
  self._nextData = data
  return true
end
function PaGlobal_ImageSlider_All:updateSubTitle()
  if nil == Panel_ImageSlider_All then
    return false
  end
  self._ui._txt_subTitleUp:SetShow(false)
  self._ui._txt_subTitleDown:SetShow(false)
  local subTitleData = ToClient_GetImageSlideSubTitleData(self._curSubTitleIndex)
  if nil == subTitleData then
    return false
  end
  if subTitleData:getImageSlideKey() ~= self._imageSlideKey then
    return false
  end
  local subTitle = subTitleData:getSubTitleString()
  if nil == subTitle then
    return false
  end
  local subTitleText = PAGetString(Defines.StringSheet_IMAGESLIDE, subTitle)
  self._isSubTitleUpPos = subTitleData:isUpPos()
  if true == self._isSubTitleUpPos then
    self._ui._txt_subTitleUp:SetText(subTitleText)
  else
    self._ui._txt_subTitleDown:SetText(subTitleText)
  end
  self._subTitleStartTime = subTitleData:getStartTime()
  self._subTitleEndTime = self._subTitleStartTime + subTitleData:getLifeTime()
  self._isSubTitleUpdate = true
  return true
end
function PaGlobal_ImageSlider_All:updateImageSlider(deltaTime)
  if nil == Panel_ImageSlider_All or false == Panel_ImageSlider_All:GetShow() then
    return
  end
  if nil == self._curData then
    self:prepareClose()
    return
  end
  if ToClient_IsDevelopment() == true and isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_SPACE) then
    self._isStop = not self._isStop
    self._ui._txt_pause:SetShow(self._isStop)
  end
  if self._isStop == true then
    return
  end
  if ToClient_IsDevelopment() == true then
    if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_RIGHT) then
      self._curLifeTime = self._curLifeTime + 1
      self._curUpdateTime = self._curUpdateTime + 1
    elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LEFT) then
      self._curLifeTime = self._curLifeTime - 1
      self._curUpdateTime = self._curUpdateTime - 1
    else
      self._curLifeTime = self._curLifeTime + deltaTime
      self._curUpdateTime = self._curUpdateTime + deltaTime
    end
  else
    self._curLifeTime = self._curLifeTime + deltaTime
    self._curUpdateTime = self._curUpdateTime + deltaTime
  end
  if self._curSubTitleIndex < self._subTitleCount then
    if self._subTitleEndTime <= self._curUpdateTime then
      self._curSubTitleIndex = self._curSubTitleIndex + 1
      if false == self:updateSubTitle() then
        self._subTitleCount = 0
        self._curSubTitleIndex = 0
      end
    end
    if true == self._isSubTitleUpdate and self._subTitleStartTime <= self._curUpdateTime then
      self._isSubTitleUpdate = false
      if true == self._isSubTitleUpPos then
        self._ui._txt_subTitleUp:SetShow(true)
      else
        self._ui._txt_subTitleDown:SetShow(true)
      end
    end
  end
  local percent = 0
  if self._lifeTime <= self._curLifeTime then
    self._curLifeTime = self._curLifeTime - self._lifeTime
    self._curSliderIndex = self._curSliderIndex + 1
    if false == self:updateCurImage() then
      self:prepareClose()
      return
    end
    self._curImageUpdateTime = 0
  elseif self._curLifeTime < 0 then
    self._curSliderIndex = self._curSliderIndex - 1
    local isIndexMinus = false
    if self._curUpdateTime < 0 then
      self._curSliderIndex = 0
      self._curUpdateTime = 0
      isIndexMinus = true
    end
    self._nextData = nil
    if false == self:updateCurImage() then
      self:prepareClose()
      return
    end
    if isIndexMinus then
      self._curLifeTime = 0
    else
      self._curLifeTime = self._lifeTime + self._curLifeTime
    end
    self._curImageUpdateTime = 0
  else
    self._curImageUpdateTime = self._curImageUpdateTime + deltaTime
    if self._curImageUpdateTime >= 0.01 then
      self._curImageUpdateTime = 0
      percent = 0
      if 0 < self._lifeTime then
        percent = self._curLifeTime / self._lifeTime
      end
      local pos = self._curData:getPos()
      local movePos = self._curData:getMovePos()
      movePos.x = movePos.x * percent
      movePos.y = movePos.y * percent
      local changeSize = self._curData:getChangeSize()
      changeSize = changeSize * percent
      local sizeX = (pos.z - pos.x) * changeSize / 2
      local sizeY = (pos.w - pos.y) * changeSize / 2
      pos.x = pos.x + movePos.x - sizeX
      pos.y = pos.y + movePos.y - sizeY
      pos.z = pos.z + movePos.x + sizeX
      pos.w = pos.w + movePos.y + sizeY
      local baseTexture = self._ui._imageBGSwapChain[self._curBGIndex]:getBaseTexture()
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._imageBGSwapChain[self._curBGIndex], pos.x, pos.y, pos.z, pos.w)
      x1 = math.max(x1, 0)
      y1 = math.max(y1, 0)
      x2 = math.min(x2, 1)
      y2 = math.min(y2, 1)
      baseTexture:setUV(x1, y1, x2, y2)
      self._ui._imageBGSwapChain[self._curBGIndex]:setRenderTexture(baseTexture)
      if false == self._isSetNextImage then
        self._isSetNextImage = true
        self:updateNextImage()
      end
    end
  end
  if 0 < self._audioCount then
    for i = self._curAudioStartIndex, self._audioCount - 1 do
      local data = ToClient_GetImageSlideAudioData(i)
      if data == nil then
        break
      elseif data:getStartTime() <= self._curUpdateTime then
        ToClient_PlayImageSlideAudio(i)
        if i >= self._audioCount - 1 then
          self._curAudioStartIndex = self._audioCount
        end
      else
        self._curAudioStartIndex = i
        break
      end
    end
  end
  if self._ui._txt_currTimeForDev:GetShow() == true then
    self._ui._txt_currTimeForDev:SetText(string.format("CurrTime : %.1f", self._curUpdateTime))
    self._ui._txt_currImagePercent:SetText(string.format("\237\152\132\236\158\172 \236\157\180\235\175\184\236\167\128 \236\167\132\237\150\137\235\165\160 : %d%%", percent * 100))
  end
end
function FromClient_ImageSlider_All_Resize()
  PaGlobal_ImageSlider_All:resize()
end
function FromClient_ImageSlider_All_StartImageSlide(fileName, imageSlideKey)
  PaGlobal_ImageSlider_All:prepareOpen(fileName, imageSlideKey)
end
function PaGlobalFunc_ImageCutScene_All_Open(fileName, imageSlideKey)
  PaGlobal_ImageSlider_All:prepareOpen(fileName, imageSlideKey)
end
function PaGlobalFunc_ImageCutScene_All_Close()
  PaGlobal_ImageSlider_All:prepareClose()
end
function PaGlobalFunc_ImageCutScene_All_UpdatePerFrame(deltaTime)
  PaGlobal_ImageSlider_All:updateImageSlider(deltaTime)
end
function PaGlobalFunc_ImageCutScene_All_LoadImageSlideData(fileName, imageSlideKey)
  ToClient_LoadImageSlideData(fileName, imageSlideKey)
end
