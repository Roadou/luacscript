function PaGlobal_PersonalField_Main_All_Open()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  PaGlobal_PersonalField_Main_All:prepareOpen()
end
function PaGlobal_PersonalField_Main_All_Close()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  PaGlobal_PersonalField_Main_All:prepareClose()
end
function PaGlobalFunc_PersonalField_Main_All_ListControlCreate(content, key)
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  PaGlobal_PersonalField_Main_All:listControlCreate(content, key)
end
function PaGlobalFunc_PersonalField_Main_All_Update()
  if nil == Panel_Window_PersonalField_Main or false == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  PaGlobal_PersonalField_Main_All:update()
end
function HandleEventLUp_PersonalField_Main_All_Navi(index)
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == index then
    if nil == PaGlobal_PersonalField_Main_All._selectIndex then
      return
    end
    index = PaGlobal_PersonalField_Main_All._selectIndex
  end
  local naviList = PaGlobal_PersonalField_Main_All._naviPosList
  if nil == naviList then
    return
  end
  local currentFieldNo = ToClient_getCurrentFieldNo()
  local fieldNo = naviList[index]._fieldNo
  if fieldNo ~= currentFieldNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTGALARY_NOREGION"))
    return
  end
  local naviPos = naviList[index]._centerPos
  if nil == naviPos then
    return
  end
  local isTopPicking = math.floor(naviPos.y) == 0
  local isAutoMove = false
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(naviPos, NavigationGuideParam(), isAutoMove, isTopPicking)
end
function HandleEventLUp_PersonalField_Main_All_OpenEnterUI()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil ~= PaGlobal_Widget_PersonalField_Enter_All_Open then
    PaGlobal_Widget_PersonalField_Enter_All_Open(false)
  end
  PaGlobal_PersonalField_Main_All:prepareClose()
end
function HandleEventLUp_PersonalField_Main_All_Leave()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == PaGlobal_Widget_PersonalField_All_CheckChangeState then
    return
  end
  if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) then
    return
  end
  local leavePersonalField = function()
    if nil == PaGlobal_Widget_PersonalField_All_CheckChangeState then
      return
    end
    if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) then
      return
    end
    ToClient_EnterOrLeavePersonalField(false)
    PaGlobal_PersonalField_Main_All:prepareClose()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_EXIT"),
    functionYes = leavePersonalField,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_PersonalField_Main_All_ToggleWidget()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if true == PaGlobal_PersonalField_Main_All._isConsole then
    PaGlobal_PersonalField_Main_All._ui._btn_uiOnOff:SetCheck(not PaGlobal_PersonalField_Main_All._ui._btn_uiOnOff:IsCheck())
  end
  local isNotShow = not PaGlobal_PersonalField_Main_All._ui._btn_uiOnOff:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eIsShowPersonalFieldWidget, isNotShow, CppEnums.VariableStorageType.eVariableStorageType_User)
  if true == isNotShow then
    if true == Panel_Widget_PersonalField_Mini:GetShow() then
      PaGlobal_Widget_PersonalField_All_Close()
    end
  elseif false == Panel_Widget_PersonalField_Mini:GetShow() then
    PaGlobal_Widget_PersonalField_All_Open()
  end
end
function HandlePadEventLUp_PersonalField_Main_All_Confirm()
  if nil == Panel_Window_PersonalField_Main or false == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  if true == PaGlobal_PersonalField_Main_All._isNonEnterServer then
    HandlePadEventLUp_PersonalField_Main_All_OpenChannelSelect()
    return
  end
  if nil ~= PaGlobal_PersonalField_Main_All._enterIndex and PaGlobal_PersonalField_Main_All._enterIndex == PaGlobal_PersonalField_Main_All._selectIndex then
    local isEnterMirrorField = ToClient_IsEnterMirrorField()
    local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
    if true == isEnterMirrorField then
      if true == isEnterPersonalField then
        HandleEventLUp_PersonalField_Main_All_Leave()
      else
        HandleEventLUp_PersonalField_Main_All_Navi()
      end
    else
      HandleEventLUp_PersonalField_Main_All_OpenEnterUI()
    end
  else
    HandleEventLUp_PersonalField_Main_All_Navi()
  end
end
function HandlePadEventOn_PersonalField_Main_All_SelectIndex(index)
  if nil == Panel_Window_PersonalField_Main or false == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  if true == PaGlobal_PersonalField_Main_All._isNonEnterServer then
    PaGlobal_PersonalField_Main_All._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SELECT"))
    return
  end
  PaGlobal_PersonalField_Main_All._selectIndex = index
  if __ePersonalFieldServerState_NoEntry == PaGlobal_PersonalField_Main_All._serverState or -1 == PaGlobal_PersonalField_Main_All._serverState or nil == PaGlobal_PersonalField_Main_All._enterIndex or PaGlobal_PersonalField_Main_All._enterIndex ~= index then
    PaGlobal_PersonalField_Main_All._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHECKEDQUESTLIST_BTN_NAVI"))
  else
    local isEnterMirrorField = ToClient_IsEnterMirrorField()
    local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
    if true == isEnterMirrorField then
      if true == isEnterPersonalField then
        PaGlobal_PersonalField_Main_All._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_EXIT"))
      else
        PaGlobal_PersonalField_Main_All._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHECKEDQUESTLIST_BTN_NAVI"))
      end
    else
      PaGlobal_PersonalField_Main_All._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_ENTER"))
    end
  end
  PaGlobal_PersonalField_Main_All:setAlignKeyGuide()
