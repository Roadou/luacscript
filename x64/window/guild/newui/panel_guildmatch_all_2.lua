function PaGlobalFunc_GuildMatch_Open()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_GuildMatch_OpenByMenu()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if _ContentsGroup_GuildMatch == false then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseItemNotExistGuild"))
    return
  end
  if PaGlobal_GuildMain_All ~= nil then
    PaGlobalFunc_GuildMain_All_Open()
    HandleEventLUp_GuildMain_All_ClickOtherTab(PaGlobal_GuildMain_All._eTABINDEX._GUILDMATCH)
  end
end
function PaGlobalFunc_GuildMatch_JoinMatch()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if _ContentsGroup_GuildMatchSeason == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotOpenedGuildMatchSeason"))
    return
  end
  local state = ToClient_GetGuildMachPlayState(self._currentMatchingType)
  if state == __eGuildMatchPlayState_None then
    ToClient_RequestJoinGuildMatch(self._currentMatchingType)
  elseif state == __eGuildMatchPlayState_Join then
    ToClient_RequestCancelJoinGuildMatch(self._currentMatchingType)
  elseif state == __eGuildMatchPlayState_Play then
    UI.ASSERT_NAME(false, "\234\184\184\235\147\156 \235\166\172\234\183\184\234\176\128 \236\167\132\237\150\137 \236\164\145\236\157\188 \235\149\140 \235\167\164\236\185\173\236\157\132 \236\139\160\236\178\173\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  else
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \234\184\184\235\147\156 \235\166\172\234\183\184 \236\139\160\236\178\173 \236\131\129\237\131\156\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164 . \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function PaGlobalFunc_GuildMatch_EnterInstanceField()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if _ContentsGroup_GuildMatchSeason == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotOpenedGuildMatchSeason"))
    return
  end
  if PaGlobalFunc_GuildMain_All_CheckIsMecernary() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEHERO_JOIN_CANCEL"))
    return
  end
  local roomIndex = ToClient_GetGuildMatchRoomIndex(self._currentMatchingType)
  if roomIndex < 0 then
    return
  end
  ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_GuildMatch, roomIndex)
end
function PaGlobalFunc_GuildMatch_LeaveInstanceField()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  ToClient_UnJoinInstanceFieldForAll()
end
function HandleEventLUp_GuildMatch_ToggleRewardTooltip()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if self._ui._stc_tooltipBg:GetShow() == true then
    self:hideRewardTooltip()
  else
    self:showRewardTooltip()
  end
end
function HandleEventOnOut_GuildMatch_ShowPenaltyToolTip(isShow)
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if self._penaltyCount == nil then
    return
  end
  if self._penaltyTime == nil then
    return
  end
  if self._ui._stc_penalty:GetShow() == false then
    return
  end
  local name = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_PENALTY_TOOLTIPNAME", "count", self._penaltyCount)
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_PENALTY_TOOLTIPDESC")
  TooltipSimple_Show(self._ui._stc_penalty, name, desc)
end
function HandleEventLUp_GuildMatch_ChangeMatchingType(matchingType)
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self:changeMatchingMode(matchingType)
end
function HandleEventLUp_GuildMatch_ToggleDescription()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self._ui._frm_desc:GetVScroll():SetControlPos(0)
  self._ui._frm_desc:UpdateContentPos()
  local isShowDesc = self._ui._stc_descArea:GetShow() == true
  self._ui._stc_descArea:SetShow(isShowDesc == false)
end
function HandleEventLUp_GuildMatch_ToggleGameRecord()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if PaGlobalFunc_GuildMatchGameRecord_IsShow() == true then
    PaGlobalFunc_GuildMatchGameRecord_Close()
  else
    PaGlobalFunc_GuildMatchGameRecord_Open()
  end
end
function HandleEventLUp_GuildMatch_ToggleGameRanking()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if PaGlobalFunc_GuildMatchRank_IsShow() == true then
    PaGlobalFunc_GuildMatchRank_Close()
  else
    ToClient_RequestLoadGuildMatchRankInfo()
  end
end
function HandleEventOnOut_GuildMatch_RewardItem(isWinnerReward, isShow, rewardIndex)
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW, control
  if isWinnerReward == true then
    local slotBg = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Winner_" .. tostring(rewardIndex))
    control = UI.getChildControl(slotBg, "Static_RewardIcon")
    local rewardItemKey = ToClient_GetGuildMatchVictoryRewardItemKey(rewardIndex)
    itemSSW = getItemEnchantStaticStatus(rewardItemKey)
  else
    local slotBg = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Loser_" .. tostring(rewardIndex))
    control = UI.getChildControl(slotBg, "Static_RewardIcon")
    local rewardItemKey = ToClient_GetGuildMatchDepeatRewardItemKey(rewardIndex)
    itemSSW = getItemEnchantStaticStatus(rewardItemKey)
  end
  if itemSSW ~= nil and control ~= nil then
    Panel_Tooltip_Item_Show(itemSSW, control, true, false)
  end
end
function FromClient_RefreshGuildMatchRecordText()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self:requestUpdateServerData()
end
function FromClient_RefreshGuildMatchButtonUI()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self:updateButtonShowState()
  self:updateEnemyGuildInfo()
  self:updateStateText()
end
function FromClient_UpdateGuildMatchRecord(winCount, loseCount, penaltyCount, penaltyTime, rankPoint)
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self._isAppliedPenalty = false
  self._ui._txt_record:SetShow(true)
  self._ui._txt_record:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_RECORDVALUE", "winCount", winCount, "loseCount", loseCount))
  self._ui._txt_rankPoint:SetShow(true)
  self._ui._txt_rankPoint:SetText(tostring(rankPoint))
  if penaltyCount > 0 then
    self._penaltyCount = penaltyCount
    self._penaltyTime = penaltyTime
    self._ui._stc_penalty:SetText(penaltyCount)
    self._ui._stc_penalty:SetShow(true)
    local currentTime_s64 = getUtc64()
    local remainTimeSecond = Int64toInt32(self._penaltyTime - currentTime_s64)
    if remainTimeSecond > 0 then
      self._isAppliedPenalty = true
    end
  else
    self._penaltyCount = nil
    self._penaltyTime = nil
    self._ui._stc_penalty:SetText(0)
    self._ui._stc_penalty:SetShow(false)
  end
  self:updateStateText()
end
function FromClient_RefreshParticipatedCount()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  self:updateStateText()
end
function FromClient_LoadCompleteGuildMatchRankInfo()
  local self = PaGlobal_GuildMatch
  if self == nil then
    return
  end
  PaGlobalFunc_GuildMatchRank_Open()
end
