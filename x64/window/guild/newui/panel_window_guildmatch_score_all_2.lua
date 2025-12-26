function PaGlobalFunc_GuildMatchScore_Open()
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_GuildMatchScore_PerFrameUpdate(deltaTime)
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function PaGlobalFunc_GuildMatchScore_checkShowGuildMatchScoreUI()
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  if Panel_Window_GuildMatchScore_All:GetShow() == false then
    PaGlobalFunc_GuildMatchScore_Open()
  end
end
function PaGlobalFunc_GuildMatchScore_updateGuildMatchCurrentState(currentState)
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:setGuildMatchCurrentState(currentState)
end
function PaGlobalFunc_GuildMatchScore_updateGuildMatchGuildName(myGuildName, enemyGuildName)
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:updateGuildName(myGuildName, enemyGuildName)
end
function PaGlobalFunc_GuildMatchScore_updateGuildMatchTeamPoint(killerTeam, killerTeamPoint, enemyTeam, enemyTeamPoint, isKillerMyTeam)
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:updateGuildMatchTeamPoint(killerTeam, killerTeamPoint, enemyTeam, enemyTeamPoint, isKillerMyTeam)
end
function PaGlobalFunc_GuildMatchScore_refreshGuildMatchTeamPoint()
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:updateScore()
end
function PaGlobalFunc_GuildMatchScore_showResult(isWin, prevScore, afterScore)
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  self:showResult(isWin, prevScore, afterScore)
end
function HandleEventLUp_GuildMatchScore_OnClickedLeave()
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  ToClient_UnJoinInstanceFieldForAll()
end
function PaGlobalFunc_GuildMatchScore_OnScreenResize()
  local self = PaGlobal_GuildMatchScore
  if self == nil then
    return
  end
  if Panel_Window_GuildMatchScore_All:GetShow() == false then
    return
  end
  self:onScreenResize()
end
