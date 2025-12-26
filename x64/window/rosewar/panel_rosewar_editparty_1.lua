function PaGlobal_RoseWarEditParty:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_tabArea = UI.getChildControl(Panel_RoseWar_EditParty, "Static_TabBar")
  self._ui._btn_toggleShowNameMode = UI.getChildControl(self._ui._stc_tabArea, "CheckButton_FamilyNameShow")
  self._ui._btn_guildTab = UI.getChildControl(self._ui._stc_tabArea, "Radiobutton_Guildmember")
  self._ui._stc_guildNotPlaceCount = UI.getChildControl(self._ui._btn_guildTab, "StaticText_NotPlaceCount")
  self._ui._btn_mercenaryTab = UI.getChildControl(self._ui._stc_tabArea, "Radiobutton_Othermember")
  self._ui._stc_mercenaryNotPlaceCount = UI.getChildControl(self._ui._btn_mercenaryTab, "StaticText_NotPlaceCount")
  self._ui._stc_tabLine = UI.getChildControl(self._ui._stc_tabArea, "Static_SelectBar")
  self._ui._stc_memberListBg = UI.getChildControl(Panel_RoseWar_EditParty, "Static_ListBG")
  self._ui._lst_memberList = UI.getChildControl(self._ui._stc_memberListBg, "List2_RoseWar_MemberList")
  self._ui._cbx_sortOption = UI.getChildControl(self._ui._stc_memberListBg, "Combobox2_1")
  self._ui._stc_sortOptionList = UI.getChildControl(self._ui._cbx_sortOption, "Combobox_1_List")
  self._ui._btn_autoPlacement = UI.getChildControl(self._ui._stc_memberListBg, "Button_Auto_Placement")
  self._ui._frm_partyList = UI.getChildControl(Panel_RoseWar_EditParty, "Frame_RoseWar_PartyList")
  self._ui._frmContent_partyList = UI.getChildControl(self._ui._frm_partyList, "Frame_1_Content")
  self._ui._stc_rclick_menu = UI.getChildControl(Panel_RoseWar_EditParty, "Static_RClick_Menu")
  self:makePartyDataPool(false)
  self:makeRClickMenuPool(false)
  self:initSortOption()
  self:initDragPanel()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarEditParty:initSortOption()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._ui._cbx_sortOption:GetListControl():AddSelectEvent("HandleEventLUp_RoseWarEditParty_SortFilterComboBoxItem()")
  self._ui._cbx_sortOption:DeleteAllItem(0)
  self._ui._cbx_sortOption:setListTextHorizonCenter()
  for index = 0, __eRoseWarMemberListSortType_Count - 1 do
    local buttonString
    if index == __eRoseWarMemberListSortType_NameAsc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_1_ASC")
    elseif index == __eRoseWarMemberListSortType_NameDes then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_1_DES")
    elseif index == __eRoseWarMemberListSortType_ClassAsc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_2_ASC")
    elseif index == __eRoseWarMemberListSortType_ClassDes then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_2_DES")
    elseif index == __eRoseWarMemberListSortType_PartyAsc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_3_ASC")
    elseif index == __eRoseWarMemberListSortType_PartyDes then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_3_DES")
    elseif index == __eRoseWarMemberListSortType_SolareAsc then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_5_ASC")
    elseif index == __eRoseWarMemberListSortType_SolareDes then
      buttonString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_SORT_TYPE_5_DES")
    else
      UI.ASSERT_NAME(false, "RoseWarMemberListSortType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\133\148\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    if buttonString ~= nil then
      self._ui._cbx_sortOption:AddItem(buttonString)
    end
  end
  self._ui._cbx_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarEditParty_SortFilterComboBox()")
  self._ui._cbx_sortOption:SetSelectItemIndex(self._currentSortOption)
end
function PaGlobal_RoseWarEditParty:registEventHandler()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._ui._btn_toggleShowNameMode:SetCheck(true)
  self._ui._btn_toggleShowNameMode:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_ToggleShowNameMode()")
  self._ui._btn_guildTab:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_ChangeTab(" .. tostring(__eRoseWarPartyType_Guild) .. ")")
  self._ui._btn_mercenaryTab:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_ChangeTab(" .. tostring(__eRoseWarPartyType_Mercenary) .. ")")
  self._ui._btn_autoPlacement:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_AutoPlaceMentParty()")
  self._ui._lst_memberList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RoseWarEditParty_OnCreateMemberContent")
  self._ui._lst_memberList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._lst_memberList:addInputEvent("Mouse_LUp", "HandleEventDragUp_RoseWarEditParty_DragToMemberList()")
  registerEvent("FromClient_UpdateRoseWarPartyName", "FromClient_RoseWarEditParty_ChangePartyName")
  registerEvent("FromClient_UpdateRoseWarPartyMemberByAdd", "FromClient_RoseWarEditParty_AddOrMovePartyMember")
  registerEvent("FromClient_UpdateRoseWarPartyMemberByRemove", "FromClient_RoseWarEditParty_RemovePartyMember")
  registerEvent("FromClient_UpdateRoseWarPartyInfo", "FromClient_RoseWarEditParty_UpdateRoseWarPartyInfo")
  registerEvent("FromClient_UpdateRoseWarMemberLogOnOff", "FromClient_RoseWarEditParty_UpdateMemberLogOnOff")
  registerEvent("onScreenResize", "FromClient_RoseWarEditParty_OnScreenResize")
  registerEvent("FromClient_ReceivedNewRoseWarMissionToCommander", "FromClient_RoseWarEditParty_UpdatePartyProgressMission")
  registerEvent("FromClient_CompleteRoseWarMissionToCommander", "FromClient_RoseWarEditParty_UpdatePartyProgressMission")
  registerEvent("FromClient_FailedRoseWarMissionToCommander", "FromClient_RoseWarEditParty_UpdatePartyProgressMission")
  registerEvent("FromClient_UpdateRoseWarMemberGradeType", "FromClient_RoseWarEditParty_UpdateMemberGradeType")
  registerEvent("FromClient_AddRoseWarMemberDataList", "FromClient_AddRoseWarMemberDataList")
  registerEvent("FromClient_EraseRoseWarMemberDataList", "FromClient_EraseRoseWarMemberDataList")
  registerEvent("FromClient_UpdateRoseWarMemberPenalty", "FromClient_UpdateRoseWarMemberPenalty")
end
function PaGlobal_RoseWarEditParty:validate()
  if Panel_RoseWar_EditParty == nil then
    return
  end
end
function PaGlobal_RoseWarEditParty:prepareOpen()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  self._isEditMode = IsSelfPlayerRoseWarGrade_Commander()
  self._ui._btn_autoPlacement:SetShow(self._isEditMode)
  self:onScreenResize()
  if self._currentTab == __eRoseWarPartyType_Count then
    self:changeTab(__eRoseWarPartyType_Guild)
  else
    self:updatePartyList()
  end
  self:updateMemberList()
  self:updateNotPlacementMemberCount()
  self:open()
end
function PaGlobal_RoseWarEditParty:open()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  Panel_RoseWar_EditParty:SetShow(true)
end
function PaGlobal_RoseWarEditParty:prepareClose()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  TooltipSimple_Hide()
  if self:isOpenRClickMenu() == true then
    self:closeRClickMenu()
    return
  end
  if self:isDragging() == true then
    self:clearDrag()
    return
  end
  if self._ui._stc_sortOptionList:GetShow() == true then
    self._ui._cbx_sortOption:ToggleListbox()
  end
  self:clearSelectInfo()
  self:clearMemberList()
  self:deactivateAllPartyData()
  self:close()
end
function PaGlobal_RoseWarEditParty:close()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  Panel_RoseWar_EditParty:SetShow(false)
end
function PaGlobal_RoseWarEditParty:onScreenResize()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local panelSizeX = getScreenSizeX()
  local panelSizeY = getScreenSizeY()
  Panel_RoseWar_EditParty:SetSize(panelSizeX, panelSizeY)
  Panel_RoseWar_EditParty:ComputePos()
  self._ui._stc_memberListBg:SetSize(self._ui._stc_memberListBg:GetSizeX(), panelSizeY)
  self._ui._stc_memberListBg:ComputePos()
  if self._ui._btn_autoPlacement:GetShow() == true then
    self._ui._lst_memberList:SetSize(self._ui._lst_memberList:GetSizeX(), panelSizeY - self._ui._lst_memberList:GetSpanSize().y - self._ui._btn_autoPlacement:GetSpanSize().y - self._ui._btn_autoPlacement:GetSizeY() - 10)
  else
    self._ui._lst_memberList:SetSize(self._ui._lst_memberList:GetSizeX(), panelSizeY - self._ui._lst_memberList:GetSpanSize().y - 10)
  end
  self._ui._lst_memberList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._lst_memberList:ComputePos()
  self._ui._btn_autoPlacement:ComputePos()
  local memberListVScroll = self._ui._lst_memberList:GetVScroll()
  if memberListVScroll ~= nil then
    memberListVScroll:SetSize(memberListVScroll:GetSizeX(), self._ui._lst_memberList:GetSizeY() - 10)
    memberListVScroll:SetShow(true)
    memberListVScroll:ComputePos()
  end
  self._ui._stc_tabArea:SetSize(panelSizeX - self._ui._stc_memberListBg:GetSizeX(), self._ui._stc_tabArea:GetSizeY())
  self._ui._stc_tabArea:ComputePosAllChild()
  self._ui._frm_partyList:SetSize(self._ui._stc_tabArea:GetSizeX(), panelSizeY - self._ui._stc_tabArea:GetSizeY())
  self._ui._frm_partyList:ComputePosAllChild()
  self._ui._frmContent_partyList:SetSize(self._ui._frm_partyList:GetSizeX(), self._ui._frmContent_partyList:GetSizeY())
  self._ui._frmContent_partyList:ComputePosAllChild()
end
function PaGlobal_RoseWarEditParty:changeTab(roseWarPartyType)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._currentTab == roseWarPartyType then
    return
  end
  if roseWarPartyType == __eRoseWarPartyType_Guild then
    self._ui._btn_guildTab:SetCheck(true)
    self._ui._btn_mercenaryTab:SetCheck(false)
    self._ui._stc_tabLine:SetSpanSize(self._ui._btn_guildTab:GetSpanSize().x, self._ui._stc_tabLine:GetSpanSize().y)
  elseif roseWarPartyType == __eRoseWarPartyType_Mercenary then
    self._ui._btn_guildTab:SetCheck(false)
    self._ui._btn_mercenaryTab:SetCheck(true)
    self._ui._stc_tabLine:SetSpanSize(self._ui._btn_mercenaryTab:GetSpanSize().x, self._ui._stc_tabLine:GetSpanSize().y)
  else
    return
  end
  ClearFocusEdit()
  self._currentTab = roseWarPartyType
  self:clearSelectInfo()
  self:updateMemberList()
  self:updatePartyList()
end
function PaGlobal_RoseWarEditParty:updateMemberList()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local currentIndex = math.floor(self._ui._lst_memberList:getCurrenttoIndex())
  self:clearMemberList()
  local listManager = self._ui._lst_memberList:getElementManager()
  if listManager == nil then
    return
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  for index = 0, memberCount - 1 do
    local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(index)
    if roseWarMemberDataWrapper ~= nil then
      local isPush = false
      local gradeType = roseWarMemberDataWrapper:getGradeType()
      if self._currentTab == __eRoseWarPartyType_Guild then
        if gradeType == __eRoseWarPlayerGradeType_Commander or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or gradeType == __eRoseWarPlayerGradeType_GuildMember then
          isPush = true
        end
      elseif self._currentTab == __eRoseWarPartyType_Mercenary and (gradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or gradeType == __eRoseWarPlayerGradeType_Mercenary) then
        isPush = true
      end
      if isPush == true then
        listManager:pushKey(toInt64(0, index))
      end
    end
  end
  self._ui._lst_memberList:moveIndex(currentIndex)
end
function PaGlobal_RoseWarEditParty:clearMemberList()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local listManager = self._ui._lst_memberList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
end
function PaGlobal_RoseWarEditParty:updateMemberListContent(content, key)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local index = Int64toInt32(key)
  local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(index)
  if roseWarMemberDataWrapper == nil then
    return
  end
  local memberUserNo = roseWarMemberDataWrapper:getUserNo()
  local memberPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByUserNo(memberUserNo)
  local stc_memberInfo = UI.getChildControl(content, "Static_MemberInfo")
  local stc_partyLeaderIcon = UI.getChildControl(stc_memberInfo, "Static_PartyLeader")
  local stc_logOnOffIcon = UI.getChildControl(stc_memberInfo, "Static_Ready")
  local stc_gradeIcon = UI.getChildControl(stc_memberInfo, "Static_Duty")
  local txt_memberInfo = UI.getChildControl(stc_memberInfo, "StaticText_Member")
  local txt_partyName = UI.getChildControl(stc_memberInfo, "StaticText_PartyName")
  local stc_classIconBG = UI.getChildControl(stc_memberInfo, "Static_ClassBG")
  local stc_classIcon = UI.getChildControl(stc_classIconBG, "Static_ClassIcon")
  local stc_penaltyIcon = UI.getChildControl(stc_memberInfo, "Static_Penalty")
  local isAppliedPenaltyUser = roseWarMemberDataWrapper:isAppliedPenalty()
  if isAppliedPenaltyUser == true then
    stc_penaltyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowMemberPenaltyIconTooltip(true, " .. tostring(index) .. ")")
    stc_penaltyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowMemberPenaltyIconTooltip(false, nil)")
    stc_penaltyIcon:SetShow(true)
  else
    stc_penaltyIcon:removeInputEvent("Mouse_On", "")
    stc_penaltyIcon:removeInputEvent("Mouse_Out", "")
    stc_penaltyIcon:SetShow(false)
  end
  local isLogOn = roseWarMemberDataWrapper:isLogOn()
  if isLogOn == true then
    stc_logOnOffIcon:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_Server_Mini_On_Green")
    stc_logOnOffIcon:setRenderTexture(stc_logOnOffIcon:getBaseTexture())
  else
    stc_logOnOffIcon:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_Server_Mini_Off")
    stc_logOnOffIcon:setRenderTexture(stc_logOnOffIcon:getBaseTexture())
  end
  if memberGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or memberPartyDataWrapper ~= nil and memberPartyDataWrapper:getPartyLeaderUserNo() == memberUserNo then
    stc_partyLeaderIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_1")
    stc_partyLeaderIcon:setRenderTexture(stc_partyLeaderIcon:getBaseTexture())
    stc_partyLeaderIcon:SetShow(true)
  else
    stc_partyLeaderIcon:SetShow(false)
  end
  local memberGradeType = roseWarMemberDataWrapper:getGradeType()
  if memberGradeType == __eRoseWarPlayerGradeType_Commander then
    stc_gradeIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_3")
    stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowMemberGradeTooltip(true, " .. tostring(__eRoseWarPlayerGradeType_Commander) .. "," .. tostring(index) .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowMemberGradeTooltip(false, nil, nil)")
    stc_gradeIcon:SetShow(true)
  elseif memberGradeType == __eRoseWarPlayerGradeType_SubCommander then
    stc_gradeIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_4")
    stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowMemberGradeTooltip(true, " .. tostring(__eRoseWarPlayerGradeType_SubCommander) .. "," .. tostring(index) .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowMemberGradeTooltip(false, nil, nil)")
    stc_gradeIcon:SetShow(true)
  else
    stc_gradeIcon:removeInputEvent("Mouse_On")
    stc_gradeIcon:removeInputEvent("Mouse_Out")
    stc_gradeIcon:SetShow(false)
  end
  if self._currentSortOption == __eRoseWarMemberListSortType_SolareAsc or self._currentSortOption == __eRoseWarMemberListSortType_SolareDes then
    if PaGlobalFunc_Solrare_Ranking_SetTierIconByScore == nil then
      stc_classIcon:SetShow(false)
    else
      PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(stc_classIcon, roseWarMemberDataWrapper:getSolareRankRating())
      stc_classIcon:SetShow(true)
    end
  elseif PaGlobalFunc_Util_SetFriendClassTypeIcon == nil then
    stc_classIcon:SetShow(false)
  else
    PaGlobalFunc_Util_SetFriendClassTypeIcon(stc_classIcon, roseWarMemberDataWrapper:getClassTypeRaw())
    stc_classIcon:SetShow(true)
  end
  stc_memberInfo:SetEnableDragAndDrop(true)
  stc_memberInfo:addInputEvent("Mouse_LUp", "HandleEventClick_RoseWarEditParty_AddSelectedMemberListData(" .. tostring(key) .. ")")
  if self._isEditMode == true then
    stc_memberInfo:addInputEvent("Mouse_RUp", "HandleEventClick_RoseWarEditParty_OpenRClickMenuByMember(" .. tostring(key) .. ")")
    stc_memberInfo:addInputEvent("Mouse_PressMove", "HandleEventPressMove_RoseWarEditParty_StartDragFromMemberList(" .. tostring(key) .. ")")
  end
  local userName = ""
  if self._ui._btn_toggleShowNameMode:IsCheck() == true then
    userName = roseWarMemberDataWrapper:getUserNickName()
  else
    userName = roseWarMemberDataWrapper:getCharacterName()
  end
  if stc_gradeIcon:GetShow() == true then
    txt_memberInfo:SetSpanSize(stc_gradeIcon:GetSpanSize().x + stc_gradeIcon:GetSizeX(), txt_memberInfo:GetSpanSize().y)
  else
    txt_memberInfo:SetSpanSize(stc_gradeIcon:GetSpanSize().x, txt_memberInfo:GetSpanSize().y)
  end
  if memberUserNo == getSelfPlayer():get():getUserNo() then
    txt_memberInfo:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    txt_memberInfo:SetFontColor(Defines.Color.C_FFD8AD70)
  end
  txt_memberInfo:SetText(userName)
  txt_memberInfo:ComputePos()
  if stc_partyLeaderIcon:GetShow() == true then
    txt_partyName:SetSpanSize(stc_partyLeaderIcon:GetSpanSize().x + stc_partyLeaderIcon:GetSizeX(), txt_partyName:GetSpanSize().y)
  else
    txt_partyName:SetSpanSize(stc_partyLeaderIcon:GetSpanSize().x, txt_partyName:GetSpanSize().y)
  end
  if memberGradeType == __eRoseWarPlayerGradeType_Commander then
    txt_partyName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_COMMANDER"))
  elseif memberPartyDataWrapper == nil then
    txt_partyName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LIST_NOPLACEMENT"))
  else
    local partyMemo = memberPartyDataWrapper:getPartyMemo()
    if partyMemo == nil or partyMemo == "" then
      partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", memberPartyDataWrapper:getPartyIndex() + 1)
    end
    txt_partyName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LIST_PARTYNAME", "PARTYNAME", partyMemo))
  end
  txt_partyName:ComputePos()
  local isSelectedContent = false
  if self._memberList_selectInfo ~= nil then
    for selectIndex = 1, #self._memberList_selectInfo do
      local value = self._memberList_selectInfo[selectIndex]
      if value ~= nil and value._dataIndex == index then
        isSelectedContent = true
        break
      end
    end
  end
  if isSelectedContent == true then
    stc_memberInfo:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_L_Btn_List_Click")
    stc_memberInfo:setRenderTexture(stc_memberInfo:getBaseTexture())
  else
    stc_memberInfo:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_L_Btn_List_Normal")
    stc_memberInfo:setRenderTexture(stc_memberInfo:getBaseTexture())
  end
end
function PaGlobal_RoseWarEditParty:makePartyDataPool(isExepand)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if isExepand == false and self._partyDataPool ~= nil then
    UI.ASSERT_NAME(false, "\236\157\180\235\175\184 \236\131\157\236\132\177\235\144\156 \236\158\144\236\155\144\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  if isExepand == false then
    self._partyDataPool = {}
  end
  local partyControl_Template = UI.getChildControl(self._ui._frmContent_partyList, "Static_RoseWar_PartyTemplate")
  local totalIndex = 0
  local beginIndex = 0
  local count = self._partyDataPoolCount - 1
  if isExepand == true then
    totalIndex = self._partyDataPoolCount
    beginIndex = self._partyDataPoolCount
    self._partyDataPoolCount = self._partyDataPoolCount + 1
    count = self._partyDataPoolCount - 1
  end
  for index = beginIndex, count do
    local controlId = "Static_RoseWar_Party_" .. tostring(totalIndex)
    local newControl = UI.cloneControl(partyControl_Template, self._ui._frmContent_partyList, controlId)
    if newControl == nil then
      UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\182\128\235\140\128 \237\142\184\236\132\177 UI \237\140\140\237\139\176 \237\146\128 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    newControl:SetShow(false)
    newControl:SetIgnore(false)
    local partyPoolData = {
      _control = newControl,
      _btn_editName = nil,
      _edt_name = nil,
      _txt_partyCount = nil,
      _lst_partyMemberList = nil,
      _stc_emptyMessage = nil,
      _stc_isProgressMission = nil,
      _partyDataIndex = nil,
      _isSet = false
    }
    local stc_listBG = UI.getChildControl(newControl, "Static_ListBG2")
    local stc_top = UI.getChildControl(newControl, "Static_TopArea")
    partyPoolData._btn_editName = UI.getChildControl(stc_top, "Button_Edit")
    partyPoolData._edt_name = UI.getChildControl(stc_top, "Edit_PartyMemo")
    partyPoolData._txt_partyCount = UI.getChildControl(stc_top, "StaticText_PartyCount")
    partyPoolData._lst_partyMemberList = UI.getChildControl(newControl, "List2_RoseWar_PartyMemberList")
    partyPoolData._stc_emptyMessage = UI.getChildControl(newControl, "StaticText_Party_Empty")
    partyPoolData._stc_isProgressMission = UI.getChildControl(newControl, "StaticText_Mission_Ing")
    partyPoolData._edt_name:SetMaxInput(12)
    partyPoolData._lst_partyMemberList:createChildContent(__ePAUIList2ElementManagerType_List)
    self._partyDataPool[index] = partyPoolData
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_RoseWarEditParty:updatePartyList()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._currentTab ~= __eRoseWarPartyType_Guild and self._currentTab ~= __eRoseWarPartyType_Mercenary then
    return
  end
  self:deactivateAllPartyData()
  local partyCount = ToClient_GetRoseWarPartyDataCount()
  for index = 0, partyCount - 1 do
    local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(index)
    if partyDataWrapper ~= nil and self._currentTab == partyDataWrapper:getPartyType() then
      self:activatePartyDataByPool(index)
      local partyDataKey = partyDataWrapper:getPartyDataKey()
      self:updatePartyUI_MemoControl(partyDataKey)
      self:updatePartyUI_MemberCountControl(partyDataKey)
      self:updatePartyUI_IsProgressMissionControl(partyDataKey)
      self:updatePartyUI_JoinButton(partyDataKey)
    end
  end
  self:updatePartyControlPosition()
end
function PaGlobal_RoseWarEditParty:deactivateAllPartyData()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._partyDataPool == nil then
    return
  end
  for index = 0, self._partyDataPoolCount - 1 do
    local partyPoolData = self._partyDataPool[index]
    if partyPoolData ~= nil and partyPoolData._isSet == true then
      partyPoolData._btn_editName:removeInputEvent("Mouse_LUp")
      partyPoolData._control:SetShow(false)
      partyPoolData._partyDataIndex = nil
      partyPoolData._isSet = false
    end
  end
end
function PaGlobal_RoseWarEditParty:activatePartyDataByPool(partyDataIndex)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._partyDataPool == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local isSuccess = false
  for index = 0, self._partyDataPoolCount - 1 do
    local partyPoolData = self._partyDataPool[index]
    if partyPoolData ~= nil and partyPoolData._isSet == false then
      if self._isEditMode == true then
        partyPoolData._btn_editName:addInputEvent("Mouse_LUp", "HandleEventClicked_RoseWarEditParty_FocusEditPartyName(" .. tostring(partyDataIndex) .. ")")
        partyPoolData._edt_name:RegistReturnKeyEvent("PaGlobalFunc_RoseWarEditParty_SetPartyName(" .. tostring(partyDataIndex) .. ")")
        partyPoolData._btn_editName:SetShow(true)
      else
        partyPoolData._btn_editName:SetShow(false)
      end
      partyPoolData._lst_partyMemberList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RoseWarEditParty_OnCreatePartyMemberContent")
      partyPoolData._lst_partyMemberList:addInputEvent("Mouse_LUp", "HandleEventDragUp_RoseWarEditParty_DragToPartyData(" .. tostring(partyDataIndex) .. ")")
      partyPoolData._stc_emptyMessage:addInputEvent("Mouse_LUp", "HandleEventDragUp_RoseWarEditParty_DragToPartyData(" .. tostring(partyDataIndex) .. ")")
      local listManager = partyPoolData._lst_partyMemberList:getElementManager()
      if listManager == nil then
        return
      end
      listManager:clearKey()
      local partyMemberCount = partyDataWrapper:getInvitedMemberCount()
      for index = 0, partyMemberCount - 1 do
        listManager:pushKey(toInt64(partyDataIndex, index))
      end
      partyPoolData._control:SetShow(true)
      partyPoolData._partyDataIndex = partyDataIndex
      partyPoolData._isSet = true
      isSuccess = true
      break
    end
  end
  if isSuccess == false then
    self:makePartyDataPool(true)
    self:activatePartyDataByPool(partyDataIndex)
  end
end
function PaGlobal_RoseWarEditParty:updatePartyMemberListContent(content, key)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyDataIndex = highFromUint64(key)
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local partyMemberIndex = lowFromUint64(key)
  local partyMemberUserNo_s64 = partyDataWrapper:getInvitedMemberUserNo(partyMemberIndex)
  local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapperByUserNo(partyMemberUserNo_s64)
  if roseWarMemberDataWrapper == nil then
    return
  end
  local partyLeaderUserNo_s64 = partyDataWrapper:getPartyLeaderUserNo()
  local stc_partyMember = UI.getChildControl(content, "Static_PartyMember")
  local stc_partyLeaderIcon = UI.getChildControl(stc_partyMember, "Static_PartyLeader")
  local stc_logOnOffIcon = UI.getChildControl(stc_partyMember, "Static_Ready")
  local stc_gradeIcon = UI.getChildControl(stc_partyMember, "Static_Duty")
  local txt_partyMember = UI.getChildControl(stc_partyMember, "StaticText_PartyMember")
  local stc_classIconBG = UI.getChildControl(stc_partyMember, "Static_ClassBG")
  local stc_classIcon = UI.getChildControl(stc_classIconBG, "Static_ClassIcon")
  local stc_penaltyIcon = UI.getChildControl(stc_partyMember, "Static_Penalty")
  local isAppliedPenaltyUser = roseWarMemberDataWrapper:isAppliedPenalty()
  if isAppliedPenaltyUser == true then
    stc_penaltyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberPenaltyIconTooltip(true, " .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
    stc_penaltyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberPenaltyIconTooltip(false, nil, nil)")
    stc_penaltyIcon:SetShow(true)
  else
    stc_penaltyIcon:removeInputEvent("Mouse_On", "")
    stc_penaltyIcon:removeInputEvent("Mouse_Out", "")
    stc_penaltyIcon:SetShow(false)
  end
  local isLogOn = roseWarMemberDataWrapper:isLogOn()
  if isLogOn == true then
    stc_logOnOffIcon:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_Server_Mini_On_Green")
    stc_logOnOffIcon:setRenderTexture(stc_logOnOffIcon:getBaseTexture())
  else
    stc_logOnOffIcon:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_Server_Mini_Off")
    stc_logOnOffIcon:setRenderTexture(stc_logOnOffIcon:getBaseTexture())
  end
  if memberGradeType == __eRoseWarPlayerGradeType_GuildPartyLeader or memberGradeType == __eRoseWarPlayerGradeType_MercenaryPartyLeader or partyLeaderUserNo_s64 == partyMemberUserNo_s64 then
    stc_partyLeaderIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_1")
    stc_partyLeaderIcon:setRenderTexture(stc_partyLeaderIcon:getBaseTexture())
    stc_partyLeaderIcon:SetShow(true)
  else
    stc_partyLeaderIcon:SetShow(false)
  end
  local memberGradeType = roseWarMemberDataWrapper:getGradeType()
  if memberGradeType == __eRoseWarPlayerGradeType_Commander then
    stc_gradeIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_3")
    stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberGradeTooltip(true, " .. tostring(__eRoseWarPlayerGradeType_Commander) .. "," .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberGradeTooltip(false, nil, nil)")
    stc_gradeIcon:SetShow(true)
  elseif memberGradeType == __eRoseWarPlayerGradeType_SubCommander then
    stc_gradeIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_UnitDeployment_Icon_Commander_4")
    stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberGradeTooltip(true, " .. tostring(__eRoseWarPlayerGradeType_SubCommander) .. "," .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_RoseWarEditParty_ShowPartyMemberGradeTooltip(false, nil, nil)")
    stc_gradeIcon:SetShow(true)
  else
    stc_gradeIcon:removeInputEvent("Mouse_On")
    stc_gradeIcon:removeInputEvent("Mouse_Out")
    stc_gradeIcon:SetShow(false)
  end
  if self._currentSortOption == __eRoseWarMemberListSortType_SolareAsc or self._currentSortOption == __eRoseWarMemberListSortType_SolareDes then
    if PaGlobalFunc_Solrare_Ranking_SetTierIconByScore == nil then
      stc_classIcon:SetShow(false)
    else
      PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(stc_classIcon, roseWarMemberDataWrapper:getSolareRankRating())
      stc_classIcon:SetShow(true)
    end
  elseif PaGlobalFunc_Util_SetFriendClassTypeIcon == nil then
    stc_classIcon:SetShow(false)
  else
    PaGlobalFunc_Util_SetFriendClassTypeIcon(stc_classIcon, roseWarMemberDataWrapper:getClassTypeRaw())
    stc_classIcon:SetShow(true)
  end
  local userName = ""
  if self._ui._btn_toggleShowNameMode:IsCheck() == true then
    userName = roseWarMemberDataWrapper:getUserNickName()
  else
    userName = roseWarMemberDataWrapper:getCharacterName()
  end
  if stc_partyLeaderIcon:GetShow() == true then
    txt_partyMember:SetSpanSize(stc_partyLeaderIcon:GetSpanSize().x + stc_partyLeaderIcon:GetSizeX(), txt_partyMember:GetSpanSize().y)
  else
    txt_partyMember:SetSpanSize(stc_partyLeaderIcon:GetSpanSize().x, txt_partyMember:GetSpanSize().y)
  end
  if partyMemberUserNo_s64 == getSelfPlayer():get():getUserNo() then
    txt_partyMember:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    txt_partyMember:SetFontColor(Defines.Color.C_FFD8AD70)
  end
  txt_partyMember:SetText(userName)
  txt_partyMember:ComputePos()
  stc_partyMember:SetEnableDragAndDrop(true)
  stc_partyMember:addInputEvent("Mouse_LUp", "HandleEventClick_RoseWarEditParty_AddSelectedPartyMemberListData(" .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
  if self._isEditMode == true then
    stc_partyMember:addInputEvent("Mouse_RUp", "HandleEventClick_RoseWarEditParty_OpenRClickMenuByPartyMember(" .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
    stc_partyMember:addInputEvent("Mouse_PressMove", "HandleEventPressMove_RoseWarEditParty_StartDragFromPartyMemberList(" .. tostring(partyDataIndex) .. "," .. tostring(partyMemberIndex) .. ")")
  end
  local isSelectedContent = false
  if self._partyMemberList_selectInfo ~= nil then
    for selectIndex = 1, #self._partyMemberList_selectInfo do
      local value = self._partyMemberList_selectInfo[selectIndex]
      if value ~= nil and value._partyDataIndex == partyDataIndex and value._partyMemberIndex == partyMemberIndex then
        isSelectedContent = true
        break
      end
    end
  end
  if isSelectedContent == true then
    stc_partyMember:ChangeTextureInfoTextureIDAsync("Combine_Frame_GradationSlot_OverClick")
    stc_partyMember:setRenderTexture(stc_partyMember:getBaseTexture())
  else
    stc_partyMember:ChangeTextureInfoTextureIDAsync("Combine_Frame_GradationSlot_Normal")
    stc_partyMember:setRenderTexture(stc_partyMember:getBaseTexture())
  end
end
function PaGlobal_RoseWarEditParty:updatePartyControlPosition()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  if self._partyDataPool == nil then
    return
  end
  local partyControl_Template = UI.getChildControl(self._ui._frmContent_partyList, "Static_RoseWar_PartyTemplate")
  if partyControl_Template == nil then
    return
  end
  local spanX = 10
  local spanY = 10
  local termX = 10
  local termY = 10
  local rowIndex = 0
  local colIndex = 0
  local templateSizeX = partyControl_Template:GetSizeX() + termX
  local templateSizeY = partyControl_Template:GetSizeY() + termY
  local rowMaxCount = math.floor(self._ui._frmContent_partyList:GetSizeX() / templateSizeX)
  for index = 0, self._partyDataPoolCount - 1 do
    local partyPoolData = self._partyDataPool[index]
    if partyPoolData ~= nil and partyPoolData._isSet == true then
      spanX = termX * (rowIndex + 1) + partyPoolData._control:GetSizeX() * rowIndex
      spanY = termY * (colIndex + 1) + partyPoolData._control:GetSizeY() * colIndex
      rowIndex = rowIndex + 1
      partyPoolData._control:SetSpanSize(spanX, spanY)
      partyPoolData._control:ComputePos()
      if rowMaxCount <= rowIndex then
        rowIndex = 0
        colIndex = colIndex + 1
      end
    end
  end
  self._ui._frmContent_partyList:SetSize(self._ui._frmContent_partyList:GetSizeX(), spanY + templateSizeY + termY)
  local frameVScroll = self._ui._frm_partyList:GetVScroll()
  frameVScroll:SetControlPos(0)
  self._ui._frm_partyList:UpdateContentPos()
  if self._ui._frm_partyList:GetSizeY() < self._ui._frmContent_partyList:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_RoseWarEditParty:getPartyPoolData(partyDataIndex)
  if Panel_RoseWar_EditParty == nil then
    return nil
  end
  for index = 0, self._partyDataPoolCount - 1 do
    local partyPoolData = self._partyDataPool[index]
    if partyPoolData ~= nil and partyPoolData._isSet == true and partyPoolData._partyDataIndex == partyDataIndex then
      return partyPoolData
    end
  end
  return nil
end
function PaGlobal_RoseWarEditParty:getPartyPoolDataByKey(partyDataKey)
  if Panel_RoseWar_EditParty == nil then
    return nil
  end
  if self._partyDataPool == nil then
    return nil
  end
  for index = 0, self._partyDataPoolCount - 1 do
    local partyPoolData = self._partyDataPool[index]
    if partyPoolData ~= nil and partyPoolData._isSet == true then
      local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
      if partyDataWrapper ~= nil and partyDataWrapper:getPartyDataKey() == partyDataKey then
        return partyPoolData
      end
    end
  end
  return nil
end
function PaGlobal_RoseWarEditParty:updatePartyInvitedMember(partyDataKey, doUpdateMemberList)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
  if partyPoolData == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local listManager = partyPoolData._lst_partyMemberList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local partyMemberCount = partyDataWrapper:getInvitedMemberCount()
  for index = 0, partyMemberCount - 1 do
    local partyMemberUserNo = partyDataWrapper:getInvitedMemberUserNo(index)
    if doUpdateMemberList ~= nil and doUpdateMemberList == true then
      local memberCount = ToClient_GetRoseWarMemberDataCount()
      for memberIndex = 0, memberCount - 1 do
        local memberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(memberIndex)
        if memberDataWrapper ~= nil and memberDataWrapper:getUserNo() == partyMemberUserNo then
          local memberContentKey = toInt64(0, memberIndex)
          local memberList2_content = self._ui._lst_memberList:GetContentByKey(memberContentKey)
          if memberList2_content ~= nil then
            self:updateMemberListContent(memberList2_content, memberContentKey)
          end
          break
        end
      end
    end
    listManager:pushKey(toInt64(partyPoolData._partyDataIndex, index))
  end
  self:updatePartyUI_MemberCountControl(partyDataKey)
  self:updatePartyUI_JoinButton(partyDataKey)
end
function PaGlobal_RoseWarEditParty:updatePartyUI_MemoControl(partyDataKey)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
  if partyPoolData == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local partyMemo = partyDataWrapper:getPartyMemo()
  if partyMemo == nil or partyMemo == "" then
    partyMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NAME", "num", partyDataWrapper:getPartyIndex() + 1)
  end
  partyPoolData._edt_name:SetEditText(partyMemo)
end
function PaGlobal_RoseWarEditParty:updatePartyUI_MemberCountControl(partyDataKey)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
  if partyPoolData == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local currentPartyMemberCount = partyDataWrapper:getInvitedMemberCount()
  local maxPartyMemberCount = partyDataWrapper:getMemberListMaxCount()
  partyPoolData._stc_emptyMessage:SetShow(currentPartyMemberCount == 0)
  partyPoolData._txt_partyCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_COUNT", "current", currentPartyMemberCount, "max", maxPartyMemberCount))
end
function PaGlobal_RoseWarEditParty:updatePartyUI_IsProgressMissionControl(partyDataKey)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
  if partyPoolData == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  partyPoolData._stc_isProgressMission:SetShow(partyDataWrapper:isProgressMission() == true)
end
function PaGlobal_RoseWarEditParty:updatePartyUI_JoinButton(partyDataKey)
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local partyPoolData = self:getPartyPoolDataByKey(partyDataKey)
  if partyPoolData == nil then
    return
  end
  local partyDataWrapper = ToClient_GetRoseWarPartyDataWrapper(partyPoolData._partyDataIndex)
  if partyDataWrapper == nil then
    return
  end
  local isJoinAble = false
  local selfPlayerMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapperBySelfPlayer()
  if selfPlayerMemberDataWrapper ~= nil then
    local selfPlayerUserNo = selfPlayerMemberDataWrapper:getUserNo()
    local selfPlayerPartyDataWrapper = ToClient_GetRoseWarPartyDataWrapperByUserNo(selfPlayerUserNo)
    if selfPlayerPartyDataWrapper == nil then
      isJoinAble = true
    elseif selfPlayerPartyDataWrapper:getPartyDataKey() == partyDataKey then
      isJoinAble = false
    else
      isJoinAble = true
    end
  end
end
function PaGlobal_RoseWarEditParty:updateNotPlacementMemberCount()
  if Panel_RoseWar_EditParty == nil then
    return
  end
  local notPlacementCount_Guild = ToClient_GetNotPlacementRoseWarMemberCount(__eRoseWarPartyType_Guild)
  local notPlacementCount_Mercenary = ToClient_GetNotPlacementRoseWarMemberCount(__eRoseWarPartyType_Mercenary)
  if notPlacementCount_Guild == 0 then
    self._ui._btn_guildTab:SetTextSpan(0, 18)
    self._ui._stc_guildNotPlaceCount:SetShow(false)
  else
    self._ui._btn_guildTab:SetTextSpan(0, 10)
    self._ui._stc_guildNotPlaceCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NOTPLACE_MEMCOUNT", "num", notPlacementCount_Guild))
    self._ui._stc_guildNotPlaceCount:SetShow(true)
  end
  if notPlacementCount_Mercenary == 0 then
    self._ui._btn_mercenaryTab:SetTextSpan(0, 18)
    self._ui._stc_mercenaryNotPlaceCount:SetShow(false)
  else
    self._ui._btn_mercenaryTab:SetTextSpan(0, 10)
    self._ui._stc_mercenaryNotPlaceCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_NOTPLACE_MEMCOUNT", "num", notPlacementCount_Mercenary))
    self._ui._stc_mercenaryNotPlaceCount:SetShow(true)
  end
end
