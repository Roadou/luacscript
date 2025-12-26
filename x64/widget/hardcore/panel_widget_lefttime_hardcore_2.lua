function PaGlobal_HardCoreLeftTime_ShowAni()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
end
function PaGlobal_HardCoreLeftTime_HideAni()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
end
function PaGlobal_HardCoreLeftTime_Open()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
  PaGlobal_HardCoreLeftTime:prepareOpen()
end
function PaGlobal_HardCoreLeftTime_Close()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
  PaGlobal_HardCoreLeftTime:prepareClose()
end
function PaGlobal_HardCoreLeftTime_UpdateBlackField()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
  PaGlobal_HardCoreLeftTime:updateBlackField()
end
function PaGlobal_HardCoreLeftTime_UpdateLeftTime()
  if PaGlobal_HardCoreLeftTime == nil then
    return
  end
  PaGlobal_HardCoreLeftTime:updateLeftTime()
end
