function PaGlobal_GuildDocumentManagement_All_Open()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  PaGlobal_GuildDocumentManagement_All._isOpenReq = true
  ToClient_RequestGuildActivityPointList()
end
function PaGlobal_GuildDocumentManagement_All_LoadGuildActivityPoint()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  if PaGlobal_GuildDocumentManagement_All._isOpenReq == false then
    return
  end
  PaGlobal_GuildDocumentManagement_All:prepareOpen()
end
function PaGlobal_GuildDocumentManagement_All_Close()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  PaGlobal_GuildDocumentManagement_All:prepareClose()
end
function PaGlobal_GuildDocumentManagement_All_Confirm(isAll, index, confirmType)
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  if isAll == nil or index == nil or confirmType == nil then
    return
  end
  if isAll == true then
    local function ApplyPoint()
      ToClient_ConfirmGuildActivityPoint(isAll, index, confirmType)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINTMANAGEMENT_ALLAPPROVAL_MSG"),
      functionYes = ApplyPoint,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_ConfirmGuildActivityPoint(isAll, index, confirmType)
end
function FromClient_ConfirmGuildActivityPoint(isAll, confirmType, name)
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  PaGlobal_GuildDocumentManagement_All:update(PaGlobal_GuildDocumentManagement_All._eTab.eNone)
  if isAll == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POINTMANAGEMENT_ALLAPPROVAL"))
  elseif confirmType == 1 then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINT_APPROVAL", "name", name))
  elseif confirmType == 2 then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINT_RETURN", "name", name))
  end
end
function PaGlobal_GuildDocumentManagement_All_SelectTab(selectTab)
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  if selectTab == nil then
    return
  end
  PaGlobal_GuildDocumentManagement_All:update(selectTab)
end
function PaGlobal_GuildDocumentManagement_All_SelectTabConsole(isNext)
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  if isNext == nil then
    return
  end
  if isNext == true then
    PaGlobal_GuildDocumentManagement_All._selectType = PaGlobal_GuildDocumentManagement_All._selectType + 1
  else
    PaGlobal_GuildDocumentManagement_All._selectType = PaGlobal_GuildDocumentManagement_All._selectType - 1
  end
  if PaGlobal_GuildDocumentManagement_All._selectType < 0 then
    PaGlobal_GuildDocumentManagement_All._selectType = 0
  end
  if PaGlobal_GuildDocumentManagement_All._selectType > 2 then
    PaGlobal_GuildDocumentManagement_All._selectType = 2
  end
  PaGlobal_GuildDocumentManagement_All:update(PaGlobal_GuildDocumentManagement_All._selectType)
end
function PaGlobal_GuildDocumentManagement_All_CreateContent(content, key)
  if nil == Panel_Window_GuildDocumentManagement_All then
    return
  end
  if content == nil or key == nil then
    return
  end
  PaGlobal_GuildDocumentManagement_All:createControl(content, key)
end
