function PaGlobal_Journal_All:initialize()
  if Panel_Window_Journal_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  local stc_Title = UI.getChildControl(Panel_Window_Journal_All, "Static_TitleArea")
  self._ui._txt_title = UI.getChildControl(stc_Title, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(stc_Title, "Button_Close")
  self._ui._stc_TabArea = UI.getChildControl(Panel_Window_Journal_All, "Static_TabArea")
  self._ui._rdo_tab_templete = UI.getChildControl(self._ui._stc_TabArea, "RadioButton_Tab_Templete")
  self._ui._frame_contentArea = UI.getChildControl(Panel_Window_Journal_All, "Frame_ContentArea")
  self._ui._frame_content = UI.getChildControl(self._ui._frame_contentArea, "Frame_1_Content")
  self._ui._stc_questNormal_templete = UI.getChildControl(self._ui._frame_content, "Static_QuestNormal_Templete")
  self._ui._stc_questHidden_templete = UI.getChildControl(self._ui._frame_content, "Static_QuestHidden_Templete")
  self._ui._stc_pageArea = UI.getChildControl(Panel_Window_Journal_All, "Static_PageArea")
  self._ui._rdo_page_templete = UI.getChildControl(self._ui._stc_pageArea, "RadioButton_Page_Templete")
  self._ui._btn_scrollL = UI.getChildControl(self._ui._stc_pageArea, "Button_Scroll_L")
  self._ui._btn_scrollR = UI.getChildControl(self._ui._stc_pageArea, "Button_Scroll_R")
  self._ui._stc_keyguide = UI.getChildControl(Panel_Window_Journal_All, "Static_KeyGuide_ConsoleUI")
  self._ui._txt_keyguideA = UI.getChildControl(self._ui._stc_keyguide, "StaticText_A_ConsoleUI")
  self._ui._txt_keyguideB = UI.getChildControl(self._ui._stc_keyguide, "StaticText_B_ConsoleUI")
  self._ui._stc_keyguideLB = UI.getChildControl(self._ui._btn_scrollL, "Static_KeyGuide_LB_ConsoleUI")
  self._ui._stc_keyguideRB = UI.getChildControl(self._ui._btn_scrollR, "Static_KeyGuide_RB_ConsoleUI")
  local stc_questTemplete = UI.getChildControl(self._ui._stc_questNormal_templete, "Static_Quest_1")
  local btn_detail = UI.getChildControl(stc_questTemplete, "Button_Detail_View")
  self._normalTempleteDetailBtnSizeX = btn_detail:GetSizeX()
  self._ui._rdo_tab_templete:SetShow(false)
  self._ui._stc_questNormal_templete:SetShow(false)
  self._ui._stc_questHidden_templete:SetShow(false)
  self._ui._rdo_page_templete:SetShow(false)
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:checkPlatform()
  self:validate()
  self._initialize = true
end
function PaGlobal_Journal_All:registEventHandler()
  if Panel_Window_Journal_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_Close()")
  self._ui._btn_scrollL:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_ChangePage(false)")
  self._ui._btn_scrollR:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_ChangePage(true)")
  Panel_Window_Journal_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Journal_All_ChangePage(false)")
  Panel_Window_Journal_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Journal_All_ChangePage(true)")
  Panel_Window_Journal_All:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_Journal_All_ClickNextJournalButton(false)")
  Panel_Window_Journal_All:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_Journal_All_ClickNextJournalButton(true)")
  registerEvent("executeLuaFunc", "PaGlobal_Journal_All_ExecuteLuaFunc")
  registerEvent("EventQuestUpdateNotify", "PaGlobal_Journal_All_CheckStamp")
end
function PaGlobal_Journal_All:checkPlatform()
  if Panel_Window_Journal_All == nil then
    return
  end
  if self._isPadSnapping == true then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_keyguide:SetShow(true)
    self._ui._stc_keyguideLB:SetShow(true)
    self._ui._stc_keyguideRB:SetShow(true)
    local keyGuides = {
      self._ui._txt_keyguideA,
      self._ui._txt_keyguideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyguide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui._btn_close:SetShow(true)
    self._ui._stc_keyguide:SetShow(false)
    self._ui._stc_keyguideLB:SetShow(false)
    self._ui._stc_keyguideRB:SetShow(false)
  end
end
function PaGlobal_Journal_All:prepareOpen(journalListType)
  if Panel_Window_Journal_All == nil then
    return
  end
  if Panel_Window_Journal_All:GetShow() == true then
    return
  end
  self:setJournalInfo(journalListType)
  self:updateJournalList()
  self:open()
end
function PaGlobal_Journal_All:open()
  Panel_Window_Journal_All:SetShow(true)
end
function PaGlobal_Journal_All:prepareClose()
  if Panel_Window_Journal_All == nil then
    return
  end
  self:deleteCopyControl()
  self._currentJournalListIndex = nil
  self._lastShowPage = nil
  self._currentPage = nil
  self._currentChapter = nil
  self._isPageChanging = false
  self:close()
end
function PaGlobal_Journal_All:close()
  Panel_Window_Journal_All:SetShow(false)
end
function PaGlobal_Journal_All:deleteCopyControl()
  if Panel_Window_Journal_All == nil then
    return
  end
  for chapterIndex = 1, #self._chapterInfo do
    local chapterInfo = self._chapterInfo[chapterIndex]
    if chapterInfo._chapterUI ~= nil then
      UI.deleteControl(chapterInfo._chapterUI)
    end
  end
  self._chapterInfo = {}
  for pageIndex = 1, #self._pageInfo do
    local pageInfo = self._pageInfo[pageIndex]
    if pageInfo._pageUI ~= nil then
      UI.deleteControl(pageInfo._pageUI)
    end
    if pageInfo._pageNumberUI ~= nil then
      UI.deleteControl(pageInfo._pageNumberUI)
    end
  end
  self._pageInfo = {}
end
function PaGlobal_Journal_All:setJournalInfo(journalListIndex)
  if Panel_Window_Journal_All == nil then
    return
  end
  self:deleteCopyControl()
  self._currentJournalListIndex = journalListIndex
  self._chapterInfo = {}
  self._pageInfo = {}
  local chapterCount = ToClient_getJournalChapterCount(self._currentJournalListIndex)
  local pageCount = 1
  local lastCompletePage = 0
  self._showChapterButton = false
  local frameTextureID = ToClient_getJournalTextureInfo(self._currentJournalListIndex, 3)
  local barTextureID = ToClient_getJournalTextureInfo(self._currentJournalListIndex, 4)
  for chapterIndex = 1, chapterCount do
    local chapterInfo = {}
    chapterInfo._chapterIndex = chapterIndex
    chapterInfo._chapterUI = UI.cloneControl(self._ui._rdo_tab_templete, self._ui._stc_TabArea, "Static_Chapter" .. chapterIndex)
    local chapterString
    local chapterUITypeMaxIndex = ToClient_getJournalUITypeMaxIndex(self._currentJournalListIndex, chapterIndex)
    for uiTypeIndex = 1, chapterUITypeMaxIndex do
      local journalCount = ToClient_getJournalInfoCount(self._currentJournalListIndex, chapterIndex, uiTypeIndex)
      local uiType = ToClient_getJournalUIType(self._currentJournalListIndex, chapterIndex, uiTypeIndex)
      if uiType == -1 then
        _PA_ASSERT_NAME(false, "\236\161\180\236\158\172\237\149\160 \236\136\152 \236\151\134\235\138\148 journal uiType\236\157\180 \237\153\149\236\157\184\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164", "\236\152\164\236\131\129\235\175\188")
      end
      local pageInfo = {}
      pageInfo._chapterIndex = chapterIndex
      pageInfo._uiType = uiType
      pageInfo._uiTypeIndex = uiTypeIndex
      pageInfo._pageIndex = pageCount
      pageInfo._journalCount = journalCount
      local clearAllJournal = true
      for journalIndex = 1, journalCount do
        if clearAllJournal == true then
          local journalInfo = ToClient_getJournalInfo(self._currentJournalListIndex, chapterIndex, uiTypeIndex, journalIndex)
          if ToClient_isCompleteJournal(journalInfo) == false then
            clearAllJournal = false
          end
          if chapterString == nil then
            chapterString = journalInfo:getChapterString()
          end
        end
      end
      pageInfo._canShow = clearAllJournal
      if pageInfo._canShow == true then
        lastCompletePage = pageInfo._pageIndex
      elseif pageInfo._pageIndex == 1 then
        pageInfo._canShow = true
      elseif pageCount == lastCompletePage + 1 then
        pageInfo._canShow = true
      end
      pageInfo._pageUI = nil
      if pageInfo._canShow == true then
        local controlToClone
        if pageInfo._uiType == 0 then
          controlToClone = self._ui._stc_questNormal_templete
        else
          controlToClone = self._ui._stc_questHidden_templete
        end
        local pageUI = UI.cloneControl(controlToClone, self._ui._frame_content, "Static_Page_" .. pageInfo._pageIndex)
        pageInfo._pageUI = pageUI
        pageInfo._pageUI:SetSpanSize(0, 0)
        pageInfo._pageUI:ComputePos()
        self._ui._frame_content:SetChildIndex(pageInfo._pageUI, 9999)
      end
      pageInfo._pageNumberUI = UI.cloneControl(self._ui._rdo_page_templete, self._ui._stc_pageArea, "Static_PageNumber_" .. pageInfo._pageIndex)
      pageInfo._pageNumberUI:SetText(pageInfo._pageIndex)
      pageInfo._pageNumberUI:SetShow(true)
      Panel_Window_Journal_All:ChangeTextureInfoTextureIDAsync(frameTextureID)
      Panel_Window_Journal_All:setRenderTexture(Panel_Window_Journal_All:getBaseTexture())
      if pageInfo._canShow == true and pageInfo._uiType == 0 then
        local stc_bar = UI.getChildControlNoneAssert(pageInfo._pageUI, "Static_Line")
        if stc_bar ~= nil then
          stc_bar:ChangeTextureInfoTextureIDAsync(barTextureID)
          stc_bar:setRenderTexture(stc_bar:getBaseTexture())
        end
      end
      table.insert(self._pageInfo, pageInfo)
      pageCount = pageCount + 1
    end
    if chapterString ~= nil then
      chapterInfo._chapterUI:SetText(PAGetString(Defines.StringSheet_GAME, chapterString))
      self._showChapterButton = true
    end
    table.insert(self._chapterInfo, chapterInfo)
  end
  self._ui._frame_contentArea:UpdateContentPos()
  self._lastShowPage = lastCompletePage + 1
  if self._lastShowPage > #self._pageInfo then
    self._lastShowPage = #self._pageInfo
  end
  self._currentPage = self._lastShowPage
  local pageInfo = self._pageInfo[self._currentPage]
  self._currentChapter = pageInfo._chapterIndex
  local spanX = 50
  for chapterIndex = 1, #self._chapterInfo do
    local chapterInfo = self._chapterInfo[chapterIndex]
    chapterInfo._chapterUI:SetShow(true)
    chapterInfo._chapterUI:SetSpanSize(spanX, 0)
    spanX = spanX + 1260 / #self._chapterInfo
  end
  local startSpanX = -25 * (#self._pageInfo - 1)
  for pageIndex = 1, #self._pageInfo do
    local pageInfo = self._pageInfo[pageIndex]
    pageInfo._pageNumberUI:SetShow(true)
    pageInfo._pageNumberUI:SetSpanSize(startSpanX + (pageIndex - 1) * 50)
  end
end
function PaGlobal_Journal_All:updateJournalList()
  if Panel_Window_Journal_All == nil then
    return
  end
  if #self._pageInfo <= 0 then
    return
  end
  if #self._pageInfo <= 1 then
    self._ui._btn_scrollL:SetShow(false)
    self._ui._btn_scrollR:SetShow(false)
    for pageIndex = 1, #self._pageInfo do
      self._pageInfo[pageIndex]._pageNumberUI:SetShow(false)
    end
  else
    self._ui._btn_scrollL:SetShow(true)
    self._ui._btn_scrollR:SetShow(true)
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self._ui._txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_TITLE", "charName", "[" .. selfPlayer:getName() .. "]"))
  self._currentJournalStartIndex = 1
  for pageIndex = 1, #self._pageInfo do
    local pageInfo = self._pageInfo[pageIndex]
    self:updatePage(pageInfo, self._currentJournalStartIndex, self._currentJournalStartIndex - 1 + self._uiTypeMaxJournalCount[pageInfo._uiType])
  end
  self:setCurrentPage()
end
function PaGlobal_Journal_All:updatePage(pageInfo, startIndex, endIndex)
  if Panel_Window_Journal_All == nil then
    return
  end
  local uiStartIndex = 1
  for index = startIndex, endIndex do
    local journalInfo = ToClient_getJournalInfo(self._currentJournalListIndex, pageInfo._chapterIndex, pageInfo._uiTypeIndex, index)
    if pageInfo._canShow == true then
      local journalUI = UI.getChildControl(pageInfo._pageUI, "Static_Quest_" .. uiStartIndex)
      local isEmpty = false
      if index <= pageInfo._journalCount then
        self:updateJournal(pageInfo, journalInfo, journalUI)
      else
        journalUI:SetShow(false)
      end
      uiStartIndex = uiStartIndex + 1
    end
  end
end
function PaGlobal_Journal_All:updateJournal(pageInfo, journalInfo, journalUI)
  if Panel_Window_Journal_All == nil then
    return
  end
  if pageInfo == nil or journalInfo == nil or journalUI == nil then
    return
  end
  local stc_progressBg = UI.getChildControl(journalUI, "Static_ProgressBG_0")
  local btn_detailView = UI.getChildControl(journalUI, "Button_Detail_View")
  journalUI:SetShow(true)
  stc_progressBg:SetShow(true)
  btn_detailView:SetShow(true)
  if ToClient_isCompleteJournal(journalInfo) == true then
    stc_progressBg:SetShow(false)
    btn_detailView:SetShow(false)
    local bookQuestNo = journalInfo:getBookQuestNo()
    journalUI:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_OpenBookShelfQuest(" .. bookQuestNo._group .. "," .. bookQuestNo._quest .. ")")
  else
    journalUI:addInputEvent("Mouse_LUp", "")
    local clearQuestCount = ToClient_getJournalInfoClearQuestCount(journalInfo)
    local progressPercent = clearQuestCount / journalInfo._totalQuestCount * 100
    local stc_progress = UI.getChildControl(stc_progressBg, "Progress2_QuestProgress")
    if progressPercent <= 0 then
      stc_progressBg:SetShow(false)
    else
      stc_progressBg:SetShow(true)
      stc_progress:SetProgressRate(progressPercent)
    end
    local posX = Panel_Window_Journal_All:GetPosX() + journalUI:GetPosX()
    local posY = Panel_Window_Journal_All:GetPosY() + journalUI:GetPosY()
    btn_detailView:ChangeTextureInfoTextureIDAsync(journalInfo:getDetailBtnTextureId(0), 0)
    btn_detailView:ChangeTextureInfoTextureIDAsync(journalInfo:getDetailBtnTextureId(1), 1)
    btn_detailView:ChangeTextureInfoTextureIDAsync(journalInfo:getDetailBtnTextureId(2), 2)
    btn_detailView:setRenderTexture(btn_detailView:getBaseTexture())
    btn_detailView:SetShow(true)
    btn_detailView:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Page_All_Open(" .. self._currentJournalListIndex .. "," .. journalInfo._chapterIndex .. "," .. journalInfo._uiTypeIndex .. "," .. journalInfo._journalIndex .. "," .. posX .. "," .. posY .. ")")
    journalUI:addInputEvent("Mouse_LUp", "PaGlobal_Journal_Page_All_Open(" .. self._currentJournalListIndex .. "," .. journalInfo._chapterIndex .. "," .. journalInfo._uiTypeIndex .. "," .. journalInfo._journalIndex .. "," .. posX .. "," .. posY .. ")")
  end
  self:updateJournalByType(pageInfo, journalInfo, journalUI)
end
function PaGlobal_Journal_All:updateJournalByType(pageInfo, journalInfo, journalUI)
  if Panel_Window_Journal_All == nil then
    return
  end
  if pageInfo == nil or journalInfo == nil or journalUI == nil then
    return
  end
  local stc_questComplete = UI.getChildControl(journalUI, "Static_QuestComplete")
  local stc_storyTitleBg = UI.getChildControl(journalUI, "Static_StoryTitleBg")
  local txt_storyTitle = UI.getChildControl(stc_storyTitleBg, "StaticText_StoryTitle")
  local stc_questVisual = UI.getChildControlNoneAssert(journalUI, "Static_QuestVisual")
  local txt_bossName = UI.getChildControl(journalUI, "StaticText_BossName")
  local btn_detailView = UI.getChildControl(journalUI, "Button_Detail_View")
  if pageInfo._uiType == 0 then
    journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 0), 0)
    journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 1), 1)
    journalUI:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 0), 2)
    journalUI:setRenderTexture(journalUI:getBaseTexture())
    journalUI:SetMonoTone(self:isMonoToneJournal(journalInfo))
    if self._currentJournalListIndex == 0 then
      btn_detailView:SetSize(self._normalTempleteDetailBtnSizeX, btn_detailView:GetSizeY())
      btn_detailView:SetSpanSize(10, 15)
      txt_bossName:SetSize(self._normalTempleteDetailBtnSizeX, txt_bossName:GetSizeY())
      txt_bossName:SetSpanSize(10, 15)
    else
      btn_detailView:SetSize(180, btn_detailView:GetSizeY())
      btn_detailView:SetSpanSize(25, 15)
      txt_bossName:SetSize(180, txt_bossName:GetSizeY())
      txt_bossName:SetSpanSize(25, 15)
    end
    btn_detailView:ComputePos()
  elseif pageInfo._uiType == 1 and stc_questVisual ~= nil then
    stc_questVisual:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 0), 0)
    stc_questVisual:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 1), 1)
    stc_questVisual:ChangeTextureInfoTextureIDAsync(ToClient_getJournalInfoTextureID(journalInfo, 0), 2)
    stc_questVisual:setRenderTexture(stc_questVisual:getBaseTexture())
    stc_questVisual:SetMonoTone(self:isMonoToneJournal(journalInfo))
  end
  stc_storyTitleBg:SetShow(false)
  if ToClient_isCompleteJournal(journalInfo) == true then
    if self._currentJournalListIndex == 0 then
      stc_questComplete:SetShow(true)
      local bookQuestNo = journalInfo:getBookQuestNo()
      stc_questComplete:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_OpenBookShelfQuest(" .. bookQuestNo._group .. "," .. bookQuestNo._quest .. ")")
      if stc_questVisual ~= nil then
        stc_questVisual:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_OpenBookShelfQuest(" .. bookQuestNo._group .. "," .. bookQuestNo._quest .. ")")
      end
      txt_bossName:SetShow(false)
      if isGameTypeKorea() == false then
        local bossNameString = journalInfo:getTitleString()
        if bossNameString ~= nil then
          stc_storyTitleBg:SetShow(true)
          txt_storyTitle:SetText(PAGetString(Defines.StringSheet_GAME, bossNameString))
        end
      end
      if self._stampQuestGroupNo == journalInfo._questGroupNo then
        stc_questComplete:AddEffect("fUI_Stamp_01C", true, 0, 0)
        audioPostEvent_SystemUi(0, 23)
        _AudioPostEvent_SystemUiForXBOX(0, 23)
        self._stampQuestGroupNo = 0
      end
    elseif self._currentJournalListIndex == 1 then
      local bossNameString = journalInfo:getDetailBtnString()
      if bossNameString ~= nil then
        txt_bossName:SetShow(true)
        txt_bossName:SetText(PAGetString(Defines.StringSheet_GAME, bossNameString))
      end
      stc_questComplete:SetShow(false)
    end
  else
    stc_questComplete:addInputEvent("Mouse_LUp", "")
    if stc_questVisual ~= nil then
      stc_questVisual:addInputEvent("Mouse_LUp", "")
    end
    stc_questComplete:SetShow(false)
    stc_questComplete:addInputEvent("Mouse_LUp", "")
    btn_detailView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING_QUESTBOARD_DETAIL"))
  end
