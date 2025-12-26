function PaGlobal_GuildAttributeReport_All:initialize()
  if PaGlobal_GuildAttributeReport_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local markBg = UI.getChildControl(Panel_GuildAttributeReport_All, "Static_GuildMarkBg")
  self._ui.stc_GuildMark = UI.getChildControl(markBg, "Static_GuildMark")
  self._ui.txt_Title = UI.getChildControl(Panel_GuildAttributeReport_All, "StaticText_AgreementSummaryTitle")
  self._ui.txt_Date = UI.getChildControl(Panel_GuildAttributeReport_All, "StaticText_Date")
  for index = 1, 4 do
    self._ui.btn_Option[index] = UI.getChildControl(Panel_GuildAttributeReport_All, "RadioButton_" .. tostring(index))
    local consoleKey = UI.getChildControl(self._ui.btn_Option[index], "Static_A_ConsoleUI")
    consoleKey:SetShow(self._isConsole)
  end
  self._ui.btn_Confirm = UI.getChildControl(Panel_GuildAttributeReport_All, "Button_Send")
  self._ui.btn_Refuse = UI.getChildControl(Panel_GuildAttributeReport_All, "Button_Cancel")
  local consoleSendKey = UI.getChildControl(self._ui.btn_Confirm, "Static_X_ConsoleUI")
  consoleSendKey:SetShow(self._isConsole)
  local consoleRefuseKey = UI.getChildControl(self._ui.btn_Refuse, "Static_B_ConsoleUI")
  consoleRefuseKey:SetShow(self._isConsole)
  self._ui.leftCount = UI.getChildControl(Panel_GuildAttributeReport_All, "StaticText_LeftCount")
  PaGlobal_GuildAttributeReport_All:changePlatform()
  PaGlobal_GuildAttributeReport_All:registEventHandler()
  PaGlobal_GuildAttributeReport_All:validate()
  PaGlobal_GuildAttributeReport_All._initialize = true
end
function PaGlobal_GuildAttributeReport_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildAttributeReport_All:registEventHandler()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_GuildAttributeReport_All_Request()")
  self._ui.btn_Refuse:addInputEvent("Mouse_LUp", "PaGlobal_GuildAttributeReport_All_Close()")
  for index = 1, 4 do
    self._ui.btn_Option[index]:addInputEvent("Mouse_LUp", "PaGlobal_GuildAttributeReport_All_Select(" .. tostring(index - 1) .. ")")
  end
  Panel_GuildAttributeReport_All:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobal_GuildAttributeReport_All_Request()")
  Panel_GuildAttributeReport_All:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_GuildAttributeReport_All_Close()")
  registerEvent("FromClient_LoadGuildActivityPoint", "PaGlobal_GuildAttributeReport_All_LoadGuildActivityPoint")
end
function PaGlobal_GuildAttributeReport_All:prepareOpen(index)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if index == nil then
    return
  end
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_GuildAttributeReport_All)
  end
  self._isSendAll = false
  self._selectOption = -1
  if index == -1 then
    PaGlobal_GuildAttributeReport_All:sendAllUpdate(index)
  else
    PaGlobal_GuildAttributeReport_All:sendTargetUpdate(index)
  end
  PaGlobal_GuildAttributeReport_All:open()
end
function PaGlobal_GuildAttributeReport_All:open()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  Panel_GuildAttributeReport_All:SetShow(true)
end
function PaGlobal_GuildAttributeReport_All:prepareClose()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  self._selectIndex = nil
  PaGlobal_GuildAttributeReport_All:close()
end
function PaGlobal_GuildAttributeReport_All:close()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  Panel_GuildAttributeReport_All:SetShow(false)
end
function PaGlobal_GuildAttributeReport_All:sendAllUpdate(index)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if index == nil then
    return
  end
  local isRight = ToClient_IsDefineGuildRightType(__eGuildRightType_PointSetting)
  if isRight == false then
    PaGlobal_GuildAttributeReport_All_Close()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), self._ui.stc_GuildMark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui.stc_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildMark, 183, 1, 188, 6)
  end
  self._ui.stc_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_GuildMark:setRenderTexture(self._ui.stc_GuildMark:getBaseTexture())
  self._ui.txt_Date:SetText(getTimeYearMonthDayHourMinSecByTTime64(getUtc64()))
  for ii = 1, 4 do
    local contents = ToClient_GetGuildFundContentsPresetSetting(ii - 1)
    local point = ToClient_GetGuildFundPointPresetSetting(ii - 1)
    if contents == "" then
      contents = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(ii))
    end
    self._ui.btn_Option[ii]:SetText(contents .. " : " .. tostring(point))
    self._ui.btn_Option[ii]:SetCheck(false)
  end
  self._ui.leftCount:SetShow(false)
  self._isSendAll = true
end
function PaGlobal_GuildAttributeReport_All:sendTargetUpdate(index)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if index == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = index
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), self._ui.stc_GuildMark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui.stc_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildMark, 183, 1, 188, 6)
  end
  self._ui.stc_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_GuildMark:setRenderTexture(self._ui.stc_GuildMark:getBaseTexture())
  self._ui.txt_Date:SetText(getTimeYearMonthDayHourMinSecByTTime64(getUtc64()))
  for ii = 1, 4 do
    local contents = ToClient_GetGuildFundContentsPresetSetting(ii - 1)
    local point = ToClient_GetGuildFundPointPresetSetting(ii - 1)
    if contents == "" then
      contents = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(ii))
    end
    self._ui.btn_Option[ii]:SetText(contents .. " : " .. tostring(point))
    self._ui.btn_Option[ii]:SetCheck(false)
  end
  local leftCount = ToClient_GetDayGuildActivityPoint(selfPlayer:get():getUserNo())
  self._ui.leftCount:SetShow(true)
  self._ui.leftCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_ATTRIBUTEREPORT_LEFTCOUNT", "count", leftCount, "maxCount", tostring(2)))
  self._isSendAll = false
end
function PaGlobal_GuildAttributeReport_All:pointUpdate(input, param)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if input == nil or param == nil then
    return
  end
  self._ui._edit_point:SetText(tostring(input))
end
function PaGlobal_GuildAttributeReport_All:validate()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
end
