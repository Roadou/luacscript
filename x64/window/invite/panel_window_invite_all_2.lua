function PaGlobalFunc_Invite_All_Open(type)
  PaGlobal_Invite_All:prepareOpen(type)
end
function PaGlobalFunc_Invite_All_Close()
  PaGlobal_Invite_All:prepareClose()
end
function PaGlobal_Invite_All_CheckCurrentUiEdit_All(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Invite_All._ui.edit_name:GetKey()
end
function PaGlobal_Invite_All_VirtualKeyEnd(str)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_Invite_All._ui.edit_name:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobal_Invite_All_SetFocusEdit()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_Invite_All._ui.edit_name)
  PaGlobal_Invite_All._ui.edit_name:SetEditText(PaGlobal_Invite_All._ui.edit_name:GetEditText(), true)
end
function PaGlobal_Invite_All_SendInvite()
  if true == MessageBox.isPopUp() then
    return
  end
  local name = PaGlobal_Invite_All._ui.edit_name:GetEditText()
  if "" == name then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DETECTPLAYER_ERRORMSG_PLAYERNAME_NIL"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    PaGlobalFunc_Invite_All_Close()
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local confirmFunction
  local messageTitle = ""
  local messageContent = ""
  local sendRentInstanceFieldInviteRequest = function()
    ToClient_requestInviteUserInRentInstanceField(PaGlobal_Invite_All._ui.edit_name:GetEditText(), PaGlobal_Invite_All._isFamilyName)
    PaGlobalFunc_Invite_All_Close()
  end
  if PaGlobal_Invite_All._type.RentInstanceField == PaGlobal_Invite_All._openType then
    confirmFunction = sendRentInstanceFieldInviteRequest
    messageTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALSERVER_OPTION_TITLE")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_INVITE_CONFIRM", "characterName", tostring(name))
  end
  if "" == messageTitle or "" == messageContent or nil == confirmFunction then
    PaGlobalFunc_Invite_All_Close()
    return
  end
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = confirmFunction,
    functionNo = PaGlobal_Invite_All_SetFocusEdit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  ClearFocusEdit()
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Invite_All_ChangeNicknameMode()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_Invite_All._isFamilyName = PaGlobal_Invite_All._ui.chk_familyName:IsCheck()
  else
    PaGlobal_Invite_All._isFamilyName = not PaGlobal_Invite_All._isFamilyName
  end
  PaGlobal_Invite_All:updateTab()
end
function FromClient_Invite_All_Resize()
  if nil == Panel_Window_Invite_All then
    return
  end
  Panel_Window_Invite_All:ComputePos()
end
