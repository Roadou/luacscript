Panel_Widget_MainQuest_AbyssOne:SetDragEnable(false)
local _static_active = UI.getChildControl(Panel_Widget_MainQuest_AbyssOne, "Static_Active")
local mainQuestWidget = {
  _ui = {
    _static_TitleBG = UI.getChildControl(_static_active, "Static_TitleBG"),
    _staticText_Quest_Title = UI.getChildControl(_static_active, "StaticText_Quest_Title"),
    _static_Eff_Complete_Eff1 = UI.getChildControl(_static_active, "Static_Eff_Complete_Eff1"),
    _static_Quest_Type = UI.getChildControl(_static_active, "Static_Quest_Type"),
    _staticText_WidgetGroupTitle = UI.getChildControl(_static_active, "StaticText_WidgetGroupTitle"),
    _staticText_Quest_ClearNpc = UI.getChildControl(_static_active, "StaticText_Quest_ClearNpc"),
    _clearNpcEffect = UI.getChildControl(_static_active, "StaticText_ClearNpc_Effect"),
    _clearNpcEffect2 = UI.getChildControl(_static_active, "StaticText_ClearNpc_Effect_2"),
    _staticText_Quest_Demand = UI.getChildControl(_static_active, "StaticText_Quest_Demand"),
    _stc_NoQuest = UI.getChildControl(_static_active, "StaticText_1"),
    _mouseR = UI.getChildControl(_static_active, "Static_MouseR"),
    _stc_bottomLine = UI.getChildControl(Panel_Widget_MainQuest_AbyssOne, "Static_BottomLine")
  },
  _config = {_maxConditionCount = 5, _closableLevel = 50},
  _uiQuestConditions = {},
  _isButtonOn = false,
  _mainQuestNo = nil,
  _isInitialized = false,
  _mainQuestNavi = {_groupNo = nil, _questNo = nil},
  _currentDesc = nil,
  _isUIMode = false,
  _isQuestGuide = false
}
function mainQuestWidget:initialize()
  self:createControl()
  self:initControl()
  self:hidePanelConditionCheck()
