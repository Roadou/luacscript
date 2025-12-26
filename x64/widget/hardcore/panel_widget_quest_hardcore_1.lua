function PaGlobal_HardCoreQuest:initialize()
  if PaGlobal_HardCoreQuest._initialize == true then
    return
  end
  local scoreBG = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_ScoreBg")
  local gaugeBg = UI.getChildControl(scoreBG, "Static_GaugeBG")
  self._ui._stc_CoinPointProgress = UI.getChildControl(gaugeBg, "Progress2_FixPoint")
  self._ui._stc_RankPointProgress = UI.getChildControl(gaugeBg, "Progress2_MinusPoint")
  self._ui._stc_CoinPointProgress:SetAniSpeed(5)
  self._ui._stc_RankPointProgress:SetAniSpeed(5)
  self._ui._stc_CoinPointProgress:SetSmoothMode(true)
  self._ui._stc_RankPointProgress:SetSmoothMode(true)
  self._ui._txt_ScoreValue = UI.getChildControl(gaugeBg, "StaticText_PointValue")
  local quest1 = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_Line_1")
  local quest2 = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_Line_2")
  for index = 0, self._questCountMax - 1 do
    local questControl = {
      _bg = nil,
      _txt_QuestName = nil,
      _txt_QuestCondition = nil
    }
    questControl._bg = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_Line_" .. index + 1)
    questControl._txt_QuestName = UI.getChildControl(questControl._bg, "StaticText_QuestName")
    questControl._txt_QuestCondition = UI.getChildControl(questControl._bg, "StaticText_QuestCondition")
    self._ui._questUI[index] = questControl
  end
  self._ui._txt_QuestName_1 = UI.getChildControl(quest1, "StaticText_QuestName")
  self._ui._txt_QuestCondition_1 = UI.getChildControl(quest1, "StaticText_QuestCondition")
  self._ui._txt_QuestName_2 = UI.getChildControl(quest2, "StaticText_QuestName")
  self._ui._txt_QuestCondition_2 = UI.getChildControl(quest2, "StaticText_QuestCondition")
  self._ui._stc_HighRankerBg = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_RankerBg")
  local myRankBg = UI.getChildControl(self._ui._stc_HighRankerBg, "Static_MyRankBg")
  local myRankTitle = UI.getChildControl(myRankBg, "StaticText_MyRankTitle")
  myRankTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERANKING_MYRANK"))
  self._ui._stc_MyRank = UI.getChildControl(myRankBg, "StaticText_MyRank")
  local hardCoreHighRankerMaxCount = ToClient_getHardCoreHighRankerMaxCount()
  local highRankerRankTemplate = UI.getChildControl(self._ui._stc_HighRankerBg, "StaticText_Rank_Template")
  local highRankerScoreTemplate = UI.getChildControl(self._ui._stc_HighRankerBg, "StaticText_Score_Template")
  highRankerRankTemplate:SetShow(false)
  highRankerScoreTemplate:SetShow(false)
  local uiPosY = highRankerRankTemplate:GetPosY()
  local uiSizeY = highRankerRankTemplate:GetSizeY()
  for index = 0, hardCoreHighRankerMaxCount - 1 do
    local highRanker = {_rankControl = nil, _scoreControl = nil}
    highRanker._rankControl = UI.cloneControl(highRankerRankTemplate, self._ui._stc_HighRankerBg, "StaticText_Rank_Template" .. tostring(index))
    highRanker._scoreControl = UI.cloneControl(highRankerScoreTemplate, self._ui._stc_HighRankerBg, "StaticText_Score_Template" .. tostring(index))
    highRanker._rankControl:SetPosY(uiPosY + (uiSizeY + self._rankControlMargin) * index)
    highRanker._scoreControl:SetPosY(uiPosY + (uiSizeY + self._rankControlMargin) * index)
    self._ui._stc_HighRanker[index] = highRanker
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreQuest:registEventHandler()
  PaGlobal_HardCoreQuest:validate()
  PaGlobal_HardCoreQuest._initialize = true
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    PaGlobal_HardCoreQuest_UpdateWidgetPosition()
    self:prepareOpen()
  end
