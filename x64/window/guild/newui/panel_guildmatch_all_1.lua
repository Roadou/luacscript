function PaGlobal_GuildMatch:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_tabBg = UI.getChildControl(Panel_GuildMatch_All, "Static_TopTabArea")
  self._ui._rdo_tabBtn = {}
  self._ui._btn_currentTab = UI.getChildControl(self._ui._stc_tabBg, "Button_Select")
  self._ui._txt_subGroupPointDesc = UI.getChildControl(Panel_GuildMatch_All, "StaticText_SubGroupPointDesc")
  if _ContentsGroup_GuildMatchRenewMatching == true then
    for ii = 0, __eGuildMatchMatchingType_Count - 1 do
      self._ui._rdo_tabBtn[ii] = UI.getChildControl(self._ui._stc_tabBg, "StaticText_MatchingType_" .. tostring(ii))
      self._ui._rdo_tabBtn[ii]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_MATCHING_TYPE_" .. tostring(ii)))
    end
    self._ui._stc_tabBg:SetShow(true)
  else
    self._ui._stc_tabBg:SetShow(false)
  end
  self._ui._txt_record = UI.getChildControl(Panel_GuildMatch_All, "StaticText_Record")
  self._ui._txt_rankPoint = UI.getChildControl(Panel_GuildMatch_All, "StaticText_Point")
  self._ui._txt_mainState = UI.getChildControl(Panel_GuildMatch_All, "StaticText_State")
  self._ui._txt_subState = UI.getChildControl(Panel_GuildMatch_All, "StaticText_State_SubDesc")
  self._ui._btn_desc = UI.getChildControl(Panel_GuildMatch_All, "Button_LeftDesc")
  self._ui._stc_descArea = UI.getChildControl(Panel_GuildMatch_All, "Static_LeftDescArea")
  self._ui._btn_gameRecord = UI.getChildControl(Panel_GuildMatch_All, "Button_Record")
  self._ui._btn_gameRanking = UI.getChildControl(Panel_GuildMatch_All, "Button_Ranking")
  self._ui._btn_join = UI.getChildControl(Panel_GuildMatch_All, "Button_Reservation")
  self._ui._btn_enter = UI.getChildControl(Panel_GuildMatch_All, "Button_Enterance")
  self._ui._btn_exit = UI.getChildControl(Panel_GuildMatch_All, "Button_Quit")
  self._ui._stc_rewardIcon = UI.getChildControl(Panel_GuildMatch_All, "StaticText_RewardIcon")
  self._ui._stc_tooltipBg = UI.getChildControl(Panel_GuildMatch_All, "Static_ToolTipBg")
  local blueBg = UI.getChildControl(Panel_GuildMatch_All, "Static_BlueFlag")
  local myGuildBg = UI.getChildControl(blueBg, "Static_MyGuildMarkBG")
  self._ui._stc_myGuildMark = UI.getChildControl(myGuildBg, "Static_GuildMark")
  self._ui._txt_myGuildName = UI.getChildControl(myGuildBg, "StaticText_GuildName")
  local redBg = UI.getChildControl(Panel_GuildMatch_All, "Static_RedFlag")
  local enemyGuildBg = UI.getChildControl(redBg, "Static_OpponentGuildMarkBG")
  self._ui._stc_enemyGuildMark = UI.getChildControl(enemyGuildBg, "Static_GuildMark")
  self._ui._txt_enemyGuildName = UI.getChildControl(enemyGuildBg, "StaticText_GuildName")
  self._ui._stc_penalty = UI.getChildControl(self._ui._btn_join, "StaticText_PenaltyIcon")
  self._ui._frm_desc = UI.getChildControl(self._ui._stc_descArea, "Frame_Desc")
  local rankBtnSizeX = self._ui._btn_gameRanking:GetTextSizeX() + self._ui._btn_gameRanking:GetTextSpan().x
  local rankBtnSpanX = self._ui._btn_gameRanking:GetSpanSize().x
  if rankBtnSizeX >= rankBtnSpanX then
    local gap = rankBtnSizeX - rankBtnSpanX
    self._ui._btn_gameRanking:SetSpanSize(rankBtnSpanX + gap, self._ui._btn_gameRanking:GetSpanSize().y)
    self._ui._btn_gameRanking:ComputePos()
  end
  local termSpanX = 20
  local rewardBtnSizeX = self._ui._stc_rewardIcon:GetTextSizeX() + self._ui._stc_rewardIcon:GetTextSpan().x
  local rewardBtnPosLeft = self._ui._stc_rewardIcon:GetPosX()
  local rewardBtnPosRight = rewardBtnPosLeft + rewardBtnSizeX + termSpanX
  local rankBtnPosX = self._ui._btn_gameRanking:GetPosX()
  if rewardBtnPosRight >= rankBtnPosX then
    local gap = rewardBtnPosRight - rankBtnPosX
    self._ui._stc_rewardIcon:SetSpanSize(self._ui._stc_rewardIcon:GetSpanSize().x + gap, self._ui._stc_rewardIcon:GetSpanSize().y)
    self._ui._stc_rewardIcon:ComputePos()
  end
  self:initialize_rewardTooltip()
  self:initialize_descFrame()
  self:initialize_ClickAreaSize()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_GuildMatch:registEventHandler()
  if Panel_GuildMatch_All == nil then
    return
  end
  if _ContentsGroup_GuildMatchRenewMatching == true then
    for index = 0, __eGuildMatchMatchingType_Count - 1 do
      self._ui._rdo_tabBtn[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ChangeMatchingType(" .. tostring(index) .. ")")
    end
  end
  self._ui._btn_desc:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleDescription()")
  self._ui._btn_gameRecord:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleGameRecord()")
  self._ui._btn_gameRanking:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleGameRanking()")
  self._ui._btn_join:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_JoinMatch()")
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_EnterInstanceField()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_LeaveInstanceField()")
  self._ui._stc_rewardIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleRewardTooltip()")
  self._ui._stc_penalty:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_ShowPenaltyToolTip(true)")
  self._ui._stc_penalty:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_ShowPenaltyToolTip(false)")
  registerEvent("FromClient_RefreshParticipatedCount", "FromClient_RefreshParticipatedCount")
  registerEvent("FromClient_RefreshGuildMatchRecordText", "FromClient_RefreshGuildMatchRecordText")
  registerEvent("FromClient_RefreshGuildMatchButtonUI", "FromClient_RefreshGuildMatchButtonUI")
  registerEvent("FromClient_UpdateGuildMatchRecord", "FromClient_UpdateGuildMatchRecord")
  registerEvent("FromClient_LoadCompleteGuildMatchRankInfo", "FromClient_LoadCompleteGuildMatchRankInfo")
end
function PaGlobal_GuildMatch:prepareOpen()
  if Panel_GuildMatch_All == nil then
    return
  end
  self:changeMatchingMode(__eGuildMatchMatchingType_Main)
  self._ui._stc_descArea:SetShow(false)
  self:requestGuildMatchRoomList()
  self:requestUpdateServerData()
  self:updateStateText()
  self:updateButtonShowState()
  self:updateMyGuildInfo()
  self:updateEnemyGuildInfo()
  self:hideRewardTooltip()
  self:open()
end
function PaGlobal_GuildMatch:open()
  if Panel_GuildMatch_All == nil then
    return
  end
  Panel_GuildMatch_All:SetShow(true)
end
function PaGlobal_GuildMatch:initialize_rewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  local stc_rewardDesc = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_Desc")
  local bgSizeX = 0
  local bgSizeY = 0
  stc_rewardDesc:SetSize(stc_rewardDesc:GetSizeX(), stc_rewardDesc:GetTextSizeY())
  stc_rewardDesc:ComputePos()
  local winnerTeamplate = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Template1")
  local winnerItemName = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_ItemName1")
  local winnerRewardItemCount = ToClient_GetGuildMatchVictoryRewardCount()
  local winnerRewardValidCount = 0
  local showWinnerItemName = winnerRewardItemCount == 1
  for index = 0, winnerRewardItemCount - 1 do
    local rewardItemKey = ToClient_GetGuildMatchVictoryRewardItemKey(index)
    local itemCount_s64 = ToClient_GetGuildMatchVictoryRewardItemCount(index)
    local winnerRewardItemBg = UI.cloneControl(winnerTeamplate, self._ui._stc_tooltipBg, "Static_SlotBg_Winner_" .. tostring(index))
    local winnerRewardItemSlot = {}
    SlotItem.new(winnerRewardItemSlot, "RewardIcon", 0, winnerRewardItemBg, self._slotConfig)
    winnerRewardItemSlot:createChild()
    winnerRewardItemSlot:clearItem()
    winnerRewardItemSlot.icon:SetPosX(0)
    winnerRewardItemSlot.icon:SetPosY(0)
    winnerRewardItemSlot.icon:SetSize(44, 44)
    winnerRewardItemSlot.icon:SetHorizonLeft()
    winnerRewardItemSlot.icon:SetVerticalTop()
    local itemSSW = getItemEnchantStaticStatus(rewardItemKey)
    if itemSSW ~= nil then
      winnerRewardItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, nil)
      winnerRewardItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_RewardItem(true, true, " .. tostring(index) .. ")")
      winnerRewardItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_RewardItem(true, false, " .. tostring(index) .. ")")
      winnerRewardItemBg:SetShow(true)
      winnerRewardItemBg:SetSpanSize(10 * (winnerRewardValidCount + 1) + winnerRewardValidCount * 44, winnerRewardItemBg:GetSpanSize().y)
      winnerRewardItemBg:ComputePos()
      winnerRewardValidCount = winnerRewardValidCount + 1
    else
      winnerRewardItemBg:SetShow(false)
    end
    if showWinnerItemName == true then
      winnerItemName:SetText(itemSSW:getName() .. " x " .. tostring(itemCount_s64))
      winnerItemName:SetSize(winnerItemName:GetTextSizeX(), winnerItemName:GetSizeY())
      winnerItemName:ComputePos()
      winnerItemName:SetShow(true)
    else
      winnerItemName:SetShow(false)
    end
  end
  local loserTeamplate = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Template2")
  local loserItemName = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_ItemName2")
  local loserRewardItemCount = ToClient_GetGuildMatchDepeatRewardCount()
  local loserRewardValidCount = 0
  local showLoserItemName = loserRewardItemCount == 1
  for index = 0, loserRewardItemCount - 1 do
    local rewardItemKey = ToClient_GetGuildMatchDepeatRewardItemKey(index)
    local itemCount_s64 = ToClient_GetGuildMatchDepeatRewardItemCount(index)
    local loserRewardItemBg = UI.cloneControl(loserTeamplate, self._ui._stc_tooltipBg, "Static_SlotBg_Loser_" .. tostring(index))
    local loserRewardItemSlot = {}
    SlotItem.new(loserRewardItemSlot, "RewardIcon", 0, loserRewardItemBg, self._slotConfig)
    loserRewardItemSlot:createChild()
    loserRewardItemSlot:clearItem()
    loserRewardItemSlot.icon:SetPosX(0)
    loserRewardItemSlot.icon:SetPosY(0)
    loserRewardItemSlot.icon:SetSize(44, 44)
    loserRewardItemSlot.icon:SetHorizonLeft()
    loserRewardItemSlot.icon:SetVerticalTop()
    local itemSSW = getItemEnchantStaticStatus(rewardItemKey)
    if itemSSW ~= nil then
      loserRewardItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, nil)
      loserRewardItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_RewardItem(false, true, " .. tostring(index) .. ")")
      loserRewardItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_RewardItem(false, false, " .. tostring(index) .. ")")
      loserRewardItemBg:SetShow(true)
      loserRewardItemBg:SetSpanSize(10 * (loserRewardValidCount + 1) + loserRewardValidCount * 44, loserRewardItemBg:GetSpanSize().y)
      loserRewardItemBg:ComputePos()
      loserRewardValidCount = loserRewardValidCount + 1
    else
      loserRewardItemBg:SetShow(false)
    end
    if showLoserItemName == true then
      loserItemName:SetText(itemSSW:getName() .. " x " .. tostring(itemCount_s64))
      loserItemName:SetSize(loserItemName:GetTextSizeX(), loserItemName:GetSizeY())
      loserItemName:ComputePos()
      loserItemName:SetShow(true)
    else
      loserItemName:SetShow(false)
    end
  end
  local rewardCountMax = math.max(winnerRewardValidCount, loserRewardValidCount)
  bgSizeX = winnerTeamplate:GetSizeX() * rewardCountMax + winnerTeamplate:GetSpanSize().x * (rewardCountMax + 1)
  bgSizeX = math.max(bgSizeX, stc_rewardDesc:GetSpanSize().x * 2 + stc_rewardDesc:GetSizeX())
  if showWinnerItemName == true then
    bgSizeX = math.max(bgSizeX, winnerItemName:GetSpanSize().x * 2 + winnerItemName:GetSizeX())
  end
  if showLoserItemName == true then
    bgSizeX = math.max(bgSizeX, loserItemName:GetSpanSize().x * 2 + loserItemName:GetSizeX())
  end
  bgSizeY = stc_rewardDesc:GetSpanSize().y + stc_rewardDesc:GetSizeY() + 10
  self._ui._stc_tooltipBg:SetSize(bgSizeX, bgSizeY)
  self._ui._stc_tooltipBg:SetSpanSize((self._ui._stc_tooltipBg:GetSizeX() + 10) * -1, self._ui._stc_tooltipBg:GetSpanSize().y)
  self._ui._stc_tooltipBg:ComputePos()
