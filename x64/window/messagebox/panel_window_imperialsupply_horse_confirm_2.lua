function PaGlobal_ImperialSupplyMSG_Open()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  if Panel_Dialog_ServantList_All == nil or Panel_Dialog_ServantList_All:GetShow() == false then
    return
  end
  local openImperialSupplyMsg = function()
    PaGlobal_ImperialSupplyMSG:prepareOpen()
    PaGlobal_ServantList_All:subMenuClose()
    PaGlobal_ImperialSupplyMSG:update()
  end
  if PaGlobal_ImperialSupplyMSG_CanSellExpensive() == true then
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_SELL_WARNING")
    local confirm = openImperialSupplyMsg
    local cancel = MessageBox_Empty_function
    local priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    messageboxData = {
      title = title,
      content = desc,
      functionYes = confirm,
      functionCancel = cancel,
      priority = priority
    }
    MessageBox.showMessageBox(messageboxData)
  else
    openImperialSupplyMsg()
  end
end
function PaGlobal_ImperialSupplyMSG_Close()
  PaGlobal_ImperialSupplyMSG:prepareClose()
end
function PaGlobal_ImperialSupplyMSG_ShowTreasureComponentEffect(treasureComponentItemKey)
  PaGlobal_ImperialSupplyMSG:showTreasureComponentEffect(treasureComponentItemKey)
end
function PaGlobal_ImperialSupplyMSG_CheckTime(fDeltaTime)
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  if Panel_ImperialSupply_Horse_Confirm:GetShow() == false then
    return
  end
  PaGlobal_ImperialSupplyMSG:checkTime(fDeltaTime)
end
function PaGlobal_ImperialSupplyMSG_CanSellExpensive()
  local servantInfo = PaGlobalFunc_ServantList_All_ServantInfo()
  if servantInfo == nil then
    return false
  end
  local needExp_s64 = servantInfo:getNeedExperienceForLvUp()
  local expStack_s64 = servantInfo:getExperienceStack()
  local level = servantInfo:getLevel()
  if _ContentsGroup_ServantLevelUpRenewal == true and level <= ToClient_GetHorseSimulateGrowUpVariableStatLevelMax() and Int64toInt32(expStack_s64) > Int64toInt32(needExp_s64) then
    return true
  end
  return false
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
