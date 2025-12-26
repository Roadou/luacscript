function PaGlobal_Party_All:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:ControlAll_Init()
  self:ControlPc_Init()
  self:createControl()
  self._isMainChannel = getCurrentChannelServerData()._isMain
  self._isDevServer = ToClient_IsDevelopment()
  self:setPositionByServer()
  self:registEventHandler()
  self:validate()
  self:hidePanelConditionCheck()
  self._ui_pc.btn_buttonBanner:SetShow(false)
  self._initialize = true
end
function PaGlobal_Party_All:hidePanelConditionCheck()
  if nil == Panel_Widget_Party_All then
    _PA_ASSERT_NAME(false, "Panel_Widget_Party_All\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\236\132\156\234\184\176\236\155\144")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_Widget_Party_All:SetRenderAndEventHide(true)
  else
    Panel_Widget_Party_All:SetRenderAndEventHide(false)
  end
end
function PaGlobal_Party_All:ControlAll_Init()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:ActiveMouseEventEffect(true)
  PaGlobal_Party_All:setPositionByServer()
  self._ui.stc_memberTemplate = UI.getChildControl(Panel_Widget_Party_All, "Static_PartyMember_Template")
  self._ui.stc_memberTemplate_Mini = UI.getChildControl(Panel_Widget_Party_All, "Static_PartyMember_Template_Mini")
  self._ui.stc_memberBG = UI.getChildControl(Panel_Widget_Party_All, "Static_MemberBG")
  self._ui.stc_memberBG_mini = UI.getChildControl(Panel_Widget_Party_All, "Static_MemberBG_Mini")
  self._ui.stc_Matching = UI.getChildControl(Panel_Widget_Party_All, "Static_Matching")
  self._ui.stc_MatchingMini = UI.getChildControl(Panel_Widget_Party_All, "Static_Matching_Mini")
  self._ui.btn_memberBG = UI.getChildControl(self._ui.stc_Matching, "Button_MatchCancel")
  self._ui.btn_memberBG_mini = UI.getChildControl(self._ui.stc_MatchingMini, "Button_MatchCancel")
  self._ui.stc_morningBossAttributeBg = UI.getChildControl(Panel_Widget_Party_All, "Static_MorningBossBg")
  self._ui.stc_attributeList[1] = UI.getChildControl(self._ui.stc_morningBossAttributeBg, "Static_Pattern_1")
  self._ui.stc_attributeList[2] = UI.getChildControl(self._ui.stc_morningBossAttributeBg, "Static_Pattern_2")
  self._ui.stc_attributeList[3] = UI.getChildControl(self._ui.stc_morningBossAttributeBg, "Static_Pattern_3")
  self._ui.stc_attributeList[4] = UI.getChildControl(self._ui.stc_morningBossAttributeBg, "Static_Pattern_4")
  self._ui.stc_attributeList[5] = UI.getChildControl(self._ui.stc_morningBossAttributeBg, "Static_Pattern_5")
end
function PaGlobal_Party_All:ControlPc_Init()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui_pc.stc_OptionBg = UI.getChildControl(Panel_Widget_Party_All, "Static_OptionBg")
  self._ui_pc.btn_specialItem = UI.getChildControl(self._ui_pc.stc_OptionBg, "Button_SpecialItem")
  self._ui_pc.btn_marketOption = UI.getChildControl(self._ui_pc.stc_OptionBg, "Button_MarketOption")
  self._ui_pc.chk_dropItem = UI.getChildControl(self._ui_pc.stc_OptionBg, "CheckButton_DropItem")
  self._ui_pc.btn_changeType = UI.getChildControl(self._ui_pc.stc_OptionBg, "Button_ChangeType")
  self._ui_pc.btn_buttonBanner = UI.getChildControl(Panel_Widget_Party_All, "Button_Banner")
  self._ui_pc.stc_buttonBG = UI.getChildControl(self._ui_pc.stc_OptionBg, "Static_Button_BG")
  self._ui_pc.chk_dragToggle = UI.getChildControl(self._ui_pc.stc_buttonBG, "CheckButton_DragToggle")
  self._ui_pc.stc_dropSetBg = UI.getChildControl(self._ui_pc.stc_OptionBg, "Static_StettingBG")
  self._ui_pc.radio_free = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Free")
  self._ui_pc.radio_turn = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Turn")
  self._ui_pc.radio_rando = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Random")
  self._ui_pc.radio_free:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_turn:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_rando:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_free:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_FREE"))
  self._ui_pc.radio_turn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TURN"))
  self._ui_pc.radio_rando:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_RANDOM"))
  self._ui_pc.stc_marketOptionBg = UI.getChildControl(Panel_Widget_Party_All, "Static_MarketOptionBg")
  self._ui_pc.stc_mainBg = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Static_MainBG")
  self._ui_pc.btn_apply = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Admin")
  self._ui_pc.stc_valuePack_enable = UI.getChildControl(self._ui_pc.stc_OptionBg, "Static_ValuePack_Enable")
  self._ui_pc.stc_valuePack_disable = UI.getChildControl(self._ui_pc.stc_OptionBg, "Static_ValuePack_disable")
  self._ui_pc.txt_marketOptionTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title")
  self._ui_pc.btn_close = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Close")
  self._ui_pc.txt_minCostTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title_MinCost")
  self._ui_pc.txt_minCostValue = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Value_MinCost")
  self._ui_pc.txt_minGradeTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title_Grade")
  self._ui_pc.txt_minGradeValue = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Value_Grade")
  self._ui_pc.btn_minCost = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_MinCost")
  self._ui_pc.btn_Grade = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Grade")
  self._ui_pc.chk_minCost = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "CheckButton_MinCost")
  self._ui_pc.chk_grade = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "CheckButton_Grade")
  self._ui_pc.stc_gradeOptionBg = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Static_StettingBG")
  self._ui_pc.btn_grades[0] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_NoSet")
  self._ui_pc.btn_grades[1] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Green")
  self._ui_pc.btn_grades[2] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Blue")
  self._ui_pc.btn_grades[3] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Yellow")
  self._ui_pc.btn_grades[4] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Orenge")
  UI.setLimitTextAndAddTooltip(self._ui_pc.txt_minCostTitle)
  UI.setLimitTextAndAddTooltip(self._ui_pc.txt_minGradeTitle)
  self._ui_pc.stc_optionBG_Mini = UI.getChildControl(Panel_Widget_Party_All, "Static_OptionBg_Mini")
  self._ui_pc.btn_specialItem_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Button_SpecialItem")
  self._ui_pc.btn_marketOption_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Button_MarketOption")
  self._ui_pc.chk_dropItem_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "CheckButton_DropItem")
  self._ui_pc.btn_changeType_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Button_ChangeType")
  self._ui_pc.stc_dropSetBg_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Static_StettingBG")
  self._ui_pc.radio_free_Mini = UI.getChildControl(self._ui_pc.stc_dropSetBg_Mini, "RadioButton_Free")
  self._ui_pc.radio_turn_Mini = UI.getChildControl(self._ui_pc.stc_dropSetBg_Mini, "RadioButton_Turn")
  self._ui_pc.radio_rando_Mini = UI.getChildControl(self._ui_pc.stc_dropSetBg_Mini, "RadioButton_Random")
  self._ui_pc.stc_valuePack_mini_enable = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Static_ValuePack_Enable")
  self._ui_pc.stc_valuePack_mini_disable = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Static_ValuePack_disable")
  self._ui_pc.stc_buttonBG_Mini = UI.getChildControl(self._ui_pc.stc_optionBG_Mini, "Static_Button_BG")
  self._ui_pc.chk_dragToggle_Mini = UI.getChildControl(self._ui_pc.stc_buttonBG_Mini, "CheckButton_DragToggle")
  Panel_Widget_Party_All:SetDragEnable(false)
  self._ui_pc.chk_dragToggle:SetCheck(true)
  self._ui_pc.chk_dragToggle_Mini:SetCheck(true)
end
function PaGlobal_Party_All:createControl()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui.stc_memberTemplate:SetShow(false)
  self._ui.stc_memberTemplate_Mini:SetShow(false)
  local startPosY = self._ui.stc_memberTemplate:GetPosY()
  local startPosY_mini = self._ui.stc_memberTemplate_Mini:GetPosY()
  self:createControlByType(self._ui.stc_memberTemplate, startPosY, self._ui.stc_members, self._ui.stc_memberBG, self._config.gapY)
  self:createControlByType(self._ui.stc_memberTemplate_Mini, startPosY_mini, self._ui.stc_members_Mini, self._ui.stc_memberBG_mini, self._config.miniGapY)
