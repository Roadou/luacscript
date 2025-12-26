function PaGlobalFunc_InstanceContentsReplayDownloadWeb_Open()
  local self = PaGlobal_InstanceContentsReplayDownloadWeb
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_InstanceContentsReplayDownloadWeb_Close()
  local self = PaGlobal_InstanceContentsReplayDownloadWeb
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_InstanceContentsReplayDownloadWeb_Resize()
  local self = PaGlobal_InstanceContentsReplayDownloadWeb
  if self == nil then
    return
  end
  self:resize()
end
