PaGlobalFunc_Sequence_LetterBox = {
  _ui = {
    _stc_top = UI.getChildControl(Panel_Sequence_LetterBox, "Static_LetterBoxTop"),
    _stc_bottom = UI.getChildControl(Panel_Sequence_LetterBox, "Static_LetterBoxBottom")
  },
  _animationType = {
    SHOW_BEGIN = 0,
    SHOW_ING = 1,
    SHOW_END = 2,
    HIDE_BEGIN = 3,
    HIDE_ING = 4,
    HIDE_END = 5
  },
  _currentSequenceEventId = nil,
  _isPause = false,
  _letterBoxMoveSpeed = 0,
  _accumulatedDelta = 0,
  _currentType = nil,
  _isInitialized = false
}
function PaGlobalFunc_Sequence_LetterBox:initialize()
  if Panel_Sequence_LetterBox == nil then
    return
  end
  if self._isInitialized == true then
    return
  end
  self:reset()
  self._isInitialized = true
end
function PaGlobalFunc_Sequence_LetterBox:prepareOpen(speed, eventId)
  if Panel_Sequence_LetterBox == nil then
    return
  end
  self._currentSequenceEventId = eventId
  self._letterBoxMoveSpeed = speed
  self._isPause = false
  self._currentType = self._animationType.SHOW_BEGIN
  self:open()
end
function PaGlobalFunc_Sequence_LetterBox:open()
  if Panel_Sequence_LetterBox == nil then
    return
  end
  Panel_Sequence_LetterBox:RegisterUpdateFunc("PaGlobalFunc_SequenceLetterBox_Update")
  Panel_Sequence_LetterBox:SetShow(true)
end
function PaGlobalFunc_Sequence_LetterBox:prepareClose(speed)
  if Panel_Sequence_LetterBox == nil then
    return
  end
  if Panel_Sequence_LetterBox:GetShow() == false then
    return
  end
  self._currentType = self._animationType.HIDE_BEGIN
  self._letterBoxMoveSpeed = speed
end
function PaGlobalFunc_Sequence_LetterBox:close()
  if Panel_Sequence_LetterBox == nil then
    return
  end
  self._isPause = false
  self._accumulatedDelta = 0
  self._letterBoxMoveSpeed = 0
  self._currentType = nil
  Panel_Sequence_LetterBox:ClearUpdateLuaFunc()
  Panel_Sequence_LetterBox:SetShow(false)
end
function PaGlobalFunc_Sequence_LetterBox:reset()
  if Panel_Sequence_LetterBox == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local resolutionScreenY = getResolutionSizeY()
  Panel_Sequence_LetterBox:SetPosX(0)
  Panel_Sequence_LetterBox:SetPosY(0)
  Panel_Sequence_LetterBox:SetSize(screenX, screenY)
  local latterHeight = (screenY - 0.5625 * screenX) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  local letterWidth = (screenX - 1.7777777777777777 * screenY) / 2
  if letterWidth < 0 then
    letterWidth = 0
  end
  local lateY = screenY / resolutionScreenY
  local latterBoxMinRate = 0.125
  local latterBoxMinSizeY = resolutionScreenY * latterBoxMinRate * lateY
  if latterHeight < latterBoxMinSizeY then
    latterHeight = latterBoxMinSizeY
  end
  self._ui._stc_top:SetSize(screenX, latterHeight)
  self._ui._stc_top:ComputePos()
  self._ui._stc_bottom:SetSize(screenX, latterHeight)
  self._ui._stc_bottom:ComputePos()
