function PaGlobal_GuildQuestList_All:initialize()
  if PaGlobal_GuildQuestList_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_CurrentQuestBG = UI.getChildControl(Panel_GuildQuestList_All, "Static_CurrentQuestArea")
  self._ui.txt_ProgressQuestTime = UI.getChildControl(self._ui.stc_CurrentQuestBG, "StaticText_QuestTime")
  self._ui.txt_ProgressQuestName = UI.getChildControl(self._ui.stc_CurrentQuestBG, "StaticText_QusetName")
  self._ui.txt_ProgressQuestCondition = UI.getChildControl(self._ui.stc_CurrentQuestBG, "StaticText_QuestCondition")
  for i = 0, self._progressQuestConditionMaxCount - 1 do
    self._progressQuestCondition[i] = UI.createAndCopyBasePropertyControl(self._ui.stc_CurrentQuestBG, "StaticText_QuestCondition", self._ui.stc_CurrentQuestBG, "StaticText_QuestCondition_" .. i)
    self._progressQuestCondition[i]:SetPosY(self._progressQuestCondition[i]:GetPosY() + (self._progressQuestCondition[i]:GetSizeY() + 5) * i)
  end
  self._ui.btn_GiveUp = UI.getChildControl(self._ui.stc_CurrentQuestBG, "Button_Giveup")
  self._ui.txt_AcceptMember = UI.getChildControl(self._ui.stc_CurrentQuestBG, "StaticText_AcceptMember")
  self._ui.btn_Complete = UI.getChildControl(self._ui.stc_CurrentQuestBG, "Button_Complete")
  self._ui.btn_ProgressingQuestInfo = UI.getChildControl(self._ui.stc_CurrentQuestBG, "Button_QuestInfo")
  self._ui.txt_ReAcceptTime = UI.getChildControl(self._ui.stc_CurrentQuestBG, "StaticText_ReacceptTime")
  self._ui.stc_QuestListBG = UI.getChildControl(Panel_GuildQuestList_All, "Static_QuestListArea")
  self._rdo_Button[0] = UI.getChildControl(self._ui.stc_QuestListBG, "RadioButton_Progress")
  self._rdo_Button[1] = UI.getChildControl(self._ui.stc_QuestListBG, "RadioButton_Combat")
  self._rdo_Button[2] = UI.getChildControl(self._ui.stc_QuestListBG, "RadioButton_Life")
  self._rdo_Button[3] = UI.getChildControl(self._ui.stc_QuestListBG, "RadioButton_Trade")
  self._rdo_Button[4] = UI.getChildControl(self._ui.stc_QuestListBG, "RadioButton_Boss")
  self._ui.stc_CheckBtnBG = UI.getChildControl(self._ui.stc_QuestListBG, "Static_CheckBtnBg")
  self._chk_Button[0] = UI.getChildControl(self._ui.stc_CheckBtnBG, "CheckButton_4")
  self._chk_Button[1] = UI.getChildControl(self._ui.stc_CheckBtnBG, "CheckButton_3")
  self._chk_Button[2] = UI.getChildControl(self._ui.stc_CheckBtnBG, "CheckButton_2")
  self._chk_Button[3] = UI.getChildControl(self._ui.stc_CheckBtnBG, "CheckButton_1")
  for btnIdx = 0, self._ChkCount - 1 do
    self._chk_Button[btnIdx]:SetEnableArea(0, 0, self._chk_Button[btnIdx]:GetSizeX() + self._chk_Button[btnIdx]:GetTextSizeX(), self._chk_Button[btnIdx]:GetSizeY())
    UI.setLimitTextAndAddTooltip(self._chk_Button[btnIdx], self._chk_Button[btnIdx]:GetText())
  end
  self._ui.list2_Quest = UI.getChildControl(self._ui.stc_QuestListBG, "List2_Quest")
  self._ui.list2_Content = UI.getChildControl(self._ui.list2_Quest, "List2_1_Content")
  self._ui.txt_GuildFunds = UI.getChildControl(Panel_GuildQuestList_All, "StaticText_GuildFunds")
  self._ui.btn_GetGuildMoney = UI.getChildControl(Panel_GuildQuestList_All, "Button_GetGuildMoney")
  self._ui.btn_ShowQuestLog = UI.getChildControl(Panel_GuildQuestList_All, "Button_QuestLog")
  self._parentBG = PaGlobal_GuildMain_All._ui.stc_Quest_Bg
  UI.setLimitTextAndAddTooltip(self._ui.btn_GiveUp, self._ui.btn_GiveUp:GetText())
  UI.setLimitTextAndAddTooltip(self._ui.btn_Complete, self._ui.btn_Complete:GetText())
  UI.setLimitTextAndAddTooltip(self._ui.btn_ProgressingQuestInfo, self._ui.btn_ProgressingQuestInfo:GetText())
  self:validate()
  self:registEventHandler(self._isConsole)
  self:swichPlatform(self._isConsole)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    self._initialize = true
    return
  end
  ToClient_RequestGuildQuestList(false)
  local myGuildGrade = myGuildInfo:getMemberCountLevel() - 1
  for index = 0, self._ChkCount - 1 do
    if index <= myGuildGrade then
      self._chk_Button[index]:SetCheck(true)
    else
      self._chk_Button[index]:SetCheck(false)
    end
  end
  self._rdo_Button[1]:SetCheck(true)
  self._initialize = true
