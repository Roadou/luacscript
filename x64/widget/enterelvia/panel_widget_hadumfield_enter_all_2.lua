function PaGlobal_Widget_HadumField_Enter_All_Open(isShowEffect)
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  if isShowEffect == true then
    PaGlobal_Widget_HadumField_Enter_All:prepareOpen(isShowEffect)
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All._isShowEffect == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if ToClient_IsEnterHadumField() == true then
    if PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave ~= nil then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ELVIA_TOOLTIP_TITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_ELVIA_MSG_EXIT"),
        functionYes = PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    return
  end
  PaGlobal_Widget_HadumField_Enter_All:prepareOpen(isShowEffect)
end
function PaGlobal_Widget_HadumField_Enter_All_Close()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All._isShowEffect == true then
    return
  end
  PaGlobal_Widget_HadumField_Enter_All:prepareClose()
end
function PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction()
  if isDoingAction("ENTER_TO_HADUMFIELD") == true or isDoingAction("ENTER_TO_HADUMFIELD_ING") == true or isDoingAction("ENTER_TO_HADUMFIELD_END") == true then
    return true
  end
  return false
end
function PaGlobal_Widget_HadumField_Enter_All_UpdateEnterEffect(deltaTime)
  PaGlobal_Widget_HadumField_Enter_All:updateEnterEffect(deltaTime)
end
function PaGlobal_Widget_HadumField_Enter_All_IsShowEnterButton()
  if Panel_Widget_HadumField_Enter == nil then
    return false
  end
  if _ContentsGroup_HadumField == false then
    return false
  end
  local curChannelData = getCurrentChannelServerData()
  if curChannelData == nil then
    return false
  end
  if curChannelData._isSiegeChannel == true or curChannelData._isInstanceChannel == true or curChannelData._isHadumChannel == false then
    return false
  end
  if ToClient_IsEnterMirrorField() == true then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper ~= nil then
    local selfPlayer = selfPlayerWrapper:get()
    if selfPlayer ~= nil and selfPlayer:isCompetitionDefined() == true then
      return false
    end
  end
  return true
end
function PaGlobal_Widget_HadumField_All_CheckChangeState(isOnlyCheck)
  if Panel_Widget_HadumField_Enter == nil then
    return false
  end
  if _ContentsGroup_HadumField == false then
    return false
  end
  local curChannelData = getCurrentChannelServerData()
  if curChannelData == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterByAccessServer"))
    return false
  end
  if curChannelData._isSiegeChannel == true or curChannelData._isInstanceChannel == true or curChannelData._isHadumChannel == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterByAccessServer"))
    return false
  end
  if ToClient_IsEnterMirrorField() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoBehaviorInPersonalField"))
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
  if selfPlayer:isCompetitionDefined() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldCurrentPosition"))
    return false
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return false
  end
  local vehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
  if vehicleProxy ~= nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
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
  if selfPlayer:getInventory():getTradeItemCount() > toInt64(0, 0) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldHaveTradeItem"))
    return false
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if houseWrapper ~= nil then
    local isAccessEnter = true
    local houseCharacterWrapper = houseWrapper:getStaticStatusWrapper()
    if houseCharacterWrapper ~= nil then
      local houseObjectWrapper = houseCharacterWrapper:getObjectStaticStatus()
      if houseObjectWrapper ~= nil and houseObjectWrapper:isFixedHouse() == false and houseObjectWrapper:isInnRoom() == false and houseObjectWrapper:isMansionLand() == false then
        isAccessEnter = false
      end
    end
    if isAccessEnter == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHadumFieldVisitHouse"))
      return false
    end
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
    return false
  end
  return true
end
function PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All._isShowEffect == true then
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction() == true then
    return
  end
  if PaGlobal_Widget_HadumField_All_CheckChangeState(false) == false then
    return
  end
  ToClient_EnterOrLeaveHadumField()
  PaGlobal_Widget_HadumField_Enter_All:prepareClose()
end
function FromClient_Widget_HadumField_Enter_All_ResizePanel()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  local screenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  Panel_Widget_HadumField_Enter:SetSize(screenSize.x, screenSize.y)
  Panel_Widget_HadumField_Enter:SetPosX(0)
  Panel_Widget_HadumField_Enter:SetPosY(0)
  PaGlobal_Widget_HadumField_Enter_All._ui._stc_blackBG:SetSize(screenSize.x, screenSize.y)
  Panel_Widget_HadumField_Enter:ComputePosAllChild()
end
function FromClient_Widget_HadumField_Enter_All_UpdateEnterState()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  if _ContentsGroup_HadumField == false then
    return false
  end
  PaGlobal_Widget_HadumField_Enter_All_Open(true)
  if PaGlobalFunc_Widget_FunctionButton_UpdateAllButton ~= nil then
    PaGlobalFunc_Widget_FunctionButton_UpdateAllButton()
  end
end
