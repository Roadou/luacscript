PaGlobal_Journal_Book_All = {
  _ui = {
    _stc_mainBG = nil,
    _stc_title = nil,
    _stc_leftFrame = nil,
    _stc_leftFrameContent = nil,
    _stc_leftFrameDesc = nil,
    _stc_emptyPageDesc = nil,
    _stc_image = nil,
    _btn_pageLeft = nil,
    _btn_pageRight = nil,
    _btn_left = nil,
    _btn_right = nil,
    _btn_close = nil,
    _btn_bookMark = nil,
    _stc_addEffect = nil,
    _stc_artworkArea = nil,
    _stc_artworkImage = nil,
    _btn_artworkPageLeft = nil,
    _btn_artworkPageRight = nil,
    _btn_artworkLeft = nil,
    _btn_artworkRight = nil,
    _btn_artworkPlay = nil,
    _btn_artworkClose = nil,
    _btn_artworkFullScreen = nil,
    _stc_artworkFullScreen = nil,
    _stc_artwork2KImage = nil,
    _stc_emptyPageRight = nil
  },
  _originalTitleTextSpanY = 0,
  _autowrapTitleTextSpanY = 0,
  _pageAnimationDeltaTime = 0,
  _pageAnimationSpeed = 2400,
  _pageAnimationNextPageXSize = 0,
  _dataList = nil,
  _currentJournalKey = nil,
  _currentChapterKey = nil,
  _currentPageIndex = nil,
  _currentPageCount = nil,
  _journalListIndex = nil,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Journal_Book_All_luaLoadeComplete")
function FromClient_PaGlobal_Journal_Book_All_luaLoadeComplete()
  PaGlobal_Journal_Book_All:initialize()
end
function PaGlobal_Journal_Book_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local leftBg = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_LeftArea")
  local rightBg = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_RightArea")
  local bottomBg = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_BottomArea")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_Template_ListBG")
  self._ui._stc_title = UI.getChildControl(leftBg, "StaticText_Title")
  self._ui._stc_leftFrame = UI.getChildControl(leftBg, "Frame_1")
  self._ui._stc_leftFrameContent = UI.getChildControl(self._ui._stc_leftFrame, "Frame_1_Content")
  self._ui._stc_leftFrameDesc = UI.getChildControl(self._ui._stc_leftFrameContent, "StaticText_Desc")
  self._ui._stc_emptyPageDesc = UI.getChildControl(leftBg, "StaticText_EmptyPageDesc")
  self._ui._stc_image = UI.getChildControl(rightBg, "Static_Image")
  self._ui._btn_pageLeft = UI.getChildControl(leftBg, "Button_PagePrevious")
  self._ui._btn_pageRight = UI.getChildControl(rightBg, "Button_PagePreview")
  self._ui._btn_left = UI.getChildControl(bottomBg, "Button_Previous")
  self._ui._btn_right = UI.getChildControl(bottomBg, "Button_Preview")
  self._ui._btn_close = UI.getChildControl(Panel_Window_Journal_Book_All, "Button_Win_Close")
  self._ui._btn_bookMark = UI.getChildControl(Panel_Window_Journal_Book_All, "CheckButton_BookMark")
  self._ui._stc_addEffect = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_AddEffect")
  self._ui._stc_artworkArea = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_ArtworkArea")
  self._ui._stc_artworkImage = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork")
  self._ui._btn_artworkPageLeft = UI.getChildControl(self._ui._stc_artworkArea, "Button_Artwork_PagePrevious")
  self._ui._btn_artworkPageRight = UI.getChildControl(self._ui._stc_artworkArea, "Button_Artwork_PagePreview")
  local artworkBottomArea = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_BottomArea")
  self._ui._btn_artworkLeft = UI.getChildControl(artworkBottomArea, "Button_Artwork_Previous")
  self._ui._btn_artworkRight = UI.getChildControl(artworkBottomArea, "Button_Artwork_Preview")
  self._ui._btn_artworkPlay = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_Play")
  self._ui._btn_artworkClose = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_Close")
  self._ui._btn_artworkFullScreen = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_DtailView")
  self._ui._stc_artworkFullScreen = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_OriginArtworkArea")
  self._ui._stc_artwork2KImage = UI.getChildControl(self._ui._stc_artworkFullScreen, "Static_OriginArtwork")
  self._ui._stc_emptyPageRight = UI.getChildControl(rightBg, "Static_HiddenImg_R")
  self._ui._stc_mainBG:SetShow(false)
  self._ui._stc_mainBG:SetRectClipOnArea(float2(0, 0), float2(430, 50))
  self._ui._stc_title:SetTextVerticalTop()
  self._ui._stc_title:SetTextHorizonCenter()
  self._ui._stc_title:SetTextMode(__eTextMode_AutoWrap)
  self._originalTitleTextSpanY = self._ui._stc_title:GetSpanSize().y
  self._autowrapTitleTextSpanY = self._originalTitleTextSpanY - 15
  self._ui._stc_leftFrameDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_leftFrameDesc:SetTextVerticalTop()
  self._ui._stc_leftFrameDesc:SetTextHorizonLeft()
  self._ui._stc_emptyPageDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_emptyPageDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLAND_STORYBOOK_LOCKED"))
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Journal_Book_All:registEventHandler()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._ui._btn_left:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_right:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_artworkLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_artworkRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_artworkClose:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Book_All_Close()")
  self._ui._stc_artwork2KImage:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonArtworkClose()")
  self._ui._stc_leftFrameContent:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_pageRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_pageRight:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_pageRight:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._stc_artworkArea:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._stc_artworkArea:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  local leftBg = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_LeftArea")
  leftBg:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  leftBg:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  local rightBg = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_RightArea")
  rightBg:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  rightBg:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  Panel_Window_Journal_Book_All:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Journal_Book_All_ButtonLeft()")
  Panel_Window_Journal_Book_All:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Journal_Book_All_ButtonRight()")
  if self._isConsole == true then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_artworkPlay:SetShow(false)
    self._ui._btn_artworkFullScreen:SetShow(false)
    Panel_Window_Journal_Book_All:ignorePadSnapMoveToOtherPanel()
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventlUp_Journal_Book_All_ButtonLeft()")
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventlUp_Journal_Book_All_ButtonRight()")
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventlUp_Journal_Book_All_ButtonArtworkOpen()")
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventlUp_Journal_Book_All_ButtonArtworkPlay()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Book_All_Close()")
    self._ui._btn_bookMark:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonBookMark()")
    self._ui._btn_artworkPlay:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonArtworkPlay()")
    self._ui._btn_artworkFullScreen:addInputEvent("Mouse_LUp", "HandleEventlUp_Journal_Book_All_ButtonArtworkOpen()")
  end
