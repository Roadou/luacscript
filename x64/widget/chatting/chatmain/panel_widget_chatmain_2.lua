local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
function HandleOn_ChattingAddTabToolTip(isShow, poolIndex, tipType)
  UI.ASSERT_NAME(nil ~= isShow, "HandleOn_ChattingAddTabToolTip isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingAddTabToolTip poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= tipType, "HandleOn_ChattingAddTabToolTip tipType nil", "\236\178\156\235\167\140\234\184\176")
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == poolIndex then
    return
  end
  local name, desc, control
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local addTabControl = poolCurrentUI._list_AddTab[0]
  local divisionControl = poolCurrentUI._list_PanelDivision[poolIndex]
  local settingControl = poolCurrentUI._list_TitleTabConfigButton[poolIndex]
  local sizeControl = poolCurrentUI._list_ResizeButton[poolIndex]
  local combineControl = poolCurrentUI._list_PanelDelete[poolIndex]
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_ADDTAB_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_ADDTAB_DESC")
    control = addTabControl
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_DIVISION_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_DIVISION_DESC")
    control = divisionControl
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_CONFIG_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_CONFIG_DESC")
    control = settingControl
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_RESIZE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_RESIZE_DESC")
    control = sizeControl
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_MERGE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_MERGE_DESC")
    control = combineControl
  end
  if nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleClicked_Chatting_ToggleDragMove(drawPanelIndex)
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "HandleEventLUp_ToggleDragMove drawPanelIndex nil", "\235\176\169\237\149\152\236\157\128")
  local panel = PaGlobal_ChatMain:getPanel(drawPanelIndex)
  local buttonBG = UI.getChildControl(panel, "Static_ButtonBG0")
  local chkDragToggle = UI.getChildControl(buttonBG, "CheckButton_PanelDragToggle0")
  local isCheck = chkDragToggle:IsCheck()
  if isCheck == true then
    panel:SetDragEnable(false)
  else
    panel:SetDragEnable(true)
  end
  HandleEventOnOut_ChatMain_All_ToggleDragToolTip(drawPanelIndex, true)
end
function HandleEventOnOut_ChatMain_All_ToggleDragToolTip(drawPanelIndex, show)
  if show == false then
    TooltipSimple_Hide()
    return
  end
  local panel = PaGlobal_ChatMain:getPanel(drawPanelIndex)
  local buttonBG = UI.getChildControl(panel, "Static_ButtonBG0")
  local control = UI.getChildControl(buttonBG, "CheckButton_PanelDragToggle0")
  if control:IsCheck() == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_DESC")
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleClicked_Chatting_ResizeStartPos(drawPanelIndex)
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "HandleClicked_Chatting_ResizeStartPos drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  local panel = PaGlobal_ChatMain:getPanel(drawPanelIndex)
  PaGlobal_ChatMain._orgMouseX = getMousePosX()
  PaGlobal_ChatMain._orgMouseY = getMousePosY()
  PaGlobal_ChatMain._orgPanelPosY = panel:GetPosY()
  PaGlobal_ChatMain._orgPanelSizeX = panel:GetSizeX()
  PaGlobal_ChatMain._orgPanelSizeY = panel:GetSizeY()
  FromClient_ChatUpdate(true, drawPanelIndex, true)
