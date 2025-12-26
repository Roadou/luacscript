function PaGlobal_Common_CountDown_Open(maxCount, getRemainTimeFunc, isCountDownEndFunc)
  local self = PaGlobal_Common_CountDown
  if self == nil then
    return
  end
  self:prepareOpen(maxCount, getRemainTimeFunc, isCountDownEndFunc)
end
function PaGlobal_Common_CountDown_Close()
  local self = PaGlobal_Common_CountDown
  if self == nil then
    return
  end
  self:close()
end
function PaGlobal_Common_CountDown_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Common_CountDown
  if self == nil then
    return
  end
  if self._getRemainTimeFunc == nil then
    return
  end
  if self._isCountDownEndFunc() == true then
    self:prepareClose()
    return
  end
  local remainTimeSecond = self._getRemainTimeFunc() + 1
  if remainTimeSecond <= self._maxCountDown and self._remainTimeSecond ~= remainTimeSecond then
    if Panel_Widget_Common_Countdown:GetShow() == false then
      self:countDownOpen()
    end
    self._remainTimeSecond = remainTimeSecond
    self:showCountDown(self._remainTimeSecond)
  end
end
function PaGlobal_Common_CountDown_Resize()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  Panel_Widget_Common_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Common_Countdown:ComputePosAllChild()
end
function PaGlobal_Common_CountDown_FromSnowBoard()
  if Panel_Widget_Common_Countdown == nil then
    return
  end
  PaGlobal_Common_CountDown_Open(6, ToClient_GetSnowBoardStartStateRemainSecond, ToClient_IsSnowBoardStartState)
end