end
function PaGlobal_Journal_All:setCurrentPage()
  if Panel_Window_Journal_All == nil then
    return
  end
  local chapterCount = ToClient_getJournalChapterCount(self._currentJournalListIndex)
  for chapterIndex = 1, chapterCount do
    local chapterInfo = self._chapterInfo[chapterIndex]
    local stc_select = UI.getChildControl(chapterInfo._chapterUI, "Static_Select")
    if self._showChapterButton == true then
      if chapterInfo._chapterIndex == self._currentChapter then
        chapterInfo._chapterUI:SetCheck(true)
        stc_select:SetShow(true)
      else
        chapterInfo._chapterUI:SetCheck(false)
        stc_select:SetShow(false)
      end
    else
      chapterInfo._chapterUI:SetShow(false)
      stc_select:SetShow(false)
    end
  end
  for pageIndex = 1, #self._pageInfo do
    local pageInfo = self._pageInfo[pageIndex]
    if pageIndex == self._currentPage then
      if pageInfo._pageUI ~= nil then
        pageInfo._pageUI:SetShow(true)
        if pageInfo._uiType == 1 then
          local btn_left = UI.getChildControl(pageInfo._pageUI, "Button_Left")
          local btn_right = UI.getChildControl(pageInfo._pageUI, "Button_Right")
          local keyguide_LT = UI.getChildControl(pageInfo._pageUI, "Static_KeyGuide_LT_ConsoleUI")
          local keyguide_RT = UI.getChildControl(pageInfo._pageUI, "Static_KeyGuide_RT_ConsoleUI")
          keyguide_LT:SetShow(false)
          keyguide_RT:SetShow(false)
          if pageInfo._journalCount > self._uiTypeMaxJournalCount[pageInfo._uiType] then
            btn_left:SetShow(true)
            btn_right:SetShow(true)
            btn_left:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_ClickNextJournalButton(false)")
            btn_right:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_ClickNextJournalButton(true)")
            if self._isPadSnapping == true then
              keyguide_LT:SetShow(true)
              keyguide_RT:SetShow(true)
              btn_left:SetShow(false)
              btn_right:SetShow(false)
            end
          else
            btn_left:SetShow(false)
            btn_right:SetShow(false)
          end
        end
      end
      pageInfo._pageNumberUI:SetCheck(true)
    else
      if pageInfo._pageUI ~= nil then
        pageInfo._pageUI:SetShow(false)
        if pageInfo._uiType == 1 then
          local btn_left = UI.getChildControl(pageInfo._pageUI, "Button_Left")
          local btn_right = UI.getChildControl(pageInfo._pageUI, "Button_Right")
          local keyguide_LT = UI.getChildControl(pageInfo._pageUI, "Static_KeyGuide_LT_ConsoleUI")
          local keyguide_RT = UI.getChildControl(pageInfo._pageUI, "Static_KeyGuide_RT_ConsoleUI")
          btn_left:SetShow(false)
          btn_right:SetShow(false)
          keyguide_LT:SetShow(false)
          keyguide_RT:SetShow(false)
        end
      end
      pageInfo._pageNumberUI:SetCheck(false)
    end
  end