end
function PaGlobal_GuildMatch:initialize_descFrame()
  if Panel_GuildMatch_All == nil then
    return
  end
  local frameContent = UI.getChildControl(self._ui._frm_desc, "Frame_1_Content")
  local txt_desc = UI.getChildControl(frameContent, "StaticText_Desc")
  local frameVScroll = self._ui._frm_desc:GetVScroll()
  txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_DESC_1"))
  txt_desc:SetSize(frameContent:GetSizeX() - frameVScroll:GetSizeX() - 15, txt_desc:GetTextSizeY())
  txt_desc:SetHorizonLeft()
  txt_desc:SetVerticalTop()
  txt_desc:SetSpanSize(15, 5)
  txt_desc:ComputePos()
  frameContent:SetSize(frameContent:GetSizeX(), txt_desc:GetSizeY() + 10)
  frameVScroll:SetControlPos(0)
  self._ui._frm_desc:UpdateContentPos()
  if self._ui._frm_desc:GetSizeY() < frameContent:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_GuildMatch:initialize_ClickAreaSize()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._btn_desc:SetEnableArea(0, 0, self._ui._btn_desc:GetSizeX() + self._ui._btn_desc:GetTextSizeX() + 15, self._ui._btn_desc:GetSizeY())
  self._ui._btn_gameRecord:SetEnableArea(0, 0, self._ui._btn_gameRecord:GetSizeX() + self._ui._btn_gameRecord:GetTextSizeX() + 15, self._ui._btn_gameRecord:GetSizeY())
  self._ui._btn_gameRanking:SetEnableArea(0, 0, self._ui._btn_gameRanking:GetSizeX() + self._ui._btn_gameRanking:GetTextSizeX() + 15, self._ui._btn_gameRanking:GetSizeY())
  self._ui._stc_rewardIcon:SetEnableArea(0, 0, self._ui._stc_rewardIcon:GetSizeX() + self._ui._stc_rewardIcon:GetTextSizeX() + 15, self._ui._stc_rewardIcon:GetSizeY())
