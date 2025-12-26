function HandleEventLUp_RequestBlockVoteChat()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  local function chatBlockVote()
    ToClient_RequestBlockChatByUser(self._clickedMsg, self._ui._edit_reportWrite_multilineEdit:GetEditText(), self._chattingTime, self._chatType, self._clickedName, self._clickedUserNickName)
    PaGlobal_ChatSubMenuSetClickedInfoInit()
    PaGlobal_Window_Chat_Report_All_Close()
  end
  local nameType = ToClient_getChatNameType()
  local selectName = ""
  if nameType == 0 then
    selectName = self._clickedName
  elseif nameType == 1 then
    selectName = self._clickedUserNickName
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CHNATNEW_CHAT_BAN_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHATNEW_CHAT_BAN_MEMO", "clickedName", selectName),
    functionYes = chatBlockVote,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_RequestReportChat()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  if self._selectedReportType == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  ToClient_RequestReportChatByChatSubMenu(self._senderUserNo, self._clickedMsg, self._ui._edit_reportWrite_multilineEdit:GetEditText(), self._chattingTime, self._chatType, self._selectedReportType, self._clickedUserNickName, self._clickedUserId, self._clickedName)
  PaGlobal_Window_Chat_Report_All_Close()
end
function HandleEventKey_Chat_Report_OnVirtualKeyboardEnd(str)
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  if self._MAX_REPORTDESCRIPTION_COUNT < getWstringLength(str) then
    self._ui._edit_reportWrite_multilineEdit:SetEditText(getMaxSliceString(str, self._MAX_REPORTDESCRIPTION_COUNT))
  else
    self._ui._edit_reportWrite_multilineEdit:SetEditText(str)
  end
  FromClient_Chat_Report_EditBoxChange()
  ClearFocusEdit()
end
function FromClient_Chat_Report_Success()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  local messageBoxData = {
    content = PAGetString(Defines.StringSheet_GAME, "LUA_REPORTCHAT_COMPLETE_REPORT"),
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function FromClient_Chat_Report_Failed(stringKey, leftTime)
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  if stringKey == nil then
    return
  end
  local contentStr = PAGetString(Defines.StringSheet_GAME, stringKey)
  if leftTime ~= nil then
    local time = Uint64toUint32(leftTime)
    if time > 0 then
      contentStr = contentStr .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORTCHAT_COOLTIME", "time", time)
    end
  end
  local messageBoxData = {
    content = contentStr,
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function FromClient_Chat_Report_EditBoxChange()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  local editTextLength = self._ui._edit_reportWrite_multilineEdit:GetEditTextSize()
  self._ui._txt_characterCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REPORTCHAT_CHARACTERCOUNT", "current", editTextLength, "max", self._MAX_REPORTDESCRIPTION_COUNT))
  if editTextLength == 0 then
    self._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORTMEMO", "stringLength", self._MAX_REPORTDESCRIPTION_COUNT))
  end
end
function FromClient_PaGlobal_Window_Chat_Report_Resize()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  Panel_Window_Chat_Report_All:ComputePos()
end
function PaGlobal_Window_Chat_Report_All_Open(openType, clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  self:prepareOpen(openType, clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
end
function PaGlobal_Window_Chat_Report_All_Close()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Window_Chat_Report_SetFocusTarget()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  ToClient_padSnapSetTargetPanel(Panel_Window_Chat_Report_All)
end
function PaGlobal_Window_Chat_Report_SelectReportType(index)
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  self._selectedReportType = self._reportType[index]
end
function HandleEventLUp_Chat_Report_SetFocusEdit()
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  SetFocusEdit(self._ui._edit_reportWrite_multilineEdit)
end
