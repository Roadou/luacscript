local Panel_Window_Knowledge_Renew_info = {
  _initialize = false,
  _ui = {
    static_TitleBg = nil,
    staticText_Title_Top = nil,
    static_TopBG = nil,
    staticText_KnowledgePointTitle = nil,
    staticText_PointValue = nil,
    staticText_EffectTitle = nil,
    staticText_EffectValue = nil,
    staticText_Depth = nil,
    staticText_DetailShow_ConsoleUI = nil,
    staticText_ChaseInfo = nil,
    static_CategoryBg = nil,
    button_Category = {
      [0] = nil,
      [1] = nil,
      [2] = nil,
      [3] = nil,
      [4] = nil,
      [5] = nil,
      [6] = nil,
      [7] = nil,
      [8] = nil
    },
    static_SubCategoryBg = nil,
    staticText_Title_1 = nil,
    list2_Category = nil,
    list2_1_Content = nil,
    button_CategoryName = nil,
    staticText_EnergyIcon = nil,
    static_Key_ConsoleUI = nil,
    list2_1_VerticalScroll = nil,
    list2_1_HorizontalScroll = nil,
    static_CategoryItemBg = nil,
    staticText_Title_2 = nil,
    list2_CategoryItem = nil,
    list2_2_Content = nil,
    button_CategoryItemName = nil,
    list2_2_VerticalScroll = nil,
    list2_2_HorizontalScroll = nil,
    stc_BottomKeyGuideBg = nil,
    stc_keyGuideSelect = nil,
    stc_keyGuideBack = nil,
    stc_keyGuideRateView = nil,
    stc_keyGuideChaseStart = nil,
    stc_keyGuideChaseStop = nil,
    stc_keyGuideChaseShow = nil,
    staticText_TooltipBg = nil,
    toolTip_Point = {},
    toolTip_PointDesc = {},
    static_TooltipChaseBg = nil,
    static_ChaseTooltipTitleBg = nil,
    staticText_ChaseTooltipTitle = nil,
    staticText_ChaseTooltipName = nil,
    static_ChaseDesc = nil,
    staticText_ChaseTooltipDesc = nil,
    static_Knowledge_Icon2 = nil,
    staticText_KnowlegeNameLine2 = nil,
    staticText_Impression2 = nil,
    staticText_Interest2 = nil,
    staticText_Interesting2 = nil
  },
  _value = {
    currentStep = 0,
    stepTextList = {
      [0] = "",
      [1] = "",
      [2] = "",
      [3] = ""
    },
    step0_currentIndex = 0,
    step0_selectMentalObjectKey = 0,
    step1_lastIndex = -1,
    step1_currentIndex = 0,
    step1_selectMentalObjectKey = 0,
    step2_useCard = false,
    step2_lastIndex = -1,
    step2_currentIndex = 0,
    step2_selectMentalObjectKey = 0,
    step3_useCard = false,
    step3_lastIndex = -1,
    step3_currentIndex = 0,
    step3_selectMentalObjectKey = 0,
    step4_lastIndex = -1,
    step4_currentIndex = 0,
    basePanelSizeY = 0,
    baseCategoryItemSizeY = 0,
    baseSubCategorySizeY = 0,
    baseChaseNameTextSizeY = 0,
    baseChaseDescLineSpanY = 0,
    bottomKeyGuideList = nil
  },
  _text = {arrow = " > "},
  _enum = {
    ePOINT_COUNT = 12,
    eKNOWLEDGE_MAX = 9,
    eSTEP_CATEGORY = 0,
    eSETP_SUBCATEGORY = 1,
    eSTEP_GROUP_1 = 2,
    eSTEP_GROUP_2 = 3,
    eSTEP_GROUP_3 = 4
  },
  _icon = {
    ["texture"] = "Renewal/UI_Icon/Console_Icon_02.dds",
    [0] = {
      x1 = 115,
      y1 = 58,
      x2 = 171,
      y2 = 114
    },
    [1] = {
      x1 = 1,
      y1 = 1,
      x2 = 57,
      y2 = 57
    },
    [5001] = {
      x1 = 58,
      y1 = 1,
      x2 = 114,
      y2 = 57
    },
    [5020] = {
      x1 = 1,
      y1 = 58,
      x2 = 57,
      y2 = 114
    },
    [10001] = {
      x1 = 1,
      y1 = 115,
      x2 = 57,
      y2 = 171
    },
    [20001] = {
      x1 = 1,
      y1 = 172,
      x2 = 57,
      y2 = 228
    },
    [25001] = {
      x1 = 58,
      y1 = 58,
      x2 = 114,
      y2 = 114
    },
    [30001] = {
      x1 = 58,
      y1 = 115,
      x2 = 114,
      y2 = 171
    },
    [31310] = {
      x1 = 58,
      y1 = 172,
      x2 = 114,
      y2 = 228
    },
    [31300] = {
      x1 = 115,
      y1 = 1,
      x2 = 171,
      y2 = 57
    }
  },
  _ani = {showAniElapsed = 0, showAniDuration = 0.3},
  _chaseData = {
    ecologyMinThemaKey = 10001,
    ecologyMaxThemaKey = 20000,
    isEcology = false,
    lastSelectKey = 0,
    chaseName = nil,
    maxShowControlCount = 1,
    ecologyCategoriIndex = 3,
    isChaseFind = false,
    isChaseFindCard = false,
    chaseFindIndex = 0,
    chaseNextFindIndex = 0
  }
}
local themeKeyKey_ControlMapping = {
  [1] = 0,
  [5001] = 1,
  [5020] = 2,
  [10001] = 3,
  [20001] = 4,
  [25001] = 5,
  [30001] = 6,
  [31310] = 7,
  [31300] = 8
}
function Panel_Window_Knowledge_Renew_info:getShowInfo()
  return self._ui.static_KnowledgeInfoBg:GetShow()
end
function Panel_Window_Knowledge_Renew_info:openInfo()
  self._ui.static_KnowledgeInfoBg:SetShow(true)
end
function Panel_Window_Knowledge_Renew_info:closeInfo()
  self._ui.static_KnowledgeInfoBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:setContentInfo()
  if false == self:getShowInfo() then
    self:openInfo()
  end
  local currentIndex = self._value.step4_currentIndex
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childkey = knowledge:getCurrentThemeChildCardKeyByIndex(currentIndex)
  local card = knowledge:getCardByKeyRaw(childkey)
  if card ~= nil then
    self._ui.static_Knowledge_Icon2:ChangeTextureInfoNameAsync(card:getPicture())
    self._ui.staticText_KnowlegeNameLine2:SetText(card:getName())
    local desciption
    if card:hasCard() == true then
      desciption = card:getDescription()
    else
      desciption = card:getKeyword()
    end
    self._ui.frame_DialogText:SetShow(true)
    self._ui.staticText_Dialog_Text:SetAutoResize(true)
    self._ui.staticText_Dialog_Text:SetTextMode(__eTextMode_AutoWrap)
    self._ui.staticText_Dialog_Text:SetText(desciption)
    self._ui.frame_Content:SetSize(self._ui.staticText_Dialog_Text:GetSizeY())
    self._ui.frame_VScroll:SetControlPos(0)
    self._ui.frame_DialogText:UpdateContentPos()
    self._ui.frame_DialogText:UpdateContentScroll()
    self._ui.frame_DialogText:ComputePos()
    if self._ui.frame_DialogText:GetSizeY() < self._ui.staticText_Dialog_Text:GetTextSizeY() then
      self._ui.frame_VScroll:SetShow(true)
    else
      self._ui.frame_VScroll:SetShow(false)
    end
    local favoritedList = ""
    local isFirst = true
    local npcpersonalityStaticWrapper = card:getNpcPersonalityStaticStatus()
    if npcpersonalityStaticWrapper == nil then
      self._ui.staticText_Interesting2:SetShow(false)
    else
      local count = npcpersonalityStaticWrapper:getFavoritedThemeCount()
      for index = 0, count - 1 do
        local favoritedName = npcpersonalityStaticWrapper:getFavoritedThemeNameByIndex(index)
        if isFirst then
          favoritedList = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Knowledge_FavoritedList", "favoritedName", favoritedName)
          isFirst = false
        else
          favoritedList = favoritedList .. "," .. favoritedName
        end
      end
      self._ui.staticText_Interesting2:SetShow(true)
      self._ui.staticText_Interesting2:SetTextMode(__eTextMode_AutoWrap)
      self._ui.staticText_Interesting2:SetText(favoritedList)
    end
    self._ui.staticText_Impression2:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_FAVOR") .. " : " .. card:getMinDd() .. "~" .. card:getMaxDd())
    self._ui.staticText_Interest2:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_INTERESTING") .. " : " .. card:getHit())
    if true == _ContentsGroup_ChaseMonster then
      self._chaseData.lastSelectKey = card:getKey()
      self:updateChasePadFunction()
    end
  else
    self._ui.frame_DialogText:SetShow(false)
  end
end
function Panel_Window_Knowledge_Renew_info:registerMessageHandler()
  registerEvent("onScreenResize", "FromClient_Window_Knowledge_Renew_Resize")
end
function Panel_Window_Knowledge_Renew_info:initialize()
  self._initialize = true
  self:initValue()
  self:childControl()
  self:resize()
  self:registerMessageHandler()
end
function Panel_Window_Knowledge_Renew_info:initValue()
  self._value.currentStep = 0
  self._value.stepTextList[0] = ""
  self._value.stepTextList[1] = ""
  self._value.stepTextList[2] = ""
  self._value.stepTextList[3] = ""
  self._value.step0_currentIndex = 0
  self._value.step0_selectMentalObjectKey = 0
  self._value.step1_lastIndex = -1
  self._value.step1_currentIndex = 0
  self._value.step1_selectMentalObjectKey = 0
  self._value.step2_useCard = false
  self._value.step2_lastIndex = -1
  self._value.step2_currentIndex = 0
  self._value.step2_selectMentalObjectKey = 0
  self._value.step4_lastIndex = -1
  self._value.step4_currentIndex = 0
