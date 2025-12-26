function PaGlobal_ReforgePresetNameEdit:initialize()
  if self._initialize == true then
    return
  end
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  self._presetCount = ToClient_GetMaxReforgeStonePresetCount()
  local defaultControl = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "RadioButton_0")
  for index = 1, self._presetCount - 1 do
    UI.cloneControl(defaultControl, Panel_Window_ReforgePresetNameEdit_All, "RadioButton_" .. tostring(index))
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "Button_Close")
  for index = 0, self._presetCount - 1 do
    self._ui.rdo_Button[index] = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "RadioButton_" .. tostring(index))
    self._ui.rdo_Button[index]:SetText(tostring(index + 1))
  end
  self._ui.txt_PresetName = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "StaticText_RegistItemName")
  self._ui.edit_Name = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "Edit_Naming")
  self._ui.edit_Name:SetMaxInput(ToClient_GetReforgeStonePresetNameLength())
  local bottomButton = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "Static_BottomButton")
  self._ui.btn_Confirm = UI.getChildControl(bottomButton, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(bottomButton, "Button_Cancel")
  self._ui.btn_Reset = UI.getChildControl(bottomButton, "Button_Reset")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_Window_ReforgePresetNameEdit_All, "Static_Bottombg")
  self._ui.txt_ChangeName = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_ChangeName")
  self._ui.txt_Confirm = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Confirm_ConsoleUI")
  self._ui.txt_Cancel = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Cancel_ConsoleUI")
  self._ui.txt_SelectPreset = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_PresetSelect_ConsoleUI")
  self._ui.txt_ResetName = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_ResetName")
  self._isConsole = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ReforgePresetNameEdit:alignButtonControlPos()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  local validBtnCount = 0
  for index = 0, self._presetCount - 1 do
    if self._ui.rdo_Button[index]:GetShow() == true then
      validBtnCount = validBtnCount + 1
    end
  end
  local controlSizeX = self._ui.rdo_Button[1]:GetSizeX()
  local controlAreaSize = controlSizeX * validBtnCount + self._btnGapX * (validBtnCount - 1)
  local startPosX = Panel_Window_ReforgePresetNameEdit_All:GetSizeX() / 2 - controlAreaSize / 2
  for index = 0, validBtnCount - 1 do
    self._ui.rdo_Button[index]:SetPosX(startPosX)
    startPosX = startPosX + controlSizeX + self._btnGapX
  end
end
function PaGlobal_ReforgePresetNameEdit:updateValidButton()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  local currentPresetCount = ToClient_GetCurrentReforgeStonePresetCount()
  for index = 0, self._presetCount - 1 do
    if index <= currentPresetCount then
      self._ui.rdo_Button[index]:SetShow(true)
    else
      self._ui.rdo_Button[index]:SetShow(false)
    end
  end
  self:alignButtonControlPos()