end
function PaGlobal_Journal_All:changePage(isRight)
  if Panel_Window_Journal_All == nil then
    return
  end
  if self._isPageChanging == true then
    return
  end
  local prevPageInfo = self._pageInfo[self._currentPage]
  local multipleValue = 1
  if isRight == true then
    self._currentPage = self._currentPage + 1
    if self._currentPage > self._lastShowPage then
      self._currentPage = self._lastShowPage
      if self._currentPage == #self._pageInfo then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsLastJournalPage"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantOpenNextJournalPage"))
      end
      return
    end
    multipleValue = 1
  else
    self._currentPage = self._currentPage - 1
    if self._currentPage < 1 then
      self._currentPage = 1
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsLastJournalPage"))
      return
    end
    multipleValue = -1
  end
  if Panel_Window_Journal_Page_All ~= nil and Panel_Window_Journal_Page_All:GetShow() == true then
    PaGlobal_Journal_Page_All_Close()
  end
  self._currentJournalStartIndex = 1
  local nextPageInfo = self._pageInfo[self._currentPage]
  self._currentChapter = nextPageInfo._chapterIndex
  self:updatePage(nextPageInfo, self._currentJournalStartIndex, self._currentJournalStartIndex - 1 + self._uiTypeMaxJournalCount[nextPageInfo._uiType])
  self._prevPageUI = prevPageInfo._pageUI
  self._prevPageUI:SetPosX(0)
  self._prevPageUI:SetShow(true)
  self._nextPageUI = nextPageInfo._pageUI
  self._nextPageUI:SetPosX(1253 * multipleValue)
  self._nextPageUI:SetShow(true)
  self._isPageChanging = true
  if isRight == true then
    Panel_Window_Journal_All:RegisterUpdateFunc("PaGlobal_Journal_All_NextPageChangeAni")
  else
    Panel_Window_Journal_All:RegisterUpdateFunc("PaGlobal_Journal_All_PrevPageChangeAni")
  end