end
function PaGlobal_GuildMatch:changeMatchingMode(matchingType)
  if Panel_GuildMatch_All == nil then
    return
  end
  if _ContentsGroup_GuildMatchRenewMatching == false then
    return
  end
  local tabBtn = self._ui._rdo_tabBtn[matchingType]
  if tabBtn == nil then
    return
  end
  self._currentMatchingType = matchingType
  local tabCenterPosX = tabBtn:GetPosX() + tabBtn:GetSizeX() / 2
  self._ui._btn_currentTab:SetPosX(tabCenterPosX - self._ui._btn_currentTab:GetSizeX() / 2)
  self._ui._btn_currentTab:SetText(tabBtn:GetText())
  self:updateButtonShowState()
  self:updateStateText()
  self:updateEnemyGuildInfo()
  local isMainMatching = self._currentMatchingType == __eGuildMatchMatchingType_Main
  self._ui._txt_record:SetShow(isMainMatching == true)
  self._ui._txt_rankPoint:SetShow(isMainMatching == true)
  self._ui._txt_subGroupPointDesc:SetShow(isMainMatching == false)
end
function PaGlobal_GuildMatch:showRewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._stc_tooltipBg:SetShow(true)
end
function PaGlobal_GuildMatch:hideRewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._stc_tooltipBg:SetShow(false)
end
function PaGlobal_GuildMatch:updateButtonShowState()
  if Panel_GuildMatch_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfPlayerProxy = selfPlayer:get()
  if selfPlayerProxy == nil then
    return
  end
  local isHaveGuildMatchAuthority = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isHaveGuildMatchAuthority = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_GuildDuel)
  else
    local isGuildMemberGrade_Master = selfPlayerProxy:isGuildMaster()
    local isGuildMemberGrade_SubMaster = selfPlayerProxy:isGuildSubMaster()
    local isGuildMemberGrade_Adviser = selfPlayerProxy:isGuildAdviser()
    local isGuildMemberGrade_ChiefOfStaff = selfPlayerProxy:isGuildChiefOfStaff()
    local isGuildMemberGrade_Scribe = selfPlayerProxy:isGuildScribe()
    isHaveGuildMatchAuthority = isGuildMemberGrade_Master == true or isGuildMemberGrade_SubMaster == true or isGuildMemberGrade_Adviser == true or isGuildMemberGrade_ChiefOfStaff == true or isGuildMemberGrade_Scribe == true
  end
  if ToClient_isInInstanceField(__eInstanceContentsType_GuildMatch) == true then
    self._ui._btn_join:SetShow(false)
    self._ui._btn_enter:SetShow(false)
    self._ui._btn_exit:SetShow(true)
  else
    local state = ToClient_GetGuildMachPlayState(self._currentMatchingType)
    if state == __eGuildMatchPlayState_Play then
      self._ui._btn_join:SetShow(false)
      self._ui._btn_enter:SetShow(true)
      self._ui._btn_exit:SetShow(false)
    else
      self._ui._btn_enter:SetShow(false)
      self._ui._btn_exit:SetShow(false)
      if isHaveGuildMatchAuthority == true then
        if state == __eGuildMatchPlayState_None then
          self._ui._btn_join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_REQUESTMATCH_BTN"))
          self._ui._btn_join:SetShow(true)
        elseif state == __eGuildMatchPlayState_Join then
          self._ui._btn_join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_CANCELMATCH_BTN"))
          self._ui._btn_join:SetShow(true)
        else
          self._ui._btn_join:SetShow(false)
        end
      else
        self._ui._btn_join:SetShow(false)
      end
    end
  end
