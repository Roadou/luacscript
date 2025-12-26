function PaGlobal_FishEncyclopedia_Renewal_All:initialize()
  if nil == Panel_Window_FishEncyclopedia_Renewal_All or true == PaGlobal_FishEncyclopedia_Renewal_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_FishEncyclopedia_Renewal_All:controlInit()
  self._ui.btn_close = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Button_Close")
  self._ui.edit_fishKeyword = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Edit_SearchText_PCUI")
  self._ui.stc_categoryTabBackground = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Static_RadioButtonBg")
  for index = 1, self._maxCategoryCount do
    self._ui.radiobuttons_category[index] = UI.getChildControl(self._ui.stc_categoryTabBackground, "RadioButton_" .. index)
  end
  self._ui.stc_leftPage = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Static_Left")
  self._ui.list2_fishList = UI.getChildControl(self._ui.stc_leftPage, "List2_Fish")
  self._ui.txt_progressValue = UI.getChildControl(self._ui.stc_leftPage, "StaticText_CompleteValue")
  self._ui.stc_progressBackground = UI.getChildControl(self._ui.stc_leftPage, "Static_CompleteBg")
  self._ui.progress_complete = UI.getChildControl(self._ui.stc_progressBackground, "Progress2_Complete")
  self._ui.stc_rightPage = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Static_Right")
  self._ui.stc_fishImage = UI.getChildControl(self._ui.stc_rightPage, "Static_FishImage")
  self._ui.txt_fishName = UI.getChildControl(self._ui.stc_rightPage, "StaticText_FishName")
  for index = 1, self._rateIconCount do
    self._ui.icons_rate[index] = UI.getChildControl(self._ui.stc_rightPage, "Static_RateIcon" .. index)
  end
  self._ui.txt_averageFishSize = UI.getChildControl(self._ui.stc_rightPage, "StaticText_AverageSizeValue")
  self._ui.stc_myFishSizeBackground = UI.getChildControl(self._ui.stc_rightPage, "Static_MySizeBg")
  self._ui.txt_myFishSize = UI.getChildControl(self._ui.stc_myFishSizeBackground, "StaticText_MySizeValue")
  self._ui.stc_myFishCountBackground = UI.getChildControl(self._ui.stc_rightPage, "Static_MyCountBg")
  self._ui.txt_myFishCount = UI.getChildControl(self._ui.stc_myFishCountBackground, "StaticText_MyCountValue")
  self._ui.txt_fishDescription = UI.getChildControl(self._ui.stc_rightPage, "StaticText_FishExplanation")
  self._ui.txt_fishDescription:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.txt_fishDescription:setLineCountByLimitAutoWrap(8)
  self._ui.stc_rankingArea = UI.getChildControl(self._ui.stc_rightPage, "Static_RankingArea")
  for index = 1, self._rankerCount do
    self._ui.txt_rankerName_list[index] = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_CharacterName" .. index)
    self._ui.txt_rankerValue_list[index] = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_Value" .. index)
    local rankingText = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_Ranking" .. index)
    rankingText:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_MYRANK", "rank", index))
  end
  self._ui.stc_myRankIcon = UI.getChildControl(self._ui.stc_rankingArea, "Static_MyRankIcon")
  self._ui.stc_myRankArea = UI.getChildControl(self._ui.stc_rightPage, "Static_MyRankArea")
  self._ui.txt_myRankTitle = UI.getChildControl(self._ui.stc_myRankArea, "StaticText_MyRankTitle")
  self._ui.txt_myRankValue = UI.getChildControl(self._ui.stc_myRankArea, "StaticText_MyRankValue")
  self._ui.stc_gradeBar = UI.getChildControl(self._ui.stc_myRankArea, "Static_GradeBar")
  self._ui.stc_arrow = UI.getChildControl(self._ui.stc_gradeBar, "Static_Arrow")
  self._ui.stc_banner = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Static_EventBanner")
  self._ui.stc_banner:SetShow(_ContentsGroup_FishCompetition)
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_Window_FishEncyclopedia_Renewal_All, "Static_BottomBg_ConsoleUI")
  self._ui.txt_guideIconY = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self._ui.txt_guideIconB = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_B_ConsoleUI")
  self._ui.txt_guideIconA = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Console_A")
