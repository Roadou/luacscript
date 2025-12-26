function PaGlobal_HardCoreCompass_ShowAni()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
end
function PaGlobal_HardCoreCompass_HideAni()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
end
function PaGlobal_HardCoreCompass_Open()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
  PaGlobal_HardCoreCompass:prepareOpen()
end
function PaGlobal_HardCoreCompass_Close()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
  PaGlobal_HardCoreCompass:prepareClose()
end
function PaGlobal_HardCoreCompass_UpdatePerFrame()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
  PaGlobal_HardCoreCompass:updatePerframe()
end
function PaGlobal_HardCoreCompass_BossData()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
  PaGlobal_HardCoreCompass:updateBossData()
end
function PaGlobal_HardCoreCompass_RankerData()
  if PaGlobal_HardCoreCompass == nil then
    return
  end
  PaGlobal_HardCoreCompass:updateRankerData()
end
