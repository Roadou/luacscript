function PaGlobal_RenewDropItem_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initialize_mainCategoryArea()
  self:initialize_subCategoryArea()
  self:initialize_leftHuntingGroundListArea()
  self:initialize_rightTopHuntingGroundInfoArea()
  self:initialize_rightBottomHuntingGroundInfoArea()
  self:initialize_bottomDescArea()
  self:initialize_consoleKeyGuideArea()
  self:changeMainCategory(self:getFirstMainCategoryKey())
  self:initSortOptionInfo()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RenewDropItem_All:initialize_mainCategoryArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  local stc_title = UI.getChildControl(Panel_Window_DropItem_All, "StaticText_Title")
  local btn_close = UI.getChildControl(stc_title, "Button_Win_Close")
  btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RenewDropItem_Close()")
  btn_close:SetShow(not self._isConsole)
  self._ui._stc_titleName = UI.getChildControl(stc_title, "StaticText_TitleIcon")
  self._ui._stc_mainCategoryArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_TabGroup")
  self._ui._stc_mainCategoryUnderLine = UI.getChildControl(self._ui._stc_mainCategoryArea, "Static_HighlightLine")
  local mainCategoryButtonTemplate = UI.getChildControl(self._ui._stc_mainCategoryArea, "RadioButton_Template")
  self._mainCategoryDataList = Array.new()
  local mainCategoryCount = ToClient_getDropUIMainCategoryCount()
  local parentsSizeX = self._ui._stc_mainCategoryArea:GetSizeX()
  local buttonSizeX = mainCategoryButtonTemplate:GetSizeX()
  local offsetSizeX = self._ui._stc_mainCategoryUnderLine:GetSizeX() - buttonSizeX
  local sumButtonSizeX = (buttonSizeX + offsetSizeX) * mainCategoryCount + offsetSizeX
  local diffSizeX = parentsSizeX - sumButtonSizeX
  if diffSizeX < 0 then
    diffSizeX = 0
  end
  local startPosX = diffSizeX / 2 + buttonSizeX / 2
  for index = 0, mainCategoryCount - 1 do
    local mainCategoryKey = ToClient_getDropUIMainCategoryKey(index)
    local mainCategorySS = ToClient_getDropUIMainCategoryStaticStatusWrapper(mainCategoryKey)
    if mainCategorySS ~= nil then
      local mainCategoryButtonData = {
        _key = nil,
        _subCategoryCount = nil,
        _buttonControl = nil
      }
      mainCategoryButtonData._key = mainCategoryKey
      mainCategoryButtonData._subCategoryCount = ToClient_getDropUISubCategoryCount(mainCategoryKey)
      mainCategoryButtonData._buttonControl = UI.cloneControl(mainCategoryButtonTemplate, self._ui._stc_mainCategoryArea, "RadioButton_Clone_MainCategory_" .. tostring(mainCategoryKey:get()))
      mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync(mainCategorySS:getIconTextureId() .. "_Normal", 0)
      mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync(mainCategorySS:getIconTextureId() .. "_Over", 1)
      mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync(mainCategorySS:getIconTextureId() .. "_Click", 2)
      mainCategoryButtonData._buttonControl:setRenderTexture(mainCategoryButtonData._buttonControl:getBaseTexture())
      mainCategoryButtonData._buttonControl:SetPosX(startPosX + (buttonSizeX + offsetSizeX) * index)
      mainCategoryButtonData._buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_MainCategoryButton(" .. tostring(mainCategoryKey:get()) .. ")")
      mainCategoryButtonData._buttonControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_MainCategoryButton(true," .. tostring(mainCategoryKey:get()) .. ")")
      mainCategoryButtonData._buttonControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_MainCategoryButton(false," .. tostring(mainCategoryKey:get()) .. ")")
      self._mainCategoryDataList:push_back(mainCategoryButtonData)
    else
      local allMainCategoryKey = ToClient_getDropUIAllMainCategoryKey()
      if allMainCategoryKey:get() == mainCategoryKey:get() then
        local mainCategoryButtonData = {
          _key = nil,
          _subCategoryCount = nil,
          _buttonControl = nil
        }
        mainCategoryButtonData._key = mainCategoryKey
        mainCategoryButtonData._subCategoryCount = ToClient_getDropUISubCategoryCount(mainCategoryKey)
        mainCategoryButtonData._buttonControl = UI.cloneControl(mainCategoryButtonTemplate, self._ui._stc_mainCategoryArea, "RadioButton_Clone_MainCategory_" .. tostring(mainCategoryKey:get()))
        mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_DropItem_Icon_Tab_00_Normal", 0)
        mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_DropItem_Icon_Tab_00_Over", 1)
        mainCategoryButtonData._buttonControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_DropItem_Icon_Tab_00_Click", 2)
        mainCategoryButtonData._buttonControl:setRenderTexture(mainCategoryButtonData._buttonControl:getBaseTexture())
        mainCategoryButtonData._buttonControl:SetPosX(startPosX + (buttonSizeX + offsetSizeX) * index)
        mainCategoryButtonData._buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_MainCategoryButton(" .. tostring(mainCategoryKey:get()) .. ")")
        mainCategoryButtonData._buttonControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_MainCategoryButton(true," .. tostring(mainCategoryKey:get()) .. ")")
        mainCategoryButtonData._buttonControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_MainCategoryButton(false," .. tostring(mainCategoryKey:get()) .. ")")
        self._mainCategoryDataList:push_back(mainCategoryButtonData)
      end
    end
  end
  UI.deleteControl(mainCategoryButtonTemplate)
  local stc_keyGuide_LB = UI.getChildControl(self._ui._stc_mainCategoryArea, "StaticText_LB_ConsoleUI")
  local stc_keyGuide_RB = UI.getChildControl(self._ui._stc_mainCategoryArea, "StaticText_RB_ConsoleUI")
  stc_keyGuide_LB:SetShow(self._isConsole)
  stc_keyGuide_RB:SetShow(self._isConsole)
end
function PaGlobal_RenewDropItem_All:initialize_subCategoryArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._stc_subCategoryArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_FilterGroup")
  self._ui._stc_subCategoryDecoLeft = UI.getChildControl(self._ui._stc_subCategoryArea, "Static_Deco_Left")
  self._ui._stc_subCategoryDecoRight = UI.getChildControl(self._ui._stc_subCategoryArea, "Static_Deco_Right")
  self._ui._btn_subCategoryTemplate = UI.getChildControl(self._ui._stc_subCategoryArea, "RadioButton_Template")
  self._ui._btn_subCategoryTemplate:SetShow(false)
  if self._isConsole == true then
    self._ui._btn_subCategoryTemplate:SetSize(self._ui._btn_subCategoryTemplate:GetSizeX() - 10, self._ui._btn_subCategoryTemplate:GetSizeY())
    self._ui._btn_subCategoryTemplate:ComputePos()
  end
  self._ui._stc_keyGuide_LT = UI.getChildControl(self._ui._stc_subCategoryArea, "StaticText_LT_ConsoleUI")
  self._ui._stc_keyGuide_RT = UI.getChildControl(self._ui._stc_subCategoryArea, "StaticText_RT_ConsoleUI")
  self._ui._stc_keyGuide_LT:SetShow(self._isConsole)
  self._ui._stc_keyGuide_RT:SetShow(self._isConsole)
