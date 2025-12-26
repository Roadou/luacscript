function PaGlobalFunc_Quest_All_Open()
  PaGlobal_Quest_All:prepareOpen()
end
function PaGlobalFunc_Quest_All_Close(isAni)
  PaGlobal_Quest_All:prepareClose(isAni)
end
function PaGlobalFunc_Quest_All_Toggle()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == Panel_Window_Quest_All:GetShow() then
    PaGlobalFunc_Quest_All_Close()
  else
    PaGlobalFunc_Quest_All_Open()
  end
end
function PaGlobalFunc_Quest_All_GetShow()
  if nil == Panel_Window_Quest_All then
    return false
  end
  return Panel_Window_Quest_All:GetShow()
end
function PaGlobalFunc_Quest_All_SetFocusEdit()
  if PaGlobalFunc_Quest_All_GetShow() == false or _ContentsGroup_UsePadSnapping == true or _ContentsGroup_QuestSearch ~= true or ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) ~= false then
    return
  end
  SetFocusEdit(PaGlobal_Quest_All._ui.edt_search)
end
function PaGlobalFunc_Quest_All_ShowAni()
  local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
  local aniInfo1 = Panel_Window_Quest_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_Quest_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Quest_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Quest_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Quest_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Quest_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_Quest_All_HideAni()
  local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
  Panel_Window_Quest_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Quest_All:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function HandleEvent_Quest_All_ListScrollOnce(isUp)
  local self = PaGlobal_Quest_All
  if self == nil then
    return
  end
  local newStartSlotIndex = UIScroll.ScrollEvent(self._ui._listScroll.stc_bg, isUp, self._config.slotMaxCount, self._listCount + 1, self._startSlotIndex, 1)
  if newStartSlotIndex < 1 then
    newStartSlotIndex = 1
  end
  if newStartSlotIndex == self._startSlotIndex then
    return
  else
    if self._isConsole == true and newStartSlotIndex < self._startSlotIndex and self._uiPool.groupTitle[1] ~= nil then
      ToClient_padSnapChangeToTarget(self._uiPool.groupTitle[1].bg)
    end
    self._startSlotIndex = newStartSlotIndex
  end
end
function HandleEvent_Quest_All_ListScroll(isUp)
  HandleEvent_Quest_All_ListScrollOnce(isUp)
  PaGlobal_Quest_All:update()
