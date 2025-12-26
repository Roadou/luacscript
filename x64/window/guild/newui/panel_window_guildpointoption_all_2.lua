function PaGlobal_GuildPointOption_All_Open()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  PaGlobal_GuildPointOption_All:prepareOpen()
end
function PaGlobal_GuildPointOption_All_Close()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  PaGlobal_GuildPointOption_All:prepareClose()
end
function PaGlobal_GuildPointOption_All_Confirm()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  for index = 1, 5 do
    if ToClient_SetGuildFundContentPresetSetting(index - 1, PaGlobal_GuildPointOption_All._ui.edit_Contents[index]:GetText()) == false then
      if isGameTypeKorea() == true or isGameTypeJapan() == true or isGameTypeTaiwan() == true then
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINT_CONTENT", "count", tostring(20)))
      else
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINT_CONTENT", "count", tostring(35)))
      end
      return
    end
  end
  ToClient_RequestUpdateGuildFundPointPreset()
end
function PaGlobal_GuildPointOption_Option_All_InputPointNumber(input, param)
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  if input == nil or param == nil then
    return
  end
  PaGlobal_GuildPointOption_All:pointUpdate(input, param)
end
function PaGlobal_GuildPointOption_Option_All_SetPoint(index)
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildPointOption_All:setPoint(index)
end
function PaGlobal_GuildPointOption_Option_All_SetFocusContent(index)
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  if index == nil then
    return
  end
  ClearFocusEdit()
  PaGlobal_GuildPointOption_All._ui.edit_Contents[index]:SetEditText("", true)
  SetFocusEdit(PaGlobal_GuildPointOption_All._ui.edit_Contents[index])
end
function FromClient_UpdateGuildFundPointSettingInfo()
  if Panel_Window_GuildPointOption_All:GetShow() == false then
    return
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINT_COMPLETE"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  PaGlobal_GuildPointOption_All_Close()
end
