function PaGlobal_Raid_All:initialize()
  if true == PaGlobal_Raid_All._initialize then
    return
  end
  PaGlobal_Raid_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Raid_All:ControlAll_Init()
  PaGlobal_Raid_All:ControlPc_Init()
  PaGlobal_Raid_All:ControlSetShow()
  PaGlobal_Raid_All:createControl()
  PaGlobal_Raid_All:registEventHandler()
  PaGlobal_Raid_All:validate()
  PaGlobal_Raid_All._initialize = true
end
function PaGlobal_Raid_All:ControlAll_Init()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui.stc_raidBg = UI.getChildControl(Panel_Widget_Raid_All, "Static_RaidBG")
  self._ui.txt_charInfo = UI.getChildControl(self._ui.stc_raidBg, "StaticText_CharacterInfo")
  self._ui.stc_hpBg = UI.getChildControl(self._ui.stc_raidBg, "Static_HpBG")
  self._ui.progress_hp = UI.getChildControl(self._ui.stc_raidBg, "Progress2_Hp")
  self._ui.stc_deadBg = UI.getChildControl(self._ui.stc_raidBg, "Static_DeadConditionBG")
  self._ui.stc_campBasic = UI.getChildControl(Panel_Widget_Raid_All, "Static_Camp_Basic")
  self._ui.stc_campKama = UI.getChildControl(Panel_Widget_Raid_All, "Static_Camp_Kama")
  self._ui.stc_campOdyl = UI.getChildControl(Panel_Widget_Raid_All, "Static_Camp_Odyl")
end
function PaGlobal_Raid_All:ControlPc_Init()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_orderIcon = UI.getChildControl(self._ui.stc_raidBg, "Button_Order")
  self._ui_pc.btn_leave = UI.getChildControl(Panel_Widget_Raid_All, "Button_Leave")
  self._ui_pc.btn_ordersBg = UI.getChildControl(Panel_Widget_Raid_All, "Static_ButtonBG1")
  self._ui_pc.btn_setLeader = UI.getChildControl(self._ui_pc.btn_ordersBg, "Button_SetLeader")
  self._ui_pc.btn_forceOut = UI.getChildControl(self._ui_pc.btn_ordersBg, "Button_ForceOut")
  self._ui_pc.stc_buttonBG = UI.getChildControl(Panel_Widget_Raid_All, "Static_Button_BG")
  self._ui_pc.chk_dragToggle = UI.getChildControl(self._ui_pc.stc_buttonBG, "CheckButton_DragToggle")
  Panel_Widget_Raid_All:SetDragEnable(false)
  Panel_Widget_Raid_All:addInputEvent("Mouse_On", "HanldeEventOnOut_Widget_Raid_All_Panel()")
  Panel_Widget_Raid_All:addInputEvent("Mouse_Out", "HanldeEventOnOut_Widget_Raid_All_Panel()")
  self._ui_pc.chk_dragToggle:SetCheck(true)