end
function HandleEventLUp_Quest_All_SetTabMenu(selectIdx)
  if nil == Panel_Window_Quest_All then
    return
  end
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    if selectIdx == 0 then
      local resetResult = true
      if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
        local isSortByTerritory = PaGlobal_Quest_All._ui.combo_questSortType:GetSelectIndex() == 1
        if PaGlobal_Quest_All._searchData.isSortByTerritory ~= isSortByTerritory then
          PaGlobal_Quest_All._searchData.isSortByTerritory = isSortByTerritory
          resetResult = false
        end
      end
      if resetResult == true then
        PaGlobal_Quest_All._searchData.searchText = ""
        PaGlobal_Quest_All._ui.edt_search:SetEditText("")
        PaGlobal_Quest_All._searchData.currentResultIdx = 0
        PaGlobal_Quest_All._searchData.currentGroupIdx = -1
        PaGlobal_Quest_All._searchData.currentQuestIdx = -1
        PaGlobal_Quest_All._searchData.resultGroupNo = -1
        PaGlobal_Quest_All._searchData.resultQuestNo = -1
        PaGlobal_Quest_All._ui.btn_searchUp:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchUpDisable:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchDown:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchDownDisable:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchPCUI:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchReset:SetShow(false)
        for tabIdx = PaGlobal_Quest_All._TABTYPE.PROGRESS, PaGlobal_Quest_All._TABTYPE.COUNT - 1 do
          PaGlobal_Quest_All._resultCount[tabIdx] = 0
        end
      end
    else
      if 0 < PaGlobal_Quest_All._resultCount[selectIdx] then
        PaGlobal_Quest_All._ui.btn_searchUp:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchUpDisable:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchDown:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchDownDisable:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchPCUI:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchReset:SetShow(true)
      else
        PaGlobal_Quest_All._ui.btn_searchUp:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchUpDisable:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchDown:SetShow(false)
        PaGlobal_Quest_All._ui.btn_searchDownDisable:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchPCUI:SetShow(true)
        PaGlobal_Quest_All._ui.btn_searchReset:SetShow(false)
      end
      for index = 1, #PaGlobal_Quest_All._radioTabs do
        PaGlobal_Quest_All._radioTabs[index]:SetCheck(false)
      end
      PaGlobal_Quest_All._radioTabs[selectIdx]:SetCheck(true)
      PaGlobal_Quest_All._currentTab = selectIdx
      local targetControl = PaGlobal_Quest_All._radioTabs[selectIdx]
      local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - PaGlobal_Quest_All._ui.stc_selectBar:GetSizeX() / 2
      PaGlobal_Quest_All._ui.stc_selectBar:SetPosX(selectBarPosX)
    end
  else
    PaGlobal_Quest_All._radioTabs[selectIdx]:SetCheck(true)
    PaGlobal_Quest_All._currentTab = selectIdx
    local targetControl = PaGlobal_Quest_All._radioTabs[selectIdx]
    local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - PaGlobal_Quest_All._ui.stc_selectBar:GetSizeX() / 2
    PaGlobal_Quest_All._ui.stc_selectBar:SetPosX(selectBarPosX)
  end
  if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
    PaGlobal_Quest_All._ui.txt_questCnt:SetShow(true)
    PaGlobal_Quest_All._ui_console.stc_guideHideEmpty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_ALL_EMPTYGROUP_HIDE"))
    PaGlobal_Quest_All._ui_console.stc_guideSortType:SetShow(true)
  else
    PaGlobal_Quest_All._ui.txt_questCnt:SetShow(false)
    PaGlobal_Quest_All._ui_console.stc_guideHideEmpty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_RECOMMAND_HIDE"))
    PaGlobal_Quest_All._ui_console.stc_guideSortType:SetShow(false)
  end
  PaGlobalFunc_Quest_All_Update()
  if _ContentsGroup_QuestSearch ~= true or ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) ~= false then
    return
  end
  if PaGlobal_Quest_All._searchData.resultGroupNo == -1 then
    PaGlobal_Quest_All._ui.txt_searchCount:SetText("0/" .. PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab])
    return
  end
  local openType = PaGlobal_Quest_All:resetAllTabs(false)
  local questListInfo = ToClient_GetQuestList()
  local slotIdx = 0
  local completeHide = PaGlobal_Quest_All._ui.chk_complteHide:IsCheck()
  local groupQuestIdx = 0
  for arrayIdx = 1, PaGlobal_Quest_All._listCount do
    local questGroupInfo, groupIdx
    if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
      if PaGlobal_Quest_All._useArray[arrayIdx].isQuest == true and PaGlobal_Quest_All._searchData.resultQuestNo == PaGlobal_Quest_All._useArray[arrayIdx].questNo then
        groupIdx = PaGlobal_Quest_All._useArray[arrayIdx].groupIdx
        questGroupInfo = questListInfo:getQuestGroupAt(groupIdx)
      end
    else
      groupQuestIdx = 0
      groupIdx = PaGlobal_Quest_All._useArray[arrayIdx].groupIdx
      if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.RECOMMEND then
        questGroupInfo = questListInfo:getRecommendationQuestGroupAt(groupIdx)
      elseif PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.REPEAT then
        questGroupInfo = questListInfo:getRepetitionQuestGroupAt(groupIdx)
      elseif PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.MAIN then
        questGroupInfo = questListInfo:getMainQuestGroupAt(groupIdx)
      elseif PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.NEW then
        questGroupInfo = questListInfo:getNewQuestGroupAt(groupIdx)
      end
    end
    if questGroupInfo ~= nil then
      for questIdx = 0, questGroupInfo:getQuestCount() - 1 do
        local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
        local isHidden = false
        if uiQuestInfo:checkHideCondition() == false and uiQuestInfo:checkVisibleCondition() == true then
          if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
            if PaGlobal_Quest_All._useArray[arrayIdx].isCleared == true then
              isHidden = true
            end
          elseif completeHide == true then
            if uiQuestInfo._isCleared == false then
              groupQuestIdx = groupQuestIdx + 1
            else
              isHidden = true
            end
          else
            groupQuestIdx = groupQuestIdx + 1
          end
          if isHidden == false and PaGlobal_Quest_All._searchData.resultGroupNo == uiQuestInfo:getQuestNo()._group and PaGlobal_Quest_All._searchData.resultQuestNo == uiQuestInfo:getQuestNo()._quest then
            PaGlobal_Quest_All._searchData.currentGroupIdx = groupIdx
            PaGlobal_Quest_All._searchData.currentQuestIdx = questIdx
            slotIdx = arrayIdx
            break
          end
        end
      end
      if slotIdx ~= 0 then
        break
      end
    end
  end
  if PaGlobal_Quest_All._ui.edt_search:GetEditText() ~= PaGlobal_Quest_All._searchData.searchText then
    PaGlobal_Quest_All._ui.edt_search:SetEditText(PaGlobal_Quest_All._searchData.searchText)
  end
  if slotIdx ~= 0 then
    PaGlobal_Quest_All:searchResultCountTabs()
    PaGlobal_Quest_All._ui.txt_searchCount:SetText(PaGlobal_Quest_All._searchData.currentResultIdx .. "/" .. PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab])
    PaGlobal_Quest_All:setScrollToResultSlot(openType, PaGlobal_Quest_All._searchData.currentGroupIdx, groupQuestIdx, slotIdx)
  else
    PaGlobal_Quest_All._searchData.currentResultIdx = -1
    PaGlobal_Quest_All._searchData.currentGroupIdx = -1
    PaGlobal_Quest_All._searchData.currentQuestIdx = -1
    PaGlobal_Quest_All._ui.txt_searchCount:SetText("0/" .. PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab])
  end
  PaGlobal_Quest_All:update()
