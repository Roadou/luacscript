function PaGlobal_FishingCamp_ShowAni()
  if PaGlobal_FishingCamp == nil then
    return
  end
end
function PaGlobal_FishingCamp_HideAni()
  if PaGlobal_FishingCamp == nil then
    return
  end
end
function PaGlobal_FishingCamp_Open()
  if PaGlobal_FishingCamp == nil then
    return
  end
  PaGlobal_FishingCamp:prepareOpen()
end
function PaGlobal_FishingCamp_Close()
  if PaGlobal_FishingCamp == nil then
    return
  end
  PaGlobal_FishingCamp:prepareClose()
end
function PaGlobal_FishingCamp_UpdateFishingCampIcon()
  if PaGlobal_FishingCamp == nil then
    return
  end
  PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetFishingCamp())
end
function PaGlobal_FishingCamp_SealOrUnsealFishingCamp()
  if PaGlobal_FishingCamp == nil then
    return
  end
  ToClient_RequestSealOrUnsealFishingCamp()
end
function PaGlobal_FishingCamp_Update()
  if PaGlobal_FishingCamp == nil then
    return
  end
  if Panel_Window_FishingCamp:GetShow() == false then
    return
  end
  PaGlobal_FishingCamp:update()
end
function PaGlobal_FishingCamp_ShowItemToolTip(equipSlotIndex, key, isShow)
  if PaGlobal_FishingCamp == nil then
    return
  end
  PaGlobal_FishingCamp:showToolTip(equipSlotIndex, key, isShow)
end
function PaGlobal_FishingCamp_RequestUnequipItem(equipSlotIndex)
  if PaGlobal_FishingCamp == nil then
    return
  end
  ToClient_RequestFishingCampUnEquipItem(equipSlotIndex)
end
