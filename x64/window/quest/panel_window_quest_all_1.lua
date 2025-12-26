function PaGlobal_Quest_All:initialize()
  if true == PaGlobal_Quest_All._initialize then
    return
  end
  PaGlobal_Quest_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Quest_All:ControlAll_Init()
  PaGlobal_Quest_All:ControlPc_Init()
  PaGlobal_Quest_All:ControlConsole_Init()
  PaGlobal_Quest_All:ControlSetShow()
  PaGlobal_Quest_All:registEventHandler()
  PaGlobal_Quest_All:validate()
  PaGlobal_Quest_All._initialize = true
  PaGlobal_Quest_All:initCreateControl()
  PaGlobal_Quest_All:resetGroupOpen()
  PaGlobal_Quest_All:favorTypeNationalCheck()
  PaGlobal_Quest_All:clearQuestLoadingTable()
end
function PaGlobal_Quest_All:ControlAll_Init()
  if nil == Panel_Window_Quest_All then
    return
  end
  local isAbyssOneLoading = ToClient_isMustAbyssOneLoading() == true and ToClient_isMagnusTeleportFlag() == false
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_Quest_All, "Static_TitleBG")
  self._ui.stc_contentBg = UI.getChildControl(Panel_Window_Quest_All, "Static_LineBG")
  self._ui.stc_radioButtonGroup = UI.getChildControl(Panel_Window_Quest_All, "Static_RadioButtonGroup")
  self._ui.radio_progressing = UI.getChildControl(self._ui.stc_radioButtonGroup, "RadioButton_TabProgressing")
  self._ui.radio_main = UI.getChildControl(self._ui.stc_radioButtonGroup, "RadioButton_Main")
  self._ui.radio_recommend = UI.getChildControl(self._ui.stc_radioButtonGroup, "RadioButton_TabImportant")
  self._ui.radio_repeat = UI.getChildControl(self._ui.stc_radioButtonGroup, "RadioButton_TabRepeat")
  self._ui.radio_new = UI.getChildControl(self._ui.stc_radioButtonGroup, "RadioButton_TabNewQuest")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_radioButtonGroup, "Static_SelectLine")
  self._ui.stc_groupTypeBG = UI.getChildControl(Panel_Window_Quest_All, "Static_GroupTypeBG")
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui.combo_questSearchType = UI.getChildControl(self._ui.stc_groupTypeBG, "Combobox_SearchType")
    self._ui.combo_questSortType = UI.getChildControl(self._ui.stc_groupTypeBG, "Combobox_QuestSortType")
    self._ui.stc_searchGroup = UI.getChildControl(self._ui.stc_groupTypeBG, "Static_Search")
    self._ui.edt_search = UI.getChildControl(self._ui.stc_searchGroup, "Edit_SearchText")
    self._ui.stc_searchFunction = UI.getChildControl(self._ui.stc_searchGroup, "Static_SearchFunction")
    self._ui.btn_searchUp = UI.getChildControl(self._ui.stc_searchFunction, "Button_Up")
    self._ui.btn_searchUpDisable = UI.getChildControl(self._ui.stc_searchFunction, "Button_Up_Disable")
    self._ui.btn_searchDown = UI.getChildControl(self._ui.stc_searchFunction, "Button_Down")
    self._ui.btn_searchDownDisable = UI.getChildControl(self._ui.stc_searchFunction, "Button_Down_Disable")
    self._ui.btn_searchPCUI = UI.getChildControl(self._ui.stc_searchFunction, "Button_BtnSearch_PCUI")
    self._ui.btn_searchReset = UI.getChildControl(self._ui.stc_searchFunction, "Button_Search_Reset")
    self._ui.txt_searchCount = UI.getChildControl(self._ui.stc_searchFunction, "StaticText_Search_Count")
  else
    self._ui.txt_questCnt = UI.getChildControl(self._ui.stc_groupTypeBG, "StaticText_QuestCount")
    self._ui.radio_questType = UI.getChildControl(self._ui.stc_groupTypeBG, "RadioButton_QuestType")
    self._ui.radio_questTerritory = UI.getChildControl(self._ui.stc_groupTypeBG, "RadioButton_Territory")
  end
  self._ui.chk_emptyGroupHide = UI.getChildControl(self._ui.stc_groupTypeBG, "CheckButton_EmptyGroupHide")
  self._ui.stc_groupFilterBg = UI.getChildControl(Panel_Window_Quest_All, "Static_ListFilterBG")
  self._ui.chk_complteHide = UI.getChildControl(self._ui.stc_groupFilterBg, "CheckButton_Complete")
  self._ui.btn_questBranch = UI.getChildControl(self._ui.stc_groupFilterBg, "Button_QuestBranch")
  self._ui._listGroup.stc_bg = UI.getChildControl(Panel_Window_Quest_All, "Static_GroupTitleBG")
  self._ui._listGroup.stc_icon = UI.getChildControl(self._ui._listGroup.stc_bg, "Static_QuestTypeIcon")
  self._ui._listGroup.txt_name = UI.getChildControl(self._ui._listGroup.stc_bg, "StaticText_QuestName")
  self._ui._listGroup.txt_percent = UI.getChildControl(self._ui._listGroup.stc_bg, "StaticText_CompletePercent")
  self._ui._listGroup.stc_loading = UI.getChildControl(self._ui._listGroup.stc_bg, "Static_Loading_Sequence")
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui._listGroup.stc_searchEffect = UI.getChildControl(self._ui._listGroup.stc_bg, "Static_GroupTitle_SearchEffect")
  end
  self._ui._listTemplate.stc_bg = UI.getChildControl(Panel_Window_Quest_All, "Static_ListMainBG")
  self._ui._listTemplate.chk_showWidget = UI.getChildControl(self._ui._listTemplate.stc_bg, "CheckButton_ShowWidget")
  self._ui._listTemplate.stc_icon = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_ListMain_QuestTypeIcon")
  self._ui._listTemplate.txt_name = UI.getChildControl(self._ui._listTemplate.stc_bg, "StaticText_ListMain_QuestName")
  self._ui._listTemplate.txt_remainTime = UI.getChildControl(self._ui._listTemplate.stc_bg, "StaticText_ListMain_Quest_RemainTime")
  self._ui._listTemplate.chk_autoNavi = UI.getChildControl(self._ui._listTemplate.stc_bg, "CheckButton_ListMain_AutoNavi")
  self._ui._listTemplate.stc_autoNavi = UI.getChildControl(self._ui._listTemplate.chk_autoNavi, "Static_3")
  self._ui._listTemplate.chk_questNavi = UI.getChildControl(self._ui._listTemplate.stc_bg, "Checkbox_ListMain_QuestNavi")
  self._ui._listTemplate.stc_questNavi = UI.getChildControl(self._ui._listTemplate.chk_questNavi, "Static_1")
  self._ui._listTemplate.chk_giveUp = UI.getChildControl(self._ui._listTemplate.stc_bg, "Checkbox_ListMain_QuestGiveup")
  self._ui._listTemplate.stc_giveUp = UI.getChildControl(self._ui._listTemplate.chk_giveUp, "Static_2")
  self._ui._listTemplate.chk_tag = UI.getChildControl(self._ui._listTemplate.stc_bg, "Checkbox_ListMain_QuestTag")
  self._ui._listTemplate.stc_tag = UI.getChildControl(self._ui._listTemplate.chk_tag, "Static_4")
  self._ui._listTemplate.txt_completeCnt = UI.getChildControl(self._ui._listTemplate.stc_bg, "StaticText_ListMain_GroupCompleteCount")
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui._listTemplate.stc_searchEffect = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_ListMain_SearchEffect")
  end
  self._ui._listScroll.stc_bg = UI.getChildControl(Panel_Window_Quest_All, "Scroll_CheckQuestList")
  self._ui._listScroll.btn_Up = UI.getChildControl(self._ui._listScroll.stc_bg, "Scroll_UpButton")
  self._ui._listScroll.btn_Down = UI.getChildControl(self._ui._listScroll.stc_bg, "Scroll_DownButton")
  self._ui._listScroll.btn_Ctrl = UI.getChildControl(self._ui._listScroll.stc_bg, "Scroll_CtrlButton")
  self._ui.stc_favorTypeBg = UI.getChildControl(Panel_Window_Quest_All, "Static_FavorLineBG")
  self._ui.txt_favorType = UI.getChildControl(self._ui.stc_favorTypeBg, "StaticText_FavorType")
  self._ui.stc_DoneQuestBg = UI.getChildControl(Panel_Window_Quest_All, "Static_QuestCountBg")
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui.txt_questCnt = UI.getChildControl(self._ui.stc_DoneQuestBg, "StaticText_QuestCount")
  end
  self._ui.txt_DoneQuest = UI.getChildControl(self._ui.stc_DoneQuestBg, "StaticText_TotalQuestTitle")
  self._ui.txt_DoneQuest:SetTextMode(__eTextMode_LimitText)
  self._ui.stc_DoneDescCH = UI.getChildControl(self._ui.stc_contentBg, "MultilineText_Noquest")
  self._ui.stc_DoneDescCH:SetShow(false)
  self._radioTabs[self._TABTYPE.PROGRESS] = self._ui.radio_progressing
  self._radioTabs[self._TABTYPE.MAIN] = self._ui.radio_main
  self._radioTabs[self._TABTYPE.RECOMMEND] = self._ui.radio_recommend
  self._radioTabs[self._TABTYPE.REPEAT] = self._ui.radio_repeat
  self._radioTabs[self._TABTYPE.NEW] = self._ui.radio_new
  self._ui._favorType[__eQuestSelectType_Count] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_0")
  self._ui._favorType[__eQuestSelectType_Main] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_Main")
  self._ui._favorType[__eQuestSelectType_BlackSpirit] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_1")
  self._ui._favorType[__eQuestSelectType_Sub] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_2")
  self._ui._favorType[__eQuestSelectType_Adventure] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_3")
  self._ui._favorType[__eQuestSelectType_Life] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_4")
  self._ui._favorType[__eQuestSelectType_Contents] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_5")
  self._ui._favorType[__eQuestSelectType_Event] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_6")
  self._ui._favorType[__eQuestSelectType_Etc] = UI.getChildControl(self._ui.stc_favorTypeBg, "CheckButton_FavorType_7")
  for key, value in ipairs(self._radioTabs) do
    if nil ~= value then
      value:SetTextMode(__eTextMode_AutoWrap)
      value:SetText(value:GetText())
    end
  end
  self._ui._listGroup.stc_bg:SetShow(false)
  self._ui._listTemplate.stc_bg:SetShow(false)
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui.combo_questSortType:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_QUESTTYPE"))
    self._ui.combo_questSortType:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_ZONE"))
    self._ui.combo_questSortType:SetSelectItemIndex(1)
    self._searchData.isSortByTerritory = true
    self._ui.combo_questSearchType:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_SEARCH_TYPE_ALL"))
    self._ui.combo_questSearchType:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_SEARCH_TYPE_NAME"))
    self._ui.combo_questSearchType:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_SEARCH_TYPE_ITEMNAME"))
    self._ui.combo_questSearchType:SetSelectItemIndex(0)
  else
    self._ui.radio_questTerritory:SetCheck(true)
    self._ui.radio_questType:SetCheck(false)
    self._searchData.isSortByTerritory = true
  end
  self._ui.chk_emptyGroupHide:SetCheck(true)
  self._ui.chk_complteHide:SetCheck(true)
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui.chk_complteHide:SetTextMode(__eTextMode_LimitText)
    self._ui.chk_complteHide:SetText(self._ui.chk_complteHide:GetText())
    UI.setLimitTextAndAddTooltip(self._ui.chk_complteHide, self._ui.chk_complteHide:GetText())
    self._ui.chk_complteHide:SetEnableArea(0, 0, self._ui.chk_complteHide:GetSizeY() + self._ui.chk_complteHide:GetTextSizeX() + 10, self._ui.chk_complteHide:GetSizeY())
    self._ui.chk_emptyGroupHide:SetEnableArea(0, 0, 2 * self._ui.chk_emptyGroupHide:GetSizeX() + 10, self._ui.chk_emptyGroupHide:GetSizeY())
  else
    self._ui.chk_complteHide:SetEnableArea(0, 0, self._ui.chk_complteHide:GetSizeX() + self._ui.chk_complteHide:GetTextSizeX() + 10, self._ui.chk_complteHide:GetSizeY())
    self._ui.chk_emptyGroupHide:SetEnableArea(0, 0, self._ui.chk_emptyGroupHide:GetSizeX() + self._ui.chk_emptyGroupHide:GetTextSizeX() + 10, self._ui.chk_emptyGroupHide:GetSizeY())
  end
  self._currentTab = self._TABTYPE.PROGRESS
  self._currentSearchType = self._SEARCHTYPE.ALL