end
function PaGlobal_Party_All:createControlByType(template, startPosY, table, parent, gapY)
  for index = 1, self._config.maxPartyCnt do
    local info = {}
    info.control = UI.cloneControl(template, parent, "Static_PartyMember_" .. index)
    info.control:SetPosY(startPosY + (info.control:GetSizeY() + gapY) * index)
    info._stc_progressBg = UI.getChildControl(info.control, "Static_ProgressBg")
    info._progress_hp = UI.getChildControl(info.control, "Progress2_Hp")
    info._progress_mp = UI.getChildControl(info.control, "Progress2_Mp")
    info._stc_classIconBg = UI.getChildControl(info.control, "Static_ClassIconBg")
    info._stc_defaultClassIconBg = UI.getChildControl(info.control, "Static_ClassIcon_OtherServer")
    info._stc_classIconLeaderBg = UI.getChildControl(info.control, "Static_ClassIconLeaderBg")
    info._stc_classIcon = UI.getChildControl(info.control, "Static_ClassIcon")
    info._txt_level = UI.getChildControl(info.control, "StaticText_CharacterLevelValue")
    info._txt_name = UI.getChildControl(info.control, "StaticText_CharacterNameValue")
    info._txt_name:SetTextMode(__eTextMode_LimitText)
    info._txt_serverName = UI.getChildControl(info.control, "StaticText_Servername")
    info._stc_deadState = UI.getChildControl(info.control, "Static_DeadState")
    info._stc_distanceWifi = UI.getChildControl(info.control, "Static_DistanceWifi")
    info._stc_rootInfo = UI.getChildControl(info.control, "Static_RootInfoIcon")
    info._stc_follow = UI.getChildControl(info.control, "Static_Follow")
    info._btn_option = UI.getChildControl(info.control, "Button_Option")
    info._btn_leave = UI.getChildControl(info.control, "Button_Leave")
    info._btn_selfLeave = UI.getChildControl(info.control, "Button_SelfLeave")
    info._stc_setMemberBg = UI.getChildControl(info.control, "Static_ButtonBG1")
    info._btn_setLeader = UI.getChildControl(info._stc_setMemberBg, "Button_SetLeader")
    info._btn_forceOut = UI.getChildControl(info._stc_setMemberBg, "Button_ForceOut")
    info._stc_platformIcon = UI.getChildControl(info.control, "Static_CrossPlay")
    info._effect = UI.getChildControl(info.control, "Static_PartyMember_Effect")
    info._btn_leave:SetTextMode(__eTextMode_AutoWrap)
    info._btn_setLeader:SetTextMode(__eTextMode_AutoWrap)
    info._btn_forceOut:SetTextMode(__eTextMode_AutoWrap)
    info._btn_leave:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEAVE"))
    info._btn_setLeader:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_AUTORIZE"))
    info._btn_forceOut:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_KICKOUT"))
    local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    if colorBlindMode >= 1 then
      info._progress_hp:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(info._progress_hp, 330, 273, 508, 282)
      info._progress_hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      info._progress_hp:setRenderTexture(info._progress_hp:getBaseTexture())
      info._progress_mp:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(info._progress_mp, 331, 290, 504, 294)
      info._progress_mp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      info._progress_mp:setRenderTexture(info._progress_mp:getBaseTexture())
    end
    table[index] = info
  end
end
function PaGlobal_Party_All:resetData()
  if nil == self._initialize or false == self._initialize then
    return
  end
  self._refuseName = nil
  self._withdrawMember = nil
  self._isMemberDataLoad = false
  self._partyData = {}
  self._ui_pc.stc_marketOptionBg:SetShow(false)
  self._ui_pc.stc_dropSetBg:SetShow(false)
  self:showLootingType()
  self._ui_pc.chk_minCost:SetCheck(false)
  self._ui_pc.chk_grade:SetCheck(false)
  self._currentMoney = self._config.baseMoney
  self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
  self._firstCheck = 0
  self._lastSelectUser = nil
  self._inviteReqList = {}
  self._preLootType = nil
  self._prevPrice = nil
  self._prevGrade = nil
  for ii = 1, self._config.maxPartyCnt do
    self._ui.stc_members[ii].control:SetShow(false)
    self._ui.stc_members_Mini[ii].control:SetShow(false)
  end
