function PaGlobalFunc_GrowPath_Info_Close()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  PaGlobal_GrowthPass_Info_ShowItemTooptip(nil, false)
  PaGlobal_GrowthPass_Info:prepareClose()
end
function PaGlobalFunc_GrowPath_Info_Show(questInfoWrapper, questInfoControl, isForceShow)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  PaGlobal_GrowthPass_Info:prepareOpen(questInfoWrapper, questInfoControl, isForceShow)
end
function PaGlobalFunc_GrowthPass_Info_OnClickedQuestionRewardIcon(questGroup, questId)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  local questState = ToClient_getGrowthPassQuestState(questGroup, questId)
  if questState ~= __eGrowthPass_QuestState_Complete then
    return
  end
  ToClient_requestClearGrowthPassQuest(questGroup, questId)
  PaGlobal_GrowthPass_Info._ui._btn_reward:SetMonoTone(true)
end
function PaGlobal_GrowthPass_Info_ShowItemTooptip(rewardItemKeyRaw, isShow)
  if nil == Panel_Window_GrowthPass_Info or nil == PaGlobal_GrowthPass_Info then
    return
  end
  local self = PaGlobal_GrowthPass_Info
  self._isShowTooltip = isShow
  if false == isShow then
    if false == self._isConsole then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  local rewardItemKey = ItemEnchantKey(rewardItemKeyRaw)
  local rewardItemSSW = getItemEnchantStaticStatus(rewardItemKey)
  if nil == rewardItemSSW then
    return
  end
  if false == self._isConsole then
    Panel_Tooltip_Item_Show(rewardItemSSW, PaGlobal_GrowthPass_Info._ui._itemSlot.icon, true, false)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, rewardItemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobalFunc_GrowthPass_Info_OnClickedKeyguideA()
  if nil == Panel_Window_GrowthPass_Info or nil == PaGlobal_GrowthPass_Info then
    return
  end
  local self = PaGlobal_GrowthPass_Info
  if false == self._isPadMode or false == self._ui._consoleKeyguide_X:GetShow() then
    return
  end
  if nil == self._cachedQuestGroupRaw or nil == self._cachedQuestIdRaw then
    return
  end
  PaGlobalFunc_GrowthPass_Info_OnClickedQuestionRewardIcon(self._cachedQuestGroupRaw, self._cachedQuestIdRaw)
end
function PaGlobalFunc_GrowthPass_Info_OnClickedKeyguideX()
  if nil == Panel_Window_GrowthPass_Info or nil == PaGlobal_GrowthPass_Info then
    return
  end
  local self = PaGlobal_GrowthPass_Info
  if false == self._isPadMode or false == self._ui._consoleKeyguide_X:GetShow() then
    return
  end
  if nil == self._cachedRewardItemKeyRaw then
    return
  end
  PaGlobal_GrowthPass_Info_ShowItemTooptip(self._cachedRewardItemKeyRaw, not self._isShowTooltip)
end
function PaGlobal_GrowthPass_Info_GetShow()
  if nil == Panel_Window_GrowthPass_Info then
    return false
  end
  return Panel_Window_GrowthPass_Info:GetShow()
end