end
function PaGlobal_GuildQuestList_All:registEventHandler(isConsole)
  registerEvent("ResponseGuildQuestList", "FromClient_GuildQuest_All_Update")
  registerEvent("ResponseUpdateGuildQuest", "PaGlobal_GuildQuest_UpdateProgressQuest")
  registerEvent("ResponseAcceptGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("ResponseUpdateGiveupGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("ResponseCompleteGuildQuest", "PaGlobalFunc_Guild_Quest_All_FirstUpdate")
  registerEvent("FromClient_UpdateGuildMemberBonus", "FromClient_GuildQuest_UpdateGuildMemberBonus")
  registerEvent("FromClient_UpdateProgressGuildQuestList", "FromClient_GuildQuest_All_UpdateOtherServerQuest")
  self._ui.list2_Quest:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildQuest_List2Update")
  self._ui.list2_Quest:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_GiveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Giveup()")
  self._ui.btn_Complete:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Clear()")
  self._ui.btn_ProgressingQuestInfo:addInputEvent("Mouse_LUp", "HandleCliekedGuildQuestReward()")
  if isConsole == true then
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "HandleEvent_GuildQuest_TabMove(true)")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "HandleEvent_GuildQuest_TabMove(false)")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_GuildQuest_ReqestMemberBonus_All()")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_GuildQuest_Open_AcceptHistory()")
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildQuestScale()")
  else
    self._ui.btn_GetGuildMoney:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_ReqestMemberBonus_All()")
    self._ui.btn_ShowQuestLog:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_Open_AcceptHistory()")
  end
  for i = 0, self._BtnCount - 1 do
    self._rdo_Button[i]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildQuest_Type_ShowSimpleTooltip(true," .. i .. ")")
    self._rdo_Button[i]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildQuest_Type_ShowSimpleTooltip(false)")
    self._rdo_Button[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_SelectType(" .. i .. ")")
  end
  for i = 0, self._ChkCount - 1 do
    self._chk_Button[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuest_SelectCheck(" .. i .. ")")
  end
end
function PaGlobal_GuildQuestList_All:swichPlatform(isConsole)
  self._ui.btn_GetGuildMoney:SetShow(not isConsole)
  self._ui.btn_ShowQuestLog:SetShow(not isConsole)
end
function PaGlobal_GuildQuestList_All:validate()
  self._ui.stc_CurrentQuestBG:isValidate()
  self._ui.txt_ProgressQuestTime:isValidate()
  self._ui.txt_ProgressQuestName:isValidate()
  self._ui.txt_ProgressQuestCondition:isValidate()
  self._ui.btn_GiveUp:isValidate()
  self._ui.btn_Complete:isValidate()
  self._ui.btn_ProgressingQuestInfo:isValidate()
  self._ui.txt_AcceptMember:isValidate()
  self._ui.txt_ReAcceptTime:isValidate()
  self._ui.stc_QuestListBG:isValidate()
  self._rdo_Button[0]:isValidate()
  self._rdo_Button[1]:isValidate()
  self._rdo_Button[2]:isValidate()
  self._rdo_Button[3]:isValidate()
  self._rdo_Button[4]:isValidate()
  self._ui.stc_CheckBtnBG:isValidate()
  self._chk_Button[0]:isValidate()
  self._chk_Button[1]:isValidate()
  self._chk_Button[2]:isValidate()
  self._chk_Button[3]:isValidate()
  self._ui.list2_Quest:isValidate()
  self._ui.list2_Content:isValidate()
  self._ui.txt_GuildFunds:isValidate()
  self._ui.btn_GetGuildMoney:isValidate()
  self._ui.btn_ShowQuestLog:isValidate()
end
function PaGlobal_GuildQuestList_All:updateAll()
  if self._parentBG:GetShow() == false then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    return
  end
  local businessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
  self._ui.txt_GuildFunds:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDMONEY", "getGuildMoney", makeDotMoney(businessFunds_s64)))
  ToClient_RequestWarehouseInfo()
  self._ui.txt_ReAcceptTime:SetShow(false)
  ToClient_RequestRemainRefreshGuildQuestTime()
  ToClient_RequestRemainRestrictTimeAcceptQuest()
  self:updateProgressQuest()
  self:updateQuestList()
end
function PaGlobal_GuildQuestList_All:setReward(reward, icon, idx)
  local rewardType = reward:getType()
  local questType = "guild"
  icon:SetAlpha(1)
  local mouseOnEnvet, mouseOutEvent
  if rewardType == __eRewardExp then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    mouseOnEnvet = "rewardTooltip( \"Exp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"Exp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardSkillExp then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds")
    mouseOnEnvet = "rewardTooltip( \"SkillExp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"SkillExp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardExpGrade then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds")
    mouseOnEnvet = "rewardTooltip( \"ExpGrade\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"ExpGrade\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardSkillExpGrade then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds")
    mouseOnEnvet = "rewardTooltip( \"SkillExpGrade\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"SkillExpGrade\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardLifeExp then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    mouseOnEnvet = "rewardTooltip( \"ProductExp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"ProductExp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardItem then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward:getItemEnchantKey()))
    icon:ChangeTextureInfoNameAsync("Icon/" .. itemStatic:getIconPath())
  elseif rewardType == __eRewardIntimacy then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/00000000_Special_Contributiveness.dds")
    mouseOnEnvet = "rewardTooltip( \"Intimacy\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"Intimacy\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif rewardType == __eRewardKnowledge then
    icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds")
    mouseOnEnvet = "rewardTooltip( \"Knowledge\", true, \"" .. questType .. "\", " .. idx .. "," .. reward._mentalCard .. " )"
    mouseOutEvent = "rewardTooltip( \"Knowledge\", false, \"" .. questType .. "\", " .. idx .. "," .. reward._mentalCard .. " )"
  else
    mouseOnEnvet = ""
    mouseOutEvent = ""
  end
  if mouseOnEnvet == nil or mouseOutEvent == nil then
    return
  end
  if self._isConsole == true and _ContentsGroup_RenewUI_Tooltip == true then
    icon:addInputEvent("Mouse_On", "")
    icon:addInputEvent("Mouse_Out", "")
    slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_GuildQuestInfo_All_ItemTooltip(" .. reward:getItemEnchantKey() .. ")")
  elseif self._isConsole == true then
    slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, mouseOnEnvet)
    slotBg:addInputEvent("Mouse_Out", mouseOutEvent)
  else
    icon:addInputEvent("Mouse_On", mouseOnEnvet)
    icon:addInputEvent("Mouse_Out", mouseOutEvent)
  end