end
function PaGlobal_Raid_All:createControl()
  if nil == Panel_Widget_Raid_All then
    return
  end
  local startY = self._ui.stc_campKama:GetSizeY()
  self._ui.stc_raidBg:SetShow(false)
  for index = 1, self._maxPartyMemberCount do
    local raidMember = {}
    raidMember._base = UI.cloneControl(self._ui.stc_raidBg, Panel_Widget_Raid_All, "Static_RaidMember_" .. index)
    raidMember._name = UI.getChildControl(raidMember._base, "StaticText_CharacterInfo")
    raidMember._hpBG = UI.getChildControl(raidMember._base, "Static_HpBG")
    raidMember._hp = UI.getChildControl(raidMember._base, "Progress2_Hp")
    raidMember._actionBtn = UI.getChildControl(raidMember._base, "Button_Order")
    raidMember._deadConditionBG = UI.getChildControl(raidMember._base, "Static_DeadConditionBG")
    raidMember._platformIcon = UI.getChildControl(raidMember._base, "Static_CrossPlay")
    raidMember._leaveBtn = UI.getChildControl(raidMember._base, "Button_SelfLeave")
    raidMember._name:SetTextMode(__eTextMode_LimitText)
    if index < 11 then
      raidMember._base:SetPosY(startY + (index - 1) * (self._ui.stc_raidBg:GetSizeY() + 5))
    else
      raidMember._base:SetPosX(self._ui.stc_raidBg:GetPosX() + self._ui.stc_raidBg:GetSizeX() + 25)
      raidMember._base:SetPosY(startY + (index - 11) * (self._ui.stc_raidBg:GetSizeY() + 5))
    end
    raidMember._base:SetShow(false)
    raidMember._actionBtn:SetShow(false)
    if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == false then
      raidMember._base:addInputEvent("Mouse_On", "HanldeEventOnOut_Widget_Raid_All_ButtonAction(true," .. index .. ")")
      raidMember._base:addInputEvent("Mouse_Out", "HanldeEventOnOut_Widget_Raid_All_ButtonAction(false," .. index .. ")")
      raidMember._base:addInputEvent("Mouse_LUp", "HanldeEventLUp_Widget_Raid_All_ClickButtonAction(" .. index .. ")")
    end
    raidMember._base:addInputEvent("Mouse_RUp", "HandleEventRUp_Widget_Raid_All_NaviGuide(" .. index .. ")")
    raidMember._leaveBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ExitParty(" .. index .. ")")
    raidMember._leaveBtn:addInputEvent("Mouse_On", "HandleEventLUp_Widget_Raid_All_ExitToolTip(true," .. tostring(index) .. ")")
    raidMember._leaveBtn:addInputEvent("Mouse_Out", "HandleEventLUp_Widget_Raid_All_ExitToolTip(false," .. tostring(index) .. ")")
    self._uiPartyMemberList[index] = raidMember
  end
end
function PaGlobal_Raid_All:ControlSetShow()
end
function PaGlobal_Raid_All:prepareOpen()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_leave:SetShow(false)
  self._ui_pc.btn_ordersBg:SetShow(false)
  self._ui.stc_campBasic:SetShow(true)
  self._ui.stc_campKama:SetShow(false)
  self._ui.stc_campOdyl:SetShow(false)
  PaGlobal_Raid_All:open()
  PaGlobal_Raid_All:resize()
end
function PaGlobal_Raid_All:open()
  if nil == Panel_Widget_Raid_All then
    return
  end
  Panel_Widget_Raid_All:SetShow(true)
end
function PaGlobal_Raid_All:prepareClose()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_ordersBg:SetShow(false)
  PaGlobal_Raid_All:close()
end
function PaGlobal_Raid_All:close()
  if nil == Panel_Widget_Raid_All then
    return
  end
  Panel_Widget_Raid_All:SetShow(false)
end
function PaGlobal_Raid_All:registEventHandler()
  if nil == Panel_Widget_Raid_All then
    return
  end
  Panel_Widget_Raid_All:addInputEvent("Mouse_LPress", "HandleEventLPress_Widget_Raid_All_DragPanelAndSavePos()")
  registerEvent("onScreenResize", "FromClient_Widget_Raid_All_ScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Widget_Raid_All_ScreenResize")
  registerEvent("FromClient_GroundMouseClick", "FromClient_Widget_Raid_All_HideOption")
  self._ui_pc.btn_setLeader:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ChangeLeader()")
  self._ui_pc.btn_forceOut:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_BanishMember()")
  self._ui_pc.btn_leave:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ExitParty(" .. self._selectIndex_Undefine .. ")")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ToggleDragMove()")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_On", "HandleEventOnOut_Raid_All_ToggleDragToolTip(true)")
  self._ui_pc.chk_dragToggle:addInputEvent("Mouse_Out", "HandleEventOnOut_Raid_All_ToggleDragToolTip(false)")
  registerEvent("FromClient_updatePartyMemberHp", "PaGlobalFunc_Widget_Raid_All_Update")
  registerEvent("FromClient_updatePartyMemberLevel", "PaGlobalFunc_Widget_Raid_All_Update")
  registerEvent("FromClient_UpdateRoseWarState", "PaGlobalFunc_Widget_Raid_All_Update")
  registerEvent("ResponseParty_updatePartyList", "PaGlobalFunc_Widget_Raid_All_Update")