end
function PaGlobal_Journal_Book_All:prepareOpen(journalKey, chapterKey, journalListIndex)
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  if Panel_Window_Journal_Page_All ~= nil and Panel_Window_Journal_Page_All:GetShow() == true then
    PaGlobal_Journal_Page_All_Close()
  end
  if journalKey == nil or chapterKey == nil then
    return
  end
  local initPageValue = ToClient_GetJournalBookMark(journalKey, chapterKey)
  if initPageValue == 0 then
    initPageValue = 1
  end
  self._currentJournalKey = journalKey
  self._currentChapterKey = chapterKey
  self._journalListIndex = journalListIndex
  self:makeDataList()
  self:setPage(initPageValue)
  self:setJournalType()
  self:open()
end
function PaGlobal_Journal_Book_All:open()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  Panel_Window_Journal_Book_All:SetShow(true)
end
function PaGlobal_Journal_Book_All:prepareClose()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._pageAnimationDeltaTime = 0
  self._dataList = nil
  self._currentJournalKey = nil
  self._currentChapterKey = nil
  self._currentPageIndex = nil
  self._currentPageCount = nil
  self._journalListIndex = nil
  self:close()
end
function PaGlobal_Journal_Book_All:close()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  Panel_Window_Journal_Book_All:SetShow(false)
end
function PaGlobal_Journal_Book_All:validate()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._ui._stc_mainBG:isValidate()
  self._ui._stc_title:isValidate()
  self._ui._stc_emptyPageDesc:isValidate()
  self._ui._stc_image:isValidate()
  self._ui._btn_pageLeft:isValidate()
  self._ui._btn_pageRight:isValidate()
  self._ui._btn_left:isValidate()
  self._ui._btn_right:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_bookMark:isValidate()
  self._ui._stc_addEffect:isValidate()
  self._ui._stc_artworkArea:isValidate()
  self._ui._stc_artworkImage:isValidate()
  self._ui._btn_artworkPageLeft:isValidate()
  self._ui._btn_artworkPageRight:isValidate()
  self._ui._btn_artworkLeft:isValidate()
  self._ui._btn_artworkRight:isValidate()
  self._ui._btn_artworkPlay:isValidate()
  self._ui._btn_artworkClose:isValidate()
  self._ui._btn_artworkFullScreen:isValidate()
  self._ui._stc_artworkFullScreen:isValidate()
  self._ui._stc_artwork2KImage:isValidate()
  self._ui._stc_emptyPageRight:isValidate()