end
function HandleClicked_Chatting_Resize(drawPanelIndex, panelIdx)
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "HandleClicked_Chatting_Resize drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIdx, "HandleClicked_Chatting_Resize panelIdx nil", "\236\178\156\235\167\140\234\184\176")
  local panel = PaGlobal_ChatMain:getPanel(drawPanelIndex)
  local chatUI = PaGlobal_ChatMain:getPool(drawPanelIndex)
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  local deltaX = currentX - PaGlobal_ChatMain._orgMouseX
  local deltaY = PaGlobal_ChatMain._orgMouseY - currentY
  local sizeX = PaGlobal_ChatMain._orgPanelSizeX + deltaX
  local sizeY = PaGlobal_ChatMain._orgPanelSizeY + deltaY
  if sizeX >= PaGlobal_ChatMain._CHATTING_WINDOW_MAXWIDTH then
    sizeX = PaGlobal_ChatMain._CHATTING_WINDOW_MAXWIDTH
  elseif sizeX < PaGlobal_ChatMain._DEFAULT_PANELSIZE_X then
    sizeX = PaGlobal_ChatMain._DEFAULT_PANELSIZE_X
  end
  if sizeY < PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y then
    sizeY = PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y
  end
  local deltaPosY = PaGlobal_ChatMain._orgPanelSizeY - sizeY
  panel:SetSize(sizeX, sizeY)
  chatUI._list_PanelBG[0]:SetSize(sizeX, sizeY)
  chatUI._list_Scroll[0]:SetSize(chatUI._list_Scroll[0]:GetSizeX(), sizeY - 67)
  for chattingContents_idx = 0, chatUI._MAXCOUNT_CHATTINGCONTENTS - 1 do
    chatUI._list_ChattingContents[chattingContents_idx]:SetSize(sizeX - 25, chatUI._list_ChattingContents[chattingContents_idx]:GetSizeY())
  end
  panel:SetPosY(PaGlobal_ChatMain._orgPanelPosY + deltaPosY)
  chatUI._list_ResizeButton[0]:SetPosX(sizeX - (chatUI._list_ResizeButton[0]:GetSizeX() + 5))
  chatUI._list_StaticButtonBG[0]:SetPosX(sizeX - (chatUI._list_StaticButtonBG[0]:GetSizeX() + 5))
  panel:SetDragArea(chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_PanelDragToggle[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY(), chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_StaticButtonBG[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY() + chatUI._list_StaticButtonBG[0]:GetSizeY())
  chatUI._list_Scroll[0]:SetPosX(sizeX - (chatUI._list_Scroll[0]:GetSizeX() + 5))
  chatUI._list_Scroll[0]:SetControlBottom()
  if PAGlobal_setPanelChattingPoolRelativeSize ~= nil then
    PAGlobal_setPanelChattingPoolRelativeSize(drawPanelIndex)
  end
  if nil ~= PaGlobal_ImportantNotice_Reposition then
    PaGlobal_ImportantNotice_Reposition(panel, chatUI._list_PanelBG[0], drawPanelIndex, true)
  end
  FromClient_ChatUpdate(true, drawPanelIndex, true)
  ToClient_SaveUiInfo(false)
end
function Chatting_PanelTransparency(panelIndex, transparency, isHideTooltip)
  UI.ASSERT_NAME(nil ~= panelIndex, "Chatting_PanelTransparency panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= transparency, "Chatting_PanelTransparency transparency nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isHideTooltip, "Chatting_PanelTransparency isHideTooltip nil", "\236\178\156\235\167\140\234\184\176")
  local count = ToClient_getChattingPanelCount()
  if panelIndex > count then
    return
  end
  local currentPanel = PaGlobal_ChatMain:getPanel(panelIndex)
  local IsMouseOver = UI.checkIsInMouseAndEventPanel(currentPanel)
  if true == isHideTooltip then
    if true == _ContentsGroup_NewUI_Tooltip_All then
      if Panel_Widget_Tooltip_Item_LinkedItem_All:GetShow() then
        Panel_Tooltip_Item_hideTooltip()
        TooltipSimple_Hide()
      end
    elseif Panel_Tooltip_Item_chattingLinkedItem:GetShow() then
      Panel_Tooltip_Item_hideTooltip()
      TooltipSimple_Hide()
    end
  end
  if true == transparency and true == IsMouseOver then
    if false == PaGlobal_ChatMain._isMouseOn then
      PaGlobal_ChatMain._cacheSimpleUI = true
      PaGlobal_ChatMain._isMouseOnChattingViewIndex = panelIndex
      PaGlobal_ChatMain._isMouseOn = true
      HandleEventOnOut_Chatting_UpdateTab(panelIndex)
    end
    TooltipSimple_Hide()
  elseif false == transparency and false == IsMouseOver then
    PaGlobal_ChatMain._cacheSimpleUI = false
    PaGlobal_ChatMain._isMouseOn = false
    PaGlobal_ChatMain._isMouseOnChattingViewIndex = nil
    TooltipSimple_Hide()
    HandleEventOnOut_Chatting_UpdateTab(panelIndex)
  end
end
function HandleEventOnOut_Chatting_UpdateTab(currentPanelIndex)
  PaGlobal_ChatMain._tabButton_PosX = 0
  local panelCount = ToClient_getChattingPanelCount()
  for panelIndex = 0, panelCount - 1 do
    PaGlobal_ChatMain:getPool(panelIndex):tabClear()
    PaGlobal_ChatMain:getPool(panelIndex):panelClear()
    local chatPanel = ToClient_getChattingPanel(panelIndex)
    if true == chatPanel:isOpen() then
      PaGlobal_ChatMain:tabUpdate(chatPanel, panelIndex)
      PaGlobal_ChatMain:poolUpdate(chatPanel, panelIndex)
    end
  end
  PaGlobal_ChatMain:addTabCheck(currentPanelIndex)
end
function HandleClicked_Chatting_ResizeStartPosEND(drawPanelIndex)
  UI.ASSERT_NAME(nil ~= drawPanelIndex, "HandleClicked_Chatting_ResizeStartPosEND drawPanelIndex nil", "\236\178\156\235\167\140\234\184\176")
  ToClient_SaveUiInfo(false)
  Chatting_PanelTransparency(drawPanelIndex, false, false)
end
function HandleClicked_Chatting_MovePosEND()
  ToClient_SaveUiInfo(false)
end
function HandleClicked_ScrollBtnPosY(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_ScrollBtnPosY panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  if PaGlobal_ChatMain._issmoothscroll then
    return
  end
  local selectindex = 0
  local chatPanel = ToClient_getChattingPanel(panelIndex)
  local isCombinedMainPanel = chatPanel:isCombinedToMainPanel()
  if isCombinedMainPanel then
    local count = ToClient_getChattingPanelCount()
    for checkpanelIndex = 0, count - 1 do
      local isActivePanel = checkpanelIndex == PaGlobal_ChatMain._mainPanelSelectPanelIndex
      if isActivePanel then
        PaGlobal_ChatMain._issmoothscroll = true
        selectindex = 0
      end
    end
  else
    PaGlobal_ChatMain._issmoothscroll = true
    selectindex = panelIndex
  end
  local poolCurrentUI = PaGlobal_ChatMain:getPool(selectindex)
  if PaGlobal_ChatMain._preScrollControlPos[panelIndex] == poolCurrentUI._list_Scroll[0]:GetControlPos() then
    FromClient_ChatUpdate(true, nil, true)
    return
  end
  local index = math.floor((1 - poolCurrentUI._list_Scroll[0]:GetControlPos()) * (PaGlobal_ChatMain._MAX_HISTORYCOUNT - 1))
  if 0 == index then
    PaGlobal_ChatMain._deltascrollPosy[panelIndex] = (1 - poolCurrentUI._list_Scroll[0]:GetControlPos()) * (PaGlobal_ChatMain._MAX_HISTORYCOUNT - 1) % 1
  else
    PaGlobal_ChatMain._deltascrollPosy[panelIndex] = ((1 - poolCurrentUI._list_Scroll[0]:GetControlPos()) * (PaGlobal_ChatMain._MAX_HISTORYCOUNT - 1) - index) % 1
  end
  PaGlobal_ChatMain._preScrollControlPos[panelIndex] = poolCurrentUI._list_Scroll[0]:GetControlPos()
  PaGlobal_ChatMain._srollPosition[panelIndex] = index
  PaGlobal_ChatMain._scroll_BTNPos[panelIndex] = poolCurrentUI._list_Scroll[0]:GetControlPos()
  FromClient_ChatUpdate(true, nil, true)
end
function Chatting_Transparency(index)
  UI.ASSERT_NAME(nil ~= index, "Chatting_Transparency index nil", "\236\178\156\235\167\140\234\184\176")
  if index < 0 then
    return
  end
  Chatting_PanelTransparency(index, false, false)
end
function HandleClicked_Chatting_Division(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_Division panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  local divisionPanel = ToClient_getChattingPanel(panelIndex)
  local panel = PaGlobal_ChatMain:getPanel(panelIndex)
  local chatUI = PaGlobal_ChatMain:getPool(panelIndex)
  divisionPanel:setPosition(getScreenSizeX() * 0.5 - panel:GetSizeX() * 0.5, getScreenSizeY() * 0.5 - panel:GetSizeY() * 0.5, panel:GetSizeX(), panel:GetSizeY())
  panel:SetSize(PaGlobal_ChatMain._DEFAULT_PANELSIZE_X, PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y)
  panel:SetPosX(getScreenSizeX() * 0.5 - panel:GetSizeX() * 0.5)
  panel:SetPosY(getScreenSizeY() * 0.5 - panel:GetSizeY() * 0.5)
  panel:SetShow(true)
  panel:SetIgnore(false)
  panel:SetRelativePosX(0.5)
  panel:SetRelativePosY(0.5)
  local sizeX = panel:GetSizeX()
  local sizeY = panel:GetSizeY()
  chatUI._list_PanelBG[0]:SetSize(sizeX, sizeY)
  chatUI._list_Scroll[0]:SetSize(chatUI._list_Scroll[0]:GetSizeX(), sizeY - 67)
  chatUI._list_ResizeButton[0]:SetPosX(sizeX - (chatUI._list_ResizeButton[0]:GetSizeX() + 5))
  chatUI._list_StaticButtonBG[0]:SetPosX(sizeX - (chatUI._list_StaticButtonBG[0]:GetSizeX() + 5))
  panel:SetDragArea(chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_PanelDragToggle[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY(), chatUI._list_StaticButtonBG[0]:GetPosX() + chatUI._list_StaticButtonBG[0]:GetSizeX(), chatUI._list_StaticButtonBG[0]:GetPosY() + chatUI._list_StaticButtonBG[0]:GetSizeY())
  chatUI._list_Scroll[0]:SetControlBottom()
  PaGlobal_ChatMain._mainPanelSelectPanelIndex = 0
  PaGlobal_ChatMain._transparency[panelIndex] = 0.5
  if true == ToClient_isContentsOpenNewChatMain() then
    PaGlobal_ChatMain:updatePanel(0, true)
    PaGlobal_ChatMain:updatePanel(panelIndex, true)
  else
    FromClient_ChatUpdate(true, nil, true)
  end
  panel:SetShow(true)
  TooltipSimple_Hide()
  ToClient_SaveUiInfo(false)
end
function HandleClicked_Chatting_Close(panelIndex, drawPanelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_Close panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  ToClient_closeChattingPanel(panelIndex)
  if true == ToClient_isContentsOpenNewChatMain() then
    if 0 ~= drawPanelIndex then
      PaGlobal_ChatMain._isMouseOn = false
      local panel = PaGlobal_ChatMain:getPanel(drawPanelIndex)
      _PA_ASSERT(nil ~= panel, "\235\139\171\236\157\132 \237\140\168\235\132\144\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. DrawPanelIndex = " .. tostring(drawPanelIndex))
      panel:SetShow(false)
    else
      PaGlobal_ChatMain._mainPanelSelectPanelIndex = 0
      PaGlobal_ChatMain:updatePanel(0, true)
    end
  else
    PaGlobal_ChatMain._mainPanelSelectPanelIndex = 0
    if 0 ~= drawPanelIndex then
      PaGlobal_ChatMain._isMouseOn = false
    end
    FromClient_ChatUpdate(nil, nil, true)
    Chatting_PanelTransparency(panelIndex, false, true)
  end
  TooltipSimple_Hide()
  ToClient_SaveUiInfo(false)
end
function HandleClicked_Chatting_ScrollReset(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_ScrollReset panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  PaGlobal_ChatMain._isResetsmoothscroll = true
  local chatPanel = ToClient_getChattingPanel(panelIndex)
  local isCombinedMainPanel = chatPanel:isCombinedToMainPanel()
  if isCombinedMainPanel then
    local count = ToClient_getChattingPanelCount()
    for checkpanelIndex = 0, count - 1 do
      local isActivePanel = checkpanelIndex == PaGlobal_ChatMain._mainPanelSelectPanelIndex
      if isActivePanel then
        PaGlobal_ChatMain._issmoothscroll = true
        PaGlobal_ChatMain._scrollIndex = panelIndex
        panelIndex = 0
      end
    end
  else
    PaGlobal_ChatMain._issmoothscroll = true
    PaGlobal_ChatMain._scrollIndex = panelIndex
  end
  local poolCurrentUI = PaGlobal_ChatMain:getPool(panelIndex)
  PaGlobal_ChatMain._scrollresetSpeed = PaGlobal_ChatMain._srollPosition[PaGlobal_ChatMain._scrollIndex]
end
function HandleClicked_Chatting_ChangeTab(panelIndex)
  if true == ToClient_isContentsOpenNewChatMain() then
    HandleClicked_Chatting_ChangeTab_New(panelIndex)
  else
    HandleClicked_Chatting_ChangeTab_Old(panelIndex)
  end
end
function HandleClicked_Chatting_ChangeTab_Old(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_ChangeTab panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  PaGlobal_ChatMain._mainPanelSelectPanelIndex = panelIndex
  TooltipSimple_Hide()
  FromClient_ChatUpdate(true, nil, true)
end
function HandleClicked_Chatting_ChangeTab_New(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_ChangeTab panelIndex nil", "\235\176\149\234\183\156\235\130\152")
  local self = PaGlobal_ChatMain
  TooltipSimple_Hide()
  self._mainPanelSelectPanelIndex = panelIndex
  self:updatePanel(panelIndex, true)
  local drawIndex = 0
  self._tabButton_PosX = 0
  self:getPool(drawIndex):tabClear()
  for ii = 0, __eChatPanelMaxCount - 1 do
    local chatPanel = ToClient_getChattingPanel(ii)
    if true == chatPanel:isOpen() and true == chatPanel:isCombinedToMainPanel() then
      self:tabUpdate(chatPanel, ii)
    end
  end
  self:addTabCheck(0)
end
function HandleClicked_Chatting_AddTab()
  PaGlobal_ChatMain._addChattingPreset = false
  PaGlobal_ChatMain._addChattingIdx = ToClient_openChattingPanel()
  local mainPaenl = ToClient_getChattingPanel(0)
  local mainPanelTransparency = mainPaenl:getTransparency()
  FGlobal_Chatting_PanelTransparency(PaGlobal_ChatMain._addChattingIdx, mainPanelTransparency, false)
  TooltipSimple_Hide()
  FromClient_ChatUpdate(true, nil, true)
  ToClient_SaveUiInfo(false)
end
function HandleClicked_Chatting_CombineTab(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_CombineTab panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  local panel = ToClient_getChattingPanel(panelIndex)
  local mainPaenl = ToClient_getChattingPanel(0)
  local mainPanelTransparency = mainPaenl:getTransparency()
  panel:combineToMainPanel()
  panel:setTransparency(mainPanelTransparency)
  FGlobal_Chatting_PanelTransparency(panelIndex, mainPanelTransparency, false)
  TooltipSimple_Hide()
  FromClient_ChatUpdate(true, nil, true)
  ToClient_SaveUiInfo(false)
end
function Chatting_OnResize()
  PaGlobal_ChatMain._CHATTING_WINDOW_MAXWIDTH = getScreenSizeX() * 0.67
  local divisionPanel, panel, chatUI
  for poolIndex = 0, PaGlobal_ChatMain._POOLCOUNT - 1 do
    divisionPanel = ToClient_getChattingPanel(poolIndex)
    panel = PaGlobal_ChatMain:getPanel(poolIndex)
    chatUI = PaGlobal_ChatMain:getPool(poolIndex)
    if poolIndex ~= 0 and (false == divisionPanel:isOpen() or divisionPanel:isCombinedToMainPanel()) then
      panel:SetShow(false)
    end
    local panelSizeX = divisionPanel:getPanelSizeX()
    local panelSizeY = divisionPanel:getPanelSizeY()
    local panelPosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_PositionX)
    local panelPosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_PositionY)
    local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
    local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
    if relativePosX == -1 and relativePosY == -1 then
      local initPosX = 0
      local initPosY
      if false == _ContentsGroup_RenewUI then
        initPosY = getScreenSizeY() - panelSizeY - Panel_GameTips:GetSizeY()
      else
        initPosY = getScreenSizeY() - panelSizeY
      end
      panelPosX = initPosX
      panelPosY = initPosY
      panel:SetPosX(panelPosX)
      panel:SetPosY(panelPosY)
      FGlobal_InitPanelRelativePos(panel, initPosX, initPosY)
    end
    if relativePosX == 0 and relativePosY == 0 then
      panelPosX = 0
      if false == _ContentsGroup_RenewUI then
        panelPosY = getScreenSizeY() - panelSizeY - Panel_GameTips:GetSizeY()
      else
        panelPosY = getScreenSizeY() - panelSizeY
      end
    elseif relativePosX > 0 or relativePosY > 0 then
      panel:SetRelativePosX(relativePosX)
      panel:SetRelativePosY(relativePosY)
      panelPosX = relativePosX * getScreenSizeX() - panel:GetSizeX() * 0.5
      panelPosY = relativePosY * getScreenSizeY() - panel:GetSizeY() * 0.5
    end
    if panelSizeX > 25 and panelSizeY > 50 then
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
      chatUI._list_Scroll[0]:SetPosY(50)
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
      chatUI._list_Scroll[0]:SetPosY(50)
      chatUI._list_Scroll[0]:SetControlBottom()
    end
    local defaultPosY
    if false == _ContentsGroup_RenewUI then
      defaultPosY = getScreenSizeY() - panel:GetSizeY() - Panel_GameTips:GetSizeY()
    else
      defaultPosY = getScreenSizeY() - panel:GetSizeY()
    end
    if -1 == panelPosX and -1 == panelPosY then
      panelPosX = 0
      panelPosY = defaultPosY
    else
      if panelPosX < 0 then
        panelPosX = 0
      elseif panelPosX > getScreenSizeX() - panel:GetSizeX() then
        if false == _ContentsGroup_RenewUI then
          panelPosX = getScreenSizeX() - panel:GetSizeX() - Panel_GameTips:GetSizeY()
        else
          panelPosX = getScreenSizeX() - panel:GetSizeX()
        end
      end
      if panelPosY < 0 then
        panelPosY = 0
      elseif panelPosY == 0 then
        panelPosY = defaultPosY
      elseif panelPosY > getScreenSizeY() - panel:GetSizeY() then
        panelPosY = defaultPosY
      end
    end
    if PaGlobal_ChatMain._POOLCOUNT - 1 == poolIndex and panelPosY == defaultPosY then
      panelPosY = panelPosY - PaGlobal_ChatMain._DEFAULT_PANELSIZE_Y
    end
    panel:SetPosX(panelPosX)
    panel:SetPosY(panelPosY)
    local isCombinePanel = divisionPanel:isCombinedToMainPanel()
    divisionPanel:setPosition(panelPosX, panelPosY, panelSizeX, panelSizeY)
    if isCombinePanel then
      divisionPanel:combineToMainPanel()
    end
    if nil ~= PaGlobal_ImportantNotice_Reposition then
      PaGlobal_ImportantNotice_Reposition(panel, chatUI._list_PanelBG[0], poolIndex, false)
    end
  end
  FromClient_ChatUpdate(nil, nil, true)
end
function FromClient_ChatUpdate(isShow, currentPanelIndex, forceUpdate)
  LUA_SCOPED_PROFILE("FromClient_ChatUpdate")
  local startTime = os.clock()
  if PaGlobal_ChatMain._issmoothWheelscroll == true then
    PaGlobal_ChatMain._issmoothWheelscroll = false
    PaGlobal_ChatMain._smoothWheelScorllTime = 0
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_ChatMain:chatting_ShowOff()
    return
  end
  local panelCount = ToClient_getChattingPanelCount()
  if true == isChangeFontSize() then
    for panelIndex = 0, panelCount - 1 do
      local chatPanel = ToClient_getChattingPanel(panelIndex)
      local fontType = chatPanel:getChatFontSizeType()
      local fontSize = PaGlobal_ChatMain:convertChatFontTypeToFontSize(fontType)
      ToClient_getFontWrapper("BaseFont_10_Chat"):changeFontSize(fontSize)
      local panelsPool = PaGlobal_ChatMain:getPool(panelIndex)
      local chatSender
      for senderIdx = 0, panelsPool._MAXCOUNT_CHATTINGSENDER do
        chatSender = panelsPool._list_ChattingSender[senderIdx]
        chatSender:SetText(" ")
        chatSender:SetSize(chatSender:GetSizeX(), fontSize + 4)
      end
    end
  end
  PaGlobal_ChatMain._tabButton_PosX = 0
  local mainPanelUpdated = false
  for panelIndex = 0, panelCount - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIndex)
    if true == chatPanel:isOpen() then
      local isCombinedMainPanel = chatPanel:isCombinedToMainPanel()
      local isActivePanel = panelIndex == PaGlobal_ChatMain._mainPanelSelectPanelIndex
      if true == chatPanel:isUpdated() or true == forceUpdate then
        if true == isCombinedMainPanel and true == isActivePanel and false == mainPanelUpdated then
          PaGlobal_ChatMain:getPool(0):chatClear()
          mainPanelUpdated = true
        end
        PaGlobal_ChatMain:getPool(panelIndex):allClear()
        PaGlobal_ChatMain:update(chatPanel, panelIndex, forceUpdate)
        if 0 == panelIndex then
          mainPanelUpdated = true
        end
      else
        PaGlobal_ChatMain:getPool(panelIndex):tabClear()
        PaGlobal_ChatMain:getPool(panelIndex):panelClear()
        PaGlobal_ChatMain:tabUpdate(chatPanel, panelIndex)
        PaGlobal_ChatMain:poolUpdate(chatPanel, panelIndex)
        if true == isCombinedMainPanel and true == isActivePanel then
          PaGlobal_ChatMain:getPool(panelIndex):chatClear()
          PaGlobal_ChatMain:scrollUpdate(chatPanel, panelIndex)
        end
      end
    else
      PaGlobal_ChatMain:getPool(panelIndex):allClear()
      local panel = PaGlobal_ChatMain:getPanel(panelIndex)
      panel:SetShow(false)
    end
  end
  setisChangeFontSize(false)
  PaGlobal_ChatMain:addTabCheck(currentPanelIndex)
  if nil ~= PaGlobal_ChatMain._addChattingIdx then
    if PaGlobal_ChatMain._addChattingPreset == false then
      if true == _ContentsGroup_ChatOption_All then
        PaGlobalFunc_ChatOption_All_Open(PaGlobal_ChatMain._addChattingIdx, 0, true)
      else
        ChattingOption_Open(PaGlobal_ChatMain._addChattingIdx, 0, true)
      end
    end
    PaGlobal_ChatMain._addChattingIdx = nil
  end
  if true == ToClient_isCheckTimeNewChat() then
    local elapsedTime = os.clock() - startTime
    _PA_SVC_LOG("FromClient_ChatUpdate. elapsedTime = " .. tostring(elapsedTime))
  end
end
local sendPossibleTime = toUint64(0, 0)
function FromClient_ChatMain_PrivateChatMessageUpdate()
  if sendPossibleTime <= getTime() then
    audioPostEvent_SystemUi(99, 0)
    sendPossibleTime = getTime() + toUint64(0, 60000)
  end
end
function FromClient_ChatMain_EventProcessorInputModeChange()
  if false == ToClient_isLoadingProcessor() and IM.eProcessorInputMode_GameMode == getInputMode() then
    PaGlobal_ChatMain._isMouseOn = false
  end
end
function HandleEventOn_ChatMainPanelTransparency(panelIndex, isHideTooltip)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleEventOn_ChatMainPanelTransparency panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isHideTooltip, "HandleEventOn_ChatMainPanelTransparency isHideTooltip nil", "\236\178\156\235\167\140\234\184\176")
  Chatting_PanelTransparency(panelIndex, true, isHideTooltip)
end
function HandleEventOut_ChatMainPanelTransparency(panelIndex, isHideTooltip)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleEventOut_ChatMainPanelTransparency panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isHideTooltip, "HandleEventOut_ChatMainPanelTransparency isHideTooltip nil", "\236\178\156\235\167\140\234\184\176")
  Chatting_PanelTransparency(panelIndex, false, isHideTooltip)
end
function HandleOn_ChattingEmoticon(poolIndex, emoticonIndex, EmoticonKey, isShow, isReset)
  UI.ASSERT_NAME(nil ~= poolIndex, "HandleOn_ChattingEmoticon poolIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= emoticonIndex, "HandleOn_ChattingEmoticon emoticonIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= EmoticonKey, "HandleOn_ChattingEmoticon EmoticonKey nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isShow, "HandleOn_ChattingEmoticon isShow nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= isReset, "HandleOn_ChattingEmoticon isReset nil", "\236\178\156\235\167\140\234\184\176")
  if true == isReset then
    PaGlobal_ChatMain._shownEmoticonIndex = nil
  end
  local EmoticonSS = ToClient_getEmoticonInfoByKey(EmoticonKey)
  if nil ~= EmoticonSS then
    local ImagePath = EmoticonSS:getSequenceImagePath()
    if nil == ImagePath then
      return
    end
    local panel = PaGlobal_ChatMain:getPanel(poolIndex)
    if false == panel:GetShow() then
      poolIndex = 0
      panel = PaGlobal_ChatMain:getPanel(poolIndex)
    end
    local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
    local emoticonUI = poolCurrentUI._list_ChatEmoticon[emoticonIndex]
    local emoticonAniUi = poolCurrentUI._list_EmoticonAni[0]
    if nil ~= emoticonAniUi then
      if true == isShow and (PaGlobal_ChatMain._shownEmoticonIndex ~= emoticonIndex or true == isReset) then
        emoticonAniUi:ChangeTextureInfoNameAsync(ImagePath)
        local orgPanelPosX = panel:GetPosX()
        local orgPanelPosY = panel:GetPosY()
        if nil == emoticonUI then
          emoticonAniUi:SetPosX(getMousePosX() - emoticonAniUi:GetSizeX() - orgPanelPosX)
          emoticonAniUi:SetPosY(getMousePosY() - emoticonAniUi:GetSizeY() * 0.65 - orgPanelPosY)
        else
          if poolCurrentUI._list_PanelBG[0]:GetSizeX() < emoticonUI:GetPosX() + math.floor(emoticonAniUi:GetSizeX() * 0.85) then
            emoticonAniUi:SetPosX(poolCurrentUI._list_PanelBG[0]:GetPosX() + poolCurrentUI._list_PanelBG[0]:GetSizeX() - emoticonAniUi:GetSizeX() * 1.1)
          else
            emoticonAniUi:SetPosX(emoticonUI:GetPosX() - emoticonAniUi:GetSizeX() * 0.15)
          end
          if 0 > emoticonUI:GetPosY() - emoticonAniUi:GetSizeY() then
            emoticonAniUi:SetPosY(emoticonAniUi:GetSizeY() * 0.2)
          else
            emoticonAniUi:SetPosY(emoticonUI:GetPosY() - emoticonAniUi:GetSizeY() * 0.7)
          end
        end
        PaGlobal_ChatMain._shownEmoticonIndex = emoticonIndex
        emoticonAniUi:setUpdateTextureAni(true)
        emoticonAniUi:SetShow(true)
      elseif false == isShow and emoticonIndex == PaGlobal_ChatMain._shownEmoticonIndex then
        PaGlobal_ChatMain._shownEmoticonIndex = nil
        emoticonAniUi:SetShow(false)
      else
        PaGlobal_ChatMain._shownEmoticonIndex = nil
      end
    end
  end
end
function HandleClicked_Chatting_AddTabByIndex(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleClicked_Chatting_AddTabByIndex panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  PaGlobal_ChatMain._addChattingIdx = ToClient_openChattingPanelbyIndex(panelIndex)
  PaGlobal_ChatMain._addChattingPreset = true
  if PaGlobal_ChatMain._addChattingIdx == -1 then
    PaGlobal_ChatMain._addChattingIdx = nil
  end
  FromClient_ChatUpdate(true, nil, true)
  ToClient_SaveUiInfo(false)
end
function HandleOn_Chatting_UserTypeTooltip(UserType)
  UI.ASSERT_NAME(nil ~= UserType, "HandleOn_Chatting_UserTypeTooltip UserType nil", "\236\160\149\236\152\129\236\164\128")
  local resultStr
  if 1 == UserType then
    resultStr = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_LEFT_RETURNUSER")
  elseif 2 == UserType then
    resultStr = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALICON_LEFT_NEWBIE")
  end
  if resultStr ~= nil then
    PaGlobal_SpeechBubble_Show(resultStr, nil)
    PaGlobal_SpeechBubble_Pos(getMousePosX() + 5, getMousePosY() - 50)
  end
end
function HandleOn_Chatting_EdanaTooltip(UserType, userNo)
  local resultStr = ""
  local edaniaRegion = ToClient_GetEdaniaRegion(tonumber64(userNo))
  if edaniaRegion ~= __eEdaniaRegion_Count then
    if edaniaRegion == __eEdaniaRegion_Aetherion then
      resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHAT_ICON_TOOLTIP", "castlename", PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CASTLE_NAME_1"))
    elseif edaniaRegion == __eEdaniaRegion_Nymphamare then
      resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHAT_ICON_TOOLTIP", "castlename", PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CASTLE_NAME_2"))
    elseif edaniaRegion == __eEdaniaRegion_Orbita then
      resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHAT_ICON_TOOLTIP", "castlename", PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CASTLE_NAME_4"))
    elseif edaniaRegion == __eEdaniaRegion_Tenebraum then
      resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHAT_ICON_TOOLTIP", "castlename", PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CASTLE_NAME_3"))
    elseif edaniaRegion == __eEdaniaRegion_Zephyros then
      resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHAT_ICON_TOOLTIP", "castlename", PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CASTLE_NAME_5"))
    end
  end
  PaGlobal_SpeechBubble_Show(resultStr, nil)
  PaGlobal_SpeechBubble_Pos(getMousePosX() + 5, getMousePosY() - 50)