end
function PaGlobal_Raid_All:resize()
  if 0 == RequestParty_getPartyMemberCount() then
    PaGlobal_Raid_All:prepareClose()
  end
  if Panel_Widget_Raid_All:GetRelativePosX() == -1 or Panel_Widget_Raid_All:GetRelativePosY() == -1 then
    local initPosX = 10
    local initPosY = 200
    changePositionBySever(Panel_Widget_Raid_All, CppEnums.PAGameUIType.PAGameUIPanel_LargeParty, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_Widget_Raid_All, initPosX, initPosY)
  elseif Panel_Widget_Raid_All:GetRelativePosX() == 0 or Panel_Widget_Raid_All:GetRelativePosY() == 0 then
    Panel_Widget_Raid_All:SetPosX(10)
    Panel_Widget_Raid_All:SetPosY(200)
  else
    Panel_Widget_Raid_All:SetPosX(getScreenSizeX() * Panel_Widget_Raid_All:GetRelativePosX() - Panel_Widget_Raid_All:GetSizeX() / 2)
    Panel_Widget_Raid_All:SetPosY(getScreenSizeY() * Panel_Widget_Raid_All:GetRelativePosY() - Panel_Widget_Raid_All:GetSizeY() / 2)
  end
  if true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_TopIcon_GetShowAllCheck() then
      Panel_Widget_Raid_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() + 20)
    else
      Panel_Widget_Raid_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - 50)
    end
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_Raid_All)
end
function PaGlobal_Raid_All:validate()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui.stc_raidBg:isValidate()
  self._ui.txt_charInfo:isValidate()
  self._ui.stc_hpBg:isValidate()
  self._ui.progress_hp:isValidate()
  self._ui.stc_deadBg:isValidate()
  self._ui_pc.btn_orderIcon:isValidate()
  self._ui_pc.btn_leave:isValidate()
  self._ui_pc.btn_ordersBg:isValidate()
  self._ui_pc.btn_setLeader:isValidate()
  self._ui_pc.btn_forceOut:isValidate()
end
function PaGlobal_Raid_All:limitTextTooptip(isShow, index)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._uiPartyMemberList[index]._name, self._uiPartyMemberList[index]._name:GetText())
end
function PaGlobal_Raid_All:update()
  if nil == Panel_Widget_Raid_All then
    return
  end
  if false == self._initialize then
    return
  end
  self._isMaster = false
  self._partyMemberCount = RequestParty_getPartyMemberCount()
  if 0 == self._partyMemberCount then
    PaGlobal_Raid_All:prepareClose()
    return
  end
  self._partyMemberData = {}
  self._partyMemberData = PaGlobalFunc_Widget_Party_All_SetMemberData(self._partyMemberCount)
  if nil == self._partyMemberData[1] then
    PaGlobal_Raid_All:prepareClose()
    return
  end
  for index = 1, self._maxPartyMemberCount do
    if nil == self._uiPartyMemberList[index] then
      return
    end
    self._uiPartyMemberList[index]._base:SetShow(false)
    if index <= self._partyMemberCount then
      PaGlobal_Raid_All:setInfo(index)
      self._uiPartyMemberList[index]._base:SetShow(true)
      local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
      if colorBlindMode >= 1 then
        self._uiPartyMemberList[index]._hp:ChangeTextureInfoNameAsync("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
        local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._uiPartyMemberList[index]._hp, 329, 415, 462, 426)
        self._uiPartyMemberList[index]._hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
        self._uiPartyMemberList[index]._hp:setRenderTexture(self._uiPartyMemberList[index]._hp:getBaseTexture())
      else
        self._uiPartyMemberList[index]._hp:ChangeTextureInfoNameAsync("Renewal/Progress/console_progressbar_03.dds")
        local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._uiPartyMemberList[index]._hp, 329, 415, 462, 426)
        self._uiPartyMemberList[index]._hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
        self._uiPartyMemberList[index]._hp:setRenderTexture(self._uiPartyMemberList[index]._hp:getBaseTexture())
      end
    end
  end
  self:setRoseWarCamp()