end
function Panel_Window_Knowledge_Renew_info:resize()
  local screenSizeY = getScreenSizeY()
  Panel_Window_Knowledge_Renew:SetSize(Panel_Window_Knowledge_Renew:GetSizeX(), screenSizeY)
  self._ui.static_TooltipChaseBg:SetSize(self._ui.static_TooltipChaseBg:GetSizeX(), screenSizeY)
  self._ui.staticText_TooltipBg:SetSize(self._ui.static_TooltipChaseBg:GetSizeX(), screenSizeY)
  self._ui.static_TooltipChaseBg:SetPosY(0)
  self._ui.staticText_TooltipBg:SetPosY(0)
  if true == _ContentsGroup_ChaseMonster then
    local diffSizeY = screenSizeY - self._value.basePanelSizeY
    local subCategorySizeY = self._value.baseSubCategorySizeY + diffSizeY
    local subCategoryButtonSizeY = self._ui.button_CategoryName:GetSizeY()
    if 0 ~= subCategoryButtonSizeY then
      local subCategoryShowCount = math.ceil(subCategorySizeY / subCategoryButtonSizeY)
      if subCategoryShowCount > 0 then
        subCategorySizeY = subCategoryButtonSizeY * subCategoryShowCount
      end
    end
    self._ui.list2_Category:SetSize(self._ui.list2_Category:GetSizeX(), subCategorySizeY)
    self._ui.list2_1_VerticalScroll:SetSize(self._ui.list2_1_VerticalScroll:GetSizeX(), subCategorySizeY)
    local categoryItemSizeY = self._value.baseCategoryItemSizeY + diffSizeY
    local categoryItemButtonSizeY = self._ui.list2_2_Content:GetSizeY()
    if 0 ~= categoryItemButtonSizeY then
      local categoryItemShowCount = math.ceil(categoryItemSizeY / categoryItemButtonSizeY)
      if categoryItemShowCount > 0 then
        self._chaseData.maxShowControlCount = categoryItemShowCount
        categoryItemSizeY = categoryItemButtonSizeY * categoryItemShowCount
      end
    end
    self._ui.list2_CategoryItem:SetSize(self._ui.list2_CategoryItem:GetSizeX(), categoryItemSizeY)
    self._ui.list2_2_VerticalScroll:SetSize(self._ui.list2_2_VerticalScroll:GetSizeX(), categoryItemSizeY)
  end
  self._ui.list2_Category:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_CategoryItem:createChildContent(__ePAUIList2ElementManagerType_List)
end
function Panel_Window_Knowledge_Renew_info:alignBottomKeyGuide()
  if self._value.bottomKeyGuideList == nil then
    return
  end
  self._ui.stc_BottomKeyGuideBg:SetSize(Panel_Window_Knowledge_Renew:GetSizeX(), self._ui.stc_BottomKeyGuideBg:GetSizeY())
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._value.bottomKeyGuideList, self._ui.stc_BottomKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  self._ui.stc_BottomKeyGuideBg:SetSpanSize(self._ui.stc_BottomKeyGuideBg:GetSpanSize().x, 0)
  self._ui.stc_BottomKeyGuideBg:ComputePos()
end
function Panel_Window_Knowledge_Renew_info:childControl()
  self._ui.static_TitleBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_TitleBg")
  self._ui.staticText_Title_Top = UI.getChildControl(self._ui.static_TitleBg, "StaticText_Title_Top")
  self._ui.static_TopBG = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_TopBG")
  self._ui.staticText_PointValue = UI.getChildControl(self._ui.static_TopBG, "StaticText_PointValue")
  self._ui.staticText_EffectTitle = UI.getChildControl(self._ui.static_TopBG, "StaticText_EffectTitle")
  self._ui.staticText_EffectValue = UI.getChildControl(self._ui.static_TopBG, "StaticText_EffectValue")
  self._ui.staticText_Depth = UI.getChildControl(self._ui.static_TopBG, "StaticText_Depth")
  self._ui.staticText_DetailShow_ConsoleUI = UI.getChildControl(self._ui.static_TopBG, "StaticText_DetailShow_ConsoleUI")
  self._ui.staticText_DetailShow_ConsoleUI_Text = UI.getChildControl(self._ui.static_TopBG, "StaticText_DetailShow_ConsoleUI_Text")
  self._ui.staticText_DetailShow_ConsoleUI_Text:SetTextMode(__eTextMode_AutoWrap)
  self._ui.staticText_DetailShow_ConsoleUI_Text:SetText(self._ui.staticText_DetailShow_ConsoleUI_Text:GetText())
  self._ui.staticText_ChaseInfo = UI.getChildControl(self._ui.static_TopBG, "StaticText_ChaseInfo_Console_UI")
  self._ui.static_CategoryBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_CategoryBg")
  for index = 0, 8 do
    local slot = {}
    slot.button = UI.getChildControl(self._ui.static_CategoryBg, "Button_" .. index)
    slot.button:SetTextMode(__eTextMode_AutoWrap)
    slot.icon = UI.getChildControl(slot.button, "Static_Icon_" .. index)
    slot.percent = UI.getChildControl(slot.button, "StaticText_Percent_" .. index)
    self._ui.button_Category[index] = slot
  end
  self._ui.static_SubCategoryBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_SubCategoryBg")
  self._ui.staticText_Title_1 = UI.getChildControl(self._ui.static_SubCategoryBg, "StaticText_Title_1")
  self._ui.list2_Category = UI.getChildControl(self._ui.static_SubCategoryBg, "List2_Category")
  self._ui.list2_Category:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Window_Knowledge_Step_123List")
  self._ui.list2_Category:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_1_Content = UI.getChildControl(self._ui.list2_Category, "List2_1_Content")
  self._ui.button_CategoryName = UI.getChildControl(self._ui.list2_1_Content, "Button_CategoryName")
  self._ui.staticText_EnergyIcon = UI.getChildControl(self._ui.list2_1_Content, "StaticText_EnergyIcon")
  self._ui.static_Key_ConsoleUI = UI.getChildControl(self._ui.list2_1_Content, "Static_Key_ConsoleUI")
  self._ui.list2_1_VerticalScroll = UI.getChildControl(self._ui.list2_Category, "List2_1_VerticalScroll")
  self._ui.list2_1_HorizontalScroll = UI.getChildControl(self._ui.list2_Category, "List2_1_VerticalScroll")
  self._ui.static_CategoryItemBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_CategoryItemBg")
  self._ui.staticText_Title_2 = UI.getChildControl(self._ui.static_CategoryItemBg, "StaticText_Title_2")
  self._ui.list2_CategoryItem = UI.getChildControl(self._ui.static_CategoryItemBg, "List2_CategoryItem")
  self._ui.list2_CategoryItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Window_Knowledge_Step_4List")
  self._ui.list2_CategoryItem:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_2_Content = UI.getChildControl(self._ui.list2_CategoryItem, "List2_2_Content")
  self._ui.list2_2_VerticalScroll = UI.getChildControl(self._ui.list2_CategoryItem, "List2_2_VerticalScroll")
  self._ui.list2_2_HorizontalScroll = UI.getChildControl(self._ui.list2_CategoryItem, "List2_2_HorizontalScroll")
  self._ui.stc_BottomKeyGuideBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_BottomKeyGuideBg")
  self._ui.stc_keyGuideSelect = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_Select_ConsoleUI")
  self._ui.stc_keyGuideBack = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_Back_ConsoleUI")
  self._ui.stc_keyGuideRateView = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_LBX_ConsoleUI")
  self._ui.stc_keyGuideChaseStart = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_Chase_ConsoleUI")
  self._ui.stc_keyGuideChaseStop = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_ChaseStop_ConsoleUI")
  self._ui.stc_keyGuideChaseShow = UI.getChildControl(self._ui.stc_BottomKeyGuideBg, "StaticText_ChaseShow_Console_UI")
  self._value.bottomKeyGuideList = Array.new()
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideChaseShow)
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideChaseStart)
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideChaseStop)
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideRateView)
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideSelect)
  self._value.bottomKeyGuideList:push_back(self._ui.stc_keyGuideBack)
  self._ui.staticText_TooltipBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "StaticText_TooltipBg")
  self._ui.toolTip_Grade = {
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_Grade_S"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_Grade_APlus"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_Grade_A"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_Grade_B"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_Grade_C")
  }
  self._ui.toolTip_GradeDesc = {
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GradeDesc_S"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GradeDesc_APlus"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GradeDesc_A"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GradeDesc_B"),
    UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GradeDesc_C")
  }
  for ii = 1, #self._ui.toolTip_Grade do
    self._ui.toolTip_Grade[ii]:SetPosX(210)
    self._ui.toolTip_Grade[ii]:SetPosY(80 + (ii - 1) * 40)
    self._ui.toolTip_GradeDesc[ii]:SetPosX(340)
    self._ui.toolTip_GradeDesc[ii]:SetPosY(80 + (ii - 1) * 40)
  end
  for ii = 0, self._enum.ePOINT_COUNT - 1 do
    self._ui.toolTip_Point[ii] = UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_" .. ii)
    self._ui.toolTip_PointDesc[ii] = UI.getChildControl(self._ui.staticText_TooltipBg, "StaticText_GreDesc_" .. ii)
    self._ui.toolTip_Point[ii]:SetFontColor(Defines.Color.C_FFEEEEEE)
    self._ui.toolTip_Point[ii]:SetPosX(210)
    self._ui.toolTip_Point[ii]:SetPosY(430 + (ii - 1) * 55)
    self._ui.toolTip_PointDesc[ii]:SetFontColor(Defines.Color.C_FFEEEEEE)
    self._ui.toolTip_PointDesc[ii]:SetPosX(210)
    self._ui.toolTip_PointDesc[ii]:SetPosY(455 + (ii - 1) * 55)
  end
  self._ui.static_TooltipChaseBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_TooltipChaseBg")
  self._ui.static_ChaseTooltipTitleBg = UI.getChildControl(self._ui.static_TooltipChaseBg, "Static_TooltipChaseTitleBg")
  self._ui.staticText_ChaseTooltipTitle = UI.getChildControl(self._ui.static_ChaseTooltipTitleBg, "StaticText_Title")
  self._ui.staticText_ChaseTooltipName = UI.getChildControl(self._ui.staticText_ChaseTooltipTitle, "StaticText_MonsterType")
  self._ui.static_ChaseDesc = UI.getChildControl(self._ui.static_TooltipChaseBg, "Static_Line3")
  self._ui.staticText_ChaseTooltipDesc = UI.getChildControl(self._ui.static_ChaseDesc, "StaticText_Chase_Info_Desc")
  self._ui.staticText_ChaseTooltipName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.staticText_ChaseTooltipDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.staticText_ChaseTooltipDesc:SetText(self._ui.staticText_ChaseTooltipDesc:GetText())
  self._value.basePanelSizeY = Panel_Window_Knowledge_Renew:GetSizeY()
  self._value.baseCategoryItemSizeY = self._ui.list2_CategoryItem:GetSizeY()
  self._value.baseSubCategorySizeY = self._ui.list2_Category:GetSizeY()
  self._value.baseChaseNameTextSizeY = self._ui.staticText_ChaseTooltipName:GetTextSizeY()
  self._value.baseChaseDescLineSpanY = self._ui.static_ChaseDesc:GetSpanSize().y
  local diffChaseTitleSize = self._ui.staticText_ChaseTooltipTitle:GetTextSizeX() - self._ui.staticText_ChaseTooltipTitle:GetSizeX()
  local diffChaseTitleGap = 5
  self._ui.staticText_ChaseTooltipName:SetSize(self._ui.staticText_ChaseTooltipName:GetSizeX() - diffChaseTitleSize, self._ui.staticText_ChaseTooltipName:GetSizeY())
  self._ui.staticText_ChaseTooltipName:SetSpanSize(self._ui.staticText_ChaseTooltipName:GetSpanSize().x + diffChaseTitleSize + diffChaseTitleGap, self._ui.staticText_ChaseTooltipName:GetSpanSize().y)
  self._ui.static_KnowledgeInfoBg = UI.getChildControl(Panel_Window_Knowledge_Renew, "Static_KnowledgeInfo_Bg")
  self._ui.static_Knowledge_Icon2 = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "Static_Knowledge_Icon")
  self._ui.staticText_KnowlegeNameLine2 = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "StaticText_KnowlegeNameLine")
  self._ui.staticText_Impression2 = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "StaticText_Impression")
  self._ui.staticText_Interest2 = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "StaticText_Interest")
  self._ui.staticText_Interesting2 = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "StaticText_Interesting")
  self._ui.frame_DialogText = UI.getChildControl(self._ui.static_KnowledgeInfoBg, "Frame_Dialog_Text")
  self._ui.frame_VScroll = UI.getChildControl(self._ui.frame_DialogText, "Frame_1_VerticalScroll")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_DialogText, "Frame_1_Content")
  self._ui.staticText_Dialog_Text = UI.getChildControl(self._ui.frame_Content, "StaticText_Dialog_Text")
