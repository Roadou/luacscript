function PaGlobal_TotalPreset:initialize()
  if PaGlobal_TotalPreset._initialize == true then
    return
  end
  local titleBar = UI.getChildControl(Panel_Window_PresetTotal_All, "Static_TitlebarArea")
  self._ui.btn_Close = UI.getChildControl(titleBar, "Button_Close")
  local leftArea = UI.getChildControl(Panel_Window_PresetTotal_All, "Static_LeftArea")
  self._ui.stc_Frame = UI.getChildControl(leftArea, "Frame_LeftMenu")
  self._ui.stc_FrameContent = UI.getChildControl(self._ui.stc_Frame, "Frame_1_Content")
  local comboButton = UI.getChildControl(Panel_Window_PresetTotal_All, "Static_Combo_Buttons")
  self._ui.btn_ComboBox = UI.getChildControl(comboButton, "Combobox_Preset")
  self._ui.btn_ChangeName = UI.getChildControl(comboButton, "Button_Change_Name")
  self._ui.btn_ApplyPreset = UI.getChildControl(comboButton, "Button_Apply")
  self._ui.btn_PresetTemplate = UI.getChildControl(self._ui.stc_FrameContent, "RadioButton_Preset")
  self._ui.stc_Class = UI.getChildControl(leftArea, "Static_Portrait_Mask")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:consoleKeyGuideAlign()
  self:registEventHandler()
  self:validate()
  self:initPresetControl()
  PaGlobal_TotalPreset._initialize = true
  if self._isConsole == true then
    self._ui.btn_Close:SetShow(false)
  end
end
function PaGlobal_TotalPreset:registEventHandler()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_TotalPreset_Close()")
  self._ui.btn_ComboBox:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalPreset_OpenComboBox()")
  self._ui.btn_ComboBox:GetListControl():AddSelectEvent("HandleEventLUp_ToatalPreset_SelectComboBox()")
  self._ui.btn_ChangeName:addInputEvent("Mouse_LUp", "HandleEventLUp_ToatalPreset_ChangeTotalPresetName()")
  self._ui.btn_ApplyPreset:addInputEvent("Mouse_LUp", "HandleEventLUp_ToatalPreset_ApplyTotalPreset()")
  Panel_Window_PresetTotal_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_TotalPreset(true)")
  Panel_Window_PresetTotal_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_TotalPreset(false)")
  registerEvent("FromClient_ToatalPreset_UpdatePresetButton", "FromClient_ToatalPreset_UpdatePresetButton")
  registerEvent("FromClient_TotalPreset_CompleteChangeName", "FromClient_TotalPreset_CompleteChangeName()")
  registerEvent("FromClient_TotalPreset_ShowApplyFailMesaageBox", "FromClient_TotalPreset_ShowApplyFailMesaageBox()")
  registerEvent("FromClient_TotalPreset_UpdatePresetInfo", "PaGlobal_TotalPreset_UpdatePreset()")
  registerEvent("FromClient_TotalPreset_UpdateClassType", "PaGlobal_TotalPreset_UpdateClassType()")
end
function PaGlobal_TotalPreset:validate()
end
function PaGlobal_TotalPreset:prepareOpen()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  Panel_Window_PresetTotal_All:SetHorizonCenter()
  Panel_Window_PresetTotal_All:SetVerticalMiddle()
  self:update()
  self:open()
end
function PaGlobal_TotalPreset:open()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  Panel_Window_PresetTotal_All:SetShow(true)
end
function PaGlobal_TotalPreset:prepareClose()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_TotalPreset:close()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  Panel_Window_PresetTotal_All:SetShow(false)
end
function PaGlobal_TotalPreset:update()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self:updatePresetControls()
  self:updateSelectPreset()
  self:updateTotalPresetComboBox()
  self:updateClassInfo()
  self:setClassTexture()
  self._ui.stc_Frame:GetVScroll():SetControlTop()
  self._ui.stc_Frame:UpdateContentPos()
  Panel_Window_PresetTotal_All:SetHorizonCenter()
  Panel_Window_PresetTotal_All:SetVerticalMiddle()