end
function PaGlobal_Journal_Book_All:makeDataList()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._currentPageCount = ToClient_GetJournalQuestCount(self._currentJournalKey, self._currentChapterKey)
  if self._currentPageCount == 0 then
    self._currentPageCount = nil
    return
  end
  self._dataList = Array.new()
  for pageIndex = 1, self._currentPageCount do
    local data = {
      _questNo = nil,
      _isShow = nil,
      _isNeedClear = nil
    }
    data._questNo = ToClient_GetJournalQuestNo(self._currentJournalKey, self._currentChapterKey, pageIndex - 1)
    local isSatisfied = ToClient_isSatisfiedCondions(data._questNo._group, data._questNo._quest)
    local isCleared = questList_isClearQuest(data._questNo._group, data._questNo._quest)
    data._isShow = isSatisfied == true or isCleared == true
    data._isNeedClear = isSatisfied == true and isCleared == false
    self._dataList:push_back(data)
  end
end
function PaGlobal_Journal_Book_All:update()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  if self._currentPageIndex == nil then
    return
  end
  local currentPageData = self._dataList[self._currentPageIndex]
  if currentPageData == nil then
    UI.ASSERT_NAME(false, "self._currentPageIndex\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 \235\141\176\236\157\180\237\132\176\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isShowPage = currentPageData._isShow
  if isShowPage == nil then
    return
  end
  self._ui._stc_title:SetShow(false)
  self._ui._stc_leftFrame:SetShow(false)
  self._ui._stc_image:SetShow(false)
  self._ui._stc_image:SetScaleDefault()
  self._ui._stc_artworkArea:SetShow(false)
  self._ui._stc_artworkFullScreen:SetShow(false)
  self._ui._stc_emptyPageDesc:SetShow(false)
  self._ui._stc_emptyPageRight:SetShow(false)
  self._ui._btn_pageLeft:SetIgnore(false)
  if isShowPage == true then
    local questSSW = questList_getQuestInfo(currentPageData._questNo._raw)
    if questSSW ~= nil then
      local isVideoType = ToClient_IsExistJournalVideoData(currentPageData._questNo)
      if isVideoType == true then
        ToClient_ChangeQuestIconFromIconPath(self._ui._stc_artworkImage, questSSW:getIconPath(), questSSW:getQuestType())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_artworkImage, 0, 0, self._ui._stc_artworkImage:GetSizeX(), self._ui._stc_artworkImage:GetSizeY())
        self._ui._stc_artworkImage:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_artworkImage:setRenderTexture(self._ui._stc_artworkImage:getBaseTexture())
        self._ui._stc_artworkArea:SetShow(true)
        if self._isConsole == true then
          self:updateKeyGuide(true)
        end
      else
        local questFullDesc = questSSW:getDesc()
        local stringList = string.split(questFullDesc, [[


]])
        local questTitleText = stringList[1]
        if questTitleText ~= nil then
          self._ui._stc_title:SetText(questTitleText)
        end
        local questDescText = ""
        for stringIndex = 2, #stringList do
          questDescText = questDescText .. stringList[stringIndex] .. [[


]]
        end
        self._ui._stc_leftFrameDesc:SetText(questDescText)
        self._ui._stc_leftFrameDesc:SetSize(self._ui._stc_leftFrameDesc:GetSizeX(), self._ui._stc_leftFrameDesc:GetTextSizeY())
        self._ui._stc_leftFrameContent:SetSize(self._ui._stc_leftFrameDesc:GetSizeX(), self._ui._stc_leftFrameDesc:GetSizeY())
        local frameVScroll = self._ui._stc_leftFrame:GetVScroll()
        local doResetFrameScroll = true
        if doResetFrameScroll ~= nil and doResetFrameScroll == true then
          frameVScroll:SetControlPos(0)
          self._ui._stc_leftFrame:UpdateContentPos()
        end
        if self._ui._stc_leftFrame:GetSizeY() < self._ui._stc_leftFrameContent:GetSizeY() then
          self._ui._btn_pageLeft:SetIgnore(true)
          frameVScroll:SetShow(true)
        else
          frameVScroll:SetShow(false)
        end
        self._ui._stc_title:SetShow(true)
        self._ui._stc_leftFrame:SetShow(true)
        ToClient_ChangeQuestIconFromIconPath(self._ui._stc_image, questSSW:getIconPath(), questSSW:getQuestType())
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_image, 0, 0, self._ui._stc_image:GetSizeX(), self._ui._stc_image:GetSizeY())
        self._ui._stc_image:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_image:setRenderTexture(self._ui._stc_image:getBaseTexture())
        self._ui._stc_image:SetScale(0.93, 0.93)
        self._ui._stc_image:SetShow(true)
        if self._isConsole == true then
          self:updateKeyGuide(false)
        end
      end
      if currentPageData._isNeedClear == true then
        ToClient_RequestCompleteQuest(currentPageData._questNo._group, currentPageData._questNo._quest)
        currentPageData._isNeedClear = false
      end
    end
  else
    local titleString = "??? ????"
    local questSSW = questList_getQuestInfo(currentPageData._questNo._raw)
    if questSSW ~= nil then
      local splitted = string.split(questSSW:getDesc(), [[


]])
      if #splitted > 1 then
        local tempString = stringReplaceToQuestionMark(splitted[1], 25)
        if tempString ~= nil then
          titleString = tempString
        end
      end
    end
    self._ui._stc_title:SetText(titleString)
    self._ui._stc_title:SetShow(true)
    self._ui._stc_emptyPageDesc:SetShow(true)
    self._ui._stc_emptyPageRight:SetShow(true)
    if self._isConsole == true then
      self:updateKeyGuide(false)
    end
  end
  if self._ui._stc_title:GetShow() == true then
    local isAutoWrap = self._ui._stc_title:IsAutoWrapText()
    if isAutoWrap == true then
      self._ui._stc_title:SetSpanSize(self._ui._stc_title:GetSpanSize().x, self._autowrapTitleTextSpanY)
    else
      self._ui._stc_title:SetSpanSize(self._ui._stc_title:GetSpanSize().x, self._originalTitleTextSpanY)
    end
  end
  self:updateBookMarkButton()