end
function PaGlobal_Party_All:setPositionByServer()
  if nil == Panel_Widget_Party_All then
    return
  end
  changePositionBySever(Panel_Widget_Party_All, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
end
function PaGlobal_Party_All:checkOpen()
  if false == self._initialize then
    return false
  end
  local memberCount = RequestParty_getPartyMemberCount()
  if memberCount <= 0 then
    return false
  end
  local partyType = ToClient_GetPartyType()
  if CppEnums.PartyType.ePartyType_Normal == partyType then
  elseif CppEnums.PartyType.ePartyType_Large == partyType then
    PaGlobalFunc_Widget_Raid_All_Open()
    PaGlobalFunc_Widget_Raid_All_Update()
    return false
  else
    return false
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return false
  elseif true == _ContentsGroup_OthilitaDungeon and nil ~= Panel_Widget_ThornCastle_Member then
    PaGlobal_ThornCastle_Member:prepareClose()
  end
  if true == _ContentsGroup_Solare and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return false
  end
  return true
end
function PaGlobal_Party_All:prepareOpen()
  if Panel_Widget_Party_All == nil then
    return
  end
  if true == _ContentsGroup_Solare and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    PaGlobal_Party_All:prepareClose()
    return
  end
  self:open()
end
function PaGlobal_Party_All:open()
  if Panel_Widget_Party_All == nil then
    return
  end
  if true ~= self:checkOpen() then
    self:prepareClose()
    return
  end
  ToClient_requestListMySellInfo()
  PaGlobalFunc_Widget_Raid_All_Close()
  if Panel_Widget_Party_All:GetShow() == false then
    local isMiniPartyUI = false
    if false == self._isConsole then
      isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
    end
    self:changeType(isMiniPartyUI)
  else
    self:changeType(self._isMini)
  end
  self:update()
  self:resize()
  FromClient_Party_All_UpdatePartyMatchingState()
  Panel_Widget_Party_All:SetShow(true)
  Panel_Widget_Party_All:RegisterUpdateFunc("PaGlobalFunc_Party_All_Update")
end
function PaGlobal_Party_All:prepareClose()
  if nil == Panel_Widget_Party_All then
    return
  end
  if self._initialize == false then
    return
  end
  self._ui_pc.stc_OptionBg:SetShow(false)
  self._ui_pc.stc_gradeOptionBg:SetShow(false)
  PaGlobal_Party_All:close()
end
function PaGlobal_Party_All:close()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:SetShow(false)
  Panel_Widget_Party_All:ClearUpdateLuaFunc()
end
function PaGlobal_Party_All:registEventHandler()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
  Panel_Widget_Party_All:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_New_ShowButton()")
  Panel_Widget_Party_All:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_New_ShowButton()")
  Panel_Widget_Party_All:addInputEvent("Mouse_LPress", "HandleEventLPress_Party_All_DragPanelAndSavePos()")
  registerEvent("ResponseParty_createPartyList", "FromClient_Party_All_createPartyList")
  registerEvent("ResponseParty_updatePartyList", "FromClient_Party_All_updatePartyList")
  registerEvent("ResponseParty_invite", "FromClient_Party_All_Invite")
  registerEvent("ResponseParty_refuse", "FromClient_Party_All_Refuse")
  registerEvent("ResponseParty_accept", "FromClient_Party_All_Accept")
  registerEvent("ResponseParty_joinOtherServer", "FromClient_Party_All_JoinOtherServer")
  registerEvent("ResponseParty_changeLeader", "FromClient_Party_All_ChangeLeader")
  registerEvent("ResponseParty_withdraw", "FromClient_Party_All_Withdraw")
  registerEvent("FromClient_GroundMouseClick", "FromClient_Party_All_PartyOption_Hide")
  registerEvent("onScreenResize", "FromClient_Party_All_OnScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Party_All_OnScreenResize")
  registerEvent("FromClient_NotifyPartyMemberPickupItem", "FromClient_Party_All_NotifyPartyMemberPickupItem")
  registerEvent("FromClient_NotifyPartyMemberPickupItemFromPartyInventory", "FromClient_Party_All_NotifyPartyMemberPickupItemFromPartyInventory")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_Party_All_RenderModeChange")
  registerEvent("FromClient_SetFollowActor", "FromClient_Party_All_SetFollowActor")
  registerEvent("FromClient_EndFollowActor", "FromClient_Party_All_EndFollowActor")
  registerEvent("FromClient_UpdatePartyContentsMatchingState", "FromClient_Party_All_UpdatePartyMatchingState")
  registerEvent("ResponseParty_showEffectMember", "PaGlobalFunc_Party_Member_Effect")
  registerEvent("FromClient_UpdateMorningBossPartyAttribute", "FromClient_UpdateMorningBossPartyAttribute")
  registerEvent("FromClient_updatePartyLootType", "FromClient_updatePartyLootType")
  registerEvent("FromClient_updatePartyDistributionOption", "FromClient_updatePartyDistributionOption")
  registerEvent("FromClient_updatePartyMemberHp", "FromClient_updatePartyMemberHp")
  registerEvent("FromClient_updatePartyMemberMp", "FromClient_updatePartyMemberMp")
  registerEvent("FromClient_updatePartyMemberLevel", "FromClient_updatePartyMemberLevel")
  registerEvent("FromClient_updatePartyMemberExpGrade", "FromClient_updatePartyMemberExpGrade")
  for index = 1, self._config.maxPartyCnt do
    local control = self._ui.stc_members[index]
    control._stc_follow:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectPartyFollow(" .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 0, " .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 0, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 1, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 1, " .. index .. ")")
    control._btn_option:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectPartyOption(" .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:wantLeaveParty(" .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 4, " .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 4, " .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_On", "PaGlobal_Party_All:overPartyLeaveCheck(true, " .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_Out", "PaGlobal_Party_All:overPartyLeaveCheck(false, " .. index .. ")")
    control.control:addInputEvent("Mouse_RUp", "HandleEventRUp_Party_All_NaviGuide(" .. index .. ")")
  end
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, true )")
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, false )")
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowMarketOptionToggle()")
  self._ui_pc.radio_free:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Free .. ")")
  self._ui_pc.radio_turn:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Shuffle .. ")")
  self._ui_pc.radio_rando:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Random .. ")")
  self._ui_pc.chk_dropItem:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:setLootingType(false)")
  self._ui_pc.btn_Grade:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowGradeListToggle()")
  self._ui_pc.btn_changeType:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:changeType(true)")
  self._ui_pc.btn_buttonBanner:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:openGroupEnchant()")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ToggleDragMove('')")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ToggleDragToolTip('', true)")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ToggleDragToolTip('', false)")
  self._ui_pc.chk_dragToggle_Mini:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ToggleDragMove('mini')")
  self._ui_pc.chk_dragToggle_Mini:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ToggleDragToolTip('mini', true)")
  self._ui_pc.chk_dragToggle_Mini:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ToggleDragToolTip('mini', false)")
  self._ui_pc.btn_minCost:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ChangeMoney()")
  self._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SetRegistItem()")
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowMarketOptionToggle(false)")
  for index = 0, #self._ui_pc.btn_grades do
    local control = self._ui_pc.btn_grades[index]
    control:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:setGrade(" .. index .. ")")
  end
  self._ui_pc.btn_marketOption_Mini:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, true )")
  self._ui_pc.btn_marketOption_Mini:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, false )")
  self._ui_pc.btn_marketOption_Mini:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowMarketOptionToggle()")
  self._ui_pc.chk_dropItem_Mini:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:setLootingType(true)")
  self._ui_pc.btn_changeType_Mini:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:changeType(false)")
  self._ui_pc.radio_free_Mini:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Free .. ")")
  self._ui_pc.radio_turn_Mini:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Shuffle .. ")")
  self._ui_pc.radio_rando_Mini:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectLootingType(" .. CppEnums.PartyLootType.LootType_Random .. ")")
  for index = 1, self._config.maxPartyCnt do
    local control = self._ui.stc_members_Mini[index]
    control._stc_follow:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectPartyFollow(" .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 0, " .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 0, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 1, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 1, " .. index .. ")")
    control._btn_option:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectPartyOption(" .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:wantLeaveParty(" .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 4, " .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 4, " .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_On", "PaGlobal_Party_All:overPartyLeaveCheck(true, " .. index .. ")")
    control._btn_selfLeave:addInputEvent("Mouse_Out", "PaGlobal_Party_All:overPartyLeaveCheck(false, " .. index .. ")")
    control.control:addInputEvent("Mouse_RUp", "HandleEventRUp_Party_All_NaviGuide(" .. index .. ")")
  end
  self._ui_pc.stc_valuePack_enable:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowEnableValuepackToolTip(true )")
  self._ui_pc.stc_valuePack_enable:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowEnableValuepackToolTip( false )")
  self._ui_pc.stc_valuePack_disable:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowDisableValuepackToolTip( true )")
  self._ui_pc.stc_valuePack_disable:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowDisableValuepackToolTip(false )")
  self._ui_pc.stc_valuePack_mini_enable:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowEnableValuepackToolTip( true )")
  self._ui_pc.stc_valuePack_mini_enable:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowEnableValuepackToolTip( false )")
  self._ui_pc.stc_valuePack_mini_disable:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowDisableValuepackToolTip( true )")
  self._ui_pc.stc_valuePack_mini_disable:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowDisableValuepackToolTip( false )")
  self._ui.btn_memberBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Party_All_PartyContentsMatchingCancel()")
  self._ui.btn_memberBG_mini:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Party_All_PartyContentsMatchingCancel()")
  registerEvent("FromClient_UpdateCharge", "FromClient_PartyUpdateValuePackageIcon")
  registerEvent("FromClient_LoadCompleteMsg", "FromClient_PartyUpdateValuePackageIcon")
  registerEvent("FromClient_ChangeUserNicknameDirectly", "FromClient_ChangeUserNicknameDirectly_Party")
end
function PaGlobal_Party_All:validate()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui_pc.stc_OptionBg:isValidate()
  self._ui_pc.btn_specialItem:isValidate()
  self._ui_pc.btn_marketOption:isValidate()
  self._ui_pc.chk_dropItem:isValidate()
  self._ui_pc.stc_dropSetBg:isValidate()
  self._ui_pc.radio_free:isValidate()
  self._ui_pc.radio_turn:isValidate()
  self._ui_pc.radio_rando:isValidate()
  self._ui_pc.stc_marketOptionBg:isValidate()
  self._ui_pc.stc_mainBg:isValidate()
  self._ui_pc.btn_apply:isValidate()
  self._ui_pc.txt_marketOptionTitle:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.txt_minCostTitle:isValidate()
  self._ui_pc.txt_minCostValue:isValidate()
  self._ui_pc.txt_minGradeTitle:isValidate()
  self._ui_pc.txt_minGradeValue:isValidate()
  self._ui_pc.btn_minCost:isValidate()
  self._ui_pc.btn_Grade:isValidate()
  self._ui_pc.stc_gradeOptionBg:isValidate()
  self._ui_pc.btn_grades[0]:isValidate()
  self._ui_pc.btn_grades[1]:isValidate()
  self._ui_pc.btn_grades[2]:isValidate()
  self._ui_pc.btn_grades[3]:isValidate()
  self._ui_pc.btn_grades[4]:isValidate()
end
function PaGlobal_Party_All:resize()
  if nil == self._initialize or false == self._initialize then
    return
  end
  local initPosX = 10
  local initPosY = 200
  if Panel_Widget_Party_All:GetRelativePosX() == -1 or Panel_Widget_Party_All:GetRelativePosY() == -1 then
    changePositionBySever(Panel_Widget_Party_All, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_Widget_Party_All, initPosX, initPosY)
  elseif Panel_Widget_Party_All:GetRelativePosX() == 0 or Panel_Widget_Party_All:GetRelativePosY() == 0 then
    Panel_Widget_Party_All:SetPosX(initPosX)
    Panel_Widget_Party_All:SetPosY(initPosY)
  else
    Panel_Widget_Party_All:SetPosX(getScreenSizeX() * Panel_Widget_Party_All:GetRelativePosX() - Panel_Widget_Party_All:GetSizeX() / 2)
    Panel_Widget_Party_All:SetPosY(getScreenSizeY() * Panel_Widget_Party_All:GetRelativePosY() - Panel_Widget_Party_All:GetSizeY() / 2)
  end
  if true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_TopIcon_GetShowAllCheck() then
      Panel_Widget_Party_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - self._ui_pc.stc_OptionBg:GetSizeY() + 20)
    else
      Panel_Widget_Party_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - self._ui_pc.stc_OptionBg:GetSizeY() - 50)
    end
  end
  self._ui_pc.stc_OptionBg:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_Party_All)
