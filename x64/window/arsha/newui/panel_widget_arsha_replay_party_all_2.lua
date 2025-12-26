function PaGlobalFunc_Arsha_Replay_Party_All_Open()
  PaGlobal_Arsha_Replay_Party_All:prepareOpen()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Close()
  PaGlobal_Arsha_Replay_Party_All:prepareClose()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Resize()
  PaGlobal_Arsha_Replay_Party_All:resize()
end
function PaGlobalFunc_Arsha_Replay_Party_All_Setting(teamNo)
  PaGlobal_Arsha_Replay_Party_All:setting(teamNo)
end
function PaGlobalFunc_Arsha_Replay_Party_All_Setting_Personal(teamNo)
  PaGlobal_Arsha_Replay_Party_All:setting_Personal(teamNo)
end
function PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  PaGlobal_Arsha_Replay_Party_All:clearIsFinish()
end
function PaGlobalFunc_Arsha_Replay_Party_All_GetTeamUIBottomPos(teamNo)
  PaGlobal_Arsha_Replay_Party_All:GetTeamUIBottomPos(teamNo)
end
function PaGlobalFunc_Arsha_Replay_Party_All_ChangeTeamNameForReplay()
  PaGlobal_Arsha_Replay_Party_All:changeTeamNameForReplay()
end
function HandleEventLUp_Arsha_Replay_Party_All(teamNo, index, actorKeyRaw)
  PaGlobal_Arsha_Replay_Party_All:clickPartyUI(teamNo, index, actorKeyRaw, false)
end
function FromClient_Arsha_Replay_Party_All_UpdateUserHP()
  local matchType = ToClient_CompetitionMatchType()
  if 2 == matchType then
    PaGlobal_Arsha_Replay_Party_All:updateUserHP_Personal()
  else
    PaGlobal_Arsha_Replay_Party_All:updateUserHP()
  end
end
function FromClient_Arsha_Replay_Party_All_AttachReplayCharacter(actorKeyRaw)
  PaGlobal_Arsha_Replay_Party_All:attchToReplayCharacter(actorKeyRaw)
end
function FromClient_Arsha_Party_All_SetMember(teamNo, actorKeyRaw)
  PaGlobal_Arsha_Replay_Party_All:setMember(teamNo, actorKeyRaw)
end
function FromClient_Arsha_Replay_Party_All_Create()
  PaGlobalFunc_Arsha_Party_All_Resize()
  local matchType = ToClient_CompetitionMatchType()
  if 0 == matchType then
    PaGlobal_Arsha_Replay_Party_All:createTeamUi()
  elseif 2 == matchType then
    PaGlobal_Arsha_Replay_Party_All:createTeamUi_Personal()
  end
end
function FromClient_Arsha_Replay_Party_All_Close()
  PaGlobalFunc_Arsha_Replay_Party_All_Close()
end
function FromClient_Arsha_Replay_Party_All_Create_Personal()
  PaGlobalFunc_Arsha_Party_All_Resize()
  PaGlobal_Arsha_Replay_Party_All:createTeamUi_Personal()
end
function FromClient_Arsha_Replay_Party_All_Clear()
  PaGlobal_Arsha_Replay_Party_All:clearTeamUi()
end
function FromClient_Arsha_Replay_Party_All_UpdateScore(teamNo, score)
  PaGlobal_Arsha_Replay_Party_All:updateScore(teamNo, score)
end
function FromClient_Arsha_Replay_Party_All_UpdateFightState(state, isNotify)
  PaGlobal_Arsha_Replay_Party_All:updateFightState(state, isNotify)
end
function FromClient_Arsha_Replay_Party_All_AlertRemainHp(teamNo, score, redTeamHp, blueTeamHp)
  PaGlobal_Arsha_Replay_Party_All:AlertRemainHp(teamNo, score, redTeamHp, blueTeamHp)
end