end
function Panel_Window_Knowledge_Renew_info:open(showAni)
  Panel_Window_Knowledge_Renew:SetShow(true)
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Close()
  end
  FGlobal_Panel_Radar_Show(false, true)
  PaGlobalFunc_Panel_TimeBar_Show(false, true)
  FGlobal_QuestWidget_Close()
end
function Panel_Window_Knowledge_Renew_info:close(showAni)
  Panel_Window_Knowledge_Renew:SetShow(false)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    FGlobal_Panel_Radar_Show(true, true)
    PaGlobalFunc_Panel_TimeBar_Show(true, true)
    FGlobal_QuestWidget_Open()
  end
end
function Panel_Window_Knowledge_Renew_info:preOpen()
  self:preOpenTooltip()
  self:initValue()
  self:resize()
  self:setTopData()
  self:initChaseData()
end
function Panel_Window_Knowledge_Renew_info:preOpenTooltip()
  local titleTextSizeX = 0
  local descTextSizeX = 0
  for index = 0, self._enum.ePOINT_COUNT - 1 do
    titleTextSizeX = math.max(titleTextSizeX, self._ui.toolTip_Point[index]:GetTextSizeX())
    descTextSizeX = math.max(descTextSizeX, self._ui.toolTip_PointDesc[index]:GetTextSizeX())
  end
  self._ui.staticText_TooltipBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:openTooltip()
  self._ui.staticText_TooltipBg:SetShow(true)
  self._ui.static_TooltipChaseBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:closeTooltip()
  self._ui.staticText_TooltipBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:clearContentPage0()
  self:initValue()
  self._ui.static_CategoryBg:SetShow(true)
  self._ui.static_SubCategoryBg:SetShow(false)
  self._ui.static_CategoryItemBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:clearContentPage1()
  self._value.stepTextList[1] = ""
  self._value.stepTextList[2] = ""
  self._value.stepTextList[3] = ""
  self._value.step1_lastIndex = -1
  self._value.step1_currentIndex = 0
  self._value.step1_selectMentalObjectKey = 0
  self._value.step2_useCard = false
  self._value.step2_lastIndex = -1
  self._value.step2_currentIndex = 0
  self._value.step2_selectMentalObjectKey = 0
  self._value.step3_useCard = false
  self._value.step3_lastIndex = -1
  self._value.step3_currentIndex = 0
  self._value.step3_selectMentalObjectKey = 0
  self._value.step4_lastIndex = -1
  self._value.step4_currentIndex = 0
  self._ui.static_CategoryBg:SetShow(false)
  self._ui.static_SubCategoryBg:SetShow(true)
  self._ui.static_CategoryItemBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:clearContentPage2()
  self._value.stepTextList[2] = ""
  self._value.stepTextList[3] = ""
  self._value.step2_useCard = false
  self._value.step2_lastIndex = -1
  self._value.step2_currentIndex = 0
  self._value.step2_selectMentalObjectKey = 0
  self._value.step3_useCard = false
  self._value.step3_lastIndex = -1
  self._value.step3_currentIndex = 0
  self._value.step3_selectMentalObjectKey = 0
  self._value.step4_lastIndex = -1
  self._value.step4_currentIndex = 0
  self._ui.static_CategoryBg:SetShow(false)
  self._ui.static_SubCategoryBg:SetShow(true)
  self._ui.static_CategoryItemBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:clearContentPage3()
  self._value.stepTextList[3] = ""
  self._value.step3_useCard = false
  self._value.step3_lastIndex = -1
  self._value.step3_currentIndex = 0
  self._value.step3_selectMentalObjectKey = 0
  self._value.step4_lastIndex = -1
  self._value.step4_currentIndex = 0
  self._ui.static_CategoryBg:SetShow(false)
  self._ui.static_SubCategoryBg:SetShow(true)
  self._ui.static_CategoryItemBg:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:clearContentPage4()
  self._value.step4_lastIndex = -1
  self._value.step4_currentIndex = 0
  self._ui.static_CategoryBg:SetShow(false)
  self._ui.static_SubCategoryBg:SetShow(false)
  self._ui.static_CategoryItemBg:SetShow(true)
end
function Panel_Window_Knowledge_Renew_info:setTopData()
  self._ui.static_TopBG:SetShow(true)
  local knowledgePoint = ToClient_getKnowledgePoint()
  self._ui.staticText_PointValue:SetText(tostring(knowledgePoint))
  local battleBuffPercent = ToClient_getBattleExperienceByKnowledgePoint()
  local dropItemBuffPercent = ToClient_getEfficiencyOfDropItemByKnowledgePoint()
  battleBuffPercent = battleBuffPercent / 10000
  dropItemBuffPercent = dropItemBuffPercent / 10000
  local isBattleBuff = ""
  if battleBuffPercent > 0 then
    isBattleBuff = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_BATTLEEXPBUFF", "battleBuff", tostring(battleBuffPercent))
  end
  local isDropItemBuff = ""
  if dropItemBuffPercent > 0 then
    isDropItemBuff = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_BUFF_TEXT", "dropPercent", tostring(dropItemBuffPercent))
  end
  local txt_Comma = "\n"
  if 0 == battleBuffPercent then
    txt_Comma = ""
  end
  local isText = isDropItemBuff .. txt_Comma .. isBattleBuff
  if knowledgePoint < 500 then
    isText = PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGE_MAIN_NONEBUFF")
  end
  self._ui.staticText_EffectValue:SetText(isText)
end
function Panel_Window_Knowledge_Renew_info:updateTopText()
  if 0 == self._value.currentStep then
    self._ui.staticText_Depth:SetShow(false)
  else
    local textAll = ""
    local count = self._value.currentStep - 1
    for index = 0, count do
      if self._value.stepTextList[index] ~= "" then
        textAll = textAll .. self._value.stepTextList[index]
        if nil ~= self._value.stepTextList[index + 1] and "" ~= self._value.stepTextList[index + 1] then
          textAll = textAll .. self._text.arrow
        end
      else
        index = index + 1
      end
    end
    self._ui.staticText_Depth:SetAutoResize(true)
    self._ui.staticText_Depth:setLineCountByLimitAutoWrap(2)
    self._ui.staticText_Depth:SetTextMode(__eTextMode_AutoWrap)
    self._ui.staticText_Depth:SetShow(true)
    self._ui.staticText_Depth:SetText(textAll)
  end
  self._ui.staticText_Depth:SetShow(false)
