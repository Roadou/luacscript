function PaGlobal_GuildQuest_ListCreate_All()
  PaGlobal_GuildQuestList_All:updateQuestList()
end
function FromClient_GuildQuest_List2Update(content, key)
  local key32 = Int64toInt32(key)
  local questInfo
  if PaGlobal_GuildQuestList_All._guildQuestType == -1 then
    questInfo = ToClient_RequestRandomProgressGuildQuestOtherServerAt(key32)
  else
    questInfo = ToClient_RequestGuildQuestAt(key32)
  end
  if questInfo == nil then
    return
  end
  local stc_quest = UI.getChildControl(content, "Static_Main")
  local stc_questIcon = UI.getChildControl(stc_quest, "Static_QuestIcon")
  local txt_title = UI.getChildControl(stc_quest, "StaticText_QuestTitle")
  local txt_desc = UI.getChildControl(stc_quest, "StaticText_QuestDesc")
  local txt_condition = UI.getChildControl(stc_quest, "StaticText_QuestCondition")
  local txt_time = UI.getChildControl(stc_quest, "StaticText_QuestLimitTime")
  local txt_funds = UI.getChildControl(stc_quest, "StaticText_QuestGuildFunds")
  local rewardSlots = {}
  for index = 0, PaGlobal_GuildQuestList_All._defaultRewardSlotCount - 1 do
    local slotBgBase = UI.getChildControl(stc_quest, "Static_SlotBg_" .. index)
    rewardSlots[index] = {
      slotBg = slotBgBase,
      icon = UI.getChildControl(slotBgBase, "Static_ItemIcon"),
      count = UI.getChildControl(slotBgBase, "StaticText_ItemCount"),
      border = UI.getChildControl(slotBgBase, "Static_ItemBorder")
    }
  end
  rewardSlots[11].slotBg:SetIgnore(true)
  rewardSlots[11].icon:SetShow(false)
  rewardSlots[11].count:SetShow(false)
  rewardSlots[11].border:SetShow(false)
  local slotIndex = 0
  local isMoneyShow = false
  for rewardIndex = 0, PaGlobal_GuildQuestList_All._defaultRewardSlotCount - 1 do
    local baseReward = questInfo:getGuildQuestBaseRewardAt(rewardIndex)
    if baseReward ~= nil then
      rewardSlots[slotIndex].slotBg:SetIgnore(false)
      local itemCount = baseReward:getItemCount()
      if baseReward:getType() == __eRewardItem then
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(baseReward:getItemEnchantKey()))
        if itemSSW:get()._key:getItemKey() == 1 then
          txt_funds:SetText(makeDotMoney(itemCount))
          isMoneyShow = true
        else
          PaGlobal_GuildQuestList_All:setReward(baseReward, rewardSlots[slotIndex].icon, slotIndex)
          rewardSlots[slotIndex].icon:SetShow(true)
          if itemSSW:get():isStackableXXX() == true then
            rewardSlots[slotIndex].count:SetText(tostring(itemCount))
            rewardSlots[slotIndex].count:SetShow(true)
          else
            rewardSlots[slotIndex].count:SetShow(false)
          end
          SlotItem:setItemBorder(rewardSlots[slotIndex].border, itemSSW:getGradeType())
          slotIndex = slotIndex + 1
        end
      else
        PaGlobal_GuildQuestList_All:setReward(baseReward, rewardSlots[slotIndex].icon, slotIndex)
        rewardSlots[slotIndex].icon:SetShow(true)
        rewardSlots[slotIndex].count:SetShow(false)
        slotIndex = slotIndex + 1
      end
    else
      rewardSlots[slotIndex].slotBg:SetIgnore(true)
      rewardSlots[slotIndex].icon:SetShow(false)
      rewardSlots[slotIndex].count:SetShow(false)
      rewardSlots[slotIndex].border:SetShow(false)
      slotIndex = slotIndex + 1
    end
  end
  local btn_accept = UI.getChildControl(content, "Button_Sub")
  local txt_accept = UI.getChildControl(btn_accept, "StaticText_QuestAccept")
  stc_quest:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Open_QuestInfo_All(" .. key32 .. ")")
  if PaGlobal_GuildQuestList_All._isConsole == true then
    btn_accept:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildQuest_Open_QuestInfo_All(" .. key32 .. ")")
    btn_accept:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_GuildQuest_ReqestMemberBonus_All()")
  end
  if PaGlobal_GuildQuestList_All._guildQuestType ~= -1 then
    btn_accept:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_AcceptQuest_All(" .. key32 .. ")")
  end
  stc_questIcon:ChangeTextureInfoNameAsync(questInfo:getIconPath())
  local requireGuildRank = questInfo:getGuildQuestGrade()
  local requireGuildRankStr = ""
  if requireGuildRank == 1 then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif requireGuildRank == 2 then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif requireGuildRank == 3 then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  elseif requireGuildRank == 4 then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  txt_title:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", questInfo:getTitle(), "requireGuildRankStr", requireGuildRankStr))
  txt_desc:SetText(questInfo:getDesc())
  txt_condition:SetText(questInfo:getConditionDesc())
  UI.setLimitTextAndAddTooltip(txt_title, txt_title:GetText())
  UI.setLimitTextAndAddTooltip(txt_condition, txt_condition:GetText())
  if PaGlobal_GuildQuestList_All._guildQuestType == -1 then
    local curChannelData = getCurrentChannelServerData()
    btn_accept:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelSelect_All_MoveChannelByServerNo(" .. curChannelData._worldNo .. "," .. questInfo._serverNo .. ")")
    btn_accept:SetIgnore(false)
    btn_accept:SetEnable(true)
    btn_accept:SetMonoTone(false)
    local limitMinutes = questInfo:getRemainedTime() / 60
    txt_accept:SetText(getChannelName(curChannelData._worldNo, questInfo._serverNo))
    txt_time:SetText(PaGlobal_GuildQuest_GetQuestTimeFormatString(limitMinutes))
    return
  end
  txt_accept:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_C_ACCEPT"))
  txt_time:SetText(PaGlobal_GuildQuest_GetQuestTimeFormatString(questInfo:getLimitMinute()))
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local enableQuestCount = myGuildInfo:getAvaiableGuildQuestCount()
  local isProgressing = ToClient_isProgressingGuildQuest()
  local isRightQuestAccept = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightQuestAccept = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Quest)
  else
    isRightQuestAccept = PaGlobalFunc_GuildQuest_All_RightCheck(__eGuildRightType_QuestAccept)
  end
  if isRightQuestAccept == true and isProgressing == false then
    if enableQuestCount > 0 or PaGlobal_GuildQuestList_All._guildQuestType == __eGuildQuestType_Arbitration then
      btn_accept:SetIgnore(false)
      btn_accept:SetEnable(true)
      btn_accept:SetMonoTone(false)
      if PaGlobal_GuildQuestList_All._isConsole == true then
        btn_accept:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_AcceptQuest_All(" .. key32 .. ")")
      end
      txt_accept:SetFontColor(Defines.Color.C_FFFFFFFF)
    else
      btn_accept:SetMonoTone(true)
      if PaGlobal_GuildQuestList_All._isConsole == true then
        btn_accept:addInputEvent("Mouse_LUp", "")
      else
        btn_accept:SetIgnore(true)
        btn_accept:SetEnable(false)
      end
    end
  else
    btn_accept:SetMonoTone(true)
    if PaGlobal_GuildQuestList_All._isConsole == true then
      btn_accept:addInputEvent("Mouse_LUp", "")
    else
      btn_accept:SetIgnore(true)
      btn_accept:SetEnable(false)
    end
  end
