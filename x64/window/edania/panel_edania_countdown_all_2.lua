function PaGlobalFunc_EdaniaCountDown_Open(remainTimeSecond)
  local self = PaGlobal_EdaniaCountDown
  if self == nil then
    return
  end
  self:prepareOpen(remainTimeSecond)
end
function PaGlobalFunc_EdaniaCountDown_GetShow()
  local self = PaGlobal_EdaniaCountDown
  if self == nil then
    return
  end
  return Panel_Widget_Edania_Countdown:GetShow() == true
end
function PaGlobalFunc_EdaniaCountDown_OnScreenResize()
  local self = PaGlobal_EdaniaCountDown
  if self == nil then
    return
  end
  if Panel_Widget_Edania_Countdown:GetShow() == false then
    return
  end
  self:onScreenResize()
end
function PaGlobalFunc_EdaniaCountDown_Update(deltaTime)
  local self = PaGlobal_EdaniaCountDown
  if self == nil then
    return
  end
  self:update(deltaTime)
end
