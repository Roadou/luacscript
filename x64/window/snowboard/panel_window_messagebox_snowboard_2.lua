function PaGlobal_MessageBox_SnowBoard_Open()
  local self = PaGlobal_MessageBox_SnowBoard
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_MessageBox_SnowBoard_Close()
  local self = PaGlobal_MessageBox_SnowBoard
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_MessageBox_SnowBoard_Retry()
  local self = PaGlobal_MessageBox_SnowBoard
  if self == nil then
    return
  end
  self:funcYes()
  self:prepareClose()
end
function PaGlobal_MessageBox_SnowBoard_Exit()
  local self = PaGlobal_MessageBox_SnowBoard
  if self == nil then
    return
  end
  self:funcOut()
  self:prepareClose()
end
