function PaGlobal_PalaceManagement_Map_Open()
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  PaGlobal_PalaceManagement_Map:prepareOpen()
end
function PaGlobal_PalaceManagement_Map_Close()
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  PaGlobal_PalaceManagement_Map:prepareClose()
end
function PaGlobal_PalaceManagement_isUsedChange()
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  PaGlobal_PalaceManagement_Map:updateIsUsed()
end
function PaGlobal_PalaceManagement_ContentUse(open)
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  if open == false then
    local PalaceManagementCloseConfirm = function()
      ToClient_setPalaceManageContentUse(false)
    end
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_POPUP_BTN_CONFIRM")
    local messageboxContent = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_EXIT")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxContent,
      functionYes = PalaceManagementCloseConfirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    ToClient_setPalaceManageContentUse(open)
  end
end
function PaGlobal_PalaceManagement_WorldMapTownOn(waypointKey)
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  if PaGlobal_PalaceManagement_Map._isConsole == true then
    return
  end
  if PaGlobal_PalaceManagement_Map._waypointUI == 0 then
    return
  end
  if PaGlobal_PalaceManagement_Map._waypointUI ~= waypointKey then
    return
  end
  PaGlobal_PalaceManagement_Map:prepareOpen()
end
function PaGlobal_PalaceManagement_Map_WorkingChange(boardGroupKeyRaw, workerNoRaw)
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  if Panel_Window_PalaceManagement_Map:GetShow() == false then
    return
  end
  PaGlobal_PalaceManagement_Map:update()
  PaGlobal_PalaceManagement_Map:updateTooltip()
end
function PaGlobal_PalaceManagement_Tooltip_Open(boardGroupKey)
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  PaGlobal_PalaceManagement_Map:prepareOpenTooltip(boardGroupKey)
end
function PaGlobal_PalaceManagement_Tooltip_Close()
  if PaGlobal_PalaceManagement_Map == nil then
    return
  end
  Panel_Window_PalaceManagement_Tooltip:SetShow(false)
end