end
function PaGlobal_Party_All:renderModeChange(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  if 0 == RequestParty_getPartyMemberCount() then
    self:resetData()
    self:prepareClose()
  else
    PaGlobalFunc_Widget_Party_All_Open()
  end
end
function PaGlobal_Party_All:showSpecialGoodsTooltip(btnType, isShow)
  local itemCount = ToClient_requestGetMySellInfoCount()
  local msg = ""
  local control
  if 1 == btnType then
    local grade = RequestParty_getDistributionGrade()
    local price = RequestParty_getDistributionPrice()
    control = self._ui_pc.btn_marketOption
    if 0 < Int64toInt32(price) then
      if grade > 0 and grade < 5 then
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHSILVER", "getDistributionPrice", makeDotMoney(price)) .. ", " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHGRADE", "getDistributionGrade", self._itemGradeString[grade])
      else
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHSILVER", "getDistributionPrice", makeDotMoney(price))
      end
    elseif grade > 0 and grade < 5 then
      msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHGRADE2", "getDistributionGrade", self._itemGradeString[grade])
    else
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_NOT_OPTION_SETTING")
    end
  end
  if true == isShow then
    TooltipSimple_Show(control, msg, nil)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_Party_All:showSimpleTooltip(isShow, tipType, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local table = self._ui.stc_members[index]
  if true == self._ui_pc.stc_optionBG_Mini:GetShow() then
    table = self._ui.stc_members_Mini[index]
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_FOLLOW_ACTOR")
    control = table._stc_follow
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_DISTANCE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_DISTANCE_DESC")
    control = table._stc_distanceWifi
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_DESC")
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_ROOTNAME_NO")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_ROOTDESC")
    control = table._stc_rootInfo
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_Party_All:showRegistItem(isShow)
  if nil == isShow then
    self._ui_pc.stc_marketOptionBg:SetShow(not self._ui_pc.stc_marketOptionBg:GetShow())
  else
    self._ui_pc.stc_marketOptionBg:SetShow(isShow)
  end
  if false == self._ui_pc.stc_marketOptionBg:GetShow() then
    return
  end
  local memberCount = RequestParty_getPartyMemberCount()
  if memberCount <= 0 then
    return
  end
  local isPartyLeader = RequestParty_isLeader()
  self._ui_pc.btn_minCost:SetEnable(isPartyLeader)
  self._ui_pc.btn_Grade:SetEnable(isPartyLeader)
  local posY = self._ui.stc_members[memberCount].control:GetPosY() + self._ui_pc.stc_marketOptionBg:GetSizeY() * 0.8
  if true == self._ui_pc.stc_optionBG_Mini:GetShow() then
    posY = self._ui.stc_members_Mini[memberCount].control:GetPosY() + self._ui_pc.stc_marketOptionBg:GetSizeY() * 0.8
  end
  self._ui_pc.stc_marketOptionBg:SetPosY(posY)
  self._currentMoney = RequestParty_getDistributionPrice()
  if toInt64(0, 0) ~= self._currentMoney then
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(true)
  else
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._config.baseMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(false)
  end
  self._currentGrade = RequestParty_getDistributionGrade()
  if 0 < self._currentGrade and self._currentGrade <= #self._itemGradeString then
    self:setGrade(self._currentGrade)
    self._ui_pc.chk_grade:SetCheck(true)
  else
    self:setGrade(0)
    self._ui_pc.chk_grade:SetCheck(false)
  end
