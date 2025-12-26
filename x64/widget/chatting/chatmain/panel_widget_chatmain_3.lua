local UI_color = Defines.Color
local UI_CT = CppEnums.ChatType
local UI_Group = Defines.UIGroup
function PaGlobal_ChatMain:initialize_Pool()
  if true == PaGlobal_ChatMain._initialize then
    return
  end
  PaGlobal_ChatMain._chatRenderMode = PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_WorldMap,
    Defines.RenderMode.eRenderMode_RoseWar,
    Defines.RenderMode.eRenderMode_SequencePlayerControl,
    Defines.RenderMode.eRenderMode_InstanceContentsCeremony
  })
  local divisionPanel, panel, panelSizeX, panelSizeY, chatUI
  for poolIndex = 0, PaGlobal_ChatMain._POOLCOUNT - 1 do
    PaGlobal_ChatMain._listPanel[poolIndex] = PaGlobal_ChatMain:createPanel(poolIndex, Panel_Chat)
    PaGlobal_ChatMain._listChatUIPool[poolIndex] = PaGlobal_ChatMain:createPool(poolIndex, Panel_Chat, PaGlobal_ChatMain._listPanel[poolIndex])
    divisionPanel = ToClient_getChattingPanel(poolIndex)
    panel = PaGlobal_ChatMain._listPanel[poolIndex]
    chatUI = PaGlobal_ChatMain._listChatUIPool[poolIndex]
    if 0 < divisionPanel:getPanelSizeX() then
      panelSizeX = divisionPanel:getPanelSizeX()
      panelSizeY = divisionPanel:getPanelSizeY()
      panel:SetSize(panelSizeX, panelSizeY)
      chatUI._list_PanelBG[0]:SetSize(panelSizeX, panelSizeY)
      chatUI._list_Scroll[0]:SetSize(chatUI._list_Scroll[0]:GetSizeX(), panelSizeY - 67)
      for chattingContents_idx = 0, chatUI._MAXCOUNT_CHATTINGCONTENTS - 1 do
        chatUI._list_ChattingContents[chattingContents_idx]:SetSize(panelSizeX - 25, chatUI._list_ChattingContents[chattingContents_idx]:GetSizeY())
      end
      chatUI._list_ResizeButton[0]:SetPosX(panelSizeX - (chatUI._list_ResizeButton[0]:GetSizeX() + 5))
      chatUI._list_StaticButtonBG[0]:SetPosX(panelSizeX - (chatUI._list_StaticButtonBG[0]:GetSizeX() + 5))
      panel:SetDragArea(chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_PanelDragToggle[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY(), chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_StaticButtonBG[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY() + chatUI._list_StaticButtonBG[0]:GetSizeY())
      chatUI._list_Scroll[0]:SetPosX(panelSizeX - (chatUI._list_Scroll[0]:GetSizeX() + 5))
      chatUI._list_Scroll[0]:SetControlBottom()
    else
      panelSizeX = PaGlobal_ChatMain._DEFAULT_PANELSIZE_X
      panelSizeY = PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y
      panel:SetSize(panelSizeX, panelSizeY)
      chatUI._list_PanelBG[0]:SetSize(panelSizeX, panelSizeY)
      chatUI._list_Scroll[0]:SetSize(chatUI._list_Scroll[0]:GetSizeX(), panelSizeY - 67)
      for chattingContents_idx = 0, chatUI._MAXCOUNT_CHATTINGCONTENTS - 1 do
        chatUI._list_ChattingContents[chattingContents_idx]:SetSize(panelSizeX - 25, chatUI._list_ChattingContents[chattingContents_idx]:GetSizeY())
      end
      chatUI._list_ResizeButton[0]:SetPosX(panelSizeX - (chatUI._list_ResizeButton[0]:GetSizeX() + 5))
      chatUI._list_StaticButtonBG[0]:SetPosX(panelSizeX - (chatUI._list_StaticButtonBG[0]:GetSizeX() + 5))
      panel:SetDragArea(chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_PanelDragToggle[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY(), chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_StaticButtonBG[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY() + chatUI._list_StaticButtonBG[0]:GetSizeY())
      chatUI._list_Scroll[0]:SetPosX(panelSizeX - (chatUI._list_Scroll[0]:GetSizeX() + 5))
      chatUI._list_Scroll[0]:SetControlBottom()
    end
    if 0 > divisionPanel:getPositionX() and 0 > divisionPanel:getPositionY() then
      panel:SetPosX(0)
      panel:SetPosY(getScreenSizeY() - panel:GetSizeY() - 35)
    else
      panel:SetPosX(divisionPanel:getPositionX())
      panel:SetPosY(divisionPanel:getPositionY())
    end
    PaGlobal_ChatMain._transparency[poolIndex] = divisionPanel:getTransparency()
    panel:addInputEvent("Mouse_LPress", "HandleEventLPress_DragPanelAndSavePos(" .. tostring(poolIndex) .. ")")
    panel:addInputEvent("Mouse_LUp", "HandleClicked_Chatting_MovePosEND()")
  end
end
function PaGlobal_ChatMain:createPanel(poolIndex, stylePanel)
  UI.ASSERT_NAME(nil ~= poolIndex, "chatUIPool:createPanel poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= stylePanel, "chatUIPool:createPanel stylePanel nil", "\236\178\156\235\167\140\234\184\176")
  local panel
  if 0 == poolIndex then
    panel = UI.createPanelAndSetPanelRenderMode("Panel_Chat" .. poolIndex, UI_Group.PAGameUIGroup_Dialog, PaGlobal_ChatMain._chatRenderMode)
  else
    panel = UI.createPanelAndSetPanelRenderMode("Panel_Chat" .. poolIndex, UI_Group.PAGameUIGroup_Chatting, PaGlobal_ChatMain._chatRenderMode)
  end
  CopyBaseProperty(stylePanel, panel)
  panel:ChangeSpecialTextureInfoName("new_ui_common_forlua/Window/Chatting/Chatting_Win_transparency.dds")
  panel:setMaskingChild(true)
  panel:setGlassBackground(true)
  panel:SetSize(PaGlobal_ChatMain._DEFAULT_PANELSIZE_X, PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y)
  panel:SetPosX(0)
  panel:SetPosY(getScreenSizeY() - panel:GetSizeY() - 35)
  panel:SetColor(UI_color.C_FFFFFFFF)
  panel:SetIgnore(false)
  panel:SetDragEnable(false)
  panel:addInputEvent("Mouse_UpScroll", "Chatting_ScrollEvent( " .. poolIndex .. ", true )")
  panel:addInputEvent("Mouse_DownScroll", "Chatting_ScrollEvent( " .. poolIndex .. ", false )")
  panel:addInputEvent("Mouse_On", "HandleEventOn_ChatMainPanelTransparency( " .. poolIndex .. ", false )")
  panel:addInputEvent("Mouse_Out", "HandleEventOut_ChatMainPanelTransparency( " .. poolIndex .. "," .. 9999 .. " )")
  local show = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  panel:SetShow(show)
  return panel
end
function PaGlobal_ChatMain:createPool(poolIndex, poolStylePanel, poolParentPanel)
  UI.ASSERT_NAME(nil ~= poolIndex, "chatUIPool:createPool poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= poolStylePanel, "chatUIPool:createPool poolStylePanel nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= poolParentPanel, "chatUIPool:createPool poolParentPanel nil", "\236\178\156\235\167\140\234\184\176")
  local chatUIPool = {
    _list_PanelBG = {},
    _list_TitleTab = {},
    _list_TitleTabText = {},
    _list_TitleTabConfigButton = {},
    _list_OtherTab = {},
    _list_AddTab = {},
    _list_ResizeButton = {},
    _list_StaticButtonBG = {},
    _list_PanelDragToggle = {},
    _list_ButtonMove = {},
    _list_PanelDivision = {},
    _list_PanelDelete = {},
    _list_ChattingIcon = {},
    _list_UserTypeIcon = {},
    _list_RecommandIcon = {},
    _list_ReportButton = {},
    _list_ChattingSender = {},
    _list_ChattingContents = {},
    _list_ChattingLinkedItem = {},
    _list_ChattingLinkedGuild = {},
    _list_ChattingLinkedParty = {},
    _list_ChattingGuildMark = {},
    _list_ChattingLinkedWebSite = {},
    _list_ChattingLinkedQuest = {},
    _list_Scroll = {},
    _list_CloseButton = {},
    _list_ScrollReset = {},
    _list_MoreList = {},
    _list_Emoticon = {},
    _list_At = {},
    _list_ChatEmoticon = {},
    _list_EmoticonAni = {},
    _list_SenderMessageIndex = {},
    _list_LinkedItemMessageIndex = {},
    _list_LinkedGuildMessageIndex = {},
    _list_LinkedPartyMessageIndex = {},
    _list_LinkedWebSiteMessageIndex = {},
    _list_LinkedQuestMessageIndex = {},
    _count_PanelBG = 0,
    _MAXCOUNT_PANELBG = 5,
    _count_TitleTab = 0,
    _MAXCOUNT_TITLETAB = 5,
    _count_TitleTabText = 0,
    _MAXCOUNT_TITLETABTEXT = 5,
    _count_TitleTabConfigButton = 0,
    _MAXCOUNT_TITLETABCONFIGBUTTON = 5,
    _count_OtherTab = 0,
    _MAXCOUNT_OTHERTAB = 4,
    _count_AddTab = 0,
    _MAXCOUNT_ADDTAB = 1,
    _count_PanelDivision = 0,
    _MAXCOUNT_PANELDIVISION = 5,
    _count_PanelDelete = 0,
    _MAXCOUNT_PANELDELETE = 5,
    _count_ResizeButton = 0,
    _MAXCOUNT_RESIZEBUTTON = 5,
    _count_StaticButtonBG = 0,
    _MAXCOUNT_STATICBUTTONBG = 1,
    _count_PanelDragToggle = 0,
    _MAXCOUNT_PANELDRAGTOGGLE = 1,
    _count_ButtonMove = 0,
    _MAXCOUNT_BUTTONMOVE = 1,
    _count_ChattingIcon = 0,
    _MAXCOUNT_CHATTINGICON = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_UserTypeIcon = 0,
    _MAXCOUNT_USERTYPEICON = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_RecommandIcon = 0,
    _MAXCOUNT_RECOMMANDICON = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ReportButton = 0,
    _MAXCOUNT_REPORTBUTTON = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingSender = 0,
    _MAXCOUNT_CHATTINGSENDER = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingContents = 0,
    _MAXCOUNT_CHATTINGCONTENTS = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingLinkedItem = 0,
    _MAXCOUNT_CHATTINGLINKEDITEM = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingLinkedGuild = 0,
    _MAXCOUNT_CHATTINGLINKEDGUILD = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingLinkedParty = 0,
    _MAXCOUNT_CHATTINGLINKEDPARTY = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingGuildMark = 0,
    _MAXCOUNT_CHATTINGGUILDMARK = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingLinkedWebSite = 0,
    _MAXCOUNT_CHATTINGLINKEDWEBSITE = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_ChattingLinkedQuest = 0,
    _MAXCOUNT_CHATTINGLINKEDQUEST = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_Scroll = 0,
    _MAXCOUNT_SCROLL = 1,
    _count_CloseButton = 0,
    _MAXCOUNT_CLOSEBUTTON = 4,
    _count_ScrollReset = 0,
    _MAXCOUNT_SCROLLRESET = 4,
    _count_MoreList = 0,
    _MAXCOUNT_MORELIST = 4,
    _count_Emoticon = 0,
    _MAXCOUNT_EMOTICON = PaGlobal_ChatMain._MAX_LISTCOUNT * 4,
    _count_ChatEmoticon = 0,
    _MAXCOUNT_CHATEMOTICON = PaGlobal_ChatMain._MAX_LISTCOUNT * 15,
    _count_At = 0,
    _MAXCOUNT_AT = PaGlobal_ChatMain._MAX_LISTCOUNT,
    _count_EmoticonAni = 0,
    _MAXCOUNT_EMOTICONANI = 1
  }
  function chatUIPool:prepareControl(Panel, parentControl, createdCotrolList, controlType, controlName, createCount)
    UI.ASSERT_NAME(nil ~= Panel, "chatUIPool:prepareControl Panel nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= parentControl, "chatUIPool:prepareControl parentControl nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= createdCotrolList, "chatUIPool:prepareControl createdCotrolList nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= controlType, "chatUIPool:prepareControl controlType nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= controlName, "chatUIPool:prepareControl controlName nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= createCount, "chatUIPool:prepareControl createCount nil", "\236\178\156\235\167\140\234\184\176")
    local styleUI = UI.getChildControl(Panel, controlName)
    for index = 0, createCount do
      createdCotrolList[index] = UI.createControl(controlType, parentControl, controlName .. index)
      CopyBaseProperty(styleUI, createdCotrolList[index])
      createdCotrolList[index]:SetShow(true)
    end
  end
  function chatUIPool:initialize(stylePanel, parentControl, poolIndex)
    UI.ASSERT_NAME(nil ~= stylePanel, "chatUIPool:initialize stylePanel nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= parentControl, "chatUIPool:initialize parentControl nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= poolIndex, "chatUIPool:initialize poolIndex nil", "\236\178\156\235\167\140\234\184\176")
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_PanelBG, __ePAUIControl_Static, "Static_ChattingBG", chatUIPool._MAXCOUNT_PANELBG)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_TitleTab, __ePAUIControl_Button, "Button_TitleButton", chatUIPool._MAXCOUNT_TITLETAB)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_TitleTabText, __ePAUIControl_StaticText, "StaticText_chattingText", chatUIPool._MAXCOUNT_TITLETABTEXT)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_TitleTabConfigButton, __ePAUIControl_Button, "Button_Setting", chatUIPool._MAXCOUNT_TITLETABCONFIGBUTTON)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_OtherTab, __ePAUIControl_Button, "Button_OtherChat", chatUIPool._MAXCOUNT_OTHERTAB)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_AddTab, __ePAUIControl_Button, "Button_AddChat", chatUIPool._MAXCOUNT_ADDTAB)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_PanelDivision, __ePAUIControl_Button, "Button_PanelDivision", chatUIPool._MAXCOUNT_PANELDIVISION)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_PanelDelete, __ePAUIControl_Button, "Button_PanelCombine", chatUIPool._MAXCOUNT_PANELDELETE)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_ResizeButton, __ePAUIControl_Button, "Button_Size", chatUIPool._MAXCOUNT_RESIZEBUTTON)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_StaticButtonBG, __ePAUIControl_Static, "Static_ButtonBG", chatUIPool._MAXCOUNT_STATICBUTTONBG)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_StaticButtonBG[0], chatUIPool._list_PanelDragToggle, __ePAUIControl_CheckButton, "CheckButton_PanelDragToggle", chatUIPool._MAXCOUNT_PANELDRAGTOGGLE)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_StaticButtonBG[0], chatUIPool._list_ButtonMove, __ePAUIControl_Button, "Button_Move", chatUIPool._MAXCOUNT_BUTTONMOVE)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingIcon, __ePAUIControl_StaticText, "Static_ChatIcon", chatUIPool._MAXCOUNT_CHATTINGICON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_UserTypeIcon, __ePAUIControl_Button, "Button_UserType", chatUIPool._MAXCOUNT_USERTYPEICON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_RecommandIcon, __ePAUIControl_Button, "Button_Recommand", chatUIPool._MAXCOUNT_RECOMMANDICON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ReportButton, __ePAUIControl_Button, "Button_TargetReport", chatUIPool._MAXCOUNT_REPORTBUTTON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingSender, __ePAUIControl_StaticText, "StaticText_ChatSender", chatUIPool._MAXCOUNT_CHATTINGSENDER)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingContents, __ePAUIControl_StaticText, "StaticText_ChatContent", chatUIPool._MAXCOUNT_CHATTINGCONTENTS)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingLinkedItem, __ePAUIControl_StaticText, "StaticText_ChatLinkedItem", chatUIPool._MAXCOUNT_CHATTINGLINKEDITEM)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingLinkedGuild, __ePAUIControl_StaticText, "StaticText_ChatLinkedGuild", chatUIPool._MAXCOUNT_CHATTINGLINKEDGUILD)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingLinkedParty, __ePAUIControl_StaticText, "StaticText_ChatLinkedParty", chatUIPool._MAXCOUNT_CHATTINGLINKEDPARTY)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingGuildMark, __ePAUIControl_Static, "Static_GuildMark", chatUIPool._MAXCOUNT_CHATTINGGUILDMARK)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingLinkedWebSite, __ePAUIControl_StaticText, "StaticText_ChatLinkedWebSite", chatUIPool._MAXCOUNT_CHATTINGLINKEDWEBSITE)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChattingLinkedQuest, __ePAUIControl_StaticText, "StaticText_ChatLinkedQuest", chatUIPool._MAXCOUNT_CHATTINGLINKEDQUEST)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_Scroll, __ePAUIControl_Scroll, "Scroll_Chatting", chatUIPool._MAXCOUNT_SCROLL)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_CloseButton, __ePAUIControl_Button, "Button_Close", chatUIPool._MAXCOUNT_CLOSEBUTTON)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_ScrollReset, __ePAUIControl_Button, "Button_ScrollReset", chatUIPool._MAXCOUNT_SCROLLRESET)
    chatUIPool:prepareControl(stylePanel, parentControl, chatUIPool._list_MoreList, __ePAUIControl_Static, "Static_MoreList", chatUIPool._MAXCOUNT_MORELIST)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_Emoticon, __ePAUIControl_Static, "Static_Emoticon", chatUIPool._MAXCOUNT_EMOTICON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_ChatEmoticon, __ePAUIControl_Static, "Static_ChatEmoticon", chatUIPool._MAXCOUNT_CHATEMOTICON)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_At, __ePAUIControl_StaticText, "Static_At", chatUIPool._MAXCOUNT_AT)
    chatUIPool:prepareControl(stylePanel, chatUIPool._list_PanelBG[0], chatUIPool._list_EmoticonAni, __ePAUIControl_Static, "Static_ChatEmoticon_SequenceAni", chatUIPool._MAXCOUNT_EMOTICONANI)
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGLINKEDITEM do
      chatUIPool._list_ChattingLinkedItem[index]:addInputEvent("Mouse_On", "HandleOn_ChattingLinkedItem(" .. poolIndex .. ", " .. index .. ", false)")
      chatUIPool._list_ChattingLinkedItem[index]:addInputEvent("Mouse_Out", "HandleEventOut_ChatMainPanelTransparency(" .. poolIndex .. ", true )")
      chatUIPool._list_ChattingLinkedItem[index]:addInputEvent("Mouse_LPress", "Chatting_Transparency(" .. poolIndex .. ")")
      chatUIPool._list_ChattingLinkedItem[index]:addInputEvent("Mouse_RPress", "Chatting_Transparency(" .. poolIndex .. ")")
      chatUIPool._list_ChattingLinkedItem[index]:addInputEvent("Mouse_LUp", "HandleOn_ChattingLinkedItem(" .. poolIndex .. ", " .. index .. ", true)")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGLINKEDGUILD do
      chatUIPool._list_ChattingLinkedGuild[index]:addInputEvent("Mouse_LUp", "HandleOn_ChattingLinkedGuild(" .. poolIndex .. ", " .. index .. ", 2)")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGLINKEDPARTY do
      chatUIPool._list_ChattingLinkedParty[index]:addInputEvent("Mouse_LUp", "HandleOn_ChattingLinkedParty(" .. poolIndex .. ", " .. index .. ", 2)")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGLINKEDWEBSITE do
      chatUIPool._list_ChattingLinkedWebSite[index]:addInputEvent("Mouse_LUp", "HandleOn_ChattingLinkedWebSite(" .. poolIndex .. ", " .. index .. ", 2)")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGLINKEDQUEST do
      chatUIPool._list_ChattingLinkedQuest[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingLinkedQuest(" .. poolIndex .. ", " .. index .. ", 2)")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGSENDER do
      chatUIPool._list_ChattingSender[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingSender(" .. poolIndex .. ", " .. index .. ")")
      chatUIPool._list_ChattingSender[index]:addInputEvent("Mouse_Out", "HandleEventOut_ChatMainPanelTransparency(" .. poolIndex .. ", false )")
      chatUIPool._list_ChattingSender[index]:addInputEvent("Mouse_LPress", "Chatting_Transparency(" .. poolIndex .. ")")
      chatUIPool._list_ChattingSender[index]:addInputEvent("Mouse_RPress", "Chatting_Transparency(" .. poolIndex .. ")")
    end
    for index = 0, chatUIPool._MAXCOUNT_CHATTINGICON do
      chatUIPool._list_ChattingIcon[index]:SetIgnore(false)
    end
    for index = 0, chatUIPool._MAXCOUNT_USERTYPEICON do
      chatUIPool._list_UserTypeIcon[index]:SetIgnore(false)
    end
    for index = 0, chatUIPool._MAXCOUNT_RECOMMANDICON do
      chatUIPool._list_RecommandIcon[index]:SetIgnore(false)
    end
    for index = 0, chatUIPool._MAXCOUNT_REPORTBUTTON do
      chatUIPool._list_ReportButton[index]:SetIgnore(false)
      chatUIPool._list_ReportButton[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ChattingSender(" .. poolIndex .. ", " .. index .. ", " .. 1 .. ")")
      chatUIPool._list_ReportButton[index]:addInputEvent("Mouse_On", "HandleOn_Chatting_TargetReport(true, " .. poolIndex .. ", " .. index .. ", " .. 1 .. ")")
      chatUIPool._list_ReportButton[index]:addInputEvent("Mouse_Out", "HandleOn_Chatting_TargetReport()")
    end
    chatUIPool:allClear()
    chatUIPool:hideAll()
    chatUIPool._list_PanelDragToggle[0]:SetCheck(true)
  end
  function chatUIPool:newPanelBG()
    chatUIPool._count_PanelBG = chatUIPool._count_PanelBG + 1
    return chatUIPool._list_PanelBG[chatUIPool._count_PanelBG - 1]
  end
  function chatUIPool:newTitleTab()
    chatUIPool._count_TitleTab = chatUIPool._count_TitleTab + 1
    return chatUIPool._list_TitleTab[chatUIPool._count_TitleTab - 1]
  end
  function chatUIPool:newTitleTabText()
    chatUIPool._count_TitleTabText = chatUIPool._count_TitleTabText + 1
    return chatUIPool._list_TitleTabText[chatUIPool._count_TitleTabText - 1]
  end
  function chatUIPool:newTitleTabConfigButton()
    chatUIPool._count_TitleTabConfigButton = chatUIPool._count_TitleTabConfigButton + 1
    return chatUIPool._list_TitleTabConfigButton[chatUIPool._count_TitleTabConfigButton - 1]
  end
  function chatUIPool:newOtherTab()
    chatUIPool._count_OtherTab = chatUIPool._count_OtherTab + 1
    return chatUIPool._list_OtherTab[chatUIPool._count_OtherTab - 1]
  end
  function chatUIPool:newAddTab()
    chatUIPool._count_AddTab = chatUIPool._count_AddTab + 1
    return chatUIPool._list_AddTab[chatUIPool._count_AddTab - 1]
  end
  function chatUIPool:newPanelDivision()
    chatUIPool._count_PanelDivision = chatUIPool._count_PanelDivision + 1
    return chatUIPool._list_PanelDivision[chatUIPool._count_PanelDivision - 1]
  end
  function chatUIPool:newPanelCombine()
    chatUIPool._count_PanelDelete = chatUIPool._count_PanelDelete + 1
    return chatUIPool._list_PanelDelete[chatUIPool._count_PanelDelete - 1]
  end
  function chatUIPool:newResizeButton()
    chatUIPool._count_ResizeButton = chatUIPool._count_ResizeButton + 1
    return chatUIPool._list_ResizeButton[chatUIPool._count_ResizeButton - 1]
  end
  function chatUIPool:newPanelDragToggle()
    chatUIPool._count_PanelDragToggle = chatUIPool._count_PanelDragToggle + 1
    return chatUIPool._list_PanelDragToggle[chatUIPool._count_PanelDragToggle - 1]
  end
  function chatUIPool:newButtonMove()
    chatUIPool._count_ButtonMove = chatUIPool._count_ButtonMove + 1
    return chatUIPool._list_ButtonMove[chatUIPool._count_ButtonMove - 1]
  end
  function chatUIPool:newChattingIcon(index)
    if nil == index then
      chatUIPool._count_ChattingIcon = chatUIPool._count_ChattingIcon + 1
      return chatUIPool._list_ChattingIcon[chatUIPool._count_ChattingIcon - 1]
    else
      return chatUIPool._list_ChattingIcon[index]
    end
  end
  function chatUIPool:newUserTypeIcon(index)
    if nil == index then
      chatUIPool._count_UserTypeIcon = chatUIPool._count_UserTypeIcon + 1
      return chatUIPool._list_UserTypeIcon[chatUIPool._count_UserTypeIcon - 1]
    else
      return chatUIPool._list_UserTypeIcon[index]
    end
  end
  function chatUIPool:newRecommandIcon(index)
    if nil == index then
      chatUIPool._count_RecommandIcon = chatUIPool._count_RecommandIcon + 1
      return chatUIPool._list_RecommandIcon[chatUIPool._count_RecommandIcon - 1]
    else
      return chatUIPool._list_RecommandIcon[index]
    end
  end
  function chatUIPool:newReportButton(index)
    if nil == index then
      chatUIPool._count_ReportButton = chatUIPool._count_ReportButton + 1
      return chatUIPool._list_ReportButton[chatUIPool._count_ReportButton - 1]
    else
      return chatUIPool._list_ReportButton[index]
    end
  end
  function chatUIPool:getCurrentChattingIconIndex()
    return chatUIPool._count_ChattingIcon - 1
  end
  function chatUIPool:getCurrentUserTypeIconIndex()
    return chatUIPool._count_UserTypeIcon - 1
  end
  function chatUIPool:getCurrentRecommandIconIndex()
    return chatUIPool._count_RecommandIcon - 1
  end
  function chatUIPool:getCurrentReportButtonIndex()
    return chatUIPool._count_ReportButton - 1
  end
  function chatUIPool:getCurrentRecommandTierIconIndex()
    return chatUIPool._count_RecommandTierIcon - 1
  end
  function chatUIPool:getCurrentEmoticonIndex()
    return chatUIPool._count_ChatEmoticon - 1
  end
  function PaGlobal_getChattingIconByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "PaGlobal_getChattingIconByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool:getChattingIconByIndex(index)
  end
  function chatUIPool:getChattingIconByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "chatUIPool:getChattingIconByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool._list_ChattingIcon[index]
  end
  function chatUIPool:getUserTypeIconByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "chatUIPool:getUserTypeIconByIndex index nil", "\236\160\149\236\152\129\236\164\128")
    return chatUIPool._list_UserTypeIcon[index]
  end
  function chatUIPool:getRecommandIconByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "chatUIPool:getRecommandIconByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool._list_RecommandIcon[index]
  end
  function chatUIPool:getReportButtonByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "chatUIPool:getReportButtonByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool._list_ReportButton[index]
  end
  function chatUIPool:newChattingSender(messageIndex, index)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingSender messageIndex nil", "\236\178\156\235\167\140\234\184\176")
    if nil == index then
      chatUIPool._count_ChattingSender = chatUIPool._count_ChattingSender + 1
      chatUIPool._list_SenderMessageIndex[chatUIPool._count_ChattingSender - 1] = messageIndex
      return chatUIPool._list_ChattingSender[chatUIPool._count_ChattingSender - 1]
    else
      return chatUIPool._list_ChattingSender[index]
    end
  end
  function chatUIPool:newChattingContents(index)
    if nil == index then
      chatUIPool._count_ChattingContents = chatUIPool._count_ChattingContents + 1
      return chatUIPool._list_ChattingContents[chatUIPool._count_ChattingContents - 1]
    else
      return chatUIPool._list_ChattingContents[index]
    end
  end
  function PaGlobal_getChattingContentsByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "PaGlobal_getChattingContentsByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool._list_ChattingContents[index]
  end
  function chatUIPool:newChattingLinkedItem(messageIndex, index)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingLinkedItem messageIndex nil", "\236\178\156\235\167\140\234\184\176")
    if nil == index then
      chatUIPool._count_ChattingLinkedItem = chatUIPool._count_ChattingLinkedItem + 1
      chatUIPool._list_LinkedItemMessageIndex[chatUIPool._count_ChattingLinkedItem - 1] = messageIndex
      return chatUIPool._list_ChattingLinkedItem[chatUIPool._count_ChattingLinkedItem - 1]
    else
      return chatUIPool._list_ChattingLinkedItem[index]
    end
  end
  function chatUIPool:newChattingLinkedGuild(messageIndex)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingLinkedGuild messageIndex nil", "\236\178\156\235\167\140\234\184\176")
    chatUIPool._count_ChattingLinkedGuild = chatUIPool._count_ChattingLinkedGuild + 1
    chatUIPool._list_LinkedGuildMessageIndex[chatUIPool._count_ChattingLinkedGuild - 1] = messageIndex
    return chatUIPool._list_ChattingLinkedGuild[chatUIPool._count_ChattingLinkedGuild - 1]
  end
  function chatUIPool:newChattingLinkedParty(messageIndex)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingLinkedParty messageIndex nil", "\234\176\156\235\176\156\236\158\144")
    chatUIPool._count_ChattingLinkedParty = chatUIPool._count_ChattingLinkedParty + 1
    chatUIPool._list_LinkedPartyMessageIndex[chatUIPool._count_ChattingLinkedParty - 1] = messageIndex
    return chatUIPool._list_ChattingLinkedParty[chatUIPool._count_ChattingLinkedParty - 1]
  end
  function chatUIPool:newChattingGuildMark(index)
    if nil == index then
      chatUIPool._count_ChattingGuildMark = chatUIPool._count_ChattingGuildMark + 1
      return chatUIPool._list_ChattingGuildMark[chatUIPool._count_ChattingGuildMark - 1]
    else
      return chatUIPool._list_ChattingGuildMark[index]
    end
  end
  function chatUIPool:getCurrentChattingGuildMarkIndex()
    return chatUIPool._count_ChattingGuildMark - 1
  end
  function PaGlobal_getChattingGuildMarkByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "PaGlobal_getChattingGuildMarkByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool:getChattingGuildMarkByIndex(index)
  end
  function chatUIPool:getChattingGuildMarkByIndex(index)
    UI.ASSERT_NAME(nil ~= index, "chatUIPool:getChattingGuildMarkByIndex index nil", "\236\178\156\235\167\140\234\184\176")
    return chatUIPool._list_ChattingGuildMark[index]
  end
  function chatUIPool:newChattingEmoticon()
    chatUIPool._count_Emoticon = chatUIPool._count_Emoticon + 1
    if chatUIPool._MAXCOUNT_EMOTICON < chatUIPool._count_Emoticon then
      chatUIPool._count_Emoticon = chatUIPool._MAXCOUNT_EMOTICON
    end
    return chatUIPool._list_Emoticon[chatUIPool._count_Emoticon - 1]
  end
  function chatUIPool:newChattingNewEmoticon()
    chatUIPool._count_ChatEmoticon = chatUIPool._count_ChatEmoticon + 1
    if chatUIPool._MAXCOUNT_CHATEMOTICON < chatUIPool._count_ChatEmoticon then
      chatUIPool._count_ChatEmoticon = chatUIPool._MAXCOUNT_CHATEMOTICON
    end
    return chatUIPool._list_ChatEmoticon[chatUIPool._count_ChatEmoticon - 1]
  end
  function chatUIPool:newChattingLinkedWebSite(messageIndex)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingLinkedWebSite messageIndex nil", "\236\178\156\235\167\140\234\184\176")
    chatUIPool._count_ChattingLinkedWebSite = chatUIPool._count_ChattingLinkedWebSite + 1
    chatUIPool._list_LinkedWebSiteMessageIndex[chatUIPool._count_ChattingLinkedWebSite - 1] = messageIndex
    return chatUIPool._list_ChattingLinkedWebSite[chatUIPool._count_ChattingLinkedWebSite - 1]
  end
  function chatUIPool:newChattingLinkedQuest(messageIndex)
    UI.ASSERT_NAME(nil ~= messageIndex, "chatUIPool:newChattingLinkedQuest messageIndex nil", "\235\176\149\236\157\184\234\183\160")
    chatUIPool._count_ChattingLinkedQuest = chatUIPool._count_ChattingLinkedQuest + 1
    chatUIPool._list_LinkedQuestMessageIndex[chatUIPool._count_ChattingLinkedQuest - 1] = messageIndex
    return chatUIPool._list_ChattingLinkedQuest[chatUIPool._count_ChattingLinkedQuest - 1]
  end
  function chatUIPool:newChattingAt(index)
    if nil == index then
      chatUIPool._count_At = chatUIPool._count_At + 1
      return chatUIPool._list_At[chatUIPool._count_At - 1]
    else
      return chatUIPool._list_At[index]
    end
  end
  function chatUIPool:newScroll()
    chatUIPool._count_Scroll = chatUIPool._count_Scroll + 1
    return chatUIPool._list_Scroll[chatUIPool._count_Scroll - 1]
  end
  function chatUIPool:newCloseButton()
    chatUIPool._count_CloseButton = chatUIPool._count_CloseButton + 1
    return chatUIPool._list_CloseButton[chatUIPool._count_CloseButton - 1]
  end
  function chatUIPool:newScrollReset()
    chatUIPool._count_ScrollReset = chatUIPool._count_ScrollReset + 1
    return chatUIPool._list_ScrollReset[chatUIPool._count_ScrollReset - 1]
  end
  function chatUIPool:newMorelist()
    chatUIPool._count_MoreList = chatUIPool._count_MoreList + 1
    return chatUIPool._list_MoreList[chatUIPool._count_MoreList - 1]
  end
  function chatUIPool:newStaticButtonBG()
    chatUIPool._count_StaticButtonBG = chatUIPool._count_StaticButtonBG + 1
    return chatUIPool._list_StaticButtonBG[chatUIPool._count_StaticButtonBG - 1]
  end
  function chatUIPool:clearChattingIcon()
    chatUIPool._count_ChattingIcon = 0
  end
  function chatUIPool:clearUserTypeIcon()
    chatUIPool._count_UserTypeIcon = 0
  end
  function chatUIPool:clearRecommandIcon()
    chatUIPool._count_RecommandIcon = 0
  end
  function chatUIPool:clearReportButton()
    chatUIPool._count_ReportButton = 0
  end
  function chatUIPool:clearRecommandTierIcon()
    chatUIPool._count_RecommandTierIcon = 0
  end
  function chatUIPool:clearChattingSender()
    chatUIPool._count_ChattingSender = 0
  end
  function chatUIPool:clearChattingContents()
    chatUIPool._count_ChattingContents = 0
  end
  function chatUIPool:clearChattingLinkedItem()
    chatUIPool._count_ChattingLinkedItem = 0
  end
  function chatUIPool:clearChattingLinkedGuild()
    chatUIPool._count_ChattingLinkedGuild = 0
  end
  function chatUIPool:clearChattingLinkedParty()
    chatUIPool._count_ChattingLinkedParty = 0
  end
  function chatUIPool:clearChattingGuildMark()
    chatUIPool._count_ChattingGuildMark = 0
  end
  function chatUIPool:clearChattingLinkedwebsite()
    chatUIPool._count_ChattingLinkedWebSite = 0
  end
  function chatUIPool:clearChattingLinkedQuest()
    chatUIPool._count_ChattingLinkedQuest = 0
  end
  function chatUIPool:clearEmoticon()
    chatUIPool._count_Emoticon = 0
  end
  function chatUIPool:clearAt()
    chatUIPool._count_At = 0
  end
  function chatUIPool:allClear()
    chatUIPool:panelClear()
    chatUIPool:tabClear()
    chatUIPool:chatClear()
  end
  function chatUIPool:panelClear()
    chatUIPool:hidePanel()
    chatUIPool._count_PanelBG = 0
    chatUIPool._count_ResizeButton = 0
    chatUIPool._count_Scroll = 0
    chatUIPool._count_StaticButtonBG = 0
    chatUIPool._count_PanelDragToggle = 0
    chatUIPool._count_ButtonMove = 0
  end
  function chatUIPool:tabClear()
    chatUIPool:hideTab()
    chatUIPool._count_TitleTab = 0
    chatUIPool._count_TitleTabConfigButton = 0
    chatUIPool._count_PanelDivision = 0
    chatUIPool._count_CloseButton = 0
    chatUIPool._count_ScrollReset = 0
    chatUIPool._count_MoreList = 0
    chatUIPool._count_OtherTab = 0
    chatUIPool._count_PanelDelete = 0
    chatUIPool._count_AddTab = 0
  end
  function chatUIPool:chatClear()
    chatUIPool:hideChat()
    chatUIPool._count_TitleTabText = 0
    chatUIPool._count_ChattingIcon = 0
    chatUIPool._count_UserTypeIcon = 0
    chatUIPool._count_RecommandIcon = 0
    chatUIPool._count_ReportButton = 0
    chatUIPool._count_RecommandTierIcon = 0
    chatUIPool._count_ChattingSender = 0
    chatUIPool._count_ChattingContents = 0
    chatUIPool._count_ChattingLinkedItem = 0
    chatUIPool._count_ChattingLinkedGuild = 0
    chatUIPool._count_ChattingLinkedParty = 0
    chatUIPool._count_ChattingGuildMark = 0
    chatUIPool._count_ChattingLinkedWebSite = 0
    chatUIPool._count_ChattingLinkedQuest = 0
    chatUIPool._count_Emoticon = 0
    chatUIPool._count_At = 0
    chatUIPool._count_ChatEmoticon = 0
    chatUIPool._count_ChatEmoticonAni = 0
    chatUIPool._list_SenderMessageIndex = {}
    chatUIPool._list_LinkedItemMessageIndex = {}
    chatUIPool._list_LinkedGuildMessageIndex = {}
    chatUIPool._list_LinkedPartyMessageIndex = {}
    chatUIPool._list_LinkedWebSiteMessageIndex = {}
    chatUIPool._list_LinkedQuestMessageIndex = {}
    chatUIPool._list_LinkedAtIndex = {}
  end
  function chatUIPool:drawclear()
    chatUIPool.clearChattingIcon()
    chatUIPool.clearUserTypeIcon()
    chatUIPool.clearRecommandIcon()
    chatUIPool.clearRecommandTierIcon()
    chatUIPool.clearChattingContents()
    chatUIPool.clearChattingSender()
    chatUIPool.clearChattingLinkedItem()
    chatUIPool.clearChattingLinkedGuild()
    chatUIPool.clearChattingLinkedParty()
    chatUIPool.clearChattingGuildMark()
    chatUIPool.clearChattingLinkedwebsite()
    chatUIPool.clearChattingLinkedQuest()
    chatUIPool.clearEmoticon()
    chatUIPool.clearAt()
  end
  function chatUIPool:hidePanel()
    for index = 0, chatUIPool._count_PanelBG do
      if chatUIPool._list_PanelBG[index] ~= nil then
        chatUIPool._list_PanelBG[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ResizeButton do
      if chatUIPool._list_ResizeButton[index] ~= nil then
        chatUIPool._list_ResizeButton[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_PanelDragToggle do
      if chatUIPool._list_PanelDragToggle[index] ~= nil then
        chatUIPool._list_PanelDragToggle[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_Scroll do
      if chatUIPool._list_Scroll[index] ~= nil then
        chatUIPool._list_Scroll[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ButtonMove do
      if chatUIPool._list_ButtonMove[index] ~= nil then
        chatUIPool._list_ButtonMove[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_StaticButtonBG do
      if chatUIPool._list_StaticButtonBG[index] ~= nil then
        chatUIPool._list_StaticButtonBG[index]:SetShow(false)
      end
    end
  end
  function chatUIPool:hideTab()
    for index = 0, chatUIPool._count_TitleTab do
      chatUIPool._list_TitleTab[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_TitleTabConfigButton do
      chatUIPool._list_TitleTabConfigButton[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_PanelDivision do
      chatUIPool._list_PanelDivision[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_CloseButton do
      chatUIPool._list_CloseButton[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_ScrollReset do
      chatUIPool._list_ScrollReset[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_MoreList do
      chatUIPool._list_MoreList[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_OtherTab do
      chatUIPool._list_OtherTab[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_PanelDelete do
      chatUIPool._list_PanelDelete[index]:SetShow(false)
    end
    for index = 0, chatUIPool._count_AddTab do
      chatUIPool._list_AddTab[index]:SetShow(false)
    end
  end
  function chatUIPool:hideChat()
    for index = 0, chatUIPool._count_TitleTabText do
      if chatUIPool._list_TitleTabText[index] ~= nil then
        chatUIPool._list_TitleTabText[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingIcon do
      if chatUIPool._list_ChattingIcon[index] ~= nil then
        chatUIPool._list_ChattingIcon[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_UserTypeIcon do
      if chatUIPool._list_UserTypeIcon[index] ~= nil then
        chatUIPool._list_UserTypeIcon[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_RecommandIcon do
      if chatUIPool._list_RecommandIcon[index] ~= nil then
        chatUIPool._list_RecommandIcon[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ReportButton do
      if chatUIPool._list_ReportButton[index] ~= nil then
        chatUIPool._list_ReportButton[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingSender do
      if chatUIPool._list_ChattingSender[index] ~= nil then
        chatUIPool._list_ChattingSender[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingContents do
      if chatUIPool._list_ChattingContents[index] ~= nil then
        chatUIPool._list_ChattingContents[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingLinkedItem do
      if chatUIPool._list_ChattingLinkedItem[index] ~= nil then
        chatUIPool._list_ChattingLinkedItem[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingLinkedGuild do
      if chatUIPool._list_ChattingLinkedGuild[index] ~= nil then
        chatUIPool._list_ChattingLinkedGuild[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingLinkedParty do
      if chatUIPool._list_ChattingLinkedParty[index] ~= nil then
        chatUIPool._list_ChattingLinkedParty[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingGuildMark do
      if chatUIPool._list_ChattingGuildMark[index] ~= nil then
        chatUIPool._list_ChattingGuildMark[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingLinkedWebSite do
      if chatUIPool._list_ChattingLinkedWebSite[index] ~= nil then
        chatUIPool._list_ChattingLinkedWebSite[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChattingLinkedQuest do
      if chatUIPool._list_ChattingLinkedQuest[index] ~= nil then
        chatUIPool._list_ChattingLinkedQuest[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_Emoticon do
      if chatUIPool._list_Emoticon[index] ~= nil then
        chatUIPool._list_Emoticon[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_At do
      if chatUIPool._list_At[index] ~= nil then
        chatUIPool._list_At[index]:SetShow(false)
      end
    end
    for index = 0, chatUIPool._count_ChatEmoticon do
      if chatUIPool._list_ChatEmoticon[index] ~= nil then
        chatUIPool._list_ChatEmoticon[index]:SetShow(false)
      end
    end
  end
  function chatUIPool:hideAll()
    for index = chatUIPool._count_PanelBG, chatUIPool._MAXCOUNT_PANELBG do
      if chatUIPool._list_PanelBG[index] ~= nil then
        chatUIPool._list_PanelBG[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_TitleTab, chatUIPool._MAXCOUNT_TITLETAB do
      if chatUIPool._list_TitleTab[index] ~= nil then
        chatUIPool._list_TitleTab[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_TitleTabText, chatUIPool._MAXCOUNT_TITLETABTEXT do
      if chatUIPool._list_TitleTabText[index] ~= nil then
        chatUIPool._list_TitleTabText[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_TitleTabConfigButton, chatUIPool._MAXCOUNT_TITLETABCONFIGBUTTON do
      if chatUIPool._list_TitleTabConfigButton[index] ~= nil then
        chatUIPool._list_TitleTabConfigButton[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_OtherTab, chatUIPool._MAXCOUNT_OTHERTAB do
      if chatUIPool._list_OtherTab[index] ~= nil then
        chatUIPool._list_OtherTab[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_AddTab, chatUIPool._MAXCOUNT_ADDTAB do
      if chatUIPool._list_AddTab[index] ~= nil then
        chatUIPool._list_AddTab[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_PanelDivision, chatUIPool._MAXCOUNT_PANELDIVISION do
      if chatUIPool._list_PanelDivision[index] ~= nil then
        chatUIPool._list_PanelDivision[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_PanelDelete, chatUIPool._MAXCOUNT_PANELDELETE do
      if chatUIPool._list_PanelDelete[index] ~= nil then
        chatUIPool._list_PanelDelete[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ResizeButton + 1, chatUIPool._MAXCOUNT_RESIZEBUTTON do
      if chatUIPool._list_ResizeButton[index] ~= nil then
        chatUIPool._list_ResizeButton[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_PanelDragToggle + 1, chatUIPool._MAXCOUNT_PANELDRAGTOGGLE do
      if chatUIPool._list_PanelDragToggle[index] ~= nil then
        chatUIPool._list_PanelDragToggle[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ButtonMove + 1, chatUIPool._MAXCOUNT_BUTTONMOVE do
      if chatUIPool._list_ButtonMove[index] ~= nil then
        chatUIPool._list_ButtonMove[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_StaticButtonBG + 1, chatUIPool._MAXCOUNT_STATICBUTTONBG do
      if chatUIPool._list_StaticButtonBG[index] ~= nil then
        chatUIPool._list_StaticButtonBG[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingIcon, chatUIPool._MAXCOUNT_CHATTINGICON do
      if chatUIPool._list_ChattingIcon[index] ~= nil then
        chatUIPool._list_ChattingIcon[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_UserTypeIcon, chatUIPool._MAXCOUNT_USERTYPEICON do
      if chatUIPool._list_UserTypeIcon[index] ~= nil then
        chatUIPool._list_UserTypeIcon[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_RecommandIcon, chatUIPool._MAXCOUNT_RECOMMANDICON do
      if chatUIPool._list_RecommandIcon[index] ~= nil then
        chatUIPool._list_RecommandIcon[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ReportButton, chatUIPool._MAXCOUNT_REPORTBUTTON do
      if chatUIPool._list_ReportButton[index] ~= nil then
        chatUIPool._list_ReportButton[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingSender, chatUIPool._MAXCOUNT_CHATTINGSENDER do
      if chatUIPool._list_ChattingSender[index] ~= nil then
        chatUIPool._list_ChattingSender[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingContents, chatUIPool._MAXCOUNT_CHATTINGCONTENTS do
      if chatUIPool._list_ChattingContents[index] ~= nil then
        chatUIPool._list_ChattingContents[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingLinkedItem, chatUIPool._MAXCOUNT_CHATTINGLINKEDITEM do
      if chatUIPool._list_ChattingLinkedItem[index] ~= nil then
        chatUIPool._list_ChattingLinkedItem[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingLinkedGuild, chatUIPool._MAXCOUNT_CHATTINGLINKEDGUILD do
      if chatUIPool._list_ChattingLinkedGuild[index] ~= nil then
        chatUIPool._list_ChattingLinkedGuild[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingLinkedParty, chatUIPool._MAXCOUNT_CHATTINGLINKEDPARTY do
      if chatUIPool._list_ChattingLinkedParty[index] ~= nil then
        chatUIPool._list_ChattingLinkedParty[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingGuildMark, chatUIPool._MAXCOUNT_CHATTINGGUILDMARK do
      if chatUIPool._list_ChattingGuildMark[index] ~= nil then
        chatUIPool._list_ChattingGuildMark[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingLinkedWebSite, chatUIPool._MAXCOUNT_CHATTINGLINKEDWEBSITE do
      if chatUIPool._list_ChattingLinkedWebSite[index] ~= nil then
        chatUIPool._list_ChattingLinkedWebSite[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChattingLinkedQuest, chatUIPool._MAXCOUNT_CHATTINGLINKEDQUEST do
      if chatUIPool._list_ChattingLinkedQuest[index] ~= nil then
        chatUIPool._list_ChattingLinkedQuest[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_Scroll, chatUIPool._MAXCOUNT_SCROLL do
      if chatUIPool._list_Scroll[index] ~= nil then
        chatUIPool._list_Scroll[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_CloseButton, chatUIPool._MAXCOUNT_CLOSEBUTTON do
      if chatUIPool._list_CloseButton[index] ~= nil then
        chatUIPool._list_CloseButton[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ScrollReset, chatUIPool._MAXCOUNT_SCROLLRESET do
      if chatUIPool._list_ScrollReset[index] ~= nil then
        chatUIPool._list_ScrollReset[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_MoreList, chatUIPool._MAXCOUNT_MORELIST do
      if chatUIPool._list_MoreList[index] ~= nil then
        chatUIPool._list_MoreList[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_Emoticon, chatUIPool._MAXCOUNT_EMOTICON do
      if chatUIPool._list_Emoticon[index] ~= nil then
        chatUIPool._list_Emoticon[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_At, chatUIPool._MAXCOUNT_AT do
      if chatUIPool._list_At[index] ~= nil then
        chatUIPool._list_At[index]:SetShow(false)
      end
    end
    for index = chatUIPool._count_ChatEmoticon, chatUIPool._MAXCOUNT_CHATEMOTICON do
      if chatUIPool._list_ChatEmoticon[index] ~= nil then
        chatUIPool._list_ChatEmoticon[index]:SetShow(false)
      end
    end
  end
  chatUIPool:initialize(poolStylePanel, poolParentPanel, poolIndex)
  return chatUIPool
end
function Chatting_ScrollEvent(poolIndex, updown)
  UI.ASSERT_NAME(nil ~= poolIndex, "Chatting_ScrollEvent poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= updown, "Chatting_ScrollEvent updown nil", "\236\178\156\235\167\140\234\184\176")
  if PaGlobal_ChatMain._issmoothWheelscroll and updown == PaGlobal_ChatMain._isUpDown then
    PaGlobal_ChatMain:addScrollCount()
    return
  end
  if true == ToClient_isContentsOpenNewChatMain() then
    PaGlobal_ChatMain._issmoothWheelscroll = true
    PaGlobal_ChatMain._isUpDown = updown
    PaGlobal_ChatMain._scrollIndex = poolIndex
  else
    local chatPanel = ToClient_getChattingPanel(poolIndex)
    local isCombinedMainPanel = chatPanel:isCombinedToMainPanel()
    if isCombinedMainPanel then
      local count = ToClient_getChattingPanelCount()
      for panelIndex = 0, count - 1 do
        local isActivePanel = panelIndex == PaGlobal_ChatMain._mainPanelSelectPanelIndex
        if isActivePanel then
          PaGlobal_ChatMain._issmoothWheelscroll = true
          PaGlobal_ChatMain._isUpDown = updown
          PaGlobal_ChatMain._scrollIndex = panelIndex
          break
        end
      end
    else
      PaGlobal_ChatMain._issmoothWheelscroll = true
      PaGlobal_ChatMain._isUpDown = updown
      PaGlobal_ChatMain._scrollIndex = poolIndex
    end
  end
  PaGlobal_ChatMain:initScrollCount()
  HandleEventOnOut_Chatting_UpdateTab(poolIndex)
end
function HandleEventLUp_ChattingSender(poolIndex, senderStaticIndex, isReport)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleEventLUp_ChattingSender poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= senderStaticIndex, "HandleEventLUp_ChattingSender senderStaticIndex nil", "\236\178\156\235\167\140\234\184\176")
  if ToClient_isPlayerControlable() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDuringSequence"))
    return
  end
  FromClient_ChatUpdate()
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local posX = getMousePosX()
  local posY = getMousePosY()
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_SenderMessageIndex[senderStaticIndex]
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  local isMe = chattingMessage.isMe
  local senderUserNo = chattingMessage:getUserNo()
  local chatRoomNo = chattingMessage:getChatRoomNo()
  local isBlockedUser = ToClient_isChatMsgFromBlockedUser(chattingMessage)
  local isPearlAppUser = chattingMessage:isPearlAppUser()
  if true == isMe then
    return
  end
  if false == isBlockedUser then
    if nil ~= chattingMessage then
      local clickedName = chattingMessage:getSender(0)
      local clickedUserNickName = chattingMessage:getSender(1)
      local clickedMsg = chattingMessage:getContent()
      chatType = chattingMessage.chatType
      isSameChannel = chattingMessage.isSameChannel
      local chatSendTime = chattingMessage:getTime()
      local chatSendServerTime = chattingMessage:getChatSendServerTime()
      local currentPoolIndex = paramIndex
      local clickedMessageIndex = messageIndex
      local clickedUserId = chattingMessage:getSenderUserId()
      if nil ~= clickedName and nil ~= clickedUserNickName then
        setClipBoardText(clickedName)
        if Panel_Chat_SubMenu:IsShow() then
          PaGlobal_ChatSubMenu:SetShow(false)
        end
        if nil == clickedMessageIndex then
          return
        end
        if isReport == 1 then
          local reportCoolTime = Int64toInt32(getTemporaryInformationWrapper():getReportChatCoolTime())
          if reportCoolTime > 0 then
            FromClient_Chat_Report_Failed("LUA_REPORTCHAT_COOLTIME_REPORT", reportCoolTime)
          elseif clickedMsg == nil or clickedMsg == "" then
            FromClient_Chat_Report_Failed("LUA_CHATREPORT_NO_EMOTICON_REPORT_MSG")
          else
            PaGlobal_Window_Chat_Report_All_Open(PaGlobal_Window_Chat_Report_All._eOpenType.Report, clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
          end
          return
        end
        PaGlobal_ChatSubMenuSetClickedInfo(currentPoolIndex, clickedMessageIndex, clickedName, clickedUserNickName, clickedMsg, senderUserNo, chatRoomNo, chatType, chatSendTime, chatSendServerTime, clickedUserId)
        local isInviteParty = PaGlobal_ChatMain:isInviteParty(chatType, isSameChannel)
        local isInviteGuild = PaGlobal_ChatMain:isInviteGuild(chatType, isSameChannel)
        local isInviteCompetition = PaGlobal_ChatMain:isInviteCompetition(isSameChannel)
        local isRecommand = PaGlobal_ChatMain:isRecommand(chatType, chatRoomNo)
        PaGlobal_ChatSubMenu:SetShow(true, isInviteParty, isInviteGuild, isInviteCompetition, chattingMessage.isGameManager, isRecommand, clickedName, clickedUserNickName, isPearlAppUser)
        PaGlobal_ChatSubMenu:SetPos(posX, posY)
      end
    else
      PaGlobal_ChatSubMenuSetClickedInfoInit()
    end
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_ChatMain:isInviteParty(chatType, isSameChannel)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isInviteParty chatType nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSameChannel, "PaGlobal_ChatMain:isInviteParty isSameChannel nil", "\236\178\156\235\167\140\234\184\176")
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  local isInvite = selfPlayer:isPartyLeader(selfActorKeyRaw) or false == selfPlayer:isPartyMemberActorKey(selfActorKeyRaw)
  if _ContentsGroup_PartyMatching_Limit_OtherServerInvite == true then
    return chatType ~= UI_CT.Party and isInvite
  else
    return isSameChannel and UI_CT.Party ~= chatType and isInvite
  end
end
function PaGlobal_ChatMain:isInviteGuild(chatType, isSameChannel)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isInviteGuild chatType nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSameChannel, "PaGlobal_ChatMain:isInviteGuild isSameChannel nil", "\236\178\156\235\167\140\234\184\176")
  local isRightInviteGuild = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightInviteGuild = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Join)
  else
    isRightInviteGuild = PaGlobalFunc_ChatMain_RightCheck(__eGuildRightType_Join)
  end
  return UI_CT.Guild ~= chatType and isRightInviteGuild
end
function PaGlobal_ChatMain:isInviteCompetition(isSameChannel)
  UI.ASSERT_NAME(nil ~= isSameChannel, "PaGlobal_ChatMain:isInviteCompetition isSameChannel nil", "\236\178\156\235\167\140\234\184\176")
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  return isSameChannel and ToClient_IsCompetitionHost()
end
function PaGlobal_ChatMain:isUserType(chatType, chatRoomNo)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isUserType chatType nil", "\236\160\149\236\152\129\236\164\128")
  UI.ASSERT_NAME(nil ~= chatRoomNo, "PaGlobal_ChatMain:isUserType chatRoomNo nil", "\236\160\149\236\152\129\236\164\128")
  if false == _ContentsGroup_ChatNewbieIcon then
    return false
  end
  if UI_CT.Channel == chatType then
    return true
  end
  return false
end
function PaGlobal_ChatMain:isEdanaType(chatType)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isEdanaType chatType nil", "\235\176\149\236\157\184\234\183\160")
  if chatType == UI_CT.World or chatType == UI_CT.Public or chatType == UI_CT.WorldWithItem then
    return true
  end
  return false
end
function PaGlobal_ChatMain:isRecommand(chatType, chatRoomNo)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isRecommand chatType nil", "\235\176\149\236\132\177\236\157\128")
  UI.ASSERT_NAME(nil ~= chatRoomNo, "PaGlobal_ChatMain:isRecommand chatRoomNo nil", "\234\185\128\236\167\128\237\152\129")
  if false == _ContentsGroup_Chat_Thumb then
    return false
  end
  if true == _ContentsGroup_ChannelChat and UI_CT.Channel == chatType then
    return true
  end
  return false
end
function PaGlobal_ChatMain:isReportButton(chatType)
  UI.ASSERT_NAME(nil ~= chatType, "PaGlobal_ChatMain:isReportButton chatType nil", "\235\176\149\236\132\177\236\157\128")
  if UI_CT.Private == chatType then
    return true
  end
  return false
end
function HandleOn_ChattingLinkedWebSite(poolIndex, LinkedWebsiteIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingLinkedWebSite poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= LinkedWebsiteIndex, "HandleOn_ChattingLinkedWebSite LinkedWebsiteIndex nil", "\236\178\156\235\167\140\234\184\176")
  FromClient_ChatUpdate()
  PaGlobal_ChatMain._linkedItemTooltipIsClicked = isClicked
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_LinkedWebSiteMessageIndex[LinkedWebsiteIndex]
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  if chattingMessage:isLinkedExpirienceWiki() then
    InputMLUp_ExpirienceWiki_All_Close()
    PaGlobal_ExpirienceWiki_All_SetDirectLink(chattingMessage:getLinkedWebsite())
    PaGlobal_ExpirienceWiki_All_Open()
  elseif chattingMessage:isLinkedWebsite() then
    ToClient_OpenChargeWebPage(chattingMessage:getLinkedWebsite(), false)
  end
end
function HandleEventLUp_ChattingLinkedQuest(poolIndex, LinkedQuestIndex)
  FromClient_ChatUpdate()
  PaGlobal_ChatMain._linkedItemTooltipIsClicked = isClicked
  local paramIndex = poolIndex
  if poolIndex == 0 then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_LinkedQuestMessageIndex[LinkedQuestIndex]
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  if chattingMessage:isLinkedQuest() == false then
    return
  end
  local chattingLinkedQuest = chattingMessage:getLinkedQuestInfo()
  if chattingLinkedQuest == nil then
    return
  end
  local questNoRaw = chattingLinkedQuest:getQuestKey()
  if questNoRaw == nil then
    return
  end
  local progressQuestWarpper = ToClient_getProgressingQuestAtKey(questNoRaw)
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if questWrapper == nil then
    return
  end
  local questGroupNo = questWrapper:getQuestGroupNo()
  local questNo = questWrapper:getQuestGroupQuestNo()
  local questCondition
  if progressQuestWarpper ~= nil and true == progressQuestWarpper:isSatisfied() then
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
  else
    questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupNo, questNo, questCondition, "nil", nil, false, false, true, isCleared, nil, index, false)
end
function HandleOn_ChattingLinkedGuild(poolIndex, LinkedGuildIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingLinkedGuild poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= LinkedGuildIndex, "HandleOn_ChattingLinkedGuild LinkedGuildIndex nil", "\236\178\156\235\167\140\234\184\176")
  FromClient_ChatUpdate()
  PaGlobal_ChatMain._linkedItemTooltipIsClicked = isClicked
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_LinkedGuildMessageIndex[LinkedGuildIndex]
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  local chat = PaGlobal_getChattingContentsByIndex(messageIndex)
  local nowY = getMousePosY()
  local panel = PaGlobal_ChatMain._listPanel[poolIndex]
  local panelPosY = panel:GetPosY()
  if nowY < panelPosY then
    return
  end
  if chattingMessage:isLinkedGuild() then
    local linkedGuildInfo = chattingMessage:getLinkedGuildInfo()
    local guildNo = linkedGuildInfo:getGuildNo()
    FGlobal_GuildWebInfoForGuildRank_Open(tostring(guildNo))
  end
end
function HandleOn_ChattingLinkedParty(poolIndex, LinkedPartyIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingLinkedParty poolIndex nil", "\234\176\156\235\176\156\236\158\144")
  UI.ASSERT_NAME(nil ~= LinkedPartyIndex, "HandleOn_ChattingLinkedParty LinkedPartyIndex nil", "\234\176\156\235\176\156\236\158\144")
  FromClient_ChatUpdate()
  PaGlobal_ChatMain._linkedItemTooltipIsClicked = isClicked
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_LinkedPartyMessageIndex[LinkedPartyIndex]
  if nil == messageIndex then
    return
  end
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  if true == chattingMessage:isLinkedPartyRecruit() then
    local linkedPartyInfo = chattingMessage:getLinkedPartyRecruitInfo()
    if nil == linkedPartyInfo then
      return
    end
    local partyRecruitKey = linkedPartyInfo:getRecruitKey()
    local isGuildParty = linkedPartyInfo:getIsGuildParty()
    if false == isGuildParty then
      if nil ~= PaGlobalFunc_PartyList_All_Open then
        PaGlobalFunc_PartyList_All_SetLinkedParty(partyRecruitKey)
        PaGlobalFunc_PartyList_All_Open()
      end
    elseif nil ~= PaGlobalFunc_GuildPartyList_All_Open then
      PaGlobalFunc_GuildPartyList_All_SetLinkedParty(partyRecruitKey)
      PaGlobalFunc_GuildPartyList_All_Open()
    end
  end
end
function HandleOn_ChattingLinkedItem(poolIndex, LinkedItemStaticIndex, isClicked)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingLinkedItem poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= LinkedItemStaticIndex, "HandleOn_ChattingLinkedItem LinkedItemStaticIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isClicked, "HandleOn_ChattingLinkedItem isClicked nil", "\236\178\156\235\167\140\234\184\176")
  FromClient_ChatUpdate()
  PaGlobal_ChatMain._linkedItemTooltipIsClicked = isClicked
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local panelCurrentUI = PaGlobal_ChatMain:getPanel(poolIndex)
  local messageIndex = poolCurrentUI._list_LinkedItemMessageIndex[LinkedItemStaticIndex]
  if nil == messageIndex then
    return
  end
  local chattingMessage = chatPanel:getChattingMessageByIndex(messageIndex)
  if nil == chattingMessage then
    return
  end
  if chattingMessage:isLinkedItem() then
    local chattingLinkedItem = chattingMessage:getLinkedItemInfo()
    local itemSSW = chattingLinkedItem:getLinkedItemStaticStatus()
    if nil ~= itemSSW then
      Panel_Tooltip_Item_Show_ForChattingLinkedItem(itemSSW, panelCurrentUI, true, false, chattingLinkedItem, isClicked)
    end
  end
end
function PaGlobal_ChatMain:getPool(poolIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "PaGlobal_ChatMain:getPool poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  return PaGlobal_ChatMain._listChatUIPool[poolIndex]
end
function PaGlobal_ChatMain:getPanel(poolIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "PaGlobal_ChatMain:getPanel poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  return PaGlobal_ChatMain._listPanel[poolIndex]
end
function PaGlobal_ChatMain:getPopupNameMenu(poolIndex)
  UI.ASSERT_NAME(nil ~= poolIndex, "PaGlobal_ChatMain:getPopupNameMenu poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  return PaGlobal_ChatMain._listPopupNameMenu[poolIndex]
end
function PaGlobal_ChatMain:getMainTab(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getMainTab poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getMainTab panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getMainTab drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getMainTab isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getMainTab isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getMainTab isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local mainTab = poolCurrentUI:newTitleTab()
  mainTab:SetTextHorizonLeft(true)
  mainTab:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHATTING_MAINTAB_TITLE", "panel_Index", panelIndex + 1))
  mainTab:SetNotAbleMasking(true)
  mainTab:SetShow(isShow)
  if isEnableSimpleUI then
    if isSimpleUI then
      mainTab:SetFontAlpha(1)
      mainTab:SetAlpha(1)
    else
      mainTab:SetFontAlpha(0.8)
      mainTab:SetAlpha(0.7)
    end
  end
  return mainTab
end
function PaGlobal_ChatMain:getSettingButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getSettingButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getSettingButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getSettingButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getSettingButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getSettingButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getSettingButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local settingButton = poolCurrentUI:newTitleTabConfigButton()
  settingButton:SetShow(isShow)
  settingButton:SetNotAbleMasking(true)
  if isEnableSimpleUI then
    if isSimpleUI then
      settingButton:SetAlpha(1)
    else
      settingButton:SetAlpha(0.7)
    end
  end
  return settingButton
end
function PaGlobal_ChatMain:getDivisionButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getDivisionButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getDivisionButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getDivisionButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getDivisionButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getDivisionButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getDivisionButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local divisionButton = poolCurrentUI:newPanelDivision()
  divisionButton:SetShow(isShow)
  divisionButton:SetNotAbleMasking(true)
  if isEnableSimpleUI then
    if isSimpleUI then
      divisionButton:SetAlpha(1)
    else
      divisionButton:SetAlpha(0.7)
    end
  end
  return divisionButton
end
function PaGlobal_ChatMain:getDeleteButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getDeleteButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getDeleteButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getDeleteButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getDeleteButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getDeleteButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getDeleteButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local deleteButton = poolCurrentUI:newCloseButton()
  deleteButton:SetShow(isShow)
  deleteButton:SetNotAbleMasking(true)
  deleteButton:SetIgnore(false)
  if isEnableSimpleUI then
    if isSimpleUI then
      deleteButton:SetAlpha(1)
    else
      deleteButton:SetAlpha(0.7)
    end
  end
  return deleteButton
end
function PaGlobal_ChatMain:getCombineButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getCombineButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getCombineButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getCombineButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getCombineButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getCombineButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getCombineButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local combineButton = poolCurrentUI:newPanelCombine()
  combineButton:SetShow(isShow)
  combineButton:SetNotAbleMasking(true)
  if isEnableSimpleUI then
    if isSimpleUI then
      combineButton:SetAlpha(1)
    else
      combineButton:SetAlpha(0.7)
    end
  end
  return combineButton
end
function PaGlobal_ChatMain:getScrollResetButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getScrollResetButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getScrollResetButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getScrollResetButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getScrollResetButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getScrollResetButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getScrollResetButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local scrollResetBtn = poolCurrentUI:newScrollReset()
  scrollResetBtn:SetShow(isShow)
  return scrollResetBtn
end
function PaGlobal_ChatMain:getMoreList(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getMoreList poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getMoreList panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getMoreList drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getMoreList isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getMoreList isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getMoreList isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local moreList = poolCurrentUI:newMorelist()
  moreList:SetShow(isShow)
  return moreList
end
function PaGlobal_ChatMain:getSubTab(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getSubTab poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getSubTab panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getSubTab drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getSubTab isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getSubTab isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getSubTab isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local subTab = poolCurrentUI:newOtherTab()
  subTab:SetTextHorizonCenter(true)
  subTab:SetText(panelIndex + 1)
  subTab:SetNotAbleMasking(true)
  subTab:SetShow(isShow)
  if isEnableSimpleUI then
    if isSimpleUI then
      subTab:SetFontAlpha(1)
      subTab:SetAlpha(1)
    else
      subTab:SetFontAlpha(0.8)
      subTab:SetAlpha(0.7)
    end
  end
  return subTab
end
function PaGlobal_ChatMain:getPanelDragToggleButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getPanelDragToggleButton poolCurrentUI nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getPanelDragToggleButton panelIndex nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getPanelDragToggleButton drawPanelIndex nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getPanelDragToggleButton isShow nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getPanelDragToggleButton isEnableSimpleUI nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getPanelDragToggleButton isSimpleUI nil", "\235\176\169\237\149\152\236\157\128")
  local panel_DragToggleButton = poolCurrentUI:newPanelDragToggle()
  panel_DragToggleButton:SetNotAbleMasking(true)
  panel_DragToggleButton:SetShow(isShow)
  return panel_DragToggleButton
end
function PaGlobal_ChatMain:getButtonMove(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getButtonMove poolCurrentUI nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getButtonMove panelIndex nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getButtonMove drawPanelIndex nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getButtonMove isShow nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getButtonMove isEnableSimpleUI nil", "\235\176\169\237\149\152\236\157\128")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getButtonMove isSimpleUI nil", "\235\176\169\237\149\152\236\157\128")
  local buttonMove = poolCurrentUI:newButtonMove()
  buttonMove:SetNotAbleMasking(true)
  buttonMove:SetShow(isShow)
  return buttonMove
end
function PaGlobal_ChatMain:getStaticButtonBG(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getStaticButtonBG poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getStaticButtonBG panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getStaticButtonBG drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getStaticButtonBG isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getStaticButtonBG isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getStaticButtonBG isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local buttonBG = poolCurrentUI:newStaticButtonBG()
  buttonBG:SetNotAbleMasking(true)
  buttonBG:SetShow(isShow)
  return buttonBG
end
function PaGlobal_ChatMain:getPanelResizeButton(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getPanelResizeButton poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getPanelResizeButton panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getPanelResizeButton drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getPanelResizeButton isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getPanelResizeButton isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getPanelResizeButton isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local panel_resizeButton = poolCurrentUI:newResizeButton()
  panel_resizeButton:SetNotAbleMasking(true)
  panel_resizeButton:SetShow(isShow)
  return panel_resizeButton
end
function PaGlobal_ChatMain:getPanelBg(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getPanelBg poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getPanelBg panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getPanelBg drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getPanelBg isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getPanelBg isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getPanelBg isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local panel_Bg = poolCurrentUI:newPanelBG()
  panel_Bg:SetNotAbleMasking(true)
  panel_Bg:SetShow(true)
  panel_Bg:SetIgnore(true)
  return panel_Bg
end
function PaGlobal_ChatMain:getPanelScroll(poolCurrentUI, panelIndex, drawPanelIndex, isShow, isEnableSimpleUI, isSimpleUI)
  UI.ASSERT_NAME(nil ~= poolCurrentUI, "PaGlobal_ChatMain:getPanelScroll poolCurrentUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getPanelScroll panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "PaGlobal_ChatMain:getPanelScroll drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_ChatMain:getPanelScroll isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isEnableSimpleUI, "PaGlobal_ChatMain:getPanelScroll isEnableSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isSimpleUI, "PaGlobal_ChatMain:getPanelScroll isSimpleUI nil", "\236\178\156\235\167\140\234\184\176")
  local panel_Scroll = poolCurrentUI:newScroll()
  panel_Scroll:SetShow(isShow)
  if isEnableSimpleUI then
    panel_Scroll:SetShow(isSimpleUI)
  end
  return panel_Scroll
end
PaGlobal_ChatMain:initialize_Pool()
