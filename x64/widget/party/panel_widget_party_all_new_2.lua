function PaGlobalFunc_Widget_Party_All_Open()
  PaGlobal_Party_All:prepareOpen()
end
function PaGlobalFunc_Widget_Party_All_Close()
  PaGlobal_Party_All:prepareClose()
end
function HandleEventLUp_Party_All_ShowGradeListToggle()
  PaGlobal_Party_All:showGradeListToggle()
end
function HandleEventLUp_Party_All_ShowMarketOptionToggle()
  PaGlobal_Party_All:showMarketOptionToggle()
end
function HandleEventOnOut_Party_All_New_ShowButton()
  if PaGlobal_Party_All._ui_pc.stc_OptionBg:GetShow() == true then
    PaGlobal_Party_All._ui_pc.stc_buttonBG:SetShow(UI.checkIsInMouseAndEventPanel(Panel_Widget_Party_All))
  else
    PaGlobal_Party_All._ui_pc.stc_buttonBG_Mini:SetShow(UI.checkIsInMouseAndEventPanel(Panel_Widget_Party_All))
  end
end
function HandleEventLUp_Party_All_ToggleDragMove(type)
  if type == "mini" then
    local isChecked = PaGlobal_Party_All._ui_pc.chk_dragToggle_Mini:IsCheck()
    Panel_Widget_Party_All:SetDragEnable(not isChecked)
    PaGlobal_Party_All._ui_pc.chk_dragToggle:SetCheck(isChecked)
  else
    local isChecked = PaGlobal_Party_All._ui_pc.chk_dragToggle:IsCheck()
    Panel_Widget_Party_All:SetDragEnable(not isChecked)
    PaGlobal_Party_All._ui_pc.chk_dragToggle_Mini:SetCheck(isChecked)
  end
  HandleEventOnOut_Party_All_ToggleDragToolTip(type, true)
end
function HandleEventLUp_Party_All_ChangeMoney()
  Panel_NumberPad_Show(true, PaGlobal_Party_All._config.maxMoney, nil, PaGlobalFunc_Widget_Party_All_SetMoney)
end
function HandleEventLUp_Party_All_SetRegistItem()
  PaGlobal_Party_All:setRegistItem()
end
function HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip(btnType, isShow)
  PaGlobal_Party_All:showSpecialGoodsTooltip(btnType, isShow)
end
function HandleEventLUp_Party_All_SelectPartyFollow(index)
  PaGlobal_Party_All:selectPartyFollow(index)
end
function HandleEventOnOut_Party_All_ShowSimpleTooltip(isShow, tipType, index)
  if 4 == tipType then
    if true == isShow then
      PaGlobal_Party_All._isRootShowFlag = true
    else
      PaGlobal_Party_All._isRootShowFlag = false
    end
  end
  PaGlobal_Party_All:showSimpleTooltip(isShow, tipType, index)
end
function HandleEventOnOut_Party_All_ShowNameTooltip(isShow, index)
  if false == isShow then
    PaGlobal_Party_All:overPartyLeaveCheck(false, index)
    TooltipSimple_Hide()
    return
  end
  PaGlobal_Party_All:overPartyLeaveCheck(true, index)
  local name, desc, control
  local control = PaGlobal_Party_All._ui.stc_members[index].control
  if true == PaGlobal_Party_All._ui_pc.stc_optionBG_Mini:GetShow() then
    control = PaGlobal_Party_All._ui.stc_members_Mini[index].control
  end
  local partyData = PaGlobal_Party_All:getPartyDataAtIndex(index)
  if nil == partyData then
    return
  end
  TooltipSimple_Show(control, "", partyData._name)
end
function HandleEventRUp_Party_All_NaviGuide(index)
  PaGlobal_Party_All:partymemberNaviGuide(index)
end
function HandleEventLPress_Party_All_DragPanelAndSavePos()
  if PaGlobal_Party_All._ui_pc.chk_dragToggle:IsCheck() == true then
    return
  else
    local currentScreenSize = {
      x = getScreenSizeX(),
      y = getScreenSizeY()
    }
    local PosX = 0
    local PosY = 0
    local posX = Panel_Widget_Party_All:GetPosX()
    local posY = Panel_Widget_Party_All:GetPosY()
    Panel_Widget_Party_All:SetPosX(posX)
    Panel_Widget_Party_All:SetPosY(posY)
    local rateX = posX + Panel_Widget_Party_All:GetSizeX() / 2
    local rateY = posY + Panel_Widget_Party_All:GetSizeY() / 2
    Panel_Widget_Party_All:SetRelativePosX(rateX / currentScreenSize.x)
    Panel_Widget_Party_All:SetRelativePosY(rateY / currentScreenSize.y)
  end
