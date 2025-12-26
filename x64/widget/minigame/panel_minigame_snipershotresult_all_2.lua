function PaGlobal_MiniGame_SniperShotResult_All_Open()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  if _ContentsGroup_NewSniperMode == false then
    return
  end
  PaGlobal_MiniGame_SniperShotResult_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperShotResult_All_Close()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  PaGlobal_MiniGame_SniperShotResult_All:prepareClose()
end
function FromClient_MiniGame_SniperShotResult_All_OnScreenSize()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  PaGlobal_MiniGame_SniperShotResult_All:resize()
  Panel_MiniGame_SniperShotResult_All:SetPosXY(0, getScreenSizeY() - Panel_MiniGame_SniperShotResult_All:GetSizeY())
end
function HandleEventRDown_MiniGame_SniperShotResult_All_PanelClicked()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  self._pressStartMousePosX = getMousePosX()
  self._pressStartMousePosY = getMousePosY()
end
function HandleEventRUp_MiniGame_SniperShotResult_All_PanelReleased()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  ToClient_SniperGame_UpdateRotationInfo(mousePosX - self._pressStartMousePosX, self._pressStartMousePosY - mousePosY)
end
function FromClient_SniperGame_ClearShotResultPanel()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  self:setShowResultPanel(false)
  self:clearShotResultText()
end
function FromClient_SniperGame_MissShotResultPanel()
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  self:updateShotResult(2, false)
end
function FromClient_SniperGame_UpdateShotResultPanel(isPerfectShot, isCriticalShot)
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  _PA_ASSERT(isPerfectShot ~= nil, "FromClient_SniperGame_UpdateShotResultPanel, isPerfectShot \234\176\146\236\157\180 \236\158\152\235\170\187\235\144\152\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164!!")
  _PA_ASSERT(isCriticalShot ~= nil, "FromClient_SniperGame_UpdateShotResultPanel, isCriticalShot \234\176\146\236\157\180 \236\158\152\235\170\187\235\144\152\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164!!")
  if isPerfectShot == true then
    self:updateShotResult(0, isCriticalShot)
  elseif isPerfectShot == false then
    self:updateShotResult(1, isCriticalShot)
  end
end
function PaGlobal_MiniGame_SniperShotResult_All_UpdatePerFrame(deltaTime)
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  if self._shotResultShowTime > self._config._shotResultCloseTime then
    return
  end
  self._shotResultShowTime = self._shotResultShowTime + deltaTime
  if self._shotResultShowTime > self._config._shotResultCloseTime then
    self:clearShotResultText()
  end
end
function PaGlobal_MiniGame_SniperShotResult_All_SetShowResultPanel(flag)
  if PaGlobal_MiniGame_SniperShotResult_All == nil then
    return
  end
  local self = PaGlobal_MiniGame_SniperShotResult_All
  self:setShowResultPanel(flag)
  if flag == false then
    self:clearShotResultText()
  end
end
