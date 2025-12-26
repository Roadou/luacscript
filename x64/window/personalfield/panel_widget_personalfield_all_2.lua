function PaGlobal_Widget_PersonalField_All_Open()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  PaGlobal_Widget_PersonalField_All:prepareOpen()
end
function PaGlobal_Widget_PersonalField_All_Close()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  PaGlobal_Widget_PersonalField_All:prepareClose()
end
function PaGlobal_Widget_PersonalField_All_SetRemainTimeText(control)
  if nil == control then
    return
  end
  local seconds = ToClient_GetPersonalFieldLeftTime()
  if nil == seconds or seconds < 0 then
    seconds = 0
  end
  local clockTime = ""
  local clockHours = math.max(math.floor(seconds / 3600), 0)
  local clockMinutes = math.max(math.floor(seconds % 3600 / 60), 0)
  local clockSeconds = math.max(math.floor(seconds % 3600 % 60), 0)
  if clockHours > 0 then
    clockTime = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", tostring(clockHours)) .. " "
  end
  clockTime = clockTime .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", tostring(clockMinutes))
  local text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_LIGHTPEARLBUFF_TIME", "getPearlPackageTime", clockTime)
  control:SetText(text)
end
function PaGlobal_Widget_PersonalField_All_CheckChangeState(isEnter, isCheckDirectChange)
  if false == _ContentsGroup_PersonalField then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return false
  end
  local selfPlayerPosition = selfPlayer:getPosition()
  if true == isEnter then
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
      return false
    end
    if true == curChannelData._isSiegeChannel or true == curChannelData:isPVPServer() or true == curChannelData._isInstanceChannel then
      return false
    end
    local regionInfo = getRegionInfoByPosition(selfPlayerPosition)
    if nil == regionInfo or nil == regionInfo:get() then
      return false
    end
    if true == regionInfo:get():isSafeZone() then
      return false
    end
    local isBadPlayer = selfPlayer:getTendency() < 0
    if true == isBadPlayer then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithMurderer"))
      return false
    end
    if true == selfPlayer:isMurdererStateBeing() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithMurderer"))
      return false
    end
    if true == selfPlayerWrapper:isDefinedPvPMatch() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterPvp"))
      return false
    end
    if true == selfPlayer:isPreemptiveStrikeBeing() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterPvp"))
      return false
    end
    if true == selfPlayer:isPvPMode() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithPvPMode"))
      return false
    end
    if true == selfPlayer:hasParty() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithParty"))
      return false
    end
    local seconds = ToClient_GetPersonalFieldEnterDelayRemainTime()
    if seconds > 0 then
      local clockTime = ""
      local clockHours = math.max(math.floor(seconds / 3600), 0)
      local clockMinutes = math.max(math.floor(seconds % 3600 / 60), 0)
      local clockSeconds = math.max(math.floor(seconds % 3600 % 60), 0)
      if clockHours > 0 then
        clockTime = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", tostring(clockHours)) .. " "
      end
      if clockMinutes > 0 then
        clockTime = clockTime .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", tostring(clockMinutes)) .. " "
      end
      clockTime = clockTime .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(clockSeconds))
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "GAME_MESSAGE_PERSONALFIELD_ENTERDELAYTIME", "time", clockTime))
      return false
    end
    local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByPosition(selfPlayerPosition)
    if nil == instanceSpawnWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRegionInfoNotExist"))
      return false
    end
  end
  local vehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
  if nil ~= vehicleProxy then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    return false
  end
  if true == isCheckDirectChange then
    if false == ToClient_CheckMirrorFieldDelayTime(true) then
      return false
    end
    local checkWaitAction = true
    if true == isEnter then
      local hp = selfPlayer:getHp()
      local maxHp = selfPlayer:getMaxHp()
      if hp ~= maxHp then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
        return false
      end
    else
      local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByPosition(selfPlayerPosition)
      if instanceSpawnWrapper == nil then
        checkWaitAction = false
      end
    end
    if checkWaitAction == true and false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
      return false
    end
  end
  return true
