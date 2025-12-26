function PaGlobal_Telescope_All_Open()
  PaGlobal_Telescope_All:prepareOpen()
end
function PaGlobal_Telescope_All_Close()
  PaGlobal_Telescope_All:prepareClose()
end
function HandleEventLUp_Telescope_All_Confirm()
  if Panel_Window_Scope_All == nil then
    return
  end
  if Panel_Window_Scope_All:GetShow() == false then
    return
  end
  if PaGlobal_IsMatchingConfirmOpen ~= nil and PaGlobal_IsMatchingConfirmOpen() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMatchNoAction"))
    return
  end
  ClearFocusEdit()
  local self = PaGlobal_Telescope_All
  local selectedUserName = self._ui._edit_TargetUserName:GetEditText()
  local defaultUserName = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGEGISTSOLDIER_NONAME_ALERT")
  local messageBoxMemo, messageBoxData
  if selectedUserName == nil or selectedUserName == defaultUserName or selectedUserName == "" then
    messageBoxMemo = defaultUserName
    messageBoxData = {
      title = "",
      content = messageBoxMemo,
      functionApply = HandleEventLUp_Telescope_All_SetFocusTargetUser,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  self._targetUserName = selectedUserName
  ToClient_requestRegionKeyByTeleportUserName(selectedUserName)
end
function HandleEventLUp_Telescope_All_SetFocusTargetUser()
  if Panel_Window_Scope_All == nil then
    return
  end
  if Panel_Window_Scope_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Telescope_All
  self:setEditFocusTargetUser()
end
function FromClient_UpdateRegionKeyForTelescope(regionKeyRaw)
  if Panel_Window_Scope_All == nil then
    return
  end
  if Panel_Window_Scope_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Telescope_All
  local function goToUser()
    getSelfPlayer():get():useTelescope(self._itemWhereType, self._itemSlotNo)
  end
  local messageBoxMemo, messageBoxData
  local regionWrapper = getRegionInfoWrapper(regionKeyRaw)
  if regionWrapper == nil then
    return
  end
  local areaName = regionWrapper:getAreaName()
  messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SCOPE_MESSAGEBOX_CONFIRM", "Region", areaName, "familyName", self._targetUserName)
  messageBoxData = {
    title = "",
    content = messageBoxMemo,
    functionYes = goToUser,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_UseTelescopeItemNotify(whereType, slotNo)
  if Panel_Window_Scope_All == nil then
    return
  end
  PaGlobal_Telescope_All_Open()
  local self = PaGlobal_Telescope_All
  self._itemWhereType = whereType
  self._itemSlotNo = slotNo
end
function FromClient_GetRegionKeyForTelescopeFailed(rv)
  local messageBoxMemo = PAGetStringSymNo(rv)
  local messageBoxData = {
    title = "",
    content = messageBoxMemo,
    functionApply = HandleEventLUp_Telescope_All_SetFocusTargetUser,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return
end