end
function PaGlobal_RenewDropItem_All:initialize_leftHuntingGroundListArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  local searchArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_Serach")
  self._ui._edt_searchEditBox = UI.getChildControl(searchArea, "Edit_SearchText_PCUI_Import")
  self._ui._btn_searchResultClear = UI.getChildControl(searchArea, "Button_Clear")
  self._ui._stc_searchIcon = nil
  if self._isConsole == true then
    self._ui._stc_searchIcon = UI.getChildControl(searchArea, "Static_ConsoleXIcon")
  else
    self._ui._stc_searchIcon = UI.getChildControl(searchArea, "Static_Icon")
  end
  self._ui._stc_searchIcon:SetShow(true)
  self._ui._edt_searchEditBox:SetMaxInput(16)
  if ToClient_isConsole() == true then
    self._ui._edt_searchEditBox:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_RenewDropItem_SearchByConsole")
  else
    self._ui._edt_searchEditBox:RegistReturnKeyEvent("PaGlobalFunc_RenewDropItem_Search()")
  end
  self._ui._btn_searchResultClear:addInputEvent("Mouse_LUp", "PaGlobalFunc_RenewDropItem_ClearSearchResult()")
  self._ui._cbx_sortOption = UI.getChildControl(Panel_Window_DropItem_All, "Combobox_SortFilter")
  self._ui._stc_sortOptionList = UI.getChildControl(self._ui._cbx_sortOption, "Combobox_1_List")
  self._ui._stc_huntingGroundList = UI.getChildControl(Panel_Window_DropItem_All, "List2_Region")
  local content = UI.getChildControl(self._ui._stc_huntingGroundList, "List2_2_Content")
  local rdoButton = UI.getChildControl(content, "RadioButton_RegionName")
  local subCategoryIconTemplate = UI.getChildControl(rdoButton, "Static_Icon_Template")
  self._originalRegionContentNameSpanRBX = rdoButton:GetTextSpanRB().x
  local offsetRight = 10
  local offsetIconTerm = 2
  local subCategoryCountMax = ToClient_getDropUISubCategoryMaxCount()
  for index = 0, subCategoryCountMax - 1 do
    local icon = UI.createAndCopyBasePropertyControl(rdoButton, "Static_Icon_Template", rdoButton, "Static_SubCategoryIcon_" .. index)
    icon:SetSpanSize(offsetRight + (icon:GetSizeX() + offsetIconTerm) * index, icon:GetSpanSize().y)
  end
  UI.deleteControl(subCategoryIconTemplate)
  self._ui._stc_huntingGroundList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RenewDropItem_OnCreateHuntingGroundListContent")
  self._ui._stc_huntingGroundList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_RenewDropItem_All:initialize_rightTopHuntingGroundInfoArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._stc_tagArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_TagBG")
  local stc_rightTop = UI.getChildControl(Panel_Window_DropItem_All, "Static_LeftTop")
  self._ui._btn_navi = UI.getChildControl(stc_rightTop, "Button_Navi")
  self._ui._btn_adventure = UI.getChildControl(stc_rightTop, "Button_Adventure")
  self._ui._txt_huntingGroundName = UI.getChildControl(stc_rightTop, "StaticText_SelectedRegionName")
  self._ui._txt_dropRate = UI.getChildControl(stc_rightTop, "StaticText_DropRate")
  self._ui._txt_needAP = UI.getChildControl(stc_rightTop, "StaticText_NeedAp")
  self._ui._stc_needAP = UI.getChildControl(self._ui._txt_needAP, "Static_Icon")
  self._ui._txt_needDP = UI.getChildControl(stc_rightTop, "StaticText_NeedDp")
  self._ui._stc_needDP = UI.getChildControl(self._ui._txt_needDP, "Static_Icon")
  self._ui._txt_myAP = UI.getChildControl(stc_rightTop, "StaticText_CharacterAtk")
  self._ui._txt_myAwakenAP = UI.getChildControl(stc_rightTop, "StaticText_CharacterAtk2")
  self._ui._txt_myDP = UI.getChildControl(stc_rightTop, "StaticText_CharacterDef")
  self._ui._stc_myDPIcon = UI.getChildControl(self._ui._txt_myDP, "Static_Icon")
  self._ui._chk_detailInfo = UI.getChildControl(stc_rightTop, "CheckButton_DetailInfo")
  self._ui._btn_notationSetting = UI.getChildControl(stc_rightTop, "Button_NotationAbilitySetting")
  self._ui._txt_limitAP = UI.getChildControl(stc_rightTop, "StaticText_LimitAP")
  self._ui._stc_limitAPIcon = UI.getChildControl(self._ui._txt_limitAP, "Static_Icon")
  self._ui._chk_detailInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_ClickDetailInfo()")
  self._ui._chk_detailInfo:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_ClickDetailInfo(true)")
  self._ui._chk_detailInfo:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_ClickDetailInfo(false)")
  self._ui._btn_notationSetting:SetShow(_ContentsGroup_RenewCharacterStatusViewMode == true)
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    self._ui._btn_notationSetting:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_NotationSetting()")
    self._ui._btn_notationSetting:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_NotationSetting(true)")
    self._ui._btn_notationSetting:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_NotationSetting(false)")
    self._ui._btn_notationSetting:setButtonShortcutsWithEvent("HandleEventLUp_RenewDropItem_NotationSetting()", "PANEL_NOTATION_ABILITY_TITLE")
  end
  self._ui._chk_detailInfo:SetShow(_ContentsGroup_Max_Att == true)
  local APIcon = UI.getChildControl(self._ui._txt_myAP, "Static_Icon")
  local awakenAPIcon = UI.getChildControl(self._ui._txt_myAwakenAP, "Static_Icon")
  APIcon:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_APTooltip(true, 0)")
  APIcon:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_APTooltip(false)")
  awakenAPIcon:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_APTooltip(true, 1)")
  awakenAPIcon:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_APTooltip(false)")
  self._ui._stc_myDPIcon:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_APTooltip(true, 2)")
  self._ui._stc_myDPIcon:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_APTooltip(false)")
  self._ui._stc_needAP:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_RecommandAPTooltip(true, 1)")
  self._ui._stc_needAP:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_RecommandAPTooltip()")
  self._ui._stc_needDP:addInputEvent("Mouse_On", "HandleEventOnOff_RenewDropItem_RecommandAPTooltip(true, 2)")
  self._ui._stc_needDP:addInputEvent("Mouse_Out", "HandleEventOnOff_RenewDropItem_RecommandAPTooltip()")
  self._originalRegionNameSizeX = self._ui._txt_huntingGroundName:GetSizeX()
  self._tagIconList = Array.new()
  local maxCount = ToClient_getDropUITagStaticStatusMaxShowCount()
  for tagIndex = 0, maxCount - 1 do
    self._tagIconList[tagIndex] = self:makeTagIcon(self._ui._stc_tagArea, "Static_Tag_Icon_" .. tagIndex, tagIndex)
    if self._tagIconList[tagIndex] == nil then
      UI.ASSERT_NAME(false, "\236\130\172\235\131\165\237\132\176 \236\160\149\235\179\180 UI - \237\131\156\234\183\184 \235\175\184\235\166\172 \236\131\157\236\132\177\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      break
    end
  end
end
function PaGlobal_RenewDropItem_All:initialize_rightBottomHuntingGroundInfoArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._stc_mainArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_MainArea")
  self._ui._frm_dropInfo = UI.getChildControl(self._ui._stc_mainArea, "Frame_RegionDropItem")
  self._ui._frameConent_dropInfo = UI.getChildControl(self._ui._frm_dropInfo, "Frame_1_Content")
  self._ui._frameVerticalScroll = UI.getChildControl(self._ui._frm_dropInfo, "Frame_1_VerticalScroll")
  self._ui._stc_dropEquipItemGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_EquipableDropItemGroup")
  self._ui._stc_dropEtcItemGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_EtcDropItemGroup")
  self._ui._stc_repeatQuestGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_RepeatQuestGroup")
  self._ui._stc_suddenQuestGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_SuddenQuestGroup")
  self._ui._stc_knowledgeThemeGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_KnowledgeThemeGroup")
  self._ui._stc_titleGroup = UI.getChildControl(self._ui._frameConent_dropInfo, "Static_TitleGroup")
  self._originalMainAreaPosY = self._ui._stc_mainArea:GetPosY()
  self._originalMainAreaSizeY = self._ui._stc_mainArea:GetSizeY()
  self._originalFrameSizeY = self._ui._frm_dropInfo:GetSizeY()
  self._ui._frm_dropInfo:GetVScroll():SetInterval(self._ui._frm_dropInfo:GetSizeY() / 100 * 1.5)
end
function PaGlobal_RenewDropItem_All:initialize_bottomDescArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  local stc_dsecArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_DescBg")
  local txt_desc = UI.getChildControl(stc_dsecArea, "StaticText_Desc")
  local originalDescSizeY = txt_desc:GetSizeY()
  txt_desc:SetTextMode(__eTextMode_AutoWrap)
  txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_DROPITEM_RENEW_DESC"))
  txt_desc:SetSize(txt_desc:GetSizeX(), txt_desc:GetTextSizeY() + 10)
  local newDescSizeY = txt_desc:GetSizeY()
  local addValueY = 0
  if originalDescSizeY < newDescSizeY then
    addValueY = newDescSizeY - originalDescSizeY
    stc_dsecArea:SetSize(stc_dsecArea:GetSizeX(), stc_dsecArea:GetSizeY() + addValueY)
    Panel_Window_DropItem_All:SetSize(Panel_Window_DropItem_All:GetSizeX(), Panel_Window_DropItem_All:GetSizeY() + addValueY)
    Panel_Window_DropItem_All:ComputePosAllChild()
  end
end
function PaGlobal_RenewDropItem_All:initialize_consoleKeyGuideArea()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._stc_keyGuideArea = UI.getChildControl(Panel_Window_DropItem_All, "Static_KeyGuide_Console")
  self._ui._stc_keyGuideArea:SetShow(self._isConsole)
  if self._isConsole == true then
    local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Select_Console")
    local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Close_Console")
    local stc_keyGuide_LS = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Waypoint_Console")
    local stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Tooltip_Console")
    local keyGuideList = Array.new()
    keyGuideList:push_back(stc_keyGuide_X)
    keyGuideList:push_back(stc_keyGuide_LS)
    keyGuideList:push_back(stc_keyGuide_A)
    keyGuideList:push_back(stc_keyGuide_B)
    for key, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  end
end
function PaGlobal_RenewDropItem_All:registEventHandler()
  if Panel_Window_DropItem_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_RenewDropItem_OnResizePanel")
  registerEvent("FromClient_CleqrQuestWithQuestNo", "FromClient_RenewDropItem_OnClearQuest")
  registerEvent("FromClient_Worldmap_LinkedDropUI_MouseOn", "FromClient_RenewDropItem_WorldMapMonsterIconMouseOn")
  registerEvent("FromClient_Worldmap_LinkedDropUI_MouseOut", "FromClient_RenewDropItem_WorldMapMonsterIconMouseOut")
  registerEvent("FromClient_Worldmap_LinkedDropUI_MouseClick", "FromClient_RenewDropItem_WorldMapMonsterIconMouseLClick")
  if _ContentsGroup_QuestBackEndLoading == true then
    registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_RenewDropItem_QuestBackEndLoadComplete")
  end
  if self._isConsole == true then
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_RenewDropItem_MoveMainCategory(false)")
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobalFunc_RenewDropItem_MoveMainCategory(true)")
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobalFunc_RenewDropItem_MoveSubCategory(false)")
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobalFunc_RenewDropItem_MoveSubCategory(true)")
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_RenewDropItem_SetFocusSearchEditBox()")
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "PaGlobalFunc_RenewDropItem_FindCurrentHuntingGroundWay()")
  end
end
function PaGlobal_RenewDropItem_All:validate()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._stc_titleName:isValidate()
  self._ui._stc_mainCategoryArea:isValidate()
  self._ui._stc_mainCategoryUnderLine:isValidate()
  self._ui._stc_subCategoryArea:isValidate()
  self._ui._btn_subCategoryTemplate:isValidate()
  self._ui._stc_keyGuide_LT:isValidate()
  self._ui._stc_keyGuide_RT:isValidate()
  self._ui._cbx_sortOption:isValidate()
  self._ui._stc_sortOptionList:isValidate()
  self._ui._stc_huntingGroundList:isValidate()
  self._ui._edt_searchEditBox:isValidate()
  self._ui._btn_searchResultClear:isValidate()
  self._ui._stc_searchIcon:isValidate()
  self._ui._stc_tagArea:isValidate()
  self._ui._stc_mainArea:isValidate()
  self._ui._btn_navi:isValidate()
  self._ui._btn_adventure:isValidate()
  self._ui._txt_huntingGroundName:isValidate()
  self._ui._txt_dropRate:isValidate()
  self._ui._txt_needAP:isValidate()
  self._ui._txt_needDP:isValidate()
  self._ui._txt_myAP:isValidate()
  self._ui._txt_myAwakenAP:isValidate()
  self._ui._txt_myDP:isValidate()
  self._ui._frm_dropInfo:isValidate()
  self._ui._frameConent_dropInfo:isValidate()
  self._ui._frameVerticalScroll:isValidate()
  self._ui._stc_dropEquipItemGroup:isValidate()
  self._ui._stc_dropEtcItemGroup:isValidate()
  self._ui._stc_repeatQuestGroup:isValidate()
  self._ui._stc_suddenQuestGroup:isValidate()
  self._ui._stc_knowledgeThemeGroup:isValidate()
  self._ui._stc_titleGroup:isValidate()
  self._ui._stc_keyGuideArea:isValidate()
  self._ui._txt_limitAP:isValidate()
end
function PaGlobal_RenewDropItem_All:prepareOpen(initMainCategoryKey, initSubCategoryKey, initHuntingGroundKey)
  if Panel_Window_DropItem_All == nil then
    return
  end
  self:recalcPanelPosition()
  self:clearSearchResult()
  if initMainCategoryKey ~= nil then
    self:changeMainCategory(initMainCategoryKey)
    if initSubCategoryKey ~= nil then
      self:changeSubCategory(initMainCategoryKey, initSubCategoryKey)
    end
    if initHuntingGroundKey ~= nil then
      self:selectHuntingGroundListContentByKey(initHuntingGroundKey:get(), true)
    end
  elseif self._currentMainCategoryKey ~= nil and self._currentSubCategoryKey ~= nil then
    HandleEventLUp_RenewDropItem_SubCategoryButton(self._currentMainCategoryKey:get(), self._currentSubCategoryKey:get())
  end
  if self._isConsole == false and initMainCategoryKey == nil then
    SetFocusEdit(self._ui._edt_searchEditBox)
  end
  self:updateMyAtkAndDef()
  self:open()
end
function PaGlobal_RenewDropItem_All:open()
  if Panel_Window_DropItem_All == nil then
    return
  end
  Panel_Window_DropItem_All:SetShow(true)
end
function PaGlobal_RenewDropItem_All:prepareClose()
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._ui._stc_sortOptionList:GetShow() == true then
    self._ui._cbx_sortOption:ToggleListbox()
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobalFunc_DropItemImageToolTip_Close()
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    PaGlobalFunc_NotationAbility_CloseIfShow()
  end
  if _ContentsGroup_QuestBackEndLoading == true then
    self:clearQuestLoadingTable()
  end
  self._isWorldMapOpen = false
  self:close()
end
function PaGlobal_RenewDropItem_All:close()
  if Panel_Window_DropItem_All == nil then
    return
  end
  Panel_Window_DropItem_All:SetShow(false)
end
function PaGlobal_RenewDropItem_All:recalcPanelPosition()
  if Panel_Window_DropItem_All == nil then
    return
  end
  local panel = Panel_Window_DropItem_All
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  if self._isConsole == true then
    panelSizeY = panelSizeY + self._ui._stc_keyGuideArea:GetSizeY()
  end
  local calcPosX = screenCenterX - panelSizeX / 2
  local calcPosY = screenCenterY - panelSizeY / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_RenewDropItem_All:onClickedMainCategoryButton(mainCategoryKey)
  if Panel_Window_DropItem_All == nil or mainCategoryKey == nil then
    return
  end
  self:changeMainCategory(mainCategoryKey)
end
function PaGlobal_RenewDropItem_All:onClickedSubCategoryButton(mainCategoryKey, subCategoryKey)
  if Panel_Window_DropItem_All == nil or mainCategoryKey == nil or subCategoryKey == nil then
    return
  end
  self:changeSubCategory(mainCategoryKey, subCategoryKey)
end
function PaGlobal_RenewDropItem_All:getFirstMainCategoryKey()
  if Panel_Window_DropItem_All == nil then
    return nil
  end
  local targetIndex = 0
  local mainCategoryCount = ToClient_getDropUIMainCategoryCount()
  for index = 0, mainCategoryCount - 1 do
    if index == targetIndex then
      return ToClient_getDropUIMainCategoryKey(targetIndex)
    end
  end
  return nil
