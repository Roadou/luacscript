function PaGlobal_LifeRingMenu_All_Open()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isDead() == true then
    return
  end
  if isObserverMode() == true then
    return
  end
  if ToClient_IsEmergencyAvoid() == true then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    if isKeyPressed(PaGlobal_LifeRingMenu_All._config._exceptKey1) == true or isKeyPressed(PaGlobal_LifeRingMenu_All._config._exceptKey2) == true then
      PaGlobal_LifeRingMenu_All_Close()
      return
    end
    if isKeyPressed(PaGlobal_LifeRingMenu_All._config._keyBinding) == false then
      PaGlobal_LifeRingMenu_All_Close()
      return
    end
  end
  FromClient_LifeRingMenu_All_ResizePanel()
  PaGlobal_LifeRingMenu_All:prepareOpen()
end
function PaGlobal_LifeRingMenu_All_Close()
  PaGlobal_LifeRingMenu_All:prepareClose()
end
function PaGlobal_LifeRingMenu_All_Update(deltaTime)
  PaGlobal_LifeRingMenu_All:update(deltaTime)
end
function FromClient_LifeRingMenu_All_ResizePanel()
  Panel_Widget_LifeRingMenu_All:ComputePosAllChild()
  PaGlobal_LifeRingMenu_All:SetPanelPosInfo(getOriginScreenSizeX() / 2, getOriginScreenSizeY() / 2)
end