end
function HandleEventLUp_Widget_PersonalField_All_Navi()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  local naviPos = PaGlobal_Widget_PersonalField_All._naviPos
  if nil == naviPos then
    return
  end
  local isTopPicking = math.floor(naviPos.y) == 0
  local isAutoMove = false
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(naviPos, NavigationGuideParam(), isAutoMove, isTopPicking)
end
function HandleEventLUp_Widget_PersonalField_All_OpenEnterUI()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if nil ~= PaGlobal_Widget_PersonalField_Enter_All_Open then
    PaGlobal_Widget_PersonalField_Enter_All_Open(false)
  end
  if nil ~= Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() and nil ~= PaGlobal_PersonalField_Main_All_Close then
    PaGlobal_PersonalField_Main_All_Close()
  end
end
function HandleEventLUp_Widget_PersonalField_All_Leave()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) then
    return
  end
  local leavePersonalField = function()
    if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) then
      return
    end
    ToClient_EnterOrLeavePersonalField(false)
    if nil ~= Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() and nil ~= PaGlobal_PersonalField_Main_All_Close then
      PaGlobal_PersonalField_Main_All_Close()
    end
  end
  local leavePersonalRelayField = function()
    if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) then
      return
    end
    ToClient_LeavePersonalRelayField()
    if nil ~= Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() and nil ~= PaGlobal_PersonalField_Main_All_Close then
      PaGlobal_PersonalField_Main_All_Close()
    end
  end
  local messageBoxData
  local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
  if isEnterPersonalRelayField == true then
    messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALRELAYFIELD_EXIT_MSG"),
      functionYes = leavePersonalRelayField,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  else
    messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_EXIT"),
      functionYes = leavePersonalField,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  end
  if messageBoxData ~= nil then
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventOnOut_Widget_PersonalField_All_SetShowStateTooltip(isShow)
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_Widget_PersonalField_All._ui._stc_stateIcon
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  local serverState = PaGlobal_Widget_PersonalField_All._serverState
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
function FromClient_Widget_PersonalField_All_UpdatePersonalFieldState()
  PaGlobal_Widget_PersonalField_All_Open()
  if _ContentsGroup_HadumField == true and PaGlobalFunc_Widget_FunctionButton_UpdateAllButton ~= nil then
    PaGlobalFunc_Widget_FunctionButton_UpdateAllButton()
  end
end
function FromClient_Widget_PersonalField_All_UpdateRemainTime(isShowEffect)
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  PaGlobal_Widget_PersonalField_All:updateRemainTime()
  if true == isShowEffect then
    PaGlobal_Widget_PersonalField_Enter_All_Open(true)
    if nil ~= Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() and nil ~= PaGlobalFunc_PersonalField_Main_All_Update then
      PaGlobalFunc_PersonalField_Main_All_Update()
    end
  end
end
function FromClient_Widget_PersonalField_All_UpdateServerState()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  PaGlobal_Widget_PersonalField_All:updateServerState()
end
function FromClient_Widget_PersonalField_All_FromClient_UpdateCurrentLootingItemList()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  PaGlobal_Widget_PersonalField_All:updateItemList()
end
function FromClient_Widget_PersonalField_All_ShowServerSelect()
  if nil ~= Panel_Widget_PersonalField_Enter and true == Panel_Widget_PersonalField_Enter:GetShow() and nil ~= PaGlobal_Widget_PersonalField_Enter_All_Close then
    PaGlobal_Widget_PersonalField_Enter_All_Close()
  end
  if nil == PaGlobalFunc_ChannelSelect_All_Open then
    return
  end
  local showChannelSelect = function()
    PaGlobalFunc_ChannelSelect_All_Open(true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_POPUP_DESC"),
    functionYes = showChannelSelect,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_Widget_PersonalField_All_ResizePanel()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  Panel_Widget_PersonalField_Mini:ComputePosAllChild()
end
function GuildBossField_Enter()
  if _ContentsGroup_GuildBossField == false then
    return
  end
  local bossKey = BossSpawnKey(Int64toInt32(4))
  ToClient_EnterOrLeaveGuildBossField(true, bossKey)
end
function GuildBossField_Leave()
  if _ContentsGroup_GuildBossField == false then
    return
  end
  local bossKey = BossSpawnKey(Int64toInt32(4))
  ToClient_EnterOrLeaveGuildBossField(false, bossKey)
end
