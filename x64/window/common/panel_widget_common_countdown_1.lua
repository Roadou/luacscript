function PaGlobal_Common_CountDown:initialize()
  if self._initialize == true or Panel_Widget_Common_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_Common_Countdown, "Static_Count" .. tostring(idx))
    self._ui._stc_countDown:push_back(control)
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Common_CountDown:registEventHandler()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  registerEvent("onScreenResize", "PaGlobal_Common_CountDown_Resize")
  registerEvent("FromClient_SetSnowBoardStartStateTick", "PaGlobal_Common_CountDown_FromSnowBoard")
end
function PaGlobal_Common_CountDown:prepareOpen(maxCount, getRemainTimeFunc, isCountDownEndFunc)
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  if self._getRemainTimeFunc ~= nil then
    return
  end
  if getRemainTimeFunc == nil or isCountDownEndFunc == nil then
    return
  end
  Panel_Widget_Common_Countdown:ComputePosAllChild()
  self:countDownInit(maxCount, getRemainTimeFunc, isCountDownEndFunc)
  self:open()
end
function PaGlobal_Common_CountDown:open()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  Panel_Widget_Common_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Common_Countdown:ComputePosAllChild()
  Panel_Widget_Common_Countdown:RegisterUpdateFunc("PaGlobal_Common_CountDown_UpdatePerFrame")
  Panel_Widget_Common_Countdown:SetShow(true)
end
function PaGlobal_Common_CountDown:prepareClose()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  self:close()
end
function PaGlobal_Common_CountDown:close()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  Panel_Widget_Common_Countdown:ClearUpdateLuaFunc()
  Panel_Widget_Common_Countdown:SetShow(false)
  self._getRemainTimeFunc = nil
  self._isCountDownEndFunc = nil
end
function PaGlobal_Common_CountDown:countDownInit(maxCount, getRemainTimeFunc, isCountDownEndFunc)
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    if self._ui._stc_countDown[idx] ~= nil then
      self._ui._stc_countDown[idx]:SetShow(false)
    end
  end
  self._getRemainTimeFunc = getRemainTimeFunc
  self._isCountDownEndFunc = isCountDownEndFunc
  self._maxCountDown = math.min(maxCount, 10)
  self._remainTimeSecond = 0
end
function PaGlobal_Common_CountDown:countDownOpen()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  Panel_Widget_Common_Countdown:SetShow(true)
end
function PaGlobal_Common_CountDown:showCountDown(time)
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  if self._ui._stc_countDown[time + 1] == nil or self._ui._stc_countDown[time] == nil then
    return
  end
  local hideControl = self._ui._stc_countDown[time + 1]
  local showControl = self._ui._stc_countDown[time]
  if hideControl ~= nil then
    hideControl:setUpdateTextureAni(true)
    hideControl:SetShow(false)
  end
  if showControl ~= nil then
    showControl:setUpdateTextureAni(true)
    showControl:SetShow(true)
  end
  if time ~= 1 then
    if time == 5 or time == 6 then
      audioPostEvent_SystemUi(30, 1)
      _AudioPostEvent_SystemUiForXBOX(30, 1)
    else
      audioPostEvent_SystemUi(30, 16)
      _AudioPostEvent_SystemUiForXBOX(30, 16)
    end
  else
    audioPostEvent_SystemUi(30, 2)
    _AudioPostEvent_SystemUiForXBOX(30, 2)
  end
end