end
function mainQuestWidget:hidePanelConditionCheck()
  if nil == Panel_Widget_MainQuest_AbyssOne then
    _PA_ASSERT_NAME(false, "Panel_Widget_MainQuest_AbyssOne\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing),
    selfPlayer:get():isCompetitionDefined(),
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_Widget_MainQuest_AbyssOne:SetRenderAndEventHide(true)
  else
    Panel_Widget_MainQuest_AbyssOne:SetRenderAndEventHide(false)
  end
end
function mainQuestWidget:createControl()
  self._ui._staticText_Quest_Demand:SetShow(false)
  for index = 0, self._config._maxConditionCount - 1 do
    self._uiQuestConditions[index] = UI.cloneControl(self._ui._staticText_Quest_Demand, _static_active, "uiCondition_" .. index)
    self._uiQuestConditions[index]:SetText("")
    self._uiQuestConditions[index]:SetIgnore(true)
    self._uiQuestConditions[index]:SetShow(false)
    self._uiQuestConditions[index]:SetPosX(2)
    self._uiQuestConditions[index]:addInputEvent("Mouse_On", "PaGlobalFunc_MainQuestWidget_MouseOnEvent()")
    self._uiQuestConditions[index]:addInputEvent("Mouse_Out", "PaGlobalFunc_MainQuestWidget_MouseOutEvent()")
  end
  self:clearConditionInfo()
end
function mainQuestWidget:initControl()
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_On", "PaGlobalFunc_MainQuestWidget_MouseOnEvent()")
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_Out", "PaGlobalFunc_MainQuestWidget_MouseOutEvent()")
  for _key, _value in pairs(self._ui) do
    if nil ~= _value then
      _value:addInputEvent("Mouse_On", "PaGlobalFunc_MainQuestWidget_MouseOnEvent()")
      _value:addInputEvent("Mouse_Out", "PaGlobalFunc_MainQuestWidget_MouseOutEvent()")
    end
  end
  Panel_Widget_MainQuest_AbyssOne:SetShow(true)
  self._isInitialized = true
  local questList = ToClient_GetQuestList()
  if false == questList:isMainQuestClearAll() then
    Panel_Widget_MainQuest_AbyssOne:SetIgnore(false)
    self._ui._static_TitleBG:SetShow(true)
    self:open()
  else
    self:clearAll()
  end
  if true == Panel_Widget_MainQuest_AbyssOne:GetShow() then
    self:update()
  end
  self._ui._static_TitleBG:SetIgnore(true)
end
function PaGlobalFunc_MainQuestWidget_Open()
  mainQuestWidget:open()
end
function mainQuestWidget:open()
  self:update()
end
function PaGlobalFunc_MainQuestWidget_Close()
  mainQuestWidget:close()
end
function mainQuestWidget:close()
  Panel_Widget_MainQuest_AbyssOne:SetShow(false)
  self:clearAll()
end
function PaGlobalFunc_MainQuestWidget_SetQuestGroupTitleInfo(uiQuestInfo)
  return mainQuestWidget:setQuestGroupTitleInfo(uiQuestInfo)
end
function mainQuestWidget:setQuestGroupTitleInfo(uiQuestInfo)
  local startPosY = self._ui._staticText_Quest_Title:GetPosY() + self._ui._staticText_Quest_Title:GetSizeY() * 2
  if uiQuestInfo:isSatisfied() or not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing then
    return startPosY
  end
  local questNo = uiQuestInfo:getQuestNo()
  local questListInfo = ToClient_GetQuestList()
  local uiQuestGroupInfo = questListInfo:getQuestGroup(questNo)
  if nil ~= uiQuestGroupInfo and uiQuestGroupInfo:isGroupQuest() then
    local groupTitle = uiQuestGroupInfo:getTitle()
    local questGroupCount = uiQuestGroupInfo:getTotalQuestCount()
    local groupQuestTitleInfo = " " .. groupTitle .. " (" .. questNo._quest .. "/" .. questGroupCount .. ")"
    self._ui._staticText_WidgetGroupTitle:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_GROUPTITLEINFO", "titleinfo", groupQuestTitleInfo))
    self._ui._staticText_WidgetGroupTitle:SetTextMode(__eTextMode_LimitText)
    self._ui._staticText_WidgetGroupTitle:SetSize(230, self._ui._staticText_Quest_Title:GetSizeY())
    self._ui._staticText_WidgetGroupTitle:SetPosX(8)
    self._ui._staticText_WidgetGroupTitle:SetPosY(self._ui._staticText_Quest_Title:GetPosY() + self._ui._staticText_Quest_Title:GetSizeY() + self._ui._staticText_Quest_Title:GetSizeY() + 5)
    self._ui._staticText_WidgetGroupTitle:SetAutoResize(true)
    self._ui._staticText_WidgetGroupTitle:SetIgnore(true)
    self._ui._staticText_WidgetGroupTitle:SetShow(true)
    startPosY = startPosY + self._ui._staticText_Quest_Title:GetSizeY() * 2
  end
  return startPosY
end
function FGlobal_MainQuest_Update(groupNo, questNo)
  mainQuestWidget:update(groupNo, questNo)
  if nil ~= PaGlobal_CheckedQuest_UpdateBackSpaceQuest then
    PaGlobal_CheckedQuest_UpdateBackSpaceQuest()
  end
end
function FGlobal_MainQuest_UpdateRenew(groupNo, questNo)
  mainQuestWidget:updateRenew(groupNo, questNo)
end
function mainQuestWidget:update(groupNo, questNo)
  if false == self._isInitialized then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    self:clearAll()
    return
  end
  if nil ~= groupNo and nil ~= questNo then
    local questInfo = ToClient_GetQuestInfo(groupNo, questNo)
    if nil ~= questInfo and false == questInfo:isNormalQuest() then
      return
    end
  end
  local questList = ToClient_GetQuestList()
  if true == questList:isMainQuestClearAll() then
    Panel_Widget_MainQuest_AbyssOne:SetIgnore(true)
    self._ui._static_TitleBG:SetShow(false)
    self:clearAll()
    self._ui._stc_NoQuest:SetShow(false)
    return
  end
  self:clearAll()
  local uiQuestInfo = questList:getMainQuestInfoByRegion(13)
  if nil ~= uiQuestInfo then
    self._mainQuestNo = uiQuestInfo:getQuestNo()
    self:setIconInfo(uiQuestInfo)
    self:setQuestTitleInfo(uiQuestInfo)
    local startPosY = self:setQuestGroupTitleInfo(uiQuestInfo)
    self:setConditionInfo(uiQuestInfo, startPosY)
    self:setButtonCheckState(uiQuestInfo)
    self._ui._stc_NoQuest:SetShow(false)
  else
    Panel_Widget_MainQuest_AbyssOne:SetIgnore(true)
    self._ui._static_TitleBG:SetShow(false)
    self._ui._stc_NoQuest:SetShow(true)
    self:clearAll()
  end
end
function mainQuestWidget:updateRenew(groupNo, questNo)
  if self._isInitialized == false then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) == true then
    Panel_Widget_MainQuest_AbyssOne:SetShow(false)
    return
  end
  local questListInfo = ToClient_GetQuestList()
  local mainQuestInfo = questListInfo:getMainQuestInfoByRegion(13)
  if mainQuestInfo == nil then
    return
  end
  local mainQuestNo = mainQuestInfo:getQuestNo()
  if mainQuestNo._group ~= groupNo or mainQuestNo._quest ~= questNo then
    return
  end
  if groupNo ~= nil and questNo ~= nil then
    local questInfo = ToClient_GetQuestInfo(groupNo, questNo)
    if questInfo ~= nil and questInfo:isNormalQuest() == false then
      return
    end
  end
  if questListInfo:isMainQuestClearAll() == true then
    Panel_Widget_MainQuest_AbyssOne:SetShow(false)
    return
  end
  self:clearAll()
  if mainQuestInfo ~= nil then
    self._mainQuestNo = mainQuestInfo:getQuestNo()
    self:setIconInfo(mainQuestInfo)
    self:setQuestTitleInfo(mainQuestInfo)
    local startPosY = self:setQuestGroupTitleInfo(mainQuestInfo)
    self:setConditionInfo(mainQuestInfo, startPosY)
    self:setButtonCheckState(mainQuestInfo)
  else
    Panel_Widget_MainQuest_AbyssOne:SetIgnore(true)
    self._ui._static_TitleBG:SetShow(false)
    self._ui._stc_NoQuest:SetShow(true)
    self:clearAll()
  end
  return true