end
function HandleEvent_Quest_All_SearchAndShowQuest(isUp)
  if Panel_Window_Quest_All == nil then
    return
  end
  if Panel_Tooltip_Item ~= nil and Panel_Tooltip_Item:IsShow() == true then
    Panel_Tooltip_Item_hideTooltip()
  end
  if Panel_Tooltip_SimpleText ~= nil and Panel_Tooltip_SimpleText:IsShow() == true then
    TooltipSimple_Hide()
  end
  local maxTabCount = PaGlobal_Quest_All._TABTYPE.COUNT - 1
  for toNextIdx = 1, maxTabCount do
    PaGlobal_Quest_All:searchQuestCurrentTab(isUp)
    local newTab = PaGlobal_Quest_All._currentTab
    if PaGlobal_Quest_All._searchData.currentGroupIdx ~= -1 then
      break
    end
    if isUp == true then
      newTab = (newTab - 1 - 1 + maxTabCount) % maxTabCount + 1
      PaGlobal_Quest_All._searchData.currentResultIdx = PaGlobal_Quest_All._resultCount[newTab]
    else
      newTab = (newTab - 1 + 1) % maxTabCount + 1
      PaGlobal_Quest_All._searchData.currentResultIdx = 0
    end
    HandleEventLUp_Quest_All_SetTabMenu(newTab)
  end
  if PaGlobal_Quest_All._searchData.currentGroupIdx == -1 and PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab] > 0 then
    PaGlobal_Quest_All:searchQuestCurrentTab(isUp)
  end
  PaGlobal_Quest_All:searchResultCountTabs()
  local clampedIdx = math.min(PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab], math.max(0, PaGlobal_Quest_All._searchData.currentResultIdx))
  PaGlobal_Quest_All._ui.txt_searchCount:SetText(clampedIdx .. "/" .. PaGlobal_Quest_All._resultCount[PaGlobal_Quest_All._currentTab])
  local isNext = false
  local questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  local questInfo = ToClient_GetQuestInfo(PaGlobal_Quest_All._searchData.resultGroupNo, PaGlobal_Quest_All._searchData.resultQuestNo)
  if questInfo == nil then
    local questGroupInfo
    local questListInfo = ToClient_GetQuestList()
    if PaGlobal_Quest_All._TABTYPE.RECOMMEND == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getRecommendationQuestGroupAt(PaGlobal_Quest_All._searchData.currentGroupIdx)
    elseif PaGlobal_Quest_All._TABTYPE.REPEAT == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getRepetitionQuestGroupAt(PaGlobal_Quest_All._searchData.currentGroupIdx)
    elseif PaGlobal_Quest_All._TABTYPE.NEW == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getNewQuestGroupAt(PaGlobal_Quest_All._searchData.currentGroupIdx)
    else
      questGroupInfo = questListInfo:getMainQuestGroupAt(PaGlobal_Quest_All._searchData.currentGroupIdx)
    end
    if questGroupInfo ~= nil then
      for questIdx = 0, questGroupInfo:getQuestCount() - 1 do
        questInfo = questGroupInfo:getQuestAt(questIdx)
        if questInfo:getQuestNo()._group == PaGlobal_Quest_All._searchData.resultGroupNo and questInfo:getQuestNo()._quest == PaGlobal_Quest_All._searchData.resultQuestNo then
          break
        end
      end
    end
    if questInfo == nil then
      return
    end
    isNext = not questInfo._isCleared
  end
  if questInfo:isSatisfied() == true then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  elseif questInfo._isCleared == false then
    if isNext == true then
      questCondition = QuestConditionCheckType.eQuestConditionCheckType_NotAccept
    else
      questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
    end
  end
  local nextChk = 1
  if isNext == true then
    nextChk = 0
  end
  local groupIdx = PaGlobal_Quest_All._searchData.currentGroupIdx
  if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
    groupIdx = PaGlobal_Quest_All._useArray[PaGlobal_Quest_All._searchData.currentGroupIdx].groupIdx
  end
  HandleEventLUp_Quest_All_ShowDetailInfo(PaGlobal_Quest_All._searchData.resultGroupNo, PaGlobal_Quest_All._searchData.resultQuestNo, questCondition, groupIdx, nextChk, questInfo._isCleared, PaGlobal_Quest_All._searchData.resultUIIdx, true)
end
function HandleEvent_Quest_All_SearchAndShowQuestByEnter()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) == true then
    HandleEvent_Quest_All_SearchAndShowQuest(true)
  else
    HandleEvent_Quest_All_SearchAndShowQuest(false)
  end
end
function HandleEventLUp_Quest_All_SetSearchType()
  if Panel_Window_Quest_All == nil then
    return
  end
  if PaGlobal_Quest_All._ui.combo_questSearchType:GetSelectIndex() == 0 then
    PaGlobal_Quest_All._currentSearchType = PaGlobal_Quest_All._SEARCHTYPE.ALL
  elseif PaGlobal_Quest_All._ui.combo_questSearchType:GetSelectIndex() == 1 then
    PaGlobal_Quest_All._currentSearchType = PaGlobal_Quest_All._SEARCHTYPE.TITLE
  elseif PaGlobal_Quest_All._ui.combo_questSearchType:GetSelectIndex() == 2 then
    PaGlobal_Quest_All._currentSearchType = PaGlobal_Quest_All._SEARCHTYPE.REWARD
  end
end
function HandleEventLUp_Quest_All_PopUp()
  if true == PaGlobal_Quest_All._ui_pc.chk_popUp:IsCheck() then
    Panel_Window_Quest_All:OpenUISubApp()
    if nil ~= Panel_Window_QuestInfo_All and true == Panel_Window_QuestInfo_All:GetShow() then
      PaGlobalFunc_QuestInfo_All_RePosition()
    end
  else
    Panel_Window_Quest_All:CloseUISubApp()
    if nil ~= Panel_Window_QuestInfo_All and true == Panel_Window_QuestInfo_All:GetShow() then
      Panel_Window_QuestInfo_All:CloseUISubApp()
      PaGlobalFunc_QuestInfo_All_RePosition()
    end
  end
  TooltipSimple_Hide()
end
function HandleEventLUp_Quest_All_SelectQuestFavorType(index)
  if PaGlobal_Quest_All._ui._favorType[index] == nil then
    return
  end
  if getSelfPlayer():get():getLevel() < __eCanSetQuestSelectLevel then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORITETYPE_ALERT"))
    if nil ~= PaGlobal_Quest_All._ui._favorType and nil ~= PaGlobal_Quest_All._ui._favorType[index] then
      PaGlobal_Quest_All._ui._favorType[index]:SetCheck(not PaGlobal_Quest_All._ui._favorType[index]:IsCheck())
    end
    return
  end
  if __eQuestSelectType_Count == index then
    PaGlobal_Quest_All:favorCheckAll()
  else
    ToClient_ToggleQuestSelectType(index)
  end
  FGlobal_UpdateQuestFavorType()
  ToClient_WorldmapDoGuideUpdateByFavorTypeChange()
