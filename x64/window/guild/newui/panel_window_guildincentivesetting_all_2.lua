function PaGlobal_GuildIncentiveSetting_All_Open()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  PaGlobal_GuildIncentiveSetting_All:prepareOpen()
end
function PaGlobal_GuildIncentiveSetting_All_Close()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  PaGlobal_GuildIncentiveSetting_All:prepareClose()
end
function PaGlobal_GuildIncentiveSetting_All_Confirm()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  if PaGlobal_GuildIncentiveSetting_All._selectPercent == nil or PaGlobal_GuildIncentiveSetting_All._selectPercent == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINT_INCENTIVEALERT"))
    return
  end
  local isAllZero = true
  for index = 1, 10 do
    if PaGlobal_GuildIncentiveSetting_All._ui.edit_Point[index]:GetText() ~= tostring(0) then
      isAllZero = false
      break
    end
  end
  if isAllZero == true then
    FromClient_UpdateGuildFundSettingInfoIncentive(__eGuildFundSettingType_Incentive)
  else
    ToClient_RequestGuildFundSetting(__eGuildFundSettingType_Incentive)
  end
end
function PaGlobal_GuildIncentiveSetting_All_SettingPercent(index)
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildIncentiveSetting_All._selectPercent = index * 10
  PaGlobal_GuildIncentiveSetting_All:update()
end
function PaGlobal_GuildIncentiveSetting_All_InputPointNumber(input, param)
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  if input == nil or param == nil then
    return
  end
  PaGlobal_GuildIncentiveSetting_All:pointUpdate(input, param)
end
function PaGlobal_GuildIncentiveSetting_All_SetPoint(index)
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildIncentiveSetting_All:setPoint(index)
end
function FromClient_UpdateGuildFundSettingInfoIncentive(settingType)
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  if settingType == nil then
    return
  end
  if settingType ~= __eGuildFundSettingType_Incentive then
    return
  end
  if Panel_Window_GuildIncentiveSetting_All:GetShow() == false then
    return
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINT_ADJUSTPOINTOPTION"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  PaGlobal_GuildIncentiveSetting_All_Close()
  PaGlobalFunc_GuildIncentiveOption_All_SetMoneyValue(PaGlobal_GuildIncentiveSetting_All._selectPercent)
end
function HandleEventOnOut_GuildIncentiveSetting_All_Tooltip(isShow, index)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local fund = PaGlobal_GuildIncentiveSetting_All._ui.txt_Fund[index]:GetText()
  if fund == "" then
    TooltipSimple_Hide()
    return
  end
  local uiControl = PaGlobal_GuildIncentiveSetting_All._ui.txt_Fund[index]
  local name = fund
  local desc = ""
  TooltipSimple_Show(uiControl, name, desc)
end
