function PaGlobalFunc_SolareCustomInvite_Open()
  if _ContentsGroup_Solare == false then
    return
  end
  local self = PaGlobal_Solare_Custom_Invite
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SolareCustomInvite_Close()
  local self = PaGlobal_Solare_Custom_Invite
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_SolareCustomInvite_Confirm()
  local self = PaGlobal_Solare_Custom_Invite
  if self == nil then
    return
  end
  self:inviteSolareCustomPlayer()
end
function PaGlobalFunc_SolareCustomInvite_InputName_SetFocus()
  local self = PaGlobal_Solare_Custom_Invite
  if self == nil then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  self._ui._edit_UserNickName:SetEditText("")
  SetFocusEdit(self._ui._edit_UserNickName)
end