end
function PaGlobal_MainQuestWidget_CheckQuestNakMessage()
  local groupNo, questNo = AcquireQuestDirect_getLastQuestInfo()
  if nil == groupNo or nil == questNo then
    return false
  end
  local uiQuestInfo = mainQuestWidget._mainQuestNo
  if nil == uiQuestInfo or nil == uiQuestInfo._group or nil == uiQuestInfo._quest then
    return false
  end
  if groupNo == uiQuestInfo._group and questNo == uiQuestInfo._quest then
    AcquireQuestDirect_clearLastQuestInfo()
    return true
  end
  return false
end
function PaGlobal_MainQuestWidget_CheckQuestEffect()
  mainQuestWidget._ui._static_Quest_Type:EraseAllEffect()
  mainQuestWidget._ui._staticText_Quest_Title:EraseAllEffect()
  mainQuestWidget._ui._staticText_Quest_Title:AddEffect("fUI_NewTitle_01B")
end
function mainQuestWidget:clearAll()
  self._ui._staticText_Quest_Title:SetShow(false)
  self._ui._static_Eff_Complete_Eff1:SetShow(false)
  self._ui._static_Quest_Type:SetShow(false)
  self._ui._staticText_WidgetGroupTitle:SetShow(false)
  self._ui._staticText_Quest_ClearNpc:SetShow(false)
  self._ui._staticText_Quest_Demand:SetShow(false)
  for index = 0, self._config._maxConditionCount - 1 do
    if nil ~= self._uiQuestConditions[index] then
      self._uiQuestConditions[index]:SetText("")
      self._uiQuestConditions[index]:SetIgnore(true)
      self._uiQuestConditions[index]:SetShow(false)
    end
  end
  self._isButtonOn = false
  self._mainQuestNo = nil
  self:clearConditionInfo()
end
function mainQuestWidget:getQuestTitle(uiQuestInfo)
  local questTitle = uiQuestInfo:getTitle()
  return questTitle
