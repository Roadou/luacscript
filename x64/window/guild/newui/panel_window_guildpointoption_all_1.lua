function PaGlobal_GuildPointOption_All:initialize()
  if PaGlobal_GuildPointOption_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local pointArea = UI.getChildControl(Panel_Window_GuildPointOption_All, "Static_PointArea")
  for index = 1, 5 do
    self._ui.edit_Contents[index] = UI.getChildControl(pointArea, "Edit_CategoryDesc" .. tostring(index))
    self._ui.edit_Point[index] = UI.getChildControl(pointArea, "Edit_Point" .. tostring(index))
    self._ui.edit_PointConsole[index] = UI.getChildControl(pointArea, "ConsoleEdit_Point" .. tostring(index))
    self._ui.edit_Point[index]:SetNumberMode(true)
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetIgnore(true)
    else
      self._ui.edit_PointConsole[index]:SetIgnore(true)
    end
  end
  self._ui_pc.btn_Confirm = UI.getChildControl(Panel_Window_GuildPointOption_All, "Button_Adjust")
  self._ui_pc.btn_Cancel = UI.getChildControl(Panel_Window_GuildPointOption_All, "Button_Cancel")
  local mainBg = UI.getChildControl(Panel_Window_GuildPointOption_All, "Static_Main_Bg")
  self._ui_pc.btn_Close = UI.getChildControl(mainBg, "Button_Close")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_GuildPointOption_All, "Static_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildPointOption_All:registEventHandler()
  PaGlobal_GuildPointOption_All:changePlatform()
  PaGlobal_GuildPointOption_All:validate()
  PaGlobal_GuildPointOption_All._initialize = true
end
function PaGlobal_GuildPointOption_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildPointOption_All:registEventHandler()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_All_Close()")
  self._ui_pc.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_All_Close()")
  self._ui_pc.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_All_Confirm()")
  for index = 1, 5 do
    self._ui.edit_Contents[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_Option_All_SetFocusContent(" .. tostring(index) .. ")")
    self._ui.edit_Point[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_Option_All_SetPoint(" .. tostring(index) .. ")")
    self._ui.edit_PointConsole[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_Option_All_SetPoint(" .. tostring(index) .. ")")
  end
  Panel_Window_GuildPointOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_GuildPointOption_All_Close()")
  Panel_Window_GuildPointOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildPointOption_All_Confirm()")
  registerEvent("FromClient_UpdateGuildFundPointSettingInfo", "FromClient_UpdateGuildFundPointSettingInfo")
end
function PaGlobal_GuildPointOption_All:prepareOpen()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  ToClient_ClearGuildFundPointSetting()
  self._editIndex = 0
  for index = 1, __eGuildActivityGradeMax do
    local contents = ToClient_GetGuildFundContentsPresetSetting(index - 1)
    local point = ToClient_GetGuildFundPointPresetSetting(index - 1)
    if contents == "" then
      contents = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(index))
    end
    if index == 5 then
      contents = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(index))
    end
    self._ui.edit_Contents[index]:SetText(contents)
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetEditText(tostring(point), true)
    else
      self._ui.edit_Point[index]:SetText(tostring(point))
    end
    ToClient_SetGuildFundContentPresetSetting(index - 1, contents)
    ToClient_SetGuildFundPointPresetSetting(index - 1, point)
  end
  PaGlobal_GuildPointOption_All:open()
end
function PaGlobal_GuildPointOption_All:open()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  Panel_Window_GuildPointOption_All:SetShow(true)
end
function PaGlobal_GuildPointOption_All:prepareClose()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  ToClient_ClearGuildFundPointSetting()
  PaGlobal_GuildPointOption_All:close()
end
function PaGlobal_GuildPointOption_All:close()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
  Panel_Window_GuildPointOption_All:SetShow(false)
end
function PaGlobal_GuildPointOption_All:update()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
end
function PaGlobal_GuildPointOption_All:validate()
  if Panel_Window_GuildPointOption_All == nil then
    return
  end
end
function PaGlobal_GuildPointOption_All:pointUpdate(input, param)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  if input > toInt64(0, 100) then
    input = toInt64(0, 100)
  end
  if true == _ContentsGroup_RenewUI then
    self._ui.edit_Point[self._editIndex]:SetEditText(tostring(input), true)
  else
    self._ui.edit_Point[self._editIndex]:SetText(tostring(input))
  end
  ToClient_SetGuildFundPointPresetSetting(self._editIndex - 1, Int64toInt32(input))
end
function PaGlobal_GuildPointOption_All:setPoint(index)
  self._editIndex = index
  Panel_NumberPad_Show(true, toInt64(0, 100), 0, PaGlobal_GuildPointOption_Option_All_InputPointNumber)
end
