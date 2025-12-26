function PaGlobal_SailorPresetGroup_All:initialize()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._btn_close = UI.getChildControl(Panel_Window_SailorPresetGroup_All, "Button_Close")
  local stc_bottom = UI.getChildControl(Panel_Window_SailorPresetGroup_All, "Static_BottomButton")
  self._ui._btn_confirm = UI.getChildControl(stc_bottom, "Button_Confirm")
  self._ui._btn_cancel = UI.getChildControl(stc_bottom, "Button_Cancel")
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  for i = 1, 10 do
    local radioButton = UI.getChildControl(Panel_Window_SailorPresetGroup_All, "RadioButton_" .. i)
    radioButton:SetShow(false)
    self._ui._rdo_buttonList:push_back(radioButton)
  end
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SailorPresetGroup_All:registerEventHandler()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetGroup_All_Close()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetGroup_All_ClickConfirm()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetGroup_All_ClickCancel()")
  local employeePresetMaxCount = ToClient_getEmployeePresetMaxCount()
  for i = 1, employeePresetMaxCount do
    self._ui._rdo_buttonList[i]:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetGroup_All_SelectPresetNo(" .. i .. ")")
  end
  registerEvent("FromClient_SailorPresetGroup_SaveEmployeePreset", "FromClient_SailorPresetGroup_SaveEmployeePreset()")
end
function PaGlobal_SailorPresetGroup_All:prepareOpen()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  local presetMaxCount = ToClient_getEmployeePresetCount()
  if presetMaxCount <= 5 then
    local startSpanSizeX = (presetMaxCount - 1) * -20
    for i = 1, presetMaxCount do
      self._ui._rdo_buttonList[i]:SetSpanSize(startSpanSizeX + (i - 1) * 40, 165)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
  else
    local firstRowstartSpanSizeX = -80
    local secondRowstartSpanSizeX = (presetMaxCount - 5 - 1) * -20
    for i = 1, 5 do
      self._ui._rdo_buttonList[i]:SetSpanSize(firstRowstartSpanSizeX + (i - 1) * 40, 145)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
    for i = 6, presetMaxCount do
      self._ui._rdo_buttonList[i]:SetSpanSize(secondRowstartSpanSizeX + (i - 6) * 40, 185)
      self._ui._rdo_buttonList[i]:SetShow(true)
    end
  end
  self._selectedPresetIndex = -1
  if self._isPadSnapping == true then
    Panel_Dialog_ServantInfo_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    Panel_Dialog_ServantList_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_SailorPresetGroup_All)
  end
  self:open()
end
function PaGlobal_SailorPresetGroup_All:open()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  Panel_Window_SailorPresetGroup_All:SetShow(true)
end
function PaGlobal_SailorPresetGroup_All:prepareClose()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  local employeePresetMaxCount = ToClient_getEmployeePresetMaxCount()
  for i = 1, employeePresetMaxCount do
    local radioButton = UI.getChildControl(Panel_Window_SailorPresetGroup_All, "RadioButton_" .. i)
    radioButton:SetCheck(false)
  end
  self._selectedPresetIndex = -1
  if self._isPadSnapping == true then
    Panel_Dialog_ServantInfo_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    Panel_Dialog_ServantList_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    ToClient_padSnapResetControl()
  end
  self:close()
end
function PaGlobal_SailorPresetGroup_All:close()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
  Panel_Window_SailorPresetGroup_All:SetShow(false)
end
function PaGlobal_SailorPresetGroup_All:validate()
  if Panel_Window_SailorPresetGroup_All == nil then
    return
  end
end