end
function PaGlobal_Quest_All:ControlPc_Init()
  if nil == Panel_Window_Quest_All then
    return
  end
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.chk_popUp = UI.getChildControl(self._ui.stc_titleBg, "CheckButton_PopUp")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
end
function PaGlobal_Quest_All:ControlConsole_Init()
  if nil == Panel_Window_Quest_All then
    return
  end
  self._ui_console.stc_menuGuideLB = UI.getChildControl(self._ui.stc_radioButtonGroup, "Static_KeyGuide_LB_ConsoleUI")
  self._ui_console.stc_menuGuideRB = UI.getChildControl(self._ui.stc_radioButtonGroup, "Static_KeyGuide_RB_ConsoleUI")
  self._ui_console.stc_keyGuideBG = UI.getChildControl(Panel_Window_Quest_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_guideSortType = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui_console.stc_guideHideEmpty = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui_console.stc_guideSelect = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui_console.stc_guideClose = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui_console.stc_guidePreferRT = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_KeyGuide_RT_ConsoleUI")
  self._ui_console.stc_guidePreferPlus = UI.getChildControl(self._ui_console.stc_guidePreferRT, "StaticText_KeyGuide_Plus_ConsoleUI")
  self._ui_console.stc_guidePreferY = UI.getChildControl(self._ui_console.stc_guidePreferRT, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui_console._focusMenu.stc_focusBg = UI.getChildControl(Panel_Window_Quest_All, "Static_FocusBg_ConsoleUI")
  self._ui_console._focusMenu.radio_autoNavi = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_AutoNavi")
  self._ui_console._focusMenu.radio_questNavi = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_QuestNavi")
  self._ui_console._focusMenu.radio_giveUp = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_QuestGiveUp")
  self._ui_console._focusMenu.radio_detail = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_ShowDetail")
  self._ui_console._focusMenu.radio_blackSpirit = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_CallBlackSpirit")
  self._ui_console._focusMenu.radio_tag = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "RadioButton_QuestTag")
  self._ui_console._focusMenu.stc_Confirm = UI.getChildControl(self._ui_console._focusMenu.stc_focusBg, "StaticText_Confirm")
end
function PaGlobal_Quest_All:initCreateControl()
  if nil == Panel_Window_Quest_All then
    return
  end
  local isAbyssOneLoading = ToClient_isMustAbyssOneLoading() == true and ToClient_isMagnusTeleportFlag() == false
  for slotIdx = 0, self._config.slotMaxCount - 1 do
    local groupSlot = {}
    local baseGroupControl = self._ui._listGroup.stc_bg
    groupSlot.bg = UI.createAndCopyBasePropertyControl(Panel_Window_Quest_All, "Static_GroupTitleBG", self._ui.stc_contentBg, "QuestWindow_GroupTitleBG_" .. slotIdx)
    groupSlot.typeIcon = UI.createAndCopyBasePropertyControl(baseGroupControl, "Static_QuestTypeIcon", groupSlot.bg, "QuestWindow_GroupTypeIcon_" .. slotIdx)
    groupSlot.name = UI.createAndCopyBasePropertyControl(baseGroupControl, "StaticText_QuestName", groupSlot.bg, "QuestWindow_GroupName_" .. slotIdx)
    groupSlot.completePercent = UI.createAndCopyBasePropertyControl(baseGroupControl, "StaticText_CompletePercent", groupSlot.bg, "QuestWindow_GroupCompletePercent_" .. slotIdx)
    groupSlot.loading = UI.createAndCopyBasePropertyControl(baseGroupControl, "Static_Loading_Sequence", groupSlot.bg, "QuestWindow_GroupLoading_" .. slotIdx)
    if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
      groupSlot.searchEffect = UI.createAndCopyBasePropertyControl(baseGroupControl, "Static_GroupTitle_SearchEffect", groupSlot.bg, "QuestWindow_GroupSearchEffect_" .. slotIdx)
    end
    groupSlot.bg:ComputePos()
    groupSlot.bg:SetPosY(slotIdx * (groupSlot.bg:GetSizeY() + 5) + 45)
    groupSlot.bg:SetShow(true)
    groupSlot.bg:SetIgnore(false)
    groupSlot.name:SetTextMode(__eTextMode_LimitText)
    groupSlot.loading:SetShow(false)
    groupSlot.bg:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    groupSlot.bg:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    groupSlot.typeIcon:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    groupSlot.typeIcon:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    groupSlot.name:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    groupSlot.name:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    groupSlot.completePercent:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    groupSlot.completePercent:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    groupSlot.loading:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    groupSlot.loading:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    self._uiPool.groupTitle[slotIdx] = groupSlot
    local listSlot = {}
    local baseListControl = self._ui._listTemplate.stc_bg
    listSlot.bg = UI.createAndCopyBasePropertyControl(Panel_Window_Quest_All, "Static_ListMainBG", self._ui.stc_contentBg, "QuestWindow_ListMainBG_" .. slotIdx)
    listSlot.showBtn = UI.createAndCopyBasePropertyControl(baseListControl, "CheckButton_ShowWidget", listSlot.bg, "QuestWindow_ListShowWidgetBtn_" .. slotIdx)
    listSlot.typeIcon = UI.createAndCopyBasePropertyControl(baseListControl, "Static_ListMain_QuestTypeIcon", listSlot.bg, "QuestWindow_ListTypeIcon_" .. slotIdx)
    listSlot.name = UI.createAndCopyBasePropertyControl(baseListControl, "StaticText_ListMain_QuestName", listSlot.bg, "QuestWindow_ListQuestName_" .. slotIdx)
    listSlot.remainTime = UI.createAndCopyBasePropertyControl(baseListControl, "StaticText_ListMain_Quest_RemainTime", listSlot.bg, "QuestWindow_ListQuestRemainTime_" .. slotIdx)
    listSlot.btnAuto = UI.createAndCopyBasePropertyControl(baseListControl, "CheckButton_ListMain_AutoNavi", listSlot.bg, "QuestWindow_ListAutoNavi_" .. slotIdx)
    listSlot.btnNavi = UI.createAndCopyBasePropertyControl(baseListControl, "Checkbox_ListMain_QuestNavi", listSlot.bg, "QuestWindow_ListNavi_" .. slotIdx)
    listSlot.btnGiveUp = UI.createAndCopyBasePropertyControl(baseListControl, "Checkbox_ListMain_QuestGiveup", listSlot.bg, "QuestWindow_ListGiveup_" .. slotIdx)
    listSlot.btnTag = UI.createAndCopyBasePropertyControl(baseListControl, "Checkbox_ListMain_QuestTag", listSlot.bg, "QuestWindow_ListTag_" .. slotIdx)
    listSlot.completeCount = UI.createAndCopyBasePropertyControl(baseListControl, "StaticText_ListMain_GroupCompleteCount", listSlot.bg, "QuestWindow_ListCompleteCount_" .. slotIdx)
    if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
      listSlot.searchEffect = UI.createAndCopyBasePropertyControl(baseListControl, "Static_ListMain_SearchEffect", listSlot.bg, "QuestWindow_ListSearchEffect_" .. slotIdx)
    end
    local stc_autoNavi = UI.createAndCopyBasePropertyControl(self._ui._listTemplate.chk_autoNavi, "Static_3", listSlot.btnAuto, "QuestWindow_ListCheckIcon_" .. slotIdx)
    local stc_questNavi = UI.createAndCopyBasePropertyControl(self._ui._listTemplate.chk_questNavi, "Static_1", listSlot.btnNavi, "QuestWindow_ListCheckIcon_" .. slotIdx)
    local stc_giveUp = UI.createAndCopyBasePropertyControl(self._ui._listTemplate.chk_giveUp, "Static_2", listSlot.btnGiveUp, "QuestWindow_ListCheckIcon_" .. slotIdx)
    local stc_tag = UI.createAndCopyBasePropertyControl(self._ui._listTemplate.chk_tag, "Static_4", listSlot.btnTag, "QuestWindow_ListCheckIcon_" .. slotIdx)
    listSlot.bg:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.bg:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.showBtn:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.showBtn:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.typeIcon:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.typeIcon:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.name:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.name:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.remainTime:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.remainTime:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.btnAuto:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.btnAuto:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.btnNavi:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.btnNavi:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.btnGiveUp:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.btnGiveUp:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.btnTag:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.btnTag:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.completeCount:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    listSlot.completeCount:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    listSlot.btnAuto:addInputEvent("Mouse_On", "")
    listSlot.btnAuto:addInputEvent("Mouse_Out", "")
    listSlot.btnNavi:addInputEvent("Mouse_On", "")
    listSlot.btnNavi:addInputEvent("Mouse_Out", "")
    listSlot.btnGiveUp:addInputEvent("Mouse_On", "")
    listSlot.btnGiveUp:addInputEvent("Mouse_Out", "")
    listSlot.btnTag:addInputEvent("Mouse_On", "")
    listSlot.btnTag:addInputEvent("Mouse_Out", "")
    if false == self._isConsole then
      listSlot.bg:ChangeClickTextureInfoNameAsync("")
      listSlot.bg:ChangeOnTextureInfoNameAsync("")
    end
    listSlot.bg:ComputePos()
    listSlot.bg:SetPosY(slotIdx * (listSlot.bg:GetSizeY() + 5) + 45)
    listSlot.bg:SetShow(false)
    listSlot.bg:SetIgnore(false)
    listSlot.name:SetTextMode(__eTextMode_LimitText)
    self._uiPool.listMain[slotIdx] = listSlot
    if true == self._isConsole then
      if slotIdx < 1 then
        self._uiPool.groupTitle[slotIdx].bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_Quest_All_ListScroll(true)")
        self._uiPool.listMain[slotIdx].bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_Quest_All_ListScroll(true)")
      elseif slotIdx > self._config.slotMaxCount - 2 then
        self._uiPool.groupTitle[slotIdx].bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_Quest_All_ListScroll(false)")
        self._uiPool.listMain[slotIdx].bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_Quest_All_ListScroll(false)")
      end
      listSlot.btnNavi:SetIgnore(true)
      listSlot.btnGiveUp:SetIgnore(true)
      listSlot.btnAuto:SetIgnore(true)
      listSlot.btnTag:SetIgnore(true)
    end
  end
  for k, v in ipairs(self._ui._listTemplate) do
    if nil ~= v then
      v:SetShow(false)
    end
  end
end
function PaGlobal_Quest_All:ControlSetShow()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.chk_popUp:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_menuGuideLB:SetShow(true)
    self._ui_console.stc_menuGuideRB:SetShow(true)
    self._ui_console.stc_keyGuideBG:SetShow(true)
    self._ui_console._focusMenu.stc_focusBg:SetShow(false)
  else
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.chk_popUp:SetShow(_ContentsGroup_PopUp)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_menuGuideLB:SetShow(false)
    self._ui_console.stc_menuGuideRB:SetShow(false)
    self._ui_console.stc_keyGuideBG:SetShow(false)
    self._ui_console._focusMenu.stc_focusBg:SetShow(false)
  end
end
function PaGlobal_Quest_All:prepareOpen()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == Panel_Window_Quest_All:IsUISubApp() then
    return
  end
  local isInstanceField = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence)
  if true == isInstanceField then
    return
  end
  self._startSlotIndex = 1
  self._ui_pc.chk_popUp:SetCheck(false)
  self._ui._listScroll.stc_bg:SetControlTop()
  self._ui_console._focusMenu.stc_focusBg:SetShow(false)
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    self._ui.edt_search:SetEditText("")
    self._currentTab = self._TABTYPE.PROGRESS
    self._searchData.searchText = ""
    self._searchData.currentResultIdx = 0
    self._searchData.currentGroupIdx = -1
    self._searchData.currentQuestIdx = -1
    self._searchData.resultGroupNo = -1
    self._searchData.resultQuestNo = -1
    for tabIdx = self._TABTYPE.PROGRESS, self._TABTYPE.COUNT - 1 do
      self._resultCount[tabIdx] = 0
    end
    self._ui.btn_searchUp:SetShow(false)
    self._ui.btn_searchUpDisable:SetShow(true)
    self._ui.btn_searchDown:SetShow(false)
    self._ui.btn_searchDownDisable:SetShow(true)
    self._ui.txt_searchCount:SetText("0/0")
  end
  HandleEventLUp_Quest_All_SetTabMenu(self._currentTab)
  PaGlobal_Quest_All:resize()
  if PaGlobal_TutorialManager ~= nil then
    PaGlobal_TutorialManager:handleShowQuestNewWindow(true)
  end
  if nil ~= PaGlobalFunc_GrowthPass_IsShow and true == PaGlobalFunc_GrowthPass_IsShow() then
    self._isOpenFromGrowthPass = true
  end
  PaGlobal_Quest_All:open()
