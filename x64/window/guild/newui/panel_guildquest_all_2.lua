function HandleEventLUp_GuildQuest_PageMove(isLeft)
  if isLeft then
    if 0 < PaGlobal_GuildQuest_All._currentPage then
      PaGlobal_GuildQuest_All._currentPage = PaGlobal_GuildQuest_All._currentPage - 1
    end
  elseif PaGlobal_GuildQuest_All._maxPageCount > PaGlobal_GuildQuest_All._currentPage + 1 then
    PaGlobal_GuildQuest_All._currentPage = PaGlobal_GuildQuest_All._currentPage + 1
  end
  PaGlobal_GuildQuest_All:updateCurrentPage()
end
function HandleEvent_GuildQuest_TabMove(isLeft)
  local questType = PaGlobal_GuildQuest_All._guildQuestType
  if questType == __eGuildQuestType_Arbitration then
    return
  end
  if isLeft then
    questType = questType - 1
    if questType < 0 then
      questType = 2
    end
  else
    questType = questType + 1
    if questType > 2 then
      questType = 0
    end
  end
  HandleEventLUp_GuildQuest_SelectType(questType)
end
function HandleEventLUp_GuildQuest_SelectType(questType)
  if PaGlobal_GuildQuest_All._guildQuestType == questType then
    return
  end
  PaGlobal_GuildQuest_All:selectTab(questType)
  PaGlobal_GuildQuest_All:resetPage()
end
function HandleEventLUp_GuildQuest_Open_QuestInfo_All(index)
  PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All(PaGlobal_GuildQuest_All._currentPage * PaGlobal_GuildQuest_All._qeustListMaxShowCount + index + 1)
end
function HandleEventLUp_GuildQuest_AcceptQuest_All(index)
  local AcceptGuildQuest = function()
    if PaGlobal_GuildQuest_All._guildQuestType == __eGuildQuestType_Arbitration then
      local enemyGuildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(PaGlobal_GuildQuest_All._targetArbitrationGuildWarringListIndex)
      ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuest_All._guildQuestType, PaGlobal_GuildQuest_All._currentQuestListData[PaGlobal_GuildQuest_All._acceptIndex + 1]._questIndex, enemyGuildNo)
    else
      ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuest_All._guildQuestType, PaGlobal_GuildQuest_All._currentQuestListData[PaGlobal_GuildQuest_All._acceptIndex + 1]._questIndex, 0)
    end
    if Panel_GuildQuestInfo_All:GetShow() then
      PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
    end
  end
  PaGlobal_GuildQuest_All._acceptIndex = PaGlobal_GuildQuest_All._currentPage * 4 + index
  local messageboxData = {
    title = "",
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_QUESTACCEPT"),
    functionYes = AcceptGuildQuest,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_GuildQuest_ReqestMemberBonus_All()
  PaGlobal_GuildQuest_All._isReqeustMemberBonus = true
  ToClient_RequestGuildMemberBonusShow()
end
function HandleEventLUp_GuildQuest_Giveup()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GIVERUP_MESSAGE_0"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GIVERUP_MESSAGE_1"),
    functionYes = PaGlobal_GuildQuest_GetQuestInfo_GiveUp,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_GuildQuest_Clear()
  local doHaveCashGuildQuestItem = doHaveContentsItem(CppEnums.ContentsEventType.ContentsType_AddGuildQuestReward, 0, false)
  if true == doHaveCashGuildQuestItem then
    local messageboxData = {
      title = "",
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_CLEAR_USEITEM"),
      functionYes = HandleEventLUp_GuildQuest_Clear_UseItem,
      functionNo = HandleEventLUp_GuildQuest_Clear_DontUseItem,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    HandleEventLUp_GuildQuest_Clear_DontUseItem()
  end
end
function HandleEventLUp_GuildQuest_Clear_UseItem()
  ToClient_RequestGuildQuestComplete(true)
  PaGlobal_GuildQuestInfo_Close_All()
end
function HandleEventLUp_GuildQuest_Clear_DontUseItem()
  ToClient_RequestGuildQuestComplete(false)
  PaGlobal_GuildQuestInfo_Close_All()
end
function FromClient_GuildQuest_All_Update()
  if nil ~= myGuildInfo and PaGlobal_GuildQuest_All._parentBG:GetShow() then
    ToClient_RequestGuildQuestList(false)
  end
  PaGlobal_GuildQuest_All:updateAll()
end
function FromClient_GuildQuest_UpdateGuildMemberBonus()
  if false == PaGlobal_GuildQuest_All._parentBG:GetShow() then
    return
  end
  if true == PaGlobal_GuildQuest_All._isReqeustMemberBonus then
    PaGlobal_GuildQuest_All._isReqeustMemberBonus = false
    local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_GETGUILDMEMBERBONUS", "money", makeDotMoney(getSelfPlayer():getGuildMemberBonus())) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PENSION_NOTICE")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GETGUILDMEMBERBONUS_TITLE"),
      content = messageboxMemo,
      functionApply = PaGlobalFunc_Guild_Quest_All_RequestMemberBonus_Confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBoxCheck.showMessageBox(messageboxData)
  end
