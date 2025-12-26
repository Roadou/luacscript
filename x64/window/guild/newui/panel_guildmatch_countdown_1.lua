function PaGlobal_GuildMatchCountDown:initialize()
  if self._initialize == true then
    return
  end
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_GuildMatch_Countdown, "Static_Count" .. tostring(idx))
    self._ui._stc_countDown:push_back(control)
  end
  self:registEventHandler()
  self:validate()
  self:clear()
  self._initialize = true
end
function PaGlobal_GuildMatchCountDown:registEventHandler()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_GuildMatchCountDown_OnScreenResize")
end
function PaGlobal_GuildMatchCountDown:validate()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
end
function PaGlobal_GuildMatchCountDown:prepareOpen(remainTimeSecond)
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  self:clear()
  self._remainTimeDelta = remainTimeSecond + 2
  if self._remainTimeDelta == nil or self._remainTimeDelta < 0 then
    UI.ASSERT_NAME(false, "self._remainTimeDelta is invalid", "\236\157\180\236\163\188")
    return
  end
  self:onScreenResize()
  self:open()
end
function PaGlobal_GuildMatchCountDown:open()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  Panel_Widget_GuildMatch_Countdown:RegisterUpdateFunc("PaGlobalFunc_GuildMatchCountDown_Update")
  Panel_Widget_GuildMatch_Countdown:SetShow(true)
end
function PaGlobal_GuildMatchCountDown:prepareClose()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  self:close()
end
function PaGlobal_GuildMatchCountDown:close()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  Panel_Widget_GuildMatch_Countdown:ClearUpdateLuaFunc()
  Panel_Widget_GuildMatch_Countdown:SetShow(false)
end
function PaGlobal_GuildMatchCountDown:onScreenResize()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  Panel_Widget_GuildMatch_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_GuildMatch_Countdown:ComputePosAllChild()
end
function PaGlobal_GuildMatchCountDown:clear()
  if Panel_Widget_GuildMatch_Countdown == nil then
    return
  end
  for idx = 0, 10 do
    local control = self._ui._stc_countDown[idx]
    if control ~= nil then
      control:SetShow(false)
    end
  end
  self._remainTimeDelta = nil
  self._remainTimeSecond = nil
end
function PaGlobal_GuildMatchCountDown:update(deltaTime)
  if Panel_Widget_GuildMatch_Countdown == nil then
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
  if self._ui._stc_countDown[self._remainTimeSecond + 1] ~= nil then
    self._ui._stc_countDown[self._remainTimeSecond + 1]:SetShow(false)
  end
  if self._ui._stc_countDown[self._remainTimeSecond] ~= nil then
    self._ui._stc_countDown[self._remainTimeSecond]:SetShow(true)
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