end
function HandleOn_Chatting_OlviaAcademyTooltip()
  local resultStr = "OlviaAcademyGuide_LUA"
  PaGlobal_SpeechBubble_Show(resultStr, nil)
  PaGlobal_SpeechBubble_Pos(getMousePosX() + 5, getMousePosY() - 50)
end
function HandleOn_Chatting_RecommandTooltip(recommandCount)
  UI.ASSERT_NAME(nil ~= recommandCount, "HandleOn_Chatting_RecommandTooltip recommandCount nil", "\234\185\128\236\167\128\237\152\129")
  local resultStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_THUMBSUP_RECEIVECOUNT", "thumbsUpCount", recommandCount)
  PaGlobal_SpeechBubble_Show(resultStr, nil)
  PaGlobal_SpeechBubble_Pos(getMousePosX() + 5, getMousePosY() - 50)
end
function HandleEventLPress_DragPanelAndSavePos(panelIndex)
  UI.ASSERT_NAME(nil ~= panelIndex, "HandleEventLPress_DragPanelAndSavePos panelIndex nil", "\235\176\169\237\149\152\236\157\128")
  local panel = PaGlobal_ChatMain:getPanel(panelIndex)
  local buttonBG = UI.getChildControl(panel, "Static_ButtonBG0")
  local chkDragToggle = UI.getChildControl(buttonBG, "CheckButton_PanelDragToggle0")
  local isCheck = chkDragToggle:IsCheck()
  if true == isCheck then
    return
  else
    local currentScreenSize = {
      x = getScreenSizeX(),
      y = getScreenSizeY()
    }
    local PosX = 0
    local PosY = 0
    local posX = panel:GetPosX()
    local posY = panel:GetPosY()
    panel:SetPosX(posX)
    panel:SetPosY(posY)
    local rateX = posX + panel:GetSizeX() / 2
    local rateY = posY + panel:GetSizeY() / 2
    panel:SetRelativePosX(rateX / currentScreenSize.x)
    panel:SetRelativePosY(rateY / currentScreenSize.y)
    PAGlobal_setIsChangePanelState(panelIndex, true, true)
  end