end
function PaGlobal_Journal_All:showAni_NextPage(deltaTime)
  if Panel_Window_Journal_All == nil then
    return
  end
  local move = self._speed * deltaTime
  self._prevPageUI:SetPosX(self._prevPageUI:GetPosX() - move)
  self._nextPageUI:SetPosX(self._nextPageUI:GetPosX() - move)
  if self._prevPageUI:GetPosX() + self._prevPageUI:GetSizeX() <= 0 then
    Panel_Window_Journal_All:ClearUpdateLuaFunc()
    self._prevPageUI:SetPosX(-1254)
    self._nextPageUI:SetPosX(0)
    self:setCurrentPage()
    self._isPageChanging = false
    self:refreshSnapTarget()
  end
end
function PaGlobal_Journal_All:showAni_PrevPage(deltaTime)
  if Panel_Window_Journal_All == nil then
    return
  end
  local move = self._speed * deltaTime
  self._prevPageUI:SetPosX(self._prevPageUI:GetPosX() + move)
  self._nextPageUI:SetPosX(self._nextPageUI:GetPosX() + move)
  if self._nextPageUI:GetPosX() >= 0 then
    Panel_Window_Journal_All:ClearUpdateLuaFunc()
    self._prevPageUI:SetPosX(1254)
    self._nextPageUI:SetPosX(0)
    self:setCurrentPage()
    self._isPageChanging = false
    PaGlobal_MorningLand_QuestBoard_All:refreshSnapTarget()
  end
