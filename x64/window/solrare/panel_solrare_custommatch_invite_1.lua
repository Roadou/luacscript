function PaGlobal_Solare_Custom_Invite:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._edit_UserNickName = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "Edit_CharacterName")
  self._ui._btn_Close = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "Button_Close")
  self._ui._btn_Confirm = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "Button_Yes")
  self._ui._btn_Cancel = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "Button_No")
  if self._isConsole == true then
    self._ui._console._keyGuideBg = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "Static_BottomBg_ConsoleUI")
    self._ui._console._stc_Confirm = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_A_ConsoleUI")
    self._ui._console._stc_Cancel = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_B_ConsoleUI")
    self._ui._console._stc_InputName = UI.getChildControl(Panel_Window_Solrare_CustomMatching_Invite, "StaticText_XButton")
    self._ui._edit_UserNickName:SetMaxInput(getGameServiceTypeCharacterNameLength())
  end
  self:validate()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_Solare_Custom_Invite:validate()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  self._ui._edit_UserNickName:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Confirm:isValidate()
  self._ui._btn_Cancel:isValidate()
  if self._isConsole == true then
    self._ui._console._keyGuideBg:isValidate()
    self._ui._console._stc_Confirm:isValidate()
    self._ui._console._stc_Cancel:isValidate()
    self._ui._console._stc_InputName:isValidate()
  end
end
function PaGlobal_Solare_Custom_Invite:registerEventHandler()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  if self._isConsole == false then
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SolareCustomInvite_Close()")
    self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_SolareCustomInvite_Confirm()")
    self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_SolareCustomInvite_Close()")
    self._ui._edit_UserNickName:RegistReturnKeyEvent("HandleEventLUp_SolareCustomInvite_Confirm()")
  else
    Panel_Window_Solrare_CustomMatching_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SolareCustomInvite_Confirm()")
    Panel_Window_Solrare_CustomMatching_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_SolareCustomInvite_Close()")
    Panel_Window_Solrare_CustomMatching_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SolareCustomInvite_InputName_SetFocus()")
  end
end
function PaGlobal_Solare_Custom_Invite:prepareOpen()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  self._ui._edit_UserNickName:SetEditText("")
  if self._isConsole == true then
    self._ui._btn_Close:SetShow(false)
    self._ui._btn_Confirm:SetShow(false)
    self._ui._btn_Cancel:SetShow(false)
    self._ui._console._keyGuideBg:SetShow(true)
    self._ui._console._stc_InputName:SetShow(true)
    local tempBtnGroup = {
      self._ui._console._stc_Confirm,
      self._ui._console._stc_Cancel
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui._console._keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self:open()
end
function PaGlobal_Solare_Custom_Invite:open()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  Panel_Window_Solrare_CustomMatching_Invite:SetShow(true)
end
function PaGlobal_Solare_Custom_Invite:prepareClose()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  self:close()
end
function PaGlobal_Solare_Custom_Invite:close()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  Panel_Window_Solrare_CustomMatching_Invite:SetShow(false)
end
function PaGlobal_Solare_Custom_Invite:inviteSolareCustomPlayer()
  if Panel_Window_Solrare_CustomMatching_Invite == nil then
    return
  end
  local invitePlayerName = self._ui._edit_UserNickName:GetEditText()
  if invitePlayerName == nil then
    return
  end
  ToClient_RequestInviteSolareCustomPlayer(invitePlayerName)
  self:prepareClose()
end