end
function PaGlobal_Quest_All:open()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == self._isConsole then
    Panel_Window_Quest_All:SetShow(true)
  else
    Panel_Window_Quest_All:SetShow(true, true)
  end
end
function PaGlobal_Quest_All:prepareClose(isAni)
  if nil == Panel_Window_Quest_All then
    return
  end
  if _ContentsGroup_QuestBackEndLoading == true then
    self:clearQuestLoadingTable()
  end
  if true == PaGlobalFunc_QuestInfo_All_GetShow() then
    PaGlobalFunc_QuestInfo_All_Close()
  end
  if nil ~= Panel_Npc_Quest_Reward and true == Panel_Npc_Quest_Reward:GetShow() then
    FGlobal_ShowRewardList(false)
  end
  if true == self._isOpenFromGrowthPass then
    PaGlobalFunc_GrowthPass_Open()
    self._isOpenFromGrowthPass = false
  end
  Panel_Window_Quest_All:CloseUISubApp()
  self._ui_pc.chk_popUp:SetCheck(false)
  if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
    ClearFocusEdit()
  end
  TooltipSimple_Hide()
  PaGlobalFunc_Quest_All_Audio(1, 1)
  PaGlobal_Quest_All:close(isAni)
  if PaGlobal_TutorialManager ~= nil then
    PaGlobal_TutorialManager:handleShowQuestNewWindow(false)
  end
