function PaGlobal_QuickTimeEvent_Manager_UpdatePerFrame(delta)
  if nil == PaGlobal_QuickTimeEvent_Manager then
    return
  end
  PaGlobal_QuickTimeEvent_Manager:UpdatePerFrame(delta)
end
function FromClient_OpenSequenceQuickTimeEvent(uiType)
  if nil == PaGlobal_QuickTimeEvent_Manager then
    return
  end
  if uiType >= PaGlobal_QuickTimeEvent_Manager.UITYPE.TYPE_NONE then
    _PA_ASSERT(false, "\235\147\177\235\161\157\235\144\152\236\167\128 \236\149\138\236\157\128 \237\128\181\237\131\128\236\158\132 \236\157\180\235\178\164\237\138\184 UI\236\158\133\235\139\136\235\139\164. \235\147\177\235\161\157\237\149\180\236\163\188\236\132\184\236\154\148")
    return
  end
  PaGlobal_QuickTimeEvent_Manager._currentUIType = uiType
  PaGlobal_QuickTimeEvent_Manager:prepareOpen()
end
function FromClient_StartSequenceQuickTimeEvent()
  if nil == PaGlobal_QuickTimeEvent_Manager then
    return
  end
  PaGlobal_QuickTimeEvent_Manager:StartQuickTimeEvent()
end
function FromClient_CloseSequenceQuickTimeEvent()
  if nil == PaGlobal_QuickTimeEvent_Manager then
    return
  end
  PaGlobal_QuickTimeEvent_Manager:prepareClose()
end
function FromClient_PushSequenceQuickTimeEventKeyEvent(keyEventType, keyCode, startTime, minTime, maxTime, posX, posY, count)
  if nil == PaGlobal_QuickTimeEvent_Manager then
    return
  end
  PaGlobal_QuickTimeEvent_Manager:PushKeyEvent(keyEventType, keyCode, startTime, minTime, maxTime, posX, posY, count)
end