end
function HandleEventLUp_Quest_All_QuestBranch(index)
  PaGlobal_questBranch_Open(index)
end
function HandleEventLUp_Quest_All_QuestShowCheck(groupNo, questNo)
  HandleClicked_QuestShowCheck(groupNo, questNo)
end
function HandleEventLUp_Quest_All_ShowDetailInfo(questGroupId, questId, questCondition_Chk, groupIdx, nextChk, isCleared, uiIdx, ignoreToggle)
  local isProgressingActive = false
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    isProgressingActive = true
  end
  local questListInfo, questGroupInfo, isGroup, groupTitle
  local isNext = false
  local groupCount
  if 0 == nextChk then
    isNext = true
  end
  questListInfo = ToClient_GetQuestList()
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    questGroupInfo = questListInfo:getQuestGroupAt(groupIdx)
    isGroup = questGroupInfo:isGroupQuest()
    groupTitle = "nil"
    groupCount = nil
    if isGroup == true then
      groupCount = questGroupInfo:getTotalQuestCount()
      groupTitle = questGroupInfo:getTitle()
    end
  else
    if PaGlobal_Quest_All._TABTYPE.RECOMMEND == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getRecommendationQuestGroupAt(groupIdx)
    elseif PaGlobal_Quest_All._TABTYPE.REPEAT == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getRepetitionQuestGroupAt(groupIdx)
    elseif PaGlobal_Quest_All._TABTYPE.NEW == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getNewQuestGroupAt(groupIdx)
    elseif PaGlobal_Quest_All._TABTYPE.MAIN == PaGlobal_Quest_All._currentTab then
      questGroupInfo = questListInfo:getMainQuestGroupAt(groupIdx)
    end
    groupTitle = PaGlobal_Quest_All._radioTabs[PaGlobal_Quest_All._currentTab]:GetText()
    groupCount = nil
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupId, questId, questCondition_Chk, groupTitle, groupCount, false, not isProgressingActive, isNext, isCleared, nil, uiIdx, ignoreToggle)
end
function HandleEventLUp_Quest_All_FindWayPrepare(gruopNo, questNo, questCondition, isAuto, uiIdx)
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    ClearFocusEdit()
  end
  local QuestStatic = questList_getQuestStatic(gruopNo, questNo)
  if nil ~= QuestStatic then
    local selectQuestType = QuestStatic:getSelectType()
    if 0 ~= selectQuestType then
      local QuestListInfo = ToClient_GetQuestList()
      if QuestListInfo:isQuestSelectType(selectQuestType) == false then
        PaGlobalFunc_Quest_All_SetQuestSelectType(gruopNo, questNo, questCondition, isAuto, selectQuestType, uiIdx)
      else
        PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
      end
    else
      PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
    end
  end
end
function HandleEventLUp_Quest_All_GiveUp(groupId, questId)
  if PaGlobal_TutorialManager ~= nil and true == PaGlobal_TutorialManager:isBeginnerTutorialQuest(groupId, questId) and true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  local QuestGiveUpConfirm = function()
    PaGlobal_Quest_All._startSlotIndex = math.max(1, PaGlobal_Quest_All._startSlotIndex - 1)
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
function HandleEventLUp_Quest_All_Tag(groupId, questId)
  if _ContentsGroup_OlviaAcademy == false then
    return
  end
  FGlobal_ChattingInput_LinkedQuest(groupId, questId)
end
function HandlePadEventLBRB_Quest_All_MoveTab(value)
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  local selectTab = PaGlobal_Quest_All._currentTab + value
  if selectTab < PaGlobal_Quest_All._TABTYPE.PROGRESS then
    selectTab = PaGlobal_Quest_All._TABTYPE.NEW
  elseif selectTab > PaGlobal_Quest_All._TABTYPE.NEW then
    selectTab = PaGlobal_Quest_All._TABTYPE.PROGRESS
  end
  TooltipSimple_Hide()
  HandlePadEventUpDown_Quest_All_HideSubMenu()
  HandleEventLUp_Quest_All_SetTabMenu(selectTab)
end
function HandlePadEventA_Quest_All_ShowSubMenu(questGroupId, questId, questCondition_Chk, groupIdx, nextChk, isCleared, uiCount)
  if true == HandlePadEventUpDown_Quest_All_HideSubMenu() then
    return
  end
  local subMenuBg = PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg
  subMenuBg:SetShow(true)
  PaGlobal_Quest_All._selectQuestInfo = {
    _questGroupId = questGroupId,
    _questId = questId,
    _questCondition_Chk = questCondition_Chk,
    _groupIdx = groupIdx,
    _nextChk = nextChk,
    _isCleared = isCleared,
    _uiCount = uiCount
  }
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:SetSpanSize(PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:GetSpanSize().x, 6)
  PaGlobal_Quest_All._ui_console._focusMenu.radio_autoNavi:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnAuto:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_questNavi:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnNavi:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_giveUp:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnGiveUp:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_detail:SetShow(true)
  PaGlobal_Quest_All._ui_console._focusMenu.radio_blackSpirit:SetShow(false)
  PaGlobal_Quest_All._ui_console._focusMenu.radio_tag:SetShow(_ContentsGroup_OlviaAcademy == true)
  local btnList = {
    [1] = PaGlobal_Quest_All._ui_console._focusMenu.radio_autoNavi,
    [2] = PaGlobal_Quest_All._ui_console._focusMenu.radio_questNavi,
    [3] = PaGlobal_Quest_All._ui_console._focusMenu.radio_giveUp,
    [4] = PaGlobal_Quest_All._ui_console._focusMenu.radio_detail,
    [5] = PaGlobal_Quest_All._ui_console._focusMenu.radio_blackSpirit,
    [6] = PaGlobal_Quest_All._ui_console._focusMenu.radio_tag
  }
  local baseSpanY = 10
  local firstBtn
  for ii = 1, #btnList do
    if nil ~= btnList[ii] and true == btnList[ii]:GetShow() then
      btnList[ii]:SetSpanSize(btnList[ii]:GetSpanSize().x, baseSpanY)
      baseSpanY = baseSpanY + btnList[ii]:GetSizeY() + 10
      btnList[ii]:ComputePos()
      btnList[ii]:addInputEvent("Mouse_On", "HandleEventOn_Quest_All_SubMenuConfirmIcon(" .. btnList[ii]:GetSpanSize().y .. ")")
      if nil == firstBtn then
        firstBtn = btnList[ii]
      end
    end
  end
  local bgSizeY = baseSpanY
  subMenuBg:SetSize(subMenuBg:GetSizeX(), bgSizeY)
  if nil ~= firstBtn then
    ToClient_padSnapChangeToTarget(firstBtn)
  end
