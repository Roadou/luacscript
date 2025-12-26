function PaGlobal_FishCompetition:initialize()
  if nil == Panel_Window_FishCompetition or true == PaGlobal_FishCompetition._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_FishCompetition:controlInit()
  self._ui.stc_topBg = UI.getChildControl(Panel_Window_FishCompetition, "Static_TopBg")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_topBg, "Button_Close")
  self._ui.stc_radioButtonArea = UI.getChildControl(Panel_Window_FishCompetition, "Static_RadioButtonArea")
  self._ui.list2_fishList = UI.getChildControl(self._ui.stc_radioButtonArea, "List2_Fish")
  self._ui.btn_Guide = UI.getChildControl(self._ui.stc_radioButtonArea, "Button_Guide")
  self._ui.stc_rightArea = UI.getChildControl(Panel_Window_FishCompetition, "Static_RightArea")
  self._ui.stc_fishInfoArea = UI.getChildControl(self._ui.stc_rightArea, "Static_FishInfoArea")
  self._ui.stc_fishBg = UI.getChildControl(self._ui.stc_fishInfoArea, "Static_FishBg")
  self._ui.stc_fishImage = UI.getChildControl(self._ui.stc_fishBg, "Static_FishImage")
  self._ui.txt_fishName = UI.getChildControl(self._ui.stc_fishInfoArea, "StaticText_FishName")
  self._ui.stc_rareBG = UI.getChildControl(self._ui.stc_fishInfoArea, "Static_RareBg")
  for index = 1, self._rateIconCount do
    self._ui.icons_rate[index] = UI.getChildControl(self._ui.stc_rareBG, "Static_RateIcon" .. index)
  end
  self._ui.stc_averageSizeBg = UI.getChildControl(self._ui.stc_fishInfoArea, "Static_AverageSizeBg")
  self._ui.txt_averageSize = UI.getChildControl(self._ui.stc_averageSizeBg, "StaticText_AverageSizeValue")
  self._ui.stc_rankingArea = UI.getChildControl(self._ui.stc_rightArea, "Static_RankingArea")
  self._ui.stc_TopBgs[1] = UI.getChildControl(self._ui.stc_rankingArea, "Static_1stBg")
  self._ui.stc_TopBgs[2] = UI.getChildControl(self._ui.stc_rankingArea, "Static_2ndBg")
  self._ui.stc_TopBgs[3] = UI.getChildControl(self._ui.stc_rankingArea, "Static_3rdBg")
  for index = 1, self._topCount do
    self._ui.txt_TopNames[index] = UI.getChildControl(self._ui.stc_TopBgs[index], "StaticText_FamilyName")
    self._ui.txt_TopValues[index] = UI.getChildControl(self._ui.stc_TopBgs[index], "StaticText_SizeValue")
    self._ui.stc_catchRegion[index] = UI.getChildControl(self._ui.stc_TopBgs[index], "Button_Tooltip")
    local txt_rank = UI.getChildControl(self._ui.stc_TopBgs[index], "StaticText_Rank")
    txt_rank:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_MYRANK", "rank", index))
  end
  for index = self._topCount + 1, self._rankCount do
    self._ui.txt_rankNames[index] = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_CharacterName" .. index)
    self._ui.txt_rankValues[index] = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_Value" .. index)
    local txt_rank = UI.getChildControl(self._ui.stc_rankingArea, "StaticText_Ranking" .. index)
    txt_rank:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_MYRANK", "rank", index))
  end
  self._ui.stc_myRankArea = UI.getChildControl(self._ui.stc_rightArea, "Static_MyRankArea")
  self._ui.txt_myRank = UI.getChildControl(self._ui.stc_myRankArea, "StaticText_MyRankValue")
  self._ui.txt_myValue = UI.getChildControl(self._ui.stc_myRankArea, "StaticText_MyRecord")
  self._ui.btn_rewardInfo = UI.getChildControl(self._ui.stc_myRankArea, "Button_RewardInfo")
  self._ui.btn_receive = UI.getChildControl(self._ui.stc_myRankArea, "Button_Receive")
  self._ui.stc_getable = UI.getChildControl(self._ui.btn_receive, "Static_Getable")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_Window_FishCompetition, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_B_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "Button_X_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Console_A")
