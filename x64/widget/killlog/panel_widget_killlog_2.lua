function FromClient_Widget_KillLog_UpdatePerFrame(deltaTime)
  PaGlobal_Widget_KillLog:updateLogPerFrame(deltaTime)
end
function FromClient_Widget_KillLog_OnScreenResize()
  PaGlobal_Widget_KillLog:screenResize()
end
function PaGlobal_Widget_KillLog_AddLog(logType, attacker, attackee, guildName, isAlly)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local name = selfPlayer:getName()
  local originalName = selfPlayer:getOriginalName()
  local nickName = selfPlayer:getUserNickname()
  if logType == PaGlobal_Widget_KillLog._eLogType.solrare then
    PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, isAlly)
    return
  end
  if logType == PaGlobal_Widget_KillLog._eLogType.roseWar then
    PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, isAlly)
    return
  end
  if logType == PaGlobal_Widget_KillLog._eLogType.guildMatch then
    PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, isAlly)
    return
  end
  if logType == PaGlobal_Widget_KillLog._eLogType.destroyShipOnOceanSiege then
    attackee = attackee .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_KILLLOG_ADD_STRING_TYPE_SHIP_OCEANSIEGE")
    PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, isAlly)
    return
  end
  if ToClient_namelessPVPServer() == true then
    PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, isAlly)
    return
  end
  if true == _ContentsGroup_NameTypeEqually then
    local nameType = ToClient_getChatNameType()
    if __eChatNameType_NickName == nameType then
      if attacker ~= nickName then
        return
      end
    elseif attacker ~= name and attacker ~= originalName then
      return
    end
  elseif attacker ~= name and attacker ~= originalName then
    return
  end
  PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName, false)
end
