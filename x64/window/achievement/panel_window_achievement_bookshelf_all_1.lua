function PaGlobal_Achievement_BookShelf_All:initialize()
  if true == self._initialize then
    return
  end
  self:initControl()
  self:setShowControl()
  self:setBookShelf()
  self:update()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Achievement_BookShelf_All:initControl()
  self._ui.stc_TopArea = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_TopArea")
  self._ui.btn_Shortcut = UI.getChildControl(self._ui.stc_TopArea, "Button_shortcut")
  self._ui.stc_CenterArea = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_CenterArea")
  self._ui.stc_FamilyWidget = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_FamilyStat_Widget")
  self._ui.stc_familyWidget_SubBG = UI.getChildControl(self._ui.stc_FamilyWidget, "Static_SubBG")
  self._ui.stc_LeftArea = UI.getChildControl(self._ui.stc_CenterArea, "Static_LeftArea")
  self._ui.stc_RightArea = UI.getChildControl(self._ui.stc_CenterArea, "Static_RightArea")
  self._ui.stc_BtnClose = UI.getChildControl(self._ui.stc_TopArea, "Static_Close")
  self._ui.stc_Chapter = UI.getChildControl(self._ui.stc_LeftArea, "Static_Chapter")
  for ii = 1, self._CHAPTER_ICON_ROW_CNT do
    self._ui.stc_ChapterGroup[ii] = UI.getChildControl(self._ui.stc_Chapter, "Static_Chapter" .. ii)
  end
  self._ui.stc_ChapterSlot = UI.getChildControl(self._ui.stc_ChapterGroup[1], "Static_Chapter_Template")
  self._ui.stc_ChapterTitle = UI.getChildControl(self._ui.stc_ChapterSlot, "StaticText_ChapterTitle")
  self._ui.txt_FamilyStatIcon = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_FamilyStat")
  self._ui.txt_LeftTitle = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_Left_Title")
  self._ui.txt_BookShelfDesc = UI.getChildControl(self._ui.stc_LeftArea, "StaticText_BookShelf_Desc")
  self._ui.txt_BookShelfDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.frame_BookShelf = UI.getChildControl(self._ui.stc_RightArea, "Frame_BookShelf")
  self._ui.frame_BookShelfContent = UI.getChildControl(self._ui.frame_BookShelf, "Frame_1_Content")
  self._ui.btn_BookArea = UI.getChildControl(self._ui.frame_BookShelfContent, "RadioButton_BookArea")
  self._ui.txt_BookTitleBg = UI.getChildControl(self._ui.btn_BookArea, "Static_BookTitleBg")
  self._ui.txt_BookTitle = UI.getChildControl(self._ui.txt_BookTitleBg, "StaticText_BookTitle")
  self._ui.txt_BookTitle:SetTextMode(__eTextMode_LimitText)
  self._ui.stc_BookGroup = UI.getChildControl(self._ui.btn_BookArea, "Static_BookGroup")
  self._ui.stc_EmptyGroup_1 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_1")
  self._ui.stc_EmptyGroup_1_object = UI.getChildControl(self._ui.stc_EmptyGroup_1, "Static_Watch")
  self._ui.stc_EmptyGroup_2 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_2")
  self._ui.stc_EmptyGroup_2_object = UI.getChildControl(self._ui.stc_EmptyGroup_2, "Static_Vase")
  self._ui.stc_EmptyGroup_3 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_3")
  self._ui.stc_EmptyGroup_3_object_1 = UI.getChildControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_1")
  self._ui.stc_EmptyGroup_3_object_2 = UI.getChildControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_2")
  self._ui.stc_EmptyGroup_4 = UI.getChildControl(self._ui.btn_BookArea, "Static_EmptyGroup_4")
  self._ui.stc_EmptyGroup_4_object_1 = UI.getChildControl(self._ui.stc_EmptyGroup_4, "Static_Teapot")
  self._ui.stc_EmptyGroup_4_object_2 = UI.getChildControl(self._ui.stc_EmptyGroup_4, "Static_Cup")
  self._ui.stc_BookImage = UI.getChildControl(self._ui.stc_BookGroup, "Static_BookImage")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Window_Achievement_BookShelf_All, "Static_Console_Buttons")
  self._defaultFamilyWidgetSizeY = self._ui.stc_FamilyWidget:GetSizeY()
end
function PaGlobal_Achievement_BookShelf_All:setShowControl()
  self._ui.stc_FamilyWidget:SetShow(false)
  if _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyGuide:SetShow(true)
    self._ui.stc_BtnClose:SetShow(false)
  end
