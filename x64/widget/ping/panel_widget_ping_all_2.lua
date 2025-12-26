function PaGlobal_Ping_All_Open(isDelayOpen)
  if nil == Panel_Widget_Ping_All then
    return
  end
  PaGlobal_Ping_All._isDelayOpen = isDelayOpen
  PaGlobal_Ping_All:prepareOpen(isDelayOpen)
end
function PaGlobal_Ping_All_Close()
  if nil == Panel_Widget_Ping_All then
    return
  end
  PaGlobal_Ping_All:prepareClose()
end
function PaGlobal_Ping_All_SetPingType(pingType)
  PaGlobal_Ping_All:setPingType(pingType)
end
function PaGlobal_Ping_All_SavePingType(pingType)
  if nil ~= pingType then
    PaGlobal_Ping_All:setPingType(pingType)
  end
  PaGlobal_Ping_All:savePingType()
  PaGlobal_Ping_All:prepareClose()
end
function PaGlobal_Ping_All_Update(deltaTime)
  PaGlobal_Ping_All:updatePingType(deltaTime)
end
function PaGlobal_Ping_All_UpdatePressKey(deltaTime)
  PaGlobal_Ping_All:updatePressKey(deltaTime)
end
function FromClient_Ping_All_ResizePanel()
  if nil == Panel_Widget_Ping_All then
    return
  end
  Panel_Widget_Ping_All:ComputePosAllChild()
  PaGlobal_Ping_All._uiScale = ToClient_getGameOptionControllerWrapper():getUIScale()
  PaGlobal_Ping_All._centerPos.x = getScreenSizeX() / 2 * PaGlobal_Ping_All._uiScale
  PaGlobal_Ping_All._centerPos.y = getScreenSizeY() / 2 * PaGlobal_Ping_All._uiScale
end