end
function PaGlobal_FishCompetition:setConsoleUI()
  self._ui.stc_KeyGuide_Bg:SetShow(self._isConsole == true)
  local keyGuideList = Array.new()
  keyGuideList:push_back(self._ui.stc_KeyGuide_X)
  keyGuideList:push_back(self._ui.stc_KeyGuide_A)
  keyGuideList:push_back(self._ui.stc_KeyGuide_B)
  self._ui.stc_KeyGuide_B:SetShow(self._isConsole == true)
  self._ui.stc_KeyGuide_X:SetShow(self._isConsole == true)
  self._ui.stc_KeyGuide_A:SetShow(self._isConsole == true)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  self._ui.btn_close:SetShow(self._isConsole == false)
end
function PaGlobal_FishCompetition:registerEventHandler()
  if Panel_Window_FishCompetition == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetition_Close()")
  self._ui.btn_receive:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetitionMyReward_Open()")
  self._ui.btn_rewardInfo:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetitionRewardInfo_Open()")
  self._ui.list2_fishList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FishCompetition_CreateContent")
  self._ui.list2_fishList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateFishCompetition", "FromClient_UpdateFishCompetition")
  registerEvent("FromClient_UpdateFishCompetitionMyReward", "FromClient_CheckCompetitionRewardExist")
  if self._isConsole == true then
    Panel_Window_FishCompetition:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMOn_FishCompetitionGuide_SimpleTooltip(nil)")
  else
    self._ui.btn_Guide:addInputEvent("Mouse_On", "HandleEventMOn_FishCompetitionGuide_SimpleTooltip(true)")
    self._ui.btn_Guide:addInputEvent("Mouse_Out", "HandleEventMOn_FishCompetitionGuide_SimpleTooltip(false)")
  end
end
function PaGlobal_FishCompetition:requestOpen()
  self._fishTypeIndex = 0
  ToClient_RequestFishCompetitionKey()
  ToClient_RequestFishCompetitionMyReward()
end
function PaGlobal_FishCompetition:prepareOpen()
  if Panel_Window_FishCompetition == nil then
    return
  end
  self:open()
end
function PaGlobal_FishCompetition:open()
  if Panel_Window_FishCompetition == nil or true == Panel_Window_FishCompetition:GetShow() then
    return
  end
  Panel_Window_FishCompetition:SetShow(true)
end
function PaGlobal_FishCompetition:prepareClose()
  if Panel_Window_FishCompetition == nil or false == Panel_Window_FishCompetition:GetShow() then
    return
  end
  self:close()
end
function PaGlobal_FishCompetition:close()
  if Panel_Window_FishCompetition == nil or false == Panel_Window_FishCompetition:GetShow() then
    return
  end
  Panel_Window_FishCompetition:SetShow(false)