end
function PaGlobal_Achievement_BookShelf_All:setKeyGuide()
  local btn_Y = UI.getChildControl(self._ui.stc_KeyGuide, "Button_Y_ConsoleUI")
  local btn_B = UI.getChildControl(self._ui.stc_KeyGuide, "Button_B_ConsoleUI")
  local btn_A = UI.getChildControl(self._ui.stc_KeyGuide, "Button_A_ConsoleUI")
  local btn_X = UI.getChildControl(self._ui.stc_KeyGuide, "Button_X_ConsoleUI")
  local keyGuide = {
    btn_X,
    btn_Y,
    btn_A,
    btn_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_Achievement_BookShelf_All:registEventHandler()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()")
  Panel_Window_Achievement_BookShelf_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_Achievement_BookShelf_All_LeftClick()")
  self._ui.txt_FamilyStatIcon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()")
  self._ui.stc_BtnClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_BookShelf_All_Close()")
  self._ui.btn_Shortcut:setButtonShortcutsWithEvent("PaGlobalFunc_Achievement_BookShelf_All_Open()", "PANEL_ADVENTRUE_BOOKSHELF_TITLE")
  registerEvent("FromClient_UpdateQuestList", "FromClient_Achievement_BookShelf_All_UpdateQuestList")
end
function PaGlobal_Achievement_BookShelf_All:prepareOpen()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return
  end
  self:update()
  self:open()
  audioPostEvent_SystemUi(1, 48)
  _AudioPostEvent_SystemUiForXBOX(1, 48)
end
function PaGlobal_Achievement_BookShelf_All:open()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetShow(true)
end
function PaGlobal_Achievement_BookShelf_All:prepareClose()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_Achievement_BookShelf_All:close()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetShow(false)
end
function PaGlobal_Achievement_BookShelf_All:update()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  local tracer1 = Profile_BeginUIFunction("PaGlobal_Achievement_BookShelf_All:update-1")
  self:setFamilyWidget()
  Profile_EndUIFunction(tracer1)
  local tracer2 = Profile_BeginUIFunction("PaGlobal_Achievement_BookShelf_All:update-2")
  self:updateJournalList()
  Profile_EndUIFunction(tracer2)
  local tracer3 = Profile_BeginUIFunction("PaGlobal_Achievement_BookShelf_All:update-3")
  self:selectJournal(self._selectedJournalGroup)
  Profile_EndUIFunction(tracer3)
end
function PaGlobal_Achievement_BookShelf_All:returnBookTextureKey(textureKeyGroup, index)
  if nil == textureKeyGroup or nil == index or nil == textureKeyGroup._cntGroup then
    return
  end
  for ii = 1, #textureKeyGroup._cntGroup do
    if index <= textureKeyGroup._cntGroup[ii] then
      return ii
    end
  end
  return
end
function PaGlobal_Achievement_BookShelf_All:setBookShelfTexture(journalKey, chapterCnt)
  if nil == journalKey or nil == chapterCnt then
    return
  end
  local journalGroupIdx = self._journalGroupIndexList[journalKey]
  if nil == journalGroupIdx then
    return
  end
  local journalContent = self._journalControlList[journalKey]
  if nil == journalContent then
    return
  end
  self._journalControlList[journalKey].chapterList = {}
  local nextPosX = 0
  local maxPosX = journalContent.stc_BookGroup:GetSizeX()
  for ii = 1, chapterCnt do
    local textureID = self:getJournalBookRoundCoverTextureID(journalGroupIdx, ii)
    if textureID == nil then
      textureID = "Adventure_Bookshelf_Static_book_01"
    end
    local stc_BookImg = UI.createAndCopyBasePropertyControl(self._ui.stc_BookGroup, "Static_BookImage", journalContent.stc_BookGroup, "Static_BookImage_" .. ii)
    if stc_BookImg ~= nil then
      stc_BookImg:SetIgnore(true)
      stc_BookImg:ChangeTextureInfoAndSizeByTextureIDKey(textureID)
      stc_BookImg:setRenderTexture(stc_BookImg:getBaseTexture())
      stc_BookImg:SetPosX(nextPosX)
      stc_BookImg:SetPosY(stc_BookImg:GetPosY() + 5)
      stc_BookImg:SetShow(false)
      nextPosX = nextPosX + stc_BookImg:GetSizeX() + 1
      if maxPosX < nextPosX then
        break
      end
      self._journalControlList[journalKey].chapterList[#self._journalControlList[journalKey].chapterList + 1] = stc_BookImg
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:returnProcessingChapterCnt(journalKey)
  local processingChapterCnt = 0
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return nil
  end
  if nil == journalKey then
    return nil
  end
  local nowChapterCnt = ToClient_GetChapterCount(journalKey)
  if nil == nowChapterCnt or 0 == nowChapterCnt then
    return nil
  end
  for ii = 1, nowChapterCnt do
    local chapterKey = ToClient_GetCapterKey(journalKey, ii - 1)
    local journalQuestCnt = ToClient_GetJournalQuestCount(journalKey, chapterKey)
    local questNo = ToClient_GetJournalQuestNo(journalKey, chapterKey, 0)
    if nil ~= questNo and (true == questList_isClearQuest(questNo._group, questNo._quest) or true == questList_hasProgressQuest(questNo._group, questNo._quest)) then
      processingChapterCnt = processingChapterCnt + 1
    end
  end
  return processingChapterCnt
end
function PaGlobal_Achievement_BookShelf_All:setBookShelf()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  self._journalGroupCnt = 0
  local nowjournalGroupCnt = ToClient_GetJournalGroupCount()
  if nil == nowjournalGroupCnt or nowjournalGroupCnt < 1 then
    return
  end
  if nil ~= nowjournalGroupCnt and nowjournalGroupCnt > 0 then
    self._journalGroupCnt = nowjournalGroupCnt
  end
  local nowJournalMaxKey = math.ceil(self._journalGroupCnt / self._BOOK_AREA_CNT)
  local bookShelfTextureInfo = self._bookShelfTextureGroup[nowJournalMaxKey]
  if nil == bookShelfTextureInfo then
    bookShelfTextureInfo = self._bookShelfTextureGroup[#self._bookShelfTextureGroup]
  end
  if nil == bookShelfTextureInfo then
    return
  end
  Panel_Window_Achievement_BookShelf_All:SetSize(bookShelfTextureInfo.panelSize, Panel_Window_Achievement_BookShelf_All:GetSizeY())
  self._ui.stc_TopArea:SetSize(bookShelfTextureInfo.panelSize, self._ui.stc_TopArea:GetSizeY())
  self._ui.stc_CenterArea:SetSize(bookShelfTextureInfo.panelSize - 10, self._ui.stc_RightArea:GetSizeY())
  self._ui.stc_RightArea:SetSize(bookShelfTextureInfo.frameSize, self._ui.stc_RightArea:GetSizeY())
  self._ui.frame_BookShelf:SetSize(bookShelfTextureInfo.frameSize, self._ui.frame_BookShelf:GetSizeY())
  self._ui.frame_BookShelfContent:SetSize(bookShelfTextureInfo.frameSize, self._ui.frame_BookShelfContent:GetSizeY())
  self._ui.stc_KeyGuide:SetSize(bookShelfTextureInfo.panelSize, self._ui.stc_KeyGuide:GetSizeY())
  Panel_Window_Achievement_BookShelf_All:ComputePos()
  self._ui.stc_BtnClose:ComputePos()
  self._ui.stc_CenterArea:ComputePos()
  self._ui.stc_RightArea:ComputePos()
  self._ui.frame_BookShelf:ComputePos()
  self._ui.frame_BookShelfContent:ComputePos()
  local stc_BackImage = UI.getChildControl(self._ui.stc_TopArea, "Static_BackImage")
  stc_BackImage:ComputePos()
  self._ui.stc_KeyGuide:ComputePos()
  self._ui.frame_BookShelf:ChangeTextureInfoNameAsync(bookShelfTextureInfo.texture)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.frame_BookShelf, bookShelfTextureInfo.x1, bookShelfTextureInfo.y1, bookShelfTextureInfo.x2, bookShelfTextureInfo.y2)
  self._ui.frame_BookShelf:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.frame_BookShelf:setRenderTexture(self._ui.frame_BookShelf:getBaseTexture())
  self:setKeyGuide()
  local lastCalledIndex = 0
  local calledCnt = 0
  self._journalControlList = {}
  for index = 1, nowJournalMaxKey * self._BOOK_AREA_CNT do
    local stc_BookArea = UI.createAndCopyBasePropertyControl(self._ui.frame_BookShelfContent, "RadioButton_BookArea", self._ui.frame_BookShelfContent, "RadioButton_BookArea_" .. index)
    self._targetControlCount = self._targetControlCount + 1
    self._targetControlList[self._targetControlCount] = stc_BookArea
    local stc_BookTitleBg = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_BookTitleBg", stc_BookArea, "Static_BookTitleBg")
    local txt_BookTitle = UI.createAndCopyBasePropertyControl(self._ui.txt_BookTitleBg, "StaticText_BookTitle", stc_BookTitleBg, "StaticText_BookTitle")
    local stc_BookGroup = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_BookGroup", stc_BookArea, "Static_BookGroup")
    local txt_BookCondition = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "StaticText_BookCondition", stc_BookArea, "StaticText_BookCondition")
    local stc_EmptyControl_1 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_1", stc_BookArea, "Static_EmptyGroup_1")
    local stc_EmptyControl_1_object = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_1, "Static_Watch", stc_EmptyControl_1, "Static_Watch")
    local stc_EmptyControl_2 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_2", stc_BookArea, "Static_EmptyGroup_2")
    local stc_EmptyControl_2_object = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_2, "Static_Vase", stc_EmptyControl_2, "Static_Vase")
    local stc_EmptyControl_3 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_3", stc_BookArea, "Static_EmptyGroup_3")
    local stc_EmptyControl_3_object_1 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_1", stc_EmptyControl_3, "Static_CandleStick_1")
    local stc_EmptyControl_3_object_2 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_3, "Static_CandleStick_2", stc_EmptyControl_3, "Static_CandleStick_2")
    local stc_EmptyControl_4 = UI.createAndCopyBasePropertyControl(self._ui.btn_BookArea, "Static_EmptyGroup_4", stc_BookArea, "Static_EmptyGroup_4")
    local stc_EmptyControl_4_object_1 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_4, "Static_Teapot", stc_EmptyControl_4, "Static_Teapot")
    local stc_EmptyControl_4_object_2 = UI.createAndCopyBasePropertyControl(self._ui.stc_EmptyGroup_4, "Static_Cup", stc_EmptyControl_4, "Static_Cup")
    local callIndex = lastCalledIndex + 1
    while true do
      if index <= self._journalGroupCnt then
      elseif ToClient_IsExistJournalGroupData(callIndex) ~= false or callIndex > self._MAX_CALLING_COUNT then
        break
      end
      callIndex = callIndex + 1
    end
    local journalCondition = ToClient_GetJournalConditionDesc(callIndex)
    txt_BookCondition:SetTextMode(__eTextMode_AutoWrap)
    if nil == journalCondition then
      journalCondition = ""
    end
    txt_BookCondition:SetText(journalCondition)
    stc_BookTitleBg:SetShow(false)
    stc_BookTitleBg:SetIgnore(true)
    txt_BookCondition:SetShow(false)
    txt_BookCondition:SetIgnore(true)
    stc_BookGroup:SetShow(false)
    stc_BookGroup:SetIgnore(true)
    stc_EmptyControl_1:SetShow(false)
    stc_EmptyControl_2:SetShow(false)
    stc_EmptyControl_3:SetShow(false)
    stc_EmptyControl_4:SetShow(false)
    local tempPosX = 29 + self._BOOK_POS_X * math.floor((index - 1) / self._BOOK_AREA_CNT)
    local bookAreaPosX = tempPosX + stc_BookArea:GetSizeX() * math.floor((index - 1) / self._BOOK_AREA_CNT)
    local bookAreaPosY = self._BOOK_POS_Y[(index - 1) % self._BOOK_AREA_CNT] - 10
    if nil == bookAreaPosY then
      bookAreaPosY = 0
    end
    local journalContent = {}
    journalContent.stc_BookArea = stc_BookArea
    journalContent.txt_bookArea_title = txt_BookTitle
    journalContent.stc_BookGroup = stc_BookGroup
    journalContent.txt_BookCondition = txt_BookCondition
    self._journalControlList[index] = {}
    self._journalControlList[index] = journalContent
    stc_BookArea:SetPosX(bookAreaPosX)
    stc_BookArea:SetPosY(bookAreaPosY)
    local needHide = false
    for hideIndex, value in pairs(self._hideIndex) do
      if value == callIndex then
        needHide = true
        break
      end
    end
    if index <= self._journalGroupCnt then
      local titleText = ToClient_GetJournalName(callIndex)
      self._journalGroupIndexList[index] = callIndex
      lastCalledIndex = callIndex
      if titleText ~= nil and needHide == false then
        stc_BookGroup:SetShow(true)
        stc_BookTitleBg:SetShow(true)
        txt_BookTitle:SetText(titleText)
        local chapterCnt = ToClient_GetChapterCount(callIndex)
        self:setBookShelfTexture(index, chapterCnt)
        stc_BookArea:SetIgnore(false)
        stc_BookArea:addInputEvent("Mouse_LUp", "HandleEventLUp_Achievement_BookShelf_All_SelectJournal(" .. callIndex .. ")")
      else
        stc_BookArea:SetIgnore(true)
        stc_BookArea:addInputEvent("Mouse_LUp", "")
      end
    else
      stc_BookArea:SetIgnore(true)
      stc_BookArea:addInputEvent("Mouse_LUp", "")
      local emptyIndex = index % self._BOOK_AREA_CNT
      local emptyControl
      if 1 == emptyIndex then
        emptyControl = stc_EmptyControl_1
      elseif 2 == emptyIndex then
        emptyControl = stc_EmptyControl_2
      elseif 3 == emptyIndex then
        emptyControl = stc_EmptyControl_3
      elseif 0 == emptyIndex then
        emptyControl = stc_EmptyControl_1
      else
        emptyControl = stc_EmptyControl_4
      end
      if nil ~= emptyControl then
        emptyControl:SetShow(true)
      end
    end
  end
  self._chapterControlList = {}
  for index = 1, self._MAX_CALLING_COUNT do
    local chapterListCnt = math.ceil(index / self._CHAPTER_ICON_CNT) - 1
    local groupStatic = self._ui.stc_ChapterGroup[chapterListCnt + 1]
    local stc_ChapterSlot = UI.createAndCopyBasePropertyControl(self._ui.stc_ChapterGroup[1], "Static_Chapter_Template", self._ui.stc_ChapterGroup[chapterListCnt + 1], "Static_Chapter_Template" .. index)
    self._targetControlCount = self._targetControlCount + 1
    self._targetControlList[self._targetControlCount] = stc_ChapterSlot
    local stc_ChapterTitle = UI.createAndCopyBasePropertyControl(self._ui.stc_ChapterSlot, "StaticText_ChapterTitle", stc_ChapterSlot, "StaticText_ChapterTitle")
    stc_ChapterSlot:SetSize(self._ui.stc_ChapterSlot:GetSizeX(), self._ui.stc_ChapterSlot:GetSizeY())
    local chapterSizeX = stc_ChapterSlot:GetSizeX()
    local chapterSizeY = stc_ChapterSlot:GetSizeY()
    stc_ChapterSlot:SetPosX(stc_ChapterSlot:GetPosX() + chapterSizeX * ((index - 1) % self._CHAPTER_ICON_CNT))
    stc_ChapterSlot:ComputePos()
    stc_ChapterSlot:SetEnableArea(0, 0, 65, 101)
    self._chapterControlList[index] = {}
    self._chapterControlList[index].slot = stc_ChapterSlot
    self._chapterControlList[index].title = stc_ChapterTitle
    self._chapterControlList[index].slot:SetShow(false)
  end