end
function PaGlobal_GuildMatch:requestUpdateServerData()
  if Panel_GuildMatch_All == nil then
    return
  end
  local currentTickCount = getTickCount32()
  if self._serverDataUpdateTimeSec * 1000 < currentTickCount - self._lastRequestServerTickCount then
    ToClient_RequestUpdateGuildMatchRecordFromServer()
    ToClient_RequestUpdateGuildMatchPersonalRecordFromServer()
    self._lastRequestServerTickCount = currentTickCount
  end
end
function PaGlobal_GuildMatch:updateStateText()
  if Panel_GuildMatch_All == nil then
    return
  end
  local state = ToClient_GetGuildMachPlayState(self._currentMatchingType)
  local mainStateString, subStateString
  if _ContentsGroup_GuildMatchSeason == false then
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_6")
    subStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_DESC_10")
  elseif self._isAppliedPenalty == true then
    local leftTimeString = ""
    local currentTime_s64 = getUtc64()
    local remainTimeSecond = Int64toInt32(self._penaltyTime - currentTime_s64)
    local oneDay = 86400
    local oneHour = 3600
    local oneMinute = 60
    local day = math.floor(remainTimeSecond / oneDay)
    if day <= 0 then
      day = 0
    end
    remainTimeSecond = remainTimeSecond - day * oneDay
    local hour = math.floor(remainTimeSecond / oneHour)
    if hour <= 0 then
      hour = 0
    end
    remainTimeSecond = remainTimeSecond - hour * oneHour
    local min = math.floor(remainTimeSecond / oneMinute)
    if min <= 0 then
      min = 0
    end
    remainTimeSecond = remainTimeSecond - min * oneMinute
    local sec = math.floor(remainTimeSecond)
    if sec <= 0 then
      sec = 0
    end
    if day > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_DAY", "day", day) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", hour)
    elseif hour > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", hour) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", min)
    elseif min > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", min)
    elseif sec > 0 then
      leftTimeString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_UNDER_ONEMINUTE")
    else
      UI.ASSERT_NAME(false, "\234\184\184\235\147\156 \235\166\172\234\183\184 \237\142\152\235\132\144\237\139\176 \236\162\133\235\163\140\234\185\140\236\167\128 \235\130\168\236\157\128\236\139\156\234\176\132\236\157\180 \236\157\180\236\131\129\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_5")
    subStateString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_3", "leftTime", leftTimeString)
  elseif state == __eGuildMatchPlayState_None or state == __eGuildMatchPlayState_Join then
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_4")
    subStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_1")
  elseif state == __eGuildMatchPlayState_Play then
    local currentEnterCount = ToClient_GetGuildMatchParticipatedCount(self._currentMatchingType)
    local maxEnterCount = ToClient_GetGuildMatchParticipatedMaxCount()
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_2")
    subStateString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_2", "currentCount", currentEnterCount, "maxCount", maxEnterCount)
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \236\131\129\237\131\156\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    mainStateString = ""
    subStateString = ""
  end
  self._ui._txt_mainState:SetText(mainStateString)
  self._ui._txt_subState:SetText(subStateString)