end
function PaGlobal_Quest_All:close(isAni)
  if nil == Panel_Window_Quest_All then
    return
  end
  if nil == isAni then
    isAni = false
  end
  Panel_Window_Quest_All:SetShow(false, isAni)
end
function PaGlobal_Quest_All:update()
  if nil == Panel_Window_Quest_All then
    return
  end
  local tracer1 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-1")
  self:resetDataArray()
  Profile_EndUIFunction(tracer1)
  local tracer2 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-2")
  self:makeDataArray()
  Profile_EndUIFunction(tracer2)
  local tracer3 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-3")
  self:tabTypeFilterUpdate()
  Profile_EndUIFunction(tracer3)
  local tracer4 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-4")
  self:favorTypeUpdate()
  Profile_EndUIFunction(tracer4)
  local tracer5 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-5")
  self:questListUpdate()
  Profile_EndUIFunction(tracer5)
  local tracer6 = Profile_BeginUIFunction(" PaGlobal_Quest_All:update-6")
  self:consoleKeyGuideAlign()
  Profile_EndUIFunction(tracer6)
end
function PaGlobal_Quest_All:favorTypeUpdate()
  local allButtonCheck = true
  local QuestListInfo = ToClient_GetQuestList()
  for ii = 0, __eQuestSelectType_Count - 1 do
    if self._ui._favorType[ii] ~= nil then
      local bChecked = QuestListInfo:isQuestSelectType(ii)
      self._ui._favorType[ii]:SetCheck(bChecked)
      self._ui._favorType[ii]:SetMonoTone(bChecked, true)
      if false == bChecked then
        self._ui._favorType[__eQuestSelectType_Count]:SetMonoTone(true, true)
        allButtonCheck = false
      end
      if true == allButtonCheck then
        self._ui._favorType[ii]:SetMonoTone(false, false)
        self._ui._favorType[__eQuestSelectType_Count]:SetMonoTone(false, false)
      elseif true == bChecked then
        self._ui._favorType[ii]:SetMonoTone(false, true)
      else
        self._ui._favorType[ii]:SetMonoTone(true, true)
      end
    end
  end
  self._ui._favorType[__eQuestSelectType_Count]:SetCheck(allButtonCheck)