end
function mainQuestWidget:setQuestTitleInfo(uiQuestInfo)
  local questTitle = self:getQuestTitle(uiQuestInfo)
  local isAccepted = 1
  if not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing then
    isAccepted = 0
  end
  self._ui._staticText_Quest_Title:SetAutoResize(true)
  self._ui._staticText_Quest_Title:SetTextMode(__eTextMode_LimitText)
  self._ui._staticText_Quest_Title:SetSize(200, self._ui._staticText_Quest_Title:GetSizeY())
  if 0 == isAccepted then
    self._ui._staticText_Quest_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_NOTACCEPTTITLE", "title", questTitle))
  else
    self._ui._staticText_Quest_Title:SetText(questTitle)
  end
  Panel_Widget_MainQuest_AbyssOne:SetIgnore(false)
  self._ui._static_TitleBG:SetShow(true)
  self._ui._staticText_Quest_Title:SetLineRender(false)
  self._ui._staticText_Quest_Title:SetShow(true)
  self._ui._staticText_Quest_Title:SetIgnore(true)
  self._ui._staticText_Quest_Title:SetFontColor(Defines.Color.C_FFEFEFEF)
  local questNo = uiQuestInfo:getQuestNo()
  local questStaticStatus = questList_getQuestStatic(questNo._group, questNo._quest)
  local checkCondition
  if true == uiQuestInfo:isSatisfied() then
    checkCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  elseif 0 == isAccepted then
    checkCondition = QuestConditionCheckType.eQuestConditionCheckType_NotAccept
  else
    checkCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  local groupTitle = "nil"
  local questGroupCnt = 0
  local questListInfo = ToClient_GetQuestList()
  local uiQuestGroupInfo = questListInfo:getQuestGroup(questNo)
  if nil ~= uiQuestGroupInfo then
    groupTitle = uiQuestGroupInfo:getTitle()
    questGroupCnt = uiQuestGroupInfo:getTotalQuestCount()
  end
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_LUp", "HandleClicked_ShowMainQuestDetail( " .. questNo._group .. ", " .. questNo._quest .. ", " .. checkCondition .. ", \"" .. groupTitle .. "\", " .. questGroupCnt .. ", " .. isAccepted .. " )")
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_RUp", "HandleClicked_MainQuest_FindWay( " .. questNo._group .. ", " .. questNo._quest .. ", " .. checkCondition .. ", false ," .. isAccepted .. ", \"GroupBG\" )")
  self._ui._staticText_Quest_ClearNpc:addInputEvent("Mouse_LUp", "HandleClicked_ShowMainQuestDetail( " .. questNo._group .. ", " .. questNo._quest .. ", " .. checkCondition .. ", \"" .. groupTitle .. "\", " .. questGroupCnt .. ", " .. isAccepted .. " )")
  self._ui._staticText_Quest_ClearNpc:addInputEvent("Mouse_RUp", "HandleClicked_MainQuest_FindWay( " .. questNo._group .. ", " .. questNo._quest .. ", " .. checkCondition .. ", false ," .. isAccepted .. ", \"GroupBG\" )")
  self._ui._static_TitleBG:addInputEvent("Mouse_On", "HandleMouseOver_MainQuestWidget( true," .. isAccepted .. ")")
  self._ui._static_TitleBG:addInputEvent("Mouse_Out", "HandleMouseOver_MainQuestWidget( false," .. isAccepted .. ")")
  self._ui._staticText_Quest_ClearNpc:addInputEvent("Mouse_On", "HandleMouseOver_MainQuestWidget( true," .. isAccepted .. ")")
  self._ui._staticText_Quest_ClearNpc:addInputEvent("Mouse_Out", "HandleMouseOver_MainQuestWidget( false," .. isAccepted .. ")")
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_On", "HandleMouseOver_MainQuestWidget( true," .. isAccepted .. ")")
  Panel_Widget_MainQuest_AbyssOne:addInputEvent("Mouse_Out", "HandleMouseOver_MainQuestWidget( false," .. isAccepted .. ")")
  local posCount = questStaticStatus:getQuestPositionCount()
  local enable = false == uiQuestInfo:isSatisfied() and 0 ~= posCount
  enable = true
end
function mainQuestWidget:setIconInfo(uiQuestInfo)
  self._ui._static_Quest_Type:EraseAllEffect()
  self._ui._static_Quest_Type:SetShow(true)
  self._ui._static_Quest_Type:SetIgnore(true)
  ToClient_ChangeQuestIconByQuestType(self._ui._static_Quest_Type, uiQuestInfo:getQuestType())
