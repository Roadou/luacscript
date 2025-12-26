registerEvent("FromClient_enterToInstanceFieldNotifyMessage", "FromClient_enterToInstanceFieldNotifyMessage")
registerEvent("FromClient_NoticeJoinInstanceFieldFailed", "FromClient_NoticeJoinInstanceFieldFailed")
function FromClient_enterToInstanceFieldNotifyMessage(contentsType, mapKey)
  local function funcYes()
    ToClient_requestJoinInstanceCheckEnterOption(contentsType, mapKey)
  end
  local txt_desc = ToClient_getEnterDescToInstanceField(mapKey)
  local messageBoxData = {
    content = txt_desc,
    functionYes = funcYes,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_NoticeJoinInstanceFieldFailed(rv)
  if rv == nil then
    return
  end
  messageBox_CloseButtonUp()
  messageBoxCheck_CloseButtonUp()
  local msg = PAGetStringSymNo(rv)
  if msg == nil or msg == "" then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = msg,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