end
function PaGlobal_Quest_All:favorCheckAll()
  if nil == Panel_Window_Quest_All then
    return
  end
  local isCheck = self._ui._favorType[__eQuestSelectType_Count]:IsCheck()
  for ii = 0, __eQuestSelectType_Count - 1 do
    if self._ui._favorType[ii] ~= nil and isCheck == not self._ui._favorType[ii]:IsCheck() then
      ToClient_ToggleQuestSelectType(ii)
      self._ui._favorType[ii]:SetCheck(isCheck)
    end
  end
end
function PaGlobal_Quest_All:checkFavorCheckType()
  if Panel_Window_Quest_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if self._config.checkFavorTypeLv ~= selfPlayer:get():getLevel() then
    return
  end
  local isOnlyCheckedMainQuest = true
  for ii = 0, __eQuestSelectType_Count - 1 do
    if self._ui._favorType[ii] ~= nil and self._ui._favorType[ii]:IsCheck() == true then
      isOnlyCheckedMainQuest = false
      break
    end
  end
  if isOnlyCheckedMainQuest == true then
    local questListInfo = ToClient_GetQuestList()
    if questListInfo ~= nil then
      questListInfo:setQuestSelectType(__eQuestSelectType_Contents, true)
      self:favorTypeUpdate()
    end
  end