end
function PaGlobal_GuildQuestList_All:updateProgressQuest()
  if self._parentBG:GetShow() == false then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local enableQuestCount = myGuildInfo:getAvaiableGuildQuestCount()
  self._enableQuestCount = enableQuestCount
  local enableQuestCountStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_ENABLEQUESTCOUNT_NEW", "enableQuestCount", enableQuestCount, "maxAvailableQuestCount", __eMaxAvaiableGuildQuestCount)
  local isProgressing = ToClient_isProgressingGuildQuest()
  for i = 0, self._progressQuestConditionMaxCount - 1 do
    self._progressQuestCondition[i]:SetShow(false)
    self._progressQuestCondition[i]:SetText("")
    self._progressQuestCondition[i]:SetLineRender(false)
    self._progressQuestCondition[i]:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  self._ui.txt_ProgressQuestName:SetShow(false)
  self._ui.txt_ProgressQuestTime:SetShow(false)
  local questName = self._ui.txt_ProgressQuestName
  local questTime = self._ui.txt_ProgressQuestTime
  local questConditionList = self._progressQuestCondition
  local remainTime = ToClient_getCurrentGuildQuestRemainedTime()
  local isRightQuestComplete = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightQuestComplete = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Quest)
  else
    isRightQuestComplete = PaGlobalFunc_GuildQuest_All_RightCheck(__eGuildRightType_QuestComplete)
  end
  if isProgressing == true then
    local currentGuildQuestName = ToClient_getCurrentGuildQuestName()
    local requireGuildRank = ToClient_getCurrentGuildQuestGrade()
    local requireGuildRankStr = ""
    if 1 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
    elseif 2 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
    elseif 3 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
    elseif 4 == requireGuildRank then
      requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
    end
    questName:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", currentGuildQuestName, "requireGuildRankStr", requireGuildRankStr) .. " " .. enableQuestCountStr)
    questName:SetShow(true)
    local strMinute = math.floor(remainTime / 60)
    if remainTime <= 0 then
      questTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_TIMEOUT"))
    else
      questTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_REMAINTIME", "time_minute", strMinute))
    end
    questTime:SetShow(true)
    questTime:SetColor(Defines.Color.C_FFFF0000)
    questTime:SetFontColor(Defines.Color.C_FFFF0000)
    local questConditionCount = ToClient_getCurrentGuildQuestConditionCount()
    for index = 0, self._progressQuestConditionMaxCount - 1 do
      if index < questConditionCount then
        local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(index)
        if currentGuildQuestInfo ~= nil then
          questConditionList[index]:SetShow(true)
          questConditionList[index]:SetText(currentGuildQuestInfo._desc .. " ( " .. currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. " ) ")
          if currentGuildQuestInfo._destCount <= currentGuildQuestInfo._currentCount then
            questConditionList[index]:SetLineRender(true)
            questConditionList[index]:SetFontColor(Defines.Color.C_FF626262)
          else
            questConditionList[index]:SetLineRender(false)
            questConditionList[index]:SetFontColor(Defines.Color.C_FFC4BEBE)
          end
        else
          questConditionList[index]:SetShow(false)
        end
      end
    end
    self._ui.txt_AcceptMember:SetShow(true)
    local acceptUserName = ToClient_getCurrentGuildQuestAcceptMember()
    self._ui.txt_AcceptMember:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUESTLIST_ACCEPTMEMBER", "familyName", acceptUserName))
    if isRightQuestComplete == true then
      self._ui.btn_GiveUp:SetShow(false == self._isConsole)
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Giveup()")
    else
      self._ui.btn_GiveUp:SetShow(false)
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_QUEST_GIVEUP_BTN"))
    if 0 >= ToClient_getCurrentGuildQuestBaseRewardCount() and 0 >= ToClient_getCurrentGuildQuestSelectRewardCount() then
      self._ui.btn_ProgressingQuestInfo:SetShow(false)
    else
      self._ui.btn_ProgressingQuestInfo:SetShow(true)
    end
  else
    self._ui.txt_AcceptMember:SetShow(false)
    self._ui.btn_ProgressingQuestInfo:SetShow(false)
    self._ui.btn_GiveUp:SetShow(false)
    questTime:SetShow(false)
    self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    local temporaryWrapper = getTemporaryInformationWrapper()
    local worldNo = temporaryWrapper:getSelectedWorldServerNo()
    local channelName = getChannelName(worldNo, ToClient_getCurrentGuildQuestServerNo())
    if ToClient_isGuildQuestOtherServer() then
      if channelName == nil then
        questName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHER"))
      else
        questName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROGRESSNOQUEST_ANOTHERCHANNEL", "channel", channelName))
      end
      questName:SetShow(true)
      if isRightQuestComplete == true then
        self._ui.btn_GiveUp:SetShow(false == self._isConsole)
        self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Giveup()")
      else
        self._ui.btn_GiveUp:SetShow(false)
      end
    else
      questName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NOCURRENT"))
      questConditionList[0]:SetShow(true)
      questConditionList[0]:SetText(enableQuestCountStr)
      questName:SetShow(true)
    end
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    PaGlobal_GuildMain_All:setKeyguideTextWithShow(false, __eConsoleUIPadEvent_Y, "")
  end
  if ToClient_isSatisfyCurrentGuildQuest() == true then
    if isRightQuestComplete == true then
      self._parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildQuest_Clear()")
      PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_Y, PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_COMPLETEQUEST"))
      questTime:SetShow(false)
      self._ui.btn_Complete:SetShow(false == self._isConsole)
    else
      self._ui.btn_Complete:SetShow(false)
    end
  else
    self._ui.btn_Complete:SetShow(false)
  end