end
function HandleEvent_GuildQuest_TabMove(isLeft)
  local questType = PaGlobal_GuildQuestList_All._guildQuestType
  if isLeft == true then
    PaGlobal_GuildQuestList_All._BtnIdx = PaGlobal_GuildQuestList_All._BtnIdx - 1
    if PaGlobal_GuildQuestList_All._BtnIdx < 0 then
      PaGlobal_GuildQuestList_All._BtnIdx = PaGlobal_GuildQuestList_All._BtnCount - 1
    end
  else
    PaGlobal_GuildQuestList_All._BtnIdx = PaGlobal_GuildQuestList_All._BtnIdx + 1
    if PaGlobal_GuildQuestList_All._BtnIdx > PaGlobal_GuildQuestList_All._BtnCount - 1 then
      PaGlobal_GuildQuestList_All._BtnIdx = 0
    end
  end
  HandleEventLUp_GuildQuest_SelectType(PaGlobal_GuildQuestList_All._BtnIdx)
end
function HandleEventLUp_GuildQuest_SelectType(btnIdx)
  local oldIdx = PaGlobal_GuildQuestList_All._guildQuestType
  if btnIdx < PaGlobal_GuildQuestList_All._BtnCount - 1 then
    PaGlobal_GuildQuestList_All._guildQuestType = btnIdx - 1
  else
    PaGlobal_GuildQuestList_All._guildQuestType = btnIdx
  end
  if PaGlobal_GuildQuestList_All._guildQuestType == oldIdx then
    return
  end
  PaGlobal_GuildQuestList_All:selectType(btnIdx)
  PaGlobal_GuildQuestList_All:resetList()
end
function HandleEventOnOut_GuildQuest_Type_ShowSimpleTooltip(isShow, tipType)
  if isShow == false or tipType == nil then
    TooltipSimple_Hide()
    return
  end
  local name
  if tipType == 0 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUEST_QUESTTYPE_PROGRESS")
  elseif tipType == 1 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUEST_QUESTTYPE_BATTLE")
  elseif tipType == 2 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUEST_QUESTTYPE_LIFE")
  elseif tipType == 3 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUEST_QUESTTYPE_TRADE")
  elseif tipType == 4 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUEST_QUESTTYPE_BOSSBATTLE")
  end
  if tipType < 0 or tipType > 4 then
    UI.ASSERT_NAME(false, "Tooltop tipType is invalid = " .. tostring(tipType), "-")
    return
  end
  TooltipSimple_Show(PaGlobal_GuildQuestList_All._rdo_Button[tipType], name, nil, false)