end
function PaGlobal_GuildMatch:requestGuildMatchRoomList()
  if Panel_GuildMatch_All == nil then
    return
  end
  ToClient_requestInstanceFieldRoomList(true, __eInstanceContentsType_GuildMatch)
end
function PaGlobal_GuildMatch:updateMyGuildInfo()
  if Panel_GuildMatch_All == nil then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    self._ui._stc_myGuildMark:SetShow(false)
    self._ui._txt_myGuildName:SetText("")
    UI.ASSERT_NAME(false, "\235\130\180 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui._stc_myGuildMark:SetShow(true)
  self:setGuildMark(myGuildInfo:getGuildNo_s64(), self._ui._stc_myGuildMark)
  self._ui._txt_myGuildName:SetText(myGuildInfo:getName())
end
function PaGlobal_GuildMatch:updateEnemyGuildInfo()
  if Panel_GuildMatch_All == nil then
    return
  end
  local state = ToClient_GetGuildMachPlayState(self._currentMatchingType)
  if state == __eGuildMatchPlayState_None or state == __eGuildMatchPlayState_Join then
    self._ui._stc_enemyGuildMark:SetShow(false)
    self:setGuildMark(nil, self._ui._stc_enemyGuildMark)
    self._ui._txt_enemyGuildName:SetShow(false)
  elseif state == __eGuildMatchPlayState_Play then
    self._ui._stc_enemyGuildMark:SetShow(true)
    self:setGuildMark(ToClient_GetGuildMatchEnemyGuildNoRaw(self._currentMatchingType), self._ui._stc_enemyGuildMark)
    self._ui._txt_enemyGuildName:SetText(ToClient_getGuildMatchEnemyGuildName(self._currentMatchingType))
    self._ui._txt_enemyGuildName:SetShow(true)
  end
end
function PaGlobal_GuildMatch:setGuildMark(guildNoRaw, control)
  if Panel_GuildMatch_All == nil then
    return
  end
  local isSet = false
  if guildNoRaw ~= nil then
    isSet = setGuildTextureByGuildNo(guildNoRaw, control)
  end
  if isSet == false then
    control:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 183, 1, 188, 6)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  else
    control:getBaseTexture():setUV(0, 0, 1, 1)
  end
  control:setRenderTexture(control:getBaseTexture())
end