end
function PaGlobal_FishCompetition:update()
  if Panel_Window_FishCompetition == nil then
    return
  end
  self:clearInformation()
  local fishTypeCount = ToClient_GetFishCompetitionArraySize()
  if fishTypeCount == 0 then
    return
  end
  local listManager = self._ui.list2_fishList:getElementManager()
  for index = 0, fishTypeCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  for index = 1, ToClient_GetFishCompetitionRareness(self._fishTypeIndex) + 1 do
    self._ui.icons_rate[index]:SetShow(true)
  end
  self._ui.stc_fishImage:ChangeTextureInfoNameAsync(ToClient_GetFishCompetitionImagePath(self._fishTypeIndex))
  self._ui.txt_fishName:SetText(ToClient_GetFishCompetitionName(self._fishTypeIndex))
  self._ui.txt_averageSize:SetText(string.format("%.3f", ToClient_GetFishCompetitionAverageSize(self._fishTypeIndex)))
  local rankerCount = ToClient_GetFishCompetitionCount(self._fishTypeIndex)
  for rankerIndex = 1, rankerCount do
    local fishCompetitionData = ToClient_GetFishCompetitionData(self._fishTypeIndex, rankerIndex - 1)
    if fishCompetitionData == nil then
      break
    end
    if rankerIndex <= self._topCount then
      self._ui.txt_TopNames[rankerIndex]:SetText(fishCompetitionData:getUserNickName())
      self._ui.txt_TopValues[rankerIndex]:SetText(string.format("%.3f", fishCompetitionData:getWeekValue()))
      local regionKey = fishCompetitionData:getWeekRegionKey()
      self._ui.stc_catchRegion[rankerIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_FishCompetition_CatcthRegionTooltip(" .. tostring(rankerIndex) .. "," .. tostring(regionKey) .. "," .. tostring(true) .. ")")
      self._ui.stc_catchRegion[rankerIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_FishCompetition_CatcthRegionTooltip(" .. tostring(rankerIndex) .. "," .. tostring(regionKey) .. "," .. tostring(false) .. ")")
    else
      self._ui.txt_rankNames[rankerIndex]:SetText(fishCompetitionData:getUserNickName())
      self._ui.txt_rankValues[rankerIndex]:SetText(string.format("%.3f", fishCompetitionData:getWeekValue()))
    end
  end
  local myRank = ToClient_GetFishCompetitionMyRank(self._fishTypeIndex)
  if myRank > 0 then
    self._ui.txt_myRank:SetText(tostring(myRank))
    local myRankValue = ToClient_GetFishCompetitionMyValue(self._fishTypeIndex)
    self._ui.txt_myValue:SetText(string.format("%.3f", myRankValue))
  end
end
function PaGlobal_FishCompetition:clearInformation()
  for index = 1, self._rateIconCount do
    self._ui.icons_rate[index]:SetShow(false)
  end
  self._ui.stc_fishImage:ChangeTextureInfoNameAsync(self._emptyImagePath)
  self._ui.txt_fishName:SetText("-")
  self._ui.txt_averageSize:SetText("-")
  for rankerIndex = 1, self._rankCount do
    if rankerIndex <= self._topCount then
      self._ui.txt_TopNames[rankerIndex]:SetText("-")
      self._ui.txt_TopValues[rankerIndex]:SetText("-")
      self._ui.stc_catchRegion[rankerIndex]:addInputEvent("Mouse_On", "")
      self._ui.stc_catchRegion[rankerIndex]:addInputEvent("Mouse_Out", "")
    else
      self._ui.txt_rankNames[rankerIndex]:SetText("-")
      self._ui.txt_rankValues[rankerIndex]:SetText("-")
    end
  end
  self._ui.txt_myRank:SetText("-")
  self._ui.txt_myValue:SetText("-")
  local listManager = self._ui.list2_fishList:getElementManager()
  listManager:clearKey()
end
function PaGlobal_FishCompetition:createContent(content, key)
  if Panel_Window_FishCompetition == nil or content == nil or key == nil then
    return
  end
  local competitionIndex = Int64toInt32(key)
  local radioButton = UI.getChildControl(content, "RadioButton_Template")
  if competitionIndex == self._fishTypeIndex then
    radioButton:SetCheck(true)
  else
    radioButton:SetCheck(false)
  end
  radioButton:SetText(ToClient_GetFishCompetitionName(competitionIndex))
  radioButton:SetFontColor(self._gradeColor[ToClient_GetFishCompetitionRareness(competitionIndex)])
  radioButton:SetOverFontColor(self._gradeColor[ToClient_GetFishCompetitionRareness(competitionIndex)])
  radioButton:SetClickFontColor(self._gradeColor[ToClient_GetFishCompetitionRareness(competitionIndex)])
  radioButton:addInputEvent("Mouse_LUp", "PaGlobal_FishCompetition_SelectButton(" .. competitionIndex .. ")")
end
function PaGlobal_FishCompetition:selectButton(index)
  self._fishTypeIndex = index
  ToClient_RequestFishCompetitionData(index)
end
function PaGlobal_FishCompetition:checkCompetitionRewardExist()
  local rewardSize = ToClient_GetMyRewardSize()
  self._ui.stc_getable:SetShow(rewardSize ~= 0)
end
