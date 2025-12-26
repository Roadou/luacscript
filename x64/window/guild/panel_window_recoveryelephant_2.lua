function PaGlobalFunc_RecoveryElephant_Open()
  local self = PaGlobal_RecoveryElephant
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RecoveryElephant_Close()
  local self = PaGlobal_RecoveryElephant
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RecoveryElephant_OnCreateListContent(content, key)
  local self = PaGlobal_RecoveryElephant
  if self == nil then
    return
  end
  self:createListContent(content, key)
end
function HandleEventLUp_RecoveryElephant_ServantListButton(index)
  local self = PaGlobal_RecoveryElephant
  if self == nil then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if guildWrapper == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseItemNotExistGuild"))
    return
  end
  local servantInfo = guildStable_getServantByIndex(__eVehicleType_Elephant, index)
  if servantInfo == nil then
    return
  end
  local deadCount = servantInfo:getDeadCount()
  if deadCount < 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantReviveServantByState"))
    return
  end
  local servantNo = servantInfo:getServantNo()
  local needMoney = guildStable_getClearGuildServantDeadCountCost_s64(servantNo)
  local function recoveryElephant_confirm()
    local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
    if guildMoney64 < needMoney and Defines.s64_const.s64_0 < needMoney then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
      return
    end
    local servantState = servantInfo:getStateType()
    if servantState == CppEnums.ServantStateType.Type_Field then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantRecoveryElephantByUnsealed"))
      return
    end
    guildStable_clearDeadCount(servantNo, true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSTABLE_RECOVERYINJURY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSTABLE_MSG_INJURYRECOVERY", "money", makeDotMoney(needMoney)),
    functionYes = recoveryElephant_confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return
end
function FromClient_RecoveryElephant_Update()
  local self = PaGlobal_RecoveryElephant
  if self == nil then
    return
  end
  self:updateList()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RECOVERINJURY_ELEPHANT"))
end