end
function PaGlobal_Quest_All:favorTypeNationalCheck()
  if true == isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_RUS) then
    PaGlobal_Quest_All:favorCheckAll()
  end
end
function PaGlobal_Quest_All:resetGroupOpen()
  local questListInfo = ToClient_GetQuestList()
  local repeatitionQuestGroupCount = questListInfo:getRepetitionQuestGroupCount()
  local questGroupCount = questListInfo:getRecommendationQuestGroupCount()
  local mainQuestGroupCount = questListInfo:getMainQuestGroupCount()
  local newQuestGroupCount = questListInfo:getNewQuestGroupCount()
  for groupIdx = 0, questGroupCount - 1 do
    self._groupOpen._recommendation[groupIdx] = {isOpen = false, isLoading = false}
  end
  for groupIdx = 0, repeatitionQuestGroupCount - 1 do
    self._groupOpen._repetitive[groupIdx] = {isOpen = false, isLoading = false}
  end
  for groupIdx = 0, mainQuestGroupCount - 1 do
    self._groupOpen._main[groupIdx] = {isOpen = false, isLoading = false}
  end
  for groupIdx = 0, newQuestGroupCount - 1 do
    self._groupOpen._new[groupIdx] = {isOpen = false, isLoading = false}
  end
end
function PaGlobal_Quest_All:tabTypeFilterUpdate()
  if self._TABTYPE.PROGRESS == self._currentTab then
    if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
      self._ui.combo_questSortType:SetShow(true)
    else
      self._ui.txt_questCnt:SetShow(true)
      self._ui.radio_questType:SetShow(true)
      self._ui.radio_questTerritory:SetShow(true)
    end
    self._ui.chk_emptyGroupHide:SetShow(true)
    self._ui.stc_groupFilterBg:SetShow(false)
  else
    if _ContentsGroup_QuestSearch == true and ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) == false then
      self._ui.combo_questSortType:SetShow(false)
    else
      self._ui.txt_questCnt:SetShow(false)
      self._ui.radio_questType:SetShow(false)
      self._ui.radio_questTerritory:SetShow(false)
    end
    self._ui.chk_emptyGroupHide:SetShow(false)
    self._ui.stc_groupFilterBg:SetShow(true)
  end
end
function PaGlobal_Quest_All:getQuestGroupCount()
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return
  end
  local questGroupCount = 0
  if self._TABTYPE.PROGRESS == self._currentTab then
    questGroupCount = questListInfo:getQuestGroupCount()
  elseif self._TABTYPE.RECOMMEND == self._currentTab then
    questGroupCount = questListInfo:getRecommendationQuestGroupCount()
  elseif self._TABTYPE.REPEAT == self._currentTab then
    questGroupCount = questListInfo:getRepetitionQuestGroupCount()
  elseif self._TABTYPE.NEW == self._currentTab then
    questGroupCount = questListInfo:getNewQuestGroupCount()
  else
    questGroupCount = questListInfo:getMainQuestGroupCount()
  end
  return questGroupCount
end
function PaGlobal_Quest_All:makeDataArray()
  local questGroupCount = self:getQuestGroupCount()
  self._progressQuestCount = 0
  if self._TABTYPE.PROGRESS == self._currentTab then
    for questGroupIndex = 0, questGroupCount - 1 do
      self:makeProgressGroup(questGroupIndex)
    end
    self:setProgressGroup()
  elseif self._TABTYPE.RECOMMEND == self._currentTab then
    self:setRecommendGroup(questGroupCount)
  elseif self._TABTYPE.REPEAT == self._currentTab then
    self:setRepeatGroup(questGroupCount)
  elseif self._TABTYPE.NEW == self._currentTab then
    self:setNewGroup(questGroupCount)
  else
    self:setMainGroup(questGroupCount)
  end
  self._ui.txt_questCnt:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_COUNTQUEST", "count", self._progressQuestCount))
