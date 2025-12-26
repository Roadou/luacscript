function PaGlobal_Window_SiegeResult_All:initialize()
  if PaGlobal_Window_SiegeResult_All._initialize == true then
    return
  end
  self._personalDataList = {}
  self._ui._stc_topMainArea = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_TopMainArea")
  self._ui._txt_resultTitle = UI.getChildControl(self._ui._stc_topMainArea, "StaticText_ResultTitle")
  self._ui._txt_result_date = UI.getChildControl(self._ui._stc_topMainArea, "StaticText_Result_Date")
  self._ui._stc_resultVisualize = UI.getChildControl(self._ui._stc_topMainArea, "Static_ResultVisualize")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_topMainArea, "Button_Close")
  self._ui._stc_middleSubArea = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_MiddleSubArea")
  self._ui._stc_joinArea = UI.getChildControl(self._ui._stc_middleSubArea, "Static_JoinArea")
  self._ui._txt_region = UI.getChildControl(self._ui._stc_joinArea, "StaticText_RegionValue")
  self._ui._txt_member = UI.getChildControl(self._ui._stc_joinArea, "StaticText_MemberValue")
  self._ui._stc_joinRewardArea = UI.getChildControl(self._ui._stc_middleSubArea, "Static_JoinRewardArea")
  self._ui._txt_rewardMoneyTitle = UI.getChildControl(self._ui._stc_joinRewardArea, "StaticText_RewardMoneyTitle")
  self._ui._txt_rewardMoney = UI.getChildControl(self._ui._stc_joinRewardArea, "StaticText_RewardMoney")
  self._ui._txt_rewardItemTitle = UI.getChildControl(self._ui._stc_joinRewardArea, "StaticText_GetRewardTitle")
  self._ui._stc_rewardTemplete = UI.getChildControl(self._ui._stc_joinRewardArea, "StaticText_PersonalReward_Template")
  self._ui._stc_joinTotalTimeArea = UI.getChildControl(self._ui._stc_middleSubArea, "Static_JoinTotalTimeArea")
  self._ui._txt_joinTime = UI.getChildControl(self._ui._stc_joinTotalTimeArea, "StaticText_JoinTimeValue")
  self._ui._txt_occupyTime = UI.getChildControl(self._ui._stc_joinTotalTimeArea, "StaticText_OccupyTimeValue")
  self._ui._stc_firstInfo = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_FirstInfo")
  self._ui._txt_firstTitleValue = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_TitleValue")
  self._ui._stc_firstInfo_txt_Ranking[1] = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_2")
  self._ui._stc_firstInfo_txt_Ranking[2] = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_3")
  self._ui._stc_firstInfo_txt_Ranking[3] = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_4")
  self._ui._stc_firstInfo_txt_Ranking[4] = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_5")
  self._ui._stc_firstInfo_txt_Ranking[5] = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_6")
  self._ui._stc_secondInfo = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_SecondInfo")
  self._ui._txt_secondTitleValue = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_TitleValue")
  self._ui._stc_secondInfo_txt_Ranking[1] = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_2")
  self._ui._stc_secondInfo_txt_Ranking[2] = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_3")
  self._ui._stc_secondInfo_txt_Ranking[3] = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_4")
  self._ui._stc_secondInfo_txt_Ranking[4] = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_5")
  self._ui._stc_secondInfo_txt_Ranking[5] = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_6")
  self._ui._stc_thirdInfo = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_ThirdInfo")
  self._ui._txt_thirdTitleValue = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_TitleValue")
  self._ui._stc_thirdInfo_txt_Ranking[1] = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_2")
  self._ui._stc_thirdInfo_txt_Ranking[2] = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_3")
  self._ui._stc_thirdInfo_txt_Ranking[3] = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_4")
  self._ui._stc_thirdInfo_txt_Ranking[4] = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_5")
  self._ui._stc_thirdInfo_txt_Ranking[5] = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_6")
  self._ui._stc_fifthInfo = UI.getChildControl(Panel_Window_SiegeResult_All, "Static_FifthInfo")
  self._ui._txt_fifthTitleValue = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_TitleValue")
  self._ui._stc_fifthInfo_txt_Ranking[1] = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_2")
  self._ui._stc_fifthInfo_txt_Ranking[2] = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_3")
  self._ui._stc_fifthInfo_txt_Ranking[3] = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_4")
  self._ui._stc_fifthInfo_txt_Ranking[4] = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_5")
  self._ui._stc_fifthInfo_txt_Ranking[5] = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_6")
  self._ui._stc_keyGuideBG = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_KeyGuide_B_ConsoleUI")
  local slot = {
    base = {}
  }
  slot.bg = UI.createAndCopyBasePropertyControl(self._ui._stc_joinRewardArea, "StaticText_PersonalReward_Template", self._ui._stc_joinRewardArea, "stc_rewardItem")
  slot.bg:SetShow(false)
  slot.bg:SetIgnore(false)
  SlotItem.new(slot.base, "SailorRestore_ItemSlot", ii, slot.bg, PaGlobal_Window_SiegeResult_All.slotConfig)
  slot.base:createChild()
  slot.base:clearItem()
  slot.base.icon:SetAlpha(1)
  slot.base.icon:SetIgnore(true)
  self._ui._rewardItemSlot = slot
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  PaGlobal_Window_SiegeResult_All:registEventHandler()
  PaGlobal_Window_SiegeResult_All:validate()
  PaGlobal_Window_SiegeResult_All:SetPosition()
  PaGlobal_Window_SiegeResult_All._initialize = true