end
function Panel_Window_Knowledge_Renew_info:setContent()
  ToClient_padSnapResetControl()
  if self._value.currentStep == self._enum.eSTEP_CATEGORY then
    self:clearContentPage0()
    self:updateTopText()
    self:setContentPage0()
    self._chaseData.isEcology = false
    self._ui.static_TooltipChaseBg:SetShow(false)
    self:clearChasePadFunction()
    self._ui.stc_keyGuideSelect:SetShow(true)
  elseif self._value.currentStep == self._enum.eSETP_SUBCATEGORY then
    self:clearContentPage1()
    self:updateTopText()
    self:setContentPage1()
    self:updateChasePadFunction()
    self._ui.stc_keyGuideSelect:SetShow(false)
  elseif self._value.currentStep == self._enum.eSTEP_GROUP_1 then
    self:clearContentPage2()
    self:updateTopText()
    self:setContentPage2()
    self:updateChasePadFunction()
    self._ui.stc_keyGuideSelect:SetShow(false)
  elseif self._value.currentStep == self._enum.eSTEP_GROUP_2 then
    self:clearContentPage3()
    self:updateTopText()
    self:setContentPage3()
    self:updateChasePadFunction()
    self._ui.stc_keyGuideSelect:SetShow(false)
  elseif self._value.currentStep == self._enum.eSTEP_GROUP_3 then
    self:clearContentPage4()
    self:updateTopText()
    self:setContentPage4()
    self:updateChasePadFunction()
    self._ui.stc_keyGuideSelect:SetShow(false)
  end
  self:alignBottomKeyGuide()
end
function Panel_Window_Knowledge_Renew_info:setContentPage0()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childKnowledgeCount = knowledge:getMainKnowledgeCount()
  for index = 0, self._enum.eKNOWLEDGE_MAX - 1 do
    self._ui.button_Category[index].button:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_KNOWLEDGE_NOTHING"))
    self._ui.button_Category[index].percent:SetText("")
    self._ui.button_Category[index].button:SetFontColor(Defines.Color.C_FFFFFFFF)
    local iconData = self._icon[0]
    self._ui.button_Category[index].icon:ChangeTextureInfoNameAsync(self._icon.texture)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.button_Category[index].icon, iconData.x1, iconData.y1, iconData.x2, iconData.y2)
    self._ui.button_Category[index].icon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.button_Category[index].icon:setRenderTexture(self._ui.button_Category[index].icon:getBaseTexture())
    self._ui.button_Category[index].button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page0_HideButtonA(false)")
    self._ui.button_Category[index].button:addInputEvent("Mouse_LUp", "")
  end
  for index = 0, childKnowledgeCount do
    local mentalCardKeyRaw = knowledge:getMainKnowledgeKeyByIndex(index)
    local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)
    local controlIndex = themeKeyKey_ControlMapping[mentalCardKeyRaw]
    if nil ~= controlIndex then
      if nil ~= self._icon[mentalCardKeyRaw] then
        local iconData = self._icon[mentalCardKeyRaw]
        self._ui.button_Category[controlIndex].icon:ChangeTextureInfoNameAsync(self._icon.texture)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui.button_Category[controlIndex].icon, iconData.x1, iconData.y1, iconData.x2, iconData.y2)
        self._ui.button_Category[controlIndex].icon:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui.button_Category[controlIndex].icon:setRenderTexture(self._ui.button_Category[controlIndex].icon:getBaseTexture())
      end
      local mentalObject = knowledge:getThemeByKeyRaw(mentalCardKeyRaw)
      local categoryName = mentalObject:getName()
      if mentalObject:getCardCollectedCount() == mentalObject:getCardCollectMaxCount() then
        self._ui.button_Category[controlIndex].button:SetFontColor(Defines.Color.C_FF6DC6FF)
      end
      local percent = mentalObject:getCardCollectPercents()
      self._ui.button_Category[controlIndex].mentalCardKeyRaw = mentalCardKeyRaw
      self._ui.button_Category[controlIndex].button:SetText(categoryName)
      self._ui.button_Category[controlIndex].percent:SetText(percent .. "%")
      self._ui.button_Category[controlIndex].button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page0_SelectButton(" .. controlIndex .. "," .. tostring(hideButtonA) .. ")")
      self._ui.button_Category[controlIndex].button:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Knowledge_Page0_ClickButton(" .. controlIndex .. ",\"" .. categoryName .. "\"" .. ")")
    end
  end
end
function Panel_Window_Knowledge_Renew_info:setContentPage1()
  local title = self._value.stepTextList[self._enum.eSTEP_CATEGORY]
  self._ui.staticText_Title_1:SetText(title)
  self._ui.list2_Category:getElementManager():clearKey()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getCurrentThemeChildThemeCount()
  if 0 == childCount then
    return
  end
  for index = 0, childCount - 1 do
    self._ui.list2_Category:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_Category:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_Knowledge_Renew_info:setContentPage2()
  local title = self._value.stepTextList[self._enum.eSETP_SUBCATEGORY]
  self._ui.staticText_Title_1:SetText(title)
  self._ui.list2_Category:getElementManager():clearKey()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getCurrentThemeChildThemeCount()
  if 0 == childCount then
    childCount = knowledge:getCurrentThemeChildCardCount()
    if 0 == childCount then
      return
    else
      self._value.step2_useCard = true
      self._value.step3_useCard = true
      PaGlobalFunc_Window_Knowledge_Page2_Pass()
    end
  end
  for index = 0, childCount - 1 do
    self._ui.list2_Category:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_Category:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_Knowledge_Renew_info:setContentPage3()
  local title = self._value.stepTextList[self._enum.eSTEP_GROUP_1]
  self._ui.staticText_Title_1:SetText(title)
  self._ui.list2_Category:getElementManager():clearKey()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getCurrentThemeChildThemeCount()
  if 0 == childCount then
    childCount = knowledge:getCurrentThemeChildCardCount()
    if 0 == childCount then
      return
    else
      self._value.step3_useCard = true
      PaGlobalFunc_Window_Knowledge_Page3_Pass()
    end
  end
  for index = 0, childCount - 1 do
    self._ui.list2_Category:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_Category:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_Knowledge_Renew_info:setContentPage4()
  local title = ""
  if false == self._value.step3_useCard and false == self._value.step2_useCard then
    title = self._value.stepTextList[self._enum.eSTEP_GROUP_2]
  elseif true == self._value.step3_useCard and false == self._value.step2_useCard then
    title = self._value.stepTextList[self._enum.eSTEP_GROUP_1]
  else
    title = self._value.stepTextList[self._enum.eSETP_SUBCATEGORY]
  end
  self._ui.staticText_Title_2:SetText(title)
  self._ui.list2_CategoryItem:getElementManager():clearKey()
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childCount = knowledge:getCurrentThemeChildCardCount()
  if 0 == childCount then
    return
  end
  for index = 0, childCount - 1 do
    self._ui.list2_CategoryItem:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_CategoryItem:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_Knowledge_Renew_info:initChaseData()
  self._chaseData.lastSelectKey = 0
  self._chaseData.isEcology = false
  self._chaseData.isChaseFind = false
  self._chaseData.isChaseFindCard = false
  self._chaseData.chaseFindIndex = 0
  self._chaseData.chaseNextFindIndex = 0
  self:clearChasePadFunction()
  self._ui.static_TooltipChaseBg:SetShow(false)
  if Panel_Window_Knowledge_Renew ~= nil then
    Panel_Window_Knowledge_Renew:ClearUpdateLuaFunc()
  end
  self:updateChaseName()
end
function Panel_Window_Knowledge_Renew_info:updateChaseName()
  self._chaseData.chaseName = PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TXT_FILTER_0")
  if _ContentsGroup_ChaseMonster == false then
    return
  end
  if self._chaseData == nil then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if selfPlayerWrrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if selfPlayer == nil then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if knowledge == nil then
    return
  end
  local chaseTargetKeyRaw = ToClient_getChaseTargetKeyRaw()
  if chaseTargetKeyRaw == 0 then
    return
  elseif chaseTargetKeyRaw > 0 then
    self._chaseData.chaseName = ""
    local cardKeyCheckTable = {}
    local chaseCardCount = ToClient_getChaseCharacterKeyCount()
    for index = 0, chaseCardCount - 1 do
      local cardKeyRaw = ToClient_getChaseCardKeyByIndex(index)
      if cardKeyRaw ~= 0 then
        local isFind = false
        for _, value in ipairs(cardKeyCheckTable) do
          if value == cardKeyRaw then
            isFind = true
            break
          end
        end
        if isFind == false then
          local card = knowledge:getCardByKeyRaw(cardKeyRaw)
          if card ~= nil then
            local cardName = card:getName()
            if cardName ~= nil then
              local addName
              local strsplit = string.split(cardName, "]")
              if strsplit[2] ~= nil then
                addName = strsplit[2]
              else
                local keyword = card:getKeyword()
                if string.len(keyword) ~= 0 then
                  addName = keyword
                else
                  addName = cardName
                end
              end
              if addName ~= nil then
                if self._chaseData.chaseName ~= "" then
                  self._chaseData.chaseName = self._chaseData.chaseName .. ", "
                end
                self._chaseData.chaseName = self._chaseData.chaseName .. addName
              end
            end
          end
          table.insert(cardKeyCheckTable, cardKeyRaw)
        end
      end
    end
    if self._chaseData.chaseName == "" then
      self._chaseData.chaseName = PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TXT_FILTER_0")
    end
  elseif chaseTargetKeyRaw < 0 then
    local theme = knowledge:getThemeByKeyRaw(-chaseTargetKeyRaw)
    if theme == nil then
      return
    end
    local themeName = theme:getName()
    if themeName ~= nil then
      self._chaseData.chaseName = themeName
    end
  end
  self:setChaseName()
end
function Panel_Window_Knowledge_Renew_info:clearChasePadFunction()
  self._ui.stc_keyGuideChaseStart:SetShow(false)
  self._ui.stc_keyGuideChaseStop:SetShow(false)
  self._ui.stc_keyGuideChaseShow:SetShow(false)
  self._ui.staticText_ChaseInfo:SetShow(false)
  self:alignBottomKeyGuide()
  if nil ~= Panel_Window_Knowledge_Renew then
    Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
  end