end
function PaGlobal_FishEncyclopedia_Renewal_All:setConsoleUI()
  self._ui.stc_KeyGuide_Bg:SetShow(self._isConsole == true)
  local guideIconGroup = {
    self._ui.txt_guideIconY,
    self._ui.txt_guideIconA,
    self._ui.txt_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_KeyGuide_Bg:ComputePos()
  self._ui.btn_close:SetShow(self._isConsole == false)
end
function PaGlobal_FishEncyclopedia_Renewal_All:registerEventHandler()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_FishEncyclopedia_Renewal_All_Close()")
  for index = 1, self._maxCategoryCount do
    self._ui.radiobuttons_category[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_FishEncyclopedia_Renewal_All_ChangeCategory(" .. index .. ")")
  end
  self._ui.stc_banner:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetition_RequestOpen()")
  Panel_Window_FishEncyclopedia_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_FishEncyclopedia_Renewal_All_SearchFishListByKeyword()")
  Panel_Window_FishEncyclopedia_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_FishEncyclopedia_Renewal_SetFocusEdit()")
  if ToClient_isConsole() == true then
    self._ui.edit_fishKeyword:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_FishEncyclopedia_Renewal_KeyboardEnd")
  else
    self._ui.edit_fishKeyword:RegistReturnKeyEvent("PaGlobalFunc_FishEncyclopedia_Renewal_All_SearchFishListByKeyword()")
  end
  registerEvent("onScreenResize", "FromClient_FishEncyclopedia_Renewal_All_OnScreenSize")
  registerEvent("FromClient_ResponseFishTopRankingBody", "PaGlobalFunc_FishEncyclopedia_Renewal_All_UpdateRankInformation")
  registerEvent("FromClient_UpdateFishEncyclopediaRenewal", "FromClient_UpdateFishEncyclopediaRenewal")
  self._ui.list2_fishList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_FishEncyclopedia_Renewal_All_CreateContent")
  self._ui.list2_fishList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.txt_fishDescription:addInputEvent("Mouse_On", "PaGlobalFunc_FishEncyclopedia_Renewal_All_DescTooltip(true)")
  self._ui.txt_fishDescription:addInputEvent("Mouse_Out", "PaGlobalFunc_FishEncyclopedia_Renewal_All_DescTooltip(false)")
end
function PaGlobal_FishEncyclopedia_Renewal_All:prepareOpen()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  self._ui.edit_fishKeyword:SetEditText("")
  self:changeCategory(1)
  self:updateWholePage()
  self:open()
end
function PaGlobal_FishEncyclopedia_Renewal_All:open()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil or true == Panel_Window_FishEncyclopedia_Renewal_All:GetShow() then
    return
  end
  Panel_Window_FishEncyclopedia_Renewal_All:SetShow(true)
end
function PaGlobal_FishEncyclopedia_Renewal_All:prepareClose()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil or false == Panel_Window_FishEncyclopedia_Renewal_All:GetShow() then
    return
  end
  self:close()
end
function PaGlobal_FishEncyclopedia_Renewal_All:close()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil or false == Panel_Window_FishEncyclopedia_Renewal_All:GetShow() then
    return
  end
  Panel_Window_FishEncyclopedia_Renewal_All:SetShow(false)
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateWholePage()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  self:updateLeftPage()
  self:updateRightPage()
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateLeftPage()
  self:updateCategoryButton()
  self:updateProgress()
  self:updateFishList()
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateRightPage()
  self:updateFishInformation()
  self:requestRankInformation()
end
function PaGlobal_FishEncyclopedia_Renewal_All:validate()
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:changeCategory(index)
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  self._currentRadioIndex = index
  ClearFocusEdit()
  self:searchFishListByKeyword(false)
  if self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui.radiobuttons_category[index])
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:setInitialSlot()
  local showingFishCount = ToClient_GetFishListSize()
  for index = 0, showingFishCount - 1 do
    local fishEncyclopedia = ToClient_GetFishEncyclopedia(index)
    if fishEncyclopedia ~= nil then
      self:selectSlot(index)
      return
    end
  end
  self:selectSlot(0)
end
function PaGlobal_FishEncyclopedia_Renewal_All:getCurrentCategory()
  return self._categoryMapping[self._currentRadioIndex]
end
function PaGlobal_FishEncyclopedia_Renewal_All:searchFishListByKeyword(isByInput)
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  local searchKeyword = self._ui.edit_fishKeyword:GetEditText()
  if searchKeyword == "" then
    self._ui.edit_fishKeyword:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PEARLSHOP_SEARCH_DEFAULT"))
  end
  ClearFocusEdit()
  local isSearchResultExist = ToClient_SetFishListByKeyword(searchKeyword, self:getCurrentCategory())
  if isSearchResultExist == false and isByInput == true then
    for index = 1, self._maxCategoryCount do
      if ToClient_SetFishListByKeyword(searchKeyword, self._categoryMapping[index]) == true then
        self:changeCategory(index)
        return
      end
    end
  end
  self:updateWholePage()
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateFishList()
  local rowCount = math.ceil(ToClient_GetFishListSize() / self._columnSize)
  self:setInitialSlot()
  self._ui.listContents = {}
  local listManager = self._ui.list2_fishList:getElementManager()
  listManager:clearKey()
  for index = 0, rowCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:createContent(content, key)
  if Panel_Window_FishEncyclopedia_Renewal_All == nil or content == nil or key == nil then
    return
  end
  local showingFishCount = ToClient_GetFishListSize()
  local index = Int64toInt32(key)
  for columnIndex = 0, self._columnSize - 1 do
    local listIndex = index * self._columnSize + columnIndex
    local fishEncyclopedia = ToClient_GetFishEncyclopedia(listIndex)
    local fishSlot = UI.getChildControl(content, "Static_SlotBg_" .. tostring(columnIndex))
    local fishImage = UI.getChildControl(fishSlot, "Static_FishImage")
    local fishName = UI.getChildControl(fishSlot, "StaticText_FishName")
    fishName:SetTextMode(__eTextMode_Limit_AutoWrap)
    local fishNameBG = UI.getChildControl(fishSlot, "Static_NameBg")
    fishSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_FishEncyclopedia_Renewal_All_SelectSlot(" .. listIndex .. ")")
    fishSlot:addInputEvent("Mouse_On", "PaGlobalFunc_FishEncyclopedia_Renewal_All_FishNameTooltip(" .. tostring(true) .. ", " .. listIndex .. ")")
    fishSlot:addInputEvent("Mouse_Out", "PaGlobalFunc_FishEncyclopedia_Renewal_All_FishNameTooltip(" .. tostring(false) .. ", " .. listIndex .. ")")
    if showingFishCount > listIndex then
      fishSlot:SetShow(true)
      self._ui.fishSlotList[listIndex] = fishSlot
      local selectBorder = UI.getChildControl(fishSlot, "Static_SelectBorder")
      if listIndex == self._selectedFishIndex and fishEncyclopedia ~= nil then
        selectBorder:SetShow(true)
        self._ui.list2_fishList:moveIndex(index)
      else
        selectBorder:SetShow(false)
      end
      if fishEncyclopedia == nil then
        fishSlot:SetIgnore(true)
        fishImage:ChangeTextureInfoNameAsync(self._emptyImagePath)
        fishName:SetText("")
        fishNameBG:SetShow(false)
      else
        if fishEncyclopedia:isAcquire() == true then
          fishName:SetFontColor(self._gradeColor[fishEncyclopedia:getGradeType()])
          fishImage:SetMonoTone(false)
          fishImage:SetAlpha(1)
        else
          fishName:SetFontColor(self._notFoundColor)
          fishImage:SetMonoTone(true)
          fishImage:SetAlpha(0.7)
        end
        fishSlot:SetIgnore(false)
        fishImage:ChangeTextureInfoNameAsync(fishEncyclopedia:getImagePath())
        fishName:SetText(fishEncyclopedia:getName())
        fishNameBG:SetShow(true)
      end
    else
      fishSlot:SetShow(false)
    end
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:selectSlot(index)
  if Panel_Window_FishEncyclopedia_Renewal_All == nil then
    return
  end
  self:setSelectBar(false)
  self._selectedFishIndex = index
  self:setSelectBar(true)
  self:updateRightPage()
end
function PaGlobal_FishEncyclopedia_Renewal_All:setSelectBar(isShow)
  local fishSlot = self._ui.fishSlotList[self._selectedFishIndex]
  if fishSlot ~= nil then
    local slotBorder = UI.getChildControl(fishSlot, "Static_SelectBorder")
    slotBorder:SetShow(isShow)
    local fishEncyclopedia = ToClient_GetFishEncyclopedia(self._selectedFishIndex)
    if fishEncyclopedia == nil then
      slotBorder:SetShow(false)
    end
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:getRankString(lengthRatio)
  if lengthRatio >= 0.8 then
    return "A"
  elseif lengthRatio >= 0.6 then
    return "B"
  elseif lengthRatio >= 0.4 then
    return "C"
  elseif lengthRatio >= 0.2 then
    return "D"
  end
  return "E"
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateCategoryButton()
  for index = 1, self._maxCategoryCount do
    self._ui.radiobuttons_category[index]:SetCheck(false)
    self._ui.radiobuttons_category[index]:SetPosX(0)
  end
  self._ui.radiobuttons_category[self._currentRadioIndex]:SetCheck(true)
  self._ui.radiobuttons_category[self._currentRadioIndex]:SetPosX(10)
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateProgress()
  local totalFishCount = ToClient_GetFishCountByCategory(self:getCurrentCategory())
  local acquireFishCount = ToClient_GetAcquireFishCountByCategory(self:getCurrentCategory())
  local progressPercent = 0
  if totalFishCount ~= 0 then
    progressPercent = string.format("%.1f", acquireFishCount / totalFishCount * 100)
  end
  self._ui.txt_progressValue:SetText(tostring(progressPercent) .. "%")
  self._ui.progress_complete:SetProgressRate(progressPercent)
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateFishInformation()
  self:clearFishInformation()
  local fishEncyclopedia = ToClient_GetFishEncyclopedia(self._selectedFishIndex)
  if fishEncyclopedia == nil then
    return
  end
  self._ui.stc_fishImage:ChangeTextureInfoNameAsync(fishEncyclopedia:getImagePath())
  self._ui.txt_fishName:SetText(fishEncyclopedia:getName())
  self._ui.txt_fishName:SetFontColor(self._gradeColor[fishEncyclopedia:getGradeType()])
  for index = 1, self._rateIconCount do
    self._ui.icons_rate[index]:SetShow(false)
  end
  for index = 1, fishEncyclopedia:getGradeType() + 1 do
    self._ui.icons_rate[index]:SetShow(true)
  end
  self._ui.txt_averageFishSize:SetText(string.format("%.3f", fishEncyclopedia:getAverageValue()))
  self._ui.txt_fishDescription:SetText(fishEncyclopedia:getDesc())
  if fishEncyclopedia:isAcquire() == true then
    self._ui.txt_myFishSize:SetText(string.format("%.3f", fishEncyclopedia:getMaxValue()))
    self._ui.txt_myFishCount:SetText(tostring(fishEncyclopedia:getCount()))
  else
    self._ui.txt_myFishSize:SetText("-")
    self._ui.txt_myFishCount:SetText("0")
  end
end
function PaGlobal_FishEncyclopedia_Renewal_All:clearFishInformation()
  self._ui.stc_fishImage:ChangeTextureInfoNameAsync(self._emptyImagePath)
  self._ui.txt_fishName:SetText("-")
  for index = 1, self._rateIconCount do
    self._ui.icons_rate[index]:SetShow(false)
  end
  self._ui.txt_averageFishSize:SetText("-")
  self._ui.txt_myFishSize:SetText("-")
  self._ui.txt_myFishCount:SetText("-")
  self._ui.txt_fishDescription:SetText("")
end
function PaGlobal_FishEncyclopedia_Renewal_All:requestRankInformation()
  local fishEncyclopedia = ToClient_GetFishEncyclopedia(self._selectedFishIndex)
  if fishEncyclopedia == nil then
    self:clearRankInformation()
    return
  end
  local fishKey = fishEncyclopedia:getKey()
  ToClient_RequestFishTopRankingBody(fishKey)
  self:updateRankInformation()
end
function PaGlobal_FishEncyclopedia_Renewal_All:updateRankInformation()
  self:clearRankInformation()
  local selfPlayerNickName = getSelfPlayer():getUserNickname()
  local fishEncyclopedia = ToClient_GetFishEncyclopedia(self._selectedFishIndex)
  if fishEncyclopedia == nil then
    return
  end
  local fishKey = fishEncyclopedia:getKey()
  for rankIndex = 1, self._rankerCount do
    self._ui.txt_rankerName_list[rankIndex]:SetText("")
    self._ui.txt_rankerValue_list[rankIndex]:SetText("")
    local rankValue = ToClient_GetFishTopRankingValueInClient(fishKey, rankIndex - 1)
    if nil ~= rankValue then
      local rankNickName = rankValue:getUserNickName()
      local rankLength = string.format("%.3f", rankValue.length)
      if rankValue.length > 0 then
        self._ui.txt_rankerName_list[rankIndex]:SetText(rankNickName)
        self._ui.txt_rankerValue_list[rankIndex]:SetText(rankLength)
      end
      if selfPlayerNickName == rankNickName then
        self._ui.stc_myRankIcon:SetShow(true)
        self._ui.stc_myRankIcon:SetPosY(self._ui.txt_rankerName_list[rankIndex]:GetPosY())
      end
    end
  end
  self._ui.stc_myRankArea:SetShow(fishEncyclopedia:isAcquire())
  local lengthRatio = ToClient_CompareMyMaxLengthToFirst(fishEncyclopedia:getKey())
  self._ui.txt_myRankValue:SetText(self:getRankString(lengthRatio))
  self._ui.txt_myRankValue:SetPosX(self._ui.txt_myRankTitle:GetPosX() + self._ui.txt_myRankTitle:GetTextSizeX() + 10)
  self._ui.stc_arrow:SetPosX(self._ui.stc_gradeBar:GetSizeX() * (1 - lengthRatio) - self._ui.stc_arrow:GetSizeX() / 2)
end
function PaGlobal_FishEncyclopedia_Renewal_All:clearRankInformation()
  for rankIndex = 1, self._rankerCount do
    self._ui.txt_rankerName_list[rankIndex]:SetText("")
    self._ui.txt_rankerValue_list[rankIndex]:SetText("")
  end
  self._ui.stc_myRankIcon:SetShow(false)
  self._ui.txt_myRankValue:SetText("-")
  self._ui.stc_arrow:SetPosX(self._ui.stc_gradeBar:GetSizeX() - self._ui.stc_arrow:GetSizeX() / 2)
end
