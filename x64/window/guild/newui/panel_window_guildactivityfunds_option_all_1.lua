function PaGlobal_GuildActivityFunds_Option_All:initialize()
  if PaGlobal_GuildActivityFunds_Option_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local fundBg = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Static_GuildFundArea")
  self._ui.txt_Fund = UI.getChildControl(fundBg, "StaticText_GuildFundTitle")
  local pointArea = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Static_PointArea")
  for index = 1, 5 do
    local gradeText = UI.getChildControl(pointArea, "StaticText_Grade" .. tostring(index))
    gradeText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVEOPTION_GRADE", "grade", tostring(index)))
    self._ui.edit_Point[index] = UI.getChildControl(pointArea, "Edit_Point" .. tostring(index))
    self._ui.edit_Fund[index] = UI.getChildControl(pointArea, "Edit_ActivityFunds" .. tostring(index))
    self._ui.edit_PointConsole[index] = UI.getChildControl(pointArea, "ConsoleEdit_Point" .. tostring(index))
    self._ui.edit_FundConsole[index] = UI.getChildControl(pointArea, "ConsoleEdit_ActivityFunds" .. tostring(index))
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetIgnore(true)
      self._ui.edit_Fund[index]:SetIgnore(true)
    else
      self._ui.edit_PointConsole[index]:SetIgnore(true)
      self._ui.edit_FundConsole[index]:SetIgnore(true)
    end
    self._ui.btn_UnLimit[index] = UI.getChildControl(pointArea, "Button_Unlimited" .. tostring(index))
    self._settingList[index] = {}
    self._settingList[index].point = 0
    self._settingList[index].fund = 0
  end
  self._ui_pc.btn_Confirm = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Button_Adjust")
  self._ui_pc.btn_Cancel = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Button_Cancel")
  local mainBg = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Static_Main_Bg")
  self._ui_pc.btn_Close = UI.getChildControl(mainBg, "Button_Close")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_GuildActivityFunds_Option_All, "Static_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildActivityFunds_Option_All:changePlatform()
  PaGlobal_GuildActivityFunds_Option_All:registEventHandler()
  PaGlobal_GuildActivityFunds_Option_All:validate()
  PaGlobal_GuildActivityFunds_Option_All._initialize = true
end
function PaGlobal_GuildActivityFunds_Option_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildActivityFunds_Option_All:registEventHandler()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  self._ui_pc.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_Confirm()")
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_Close()")
  self._ui_pc.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_Close()")
  for index = 1, 5 do
    self._ui.edit_Point[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_SetPoint(" .. tostring(index) .. ")")
    self._ui.edit_Fund[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_SetFunds(" .. tostring(index) .. ")")
    self._ui.btn_UnLimit[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_SetLimit(" .. tostring(index) .. ")")
    self._ui.edit_PointConsole[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_SetPoint(" .. tostring(index) .. ")")
    self._ui.edit_FundConsole[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_SetFunds(" .. tostring(index) .. ")")
  end
  Panel_Window_GuildActivityFunds_Option_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_GuildActivityFunds_Option_All_Close()")
  Panel_Window_GuildActivityFunds_Option_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildActivityFunds_Option_All_Confirm()")
  registerEvent("FromClient_UpdateGuildFundSettingInfo", "FromClient_UpdateGuildFundSettingInfoActivity")
end
function PaGlobal_GuildActivityFunds_Option_All:prepareOpen()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  ToClient_ClearGuildFundSetting()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  for index = 1, __eGuildActivityGradeMax do
    self._settingList[index].point = ToClient_GetGuildFundPointSetting(__eGuildFundSettingType_Activity, index - 1)
    self._settingList[index].fund = ToClient_GetGuildFundMoneySetting(__eGuildFundSettingType_Activity, index - 1)
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetEditText(tostring(self._settingList[index].point), true)
    else
      self._ui.edit_Point[index]:SetText(tostring(self._settingList[index].point))
    end
    if self._settingList[index].fund == toInt64(0, -1) then
      if true == _ContentsGroup_RenewUI then
        self._ui.edit_Fund[index]:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"), true)
      else
        self._ui.edit_Fund[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
      end
    elseif true == _ContentsGroup_RenewUI then
      self._ui.edit_Fund[index]:SetEditText(makeDotMoney(self._settingList[index].fund), true)
    else
      self._ui.edit_Fund[index]:SetText(makeDotMoney(self._settingList[index].fund))
    end
    ToClient_SetGuildFundPointSetting(__eGuildFundSettingType_Activity, index - 1, self._settingList[index].point)
    ToClient_SetGuildFundMoneySetting(__eGuildFundSettingType_Activity, index - 1, self._settingList[index].fund)
  end
  self._ui.txt_Fund:SetText(makeDotMoney(myGuildInfo:getGuildBusinessFunds_s64()))
  PaGlobal_GuildActivityFunds_Option_All:open()
end
function PaGlobal_GuildActivityFunds_Option_All:open()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  Panel_Window_GuildActivityFunds_Option_All:SetShow(true)
end
function PaGlobal_GuildActivityFunds_Option_All:prepareClose()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  ToClient_ClearGuildFundSetting()
  PaGlobal_GuildActivityFunds_Option_All:close()
end
function PaGlobal_GuildActivityFunds_Option_All:close()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
  Panel_Window_GuildActivityFunds_Option_All:SetShow(false)
end
function PaGlobal_GuildActivityFunds_Option_All:validate()
  if Panel_Window_GuildActivityFunds_Option_All == nil then
    return
  end
end
function PaGlobal_GuildActivityFunds_Option_All:pointUpdate(input, param)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  if input > toInt64(0, 10000) then
    input = toInt64(0, 10000)
  end
  if true == _ContentsGroup_RenewUI then
    self._ui.edit_Point[self._editIndex]:SetEditText(tostring(input), true)
  else
    self._ui.edit_Point[self._editIndex]:SetText(tostring(input))
  end
  self._settingList[self._editIndex].point = input
  ToClient_SetGuildFundPointSetting(__eGuildFundSettingType_Activity, self._editIndex - 1, Int64toInt32(input))
end
function PaGlobal_GuildActivityFunds_Option_All:fundUpdate(input, param)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local limitPriceMax = myGuildInfo:getGuildBusinessFunds_s64()
  if input > limitPriceMax then
    input = limitPriceMax
  end
  if true == _ContentsGroup_RenewUI then
    self._ui.edit_Fund[self._editIndex]:SetEditText(makeDotMoney(tostring(input)), true)
  else
    self._ui.edit_Fund[self._editIndex]:SetText(makeDotMoney(tostring(input)))
  end
  self._settingList[self._editIndex].fund = input
  ToClient_SetGuildFundMoneySetting(__eGuildFundSettingType_Activity, self._editIndex - 1, input)
end
function PaGlobal_GuildActivityFunds_Option_All:fundLimit(index)
  self._ui.edit_Fund[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
  self._settingList[index].fund = -1
  ToClient_SetGuildFundMoneySetting(__eGuildFundSettingType_Activity, index - 1, toInt64(0, -1))
end
function PaGlobal_GuildActivityFunds_Option_All:setFunds(index)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  self._editIndex = index
  Panel_NumberPad_Show(true, myGuildInfo:getGuildBusinessFunds_s64(), 0, PaGlobal_GuildActivityFunds_Option_All_InputFundNumber)
end
function PaGlobal_GuildActivityFunds_Option_All:setPoint(index)
  self._editIndex = index
  Panel_NumberPad_Show(true, toInt64(0, 10000), 0, PaGlobal_GuildActivityFunds_Option_All_InputPointNumber)
end
