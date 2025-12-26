function PaGlobal_SailorPreset_NameEdit_All:initialize()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._btn_close = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "Button_Close")
  for index = 1, 10 do
    local rdoButton = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "RadioButton_" .. index)
    self._ui._rdo_buttonList:push_back(rdoButton)
  end
  self._ui._txt_presetName = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "StaticText_RegistItemName")
  self._ui._edit_name = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "Edit_Naming")
  self._ui._stc_bottomButton = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "Static_BottomButton")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_bottomButton, "Button_Confirm")
  self._ui._btn_cancel = UI.getChildControl(self._ui._stc_bottomButton, "Button_Cancel")
  self._ui._stc_bottomBG = UI.getChildControl(Panel_Window_SailorPreset_NameEdit_All, "Static_Bottombg")
  self._ui._txt_changeName = UI.getChildControl(self._ui._stc_bottomBG, "StaticText_ChangeName")
  self._ui._txt_confirm = UI.getChildControl(self._ui._stc_bottomBG, "StaticText_Confirm_ConsoleUI")
  self._ui._txt_cancel = UI.getChildControl(self._ui._stc_bottomBG, "StaticText_Cancel_ConsoleUI")
  self._ui._txt_selectGroup = UI.getChildControl(self._ui._stc_bottomBG, "StaticText_GroupSelect_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping == true
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SailorPreset_NameEdit_All:registerEventHandler()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  registerEvent("FromClient_UpdateEmployeePresetName", "FromClient_UpdateEmployeePresetName()")
  registerEvent("FromClient_CheckChinaProhibitedWord_EditEmployeePresetName", "FromClient_CheckChinaProhibitedWord_EditEmployeePresetName()")
  if self._isConsole == true then
    Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_SailorPreset_NameEdit_ClickGroupForConsole(true)")
    Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_SailorPreset_NameEdit_ClickGroupForConsole(false)")
    Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_SailorPreset_NameEdit_All:setFocusEditText(false)")
    Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
    self._ui._edit_name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPreset_NameEdit_All_Close()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPreset_NameEdit_All_Close()")
    for index = 1, 10 do
      self._ui._rdo_buttonList[index]:addInputEvent("Mouse_LUp", "PaGlobal_SailorPreset_NameEdit_All:clickGroup(" .. index .. ")")
    end
    self._ui._edit_name:addInputEvent("Mouse_LUp", "PaGlobal_SailorPreset_NameEdit_All:setFocusEditText(false)")
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_SailorPreset_NameEdit_All:saveGroupName()")
  end
end
function PaGlobal_SailorPreset_NameEdit_All:prepareOpen()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  local presetMaxCount = ToClient_getEmployeePresetCount()
  if presetMaxCount <= 5 then
    local startSpanSizeX = (presetMaxCount - 1) * -20
    for i = 1, presetMaxCount do
      self._ui._rdo_buttonList[i]:SetSpanSize(startSpanSizeX + (i - 1) * 40, 130)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
  else
    local firstRowstartSpanSizeX = -80
    local secondRowstartSpanSizeX = (presetMaxCount - 5 - 1) * -20
    for i = 1, 5 do
      self._ui._rdo_buttonList[i]:SetSpanSize(firstRowstartSpanSizeX + (i - 1) * 40, 110)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
    for i = 6, presetMaxCount do
      self._ui._rdo_buttonList[i]:SetSpanSize(secondRowstartSpanSizeX + (i - 6) * 40, 150)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
  end
  for index = 1, 10 do
    self._ui._rdo_buttonList[index]:SetCheck(false)
  end
  self:clickGroup(1)
  if self._isConsole == true then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_confirm:SetShow(false)
    self._ui._btn_cancel:SetShow(false)
    self._ui._stc_bottomBG:SetShow(true)
    local keyGuideTable = {
      self._ui._txt_changeName,
      self._ui._txt_confirm,
      self._ui._txt_cancel,
      self._ui._txt_selectGroup
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui._stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  Panel_Window_SailorPreset_NameEdit_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  ToClient_padSnapSetTargetPanel(Panel_Window_SailorPreset_NameEdit_All)
  self:open()
end
function PaGlobal_SailorPreset_NameEdit_All:open()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  Panel_Window_SailorPreset_NameEdit_All:SetShow(true)
end
function PaGlobal_SailorPreset_NameEdit_All:prepareClose()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  self._indexForConsole = 1
  Panel_Window_SailorPreset_NameEdit_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  ToClient_padSnapResetControl()
  self:close()
end
function PaGlobal_SailorPreset_NameEdit_All:close()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  Panel_Window_SailorPreset_NameEdit_All:SetShow(false)
end
function PaGlobal_SailorPreset_NameEdit_All:clickGroup(presetIndex)
  for index = 1, 10 do
    if index == presetIndex then
      self._ui._rdo_buttonList[index]:SetCheck(true)
    else
      self._ui._rdo_buttonList[index]:SetCheck(false)
    end
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
  local presetName = ToClient_getEmployeePresetName(currentServantcharacterKeyRaw, presetIndex - 1)
  if presetName == nil then
    self._ui._txt_presetName:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_CURRENTNAME", "name", tostring(presetIndex)))
  else
    self._ui._txt_presetName:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_CURRENTNAME", "name", presetName))
  end
  self._ui._edit_name:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE"))
  ClearFocusEdit()
end
function PaGlobal_SailorPreset_NameEdit_All:setFocusEditText(isRefresh)
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  if isRefresh == true then
    self._ui._edit_name:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE"))
    ClearFocusEdit()
  else
    self._ui._edit_name:SetEditText("")
    SetFocusEdit(self._ui._edit_name)
  end
end
function PaGlobal_SailorPreset_NameEdit_All:saveGroupName()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  if self._ui._edit_name:GetText() == PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE") then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local textValue = self._ui._edit_name:GetText()
    local result = ToClient_CheckChinaProhibitedWord(textValue, __eSceneIdSailorPresetName)
    if result == true then
      if _ContentsGroup_UsePadSnapping == true then
        Panel_Window_SailorPreset_NameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        self._ui._edit_name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      else
        self._ui._btn_confirm:addInputEvent("Mouse_LUp", "")
      end
    end
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
  local presetIndex = -1
  for index = 1, 10 do
    if self._ui._rdo_buttonList[index]:IsCheck() == true then
      presetIndex = index
      break
    end
  end
  ToClient_saveEmployeePresetName(currentServantcharacterKeyRaw, presetIndex - 1, self._ui._edit_name:GetText())
end
function PaGlobal_SailorPreset_NameEdit_All:validate()
  if Panel_Window_SailorPreset_NameEdit_All == nil then
    return
  end
  self._ui._btn_close:isValidate()
  for index = 1, 10 do
    self._ui._rdo_buttonList[index]:isValidate()
  end
  self._ui._txt_presetName:isValidate()
  self._ui._edit_name:isValidate()
  self._ui._stc_bottomButton:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._stc_bottomBG:isValidate()
  self._ui._txt_changeName:isValidate()
  self._ui._txt_confirm:isValidate()
  self._ui._txt_cancel:isValidate()
  self._ui._txt_selectGroup:isValidate()
end
