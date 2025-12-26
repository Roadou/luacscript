function PaGlobal_FadeOut:initialize()
  if true == self._initialize then
    return
  end
  self._ui._loadingText = UI.getChildControl(Common_FadeOut, "StaticText_LoadingEffect")
  self._ui._loadingText:EraseAllEffect()
  self._loadingTextEffectName = "UI_Loading_01A"
  if true == _ContetnsGroup_ChangeLoadingImg then
    self._ui.temp_img1 = UI.getChildControl(Common_FadeOut, "Static_Img1")
  end
  self._ui._staticText_Desc = UI.getChildControl(Common_FadeOut, "StaticText_Desc")
  self:registEventHandler()
  self:validate()
  self:initBackGroundImage()
  self._initialize = true
end
function PaGlobal_FadeOut:registEventHandler()
  Common_FadeOut:RegisterShowEventFunc(true, "PaGlobal_FadeOutShowAni()")
  registerEvent("onScreenResize", "PaGlobal_FadeOutResize")
  registerEvent("FromClinet_FadeOut", "PaGlobal_FadeOutOpen")
  registerEvent("FromClient_CloseBattleRoyaleEnterLoading", "PaGlobal_FadeOutClose")
end
function PaGlobal_FadeOut:initBackGroundImageForException()
  self._bgImageTexture = {
    [0] = "Combine/Loading/Abyss_One/Abyss_One_Exit.dds"
  }
  self._totalImageCount = 1
end
function PaGlobal_FadeOut:initBackGroundImage()
  if nil == Common_FadeOut then
    return
  end
  if false == _ContetnsGroup_ChangeLoadingImg then
    return
  end
  local tempImagePath = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Image)
  if tempImagePath ~= nil then
    self._bgImageTexture = {
      [0] = tempImagePath
    }
    self._totalImageCount = 1
  else
    self:initBackGroundImageForException()
  end
  self._bgEmptyControl = {}
  for idx = 0, self._totalImageCount - 1 do
    local emptyControl = UI.createAndCopyBasePropertyControl(Common_FadeOut, "Static_Img1", Common_FadeOut, "Static_FadeBg_" .. tostring(idx))
    emptyControl:SetHorizonCenter()
    emptyControl:SetVerticalMiddle()
    emptyControl:ChangeTextureInfoNameAsync(self._bgImageTexture[idx])
    local x1, y1, x2, y2 = setTextureUV_Func(emptyControl, 0, 0, 1920, 1080)
    emptyControl:getBaseTexture():setUV(x1, y1, x2, y2)
    emptyControl:setRenderTexture(emptyControl:getBaseTexture())
    self._bgEmptyControl[idx] = emptyControl
  end
  Common_FadeOut:SetChildIndex(self._ui._loadingText, 9999)
end
function PaGlobal_Common_FadeOutUpdate(deltaTime)
  if PaGlobal_FadeOut._fadeDuration < PaGlobal_FadeOut._fadeDruationMaxTime then
    PaGlobal_FadeOut._fadeDuration = PaGlobal_FadeOut._fadeDuration + deltaTime
    PaGlobal_FadeOut:FadeLoadingImagePerFrame(deltaTime)
    return
  end
  PaGlobal_FadeOutEscapeClose()
