function PaGlobalFunc_DropItemImageToolTip_Open(name, desc, textureId)
  local self = PaGlobal_DropItemImageToolTip_All
  if self == nil then
    return
  end
  self:prepareOpen(name, desc, textureId)
end
function PaGlobalFunc_DropItemImageToolTip_Close()
  local self = PaGlobal_DropItemImageToolTip_All
  if self == nil then
    return
  end
  self:prepareClose()
end