end
function PaGlobal_RenewDropItem_All:getFirstSubCategoryKey(mainCategoryKey)
  if Panel_Window_DropItem_All == nil or mainCategoryKey == nil then
    return nil
  end
  local targetIndex = 0
  local subCategoryCount = ToClient_getDropUISubCategoryCount(mainCategoryKey)
  for index = 0, subCategoryCount - 1 do
    if index == targetIndex then
      return ToClient_getDropUISubCategoryKey(mainCategoryKey:get(), targetIndex)
    end
  end
  return nil
end
function PaGlobal_RenewDropItem_All:initSortOptionInfo()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._cbx_sortOption:GetListControl():AddSelectEvent("HandleEventLUp_RenewDropItem_SortFilterComboBoxItem()")
  self._ui._cbx_sortOption:DeleteAllItem(0)
  self._ui._cbx_sortOption:setListTextHorizonCenter()
  for index = 0, __eDropUIRegionSortOpion_Name_Count - 1 do
    local buttonString
    if index == __eDropUIRegionSortOpion_Name_Asce then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_FILTER_00")
    elseif index == __eDropUIRegionSortOpion_Name_Desc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_FILTER_01")
    elseif index == __eDropUIRegionSortOpion_Atk_Asce then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_FILTER_02")
    elseif index == __eDropUIRegionSortOpion_Atk_Desc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_FILTER_03")
    else
      UI.ASSERT_NAME(false, "DropUIRegionSortOption\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\133\148\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    if buttonString ~= nil then
      self._ui._cbx_sortOption:AddItem(buttonString)
    end
  end
  self._ui._cbx_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_SortFilterComboBox()")
  local currentSortOptionInfo = ToClient_getDropUICurrentRegionMapSortOption()
  self._ui._cbx_sortOption:SetSelectItemIndex(currentSortOptionInfo)
end
function PaGlobal_RenewDropItem_All:updateTitle()
  local mainCategoryTitle = ""
  if self._currentMainCategoryKey ~= nil then
    for key, value in pairs(self._mainCategoryDataList) do
      if value._key:get() == self._currentMainCategoryKey:get() then
        local mainCategorySSW = ToClient_getDropUIMainCategoryStaticStatusWrapper(value._key)
        if mainCategorySSW ~= nil then
          mainCategoryTitle = mainCategorySSW:getTerritoryName()
        else
          mainCategoryTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_CATEGORY_ALL")
        end
      end
    end
  end
  local subCategoryTitle = ""
  if self._currentSubCategoryKey == nil then
    subCategoryTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_CATEGORY_ALL")
  else
    local subCategorySS = ToClient_getDropUISubCategoryStaticStatusWrapper(self._currentSubCategoryKey)
    if subCategorySS ~= nil then
      subCategoryTitle = subCategorySS:getCategoryName()
    else
      subCategoryTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_CATEGORY_ALL")
    end
  end
  self._ui._stc_titleName:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DROPITEMUI_TITLE_NEW", "region", mainCategoryTitle, "category", subCategoryTitle))
end
function PaGlobal_RenewDropItem_All:changeMainCategory(mainCategoryKey)
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == mainCategoryKey then
    return
  else
    self._currentMainCategoryKey = mainCategoryKey
  end
  if self._currentMainCategoryKey ~= nil then
    for key, value in pairs(self._mainCategoryDataList) do
      if value._key:get() == self._currentMainCategoryKey:get() then
        local underlineSizeX = self._ui._stc_mainCategoryUnderLine:GetSizeX()
        local buttonSizeX = value._buttonControl:GetSizeX()
        local diffSizeX = underlineSizeX - buttonSizeX
        self._ui._stc_mainCategoryUnderLine:SetPosX(value._buttonControl:GetPosX() - diffSizeX / 2)
        self._ui._stc_mainCategoryUnderLine:ComputePos()
        value._buttonControl:SetCheck(true)
      else
        value._buttonControl:SetCheck(false)
      end
    end
  end
  self:changeSubCategory(self._currentMainCategoryKey, self:getFirstSubCategoryKey(self._currentMainCategoryKey))
end
function PaGlobal_RenewDropItem_All:changeSubCategory(mainCategoryKey, subCategoryKey)
  if Panel_Window_DropItem_All == nil or mainCategoryKey == nil or subCategoryKey == nil then
    return
  end
  if self._currentSubCategoryKey == subCategoryKey then
    return
  else
    self._currentSubCategoryKey = subCategoryKey
  end
  self:updateSubCategory()
  self:updateTitle()
end
function PaGlobal_RenewDropItem_All:updateSubCategory()
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  local currentMainCategoryData
  for key, value in pairs(self._mainCategoryDataList) do
    if value._key:get() == self._currentMainCategoryKey:get() then
      currentMainCategoryData = value
      break
    end
  end
  if currentMainCategoryData == nil then
    return
  end
  if self._subCategoryDataList == nil then
    self._subCategoryDataList = Array.new()
  end
  for key, value in pairs(self._subCategoryDataList) do
    if value ~= nil then
      value._mainCategoryKey = nil
      value._key = nil
      value._huntingGroundCount = nil
      if value._buttonControl ~= nil then
        value._buttonControl:SetCheck(false)
        value._buttonControl:SetShow(false)
      end
    end
  end
  local subCategoryBeginPosX = 10
  local offsetPosX = 5
  local subCategoryCount = currentMainCategoryData._subCategoryCount
  local buttonSizeX = self._ui._btn_subCategoryTemplate:GetSizeX()
  local totalButtonSizeX = buttonSizeX * subCategoryCount + offsetPosX * (subCategoryCount + 1)
  local parentSizeX = self._ui._stc_subCategoryArea:GetSizeX()
  subCategoryBeginPosX = (parentSizeX - totalButtonSizeX) / 2
  local template_sizeX = self._ui._btn_subCategoryTemplate:GetSizeX()
  local gapDecoSizeX = 42
  local decoSizeX = self._ui._stc_subCategoryDecoLeft:GetSizeX()
  self._ui._stc_subCategoryDecoLeft:SetPosX(subCategoryBeginPosX - decoSizeX - gapDecoSizeX)
  self._ui._stc_subCategoryDecoRight:SetPosX(subCategoryBeginPosX + totalButtonSizeX + gapDecoSizeX)
  for index = 0, currentMainCategoryData._subCategoryCount - 1 do
    local subCategoryDataIndex = index + 1
    local subCategoryKey = ToClient_getDropUISubCategoryKey(currentMainCategoryData._key:get(), index)
    local subCategorySS = ToClient_getDropUISubCategoryStaticStatusWrapper(subCategoryKey)
    if subCategorySS ~= nil then
      if self._subCategoryDataList[subCategoryDataIndex] == nil then
        local subCategoryDataTemplate = {
          _mainCategoryKey = nil,
          _key = nil,
          _huntingGroundCount = nil,
          _buttonControl = nil,
          _filterIcon = nil
        }
        self._subCategoryDataList[subCategoryDataIndex] = subCategoryDataTemplate
      end
      self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey = currentMainCategoryData._key
      self._subCategoryDataList[subCategoryDataIndex]._key = subCategoryKey
      self._subCategoryDataList[subCategoryDataIndex]._huntingGroundCount = ToClient_getDropUIHuntingGroundCount(currentMainCategoryData._key, subCategoryKey)
      if self._subCategoryDataList[subCategoryDataIndex]._buttonControl == nil then
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl = UI.cloneControl(self._ui._btn_subCategoryTemplate, self._ui._stc_subCategoryArea, "RadioButton_Clone_SubCategory_" .. tostring(subCategoryDataIndex))
      end
      self._subCategoryDataList[subCategoryDataIndex]._filterIcon = UI.getChildControl(self._subCategoryDataList[subCategoryDataIndex]._buttonControl, "Static_FilterIcon")
      self._subCategoryDataList[subCategoryDataIndex]._filterIcon:ChangeTextureInfoTextureIDAsync(subCategorySS:getIconTextureId())
      self._subCategoryDataList[subCategoryDataIndex]._filterIcon:setRenderTexture(self._subCategoryDataList[subCategoryDataIndex]._filterIcon:getBaseTexture())
      self._subCategoryDataList[subCategoryDataIndex]._filterIcon:SetShow(true)
      self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetPosX(self._subCategoryDataList[subCategoryDataIndex]._buttonControl:GetSizeX() * index + offsetPosX * index + subCategoryBeginPosX)
      self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_SubCategoryButton(" .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._key:get()) .. ")")
      self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_SubCategoryButton(true," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(index) .. ")")
      self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_SubCategoryButton(false," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(index) .. ")")
      self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetShow(true)
      if self._currentSubCategoryKey:get() == self._subCategoryDataList[subCategoryDataIndex]._key:get() then
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetCheck(true)
      end
    else
      local staticAllSubCategoryKey = ToClient_getDropUIAllSubCategoryKey()
      if subCategoryKey:get() == staticAllSubCategoryKey:get() then
        if self._subCategoryDataList[subCategoryDataIndex] == nil then
          local subCategoryDataTemplate = {
            _mainCategoryKey = nil,
            _key = nil,
            _huntingGroundCount = nil,
            _buttonControl = nil,
            _filterIcon = nil
          }
          self._subCategoryDataList[subCategoryDataIndex] = subCategoryDataTemplate
        end
        self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey = currentMainCategoryData._key
        self._subCategoryDataList[subCategoryDataIndex]._key = subCategoryKey
        self._subCategoryDataList[subCategoryDataIndex]._huntingGroundCount = ToClient_getDropUIHuntingGroundCount(currentMainCategoryData._key, subCategoryKey)
        if self._subCategoryDataList[subCategoryDataIndex]._buttonControl == nil then
          self._subCategoryDataList[subCategoryDataIndex]._buttonControl = UI.cloneControl(self._ui._btn_subCategoryTemplate, self._ui._stc_subCategoryArea, "RadioButton_Clone_SubCategory_" .. tostring(subCategoryDataIndex))
        end
        self._subCategoryDataList[subCategoryDataIndex]._filterIcon = UI.getChildControl(self._subCategoryDataList[subCategoryDataIndex]._buttonControl, "Static_FilterIcon")
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetPosX(self._subCategoryDataList[subCategoryDataIndex]._buttonControl:GetSizeX() * index + offsetPosX * index + subCategoryBeginPosX)
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_SubCategoryButton(" .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._key:get()) .. ")")
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_SubCategoryButton(true," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(index) .. ")")
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_SubCategoryButton(false," .. tostring(self._subCategoryDataList[subCategoryDataIndex]._mainCategoryKey:get()) .. "," .. tostring(index) .. ")")
        self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetShow(true)
        if self._currentSubCategoryKey:get() == self._subCategoryDataList[subCategoryDataIndex]._key:get() then
          self._subCategoryDataList[subCategoryDataIndex]._buttonControl:SetCheck(true)
        end
      end
    end
  end
  self:updateHuntingGroundList()
end
function PaGlobal_RenewDropItem_All:updateHuntingGroundList()
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  if self._currentSubCategoryKey == nil then
    return
  end
  local currentMainCategoryData
  for key, value in pairs(self._mainCategoryDataList) do
    if value._key:get() == self._currentMainCategoryKey:get() then
      currentMainCategoryData = value
      break
    end
  end
  local currentSubCategoryData
  for key, value in pairs(self._subCategoryDataList) do
    if value._key:get() == self._currentSubCategoryKey:get() then
      currentSubCategoryData = value
      break
    end
  end
  if currentMainCategoryData == nil or currentSubCategoryData == nil then
    return
  end
  local listManager = self._ui._stc_huntingGroundList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for index = 0, currentSubCategoryData._huntingGroundCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  if 0 < currentSubCategoryData._huntingGroundCount then
    self:selectHuntingGroundListContentByIndex(0)
  end
end
function PaGlobal_RenewDropItem_All:createHuntingGroundListContent(content, key)
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  if self._currentSubCategoryKey == nil then
    return
  end
  local huntingGroundIndex = Int64toInt32(key)
  local huntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, huntingGroundIndex)
  local huntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  local btn_radio = UI.getChildControl(content, "RadioButton_RegionName")
  if self._currentHuntingGroundKey ~= nil and self._currentHuntingGroundKey:get() == huntingGroundKey:get() then
    btn_radio:SetCheck(true)
  else
    btn_radio:SetCheck(false)
  end
  btn_radio:EraseAllEffect()
  if self._searchResultTable ~= nil then
    for srKey, srValue in pairs(self._searchResultTable) do
      if srValue._isItem == false and srValue._listContentKey == key and srValue._huntingGroundKeyRaw == huntingGroundKey:get() then
        btn_radio:AddEffect("fUI_inGame_Light_06A", true, 0, 0)
      end
    end
  end
  if huntingGroundSS ~= nil then
    local myMainCategoryKey = huntingGroundSS:getMainCategoryKey()
    local mySubCategoryCount = huntingGroundSS:getSubCategoryCount()
    local subCategoryCountMax = ToClient_getDropUISubCategoryMaxCount()
    for index = 0, subCategoryCountMax - 1 do
      local icon = UI.getChildControl(btn_radio, "Static_SubCategoryIcon_" .. index)
      if icon ~= nil then
        icon:SetShow(false)
      end
    end
    local lastIconPosX = 0
    for index = 0, mySubCategoryCount - 1 do
      local mySubCategoryKey = huntingGroundSS:getSubCategoryKeyByIndex(index)
      local mySubCategorySS = ToClient_getDropUISubCategoryStaticStatusWrapper(mySubCategoryKey)
      local icon = UI.getChildControl(btn_radio, "Static_SubCategoryIcon_" .. index)
      if mySubCategorySS ~= nil and icon ~= nil and icon ~= nil then
        icon:ChangeTextureInfoTextureIDAsync(mySubCategorySS:getIconTextureId())
        icon:setRenderTexture(icon:getBaseTexture())
        icon:SetShow(true)
        lastIconPosX = icon:GetSpanSize().x + icon:GetSizeX()
      end
    end
    if lastIconPosX == 0 then
      btn_radio:SetTextSpanRB(float2(self._originalRegionContentNameSpanRBX, 0))
    else
      btn_radio:SetTextSpanRB(float2(self._originalRegionContentNameSpanRBX + lastIconPosX, 0))
    end
    btn_radio:SetText(huntingGroundSS:getName())
    btn_radio:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_HuntingGroundButton(" .. tostring(huntingGroundKey:get()) .. ")")
    if self._isConsole == true then
      btn_radio:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventDPadRight_RenewDropItem_HuntingGroundButton()")
    end
  end