end
function PaGlobal_ChatMain:initScrollCount()
  PaGlobal_ChatMain._scrollCount = 1
end
function PaGlobal_ChatMain:addScrollCount()
  PaGlobal_ChatMain._scrollCount = math.min(PaGlobal_ChatMain._scrollCount + PaGlobal_ChatMain._SCROLL_COUNT_ADD, PaGlobal_ChatMain._SCROLL_COUNT_MAX)
end
function PaGlobal_ChatMain:getScrollSpeed(wheelScrollingTime)
  UI.ASSERT_NAME(nil ~= wheelScrollingTime, "PaGlobal_ChatMain:getScrollSpeed wheelScrollingTime nil", "\236\178\156\235\167\140\234\184\176")
  return wheelScrollingTime * PaGlobal_ChatMain._SCROLL_INTERVALSIZE * PaGlobal_ChatMain._scrollCount
end
function PaGlobal_ChatMain:getAddMessageCountLine(panelIndex, addMessageCount)
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getAddMessageCountLine panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= addMessageCount, "PaGlobal_ChatMain:getAddMessageCountLine addMessageCount nil", "\236\178\156\235\167\140\234\184\176")
  if addMessageCount <= 0 then
    return 0
  end
  local chatPanel = ToClient_getChattingPanel(panelIndex)
  local drawPanelIndex = panelIndex
  if true == chatPanel:isCombinedToMainPanel() then
    drawPanelIndex = 0
  end
  local poolCurrentUI = PaGlobal_ChatMain:getPool(drawPanelIndex)
  local chattingMessage = chatPanel:beginMessage(0)
  local lineCount = 0
  for i = 0, addMessageCount - 1 do
    lineCount = lineCount + PaGlobal_ChatMain:getLineSizeCheck(chattingMessage, poolCurrentUI, 0, i, panelIndex)
    chattingMessage = chatPanel:nextMessage()
  end
  return lineCount
