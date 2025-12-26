function PaGlobal_CutSceneSkip_Open()
  PaGlobal_CutSceneSkip:prepareOpen()
end
function PaGlobal_CutSceneSkip_Close()
  PaGlobal_CutSceneSkip:prepareClose()
end
function FromClient_stopCutSceneCamera()
  PaGlobal_CutSceneSkip_Close()
  PaGlobal_CutSceneScript_Close()
  PaGlobalFunc_CutSceneEscSkip_Close()
end
function PaGlobalFunc_CutSceneSkip_Awake()
end
function PaGlobalFunc_CutSceneSkip_DoSkip()
  PaGlobal_CutSceneSkip:doSkip()
end
function FromClient_CutSceneSkip_CutsceneKeyGuideShow(posX, posY, keyType, isShow)
  if false == isShow and true == PaGlobal_CutSceneSkip._isBackToCharacterSelect then
    PaGlobal_CutSceneSkip._isBackToCharacterSelect = false
    PaGlobal_GameExit_All_GoToCharacterSelect()
  end
end
function PaGlobalFunc_CutSceneSkip_SetBackToCharacterSelect(isSet)
  PaGlobal_CutSceneSkip._isBackToCharacterSelect = isSet
end