end
function Panel_Window_Knowledge_Renew_info:updateChasePadFunction()
  self:clearChasePadFunction()
  if Panel_Window_Knowledge_Renew == nil or _ContentsGroup_ChaseMonster == false then
    return
  end
  self._ui.staticText_ChaseInfo:SetShow(self._chaseData.isEcology)
  if self._chaseData.isEcology == false then
    return
  end
  self._ui.staticText_ChaseInfo:SetShow(true)
  Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_Window_Knowledge_Renew_ShowChaseGuide()")
  if self._chaseData == nil then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if selfPlayerWrrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if selfPlayer == nil then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if knowledge == nil then
    return
  end
  local chaseTargetKeyRaw = ToClient_getChaseTargetKeyRaw()
  self._ui.stc_keyGuideChaseShow:SetShow(true)
  self:alignBottomKeyGuide()
  Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_Window_Knowledge_Renew_FindChaseCard()")
  if self._value.currentStep == self._enum.eSTEP_CATEGORY or self._value.currentStep == self._enum.eSETP_SUBCATEGORY then
    return
  end
  if self._chaseData.lastSelectKey == 0 then
    return
  end
  local chaseStartText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TARGET_MONSTER_CHASE_START")
  if self._chaseData.lastSelectKey > 0 then
    local selectCharacterKey = ToClient_getCharacterKeyByMentalCardKey(self._chaseData.lastSelectKey)
    if selectCharacterKey ~= 0 and ToClient_isChaseMonster(selectCharacterKey) == true then
      self._ui.stc_keyGuideChaseStop:SetShow(true)
      Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Window_Knowledge_Renew_SelectChase(false)")
    else
      self._ui.stc_keyGuideChaseStart:SetShow(true)
      Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Window_Knowledge_Renew_SelectChase(true)")
      if selectCharacterKey == 0 or ToClient_isPossibleChase(selectCharacterKey) == false then
        chaseStartText = "<PAColor0xffb82929>" .. chaseStartText .. "<PAOldColor>"
      end
    end
    self._ui.stc_keyGuideChaseStart:SetText(chaseStartText)
    self:alignBottomKeyGuide()
  elseif self._chaseData.lastSelectKey == chaseTargetKeyRaw then
    self._ui.stc_keyGuideChaseStop:SetShow(true)
    Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Window_Knowledge_Renew_SelectChase(false)")
    self:alignBottomKeyGuide()
  else
    local theme = knowledge:getThemeByKeyRaw(-self._chaseData.lastSelectKey)
    if theme == nil then
      return
    end
    local childCardCount = theme:getChildCardCount()
    if childCardCount == 0 then
      return
    end
    for idx = 0, childCardCount - 1 do
      local childCard = theme:getChildCardByIndex(idx)
      if nil ~= childCard then
        local characterKey = ToClient_getCharacterKeyByMentalCardKey(childCard:getKey())
        if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
          self._ui.stc_keyGuideChaseStart:SetShow(true)
          self:alignBottomKeyGuide()
          Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Window_Knowledge_Renew_SelectChase(true)")
          break
        end
      end
    end
  end
end
function Panel_Window_Knowledge_Renew_info:selectChase(isSetting)
  if false == _ContentsGroup_ChaseMonster then
    return
  end
  if nil == self._chaseData then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if nil == selfPlayerWrrapper then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if nil == selfPlayer then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if nil == knowledge then
    return
  end
  local function chaseUpdate()
    if nil ~= FGlobal_Radar_UpdateActorIconColor then
      FGlobal_Radar_UpdateActorIconColor()
    end
    self:updateChasePadFunction()
    self._ui.list2_CategoryItem:requestUpdateVisible()
    self:setChaseName()
  end
  local prevChaseTargetKeyRaw = ToClient_getChaseTargetKeyRaw()
  if true == isSetting then
    if false == self._chaseData.isEcology then
      return
    end
    if 0 == self._chaseData.lastSelectKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
      return
    end
    if 0 < self._chaseData.lastSelectKey then
      local currentTheme = knowledge:getCurrentTheme()
      if nil == currentTheme then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      local currentThemeKey = currentTheme:getKey()
      if currentThemeKey < self._chaseData.ecologyMinThemaKey or currentThemeKey > self._chaseData.ecologyMaxThemaKey then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      local card = knowledge:getCardByKeyRaw(self._chaseData.lastSelectKey)
      if nil == card then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      local selectCharacterKey = ToClient_getCharacterKeyByMentalCardKey(self._chaseData.lastSelectKey)
      if 0 == selectCharacterKey or false == ToClient_isPossibleChase(selectCharacterKey) then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
        return
      end
      if prevChaseTargetKeyRaw <= 0 then
        ToClient_clearChaseMonsterList()
      end
      local rv = ToClient_startChaseMonster(self._chaseData.lastSelectKey)
      if rv ~= 0 then
        Proc_ShowMessage_Ack(PAGetStringSymNo(rv))
        return
      end
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ENABLE"))
      self:updateChaseName()
      chaseUpdate()
    else
      do
        local theme = knowledge:getThemeByKeyRaw(-self._chaseData.lastSelectKey)
        if nil == theme then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
          return
        end
        local childCardCount = theme:getChildCardCount()
        if 0 == childCardCount then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
          return
        end
        local function chaseStart()
          ToClient_clearChaseMonsterList()
          local rv = ToClient_startChaseMonster(self._chaseData.lastSelectKey)
          if rv ~= 0 then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
            return
          end
          local themeName = theme:getName()
          if nil ~= themeName then
            self._chaseData.chaseName = themeName
          end
          self._ui.list2_Category:requestUpdateVisible()
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ENABLE"))
          chaseUpdate()
        end
        local checkImpossibleChase = false
        local isPossibleChase = false
        for idx = 0, childCardCount - 1 do
          local childCard = theme:getChildCardByIndex(idx)
          if nil ~= childCard then
            local cardKey = childCard:getKey()
            local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
            if 0 ~= characterKey and true == ToClient_isPossibleChase(characterKey) then
              isPossibleChase = true
            else
              checkImpossibleChase = true
            end
          end
        end
        if false == isPossibleChase then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_ELITE"))
          return
        end
        local messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_COMPLETE")
        if true == checkImpossibleChase then
          messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_ALRET")
        end
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
          content = messageDesc,
          functionYes = chaseStart,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
      end
    end
  else
    local function chaseStop()
      local selectedButtonIndex = MessageBoxCheck.getSelectedButtonIndex()
      local checkCardKey
      if selectedButtonIndex ~= nil and selectedButtonIndex == 1 and prevChaseTargetKeyRaw > 0 and 0 < self._chaseData.lastSelectKey and ToClient_isChaseMonster(ToClient_getCharacterKeyByMentalCardKey(self._chaseData.lastSelectKey)) == true then
        checkCardKey = self._chaseData.lastSelectKey
      end
      if prevChaseTargetKeyRaw < 0 then
        ToClient_clearChaseMonsterList()
        self._ui.list2_Category:requestUpdateVisible()
      elseif checkCardKey == nil then
        ToClient_clearChaseMonsterList()
      else
        ToClient_removeChaseMonster(checkCardKey)
      end
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "NAKMSG_MONSTERTRACKING_DISABLE"))
      self:updateChaseName()
      chaseUpdate()
    end
    if prevChaseTargetKeyRaw > 0 then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGETRACKING_CANCEL_DESC"),
        functionApply = chaseStop,
        functionCancel = MessageBox_Empty_function,
        buttonStrings = {
          PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGETRACKING_CANCEL_SELECT"),
          PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGETRACKING_CANCEL_ALL")
        },
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBoxCheck.showMessageBox(messageBoxData, "middle")
      MessageBoxCheck.setCheck(1)
    else
      local messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MONSTERTRACKING_SELECTTHEME_CANCEL")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = messageDesc,
        functionYes = chaseStop,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function Panel_Window_Knowledge_Renew_info:findChase()
  if _ContentsGroup_ChaseMonster == false then
    return
  end
  local selfPlayerWrrapper = getSelfPlayer()
  if selfPlayerWrrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if selfPlayer == nil then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if knowledge == nil then
    return
  end
  local chaseTargetKeyRaw = ToClient_getChaseTargetKeyRaw()
  if chaseTargetKeyRaw == 0 then
    return
  elseif chaseTargetKeyRaw > 0 then
    local chaseCardKey = 0
    local cardKeyCheckTable = {}
    local chaseCardCount = ToClient_getChaseCharacterKeyCount()
    for index = 0, chaseCardCount - 1 do
      local cardKeyRaw = ToClient_getChaseCardKeyByIndex(index)
      if cardKeyRaw ~= 0 then
        local isFind = false
        for _, value in ipairs(cardKeyCheckTable) do
          if value == cardKeyRaw then
            isFind = true
            break
          end
        end
        if isFind == false then
          local card = knowledge:getCardByKeyRaw(cardKeyRaw)
          if card ~= nil then
            local cardKey = card:getKey()
            local characterKey = ToClient_getCharacterKeyByMentalCardKey(cardKey)
            if ToClient_isChaseMonster(characterKey) == true then
              table.insert(cardKeyCheckTable, cardKey)
            end
          end
        end
      end
    end
    if #cardKeyCheckTable < self._chaseData.chaseNextFindIndex or 0 >= self._chaseData.chaseNextFindIndex then
      self._chaseData.chaseNextFindIndex = 1
    end
    for index, value in ipairs(cardKeyCheckTable) do
      if index == self._chaseData.chaseNextFindIndex then
        chaseCardKey = value
        break
      end
    end
    self._chaseData.chaseNextFindIndex = self._chaseData.chaseNextFindIndex + 1
    local chaseCard = knowledge:getCardByKeyRaw(chaseCardKey)
    if chaseCard == nil then
      return
    end
    local childCardCount = 0
    local chaseCardIndex = -1
    local chaseCardParentsIndex = -1
    local ecologyThemaIndex = -1
    local chaseCardParentsName, ecologyThemaName
    local chaseCardParents = chaseCard:getParents()
    if chaseCardParents == nil then
      return
    end
    childCardCount = chaseCardParents:getChildCardCount()
    if childCardCount <= 0 then
      return
    end
    for index = 0, childCardCount - 1 do
      local card = chaseCardParents:getChildCardByIndex(index)
      if card ~= nil and chaseCardKey == card:getKey() then
        chaseCardIndex = index
        break
      end
    end
    if chaseCardIndex == -1 then
      return
    end
    local ecologyThema = chaseCardParents:getParents()
    if ecologyThema == nil then
      return
    end
    local chaseCardParentsKey = chaseCardParents:getKey()
    local childThemaCount = ecologyThema:getChildThemeCount()
    for index = 0, childThemaCount - 1 do
      local thema = ecologyThema:getChildThemeByIndex(index)
      if thema ~= nil and chaseCardParentsKey == thema:getKey() then
        chaseCardParentsIndex = index
        chaseCardParentsName = thema:getName()
        break
      end
    end
    if chaseCardParentsIndex == -1 or chaseCardParentsName == nil then
      return
    end
    local mainThema = ecologyThema:getParents()
    if mainThema == nil then
      return
    end
    local ecologyThemaKey = ecologyThema:getKey()
    local childThemaCount = mainThema:getChildThemeCount()
    for index = 0, childThemaCount - 1 do
      local thema = mainThema:getChildThemeByIndex(index)
      if thema ~= nil and ecologyThemaKey == thema:getKey() then
        ecologyThemaIndex = index
        ecologyThemaName = thema:getName()
        break
      end
    end
    if ecologyThemaIndex == -1 or ecologyThemaName == nil then
      return
    end
    local ecologyCategoriIndex = self._chaseData.ecologyCategoriIndex
    local mainThemaKey = mainThema:getKey()
    if mainThemaKey == 0 then
      PaGlobalFunc_Window_Knowledge_Page0_ClickButton(ecologyCategoriIndex, ecologyThemaName)
      PaGlobalFunc_Window_Knowledge_Page1_ClickButton(chaseCardParentsIndex, chaseCardParentsName)
    else
      local categoriThema = mainThema:getParents()
      if categoriThema == nil then
        return
      end
      local mainThemaName = ""
      local childThemaCount = categoriThema:getChildThemeCount()
      for index = 0, childThemaCount - 1 do
        local thema = categoriThema:getChildThemeByIndex(index)
        if thema ~= nil and mainThemaKey == thema:getKey() then
          mainThemaName = thema:getName()
          break
        end
      end
      if mainThemaName == nil then
        return
      end
      PaGlobalFunc_Window_Knowledge_Page0_ClickButton(ecologyCategoriIndex, mainThemaName)
      PaGlobalFunc_Window_Knowledge_Page1_ClickButton(ecologyThemaIndex, ecologyThemaName)
      PaGlobalFunc_Window_Knowledge_Page2_ClickButton(chaseCardParentsIndex, chaseCardParentsName)
    end
    self._ui.list2_CategoryItem:moveIndex(chaseCardIndex)
    self._chaseData.isChaseFindCard = true
    self._chaseData.chaseFindIndex = chaseCardIndex
  else
    local theme = knowledge:getThemeByKeyRaw(-chaseTargetKeyRaw)
    if theme == nil then
      return
    end
    local chaseCardIndex = -1
    local childCardCount = theme:getChildCardCount()
    if childCardCount <= 0 then
      return
    end
    for index = 0, childCardCount - 1 do
      local card = theme:getChildCardByIndex(index)
      if card ~= nil then
        local characterKey = ToClient_getCharacterKeyByMentalCardKey(card:getKey())
        if ToClient_isChaseMonster(characterKey) == true then
          chaseCardIndex = index
          break
        end
      end
    end
    if chaseCardIndex == -1 then
      return
    end
    local chaseThemeCount = 0
    local chaseThemeIndex = -1
    local ecologyThemaIndex = -1
    local ecologyThemaName
    local chaseThemeKey = theme:getKey()
    local chaseThemeName = theme:getName()
    local ecologyThema = theme:getParents()
    if ecologyThema == nil then
      return
    end
    chaseThemeCount = ecologyThema:getChildThemeCount()
    for index = 0, chaseThemeCount - 1 do
      local curThema = ecologyThema:getChildThemeByIndex(index)
      if curThema ~= nil and chaseThemeKey == curThema:getKey() then
        chaseThemeIndex = index
        break
      end
    end
    if chaseThemeIndex == -1 then
      return
    end
    local mainThema = ecologyThema:getParents()
    if mainThema == nil then
      return
    end
    local ecologyThemaKey = ecologyThema:getKey()
    local childThemaCount = mainThema:getChildThemeCount()
    for index = 0, childThemaCount - 1 do
      local thema = mainThema:getChildThemeByIndex(index)
      if nil ~= thema and ecologyThemaKey == thema:getKey() then
        ecologyThemaIndex = index
        ecologyThemaName = thema:getName()
        break
      end
    end
    if ecologyThemaIndex == -1 or ecologyThemaName == nil then
      return
    end
    local mainThemaKey = mainThema:getKey()
    if mainThemaKey == 0 then
      return
    end
    local categoriThema = mainThema:getParents()
    if categoriThema == nil then
      return
    end
    local mainThemaName = ""
    local childThemaCount = categoriThema:getChildThemeCount()
    for index = 0, childThemaCount - 1 do
      local thema = categoriThema:getChildThemeByIndex(index)
      if thema ~= nil and mainThemaKey == thema:getKey() then
        mainThemaName = thema:getName()
        break
      end
    end
    if mainThemaName == nil then
      return
    end
    local ecologyCategoriIndex = self._chaseData.ecologyCategoriIndex
    PaGlobalFunc_Window_Knowledge_Page0_ClickButton(ecologyCategoriIndex, mainThemaName)
    PaGlobalFunc_Window_Knowledge_Page1_ClickButton(ecologyThemaIndex, ecologyThemaName)
    PaGlobalFunc_Window_Knowledge_Page2_ClickButton(chaseThemeIndex, chaseThemeName)
    self._ui.list2_CategoryItem:moveIndex(chaseCardIndex)
    self._chaseData.chaseFindIndex = chaseCardIndex
    self._chaseData.isChaseFindCard = true
  end
  if Panel_Window_Knowledge_Renew ~= nil then
    self._chaseData.isChaseFind = true
    Panel_Window_Knowledge_Renew:RegisterUpdateFunc("PaGlobalFunc_Window_Knowledge_Renew_UpdateChaseFindSnap")
  end
