function PaGlobalFunc_MiniGameYacht_Notice_Dev()
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  local expireTime = getServerUtc64() + toInt64(0, 10)
  local gameBoardKey = YachtGameBoardKey(1)
  PaGlobal_YachtDice_Notice:prepareOpen("Test", expireTime, gameBoardKey)
end
function PaGlobalFunc_MiniGameYacht_Notice_Open(requestUserNickName, expireTime, gameBoardKey, useKeepData)
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  if true == useKeepData then
    PaGlobal_YachtDice_Notice:prepareOpen(PaGlobal_YachtDice_Notice._keepOpenInfo._requestUserNickName, PaGlobal_YachtDice_Notice._keepOpenInfo._expireTime, PaGlobal_YachtDice_Notice._keepOpenInfo._gameBoardKey, PaGlobal_YachtDice_Notice._keepOpenInfo._requestUserPlatformId, PaGlobal_YachtDice_Notice._keepOpenInfo._requestUserPlatformType)
  else
    PaGlobal_YachtDice_Notice:prepareOpen(requestUserNickName, expireTime, gameBoardKey)
  end
end
function PaGlobalFunc_MiniGameYacht_Notice_KeepOpenInfo(requestUserNickName, expireTime, gameBoardKey, platformId, platformType)
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  PaGlobal_YachtDice_Notice:keepOpenInfo(requestUserNickName, expireTime, gameBoardKey, platformId, platformType)
end
function PaGlobalFunc_MiniGameYacht_Notice_Close(isRefuse)
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  if true == isRefuse then
    ToClient_requestRefuseMiniGameYachtDiceToPlayer()
  end
  if true == PaGlobal_YachtDice_Notice._isConsole then
    PaGlobal_YachtDice_Notice:prepareClose()
  else
    PaGlobal_YachtDice_Notice:doCloseAnimation()
  end
  if true == PaGlobal_YachtDice_Notice._isConsole then
    PaGlobal_YachtDice_Invite_SetChangeMode_InviteMode()
  end
end
function PaGlobalFunc_MiniGameYacht_Notice_Update(deltaTime)
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  PaGlobal_YachtDice_Notice:update(deltaTime)
end
function PaGlobalFunc_MiniGameYacht_Notice_Canceled()
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  if false == Panel_Widget_MiniGame_YachtDice_Notice:GetShow() then
    return
  end
  PaGlobal_YachtDice_Notice._isExpireRequest = true
end
function PaGlobalFunc_MiniGameYacht_Notice_OnCLickedAcceptButton()
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  ToClient_requestAcceptMiniGameYachtDiceToPlayer()
  PaGlobalFunc_MiniGameYacht_Notice_Close(false)
end
function PaGlobalFunc_MiniGameYacht_Notice_OnClickedRefuseButton()
  if nil == PaGlobal_YachtDice_Notice then
    return
  end
  PaGlobalFunc_MiniGameYacht_Notice_Close(true)
end
