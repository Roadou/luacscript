function FromClient_TotalPreset_CompleteChangeName()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:updateTotalPresetComboBox()
end
function FromClient_TotalPreset_ShowApplyFailMesaageBox(typeIndex, desc)
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  local presetTitle = {
    [__eTotalPresetType_AutoUse] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_AUTOBUFFTITLE"),
    [__eTotalPresetType_Skill] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_SKILLPRESETTITLE"),
    [__eTotalPresetType_Pet] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_PETGROUPTITLE"),
    [__eTotalPresetType_Artifact] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_ARTIFACTPRESETTITLE"),
    [__eTotalPresetType_Jewel] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_CRYSTALPRESETTITLE"),
    [__eTotalPresetType_Reforge] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_PRESETTITLE"),
    [__eTotalPresetType_Count] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_TITLE")
  }
  if presetTitle[typeIndex] == nil then
    return
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = "[" .. presetTitle[typeIndex] .. "]  " .. desc,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_TotalPreset_UpdateClassType()
  local self = PaGlobal_TotalPreset
  if self == nil or Panel_Window_PresetTotal_All:GetShow() == false then
    return
  end
  self:updateClassInfo()
  self:setClassTexture()
end
function PaGlobal_TotalPreset_Open()
  if PaGlobal_TotalPreset == nil then
    return
  end
  PaGlobal_TotalPreset:prepareOpen()
end
function PaGlobal_TotalPreset_Close()
  if PaGlobal_TotalPreset == nil then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
    return
  end
  PaGlobal_TotalPreset:prepareClose()
end
function PaGlobal_TotalPreset_UpdatePreset()
  if PaGlobal_TotalPreset == nil or Panel_Window_PresetTotal_All:GetShow() == false then
    return
  end
  PaGlobal_TotalPreset:updatePresetControls()
end
function HandleEventLUp_TotalPreset_OpenComboBox()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self._ui.btn_ComboBox:ToggleListbox()
end
function HandleEventLUp_ToatalPreset_SelectComboBox()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:updateTotalPresetComboBoxIndex()
end
function HandleEventLUp_ToatalPreset_ChangeTotalPresetName()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  PaGlobalFunc_TotalPresetMemo_Open(self._currentPresetKey)
end
function FromClient_ToatalPreset_UpdatePresetButton()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
  end
  self:updateSelectPreset()
end
function HandleEventLUp_ToatalPreset_SelectPresetButton(presetType, index)
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:selectPresetButton(presetType, index)
end
function HandleEventLUp_ToatalPreset_ApplyTotalPreset()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  if self._currentPresetKey == nil then
    return
  end
  ToClient_RequestApplyTotalPreset(self._currentPresetKey)
end
function HandleEventScroll_TotalPreset(isUp)
  local self = PaGlobal_TotalPreset
  if self == nil or Panel_Window_PresetTotal_All:GetShow() == false then
    return
  end
  if isUp == true then
    self._ui.stc_Frame:MouseUpScroll(self._ui.stc_Frame)
  else
    self._ui.stc_Frame:MouseDownScroll(self._ui.stc_Frame)
  end
end
function HandleEventLUp_ToatalPreset_OpenArtifactPresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  InventoryWindow_Show()
  PaGlobalFunc_LightStoneBag_Open()
  Panel_Window_PresetTotal_All:SetPosX(Panel_Window_ArtifactPreset_All:GetPosX() - Panel_Window_PresetTotal_All:GetSizeX() - 5)
  if self._isConsole == true then
    Panel_Window_PresetTotal_All:SetPosY(Panel_Window_ArtifactPreset_All:GetPosY())
  else
    Panel_Window_PresetTotal_All:SetPosY(Panel_Window_ArtifactPreset_All:GetPosY() + Panel_Window_ArtifactPreset_All:GetSizeY() - Panel_Window_PresetTotal_All:GetSizeY())
  end
end
function HandleEventLUp_ToatalPreset_OpenAutoUsePresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  PaGlobalFunc_AutoUseBuffItem_Open()
  Panel_Window_AutoBuff:SetPosX(Panel_Window_PresetTotal_All:GetPosX() + Panel_Window_PresetTotal_All:GetSizeX() + 5)
  Panel_Window_AutoBuff:SetPosY(Panel_Window_PresetTotal_All:GetPosY())
end
function HandleEventLUp_ToatalPreset_OpenPetPresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  PaGlobal_PetList_Show_All()
  Panel_Window_PresetTotal_All:SetHorizonCenter()
  Panel_Window_PresetTotal_All:SetVerticalMiddle()
  Panel_Window_PresetTotal_All:SetPosX(Panel_Window_PresetTotal_All:GetPosX() - Panel_Window_PresetTotal_All:GetSizeX() / 2 - 3)
  Panel_Window_PetList_All:SetHorizonCenter()
  Panel_Window_PetList_All:SetVerticalMiddle()
  Panel_Window_PetList_All:SetPosX(Panel_Window_PetList_All:GetPosX() + Panel_Window_PetList_All:GetSizeX() / 2 + 3)
end
function HandleEventLUp_ToatalPreset_OpenSkillPresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
  Panel_Window_PresetTotal_All:SetHorizonCenter()
  Panel_Window_PresetTotal_All:SetVerticalMiddle()
  Panel_Window_PresetTotal_All:SetPosX(Panel_Window_PresetTotal_All:GetPosX() - Panel_Window_PresetTotal_All:GetSizeX() / 2 - 10)
end
function HandleEventLUp_ToatalPreset_OpenJewelPresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  PaGlobalFunc_JewelPreset_Open()
end
function HandleEventLUp_ToatalPreset_OpenReforgeStonePresetPanel()
  local self = PaGlobal_TotalPreset
  if self == nil then
    return
  end
  self:closeAllPresetPanels()
  PaGlobal_ReforgeStonePreset_Open()
end
function PaGlobal_TotalPreset_SetClassType(skillType, classType)
  local self = PaGlobal_TotalPreset
  if self == nil or Panel_Window_PresetTotal_All:GetShow() == false then
    return
  end
  self._skillType = skillType
  self._classType = classType
  self:setClassTexture()
end