end
function PaGlobal_Raid_All:setInfo(index)
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._uiPartyMemberList[index]._leaveBtn:SetShow(self._partyMemberData[index]._isSelf)
  if true == self._partyMemberData[index]._isSelf and true == self._partyMemberData[index]._isMaster then
    self._isMaster = true
  end
  if self._partyMemberData[index]._isMaster then
    self._uiPartyMemberList[index]._name:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    self._uiPartyMemberList[index]._name:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  self._uiPartyMemberList[index]._base:SetShow(true)
  self._uiPartyMemberList[index]._name:SetShow(true)
  if self._partyMemberData[index]._isOffline == true then
    self._uiPartyMemberList[index]._name:SetText(self._partyMemberData[index]._name)
    UI.setLimitTextAndAddTooltip(self._uiPartyMemberList[index]._name, self._uiPartyMemberList[index]._name:GetText(), "")
    self._uiPartyMemberList[index]._hpBG:SetShow(true)
    self._uiPartyMemberList[index]._hpBG:SetMonoTone(true)
    self._uiPartyMemberList[index]._deadConditionBG:SetShow(false)
    self._uiPartyMemberList[index]._deadConditionBG:SetMonoTone(true)
    self._uiPartyMemberList[index]._hp:SetProgressRate(0)
    self._uiPartyMemberList[index]._hp:SetMonoTone(true)
  else
    self._uiPartyMemberList[index]._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. self._partyMemberData[index]._level .. " " .. self._partyMemberData[index]._name)
    UI.setLimitTextAndAddTooltip(self._uiPartyMemberList[index]._name, self._uiPartyMemberList[index]._name:GetText(), "")
    self._uiPartyMemberList[index]._hpBG:SetMonoTone(false)
    self._uiPartyMemberList[index]._hp:SetMonoTone(false)
    self._uiPartyMemberList[index]._deadConditionBG:SetMonoTone(false)
    local isDead = 0 >= self._partyMemberData[index]._currentHp
    self._uiPartyMemberList[index]._hp:SetProgressRate(self._partyMemberData[index]._currentHp / self._partyMemberData[index]._maxHp)
    self._uiPartyMemberList[index]._hpBG:SetShow(not isDead)
    self._uiPartyMemberList[index]._deadConditionBG:SetShow(isDead)
  end
  if true == ToClient_isTotalGameClient() then
    PaGlobal_Raid_All:setCrossPlayIcon(self._uiPartyMemberList[index]._platformIcon, self._partyMemberData[index]._platformType)
  end
end
function PaGlobal_Raid_All:showButtonAction(isShow, index)
  if nil == Panel_Widget_Raid_All then
    return
  end
  if self._uiPartyMemberList[index]._actionBtn:GetShow() and index == self._selectIndex then
    return
  end
  if isShow and self._isMaster == true and self._partyMemberData[index]._isSelf == false then
    local memberCount = RequestParty_getPartyMemberCount()
    for count = 1, memberCount do
      if count == index then
        self._uiPartyMemberList[count]._actionBtn:SetShow(true)
      else
        self._uiPartyMemberList[count]._actionBtn:SetShow(false)
        self._ui_pc.btn_leave:SetShow(false)
        self._ui_pc.btn_ordersBg:SetShow(false)
      end
    end
  else
    self._uiPartyMemberList[index]._actionBtn:SetShow(false)
  end
end
function PaGlobal_Raid_All:clickButtonAction(index)
  if self._ui_pc.btn_leave:GetShow() or self._ui_pc.btn_ordersBg:GetShow() then
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
  end
  self._ui_pc.btn_leave:SetPosX(self._uiPartyMemberList[index]._base:GetPosX() + self._uiPartyMemberList[index]._base:GetSizeX() + 5)
  self._ui_pc.btn_ordersBg:SetPosX(self._uiPartyMemberList[index]._base:GetPosX() + self._uiPartyMemberList[index]._base:GetSizeX() + 5)
  self._ui_pc.btn_leave:SetPosY(self._uiPartyMemberList[index]._base:GetPosY())
  self._ui_pc.btn_ordersBg:SetPosY(self._uiPartyMemberList[index]._base:GetPosY())
  if false == self._partyMemberData[index]._isSelf and true == self._isMaster then
    self._ui_pc.btn_ordersBg:SetShow(true)
  else
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
  end
  Panel_Widget_Raid_All:SetChildIndex(self._ui_pc.btn_leave, 9999)
  Panel_Widget_Raid_All:SetChildIndex(self._ui_pc.btn_ordersBg, 9998)
  self._selectIndex = self._partyMemberData[index]._index
