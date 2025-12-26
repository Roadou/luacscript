function PaGlobal_CutSceneScript_Open()
  PaGlobal_CutSceneScript:prepareOpen()
end
function PaGlobal_CutSceneScript_Close()
  PaGlobal_CutSceneScript:prepareClose()
end
function FromClient_startCutSceneGroupCamera()
  local self = PaGlobal_CutSceneScript
  self:prepareOpen()
end
function PaGlobalFunc_CutSceneScript_Awake()
end
function PaGlobal_CutSceneScript_UpdatePerFrame(deltaTime)
end
function PaGlobalFunc_CutSceneScript_IsOnlyPartyLeaderSkipAble()
  return PaGlobal_CutSceneScript:isOnlyPartyLeaderSkipAble()
end
function PaGlobalFunc_CutSceneScript_KeyPressReset()
  PaGlobal_CutSceneScript:keyPressReset()
end
