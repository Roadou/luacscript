function PaGlobalFunc_CameraMode_All_Open()
  PaGlobal_CameraMode_All:prepareOpen()
end
function PaGlobalFunc_CameraMode_All_Close()
  PaGlobal_CameraMode_All:prepareClose()
end
function HandleEventLUp_CameraMode_All_Close()
  PaGlobalFunc_CameraMode_All_Close()
end
function PaGlobalFunc_CameraMode_All_DistanceCheck(deltaTime)
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  if false == Panel_Widget_CameraMode_All:GetShow() then
    return
  end
  PaGlobal_CameraMode_All._distanceCheckInterval = PaGlobal_CameraMode_All._distanceCheckInterval + deltaTime
  if PaGlobal_CameraMode_All._distanceCheckTime < PaGlobal_CameraMode_All._distanceCheckInterval then
    PaGlobal_CameraMode_All._distanceCheckInterval = 0
    PaGlobal_CameraMode_All:update()
  end
end
function FromClient_CameraMode_All_ChangePadCameraControlMode(isCameraMode)
  if true == isCameraMode then
    PaGlobalFunc_CameraMode_All_Open()
  else
    PaGlobalFunc_CameraMode_All_Close()
  end
end
function FromClient_CameraMode_All_onScreenResize()
  PaGlobal_CameraMode_All:resize()
end
