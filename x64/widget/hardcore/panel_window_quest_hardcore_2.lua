function PaGlobal_HardCoreQuestDetails_ShowAni()
  if PaGlobal_HardCoreQuestDetails == nil then
    return
  end
end
function PaGlobal_HardCoreQuestDetails_HideAni()
  if PaGlobal_HardCoreQuestDetails == nil then
    return
  end
end
function PaGlobal_HardCoreQuestDetails_Open()
  if PaGlobal_HardCoreQuestDetails == nil then
    return
  end
  PaGlobal_HardCoreQuestDetails:prepareOpen()
end
function PaGlobal_HardCoreQuestDetails_Close()
  if PaGlobal_HardCoreQuestDetails == nil then
    return
  end
  PaGlobal_HardCoreQuestDetails:prepareClose()
end
function PaGlobal_HardCoreQuestDetails_UpdateQuestInfo()
  local self = PaGlobal_HardCoreQuestDetails
  if self == nil then
    return
  end
  self:updateQuest(index)
end
function PaGlobal_HardCoreQuestDetails_QuestInfo(index)
  local self = PaGlobal_HardCoreQuestDetails
  if self == nil then
    return
  end
  self:openQuestInfo(index)
end
function PaGlobal_HardCoreQuestDetails_QuestNavi(index)
  local self = PaGlobal_HardCoreQuestDetails
  if self == nil then
    return
  end
  self:findQuestNavi(index)
end
function PaGlobal_HardCoreQuestDetails_QuestGiveUp(groupId, questId)
  local QuestGiveUpConfirm = function()
    QuestWidget_QuestGiveUp_Confirm()
  end
  FGlobal_PassGroupIdQuestId(groupId, questId)
  local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "GUILD_MESSAGEBOX_TITLE")
  local messageboxContent = PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_REAL_GIVEUP_QUESTION")
  local messageboxData = {
    title = messageboxTitle,
    content = messageboxContent,
    functionYes = QuestGiveUpConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandlePadEventX_QuestInfo_All_HardCoreRewardItemTooltip(index)
  local self = PaGlobal_HardCoreQuestDetails
  if self == nil then
    return
  end
  local reward = self._baseReward[index + 1]
  if nil == reward then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._key))
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function rewardTooltip_ForHardCoreQuestWindow(rewardType, isShow, questIndex, index, key, value)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local self = PaGlobal_HardCoreQuestDetails
  if self == nil then
    return
  end
  local name, desc = "", ""
  local control = self._ui._questUI[questIndex]._itemSlotBg[index]
  if "Exp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP")
  elseif "SkillExp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP")
  elseif "ExpGrade" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP_GRADE")
  elseif "SkillExpGrade" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP_GRADE")
  elseif "ProductExp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP")
  end
  TooltipSimple_Show(control, name, desc)
end