end
function mainQuestWidget:setConditionInfo(uiQuestInfo, startPosY)
  self:clearConditionInfo()
  local checkCondition
  if true == uiQuestInfo:isSatisfied() then
    checkCondition = 0
  else
    checkCondition = 1
  end
  local uiQuestCondition
  self._ui._staticText_Quest_ClearNpc:SetLineRender(false)
  if not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing then
    self._ui._staticText_Quest_ClearNpc:SetTextMode(__eTextMode_LimitText)
    self._ui._staticText_Quest_ClearNpc:SetText(" " .. PAGetString(Defines.StringSheet_GAME, "LUA_MAINQUEST_ACCEPT_NOTICE"))
    self._ui._staticText_Quest_ClearNpc:SetFontColor(Defines.Color.C_FFC4BEBE)
    self._ui._staticText_Quest_ClearNpc:SetPosY(startPosY)
    self._ui._staticText_Quest_ClearNpc:SetShow(true)
    startPosY = startPosY + self._ui._staticText_Quest_ClearNpc:GetSizeY() + 2
  elseif 1 == checkCondition then
    for conditionIndex = 0, uiQuestInfo:getDemandCount() - 1 do
      local conditionInfo = uiQuestInfo:getDemandAt(conditionIndex)
      uiQuestCondition = self._uiQuestConditions[conditionIndex]
      uiQuestCondition:SetAutoResize(true)
      uiQuestCondition:SetTextMode(__eTextMode_AutoWrap)
      uiQuestCondition:SetFontColor(Defines.Color.C_FFC4BEBE)
      uiQuestCondition:SetPosY(startPosY)
      uiQuestCondition:SetSize(self._ui._static_TitleBG:GetSizeX(), uiQuestCondition:GetTextSizeY())
      local conditionText
      if conditionInfo._currentCount == conditionInfo._destCount or conditionInfo._destCount <= conditionInfo._currentCount then
        uiQuestCondition:SetTextMode(__eTextMode_LimitText)
        uiQuestCondition:SetLineCount(1)
        conditionText = " - " .. conditionInfo._desc .. " (" .. PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_COMPLETE") .. ")"
        uiQuestCondition:SetText(ToClient_getReplaceDialog(conditionText))
        uiQuestCondition:SetLineRender(true)
        uiQuestCondition:SetFontColor(Defines.Color.C_FF626262)
      elseif 1 == conditionInfo._destCount then
        conditionText = " - " .. conditionInfo._desc
        uiQuestCondition:SetText(ToClient_getReplaceDialog(conditionText))
        uiQuestCondition:SetLineRender(false)
      else
        conditionText = " - " .. conditionInfo._desc .. " (" .. conditionInfo._currentCount .. "/" .. conditionInfo._destCount .. ")"
        uiQuestCondition:SetText(ToClient_getReplaceDialog(conditionText))
        uiQuestCondition:SetLineRender(false)
      end
      uiQuestCondition:SetShow(true)
      uiQuestCondition:SetIgnore(true)
      startPosY = startPosY + uiQuestCondition:GetSizeY() + 2
    end
  elseif 0 == checkCondition then
    local currentSeasonUIType = ToClient_GetCurrentSeasonUIType()
    if __eSeasonUIType_Summer ~= currentSeasonUIType then
      self._ui._static_Quest_Type:AddEffect("UI_Quest_Complete_GoldAura", true, 130, 0)
    end
    self._ui._staticText_Quest_ClearNpc:SetTextMode(__eTextMode_LimitText)
    self._ui._staticText_Quest_ClearNpc:SetPosY(startPosY)
    if true == uiQuestInfo:isCompleteBlackSpirit() then
      self._ui._staticText_Quest_ClearNpc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTCOMPLETE_DESC"))
    else
      self._ui._staticText_Quest_ClearNpc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "QUESTLIST_COMPLETETARGET", "getCompleteDisplay", uiQuestInfo:getCompleteDisplay()))
    end
    self._ui._staticText_Quest_ClearNpc:SetFontColor(4291617922)
    self._ui._staticText_Quest_ClearNpc:SetShow(true)
    FGlobal_ChangeOnTextureForDialogQuestCompleteIcon(self._ui._static_Quest_Type)
    startPosY = startPosY + self._ui._staticText_Quest_ClearNpc:GetSizeY() + 2
    FGlobal_QuestWidget_AutoReleaseNavi(uiQuestInfo)
    if false == uiQuestInfo:isCompleteBlackSpirit() then
      local mainQuestNo = uiQuestInfo:getQuestNo()
      local questGroupId = mainQuestNo._group
      local questId = mainQuestNo._quest
      local condition = 0
      local questStaticStatus = questList_getQuestStatic(questGroupId, questId)
      if nil ~= questStaticStatus and true == questStaticStatus:isGuideForce() then
        if false == (questGroupId == self._mainQuestNavi._groupNo and questId == self._mainQuestNavi._questNo) then
          _QuestWidget_FindTarget_DrawMapPath(questGroupId, questId, condition, false)
          self._mainQuestNavi._groupNo = questGroupId
          self._mainQuestNavi._questNo = questId
        end
      end
    end
  end
  Panel_Widget_MainQuest_AbyssOne:SetSize(Panel_Widget_MainQuest_AbyssOne:GetSizeX(), startPosY + 10)
  _static_active:SetSize(Panel_Widget_MainQuest_AbyssOne:GetSizeX(), startPosY + 10)
  self._ui._stc_bottomLine:ComputePos()
end
function mainQuestWidget:showClearedTooltip(isMouseOver)
  if false == self._ui._staticText_Quest_ClearNpc:IsLimitText() then
    return
  end
  if true == isMouseOver then
    TooltipSimple_Show(self._ui._staticText_Quest_ClearNpc, "", self._ui._staticText_Quest_ClearNpc:GetText())
  else
    TooltipSimple_Hide()
  end
