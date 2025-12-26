function PaGlobalFunc_SailorPreset_NameEdit_All_Open()
  local self = PaGlobal_SailorPreset_NameEdit_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SailorPreset_NameEdit_All_Close()
  local self = PaGlobal_SailorPreset_NameEdit_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SailorPreset_NameEdit_All_IsOpen()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  return Panel_Window_SailorPreset_NameEdit_All:GetShow()
end
function FromClient_UpdateEmployeePresetName(presetNo)
  local self = PaGlobal_SailorPreset_NameEdit_All
  if self == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
  local presetName = ToClient_getEmployeePresetName(currentServantcharacterKeyRaw, presetNo)
  if presetName ~= nil then
    self._ui._txt_presetName:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_CURRENTNAME", "name", presetName))
  end
end
function PaGlobalFunc_SailorPreset_NameEdit_ClickGroupForConsole(isLeft)
  local self = PaGlobal_SailorPreset_NameEdit_All
  if self == nil then
    return
  end
  if isLeft == true then
    self._indexForConsole = self._indexForConsole - 1
  elseif isLeft == false then
    self._indexForConsole = self._indexForConsole + 1
  end
  local presetCount = ToClient_getEmployeePresetCount()
  if self._indexForConsole < 1 then
    self._indexForConsole = presetCount
  elseif presetCount < self._indexForConsole then
    self._indexForConsole = 1
  end
  self:clickGroup(self._indexForConsole)
end
function FromClient_CheckChinaProhibitedWord_EditEmployeePresetName(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_SailorPreset_NameEdit_All
  if self == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
    self._ui._edit_name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
  else
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
  end
  if isPass == true then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
    if currentServantWrapper == nil then
      return
    end
    local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
    local presetIndex = -1
    for index = 1, 10 do
      if self._ui._rdo_buttonList[index]:IsCheck() == true then
        presetIndex = index
        break
      end
    end
    ToClient_saveEmployeePresetName(currentServantcharacterKeyRaw, presetIndex - 1, filteredText)
  else
    self._ui._edit_name:SetEditText("")
  end
end
