function PaGlobal_GuildActivityFunds_Option_All_Open()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:prepareOpen()
end
function PaGlobal_GuildActivityFunds_Option_All_Close()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:prepareClose()
end
function PaGlobal_GuildActivityFunds_Option_All_Confirm()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  ToClient_RequestGuildFundSetting(__eGuildFundSettingType_Activity)
end
function FromClient_UpdateGuildFundSettingInfoActivity(settingType)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if settingType == nil then
    return
  end
  if settingType ~= __eGuildFundSettingType_Activity then
    return
  end
  if Panel_Window_GuildActivityFunds_Option_All:GetShow() == false then
    return
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINT_ADJUSTPOINTOPTION"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  PaGlobal_GuildActivityFunds_Option_All_Close()
end
function PaGlobal_GuildActivityFunds_Option_All_InputPointNumber(input, param)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if input == nil or param == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:pointUpdate(input, param)
end
function PaGlobal_GuildActivityFunds_Option_All_InputFundNumber(input, param)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if input == nil or param == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:fundUpdate(input, param)
end
function PaGlobal_GuildActivityFunds_Option_All_SetPoint(index)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:setPoint(index)
end
function PaGlobal_GuildActivityFunds_Option_All_SetFunds(index)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:setFunds(index)
end
function PaGlobal_GuildActivityFunds_Option_All_SetLimit(index)
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All:fundLimit(index)
end