end
function PaGlobal_FadeOut:showAni()
  if nil == Common_FadeOut then
    return
  end
  local showAni = Common_FadeOut:addColorAnimation(0, self._ANIMATION_TIME, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartColor(Defines.Color.C_00000000)
  showAni:SetEndColor(Defines.Color.C_FF000000)
  showAni:SetStartIntensity(3)
  showAni:SetEndIntensity(1)
  showAni.IsChangeChild = false
end
function PaGlobal_FadeOut:hideAni()
  if nil == Common_FadeOut then
    return
  end
  local closeAni = Common_FadeOut:addColorAnimation(0, self._ANIMATION_TIME, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_00000000)
  closeAni:SetEndColor(Defines.Color.C_FF000000)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = false
  closeAni:SetHideAtEnd(true)
end
function PaGlobal_FadeOut:resize()
  if nil == Common_FadeOut then
    return
  end
  if false == self._initialize then
    return
  end
  Common_FadeOut:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._loadingText:ComputePos()
  self._ui._loadingText:SetPosX(getScreenSizeX() / 2 - (self._ui._loadingText:GetTextSpan().x + self._ui._loadingText:GetTextSizeX()) / 2)
end
function PaGlobal_FadeOut:open()
  if nil == Common_FadeOut then
    return
  end
  self:resize()
  self._ui._loadingText:SetShow(true)
  self._ui._loadingText:EraseAllEffect()
  self._ui._loadingText:AddEffect(self._loadingTextEffectName, true, 0, 0)
  Common_FadeOut:SetShow(true, true)
  local uiScale = ToClient_GetUIScale()
  local scrX = getResolutionSizeX()
  local scrY = getResolutionSizeY()
  scrX = scrX / uiScale
  scrY = scrY / uiScale
  local movieSizeX = scrX
  local movieSizeY = scrX * 9 / 16
  local posX = 0
  local posY = 0
  if scrY >= movieSizeY then
    posY = (scrY - movieSizeY) / 2
  else
    movieSizeX = scrY * 16 / 9
    movieSizeY = scrY
    posX = (scrX - movieSizeX) / 2
  end
  if true == _ContetnsGroup_ChangeLoadingImg then
    for idx = 0, self._totalImageCount - 1 do
      if nil ~= self._bgEmptyControl[idx] then
        self._bgEmptyControl[idx]:SetShow(false)
        self._bgEmptyControl[idx]:SetColor(Defines.Color.C_00FFFFFF)
        self._bgEmptyControl[idx]:SetSize(movieSizeX, movieSizeY)
        self._bgEmptyControl[idx]:ComputePos()
      end
      self._currentFadeTIme = 0
      self._isFadeProcessing = false
      self._isImageFadeOut = false
    end
  end
  Common_FadeOut:RegisterUpdateFunc("PaGlobal_Common_FadeOutUpdate")
end
function PaGlobal_FadeOut:close()
  if nil == Common_FadeOut then
    return
  end
  if true == Common_FadeOut:GetShow() then
    Common_FadeOut:SetShow(false, true)
    self._ui._loadingText:SetShow(false)
    self._ui._loadingText:EraseAllEffect()
    self._fadeDuration = 0
    Common_FadeOut:ClearUpdateLuaFunc()
  end
end
function PaGlobal_FadeOut:validate()
  self._ui._loadingText:isValidate()
end
function PaGlobal_FadeOut:FadeLoadingImagePerFrame(deltaTime)
  if false == _ContetnsGroup_ChangeLoadingImg or false == Common_FadeOut:GetShow() then
    return
  end
  if nil == self._bgImageTexture or nil == self._bgEmptyControl then
    return
  end
  if false == self._isImageFadeOut then
    local randomIdx = 0
    if 1 < self._totalImageCount then
      randomIdx = math.random(0, self._totalImageCount - 1)
    end
    self._currentImageIdx = randomIdx
    if nil ~= self._bgEmptyControl[self._currentImageIdx] then
      self._isImageFadeOut = true
      self._isFadeProcessing = false
      self._bgEmptyControl[self._currentImageIdx]:SetShow(true)
      local showAni = self._bgEmptyControl[self._currentImageIdx]:addColorAnimation(0, self._imageFadeTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      showAni:SetStartColor(Defines.Color.C_00FFFFFF)
      showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
      showAni:SetStartIntensity(1)
      showAni:SetEndIntensity(1)
      self._currentFadeTIme = 0
      local temporaryWrapper = getTemporaryInformationWrapper()
      if temporaryWrapper ~= nil then
        local bgSizeX = self._bgEmptyControl[self._currentImageIdx]:GetSizeX()
        local bgSizeY = self._bgEmptyControl[self._currentImageIdx]:GetSizeY()
        local textPosX = self._ui._loadingText:GetPosX()
        local textPosY = self._ui._loadingText:GetPosY()
        local loadingText = self._ui._loadingText:GetText()
        temporaryWrapper:updateFadeOutSceneInfo(bgSizeX, bgSizeY, textPosX, textPosY, loadingText, self._loadingTextEffectName, self._bgImageTexture[self._currentImageIdx])
      end
    end
  elseif nil ~= self._bgEmptyControl[self._currentImageIdx] then
    self._currentFadeTIme = self._currentFadeTIme + deltaTime
    if self._imageFadeTime * 2 < self._currentFadeTIme and false == self._isFadeProcessing then
      self._isFadeProcessing = true
      local offAni = self._bgEmptyControl[self._currentImageIdx]:addColorAnimation(0, self._imageFadeTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      offAni:SetStartColor(Defines.Color.C_FFFFFFFF)
      offAni:SetEndColor(Defines.Color.C_00FFFFFF)
      offAni:SetStartIntensity(1)
      offAni:SetEndIntensity(1)
      offAni:SetHideAtEnd(true)
    elseif self._imageFadeTime * 2 + 1 < self._currentFadeTIme then
      self._isImageFadeOut = false
    end
  else
    self._isFadeProcessing = false
  end
end