end
function PaGlobal_Quest_All:registEventHandler()
  if nil == Panel_Window_Quest_All then
    return
  end
  local isAbyssOneLoading = ToClient_isMustAbyssOneLoading() == true and ToClient_isMagnusTeleportFlag() == false
  Panel_Window_Quest_All:SetShow(false)
  Panel_Window_Quest_All:setGlassBackground(true)
  Panel_Window_Quest_All:RegisterShowEventFunc(true, "PaGlobalFunc_Quest_All_ShowAni()")
  Panel_Window_Quest_All:RegisterShowEventFunc(false, "PaGlobalFunc_Quest_All_HideAni()")
  if _ContentsGroup_QuestBackEndLoading == true then
    registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_Quest_All_QuestBackEndLoadComplete")
  end
  registerEvent("FromClient_UpdateQuestList", "FromClient_Quest_All_UpdateQuestList")
  registerEvent("onScreenResize", "FromClient_Quest_All_Resize")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_Quest_All_SelfPlayerLevelUp")
  if true == self._isConsole then
    Panel_Window_Quest_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandlePadEventLBRB_Quest_All_MoveTab(-1)")
    Panel_Window_Quest_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandlePadEventLBRB_Quest_All_MoveTab(1)")
    Panel_Window_Quest_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_Quest_All_ChangeQuestSortType()")
    Panel_Window_Quest_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_Quest_All_CheckEmptyHideGroup()")
    Panel_Window_Quest_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandlePadEventLTY_Quest_All_ChangeQuestTypeSet()")
    self._ui_console._focusMenu.radio_autoNavi:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"autoNavi\" )")
    self._ui_console._focusMenu.radio_questNavi:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"questNavi\" )")
    self._ui_console._focusMenu.radio_giveUp:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"giveUp\" )")
    self._ui_console._focusMenu.radio_detail:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"detail\" )")
    self._ui_console._focusMenu.radio_blackSpirit:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"blackSpirit\" )")
    self._ui_console._focusMenu.radio_tag:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_SubMenuClick( \"tag\" )")
    if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
      self._ui.combo_questSortType:GetListControl():AddSelectEvent("HandleEventLUp_Quest_All_SetTabMenu(0)")
      self._ui.combo_questSortType:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_ToggleSortType()")
      self._ui.combo_questSortType:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 0)")
      self._ui.combo_questSortType:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
      self._ui.combo_questSearchType:GetListControl():AddSelectEvent("HandleEventLUp_Quest_All_SetSearchType()")
      self._ui.combo_questSearchType:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_ToggleSearchType()")
      self._ui.edt_search:RegistReturnKeyEvent("HandleEvent_Quest_All_SearchAndShowQuestByEnter()")
      self._ui.btn_searchUp:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuest(true)")
      self._ui.btn_searchDown:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuest(false)")
      self._ui.btn_searchPCUI:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuest(false)")
      self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_SetTabMenu(0)")
      self._ui.chk_emptyGroupHide:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
      self._ui.chk_complteHide:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
      self._ui.chk_emptyGroupHide:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 2)")
      self._ui.chk_emptyGroupHide:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
    end
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelQuestHistory\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelQuestHistory\"")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_PopUp()")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_PopUp(true)")
    self._ui_pc.chk_popUp:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_PopUp(false)")
    self._ui.stc_contentBg:SetIgnore(false)
    self._ui.stc_contentBg:addInputEvent("Mouse_UpScroll", "HandleEvent_Quest_All_ListScroll( true )")
    self._ui.stc_contentBg:addInputEvent("Mouse_DownScroll", "HandleEvent_Quest_All_ListScroll( false )")
    for index = 1, #self._radioTabs do
      self._radioTabs[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_SetTabMenu(" .. index .. ")")
    end
    for index = 0, __eQuestSelectType_Count do
      if self._ui._favorType[index] ~= nil then
        self._ui._favorType[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_SelectQuestFavorType(" .. index .. ")")
        self._ui._favorType[index]:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(true," .. index .. ")")
        self._ui._favorType[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(false," .. index .. ")")
        self._ui._favorType[index]:SetNotAbleMasking(true)
      end
    end
    self._ui.txt_favorType:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(true, 99)")
    self._ui.txt_favorType:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(false, 99)")
    self._ui.btn_questBranch:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_QuestBranch(0)")
    if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
      self._ui.combo_questSortType:GetListControl():AddSelectEvent("HandleEventLUp_Quest_All_SetTabMenu(0)")
      self._ui.combo_questSortType:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_ToggleSortType()")
      self._ui.combo_questSortType:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 0)")
      self._ui.combo_questSortType:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
      self._ui.combo_questSearchType:GetListControl():AddSelectEvent("HandleEventLUp_Quest_All_SetSearchType()")
      self._ui.combo_questSearchType:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_ToggleSearchType()")
      self._ui.edt_search:RegistReturnKeyEvent("HandleEvent_Quest_All_SearchAndShowQuestByEnter()")
      self._ui.btn_searchUp:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuest(true)")
      self._ui.btn_searchDown:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuest(false)")
      self._ui.btn_searchPCUI:addInputEvent("Mouse_LUp", "HandleEvent_Quest_All_SearchAndShowQuestByEnter()")
      self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_SetTabMenu(0)")
    else
      self._ui.radio_questType:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
      self._ui.radio_questTerritory:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
      self._ui.radio_questType:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 0)")
      self._ui.radio_questType:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
      self._ui.radio_questTerritory:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 1)")
      self._ui.radio_questTerritory:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
    end
    self._ui.chk_emptyGroupHide:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
    self._ui.chk_complteHide:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Update()")
    self._ui.chk_emptyGroupHide:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(true, 2)")
    self._ui.chk_emptyGroupHide:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(false)")
  end
  UIScroll.InputEvent(self._ui._listScroll.stc_bg, "HandleEvent_Quest_All_ListScroll")
end
function PaGlobal_Quest_All:validate()
  if nil == Panel_Window_Quest_All then
    return
  end
  local isAbyssOneLoading = ToClient_isMustAbyssOneLoading() == true and ToClient_isMagnusTeleportFlag() == false
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_contentBg:isValidate()
  self._ui.stc_radioButtonGroup:isValidate()
  self._ui.radio_progressing:isValidate()
  self._ui.radio_main:isValidate()
  self._ui.radio_recommend:isValidate()
  self._ui.radio_repeat:isValidate()
  self._ui.radio_new:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.stc_groupTypeBG:isValidate()
  self._ui.txt_questCnt:isValidate()
  if _ContentsGroup_QuestSearch == true and isAbyssOneLoading == false then
    self._ui.combo_questSortType:isValidate()
    self._ui.combo_questSearchType:isValidate()
  else
    self._ui.radio_questType:isValidate()
    self._ui.radio_questTerritory:isValidate()
  end
  self._ui.chk_emptyGroupHide:isValidate()
  self._ui.stc_groupFilterBg:isValidate()
  self._ui.chk_complteHide:isValidate()
  self._ui.btn_questBranch:isValidate()
  self._ui._listGroup.stc_bg:isValidate()
  self._ui._listGroup.stc_icon:isValidate()
  self._ui._listGroup.txt_name:isValidate()
  self._ui._listGroup.txt_percent:isValidate()
  self._ui._listTemplate.stc_bg:isValidate()
  self._ui._listTemplate.chk_showWidget:isValidate()
  self._ui._listTemplate.stc_icon:isValidate()
  self._ui._listTemplate.txt_name:isValidate()
  self._ui._listTemplate.txt_remainTime:isValidate()
  self._ui._listTemplate.chk_autoNavi:isValidate()
  self._ui._listTemplate.stc_autoNavi:isValidate()
  self._ui._listTemplate.chk_questNavi:isValidate()
  self._ui._listTemplate.stc_questNavi:isValidate()
  self._ui._listTemplate.chk_giveUp:isValidate()
  self._ui._listTemplate.stc_giveUp:isValidate()
  self._ui._listTemplate.chk_tag:isValidate()
  self._ui._listTemplate.stc_tag:isValidate()
  self._ui._listTemplate.txt_completeCnt:isValidate()
  self._ui._listScroll.stc_bg:isValidate()
  self._ui._listScroll.btn_Up:isValidate()
  self._ui._listScroll.btn_Down:isValidate()
  self._ui._listScroll.btn_Ctrl:isValidate()
  self._ui.stc_favorTypeBg:isValidate()
  self._ui.txt_favorType:isValidate()
  self._ui.stc_DoneQuestBg:isValidate()
  self._ui.txt_DoneQuest:isValidate()
  self._ui._favorType[__eQuestSelectType_Count]:isValidate()
  self._ui._favorType[__eQuestSelectType_BlackSpirit]:isValidate()
  self._ui._favorType[__eQuestSelectType_Sub]:isValidate()
  self._ui._favorType[__eQuestSelectType_Adventure]:isValidate()
  self._ui._favorType[__eQuestSelectType_Life]:isValidate()
  self._ui._favorType[__eQuestSelectType_Contents]:isValidate()
  self._ui._favorType[__eQuestSelectType_Event]:isValidate()
  self._ui._favorType[__eQuestSelectType_Etc]:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.chk_popUp:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_console.stc_menuGuideLB:isValidate()
  self._ui_console.stc_menuGuideRB:isValidate()
  self._ui_console.stc_keyGuideBG:isValidate()
  self._ui_console.stc_guideSortType:isValidate()
  self._ui_console.stc_guideHideEmpty:isValidate()
  self._ui_console.stc_guideSelect:isValidate()
  self._ui_console.stc_guideClose:isValidate()
  self._ui_console.stc_guidePreferRT:isValidate()
  self._ui_console.stc_guidePreferPlus:isValidate()
  self._ui_console.stc_guidePreferY:isValidate()
  self._ui_console._focusMenu.stc_focusBg:isValidate()
  self._ui_console._focusMenu.radio_autoNavi:isValidate()
  self._ui_console._focusMenu.radio_questNavi:isValidate()
  self._ui_console._focusMenu.radio_giveUp:isValidate()
  self._ui_console._focusMenu.radio_detail:isValidate()
  self._ui_console._focusMenu.radio_blackSpirit:isValidate()
  self._ui_console._focusMenu.radio_tag:isValidate()
  self._ui_console._focusMenu.stc_Confirm:isValidate()
