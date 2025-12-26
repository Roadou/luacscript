function PaGlobalFunc_Guild_BossSummon_All_Update()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:update()
end
function PaGlobalFunc_Guild_BossSummon_All_CreateControlList2(content, key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:updateList(content, key)
end
function PaGlobalFunc_Guild_BossSummon_All_UpdateRemoveTime()
  if Panel_Guild_BossSummon_All == nil then
    return
  end
  PaGlobal_Guild_BossSummon_All:updateGuildBossFieldRemoveTime()
end
function PaGlobalFunc_Guild_BossSummon_All_UpdateMirrorFieldState()
  if Panel_Guild_BossSummon_All == nil or Panel_Guild_BossSummon_All:GetShow() == false then
    return
  end
  local bossList = ToClient_bossSpawnList()
  if bossList == nil then
    return
  end
  for ii = 0, #bossList do
    local key = bossList[ii]:get()
    if key ~= nil then
      PaGlobal_Guild_BossSummon_All:updateState(key)
    end
  end
end
function HandleEventLUp_Guild_BossSummon_All_SelectLevel(key, isNext)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key or nil == isNext then
    return
  end
  PaGlobal_Guild_BossSummon_All:selectLevel(key, isNext)
end
function HandleEventLUp_Guild_BossSummon_All_RequestFindPosition(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:requestFindPosition(key)
end
function HandleEventLUp_Guild_BossSummon_All_RequestGuildBossSpawn(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:requestGuildBossSpawn(key)
end
function HandleEventOnOut_Guild_BossSummon_All_ShowItemTooltip(key, itemEnchantKey, isShow)
  if nil == Panel_Guild_BossSummon_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  PaGlobal_Guild_BossSummon_All:showItemTooltip(key, itemEnchantKey, isShow)
end
function HandleEventOnOut_Guild_BossSummon_All_ShowConsoleItemTooltip(key, itemEnchantKey)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  PaGlobal_Guild_BossSummon_All:showItemTooltip_Console(key, itemEnchantKey)
end
function HandleEventMOnOut_Guild_BossSummon_All_ShowDpadKeyGuide(showDpad, showY)
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(showY, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMPETITIONGAME_BTN_SUMMON"))
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(showDpad, __eConsoleUIPadEvent_DpadLeft, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSUMMON_LEVELSETTING_KEYGUIDE"))
end
function HandleEventLUp_Guild_BossSummon_All_EnterToGuildBossField(key)
  if Panel_Guild_BossSummon_All == nil then
    return
  end
  if _ContentsGroup_GuildBossField == false then
    return
  end
  local bossKey = BossSpawnKey(key)
  if bossKey == nil then
    return
  end
  if PaGlobal_GuildBossField_Enter_All_CheckChangeState == nil or PaGlobal_GuildBossField_Enter_All_CheckChangeState(bossKey, true, false) == false then
    return
  end
  local function enterToGuildBossField()
    if PaGlobal_GuildBossField_Enter_All_CheckChangeState(bossKey, true, true) == false then
      return
    end
    ToClient_EnterOrLeaveGuildBossField(true, bossKey)
    if HandleEventLUp_GuildMain_All_Close ~= nil then
      HandleEventLUp_GuildMain_All_Close()
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBOSS_ENTER_DESC", "bossName", PaGlobal_Guild_BossSummon_All._bossInfoList[key].txt_BossName:GetText()),
    functionYes = enterToGuildBossField,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  local keyUse = _ContentsGroup_UsePadSnapping == true
  MessageBox.showMessageBox(messageBoxData, nil, false, keyUse)
end
function HandleEventLUp_Guild_BossSummon_All_LeaveFromGuildBossField(key)
  if Panel_Guild_BossSummon_All == nil then
    return
  end
  if _ContentsGroup_GuildBossField == false then
    return
  end
  local bossKey = BossSpawnKey(key)
  if bossKey == nil then
    return
  end
  if PaGlobal_GuildBossField_Enter_All_CheckChangeState == nil or PaGlobal_GuildBossField_Enter_All_CheckChangeState(bossKey, false, false) == false then
    return
  end
  local function leaveFromGuildBossField()
    if PaGlobal_GuildBossField_Enter_All_CheckChangeState(bossKey, false, true) == false then
      return
    end
    ToClient_EnterOrLeaveGuildBossField(false, bossKey)
    if HandleEventLUp_GuildMain_All_Close ~= nil then
      HandleEventLUp_GuildMain_All_Close()
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBOSS_EXIT_DESC", "bossName", PaGlobal_Guild_BossSummon_All._bossInfoList[key].txt_BossName:GetText()),
    functionYes = leaveFromGuildBossField,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  local keyUse = _ContentsGroup_UsePadSnapping == true
  MessageBox.showMessageBox(messageBoxData, nil, false, keyUse)
end
function FromClient_BossSummon_All_UpdateStatus(key)
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  if nil == key then
    return
  end
  PaGlobal_Guild_BossSummon_All:updateState(key)
end
function FromClient_BossSummon_All_ClearCount()
  if nil == Panel_Guild_BossSummon_All then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_GUILDRAID_SUMMON_RESET"))
end
