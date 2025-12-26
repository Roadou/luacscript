function PaGlobal_SimpleBuildMode_All_Open()
  if Panel_SimpleBuildMode == nil then
    return
  end
  if _ContentsGroup_SimpleBuildMode == false then
    return
  end
  PaGlobal_SimpleBuildMode_All:prepareOpen()
end
function PaGlobal_SimpleBuildMode_All_Close()
  if Panel_SimpleBuildMode == nil then
    return
  end
  PaGlobal_SimpleBuildMode_All:prepareClose()
end
function PaGlobal_SimpleBuildMode_All_Update(deltaTime)
  if Panel_SimpleBuildMode == nil then
    return
  end
  PaGlobal_SimpleBuildMode_All:update(deltaTime)
end
function PaGlobal_SimpleBuildMode_All_SimpleBuildEnd()
  ToClient_SimpleBuildEnd()
  PaGlobal_SimpleBuildMode_All_Close()
end
function PaGlobal_SimpleBuildMode_All_SetSimpleBuildFixState(isSet)
  ToClient_setSimpleBuildFixState(isSet)
  PaGlobal_SimpleBuildMode_All:updateFixState()
end
function PaGlobal_SimpleBuildMode_All_SetCameraMode(isSet, index)
  if isSet == false then
    PaGlobal_SimpleBuildMode_All._isChangeCameraMode = false
    ToClient_onBossCamera(false)
    if PaGlobal_SimpleBuildMode_All._prevCameraPitch ~= nil then
      selfPlayerSetCameraPich(PaGlobal_SimpleBuildMode_All._prevCameraPitch)
      ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
      ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
      ToClient_HideMouseCursor()
      PaGlobal_SimpleBuildMode_All._isCheckDelay = true
      PaGlobal_SimpleBuildMode_All._prevCameraPitch = nil
    end
    return
  end
  local activeViewDistance, viewDistance, minDistance, maxDistance, viewBoundaryDistacne, viewInterPlationTime, mouse_wheel_sensitivity
  if index == 0 then
    activeViewDistance = 1500
    viewDistance = 1000
    minDistance = 500
    maxDistance = 1500
    viewBoundaryDistacne = 500
    viewInterPlationTime = 0
    mouse_wheel_sensitivity = 0.08
  elseif index == 1 then
    activeViewDistance = 2000
    viewDistance = 2000
    minDistance = 500
    maxDistance = 2000
    viewBoundaryDistacne = 500
    viewInterPlationTime = 0
    mouse_wheel_sensitivity = 0.08
  elseif index == 2 then
    activeViewDistance = 3000
    viewDistance = 2000
    minDistance = 500
    maxDistance = 3000
    viewBoundaryDistacne = 500
    viewInterPlationTime = 0
    mouse_wheel_sensitivity = 0.08
  else
    return
  end
  local isSuccess = ToClient_onBossCamera(true, activeViewDistance, viewDistance, minDistance, maxDistance, viewBoundaryDistacne, viewInterPlationTime, mouse_wheel_sensitivity)
  if isSuccess == false then
    PaGlobal_SimpleBuildMode_All._isChangeCameraMode = false
    ToClient_onBossCamera(false)
    return
  end
  PaGlobal_SimpleBuildMode_All._isChangeCameraMode = true
  ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, false)
  ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode)
  ToClient_HideMouseCursor()
  local cameraRotation = getCameraYawPitchRoll()
  PaGlobal_SimpleBuildMode_All._prevCameraPitch = cameraRotation.y
  PaGlobal_SimpleBuildMode_All._isCheckDelay = true
  selfPlayerSetCameraPich(-1.4)
end
function HandleEventLUp_SimpleBuildMode_All_ShowCommandFunc()
  if Panel_SimpleBuildMode == nil then
    return
  end
  local isCheck = PaGlobal_SimpleBuildMode_All._ui._btn_showCommand:IsCheck()
  PaGlobal_SimpleBuildMode_All._ui._stc_commandBg:SetShow(isCheck == true)
end
function FromClient_SimpleBuildMode_All_ResizePanel()
  PaGlobal_SimpleBuildMode_All:resize()
end
