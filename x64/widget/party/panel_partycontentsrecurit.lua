PaGlobal_PartyContentsRecruit = {
  _ui = {
    _stc_bg = nil,
    _stc_selectBg = nil,
    _stc_btn1 = nil,
    _stc_btn2 = nil,
    _stc_btn3 = nil,
    _stc_btn4 = nil,
    _stc_lock1 = nil,
    _stc_lock2 = nil,
    _stc_lock3 = nil,
    _stc_lock4 = nil,
    _txt_desc = nil,
    _btn_enter = nil,
    _btn_exit = nil,
    _stc_blackBg = nil
  },
  _isSelectKind = nil,
  _matchingState = -1,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PartyContentsRecruit_Init")
function FromClient_PartyContentsRecruit_Init()
  PaGlobal_PartyContentsRecruit:initialize()
end
function PaGlobal_PartyContentsRecruit:initialize()
  self._ui._stc_bg = UI.getChildControl(Panel_PartyContentRecurit, "Static_EnterBG")
  self._ui._stc_selectBg = UI.getChildControl(self._ui._stc_bg, "Static_SelectArea_Group")
  self._ui._stc_btn1 = UI.getChildControl(self._ui._stc_selectBg, "RadioButton_1")
  self._ui._stc_btn2 = UI.getChildControl(self._ui._stc_selectBg, "RadioButton_2")
  self._ui._stc_btn3 = UI.getChildControl(self._ui._stc_selectBg, "RadioButton_3")
  self._ui._stc_btn4 = UI.getChildControl(self._ui._stc_selectBg, "RadioButton_4")
  self._ui._stc_lock1 = UI.getChildControl(self._ui._stc_selectBg, "Static_LockedArea_1")
  self._ui._stc_lock2 = UI.getChildControl(self._ui._stc_selectBg, "Static_LockedArea_2")
  self._ui._stc_lock3 = UI.getChildControl(self._ui._stc_selectBg, "Static_LockedArea_3")
  self._ui._stc_lock4 = UI.getChildControl(self._ui._stc_selectBg, "Static_LockedArea_4")
  self._ui._btn_enter = UI.getChildControl(self._ui._stc_bg, "Button_Enter")
  self._ui._btn_exit = UI.getChildControl(self._ui._stc_bg, "Button_Exit")
  self._ui._stc_blackBg = UI.getChildControl(Panel_PartyContentRecurit, "Static_BlackBG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_bg, "StaticText_DungeonName")
  self._ui._stc_lock1:SetShow(not _ContentsGroup_AtoraxionDesert)
  self._ui._stc_lock2:SetShow(not _ContentsGroup_AtoraxionSea)
  self._ui._stc_lock3:SetShow(not _ContentsGroup_AtoraxionForest)
  self._ui._stc_lock4:SetShow(not _ContentsGroup_AtoraxionThorn)
  self._ui._stc_btn1:SetIgnore(not _ContentsGroup_AtoraxionDesert)
  self._ui._stc_btn2:SetIgnore(not _ContentsGroup_AtoraxionSea)
  self._ui._stc_btn3:SetIgnore(not _ContentsGroup_AtoraxionForest)
  self._ui._stc_btn4:SetIgnore(not _ContentsGroup_AtoraxionThorn)
  self._ui._stc_btn1:SetIgnore(not _ContentsGroup_AtoraxionDesert)
  self._ui._stc_btn1:SetMonoTone(not _ContentsGroup_AtoraxionDesert)
  self._ui._stc_btn2:SetMonoTone(not _ContentsGroup_AtoraxionSea)
  self._ui._stc_btn3:SetMonoTone(not _ContentsGroup_AtoraxionForest)
  self._ui._stc_btn4:SetMonoTone(not _ContentsGroup_AtoraxionThorn)
  PaGlobal_PartyContentsRecruit:registerEvent()
end
function PaGlobal_PartyContentsRecruit:registerEvent()
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_RequestPartyMatching()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_Close()")
  registerEvent("onScreenResize", "PaGlobalFunc_PartyContentsRecruit_OnScreenResize")
  registerEvent("ResponseParty_createPartyList", "FromClient_UpdatePartyContentsMatchingState")
  registerEvent("ResponseParty_updatePartyList", "FromClient_UpdatePartyContentsMatchingState")
  self._ui._stc_btn1:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_DescChange()")
  self._ui._stc_btn2:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_DescChange()")
  self._ui._stc_btn3:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_DescChange()")
  self._ui._stc_btn4:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyContentsRecruit_DescChange()")
end
function PaGlobal_PartyContentsRecruit:setMatchingText()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local hasParty = selfPlayer:get():hasParty()
  local isMaxMember = ToClient_isPartyFull()
  self._matchingState = ToClient_getPartyContentsMatchingState()
  if true == hasParty then
    local isLeader = RequestParty_isLeader()
    if isLeader == true then
      self._ui._btn_enter:SetIgnore(isMaxMember == true)
      self._ui._btn_enter:SetMonoTone(isMaxMember == true)
    else
      self._ui._btn_enter:SetIgnore(true)
      self._ui._btn_enter:SetMonoTone(true)
    end
  else
    self._ui._btn_enter:SetIgnore(false)
    self._ui._btn_enter:SetMonoTone(false)
  end
  if self._matchingState == __ePartyContentsMatchingState_Matching and isMaxMember == false then
    self._ui._btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLOODALTAR_RAMDOMMATCH_MATCHCANCEL"))
  else
    self._ui._btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PARTYMATCHING_ATORAXXION_START"))
  end
end
function PaGlobal_PartyContentsRecruit:prepareOpen()
  local matchingType = ToClient_getPartyContentsMatchingType()
  if nil == self._isSelectKind then
    self._ui._stc_btn1:SetCheck(matchingType == __ePartyContentsType_AtoraxionDesert)
    self._ui._stc_btn2:SetCheck(matchingType == __ePartyContentsType_AtoraxionSea)
    self._ui._stc_btn3:SetCheck(matchingType == __ePartyContentsType_AtoraxionVelly)
    self._ui._stc_btn4:SetCheck(matchingType == __ePartyContentsType_AtoraxionThorn)
  else
    self._ui._stc_btn1:SetCheck(__eInstanceAtoraxion_Hadum == self._isSelectKind)
    self._ui._stc_btn2:SetCheck(__eInstanceAtoraxionSea_Hadum == self._isSelectKind)
    self._ui._stc_btn3:SetCheck(__eInstanceAtoraxionValley_Hadum == self._isSelectKind)
    self._ui._stc_btn4:SetCheck(__eInstanceAtoraxionThorn_Hadum == self._isSelectKind)
  end
  PaGlobalFunc_PartyContentsRecruit_DescChange()
  PaGlobalFunc_PartyContentsRecruit_OnScreenResize()
  PaGlobal_PartyContentsRecruit:setMatchingText()
  PaGlobal_PartyContentsRecruit:open()
end
function PaGlobal_PartyContentsRecruit:open()
  Panel_PartyContentRecurit:SetShow(true)
end
function PaGlobal_PartyContentsRecruit:prepareClose()
  PaGlobal_PartyContentsRecruit:close()
end
function PaGlobal_PartyContentsRecruit:close()
  Panel_PartyContentRecurit:SetShow(false)
end
function PaGlobal_PartyContentsRecruit:checkBtn()
  local index
  if self._ui._stc_btn1:IsCheck() == true and _ContentsGroup_AtoraxionDesert == true then
    index = __ePartyContentsType_AtoraxionDesert
  elseif self._ui._stc_btn2:IsCheck() == true and _ContentsGroup_AtoraxionSea == true then
    index = __ePartyContentsType_AtoraxionSea
  elseif self._ui._stc_btn3:IsCheck() == true and _ContentsGroup_AtoraxionForest == true then
    index = __ePartyContentsType_AtoraxionVelly
  elseif self._ui._stc_btn4:IsCheck() == true and _ContentsGroup_AtoraxionThorn == true then
    index = __ePartyContentsType_AtoraxionThorn
  end
  return index
end
function PaGlobalFunc_PartyContentsRecruit_Close()
  if nil == Panel_PartyContentRecurit then
    return
  end
  PaGlobal_PartyContentsRecruit:prepareClose()
end
function PaGlobalFunc_PartyContentsRecruit_RequestPartyMatching()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local isMsgShow = false
  if selfPlayer:getLevel() < 60 then
    isMsgShow = true
  end
  if isMsgShow == true then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXXION_MATCHING_CONDITION_LV")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local isFindOrCreate
  if selfPlayer:hasParty() == true then
    local selfIsPartyLeader = RequestParty_isLeader()
    if selfIsPartyLeader == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_NOPARTYBOSS"))
      return
    end
    if ToClient_GetPartyType() ~= CppEnums.PartyType.ePartyType_Normal then
      local typeStr = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_PARTY")
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MENU_PARTY_ALERTMESSAGE", "partyType", typeStr))
      return
    end
  end
  local selectedType
  if ToClient_getPartyContentsMatchingState() == __ePartyContentsMatchingState_Matching then
    isFindOrCreate = false
  else
    isFindOrCreate = true
    if ToClient_IsEnterMirrorField() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingInThisField"))
      return
    end
    if ToClient_isPremiumCharacter() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseContentsPremiumCharacter"))
      return
    end
    selectedType = PaGlobal_PartyContentsRecruit:checkBtn()
    if selectedType == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_NONEZODIAC"))
      return
    end
    if selectedType < __ePartyContentsType_Normal or selectedType >= __ePartyContentsType_Count then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CUSTOMIZATIONMAIN_NONEZODIAC"))
      return
    end
  end
  ToClient_requestPartyContentsRecurit(selectedType, isFindOrCreate)
  PaGlobalFunc_PartyContentsRecruit_Close()
end
function PaGlobalFunc_PartyContentsRecruit_OnScreenResize()
  if nil == Panel_PartyContentRecurit then
    return
  end
  Panel_PartyContentRecurit:ComputePos()
  PaGlobal_PartyContentsRecruit._ui._stc_blackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_PartyContentsRecruit._ui._stc_blackBg:ComputePos()
end
function FromClient_UpdatePartyContentsMatchingState()
  if nil == Panel_PartyContentRecurit or Panel_PartyContentRecurit:GetShow() == false then
    return
  end
  PaGlobal_PartyContentsRecruit:setMatchingText()
end
function PaGlobalFunc_PartyContentsRecruit_DescChange()
  local self = PaGlobal_PartyContentsRecruit
  if self._ui._stc_btn1:IsCheck() == true then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_0"))
  elseif self._ui._stc_btn2:IsCheck() == true then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_1"))
  elseif self._ui._stc_btn3:IsCheck() == true then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_2"))
  elseif self._ui._stc_btn4:IsCheck() == true then
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_3"))
  else
    self._ui._txt_desc:SetText("")
  end
end