end
function PaGlobal_RenewDropItem_All:selectHuntingGroundListContentByIndex(index)
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  if self._currentSubCategoryKey == nil then
    return
  end
  local listManager = self._ui._stc_huntingGroundList:getElementManager()
  if listManager == nil then
    return
  end
  local selectedHuntingGroundKey
  local currentHuntingGroundContentListSize = Int64toInt32(listManager:getSize())
  for listIndex = 0, currentHuntingGroundContentListSize - 1 do
    local s64_key = self._ui._stc_huntingGroundList:getKeyByIndex(listIndex)
    local content = self._ui._stc_huntingGroundList:GetContentByKey(s64_key)
    local isSelectedContent = false
    if listIndex == index then
      isSelectedContent = true
      selectedHuntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, Int64toInt32(s64_key))
    end
    if content ~= nil then
      local btn = UI.getChildControl(content, "RadioButton_RegionName")
      btn:SetCheck(isSelectedContent)
      if (self._isConsole == true or ToClient_isUsePadSnapping() == true) and listIndex == 0 then
        topControl = btn
      end
    end
  end
  if (self._isConsole == true or ToClient_isUsePadSnapping() == true) and topControl ~= nil then
    ToClient_padSnapChangeToTarget(topControl)
  end
  if self._currentHuntingGroundKey == selectedHuntingGroundKey then
    return
  else
    self._currentHuntingGroundKey = selectedHuntingGroundKey
  end
  self:updateHuntingGroundDetailInfo(true)
end
function PaGlobal_RenewDropItem_All:selectHuntingGroundListContentByKey(huntingGroundKeyRaw, doCheckList)
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  if self._currentSubCategoryKey == nil then
    return
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  if self._currentHuntingGroundKey == huntingGroundKey then
    return
  else
    self._currentHuntingGroundKey = huntingGroundKey
  end
  if doCheckList ~= nil and doCheckList == true then
    local listManager = self._ui._stc_huntingGroundList:getElementManager()
    if listManager == nil then
      return
    end
    local currentContentCount = Int64toInt32(listManager:getSize())
    for index = 0, currentContentCount - 1 do
      local s64_key = self._ui._stc_huntingGroundList:getKeyByIndex(index)
      local content = self._ui._stc_huntingGroundList:GetContentByKey(s64_key)
      if content ~= nil then
        local btn = UI.getChildControl(content, "RadioButton_RegionName")
        local btn_huntingGroundIndex = Int64toInt32(s64_key)
        local btn_huntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, btn_huntingGroundIndex)
        if btn_huntingGroundKey ~= nil then
          if btn_huntingGroundKey:get() == huntingGroundKeyRaw then
            btn:SetCheck(true)
            if self._isConsole == true then
              ToClient_padSnapChangeToTarget(btn)
            end
          else
            btn:SetCheck(false)
          end
        end
      end
    end
  end
  self:updateHuntingGroundDetailInfo(true)
end
function PaGlobal_RenewDropItem_All:updateMyAtkAndDef()
  if Panel_Window_DropItem_All == nil then
    return 0, 0, 0
  end
  if self._initialize == false then
    return 0, 0, 0
  end
  local currnetMyAtk = 0
  local currentMyAwakenAtk = 0
  local currentMyDef = 0
  local doUpdateColor = false
  if _ContentsGroup_RenewCharacterStatusViewMode == true and PaGlobalFunc_NotationAbility_IsLateInitialized ~= nil and PaGlobalFunc_NotationAbility_IsLateInitialized() == true then
    local viewType = ToClient_GetNotationAbilityOption_ViewType()
    self._ui._chk_detailInfo:SetCheck(viewType == __eUINotationAbilityViewType_Total)
    currnetMyAtk = PaGlobalFunc_NotationAbility_GetMyAtk()
    currentMyAwakenAtk = PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
    currentMyDef = PaGlobalFunc_NotationAbility_GetMyDef()
    doUpdateColor = true
  elseif self._ui._chk_detailInfo:IsCheck() == true then
    currnetMyAtk = ToClient_getAttToClient_getAttackOffenceAll(__eSkillTypeParam_Succession, false, __eNewTribeType_Count, false)
    currentMyAwakenAtk = ToClient_getAttToClient_getAttackOffenceAll(__eSkillTypeParam_Awaken, false, __eNewTribeType_Count, false)
    currentMyDef = ToClient_getAttackDefenceAll(true)
  else
    currnetMyAtk = ToClient_getOffence()
    currentMyAwakenAtk = ToClient_getAwakenOffence()
    currentMyDef = ToClient_getDefence()
  end
  if doUpdateColor == true then
    local fontColor = PaGlobalFunc_NotationAbility_GetFontColor()
    local glowFontColor = PaGlobalFunc_NotationAbility_GetGlowFontColor()
    local iconColor = PaGlobalFunc_NotationAbility_GetIconColor()
    local iconAP = UI.getChildControl(self._ui._txt_myAP, "Static_Icon")
    local iconAwakenAP = UI.getChildControl(self._ui._txt_myAwakenAP, "Static_Icon")
    local iconDP = UI.getChildControl(self._ui._txt_myDP, "Static_Icon")
    self._ui._txt_myAP:SetFontColor(fontColor)
    self._ui._txt_myAP:useGlowFont(true, "RealFont_17_Base", glowFontColor)
    self._ui._txt_myAwakenAP:SetFontColor(fontColor)
    self._ui._txt_myAwakenAP:useGlowFont(true, "RealFont_17_Base", glowFontColor)
    self._ui._txt_myDP:SetFontColor(fontColor)
    self._ui._txt_myDP:useGlowFont(true, "RealFont_17_Base", glowFontColor)
    iconAP:SetColor(iconColor)
    iconAwakenAP:SetColor(iconColor)
    iconDP:SetColor(iconColor)
    self._ui._stc_needAP:SetColor(iconColor)
    self._ui._stc_needDP:SetColor(iconColor)
  end
  self._ui._txt_myAP:SetText(currnetMyAtk)
  self._ui._txt_myAwakenAP:SetText(currentMyAwakenAtk)
  self._ui._txt_myDP:SetText(currentMyDef)
  return currnetMyAtk, currentMyAwakenAtk, currentMyDef
