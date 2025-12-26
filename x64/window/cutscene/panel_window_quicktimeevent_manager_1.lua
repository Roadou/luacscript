function PaGlobal_QuickTimeEvent_Manager:initialize()
  self._panelList[self.UITYPE.TYPE_CIRCLE] = Panel_Window_QuickTimeEvent_CircleKeyDown
  self._luaList[self.UITYPE.TYPE_CIRCLE] = PaGlobal_QuickTimeEvent_CircleKeyDown
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_QuickTimeEvent_Manager:registEventHandler()
  registerEvent("FromClient_PushSequenceQuickTimeEventKeyEvent", "FromClient_PushSequenceQuickTimeEventKeyEvent")
  registerEvent("FromClient_OpenSequenceQuickTimeEvent", "FromClient_OpenSequenceQuickTimeEvent")
  registerEvent("FromClient_CloseSequenceQuickTimeEvent", "FromClient_CloseSequenceQuickTimeEvent")
  registerEvent("FromClient_StartSequenceQuickTimeEvent", "FromClient_StartSequenceQuickTimeEvent")
end
function PaGlobal_QuickTimeEvent_Manager:prepareOpen()
  self._panelList[self.UITYPE.TYPE_CIRCLE] = Panel_Window_QuickTimeEvent_CircleKeyDown
  self._luaList[self.UITYPE.TYPE_CIRCLE] = PaGlobal_QuickTimeEvent_CircleKeyDown
  if nil == self._luaList[self._currentUIType] then
    return
  end
  self._keyEventList = {}
  self._timeAccum = 0
  self._luaList[self._currentUIType]:prepareOpen()
end
function PaGlobal_QuickTimeEvent_Manager:prepareClose()
  if nil == self._luaList[self._currentUIType] then
    return
  end
  if nil == self._panelList[self._currentUIType] then
    return
  end
  self._keyEventList = {}
  self._panelList[self._currentUIType]:ClearUpdateLuaFunc()
  self._luaList[self._currentUIType]:prepareClose()
end
function PaGlobal_QuickTimeEvent_Manager:UpdatePerFrame(delta)
  if nil == self._luaList[self._currentUIType] then
    return
  end
  self._timeAccum = self._timeAccum + delta
  self._luaList[self._currentUIType]:UpdatePerFrame(delta)
  if true == self._luaList[self._currentUIType]:UpdatePerFrame_CheckFail() then
    self._luaList[self._currentUIType]:UpdatePerFrame_ExcuteResult(false)
  elseif true == self._luaList[self._currentUIType]:UpdatePerFrame_CheckSuccess() then
    self._luaList[self._currentUIType]:UpdatePerFrame_ExcuteResult(true)
  end
end
function PaGlobal_QuickTimeEvent_Manager:StartQuickTimeEvent()
  if nil == self._panelList[self._currentUIType] then
    return
  end
  if nil == self._luaList[self._currentUIType] then
    return
  end
  self._panelList[self._currentUIType]:RegisterUpdateFunc("PaGlobal_QuickTimeEvent_Manager_UpdatePerFrame")
end
function PaGlobal_QuickTimeEvent_Manager:PushKeyEvent(keyEventType, keyCode, startTime, minTime, maxTime, posX, posY, count)
  keyEvent = {}
  keyEvent._keyEventType = keyEventType
  keyEvent._keyCode = keyCode
  keyEvent._minTime = minTime
  keyEvent._maxTime = maxTime
  keyEvent._startTime = startTime
  keyEvent._posX = posX
  keyEvent._posY = posY
  keyEvent._count = count
  keyEvent._state = self.KEYEVENTSTATE.NONE
  table.insert(self._keyEventList, keyEvent)
end