end
function PaGlobal_Window_SiegeResult_All:registEventHandler()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SiegeResult_All_Close()")
  registerEvent("FromClient_ShowSiegeResult", "PaGlobalFunc_SiegeResult_All_ReqestNewestSiegeHistory()")
  registerEvent("FromClient_UpdateSiegeResult", "FromClient_UpdateSiegeResult()")
end
function PaGlobal_Window_SiegeResult_All:SetPosition()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  local firstTitle = UI.getChildControl(self._ui._stc_firstInfo, "StaticText_Title")
  local secondTitle = UI.getChildControl(self._ui._stc_secondInfo, "StaticText_Title")
  local thirdTitle = UI.getChildControl(self._ui._stc_thirdInfo, "StaticText_Title")
  local fifthTitle = UI.getChildControl(self._ui._stc_fifthInfo, "StaticText_Title")
  local firstIcon = UI.getChildControl(self._ui._stc_firstInfo, "Static_Icon")
  local secondIcon = UI.getChildControl(self._ui._stc_secondInfo, "Static_Icon")
  local thirdIcon = UI.getChildControl(self._ui._stc_thirdInfo, "Static_Icon")
  local fifthIcon = UI.getChildControl(self._ui._stc_fifthInfo, "Static_Icon")
  local spanX = 0
  local gap = 30
  if firstTitle:GetTextSizeX() > firstTitle:GetSizeX() then
    UI.setLimitTextAndAddTooltip(firstTitle, firstTitle:GetText(), "")
    firstTitle:SetSpanSize(40, firstTitle:GetSpanSize().y)
  else
    firstTitle:SetSize(firstTitle:GetTextSizeX() + 10, firstTitle:GetSizeY())
    spanX = (self._ui._stc_firstInfo:GetSizeX() - (firstTitle:GetTextSizeX() + gap)) / 2
    firstTitle:SetSpanSize(spanX + gap, firstTitle:GetSpanSize().y)
  end
  firstIcon:SetPosXY(firstTitle:GetPosX() - gap, firstTitle:GetPosY())
  if secondTitle:GetTextSizeX() > secondTitle:GetSizeX() then
    UI.setLimitTextAndAddTooltip(secondTitle, secondTitle:GetText(), "")
    secondTitle:SetSpanSize(40, secondTitle:GetSpanSize().y)
  else
    secondTitle:SetSize(secondTitle:GetTextSizeX() + 10, secondTitle:GetSizeY())
    spanX = (self._ui._stc_secondInfo:GetSizeX() - (secondTitle:GetTextSizeX() + gap)) / 2
    secondTitle:SetSpanSize(spanX + gap, secondTitle:GetSpanSize().y)
  end
  secondIcon:SetPosXY(secondTitle:GetPosX() - gap, secondTitle:GetPosY())
  if thirdTitle:GetTextSizeX() > thirdTitle:GetSizeX() then
    UI.setLimitTextAndAddTooltip(thirdTitle, thirdTitle:GetText(), "")
    thirdTitle:SetSpanSize(40, thirdTitle:GetSpanSize().y)
  else
    thirdTitle:SetSize(thirdTitle:GetTextSizeX() + 10, thirdTitle:GetSizeY())
    spanX = (self._ui._stc_thirdInfo:GetSizeX() - (thirdTitle:GetTextSizeX() + gap)) / 2
    thirdTitle:SetSpanSize(spanX + gap, thirdTitle:GetSpanSize().y)
  end
  thirdIcon:SetPosXY(thirdTitle:GetPosX() - gap, thirdTitle:GetPosY())
  if fifthTitle:GetTextSizeX() > fifthTitle:GetSizeX() then
    UI.setLimitTextAndAddTooltip(fifthTitle, fifthTitle:GetText(), "")
    fifthTitle:SetSpanSize(40, fifthTitle:GetSpanSize().y)
  else
    fifthTitle:SetSize(fifthTitle:GetTextSizeX() + 10, fifthTitle:GetSizeY())
    spanX = (self._ui._stc_fifthInfo:GetSizeX() - (fifthTitle:GetTextSizeX() + gap)) / 2
    fifthTitle:SetSpanSize(spanX + gap, fifthTitle:GetSpanSize().y)
  end
  fifthIcon:SetPosXY(fifthTitle:GetPosX() - gap, fifthTitle:GetPosY())
  if self._isPadSnapping == true then
    self._ui._stc_keyGuideBG:SetShow(true)
    self._ui._btn_close:SetShow(false)
  else
    self._ui._stc_keyGuideBG:SetShow(false)
    self._ui._btn_close:SetShow(true)
  end