end
function PaGlobal_Achievement_BookShelf_All:moveLeftTarget()
  local currentControl = ToClient_getSnappedControl()
  if currentControl == nil then
    return
  end
  local targetTemp, resultTarget
  for ii = 1, self._targetControlCount do
    targetTemp = self._targetControlList[ii]
    if targetTemp:GetShow() == true and targetTemp:IsIgnore() == false and targetTemp ~= currentControl and currentControl:GetParentPosX() > targetTemp:GetParentPosX() then
      if resultTarget == nil then
        resultTarget = targetTemp
      else
        local prevDiffX = math.abs(currentControl:GetParentPosX() - resultTarget:GetParentPosX())
        local prevDiffY = math.abs(currentControl:GetParentPosY() - resultTarget:GetParentPosY())
        local curDiffX = math.abs(currentControl:GetParentPosX() - targetTemp:GetParentPosX())
        local curDiffY = math.abs(currentControl:GetParentPosY() - targetTemp:GetParentPosY())
        if prevDiffY >= curDiffY and prevDiffX >= curDiffX then
          resultTarget = targetTemp
        end
      end
    end
  end
  if resultTarget ~= nil then
    ToClient_padSnapChangeToTarget(resultTarget)
  end
end
function PaGlobal_Achievement_BookShelf_All:setChapterSlot()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  self._ui.stc_Chapter:SetIgnore(true)
  local firstContents
  for index = 1, self._journalChapterCnt do
    local chapterSlot = self._chapterControlList[index].slot
    local chapterTitle = self._chapterControlList[index].title
    chapterSlot:removeInputEvent("Mouse_On")
    chapterSlot:removeInputEvent("Mouse_Out")
    local chapterKey = ToClient_GetCapterKey(self._selectedJournalGroup, index - 1)
    if 0 == chapterKey then
      return
    end
    local groupIndx = math.ceil(index / self._CHAPTER_ICON_CNT)
    if self._journalChapterCnt > 0 then
      local journalQuestCnt = ToClient_GetJournalQuestCount(self._selectedJournalGroup, chapterKey)
      if nil == journalQuestCnt then
        return
      end
      local showFlag = false
      for ii = 1, journalQuestCnt do
        local questNo = ToClient_GetJournalQuestNo(self._selectedJournalGroup, chapterKey, ii - 1)
        if nil ~= questNo and (true == questList_isClearQuest(questNo._group, questNo._quest) or true == questList_hasProgressQuest(questNo._group, questNo._quest)) then
          showFlag = true
        end
      end
      PaGlobal_Achievement_BookShelf_All:SetBookTexture(chapterSlot, self._selectedJournalGroup, chapterKey)
      local titleText = chapterKey
      if false == showFlag then
        titleText = "?"
        chapterSlot:addInputEvent("Mouse_LUp", "")
        chapterSlot:SetMonoTone(true)
        chapterSlot:SetIgnore(true)
      else
        if firstContents == nil then
          firstContents = chapterSlot
        end
        chapterSlot:SetMonoTone(false)
        chapterSlot:SetIgnore(false)
        chapterSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_Achievement_BookShelf_All_SelectChapter(" .. chapterKey .. ")")
      end
      chapterSlot:addInputEvent("Mouse_On", "HandleEventOn_Achievement_BookShelf_All_ShowSubTitleTooltip(true, " .. tostring(index) .. ", " .. tostring(self._selectedJournalGroup) .. ", " .. tostring(chapterKey) .. ")")
      chapterSlot:addInputEvent("Mouse_Out", "HandleEventOn_Achievement_BookShelf_All_ShowSubTitleTooltip(false, " .. tostring(index) .. ", " .. tostring(self._selectedJournalGroup) .. ", " .. tostring(chapterKey) .. ")")
      chapterTitle:SetText(titleText)
      chapterSlot:SetShow(true)
    else
      chapterSlot:SetShow(false)
      chapterSlot:addInputEvent("Mouse_LUp", "")
    end
  end
  if firstContents ~= nil then
    ToClient_padSnapChangeToTarget(firstContents)
  end
