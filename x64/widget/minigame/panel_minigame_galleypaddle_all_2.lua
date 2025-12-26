function PaGloabl_MiniGame_GalleyPaddle_All_Open()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  PaGlobal_MiniGame_GalleyPaddle_All:prepareOpen()
end
function PaGloabl_MiniGame_GalleyPaddle_All_Close()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  PaGlobal_MiniGame_GalleyPaddle_All:prepareClose()
end
function Panel_MiniGame_GalleyPaddle_All_UpdatePerFrame(deltaTime)
  PaGlobal_MiniGame_GalleyPaddle_All:update(deltaTime)
end
function PaGloabl_MiniGame_GalleyPaddle_All_ShowAni()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
end
function PaGloabl_MiniGame_GalleyPaddle_All_HideAni()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
end
function PaGloabl_MiniGame_GalleyPaddle_All_StartGame()
  PaGlobal_MiniGame_GalleyPaddle_All:startGame()
end
function PaGloabl_MiniGame_GalleyPaddle_All_EndGame()
  PaGlobal_MiniGame_GalleyPaddle_All:endGame()
end
function PaGloabl_MiniGame_GalleyPaddle_All_IsPlaying()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return false
  end
  return PaGlobal_MiniGame_GalleyPaddle_All._startGame
end
function FromClient_StartGuildShipPaddleMiniGame()
  if Panel_MiniGame_GalleyPaddle_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  if seatPosition == 0 then
    PaGlobal_GalleyBoost_All_SetState(PaGlobal_GalleyBoost_All._stateType.PaddleMiniGame, true)
  else
    PaGloabl_MiniGame_GalleyPaddle_All_Open()
    PaGlobal_GalleyBoost_All_SetState(PaGlobal_GalleyBoost_All._stateType.PaddleMiniGame, true)
  end
  PaGlobal_GalleyMember_All_ResponsePaddleMiniGameStart()
end
function FromClient_PaddleMiniGameAllEnd()
  PaGlobal_GalleyMember_All_ResponsePaddleMiniGameEnd()
  PaGlobal_GalleyBoost_All_SetState(PaGlobal_GalleyBoost_All._stateType.PaddleMiniGame, false)
end
function PaGlobal_MiniGame_GalleyPaddle_All_responseOtherWindowClose()
  if Panel_MiniGame_GalleyPaddle_All == nil or Panel_MiniGame_GalleyPaddle_All:GetShow() == false then
    return
  end
  if self._startGame == false then
    return
  end
  ToClient_uiManagerSetUIConvertableState(CppEnums.UIConvertableType.eUIConvertableType_always, true)
  ToClient_uiManagerSetConvetableInputMode(CppEnums.EProcessorInputMode.eProcessorInputMode_UiModeNotInput)
end