end
function PaGlobal_RenewDropItem_All:updateHuntingGroundDetailInfo(doResetFrameScroll)
  if Panel_Window_DropItem_All == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    _PA_ASSERT(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \235\169\148\236\157\184 \236\185\180\237\133\140\234\179\160\235\166\172 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!")
    return
  end
  if self._currentSubCategoryKey == nil then
    _PA_ASSERT(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \236\132\156\235\184\140 \236\185\180\237\133\140\234\179\160\235\166\172 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!")
    return
  end
  if self._currentHuntingGroundKey == nil then
    self._currentHuntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, 0)
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    _PA_ASSERT(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \236\130\172\235\131\165\237\132\176\236\157\152 StaticStatus \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!")
    return
  end
  self._ui._txt_huntingGroundName:SetSize(self._originalRegionNameSizeX, self._ui._txt_huntingGroundName:GetSizeY())
  self._ui._txt_huntingGroundName:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_huntingGroundName:SetText(currentHuntingGroundSS:getName())
  self._ui._txt_huntingGroundName:SetSize(self._ui._txt_huntingGroundName:GetTextSizeX(), self._ui._txt_huntingGroundName:GetSizeY())
  if currentHuntingGroundSS:isHaveNaviPosition() == true then
    self._ui._btn_navi:SetShow(true)
    self._ui._btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_FindHuntingGroundNavigation(" .. tostring(self._currentHuntingGroundKey:get()) .. ")")
  elseif currentHuntingGroundSS:isHaveRegionInfo() == true then
    local firstRegionKeyRaw = currentHuntingGroundSS:getRegionKeyRawByIndex(0)
    local regionInfo = getRegionInfoWrapper(firstRegionKeyRaw)
    if regionInfo == nil then
      UI.ASSERT_NAME(false, "regionInfoWrapper\234\176\128 nil\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    if regionInfo:hasBaseWaypoint() == true then
      self._ui._btn_navi:SetShow(true)
      self._ui._btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_FindHuntingGroundNavigation(" .. tostring(self._currentHuntingGroundKey:get()) .. ")")
    else
      self._ui._btn_navi:SetShow(false)
      self._ui._btn_navi:addInputEvent("Mouse_LUp", "")
    end
  else
    self._ui._btn_navi:SetShow(false)
    self._ui._btn_navi:addInputEvent("Mouse_LUp", "")
  end
  if self._ui._btn_navi:GetShow() == true then
    self._ui._btn_navi:SetPosX(self._ui._txt_huntingGroundName:GetPosX() + self._ui._txt_huntingGroundName:GetSizeX() + 10)
  end
  local urlSS = ToClient_getDropUIHuntingGroundURLStaticStatusWrapper(self._currentHuntingGroundKey)
  if urlSS ~= nil and _ContentsGroup_ExpirienceWiki_All == true then
    self._ui._btn_adventure:SetShow(true)
    self._ui._btn_adventure:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_OpenAdventureNote(" .. tostring(self._currentHuntingGroundKey:get()) .. ")")
  else
    self._ui._btn_adventure:SetShow(false)
    self._ui._btn_adventure:addInputEvent("Mouse_LUp", "")
  end
  if self._ui._btn_adventure:GetShow() == true then
    if self._ui._btn_navi:GetShow() == true then
      self._ui._btn_adventure:SetPosX(self._ui._btn_navi:GetPosX() + self._ui._btn_navi:GetSizeX() + 5)
    else
      self._ui._btn_adventure:SetPosX(self._ui._txt_huntingGroundName:GetPosX() + self._ui._txt_huntingGroundName:GetSizeX() + 10)
    end
  end
  local currnetMyAtk, currentMyAwakenAtk, currentMyDef = self:updateMyAtkAndDef()
  local isDetailView = self._ui._chk_detailInfo:IsCheck()
  local recommendedAtk = 0
  if isDetailView == true then
    recommendedAtk = currentHuntingGroundSS:getNeedDD()
  else
    recommendedAtk = currentHuntingGroundSS:getOffensePoint()
  end
  local attFontColorString
  if currnetMyAtk >= recommendedAtk or currentMyAwakenAtk >= recommendedAtk then
    attFontColorString = "<PAColor0xff6cf000>"
  else
    attFontColorString = "<PAColor0xffd05d48>"
  end
  self._ui._txt_needAP:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DROPITEM_DESC_ATT", "att", attFontColorString .. tostring(recommendedAtk) .. "<PAOldColor>"))
  self._ui._txt_needAP:SetSize(self._ui._txt_needAP:GetTextSizeX(), self._ui._txt_needAP:GetSizeY())
  local recommendedDef = 0
  if isDetailView == true then
    recommendedDef = currentHuntingGroundSS:getNeedPV()
  else
    recommendedDef = currentHuntingGroundSS:getDefensePoint()
  end
  local defFontColorString
  if currentMyDef >= recommendedDef then
    defFontColorString = "<PAColor0xff6cf000>"
  else
    defFontColorString = "<PAColor0xffd05d48>"
  end
  self._ui._txt_needDP:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DROPITEM_DESC_DFF", "dff", defFontColorString .. tostring(recommendedDef) .. "<PAOldColor>"))
  self._ui._txt_needDP:SetSize(self._ui._txt_needDP:GetTextSizeX(), self._ui._txt_needDP:GetSizeY())
  if _ContentsGroup_Max_Att == true then
    local limitedAP = currentHuntingGroundSS:getLimitedAP()
    local LAPApplyPercent = currentHuntingGroundSS:getLAPApplyPercent()
    if isDetailView == true and limitedAP ~= 0 then
      self._ui._txt_limitAP:SetShow(true)
      local limitApColorString
      if currnetMyAtk <= limitedAP or currentMyAwakenAtk <= limitedAP then
        limitApColorString = "<PAColor0xfff5ba3a>" .. tostring(limitedAP) .. "<PAOldColor>"
      else
        limitApColorString = "<PAColor0xffffedd4>" .. tostring(limitedAP) .. "<PAOldColor>"
      end
      self._ui._txt_limitAP:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DROPINFO_MAXAP_NONE_PERCENT", "appoint", limitApColorString))
      self._ui._stc_limitAPIcon:SetEnableArea(0, 0, self._ui._stc_limitAPIcon:GetSizeX() + self._ui._txt_limitAP:GetTextSizeX() + 10, self._ui._stc_limitAPIcon:GetSizeY())
      self._ui._stc_limitAPIcon:addInputEvent("Mouse_On", "PaGlobal_RenewDropItem_All:onOutHandlerLimitedAPUI(true, " .. LAPApplyPercent .. "," .. limitedAP .. ")")
      self._ui._stc_limitAPIcon:addInputEvent("Mouse_Out", "PaGlobal_RenewDropItem_All:onOutHandlerLimitedAPUI(false)")
    else
      self._ui._txt_limitAP:SetShow(false)
    end
  else
    self._ui._txt_limitAP:SetShow(false)
  end
  local defIcon = UI.getChildControl(self._ui._txt_needDP, "Static_Icon")
  local atkAndDefIconTermX = defIcon:GetSizeX() + 20
  self._ui._txt_needDP:SetPosX(self._ui._txt_needAP:GetPosX() + self._ui._txt_needAP:GetSizeX() + atkAndDefIconTermX)
  self._ui._stc_tagArea:SetShow(false)
  for key, value in pairs(self._tagIconList) do
    if value ~= nil then
      value.tagControl:SetShow(false)
      value.tagControl:addInputEvent("Mouse_On", "")
      value.tagControl:addInputEvent("Mouse_Out", "")
    end
  end
  local tagCount = currentHuntingGroundSS:getTagCount()
  for index = 0, tagCount - 1 do
    local tagKey = currentHuntingGroundSS:getTagKeyByIndex(index)
    local tagSSW = ToClient_getDropUITagStaticStatusWrapper(tagKey)
    if tagSSW ~= nil then
      if self._tagIconList[index] == nil then
        UI.ASSERT_NAME(false, "\236\130\172\235\131\165\237\132\176 \236\160\149\235\179\180 UI - \237\131\156\234\183\184 \236\149\132\236\157\180\236\189\152\236\157\180 \235\182\128\236\161\177\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
        return
      end
      self._tagIconList[index].tagControl:SetShow(true)
      self._tagIconList[index].tagControl:SetColor(tagSSW:getTextureColor())
      self._tagIconList[index].tagControl:SetFontColor(tagSSW:getFontColor())
      self._tagIconList[index].tagControl:SetText(tagSSW:getTagString())
      self._tagIconList[index].tagControl:SetSize(self._tagIconList[index].tagControl:GetTextSizeX() + 25, self._tagIconList[index].tagControl:GetSizeY())
      local isHaveTagGuideTexture = tagSSW:isExistGuideTextureId()
      if isHaveTagGuideTexture == true then
        if tagSSW:getTagTooltipDescString() ~= nil and tagSSW:getTagTooltipDescString() ~= "" then
          self._tagIconList[index].tagControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_TagDetailInfo(true," .. tostring(index) .. ")")
          self._tagIconList[index].tagControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_TagDetailInfo(false," .. tostring(index) .. ")")
        end
      elseif tagSSW:getTagTooltipDescString() ~= nil and tagSSW:getTagTooltipDescString() ~= "" then
        self._tagIconList[index].tagControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_TagInfo(true," .. tostring(index) .. ")")
        self._tagIconList[index].tagControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_TagInfo(false," .. tostring(index) .. ")")
      end
      self._tagIconList[index].tagControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_TagInfo(" .. tostring(index) .. ")")
      local beginSpanX = 10
      local termXY = 5
      local prevTagIcon = self._tagIconList[index - 1]
      if prevTagIcon == nil then
        self._tagIconList[index].tagControl:SetSpanSize(beginSpanX, 0)
      else
        self._tagIconList[index].tagControl:SetSpanSize(prevTagIcon.tagControl:GetPosX() + prevTagIcon.tagControl:GetSizeX() + termXY, prevTagIcon.tagControl:GetPosY())
        local parentSizeX = self._ui._stc_tagArea:GetSizeX()
        if parentSizeX < self._tagIconList[index].tagControl:GetPosX() + self._tagIconList[index].tagControl:GetSizeX() then
          self._tagIconList[index].tagControl:SetSpanSize(beginSpanX, prevTagIcon.tagControl:GetPosY() + prevTagIcon.tagControl:GetSizeY() + termXY)
        end
      end
      if self._ui._stc_tagArea:GetShow() == false then
        self._ui._stc_tagArea:SetShow(true)
      end
      self._ui._stc_tagArea:SetSize(self._ui._stc_tagArea:GetSizeX(), self._tagIconList[index].tagControl:GetPosY() + self._tagIconList[index].tagControl:GetSizeY())
    end
  end
  self._ui._stc_dropEquipItemGroup:SetShow(false)
  self._ui._stc_dropEtcItemGroup:SetShow(false)
  self._ui._stc_repeatQuestGroup:SetShow(false)
  self._ui._stc_suddenQuestGroup:SetShow(false)
  self._ui._stc_knowledgeThemeGroup:SetShow(false)
  self._ui._stc_titleGroup:SetShow(false)
  if self._dropEquipableItemIconList == nil then
    self._dropEquipableItemIconList = Array.new()
  end
  if self._dropEtcItemIconList == nil then
    self._dropEtcItemIconList = Array.new()
  end
  for key, value in pairs(self._dropEquipableItemIconList) do
    if value ~= nil then
      value.boxControl:SetShow(false)
      value.itemSlot:clearItem()
      value.itemSlot.icon:addInputEvent("Mouse_On", "")
      value.itemSlot.icon:addInputEvent("Mouse_Out", "")
    end
  end
  for key, value in pairs(self._dropEtcItemIconList) do
    if value ~= nil then
      value.boxControl:SetShow(false)
      value.itemSlot:clearItem()
      value.itemSlot.icon:addInputEvent("Mouse_On", "")
      value.itemSlot.icon:addInputEvent("Mouse_Out", "")
    end
  end
  local dropEquipableItemIndex = 0
  local dropEtcItemIndex = 0
  local dropItemCount = currentHuntingGroundSS:getDropItemCount()
  for index = 0, dropItemCount - 1 do
    local isSearchedItem = false
    if self._searchResultTable ~= nil then
      for srKey, srValue in pairs(self._searchResultTable) do
        if srValue._huntingGroundKeyRaw == self._currentHuntingGroundKey:get() and srValue._isItem == true and srValue._dropItemIndex == index then
          isSearchedItem = true
          break
        end
      end
    end
    local dropItemSSW = currentHuntingGroundSS:getDropItemStaticStatusWrapper(index)
    if dropItemSSW ~= nil then
      if dropItemSSW:isEquipable() == true then
        if self._dropEquipableItemIconList[dropEquipableItemIndex] == nil then
          self._dropEquipableItemIconList[dropEquipableItemIndex] = self:makeDropItemIcon(self._ui._stc_dropEquipItemGroup, "Static_EquipableItem_Icon_" .. dropEquipableItemIndex, dropEquipableItemIndex)
        end
        self._dropEquipableItemIconList[dropEquipableItemIndex].boxControl:SetShow(true)
        self._dropEquipableItemIconList[dropEquipableItemIndex].itemSlot:setItemByStaticStatus(dropItemSSW)
        self._dropEquipableItemIconList[dropEquipableItemIndex].itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_DropItemIcon(true," .. tostring(self._currentHuntingGroundKey:get()) .. "," .. tostring(index) .. "," .. tostring(dropEquipableItemIndex) .. ")")
        if self._isConsole == true then
          self._dropEquipableItemIconList[dropEquipableItemIndex].boxControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_RenewDropItem_DropItemIconForConsole(true," .. tostring(self._currentHuntingGroundKey:get()) .. "," .. tostring(index) .. "," .. tostring(dropEquipableItemIndex) .. ")")
          self._dropEquipableItemIconList[dropEquipableItemIndex].boxControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_DropItemIcon(false)")
        else
          self._dropEquipableItemIconList[dropEquipableItemIndex].itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_DropItemIcon(false)")
        end
        if self._ui._stc_dropEquipItemGroup:GetShow() == false then
          self._ui._stc_dropEquipItemGroup:SetShow(true)
        end
        self._ui._stc_dropEquipItemGroup:SetSize(self._ui._stc_dropEquipItemGroup:GetSizeX(), self._dropEquipableItemIconList[dropEquipableItemIndex].boxControl:GetPosY() + self._dropEquipableItemIconList[dropEquipableItemIndex].boxControl:GetSizeY())
        self._dropEquipableItemIconList[dropEquipableItemIndex].itemSlot.icon:EraseAllEffect()
        if isSearchedItem == true then
          self._dropEquipableItemIconList[dropEquipableItemIndex].itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        end
        dropEquipableItemIndex = dropEquipableItemIndex + 1
      else
        if self._dropEtcItemIconList[dropEtcItemIndex] == nil then
          self._dropEtcItemIconList[dropEtcItemIndex] = self:makeDropItemIcon(self._ui._stc_dropEtcItemGroup, "Static_EtcItem_Icon_" .. dropEtcItemIndex, dropEtcItemIndex)
        end
        self._dropEtcItemIconList[dropEtcItemIndex].boxControl:SetShow(true)
        self._dropEtcItemIconList[dropEtcItemIndex].itemSlot:setItemByStaticStatus(dropItemSSW)
        self._dropEtcItemIconList[dropEtcItemIndex].itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_DropItemIcon(true," .. tostring(self._currentHuntingGroundKey:get()) .. "," .. tostring(index) .. "," .. tostring(dropEtcItemIndex) .. ")")
        if self._isConsole == true then
          self._dropEtcItemIconList[dropEtcItemIndex].boxControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_RenewDropItem_DropItemIconForConsole(true," .. tostring(self._currentHuntingGroundKey:get()) .. "," .. tostring(index) .. "," .. tostring(dropEtcItemIndex) .. ")")
          self._dropEtcItemIconList[dropEtcItemIndex].boxControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_DropItemIcon(false)")
        else
          self._dropEtcItemIconList[dropEtcItemIndex].itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_DropItemIcon(false)")
        end
        if self._ui._stc_dropEtcItemGroup:GetShow() == false then
          self._ui._stc_dropEtcItemGroup:SetShow(true)
        end
        self._ui._stc_dropEtcItemGroup:SetSize(self._ui._stc_dropEtcItemGroup:GetSizeX(), self._dropEtcItemIconList[dropEtcItemIndex].boxControl:GetPosY() + self._dropEtcItemIconList[dropEtcItemIndex].boxControl:GetSizeY())
        self._dropEtcItemIconList[dropEtcItemIndex].itemSlot.icon:EraseAllEffect()
        if isSearchedItem == true then
          self._dropEtcItemIconList[dropEtcItemIndex].itemSlot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        end
        dropEtcItemIndex = dropEtcItemIndex + 1
      end
    end
  end
  if self._dropRepeatQuestIconList == nil then
    self._dropRepeatQuestIconList = Array.new()
  end
  for key, value in pairs(self._dropRepeatQuestIconList) do
    if value ~= nil then
      value.boxControl:SetShow(false)
      value.boxControl:addInputEvent("Mouse_LUp", "")
      value.boxControl:addInputEvent("Mouse_On", "")
      value.boxControl:addInputEvent("Mouse_Out", "")
      value.clearControl:SetShow(false)
      value.npcNameControl:SetShow(false)
      value.loadingControl:SetShow(false)
      value.imageBackControl:SetShow(false)
      value.imageControl:SetShow(false)
      value.titleControl:SetShow(false)
    end
  end
  local repeatQuestCount = currentHuntingGroundSS:getRepeatQuestCount()
  for index = 0, repeatQuestCount - 1 do
    local repeatQuestNo = currentHuntingGroundSS:getRepeatQuestNoByIndex(index)
    local repeatQuestSSW = questList_getQuestStatic(repeatQuestNo._group, repeatQuestNo._quest)
    if repeatQuestSSW ~= nil then
      if self._dropRepeatQuestIconList[index] == nil then
        self._dropRepeatQuestIconList[index] = self:makeRepeatQuestIcon(self._ui._stc_repeatQuestGroup, "Static_RepeatQuest_Icon_" .. index, index)
      end
      self._dropRepeatQuestIconList[index].boxControl:SetShow(true)
      if repeatQuestSSW:isHaveBackEndData() == true then
        self._dropRepeatQuestIconList[index].titleControl:SetTextMode(__eTextMode_Limit_AutoWrap)
        self._dropRepeatQuestIconList[index].titleControl:setLineCountByLimitAutoWrap(1)
        self._dropRepeatQuestIconList[index].titleControl:SetText(ToClient_getReplaceDialog(repeatQuestSSW:getTitle()))
        self._dropRepeatQuestIconList[index].titleControl:SetShow(true)
        self._dropRepeatQuestIconList[index].imageControl:ChangeTextureInfoNameAsync(repeatQuestSSW:getIconPath())
        self._dropRepeatQuestIconList[index].imageControl:SetShow(true)
        self._dropRepeatQuestIconList[index].imageBackControl:SetShow(true)
        local acceptNpcKey = repeatQuestSSW:getAccecptNpc()
        local acceptNpcSSW = ToClient_GetCharacterStaticStatusWrapper(acceptNpcKey:get())
        if acceptNpcSSW ~= nil then
          self._dropRepeatQuestIconList[index].npcNameControl:SetTextMode(__eTextMode_LimitText)
          self._dropRepeatQuestIconList[index].npcNameControl:SetText(acceptNpcSSW:getName())
          self._dropRepeatQuestIconList[index].npcNameControl:SetShow(true)
        end
        if questList_isClearQuest(repeatQuestNo._group, repeatQuestNo._quest) == true then
          self._dropRepeatQuestIconList[index].clearControl:SetShow(true)
        end
        self._dropRepeatQuestIconList[index].loadingControl:SetShow(false)
        self._dropRepeatQuestIconList[index].boxControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_RepeatQuest(" .. tostring(repeatQuestNo._group) .. "," .. tostring(repeatQuestNo._quest) .. ")")
        self._dropRepeatQuestIconList[index].boxControl:addInputEvent("Mouse_On", "HandleEventOnOut_RenewDropItem_RepeatQuest(true," .. tostring(index) .. ")")
        self._dropRepeatQuestIconList[index].boxControl:addInputEvent("Mouse_Out", "HandleEventOnOut_RenewDropItem_RepeatQuest(false," .. tostring(index) .. ")")
      else
        self._dropRepeatQuestIconList[index].loadingControl:SetShow(true)
        self:pushQuestLoadingData(repeatQuestSSW, self._currentHuntingGroundKey:get())
      end
      if self._ui._stc_repeatQuestGroup:GetShow() == false then
        self._ui._stc_repeatQuestGroup:SetShow(true)
      end
      self._ui._stc_repeatQuestGroup:SetSize(self._ui._stc_repeatQuestGroup:GetSizeX(), self._dropRepeatQuestIconList[index].boxControl:GetPosY() + self._dropRepeatQuestIconList[index].boxControl:GetSizeY())
    end
  end
  if self._dropSuddenQuestIconList == nil then
    self._dropSuddenQuestIconList = Array.new()
  end
  for key, value in pairs(self._dropSuddenQuestIconList) do
    if value ~= nil then
      value.boxControl:SetShow(false)
      value.imageBackControl:SetShow(false)
      value.imageControl:SetShow(false)
      value.titleControl:SetShow(false)
      value.clearControl:SetShow(false)
      value.conditionControl:SetShow(false)
      value.seasonIconControl:SetShow(false)
      value.progressBackControl:SetShow(false)
      value.progressBarControl:SetShow(false)
      value.progressBarControl:SetProgressRate(0)
      value.loadingControl:SetShow(false)
    end
  end
  local acceptSuddenQuestIndex = 0
  local suddenQuestCount = currentHuntingGroundSS:getSuddenQuestCount()
  for index = 0, suddenQuestCount - 1 do
    local suddenQuestNo = currentHuntingGroundSS:getSuddenQuestNoByIndex(index)
    local isClearQuest = questList_isClearQuest(suddenQuestNo._group, suddenQuestNo._quest)
    local isProgressQuest = ToClient_isProgressingQuest(suddenQuestNo._group, suddenQuestNo._quest)
    local isSatisfied = ToClient_isSatisfiedCondions(suddenQuestNo._group, suddenQuestNo._quest)
    local suddenQuestSSW = questList_getQuestStatic(suddenQuestNo._group, suddenQuestNo._quest)
    if suddenQuestSSW ~= nil then
      if self._dropSuddenQuestIconList[acceptSuddenQuestIndex] == nil then
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex] = self:makeSuddenQuestIcon(self._ui._stc_suddenQuestGroup, "Static_SuddenQuest_Icon_" .. acceptSuddenQuestIndex, acceptSuddenQuestIndex)
      end
      self._dropSuddenQuestIconList[acceptSuddenQuestIndex].boxControl:SetShow(true)
      if suddenQuestSSW:isHaveBackEndData() == true then
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].titleControl:SetTextMode(__eTextMode_Limit_AutoWrap)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].titleControl:setLineCountByLimitAutoWrap(1)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].titleControl:SetText(ToClient_getReplaceDialog(suddenQuestSSW:getTitle()))
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].titleControl:SetShow(true)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].imageControl:ChangeTextureInfoNameAsync(suddenQuestSSW:getIconPath())
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].imageControl:SetShow(true)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].imageBackControl:SetShow(true)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].seasonIconControl:SetShow(suddenQuestSSW:isSeasonPassType())
        local questInfo = ToClient_GetQuestInfo(suddenQuestNo._group, suddenQuestNo._quest)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBarControl:SetShow(true)
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBackControl:SetShow(true)
        if isClearQuest == true then
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].clearControl:SetShow(true)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetShow(false)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBarControl:SetProgressRate(100)
        elseif isSatisfied == true then
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].clearControl:SetShow(true)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetShow(false)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBarControl:SetProgressRate(100)
        elseif questInfo ~= nil and isProgressQuest == true then
          local questConditionWrapper = questInfo:getDemandAt(0)
          local currentCondition = questConditionWrapper._currentCount
          local maxCondition = questConditionWrapper._destCount
          local progressRate = currentCondition / maxCondition
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetShow(true)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetText("(" .. tostring(currentCondition) .. "/" .. tostring(maxCondition) .. ")")
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBarControl:SetProgressRate(progressRate * 100)
        else
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetShow(true)
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].conditionControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMDROP_SUDDENQUEST_DESC"))
          self._dropSuddenQuestIconList[acceptSuddenQuestIndex].progressBarControl:SetProgressRate(0)
        end
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].loadingControl:SetShow(false)
      else
        self._dropSuddenQuestIconList[acceptSuddenQuestIndex].loadingControl:SetShow(true)
        self:pushQuestLoadingData(suddenQuestSSW, self._currentHuntingGroundKey:get())
      end
      if self._ui._stc_suddenQuestGroup:GetShow() == false then
        self._ui._stc_suddenQuestGroup:SetShow(true)
      end
      self._ui._stc_suddenQuestGroup:SetSize(self._ui._stc_suddenQuestGroup:GetSizeX(), self._dropSuddenQuestIconList[acceptSuddenQuestIndex].boxControl:GetPosY() + self._dropSuddenQuestIconList[acceptSuddenQuestIndex].boxControl:GetSizeY())
      acceptSuddenQuestIndex = acceptSuddenQuestIndex + 1
    end
  end
  if self._dropKnowledgeIconList == nil then
    self._dropKnowledgeIconList = Array.new()
  end
  for key, value in pairs(self._dropKnowledgeIconList) do
    if value ~= nil then
      value.buttonControl:SetShow(false)
      value.buttonControl:addInputEvent("Mouse_LUp", "")
      value.clearControl:SetShow(false)
      value.progressBarControl:SetProgressRate(0)
    end
  end
  local mentalThemeCount = currentHuntingGroundSS:getDropKnowledgeCount()
  for index = 0, mentalThemeCount - 1 do
    local mentalThemeSSW = currentHuntingGroundSS:getDropMentalThemeStaticStatusWrapper(index)
    if mentalThemeSSW ~= nil then
      if self._dropKnowledgeIconList[index] == nil then
        self._dropKnowledgeIconList[index] = self:makeKnowledThemeIcon(self._ui._stc_knowledgeThemeGroup, "Static_MentalTheme_Icon_" .. index, index)
      end
      self._dropKnowledgeIconList[index].buttonControl:SetShow(true)
      self._dropKnowledgeIconList[index].buttonControl:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._dropKnowledgeIconList[index].buttonControl:setLineCountByLimitAutoWrap(1)
      self._dropKnowledgeIconList[index].buttonControl:SetText(mentalThemeSSW:getName())
      local currentValue = mentalThemeSSW:getLearndMentalCardCount()
      local maxValue = mentalThemeSSW:getMentalThemeChildCardCountFromAllDataForDropUI()
      local ratio = currentValue / maxValue
      local needCount1 = mentalThemeSSW:getWpNeedCount()
      local addWp1 = mentalThemeSSW:getIncreaseMaxWp()
      local needCount2 = mentalThemeSSW:getWpNeedCount2()
      local addWp2 = mentalThemeSSW:getIncreaseMaxWp2()
      local addWpMax = 0
      local addWpString
      if addWp1 < addWp2 then
        addWpMax = addWp2
      else
        addWpMax = addWp1
      end
      if addWpMax ~= 0 then
        if currentValue >= needCount2 then
          addWpString = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_TalkingPowerUp", "increaseWp", tostring(addWp2) .. "/" .. tostring(addWpMax))
        elseif currentValue >= needCount1 then
          addWpString = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_TalkingPowerUp", "increaseWp", tostring(addWp1) .. "/" .. tostring(addWpMax))
        else
          addWpString = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_TalkingPowerUp", "increaseWp", "0/" .. tostring(addWpMax))
        end
      end
      if addWpString == nil then
        self._dropKnowledgeIconList[index].conditionTextControl:SetText(tostring(currentValue) .. "/" .. tostring(maxValue))
      else
        self._dropKnowledgeIconList[index].conditionTextControl:SetText(tostring(currentValue) .. "/" .. tostring(maxValue) .. " " .. addWpString)
      end
      self._dropKnowledgeIconList[index].progressBarControl:SetProgressRate(ratio * 100)
      if currentValue == maxValue then
        self._dropKnowledgeIconList[index].clearControl:SetShow(true)
      end
      self._dropKnowledgeIconList[index].buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_KnowledgeTheme(" .. tostring(mentalThemeSSW:getKey():get()) .. ")")
      if self._ui._stc_knowledgeThemeGroup:GetShow() == false then
        self._ui._stc_knowledgeThemeGroup:SetShow(true)
      end
      self._ui._stc_knowledgeThemeGroup:SetSize(self._ui._stc_knowledgeThemeGroup:GetSizeX(), self._dropKnowledgeIconList[index].buttonControl:GetPosY() + self._dropKnowledgeIconList[index].buttonControl:GetSizeY())
    end
  end
  if self._dropTitleIconList == nil then
    self._dropTitleIconList = Array.new()
  end
  for key, value in pairs(self._dropTitleIconList) do
    if value ~= nil then
      value.buttonControl:SetShow(false)
      value.buttonControl:addInputEvent("Mouse_On", "")
      value.buttonControl:addInputEvent("Mouse_Out", "")
      value.buttonControl:addInputEvent("Mouse_LUp", "")
      value.clearControl:SetShow(false)
      value.conditionControl:SetShow(false)
    end
  end
  local titleCount = currentHuntingGroundSS:getDropTitleCount()
  for index = 0, titleCount - 1 do
    local titleSSW = currentHuntingGroundSS:getDropTitleStaticStatusWrapper(index)
    if titleSSW ~= nil then
      if self._dropTitleIconList[index] == nil then
        self._dropTitleIconList[index] = self:makeTitleIcon(self._ui._stc_titleGroup, "Static_Title_Icon_" .. index, index)
      end
      self._dropTitleIconList[index].buttonControl:SetShow(true)
      self._dropTitleIconList[index].buttonControl:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._dropTitleIconList[index].buttonControl:setLineCountByLimitAutoWrap(1)
      self._dropTitleIconList[index].buttonControl:SetText(titleSSW:getName())
      if isGameTypeKorea() == true then
        local titleDescSplitText = string.split(titleSSW:getDescription(), "\\n")
        if #titleDescSplitText > 1 then
          self._dropTitleIconList[index].conditionControl:SetTextMode(__eTextMode_LimitText)
          self._dropTitleIconList[index].conditionControl:SetText(titleDescSplitText[1])
          self._dropTitleIconList[index].conditionControl:SetShow(true)
        else
          self._dropTitleIconList[index].conditionControl:SetShow(false)
        end
      else
        self._dropTitleIconList[index].buttonControl:addInputEvent("Mouse_On", "HandleEventLOnOut_RenewDropItem_Title(true," .. tostring(index) .. ")")
        self._dropTitleIconList[index].buttonControl:addInputEvent("Mouse_Out", "HandleEventLOnOut_RenewDropItem_Title(false," .. tostring(index) .. ")")
        self._dropTitleIconList[index].conditionControl:SetShow(false)
      end
      local isHaveTitle = ToClient_isHaveTitle(titleSSW:getKey())
      self._dropTitleIconList[index].clearControl:SetShow(isHaveTitle)
      self._dropTitleIconList[index].buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_RenewDropItem_Title(" .. tostring(titleSSW:getKey():get()) .. "," .. tostring(titleSSW:getTitleCategory()) .. ")")
      if self._ui._stc_titleGroup:GetShow() == false then
        self._ui._stc_titleGroup:SetShow(true)
      end
      self._ui._stc_titleGroup:SetSize(self._ui._stc_titleGroup:GetSizeX(), self._dropTitleIconList[index].buttonControl:GetPosY() + self._dropTitleIconList[index].buttonControl:GetSizeY())
    end
  end
  local selfplayerActorProxyWrapper = getSelfPlayer()
  if selfplayerActorProxyWrapper ~= nil then
    local guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildNo_s64()
    if selfplayerActorProxyWrapper:isGuildAllianceMember() == true then
      guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildAllianceNo_s64()
    end
    self._ui._txt_dropRate:SetShow(true)
    local waypointKey = currentHuntingGroundSS:getWayPointKey()
    self._ui._txt_dropRate:SetMonoTone(ToClient_IsNodePurchased(waypointKey) ~= true)
    local nodeLevel = ToClient_GetNodeLevel(waypointKey)
    local currentNodeBuffPercent = ToClient_getNodeIncreaseItemDropPercent() * nodeLevel
    currentNodeBuffPercent = currentNodeBuffPercent / 10000
    local minorSiegeRegionKey = ToClient_GetSiegeRegionKeyRawByWaypointKey(waypointKey)
    local regionKey = ToClient_GetRegionKeyRawByWaypointKey(waypointKey)
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(minorSiegeRegionKey)
    if ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(minorSiegeRegionKey) == true then
      currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
    elseif ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(regionKey) == true then
      currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
    end
    self._ui._txt_dropRate:SetText(tostring(currentNodeBuffPercent) .. "%")
    self._ui._txt_dropRate:addInputEvent("Mouse_On", "HandleEventLOnOut_RenewDropItem_DropRate(true," .. waypointKey .. ")")
    self._ui._txt_dropRate:addInputEvent("Mouse_Out", "HandleEventLOnOut_RenewDropItem_DropRate(false," .. waypointKey .. ")")
  else
    self._ui._txt_dropRate:SetShow(false)
  end
  self:updateHuntingGroundFrameSize(doResetFrameScroll)
