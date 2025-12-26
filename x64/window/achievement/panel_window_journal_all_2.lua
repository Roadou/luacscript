function PaGlobal_Journal_All_Open(journalListIndex)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  self:prepareOpen(journalListIndex)
end
function PaGlobal_Journal_All_Close()
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  if Panel_Window_Journal_Page_All ~= nil and Panel_Window_Journal_Page_All:GetShow() == true then
    PaGlobal_Journal_Page_All_Close()
    return
  end
  self:prepareClose()
end
function PaGlobal_Journal_All_ExecuteLuaFunc(funcText)
  if getSelfPlayer() == nil then
    return
  end
  if funcText == "MorningLandStart" then
    PaGlobal_Journal_All_OpenMorningLand()
    PaGlobal_MorningLand_QuestBoardAlert_All_Open()
  elseif funcText == "EdaniaStart" then
    PaGlobal_Journal_All_OpenEdania()
  end
end
function PaGlobal_Journal_All_CheckStamp(isAccept, questNoRaw)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  if isAccept == nil or isAccept == true or questNoRaw == nil then
    return
  end
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  if questInfoWrapper == nil then
    return
  end
  local questNo = questInfoWrapper:getQuestNo()
  self._stampQuestGroupNo = questNo._group
end
function PaGlobal_Journal_All_OpenBookShelfQuest(bookGroupId, bookQuestId)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  if bookGroupId == nil or bookQuestId == nil then
    return
  end
  PaGlobalFunc_Achievement_OpenBookShelfQuest(bookGroupId, bookQuestId, self._currentJournalListIndex)
end
function PaGlobal_Journal_All_ChangePage(isRight)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  self:changePage(isRight)
end
function PaGlobal_Journal_All_NextPageChangeAni(deltaTime)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  PaGlobal_Journal_All:showAni_NextPage(deltaTime)
end
function PaGlobal_Journal_All_PrevPageChangeAni(deltaTime)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  PaGlobal_Journal_All:showAni_PrevPage(deltaTime)
end
function PaGlobal_Journal_All_ClickNextJournalButton(isRight)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  local pageInfo = self._pageInfo[self._currentPage]
  if pageInfo == nil then
    return
  end
  if Panel_Window_Journal_Page_All ~= nil and Panel_Window_Journal_Page_All:GetShow() == true then
    PaGlobal_Journal_Page_All_Close()
  end
  if isRight == true then
    self._currentJournalStartIndex = self._currentJournalStartIndex + 1
    local maxStartIndex = pageInfo._journalCount - self._uiTypeMaxJournalCount[pageInfo._uiType] + 1
    if maxStartIndex < self._currentJournalStartIndex then
      self._currentJournalStartIndex = maxStartIndex
    end
  else
    self._currentJournalStartIndex = self._currentJournalStartIndex - 1
    if self._currentJournalStartIndex < 1 then
      self._currentJournalStartIndex = 1
    end
  end
  self:updatePage(pageInfo, self._currentJournalStartIndex, self._currentJournalStartIndex - 1 + self._uiTypeMaxJournalCount[pageInfo._uiType])
end
function PaGlobal_Journal_All_OpenMorningLand()
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  self:prepareOpen(self._journalListType._morningLand)
end
function PaGlobal_Journal_All_isAnotherQuestProgressing(currentJournalInfo)
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  if self._currentJournalListIndex == nil then
    return
  end
  local currentChapterIndex = currentJournalInfo._chapterIndex
  local currentUiTypeIndex = currentJournalInfo._uiTypeIndex
  local currentJournalIndex = currentJournalInfo._journalIndex
  local isProgressing = false
  local journalCount = ToClient_getJournalInfoCount(self._currentJournalListIndex, currentChapterIndex, currentUiTypeIndex)
  for journalIndex = 1, journalCount do
    if isProgressing == false then
      local journalInfo = ToClient_getJournalInfo(self._currentJournalListIndex, currentChapterIndex, currentUiTypeIndex, journalIndex)
      local uiQuestInfo = ToClient_GetQuestInfo(journalInfo._questGroupNo, 1)
      if uiQuestInfo ~= nil and uiQuestInfo._isProgressing == true then
        isProgressing = true
      end
      if questList_isClearQuest(journalInfo._questGroupNo, 1) == true and ToClient_isCompleteJournal(journalInfo) == false then
        isProgressing = true
      end
    end
  end
  return isProgressing
end
function PaGlobal_Journal_All_OpenEdania()
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  self:prepareOpen(self._journalListType._edania)
end
