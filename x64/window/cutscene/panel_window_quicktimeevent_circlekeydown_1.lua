function PaGlobal_QuickTimeEvent_CircleKeyDown:initialize()
  if true == PaGlobal_QuickTimeEvent_CircleKeyDown._initialize then
    return
  end
  if self._MANAGER == nil then
    _PA_ASSERT(false, "\237\128\181 \237\131\128\236\158\132 \236\157\180\235\178\164\237\138\184 \235\167\164\235\139\136\236\160\128\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. Initialize \236\136\156\236\132\156\234\176\128 \235\176\148\235\128\140\236\167\128 \236\149\138\236\149\152\235\138\148\236\167\128 \237\153\149\236\157\184 \235\176\148\235\158\141\235\139\136\235\139\164.")
    return
  end
  self._ui.stc_CircleBig = UI.getChildControl(Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_Circle_Big")
  self._ui.stc_CircleSmall = UI.getChildControl(Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_Circle_small")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_KeyGuide")
  self._ui.stc_keyGuideBtn = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Btn_Type0")
  self._ui.stc_success = UI.getChildControl(Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_Success")
  self._ui.stc_fail = UI.getChildControl(Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_Fail")
  self._ui.stc_CircleBig:SetShow(false)
  self._ui.stc_CircleSmall:SetShow(false)
  self._ui.stc_keyGuideBG:SetShow(false)
  self._ui.stc_keyGuideBtn:SetShow(false)
  self._ui.stc_success:SetShow(false)
  self._ui.stc_fail:SetShow(false)
  self._MANAGER._timeAccum = 0
  self._sizeScale = 1000
  self._maxSize = self._ui.stc_CircleBig:GetSizeY()
  self._minSize = self._ui.stc_CircleSmall:GetSizeY()
  self._minRatio = self._minSize / self._maxSize
  self._timeSize = self._ui.stc_CircleBig:GetSizeY() - self._ui.stc_CircleSmall:GetSizeY()
  self._timeStepSize = self._maxSize / self._sizeScale
  for ii = 0, self.MAX_CONTROL_COUNT do
    if self._keyEventControlList[ii] == nil then
      self._keyEventControlList[ii] = {}
      self._keyEventControlList[ii]._keyGuideControl = UI.cloneControl(self._ui.stc_keyGuideBG, Panel_Window_QuickTimeEvent_CircleKeyDown, "Static_Circle_KeyGuideBG_" .. ii)
      self._keyEventControlList[ii]._bigCircleControl = UI.cloneControl(self._ui.stc_CircleBig, self._keyEventControlList[ii]._keyGuideControl, "Static_Circle_Big_" .. ii)
      self._keyEventControlList[ii]._smallCircleControl = UI.cloneControl(self._ui.stc_CircleSmall, self._keyEventControlList[ii]._keyGuideControl, "Static_Circle_Small_" .. ii)
      self._keyEventControlList[ii]._keyGuideBtnControl = UI.cloneControl(self._ui.stc_keyGuideBtn, self._keyEventControlList[ii]._keyGuideControl, "Static_Circle_KeyGuideBtn_" .. ii)
      self._keyEventControlList[ii]._successControl = UI.cloneControl(self._ui.stc_success, self._keyEventControlList[ii]._keyGuideControl, "Static_Success_" .. ii)
      self._keyEventControlList[ii]._failControl = UI.cloneControl(self._ui.stc_fail, self._keyEventControlList[ii]._keyGuideControl, "Static_Fail_" .. ii)
    end
  end
  self:registEventHandler()
  self:validate()
  self:resetKeyEventControl()
  self._initialize = true
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:registEventHandler()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:prepareOpen()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  if self._MANAGER == nil then
    _PA_ASSERT(false, "\237\128\181 \237\131\128\236\158\132 \236\157\180\235\178\164\237\138\184 \235\167\164\235\139\136\236\160\128\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184 \237\149\132\236\154\148!")
    return
  end
  PaGlobal_QuickTimeEvent_CircleKeyDown:resetKeyEventControl()
  PaGlobal_QuickTimeEvent_CircleKeyDown:open()
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:open()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  Panel_Window_QuickTimeEvent_CircleKeyDown:SetShow(true)
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:prepareClose()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  PaGlobal_QuickTimeEvent_CircleKeyDown:close()
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:close()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  Panel_Window_QuickTimeEvent_CircleKeyDown:ClearUpdateLuaFunc()
  PaGlobal_QuickTimeEvent_CircleKeyDown:resetKeyEventControl()
  Panel_Window_QuickTimeEvent_CircleKeyDown:SetShow(false)
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:validate()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  PaGlobal_QuickTimeEvent_CircleKeyDown._ui.stc_CircleBig:isValidate()
  PaGlobal_QuickTimeEvent_CircleKeyDown._ui.stc_CircleSmall:isValidate()
  PaGlobal_QuickTimeEvent_CircleKeyDown._ui.stc_keyGuideBG:isValidate()
  PaGlobal_QuickTimeEvent_CircleKeyDown._ui.stc_keyGuideBtn:isValidate()
  for ii = 0, self.MAX_CONTROL_COUNT do
    if self._keyEventControlList[ii] ~= nil then
      for key, control in pairs(self._keyEventControlList[ii]) do
        if control ~= nil then
          control:isValidate()
        end
      end
    end
  end
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame(delta)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  local VCK = CppEnums.VirtualKeyCode
  self:UpdatePerFrame_UpdateKeyState()
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_UpdateKeyState()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  for ii = 0, #self._MANAGER._keyEventList do
    if nil ~= self._MANAGER._keyEventList[ii] then
      if self._MANAGER._keyEventList[ii]._state == self._MANAGER.KEYEVENTSTATE.NONE then
        self:UpdatePerFrame_KeyStateNone(ii)
      elseif self._MANAGER._keyEventList[ii]._state == self._MANAGER.KEYEVENTSTATE.PROCESSING then
        self:UpdatePerFrame_KeyStateProcessing(ii)
      end
    end
  end
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_KeyStateNone(idx)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  if nil == self._MANAGER._keyEventList[idx] then
    return
  end
  if self._MANAGER._keyEventList[idx]._state ~= self._MANAGER.KEYEVENTSTATE.NONE then
    return
  end
  if self._MANAGER._timeAccum <= self._MANAGER._keyEventList[idx]._startTime then
    return
  end
  self:setShowKeyEventControl(idx, self._MANAGER._keyEventList[idx]._keyCode, self._MANAGER._keyEventList[idx]._posX, self._MANAGER._keyEventList[idx]._posY)
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_KeyStateProcessing(idx)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  if nil == self._MANAGER._keyEventList[idx] then
    return
  end
  if self._MANAGER._keyEventList[idx]._state ~= self._MANAGER.KEYEVENTSTATE.PROCESSING then
    return
  end
  local ratioTime = 1 - self._MANAGER._timeAccum / self._MANAGER._keyEventList[idx]._maxTime
  local newSize = self._maxSize * ratioTime
  if ratioTime <= self._minRatio and true == isKeyDown_Once(self._MANAGER._keyEventList[idx]._keyCode) then
    self._MANAGER._keyEventList[idx]._state = self._MANAGER.KEYEVENTSTATE.SUCCESS
    self:setKeyEventControl(idx, true)
  end
  if self._MANAGER._timeAccum + 0.1 >= self._MANAGER._keyEventList[idx]._maxTime then
    self._MANAGER._keyEventList[idx]._state = self._MANAGER.KEYEVENTSTATE.FAIL
    self:setKeyEventControl(idx, false)
  end
  local controlList = self._keyEventControlList[idx]
  controlList._bigCircleControl:SetSize(newSize, newSize)
  local smallPosX = controlList._smallCircleControl:GetPosX()
  local smallPosY = controlList._smallCircleControl:GetPosY()
  local smallSizeX = controlList._smallCircleControl:GetSizeX()
  local smallSizeY = controlList._smallCircleControl:GetSizeY()
  local middleX = smallPosX + smallSizeX / 2
  local middleY = smallPosY + smallSizeY / 2
  local newPosX = middleX - newSize / 2
  local newPosY = middleY - newSize / 2
  controlList._bigCircleControl:SetPosXY(newPosX, newPosY)
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_CheckSuccess()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return false
  end
  for ii = 0, #self._MANAGER._keyEventList do
    if nil ~= self._MANAGER._keyEventList[ii] and self._MANAGER._keyEventList[ii]._state ~= self._MANAGER.KEYEVENTSTATE.SUCCESS then
      return false
    end
  end
  return true
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_CheckFail()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return false
  end
  for ii = 0, #self._MANAGER._keyEventList do
    if nil ~= self._MANAGER._keyEventList[ii] and self._MANAGER._keyEventList[ii]._state == self._MANAGER.KEYEVENTSTATE.FAIL then
      return true
    end
  end
  return false
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:UpdatePerFrame_ExcuteResult(isSuccess)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return false
  end
  if isSuccess == true then
    ToClient_SetSequenceInputActionState(1)
  elseif isSuccess == false then
    ToClient_SetSequenceInputActionState(2)
  end
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:setShowKeyEventControl(idx, keyCode, posX, posY)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  if self._keyEventControlList[idx] == nil then
    return
  end
  if self._MANAGER._keyString[keyCode] == nil then
    return
  end
  self._MANAGER._keyEventList[idx]._state = self._MANAGER.KEYEVENTSTATE.PROCESSING
  self._keyEventControlList[idx]._keyGuideControl:SetShow(true)
  self._keyEventControlList[idx]._bigCircleControl:SetShow(true)
  self._keyEventControlList[idx]._smallCircleControl:SetShow(true)
  self._keyEventControlList[idx]._keyGuideBtnControl:SetShow(true)
  self._keyEventControlList[idx]._keyGuideControl:SetPosXY(posX, posY)
  self._keyEventControlList[idx]._keyGuideBtnControl:SetText(self._MANAGER._keyString[keyCode])
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:resetKeyEventControl()
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  for ii = 0, self.MAX_CONTROL_COUNT do
    if self._keyEventControlList[ii] ~= nil then
      for key, control in pairs(self._keyEventControlList[ii]) do
        if control ~= nil then
          control:SetShow(false)
        end
      end
    end
  end
end
function PaGlobal_QuickTimeEvent_CircleKeyDown:setKeyEventControl(idx, isSuccess)
  if nil == Panel_Window_QuickTimeEvent_CircleKeyDown then
    return
  end
  if self._keyEventControlList[idx] == nil then
    return
  end
  for key, control in pairs(self._keyEventControlList[idx]) do
    if control ~= nil then
      control:SetShow(false)
    end
  end
  self._keyEventControlList[idx]._keyGuideControl:SetShow(true)
  if isSuccess == true then
    self._keyEventControlList[idx]._successControl:SetShow(true)
    self._keyEventControlList[idx]._successControl:SetAlpha(1)
    local ani1 = UIAni.AlphaAnimation(0, self._keyEventControlList[idx]._successControl, 0, 0.3)
    ani1:SetHideAtEnd(true)
  else
    self._keyEventControlList[idx]._failControl:SetShow(true)
    self._keyEventControlList[idx]._failControl:SetAlpha(1)
    local ani1 = UIAni.AlphaAnimation(0, self._keyEventControlList[idx]._failControl, 0, 0.3)
    ani1:SetHideAtEnd(true)
  end
end