end
function PaGlobal_Achievement_BookShelf_All:SetBookTexture(control, journalKey, chapterKey)
  if control == nil or journalKey == nil or chapterKey == nil then
    return
  end
  local base_textureID = self:getJournalBookCoverTextureID(0, journalKey, chapterKey)
  if base_textureID == nil then
    return
  end
  local on_textureID = self:getJournalBookCoverTextureID(1, journalKey, chapterKey)
  if on_textureID == nil then
    return
  end
  local click_textureID = self:getJournalBookCoverTextureID(2, journalKey, chapterKey)
  if click_textureID == nil then
    return
  end
  control:ChangeTextureInfoTextureIDAsync(base_textureID, 0)
  control:ChangeTextureInfoTextureIDAsync(on_textureID, 1)
  control:ChangeTextureInfoTextureIDAsync(click_textureID, 2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_Achievement_BookShelf_All:updateJournalList()
  for index = 1, #self._journalControlList do
    local journalKey = self._journalGroupIndexList[index]
    if nil ~= journalKey then
      local processingChapterCnt = self:returnProcessingChapterCnt(journalKey)
      if nil ~= processingChapterCnt then
        local needHide = false
        for hideIndex, value in pairs(self._hideIndex) do
          if value == journalKey then
            needHide = true
            break
          end
        end
        if processingChapterCnt == 0 and needHide == false then
          self._journalControlList[index].txt_BookCondition:SetShow(true)
        else
          self._journalControlList[index].txt_BookCondition:SetShow(false)
        end
        local chapterList = self._journalControlList[index].chapterList
        if nil ~= chapterList then
          for ii = 1, #chapterList do
            if nil ~= chapterList[ii] then
              if ii <= processingChapterCnt then
                chapterList[ii]:SetShow(true)
              else
                chapterList[ii]:SetShow(false)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:updateChapterList(index)
  if nil == index then
    index = self._selectedJournalGroup
  end
  if nil == self._selectedJournalGroup or self._selectedJournalGroup < 1 then
    return
  end
  local nowChapterCnt = ToClient_GetChapterCount(self._selectedJournalGroup)
  if nil ~= nowChapterCnt and nowChapterCnt > 0 then
    self._journalChapterCnt = nowChapterCnt
  end
  local leftTitle = ToClient_GetJournalName(self._selectedJournalGroup)
  local leftDesc = ToClient_GetJournalDesc(self._selectedJournalGroup)
  if nil == leftTitle or nil == leftDesc then
    return
  end
  local processingChapterCnt = self:returnProcessingChapterCnt(self._selectedJournalGroup)
  if nil == processingChapterCnt then
    processingChapterCnt = 0
  end
  self._ui.txt_LeftTitle:SetShow(true)
  leftTitle = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_BOOKSHELF_SUBTITLE", "title", leftTitle, "count1", processingChapterCnt, "countAll", self._journalChapterCnt)
  self._ui.txt_LeftTitle:SetText(leftTitle)
  self._ui.txt_BookShelfDesc:SetText(leftDesc)
  for index = 1, self._MAX_CALLING_COUNT do
    self._chapterControlList[index].slot:SetShow(false)
  end
  self:setChapterSlot()
end
function PaGlobal_Achievement_BookShelf_All:selectJournal(index)
  if nil ~= index then
    self._selectedJournalGroup = index
  else
    self._selectedJournalGroup = 1
  end
  self._selectedButton = self._journalControlList[index]
  TooltipSimple_Hide()
  self:updateChapterList(index)
end
function PaGlobal_Achievement_BookShelf_All:selectChapter(index)
  if nil == index then
    return
  end
  local journalType = ToClient_GetJournalType(self._selectedJournalGroup, index)
  if journalType == __eQuestJournalType_Count then
    return
  end
  if journalType == __eQuestJournalType_Normal then
    local journalQuestCnt = ToClient_GetJournalQuestCount(self._selectedJournalGroup, index)
    if journalQuestCnt == nil or journalQuestCnt < 1 then
      return
    end
    local questNo = ToClient_GetJournalQuestNo(self._selectedJournalGroup, index, 0)
    if questNo == nil then
      return
    end
    if PaGlobalFunc_Achievement_Open_From_BookShelf ~= nil then
      self._selectedJournalChapter = index
      PaGlobalFunc_Achievement_Open_From_BookShelf(questNo._group)
    end
  elseif journalType == __eQuestJournalType_Renew then
    if _ContentsGroup_MorningLand == false then
      return
    end
    PaGlobalFunc_Achievement_MorningLand_Open(self._selectedJournalGroup, index)
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \235\170\168\237\151\152\236\157\188\236\167\128 \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_Achievement_BookShelf_All:setFamilyWidget()
  local specialInfo = ToClient_GetFamilySpecialInfo()
  if nil == specialInfo then
    return
  end
  local txt_FamilyName = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_FamilyName")
  txt_FamilyName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIEVEMENT_BOOKSHELF_FAMILYNAME", "familyname", getFamilyName()))
  local offence = specialInfo:getFamilySpecialOffence()
  local defence = specialInfo:getFamilySpecialDefence()
  local maxhp = specialInfo:getFamilySpecialMaxHp()
  local maxsp = specialInfo:getFamilySpecialMaxSp()
  local weight = specialInfo:getFamilySpecialWeight()
  if nil ~= weight then
    weight = weight / 10000
  end
  local inven = specialInfo:getFamilySpecialInven()
  local hit = specialInfo:getFamilySpecialHit()
  local dv = specialInfo:getFamilySpecialDv()
  local specialStack = specialInfo:getFamilySpecialStack()
  local valksLimitExceed = specialInfo:getFamilySpecialValksLimitExceed()
  local txt_offence = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Offence_Value")
  local txt_defence = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Defence_Value")
  local txt_maxHp = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_MaxHP_Value")
  local txt_maxSp = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_MaxSP_Value")
  local txt_weight = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Weight_Value")
  local txt_inven = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Inven_Value")
  local txt_hit = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Hit_Value")
  local txt_dv = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_DV_Value")
  local txt_specialStack = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_Special_Stack_Value")
  local txt_valksLimitExcced = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_ValksLimitExceed_Value")
  if nil ~= offence then
    txt_offence:SetText(offence)
  end
  if nil ~= defence then
    txt_defence:SetText(defence)
  end
  if nil ~= maxhp then
    txt_maxHp:SetText(maxhp)
  end
  if nil ~= maxsp then
    txt_maxSp:SetText(maxsp)
  end
  if nil ~= weight then
    txt_weight:SetText(weight)
  end
  if nil ~= inven then
    txt_inven:SetText(inven)
  end
  if nil ~= hit then
    txt_hit:SetText(hit)
  end
  if nil ~= dv then
    txt_dv:SetText(dv)
  end
  if nil ~= specialStack then
    txt_specialStack:SetText(specialStack)
  end
  if nil ~= valksLimitExceed then
    txt_valksLimitExcced:SetText(valksLimitExceed)
  end
  if false == _ContentsGroup_RubinSpecial then
    local txt_valksLimitExceedTitle = UI.getChildControl(self._ui.stc_FamilyWidget, "StaticText_ValksLimitExceed")
    txt_valksLimitExceedTitle:SetShow(false)
    txt_valksLimitExcced:SetShow(false)
    self._ui.stc_FamilyWidget:SetSize(self._ui.stc_FamilyWidget:GetSizeX(), self._defaultFamilyWidgetSizeY - 30)
    self._ui.stc_familyWidget_SubBG:SetSize(self._ui.stc_familyWidget_SubBG:GetSizeX(), self._ui.stc_FamilyWidget:GetSizeY() - 50)
  end
end
function PaGlobal_Achievement_BookShelf_All:showToggleFamilyWidget()
  if nil == self._ui.stc_FamilyWidget then
    return
  end
  local isShow = not self._ui.stc_FamilyWidget:GetShow()
  self._ui.stc_FamilyWidget:SetShow(isShow)
  if true == isShow then
    self:setFamilyWidget()
  end
end
function PaGlobal_Achievement_BookShelf_All:validate()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  self._ui.stc_TopArea:isValidate()
  self._ui.stc_CenterArea:isValidate()
  self._ui.stc_FamilyWidget:isValidate()
  self._ui.stc_LeftArea:isValidate()
  self._ui.stc_RightArea:isValidate()
  self._ui.stc_BtnClose:isValidate()
  self._ui.stc_Chapter:isValidate()
  self._ui.stc_ChapterSlot:isValidate()
  self._ui.stc_ChapterTitle:isValidate()
  self._ui.txt_FamilyStatIcon:isValidate()
  self._ui.txt_LeftTitle:isValidate()
  self._ui.txt_BookShelfDesc:isValidate()
  self._ui.frame_BookShelf:isValidate()
  self._ui.frame_BookShelfContent:isValidate()
  self._ui.btn_BookArea:isValidate()
  self._ui.txt_BookTitleBg:isValidate()
  self._ui.txt_BookTitle:isValidate()
  self._ui.stc_BookGroup:isValidate()
  self._ui.stc_EmptyGroup_1:isValidate()
  self._ui.stc_EmptyGroup_1_object:isValidate()
  self._ui.stc_EmptyGroup_2:isValidate()
  self._ui.stc_EmptyGroup_2_object:isValidate()
  self._ui.stc_EmptyGroup_3:isValidate()
  self._ui.stc_EmptyGroup_3_object_1:isValidate()
  self._ui.stc_EmptyGroup_3_object_2:isValidate()
  self._ui.stc_EmptyGroup_4:isValidate()
  self._ui.stc_EmptyGroup_4_object_1:isValidate()
  self._ui.stc_EmptyGroup_4_object_2:isValidate()
  self._ui.stc_BookImage:isValidate()
end
function PaGlobal_Achievement_BookShelf_All:updateSetDirectJournalChapter(questGroup, questNo)
  for index = 1, #self._journalControlList do
    local journalKey = self._journalGroupIndexList[index]
    if nil ~= journalKey then
      local nowChapterCnt = ToClient_GetChapterCount(journalKey)
      if nil ~= nowChapterCnt and 0 ~= nowChapterCnt then
        for ii = 1, nowChapterCnt do
          local chapterKey = ToClient_GetCapterKey(journalKey, ii)
          local questNoData = ToClient_GetJournalQuestNo(journalKey, chapterKey, 0)
          if nil ~= questNoData and questGroup == questNoData._group and questNo == questNoData._quest then
            self._selectedJournalGroup = journalKey
            self._selectedJournalChapter = chapterKey
            break
          end
        end
      end
    end
  end
end
function PaGlobal_Achievement_BookShelf_All:getJournalBookCoverTextureID(type, journalKey, chapterKey)
  local bookCoverTextureID = ToClient_GetJournalBookCoverTextureID(journalKey, chapterKey)
  if bookCoverTextureID == nil then
    return nil
  end
  if type == 0 then
    bookCoverTextureID = bookCoverTextureID .. "_BTN_Normal"
  elseif type == 1 then
    bookCoverTextureID = bookCoverTextureID .. "_BTN_Over"
  elseif type == 2 then
    bookCoverTextureID = bookCoverTextureID .. "_BTN_Click"
  elseif type == 3 then
    bookCoverTextureID = bookCoverTextureID .. "_BTN_Dimd"
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 Type \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return nil
  end
  return bookCoverTextureID
end
function PaGlobal_Achievement_BookShelf_All:getJournalBookRoundCoverTextureID(journalKey, chapterKey)
  local bookRoundCoverTextureID = ToClient_GetJournalBookRoundCoverTextureID(journalKey, chapterKey)
  if bookRoundCoverTextureID == nil then
    return nil
  end
  return bookRoundCoverTextureID
end
