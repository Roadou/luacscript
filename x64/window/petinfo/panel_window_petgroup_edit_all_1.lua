function PaGlobal_PetGroupEdit:initialize()
  if self._initialize == true then
    return
  end
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if _ContentsGroup_PetPresetExpansion == true then
    self._groupCount = ToClient_GetMaxPetPresetCount()
    local defaultControl = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_1")
    for index = 6, self._groupCount do
      UI.cloneControl(defaultControl, Panel_Window_GroupEdit_All, "RadioButton_" .. tostring(index))
    end
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_GroupEdit_All, "Button_Close")
  for index = 1, self._groupCount do
    self._ui.rdo_Button[index] = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_" .. tostring(index))
    self._ui.rdo_Button[index]:SetText(tostring(index))
  end
  self._ui.txt_GroupName = UI.getChildControl(Panel_Window_GroupEdit_All, "StaticText_RegistItemName")
  self._ui.edit_Name = UI.getChildControl(Panel_Window_GroupEdit_All, "Edit_Naming")
  self._ui.edit_Name:SetMaxInput(getGameServiceTypeCharacterNameLength())
  local bottomButton = UI.getChildControl(Panel_Window_GroupEdit_All, "Static_BottomButton")
  self._ui.btn_Confirm = UI.getChildControl(bottomButton, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(bottomButton, "Button_Cancel")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_Window_GroupEdit_All, "Static_Bottombg")
  self._ui.txt_ChangeName = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_ChangeName")
  self._ui.txt_Confirm = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Confirm_ConsoleUI")
  self._ui.txt_Cancel = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Cancel_ConsoleUI")
  self._ui.txt_SelectGroup = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_GroupSelect_ConsoleUI")
  self._isConsole = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_PetGroupEdit:alignButtonControlPos()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  local validBtnCount = 0
  for index = 1, self._groupCount do
    if self._ui.rdo_Button[index]:GetShow() == true then
      validBtnCount = validBtnCount + 1
    end
  end
  local controlSizeX = self._ui.rdo_Button[1]:GetSizeX()
  local controlAreaSize = controlSizeX * validBtnCount + self._btnGapX * (validBtnCount - 1)
  local startPosX = Panel_Window_GroupEdit_All:GetSizeX() / 2 - controlAreaSize / 2
  for index = 1, validBtnCount do
    self._ui.rdo_Button[index]:SetPosX(startPosX)
    startPosX = startPosX + controlSizeX + self._btnGapX
  end
end
function PaGlobal_PetGroupEdit:updateValidButton()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if _ContentsGroup_PetPresetExpansion == true then
    local currentPresetCount = ToClient_GetPetPresetCount()
    for index = 6, self._groupCount do
      if index <= currentPresetCount then
        self._ui.rdo_Button[index]:SetShow(true)
      else
        self._ui.rdo_Button[index]:SetShow(false)
      end
    end
  end
  self:alignButtonControlPos()