end
function PaGlobal_Quest_All:resize()
  if nil == Panel_Window_Quest_All then
    return
  end
  if _ContentsGroup_QuestSearch ~= true or ToClient_isInInstanceField(__eInstanceContentsType_AbyssOne) ~= false then
    self._ui.chk_emptyGroupHide:SetSpanSize(self._ui.chk_emptyGroupHide:GetSizeX() + self._ui.chk_emptyGroupHide:GetTextSizeX(), self._ui.chk_emptyGroupHide:GetSpanSize().y)
    self._ui.radio_questTerritory:SetSpanSize(self._ui.chk_emptyGroupHide:GetSpanSize().x + self._ui.chk_emptyGroupHide:GetSizeX() + 5, self._ui.radio_questTerritory:GetSpanSize().y)
    self._ui.radio_questType:SetSpanSize(self._ui.radio_questTerritory:GetSpanSize().x + self._ui.radio_questType:GetSizeX() + 5, self._ui.radio_questType:GetSpanSize().y)
    self._ui.radio_questTerritory:ComputePos()
    self._ui.radio_questType:ComputePos()
  end
  self._ui.chk_emptyGroupHide:ComputePos()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local startPosX = Panel_Window_Quest_All:GetPosX()
  local startPosY = Panel_Window_Quest_All:GetPosY()
  local endPosX = startPosX + Panel_Window_Quest_All:GetSizeX()
  local endPosY = startPosY + Panel_Window_Quest_All:GetSizeY()
  if false == Panel_Window_Quest_All:IsUISubApp() then
    if startPosX < 0 or scrSizeX < endPosX then
      Panel_Window_Quest_All:SetPosX(scrSizeX / 2 - Panel_Window_Quest_All:GetSizeX())
    end
    if startPosY < 0 or scrSizeY < endPosY then
      Panel_Window_Quest_All:SetPosY(scrSizeY / 2 - Panel_Window_Quest_All:GetSizeY() / 2)
    end
  end
  self:consoleKeyGuideAlign()
end
function PaGlobal_Quest_All:consoleKeyGuideAlign()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == self._isConsole then
    local tempBtnGroup = {
      self._ui_console.stc_guidePreferRT,
      self._ui_console.stc_guideSortType,
      self._ui_console.stc_guideHideEmpty,
      self._ui_console.stc_guideSelect,
      self._ui_console.stc_guideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_Quest_All:clearQuestLoadingTable()
  if Panel_Window_Quest_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
  self._progessQuestLoadingGroup = Array.new()
end
function PaGlobal_Quest_All:pushLoadingData(tabIdx, groupIdx, uiQuestInfo)
  if Panel_Window_Quest_All == nil or groupIdx == nil or uiQuestInfo == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if self._questLoadingDataList == nil then
    self._questLoadingDataList = Array.new()
  end
  local newLoadingData = {
    _tabIndex = tabIdx,
    _groupIndex = groupIdx,
    _questNoRaw = uiQuestInfo:getQuestNo()._raw
  }
  if self:isExistLoadingDataAnyOne() == true then
    for index = #self._questLoadingDataList, 1, -1 do
      local value = self._questLoadingDataList[index]
      if value ~= nil then
        if value._questNoRaw == newLoadingData._questNoRaw then
          table.remove(self._questLoadingDataList, index)
        elseif value._tabIndex ~= newLoadingData._tabIndex then
          table.remove(self._questLoadingDataList, index)
        elseif value._groupIndex ~= newLoadingData._groupIndex then
          table.remove(self._questLoadingDataList, index)
        end
      end
    end
  end
  self._questLoadingDataList:push_back(newLoadingData)
  uiQuestInfo:requestLoadBackEndData()
end
function PaGlobal_Quest_All:pushProgressQuestLoadingGroup(groupIdx)
  if Panel_Window_Quest_All == nil or groupIdx == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if self._progessQuestLoadingGroup == nil then
    self._progessQuestLoadingGroup = Array.new()
  end
  self._progessQuestLoadingGroup:push_back(groupIdx)
end
function PaGlobal_Quest_All:isExistLoadingDataAnyOne()
  if Panel_Window_Quest_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