end
function PaGlobal_Journal_Book_All:setPage(newPageIndex)
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  if self._currentPageCount == nil then
    return
  end
  if newPageIndex < 1 then
    return
  end
  if newPageIndex > self._currentPageCount then
    newPageIndex = 1
  end
  local animationType = 0
  if self._currentPageIndex ~= nil then
    if newPageIndex < self._currentPageIndex then
      animationType = 1
    elseif newPageIndex > self._currentPageIndex then
      animationType = 2
    end
  end
  local newPageData = self._dataList[newPageIndex]
  if newPageData == nil then
    UI.ASSERT_NAME(false, "newPageIndex \236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 \235\141\176\236\157\180\237\132\176\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._currentPageIndex = newPageIndex
  local isVideoTypePage = ToClient_IsExistJournalVideoData(newPageData._questNo)
  if self._currentPageIndex == 1 then
    self._ui._btn_left:SetShow(false)
    self._ui._btn_right:SetShow(true)
    if isVideoTypePage == true then
      self._ui._btn_artworkLeft:SetShow(false)
      self._ui._btn_artworkRight:SetShow(true)
    end
  elseif self._currentPageIndex == self._currentPageCount then
    self._ui._btn_left:SetShow(true)
    self._ui._btn_right:SetShow(false)
    if isVideoTypePage == true then
      self._ui._btn_artworkLeft:SetShow(true)
      self._ui._btn_artworkRight:SetShow(false)
    end
  else
    self._ui._btn_left:SetShow(true)
    self._ui._btn_right:SetShow(true)
    if isVideoTypePage == true then
      self._ui._btn_artworkLeft:SetShow(true)
      self._ui._btn_artworkRight:SetShow(true)
    end
  end
  if animationType ~= 0 then
    if animationType == 1 then
      self:playChangeBackPageAnimation()
    elseif animationType == 2 then
      self:playChangeNextPageAnimation()
    end
    audioPostEvent_SystemUi(1, 47)
    _AudioPostEvent_SystemUiForXBOX(1, 47)
  else
    self:update()
  end
end
function PaGlobal_Journal_Book_All:playChangeBackPageAnimation()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  local bookEffect = ToClient_getJournalTextureInfo(self._journalListIndex, 19)
  self._ui._stc_addEffect:AddEffect(bookEffect, false, 0, 0)
  Panel_Window_Journal_Book_All:RegisterUpdateFunc("PaGlobal_Journal_Book_All_ChangeBackPageAnimation")
end
function PaGlobal_Journal_Book_All:playChangeNextPageAnimation()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  local bookEffect = ToClient_getJournalTextureInfo(self._journalListIndex, 20)
  self._ui._stc_addEffect:AddEffect(bookEffect, false, 0, 0)
  Panel_Window_Journal_Book_All:RegisterUpdateFunc("PaGlobal_Journal_Book_All_ChangeNextPageAnimation")
end
function PaGlobal_Journal_Book_All:updateBackPageAnimation(deltaTime)
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._pageAnimationDeltaTime = self._pageAnimationDeltaTime + self._pageAnimationSpeed * deltaTime
  local _moveSizeX = self._pageAnimationNextPageXSize - self._pageAnimationDeltaTime
  self._ui._stc_mainBG:SetRectClipOnArea(float2(0, 0), float2(_moveSizeX, self._ui._stc_mainBG:GetSizeY()))
  if _moveSizeX <= 0 then
    self._pageAnimationNextPageXSize = self._ui._stc_mainBG:GetSizeX()
    self._pageAnimationDeltaTime = 0
    self:update()
    Panel_Window_Journal_Book_All:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Journal_Book_All:updateNextPageAnimation(deltaTime)
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._pageAnimationDeltaTime = self._pageAnimationDeltaTime + self._pageAnimationSpeed * deltaTime
  self._ui._stc_mainBG:SetRectClipOnArea(float2(self._pageAnimationDeltaTime, 0), float2(913, 621))
  if self._ui._stc_mainBG:GetSizeX() <= self._pageAnimationDeltaTime then
    self._pageAnimationDeltaTime = 0
    self:update()
    Panel_Window_Journal_Book_All:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Journal_Book_All:updateBookMarkButton()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  local currentBookmarkPage = ToClient_GetJournalBookMark(self._currentJournalKey, self._currentChapterKey)
  self._ui._btn_bookMark:SetMonoTone(self._currentPageIndex ~= currentBookmarkPage)
end
function PaGlobal_Journal_Book_All:openArtworkImageControl()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  local currentPageData = self._dataList[self._currentPageIndex]
  if currentPageData == nil then
    return
  end
  local imagePath = ToClient_getJournalArtworkImagePath(currentPageData._questNo)
  if imagePath == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  self._ui._stc_artwork2KImage:SetSize(screenX, screenY)
  self._ui._stc_artworkFullScreen:SetSize(screenX, screenY)
  self._ui._stc_artworkFullScreen:ComputePosAllChild()
  self._ui._stc_artwork2KImage:ChangeTextureInfoNameAsync(imagePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_artwork2KImage, 0, 0, 2560, 1440)
  self._ui._stc_artwork2KImage:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_artwork2KImage:setRenderTexture(self._ui._stc_artwork2KImage:getBaseTexture())
  self._ui._stc_artworkFullScreen:SetShow(true)
end
function PaGlobal_Journal_Book_All:closeArtworkImageControl()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  self._ui._stc_artworkFullScreen:SetShow(false)
end
function PaGlobal_Journal_Book_All:updateKeyGuide(isArtworkPage)
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local keyGuideArea = UI.getChildControl(Panel_Window_Journal_Book_All, "Static_Console_Buttons")
  local keyGuide_A = UI.getChildControl(keyGuideArea, "Button_A_ConsoleUI")
  local keyGuide_Y = UI.getChildControl(keyGuideArea, "Button_Y_ConsoleUI")
  local keyGuide_RS = UI.getChildControl(keyGuideArea, "Button_RS_ConsoleUI")
  local keyGuide_X = UI.getChildControl(keyGuideArea, "Button_X_ConsoleUI")
  local keyGuide_B = UI.getChildControl(keyGuideArea, "Button_B_ConsoleUI")
  if isArtworkPage == true then
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  else
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventlUp_Journal_Book_All_ButtonBookMark()")
  end
  local isScrollShow = false
  local vScroll = self._ui._stc_leftFrame:GetVScroll()
  if vScroll ~= nil and vScroll:GetShow() == true then
    isScrollShow = true
  end
  if isArtworkPage == true or isScrollShow == false then
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "")
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "")
  else
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventRSUp_Journal_Book_All()")
    Panel_Window_Journal_Book_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventRSDown_Journal_Book_All()")
  end
  keyGuide_X:SetShow(not isArtworkPage)
  keyGuide_RS:SetShow(not isArtworkPage and isScrollShow)
  keyGuide_Y:SetShow(isArtworkPage)
  keyGuide_A:SetShow(isArtworkPage)
  keyGuide_B:SetShow(true)
  local keyGuideList = Array.new()
  keyGuideList:push_back(keyGuide_RS)
  keyGuideList:push_back(keyGuide_X)
  keyGuideList:push_back(keyGuide_Y)
  keyGuideList:push_back(keyGuide_A)
  keyGuideList:push_back(keyGuide_B)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