end
function PaGlobal_TotalPreset:updatePresetControls()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self._frameSizeY = 0
  self:updateSkillPresetControl()
  self:updateAutoUsePresetControl()
  self:updatePetPresetControl()
  self:updateArtifactPresetControl()
  self:updateJewelPresetControl()
  self:updateReforgeStonePresetControl()
  self._frameSizeY = self._frameSizeY + 10
  self._ui.stc_FrameContent:SetSize(self._ui.stc_FrameContent:GetSizeX(), self._frameSizeY)
  self._ui.stc_Frame:UpdateContentPos()
  self._ui.stc_Frame:UpdateContentScroll()
end
function PaGlobal_TotalPreset:updateSelectPreset()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self._selectPresetList = {}
  local maxPreset = ToClient_GetMaxTotalPresetCount()
  for key = 1, maxPreset do
    self._selectPresetList[key] = nil
    if ToClient_IsSetTotalPreset(key) == true then
      self._selectPresetList[key] = {}
      for typeIndex = 0, __eTotalPresetType_Count - 1 do
        local presetNo = ToClient_GetTotalPresetNo(key, typeIndex)
        self._selectPresetList[key][typeIndex] = presetNo
      end
    end
  end
  self:setCheckPresetButton(self._currentPresetKey)
end
function PaGlobal_TotalPreset:updateTotalPresetComboBox()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self:updateTotalPresetComboBoxItems()
  self._ui.btn_ComboBox:SetSelectItemIndex(self._currentPresetKey - 1)
  self:updateTotalPresetComboBoxIndex()
end
function PaGlobal_TotalPreset:updateTotalPresetComboBoxItems()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self._ui.btn_ComboBox:DeleteAllItem()
  local currentPresetCount = ToClient_GetCurrentTotalPresetCount()
  for presetKey = 1, currentPresetCount do
    local presetName = ToClient_GetTotalPresetName(presetKey)
    if presetName == "" then
      presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_TABBUTTON", "number", tostring(presetKey))
    end
    self._ui.btn_ComboBox:AddItem(presetName)
  end
end
function PaGlobal_TotalPreset:updateTotalPresetComboBoxIndex()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self._currentPresetKey = self._ui.btn_ComboBox:GetSelectIndex() + 1
  local presetName = ToClient_GetTotalPresetName(self._currentPresetKey)
  if presetName == "" then
    presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_TABBUTTON", "number", tostring(self._currentPresetKey))
  end
  self._ui.btn_ComboBox:SetText(presetName)
  self:setCheckPresetButton(self._currentPresetKey)
end
function PaGlobal_TotalPreset:selectPresetButton(presetType, buttonIndex)
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  ToClient_RequestChangeTotalPresetNo(self._currentPresetKey, presetType, self:convertPresetIndexToPresetNo(presetType, buttonIndex))
  self:setCheckPresetButton(self._currentPresetKey)
