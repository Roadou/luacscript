function HandleCliekedGuildQuestReward()
  PaGlobal_GuildQuestInfo_All._isProgressingQuest = true
  PaGlobal_GuildQuestInfo_All:prepareOpen(nil, nil)
end
function HandlePadEventX_GuildQuestInfo_All_ItemTooltip(itemKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemStatic then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0)
end
function HandleEventLUp_GuildQuestInfo_AcceptQuest_All()
  local AcceptGuildQuest = function()
    if _ContentsGroup_GuildQuestAndSkillImprove == true then
      if PaGlobal_GuildQuestList_All._guildQuestType == __eGuildQuestType_Arbitration then
        local enemyGuildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(PaGlobal_GuildQuestList_All._targetArbitrationGuildWarringListIndex)
        ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuestList_All._guildQuestType, PaGlobal_GuildQuestInfo_All._acceptQuestIndex, enemyGuildNo)
      else
        ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuestList_All._guildQuestType, PaGlobal_GuildQuestInfo_All._acceptQuestIndex, 0)
      end
    elseif PaGlobal_GuildQuest_All._guildQuestType == __eGuildQuestType_Arbitration then
      local enemyGuildNo = ToClient_GetDeclareGuildWarToMyGuild_s64(PaGlobal_GuildQuest_All._targetArbitrationGuildWarringListIndex)
      ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuest_All._guildQuestType, PaGlobal_GuildQuestInfo_All._acceptQuestIndex, enemyGuildNo)
    else
      ToClient_RequestGuildQuestAccept(PaGlobal_GuildQuest_All._guildQuestType, PaGlobal_GuildQuestInfo_All._acceptQuestIndex, 0)
    end
    if Panel_GuildQuestInfo_All:GetShow() then
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
function FromClient_GuildQuestInfo_UpdateProgressingQuest_All()
  if false == Panel_GuildQuestInfo_All:GetShow() then
    return
  end
  PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
end
function PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All(key)
  PaGlobal_GuildQuestInfo_All._isProgressingQuest = false
  PaGlobal_GuildQuestInfo_All._currentQuestKey = key
  PaGlobal_GuildQuestInfo_All:prepareOpen(nil, nil)
end
function PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All_ByQuestNo(questNo, historyIdx)
  PaGlobal_GuildQuestInfo_All._isProgressingQuest = false
  PaGlobal_GuildQuestInfo_All:prepareOpen(questNo, historyIdx)
  PaGlobal_GuildQuestInfo_All:ComputePos()
end
function PaGlobal_GuildQuestInfo_Close_All()
  PaGlobal_GuildQuestInfo_All:prepareClose()
end
