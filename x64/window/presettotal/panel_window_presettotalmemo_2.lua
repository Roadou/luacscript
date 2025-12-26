function PaGlobalFunc_TotalPresetMemo_Open(presetKey)
  PaGlobal_TotalPresetMemo:prepareOpen(presetKey)
end
function PaGlobalFunc_TotalPresetMemo_Close()
  PaGlobal_TotalPresetMemo:prepareClose()
end
function HandleEventLUp_TotalPresetMemo_Close()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  PaGlobalFunc_TotalPresetMemo_Close()
end
function HandleEventLUp_TotalPresetMemo_EditText()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  SetFocusEdit(PaGlobal_TotalPresetMemo._ui.edit_memo)
end
function HandleEventLUp_TotalPresetMemo_Save()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  local self = PaGlobal_TotalPresetMemo
  if self == nil then
    return
  end
  if self._selectPresetKey == nil then
    return
  end
  local saveStr = self._ui.edit_memo:GetEditText()
  if saveStr == "" or saveStr == nil or saveStr == " " or string.len(saveStr) <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT"))
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(saveStr, __eSceneIdTotalPresetName)
    if result == true then
      if self._isConsole == false then
        self._ui.btn_save:SetIgnore(true)
        self._ui.edit_memo:RegistReturnKeyEvent("")
      else
        Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
    end
    return
  end
  ToClient_RequestChangeTotalPresetName(self._selectPresetKey, saveStr)
end
function HandleEventLUp_TotalPresetMemo_Reset()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  local self = PaGlobal_TotalPresetMemo
  if self == nil then
    return
  end
  if self._selectPresetKey == nil then
    return
  end
  local presetName = ToClient_GetTotalPresetName(self._selectPresetKey)
  if presetName == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAlreadyInitializedName"))
    return
  end
  ToClient_RequestChangeTotalPresetName(self._selectPresetKey, "")
end
function HandlePadEvent_TotalPresetMemo_EndVirtualKey(str)
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  local self = PaGlobal_TotalPresetMemo
  if self == nil then
    return
  end
  ClearFocusEdit()
  self._ui.edit_memo:SetEditText(str, true)
end
function FromClient_TotalPresetMemo_CompleteChangeMemo()
  if Panel_Window_TotalPresetMemo == nil then
    return
  end
  local self = PaGlobal_TotalPresetMemo
  if self == nil then
    return
  end
  local presetName = ToClient_GetTotalPresetName(self._selectPresetKey)
  if presetName == nil or presetName == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOTAL_PRESET_NAME_INITIALIZATION"))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTAL_PRESET_NAME_CONFIRM", "name", presetName))
  end
  PaGlobalFunc_TotalPresetMemo_Close()
end
function FromClient_CheckChinaProhibitedWord_SetTotalPresetName(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_TotalPresetMemo
  if self == nil then
    return
  end
  if self._isConsole == false then
    self._ui.btn_save:SetIgnore(false)
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_TotalPresetMemo_Save()")
  else
    Panel_Window_TotalPresetMemo:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TotalPresetMemo_Save()")
  end
  if isPass == true then
    ToClient_RequestChangeTotalPresetName(self._selectPresetKey, filteredText)
  end
end
