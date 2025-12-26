function PaGlobal_MiniGame_SniperShotResult_All:initialize()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self._ui.stc_resultView_BG = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "Static_ResultViewViewBG")
  self._ui.stc_resultView_Deco = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "Static_FrameDeco")
  self._ui.stc_resultView_View = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "Static_ResultViewView")
  self._ui.stc_resultCritical = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "StaticText_Critical")
  self._ui.stc_resultPerfect = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "StaticText_Perfect")
  self._ui.stc_resultMiss = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "StaticText_Miss")
  self._ui.stc_resultHit = UI.getChildControl(Panel_MiniGame_SniperShotResult_All, "StaticText_Hit")
  self:registerEventHandler()
  self:validate()
  Panel_MiniGame_SniperShotResult_All:SetPosXY(0, getScreenSizeY() - Panel_MiniGame_SniperShotResult_All:GetSizeY())
end
function PaGlobal_MiniGame_SniperShotResult_All:prepareOpen()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self._ui.stc_resultView_View:ChangeTextureInfoToRenderTargetXXXXX(__eRenderTargetType_SniperTarget)
  ToClient_SniperGame_RedrawBulletLine()
  ToClient_SniperGame_StartRenderResultPanel(true)
  self:open()
end
function PaGlobal_MiniGame_SniperShotResult_All:open()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  Panel_MiniGame_SniperShotResult_All:SetShow(true)
end
function PaGlobal_MiniGame_SniperShotResult_All:prepareClose()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self:clearShotResultText()
  ToClient_SniperGame_StartRenderResultPanel(false)
  self:close()
end
function PaGlobal_MiniGame_SniperShotResult_All:close()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  Panel_MiniGame_SniperShotResult_All:SetShow(false)
end
function PaGlobal_MiniGame_SniperShotResult_All:resize()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  Panel_MiniGame_SniperShotResult_All:ComputePosAllChild()
end
function PaGlobal_MiniGame_SniperShotResult_All:registerEventHandler()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_SniperShotResult_All_OnScreenSize")
  registerEvent("FromClient_SniperGame_ClearShotResultPanel", "FromClient_SniperGame_ClearShotResultPanel")
  registerEvent("FromClient_SniperGame_MissShotResultPanel", "FromClient_SniperGame_MissShotResultPanel")
  registerEvent("FromClient_SniperGame_UpdateShotResultPanel", "FromClient_SniperGame_UpdateShotResultPanel")
  Panel_MiniGame_SniperShotResult_All:RegisterUpdateFunc("PaGlobal_MiniGame_SniperShotResult_All_UpdatePerFrame")
end
function PaGlobal_MiniGame_SniperShotResult_All:validate()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self._ui.stc_resultView_BG:isValidate()
  self._ui.stc_resultView_Deco:isValidate()
  self._ui.stc_resultView_View:isValidate()
  self._ui.stc_resultCritical:isValidate()
  self._ui.stc_resultPerfect:isValidate()
  self._ui.stc_resultMiss:isValidate()
  self._ui.stc_resultHit:isValidate()
end
function PaGlobal_MiniGame_SniperShotResult_All:clearShotResultText()
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self._ui.stc_resultCritical:SetShow(false)
  self._ui.stc_resultPerfect:SetShow(false)
  self._ui.stc_resultMiss:SetShow(false)
  self._ui.stc_resultHit:SetShow(false)
end
function PaGlobal_MiniGame_SniperShotResult_All:setShowResultPanel(flag)
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self._ui.stc_resultView_BG:SetShow(flag)
  self._ui.stc_resultView_Deco:SetShow(flag)
  self._ui.stc_resultView_View:SetShow(flag)
end
function PaGlobal_MiniGame_SniperShotResult_All:updateShotResult(shotResultType, isCriticalShot)
  if Panel_MiniGame_SniperShotResult_All == nil then
    return
  end
  self:clearShotResultText()
  self._shotResultShowTime = 0
  if shotResultType == 0 then
    self._ui.stc_resultPerfect:SetShow(true)
  elseif shotResultType == 1 then
    self._ui.stc_resultHit:SetShow(true)
  elseif shotResultType == 2 then
    self._ui.stc_resultMiss:SetShow(true)
  end
  self._ui.stc_resultCritical:SetShow(isCriticalShot)
  local isHit = shotResultType == 0 or shotResultType == 1
  self:setShowResultPanel(isHit)
end