end
function PaGlobalFunc_Guild_Quest_All_FirstUpdate()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildInfo then
    ToClient_RequestGuildQuestList(false)
  end
  PaGlobal_GuildQuest_All._latestRefreshGuildQuestTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuest_All._startRefreshQuestTick32 = 0
  PaGlobal_GuildQuest_All._remainRestrictTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuest_All._startRestrictCheckTick32 = 0
  for ii = 0, 2 do
    PaGlobal_GuildQuest_All._rdo_Tab[ii]:SetShow(true)
  end
  PaGlobal_GuildQuest_All._rdo_Tab[3]:SetShow(false)
  PaGlobal_GuildQuest_All._ui.txt_ProgressQuestName:SetShow(true)
  PaGlobal_GuildQuest_All._ui.stc_ArbitratioBG:SetShow(false)
  PaGlobal_GuildQuest_All._targetArbitrationGuildWarringListIndex = PaGlobal_GuildQuest_All.UNDEFINED_WARRINGLISTINDEX
  PaGlobal_GuildQuest_All:selectTab(0)
  PaGlobal_GuildQuest_All._currentPage = 0
  PaGlobal_GuildQuest_All:updateAll()
end
function PaGlobalFunc_Guild_Quest_All_ArbitrationOpen(warringGuildIndex)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildInfo then
    ToClient_RequestGuildQuestList(false)
  end
  PaGlobal_GuildQuest_All._latestRefreshGuildQuestTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuest_All._startRefreshQuestTick32 = 0
  PaGlobal_GuildQuest_All._remainRestrictTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuest_All._startRestrictCheckTick32 = 0
  for ii = 0, 2 do
    PaGlobal_GuildQuest_All._rdo_Tab[ii]:SetShow(false)
  end
  PaGlobal_GuildQuest_All._rdo_Tab[3]:SetShow(true)
  PaGlobal_GuildQuest_All._targetArbitrationGuildWarringListIndex = warringGuildIndex
  PaGlobal_GuildQuest_All:selectTab(3)
  PaGlobal_GuildQuest_All._currentPage = 0
  PaGlobal_GuildQuest_All:updateAll()
end
function PaGlobalFunc_Guild_Quest_All_RequestMemberBonus_Confirm()
  ToClient_RequestGuildMemberBonus(false)
end
function PaGlobal_GuildQuest_GetQuestInfo_ByIndex(index)
  return PaGlobal_GuildQuest_All._currentQuestListData[index]
end
function PaGlobal_GuildQuest_GetQuestInfo_GiveUp()
  ToClient_RequestGuildQuestGiveup()
  PaGlobal_GuildQuestInfo_Close_All()
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(false, __eConsoleUIPadEvent_Y, "")
  PaGlobal_GuildMain_All:setKeyguideTextWithShow(false, __eConsoleUIPadEvent_X, "")
end
function PaGlobalFunc_GuildQuest_All_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
    local isMasters = true == isGuildSubMaster or true == isGuildMaster
    return isMasters
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
function PaGlobal_GuildQuest_GetQuestTimeFormatString(timeValue)
  if timeValue >= 60 then
    timeValue2 = timeValue % 60
    timeValue = timeValue / 60
    if 0 == timeValue2 then
      return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_HOUR")
    else
      return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_HOUR") .. string.format(" %d ", timeValue2) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_MINUTE")
    end
  else
    return string.format("%d ", timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_MINUTE")
  end
end
function PaGlobal_GuildQuest_UpdateRemainTime()
  if not ToClient_isProgressingGuildQuest() then
    return
  end
  local questTimeControl
  if ToClient_getCurrentGuildQuestType() == __eGuildQuestType_Arbitration then
    questTimeControl = PaGlobal_GuildQuest_All._ui.txt_ProgressQuestTime
  else
    questTimeControl = PaGlobal_GuildQuest_All._ui.txt_ArbitrationQuestTime
  end
  local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
  local strMinute = math.floor(remainTime / 60)
  if remainTime <= 0 then
    questTimeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
  else
    questTimeControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
  end
end
function FromClient_ResponsGuildQuestLastRefreshTickCount(tickCount_s64)
  if nil == Panel_GuildMain_All or false == PaGlobal_GuildQuest_All._parentBG:GetShow() then
    return
  end
  PaGlobal_GuildQuest_All._latestRefreshGuildQuestTime_s64 = tickCount_s64
  PaGlobal_GuildQuest_All._startRefreshQuestTick32 = getTickCount32()
  Panel_GuildMain_All:RegisterUpdateFunc("PaGlobal_GuildQuest_UpdateRemainRefreshTime")
end
function FromClient_GuildQuest_ResponsGuildQuestRemainRestrictTickCount(tickCount_s64)
  if nil == Panel_GuildMain_All or false == PaGlobal_GuildQuest_All._parentBG:GetShow() then
    return
  end
  PaGlobal_GuildQuest_All._remainRestrictTime_s64 = tickCount_s64
  PaGlobal_GuildQuest_All._startRestrictCheckTick32 = getTickCount32()
  Panel_GuildMain_All:RegisterUpdateFunc("PaGlobal_GuildQuest_UpdateRemainRefreshTime")
end
function PaGlobal_GuildQuest_UpdateRemainRefreshTime(deltaTime)
  if nil == Panel_GuildMain_All or false == PaGlobal_GuildQuest_All._parentBG:GetShow() then
    return
  end
  local currentTick32 = getTickCount32()
  local beforeRefreshTick = currentTick32 - PaGlobal_GuildQuest_All._startRefreshQuestTick32
  local tickCountRefresh_s64 = PaGlobal_GuildQuest_All._latestRefreshGuildQuestTime_s64 - toInt64(0, beforeRefreshTick)
  local beforeRestrictTick = currentTick32 - PaGlobal_GuildQuest_All._startRestrictCheckTick32
  local tickCountRestrict_s64 = PaGlobal_GuildQuest_All._remainRestrictTime_s64 - toInt64(0, beforeRestrictTick)
  PaGlobal_GuildQuest_All:setQuestRefreshTime(tickCountRefresh_s64)
  PaGlobal_GuildQuest_All:setQuestRestrictTime(tickCountRestrict_s64)
end
