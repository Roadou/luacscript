function PaGlobalFunc_GuildMatchCountDown_Open(remainTimeSecond)
  local self = PaGlobal_GuildMatchCountDown
  if self == nil then
    return
  end
  self:prepareOpen(remainTimeSecond)
end
function PaGlobalFunc_GuildMatchCountDown_GetShow()
  local panel = Panel_Widget_GuildMatch_Countdown
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_GuildMatchCountDown_OnScreenResize()
  local self = PaGlobal_GuildMatchCountDown
  if self == nil then
    return
  end
  if Panel_Widget_GuildMatch_Countdown:GetShow() == false then
    return
  end
  self:onScreenResize()
end
function PaGlobalFunc_GuildMatchCountDown_Update(deltaTime)
  local self = PaGlobal_GuildMatchCountDown
  if self == nil then
    return
  end
  self:update(deltaTime)
end
