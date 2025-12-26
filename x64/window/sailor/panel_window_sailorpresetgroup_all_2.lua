function PaGlobalFunc_SailorPresetGroup_All_Open()
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SailorPresetGroup_All_Close()
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  self:prepareClose()
  if PaGlobalFunc_SailorPresetManager_All_Open ~= nil then
    PaGlobalFunc_SailorPresetManager_All_Open(false)
  end
end
function PaGlobalFunc_SailorPresetGroup_All_ClickConfirm()
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  if self._selectedPresetIndex == -1 then
    return
  end
  ToClient_saveEmployeePreset(self._selectedPresetIndex)
end
function PaGlobalFunc_SailorPresetGroup_All_ClickCancel()
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobalFunc_SailorPresetManager_All_Open(false)
end
function PaGlobalFunc_SailorPresetGroup_All_SelectPresetNo(presetNo)
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  self._selectedPresetIndex = presetNo - 1
end
function FromClient_SailorPresetGroup_SaveEmployeePreset()
  local self = PaGlobal_SailorPresetGroup_All
  if self == nil then
    return
  end
  local presetNo = self._selectedPresetIndex + 1
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SAVE", "number", presetNo))
  self:prepareClose()
  PaGlobalFunc_SailorPresetManager_All_Open(false)
end