end
function PaGlobal_Raid_All:changeLeader()
  if -1 == self._selectIndex or nil == self._selectIndex then
    return
  end
  RequestParty_changeLeader(self._selectIndex)
  self._ui_pc.btn_leave:SetShow(false)
  self._ui_pc.btn_ordersBg:SetShow(false)
  PaGlobal_Raid_All:update()
end
function PaGlobal_Raid_All:banishMember()
  local withdrawMemberData = RequestParty_getPartyMemberAt(self._selectIndex)
  if nil == withdrawMemberData then
    return
  end
  local withdrawMemberActorKey = withdrawMemberData:getActorKey()
  local withdrawMemberPlayerActor = getPlayerActor(withdrawMemberActorKey)
  local partyType = ToClient_GetPartyType()
  local function messageBox_party_BanishMember()
    RequestParty_withdrawMember(self._selectIndex)
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
    PaGlobal_Raid_All:update()
  end
  local contentString = ""
  local titleForceOut = ""
  if 0 == partyType then
    contentString = withdrawMemberData:name() .. PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_QUESTION")
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT")
  else
    contentString = withdrawMemberData:name() .. PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_QUESTION")
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT")
  end
  local messageboxData = {
    title = titleForceOut,
    content = contentString,
    functionYes = messageBox_party_BanishMember,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Raid_All:exitParty(selectIndex)
  if selectIndex ~= self._selectIndex_Undefine then
    self._selectIndex = self._partyMemberData[selectIndex]._index
  end
  local isPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == isPlayingPvPMatch then
    RequestParty_withdrawMember(self._selectIndex)
    return
  end
  local function partyOut()
    RequestParty_withdrawMember(self._selectIndex)
    PaGlobal_Raid_All:update()
  end
  local partyType = ToClient_GetPartyType()
  local messageBoxMemo = ""
  if 0 == partyType then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_GETOUTPARTY")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_DISTRIBUTION_GETOUTPARTY")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = partyOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  PaGlobal_Raid_All:update()
end
function PaGlobal_Raid_All:setCrossPlayIcon(targetControl, platformType)
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
function PaGlobal_Raid_All:naviGuide(index)
  if nil == self._partyMemberData[index] then
    return
  end
  local memberData = RequestParty_getPartyMemberAt(self._partyMemberData[index]._index)
  if nil == memberData then
    return
  end
  local position = float3(memberData:getPositionX(), memberData:getPositionY(), memberData:getPositionZ())
  ToClient_DeleteNaviGuideByGroup(0)
  worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
end
function PaGlobal_Raid_All:setRoseWarCamp()
  if self._ui.stc_campKama:GetShow() == true or self._ui.stc_campOdyl:GetShow() == true then
    return
  end
  self._ui.stc_campKama:SetShow(false)
  self._ui.stc_campOdyl:SetShow(false)
  if _ContentsGroup_RoseWar == true then
    if ToClient_GetRoseWarState() ~= __eRoseWar_Start then
      return
    end
    local selfPlayer = getSelfPlayer()
    local roseWarTeamNo = selfPlayer:getRoseWarTeamNo()
    if roseWarTeamNo == __eRoseWarTeam_Kamasylvia then
      self._ui.stc_campBasic:SetShow(false)
      self._ui.stc_campKama:SetShow(true)
    elseif roseWarTeamNo == __eRoseWarTeam_Odyllita then
      self._ui.stc_campBasic:SetShow(false)
      self._ui.stc_campOdyl:SetShow(true)
    end
  end
end