end
function PaGlobal_TotalPreset:consoleKeyGuideAlign()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local consoleButtons = UI.getChildControl(Panel_Window_PresetTotal_All, "Static_BottomConsoleButtons")
  local buttonA = UI.getChildControl(consoleButtons, "Button_A_ConsoleUI")
  local buttonB = UI.getChildControl(consoleButtons, "Button_B_ConsoleUI")
  local buttonRS = UI.getChildControl(consoleButtons, "Button_RS_ConsoleUI")
  if self._isConsole == true then
    local tempBtnGroup = {
      buttonRS,
      buttonA,
      buttonB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, consoleButtons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_TotalPreset:initPresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  self:createPresetControl(__eTotalPresetType_AutoUse, "AutoUse", "PANEL_PRESETTOTAL_AUTOBUFFTITLE", ToClient_getAutoUseItemPresetMaxSize(), "HandleEventLUp_ToatalPreset_OpenAutoUsePresetPanel()", "Combine_Etc_Preset_Cook_Icon")
  self:createPresetControl(__eTotalPresetType_Skill, "Skill", "PANEL_PRESETTOTAL_SKILLPRESETTITLE", ToClient_getSkillPresetSlotMaxCount(), "HandleEventLUp_ToatalPreset_OpenSkillPresetPanel()", "Combine_Etc_Preset_Skill_Icon")
  self:createPresetControl(__eTotalPresetType_Pet, "Pet", "PANEL_PRESETTOTAL_PETGROUPTITLE", ToClient_GetMaxPetPresetCount(), "HandleEventLUp_ToatalPreset_OpenPetPresetPanel()", "Combine_Etc_Preset_Pet_Icon")
  self:createPresetControl(__eTotalPresetType_Artifact, "Artifact", "PANEL_PRESETTOTAL_ARTIFACTPRESETTITLE", ToClient_getArtifactBagPresetPossibleMaxCount(), "HandleEventLUp_ToatalPreset_OpenArtifactPresetPanel()", "Combine_Etc_Preset_Relic_Icon")
  self:createPresetControl(__eTotalPresetType_Jewel, "Jewel", "PANEL_PRESETTOTAL_CRYSTALPRESETTITLE", ToClient_GetJewelPresetMaxCount(), "HandleEventLUp_ToatalPreset_OpenJewelPresetPanel()", "Combine_Etc_Preset_CrystalManage_Icon")
  if _ContentsGroup_ReforgeStonePreset == true then
    self:createPresetControl(__eTotalPresetType_Reforge, "Reforge", "PANEL_WINDOW_REFORGESTONE_PRESETTITLE", ToClient_GetMaxReforgeStonePresetCount(), "HandleEventLUp_ToatalPreset_OpenReforgeStonePresetPanel()", "Combine_Etc_Preset_ReforgeStone_Icon")
  end
end
function PaGlobal_TotalPreset:createPresetControl(presetType, presetName, presetTitleString, maxSlotCount, openButtonEvent, iconTextureID)
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local controlList = {
    _title = nil,
    _openButton = nil,
    _buttonList = {}
  }
  local titleTemplate = UI.getChildControl(self._ui.stc_FrameContent, "StaticText_PresetTitle")
  controlList._title = UI.cloneControl(titleTemplate, self._ui.stc_FrameContent, "StaticText_PresetTitle_" .. presetName)
  controlList._title:SetShow(false)
  controlList._title:SetText(PAGetString(Defines.StringSheet_RESOURCE, presetTitleString))
  controlList._title:ChangeTextureInfoTextureIDAsync(iconTextureID)
  controlList._title:setRenderTexture(controlList._title:getBaseTexture())
  local openButtonTemplate = UI.getChildControl(self._ui.stc_FrameContent, "Button_OpenPreset")
  controlList._openButton = UI.cloneControl(openButtonTemplate, self._ui.stc_FrameContent, "Button_OpenPreset_" .. presetName)
  controlList._openButton:SetShow(false)
  controlList._openButton:addInputEvent("Mouse_LUp", openButtonEvent)
  for index = 0, maxSlotCount - 1 do
    local buttonTemplate = UI.getChildControl(self._ui.stc_FrameContent, "RadioButton_Preset")
    local button = UI.cloneControl(buttonTemplate, self._ui.stc_FrameContent, "RadioButton_Preset" .. presetName .. "_" .. tostring(index))
    local presetNoControl = UI.getChildControl(button, "StaticText_PresetNo")
    presetNoControl:SetText(tostring(index + 1))
    button:SetShow(false)
    button:addInputEvent("Mouse_LUp", "HandleEventLUp_ToatalPreset_SelectPresetButton(" .. tostring(presetType) .. "," .. tostring(index) .. ")")
    controlList._buttonList[index] = button
  end
  self._ui.presetControl[presetType] = controlList
end
function PaGlobal_TotalPreset:setPresetButtonSpanSize(index, button)
  local indexX = index % 3
  local indexY = math.floor(index / 3)
  local templateSizeX = button:GetSizeX()
  local templateSizeY = button:GetSizeY()
  local gapX = 2
  local gapY = 2
  local spanX = self._ui.btn_PresetTemplate:GetSpanSize().x + (templateSizeX + gapX) * indexX
  local spanY = self._frameSizeY + self._ui.btn_PresetTemplate:GetSpanSize().y + (templateSizeY + gapY) * indexY
  button:SetSpanSize(spanX, spanY)
end
function PaGlobal_TotalPreset:updateSkillPresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_Skill]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_Skill]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_Skill]._buttonList
  local maxSlotCount = ToClient_getSkillPresetSlotMaxCount()
  local currentCount = ToClient_getSkillPresetSlotCount()
  if currentCount == 0 then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if currentCount > index then
      local presetName = ToClient_getSkillPresetMemo(index)
      if presetName == nil or presetName == "" then
        presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_SKILLPRESETNAME", "number", tostring(index + 1))
      end
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  self._frameSizeY = buttonList[currentCount - 1]:GetSpanSize().y + buttonList[currentCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:updateAutoUsePresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_AutoUse]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_AutoUse]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_AutoUse]._buttonList
  local isLearnedSkill = ToClient_isLearnedFairySkill()
  local maxSlotCount = ToClient_getAutoUseItemPresetMaxSize()
  if isLearnedSkill == false then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if isLearnedSkill == true then
      presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_AUTOBUFFNAME", "number", tostring(index + 1))
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  self._frameSizeY = buttonList[maxSlotCount - 1]:GetSpanSize().y + buttonList[maxSlotCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:updatePetPresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_Pet]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_Pet]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_Pet]._buttonList
  local maxSlotCount = ToClient_GetMaxPetPresetCount()
  local currentCount = ToClient_GetPetPresetCount()
  if currentCount == 0 then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if currentCount > index then
      local presetName = ToClient_GetPetPresetName(index + 1)
      if presetName == nil or presetName == "" then
        presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_PETGROUPNAME", "number", tostring(index + 1))
      end
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  self._frameSizeY = buttonList[currentCount - 1]:GetSpanSize().y + buttonList[currentCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:updateArtifactPresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_Artifact]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_Artifact]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_Artifact]._buttonList
  local maxSlotCount = ToClient_getArtifactBagPresetPossibleMaxCount()
  local currentCount = ToClient_getMyArtifactBagPresetMaxCount()
  if currentCount == 0 then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local copyDataForLua = false
  if Panel_Window_ArtifactPreset_All:GetShow() == false then
    copyDataForLua = true
  end
  if copyDataForLua == true then
    ToClient_copyArtifactBagPresetDataListForLua()
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if currentCount > index then
      local presetName = tempWrapper:getArtifactPresetName(index + 1)
      if presetName == nil or presetName == "" then
        presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_ARTIFACTPRESETNAME", "number", tostring(index + 1))
      end
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  if copyDataForLua == true then
    ToClient_clearArtifactBagPresetDataForLua()
  end
  self._frameSizeY = buttonList[currentCount - 1]:GetSpanSize().y + buttonList[currentCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:updateJewelPresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_Jewel]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_Jewel]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_Jewel]._buttonList
  local maxSlotCount = ToClient_GetJewelPresetMaxCount()
  local currentCount = ToClient_GetJewelPresetCount()
  if currentCount == 0 then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if currentCount > index then
      local presetName = ToClient_GetJewelPresetName(index)
      if presetName == nil or presetName == "" then
        presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_CRYSTALPRESETNAME", "number", tostring(index + 1))
      end
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  self._frameSizeY = buttonList[currentCount - 1]:GetSpanSize().y + buttonList[currentCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:updateReforgeStonePresetControl()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local title = self._ui.presetControl[__eTotalPresetType_Reforge]._title
  local openButton = self._ui.presetControl[__eTotalPresetType_Reforge]._openButton
  local buttonList = self._ui.presetControl[__eTotalPresetType_Reforge]._buttonList
  local maxSlotCount = ToClient_GetMaxReforgeStonePresetCount()
  local currentCount = ToClient_GetCurrentReforgeStonePresetCount()
  if currentCount == 0 then
    title:SetShow(false)
    openButton:SetShow(false)
    return
  end
  self._frameSizeY = self._frameSizeY + 20
  title:SetShow(true)
  title:SetSpanSize(title:GetSpanSize().x, self._frameSizeY)
  openButton:SetShow(true)
  openButton:SetSpanSize(openButton:GetSpanSize().x, self._frameSizeY)
  for index = 0, maxSlotCount - 1 do
    local button = buttonList[index]
    local nameControl = UI.getChildControl(button, "StaticText_PresetName")
    if currentCount > index then
      local presetName = ToClient_GetReforgeStonePresetName(index)
      if presetName == nil or presetName == "" then
        presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_PRESETNAME", "number", tostring(index + 1))
      end
      self:setPresetButtonSpanSize(index, button)
      button:SetShow(true)
      nameControl:SetText(presetName)
      UI.setLimitTextToReferenceAndAddTooltip(button, "", presetName, nameControl)
    else
      button:SetShow(false)
    end
  end
  self._frameSizeY = buttonList[currentCount - 1]:GetSpanSize().y + buttonList[currentCount - 1]:GetSizeY()
end
function PaGlobal_TotalPreset:convertPresetNoToIndex(presetType, presetNo)
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  if presetType == __eTotalPresetType_Pet or presetType == __eTotalPresetType_Artifact then
    return presetNo - 1
  end
  return presetNo
end
function PaGlobal_TotalPreset:convertPresetIndexToPresetNo(presetType, index)
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  if presetType == __eTotalPresetType_Pet or presetType == __eTotalPresetType_Artifact then
    return index + 1
  end
  return index
end
function PaGlobal_TotalPreset:setCheckPresetButton(presetKey)
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  for typeIndex = 0, __eTotalPresetType_Count - 1 do
    if self._ui.presetControl[typeIndex] ~= nil then
      local buttonList = self._ui.presetControl[typeIndex]._buttonList
      for index, button in pairs(buttonList) do
        button:SetCheck(false)
      end
      if self._selectPresetList[presetKey] ~= nil then
        local presetNo = self._selectPresetList[presetKey][typeIndex]
        if presetNo ~= nil and presetNo ~= nil and presetNo ~= self._undefinedPresetNo then
          presetNo = self:convertPresetNoToIndex(typeIndex, presetNo)
          buttonList[presetNo]:SetCheck(true)
        end
      end
    end
  end
end
function PaGlobal_TotalPreset:updateClassInfo()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self._classType = selfPlayerWrapper:getClassType()
  local isReverseSkillType = PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(self._classType)
  local cacheValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree)
  local playerType = ToClient_GetCurrentPlayerSkillType()
  if cacheValue == 0 then
    self._skillType = playerType
  elseif playerType == 0 and (isReverseSkillType == false and cacheValue == 2 or isReverseSkillType == true and cacheValue == 3) then
    self._skillType = cacheValue - 1
  else
    self._skillType = playerType
  end
end
function PaGlobal_TotalPreset:setClassTexture()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  if self._skillType == nil or self._classType == nil then
    return
  end
  PaGlobalFunc_Util_SetTotalPresetClassTexture(self._ui.stc_Class, self._classType, self._skillType == __eSkillTypeParam_Awaken)
end
function PaGlobal_TotalPreset:closeAllPresetPanels()
  if Panel_Window_PresetTotal_All == nil then
    return
  end
  if Panel_Window_AutoBuff:GetShow() == true then
    PaGlobalFunc_AutoUseBuffItem_Close()
  end
  PanelCloseFunc_Skill()
  if Panel_Window_PetList_All:GetShow() == true then
    PaGlobal_PetList_Close_All()
  end
  if Panel_Window_LightStoneBag:GetShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  PanelCloseFunc_Inventory()
  if Panel_Window_JewelPreset_All:GetShow() == true then
    PaGlobalFunc_JewelPreset_Close()
  end
end