end
function HandlePadEventUpDown_Quest_All_HideSubMenu()
  if false == PaGlobal_Quest_All._isConsole then
    return true
  end
  if nil == PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg then
    return true
  end
  if true == PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg:GetShow() then
    PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg:SetShow(false)
    return true
  end
end
function HandleEventOn_Quest_All_SubMenuConfirmIcon(spanY)
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:SetSpanSize(PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:GetSpanSize().x, spanY - 4)
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:ComputePos()
end
function HandlePadEventA_Quest_All_SubMenuClick(menuType)
  if nil == menuType or "" == menuType then
    return
  end
  HandlePadEventUpDown_Quest_All_HideSubMenu()
  local selectInfo = PaGlobal_Quest_All._selectQuestInfo
  if "autoNavi" == menuType then
    HandleEventLUp_Quest_All_FindWayPrepare(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, true, selectInfo._uiCount)
  elseif "questNavi" == menuType then
    HandleEventLUp_Quest_All_FindWayPrepare(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, false, selectInfo._uiCount)
  elseif "giveUp" == menuType then
    HandleEventLUp_Quest_All_GiveUp(selectInfo._questGroupId, selectInfo._questId)
  elseif "detail" == menuType then
    HandleEventLUp_Quest_All_ShowDetailInfo(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, selectInfo._groupIdx, selectInfo._nextChk, selectInfo._isCleared)
  elseif "blackSpirit" == menuType then
  elseif "tag" == menuType then
    HandleEventLUp_Quest_All_Tag(selectInfo._questGroupId, selectInfo._questId)
  end
end
function HandlePadEventY_Quest_All_ChangeQuestSortType()
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    PaGlobal_Quest_All._ui.combo_questSortType:SetSelectItemIndex((PaGlobal_Quest_All._ui.combo_questSortType:GetSelectIndex() + 1) % PaGlobal_Quest_All._ui.combo_questSortType:GetListSize())
  else
    local isSortByTerritory = not PaGlobal_Quest_All._ui.radio_questTerritory:IsCheck()
    PaGlobal_Quest_All._ui.radio_questType:SetCheck(not isSortByTerritory)
    PaGlobal_Quest_All._ui.radio_questTerritory:SetCheck(isSortByTerritory)
    PaGlobal_Quest_All._searchData.isSortByTerritory = isSortByTerritory
  end
  PaGlobalFunc_Quest_All_Update()
end
function HandlePadEventX_Quest_All_CheckEmptyHideGroup()
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    PaGlobal_Quest_All._ui.chk_emptyGroupHide:SetCheck(not PaGlobal_Quest_All._ui.chk_emptyGroupHide:IsCheck())
  else
    PaGlobal_Quest_All._ui.chk_complteHide:SetCheck(not PaGlobal_Quest_All._ui.chk_complteHide:IsCheck())
  end
  PaGlobalFunc_Quest_All_Update()
end
function HandlePadEventLTY_Quest_All_ChangeQuestTypeSet()
  if getSelfPlayer():get():getLevel() < __eCanSetQuestSelectLevel then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORITETYPE_ALERT"))
    return
  end
  PaGlobalFunc_QuestTypeSet_All_Open()
end
function HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(isShow, index)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_Window_Quest_All then
    return
  end
  if PaGlobal_Quest_All._ui._favorType[index] == nil then
    return
  end
  local name, desc, control
  local control = PaGlobal_Quest_All._ui._favorType[index]
  if __eQuestSelectType_Count == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ALL")
  elseif __eQuestSelectType_Main == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_STORY")
  elseif __eQuestSelectType_BlackSpirit == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_BLACKSPIRIT")
  elseif __eQuestSelectType_Sub == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_SUB")
  elseif __eQuestSelectType_Adventure == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE4")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ADVENTURE")
  elseif __eQuestSelectType_Life == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE5")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_LIFE")
  elseif __eQuestSelectType_Contents == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE6")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_CONTENTS")
  elseif __eQuestSelectType_Event == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE7")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_EVENT")
  elseif __eQuestSelectType_Etc == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE8")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ETC")
  elseif 99 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_FAVORTYPE")
    control = PaGlobal_Quest_All._ui.txt_favorType
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Quest_All_PopUp(isShow)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc = ""
  if true == PaGlobal_Quest_All._ui_pc.chk_popUp:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(PaGlobal_Quest_All._ui_pc.chk_popUp, name, desc)
end
function HandleEventLUp_Quest_All_ToggleSortType()
  PaGlobal_Quest_All._ui.combo_questSortType:ToggleListbox()