end
function PaGlobal_Journal_Book_All:setJournalType()
  if Panel_Window_Journal_Book_All == nil then
    return
  end
  if self._journalListIndex == nil then
    return
  end
  local bookBaseTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 11)
  local bookBtnLBaseTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 12)
  local bookBtnLOnTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 13)
  local bookBtnLClickTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 14)
  local bookBtnRBaseTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 15)
  local bookBtnROnTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 16)
  local bookBtnRClickTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 17)
  local bookHiddenBaseTextureId = ToClient_getJournalTextureInfo(self._journalListIndex, 18)
  Panel_Window_Journal_Book_All:ChangeTextureInfoTextureIDAsync(bookBaseTextureId)
  self._ui._btn_left:ChangeTextureInfoTextureIDAsync(bookBtnLBaseTextureId, 0)
  self._ui._btn_left:ChangeTextureInfoTextureIDAsync(bookBtnLOnTextureId, 1)
  self._ui._btn_left:ChangeTextureInfoTextureIDAsync(bookBtnLClickTextureId, 2)
  self._ui._btn_right:ChangeTextureInfoTextureIDAsync(bookBtnRBaseTextureId, 0)
  self._ui._btn_right:ChangeTextureInfoTextureIDAsync(bookBtnROnTextureId, 1)
  self._ui._btn_right:ChangeTextureInfoTextureIDAsync(bookBtnRClickTextureId, 2)
  self._ui._stc_emptyPageRight:ChangeTextureInfoTextureIDAsync(bookHiddenBaseTextureId, 0)
  Panel_Window_Journal_All:setRenderTexture(Panel_Window_Journal_All:getBaseTexture())
  self._ui._btn_left:setRenderTexture(self._ui._btn_left:getBaseTexture())
  self._ui._btn_right:setRenderTexture(self._ui._btn_right:getBaseTexture())
  self._ui._stc_emptyPageRight:setRenderTexture(self._ui._stc_emptyPageRight:getBaseTexture())
