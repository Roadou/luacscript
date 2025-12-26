function PaGlobal_LocalWarInfo_All_New_Open()
  PaGlobal_LocalWarInfo_All_New:prepareOpen()
end
function PaGlobal_LocalWarInfo_All_New_Close()
  PaGlobal_LocalWarInfo_All_New:prepareClose()
end
function PaGlobal_LocalWarInfo_All_New_ShowAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_LocalWarInfo_All, 0, 0.3)
end
function PaGlobal_LocalWarInfo_All_New_HideAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local hideAni = UIAni.AlphaAnimation(0, Panel_LocalWarInfo_All, 0, 0.2)
  hideAni:SetHideAtEnd(true)
end
function PaGlobal_LocalWarInfo_All_New_UpdateServerList(list_content, key)
  local id = Int64toInt32(key)
  local rdo_btn = UI.getChildControl(list_content, "StaticText_LocalWar_Rule")
  local stc_bg = UI.getChildControl(list_content, "Static_BG_1")
  local txt_channel = UI.getChildControl(stc_bg, "StaticText_Channel")
  local txt_joinMemberCount = UI.getChildControl(stc_bg, "StaticText_JoinMemberCount")
  local txt_remainTime = UI.getChildControl(stc_bg, "StaticText_RemainTime")
  local btn_join = UI.getChildControl(stc_bg, "Button_Join")
  local btn_seasonIcon = UI.getChildControl(stc_bg, "Static_Icon_Season")
  local btn_disableCamo = UI.getChildControl(stc_bg, "Static_Icon_DisableCamo")
  stc_bg:addInputEvent("Mouse_On", "")
  stc_bg:addInputEvent("Mouse_Out", "")
  rdo_btn:addInputEvent("Mouse_LUp", "")
  rdo_btn:SetText("")
  rdo_btn:SetShow(false)
  stc_bg:SetShow(false)
  rdo_btn:setNotImpactScrollEvent(true)
  stc_bg:setNotImpactScrollEvent(true)
  rdo_btn:SetShow(false)
  stc_bg:SetShow(true)
  local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_RedBattleField, id)
  if nil == roomInfoWrapper then
    return
  end
  stc_bg:SetShow(true)
  local getJoinMemberCount = roomInfoWrapper:getMatchedCount()
  local getCurrentState = roomInfoWrapper:getIsMatching()
  local channelName = roomInfoWrapper:getTitle()
  local getRemainTime = roomInfoWrapper:getLeftEnterTime()
  local warTimeMinute = math.floor(Int64toInt32(getRemainTime / toInt64(0, 60)))
  local warTimeSecond = Int64toInt32(getRemainTime) % 60
  local getFieldKey = roomInfoWrapper:getFieldMapKey()
  local fieldNameString = ToClient_getRedBattleFieldRoomTypeString(getFieldKey)
  local getUniqueIndex = roomInfoWrapper:getUniqueIndex()
  local isSeasonOnly = ToClient_isSeasonRedBattleField(getFieldKey)
  local isDisableCamouflage = ToClient_isDisableCamouflageRedBattleField(getFieldKey)
  local getMatchingUserCount = roomInfoWrapper:getMatchingUserCount()
  local warTime = ""
  local joinMemberCountString = 0
  if 0 == getCurrentState then
    warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
    joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
  elseif 1 == getCurrentState then
    warTime = PAGetString(Defines.StringSheet_RESOURCE, "LUA_REDBATTLEFIELDINFO_MACHING_NEW")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
    joinMemberCountString = tostring(getMatchingUserCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
  elseif 2 == getCurrentState then
    warTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
    joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
  else
    warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
    btn_join:SetIgnore(true)
    joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
  end
  txt_channel:SetShow(true)
  txt_joinMemberCount:SetShow(true)
  txt_remainTime:SetShow(true)
  btn_join:SetShow(true)
  txt_channel:SetText(fieldNameString .. " - " .. tostring(id + 1))
  if ToClient_SelfPlayerIsGM() == true then
    txt_channel:SetText(txt_channel:GetText() .. " (" .. tostring(channelName) .. " )")
  end
  btn_seasonIcon:SetShow(isSeasonOnly)
  btn_disableCamo:SetShow(isDisableCamouflage)
  txt_remainTime:SetText(warTime)
  txt_joinMemberCount:SetText(joinMemberCountString)
  btn_join:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_New_JoinLocalWar(" .. tostring(id) .. "," .. tostring(isSeasonOnly) .. "," .. tostring(key) .. ")")
  btn_join:addInputEvent("Mouse_On", "HandleEventOn_LocalWarInfo_All_New_JoinLocalWarDesc(" .. tostring(id) .. ")")
  if true == isDisableCamouflage then
    if true == isSeasonOnly then
      btn_disableCamo:SetPosX(PaGlobal_LocalWarInfo_All_New._originalCamoPosX)
    else
      btn_disableCamo:SetPosX(btn_seasonIcon:GetPosX())
    end
  end
end
function HandleEventOnOut_LocalWarInfo_All_SeasonIconTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local txt_title = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_TOOLTIP_SEASON_NAME")
  local txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_TOOLTIP_SEASON_DESC")
  TooltipSimple_Show(PaGlobal_LocalWarInfo_All_New._ui._txt_season, txt_title, txt_desc)
end
function HandleEventOnOut_LocalWarInfo_All_DisableCamoIconTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local txt_title = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_TOOLTIP_DISABLECAMO_NAME")
  local txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_TOOLTIP_DISABLECAMO_DESC")
  TooltipSimple_Show(PaGlobal_LocalWarInfo_All_New._ui._txt_disableCamo, txt_title, txt_desc)
end
function PaGlobal_LocalWarInfo_All_New_InformationUpdate(deltaTime)
  if nil == Panel_LocalWarInfo_All or false == Panel_LocalWarInfo_All:GetShow() then
    return
  end
  local penaltyControl = PaGlobal_LocalWarInfo_All_New._ui._penalty
  local penaltyMaxSize = PaGlobal_LocalWarInfo_All_New._maxPenaltySize
  local ruleControl = PaGlobal_LocalWarInfo_All_New._ui._rule
  local ruleMaxSize = PaGlobal_LocalWarInfo_All_New._maxRuleSize
  local explanationControl = PaGlobal_LocalWarInfo_All_New._ui._explanation
  local explanationMaxSize = PaGlobal_LocalWarInfo_All_New._maxExplanationSize
  local frame = PaGlobal_LocalWarInfo_All_New._ui._frame_desc
  local vScroll = frame:GetVScroll()
  local content = frame:GetFrameContent()
  local SpeedTime = PaGlobal_LocalWarInfo_All_New._rule_ani_SpeedTime
  if penaltyControl._txt_title:IsCheck() then
    local value = penaltyControl._stc_background:GetSizeY() + (penaltyMaxSize - penaltyControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    penaltyControl._stc_background:SetSize(penaltyControl._stc_background:GetSizeX(), value)
    penaltyControl._stc_background:SetShow(true)
  else
    local value = penaltyControl._stc_background:GetSizeY() - (penaltyMaxSize + penaltyControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    penaltyControl._stc_background:SetSize(penaltyControl._stc_background:GetSizeX(), value)
    if penaltyControl._stc_background:GetSizeY() <= 10 then
      penaltyControl._stc_background:SetShow(false)
    end
  end
  if ruleControl._txt_title:IsCheck() then
    local value = ruleControl._stc_background:GetSizeY() + (ruleMaxSize - ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    ruleControl._stc_background:SetShow(true)
  else
    local value = ruleControl._stc_background:GetSizeY() - (ruleMaxSize + ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    if ruleControl._stc_background:GetSizeY() <= 10 then
      ruleControl._stc_background:SetShow(false)
    end
  end
  if explanationControl._txt_title:IsCheck() then
    local value = explanationControl._stc_background:GetSizeY() + (explanationMaxSize - explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    explanationControl._stc_background:SetShow(true)
  else
    local value = explanationControl._stc_background:GetSizeY() - (explanationMaxSize + explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    if explanationControl._stc_background:GetSizeY() <= 10 then
      explanationControl._stc_background:SetShow(false)
    end
  end
  penaltyControl._stc_background:SetPosY(penaltyControl._txt_title:GetPosY() + penaltyControl._txt_title:GetSizeY())
  if penaltyControl._stc_background:GetShow() then
    ruleControl._txt_title:SetPosY(penaltyControl._stc_background:GetPosY() + penaltyControl._stc_background:GetSizeY() + 10)
  else
    ruleControl._txt_title:SetPosY(penaltyControl._txt_title:GetPosY() + penaltyControl._txt_title:GetSizeY() + 5)
  end
  ruleControl._stc_background:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY())
  if ruleControl._stc_background:GetShow() then
    explanationControl._txt_title:SetPosY(ruleControl._stc_background:GetPosY() + ruleControl._stc_background:GetSizeY() + 10)
  else
    explanationControl._txt_title:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY() + 5)
  end
  explanationControl._stc_background:SetPosY(explanationControl._txt_title:GetPosY() + explanationControl._txt_title:GetSizeY())
  for _, control in pairs(penaltyControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < penaltyControl._stc_background:GetSizeY())
  end
  for _, control in pairs(ruleControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < ruleControl._stc_background:GetSizeY())
  end
  for _, control in pairs(explanationControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < explanationControl._stc_background:GetSizeY())
  end
  PaGlobal_LocalWarInfo_All_New._updateDeltaTime = PaGlobal_LocalWarInfo_All_New._updateDeltaTime - deltaTime
  if PaGlobal_LocalWarInfo_All_New._updateDeltaTime <= 0 then
    ToClient_requestInstanceFieldRoomList(false, __eInstanceContentsType_RedBattleField)
    PaGlobal_LocalWarInfo_All_New._updateDeltaTime = 10
  end
end
function PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  if nil == player then
    return
  end
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local isGameMaster = ToClient_SelfPlayerIsGM()
  if true == player:isCompetitionDefined() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
    return
  end
  if 0 == ToClient_GetMyTeamNoRedBattleField() then
    if true == Panel_LocalWarInfo_All:GetShow() then
      PaGlobal_LocalWarInfo_All_New_Close()
    else
      PaGlobal_LocalWarInfo_All_New_Open()
    end
    return
  end
  local getOut = function()
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITPOSITION_POSSIBLE"))
      return
    end
    ToClient_UnJoinInstanceFieldForAll()
    PaGlobal_LocalWarInfo_All_New_Close()
  end
  if hp == maxHp or isGameMaster then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_GETOUT_MEMO"),
      functionYes = getOut,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function HandleEventLUp_LocalWarInfo_All_DescriptionCheck(descType)
  local frame = PaGlobal_LocalWarInfo_All_New._ui._frame_desc
  local vScroll = frame:GetVScroll()
  vScroll:SetControlTop()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  PaGlobal_LocalWarInfo_All_New._openDesc = descType
  if 0 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._penalty._stc_background:SetShow(true)
  elseif 1 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._rule._stc_background:SetShow(true)
  elseif 2 == descType then
    PaGlobal_LocalWarInfo_All_New._ui._explanation._stc_background:SetShow(true)
  else
    PaGlobal_LocalWarInfo_All_New._openDesc = -1
  end
end
function HandleEventOn_LocalWarInfo_All_New_JoinLocalWarDesc(mapKey)
  local self = PaGlobal_LocalWarInfo_All_New
  local selfKeyIndex = self._eMapKeyIndex
  if mapKey == selfKeyIndex._OCCUPATION or mapKey == selfKeyIndex._SEASONOCCUPATION or mapKey == selfKeyIndex._DISABLEOCCUPATION or mapKey == selfKeyIndex._SEASONDISABLEOCCUPATION then
    isOccupation = true
  else
    isOccupation = false
  end
  if self._isOccupationDesc == isOccupation then
    return
  end
  self._isOccupationDesc = isOccupation
  self._maxRuleSize = 40
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  local ruleStringHeader = "LUA_LOCALWARINFO_DESC_RULETEXT_"
  if true == isOccupation then
    ruleStringHeader = "LUA_JOIN_LOCALWAR_1_RULE"
  end
  for index = 1, self._ruleCount do
    local control = self._ui._rule._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    if index == 2 then
      control:SetText(PAGetStringParam2(Defines.StringSheet_GAME, ruleStringHeader .. tostring(index), "playTime", ToClient_GetPlayingTimeRedBattleField() / 60, "intrusionTime", ToClient_GetIntrusionTimeRedBattleField() / 60))
    else
      control:SetText(PAGetString(Defines.StringSheet_GAME, ruleStringHeader .. tostring(index)))
    end
    self._maxRuleSize = self._maxRuleSize + control:GetTextSizeY()
  end
  for index = 0, #self._ui._rule._txt_content do
    self._ui._rule._txt_content[index]:SetPosX(5)
  end
  self._ui._rule._txt_content[0]:SetPosY(5)
  self._ui._rule._txt_content[1]:SetPosY(self._ui._rule._txt_content[0]:GetPosY() + self._ui._rule._txt_content[0]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[2]:SetPosY(self._ui._rule._txt_content[1]:GetPosY() + self._ui._rule._txt_content[1]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[3]:SetPosY(self._ui._rule._txt_content[2]:GetPosY() + self._ui._rule._txt_content[2]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[4]:SetPosY(self._ui._rule._txt_content[3]:GetPosY() + self._ui._rule._txt_content[3]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[5]:SetPosY(self._ui._rule._txt_content[4]:GetPosY() + self._ui._rule._txt_content[4]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[6]:SetPosY(self._ui._rule._txt_content[5]:GetPosY() + self._ui._rule._txt_content[5]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[7]:SetPosY(self._ui._rule._txt_content[6]:GetPosY() + self._ui._rule._txt_content[6]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[8]:SetPosY(self._ui._rule._txt_content[7]:GetPosY() + self._ui._rule._txt_content[7]:GetTextSizeY() + 2)
  self._ui._frame_desc:UpdateContentScroll()
  self._ui._frame_desc:UpdateContentPos()
end
function HandleEventLUp_LocalWarInfo_All_New_JoinLocalWar(index, isSeasonOnly, uiKeyIndex)
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_RedBattleField)
  if nil == index or index > roomCount then
    return
  end
  local roomName = ""
  local uiContent = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:GetContentByKey(toInt64(0, uiKeyIndex))
  if nil ~= uiContent then
    local bg = UI.getChildControl(uiContent, "Static_BG_1")
    roomName = UI.getChildControl(bg, "StaticText_Channel"):GetText()
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  if nil == player then
    return
  end
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local isSeasonCharacter = player:isSeasonCharacter()
  local isHardCoreCharacter = ToClient_isHardCoreCharacter()
  local isPremiumCharacter = ToClient_isPremiumCharacter()
  local getLevel = player:getLevel()
  if isHardCoreCharacter == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterHardCoreCharacter"))
    return
  end
  if isPremiumCharacter == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterPremiumCharacter"))
    return
  end
  if true == isSeasonOnly then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_TOOLTIP_SEASON_DESC"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if false == isSeasonCharacter then
      MessageBox.showMessageBox(messageBoxData)
      return
    end
    local limitAttack = ToClient_GetAttackForLimitedRedBattleField()
    local limitDefence = ToClient_GetDefenseForLimitedRedBattleField()
    local limitADSum = ToClient_GetADSummaryForLimitedRedBattleField()
    local isMineADSum = ToClient_getOffence() + ToClient_getDefence()
    local awakenOffenceValue = ToClient_getAwakenOffence()
    local isMineADSumWithAwk = awakenOffenceValue + ToClient_getDefence()
    if limitAttack <= ToClient_getOffence() or limitDefence <= ToClient_getDefence() or limitAttack <= awakenOffenceValue or limitADSum <= isMineADSum or limitADSum <= isMineADSumWithAwk then
      MessageBox.showMessageBox(messageBoxData)
      return
    end
  end
  local function joinLocalWar()
    if player:getLevel() < 50 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVELLIMIT"))
      return
    end
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    if player:doRideMyVehicle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
      return
    elseif ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
      return
    end
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_LOCALWARINFO"))
      return
    end
    local appliedBuff = playerWrapper:getAppliedBuffBegin(true)
    local notJoinableDebeffCount = 0
    local self = PaGlobal_LocalWarInfo_All_New
    while appliedBuff ~= nil do
      local appliedBuffKey = appliedBuff:getBuffKey()
      local hasJoinableDebuff = false
      for idx = 1, #self._joinableDebeffTable do
        local joinableDebeffKey = self._joinableDebeffTable[idx]
        if joinableDebeffKey == appliedBuffKey then
          hasJoinableDebuff = true
        end
      end
      if false == hasJoinableDebuff then
        notJoinableDebeffCount = notJoinableDebeffCount + 1
      end
      appliedBuff = getSelfPlayer():getAppliedBuffNext(true)
    end
    if notJoinableDebeffCount > 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANNOTJOIN_DEBUFF"))
      return
    end
    local rightHandItemWrapper = ToClient_getEquipmentItem(0)
    local isFishingRod = false
    if nil ~= rightHandItemWrapper then
      local equipType = rightHandItemWrapper:getStaticStatus():getEquipType()
      isFishingRod = 44 == equipType
    end
    if isFishingRod == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_MSG_EQUIPMENT"))
      return
    end
    if ToClient_isPremiumCharacter() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterPremiumCharacter"))
      return
    end
    if hp == maxHp or true == ToClient_SelfPlayerIsGM() then
      local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_RedBattleField, index)
      if roomInfoWrapper == nil then
        return
      end
      local fieldMapKey = roomInfoWrapper:getFieldMapKey()
      local instanceFieldKey = roomInfoWrapper:getFieldKey()
      local roomState = roomInfoWrapper:getIsMatching()
      if instanceFieldKey:isDefined() == false then
        return
      end
      if roomState == 2 then
        ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_RedBattleField, index)
      else
        ToClient_requestJoinMatching(__eMatchMode_Normal, __eInstanceContentsType_RedBattleField, instanceFieldKey:getMode(), fieldMapKey, 0)
      end
      if true == _ContentsGroup_RenewUI then
        PaGlobal_LocalWarInfo_All_New_Close()
        local selfPlayer = getSelfPlayer()
        if nil == selfPlayer then
          return
        end
        if false == selfPlayer:isInstancePlayer() and false == getPvPMode() then
          local messageData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
            content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
            functionCancel = MessageBox_Empty_function,
            isLoading = true,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0,
            btnCancelText = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_APPLY_WITHOUT_KEY")
          }
          MessageBox.showMessageBox(messageData)
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CHANNELMOVE", "channelName", roomName),
    functionYes = joinLocalWar,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_LocalWarInfo_All_ResizePanel()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_LocalWarInfo_All:SetPosX((screenSizeX - Panel_LocalWarInfo_All:GetSizeX()) / 2)
  Panel_LocalWarInfo_All:SetPosY((screenSizeY - Panel_LocalWarInfo_All:GetSizeY()) / 2)
end
function FromClient_LocalWarInfo_All_New_UpdateLocalWarStatus()
  if false == Panel_LocalWarInfo_All:GetShow() then
    return
  end
  PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:requestUpdateVisible()
end
function FromClient_LocalWarInfo_All_New_UpdateInstanceRoom(needUIRefresh)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if Panel_LocalWarInfo_All:GetShow() == false then
    return
  end
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_RedBattleField)
  if roomCount <= 0 then
    return
  end
  if needUIRefresh == true then
    PaGlobal_LocalWarInfo_All_New:createInstanceRoomList()
  else
    for idx = 0, roomCount - 1 do
      local uiContent = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:GetContentByKey(toInt64(0, idx))
      local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_RedBattleField, idx)
      if uiContent ~= nil and roomInfoWrapper ~= nil then
        local bg = UI.getChildControl(uiContent, "Static_BG_1")
        if bg ~= nil then
          local getRemainTime = roomInfoWrapper:getLeftEnterTime()
          local getCurrentState = roomInfoWrapper:getIsMatching()
          local roomName = roomInfoWrapper:getTitle()
          local getJoinMemberCount = roomInfoWrapper:getMatchedCount()
          local getMatchingUserCount = roomInfoWrapper:getMatchingUserCount()
          local warTimeMinute = math.floor(Int64toInt32(getRemainTime / toInt64(0, 60)))
          local warTimeSecond = Int64toInt32(getRemainTime) % 60
          local warTime = ""
          local joinMemberCountString = 0
          local txt_remainTime = UI.getChildControl(bg, "StaticText_RemainTime")
          local txt_joinMemberCount = UI.getChildControl(bg, "StaticText_JoinMemberCount")
          local btn_join = UI.getChildControl(bg, "Button_Join")
          if 0 == getCurrentState then
            warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
            btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
            btn_join:SetIgnore(false)
            joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
          elseif 1 == getCurrentState then
            warTime = PAGetString(Defines.StringSheet_RESOURCE, "LUA_REDBATTLEFIELDINFO_MACHING_NEW")
            btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
            btn_join:SetIgnore(false)
            joinMemberCountString = tostring(getMatchingUserCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
          elseif 2 == getCurrentState then
            warTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
            btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
            btn_join:SetIgnore(false)
            joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
          else
            warTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN")
            btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
            btn_join:SetIgnore(true)
            joinMemberCountString = tostring(getJoinMemberCount) .. " / " .. tostring(PaGlobal_LocalWarInfo_All_New._maxPlayerCount)
          end
          txt_remainTime:SetText(warTime)
          txt_joinMemberCount:SetText(joinMemberCountString)
        end
      end
    end
  end
end
function PaGlobal_LocalWarInfo_All_ShowRewardTooltip(isWin, isShow)
  if Panel_LocalWarInfo_All == nil then
    return
  end
  local self = PaGlobal_LocalWarInfo_All_New
  if self == nil then
    return
  end
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local targetSlot, itemSSW
  if isWin == true then
    targetSlot = UI.getChildControl(self._ui._stc_winRewardSlotBG, "Static_WinSlot")
    itemSSW = getItemEnchantStaticStatus(ToClient_GetRedBattleFieldRewardItemKey(true))
  else
    targetSlot = UI.getChildControl(self._ui._stc_loseRewardSlotBG, "Static_LoseSlot")
    itemSSW = getItemEnchantStaticStatus(ToClient_GetRedBattleFieldRewardItemKey(false))
  end
  if targetSlot == nil or itemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, targetSlot, true, false)
  end
end