end
function PaGlobal_Party_All:setPartyMember()
  local memberCount = RequestParty_getPartyMemberCount()
  UI.ASSERT_NAME(memberCount > 0, "\237\140\140\237\139\176\236\155\144 \236\136\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
  for index = 0, memberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil == memberData then
      return
    end
    local memberInfo = {}
    memberInfo._index = index
    memberInfo._isMaster = memberData._isMaster
    memberInfo._isSelf = RequestParty_isSelfPlayer(index)
    memberInfo._name = memberData:name()
    memberInfo._class = memberData:classType()
    memberInfo._level = memberData._level
    memberInfo._currentHp = memberData._hp * 100
    memberInfo._maxHp = memberData._maxHp
    memberInfo._currentMp = memberData._mp * 100
    memberInfo._maxMp = memberData._maxMp
    memberInfo._distance = memberData:getExperienceGrade()
    memberInfo._platformType = memberData:getPlatformType()
    memberInfo._actorKeyRaw = memberData:getActorKey()
    memberInfo._isOffline = memberData._isOffline
    memberInfo._serverNo = memberData._serverNo
    if memberInfo._index == 0 and false == memberInfo._isSelf then
      UI.ASSERT_NAME(false, "_index = 0\235\138\148 \235\172\180\236\161\176\234\177\180 Self\236\151\172\236\149\188 \237\149\169\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
      return
    end
    self:setPartyMemberXXX(memberInfo, true)
    self:setPartyMemberXXX(memberInfo, false)
    table.insert(self._partyData, memberInfo)
  end
  self:changeType(self._isMini)
  self._isMemberDataLoad = true
end
function PaGlobal_Party_All:setClassIcon(control, classType)
  if nil == control then
    return
  end
  local textureId
  if NewClassData.newClass_Texture_ID[classType] == nil then
    return
  end
  textureId = NewClassData.newClass_Texture_ID[classType]._symbolTextureTID
  if textureId ~= nil then
    control:ChangeTextureInfoTextureIDAsync(textureId, 0)
    control:setRenderTexture(control:getBaseTexture())
  end
end
function PaGlobal_Party_All:setClassMpBar(control, class, isMini)
  UI.ASSERT_NAME(nil ~= control, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
  local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 0 == colorBlindMode then
    local textureId
    if NewClassData.newClass_Texture_ID[class] == nil then
      return
    end
    if isMini == false then
      textureId = NewClassData.newClass_Texture_ID[class]._mpBarTextureTID
    else
      textureId = NewClassData.newClass_Texture_ID[class]._mpBarMiniTextureTID
    end
    if textureId == nil then
      UI.ASSERT_NAME(nil ~= control, "MpBar Texture\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
      return
    end
    control:ChangeTextureInfoTextureIDAsync(textureId, 0)
    control:setRenderTexture(control:getBaseTexture())
  elseif colorBlindMode >= 1 then
    if false == isMini then
      control:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_02.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 327, 560, 500, 564)
      control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      control:setRenderTexture(control:getBaseTexture())
    else
      control:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_03.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 1, 219, 166, 222)
      control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      control:setRenderTexture(control:getBaseTexture())
    end
  end
end
function PaGlobal_Party_All:setClassHpBar(control, class, isMini)
  UI.ASSERT_NAME(nil ~= control, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
  local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 0 == colorBlindMode then
    if false == isMini then
      control:ChangeTextureInfoNameAsync("combine/progress/combine_progress_02.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 330, 273, 508, 282)
      control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      control:setRenderTexture(control:getBaseTexture())
    else
      control:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_03.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 1, 130, 166, 140)
      control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      control:setRenderTexture(control:getBaseTexture())
    end
  elseif false == isMini then
    control:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_02.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 327, 550, 505, 559)
    control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    control:setRenderTexture(control:getBaseTexture())
  else
    control:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 1, 208, 166, 218)
    control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    control:setRenderTexture(control:getBaseTexture())
  end
end
function PaGlobal_Party_All:setRootInfo(control, partyData)
  if false == partyData._isSelf then
    return
  end
  local rootInfoTexture
  local diffLevel = ToClient_getPartyMemberMaxLevel() - ToClient_getPartyMemberMinLevel()
  if diffLevel >= 10 then
    control:ChangeTextureInfoNameAsync("renewal/etc/console_etc_00.dds")
    rootInfoTexture = self._textureRootInfo[2]
    local x1, y1, x2, y2 = setTextureUV_Func(control, rootInfoTexture[1], rootInfoTexture[2], rootInfoTexture[3], rootInfoTexture[4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetShow(true)
  else
    if true == self._isRootShowFlag then
      self._isRootShowFlag = false
      TooltipSimple_Hide()
    end
    control:SetShow(false)
  end
end
function PaGlobal_Party_All:changeType(isMini)
  if true == isMini then
    self._ui.stc_memberBG:SetShow(false)
    self._ui.stc_memberBG_mini:SetShow(true)
    self._ui_pc.stc_OptionBg:SetShow(false)
    self._ui_pc.stc_optionBG_Mini:SetShow(true)
    for index = 1, self._config.maxPartyCnt do
      self._ui.stc_members_Mini[index]._stc_classIconBg:SetShow(false)
      self._ui.stc_members_Mini[index]._stc_defaultClassIconBg:SetShow(false)
      self._ui.stc_members_Mini[index]._stc_classIconLeaderBg:SetShow(false)
      self._ui.stc_members_Mini[index]._stc_classIcon:SetShow(false)
    end
    Panel_Widget_Party_All:SetDragArea(157, 0, 180, 25)
  else
    self._ui.stc_memberBG:SetShow(true)
    self._ui.stc_memberBG_mini:SetShow(false)
    self._ui_pc.stc_OptionBg:SetShow(true)
    self._ui_pc.stc_optionBG_Mini:SetShow(false)
    Panel_Widget_Party_All:SetDragArea(297, 0, 320, 25)
  end
  if ToClient_isConsole() == true then
    self._ui_pc.stc_OptionBg:SetShow(false)
    self._ui_pc.stc_optionBG_Mini:SetShow(false)
  end
  self:updateVariedPoints(isMini)
  self:updateValuePackageIcon()
  self._isMini = isMini
  self:updateMorningBossPartyAttributePosition()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMiniPartyUI, isMini, CppEnums.VariableStorageType.eVariableStorageType_User)
  FromClient_Party_All_UpdatePartyMatchingState()
end
function PaGlobal_Party_All:openGroupEnchantState()
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  if self._ui_pc.btn_buttonBanner ~= nil then
    self._ui_pc.btn_buttonBanner:SetShow(ToClient_IsGroupEnchantAble())
    if self._ui_pc.btn_buttonBanner:GetShow() == true then
      self._ui_pc.btn_buttonBanner:EraseAllEffect()
      self._ui_pc.btn_buttonBanner:AddEffect("fUI_Party_Upgrade_01A", false, 0, 0)
    end
    self._ui_pc.btn_buttonBanner:SetPosX(Panel_Widget_Party_All:GetPosX() + Panel_Widget_Party_All:GetSizeX() + 10)
  end
end
function PaGlobal_Party_All:openGroupEnchant()
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  local pcPosition = selfPlayer:get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  if regionInfo:get():isSafeZone() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_DO_SAFEZONE"))
    return
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  if ToClient_IsGroupEnchantAble() == true then
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_GroupEnchant)
  end
end
function PaGlobal_Party_All:setStateIcon(member, partyData)
  if nil == member then
    return
  end
  local control = member._stc_distanceWifi
  control:SetShow(not partyData._isSelf and not partyData._isOffline)
  local distTemp = partyData._distance + 1
  if distTemp < 1 or distTemp > 4 then
    distTemp = 4
  end
  local wifiTexture = self._textureWifi[distTemp]
  if nil ~= wifiTexture then
    control:ChangeTextureInfoNameAsync(self._textureWifi.path)
    local x1, y1, x2, y2 = setTextureUV_Func(control, wifiTexture[1], wifiTexture[2], wifiTexture[3], wifiTexture[4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  end
  local isDead = partyData._currentHp <= 0
  control = member._stc_deadState
  control:SetShow(isDead)
  control = member._progress_mp
  control:SetShow(not isDead)
  control = member._progress_hp
  control:SetShow(not isDead)
  control = member._stc_defaultClassIconBg
  control:SetShow(partyData._isOffline)
  control = member._stc_classIconLeaderBg
  control:SetShow(partyData._isMaster)
  control = member._txt_serverName
  control:SetShow(partyData._isOffline)
  control = member._btn_option
  control:SetShow(RequestParty_isLeader() and false == partyData._isSelf and false == self._isConsole)
  control = member._stc_follow
  control:SetShow(not partyData._isSelf and false == self._isConsole and not partyData._isOffline)
  control = member._stc_distanceWifi
  control:SetShow(not partyData._isSelf and not partyData._isOffline)
  local posX = member._txt_name:GetPosX()
  posX = posX + member._txt_name:GetTextSizeX() + 10
  control:SetPosX(posX)
  local posX = member._btn_option:GetPosX()
  local posX2 = member._btn_selfLeave:GetPosX()
  if true == member._btn_option:GetShow() then
    member._stc_follow:SetPosX(posX - 21)
    if true == member._stc_follow:GetShow() then
      posX = posX - 48
    end
    member._stc_distanceWifi:SetPosX(posX)
  elseif true == member._btn_selfLeave:GetShow() then
    member._stc_follow:SetPosX(posX2 - 21)
    if true == member._stc_follow:GetShow() then
      posX2 = posX2 - 48
    end
    member._stc_distanceWifi:SetPosX(posX2)
  else
    member._stc_follow:SetPosX(posX)
    if true == member._stc_follow:GetShow() then
      posX = posX - 25
    else
      posX = posX - 5
    end
    member._stc_distanceWifi:SetPosX(posX)
  end
end
function PaGlobal_Party_All:setLootingType(isMini)
  PaGlobal_Party_All:closePartyOption()
  self._lastSelectUser = nil
  if false == RequestParty_isLeader() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ONLYLEADERCHANGE"))
    self._ui_pc.chk_dropItem:SetCheck(false)
    self._ui_pc.chk_dropItem_Mini:SetCheck(false)
    return
  end
  PaGlobal_Party_All:showLootingType(isMini)
end
function PaGlobal_Party_All:showLootingType(isMini)
  local lootType = RequestParty_getPartyLootType()
  local setShow = false
  if true == isMini then
    setShow = self._ui_pc.chk_dropItem_Mini:IsCheck()
    self._ui_pc.stc_dropSetBg:SetShow(false)
    self._ui_pc.stc_dropSetBg_Mini:SetShow(setShow)
  else
    setShow = self._ui_pc.chk_dropItem:IsCheck()
    self._ui_pc.stc_dropSetBg:SetShow(setShow)
    self._ui_pc.stc_dropSetBg_Mini:SetShow(false)
  end
  if true == setShow then
    self:changeLootingType(lootType)
  end
end
function PaGlobal_Party_All:changeLootingType(lootType)
  self._ui_pc.radio_free:SetCheck(false)
  self._ui_pc.radio_turn:SetCheck(false)
  self._ui_pc.radio_rando:SetCheck(false)
  self._ui_pc.radio_free_Mini:SetCheck(false)
  self._ui_pc.radio_turn_Mini:SetCheck(false)
  self._ui_pc.radio_rando_Mini:SetCheck(false)
  if lootType == CppEnums.PartyLootType.LootType_Free then
    self._ui_pc.radio_free:SetCheck(true)
    self._ui_pc.radio_free_Mini:SetCheck(true)
  elseif lootType == CppEnums.PartyLootType.LootType_Shuffle then
    self._ui_pc.radio_turn:SetCheck(true)
    self._ui_pc.radio_turn_Mini:SetCheck(true)
  elseif lootType == CppEnums.PartyLootType.LootType_Random then
    self._ui_pc.radio_rando:SetCheck(true)
    self._ui_pc.radio_rando_Mini:SetCheck(true)
  end
end
function PaGlobal_Party_All:selectLootingType(lootType)
  RequestParty_changeLooting(lootType)
  local showString
  if lootType == CppEnums.PartyLootType.LootType_Free then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_FREE")
  elseif lootType == CppEnums.PartyLootType.LootType_Shuffle then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_SHUFFLE")
  elseif lootType == CppEnums.PartyLootType.LootType_Random then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_RANDOM")
  elseif lootType == CppEnums.PartyLootType.LootType_Master then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_MASTER")
  end
  self._ui_pc.chk_dropItem:SetText(showString)
  self._ui_pc.chk_dropItem:SetCheck(false)
  self._ui_pc.chk_dropItem_Mini:SetCheck(false)
  self:showLootingType()
end
function PaGlobal_Party_All:closePartyOption(index)
  if nil ~= index then
    local control = self._ui.stc_members[index]
    local control_mini = self._ui.stc_members_Mini[index]
    control._btn_leave:SetShow(false)
    control._stc_setMemberBg:SetShow(false)
    control_mini._btn_leave:SetShow(false)
    control_mini._stc_setMemberBg:SetShow(false)
  else
    for index = 1, self._config.maxPartyCnt do
      local control = self._ui.stc_members[index]
      local control_mini = self._ui.stc_members_Mini[index]
      control._btn_leave:SetShow(false)
      control._stc_setMemberBg:SetShow(false)
      control_mini._btn_leave:SetShow(false)
      control_mini._stc_setMemberBg:SetShow(false)
    end
  end
end
function PaGlobal_Party_All:wantLeaveParty(index)
  local partyData = self:getPartyDataAtIndex(index)
  if nil == partyData then
    return
  end
  local control = self._ui.stc_members[index]
  local control_mini = self._ui.stc_members_Mini[index]
  if partyData._isSelf == true then
    PaGlobal_Party_All:selectWithdrawMember(partyData._index)
  end
end
function PaGlobal_Party_All:selectPartyOption(index)
  local partyData = self:getPartyDataAtIndex(index)
  if nil == partyData then
    return
  end
  local control = self._ui.stc_members[index]
  local control_mini = self._ui.stc_members_Mini[index]
  self:closePartyOption()
  self._ui_pc.chk_dropItem:SetCheck(false)
  self._ui_pc.chk_dropItem_Mini:SetCheck(false)
  self:showLootingType()
  if self._lastSelectUser == index then
    self._lastSelectUser = nil
  else
    if partyData._isSelf == true then
      control._btn_selfLeave:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectWithdrawMember(" .. partyData._index .. ")")
      control_mini._btn_selfLeave:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectWithdrawMember(" .. partyData._index .. ")")
    elseif RequestParty_isLeader() == true then
      control._btn_forceOut:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:banishMemeber(" .. partyData._index .. ")")
      control._btn_setLeader:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectChangeLeader(" .. partyData._index .. ")")
      control._stc_setMemberBg:SetShow(true)
      control_mini._btn_forceOut:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:banishMemeber(" .. partyData._index .. ")")
      control_mini._btn_setLeader:addInputEvent("Mouse_LUp", "PaGlobal_Party_All:selectChangeLeader(" .. partyData._index .. ")")
      control_mini._stc_setMemberBg:SetShow(true)
    end
    self._lastSelectUser = index
  end
end
function PaGlobal_Party_All:selectWithdrawMember(index)
  local isPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == isPlayingPvPMatch then
    RequestParty_withdrawMember(index)
    return
  end
  local function partyOut()
    RequestParty_withdrawMember(index)
    self:closePartyOption()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_GETOUTPARTY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = partyOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Party_All:Common_WidgetMouseOn(index)
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  local control
  if isMiniPartyUI == false then
    control = self._ui.stc_members[index]
  else
    control = self._ui.stc_members_Mini[index]
  end
  if control == nil then
    return false
  end
  local panelPosX = Panel_Widget_Party_All:GetPosX() + self._ui.stc_memberBG:GetPosX() + control.control:GetPosX()
  local panelPosY = Panel_Widget_Party_All:GetPosY() + self._ui.stc_memberBG:GetPosY() + control.control:GetPosY()
  local panelSizeX = control.control:GetSizeX()
  local panelSizeY = control.control:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX < mousePosX and mousePosX < panelPosX + panelSizeX and panelPosY < mousePosY and mousePosY < panelPosY + panelSizeY then
    return true
  end
  return false
end
function PaGlobal_Party_All:overPartyLeaveCheck(isShow, index)
  self._isMouseOn = isShow
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui.stc_members[index]
  local control_mini = self._ui.stc_members_Mini[index]
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_WIDGET_OUT_BTN")
  local desc = ""
  local tipControl = control._btn_selfLeave
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  if true == isMiniPartyUI then
    tipControl = control_mini._btn_selfLeave
  else
    tipControl = control._btn_selfLeave
  end
  TooltipSimple_Show(tipControl, name, desc)
end
function PaGlobal_Party_All:banishMemeber(index)
  self._withdrawMember = index
  local withdrawMemberData = RequestParty_getPartyMemberAt(self._withdrawMember)
  local withdrawMemberActorKey = withdrawMemberData:getActorKey()
  local withdrawMemberPlayerActor = getPlayerActor(withdrawMemberActorKey)
  local contentString = ""
  local titleForceOut = ""
  if CppEnums.PartyType.ePartyType_Normal == ToClient_GetPartyType() then
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT")
  else
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT")
  end
  local function messageBox_party_withdrawMember()
    local memberData = RequestParty_getPartyMemberAt(self._withdrawMember)
    RequestParty_withdrawMember(self._withdrawMember)
    if true == getSelfPlayer():isDefinedPvPMatch() then
      return
    end
  end
  local messageboxData = {
    title = titleForceOut,
    content = contentString,
    functionYes = messageBox_party_withdrawMember,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  self:closePartyOption()
end
function PaGlobal_Party_All:selectChangeLeader(index)
  RequestParty_changeLeader(index)
  self:closePartyOption()
end
function PaGlobal_Party_All:setGrade(index)
  if nil == index or index > #self._itemGradeString then
    return
  end
  self._currentGrade = index
  self._ui_pc.txt_minGradeValue:SetText(self._itemGradeString[index])
  self:showGradeListToggle(false)
end
function PaGlobal_Party_All:showGradeListToggle(isShow)
  if false == isShow or true == self._ui_pc.stc_gradeOptionBg:GetShow() then
    self._ui_pc.stc_gradeOptionBg:SetShow(false)
    return
  end
  self._ui_pc.stc_gradeOptionBg:SetShow(true)
end
function PaGlobal_Party_All:showMarketOptionToggle(isShow)
  if false == isShow or true == self._ui_pc.stc_marketOptionBg:GetShow() then
    self._ui_pc.stc_marketOptionBg:SetShow(false)
    return
  end
  self._ui_pc.stc_marketOptionBg:SetShow(true)
  PaGlobal_Party_All:showRegistItem(true)
end
function PaGlobal_Party_All:setMoney(inputNum)
  local _inputNum
  if Int64toInt32(self._config.maxMoney) < Int64toInt32(inputNum) then
    _inputNum = self._config.maxMoney
  elseif Int64toInt32(inputNum) < 1000000 then
    _inputNum = self._config.baseMoney
  else
    _inputNum = inputNum
  end
  self._currentMoney = _inputNum
  self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(_inputNum) .. "<PAOldColor>")
end
function PaGlobal_Party_All:setRegistItem()
  local price = toInt64(0, 0)
  local grade = 5
  if true == self._ui_pc.chk_minCost:IsCheck() then
    price = toInt64(0, math.max(Int64toInt32(self._currentMoney), Int64toInt32(self._config.baseMoney)))
  end
  if true == self._ui_pc.chk_grade:IsCheck() then
    grade = self._currentGrade
    if 0 == grade then
      grade = 5
    end
  end
  RequestParty_changeDistributionOption(price, grade)
  self:showMarketOptionToggle(false)
end
function PaGlobal_Party_All:selectPartyFollow(index)
  local partyData = self:getPartyDataAtIndex(index)
  if nil == partyData then
    return
  end
  local idx = partyData._index
  local selfPlayer = getSelfPlayer()
  local memberData = RequestParty_getPartyMemberAt(idx)
  if nil ~= memberData then
    local actorKey = memberData:getActorKey()
    selfPlayer:setFollowActor(actorKey)
  end
end
function PaGlobal_Party_All:invite(hostName, invitePartyType, platformNickname, platformType)
  if true == self._inviteReqList[hostName] then
    return
  end
  if ToClient_namelessPVPServer() == true then
    hostName = PaGlobalFunc_getAnonymousNameString(0)
  end
  local function messageBox_party_accept()
    if nil == self._currentPartyType then
      return
    end
    self._inviteReqList = {}
    if true == ToClient_IsInstanceRandomMatching() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RAMDOMMATCH_FAILBYPARTY"))
      RequestParty_refuseInvite()
    else
      RequestParty_acceptInvite(self._currentPartyType)
    end
    if Panel_PartyList_All ~= nil and Panel_PartyList_All:GetShow() then
      PaGlobalFunc_PartyList_All_Close()
    end
  end
  local function messageBox_party_refuse()
    RequestParty_refuseInvite()
    if true == self._inviteReqList[self._refuseName] then
      self._inviteReqList[self._refuseName] = nil
    end
  end
  self._refuseName = hostName
  self._currentPartyType = invitePartyType
  self._inviteReqList[hostName] = true
  local messageboxMemo = ""
  local messageboxData = ""
  local displayName = hostName
  if ToClient_isPS5() == true then
    if platformType ~= __eGAME_PLATFORM_TYPE_PS or platformNickname == nil or platformNickname == "" then
      displayName = hostName
    else
      displayName = hostName .. "[ " .. platformNickname .. " ]"
    end
  end
  if MessageBoxGetShow() then
    MessageBox_Empty_function()
    allClearMessageData()
  end
  if 0 == invitePartyType then
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_INVITE_ACCEPT", "host_name", displayName)
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "PARTY_INVITE_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = messageBox_party_accept,
      functionNo = messageBox_party_refuse,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  else
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_ACCEPT", "host_name", displayName)
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = messageBox_party_accept,
      functionNo = messageBox_party_refuse,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  end
  MessageBox.showMessageBox(messageboxData, "top", false, true, 0)
end
function PaGlobal_Party_All:refuse(reason)
  local contentString = reason
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Party_All:changeLeader(actorKey)
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local function getChangeLeaderName()
    local name = ""
    local nameType = ToClient_getChatNameType()
    local playerActorProxyWrapper
    playerActorProxyWrapper = getPlayerActor(actorKey)
    if __eChatNameType_NickName == nameType and nil ~= playerActorProxyWrapper then
      name = playerActorProxyWrapper:getUserNickname()
    else
      name = actorProxyWrapper:getName()
    end
    return name
  end
  local textName = getChangeLeaderName()
  if CppEnums.PartyType.ePartyType_Normal == ToClient_GetPartyType() then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_CHANGE_PARTY_LEADER", "text_name", tostring(textName)))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_CHANGE_PARTY_LEADER", "text_name", tostring(textName)))
  end
end
function PaGlobal_Party_All:withdraw(withdrawType, actorKey, isMe)
  if ToClient_IsRequestedPvP() or ToClient_IsMyselfInEntryUser() then
    return
  end
  local partyType = ToClient_GetPartyType()
  local message = ""
  if 0 == withdrawType then
    if isMe then
      if 0 == partyType then
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_LEAVE_PARTY_SELF")
      else
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_LEAVE_PARTY_SELF")
      end
      if nil ~= Panel_Atoraxion_Enter and true == Panel_Atoraxion_Enter:GetShow() then
        PaGlobalFunc_Atoraxion_Enter_Close()
      end
    else
      local textName = ""
      local nameType = ToClient_getChatNameType()
      if __eChatNameType_NickName == nameType then
        local playerActorProxyWrapper = getPlayerActor(actorKey)
        if nil ~= playerActorProxyWrapper then
          textName = playerActorProxyWrapper:getUserNickname()
        end
      else
        local actorProxyWrapper = getActor(actorKey)
        if nil ~= actorProxyWrapper then
          textName = actorProxyWrapper:getOriginalName()
        end
      end
      if "" ~= textName and nil ~= textName then
        if 0 == partyType then
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_LEAVE_PARTY_MEMBER", "text_name", tostring(textName))
        else
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_LEAVE_PARTY_MEMBER", "text_name", tostring(textName))
        end
      end
    end
  elseif 1 == withdrawType then
    if isMe then
      if 0 == partyType then
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_SELF")
      else
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_SELF")
      end
      if nil ~= Panel_Atoraxion_Enter and true == Panel_Atoraxion_Enter:GetShow() then
        PaGlobalFunc_Atoraxion_Enter_Close()
      end
    else
      local textName = ""
      local nameType = ToClient_getChatNameType()
      if __eChatNameType_NickName == nameType then
        local playerActorProxyWrapper = getPlayerActor(actorKey)
        if nil ~= playerActorProxyWrapper then
          textName = playerActorProxyWrapper:getUserNickname()
        end
      else
        local actorProxyWrapper = getActor(actorKey)
        if nil ~= actorProxyWrapper then
          textName = actorProxyWrapper:getOriginalName()
        end
      end
      if "" ~= textName and nil ~= textName then
        if 0 == partyType then
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_MEMBER", "text_name", tostring(textName))
        else
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_MEMBER", "text_name", tostring(textName))
        end
      end
    end
  elseif 2 == withdrawType then
    if 0 == partyType then
      message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_DISPERSE")
    else
      message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_DISPERSE")
    end
    if nil ~= Panel_Atoraxion_Enter and true == Panel_Atoraxion_Enter:GetShow() then
      PaGlobalFunc_Atoraxion_Enter_Close()
    end
  end
  NakMessagePanel_Reset()
  if "" ~= message and nil ~= message then
    Proc_ShowMessage_Ack(message)
  end
end
function PaGlobal_Party_All:partyConditionalShow()
  if 0 == RequestParty_getPartyMemberCount() then
    PaGlobal_Party_All:prepareClose()
    self:resetData()
  else
    self:open()
  end
end
function PaGlobal_Party_All:setCrossPlayIcon(targetControl, platformType)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function PaGlobal_Party_All:updateValuePackageIcon()
  self._ui_pc.stc_valuePack_disable:SetShow(false)
  self._ui_pc.stc_valuePack_enable:SetShow(false)
  self._ui_pc.stc_valuePack_mini_disable:SetShow(false)
  self._ui_pc.stc_valuePack_mini_enable:SetShow(false)
  if true == _contentsGroup_valueBuffReduceTax then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local UI_BUFFTYPE = CppEnums.UserChargeType
      local player = selfPlayer:get()
      local premium = player:getUserChargeTime(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
      local applyPremium = player:isApplyChargeSkill(UI_BUFFTYPE.eUserChargeType_PremiumPackage)
      local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
      if false == applyPremium or true == applyPremium and premium <= 0 then
        if true == isMiniPartyUI then
          self._ui_pc.stc_valuePack_mini_disable:SetShow(true)
        else
          self._ui_pc.stc_valuePack_disable:SetShow(true)
        end
      elseif true == isMiniPartyUI then
        self._ui_pc.stc_valuePack_mini_enable:SetShow(true)
      else
        self._ui_pc.stc_valuePack_enable:SetShow(true)
      end
    end
  end
end
function PaGlobal_Party_All:partymemberNaviGuide(index)
  local partyData = self:getPartyDataAtIndex(index)
  if nil == partyData then
    return
  end
  local memberData = RequestParty_getPartyMemberAt(partyData._index)
  if nil == memberData then
    return
  end
  local position = float3(memberData:getPositionX(), memberData:getPositionY(), memberData:getPositionZ())
  ToClient_DeleteNaviGuideByGroup(0)
  worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
end
function PaGlobal_Party_All:update()
  self:resetData()
  self:setPartyMember()
  local lootType = RequestParty_getPartyLootType()
  self:updateLootType(lootType)
  self:updatePartyDistributionOption()
  self:updateOptionBg()
  self:openGroupEnchantState()
end
function PaGlobal_Party_All:getPartyDataAtIndex(index)
  local partyData = self:getPartyDataAtIndex__XXX(index)
  if nil == partyData then
    self._refCount = self._refCount + 1
  end
  return partyData
end
function PaGlobal_Party_All:getPartyDataAtIndex__XXX(index)
  if false == self._isMemberDataLoad then
    return nil
  end
  return self._partyData[index]
end
function PaGlobal_Party_All:getPartyDataByActorKeyRaw(actorKeyRaw)
  local partyData = self:getPartyDataByActorKeyRaw__XXX(actorKeyRaw)
  if nil == partyData then
    self._refCount = self._refCount + 1
  end
  return partyData
end
function PaGlobal_Party_All:getPartyDataByActorKeyRaw__XXX(actorKeyRaw)
  if false == self._isMemberDataLoad then
    return nil
  end
  for _, partyData in pairs(self._partyData) do
    if partyData._actorKeyRaw == actorKeyRaw then
      return partyData
    end
  end
  return nil
end
function PaGlobal_Party_All:updateLootType(lootType)
  local currentLootTypeString = CppEnums.PartyLootType2String[lootType]
  if self._preLootType ~= nil and self._preLootType ~= currentLootTypeString then
    local rottingMsg = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_CHANGE_LOOTING_RULE1", "plt2s_lootType", currentLootTypeString)
    Proc_ShowMessage_Ack(rottingMsg)
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  elseif self._preLootType == nil then
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  end
  self._preLootType = currentLootTypeString
end
function PaGlobal_Party_All:updatePartyDistributionOption()
  if false == self._ui_pc.stc_marketOptionBg:GetShow() then
    return
  end
  self._currentMoney = RequestParty_getDistributionPrice()
  if toInt64(0, 0) ~= self._currentMoney then
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(true)
  else
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._config.baseMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(false)
  end
  self._currentGrade = RequestParty_getDistributionGrade()
  if 0 < self._currentGrade and self._currentGrade <= #self._itemGradeString then
    self:setGrade(self._currentGrade)
    self._ui_pc.chk_grade:SetCheck(true)
  else
    self:setGrade(0)
    self._ui_pc.chk_grade:SetCheck(false)
  end
end
function PaGlobal_Party_All:updateOptionBg()
  if true == self._isConsole then
    self._ui_pc.stc_gradeOptionBg:SetShow(false)
    self._ui_pc.stc_OptionBg:SetShow(false)
  else
    local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
    self._ui_pc.stc_OptionBg:SetShow(not isMiniPartyUI)
    self._ui_pc.stc_optionBG_Mini:SetShow(isMiniPartyUI)
  end
end
function PaGlobal_Party_All:setPartyMemberXXX(partyData, isMini)
  UI.ASSERT_NAME(nil ~= partyData, "PartyData\234\176\128 nil \236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
  local uiIndex = partyData._index + 1
  local member
  if true == isMini then
    member = self._ui.stc_members_Mini[uiIndex]
  else
    member = self._ui.stc_members[uiIndex]
  end
  if nil == member then
    UI.ASSERT_NAME(nil ~= partyData, "member \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  member.control:SetShow(true)
  member.control:SetMonoTone(partyData._isOffline)
  if isMini == true then
    member.control:SetMonoTone(false)
  end
  member._progress_hp:SetProgressRate(partyData._currentHp / partyData._maxHp)
  member._progress_mp:SetProgressRate(partyData._currentMp / partyData._maxMp)
  member._stc_classIcon:SetShow(not partyData._isOffline)
  self:setClassIcon(member._stc_classIcon, partyData._class)
  self:setClassMpBar(member._progress_mp, partyData._class, isMini)
  self:setClassHpBar(member._progress_hp, partyData._class, isMini)
  if true == partyData._isSelf then
    self:setRootInfo(member._stc_rootInfo, partyData)
  end
  self:setStateIcon(member, partyData)
  if partyData._isOffline == true then
    if partyData._serverNo == 0 then
      member._txt_serverName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_PARTY_DISCONNECT"))
    else
      local serverNo = partyData._serverNo
      local curChannelData = getCurrentChannelServerData()
      local currentServerNo = curChannelData._serverNo
      local channelName = getChannelName(curChannelData._worldNo, serverNo)
      member._txt_serverName:SetText(channelName)
    end
    member._progress_hp:SetShow(false)
    member._progress_mp:SetShow(false)
    member._txt_level:SetText("")
  else
    member._txt_level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. partyData._level)
  end
  local showCheck = {
    member._btn_option,
    member._btn_selfLeave,
    member._stc_follow,
    member._stc_distanceWifi
  }
  local template = self._ui.stc_memberTemplate
  local originNameSizeX = UI.getChildControl(template, "StaticText_CharacterNameValue"):GetSizeX()
  local originIconSizeX = UI.getChildControl(template, "Static_Follow"):GetSizeX()
  local showIconNum = #showCheck
  for index = 1, #showCheck do
    if true == showCheck[index]:GetShow() then
      showIconNum = showIconNum - 1
    end
  end
  member._txt_name:SetPosX(member._txt_level:GetPosX() + member._txt_level:GetTextSizeX() + 3)
  if true == isMini then
    local cnt = 0
    if true == member._stc_rootInfo:GetShow() then
      cnt = cnt + 1
    end
    if true == member._stc_follow:GetShow() then
      cnt = cnt + 1
    end
    if true == member._stc_distanceWifi:GetShow() then
      cnt = cnt + 1
    end
    if true == member._btn_option:GetShow() then
      cnt = cnt + 1
    end
    if true == member._btn_selfLeave:GetShow() then
      cnt = cnt + 1
    end
    if cnt >= 3 then
      member._txt_name:SetSize(45, member._txt_name:GetSizeY())
    end
    if true == partyData._isMaster then
      member._txt_name:SetFontColor(Defines.Color.C_FFF5BA3A)
    else
      member._txt_name:SetFontColor(Defines.Color.C_FFFFEDD4)
    end
  else
    if true == partyData._isSelf and true == member._stc_rootInfo:GetShow() then
      local gapSizeX = member._stc_rootInfo:GetPosX() - member._txt_name:GetPosX()
      member._txt_name:SetSize(gapSizeX, member._txt_name:GetSizeY())
    else
      member._txt_name:SetSize(originNameSizeX + originIconSizeX * showIconNum, member._txt_name:GetSizeY())
    end
    member._txt_name:SetFontColor(Defines.Color.C_FFFFEDD4)
  end
  member._txt_name:SetTextMode(__eTextMode_LimitText)
  member._txt_name:SetText(partyData._name)
  if true == member._txt_name:IsLimitText() then
    member._txt_name:SetIgnore(false)
    member._txt_name:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowNameTooltip(true," .. uiIndex .. ")")
    member._txt_name:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowNameTooltip(false," .. uiIndex .. ")")
  else
    member._txt_name:SetIgnore(true)
    member._txt_name:addInputEvent("Mouse_On", "")
    member._txt_name:addInputEvent("Mouse_Out", "")
  end
  if true == ToClient_isTotalGameClient() then
    self:setCrossPlayIcon(member._stc_platformIcon, partyData._platformType)
  end
  member._btn_selfLeave:SetShow(partyData._isSelf)
end
function PaGlobal_Party_All:updateVariedPoints(isMini)
  for key, partyData in pairs(self._partyData) do
    local member
    if true == isMini then
      member = self._ui.stc_members_Mini[key]
    else
      member = self._ui.stc_members[key]
    end
    if nil ~= member then
      local isDead = partyData._currentHp <= 0
      member._stc_deadState:SetShow(isDead and not partyData._isOffline)
      member._progress_hp:SetShow(not isDead and not partyData._isOffline)
      member._progress_mp:SetShow(not isDead and not partyData._isOffline)
      member._progress_hp:SetProgressRate(partyData._currentHp / partyData._maxHp)
      member._progress_mp:SetProgressRate(partyData._currentMp / partyData._maxMp)
      if partyData._isOffline == true then
        member._txt_level:SetText("")
        if partyData._serverNo == 0 then
          member._txt_serverName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_PARTY_DISCONNECT"))
        else
          local serverNo = partyData._serverNo
          local curChannelData = getCurrentChannelServerData()
          local currentServerNo = curChannelData._serverNo
          local channelName = getChannelName(curChannelData._worldNo, serverNo)
          member._txt_serverName:SetText(channelName)
        end
        member._progress_hp:SetShow(false)
        member._progress_mp:SetShow(false)
      else
        member._txt_level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. partyData._level)
      end
      member._txt_name:SetPosX(member._txt_level:GetPosX() + member._txt_level:GetTextSizeX() + 3)
      local control = member._stc_distanceWifi
      local wifiTexture = self._textureWifi[partyData._distance + 1]
      if nil ~= wifiTexture then
        control:ChangeTextureInfoNameAsync(self._textureWifi.path)
        local x1, y1, x2, y2 = setTextureUV_Func(control, wifiTexture[1], wifiTexture[2], wifiTexture[3], wifiTexture[4])
        control:getBaseTexture():setUV(x1, y1, x2, y2)
        control:setRenderTexture(control:getBaseTexture())
      end
    end
  end
end
function PaGlobal_Party_All:checkPartyLeaderUI()
  local isMiniPartyUI = false
  if false == self._isConsole then
    isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  end
  if isMiniPartyUI == true then
    return
  end
  local leaderCount = 0
  for key, partyData in pairs(self._partyData) do
    local index = partyData._index
    local member
    if true == self._isMini then
      member = self._ui.stc_members_Mini[index + 1]
    else
      member = self._ui.stc_members[index + 1]
    end
    if nil ~= member then
      control = member._stc_classIconLeaderBg
      if true == control:GetShow() then
        leaderCount = leaderCount + 1
      end
    end
  end
  if 1 ~= leaderCount then
    self._refCount = self._refCount + 1
  end
end
function PaGlobal_Party_All:showPartyData()
  UI.ASSERT_NAME(false, "*** PaGlobal_Party_All:showPartyData(\235\178\132\234\183\184 \236\158\172\237\152\132\236\139\156 \237\153\149\236\157\184\236\154\169) ***", "\235\176\149\234\183\156\235\130\152")
  for key, partyData in pairs(self._partyData) do
  end
end
function PaGlobal_Party_All:updateMorningBossPartyAttribute(sunCount, moonCount, landCount)
  local moonRange = sunCount + moonCount
  local landRange = moonRange + landCount
  self._ui.stc_morningBossAttributeBg:SetShow(true)
  for attributeIndex = 1, self._config.maxPartyCnt do
    if attributeIndex > landRange then
      self._ui.stc_attributeList[attributeIndex]:SetShow(false)
    else
      self._ui.stc_attributeList[attributeIndex]:SetShow(true)
      if attributeIndex <= sunCount then
        self._ui.stc_attributeList[attributeIndex]:ChangeTextureInfoTextureIDAsync(self._morningBossAttributeIcon[__eElementalStat_Sun])
      elseif attributeIndex <= moonRange then
        self._ui.stc_attributeList[attributeIndex]:ChangeTextureInfoTextureIDAsync(self._morningBossAttributeIcon[__eElementalStat_Moon])
      else
        self._ui.stc_attributeList[attributeIndex]:ChangeTextureInfoTextureIDAsync(self._morningBossAttributeIcon[__eElementalStat_Land])
      end
      self._ui.stc_attributeList[attributeIndex]:setRenderTexture(self._ui.stc_attributeList[attributeIndex]:getBaseTexture())
    end
  end
  self:updateMorningBossPartyAttributePosition()
end
function PaGlobal_Party_All:updateMorningBossPartyAttributePosition()
  if self._ui.stc_morningBossAttributeBg:GetShow() == true then
    local memberCount = RequestParty_getPartyMemberCount()
    local posY = self._ui.stc_morningBossAttributeBg:GetPosY()
    if self._isMini == true then
      posY = self._ui.stc_members_Mini[memberCount].control:GetPosY() + self._ui.stc_members_Mini[memberCount].control:GetSizeY() + self._config.gapY
    else
      posY = self._ui.stc_members[memberCount].control:GetPosY() + self._ui.stc_members[memberCount].control:GetSizeY() + self._config.gapY
    end
    self._ui.stc_morningBossAttributeBg:SetPosY(posY)
  end
end