end
function PaGlobal_Journal_Book_All_Open(journalKey, chapterKey, journalListIndex)
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  self:prepareOpen(journalKey, chapterKey, journalListIndex)
end
function PaGlobal_Journal_Book_All_Close()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  if self._ui._stc_artworkFullScreen:GetShow() == true then
    self:closeArtworkImageControl()
  else
    self:prepareClose()
  end
end
function PaGlobal_Journal_Book_All_ChangeBackPageAnimation(deltaTime)
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  self:updateBackPageAnimation(deltaTime)
end
function PaGlobal_Journal_Book_All_ChangeNextPageAnimation(deltaTime)
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  self:updateNextPageAnimation(deltaTime)
end
function HandleEventlUp_Journal_Book_All_ButtonLeft()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  if self._currentPageIndex == 1 then
    return
  end
  self:setPage(self._currentPageIndex - 1)
end
function HandleEventlUp_Journal_Book_All_ButtonRight()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  if self._currentPageIndex == self._currentPageCount then
    return
  end
  self:setPage(self._currentPageIndex + 1)
end
function HandleEventlUp_Journal_Book_All_ButtonBookMark()
  local self = PaGlobal_Journal_Book_All
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
function HandleEventlUp_Journal_Book_All_ButtonArtworkPlay()
  local self = PaGlobal_Journal_Book_All
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
function HandleEventlUp_Journal_Book_All_ButtonArtworkOpen()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  local currentPageData = self._dataList[self._currentPageIndex]
  if currentPageData == nil then
    return
  end
  self:openArtworkImageControl()
end
function HandleEventlUp_Journal_Book_All_ButtonArtworkClose()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  self:closeArtworkImageControl()
end
function HandleEventRSUp_Journal_Book_All()
  local self = PaGlobal_Journal_Book_All
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
function HandleEventRSDown_Journal_Book_All()
  local self = PaGlobal_Journal_Book_All
  if self == nil then
    return
  end
  if self._ui._stc_leftFrame == nil then
    return
  end
  self._ui._stc_leftFrame:MouseDownScroll(self._ui._stc_leftFrame)
end
