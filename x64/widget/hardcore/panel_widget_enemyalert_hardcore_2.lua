function PaGlobal_EnemyAlert_HardCore_All_ShowAni()
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
end
function PaGlobal_EnemyAlert_HardCore_All_HideAni()
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
end
function PaGlobal_EnemyAlert_HardCore_All_Open()
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
  PaGlobal_EnemyAlert_HardCore_All:prepareOpen()
end
function PaGlobal_EnemyAlert_HardCore_All_Close()
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
  PaGlobal_EnemyAlert_HardCore_All:prepareClose()
end
function PaGlobal_EnemyAlert_HardCore_All_UpdatAlert()
  if PaGlobal_EnemyAlert_HardCore_All == nil then
    return
  end
  PaGlobal_EnemyAlert_HardCore_All:update()
end
