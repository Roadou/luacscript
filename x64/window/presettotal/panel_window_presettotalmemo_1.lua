function PaGlobal_TotalPresetMemo:initialize()
  if PaGlobal_TotalPresetMemo._initialize == true or Panel_Window_TotalPresetMemo == nil then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_TotalPresetMemo, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_TItle")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_TotalPresetMemo, "Static_MainArea")
  self._ui.btn_save = UI.getChildControl(self._ui.stc_mainBg, "Button_Write")
  self._ui.btn_reset = UI.getChildControl(self._ui.stc_mainBg, "Button_Reset")
  self._ui.edit_memo = UI.getChildControl(self._ui.stc_mainBg, "Edit_NoticeSquare")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_TotalPresetMemo, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_LT = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_LT_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_X = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TotalPresetMemo:validate()
  PaGlobal_TotalPresetMemo:registEventHandler()
  PaGlobal_TotalPresetMemo:swichPlatform(self._isConsole)
  PaGlobal_TotalPresetMemo._initialize = true
end
function PaGlobal_TotalPresetMemo:swichPlatform(isConsole)
  if isConsole == true then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_save:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.stc_keyGuideBg:SetShow(true)
    Panel_Window_TotalPresetMemo:SetSize(Panel_Window_TotalPresetMemo:GetSizeX(), Panel_Window_TotalPresetMemo:GetSizeY() - self._ui.btn_save:GetSizeY() - 10)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_save:SetShow(true)
    self._ui.btn_reset:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_TotalPresetMemo:prepareOpen(presetKey)
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  self._selectPresetKey = presetKey
  self._ui.edit_memo:SetMaxInput(ToClient_GetTotalPresetNameLength())
  self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TOTAL_PRESET_NAME_TITLE"))
  if self._isConsole == true then
    Panel_Window_TotalPresetMemo:ignorePadSnapMoveToOtherPanel()
  end
  self:open()
  self:update()
  self:resize()
end
function PaGlobal_TotalPresetMemo:open()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  Panel_Window_TotalPresetMemo:SetShow(true)
end
function PaGlobal_TotalPresetMemo:prepareClose()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  self._selectSlotNo = nil
  if _ContentsOption_CH_CheckProhibitedWord == true then
    if self._isConsole == false then
      self._ui.btn_save:SetIgnore(false)
      self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_TotalPresetMemo_Save()")
    else
      Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TotalPresetMemo_Save()")
    end
  end
  PaGlobal_TotalPresetMemo:close()
end
function PaGlobal_TotalPresetMemo:close()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  Panel_Window_TotalPresetMemo:SetShow(false)
end
function PaGlobal_TotalPresetMemo:update()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  if self._selectPresetKey == nil then
    self._ui.edit_memo:SetEditText("")
    return
  end
  local memoContent = ToClient_GetTotalPresetName(self._selectPresetKey)
  self._ui.edit_memo:SetEditText(memoContent, false)
end
function PaGlobal_TotalPresetMemo:registEventHandler()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  if self._isConsole == false then
    self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalPresetMemo_Close()")
    self._ui.edit_memo:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalPresetMemo_EditText()")
    self._ui.btn_save:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalPresetMemo_Save()")
    self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalPresetMemo_Reset()")
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_TotalPresetMemo_Save()")
  else
    Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TotalPresetMemo_Save()")
    Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_TotalPresetMemo_EditText()")
    Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_TotalPresetMemo_Reset()")
    self._ui.edit_memo:setXboxVirtualKeyBoardEndEvent("HandlePadEvent_TotalPresetMemo_EndVirtualKey")
    Panel_Window_TotalPresetMemo:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  registerEvent("FromClient_CheckChinaProhibitedWord_SetTotalPresetName", "FromClient_CheckChinaProhibitedWord_SetTotalPresetName")
  registerEvent("FromClient_TotalPreset_CompleteChangeName", "FromClient_TotalPresetMemo_CompleteChangeMemo")
end
function PaGlobal_TotalPresetMemo:validate()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.edit_memo:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
  self._ui.stc_keyGuide_LT:isValidate()
  self._ui.stc_keyGuide_B:isValidate()
  self._ui.stc_keyGuide_X:isValidate()
  self._ui.stc_keyGuide_Y:isValidate()
end
function PaGlobal_TotalPresetMemo:resize()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  if self._isConsole == true then
    local keyguideArr = {
      self._ui.stc_keyGuide_LT,
      self._ui.stc_keyGuide_X,
      self._ui.stc_keyGuide_Y,
      self._ui.stc_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguideArr, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._ui.stc_keyGuideBg:ComputePos()
end