end
function mainQuestWidget:setButtonCheckState(uiQuestInfo)
  local questNo = uiQuestInfo:getQuestNo()
end
function mainQuestWidget:setButtonState(isMouseOver)
end
function HandleClicked_ShowMainQuestDetail(groupId, questId, checkCondition, groupTitle, questGroupCount, isAccepted)
  if false == _static_active:GetShow() then
    return
  end
  local fromQuestWidget = true
  PaGlobalFunc_Quest_All_Open()
  PaGlobalFunc_QuestInfo_All_Detail(groupId, questId, checkCondition, groupTitle, questGroupCount, true, nil, nil, nil, isAccepted)
  HandleEventLUp_Quest_All_SetTabMenu(PaGlobal_Quest_All._TABTYPE.MAIN)
  audioPostEvent_SystemUi(0, 0)
end
function HandleClicked_MainQuest_FindWay(gruopNo, questNo, questCondition, isAuto, checkFindWay, control)
  if false == _static_active:GetShow() then
    return
  end
  local self = mainQuestWidget
  if checkFindWay == 0 then
    local checkFindWay = ToClient_isFindWayPossibleQuest(gruopNo, questNo)
    if false == checkFindWay then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MAINQUEST_CHECH_CONDITION_NOTICE"))
      return
    end
  end
  PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