end
function PaGlobal_Window_SiegeResult_All:prepareOpen(isRecord, historyIndex)
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  if isRecord == nil then
    isRecord = false
  end
  local result = PaGlobal_Window_SiegeResult_All:update(isRecord, historyIndex)
  if result == true then
    PaGlobal_Window_SiegeResult_All:open()
  end
  Panel_GuildMain_All:ignorePadSnapMoveToOtherPanelUpdate(true)
end
function PaGlobal_Window_SiegeResult_All:open()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  Panel_Window_SiegeResult_All:SetShow(true)
end
function PaGlobal_Window_SiegeResult_All:prepareClose()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  self._requestSiegeHistory = false
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  Panel_GuildMain_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_Window_SiegeResult_All:close()
end
function PaGlobal_Window_SiegeResult_All:close()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  Panel_Window_SiegeResult_All:SetShow(false)
end
function PaGlobal_Window_SiegeResult_All:update(isRecord, historyIndex)
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  if isRecord == false or historyIndex == nil then
    historyIndex = 0
  end
  local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
  if siegeHistoryWrapper == nil then
    return
  end
  local guildKillCount = 0
  local guildTowerCount = 0
  local guildDeathCount = 0
  local guildInstallationCount = 0
  local guildComandCount = 0
  local guildCastlegateCount = 0
  local guildSummonCount = 0
  local personalRecordCount = 0
  local volunteerCount = 0
  self._personalDataList = {}
  if isRecord == false then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if myGuildInfo == nil then
      return
    end
    ToClient_refreshProgressingGuildSiegePersonalRecord()
    personalRecordCount = ToClient_getProgressingGuildSiegePersonalRecordCount()
    for personalIndex = 1, personalRecordCount do
      local presonalRecordWrapper = ToClient_getProgressingGuildSiegePersonalRecord(personalIndex - 1)
      self._personalDataList[personalIndex] = {
        idx = personalIndex,
        name = presonalRecordWrapper:getUserNickname(),
        userNo = presonalRecordWrapper:getUserNo(),
        command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
        tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
        castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
        help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
        summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
        installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
        lord = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeLord),
        master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
        commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
        member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
        death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
        killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon)
      }
      local volunteerMemberInfo = myGuildInfo:getVolunteerMemberByUserNo(self._personalDataList[personalIndex].userNo)
      if volunteerMemberInfo ~= nil then
        self._personalDataList[personalIndex] = nil
        volunteerCount = volunteerCount + 1
      else
        local memberKillCount = self._personalDataList[personalIndex].lord + self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
        self._personalDataList[personalIndex].member = memberKillCount
        guildKillCount = guildKillCount + memberKillCount
        guildComandCount = guildComandCount + self._personalDataList[personalIndex].command + self._personalDataList[personalIndex].tower
        guildDeathCount = guildDeathCount + self._personalDataList[personalIndex].death
        guildInstallationCount = guildInstallationCount + self._personalDataList[personalIndex].installation
        guildSummonCount = guildSummonCount + self._personalDataList[personalIndex].castlegate
      end
    end
  else
    personalRecordCount = ToClient_getGuildSiegePersonalRecordCount(historyIndex)
    if personalRecordCount == 0 then
      for key, control in pairs(self._personalDataList) do
        control = nil
      end
    else
      for personalIndex = 1, personalRecordCount do
        local presonalRecordWrapper = ToClient_getGuildSiegePersonalRecord(historyIndex, personalIndex - 1)
        self._personalDataList[personalIndex] = {
          idx = personalIndex,
          name = presonalRecordWrapper:getUserNickname(),
          userNo = presonalRecordWrapper:getUserNo(),
          command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
          tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
          castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
          help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
          summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
          installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
          lord = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeLord),
          master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
          commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
          member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
          death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
          killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon)
        }
        local memberKillCount = self._personalDataList[personalIndex].lord + self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
        self._personalDataList[personalIndex].member = memberKillCount
        guildKillCount = guildKillCount + memberKillCount
        guildComandCount = guildComandCount + self._personalDataList[personalIndex].command + self._personalDataList[personalIndex].tower
        guildDeathCount = guildDeathCount + self._personalDataList[personalIndex].death
        guildInstallationCount = guildInstallationCount + self._personalDataList[personalIndex].installation
        guildSummonCount = guildSummonCount + self._personalDataList[personalIndex].castlegate
      end
    end
  end
  local resultString = ""
  if siegeHistoryWrapper:isOccupied() == 2 then
    resultString = PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_WIN")
    self._ui._stc_resultVisualize:ChangeTextureInfoTextureIDAsync("Combine_Etc_StrongholdWar_Result_Win_BG")
  else
    resultString = PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_LOSE")
    self._ui._stc_resultVisualize:ChangeTextureInfoTextureIDAsync("Combine_Etc_StrongholdWar_Result_Lose_BG")
  end
  self._ui._stc_resultVisualize:setRenderTexture(self._ui._stc_resultVisualize:getBaseTexture())
  local siegeScoreNo = siegeHistoryWrapper:getSiegeScoreNo()
  local isYear = ToClient_getYearFromSiegeScoreNo(siegeScoreNo)
  local isMonth = ToClient_getMonthFromSiegeScoreNo(siegeScoreNo)
  local isDay = ToClient_getDayFromSiegeScoreNo(siegeScoreNo)
  local day = ToClient_getDayOfWeekFromSiegeScroeNo(siegeScoreNo)
  local dateString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_ATTRIBUTEREPORT_DATE", "year", tostring(isYear), "month", tostring(isMonth), "day", tostring(isDay))
  self._ui._txt_result_date:SetText(dateString .. " " .. resultString)
  local territoryInfoWrapper = getTerritoryInfoWrapper(siegeHistoryWrapper:getTerritoryKeyRaw())
  if territoryInfoWrapper == nil then
    self._ui._txt_region:SetText("")
  else
    self._ui._txt_region:SetText(territoryInfoWrapper:getTerritoryName())
  end
  resultString = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TERRITORYWAR")
  if siegeHistoryWrapper:isVilliageSiege() == true then
    self._ui._txt_resultTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SIEGERESULT_WARRESULT"))
  else
    self._ui._txt_resultTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SIEGERESULT_WARRESULT2"))
  end
  self._ui._txt_rewardItemTitle:SetShow(false)
  self._ui._rewardItemSlot.bg:SetShow(false)
  local rewardItemEnchantKey = siegeHistoryWrapper:getRewardItemEnchantKey()
  if rewardItemEnchantKey == nil or rewardItemEnchantKey:getItemKey() == 0 then
    self._ui._txt_rewardMoneyTitle:SetSpanSize(self._ui._txt_rewardMoneyTitle:GetSpanSize().x, -15)
    self._ui._txt_rewardMoney:SetSpanSize(self._ui._txt_rewardMoneyTitle:GetSpanSize().x, 15)
  else
    local rewardItemWarpper = getItemEnchantStaticStatus(rewardItemEnchantKey)
    if rewardItemWarpper ~= nil then
      self._ui._rewardItemSlot.base.icon:ChangeTextureInfoNameAsync("icon/" .. rewardItemWarpper:getIconPath())
      self._ui._rewardItemSlot.base.icon:SetIgnore(false)
      self._ui._rewardItemSlot.base.icon:addInputEvent("Mouse_On", "PaGlobalFunc_SiegeResult_All_RewardItemTooltip(true," .. historyIndex .. ")")
      self._ui._rewardItemSlot.base.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_SiegeResult_All_RewardItemTooltip(false)")
      self._ui._rewardItemSlot.base.icon:SetPosY(1)
      self._ui._rewardItemSlot.base.icon:SetPosX(1)
      self._ui._rewardItemSlot.bg:SetShow(true)
      self._ui._txt_rewardItemTitle:SetShow(true)
    end
    self._ui._txt_rewardMoneyTitle:SetSpanSize(self._ui._txt_rewardMoneyTitle:GetSpanSize().x, -50)
    self._ui._txt_rewardMoney:SetSpanSize(self._ui._txt_rewardMoneyTitle:GetSpanSize().x, -20)
  end
  self._ui._txt_member:SetText(tostring(personalRecordCount - volunteerCount) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_INFO_MEMBERCOUNT_TEXT"))
  self._ui._txt_joinTime:SetText(convertStringFromDatetime(siegeHistoryWrapper:getPlayTime()))
  self._ui._txt_occupyTime:SetText(convertStringFromDatetime(siegeHistoryWrapper:getOccupyTime()))
  self._ui._txt_rewardMoney:SetText(makeDotMoney(siegeHistoryWrapper:getAcquiredTax()) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_INCENTIVE_MONEY"))
  self._ui._txt_firstTitleValue:SetText(guildComandCount)
  self._ui._txt_secondTitleValue:SetText(guildKillCount)
  self._ui._txt_thirdTitleValue:SetText(guildDeathCount)
  self._ui._txt_fifthTitleValue:SetText(guildInstallationCount)
  table.sort(PaGlobal_Window_SiegeResult_All._personalDataList, function(a, b)
    return a.command + a.tower > b.command + b.tower
  end)
  for i = 1, 5 do
    if PaGlobal_Window_SiegeResult_All._personalDataList[i] ~= nil and PaGlobal_Window_SiegeResult_All._personalDataList[i].command + PaGlobal_Window_SiegeResult_All._personalDataList[i].tower ~= 0 then
      self._ui._stc_firstInfo_txt_Ranking[i]:SetText(PaGlobal_Window_SiegeResult_All._personalDataList[i].name)
    else
      self._ui._stc_firstInfo_txt_Ranking[i]:SetText("")
    end
  end
  table.sort(PaGlobal_Window_SiegeResult_All._personalDataList, function(a, b)
    return a.member > b.member
  end)
  for i = 1, 5 do
    if PaGlobal_Window_SiegeResult_All._personalDataList[i] ~= nil and PaGlobal_Window_SiegeResult_All._personalDataList[i].member ~= 0 then
      self._ui._stc_secondInfo_txt_Ranking[i]:SetText(PaGlobal_Window_SiegeResult_All._personalDataList[i].name)
    else
      self._ui._stc_secondInfo_txt_Ranking[i]:SetText("")
    end
  end
  table.sort(PaGlobal_Window_SiegeResult_All._personalDataList, function(a, b)
    return a.death > b.death
  end)
  for i = 1, 5 do
    if PaGlobal_Window_SiegeResult_All._personalDataList[i] ~= nil and PaGlobal_Window_SiegeResult_All._personalDataList[i].death ~= 0 then
      self._ui._stc_thirdInfo_txt_Ranking[i]:SetText(PaGlobal_Window_SiegeResult_All._personalDataList[i].name)
    else
      self._ui._stc_thirdInfo_txt_Ranking[i]:SetText("")
    end
  end
  table.sort(PaGlobal_Window_SiegeResult_All._personalDataList, function(a, b)
    return a.installation > b.installation
  end)
  for i = 1, 5 do
    if PaGlobal_Window_SiegeResult_All._personalDataList[i] ~= nil and PaGlobal_Window_SiegeResult_All._personalDataList[i].installation ~= 0 then
      self._ui._stc_fifthInfo_txt_Ranking[i]:SetText(PaGlobal_Window_SiegeResult_All._personalDataList[i].name)
    else
      self._ui._stc_fifthInfo_txt_Ranking[i]:SetText("")
    end
  end
  return true
end
function PaGlobal_Window_SiegeResult_All:validate()
  if Panel_Window_SiegeResult_All == nil then
    return
  end
  self._ui._stc_topMainArea:isValidate()
  self._ui._txt_resultTitle:isValidate()
  self._ui._txt_result_date:isValidate()
  self._ui._stc_resultVisualize:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_middleSubArea:isValidate()
  self._ui._stc_joinArea:isValidate()
  self._ui._txt_region:isValidate()
  self._ui._txt_member:isValidate()
  self._ui._stc_joinRewardArea:isValidate()
  self._ui._txt_rewardMoneyTitle:isValidate()
  self._ui._txt_rewardMoney:isValidate()
  self._ui._txt_rewardItemTitle:isValidate()
  self._ui._stc_rewardTemplete:isValidate()
  self._ui._stc_joinTotalTimeArea:isValidate()
  self._ui._txt_joinTime:isValidate()
  self._ui._txt_occupyTime:isValidate()
  self._ui._stc_firstInfo:isValidate()
  self._ui._txt_firstTitleValue:isValidate()
  self._ui._stc_firstInfo_txt_Ranking[1]:isValidate()
  self._ui._stc_firstInfo_txt_Ranking[2]:isValidate()
  self._ui._stc_firstInfo_txt_Ranking[3]:isValidate()
  self._ui._stc_firstInfo_txt_Ranking[4]:isValidate()
  self._ui._stc_firstInfo_txt_Ranking[5]:isValidate()
  self._ui._stc_secondInfo:isValidate()
  self._ui._txt_secondTitleValue:isValidate()
  self._ui._stc_secondInfo_txt_Ranking[1]:isValidate()
  self._ui._stc_secondInfo_txt_Ranking[2]:isValidate()
  self._ui._stc_secondInfo_txt_Ranking[3]:isValidate()
  self._ui._stc_secondInfo_txt_Ranking[4]:isValidate()
  self._ui._stc_secondInfo_txt_Ranking[5]:isValidate()
  self._ui._stc_thirdInfo:isValidate()
  self._ui._txt_thirdTitleValue:isValidate()
  self._ui._stc_thirdInfo_txt_Ranking[1]:isValidate()
  self._ui._stc_thirdInfo_txt_Ranking[2]:isValidate()
  self._ui._stc_thirdInfo_txt_Ranking[3]:isValidate()
  self._ui._stc_thirdInfo_txt_Ranking[4]:isValidate()
  self._ui._stc_thirdInfo_txt_Ranking[5]:isValidate()
  self._ui._stc_fifthInfo:isValidate()
  self._ui._txt_fifthTitleValue:isValidate()
  self._ui._stc_fifthInfo_txt_Ranking[1]:isValidate()
  self._ui._stc_fifthInfo_txt_Ranking[2]:isValidate()
  self._ui._stc_fifthInfo_txt_Ranking[3]:isValidate()
  self._ui._stc_fifthInfo_txt_Ranking[4]:isValidate()
  self._ui._stc_fifthInfo_txt_Ranking[5]:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
end
