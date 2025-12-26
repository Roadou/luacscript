function PaGlobal_Widget_HardCoreBlackField_Enter_UpdateEnterEffect(deltaTime)
  local self = PaGlobal_Widget_HardCoreBlackField_Enter_All
  if self == nil then
    return
  end
  self:updateEnterEffect(deltaTime)
end
function FromClient_ShowHardCoreBlackFieldEnterEffect()
  local self = PaGlobal_Widget_HardCoreBlackField_Enter_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function FromClient_Widget_HardCoreBlackField_Enter_ResizePanel()
  local self = PaGlobal_Widget_HardCoreBlackField_Enter_All
  if self == nil then
    return
  end
  self:resizePanel()
end