end
function PaGlobal_HardCoreQuest:registEventHandler()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  registerEvent("FromClient_HardCoreCharacterInfoChangedSelf", "PaGlobal_HardCoreQuest_HardCoreSurvivalPoint")
  registerEvent("FromClient_UpdateQuestList", "PaGlobal_HardCoreQuest_UpdateQuestInfo")
  registerEvent("FromClient_HardCoreMyRankChangedSelf", "PaGlobal_HardCoreQuest_UpdateHardCoreMyRank")
  registerEvent("FromClient_HardCoreUpdateHighRankerList", "PaGlobal_HardCoreQuest_UpdateHardCoreHighRankerList")
  registerEvent("onScreenResize", "PaGlobal_HardCoreQuest_UpdateWidgetPosition")
  local scoreBG = UI.getChildControl(Panel_Widget_Quest_HardCore, "Static_ScoreBg")
  scoreBG:addInputEvent("Mouse_On", "PaGlobal_HardCoreQuest:showPointTooltip(true)")
  scoreBG:addInputEvent("Mouse_Out", "PaGlobal_HardCoreQuest:showPointTooltip(false)")
end
function PaGlobal_HardCoreQuest:validate()
  self._ui._txt_ScoreValue:isValidate()
  for index = 0, self._questCountMax - 1 do
    self._ui._questUI[index]._bg:isValidate()
    self._ui._questUI[index]._txt_QuestName:isValidate()
    self._ui._questUI[index]._txt_QuestCondition:isValidate()
  end
end
function PaGlobal_HardCoreQuest:prepareOpen()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_HardCoreQuest:open()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  Panel_Widget_Quest_HardCore:SetShow(true)
end
function PaGlobal_HardCoreQuest:prepareClose()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreQuest:close()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  Panel_Widget_Quest_HardCore:SetShow(false)
end
function PaGlobal_HardCoreQuest:update()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  self:updateQuest()
  self:updateRankPoint(false)
  self:updateMyRank()
  self:updateHighRankerList()
end
function PaGlobal_HardCoreQuest:updateRankPoint(isAni)
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local lastRankPoint = ToClient_getHardCoreAccumulatedPoint()
  local currentRankPoint = ToClient_getHardCoreRankPoint()
  local coinPoint = ToClient_getHardCoreCoinPoint()
  local maxCount = ToClient_getHardCoreExchangeCoinMaxCount()
  local rankPoint = 0
  if lastRankPoint < currentRankPoint then
    rankPoint = currentRankPoint - lastRankPoint
  end
  local exchangePoint = coinPoint + rankPoint
  if maxCount < exchangePoint then
    rankPoint = rankPoint - (exchangePoint - maxCount)
    exchangePoint = maxCount
  end
  self._ui._txt_ScoreValue:SetText(tostring(exchangePoint) .. "/" .. tostring(maxCount))
  local coinPointRate = coinPoint / maxCount * 100
  local rankPointRate = exchangePoint / maxCount * 100
  self._ui._stc_CoinPointProgress:SetProgressRate(coinPointRate)
  self._ui._stc_RankPointProgress:SetProgressRate(rankPointRate)
  if isAni == false then
    self._ui._stc_CoinPointProgress:SetCurrentProgressRate(coinPointRate)
    self._ui._stc_RankPointProgress:SetCurrentProgressRate(rankPointRate)
  end
end
function PaGlobal_HardCoreQuest:showPointTooltip(show)
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  if show == false then
    TooltipSimple_Hide()
    return
  end
  local lastRankPoint = ToClient_getHardCoreAccumulatedPoint()
  local currentRankPoint = ToClient_getHardCoreRankPoint()
  local coinPoint = ToClient_getHardCoreCoinPoint()
  local rankPoint = currentRankPoint - lastRankPoint
  local totalPoint = coinPoint
  if rankPoint > 0 then
    totalPoint = totalPoint + rankPoint
  end
  local text = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HARDCORE_CHANGEPOINT_TOOLTIP", "value1", tostring(rankPoint), "value2", tostring(coinPoint), "value3", tostring(totalPoint))
  TooltipSimple_Show(self._ui._txt_ScoreValue, "", text)
