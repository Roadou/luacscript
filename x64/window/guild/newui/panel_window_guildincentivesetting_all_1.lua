function PaGlobal_GuildIncentiveSetting_All:initialize()
  if PaGlobal_GuildIncentiveSetting_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local fundArea = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Static_GuildFundArea")
  self._ui.txt_GuildFund = UI.getChildControl(fundArea, "StaticText_GuildFundTitle")
  self._ui.txt_IncentiveFund = UI.getChildControl(fundArea, "StaticText_IncentiveTitle")
  self._ui.edit_Fund = UI.getChildControl(fundArea, "Edit_IncentiveValue")
  for index = 1, 4 do
    self._ui.btn_Fund[index] = UI.getChildControl(fundArea, "Button_" .. tostring(index))
  end
  local pointArea = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Static_PointArea")
  for index = 1, 10 do
    self._ui.txt_Grade[index] = UI.getChildControl(pointArea, "StaticText_Grade" .. tostring(index) .. "_Title")
    self._ui.txt_Grade[index]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVEOPTION_GRADE", "grade", tostring(index)))
    self._ui.txt_Fund[index] = UI.getChildControl(pointArea, "StaticText_Grade" .. tostring(index) .. "_Value")
    self._ui.edit_Point[index] = UI.getChildControl(pointArea, "Edit_Grade" .. tostring(index))
    self._ui.edit_PointConsole[index] = UI.getChildControl(pointArea, "ConsoleEdit_Grade" .. tostring(index))
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetIgnore(true)
    else
      self._ui.edit_PointConsole[index]:SetIgnore(true)
    end
  end
  self._ui_pc.btn_Confirm = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Button_Confirm")
  self._ui_pc.btn_Cancel = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Button_Cancel")
  local mainBg = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Static_Main_Bg")
  self._ui_pc.btn_Close = UI.getChildControl(mainBg, "Button_Close")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_GuildIncentiveSetting_All, "Static_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildIncentiveSetting_All:registEventHandler()
  PaGlobal_GuildIncentiveSetting_All:changePlatform()
  PaGlobal_GuildIncentiveSetting_All:validate()
  PaGlobal_GuildIncentiveSetting_All._initialize = true
end
function PaGlobal_GuildIncentiveSetting_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildIncentiveSetting_All:registEventHandler()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_Close()")
  self._ui_pc.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_Confirm()")
  self._ui_pc.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_Close()")
  for index = 1, 4 do
    self._ui.btn_Fund[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_SettingPercent(" .. tostring(index) .. ")")
  end
  for index = 1, 10 do
    self._ui.edit_Point[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_SetPoint(" .. tostring(index) .. ")")
    self._ui.edit_PointConsole[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildIncentiveSetting_All_SetPoint(" .. tostring(index) .. ")")
    self._ui.txt_Fund[index]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIncentiveSetting_All_Tooltip(true, " .. index .. ")")
    self._ui.txt_Fund[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildIncentiveSetting_All_Tooltip(false)")
  end
  Panel_Window_GuildIncentiveSetting_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_GuildIncentiveSetting_All_Close()")
  Panel_Window_GuildIncentiveSetting_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildIncentiveSetting_All_Confirm()")
  registerEvent("FromClient_UpdateGuildFundSettingInfo", "FromClient_UpdateGuildFundSettingInfoIncentive")
end
function PaGlobal_GuildIncentiveSetting_All:prepareOpen()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  ToClient_ClearGuildFundSetting()
  self._selectPercent = 0
  PaGlobal_GuildIncentiveSetting_All:update()
  PaGlobal_GuildIncentiveSetting_All:open()
end
function PaGlobal_GuildIncentiveSetting_All:open()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  Panel_Window_GuildIncentiveSetting_All:SetShow(true)
end
function PaGlobal_GuildIncentiveSetting_All:prepareClose()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  ToClient_ClearGuildFundSetting()
  PaGlobal_GuildIncentiveSetting_All:close()
end
function PaGlobal_GuildIncentiveSetting_All:close()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  Panel_Window_GuildIncentiveSetting_All:SetShow(false)
end
function PaGlobal_GuildIncentiveSetting_All:update()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local businessFunds = myGuildInfo:getGuildBusinessFunds_s64()
  local businessFundsResult = businessFunds * toInt64(0, self._selectPercent) / toInt64(0, 100)
  ToClient_InitGuildIncentiveList(businessFundsResult)
  for index = 1, __eGuildIncentiveGradeMax do
    local point = ToClient_GetGuildFundPointSetting(__eGuildFundSettingType_Incentive, index - 1)
    local fund = ToClient_getGuildIncentiveGradeByIndex(index)
    if true == _ContentsGroup_RenewUI then
      self._ui.edit_Point[index]:SetEditText(tostring(point), true)
    else
      self._ui.edit_Point[index]:SetText(tostring(point))
    end
    self._ui.txt_Fund[index]:SetText(makeDotMoney(fund))
    ToClient_SetGuildFundPointSetting(__eGuildFundSettingType_Incentive, index - 1, point)
    ToClient_SetGuildFundMoneySetting(__eGuildFundSettingType_Incentive, index - 1, fund)
  end
  self._ui.txt_GuildFund:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDMONEY", "getGuildMoney", makeDotMoney(myGuildInfo:getGuildBusinessFunds_s64())))
  self._ui.txt_IncentiveFund:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVEOPTION_VALUE", "incentiveValue", makeDotMoney(businessFundsResult)))
  self._ui.edit_Fund:SetText(makeDotMoney(businessFundsResult))
end
function PaGlobal_GuildIncentiveSetting_All:validate()
  if Panel_Window_GuildIncentiveSetting_All == nil then
    return
  end
end
function PaGlobal_GuildIncentiveSetting_All:pointUpdate(input, param)
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
  ToClient_SetGuildFundPointSetting(__eGuildFundSettingType_Incentive, self._editIndex - 1, Int64toInt32(input))
end
function PaGlobal_GuildIncentiveSetting_All:setPoint(index)
  self._editIndex = index
  Panel_NumberPad_Show(true, toInt64(0, 10000), 0, PaGlobal_GuildIncentiveSetting_All_InputPointNumber)
end
