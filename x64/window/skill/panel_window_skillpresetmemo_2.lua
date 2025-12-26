function PaGlobalFunc_SkillPresetMemo_Open(openType, slotNo)
  PaGloabal_SkillPresetMemo:prepareOpen(openType, slotNo)
end
function PaGlobalFunc_SkillPresetMemo_Close()
  PaGloabal_SkillPresetMemo:prepareClose()
end
function FromClient_SetSkillPresetMemo(slotNo)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET" .. tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1) .. "_SAVE_ACK"))
  HandleEventLUp_SkillPresetMemo_Close()
  PaGlobal_TotalPreset_UpdatePreset()
end
function FromClient_SetQuickMenuPresetName(presetIndex)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RINGMENUPRESET" .. tostring(presetIndex + 1) .. "_SAVE_ACK"))
  HandleEventLUp_SkillPresetMemo_Close()
  PaGlobalFunc_ConsoleQuickMenuSetting_UpdatePresetMenu()
end
function HandleEventLUp_SkillPresetMemo_Close()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  PaGlobalFunc_SkillPresetMemo_Close()
end
function HandleEventLUp_SkillPresetMemo_EditText()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  SetFocusEdit(PaGloabal_SkillPresetMemo._ui.edit_memo)
end
function HandleEventLUp_SkillPresetMemo_Save()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == PaGloabal_SkillPresetMemo._selectSlotNo then
    return
  end
  local saveStr = PaGloabal_SkillPresetMemo._ui.edit_memo:GetEditText()
  if "" == saveStr or nil == saveStr or " " == saveStr or string.len(saveStr) <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT"))
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(saveStr, __eSceneIdSetSkillPresetMemo)
    if result == true then
      if PaGloabal_SkillPresetMemo._isConsole == false then
        PaGloabal_SkillPresetMemo._ui.btn_save:SetIgnore(true)
        PaGloabal_SkillPresetMemo._ui.edit_memo:RegistReturnKeyEvent("")
      else
        Panel_Window_SkillPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
    end
    return
  end
  local self = PaGloabal_SkillPresetMemo
  local ApplyPresetMemo, contentStr
  if self._curOpenType == self._OPENTYPE._SKILL then
    function ApplyPresetMemo()
      ToClient_setSkillPresetMemo(PaGloabal_SkillPresetMemo._selectSlotNo, saveStr)
    end
    contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DESC_MSG", "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1), "name", saveStr)
  else
    if self._curOpenType == self._OPENTYPE._QUICKMENU then
      function ApplyPresetMemo()
        ToClient_SetQuickMenuPresetName(PaGloabal_SkillPresetMemo._selectSlotNo, saveStr)
      end
      contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RINGMENUPRESET_NAME_DESC_MSG", "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1), "name", saveStr)
    else
    end
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = contentStr,
    functionYes = ApplyPresetMemo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  ClearFocusEdit()
  CheckChattingInput()
end
function HandleEventLUp_SkillPresetMemo_Reset()
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  if nil == PaGloabal_SkillPresetMemo._selectSlotNo then
    return
  end
  local saveStr = PaGloabal_SkillPresetMemo._ui.edit_memo:GetEditText()
  if "" == saveStr or nil == saveStr or string.len(saveStr) <= 0 then
    return
  end
  local self = PaGloabal_SkillPresetMemo
  local ResetPresetMemo, contentStr
  if self._curOpenType == self._OPENTYPE._SKILL then
    function ResetPresetMemo()
      ToClient_resetSkillPresetMemo(PaGloabal_SkillPresetMemo._selectSlotNo)
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DELETE_ACK"))
      PaGloabal_SkillPresetMemo._ui.edit_memo:SetEditText("", true)
    end
    contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DELETE_MSG", "name", saveStr, "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1))
  else
    if self._curOpenType == self._OPENTYPE._QUICKMENU then
      function ResetPresetMemo()
        ToClient_ResetQuickMenuPresetName(PaGloabal_SkillPresetMemo._selectSlotNo)
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RINGMENUPRESET_NAME_DELETE_ACK"))
        PaGloabal_SkillPresetMemo._ui.edit_memo:SetEditText("", true)
        PaGlobalFunc_ConsoleQuickMenuSetting_UpdatePresetMenu()
      end
      contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RINGMENUPRESET_NAME_DELETE_MSG", "name", saveStr, "num", tostring(PaGloabal_SkillPresetMemo._selectSlotNo + 1))
    else
    end
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = contentStr,
    functionYes = ResetPresetMemo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
  ClearFocusEdit()
end
function HandlePadEvent_SkillPresetMemo_EndVirtualKey(str)
  if nil == Panel_Window_SkillPresetMemo then
    return
  end
  ClearFocusEdit()
  PaGloabal_SkillPresetMemo._ui.edit_memo:SetEditText(str, true)
end
function PaGlobalFunc_SkillPresetMemo_IsSetMemo(slotNo)
  local memo = ToClient_getSkillPresetMemo(slotNo)
  if "" == memo or nil == memo or " " == memo or string.len(memo) <= 0 then
    return false, ""
  end
  return true, memo
end
function FromClient_CheckChinaProhibitedWord_SetSkillPresetMemo(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGloabal_SkillPresetMemo
  if self == nil then
    return
  end
  if self._isConsole == false then
    self._ui.btn_save:SetIgnore(false)
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_SkillPresetMemo_Save()")
  else
    Panel_Window_SkillPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SkillPresetMemo_Save()")
  end
  if isPass == true then
    local ApplyPresetMemo, contentStr
    if self._curOpenType == self._OPENTYPE._SKILL then
      function ApplyPresetMemo()
        ToClient_setSkillPresetMemo(self._selectSlotNo, filteredText)
      end
      contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SKILLPRESET_NAME_DESC_MSG", "num", tostring(self._selectSlotNo + 1), "name", filteredText)
    else
      if self._curOpenType == self._OPENTYPE._QUICKMENU then
        function ApplyPresetMemo()
          ToClient_SetQuickMenuPresetName(self._selectSlotNo, filteredText)
        end
        contentStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RINGMENUPRESET_NAME_DESC_MSG", "num", tostring(self._selectSlotNo + 1), "name", filteredText)
      else
      end
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = contentStr,
      functionYes = ApplyPresetMemo,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
    ClearFocusEdit()
    CheckChattingInput()
  end
end
