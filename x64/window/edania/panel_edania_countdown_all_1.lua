function PaGlobal_EdaniaCountDown:initialize()
  if self._initialize == true then
    return
  end
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_Edania_Countdown, "Static_Count" .. tostring(idx))
    self._ui._stc_CountDown:push_back(control)
  end
  self:registEventHandler()
  self:validate()
  self:clear()
  self._initialize = true
end
function PaGlobal_EdaniaCountDown:registEventHandler()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_EdaniaCountDown_OnScreenResize")
end
function PaGlobal_EdaniaCountDown:validate()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_Edania_Countdown, "Static_Count" .. tostring(idx))
    control:isValidate()
  end
end
function PaGlobal_EdaniaCountDown:prepareOpen(remainTimeSecond)
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  self:clear()
  self._remainTimeDelta = remainTimeSecond + 2
  if self._remainTimeDelta == nil or self._remainTimeDelta < 0 then
    return
  end
  self:onScreenResize()
  self:open()
end
function PaGlobal_EdaniaCountDown:open()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  Panel_Widget_Edania_Countdown:RegisterUpdateFunc("PaGlobalFunc_EdaniaCountDown_Update")
  Panel_Widget_Edania_Countdown:SetShow(true)
end
function PaGlobal_EdaniaCountDown:prepareClose()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  Panel_Widget_Edania_Countdown:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_EdaniaCountDown:close()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  Panel_Widget_Edania_Countdown:SetShow(false)
end
function PaGlobal_EdaniaCountDown:onScreenResize()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  Panel_Widget_Edania_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Edania_Countdown:ComputePosAllChild()
end
function PaGlobal_EdaniaCountDown:clear()
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    local control = self._ui._stc_CountDown[idx]
    if control ~= nil then
      control:SetShow(false)
    end
  end
  self._remainTimeDelta = nil
  self._remainTimeSecond = nil
end
function PaGlobal_EdaniaCountDown:update(deltaTime)
  if Panel_Widget_Edania_Countdown == nil then
    return
  end
  self._remainTimeDelta = self._remainTimeDelta - deltaTime
  if self._remainTimeDelta < 0 then
    self:prepareClose()
    return
  end
  local remainSecond = math.floor(self._remainTimeDelta)
  if self._remainTimeSecond == remainSecond then
    return
  else
    self._remainTimeSecond = remainSecond
  end
  if self._ui._stc_CountDown[self._remainTimeSecond + 1] ~= nil then
    self._ui._stc_CountDown[self._remainTimeSecond + 1]:SetShow(false)
  end
  if self._ui._stc_CountDown[self._remainTimeSecond] ~= nil then
    self._ui._stc_CountDown[self._remainTimeSecond]:SetShow(true)
  end
  if self._remainTimeSecond ~= 1 then
    if self._remainTimeSecond == 5 or self._remainTimeSecond == 6 then
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