end
function Panel_Window_Knowledge_Renew_info:updateChaseFindSnap(deltaTime)
  if false == _ContentsGroup_ChaseMonster or nil == Panel_Window_Knowledge_Renew then
    Panel_Window_Knowledge_Renew:ClearUpdateLuaFunc()
    return
  end
  if true == self._chaseData.isChaseFind then
    self._chaseData.isChaseFind = false
    return
  end
  local key = toInt64(0, self._chaseData.chaseFindIndex)
  local content
  if true == self._chaseData.isChaseFindCard then
    content = self._ui.list2_CategoryItem:GetContentByKey(key)
  else
    content = self._ui.list2_Category:GetContentByKey(key)
  end
  if nil ~= content and true == content:GetShow() then
    ToClient_padSnapChangeToTarget(content)
  end
  Panel_Window_Knowledge_Renew:ClearUpdateLuaFunc()
end
function Panel_Window_Knowledge_Renew_info:setChaseName()
  if _ContentsGroup_ChaseMonster == false then
    return
  end
  if Panel_Window_Knowledge_Renew == nil then
    return
  end
  local chaseName = self._chaseData.chaseName
  if chaseName == nil then
    self._ui.staticText_ChaseTooltipName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TXT_FILTER_0"))
  else
    self._ui.staticText_ChaseTooltipName:SetText(chaseName)
  end
  local chaseNameGapY = self._value.baseChaseNameTextSizeY - self._ui.staticText_ChaseTooltipName:GetTextSizeY()
  self._ui.static_ChaseDesc:SetSpanSize(self._ui.static_ChaseDesc:GetSpanSize().x, self._value.baseChaseDescLineSpanY - chaseNameGapY)
end
function PaGlobalFunc_Window_Knowledge_Renew_UpdateChaseFindSnap(deltaTime)
  Panel_Window_Knowledge_Renew_info:updateChaseFindSnap(deltaTime)
end
function PaGlobalFunc_Window_Knowledge_Renew_ShowChaseGuide()
  if false == _ContentsGroup_ChaseMonster then
    return
  end
  if nil == Panel_Window_Knowledge_Renew or false == Panel_Window_Knowledge_Renew:GetShow() then
    return
  end
  local isShowChaseTooltip = Panel_Window_Knowledge_Renew_info._ui.static_TooltipChaseBg:GetShow()
  if false == isShowChaseTooltip then
    Panel_Window_Knowledge_Renew_info._ui.staticText_TooltipBg:SetShow(false)
    Panel_Window_Knowledge_Renew_info._ui.static_TooltipChaseBg:SetShow(true)
    Panel_Window_Knowledge_Renew_info:setChaseName()
  else
    Panel_Window_Knowledge_Renew_info._ui.static_TooltipChaseBg:SetShow(false)
  end
end
function HandleEventLUp_KnowledgeRenew_ShowRateView()
  PaGlobalFunc_Util_OpenRateView(PaGlobalFunc_Window_Knowledge_Exit)
end
function PaGlobalFunc_Window_Knowledge_Renew_SelectChase(isSetting)
  Panel_Window_Knowledge_Renew_info:selectChase(isSetting)
end
function PaGlobalFunc_Window_Knowledge_Renew_FindChaseCard()
  Panel_Window_Knowledge_Renew_info:findChase()
