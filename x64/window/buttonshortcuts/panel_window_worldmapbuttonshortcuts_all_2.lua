function PaGlobalFunc_WorldmapButtonShorcuts_All_Open(index)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self._isShortcutOpen = false
  self:changeUI(self._UIMODE.ListOnly.index)
  self:prepareOpen(index)
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_Close()
  if Panel_Window_WorldmapButtonShortcuts_All == nil then
    return
  end
  PaGlobal_WorldmapButtonShortcuts_All:prepareClose()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_ChangeShortcuts(id)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  if self._curId ~= nil and self._curId >= 0 then
    local tempId = self._curId
    self._curId = id
    self._ui.list2_keySet:requestUpdateByKey(toInt64(0, tempId))
  end
  self._curId = id
  self._curButtonsShortcuts = ToClient_GetWorldmapButtonShortcut(id)
  self._ui.list2_keySet:requestUpdateByKey(toInt64(0, self._curId))
  ClearFocusEdit()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_DeleteShortcuts(id)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self._curId = id
  self._curButtonsShortcuts = ToClient_GetWorldmapButtonShortcut(id)
  PaGlobalFunc_WorldmapButtonShorcuts_All_RemoveByGlobalKeyBinder()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_SetDefault()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self:setDefault()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_ClickedChangeShortcuts()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self:clickedChangeShortcuts()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_ToggleAllView()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  TooltipSimple_Hide()
  self._searchText = ""
  self:listRefresh()
  ClearFocusEdit()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_ApplySearch()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self._searchText = self._ui.edit_search:GetEditText()
  self:uiRefresh()
  ClearFocusEdit()
end
function HandleEventLUp_WorldmapButtonShortcuts_All_EditSearch()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self._ui.edit_search:SetEditText("")
  self._searchText = ""
end
function HandleEventLUp_WorldmapButtonShortcuts_All_ChangeAllViewMode()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.List.index)
  self:resize()
end
function HandleEventOnOut_WorldmapButtonShortcuts_All_SimpleTooltips(isShow, tipType)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_LIST")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_LIST_DESC")
    control = self._ui.btn_allView
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_RESET")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_RESET_DESC")
    control = self._ui.btn_reset
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_VIEW")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_VIEW_DESC")
    control = self._ui.chk_all
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_WorldmapButtonShortcuts_All_OpenButtonShortcuts(index)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.List.index)
  self:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.Current.index)
  self:prepareOpen(index)
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_ListControlCreate(content, key)
  PaGlobal_WorldmapButtonShortcuts_All:listControlCreate(content, key)
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_RegisterOk()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  ToClient_SetWorldmapButtonShortcutKey(self._curButtonsShortcuts, self._registerKey)
  self:uiRefresh()
  self._curButtonsShortcuts = nil
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_Refresh()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self:uiRefresh()
  self._curButtonsShortcuts = nil
end
function PaGlobal_WorldmapButtonShortcuts_All_CurrentRefresh()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  local saveCurId = self._curId
  self:uiRefresh(self._curId)
  self._curId = saveCurId
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_SetDefault()
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  self._curId = -1
  self._ui.list2_keySet:requestUpdateVisible()
  ClearFocusEdit()
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_UiRefreshByGlobalKeyBinder(index)
  PaGlobal_WorldmapButtonShortcuts_All:uiRefresh(index)
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_RemoveByGlobalKeyBinder()
  PaGlobal_WorldmapButtonShortcuts_All:remove()
end
function PaGlobalFunc_WorldmapButtonShorcuts_All_Register(VirtualKeyCode)
  PaGlobal_WorldmapButtonShortcuts_All:register(VirtualKeyCode)
end
function PaGlobalFunc_WorldmapButtonShortcuts_All_CheckUiEdit(uiEdit)
  local self = PaGlobal_WorldmapButtonShortcuts_All
  if self == nil then
    return
  end
  if self._ui == nil or self._ui.edit_search == nil then
    return false
  end
  if Panel_Window_ButtonShortcuts_All:GetShow() == false then
    return false
  end
  if uiEdit:GetKey() == self._ui.edit_search:GetKey() then
    return true
  end
  return false
end
