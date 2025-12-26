function PaGlobal_GuildBossField_Enter_All_Open()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  PaGlobal_GuildBossField_Enter_All:prepareOpen()
end
function PaGlobal_GuildBossField_Enter_All_Close()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  if PaGlobal_GuildBossField_Enter_All._isShowEffect == true then
    return
  end
  PaGlobal_GuildBossField_Enter_All:prepareClose()
end
function PaGlobal_GuildBossField_Enter_All_UpdateEnterEffect(deltaTime)
  PaGlobal_GuildBossField_Enter_All:updateEnterEffect(deltaTime)
end
function PaGlobal_GuildBossField_Enter_All_CheckChangeState(bossKey, isEnter, isCheckDirectChange)
  if _ContentsGroup_GuildBossField == false then
    return false
  end
  if bossKey == nil then
    return false
  end
  if ToClient_CheckMirrorFieldDelayTime(true) == false then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return false
  end
  if selfPlayer:isMurdererStateBeing() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithMurderer"))
    return false
  end
  if selfPlayerWrapper:isDefinedPvPMatch() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterPvp"))
    return false
  end
  if selfPlayer:isPreemptiveStrikeBeing() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterPvp"))
    return false
  end
  if selfPlayer:isPvPMode() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWithPvPMode"))
    return false
  end
  local vehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
  if vehicleProxy ~= nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    return false
  end
  local selfPlayerPosition = selfPlayer:getPosition()
  local checkWaitAction = true
  if isEnter == true then
    local curChannelData = getCurrentChannelServerData()
    if curChannelData == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterByAccessServer"))
      return false
    end
    if true == curChannelData._isSiegeChannel or true == curChannelData:isPVPServer() or true == curChannelData._isInstanceChannel then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterByAccessServer"))
      return false
    end
    if ToClient_IsEnterBasicField() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldCurrentPosition"))
      return false
    end
    if ToClient_IsEnterMirrorField() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldCurrentPosition"))
      return false
    end
    if ToClient_IsInGuildBossFieldPos(bossKey) == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldCurrentPosition"))
      return false
    end
  else
    if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
      return false
    end
    if ToClient_CheckActorInsideMirrorField(selfPlayerPosition) == false then
      checkWaitAction = false
    end
  end
  if isCheckDirectChange == true and checkWaitAction == true and IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
    return false
  end
  return true
end
function FromClient_GuildBossField_Enter_All_Resize()
  if Panel_Widget_GuildBossField_Enter == nil then
    return
  end
  local screenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  Panel_Widget_GuildBossField_Enter:SetSize(screenSize.x, screenSize.y)
  Panel_Widget_GuildBossField_Enter:SetPosX(0)
  Panel_Widget_GuildBossField_Enter:SetPosY(0)
  PaGlobal_GuildBossField_Enter_All._ui._stc_blackBG:SetSize(screenSize.x, screenSize.y)
  Panel_Widget_GuildBossField_Enter:ComputePosAllChild()
end
function FromClient_GuildBossField_Enter_All_UpdateEnterState(isEnter)
  PaGlobal_GuildBossField_Enter_All_Open()
  PaGlobalFunc_Guild_BossSummon_All_UpdateMirrorFieldState()
end