end
function PaGlobalFunc_Window_Knowledge_Renew_ShowAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  local self = Panel_Window_Knowledge_Renew_info
  Panel_Window_Knowledge_Renew:ResetVertexAni()
  local aniInfo1 = Panel_Window_Knowledge_Renew:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(getOriginScreenSizeX(), 0)
  aniInfo1:SetEndPosition(getOriginScreenSizeX() - Panel_Window_Knowledge_Renew:GetSizeX(), 0)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(false)
  aniInfo1:SetDisableWhileAni(true)
  aniInfo1:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_Window_Knowledge_Renew_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_Window_Knowledge_Renew:ResetVertexAni()
  local aniInfo1 = Panel_Window_Knowledge_Renew:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartPosition(Panel_Window_Knowledge_Renew:GetPosX(), 0)
  aniInfo1:SetEndPosition(Panel_Window_Knowledge_Renew:GetPosX() + Panel_Window_Knowledge_Renew:GetSizeX(), 0)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  aniInfo1:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_Window_Knowledge_GetShow()
  return Panel_Window_Knowledge_Renew:GetShow()
end
function PaGlobalFunc_Window_Knowledge_Show()
  if PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction ~= nil and PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction() == true or PaGlobalFunc_BossReward_IsOpen ~= nil and PaGlobalFunc_BossReward_IsOpen() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEOPENALERT_INDEAD"))
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  local self = Panel_Window_Knowledge_Renew_info
  self:preOpen()
  self:open(true)
  self:setContent()
end
function PaGlobalFunc_Window_Knowledge_Exit()
  local self = Panel_Window_Knowledge_Renew_info
  if nil ~= Panel_Window_Knowledge_Renew then
    Panel_Window_Knowledge_Renew:ClearUpdateLuaFunc()
  end
  self:closeInfo()
  self:close(true)
end
function PaGlobalFunc_Window_Knowledge_GOBackStep()
  local self = Panel_Window_Knowledge_Renew_info
  if true == self:getShowInfo() then
    self:closeInfo()
  end
  self._value.currentStep = self._value.currentStep - 1
  if self._value.currentStep == self._enum.eSTEP_GROUP_2 then
    if true == self._value.step3_useCard then
      self._value.currentStep = self._value.currentStep - 1
    else
      local knowledge = getSelfPlayer():get():getMentalKnowledge()
      local theme = knowledge:getThemeByKeyRaw(self._value.step2_selectMentalObjectKey)
      knowledge:setCurrentTheme(theme)
      self:setContent()
      return
    end
  end
  if self._value.currentStep == self._enum.eSTEP_GROUP_1 then
    if true == self._value.step2_useCard then
      self._value.currentStep = self._value.currentStep - 1
    else
      local knowledge = getSelfPlayer():get():getMentalKnowledge()
      local theme = knowledge:getThemeByKeyRaw(self._value.step1_selectMentalObjectKey)
      knowledge:setCurrentTheme(theme)
      self:setContent()
      return
    end
  end
  if self._value.currentStep == self._enum.eSETP_SUBCATEGORY then
    local knowledge = getSelfPlayer():get():getMentalKnowledge()
    local theme = knowledge:getThemeByKeyRaw(self._value.step0_selectMentalObjectKey)
    knowledge:setCurrentTheme(theme)
    self:setContent()
    return
  end
  if self._enum.eSTEP_CATEGORY == self._value.currentStep then
    self:setContent()
    return
  end
  if self._value.currentStep < 0 then
    self._value.currentStep = self._enum.eSTEP_CATEGORY
    PaGlobalFunc_Window_Knowledge_Exit()
  end
end
function PaGlobalFunc_Window_Knowledge_Page2_Pass()
  local self = Panel_Window_Knowledge_Renew_info
  self._value.currentStep = self._enum.eSTEP_GROUP_3
  self:updateTopText()
  self:setContent()
end
function PaGlobalFunc_Window_Knowledge_Page3_Pass()
  local self = Panel_Window_Knowledge_Renew_info
  self._value.currentStep = self._enum.eSTEP_GROUP_3
  self:updateTopText()
  self:setContent()
end
function PaGlobalFunc_Window_Knowledge_Page4_SelectButton(index)
  local self = Panel_Window_Knowledge_Renew_info
  self._value.step4_lastIndex = self._value.step4_currentIndex
  self._value.step4_currentIndex = index
  self._ui.list2_CategoryItem:requestUpdateByKey(toInt64(0, self._value.step4_lastIndex))
  self._ui.list2_CategoryItem:requestUpdateByKey(toInt64(0, self._value.step4_currentIndex))
end
function PaGlobalFunc_Window_Knowledge_Page4_ClickButton(index)
  local self = Panel_Window_Knowledge_Renew_info
  PaGlobalFunc_Window_Knowledge_Page4_SelectButton(index)
  self:setContentInfo()
end
function PaGlobalFunc_Window_Knowledge_Page3_SelectButton(index)
  local self = Panel_Window_Knowledge_Renew_info
  if self._value.step3_currentIndex == index then
    return
  end
  self._value.step3_lastIndex = self._value.step3_currentIndex
  self._value.step3_currentIndex = index
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step3_lastIndex))
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step3_currentIndex))
end
function PaGlobalFunc_Window_Knowledge_Page3_ClickButton(index, subCategory)
  local self = Panel_Window_Knowledge_Renew_info
  PaGlobalFunc_Window_Knowledge_Page3_SelectButton(index)
  self._value.stepTextList[self._enum.eSTEP_GROUP_2] = subCategory
  self._value.currentStep = self._enum.eSTEP_GROUP_3
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
  self._value.step3_selectMentalObjectKey = childkey
  local mentalObjectKey = self._value.step3_selectMentalObjectKey
  if mentalObjectKey > 0 then
    local theme = knowledge:getThemeByKeyRaw(mentalObjectKey)
    if nil == theme then
      return
    end
    knowledge:setCurrentTheme(theme)
    self:updateTopText()
    self:setContent()
  end
end
function PaGlobalFunc_Window_Knowledge_Page2_SelectButton(index)
  local self = Panel_Window_Knowledge_Renew_info
  if true == _ContentsGroup_ChaseMonster then
    local selfPlayerWrrapper = getSelfPlayer()
    if nil == selfPlayerWrrapper then
      return
    end
    local selfPlayer = selfPlayerWrrapper:get()
    if nil == selfPlayer then
      return
    end
    local knowledge = selfPlayer:getMentalKnowledge()
    if nil == knowledge then
      return
    end
    local mentalObjectKey = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
    if mentalObjectKey == 0 then
      return
    end
    local theme = knowledge:getThemeByKeyRaw(mentalObjectKey)
    if nil == theme then
      return
    end
    self._chaseData.lastSelectKey = -theme:getKey()
    self:updateChasePadFunction()
  end
  if self._value.step2_currentIndex == index then
    return
  end
  self._value.step2_lastIndex = self._value.step2_currentIndex
  self._value.step2_currentIndex = index
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step2_lastIndex))
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step2_currentIndex))
end
function PaGlobalFunc_Window_Knowledge_Page2_ClickButton(index, subCategory)
  local self = Panel_Window_Knowledge_Renew_info
  PaGlobalFunc_Window_Knowledge_Page2_SelectButton(index)
  self._value.stepTextList[self._enum.eSTEP_GROUP_1] = subCategory
  self._value.currentStep = self._enum.eSTEP_GROUP_2
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
  self._value.step2_selectMentalObjectKey = childkey
  local mentalObjectKey = self._value.step2_selectMentalObjectKey
  if mentalObjectKey > 0 then
    local theme = knowledge:getThemeByKeyRaw(mentalObjectKey)
    if nil == theme then
      return
    end
    knowledge:setCurrentTheme(theme)
    self:updateTopText()
    self:setContent()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
end
function PaGlobalFunc_Window_Knowledge_Page1_SelectButton(index)
  local self = Panel_Window_Knowledge_Renew_info
  if self._value.step1_currentIndex == index then
    return
  end
  self._value.step1_lastIndex = self._value.step1_currentIndex
  self._value.step1_currentIndex = index
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step1_lastIndex))
  self._ui.list2_Category:requestUpdateByKey(toInt64(0, self._value.step1_currentIndex))
end
function PaGlobalFunc_Window_Knowledge_Page1_ClickButton(index, subCategory)
  local self = Panel_Window_Knowledge_Renew_info
  PaGlobalFunc_Window_Knowledge_Page1_SelectButton(index)
  self._value.stepTextList[self._enum.eSETP_SUBCATEGORY] = subCategory
  self._value.currentStep = self._enum.eSTEP_GROUP_1
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
  self._value.step1_selectMentalObjectKey = childkey
  local mentalObjectKey = self._value.step1_selectMentalObjectKey
  if mentalObjectKey > 0 then
    local theme = knowledge:getThemeByKeyRaw(mentalObjectKey)
    if nil == theme then
      return
    end
    knowledge:setCurrentTheme(theme)
    self:updateTopText()
    self:setContent()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
end
function PaGlobalFunc_Window_Knowledge_Page0_HideButtonA(hideButtonA)
  local self = Panel_Window_Knowledge_Renew_info
  if nil == hideButtonA then
    hideButtonA = true
  end
  self._ui.stc_keyGuideSelect:SetShow(hideButtonA)
  self:alignBottomKeyGuide()
end
function PaGlobalFunc_Window_Knowledge_Page0_SelectButton(index, hideButtonA)
  local self = Panel_Window_Knowledge_Renew_info
  if nil == hideButtonA then
    hideButtonA = true
  end
  self._value.step0_currentIndex = index
  self._ui.stc_keyGuideSelect:SetShow(hideButtonA)
  self:alignBottomKeyGuide()