end
function HandleEventLUp_Quest_All_ToggleSearchType()
  PaGlobal_Quest_All._ui.combo_questSearchType:ToggleListbox()
end
function HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(isShow, tipType)
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    if tipType == 2 then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_EMPTYGROUP_HIDE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_EMPTYGROUP_DESC")
      control = PaGlobal_Quest_All._ui.chk_emptyGroupHide
    else
      if PaGlobal_Quest_All._ui.combo_questSortType:GetSelectIndex() == 0 then
        name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_QUESTTYPE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GRUOP_ORDER_DESC")
      elseif PaGlobal_Quest_All._ui.combo_questSortType:GetSelectIndex() == 1 then
        name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_ZONE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_TERRITORY_ORDER_DESC")
      end
      control = PaGlobal_Quest_All._ui.combo_questSortType
    end
  elseif tipType == 0 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_QUESTTYPE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GRUOP_ORDER_DESC")
    control = PaGlobal_Quest_All._ui.radio_questType
  elseif tipType == 1 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_ZONE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_TERRITORY_ORDER_DESC")
    control = PaGlobal_Quest_All._ui.radio_questTerritory
  elseif tipType == 2 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_EMPTYGROUP_HIDE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_EMPTYGROUP_DESC")
    control = PaGlobal_Quest_All._ui.chk_emptyGroupHide
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Quest_All_ShowCondition(isShow, arrayIdx, uiIdx, buttonType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    local name, desc, control, icon = "", "", nil, nil
    if nil ~= buttonType then
      if 0 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_AUTONAVI_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_AUTONAVI_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi
        icon = PaGlobal_Quest_All._ui._listTemplate.stc_autoNavi
      elseif 1 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_NAVI_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_NAVI_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto
        icon = PaGlobal_Quest_All._ui._listTemplate.stc_questNavi
      elseif 2 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GIVEUP_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GIVEUP_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnGiveUp
        icon = PaGlobal_Quest_All._ui._listTemplate.stc_giveUp
      elseif 3 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_TAG_TOOLTIP_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_TAG_TOOLTIP_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnTag
        icon = PaGlobal_Quest_All._ui._listTemplate.stc_tag
      end
      TooltipSimple_Show(control, name, desc, icon)
    end
  else
    local control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].name
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_ACCEPTCONDITION")
    local desc = PaGlobal_Quest_All._useArray[arrayIdx].isShowWidget
    local icon = false
    if nil ~= buttonType then
      if 0 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_AUTONPCNAVI_HELP")
      elseif 1 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_NPCNAVI_HELP")
      elseif 2 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnGiveUp
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_GIVEUP_HELP")
      elseif 3 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnTag
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_TAG_HELP")
      end
    end
    TooltipSimple_Show(control, name, desc, icon)
  end
  HandlePadEventUpDown_Quest_All_HideSubMenu()
end
function HandleEventOnOut_Quest_All_GroupTitleSimpleTooltip(isShow, idx, uiCount, baseCount)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if not PaGlobal_Quest_All._uiPool.groupTitle[uiCount].name:IsLimitText() then
    return
  end
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local title = PaGlobal_Quest_All._useArray[idx].title
  local completeCount = PaGlobal_Quest_All._questArrayGroupCompleteCount[PaGlobal_Quest_All._useArray[idx].groupIdx]
  local totalCount = PaGlobal_Quest_All._questArrayGroupCount[PaGlobal_Quest_All._useArray[idx].groupIdx]
  name = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_GROUPTITLE", "title", title, "count", completeCount .. "/" .. totalCount)
  control = PaGlobal_Quest_All._uiPool.groupTitle[uiCount].bg
  TooltipSimple_Show(control, name, desc)
  HandlePadEventUpDown_Quest_All_HideSubMenu()
end
function FromClient_Quest_All_UpdateQuestList()
  if Panel_Window_Quest_All:GetShow() == false then
    return
  end
  PaGlobal_Quest_All:update()
end
function FromClient_Quest_All_Resize()
  PaGlobal_Quest_All:resize()
end
function FromClient_Quest_All_SelfPlayerLevelUp()
  if PaGlobal_Quest_All == nil then
    return
  end
  PaGlobal_Quest_All:checkFavorCheckType()
end
function PaGlobalFunc_Quest_All_Audio(group, index)
  if PaGlobal_Quest_All._isConsole then
    audioPostEvent_SystemUi(group, index)
  else
    _AudioPostEvent_SystemUiForXBOX(group, index)
  end
end
function PaGlobalFunc_Quest_All_Update()
  PaGlobal_Quest_All._startSlotIndex = 1
  PaGlobal_Quest_All._ui._listScroll.stc_bg:SetControlTop()
  PaGlobal_Quest_All:update()
end
function PaGlobalFunc_Quest_All_SetProgress()
  for key, value in ipairs(PaGlobal_Quest_All._radioTabs) do
    if nil ~= value then
      value:SetCheck(false)
    end
  end
  PaGlobal_Quest_All._radioTabs[PaGlobal_Quest_All._TABTYPE.PROGRESS]:SetCheck(true)
end
function PaGlobalFunc_Quest_All_FavorTypeUpdate()
  PaGlobal_Quest_All:favorTypeUpdate()
end
function PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
  local QuestStatic = questList_getQuestStatic(gruopNo, questNo)
  if nil ~= QuestStatic then
    if QuestConditionCheckType.eQuestConditionCheckType_Complete == questCondition then
      if true == QuestStatic:isCompleteBlackSpirit() then
        PaGlobal_Quest_All._selectWay.groupID = ""
        PaGlobal_Quest_All._selectWay.questID = ""
        HandleClicked_CallBlackSpirit()
      else
        HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
      end
    elseif QuestConditionCheckType.eQuestConditionCheckType_NotAccept == questCondition then
      if 0 == QuestStatic:getAccecptNpc():get() then
        PaGlobal_Quest_All._selectWay.groupID = ""
        PaGlobal_Quest_All._selectWay.questID = ""
        HandleClicked_CallBlackSpirit()
      else
        HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
      end
    else
      HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
    end
  end