end
function PaGlobalFunc_Sequence_LetterBox:update(deltaTime)
  if Panel_Sequence_LetterBox == nil then
    return
  end
  if self._isPause == true then
    return
  end
  if self._currentType == self._animationType.SHOW_BEGIN then
    self:reset()
    self._accumulatedDelta = 0
    self._currentType = self._animationType.SHOW_ING
    self._ui._stc_top:SetSpanSize(0, -self._ui._stc_top:GetSizeY())
    self._ui._stc_top:ComputePos()
    self._ui._stc_bottom:SetSpanSize(0, -self._ui._stc_bottom:GetSizeY())
    self._ui._stc_bottom:ComputePos()
  elseif self._currentType == self._animationType.SHOW_ING then
    self._accumulatedDelta = self._accumulatedDelta + deltaTime
    local rate = self._accumulatedDelta / self._letterBoxMoveSpeed
    local top_goalPosY = self._ui._stc_top:GetSizeY()
    local top_calcPosY = top_goalPosY * rate
    local top_isEnd = false
    if top_goalPosY < top_calcPosY then
      top_calcPosY = top_goalPosY
      top_isEnd = true
    end
    self._ui._stc_top:SetSpanSize(0, top_calcPosY - self._ui._stc_top:GetSizeY())
    self._ui._stc_top:ComputePos()
    local bottom_goalPosY = self._ui._stc_bottom:GetSizeY()
    local bottom_calcPosY = bottom_goalPosY * rate
    local bottom_isEnd = false
    if bottom_goalPosY < bottom_calcPosY then
      bottom_calcPosY = bottom_goalPosY
      bottom_isEnd = true
    end
    self._ui._stc_bottom:SetSpanSize(0, bottom_calcPosY - self._ui._stc_bottom:GetSizeY())
    self._ui._stc_bottom:ComputePos()
    if top_isEnd == true and bottom_isEnd == true then
      self._currentType = self._animationType.SHOW_END
    end
  elseif self._currentType == self._animationType.SHOW_END then
  elseif self._currentType == self._animationType.HIDE_BEGIN then
    self:reset()
    self._accumulatedDelta = 0
    self._currentType = self._animationType.HIDE_ING
    self._ui._stc_top:SetSpanSize(0, 0)
    self._ui._stc_top:ComputePos()
    self._ui._stc_bottom:SetSpanSize(0, 0)
    self._ui._stc_bottom:ComputePos()
  elseif self._currentType == self._animationType.HIDE_ING then
    self._accumulatedDelta = self._accumulatedDelta + deltaTime
    local rate = self._accumulatedDelta / self._letterBoxMoveSpeed
    local top_goalPosY = -self._ui._stc_top:GetSizeY()
    local top_calcPosY = top_goalPosY * rate
    local top_isEnd = false
    if top_goalPosY > top_calcPosY then
      top_calcPosY = top_goalPosY
      top_isEnd = true
    end
    self._ui._stc_top:SetSpanSize(0, top_calcPosY)
    self._ui._stc_top:ComputePos()
    local bottom_goalPosY = -self._ui._stc_bottom:GetSizeY()
    local bottom_calcPosY = bottom_goalPosY * rate
    local bottom_isEnd = false
    if bottom_goalPosY > bottom_calcPosY then
      bottom_calcPosY = bottom_goalPosY
      bottom_isEnd = true
    end
    self._ui._stc_bottom:SetSpanSize(0, bottom_calcPosY)
    self._ui._stc_bottom:ComputePos()
    if top_isEnd == true and bottom_isEnd == true then
      self._currentType = self._animationType.HIDE_END
    end
  elseif self._currentType == self._animationType.HIDE_END then
    self:close()
  end
end
function PaGlobalFunc_Sequence_LetterBox:forceMoveDelta(eventId, isHideAnimation, deltaTime, speed)
  if Panel_Sequence_LetterBox == nil then
    return
  end
  if self._currentSequenceEventId ~= eventId then
    return
  end
  if Panel_Sequence_LetterBox:GetShow() == false then
    self:prepareOpen(speed, eventId)
  end
  local cached_isPause = self._isPause
  self._isPause = false
  self._accumulatedDelta = deltaTime
  self._letterBoxMoveSpeed = speed
  if isHideAnimation == true then
    self._currentType = self._animationType.HIDE_ING
  else
    self._currentType = self._animationType.SHOW_ING
  end
  self:update(0)
  if self._currentType == self._animationType.HIDE_END then
    self:update(0)
  end
  self._isPause = cached_isPause
end
function SequenceLetterBox_OnScreenResize()
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil then
    return
  end
  self:reset()
end
function FromClient_SequenceLetterBoxShow(isOn, speed, eventId)
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil then
    return
  end
  if isOn == true then
    self:prepareOpen(speed, eventId)
  else
    self:prepareClose(speed)
  end
end
function FromClient_SequenceLetterBoxMoveFrame(eventId, isHideAnimation, deltaTime, speed)
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil then
    return
  end
  self:forceMoveDelta(eventId, isHideAnimation, deltaTime, speed)
end
function PaGlobalFunc_SequenceLetterBox_Update(deltaTime)
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil then
    return
  end
  if self._isPause == true then
    return
  end
  self:update(deltaTime)
end
function FromClient_SequenceLetterBoxOnClickedSequenceTogglePauseResume(isPause)
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil or isPause == nil then
    return
  end
  self._isPause = isPause
end
function PaGlobalFunc_SequenceLetterBox_Close()
  local self = PaGlobalFunc_Sequence_LetterBox
  if self == nil then
    return
  end
  self:close()
end
Panel_Sequence_LetterBox:SetShow(false)
Panel_Sequence_LetterBox:SetFadeOverRender()
PaGlobalFunc_Sequence_LetterBox:initialize()
registerEvent("onScreenResize", "SequenceLetterBox_OnScreenResize")
registerEvent("FromClient_SequenceLetterBoxShow", "FromClient_SequenceLetterBoxShow")
registerEvent("FromClient_SequenceLetterBoxMoveFrame", "FromClient_SequenceLetterBoxMoveFrame")
registerEvent("FromClient_OnClickedSequenceTogglePauseResume", "FromClient_SequenceLetterBoxOnClickedSequenceTogglePauseResume")
registerEvent("FromClient_OnClickedSequenceStopButton", "PaGlobalFunc_SequenceLetterBox_Close")
registerEvent("FromClient_SelectSequence_Ocean", "PaGlobalFunc_SequenceLetterBox_Close")
registerEvent("FromClient_CloseSequenceEditorUI_Ocean", "PaGlobalFunc_SequenceLetterBox_Close")
registerEvent("FromClient_StopSequence", "PaGlobalFunc_SequenceLetterBox_Close")
registerEvent("FromClient_StopSequence_Ocean", "PaGlobalFunc_SequenceLetterBox_Close")
