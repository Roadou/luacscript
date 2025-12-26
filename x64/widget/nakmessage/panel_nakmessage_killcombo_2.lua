function FromClient_UpdateGuildMatchStreak(attackerName, killStreak, remainNextStreakTime, isKillerMyTeam, isKillerMe)
  local self = PaGlobal_NakMessage_KillCombo
  if self == nil then
    return
  end
  local killStreakLogMessage
  if isKillerMyTeam == true then
    if killStreak == 2 then
      killStreakLogMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_DUO", "killerPlayer", attackerName) .. "<PAOldColor>"
    elseif killStreak == 3 then
      killStreakLogMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_TRIO", "killerPlayer", attackerName) .. "<PAOldColor>"
    elseif killStreak == 4 then
      killStreakLogMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_QUARTET", "killerPlayer", attackerName) .. "<PAOldColor>"
    elseif killStreak >= 5 then
      killStreakLogMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_QUINTET", "killerPlayer", attackerName) .. "<PAOldColor>"
    end
  elseif killStreak == 2 then
    killStreakLogMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_DUO", "killerPlayer", attackerName) .. "<PAOldColor>"
  elseif killStreak == 3 then
    killStreakLogMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_TRIO", "killerPlayer", attackerName) .. "<PAOldColor>"
  elseif killStreak == 4 then
    killStreakLogMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_QUARTET", "killerPlayer", attackerName) .. "<PAOldColor>"
  elseif killStreak >= 5 then
    killStreakLogMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMATCH_KILLSTREAK_QUINTET", "killerPlayer", attackerName) .. "<PAOldColor>"
  end
  if killStreakLogMessage ~= nil then
    chatting_sendMessage("", killStreakLogMessage, CppEnums.ChatType.Battle)
  end
  if isKillerMe == true then
    self:updateGuildMatchStreak(killStreak)
  end
end
function PaGlobal_NakMessage_KillCombo_UpdateFunc(deltaTime)
  local self = PaGlobal_NakMessage_KillCombo
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_NotifyGuildMatchFirstKill(guildName, point)
  local self = PaGlobal_NakMessage_KillCombo
  if self == nil then
    return
  end
  local firstKillLogMessage = "<PAColor0xFFFFFFFF>" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDMATCH_FIRSTKILL", "guildName", guildName, "point", point) .. "<PAOldColor>"
  if firstKillLogMessage ~= nil then
    chatting_sendMessage("", firstKillLogMessage, CppEnums.ChatType.Battle)
  end
  self:showFirstKill(guildName, point)
end
