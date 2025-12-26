function PaGlobalFunc_RoseWarEditParty_Open()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if ToClient_IsRoseWarServer() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionOnlyRoseWarServer"))
    return
  end
  local memberDataCount = ToClient_GetRoseWarMemberDataCount()
  local partyDataCount = ToClient_GetRoseWarPartyDataCount()
  if memberDataCount == 0 or partyDataCount == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMentalNotReady"))
    return
  end
  self:prepareOpen()
  ToClient_RequestCheckRoseWarPartyDataListSeqNo()
  PaGlobal_RoseWarMiniMap._ui._chk_toggleEditParty:SetCheck(true)
end
function PaGlobalFunc_RoseWarEditParty_Close()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobal_RoseWarMiniMap._ui._chk_toggleEditParty:SetCheck(false)
end
function PaGlobalFunc_RoseWarEditParty_IsShow()
  if Panel_RoseWar_EditParty == nil then
    return false
  end
  return Panel_RoseWar_EditParty:GetShow()
end
function PaGlobalFunc_RoseWarEditParty_OnCreateMemberContent(content, key)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or content == nil or key == nil then
    return
  end
  self:updateMemberListContent(content, key)
end
function PaGlobalFunc_RoseWarEditParty_OnCreatePartyMemberContent(content, key)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or content == nil or key == nil then
    return
  end
  self:updatePartyMemberListContent(content, key)