end
function PaGlobal_ReforgePresetNameEdit:registEventHandler()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_ReforgePresetNameEdit_ClickPresetForConsole(true)")
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_ReforgePresetNameEdit_ClickPresetForConsole(false)")
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ReforgePresetNameEdit:setFocusEditText(false)")
    self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
    Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ReforgePresetNameEdit:clearPresetName()")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ReforgePresetNameEdit_Close()")
    for index = 0, self._presetCount - 1 do
      self._ui.rdo_Button[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_ReforgePresetNameEdit_ClickPreset(" .. tostring(index) .. ")")
    end
    self._ui.edit_Name:addInputEvent("Mouse_LUp", "PaGlobal_ReforgePresetNameEdit:setFocusEditText(false)")
    self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_ReforgePresetNameEdit:savePresetName()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ReforgePresetNameEdit_Close()")
    self._ui.btn_Reset:addInputEvent("Mouse_LUp", "PaGlobal_ReforgePresetNameEdit:clearPresetName()")
  end
  registerEvent("FromClient_SaveReforgeStonePresetName", "FromClient_ReforgePresetNameEdit_SavePresetName")
  registerEvent("FromClient_CheckChinaProhibitedWord_SaveReforgeStonePresetName", "FromClient_CheckChinaProhibitedWord_SaveReforgeStonePresetName")
end
function PaGlobal_ReforgePresetNameEdit:prepareOpen()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:updateValidButton()
  for index = 0, self._presetCount - 1 do
    self._ui.rdo_Button[index]:SetCheck(false)
  end
  self:clickPreset(0)
  if self._isConsole == true then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Confirm:SetShow(false)
    self._ui.btn_Cancel:SetShow(false)
    self._ui.btn_Reset:SetShow(false)
    self._ui.stc_BottomBG:SetShow(true)
    local keyGuideTable = {
      self._ui.txt_ResetName,
      self._ui.txt_ChangeName,
      self._ui.txt_Confirm,
      self._ui.txt_Cancel,
      self._ui.txt_SelectPreset
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  Panel_Window_ReforgePresetNameEdit_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self:open()
end
function PaGlobal_ReforgePresetNameEdit:open()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  Panel_Window_ReforgePresetNameEdit_All:SetShow(true)
end
function PaGlobal_ReforgePresetNameEdit:prepareClose()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    if self._isConsole == true then
      self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
      Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ReforgePresetNameEdit:savePresetName()")
    else
      self._ui.btn_Confirm:SetIgnore(false)
    end
  end
  Panel_Window_ReforgePresetNameEdit_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self:close()
end
function PaGlobal_ReforgePresetNameEdit:close()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  Panel_Window_ReforgePresetNameEdit_All:SetShow(false)
end
function PaGlobal_ReforgePresetNameEdit:clickPreset(index)
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  for btnIndex = 0, self._presetCount - 1 do
    if btnIndex == index then
      self._ui.rdo_Button[btnIndex]:SetCheck(true)
    else
      self._ui.rdo_Button[btnIndex]:SetCheck(false)
    end
  end
  self._indexForConsole = index
  local presetName = ToClient_GetReforgeStonePresetName(index)
  if presetName == nil or presetName == "" then
    presetName = tostring(index + 1)
  end
  self._ui.txt_PresetName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_PresetName:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_CURRENTNAME", "name", presetName))
  self:setFocusEditText(true)
end
function PaGlobal_ReforgePresetNameEdit:setFocusEditText(isRefresh)
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  if isRefresh == true then
    self._ui.edit_Name:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_EDITBOX"))
    ClearFocusEdit()
  else
    self._ui.edit_Name:SetEditText("")
    SetFocusEdit(self._ui.edit_Name)
  end
end
function PaGlobal_ReforgePresetNameEdit:savePresetName()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  if self._ui.edit_Name:GetText() == PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_PRESETEDIT_EDITBOX") then
    return
  end
  if self._ui.edit_Name:GetText() == "" then
    NotifyDisplay(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNameCharacterIsInvalid"))
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(self._ui.edit_Name:GetText(), __eSceneIdReforgeStonePresetName)
    if result == true then
      if self._isConsole == true then
        self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        Panel_Window_ReforgePresetNameEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      else
        self._ui.btn_Confirm:SetIgnore(true)
      end
    end
    return
  end
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
function PaGlobal_ReforgePresetNameEdit:clearPresetName()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  local index = -1
  for btnIndex = 0, self._presetCount - 1 do
    if self._ui.rdo_Button[btnIndex]:IsCheck() == true then
      index = btnIndex
    end
  end
  if index == -1 then
    return
  end
  self._ui.edit_Name:SetEditText("")
  ToClient_ChangeReforgeStonePresetName(index, "")
end
function PaGlobal_ReforgePresetNameEdit:validate()
  if Panel_Window_ReforgePresetNameEdit_All == nil then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_PresetName:isValidate()
  self._ui.edit_Name:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.btn_Reset:isValidate()
  self._ui.stc_BottomBG:isValidate()
  self._ui.txt_ChangeName:isValidate()
  self._ui.txt_Confirm:isValidate()
  self._ui.txt_Cancel:isValidate()
  self._ui.txt_SelectPreset:isValidate()
  for btnIndex = 0, self._presetCount - 1 do
    self._ui.rdo_Button[btnIndex]:isValidate()
  end
end
