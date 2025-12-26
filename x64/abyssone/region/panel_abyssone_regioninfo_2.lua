function PaGlobalFunc_AbyssOneInfo_Open()
  local self = PaGlobal_AbyssOneInfo
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_AbyssOneInfo_TimeClose()
  local self = PaGlobal_AbyssOneInfo
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_AbyssOneInfo_GetPosY()
  local panel = Panel_Window_AbyssOneInfo
  if panel == nil then
    return 0
  end
  return panel:GetPosY()
end
function PaGlobalFunc_AbyssOneInfo_GetSizeY()
  local panel = Panel_Window_AbyssOneInfo
  if panel == nil then
    return 0
  end
  return panel:GetSizeY()
end
function FromClient_SetAbyssOneRegionInfo(contentsType)
  local self = PaGlobal_AbyssOneInfo
  if self == nil then
    return
  end
  if contentsType ~= __eInstanceContentsType_AbyssOne then
    return
  end
  PaGlobalFunc_AbyssOneInfo_Open()
end
