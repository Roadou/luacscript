local _renderMode, _prevUIMode
function FromClient_PlayFieldWalkingCamera()
  _renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_FieldWalkingCamera
  }, false)
  _renderMode:setClosefunctor(_renderMode, FromClient_StopFieldWalkingCamera)
  _renderMode:set()
  _prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_FieldWalkingCamera)
  crossHair_SetShow(false)
end
function FromClient_StopFieldWalkingCamera()
  _renderMode:reset()
  SetUIMode(_prevUIMode)
  crossHair_SetShow(true)
end
registerEvent("FromClient_PlayFieldWalkingCamera", "FromClient_PlayFieldWalkingCamera")
registerEvent("FromClient_StopFieldWalkingCamera", "FromClient_StopFieldWalkingCamera")
