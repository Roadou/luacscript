function PaGlobalFunc_Achievement_MorningLand_Open(journalKey, chapterKey, pageIndex)
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  self:prepareOpen(journalKey, chapterKey, pageIndex)
end
function PaGlobalFunc_Achievement_MorningLand_Close()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  if self._ui._stc_artworkFullScreen:GetShow() == true then
    self:closeArtworkImageControl()
  else
    self:prepareClose()
  end
end
function PaGlobalFunc_Achievement_MorningLand_ChangeBackPageAnimation(deltaTime)
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  self:updateBackPageAnimation(deltaTime)
end
function PaGlobalFunc_Achievement_MorningLand_ChangeNextPageAnimation(deltaTime)
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  self:updateNextPageAnimation(deltaTime)
end
function HandleEventlUp_Achievement_MorningLand_ButtonLeft()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  if self._currentPageIndex == 1 then
    return
  end
  self:setPage(self._currentPageIndex - 1)
end
function HandleEventlUp_Achievement_MorningLand_ButtonRight()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  if self._currentPageIndex == self._currentPageCount then
    return
  end
  self:setPage(self._currentPageIndex + 1)
end
function HandleEventlUp_Achievement_MorningLand_ButtonBookMark()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  if self._currentJournalKey == nil or self._currentChapterKey == nil then
    return
  end
  local currentBookmarkPage = ToClient_GetJournalBookMark(self._currentJournalKey, self._currentChapterKey)
  if currentBookmarkPage == 0 then
    ToClient_SetJournalBookMark(self._currentJournalKey, self._currentChapterKey, self._currentPageIndex)
    self:updateBookMarkButton()
  elseif currentBookmarkPage == self._currentPageIndex then
    ToClient_RemoveJournalBookMark(self._currentJournalKey, self._currentChapterKey)
    self:updateBookMarkButton()
  else
    self:setPage(currentBookmarkPage)
  end
end
function HandleEventlUp_Achievement_MorningLand_ButtonArtworkPlay()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  local currentPageData = self._dataList[self._currentPageIndex]
  if currentPageData == nil then
    return
  end
  if isMoviePlayMode() == true then
    return
  end
  ToClient_PlayJournalVideo(currentPageData._questNo)
end
function HandleEventlUp_Achievement_MorningLand_ButtonArtworkOpen()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  local currentPageData = self._dataList[self._currentPageIndex]
  if currentPageData == nil then
    return
  end
  self:openArtworkImageControl()
end
function HandleEventlUp_Achievement_MorningLand_ButtonArtworkClose()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  self:closeArtworkImageControl()
end
function HandleEventRSUp_Achievement_MorningLand()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    _PA_ASSERT(false, "why?")
    return
  end
  if self._ui._stc_leftFrame == nil then
    _PA_ASSERT(false, "why??")
    return
  end
  self._ui._stc_leftFrame:MouseUpScroll(self._ui._stc_leftFrame)
end
function HandleEventRSDown_Achievement_MorningLand()
  local self = PaGlobal_Achievement_MorningLand
  if self == nil then
    return
  end
  if self._ui._stc_leftFrame == nil then
    return
  end
  self._ui._stc_leftFrame:MouseDownScroll(self._ui._stc_leftFrame)
end
