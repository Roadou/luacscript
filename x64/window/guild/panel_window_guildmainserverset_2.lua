function PaGlobalFunc_GuildMainServerSet_Open()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  PaGlobal_GuildMainServerSet:prepareOpen()
end
function PaGlobalFunc_GuildMainServerSet_Close()
  if nil == Panel_Guild_MainServerSet_All then
    return
  end
  PaGlobal_GuildMainServerSet:prepareClose()
end
function PaGlobalFunc_GuildMainServerSet_ListCreateControl(content, key)
  local index = Int64toInt32(key)
  local groupButton = UI.getChildControl(content, "RadioButton_MainServerList")
  if nil == groupButton then
    return
  end
  local serverInfo = ToClient_GetNormalServerInfoByIndex(index)
  if 0 == serverInfo._serverNo then
    groupButton:SetShow(false)
    return
  end
  local groupName = ToClient_GetNormalServerGuildGroupNo(serverInfo._guildServerGroupNo)
  if nil == groupName then
    local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
    groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  end
  if PaGlobal_GuildMainServerSet._selectIndex == index then
    groupButton:SetCheck(true)
  else
    groupButton:SetCheck(false)
  end
  groupButton:SetText(groupName)
  UI.setLimitTextAndAddTooltip(groupButton)
  groupButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMainServerSet_CheckServer(" .. index .. ")")
end
function HandleEventLUp_GuildMainServerSet_CheckServer(index)
  PaGlobal_GuildMainServerSet._selectIndex = index
  PaGlobal_GuildMainServerSet._ui.btn_confirm:SetIgnore(false)
  PaGlobal_GuildMainServerSet._ui.btn_confirm:SetMonoTone(false)
end
function HandleEventLUp_GuildMainServerSet_SetServer()
  local index = PaGlobal_GuildMainServerSet._selectIndex
  if -1 == index then
    return
  end
  local serverInfo = ToClient_GetNormalServerInfoByIndex(index)
  if 0 == serverInfo._serverNo then
    return
  end
  if isUseTotalAccountVer2() == true then
    local getAccessNationServerString = serverInfo:getAccessibleNation()
    if getAccessNationServerString ~= "" and getAccessNationServerString ~= ToClient_getEnteredNationString() then
      return
    end
  end
  local function setGuildMainServer()
    ToClient_SetGuildMainServerGroup(serverInfo._guildServerGroupNo, serverInfo._serverNo)
  end
  local groupName = ToClient_GetNormalServerGuildGroupNo(serverInfo._guildServerGroupNo)
  if nil == groupName then
    local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
    groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local coolTime = ToClient_GetGuildMainServerCoolTime()
  local contentString = ""
  local oneDay = 86400
  if coolTime >= oneDay then
    local day = math.ceil(coolTime / oneDay)
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_DAY", "name", tostring(groupName), "day", tostring(day))
  else
    local hour = math.ceil(coolTime / 3600)
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_HOUR", "name", tostring(groupName), "hour", tostring(hour))
  end
  contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CONFIRM_MESSAGE_NORMAL", "name", tostring(groupName))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = setGuildMainServer,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, nil, nil, false)
end
function FromClient_GuildMainServerSet_ChangeGuildMainServer(isSet)
  if false == isSet then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if false == isGuildMaster then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildMainServerGroupNo = guildWrapper:getGuildMainServerGroupNo()
  if 0 == guildMainServerGroupNo then
    return
  end
  local serverInfo = ToClient_GetNormalServerInfoByGroupNo(guildMainServerGroupNo)
  if 0 == serverInfo._serverNo then
    return
  end
  local channelName = getChannelName(serverInfo._worldNo, serverInfo._serverNo)
  local groupName = PaGlobalFunc_Util_GetServerGroupName(channelName)
  local completeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVERSET_CHANGE_COMPLETE", "name", tostring(groupName))
  Proc_ShowMessage_Ack(completeString)
  PaGlobalFunc_GuildMainServerSet_Close()
end