end
function PaGlobalFunc_Quest_All_UpdateFindWay(groupId, questId, isAuto)
  if PaGlobal_Quest_All._selectWay.groupID == groupId and PaGlobal_Quest_All._selectWay.questID == questId then
    PaGlobal_Quest_All._selectWay.groupID = ""
    PaGlobal_Quest_All._selectWay.questID = ""
    PaGlobal_Quest_All._selectWay.isAuto = false
  else
    PaGlobal_Quest_All._selectWay.groupID = groupId
    PaGlobal_Quest_All._selectWay.questID = questId
    PaGlobal_Quest_All._selectWay.isAuto = isAuto
  end
  if true == Panel_Window_Quest_All:GetShow() then
    PaGlobal_Quest_All:update()
  end
  if true == Panel_Window_QuestInfo_All:GetShow() then
    PaGlobalFunc_QuestInfo_All_Update()
  end
  if ToClient_HardCoreChannelWithContensOption() == true and Panel_Window_Quest_HardCore:GetShow() == true then
    PaGlobal_HardCoreQuestDetails_UpdateQuestInfo()
  end
end
function PaGlobalFunc_Quest_All_SetQuestSelectType(gruopNo, questNo, questCondition, isAuto, selectQuestType, uiIdx)
  if selectQuestType < 0 or selectQuestType >= __eQuestSelectType_Count then
    return
  end
  local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "GUILD_MESSAGEBOX_TITLE")
  local messageboxContent = ""
  if true == PaGlobal_Quest_All._isConsole then
    messageboxContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORTYPE_ENABLE_CONSOLE", "favortype", PaGlobal_Quest_All._questSelectTypeString[selectQuestType])
  else
    messageboxContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORTYPE_ENABLE", "favortype", PaGlobal_Quest_All._questSelectTypeString[selectQuestType])
  end
  local function funcSetQuestSelectType()
    local QuestListInfo = ToClient_GetQuestList()
    QuestListInfo:setQuestSelectType(selectQuestType, true)
    FGlobal_UpdateQuestFavorType()
    PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
  end
  local function funcResetCheckButton()
    PaGlobalFunc_QuestInfo_All_DenySetQuestTypeResetButton(gruopNo, questNo)
    if -1 == uiIdx or nil == PaGlobal_Quest_All._uiPool.listMain[uiIdx] then
      return
    end
    PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto:SetCheck(false)
    PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi:SetCheck(false)
  end
  local messageboxData = {
    title = messageboxTitle,
    content = messageboxContent,
    functionYes = funcSetQuestSelectType,
    functionNo = funcResetCheckButton,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Quest_All_GroupTitleUpdateExpand(isRegion, Idx, uiIdx)
  local isOpenableOnlyGroupOne, isOpenGroup
  if 0 == isRegion then
    isOpenableOnlyGroupOne = false
    isOpenGroup = not PaGlobal_Quest_All._regionOpen[Idx].isOpen
  elseif 1 == isRegion then
    isOpenableOnlyGroupOne = false
    isOpenGroup = not PaGlobal_Quest_All._typeOpen[Idx].isOpen
  elseif 2 == isRegion then
    isOpenableOnlyGroupOne = true
    isOpenGroup = not PaGlobal_Quest_All._groupOpen._recommendation[Idx].isOpen
  elseif 3 == isRegion then
    isOpenableOnlyGroupOne = true
    isOpenGroup = not PaGlobal_Quest_All._groupOpen._repetitive[Idx].isOpen
  elseif 4 == isRegion then
    isOpenableOnlyGroupOne = true
    isOpenGroup = not PaGlobal_Quest_All._groupOpen._main[Idx].isOpen
  elseif 5 == isRegion then
    isOpenableOnlyGroupOne = true
    isOpenGroup = not PaGlobal_Quest_All._groupOpen._new[Idx].isOpen
  end
  if isOpenableOnlyGroupOne == nil or isOpenGroup == nil then
    return
  end
  if isOpenableOnlyGroupOne == true and isOpenGroup == true then
    local questListInfo = ToClient_GetQuestList()
    local isExistOpenedGroup = false
    local isOpenedGroupIdx
    if 2 == isRegion then
      questGroupCount = questListInfo:getRecommendationQuestGroupCount()
      for groupIdx = 0, questGroupCount - 1 do
        if PaGlobal_Quest_All._groupOpen._recommendation[groupIdx].isOpen == true then
          PaGlobal_Quest_All._groupOpen._recommendation[groupIdx].isOpen = false
          isExistOpenedGroup = true
          isOpenedGroupIdx = groupIdx
          break
        end
      end
    elseif 3 == isRegion then
      questGroupCount = questListInfo:getRepetitionQuestGroupCount()
      for groupIdx = 0, questGroupCount - 1 do
        if PaGlobal_Quest_All._groupOpen._repetitive[groupIdx].isOpen == true then
          PaGlobal_Quest_All._groupOpen._repetitive[groupIdx].isOpen = false
          isExistOpenedGroup = true
          isOpenedGroupIdx = groupIdx
          break
        end
      end
    elseif 4 == isRegion then
      questGroupCount = questListInfo:getMainQuestGroupCount()
      for groupIdx = 0, questGroupCount - 1 do
        if PaGlobal_Quest_All._groupOpen._main[groupIdx].isOpen == true then
          PaGlobal_Quest_All._groupOpen._main[groupIdx].isOpen = false
          isExistOpenedGroup = true
          isOpenedGroupIdx = groupIdx
          break
        end
      end
    elseif 5 == isRegion then
      questGroupCount = questListInfo:getNewQuestGroupCount()
      for groupIdx = 0, questGroupCount - 1 do
        if PaGlobal_Quest_All._groupOpen._new[groupIdx].isOpen == true then
          PaGlobal_Quest_All._groupOpen._new[groupIdx].isOpen = false
          isExistOpenedGroup = true
          isOpenedGroupIdx = groupIdx
          break
        end
      end
    end
    if isExistOpenedGroup == true then
      local preScrollPos = PaGlobal_Quest_All._startSlotIndex
      local closeQuestCount = PaGlobal_Quest_All._questArrayGroupCount[isOpenedGroupIdx]
      local openGroupIndex = -1
      local closeGroupIndex = -1
      for idx = 1, #PaGlobal_Quest_All._useArray do
        local value = PaGlobal_Quest_All._useArray[idx]
        if value ~= nil then
          if value.groupIdx == isOpenedGroupIdx then
            closeGroupIndex = idx
          elseif value.groupIdx == Idx then
            openGroupIndex = idx
          end
        end
      end
      if openGroupIndex ~= -1 and closeGroupIndex ~= -1 and closeGroupIndex < openGroupIndex then
        PaGlobal_Quest_All._startSlotIndex = preScrollPos - closeQuestCount
        if 1 > PaGlobal_Quest_All._startSlotIndex then
          PaGlobal_Quest_All._startSlotIndex = 1
        end
      end
    end
  end
  if 0 == isRegion then
    PaGlobal_Quest_All._regionOpen[Idx].isOpen = isOpenGroup
  elseif 1 == isRegion then
    PaGlobal_Quest_All._typeOpen[Idx].isOpen = isOpenGroup
  elseif 2 == isRegion then
    PaGlobal_Quest_All._groupOpen._recommendation[Idx].isOpen = isOpenGroup
  elseif 3 == isRegion then
    PaGlobal_Quest_All._groupOpen._repetitive[Idx].isOpen = isOpenGroup
  elseif 4 == isRegion then
    PaGlobal_Quest_All._groupOpen._main[Idx].isOpen = isOpenGroup
  elseif 5 == isRegion then
    PaGlobal_Quest_All._groupOpen._new[Idx].isOpen = isOpenGroup
  end
  PaGlobal_Quest_All:update()
end
function PaGlobalFunc_Quest_All_GetProgressQuestCount()
  return PaGlobal_Quest_All._progressQuestCount
end
function FromClient_Quest_All_QuestBackEndLoadComplete(s32_questNoRaw)
  if Panel_Window_Quest_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if Panel_Window_Quest_All:GetShow() == false then
    return
  end
  if PaGlobal_Quest_All:isExistLoadingDataAnyOne() == false then
    return
  end
  local updateTargetType = PaGlobal_Quest_All._TABTYPE.COUNT
  local updateTargetGroupIdx = -1
  for index = 1, #PaGlobal_Quest_All._questLoadingDataList do
    local value = PaGlobal_Quest_All._questLoadingDataList[index]
    if value ~= nil and value._questNoRaw == s32_questNoRaw then
      updateTargetType = value._tabIndex
      updateTargetGroupIdx = value._groupIndex
      table.remove(PaGlobal_Quest_All._questLoadingDataList, index)
      break
    end
  end
  if PaGlobal_Quest_All:isExistLoadingDataAnyOne() == false then
    if updateTargetType == PaGlobal_Quest_All._TABTYPE.COUNT or updateTargetGroupIdx == -1 then
      return
    end
    if updateTargetType == PaGlobal_Quest_All._TABTYPE.MAIN then
      PaGlobal_Quest_All._groupOpen._main[updateTargetGroupIdx].isOpen = true
      PaGlobal_Quest_All._groupOpen._main[updateTargetGroupIdx].isLoading = false
    elseif updateTargetType == PaGlobal_Quest_All._TABTYPE.RECOMMEND then
      PaGlobal_Quest_All._groupOpen._recommendation[updateTargetGroupIdx].isOpen = true
      PaGlobal_Quest_All._groupOpen._recommendation[updateTargetGroupIdx].isLoading = false
    elseif updateTargetType == PaGlobal_Quest_All._TABTYPE.REPEAT then
      PaGlobal_Quest_All._groupOpen._repetitive[updateTargetGroupIdx].isOpen = true
      PaGlobal_Quest_All._groupOpen._repetitive[updateTargetGroupIdx].isLoading = false
    elseif updateTargetType == PaGlobal_Quest_All._TABTYPE.NEW then
      PaGlobal_Quest_All._groupOpen._new[updateTargetGroupIdx].isOpen = true
      PaGlobal_Quest_All._groupOpen._new[updateTargetGroupIdx].isLoading = false
    elseif updateTargetType == PaGlobal_Quest_All._TABTYPE.PROGRESS then
      if PaGlobal_Quest_All._searchData.isSortByTerritory == true then
        for groupIndex = 1, #PaGlobal_Quest_All._progessQuestLoadingGroup do
          PaGlobal_Quest_All._regionOpen[groupIndex].isOpen = true
          PaGlobal_Quest_All._regionOpen[groupIndex].isLoading = false
        end
      else
        for index = 1, #PaGlobal_Quest_All._progessQuestLoadingGroup do
          PaGlobal_Quest_All._typeOpen[groupIndex].isOpen = true
          PaGlobal_Quest_All._typeOpen[groupIndex].isLoading = false
        end
      end
    else
      return
    end
    PaGlobal_Quest_All:update()
    return
  end
end