end
function HandleEventOnOut_PersonalField_Main_All_SetShowStateTooltip(isShow)
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_PersonalField_Main_All._ui._txt_titelIcon
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  local serverState = PaGlobal_PersonalField_Main_All._serverState
  local stateText = ""
  if __ePersonalFieldServerState_NoEntry == serverState then
    stateText = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALFIELD_SERVERSTATUS_LOCKED") .. "<PAOldColor>"
  elseif __ePersonalFieldServerState_Free == serverState then
    stateText = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_STATE_GREEN")
  elseif __ePersonalFieldServerState_Busy == serverState then
    stateText = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_STATE_YELLOW")
  else
    stateText = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_STATE_RED")
  end
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_TOOLTIP_STATE", "state", stateText)
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_PersonalField_Main_All_SetShowRemainTimeTooltip(isShow)
  if Panel_Window_PersonalField_Main == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_PersonalField_Main_All._ui._txt_time
  if control == nil then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_PERSONALFIELD_RECOMMAND_TOOLTIP")
  TooltipSimple_Show(control, name, desc)
end
function HandlePadEventLUp_PersonalField_Main_All_OpenChannelSelect()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == PaGlobalFunc_ChannelSelect_All_Open then
    return
  end
  PaGlobalFunc_ChannelSelect_All_Open(true)
  PaGlobal_PersonalField_Main_All:prepareClose()
end
function HandlePadEventLUp_PersonalField_Main_All_SelectType(isShallow)
  if Panel_Window_PersonalField_Main == nil then
    return
  end
  if PaGlobal_PersonalField_Main_All._isDeepInfoExist == false then
    isShallow = true
  end
  if PaGlobal_PersonalField_Main_All._isConsole == true then
    if isShallow == true then
      PaGlobal_PersonalField_Main_All._ui._rdo_shallow:SetCheck(true)
      PaGlobal_PersonalField_Main_All._ui._rdo_deep:SetCheck(false)
    else
      PaGlobal_PersonalField_Main_All._ui._rdo_shallow:SetCheck(false)
      PaGlobal_PersonalField_Main_All._ui._rdo_deep:SetCheck(true)
    end
  end
  PaGlobal_PersonalField_Main_All:update()
end
function FromClient_PersonalField_Main_All_UpdateRemainTime()
  if nil == Panel_Window_PersonalField_Main or false == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  PaGlobal_PersonalField_Main_All:updateRemainTime()
end
function FromClient_PersonalField_Main_All_UpdateServerState()
  if nil == Panel_Window_PersonalField_Main or false == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  PaGlobal_PersonalField_Main_All:updateServerState()
end
function FromClient_PersonalField_Main_All_ResizePanel()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  local descSizeY = PaGlobal_PersonalField_Main_All._ui._txt_desc:GetTextSizeY()
  local baseDescSizeY = PaGlobal_PersonalField_Main_All._baseDescBGSizeY
  if descSizeY < baseDescSizeY then
    descSizeY = baseDescSizeY
  end
  descSizeY = descSizeY + 20
  PaGlobal_PersonalField_Main_All._ui._stc_desc:SetSize(PaGlobal_PersonalField_Main_All._ui._stc_desc:GetSizeX(), descSizeY)
  local descSizeGapY = descSizeY - PaGlobal_PersonalField_Main_All._baseDescBGSizeY
  PaGlobal_PersonalField_Main_All._ui._stc_mainBG:SetSize(PaGlobal_PersonalField_Main_All._ui._stc_desc:GetSizeX(), PaGlobal_PersonalField_Main_All._baseMainBGSizeY + descSizeGapY + 10)
  Panel_Window_PersonalField_Main:SetSize(Panel_Window_PersonalField_Main:GetSizeX(), PaGlobal_PersonalField_Main_All._basePanelSizeY + descSizeGapY)
  Panel_Window_PersonalField_Main:ComputePosAllChild()
  local serverSelectPosY = PaGlobal_PersonalField_Main_All._ui._fieldList:GetPosY() + PaGlobal_PersonalField_Main_All._ui._fieldList:GetSizeY() + 10
  PaGlobal_PersonalField_Main_All._ui._btn_serverSelectAlwaysOn:SetPosY(serverSelectPosY)
end
