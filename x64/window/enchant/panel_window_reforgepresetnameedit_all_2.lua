function PaGlobalFunc_ReforgePresetNameEdit_Open()
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  PaGlobal_ReforgePresetNameEdit:prepareOpen()
end
function PaGlobalFunc_ReforgePresetNameEdit_Close()
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  PaGlobal_ReforgePresetNameEdit:prepareClose()
end
function PaGlobalFunc_ReforgePresetNameEdit_GetShow()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return false
  end
  return (Panel_Window_ReforgePresetNameEdit_All:GetShow())
end
function PaGlobalFunc_ReforgePresetNameEdit_ClickPreset(index)
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  self:clickPreset(index)
end
function PaGlobalFunc_ReforgePresetNameEdit_ClickPresetForConsole(isLeft)
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  local currentPresetCount = ToClient_GetCurrentReforgeStonePresetCount()
  if isLeft == true then
    self._indexForConsole = self._indexForConsole - 1
  elseif isLeft == false then
    self._indexForConsole = self._indexForConsole + 1
  end
  if self._indexForConsole < 0 then
    self._indexForConsole = currentPresetCount - 1
  elseif currentPresetCount <= self._indexForConsole then
    self._indexForConsole = 0
  end
  self:clickPreset(self._indexForConsole)
end
function FromClient_ReforgePresetNameEdit_SavePresetName(presetNo, presetName)
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  if presetName == nil or presetName == "" then
    presetName = tostring(self._indexForConsole + 1)
  end
  self._ui.txt_PresetName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_PresetName:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_CURRENTNAME", "name", presetName))
end
function FromClient_CheckChinaProhibitedWord_SaveReforgeStonePresetName(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_ReforgePresetNameEdit
  if self == nil then
    return
  end
  if self._isConsole == true then
    self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
  else
    self._ui.btn_Confirm:SetIgnore(false)
  end
  if isPass == true then
    local index = -1
    for btnIndex = 0, self._presetCount - 1 do
      if self._ui.rdo_Button[btnIndex]:IsCheck() == true then
        index = btnIndex
      end
    end
    if index == -1 then
      return
    end
    ToClient_ChangeReforgeStonePresetName(index, self._ui.edit_Name:GetText())
  end
end
