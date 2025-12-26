function PaGlobal_Dialog_HorseLevelDecrease_All_Open(servantNo, downHp, downMp, downWeight, downSpeed, downAcceleration, downCornering, downBrake, vehicleSkillKey)
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  if Panel_Dialog_HorseLevelDecrease_All:GetShow() == true then
    return
  end
  PaGlobal_Dialog_HorseLevelDecrease_All:prepareOpen(servantNo, downHp, downMp, downWeight, downSpeed, downAcceleration, downCornering, downBrake, vehicleSkillKey)
  if _ContentsGroup_UsePadSnapping == true then
    ToClient_padSnapSetTargetPanel(Panel_Dialog_HorseLevelDecrease_All)
  end
end
function PaGlobal_Dialog_HorseLevelDecrease_All_Close()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  PaGlobal_Dialog_HorseLevelDecrease_All:prepareClose()
end
function PaGlobal_Dialog_HorseLevelDecrease_All_ShowAni()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
end
function PaGlobal_Dialog_HorseLevelDecrease_All_HideAni()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
end
