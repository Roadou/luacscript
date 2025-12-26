function PaGlobal_HardCoreResult_ShowAni()
  if PaGlobal_HardCoreResult == nil then
    return
  end
end
function PaGlobal_HardCoreResult_HideAni()
  if PaGlobal_HardCoreResult == nil then
    return
  end
end
function PaGlobal_HardCoreResult_Open()
  if PaGlobal_HardCoreResult == nil then
    return
  end
  PaGlobal_HardCoreResult:prepareOpen()
end
function PaGlobal_HardCoreResult_Close()
  if PaGlobal_HardCoreResult == nil then
    return
  end
  PaGlobal_HardCoreResult:prepareClose()
end
function PaGlobal_HardCoreResult_GetShow()
  if PaGlobal_HardCoreResult == nil then
    return
  end
  return Panel_Window_Hardcore_Result:GetShow()
end
