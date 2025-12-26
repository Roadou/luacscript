function PaGlobal_MiniGame_SniperGame_Result_All_Open()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperGame_Result_All_Close()
  if nil == Panel_MiniGame_SniperGame_Result_All or false == Panel_MiniGame_SniperGame_Result_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:prepareClose()
end
function PaGlobal_MiniGame_SniperGame_Result_All_GetShow()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return false
  end
  return Panel_MiniGame_SniperGame_Result_All:GetShow()
end
function PaGlobal_MiniGame_SniperGame_Result_All_ClearResult()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_impactPoint:SetShow(false)
  if _ContentsGroup_NewSniperMode == true then
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultTextRenew(3, false)
  else
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(3, nil)
  end
end
function PaGlobal_MiniGame_SniperGame_Result_All_UpdateShootResult(deviationDiameter, desiredScreenPos, hittedScreenPos, hitPartType)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateBulletPos(false, deviationDiameter, desiredScreenPos, hittedScreenPos)
  if _ContentsGroup_NewSniperMode == true then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(1, hitPartType)
end
function PaGlobal_MiniGame_SniperGame_Result_All_UpdateMissResult(deviationDiameter, desiredScreenPos, hittedScreenPos)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  local isBulletPosSet = PaGlobal_MiniGame_SniperGame_Result_All:UpdateBulletPos(true, deviationDiameter, desiredScreenPos, hittedScreenPos)
  if _ContentsGroup_NewSniperMode == true then
    return
  end
  if true == isBulletPosSet then
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(2, nil)
  else
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(3, nil)
  end
end
function PaGlobal_MiniGame_SniperGame_Result_All_MissShotResultPanel()
  if Panel_MiniGame_SniperGame_Result_All == nil then
    return
  end
  if _ContentsGroup_NewSniperMode == false then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultTextRenew(2, false)
end
function PaGlobal_MiniGame_SniperGame_Result_All_UpdateShotResultPanel(isPerfectShot, isCriticalShot)
  if Panel_MiniGame_SniperGame_Result_All == nil then
    return
  end
  if _ContentsGroup_NewSniperMode == false then
    return
  end
  if isPerfectShot == true then
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultTextRenew(0, isCriticalShot)
  else
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultTextRenew(1, isCriticalShot)
  end
end
function FromClient_Minigame_SniperGame_Result_All_OnScreenSize()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  Panel_MiniGame_SniperGame_Result_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_MiniGame_SniperGame_Result_All:SetPosXY(0, 0)
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_deviationMark:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultPerfect:ComputePos()
end
