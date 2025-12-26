function PaGlobal_Telescope_All:initialize()
  if self._initialize == true or Panel_Window_Scope_All == nil then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_TitleBg = UI.getChildControl(Panel_Window_Scope_All, "Static_Title_BG")
  self._ui._stc_ContentsTitle = UI.getChildControl(stc_TitleBg, "StaticText_Title")
  self._ui._stc_ContentsDesc = UI.getChildControl(Panel_Window_Scope_All, "StaticText_Desc")
  self._ui._edit_TargetUserName = UI.getChildControl(Panel_Window_Scope_All, "Edit_FamilyName")
  self._ui._stc_ContentsDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._pc._btn_Close = UI.getChildControl(stc_TitleBg, "Button_Win_Close")
  self._ui._pc._btn_Confirm = UI.getChildControl(Panel_Window_Scope_All, "Button_Confirm")
  self._ui._console._txt_keyGuideInput = UI.getChildControl(self._ui._edit_TargetUserName, "StaticText_X_ConsoleUI")
  self._ui._console._keyGuideBg = UI.getChildControl(Panel_Window_Scope_All, "StaticText_Keyguide_BG")
  self._ui._console._txt_keyGuideClose = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui._console._txt_keyGuideConfirm = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_A_ConsoleUI")
  if self._isConsole == false then
    self._ui._pc._btn_Confirm:SetShow(true)
    self._ui._pc._btn_Close:SetShow(true)
    self._ui._console._keyGuideBg:SetShow(false)
    self._ui._console._txt_keyGuideInput:SetShow(false)
    self._ui._console._txt_keyGuideClose:SetShow(false)
    self._ui._console._txt_keyGuideConfirm:SetShow(false)
  else
    self._ui._console._keyGuideBg:SetShow(true)
    self._ui._console._txt_keyGuideInput:SetShow(true)
    self._ui._console._txt_keyGuideClose:SetShow(true)
    self._ui._console._txt_keyGuideConfirm:SetShow(true)
    self._ui._pc._btn_Confirm:SetShow(false)
    self._ui._pc._btn_Close:SetShow(false)
    local keyguides = {
      self._ui._console._txt_keyGuideConfirm,
      self._ui._console._txt_keyGuideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui._console._keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self._initialize = true
  self:validate()
  self:registEventHandler()
end
function PaGlobal_Telescope_All:validate()
  self._ui._stc_ContentsTitle:isValidate()
  self._ui._stc_ContentsDesc:isValidate()
  self._ui._edit_TargetUserName:isValidate()
  self._ui._pc._btn_Confirm:isValidate()
  self._ui._pc._btn_Close:isValidate()
  self._ui._console._keyGuideBg:isValidate()
  self._ui._console._txt_keyGuideConfirm:isValidate()
  self._ui._console._txt_keyGuideClose:isValidate()
end
function PaGlobal_Telescope_All:prepareOpen()
  if Panel_Window_Scope_All == nil or Panel_Window_Scope_All:GetShow() == true then
    return
  end
  if Panel_Window_Scope_All == nil then
    return
  end
  self._itemSlotNo = nil
  self._itemWhereType = nil
  self._targetUserName = nil
  self._ui._edit_TargetUserName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGEGISTSOLDIER_NONAME_ALERT"))
  PaGlobal_Telescope_All:open()
end
function PaGlobal_Telescope_All:open()
  if Panel_Window_Scope_All == nil then
    return
  end
  Panel_Window_Scope_All:SetShow(true, true)
end
function PaGlobal_Telescope_All:prepareClose()
  if Panel_Window_Scope_All == nil then
    return
  end
  if Panel_Window_Scope_All:GetShow() == false then
    return
  end
  PaGlobal_Telescope_All:clear()
  PaGlobal_Telescope_All:close()
end
function PaGlobal_Telescope_All:close()
  if Panel_Window_Scope_All == nil then
    return
  end
  Panel_Window_Scope_All:SetShow(false, false)
end
function PaGlobal_Telescope_All:registEventHandler()
  if Panel_Window_Scope_All == nil then
    return
  end
  if self._isConsole == false then
    self._ui._pc._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Telescope_All_Close()")
    self._ui._pc._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Telescope_All_Confirm()")
    self._ui._edit_TargetUserName:addInputEvent("Mouse_LUp", "HandleEventLUp_Telescope_All_SetFocusTargetUser()")
    self._ui._edit_TargetUserName:RegistReturnKeyEvent("HandleEventLUp_Telescope_All_Confirm()")
  else
    Panel_Window_Scope_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Telescope_All_SetFocusTargetUser()")
    Panel_Window_Scope_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Telescope_All_Confirm()")
  end
  registerEvent("FromClient_UseTelescopeItemNotify", "FromClient_UseTelescopeItemNotify")
  registerEvent("FromClient_UpdateRegionKeyForTelescope", "FromClient_UpdateRegionKeyForTelescope")
  registerEvent("FromClient_GetRegionKeyForTelescopeFailed", "FromClient_GetRegionKeyForTelescopeFailed")
end
function PaGlobal_Telescope_All:clear()
  if Panel_Window_Scope_All == nil then
    return
  end
  self._itemSlotNo = nil
  self._itemWhereType = nil
  self._targetUserName = nil
  self._ui._edit_TargetUserName:SetEditText("")
  ClearFocusEdit()
end
function PaGlobal_Telescope_All:setEditFocusTargetUser()
  self._ui._edit_TargetUserName:SetEditText("")
  SetFocusEdit(self._ui._edit_TargetUserName)
end