end
function FromClient_UpdateMorningBossPartyAttribute(sunCount, moonCount, landCount)
  if Panel_Widget_Party_All == nil then
    return false
  end
  if FromClinet_AllCloseFullScreenUI ~= nil then
    FromClinet_AllCloseFullScreenUI()
  end
  PaGlobal_Party_All:updateMorningBossPartyAttribute(sunCount, moonCount, landCount)
end
function FromClient_ToggleMorningBossPartyAttribute(isShow)
  if Panel_Widget_Party_All == nil then
    return
  end
  if PaGlobal_Party_All._ui.stc_morningBossAttributeBg == nil then
    return
  end
  PaGlobal_Party_All._ui.stc_morningBossAttributeBg:SetShow(isShow)
end
function FromClient_Party_All_createPartyList()
  PaGlobal_Party_All:prepareOpen()
end
function FromClient_Party_All_updatePartyList()
  local memberCount = RequestParty_getPartyMemberCount()
  if memberCount <= 0 then
    PaGlobal_Party_All:prepareClose()
  else
    PaGlobal_Party_All:prepareOpen()
  end
end
function FromClient_Party_All_OnScreenResize()
  PaGlobal_Party_All:prepareOpen()
  PaGlobal_Party_All:resize()
end
function PaGlobalFunc_Widget_Party_All_Resize()
  PaGlobal_Party_All:prepareOpen()
end
function FromClient_Party_All_Invite(hostName, invitePartyType, platformNickname, platformType)
  PaGlobal_Party_All:invite(hostName, invitePartyType, platformNickname, platformType)
end
function FromClient_Party_All_Refuse(reason)
  PaGlobal_Party_All:refuse(reason)
end
function PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  local worldServerCount = getGameWorldServerDataCount()
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local lastServerName = getChannelName(worldServerData._worldNo, serverNo)
    if nil ~= lastServerName then
      return lastServerName
    end
  end
  return nil
end
function FromClient_Party_All_Accept(joinCharacterName, serverNo, platformNickname, platformType)
  local serverName = PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  if nil == serverName then
    return
  end
  local partyType = ToClient_GetPartyType()
  local partyTypeString = ""
  if partyType == __ePartyType_Normal then
    partyTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_PARTY_TITLE")
  else
    partyTypeString = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE")
  end
  local displayName = joinCharacterName
  if ToClient_isPS5() == true then
    if platformType ~= __eGAME_PLATFORM_TYPE_PS or platformNickname == nil or platformNickname == "" then
      displayName = joinCharacterName
    else
      displayName = joinCharacterName .. "[ " .. platformNickname .. " ]"
    end
  end
  local contentString = PAGetStringParam3(Defines.StringSheet_GAME, "PANEL_PARTY_INVITE_ACCEPT_OTHERSERVER", "serverName", serverName, "characterName", displayName, "partyType", partyTypeString)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_Party_All_JoinOtherServer(hostCharacterName, serverNo)
  local serverName = PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  if nil == serverName then
    return
  end
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_JOIN_OTHERSERVER", "serverName", serverName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = HandleEventLUp_GameExit_All_ServerChange,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_Party_All_ChangeLeader(actorKey)
  PaGlobal_Party_All:changeLeader(actorKey)
  FromClient_Party_All_UpdatePartyMatchingState()
end
function FromClient_Party_All_Withdraw(withdrawType, actorKey, isMe)
  PaGlobal_Party_All:withdraw(withdrawType, actorKey, isMe)
end
function FromClient_Party_All_PartyOption_Hide()
  if nil == Panel_Widget_Party_All then
    return false
  end
  PaGlobal_Party_All:showRegistItem(false)
  PaGlobal_Party_All:closePartyOption()
  PaGlobal_Party_All._ui_pc.chk_dropItem:SetCheck(false)
  PaGlobal_Party_All._ui_pc.chk_dropItem_Mini:SetCheck(false)
  PaGlobal_Party_All:showLootingType()
  return false
