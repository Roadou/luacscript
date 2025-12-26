PaGlobal_MatchingSystem = {_initialize = false}
registerEvent("FromClient_luaLoadComplete", "FromClient_MatchingSystem_Init")
function FromClient_MatchingSystem_Init()
  PaGlobal_MatchingSystem:initialize()
end
function PaGlobal_MatchingSystem:initialize()
  PaGlobal_MatchingSystem:registEventHandler()
  ToClient_RequestCheckIsMatchState()
  PaGlobal_MatchingSystem._initialize = true
end
function PaGlobal_MatchingSystem:registEventHandler()
  registerEvent("FromClient_RequestCheckIsMatchState", "FromClient_RequestCheckIsMatchState")
  registerEvent("FromClient_MatchServerConnectSuccess", "FromClient_MatchServerConnectSuccess")
  registerEvent("FromClient_SuccessMatchServerLogin", "FromClient_SuccessMatchServerLogin")
  registerEvent("FromClient_MatchingSuccessFromMatchServer", "FromClient_MatchingSuccessFromMatchServer")
  registerEvent("FromClient_SuccessMatchServerLogout", "FromClient_SuccessMatchServerLogout")
  registerEvent("FromClient_ResponseMatchingStateAck", "FromClient_ResponseMatchingStateAck")
  registerEvent("FromClient_JoinMatchConfirmUpdate", "FromClient_JoinMatchConfirmUpdate")
end
function FromClient_RequestCheckIsMatchState()
  ToClient_RequestCheckIsMatchState()
end
function FromClient_MatchServerConnectSuccess(instanceType)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_Solrare_MatchServerConnectSuccess()
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacing_MatchServerConnectSuccess()
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacing_MatchServerConnectSuccess()
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleField_MatchServerConnectSuccess()
  end
end
function FromClient_SuccessMatchServerLogin(instanceType)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_Solrare_SuccessMatchServerLogin()
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacing_SuccessMatchServerLogin()
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacing_SuccessMatchServerLogin()
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleField_SuccessMatchServerLogin()
  end
end
function FromClient_MatchingSuccessFromMatchServer(instanceType)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_Solrare_MatchingSuccess()
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacing_MatchingSuccess()
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacing_MatchingSuccess()
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleField_MatchingSuccess()
  end
end
function FromClient_SuccessMatchServerLogout(instanceType)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_Solrare_SuccessMatchServerLogout()
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacing_SuccessMatchServerLogout()
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacing_SuccessMatchServerLogout()
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleField_SuccessMatchServerLogout()
  end
end
function FromClient_ResponseMatchingStateAck(instanceType, isMatching)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_Solare_MatchingStateUpdate(isMatching)
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacing_MatchingStateUpdate(isMatching)
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacing_MatchingStateUpdate(isMatching)
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleField_MatchingStateUpdate(isMatching)
  end
end
function FromClient_JoinMatchConfirmUpdate(instanceType, maxPlayerCount, minPlayerCount, playerCount, confirmCount, isConfirm)
  if instanceType == __eInstanceContentsType_Solare then
    if _ContentsGroup_Solare == true then
      FromClient_SolareJoinConfirmUpdate(maxPlayerCount, playerCount, confirmCount, isConfirm)
    end
  elseif instanceType == __eInstanceContentsType_HorseRacing then
    if _ContentsGroup_HorseRaceMatch == true then
      FromClient_HorseRacingJoinConfirmUpdate(minPlayerCount, playerCount, confirmCount, isConfirm)
    end
  elseif instanceType == __eInstanceContentsType_MiniGame then
    if _ContentsGroup_DragonPalace == true then
      FromClient_HorseRacingJoinConfirmUpdate(minPlayerCount, playerCount, confirmCount, isConfirm)
    end
  elseif instanceType == __eInstanceContentsType_RedBattleField and _ContentsGroup_RedBattleFieldMatching == true then
    FromClient_RedBattleFieldJoinConfirmUpdate(minPlayerCount, playerCount, confirmCount, isConfirm)
  end
end
function PaGlobal_IsMatchingConfirmOpen()
  if PaGlobalFunc_RedBattleField_MatchingConfirm_IsOpen ~= nil and PaGlobalFunc_RedBattleField_MatchingConfirm_IsOpen() == true then
    return true
  end
  if PaGlobalFunc_Solrare_MatchingConfirm_IsOpen ~= nil and PaGlobalFunc_Solrare_MatchingConfirm_IsOpen() == true then
    return true
  end
  if PaGlobalFunc_HorseRacing_MatchingConfirm_IsOpen ~= nil and PaGlobalFunc_HorseRacing_MatchingConfirm_IsOpen() == true then
    return true
  end
  return false
end