end
function PaGlobal_PetGroupEdit:registEventHandler()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  registerEvent("FromClient_SavePetGroupName", "FromClient_SavePetGroupName")
  if self._isConsole == true then
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(true)")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(false)")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_PetGroupEdit:setFocusEditText(false)")
    self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_Close()")
    for index = 1, self._groupCount do
      self._ui.rdo_Button[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(" .. tostring(index) .. ")")
    end
    self._ui.edit_Name:addInputEvent("Mouse_LUp", "PaGlobal_PetGroupEdit:setFocusEditText(false)")
    self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_PetGroupEdit:saveGroupName()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_Close()")
  end
  registerEvent("FromClient_CheckChinaProhibitedWord_SavePetGroupName", "FromClient_CheckChinaProhibitedWord_SavePetGroupName")
end
function PaGlobal_PetGroupEdit:prepareOpen()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  self:updateValidButton()
  for index = 1, self._groupCount do
    self._ui.rdo_Button[index]:SetCheck(false)
  end
  self:clickGroup(1)
  if self._isConsole == true then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Confirm:SetShow(false)
    self._ui.btn_Cancel:SetShow(false)
    self._ui.stc_BottomBG:SetShow(true)
    local keyGuideTable = {
      self._ui.txt_ChangeName,
      self._ui.txt_Confirm,
      self._ui.txt_Cancel,
      self._ui.txt_SelectGroup
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  Panel_Window_GroupEdit_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self:open()
end
function PaGlobal_PetGroupEdit:open()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  Panel_Window_GroupEdit_All:SetShow(true)
end
function PaGlobal_PetGroupEdit:prepareClose()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    if self._isConsole == true then
      self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
      Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
    else
      self._ui.btn_Confirm:SetIgnore(false)
    end
  end
  Panel_Window_GroupEdit_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self:close()
end
function PaGlobal_PetGroupEdit:close()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  Panel_Window_GroupEdit_All:SetShow(false)
end
function PaGlobal_PetGroupEdit:clickGroup(index)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  for btnIndex = 1, self._groupCount do
    if btnIndex == index then
      self._ui.rdo_Button[btnIndex]:SetCheck(true)
    else
      self._ui.rdo_Button[btnIndex]:SetCheck(false)
    end
  end
  self._indexForConsole = index
  local groupName
  if _ContentsGroup_PetPresetExpansion == true then
    groupName = ToClient_GetPetPresetName(index)
  else
    groupName = ToClient_GetPetGroupName(index - 1)
  end
  if groupName == nil or groupName == "" then
    groupName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP_NAME", "name", tostring(index))
  end
  self._ui.txt_GroupName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETGROUPNAME_EDIT", "name", groupName))
  self:setFocusEditText(true)
end
function PaGlobal_PetGroupEdit:setFocusEditText(isRefresh)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if isRefresh == true then
    self._ui.edit_Name:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE"))
    ClearFocusEdit()
  else
    self._ui.edit_Name:SetEditText("")
    SetFocusEdit(self._ui.edit_Name)
  end
end
function PaGlobal_PetGroupEdit:saveGroupName()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if self._ui.edit_Name:GetText() == PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE") then
    return
  end
  if _ContentsGroup_PetPresetExpansion == false and _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(self._ui.edit_Name:GetText(), __eSceneIdSavePetGroupName)
    if result == true then
      if self._isConsole == true then
        self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      else
        self._ui.btn_Confirm:SetIgnore(true)
      end
    end
    return
  end
  local index = -1
  for btnIndex = 1, self._groupCount do
    if self._ui.rdo_Button[btnIndex]:IsCheck() == true then
      index = btnIndex
    end
  end
  if _ContentsGroup_PetPresetExpansion == false then
    ToClient_SavePetGroupName(index - 1, self._ui.edit_Name:GetText())
  else
    ToClient_ChangePetPresetName(index, self._ui.edit_Name:GetText())
  end
end
function PaGlobal_PetGroupEdit:validate()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.txt_GroupName:isValidate()
  self._ui.edit_Name:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.stc_BottomBG:isValidate()
  self._ui.txt_ChangeName:isValidate()
  self._ui.txt_Confirm:isValidate()
  self._ui.txt_Cancel:isValidate()
  self._ui.txt_SelectGroup:isValidate()
  for btnIndex = 1, self._groupCount do
    self._ui.rdo_Button[btnIndex]:isValidate()
  end
end
function FromClient_SavePetGroupName(groupName)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  PaGlobal_PetGroupEdit._ui.txt_GroupName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETGROUPNAME_EDIT", "name", groupName))
end
function FromClient_CheckChinaProhibitedWord_SavePetGroupName(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_PetGroupEdit
  if self == nil then
    return
  end
  if self._isConsole == true then
    self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
  else
    self._ui.btn_Confirm:SetIgnore(false)
  end
  if isPass == true then
    local index = -1
    for btnIndex = 1, self._groupCount do
      if self._ui.rdo_Button[btnIndex]:IsCheck() == true then
        index = btnIndex
      end
    end
    ToClient_SavePetGroupName(index - 1, filteredText)
  end
end