end
function PaGlobal_HardCoreQuest:updateQuest()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local hardCoreSubQuestWarpper = ToClient_getHardCoreSubQuest()
  local hardCoreRepeatQuestWarpper = ToClient_getHardCoreRepeatQuest()
  for index = 0, self._questCountMax - 1 do
    self._questData[index] = nil
    self._ui._questUI[index]._bg:SetShow(false)
  end
  local insertIndex = 0
  local hardCoreSubQuestWarpper = ToClient_getHardCoreSubQuest()
  if hardCoreSubQuestWarpper ~= nil then
    self._questData[insertIndex] = hardCoreSubQuestWarpper:getKey()
    insertIndex = insertIndex + 1
  end
  local repeatQuestCount = ToClient_getHardCoreRepeatQuestCountMax()
  for repeatQuestIndex = 0, repeatQuestCount - 1 do
    local hardCoreRepeatQuestWarpper = ToClient_getHardCoreRepeatQuest(repeatQuestIndex)
    if hardCoreRepeatQuestWarpper ~= nil then
      self._questData[insertIndex] = hardCoreRepeatQuestWarpper:getKey()
      insertIndex = insertIndex + 1
    end
  end
  local controlIndex = 0
  for index = 0, self._questCountMax - 1 do
    if self._questData[index] ~= nil then
      local progressQuestWarpper = ToClient_getProgressingQuestAtKey(self._questData[index])
      if progressQuestWarpper ~= nil then
        local uiQuestInfo = ToClient_GetQuestInfo(progressQuestWarpper:getQuestNo()._group, progressQuestWarpper:getQuestNo()._quest)
        self._ui._questUI[controlIndex]._bg:SetShow(true)
        self._ui._questUI[controlIndex]._txt_QuestName:SetText(progressQuestWarpper:getTitle())
        self._ui._questUI[controlIndex]._txt_QuestName:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuest_QuestInfo(" .. index .. ")")
        self._ui._questUI[controlIndex]._txt_QuestCondition:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreQuest_QuestInfo(" .. index .. ")")
        self._ui._questUI[controlIndex]._txt_QuestName:addInputEvent("Mouse_RUp", "PaGlobal_HardCoreQuest_QuestNavi(" .. index .. ")")
        self._ui._questUI[controlIndex]._txt_QuestCondition:addInputEvent("Mouse_RUp", "PaGlobal_HardCoreQuest_QuestNavi(" .. index .. ")")
        local demandCount = progressQuestWarpper:getDemadCount()
        local demandString = ""
        for demandIndex = 0, demandCount - 1 do
          local demand = progressQuestWarpper:getDemandAt(demandIndex)
          local conditionText
          if demand._currentCount == demand._destCount or demand._destCount <= demand._currentCount then
            conditionText = "- " .. demand._desc .. " (" .. PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_COMPLETE") .. ")"
          elseif 1 == demand._destCount then
            conditionText = "- " .. demand._desc
          else
            conditionText = "- " .. demand._desc .. " (" .. demand._currentCount .. "/" .. demand._destCount .. ")"
          end
          demandString = conditionText .. "\n"
        end
        self._ui._questUI[controlIndex]._txt_QuestCondition:SetLineRender(false)
        self._ui._questUI[controlIndex]._txt_QuestCondition:SetFontColor(Defines.Color.C_FFC4BEBE)
        if uiQuestInfo ~= nil and uiQuestInfo:isSatisfied() == true then
          if true == uiQuestInfo:isCompleteBlackSpirit() then
            demandString = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTCOMPLETE_DESC")
          else
            demandString = PAGetStringParam1(Defines.StringSheet_GAME, "QUESTLIST_COMPLETETARGET", "getCompleteDisplay", uiQuestInfo:getCompleteDisplay())
          end
          self._ui._questUI[controlIndex]._txt_QuestCondition:SetLineRender(true)
          self._ui._questUI[controlIndex]._txt_QuestCondition:SetFontColor(4291617922)
        end
        self._ui._questUI[controlIndex]._txt_QuestCondition:SetShow(true)
        self._ui._questUI[controlIndex]._txt_QuestCondition:SetTextMode(__eTextMode_AutoWrap)
        self._ui._questUI[controlIndex]._txt_QuestCondition:SetText(tostring(ToClient_getReplaceDialog(demandString)))
        controlIndex = controlIndex + 1
      end
    end
  end