end
function mainQuestWidget:showAcceptConditionTooltip(show)
  if true == show then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_ACCEPTCONDITION")
    local questList = ToClient_GetQuestList()
    local uiQuestInfo = questList:getMainQuestInfoByRegion(13)
    if nil ~= uiQuestInfo then
      local desc = uiQuestInfo:getAcceptConditionText()
      registTooltipControl(Panel_Widget_MainQuest_AbyssOne, Panel_Tooltip_SimpleText)
      TooltipSimple_Show(Panel_Widget_MainQuest_AbyssOne, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function mainQuestWidget:clearConditionInfo()
  self._ui._staticText_Quest_ClearNpc:SetShow(false)
  self._ui._staticText_Quest_ClearNpc:SetText("")
  for index = 0, self._config._maxConditionCount - 1 do
    self._uiQuestConditions[index]:SetShow(false)
    self._uiQuestConditions[index]:SetText("")
  end
  if false == self._isBlabla then
    self._ui._mouseR:SetShow(false)
    self._ui._clearNpcEffect:SetShow(false)
    self._ui._clearNpcEffect2:SetShow(false)
  end
end
function mainQuestWidget:ShowGroupBG(show)
end
function mainQuestWidget:isHitTest(control)
  local panel = Panel_Widget_MainQuest_AbyssOne
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = panel:GetPosX()
  local panelPosY = panel:GetPosY()
  local bgPosX = panelPosX
  local bgPosY = panelPosY
  local bgSizeX = panel:GetSizeX()
  local bgSizeY = panel:GetSizeY()
  if mousePosX >= bgPosX and mousePosX <= bgPosX + bgSizeX and mousePosY >= bgPosY and mousePosY <= bgPosY + bgSizeY then
    return true
  end
  return false
end
function mainQuestWidget:setTooltipPos(posY)
end
function mainQuestWidget:isShownQuest(questNo)
  local uiQuestInfo = self._mainQuestNo
  if nil ~= uiQuestInfo then
    if uiQuestInfo._group == questNo._group and uiQuestInfo._quest == questNo._quest then
      return true
    else
      return false
    end
  end
  return false
end
function HandleMouseOver_Button(show, target)
  if false == _static_active:GetShow() then
    return
  end
  mainQuestWidget:mouseOverToButton(show, target)
end
function mainQuestWidget:mouseOverToButton(show, target)
end
function mainQuestWidget:Common_WidgetMouseOut()
  if CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode ~= UI.Get_ProcessorInputMode() then
    local panelPosX = Panel_Widget_MainQuest_AbyssOne:GetPosX()
    local panelPosY = Panel_Widget_MainQuest_AbyssOne:GetPosY()
    local panelSizeX = Panel_Widget_MainQuest_AbyssOne:GetSizeX()
    local panelSizeY = Panel_Widget_MainQuest_AbyssOne:GetSizeY()
    local mousePosX = getMousePosX()
    local mousePosY = getMousePosY()
    if panelPosX < mousePosX and mousePosX < panelPosX + panelSizeX and panelPosY < mousePosY and mousePosY < panelPosY + panelSizeY then
      return false
    end
  end
  return true
end
function PaGlobalFunc_MainQuestWidget_MouseOnEvent()
  if nil == _static_active or false == _static_active:GetShow() then
    return
  end
  if nil ~= PaGlobal_CheckedQuest_UpdateBackSpaceQuest then
    PaGlobal_CheckedQuest_UpdateBackSpaceQuest()
  end
end
function PaGlobalFunc_MainQuestWidget_MouseOutEvent()
  if false == _static_active:GetShow() then
    return
  end
  mainQuestWidget:Common_HideTooltip()
end
function mainQuestWidget:Common_HideTooltip()
  if false == Panel_Widget_MainQuest_AbyssOne:GetShow() then
    return
  end
  if true == self:Common_WidgetMouseOut() and true == self._isButtonOn then
    self:mouseOverToButton(false)
  end
end
local isMouseOnWidget = false
function HandleMouseOver_MainQuestWidget(isMouseOver, isAcceptedQuest)
  if false == _static_active:GetShow() then
    return
  end
  mainQuestWidget:mouseOverToMaindQuestWidget(isMouseOver, isAcceptedQuest)
end
function mainQuestWidget:mouseOverToMaindQuestWidget(isMouseOver, isAcceptedQuest)
  if true == self._isButtonOn then
    return
  end
  if true == isMouseOver then
    isMouseOnWidget = true
  else
    local isMouseOn = self:Common_WidgetMouseOut() == false
    if nil ~= PaGlobal_CheckedQuest_UpdateBackSpaceQuest then
      PaGlobal_CheckedQuest_UpdateBackSpaceQuest()
    end
    if true == self:isHitTest(Panel_Widget_MainQuest_AbyssOne) then
      return
    end
    isMouseOnWidget = false
    self:showAcceptConditionTooltip(false)
  end
  self:showClearedTooltip(isMouseOver)
  if 0 == isAcceptedQuest then
    self:showAcceptConditionTooltip(isMouseOver)
  end
end
function PaGlobalFunc_MainQuestWidget_IsShownQuest(questNo)
  return mainQuestWidget:isShownQuest(questNo)
end
function PaGlobalFunc_MainQuestWidget_GetClosableLevel()
  return mainQuestWidget._config._closableLevel
end
function PaGlobalFunc_MainQuestWidget_GetMainQuestNo()
  return mainQuestWidget._mainQuestNo
end
function PaGlobalFunc_MainQuestWidget_CheckPosition()
  if nil == Panel_Radar or false == Panel_Radar:GetShow() then
    return
  end
  local Rect1 = {}
  local Rect2 = {}
  Rect1.left = Panel_Radar:GetPosX()
  Rect1.top = Panel_Radar:GetPosY()
  Rect1.right = Rect1.left + Panel_Radar:GetSizeX()
  Rect1.bottom = Rect1.top + Panel_Radar:GetSizeY()
  Rect2.left = Panel_Widget_MainQuest_AbyssOne:GetPosX()
  Rect2.top = Panel_Widget_MainQuest_AbyssOne:GetPosY()
  Rect2.right = Rect2.left + Panel_Widget_MainQuest_AbyssOne:GetSizeX()
  Rect2.bottom = Rect2.top + Panel_Widget_MainQuest_AbyssOne:GetSizeY()
  if Rect1.left < Rect2.right and Rect1.top < Rect2.bottom and Rect1.right > Rect2.left and Rect1.bottom > Rect2.top then
    Panel_Widget_MainQuest_AbyssOne:SetPosY(Rect1.bottom + 5)
  end
end
function PaGlobalFunc_MainQuestWidget_CheckPosition_AbyssOneTitle()
  if nil == Panel_Window_AbyssOneInfo or false == Panel_Window_AbyssOneInfo:GetShow() then
    return
  end
  local Rect1 = {}
  local Rect2 = {}
  Rect1.left = Panel_Window_AbyssOneInfo:GetPosX()
  Rect1.top = Panel_Window_AbyssOneInfo:GetPosY()
  Rect1.right = Rect1.left + Panel_Window_AbyssOneInfo:GetSizeX()
  Rect1.bottom = Rect1.top + Panel_Window_AbyssOneInfo:GetSizeY() + PaGlobal_AbyssOneInfo._ui._stc_descText:GetTextSizeY()
  Rect2.left = Panel_Widget_MainQuest_AbyssOne:GetPosX()
  Rect2.top = Panel_Widget_MainQuest_AbyssOne:GetPosY()
  Rect2.right = Rect2.left + Panel_Widget_MainQuest_AbyssOne:GetSizeX()
  Rect2.bottom = Rect2.top + Panel_Widget_MainQuest_AbyssOne:GetSizeY()
  if Rect1.left < Rect2.right and Rect1.top < Rect2.bottom and Rect1.right > Rect2.left and Rect1.bottom > Rect2.top then
    Panel_Widget_MainQuest_AbyssOne:SetPosY(Rect1.bottom + 5)
  end
end
function FromClient_MainQuestWidget_ResetPosition()
  local relativePosX = Panel_Widget_MainQuest_AbyssOne:GetRelativePosX()
  local relativePosY = Panel_Widget_MainQuest_AbyssOne:GetRelativePosY()
  local panelSizeX = Panel_Widget_MainQuest_AbyssOne:GetSizeX()
  local panelSizeY = Panel_Widget_MainQuest_AbyssOne:GetSizeY()
  if relativePosX == -1 and relativePosY == -1 then
    local initPosX = getScreenSizeX() - panelSizeX - 16
    local initPosY = PaGlobalFunc_AbyssOneInfo_GetPosY() + PaGlobalFunc_AbyssOneInfo_GetSizeY() + 10
    Panel_Widget_MainQuest_AbyssOne:SetPosX(initPosX)
    Panel_Widget_MainQuest_AbyssOne:SetPosY(initPosY)
    FGlobal_InitPanelRelativePos(Panel_Widget_MainQuest_AbyssOne, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_Widget_MainQuest_AbyssOne:SetPosX(getScreenSizeX() - panelSizeX - 16)
    Panel_Widget_MainQuest_AbyssOne:SetPosY(PaGlobalFunc_AbyssOneInfo_GetPosY() + PaGlobalFunc_AbyssOneInfo_GetSizeY() + 10)
  else
    local originalPosX = (getScreenSizeX() * relativePosX * 2 - panelSizeX) / 2
    local originalPosY = (getScreenSizeY() * relativePosY * 2 - panelSizeY) / 2
    Panel_Widget_MainQuest_AbyssOne:SetPosX(originalPosX)
    Panel_Widget_MainQuest_AbyssOne:SetPosY(originalPosY)
  end
  Panel_Widget_MainQuest_AbyssOne:SetShow(true)
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_MainQuest_AbyssOne)
  if true == Panel_Widget_MainQuest_AbyssOne:GetShow() then
    FGlobal_MainQuest_Update()
  end
  PaGlobalFunc_MainQuestWidget_CheckPosition()
  PaGlobalFunc_MainQuestWidget_CheckPosition_AbyssOneTitle()
  PaGlobalFunc_Quest_UpdatePosition()
end
function FGlobal_QuestWidget_CalcScrollButtonSize()
end
function FromClient_luaLoadComplete_MainQuest()
  mainQuestWidget:initialize()
end
function renderModeChange_Panel_Widget_MainQuest_AbyssOne_ResetPosition(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  FromClient_MainQuestWidget_ResetPosition()
end
function mainQuestWidget:registEventHandler()
  registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_MainQuest")
  registerEvent("onScreenResize", "FromClient_MainQuestWidget_ResetPosition")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_MainQuestWidget_ResetPosition")
  registerEvent("FromClient_RenderModeChangeState", "renderModeChange_Panel_Widget_MainQuest_AbyssOne_ResetPosition")
end
function PaGlobal_MainQuest_SetShowControl(isShow)
  _static_active:SetShow(isShow)
end
function PaGlobal_MainQuestWidget_TopQuestGuide_Open()
  local self = mainQuestWidget
  local uiQuestInfo = ToClient_GetQuestList():getMainQuestInfoByRegion()
  if nil ~= uiQuestInfo and true == PaGlobal_MainQuestWidget_IsCorrectQuest(uiQuestInfo) then
    self._isQuestGuide = true
    PaGlobal_MainQuestWidget_TopQuestGuide_Close()
  end
end
function PaGlobal_MainQuestWidget_TopQuestGuide_Close()
  local self = mainQuestWidget
end
function PaGlobal_MainQuestWidget_IsCorrectQuest(questInfo)
  if nil == questInfo then
    return false
  end
  local groupId = questInfo:getQuestNo()._group
  if nil == groupId then
    return false
  end
  if false == (21001 == groupId or 21117 == groupId or 21112 == groupId) then
    if 1 == questInfo:getQuestNo()._quest and false == questInfo._isProgressing then
      return true
    else
      return false
    end
  end
  return false
end
mainQuestWidget:registEventHandler()
changePositionBySever(Panel_Widget_MainQuest_AbyssOne, CppEnums.PAGameUIType.PAGameUIPanel_Widget_MainQuest_AbyssOne, true, true, true)