end
function FromClient_Party_All_NotifyPartyMemberPickupItem(userName, itemName)
  local message = ""
  message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM", "userName", userName, "itemName", itemName)
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_NotifyPartyMemberPickupItemFromPartyInventory(userName, itemName, itemCount)
  local message = ""
  message = PAGetStringParam3(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM_FOR_PARTYINVENTORY", "userName", userName, "itemName", itemName, "itemCount", tostring(itemCount))
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_RenderModeChange(prevRenderModeList, nextRenderModeList)
  PaGlobal_Party_All:renderModeChange(prevRenderModeList, nextRenderModeList)
end
function FromClient_Party_All_SetFollowActor(actorKey)
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local name = ""
  local nameType = ToClient_getChatNameType()
  local playerActorProxyWrapper
  playerActorProxyWrapper = getPlayerActor(actorKey)
  if __eChatNameType_NickName == nameType and nil ~= playerActorProxyWrapper then
    name = playerActorProxyWrapper:getUserNickname()
  else
    name = actorProxyWrapper:getName()
  end
  if nil ~= playerActorProxyWrapper and true == playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERNAME_CAMO")
  end
  if actorProxyWrapper:IsNeedHideNameForPVPServer() == true then
    name = PaGlobalFunc_getAnonymousNameString(0)
  end
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETFOLLOWACTOR_MSG", "name", tostring(name))
  Proc_ShowMessage_Ack(message)
end
function FromClient_Party_All_EndFollowActor()
end
function PaGlobalFunc_Widget_Party_All_GetMemberCount()
  return RequestParty_getPartyMemberCount()
end
function PaGlobalFunc_Widget_Party_All_GetShow()
  if nil == Panel_Widget_Party_All then
    return false
  end
  return Panel_Widget_Party_All:GetShow()
end
function PaGlobalFunc_Widget_Party_All_SetMoney(inputNum)
  PaGlobal_Party_All:setMoney(inputNum)
end
function PaGlobalFunc_Widget_Party_All_ConditionShow()
  PaGlobal_Party_All:partyConditionalShow()
end
function PaGlobalFunc_Widget_Party_All_SetMemberData(partyMemberCount)
  local partyData = {}
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil ~= memberData then
      local memberInfo = {}
      memberInfo._index = index
      memberInfo._isMaster = memberData._isMaster
      memberInfo._isOffline = memberData._isOffline
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
      memberInfo._serverNo = memberData._serverNo
      if memberInfo._index == 0 and false == memberInfo._isSelf then
        UI.ASSERT_NAME(false, "_index = 0\235\138\148 \235\172\180\236\161\176\234\177\180 Self\236\151\172\236\149\188 \237\149\169\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
      end
      table.insert(partyData, memberInfo)
    end
  end
  return partyData
end
function PaGlobalFunc_Widget_Party_All_SetMemberDataConsole(partyMemberCount)
  local partyData = {}
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil ~= memberData then
      local memberInfo = {}
      memberInfo._index = index
      memberInfo._isMaster = memberData._isMaster
      memberInfo._isOffline = memberData._isOffline
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
      memberInfo._serverNo = memberData._serverNo
      if memberInfo._index == 0 and false == memberInfo._isSelf then
        UI.ASSERT_NAME(false, "_index = 0\235\138\148 \235\172\180\236\161\176\234\177\180 Self\236\151\172\236\149\188 \237\149\169\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
      end
      partyData[index] = memberInfo
    end
  end
  return partyData
end
function PaGlobalFunc_Widget_Party_All_CheckInParty(name)
  if false == PaGlobal_Party_All._isMemberDataLoad then
    return false
  end
  local retval = false
  for key, value in pairs(PaGlobal_Party_All._partyData) do
    if value._name == name then
      retval = true
      break
    end
  end
  return retval
end
function HandleEventOnOut_Party_All_ShowEnableValuepackToolTip(onoff)
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == _contentsGroup_valueBuffReduceTax then
    return
  end
  local control
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  if true == isMiniPartyUI then
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_mini_enable
  else
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_enable
  end
  if nil == control then
    return
  end
  if true == onoff then
    TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_ENABLE_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_ENABLE_DESC"))
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Party_All_ShowDisableValuepackToolTip(onoff)
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == _contentsGroup_valueBuffReduceTax then
    return
  end
  local control
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  if true == isMiniPartyUI then
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_mini_disable
  else
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_disable
  end
  if nil == control then
    return
  end
  if true == onoff then
    TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_DISABLE_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_DISABLE_DESC"))
  else
    TooltipSimple_Hide()
  end
end
function FromClient_PartyUpdateValuePackageIcon()
  if nil == Panel_Widget_Party_All then
    return
  end
  PaGlobal_Party_All:updateValuePackageIcon()
end
function FromClient_updatePartyLootType(lootType)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  PaGlobal_Party_All:updateLootType(lootType)
end
function FromClient_updatePartyDistributionOption(price_s64, itemGradeRaw)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_CHANGE_OPTION"))
  PaGlobal_Party_All:updatePartyDistributionOption()
end
function FromClient_updatePartyMemberHp(actorKeyRaw, hp, maxHp)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:getPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._currentHp = hp * 100
  partyData._maxHp = maxHp
  _PA_ASSERT(maxHp > 0, "maxHp\234\176\128 0\236\157\180\237\149\152 \236\158\133\235\139\136\235\139\164.")
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  local isDead = partyData._currentHp <= 0
  member._stc_deadState:SetShow(isDead)
  member._progress_hp:SetShow(not isDead)
  member._progress_mp:SetShow(not isDead)
  member._progress_hp:SetProgressRate(partyData._currentHp / partyData._maxHp)
end
function FromClient_updatePartyMemberMp(actorKeyRaw, mp, maxMp)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:getPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._currentMp = mp * 100
  partyData._maxMp = maxMp
  _PA_ASSERT(maxMp > 0, "maxMp\234\176\128 0\236\157\180\237\149\152 \236\158\133\235\139\136\235\139\164." .. tostring(maxMp))
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  member._progress_mp:SetProgressRate(partyData._currentMp / partyData._maxMp)
end
function FromClient_updatePartyMemberLevel(actorKeyRaw, level)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:getPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._level = level
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  member._txt_name:SetPosX(member._txt_level:GetPosX() + member._txt_level:GetTextSizeX() + 3)
  PaGlobal_Party_All:setPartyMember()
end
function FromClient_updatePartyMemberExpGrade(actorKeyRaw, expGrade)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:getPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._distance = expGrade
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  local control = member._stc_distanceWifi
  local wifiTexture = self._textureWifi[partyData._distance + 1]
  if nil == wifiTexture then
    return
  end
  control:ChangeTextureInfoNameAsync(self._textureWifi.path)
  local x1, y1, x2, y2 = setTextureUV_Func(control, wifiTexture[1], wifiTexture[2], wifiTexture[3], wifiTexture[4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobalFunc_Party_All_Update(deltaTime)
  local self = PaGlobal_Party_All
  self._updateTime = self._updateTime + deltaTime
  if self._updateTime < 1 then
    return
  end
  self._updateTime = 0
  self:checkPartyLeaderUI()
  if 0 < self._refCount then
    self:prepareOpen()
    self._refCount = 0
  end
end
function FromClient_Party_All_UpdatePartyMatchingState()
  if Panel_Widget_Party_All == nil then
    return
  end
  local self = PaGlobal_Party_All
  local partyMemberCount = RequestParty_getPartyMemberCount()
  local matchingState = ToClient_getPartyContentsMatchingState()
  local isMini = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  local isLeader = RequestParty_isLeader()
  self._ui.btn_memberBG_mini:SetShow(isLeader)
  self._ui.btn_memberBG:SetShow(isLeader)
  if matchingState == __ePartyContentsMatchingState_Matching and partyMemberCount < self._config.maxPartyCnt then
    local startPosY = self._ui.stc_memberTemplate:GetPosY() + self._ui.stc_Matching:GetSizeY()
    local startPosY_mini = self._ui.stc_memberTemplate_Mini:GetPosY() + self._ui.stc_MatchingMini:GetSizeY()
    if true == isMini then
      self._ui.stc_MatchingMini:SetShow(true)
      self._ui.stc_MatchingMini:SetSpanSize(self._ui.stc_MatchingMini:GetSpanSize().x, startPosY + (self._ui.stc_MatchingMini:GetSizeY() + self._config.gapY + 10) * partyMemberCount + 1)
      self._ui.stc_Matching:SetShow(false)
    else
      self._ui.stc_Matching:SetShow(true)
      self._ui.stc_Matching:SetSpanSize(self._ui.stc_Matching:GetSpanSize().x, startPosY + (self._ui.stc_Matching:GetSizeY() + self._config.gapY) * partyMemberCount + 1)
      self._ui.stc_MatchingMini:SetShow(false)
    end
  else
    self._ui.stc_Matching:SetShow(false)
    self._ui.stc_MatchingMini:SetShow(false)
  end
end
function PaGlobalFunc_Widget_Party_All_PartyContentsMatchingCancel()
  ToClient_requestPartyContentsRecurit(0, false)
end
function PaGlobalFunc_Party_Member_Effect(index)
  if nil == Panel_Widget_Party_All then
    return
  end
  local self = PaGlobal_Party_All
  local member = self._ui.stc_members_Mini[index + 1]
  if nil ~= member then
    member._effect:EraseAllEffect()
    member._effect:AddEffect("fUI_InGame_Light_07A", false, 0, 0)
  end
  member = self._ui.stc_members[index + 1]
  if nil ~= member then
    member._effect:EraseAllEffect()
    member._effect:AddEffect("fUI_InGame_Light_07A", false, 0, 0)
  end
end
function FromClient_ChangeUserNicknameDirectly_Party()
  if Panel_Widget_Party_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Party_All
  if self == nil then
    return
  end
  self:update()
end
function HandleEventOnOut_Party_All_ToggleDragToolTip(type, show)
  if show == false then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  local desc = ""
  if type == "mini" then
    control = PaGlobal_Party_All._ui_pc.chk_dragToggle_Mini
  else
    control = PaGlobal_Party_All._ui_pc.chk_dragToggle
  end
  if control:IsCheck() == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_DESC")
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