end
function PaGlobal_HardCoreQuest:openQuestInfo(index)
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local questKeyRaw = self._questData[index]
  if questKeyRaw == nil then
    return
  end
  local progressQuestWarpper = ToClient_getProgressingQuestAtKey(questKeyRaw)
  local questWarpper = questList_getQuestInfo(questKeyRaw)
  local questGroupNo = questWarpper:getQuestGroupNo()
  local questNo = questWarpper:getQuestGroupQuestNo()
  local questCondition
  if progressQuestWarpper ~= nil and true == progressQuestWarpper:isSatisfied() then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  else
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupNo, questNo, questCondition, "nil", nil, false, false, true, isCleared, nil, index, false)
end
function PaGlobal_HardCoreQuest:findQuestNavi(index)
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local questKeyRaw = self._questData[index]
  if questKeyRaw == nil then
    return
  end
  local progressQuestWarpper = ToClient_getProgressingQuestAtKey(questKeyRaw)
  local questWarpper = questList_getQuestInfo(questKeyRaw)
  local questGroupNo = questWarpper:getQuestGroupNo()
  local questNo = questWarpper:getQuestGroupQuestNo()
  local questCondition
  if progressQuestWarpper ~= nil and true == progressQuestWarpper:isSatisfied() then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  else
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  PaGlobalFunc_Quest_All_FindWay(questGroupNo, questNo, questCondition, false)
end
function PaGlobal_HardCoreQuest:updateMyRank()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local myRank = tostring(ToClient_getHardCoreMyRank())
  if myRank == "0" then
    myRank = "-"
  end
  self._ui._stc_MyRank:SetText(myRank)
end
function PaGlobal_HardCoreQuest:updateHighRankerList()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  local hardCoreHighRankerMaxCount = ToClient_getHardCoreHighRankerMaxCount()
  local rankerCount = 0
  for index = 0, hardCoreHighRankerMaxCount - 1 do
    local rank = ToClient_getHardCoreHighRankerRankByIndex(index)
    if rank ~= 0 then
      local rankerName = ToClient_getHardCoreHighRankerNameByIndex(index)
      local rankText = tostring(rank) .. ". " .. tostring(rankerName)
      self._ui._stc_HighRanker[index]._rankControl:SetText(rankText)
      self._ui._stc_HighRanker[index]._scoreControl:SetText(ToClient_getHardCoreHighRankerPointByIndex(index))
      self._ui._stc_HighRanker[index]._rankControl:SetShow(true)
      self._ui._stc_HighRanker[index]._scoreControl:SetShow(true)
      rankerCount = rankerCount + 1
    else
      self._ui._stc_HighRanker[index]._rankControl:SetShow(false)
      self._ui._stc_HighRanker[index]._scoreControl:SetShow(false)
    end
  end
end
function PaGlobal_HardCoreQuest:updateWidgetPosition()
  if Panel_Widget_Quest_HardCore == nil then
    return
  end
  if Panel_Widget_Quest_HardCore:GetRelativePosX() == -1 and Panel_Widget_Quest_HardCore:GetRelativePosY() == -1 then
    local initPosX = getScreenSizeX() - Panel_Widget_Quest_HardCore:GetSizeX()
    local initPosY = FGlobal_Panel_Radar_GetPosY() + FGlobal_Panel_Radar_GetSizeY() + 32
    Panel_Widget_Quest_HardCore:SetPosX(initPosX)
    Panel_Widget_Quest_HardCore:SetPosY(initPosY)
    FGlobal_InitPanelRelativePos(Panel_Widget_Quest_HardCore, initPosX, initPosY)
  elseif Panel_Widget_Quest_HardCore:GetRelativePosX() == 0 and Panel_Widget_Quest_HardCore:GetRelativePosY() == 0 then
    Panel_Widget_Quest_HardCore:SetPosX(getScreenSizeX() - Panel_Widget_Quest_HardCore:GetSizeX())
    Panel_Widget_Quest_HardCore:SetPosY(FGlobal_Panel_Radar_GetPosY() + FGlobal_Panel_Radar_GetSizeY() + 32)
  else
    Panel_Widget_Quest_HardCore:SetPosX(getScreenSizeX() * Panel_Widget_Quest_HardCore:GetRelativePosX() - Panel_Widget_Quest_HardCore:GetSizeX() / 2)
    Panel_Widget_Quest_HardCore:SetPosY(getScreenSizeY() * Panel_Widget_Quest_HardCore:GetRelativePosY() - Panel_Widget_Quest_HardCore:GetSizeY() / 2)
  end
end
