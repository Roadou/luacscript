function PaGlobal_Achievement_MorningLand:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local leftBg = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_LeftArea")
  local rightBg = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_RightArea")
  local bottomBg = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_BottomArea")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_Template_ListBG")
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
  self._ui._btn_close = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Button_Win_Close")
  self._ui._btn_bookMark = UI.getChildControl(Panel_Window_Achievement_MorningLand, "CheckButton_BookMark")
  self._ui._stc_addEffect = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_AddEffect")
  self._ui._stc_artworkArea = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_ArtworkArea")
  self._ui._stc_artworkImage = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork")
  self._ui._btn_artworkPageLeft = UI.getChildControl(self._ui._stc_artworkArea, "Button_Artwork_PagePrevious")
  self._ui._btn_artworkPageRight = UI.getChildControl(self._ui._stc_artworkArea, "Button_Artwork_PagePreview")
  local artworkBottomArea = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_BottomArea")
  self._ui._btn_artworkLeft = UI.getChildControl(artworkBottomArea, "Button_Artwork_Previous")
  self._ui._btn_artworkRight = UI.getChildControl(artworkBottomArea, "Button_Artwork_Preview")
  self._ui._btn_artworkPlay = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_Play")
  self._ui._btn_artworkClose = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_Close")
  self._ui._btn_artworkFullScreen = UI.getChildControl(self._ui._stc_artworkArea, "Static_Artwork_DtailView")
  self._ui._stc_artworkFullScreen = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_OriginArtworkArea")
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
function PaGlobal_Achievement_MorningLand:registEventHandler()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._ui._btn_left:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_right:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_artworkLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_artworkRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_artworkClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_MorningLand_Close()")
  self._ui._stc_artwork2KImage:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonArtworkClose()")
  self._ui._stc_leftFrameContent:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_pageLeft:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_pageRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_pageRight:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_pageRight:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._stc_artworkArea:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._stc_artworkArea:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_artworkPageLeft:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  self._ui._btn_artworkPageRight:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  local leftBg = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_LeftArea")
  leftBg:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  leftBg:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  local rightBg = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_RightArea")
  rightBg:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  rightBg:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  Panel_Window_Achievement_MorningLand:addInputEvent("Mouse_UpScroll", "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
  Panel_Window_Achievement_MorningLand:addInputEvent("Mouse_DownScroll", "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
  if self._isConsole == true then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_artworkPlay:SetShow(false)
    self._ui._btn_artworkFullScreen:SetShow(false)
    Panel_Window_Achievement_MorningLand:ignorePadSnapMoveToOtherPanel()
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventlUp_Achievement_MorningLand_ButtonLeft()")
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventlUp_Achievement_MorningLand_ButtonRight()")
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventlUp_Achievement_MorningLand_ButtonArtworkOpen()")
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventlUp_Achievement_MorningLand_ButtonArtworkPlay()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_MorningLand_Close()")
    self._ui._btn_bookMark:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonBookMark()")
    self._ui._btn_artworkPlay:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonArtworkPlay()")
    self._ui._btn_artworkFullScreen:addInputEvent("Mouse_LUp", "HandleEventlUp_Achievement_MorningLand_ButtonArtworkOpen()")
  end
end
function PaGlobal_Achievement_MorningLand:prepareOpen(journalKey, chapterKey, pageIndex)
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  if journalKey == nil or chapterKey == nil then
    return
  end
  local initPageValue = 1
  if pageIndex ~= nil and pageIndex > 0 then
    initPageValue = pageIndex
  else
    initPageValue = ToClient_GetJournalBookMark(journalKey, chapterKey)
    if initPageValue == 0 then
      initPageValue = 1
    end
  end
  self._currentJournalKey = journalKey
  self._currentChapterKey = chapterKey
  self:makeDataList()
  self:setPage(initPageValue)
  self:open()
end
function PaGlobal_Achievement_MorningLand:open()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  Panel_Window_Achievement_MorningLand:SetShow(true)
end
function PaGlobal_Achievement_MorningLand:prepareClose()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._pageAnimationDeltaTime = 0
  self._dataList = nil
  self._currentJournalKey = nil
  self._currentChapterKey = nil
  self._currentPageIndex = nil
  self._currentPageCount = nil
  self:close()
end
function PaGlobal_Achievement_MorningLand:close()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  Panel_Window_Achievement_MorningLand:SetShow(false)
end
function PaGlobal_Achievement_MorningLand:validate()
  if Panel_Window_Achievement_MorningLand == nil then
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
function PaGlobal_Achievement_MorningLand:makeDataList()
  if Panel_Window_Achievement_MorningLand == nil then
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
function PaGlobal_Achievement_MorningLand:update()
  if Panel_Window_Achievement_MorningLand == nil then
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
function PaGlobal_Achievement_MorningLand:setPage(newPageIndex)
  if Panel_Window_Achievement_MorningLand == nil then
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
function PaGlobal_Achievement_MorningLand:playChangeBackPageAnimation()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._ui._stc_addEffect:AddEffect("UI_Book_01B", false, 0, 0)
  Panel_Window_Achievement_MorningLand:RegisterUpdateFunc("PaGlobalFunc_Achievement_MorningLand_ChangeBackPageAnimation")
end
function PaGlobal_Achievement_MorningLand:playChangeNextPageAnimation()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._ui._stc_addEffect:AddEffect("UI_Book_01A", false, 0, 0)
  Panel_Window_Achievement_MorningLand:RegisterUpdateFunc("PaGlobalFunc_Achievement_MorningLand_ChangeNextPageAnimation")
end
function PaGlobal_Achievement_MorningLand:updateBackPageAnimation(deltaTime)
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._pageAnimationDeltaTime = self._pageAnimationDeltaTime + self._pageAnimationSpeed * deltaTime
  local _moveSizeX = self._pageAnimationNextPageXSize - self._pageAnimationDeltaTime
  self._ui._stc_mainBG:SetRectClipOnArea(float2(0, 0), float2(_moveSizeX, self._ui._stc_mainBG:GetSizeY()))
  if _moveSizeX <= 0 then
    self._pageAnimationNextPageXSize = self._ui._stc_mainBG:GetSizeX()
    self._pageAnimationDeltaTime = 0
    self:update()
    Panel_Window_Achievement_MorningLand:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Achievement_MorningLand:updateNextPageAnimation(deltaTime)
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._pageAnimationDeltaTime = self._pageAnimationDeltaTime + self._pageAnimationSpeed * deltaTime
  self._ui._stc_mainBG:SetRectClipOnArea(float2(self._pageAnimationDeltaTime, 0), float2(913, 621))
  if self._ui._stc_mainBG:GetSizeX() <= self._pageAnimationDeltaTime then
    self._pageAnimationDeltaTime = 0
    self:update()
    Panel_Window_Achievement_MorningLand:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Achievement_MorningLand:updateBookMarkButton()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  local currentBookmarkPage = ToClient_GetJournalBookMark(self._currentJournalKey, self._currentChapterKey)
  self._ui._btn_bookMark:SetMonoTone(self._currentPageIndex ~= currentBookmarkPage)
end
function PaGlobal_Achievement_MorningLand:openArtworkImageControl()
  if Panel_Window_Achievement_MorningLand == nil then
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
function PaGlobal_Achievement_MorningLand:closeArtworkImageControl()
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  self._ui._stc_artworkFullScreen:SetShow(false)
end
function PaGlobal_Achievement_MorningLand:updateKeyGuide(isArtworkPage)
  if Panel_Window_Achievement_MorningLand == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local keyGuideArea = UI.getChildControl(Panel_Window_Achievement_MorningLand, "Static_Console_Buttons")
  local keyGuide_A = UI.getChildControl(keyGuideArea, "Button_A_ConsoleUI")
  local keyGuide_Y = UI.getChildControl(keyGuideArea, "Button_Y_ConsoleUI")
  local keyGuide_RS = UI.getChildControl(keyGuideArea, "Button_RS_ConsoleUI")
  local keyGuide_X = UI.getChildControl(keyGuideArea, "Button_X_ConsoleUI")
  local keyGuide_B = UI.getChildControl(keyGuideArea, "Button_B_ConsoleUI")
  if isArtworkPage == true then
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  else
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventlUp_Achievement_MorningLand_ButtonBookMark()")
  end
  local isScrollShow = false
  local vScroll = self._ui._stc_leftFrame:GetVScroll()
  if vScroll ~= nil and vScroll:GetShow() == true then
    isScrollShow = true
  end
  if isArtworkPage == true or isScrollShow == false then
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "")
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "")
  else
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventRSUp_Achievement_MorningLand()")
    Panel_Window_Achievement_MorningLand:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventRSDown_Achievement_MorningLand()")
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