end
function PaGlobal_ChatMain:addMessageScrollCount(panelIndex, addMessageCount)
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:addMessageScrollCount panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= addMessageCount, "PaGlobal_ChatMain:addMessageScrollCount addMessageCount nil", "\236\178\156\235\167\140\234\184\176")
  if PaGlobal_ChatMain._srollPosition[panelIndex] <= 0 then
    return
  end
  local countLine = PaGlobal_ChatMain:getAddMessageCountLine(panelIndex, addMessageCount)
  PaGlobal_ChatMain._srollPosition[panelIndex] = PaGlobal_ChatMain._srollPosition[panelIndex] + countLine
end
function PaGlobal_ChatMain:getCheckAddMessageCount(chatPanel, panelIndex)
  UI.ASSERT_NAME(nil ~= chatPanel, "PaGlobal_ChatMain:getCheckAddMessageCount chatPanel nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= panelIndex, "PaGlobal_ChatMain:getCheckAddMessageCount panelIndex nil", "\236\178\156\235\167\140\234\184\176")
  local addMessageCount = 0
  if 0 == chatPanel:getPopMessageCount() then
    addMessageCount = chatPanel:getMessageCount() - PaGlobal_ChatMain._premsgCount[panelIndex]
    PaGlobal_ChatMain._premsgCount[panelIndex] = chatPanel:getMessageCount()
  else
    if chatPanel:getPopMessageCount() < PaGlobal_ChatMain._prepopmsgCount[panelIndex] then
      PaGlobal_ChatMain._prepopmsgCount[panelIndex] = 0
    end
    if ToClient_getChattingMaxContentsCount() == PaGlobal_ChatMain._premsgCount[panelIndex] then
      addMessageCount = chatPanel:getPopMessageCount() - PaGlobal_ChatMain._prepopmsgCount[panelIndex]
    else
      addMessageCount = chatPanel:getPopMessageCount() - PaGlobal_ChatMain._prepopmsgCount[panelIndex] + ToClient_getChattingMaxContentsCount() - PaGlobal_ChatMain._premsgCount[panelIndex]
      PaGlobal_ChatMain._premsgCount[panelIndex] = ToClient_getChattingMaxContentsCount()
    end
    PaGlobal_ChatMain._prepopmsgCount[panelIndex] = chatPanel:getPopMessageCount()
  end
  return addMessageCount
end
function HandleClicked_Chatting_Recommand(senderUserNo, chatType)
  UI.ASSERT_NAME(nil ~= senderUserNo, "HandleClicked_Chatting_Recommand senderUserNo nil", "\236\158\132\236\136\152\237\152\132")
  UI.ASSERT_NAME(nil ~= chatType, "HandleClicked_Chatting_Recommand chatType nil", "\234\185\128\236\167\128\237\152\129")
  local selfUserNo = getSelfPlayer():get():getUserNo()
  if selfUserNo == senderUserNo then
    return
  end
  ToClient_GiveThumbsUp(toInt64(0, senderUserNo), chatType)
end
function FromClient_ChatMain_RecieveThumbsUpFromUser(charname)
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECOMMAND_ALERT_MESSAGE", "actorName", charname))
end
function PaGlobalFunc_ChatMain_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local selfActorKeyRaw = selfPlayer:getActorKey()
    if __eGuildRightType_Join == eRightType then
      return (selfPlayer:isSpecialGuildMember(selfActorKeyRaw))
    end
    return false
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
