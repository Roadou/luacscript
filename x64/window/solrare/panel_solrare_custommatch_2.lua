function PaGlobalFunc_SolareCustom_Open()
  if _ContentsGroup_Solare == false then
    return
  end
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SolareCustom_Close()
  if _ContentsGroup_Solare == false then
    return
  end
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SolareCustom_UpdateWaitInfo(control, index)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:updateWaitTeamInfo(control, index)
end
function PaGlobalFunc_SolareCustom_PressedEnter()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:sendChatMessage()
  if ToClient_isConsole() == true then
    ClearFocusEdit()
  end
end
function PaGlobalFunc_SolareCustom_CheckUiEdit(uiEdit)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  if self._ui == nil or self._ui._edit_Chat == nil then
    return false
  end
  if Panel_Window_Solrare_CustomMatching:GetShow() == false then
    return false
  end
  if uiEdit:GetKey() == self._ui._edit_Chat:GetKey() then
    return true
  end
  return false
end
function PaGlobalFunc_SolareCustom_EditChat_SetFocus()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  self._ui._edit_Chat:SetEditText("")
  SetFocusEdit(self._ui._edit_Chat)
end
function PaGlobalFunc_SolrareCustom_IsOpen()
  if Panel_Window_Solrare_CustomMatching == nil then
    return false
  end
  return Panel_Window_Solrare_CustomMatching:GetShow()
end
function FromClient_NotifyCreateSolareCustomRoom()
  PaGlobalFunc_SolareCustom_Open()
end
function FromClient_NotifyDestroySolareCustomRoom()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self._isRoomLeader = false
  self:clearChatMessage()
  PaGlobalFunc_SolareCustom_Close()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_NAK_DESTROYCUSTOMMATCHING"), nil, nil, nil, nil, true)
end
function FromClient_UpdateSolareCustomRoom()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:updateTeamInfo()
  self:checkCanStartCustomMatch()
end
function FromClient_NotifyInviteSolareCustomRoom(inviterName)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  local wrapper = ToClient_getGameOptionControllerWrapper()
  if wrapper == nil then
    return
  end
  if wrapper:getSolareCustomGameRefuse() == true then
    ToClient_AcceptInviteSolareCustomRoom(inviterName, false)
    return
  end
  local function acceptInviteSolareCustomRoom()
    ToClient_AcceptInviteSolareCustomRoom(inviterName, true)
  end
  local function refuseInviteSolareCustomRoom()
    ToClient_AcceptInviteSolareCustomRoom(inviterName, false)
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SOLARE_CUSTOMGAME_MESSAGEBOX_JOINDESC", "name", inviterName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = acceptInviteSolareCustomRoom,
    functionNo = refuseInviteSolareCustomRoom,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top", false, true, 7)
end
function FromClient_NotifySolareCustomRoomChat(userNickname, message)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:addChatMessage(userNickname, message)
end
function FromClient_ExitSolareCustomRoom()
  if _ContentsGroup_Solare == false then
    return
  end
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:clearChatMessage()
  self:prepareClose()
end
function HandleEventLUp_SolareCustom_MoveTeam(newTeam)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  ToClient_RequestChangeSolareCustomTeam(self._selectedTeamType, self._selectedMemberIndex, newTeam)
  self:closeFloatingPopUp()
end
function HandleEventLUp_SolareCustom_KickOut()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  ToClient_RequestKickUserSolareCustomRoom(self._selectedTeamType, self._selectedMemberIndex)
  self:closeFloatingPopUp()
end
function HandleEventLUp_SolareCustom_ShowFloatButton(teamType, memberIndex)
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  self:openFloatingPopUp(teamType, memberIndex)
end
function HandleEventLUp_SolareCustom_ShowGuide()
  Panel_WebHelper_ShowToggle("Solare")
end
function HandleEventLUp_SolareCustom_StartCustomMatch()
  ToClient_RequestStartSolareCustomMatch()
end
function HandleEventLUp_SolareCustom_Invite()
  PaGlobalFunc_SolareCustomInvite_Open()
end
function HandleEventLUp_SolareCustom_ExitRoom()
  local self = PaGlobal_Solare_Custom
  if self == nil then
    return
  end
  if ToClient_IsCreatedSolareCustomRoom() == true then
    ToClient_ExitSolareCustomRoom()
    self:closeFloatingPopUp()
  else
    PaGlobalFunc_SolareCustom_Close()
  end
end