end
function PaGlobal_GuildQuestList_All:updateQuestList()
  if self._parentBG:GetShow() == false then
    return
  end
  if ToClient_GetMyGuildInfoWrapper() == nil then
    return
  end
  self._ui.list2_Quest:getElementManager():clearKey()
  if self._guildQuestType == -1 then
    local myGuildProgressQuestOtherServerListCount = ToClient_RequestProgressGuildQuestOtherServerCount()
    for index = 0, myGuildProgressQuestOtherServerListCount - 1 do
      local quest = ToClient_RequestRandomProgressGuildQuestOtherServerAt(index)
      local remainedTime = quest:getRemainedTime()
      local guildQuestType = quest:getGuildQuestType()
      if guildQuestType ~= __eGuildQuestType_Arbitration and remainedTime > 0 then
        self._ui.list2_Quest:getElementManager():pushKey(index)
      end
    end
  else
    local myGuildQuestListCount = ToClient_RequestGuildQuestCount()
    for index = 0, myGuildQuestListCount - 1 do
      local quest = ToClient_RequestGuildQuestAt(index)
      local guildQuestType = quest:getGuildQuestType()
      if guildQuestType == self._guildQuestType and guildQuestType ~= __eGuildQuestType_Arbitration then
        local questGrade = quest:getGuildQuestGrade() - 1
        if self._chk_Button[questGrade]:IsCheck() == true then
          self._ui.list2_Quest:getElementManager():pushKey(quest._questIndex)
        end
      end
    end
  end
end
function PaGlobal_GuildQuestList_All:selectType(btnIdx)
  if btnIdx == nil then
    return
  end
  if self._BtnIdx ~= btnIdx then
    self._BtnIdx = btnIdx
  end
  for i = 0, self._BtnCount - 1 do
    if i == btnIdx then
      self._rdo_Button[i]:SetCheck(true)
    else
      self._rdo_Button[i]:SetCheck(false)
    end
  end
  if self._guildQuestType == -1 then
    self._ui.stc_CheckBtnBG:SetShow(false)
    for i = 0, self._ChkCount - 1 do
      self._chk_Button[i]:SetShow(false)
    end
  else
    self._ui.stc_CheckBtnBG:SetShow(true)
    for i = 0, self._ChkCount - 1 do
      self._chk_Button[i]:SetShow(true)
    end
  end
end
function PaGlobal_GuildQuestList_All:selectCheck(checkIndex)
  if checkIndex == nil then
    return
  end
  self._chk_Button[checkIndex]:SetCheck(not self._chk_Button[checkIndex]:IsCheck())
end
function PaGlobal_GuildQuestList_All:resetList()
  self:updateQuestList()
end
