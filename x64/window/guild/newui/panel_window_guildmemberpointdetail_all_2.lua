function PaGlobal_GuildMemberPointDetail_All_Open(index)
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildMemberPointDetail_All._memberIndex = index
  ToClient_RequestGuildActivityPointList()
end
function PaGlobal_GuildMemberPointDetail_All_LoadGuildActivityPoint()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  if PaGlobal_GuildMemberPointDetail_All._memberIndex == nil or PaGlobal_GuildMemberPointDetail_All._memberIndex == -1 then
    return
  end
  PaGlobal_GuildMemberPointDetail_All:prepareOpen(PaGlobal_GuildMemberPointDetail_All._memberIndex)
end
function PaGlobal_GuildMemberPointDetail_All_Close()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  PaGlobal_GuildMemberPointDetail_All:prepareClose()
end
function PaGlobal_GuildMemberPointDetail_All_Update()
  if nil == Panel_Window_GuildMemberPointDetail_All then
    return false
  end
  if Panel_Window_GuildMemberPointDetail_All:GetShow() == false then
    return
  end
  PaGlobal_GuildMemberPointDetail_All:update()
end
function HandleEventScroll_GuildMemberPointDetail_All_Scroll(isUp)
  if nil == Panel_Window_GuildMemberPointDetail_All then
    return false
  end
  if isUp == nil then
    return
  end
  if Panel_Window_GuildMemberPointDetail_All:GetShow() == false then
    return
  end
  local memberCount = 10
  UIScroll.ScrollEvent(PaGlobal_GuildMemberPointDetail_All._ui.scroll_vs, isUp, memberCount, memberCount, 0, 1)
  PaGlobal_GuildMemberPointDetail_All_Update()
end
function PaGlobal_GuildMemberPointDetail_All_OpenInfo(isSendAll, userNoStr, index, uiIndex)
  if nil == Panel_Window_GuildMemberPointDetail_All then
    return
  end
  if isSendAll == nil or userNoStr == nil or index == nil or uiIndex == nil then
    return
  end
  local userNo_s64 = tonumber64(userNoStr)
  local listWrapper = ToClient_GetGuildActivityPoint(userNo_s64, index)
  if listWrapper == nil then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if isSendAll == true then
    control = PaGlobal_GuildMemberPointDetail_All._ui._allSendList[uiIndex]
  else
    control = PaGlobal_GuildMemberPointDetail_All._ui._requestList[uiIndex]
  end
  local stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_UNAPPROVED_TOOLTIPTITLE")
  if listWrapper:getConfirmType() == 1 then
    stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_APPROVAL_TOOLTIPNAME")
  elseif listWrapper:getConfirmType() == 2 then
    stateStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_RETURN_TOOLTIPNAME")
  end
  local content = listWrapper:getContents()
  if content == "" then
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(listWrapper:getOptionType() + 1))
  end
  name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINT_TOOLTIPNAME", "name", listWrapper:getRequestUserName())
  desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_GUILD_POINT_NAMEDESC", "state", stateStr, "point", tostring(listWrapper:getPoint()), "contents", content, "day", getTimeYearMonthDayHourMinSecByTTime64(listWrapper:getRegistDate()))
  if nil == control or nil == name or nil == desc then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_GuildMemberPointDetail_All_HideInfo()
  if nil == Panel_Window_GuildMemberPointDetail_All then
    return
  end
  TooltipSimple_Hide()
end