end
function PaGlobal_RenewDropItem_All:makeTagIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "StaticText_Tag_Templete")
  if iconTemplate == nil then
    return nil
  end
  local cloneTemplate = UI.cloneControl(iconTemplate, parent, newIconName)
  if cloneTemplate == nil then
    return nil
  end
  local newIconData = {tagControl = nil}
  newIconData.tagControl = cloneTemplate
  return newIconData
end
function PaGlobal_RenewDropItem_All:makeDropItemIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "Static_ItemSlotBg_Template")
  if iconTemplate == nil then
    return nil
  end
  local cloneTemplate = UI.cloneControl(iconTemplate, parent, newIconName)
  local newIconData = {boxControl = nil, itemSlot = nil}
  local newItemSlot = {}
  SlotItem.new(newItemSlot, "Icon_ItemSlot_", 0, cloneTemplate, self._slotConfig)
  newItemSlot:createChild()
  newItemSlot:clearItem()
  newItemSlot.icon:SetPosX(0)
  newItemSlot.icon:SetPosY(0)
  newItemSlot.icon:SetSize(44, 44)
  newItemSlot.icon:SetHorizonLeft()
  newItemSlot.icon:SetVerticalTop()
  newIconData.boxControl = cloneTemplate
  newIconData.itemSlot = newItemSlot
  local scrollPosX = self._ui._frameVerticalScroll:GetPosX()
  local validRowSizeX = scrollPosX - iconTemplate:GetSizeX()
  local iconRowMaxCount = math.floor(validRowSizeX / iconTemplate:GetSizeX()) - 1
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 22
  local iconTermSpanXY = 5
  newIconData.boxControl:SetSpanSize(beginSpanX + (newIconData.boxControl:GetSizeX() + iconTermSpanXY) * colIndex, iconTemplate:GetSpanSize().y + (newIconData.boxControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
function PaGlobal_RenewDropItem_All:makeRepeatQuestIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "Button_QuestBox_Template")
  if iconTemplate == nil then
    return nil
  end
  local cloneTemplate = UI.cloneControl(iconTemplate, parent, newIconName)
  if cloneTemplate == nil then
    return nil
  end
  local newIconData = {
    boxControl = nil,
    imageBackControl = nil,
    imageControl = nil,
    titleControl = nil,
    npcNameControl = nil,
    clearControl = nil,
    loadingControl = nil
  }
  newIconData.boxControl = cloneTemplate
  newIconData.imageBackControl = UI.getChildControl(newIconData.boxControl, "Static_QuestSlotBG")
  newIconData.imageControl = UI.getChildControl(newIconData.imageBackControl, "Static_QuestSlot")
  newIconData.titleControl = UI.getChildControl(newIconData.boxControl, "StaticText_QuestTitle")
  newIconData.npcNameControl = UI.getChildControl(newIconData.boxControl, "StaticText_QuestNpcName")
  newIconData.clearControl = UI.getChildControl(newIconData.boxControl, "Static_Disable_BG")
  newIconData.loadingControl = UI.getChildControl(newIconData.boxControl, "Static_Loading_Sequence")
  local scrollPosX = self._ui._frameVerticalScroll:GetPosX()
  local iconRowMaxCount = math.floor(scrollPosX / iconTemplate:GetSizeX())
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 22
  local iconTermSpanXY = 5
  newIconData.boxControl:SetSpanSize(beginSpanX + (newIconData.boxControl:GetSizeX() + iconTermSpanXY) * colIndex, iconTemplate:GetSpanSize().y + (newIconData.boxControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
function PaGlobal_RenewDropItem_All:makeSuddenQuestIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "Static_QuestBox_Template")
  if iconTemplate == nil then
    return nil
  end
  local cloneTemplate = UI.cloneControl(iconTemplate, parent, newIconName)
  if cloneTemplate == nil then
    return nil
  end
  local newIconData = {
    boxControl = nil,
    imageBackControl = nil,
    imageControl = nil,
    titleControl = nil,
    progressBackControl = nil,
    progressBarControl = nil,
    conditionControl = nil,
    seasonIconControl = nil,
    clearControl = nil,
    loadingControl = nil
  }
  newIconData.boxControl = cloneTemplate
  newIconData.imageBackControl = UI.getChildControl(newIconData.boxControl, "Static_QuestSlotBG")
  newIconData.imageControl = UI.getChildControl(newIconData.imageBackControl, "Static_QuestSlot")
  newIconData.titleControl = UI.getChildControl(newIconData.boxControl, "StaticText_QuestTitle")
  newIconData.progressBackControl = UI.getChildControl(newIconData.boxControl, "Static_ProgressBG")
  newIconData.progressBarControl = UI.getChildControl(newIconData.progressBackControl, "Progress2_Gage")
  newIconData.conditionControl = UI.getChildControl(newIconData.boxControl, "StaticText_QuestCondition")
  newIconData.seasonIconControl = UI.getChildControl(newIconData.boxControl, "Static_SeasonIcon")
  newIconData.clearControl = UI.getChildControl(newIconData.boxControl, "Static_Disable_BG")
  newIconData.loadingControl = UI.getChildControl(newIconData.boxControl, "Static_Loading_Sequence")
  local scrollPosX = self._ui._frameVerticalScroll:GetPosX()
  local iconRowMaxCount = math.floor(scrollPosX / iconTemplate:GetSizeX())
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 22
  local iconTermSpanXY = 5
  newIconData.boxControl:SetSpanSize(beginSpanX + (newIconData.boxControl:GetSizeX() + iconTermSpanXY) * colIndex, iconTemplate:GetSpanSize().y + (newIconData.boxControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
function PaGlobal_RenewDropItem_All:makeKnowledThemeIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "Button_Template")
  if iconTemplate == nil then
    return nil
  end
  local cloneControl = UI.cloneControl(iconTemplate, parent, newIconName)
  if cloneControl == nil then
    return nil
  end
  local progressBG = UI.getChildControl(cloneControl, "Static_ProgressBG")
  local newIconData = {
    buttonControl = nil,
    progressBarControl = nil,
    conditionTextControl = nil,
    clearControl = nil
  }
  newIconData.buttonControl = cloneControl
  newIconData.progressBarControl = UI.getChildControl(progressBG, "Progress2_Gage")
  newIconData.conditionTextControl = UI.getChildControl(newIconData.buttonControl, "StaticText_Condition")
  newIconData.clearControl = UI.getChildControl(newIconData.buttonControl, "Static_Disable_BG")
  local scrollPosX = self._ui._frameVerticalScroll:GetPosX()
  local iconRowMaxCount = math.floor(scrollPosX / iconTemplate:GetSizeX())
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 22
  local iconTermSpanXY = 5
  newIconData.buttonControl:SetSpanSize(beginSpanX + (newIconData.buttonControl:GetSizeX() + iconTermSpanXY) * colIndex, iconTemplate:GetSpanSize().y + (newIconData.buttonControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
function PaGlobal_RenewDropItem_All:makeTitleIcon(parent, newIconName, iconIndex)
  if Panel_Window_DropItem_All == nil or parent == nil or newIconName == nil then
    return nil
  end
  local iconTemplate = UI.getChildControl(parent, "Button_Template")
  if iconTemplate == nil then
    return nil
  end
  local cloneControl = UI.cloneControl(iconTemplate, parent, newIconName)
  if cloneControl == nil then
    return nil
  end
  local newIconData = {
    buttonControl = nil,
    clearControl = nil,
    conditionControl = nil
  }
  newIconData.buttonControl = cloneControl
  newIconData.clearControl = UI.getChildControl(newIconData.buttonControl, "Static_Disable_BG")
  newIconData.conditionControl = UI.getChildControl(newIconData.buttonControl, "StaticText_Condition")
  if isGameTypeKorea() == false then
    newIconData.buttonControl:SetTextVerticalCenter()
  end
  local scrollPosX = self._ui._frameVerticalScroll:GetPosX()
  local iconRowMaxCount = math.floor(scrollPosX / iconTemplate:GetSizeX())
  local rowIndex = math.floor(iconIndex / iconRowMaxCount)
  local colIndex = iconIndex - iconRowMaxCount * rowIndex
  local beginSpanX = 22
  local iconTermSpanXY = 5
  newIconData.buttonControl:SetSpanSize(beginSpanX + (newIconData.buttonControl:GetSizeX() + iconTermSpanXY) * colIndex, iconTemplate:GetSpanSize().y + (newIconData.buttonControl:GetSizeY() + iconTermSpanXY) * rowIndex)
  return newIconData
end
function PaGlobal_RenewDropItem_All:updateHuntingGroundFrameSize(doResetFrameScroll)
  if Panel_Window_DropItem_All == nil then
    return nil
  end
  local contentSizeY = 10
  local groupList = Array.new()
  groupList:push_back(self._ui._stc_dropEquipItemGroup)
  groupList:push_back(self._ui._stc_dropEtcItemGroup)
  groupList:push_back(self._ui._stc_repeatQuestGroup)
  groupList:push_back(self._ui._stc_suddenQuestGroup)
  groupList:push_back(self._ui._stc_knowledgeThemeGroup)
  groupList:push_back(self._ui._stc_titleGroup)
  for index, group in pairs(groupList) do
    if group ~= nil and group:GetShow() == true then
      local prevGroup
      for prevIndex = 1, index - 1 do
        if groupList[prevIndex] ~= nil and groupList[prevIndex]:GetShow() == true then
          prevGroup = groupList[prevIndex]
        end
      end
      if prevGroup == nil then
        group:SetSpanSize(0, 0)
      else
        group:SetSpanSize(0, prevGroup:GetSpanSize().y + prevGroup:GetSizeY())
      end
      contentSizeY = contentSizeY + group:GetSizeY()
    end
  end
  if self._ui._stc_tagArea:GetShow() == true then
    local offsetY = 10
    local tagAreaSizeY = self._ui._stc_tagArea:GetSizeY() + offsetY
    local newMainAreaPosY = self._ui._stc_tagArea:GetPosY() + tagAreaSizeY
    self._ui._stc_mainArea:SetSize(self._ui._stc_mainArea:GetSizeX(), self._originalMainAreaSizeY - tagAreaSizeY)
    self._ui._stc_mainArea:SetPosY(newMainAreaPosY)
    self._ui._frm_dropInfo:SetSize(self._ui._frm_dropInfo:GetSizeX(), self._originalFrameSizeY - tagAreaSizeY)
  else
    self._ui._stc_mainArea:SetSize(self._ui._stc_mainArea:GetSizeX(), self._originalMainAreaSizeY)
    self._ui._stc_mainArea:SetPosY(self._originalMainAreaPosY)
    self._ui._frm_dropInfo:SetSize(self._ui._frm_dropInfo:GetSizeX(), self._originalFrameSizeY)
  end
  self._ui._frameConent_dropInfo:SetSize(self._ui._frameConent_dropInfo:GetSizeX(), contentSizeY)
  local frameVScroll = self._ui._frm_dropInfo:GetVScroll()
  if doResetFrameScroll ~= nil and doResetFrameScroll == true then
    frameVScroll:SetControlPos(0)
    self._ui._frm_dropInfo:UpdateContentPos()
  end
  self._isResetPadSnap = true
  if self._ui._frm_dropInfo:GetSizeY() < self._ui._frameConent_dropInfo:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_RenewDropItem_All:doSearch(searchType, param0)
  if Panel_Window_DropItem_All == nil or self._currentMainCategoryKey == nil or self._currentSubCategoryKey == nil then
    return
  end
  if searchType ~= self._eSEARCH_TYPE.TEXT and searchType ~= self._eSEARCH_TYPE.TAG then
    return
  end
  if searchType == self._eSEARCH_TYPE.TAG then
    local tagSSW = ToClient_getDropUITagStaticStatusWrapper(param0)
    if tagSSW == nil then
      return
    end
  end
  local currentMainCategoryData
  for key, value in pairs(self._mainCategoryDataList) do
    if value._key:get() == self._currentMainCategoryKey:get() then
      currentMainCategoryData = value
      break
    end
  end
  local currentSubCategoryData
  for key, value in pairs(self._subCategoryDataList) do
    if value._key:get() == self._currentSubCategoryKey:get() then
      currentSubCategoryData = value
      break
    end
  end
  if currentMainCategoryData == nil or currentSubCategoryData == nil then
    return
  end
  local listManager = self._ui._stc_huntingGroundList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  if self._searchResultTable ~= nil then
    self._searchResultTable = nil
  end
  self._searchResultTable = Array.new()
  if searchType == self._eSEARCH_TYPE.TEXT then
    local filterText = self._ui._edt_searchEditBox:GetEditText()
    if filterText == nil or filterText == "" then
      HandleEventLUp_RenewDropItem_SubCategoryButton(currentMainCategoryData._key:get(), currentSubCategoryData._key:get())
      return
    end
    for index = 0, currentSubCategoryData._huntingGroundCount - 1 do
      local huntingGroundIndex = index
      local huntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, huntingGroundIndex)
      local huntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
      if huntingGroundSS ~= nil then
        local isPushList = false
        local huntingGroundName = huntingGroundSS:getName()
        if stringSearch(huntingGroundName, filterText) == true then
          local searchResultData = {
            _huntingGroundKeyRaw = huntingGroundKey:get(),
            _isItem = false,
            _dropItemIndex = nil,
            _listContentKey = toInt64(0, index)
          }
          isPushList = true
          self._searchResultTable:push_back(searchResultData)
          listManager:pushKey(searchResultData._listContentKey)
        end
        local dropItemCount = huntingGroundSS:getDropItemCount()
        for dropItemIndex = 0, dropItemCount - 1 do
          local dropItemSSW = huntingGroundSS:getDropItemStaticStatusWrapper(dropItemIndex)
          if dropItemSSW ~= nil then
            local itemName = dropItemSSW:getName()
            if stringSearch(itemName, filterText) == true then
              local searchResultData = {
                _huntingGroundKeyRaw = huntingGroundKey:get(),
                _isItem = true,
                _dropItemIndex = dropItemIndex,
                _listContentKey = toInt64(0, index)
              }
              self._searchResultTable:push_back(searchResultData)
              if isPushList == false then
                listManager:pushKey(searchResultData._listContentKey)
                isPushList = true
              end
            end
          end
        end
      end
    end
    self._ui._btn_searchResultClear:SetShow(true)
    self._ui._stc_searchIcon:SetShow(false)
  elseif searchType == self._eSEARCH_TYPE.TAG and param0 ~= nil then
    for index = 0, currentSubCategoryData._huntingGroundCount - 1 do
      local huntingGroundIndex = index
      local huntingGroundKey = ToClient_getDropUIHuntingGroundKey(self._currentMainCategoryKey, self._currentSubCategoryKey, huntingGroundIndex)
      local huntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
      if huntingGroundSS ~= nil and huntingGroundSS:isHaveTag(param0) == true then
        local searchResultData = {
          _huntingGroundKeyRaw = huntingGroundKey:get(),
          _isItem = false,
          _dropItemIndex = nil,
          _listContentKey = toInt64(0, index)
        }
        self._searchResultTable:push_back(searchResultData)
        listManager:pushKey(searchResultData._listContentKey)
      end
    end
  else
    UI.ASSERT_NAME(false, "\236\130\172\235\131\165\237\132\176 \236\160\149\235\179\180 UI\236\157\152 \234\178\128\236\131\137 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if #self._searchResultTable > 0 then
    self:selectHuntingGroundListContentByIndex(0)
  end
end
function PaGlobal_RenewDropItem_All:clearSearchResult()
  if Panel_Window_DropItem_All == nil then
    return
  end
  self._ui._btn_searchResultClear:SetShow(false)
  self._ui._stc_searchIcon:SetShow(true)
  self._ui._edt_searchEditBox:SetEditText("")
  self._ui._edt_searchEditBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMDROPUI_SEARCH_DESC"))
  self._searchResultTable = nil
  if self._isConsole == true then
    self._lastSnapItemInfo._huntingGroundKeyRaw = nil
    self._lastSnapItemInfo._dropItemIndex = nil
    self._lastSnapItemInfo._iconIndex = nil
    local stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Tooltip_Console")
    stc_keyGuide_X:SetShow(false)
    PaGlobalFunc_RenewDropItem_ShowSnappedItemTooltip()
  end
  ClearFocusEdit()
end
function PaGlobal_RenewDropItem_All:clearQuestLoadingTable()
  if Panel_Window_DropItem_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
end
function PaGlobal_RenewDropItem_All:pushQuestLoadingData(questWrapper, huntingGroundKeyRaw)
  if Panel_Window_DropItem_All == nil or _ContentsGroup_QuestBackEndLoading == false or questWrapper == nil or huntingGroundKeyRaw == nil then
    return
  end
  if self._questLoadingDataList == nil then
    self:clearQuestLoadingTable()
  end
  local newLoadingData = {
    _questNoRaw = questWrapper:getQuestNo()._raw,
    _huntingGroundKeyRaw = huntingGroundKeyRaw
  }
  if self:isExistLoadingDataAnyOne() == true then
    for index = #self._questLoadingDataList, 1, -1 do
      local value = self._questLoadingDataList[index]
      if value ~= nil then
        if value._questNoRaw == newLoadingData._questNoRaw then
          table.remove(self._questLoadingDataList, index)
        elseif value._huntingGroundKeyRaw ~= newLoadingData._huntingGroundKeyRaw then
          table.remove(self._questLoadingDataList, index)
        end
      end
    end
  end
  self._questLoadingDataList:push_back(newLoadingData)
  questWrapper:requestLoadBackEndData()
end
function PaGlobal_RenewDropItem_All:isExistLoadingDataAnyOne()
  if Panel_Window_DropItem_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
function PaGlobal_RenewDropItem_All:onOutHandlerLimitedAPUI(isShow, percent, att)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._txt_limitAP, PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_MAXAP_TITLE"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DROPINFO_MAXAP_DESC", "att", att, "param", percent), false)
end
