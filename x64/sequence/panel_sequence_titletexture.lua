PaGlobalFunc_Sequence_TitleTexture = {
  _ui = {
    _stc_backGround = UI.getChildControl(Panel_Sequence_TitleTexture, "Static_BackGround"),
    _stc_image = UI.getChildControl(Panel_Sequence_TitleTexture, "Static_Image")
  },
  _fadeTimeSec = 0,
  _isInitialized = false
}
function PaGlobalFunc_Sequence_TitleTexture:initialize()
  if Panel_Sequence_TitleTexture == nil then
    return
  end
  if self._isInitialized == true then
    return
  end
  self._isInitialized = true
end
function PaGlobalFunc_Sequence_TitleTexture:open(fadeTime, posRateX, posRateY, texturePath, isUseBackGroundTexture, isFillScreenSize)
  if Panel_Sequence_TitleTexture == nil then
    return
  end
  if fadeTime == nil or posRateX == nil or posRateY == nil or texturePath == nil or isUseBackGroundTexture == nil or isFillScreenSize == nil then
    return
  end
  self._fadeTimeSec = fadeTime
  self:computePanelSize()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  if isFillScreenSize == true then
    self._ui._stc_image:ChangeTextureInfoNameAsync(texturePath, 0)
    self._ui._stc_image:setRenderTexture(self._ui._stc_image:getBaseTexture())
    self._ui._stc_image:SetSize(screenX, screenY)
    self._ui._stc_image:SetPosX(0)
    self._ui._stc_image:SetPosY(0)
  else
    local rateX = posRateX / 100
    local rateY = posRateY / 100
    local posX = screenX * rateX
    local posY = screenY * rateY
    self._ui._stc_image:ChangeTextureInfoAndSize(texturePath, 0, true)
    self._ui._stc_image:setRenderTexture(self._ui._stc_image:getBaseTexture())
    posX = posX - self._ui._stc_image:GetSizeX() / 2
    posY = posY - self._ui._stc_image:GetSizeY() / 2
    self._ui._stc_image:SetPosX(posX)
    self._ui._stc_image:SetPosY(posY)
  end
  self._ui._stc_image:SetShow(true)
  self._ui._stc_backGround:SetSize(screenX, screenY)
  self._ui._stc_backGround:ComputePos()
  self._ui._stc_backGround:SetShow(isUseBackGroundTexture)
  Panel_Sequence_TitleTexture:SetAlpha(0)
  Panel_Sequence_TitleTexture:SetShow(true)
  UIAni.AlphaAnimation(1, Panel_Sequence_TitleTexture, 0, self._fadeTimeSec)
end
function PaGlobalFunc_Sequence_TitleTexture:close_ani()
  if Panel_Sequence_TitleTexture == nil then
    return
  end
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Sequence_TitleTexture, 0, self._fadeTimeSec)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobalFunc_Sequence_TitleTexture:close()
  if Panel_Sequence_TitleTexture == nil then
    return
  end
  Panel_Sequence_TitleTexture:SetAlpha(1)
  Panel_Sequence_TitleTexture:SetShow(false)
end
function PaGlobalFunc_Sequence_TitleTexture:computePanelSize()
  if Panel_Sequence_TitleTexture == nil then
    return
  end
  Panel_Sequence_TitleTexture:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Sequence_TitleTexture:ComputePosAllChild()
end
function PaGlobalFunc_SequenceTitleTexture_Close_Ani()
  local self = PaGlobalFunc_Sequence_TitleTexture
  if self == nil then
    return
  end
  self:close_ani()
end
function PaGlobalFunc_SequenceTitleTexture_Close()
  local self = PaGlobalFunc_Sequence_TitleTexture
  if self == nil then
    return
  end
  self:close()
end
function FromClient_ShowSequenceTitleTexture(fadeTime, posRateX, posRateY, texturePath, isUseBackGroundTexture, isFillScreenSize)
  local self = PaGlobalFunc_Sequence_TitleTexture
  if self == nil then
    return
  end
  self:open(fadeTime, posRateX, posRateY, texturePath, isUseBackGroundTexture, isFillScreenSize)
end
Panel_Sequence_TitleTexture:SetShow(false)
PaGlobalFunc_Sequence_TitleTexture:initialize()
registerEvent("FromClient_ShowSequenceTitleTexture", "FromClient_ShowSequenceTitleTexture")
registerEvent("FromClient_HideSequenceTitleTexture", "PaGlobalFunc_SequenceTitleTexture_Close_Ani")
registerEvent("FromClient_CloseSequenceEditorUI_Ocean", "PaGlobalFunc_SequenceTitleTexture_Close")
registerEvent("FromClient_StopSequence", "PaGlobalFunc_SequenceTitleTexture_Close")
registerEvent("FromClient_StopSequence_Ocean", "PaGlobalFunc_SequenceTitleTexture_Close")
registerEvent("FromClient_SelectSequence_Ocean", "PaGlobalFunc_SequenceTitleTexture_Close")