end
function PaGlobalFunc_RoseWarEditParty_SetPartyName(partyDataIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local partyPoolData = self:getPartyPoolData(partyDataIndex)
  if partyPoolData == nil then
    return
  end
  ToClient_SetRoseWarPartyDataMemo(partyDataWrapper:getPartyDataKey(), partyPoolData._edt_name:GetEditText())
  ClearFocusEdit()
end
function HandleEventClicked_RoseWarEditParty_FocusEditPartyName(partyDataIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil then
    return
  end
  local partyPoolData = self:getPartyPoolData(partyDataIndex)
  if partyPoolData == nil then
    return
  end
  SetFocusEdit(partyPoolData._edt_name)
end
function HandleEventDragUp_RoseWarEditParty_DragToMemberList()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if self:isDragging() == false then
    return
  end
  if 0 < self._memberList_selectInfo:length() then
    self:clearSelectInfo()
    self:updateMemberList()
  elseif 0 < self._partyMemberList_selectInfo:length() then
    for cacheIndex = 1, #self._partyMemberList_selectInfo do
      local cachedSelectedUserInfo = self._partyMemberList_selectInfo[cacheIndex]
      if cachedSelectedUserInfo ~= nil then
        local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(cachedSelectedUserInfo._partyDataIndex)
        if partyDataWrapper ~= nil then
          ToClient_RequestRemoveRoseWarPartyMember(partyDataWrapper:getPartyDataKey(), cachedSelectedUserInfo._userNo)
        end
      end
    end
    self:clearSelectInfo()
    self:updatePartyList()
  else
    return
  end
end
function HandleEventDragUp_RoseWarEditParty_DragToPartyData(partyDataIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil then
    return
  end
  if self:isDragging() == false then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  if 0 < self._memberList_selectInfo:length() then
    for cacheIndex = 1, #self._memberList_selectInfo do
      local cachedSelectedUserInfo = self._memberList_selectInfo[cacheIndex]
      if cachedSelectedUserInfo ~= nil then
        ToClient_RequestAddRoseWarPartyMember(partyDataWrapper:getPartyDataKey(), cachedSelectedUserInfo._userNo)
      end
    end
    self:clearSelectInfo()
    self:updateMemberList()
  elseif 0 < self._partyMemberList_selectInfo:length() then
    for cacheIndex = 1, #self._partyMemberList_selectInfo do
      local cachedSelectedUserInfo = self._partyMemberList_selectInfo[cacheIndex]
      if cachedSelectedUserInfo ~= nil and cachedSelectedUserInfo._partyDataIndex ~= partyDataIndex then
        ToClient_RequestAddRoseWarPartyMember(partyDataWrapper:getPartyDataKey(), cachedSelectedUserInfo._userNo)
      end
    end
    self:clearSelectInfo()
    self:updatePartyList()
  else
    return
  end
end
function HandleEventClicked_RoseWarEditParty_ToggleShowNameMode()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  self:updateMemberList()
  self:updatePartyList()
end
function HandleEventClick_RoseWarEditParty_AddSelectedMemberListData(s64_memberListKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or s64_memberListKey == nil then
    return
  end
  if self:isDragging() == true then
    HandleEventDragUp_RoseWarEditParty_DragToMemberList()
  else
    self:addMemberListSelectInfo(s64_memberListKey)
  end
end
function HandleEventClick_RoseWarEditParty_OpenRClickMenuByMember(s64_memberListKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or s64_memberListKey == nil then
    return
  end
  if self._isEditMode == false then
    return
  end
  self:openRClickMenuByMember(s64_memberListKey)
end
function HandleEventPressMove_RoseWarEditParty_StartDragFromMemberList(s64_memberListKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or s64_memberListKey == nil then
    return
  end
  self:startDragByMember(s64_memberListKey)
end
function HandleEventClick_RoseWarEditParty_AddSelectedPartyMemberListData(partyDataIndex, partyMemberIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  if self:isDragging() == true then
    HandleEventDragUp_RoseWarEditParty_DragToPartyData(partyDataIndex)
  else
    self:addPartyMemberListSelectInfo(partyDataIndex, partyMemberIndex)
  end
end
function HandleEventClick_RoseWarEditParty_OpenRClickMenuByPartyMember(partyDataIndex, partyMemberIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  if self._isEditMode == false then
    return
  end
  self:openRClickMenuByPartyMember(partyDataIndex, partyMemberIndex)
end
function HandleEventPressMove_RoseWarEditParty_StartDragFromPartyMemberList(partyDataIndex, partyMemberIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or partyDataIndex == nil or partyMemberIndex == nil then
    return
  end
  self:startDragByPartyMember(partyDataIndex, partyMemberIndex)
end
function HandleEventClicked_RoseWarEditParty_OnClickedRClickMenuButton(rClickMenuButtonIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or rClickMenuButtonIndex == nil then
    return
  end
  if self._rClickMenuButtonPool == nil then
    return
  end
  local rClickButtonData = self._rClickMenuButtonPool[rClickMenuButtonIndex]
  if rClickButtonData == nil then
    return
  end
  if rClickButtonData._isSet == false then
    return
  end
  if rClickButtonData._buttonType == self._eRClickButtonType.JOIN_PARTY then
    ToClient_RequestAddRoseWarPartyMember(rClickButtonData._partyDataKey, rClickButtonData._userNo)
  elseif rClickButtonData._buttonType == self._eRClickButtonType.SET_PARTY_LEADER then
    ToClient_SetRoseWarPartyLeader(rClickButtonData._partyDataKey, rClickButtonData._userNo)
  elseif rClickButtonData._buttonType == self._eRClickButtonType.SET_SUBCOMMANDER then
    ToClient_SetRoseWarSubCommander(true, rClickButtonData._userNo)
  elseif rClickButtonData._buttonType == self._eRClickButtonType.UNSET_SUBCOMMANDER then
    ToClient_SetRoseWarSubCommander(false, rClickButtonData._userNo)
  end
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
  end
end
function HandleEventClicked_RoseWarEditParty_ChangeTab(roseWarPartyType)
  local self = PaGlobal_RoseWarEditParty
  if self == nil or roseWarPartyType == nil then
    return
  end
  self:changeTab(roseWarPartyType)
end
function HandleEventClicked_RoseWarEditParty_AutoPlaceMentParty()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  ToClient_RequestAutoPlaceMentRoseWarParty(self._currentTab)
end
function HandleEventLUp_RoseWarEditParty_SortFilterComboBoxItem()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  local before = self._currentSortOption
  local after = self._ui._cbx_sortOption:GetSelectIndex()
  if before ~= after then
    self._currentSortOption = self._ui._cbx_sortOption:GetSelectIndex()
    ToClient_SortRoseWarMemberDataList(self._currentSortOption)
    self:clearSelectInfo()
    self:updateMemberList()
    self:updatePartyList()
  end
end
function HandleEventLUp_RoseWarEditParty_SortFilterComboBox()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  self._ui._cbx_sortOption:ToggleListbox()
  if self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui._cbx_sortOption)
  end
end
function HandleEventOnOut_RoseWarEditParty_ShowMemberPenaltyIconTooltip(isShow, index)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local key = toInt64(0, index)
  local content = self._ui._lst_memberList:GetContentByKey(key)
  if content == nil then
    return
  end
  local stc_memberInfo = UI.getChildControl(content, "Static_MemberInfo")
  local control = UI.getChildControl(stc_memberInfo, "Static_Penalty")
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_PENALTY_TOOLTIP")
  local desc = ""
  if control ~= nil then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOnOut_RoseWarEditParty_ShowMemberGradeTooltip(isShow, gradeType, index)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local key = toInt64(0, index)
  local content = self._ui._lst_memberList:GetContentByKey(key)
  if content == nil then
    return
  end
  local stc_memberInfo = UI.getChildControl(content, "Static_MemberInfo")
  local control = UI.getChildControl(stc_memberInfo, "Static_Duty")
  local name = ""
  local desc = ""
  if gradeType == __eRoseWarPlayerGradeType_Commander then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_COMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_SubCommander then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_SUBCOMMANDER")
  else
    return
  end
  if control ~= nil then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOnOut_RoseWarEditParty_ShowPartyMemberPenaltyIconTooltip(isShow, partyDataIndex, partyMemberIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local partyPoolData = self:getPartyPoolData(partyDataIndex)
  if partyPoolData == nil then
    return
  end
  local key = toInt64(partyDataIndex, partyMemberIndex)
  local content = partyPoolData._lst_partyMemberList:GetContentByKey(key)
  if content == nil then
    return
  end
  local stc_partyMember = UI.getChildControl(content, "Static_PartyMember")
  local control = UI.getChildControl(stc_partyMember, "Static_Penalty")
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_PENALTY_TOOLTIP")
  local desc = ""
  if control ~= nil then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOnOut_RoseWarEditParty_ShowPartyMemberGradeTooltip(isShow, gradeType, partyDataIndex, partyMemberIndex)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local partyPoolData = self:getPartyPoolData(partyDataIndex)
  if partyPoolData == nil then
    return
  end
  local key = toInt64(partyDataIndex, partyMemberIndex)
  local content = partyPoolData._lst_partyMemberList:GetContentByKey(key)
  if content == nil then
    return
  end
  local stc_partyMember = UI.getChildControl(content, "Static_PartyMember")
  local control = UI.getChildControl(stc_partyMember, "Static_Duty")
  local name = ""
  local desc = ""
  if gradeType == __eRoseWarPlayerGradeType_Commander then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_COMMANDER")
  elseif gradeType == __eRoseWarPlayerGradeType_SubCommander then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_SUBCOMMANDER")
  else
    return
  end
  if control ~= nil then
    TooltipSimple_Show(control, name, desc)
  end
end
function FromClient_RoseWarEditParty_ChangePartyName(partyDataKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  self:updatePartyUI_MemoControl(partyDataKey)
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  for memberIndex = 0, memberCount - 1 do
    local memberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(memberIndex)
    if memberDataWrapper ~= nil then
      local memberPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByUserNo(memberDataWrapper:getUserNo())
      if memberPartyDataWrapper ~= nil and memberPartyDataWrapper:getPartyDataKey() == partyDataKey then
        local memberContentKey = toInt64(0, memberIndex)
        local memberList2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
        if memberList2_content ~= nil then
          self:updateMemberListContent(memberList2_content, memberContentKey)
        end
      end
    end
  end
end
function FromClient_RoseWarEditParty_AddOrMovePartyMember(fromPartyDataKey, toPartyDataKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  if fromPartyDataKey ~= -1 then
    self:updatePartyInvitedMember(fromPartyDataKey, true)
  end
  if toPartyDataKey ~= -1 and fromPartyDataKey ~= toPartyDataKey then
    self:updatePartyInvitedMember(toPartyDataKey, true)
  end
  self:updateNotPlacementMemberCount()
end
function FromClient_RoseWarEditParty_RemovePartyMember(fromPartyDataKey, targetUserNo)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  if fromPartyDataKey ~= -1 then
    self:updatePartyInvitedMember(fromPartyDataKey, false)
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  for memberIndex = 0, memberCount - 1 do
    local memberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(memberIndex)
    if memberDataWrapper ~= nil and memberDataWrapper:getUserNo() == targetUserNo then
      local memberContentKey = toInt64(0, memberIndex)
      local memberList2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
      if memberList2_content ~= nil then
        self:updateMemberListContent(memberList2_content, memberContentKey)
      end
      break
    end
  end
  self:updateNotPlacementMemberCount()
end
function FromClient_RoseWarEditParty_UpdateRoseWarPartyInfo(partyDataKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  self:updatePartyInvitedMember(partyDataKey, true)
  self:updateNotPlacementMemberCount()
end
function FromClient_RoseWarEditParty_UpdateMemberLogOnOff(userNo)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for partyIndex = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyIndex)
    if partyDataWrapper ~= nil then
      local isPartyMember = false
      local partyMemberCount = partyDataWrapper:getInvitedMemberCount()
      for partyMemberIndex = 0, partyMemberCount - 1 do
        local partyMemberUserNo = partyDataWrapper:getInvitedMemberUserNo(partyMemberIndex)
        if partyMemberUserNo == userNo then
          isPartyMember = true
          break
        end
      end
      if isPartyMember == true then
        self:updatePartyInvitedMember(partyDataWrapper:getPartyDataKey(), true)
        break
      end
    end
  end
end
function FromClient_RoseWarEditParty_OnScreenResize()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  self:onScreenResize()
end
function FromClient_RoseWarEditParty_UpdatePartyProgressMission(partyDataKey)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  self:updatePartyUI_IsProgressMissionControl(partyDataKey)
end
function FromClient_RoseWarEditParty_UpdateMemberGradeType(memberUserNo)
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == false then
    return
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  for memberIndex = 0, memberCount - 1 do
    local memberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(memberIndex)
    if memberDataWrapper ~= nil and memberDataWrapper:getUserNo() == memberUserNo then
      local memberContentKey = toInt64(0, memberIndex)
      local list2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
      if list2_content ~= nil then
        self:updateMemberListContent(list2_content, memberContentKey)
      end
      break
    end
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByUserNo(memberUserNo)
  if partyDataWrapper ~= nil then
    local partyPoolData = self:getPartyPoolDataByKey(partyDataWrapper:getPartyDataKey())
    if partyPoolData ~= nil then
      local partyMemberCount = partyDataWrapper:getInvitedMemberCount()
      for index = 0, partyMemberCount - 1 do
        local partyMemberContentKey = toInt64(partyPoolData._partyDataIndex, index)
        local list2_content = partyPoolData._lst_partyMemberList:GetContentByKey(partyMemberContentKey)
        if list2_content ~= nil then
          self:updatePartyMemberListContent(list2_content, partyMemberContentKey)
        end
      end
    end
  end
end
function FromClient_AddRoseWarMemberDataList()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if self:isDragging() == false then
    self:clearDrag()
  end
  self:updatePartyList()
  self:updateMemberList()
  self:updateNotPlacementMemberCount()
end
function FromClient_EraseRoseWarMemberDataList()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if self:isDragging() == false then
    self:clearDrag()
  end
  self:updatePartyList()
  self:updateMemberList()
  self:updateNotPlacementMemberCount()
end
function FromClient_UpdateRoseWarMemberPenalty()
  local self = PaGlobal_RoseWarEditParty
  if self == nil then
    return
  end
  if self:isDragging() == false then
    self:clearDrag()
  end
  self:updatePartyList()
  self:updateMemberList()
  self:updateNotPlacementMemberCount()
end