end
function HandleEventLUp_GuildQuest_SelectCheck()
  PaGlobal_GuildQuestList_All:resetList()
end
function PaGlobal_GuildQuest_SelectCheck(checkType)
  PaGlobal_GuildQuestList_All:selectCheck(checkType)
  PaGlobal_GuildQuestList_All:resetList()
end
function PaGlobal_GuildQuest_UpdateProgressQuest()
  PaGlobal_GuildQuestList_All:updateProgressQuest()
end
function HandleEventLUp_GuildQuest_Open_QuestInfo_All(key)
  PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All(key)
end
function HandleEventLUp_GuildQuest_AcceptQuest_All(key)
  local function AcceptGuildQuest()
    local quest = ToClient_RequestGuildQuestAt(key)
    ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuestList_All._guildQuestType, quest._questIndex, 0)
    if Panel_GuildQuestInfo_All:GetShow() == true then
      PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
    end
  end
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
  PaGlobal_GuildQuestList_All._isReqeustMemberBonus = true
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
  if doHaveCashGuildQuestItem == true then
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
function HandleEventLUp_GuildQuest_Open_AcceptHistory()
  HandleEventLUp_Warehouse_All_GuildWareHouseHistory()
  PaGlobal_GuildWareHouseHistory:selectTab(PaGlobal_GuildWareHouseHistory._eTabType.QUESTACCEPT)
end
function FromClient_GuildQuest_All_Update()
  PaGlobal_GuildQuestList_All:updateAll()
end
function FromClient_GuildQuest_All_UpdateOtherServerQuest()
  if PaGlobal_GuildQuestList_All._parentBG:GetShow() == false then
    return
  end
  if ToClient_GetMyGuildInfoWrapper() == nil then
    return
  end
  if PaGlobal_GuildQuestList_All._guildQuestType == -1 then
    PaGlobal_GuildQuestList_All._ui.list2_Quest:getElementManager():clearKey()
    local myGuildProgressQuestOtherServerListCount = ToClient_RequestProgressGuildQuestOtherServerCount()
    for index = 0, myGuildProgressQuestOtherServerListCount - 1 do
      local quest = ToClient_RequestRandomProgressGuildQuestOtherServerAt(index)
      local guildQuestType = quest:getGuildQuestType()
      if guildQuestType ~= __eGuildQuestType_Arbitration then
        PaGlobal_GuildQuestList_All._ui.list2_Quest:getElementManager():pushKey(index)
      end
    end
    PaGlobal_GuildQuestList_All:updateAll()
  end
end
function FromClient_GuildQuest_UpdateGuildMemberBonus()
  if PaGlobal_GuildQuestList_All._parentBG:GetShow() == false then
    return
  end
  if PaGlobal_GuildQuestList_All._isReqeustMemberBonus == true then
    PaGlobal_GuildQuestList_All._isReqeustMemberBonus = false
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
  if myGuildInfo ~= nil then
    ToClient_RequestGuildQuestList(false)
  end
  PaGlobal_GuildQuestList_All._latestRefreshGuildQuestTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuestList_All._startRefreshQuestTick32 = 0
  PaGlobal_GuildQuestList_All._remainRestrictTime_s64 = toInt64(0, 0)
  PaGlobal_GuildQuestList_All._startRestrictCheckTick32 = 0
  PaGlobal_GuildQuestList_All._ui.txt_ProgressQuestName:SetShow(true)
  PaGlobal_GuildQuestList_All:resetList()
  PaGlobal_GuildQuestList_All:updateAll()
end
function PaGlobalFunc_Guild_Quest_All_RequestMemberBonus_Confirm()
  ToClient_RequestGuildMemberBonus(false)
end
function PaGlobal_GuildQuest_GetQuestInfo_ByIndex(key)
  if PaGlobal_GuildQuestList_All._guildQuestType == -1 then
    return ToClient_RequestRandomProgressGuildQuestOtherServerAt(key)
  else
    return ToClient_RequestGuildQuestAt(key)
  end
end
function PaGlobal_GuildQuest_GetCurrentType()
  return PaGlobal_GuildQuestList_All._guildQuestType
end
function PaGlobal_GuildQuest_IsCheckedGrade(checkIndex)
  if checkIndex == nil then
    return
  end
  return PaGlobal_GuildQuestList_All._chk_Button[checkIndex]:IsCheck()
end
function PaGlobal_GuildQuest_GetQuestInfo_GiveUp()
  ToClient_RequestGuildQuestGiveup()
  PaGlobal_GuildQuestInfo_Close_All()
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
    local timeValue2 = timeValue % 60
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
    questTimeControl = PaGlobal_GuildQuestList_All._ui.txt_ArbitrationQuestTime
  else
    questTimeControl = PaGlobal_GuildQuestList_All._ui.txt_ProgressQuestTime
  end
  local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
  local strMinute = math.floor(remainTime / 60)
  if remainTime <= 0 then
    questTimeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
  else
    questTimeControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
  end
end