end
function PaGlobalFunc_Window_Knowledge_Page0_ClickButton(index, category)
  local self = Panel_Window_Knowledge_Renew_info
  PaGlobalFunc_Window_Knowledge_Page0_SelectButton(index)
  self._value.stepTextList[self._enum.eSTEP_CATEGORY] = category
  self._value.currentStep = self._enum.eSETP_SUBCATEGORY
  self._value.step0_selectMentalObjectKey = self._ui.button_Category[index].mentalCardKeyRaw
  if 0 == self._value.step0_selectMentalObjectKey then
    return
  end
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  local mentalObjectKey = self._value.step0_selectMentalObjectKey
  if mentalObjectKey > 0 then
    local theme = knowledge:getThemeByKeyRaw(mentalObjectKey)
    if nil == theme then
      return
    end
    knowledge:setCurrentTheme(theme)
    if true == _ContentsGroup_ChaseMonster then
      local currentThemeKey = theme:getKey()
      self._chaseData.isEcology = currentThemeKey >= self._chaseData.ecologyMinThemaKey and currentThemeKey <= self._chaseData.ecologyMaxThemaKey
    end
    self:updateTopText()
    self:setContent()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function PaGlobalFunc_Window_Knowledge_Step_123List(list_content, key)
  local id = Int64toInt32(key)
  local button = UI.getChildControl(list_content, "Button_CategoryName")
  local text = UI.getChildControl(button, "StaticText_CategoryName")
  local energyIcon = UI.getChildControl(list_content, "StaticText_EnergyIcon")
  local key_A = UI.getChildControl(list_content, "Static_Key_ConsoleUI")
  local self = Panel_Window_Knowledge_Renew_info
  key_A:SetShow(false)
  local textSizeX = button:GetSizeX() - key_A:GetSizeX()
  text:SetSize(textSizeX, text:GetSizeY())
  text:SetFontColor(Defines.Color.C_FFFFFFFF)
  text:SetTextMode(__eTextMode_LimitText)
  local chaseTargetKeyRaw = ToClient_getChaseTargetKeyRaw()
  if self._enum.eSETP_SUBCATEGORY == self._value.currentStep then
    if self._value.step1_currentIndex == id then
      key_A:SetShow(true)
    end
    if self._value.step1_lastIndex == id then
      key_A:SetShow(false)
    end
    energyIcon:SetShow(false)
    local knowledge = getSelfPlayer():get():getMentalKnowledge()
    local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(id)
    local theme = knowledge:getThemeByKeyRaw(childkey)
    local subCategoryName = theme:getName()
    local addText = ""
    if 0 < theme:getMaxIncreaseWp() then
      energyIcon:SetShow(true)
      energyIcon:SetText(theme:getIncreaseWp() .. "/" .. theme:getMaxIncreaseWp() .. " ")
      text:SetSize(textSizeX - energyIcon:GetSizeX() - energyIcon:GetTextSizeX(), text:GetSizeY())
    end
    if theme:getCardCollectedCount() == theme:getCardCollectMaxCount() then
      text:SetFontColor(Defines.Color.C_FF6DC6FF)
    end
    text:SetText(subCategoryName .. addText)
    if text:IsLimitText() == true then
      text:SetIgnore(true)
    end
    button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page1_SelectButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
    button:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Knowledge_Page1_ClickButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
  end
  if self._enum.eSTEP_GROUP_1 == self._value.currentStep then
    if self._value.step2_currentIndex == id then
      key_A:SetShow(true)
    end
    if self._value.step2_lastIndex == id then
      key_A:SetShow(false)
    end
    energyIcon:SetShow(false)
    do
      local knowledge = getSelfPlayer():get():getMentalKnowledge()
      if false == self._value.step2_useCard then
        local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(id)
        local theme = knowledge:getThemeByKeyRaw(childkey)
        local subCategoryName = theme:getName()
        if 0 < theme:getMaxIncreaseWp() then
          energyIcon:SetShow(true)
          energyIcon:SetText(theme:getIncreaseWp() .. "/" .. theme:getMaxIncreaseWp() .. " ")
          text:SetSize(textSizeX - energyIcon:GetSizeX() - energyIcon:GetTextSizeX(), text:GetSizeY())
        end
        if theme:getCardCollectedCount() == theme:getCardCollectMaxCount() then
          text:SetFontColor(Defines.Color.C_FF6DC6FF)
        end
        local setName = subCategoryName
        if chaseTargetKeyRaw < 0 and -chaseTargetKeyRaw == childkey then
          setName = "<PAColor0xff84fff5>" .. subCategoryName .. "<PAOldColor>"
        end
        text:SetText(setName)
        if text:IsLimitText() == true then
          text:SetIgnore(true)
        end
        button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page2_SelectButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
        button:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Knowledge_Page2_ClickButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
      end
    end
  else
  end
  if self._enum.eSTEP_GROUP_2 == self._value.currentStep then
    if self._value.step3_currentIndex == id then
      key_A:SetShow(true)
    end
    if self._value.step3_lastIndex == id then
      key_A:SetShow(false)
    end
    energyIcon:SetShow(false)
    local knowledge = getSelfPlayer():get():getMentalKnowledge()
    if false == self._value.step3_useCard then
      local childkey = knowledge:getCurrentThemeChildThemeKeyByIndex(id)
      local theme = knowledge:getThemeByKeyRaw(childkey)
      local subCategoryName = theme:getName()
      if 0 < theme:getMaxIncreaseWp() then
        energyIcon:SetShow(true)
        energyIcon:SetText(theme:getIncreaseWp() .. "/" .. theme:getMaxIncreaseWp() .. " ")
        text:SetSize(textSizeX - energyIcon:GetSizeX() - energyIcon:GetTextSizeX(), text:GetSizeY())
      end
      if theme:getCardCollectedCount() == theme:getCardCollectMaxCount() then
        text:SetFontColor(Defines.Color.C_FF6DC6FF)
      end
      local setName = subCategoryName
      if chaseTargetKeyRaw < 0 and -chaseTargetKeyRaw == childkey then
        setName = "<PAColor0xff84fff5>" .. subCategoryName .. "<PAOldColor>"
      end
      text:SetText(setName)
      if text:IsLimitText() == true then
        text:SetIgnore(true)
      end
      button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page3_SelectButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
      button:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Knowledge_Page3_ClickButton(" .. id .. ",\"" .. subCategoryName .. "\"" .. ")")
    end
  else
  end
end
function PaGlobalFunc_Window_Knowledge_Step_4List(list_content, key)
  local selfPlayerWrrapper = getSelfPlayer()
  if selfPlayerWrrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrrapper:get()
  if selfPlayer == nil then
    return
  end
  local knowledge = selfPlayer:getMentalKnowledge()
  if knowledge == nil then
    return
  end
  local button = UI.getChildControl(list_content, "Button_CategoryItemName")
  if button == nil then
    return
  end
  local id = Int64toInt32(key)
  local childkey = knowledge:getCurrentThemeChildCardKeyByIndex(id)
  local card = knowledge:getCardByKeyRaw(childkey)
  if card == nil then
    return
  end
  button:SetTextMode(__eTextMode_LimitText)
  local cardName = card:getName()
  if _ContentsGroup_ChaseMonster == true then
    local chaseCharacterKey = ToClient_getCharacterKeyByMentalCardKey(card:getKey())
    if chaseCharacterKey ~= 0 and ToClient_isChaseMonster(chaseCharacterKey) == true then
      local strsplit = string.split(cardName, "]")
      if strsplit[2] ~= nil then
        local grade = strsplit[1]
        local monsterName = strsplit[2]
        cardName = grade .. "]<PAColor0xff84fff5>" .. monsterName .. "<PAOldColor>"
      else
        cardName = "<PAColor0xff84fff5>" .. cardName .. "<PAOldColor>"
      end
    end
  end
  button:SetText(cardName)
  button:addInputEvent("Mouse_On", "PaGlobalFunc_Window_Knowledge_Page4_ClickButton(" .. id .. ")")
end
function PaGlobalFunc_Window_Knowledge_ToggleTooltip()
  local self = Panel_Window_Knowledge_Renew_info
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  if true == self._ui.staticText_TooltipBg:GetShow() then
    self:closeTooltip()
  else
    self:openTooltip()
  end
end
function PaGlobalFunc_Window_Knowledge_SetSelectList(themeKeyArray)
  if themeKeyArray == nil then
    return
  end
  local knowledge = getSelfPlayer():get():getMentalKnowledge()
  if knowledge == nil then
    return
  end
  if themeKeyArray[1] == nil then
    return
  end
  for key, value in pairs(themeKeyArray) do
    local mentalObject = knowledge:getThemeByKeyRaw(value)
    if mentalObject ~= nil then
      local categoryName = mentalObject:getName()
      local controlIndex = themeKeyKey_ControlMapping[value]
      PaGlobalFunc_Window_Knowledge_Page0_ClickButton(controlIndex, categoryName)
      break
    else
      return
    end
  end
  if themeKeyArray[2] == nil then
    return
  end
  local childCount = knowledge:getCurrentThemeChildThemeCount()
  for index = 0, childCount - 1 do
    local themeKeyRaw = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
    if themeKeyRaw == themeKeyArray[2] then
      local theme = knowledge:getThemeByKeyRaw(themeKeyRaw)
      if theme ~= nil then
        local subCategoryName = theme:getName()
        PaGlobalFunc_Window_Knowledge_Page1_ClickButton(index, subCategoryName)
        break
      else
        return
      end
    end
  end
  if themeKeyArray[3] == nil then
    return
  end
  childCount = knowledge:getCurrentThemeChildThemeCount()
  if childCount == 0 then
    childCount = knowledge:getCurrentThemeChildCardCount()
    if childCount == 0 then
      return
    end
  end
  for index = 0, childCount - 1 do
    local themeKeyRaw = knowledge:getCurrentThemeChildThemeKeyByIndex(index)
    if themeKeyRaw == themeKeyArray[3] then
      local theme = knowledge:getThemeByKeyRaw(themeKeyRaw)
      if theme ~= nil then
        local subCategoryName = theme:getName()
        PaGlobalFunc_Window_Knowledge_Page2_ClickButton(index, subCategoryName)
        break
      else
        return
      end
    end
  end
end
function FromClient_Window_Knowledge_Renew_Init()
  local self = Panel_Window_Knowledge_Renew_info
  self:initialize()
  Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_Window_Knowledge_ToggleTooltip()")
  Panel_Window_Knowledge_Renew:registerPadEvent(__eConsoleUIPadEvent_LBPress_X, "HandleEventLUp_KnowledgeRenew_ShowRateView()")
end
function FromClient_Window_Knowledge_Renew_Resize()
  local self = Panel_Window_Knowledge_Renew_info
  self:resize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Knowledge_Renew_Init")