end
function PaGlobal_Journal_All:refreshSnapTarget()
  if Panel_Window_Journal_All == nil then
    return
  end
end
function PaGlobal_Journal_All:isMonoToneJournal(currentJournalInfo)
  if Panel_Window_Journal_All == nil then
    return
  end
  local self = PaGlobal_Journal_All
  if self == nil then
    return
  end
  if self._currentJournalListIndex == nil then
    return
  end
  local currentChapterIndex = currentJournalInfo._chapterIndex
  local currentUiTypeIndex = currentJournalInfo._uiTypeIndex
  local journalCount = ToClient_getJournalInfoCount(self._currentJournalListIndex, currentChapterIndex, currentUiTypeIndex)
  local isProgressing = false
  local progressingJournalIndex = 0
  for journalIndex = 1, journalCount do
    if isProgressing == false then
      local journalInfo = ToClient_getJournalInfo(self._currentJournalListIndex, currentChapterIndex, currentUiTypeIndex, journalIndex)
      if journalInfo ~= nil and ToClient_getJournalInfoClearQuestCount(journalInfo) ~= 0 and ToClient_isCompleteJournal(journalInfo) == false then
        isProgressing = true
        progressingJournalIndex = journalInfo._journalIndex
      end
      local uiQuestInfo = ToClient_GetQuestInfo(journalInfo._questGroupNo, 1)
      if uiQuestInfo ~= nil and uiQuestInfo._isProgressing == true then
        isProgressing = true
        progressingJournalIndex = journalInfo._journalIndex
      end
    end
  end
  if isProgressing == false then
    return false
  end
  if progressingJournalIndex == currentJournalInfo._journalIndex or ToClient_isCompleteJournal(currentJournalInfo) == true then
    return false
  end
  return true
end
function PaGlobal_Journal_All:validate()
  if Panel_Window_Journal_All == nil then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_TabArea:isValidate()
  self._ui._rdo_tab_templete:isValidate()
  self._ui._frame_contentArea:isValidate()
  self._ui._frame_content:isValidate()
  self._ui._stc_questNormal_templete:isValidate()
  self._ui._stc_questHidden_templete:isValidate()
  self._ui._stc_pageArea:isValidate()
  self._ui._rdo_page_templete:isValidate()
  self._ui._btn_scrollL:isValidate()
  self._ui._btn_scrollR:isValidate()
  self._ui._stc_keyguide:isValidate()
  self._ui._txt_keyguideA:isValidate()
  self._ui._txt_keyguideB:isValidate()
end
