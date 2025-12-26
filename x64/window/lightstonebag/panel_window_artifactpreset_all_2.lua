function PaGlobalFunc_ArtifactPreset_All_Open()
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ArtifactPreset_All_Close(closeType)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  self._currentCloseType = closeType
  return self:prepareClose()
end
function PaGlobalFunc_ArtifactPreset_All_ToggleEditMode(isOpen)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true and (isOpen == nil or isOpen == false) then
    self._ui._btn_editPreset:SetCheck(not self._ui._btn_editPreset:IsCheck())
  end
  local prevEditMode = self._isEditMode
  self._isEditMode = self._ui._btn_editPreset:IsCheck()
  if prevEditMode == true and self._isEditMode == false then
    PaGlobalFunc_ArtifactPreset_All_SetPresetName(self._currentSelectedPresetIndex_s64)
    ToClient_saveArtifactBagPresetDataListForLua()
    PaGlobal_TotalPreset_UpdatePreset()
  end
  local textControl = self._ui._txt_editPreset
  if self._isPadSnapping == true then
    textControl = UI.getChildControl(self._ui._txt_editPreset, "StaticText_Y")
  end
  if self._isEditMode == true then
    textControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_PRESET_SAVE"))
  else
    textControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN"))
  end
  local centerPosX = 0
  if self._isPadSnapping == true then
    local stc_innerKeyGuide_Plus = UI.getChildControl(self._ui._txt_editPreset, "Static_Plus_ConsoleUI")
    local buttonSize = self._ui._txt_editPreset:GetSizeX() + stc_innerKeyGuide_Plus:GetSizeX() + textControl:GetSizeX() + textControl:GetTextSizeX() + 28
    self._ui._btn_editPreset:SetSize(buttonSize, self._ui._btn_editPreset:GetSizeY())
  else
    self._ui._btn_editPreset:SetSize(textControl:GetSizeX() + textControl:GetTextSizeX() + 50, self._ui._btn_editPreset:GetSizeY())
  end
  self:reloadArtifactPresetList()
  if PaGlobal_LightStoneBag ~= nil then
    PaGlobal_LightStoneBag:simpleReloadList_artifactBagList()
  end
  if self._isPadSnapping == true and self._isEditMode ~= prevEditMode then
    if self._isEditMode == true then
      PaGlobal_ArtifactPreset_All:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnEditMode)
    else
      PaGlobal_ArtifactPreset_All:changePadSnapState(self._beforePadSnapState, true)
    end
  end
  ClearFocusEdit()
end
function PaGlobalFunc_ArtifactPreset_All_UpdateArtifactPresetList(content, s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local presetNo = Int64toInt32(s64_key)
  local isSameBoth = tempWrapper:isSameArtifactPresetSlotBoth(presetNo)
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local btn_showEffect = UI.getChildControl(btn_preset, "Button_ShowEffect")
  local btn_equip = UI.getChildControl(btn_preset, "Button_Equip")
  local txt_presetNameEditBox = UI.getChildControl(btn_preset, "Edit_ItemName")
  local keyGuideX = UI.getChildControl(txt_presetNameEditBox, "Static_X_ConsoleUI")
  local stc_presetNumber = UI.getChildControl(btn_preset, "StaticText_NoTag")
  local stc_leftRedEffect = UI.getChildControl(btn_preset, "Static_Slot_Red_L")
  local stc_rightRedEffect = UI.getChildControl(btn_preset, "Static_Slot_Red_R")
  local stc_leftArtifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_L")
  local stc_leftArtifactIcon = UI.getChildControl(stc_leftArtifactSlotBg, "Static_ItemIcon")
  local stc_leftPushedItemSlotBg_0 = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_0")
  local stc_leftPushedItemIcon_0 = UI.getChildControl(stc_leftPushedItemSlotBg_0, "Static_Icon")
  local stc_leftPushedItemSlotBg_1 = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_1")
  local stc_leftPushedItemIcon_1 = UI.getChildControl(stc_leftPushedItemSlotBg_1, "Static_Icon")
  local stc_rightArtifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_R")
  local stc_rightArtifactIcon = UI.getChildControl(stc_rightArtifactSlotBg, "Static_ItemIcon")
  local stc_rightPushedItemSlotBg_0 = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_0")
  local stc_rightPushedItemIcon_0 = UI.getChildControl(stc_rightPushedItemSlotBg_0, "Static_Icon")
  local stc_rightPushedItemSlotBg_1 = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_1")
  local stc_rightPushedItemIcon_1 = UI.getChildControl(stc_rightPushedItemSlotBg_1, "Static_Icon")
  if self._isPadSnapping == true and self._isEditMode == true and self._lastPadSnappedPresetIndex_s64 == s64_key then
    btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ArtifactPreset_All_SetFocusEdit(" .. tostring(s64_key) .. ")")
    keyGuideX:SetShow(true)
  else
    btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    keyGuideX:SetShow(false)
  end
  btn_preset:SetChildIndex(stc_leftRedEffect, 9999)
  btn_preset:SetChildIndex(stc_rightRedEffect, 9999)
  if self._currentSelectedPresetIndex_s64 == nil then
    btn_preset:SetCheck(false)
  elseif Int64toInt32(self._currentSelectedPresetIndex_s64) == Int64toInt32(s64_key) then
    btn_preset:SetCheck(true)
  else
    btn_preset:SetCheck(false)
  end
  btn_preset:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetButton(" .. tostring(s64_key) .. ")")
  if self._isPadSnapping == true then
    btn_preset:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_OnPadSnap(true," .. tostring(s64_key) .. ")")
    btn_preset:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_OnPadSnap(false," .. tostring(s64_key) .. ")")
    if self._isEditMode == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_ArtifactPreset_All_OnClickedClearPreset(" .. tostring(s64_key) .. ")")
    else
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    end
  end
  if PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    if self._isPadSnapping == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_ArtifactTooltip_ToggleArtifactPresetInfo(" .. tostring(presetNo) .. ")")
    else
      btn_showEffect:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(true," .. tostring(presetNo) .. ")")
      btn_showEffect:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false," .. tostring(presetNo) .. ")")
    end
  end
  txt_presetNameEditBox:SetMaxInput(12)
  txt_presetNameEditBox:SetEditText(tempWrapper:getArtifactPresetName(presetNo))
  txt_presetNameEditBox:RegistReturnKeyEvent("PaGlobalFunc_ArtifactPreset_All_SetPresetName(" .. tostring(s64_key) .. ")")
  btn_equip:SetTextMode(__eTextMode_LimitText)
  if self._isEditMode == true then
    btn_equip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_PRESET_CLEAR"))
    btn_equip:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedClearPreset(" .. tostring(s64_key) .. ")")
    txt_presetNameEditBox:SetIgnore(false)
  else
    btn_equip:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN_USE"))
    btn_equip:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedEquipButton(" .. tostring(s64_key) .. ")")
    txt_presetNameEditBox:SetIgnore(true)
  end
  stc_presetNumber:SetText(tostring(presetNo))
  local leftArtifactItemSSW = tempWrapper:getArtifactPresetLeftArtifactItemStaticStatusWrapper(presetNo)
  local leftArtifactFirstPushedItemSSW = tempWrapper:getArtifactPresetLeftFirstPushedItemItemStaticStatusWrapper(presetNo)
  local leftArtifactSecondPushedItemSSW = tempWrapper:getArtifactPresetLeftSecondPushedItemItemStaticStatusWrapper(presetNo)
  local isExistLeftArtifact = false
  if leftArtifactItemSSW ~= nil then
    local leftPushedItemKey_0 = ItemEnchantKey(0, 0)
    if leftArtifactFirstPushedItemSSW ~= nil then
      leftPushedItemKey_0 = leftArtifactFirstPushedItemSSW:get()._key
    end
    local leftPushedItemKey_1 = ItemEnchantKey(0, 0)
    if leftArtifactSecondPushedItemSSW ~= nil then
      leftPushedItemKey_1 = leftArtifactSecondPushedItemSSW:get()._key
    end
    local currentLeftArtifactCount = tempWrapper:getArtifactItemCountFromArtifactBag(leftArtifactItemSSW:get()._key, leftPushedItemKey_0, leftPushedItemKey_1)
    if isSameBoth == true then
      if currentLeftArtifactCount > 0 then
        isExistLeftArtifact = true
      end
    elseif currentLeftArtifactCount > 0 then
      isExistLeftArtifact = true
    end
    stc_leftRedEffect:SetShow(not isExistLeftArtifact)
  else
    stc_leftRedEffect:SetShow(false)
  end
  local artifactPreset_leftArtifactSlot = {}
  SlotItem.reInclude(artifactPreset_leftArtifactSlot, "ArtifactPreset_Left_Slot_", 0, stc_leftArtifactIcon, self._slotConfig)
  if leftArtifactItemSSW ~= nil then
    artifactPreset_leftArtifactSlot:setItemByStaticStatus(leftArtifactItemSSW, 1)
    if ToClient_isConsole() == false then
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(true, true," .. tostring(s64_key) .. ")")
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(false, true," .. tostring(s64_key) .. ")")
    end
    if self._isEditMode == true then
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_All_ClearPresetSlotOnce(true," .. tostring(s64_key) .. ")")
    else
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    end
  else
    artifactPreset_leftArtifactSlot:clearItem()
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_leftSubSlot_0 = {}
  SlotItem.reInclude(artifactPreset_leftSubSlot_0, "ArtifactPreset_Left_SubSlot_0_", 0, stc_leftPushedItemIcon_0, self._subSlotConfig)
  if leftArtifactFirstPushedItemSSW ~= nil then
    artifactPreset_leftSubSlot_0:setItemByStaticStatus(leftArtifactFirstPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(true, true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(false, true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    end
  else
    artifactPreset_leftSubSlot_0:clearItem()
    artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_leftSubSlot_1 = {}
  SlotItem.reInclude(artifactPreset_leftSubSlot_1, "ArtifactPreset_Left_SubSlot_1_", 0, stc_leftPushedItemIcon_1, self._subSlotConfig)
  if leftArtifactSecondPushedItemSSW ~= nil then
    artifactPreset_leftSubSlot_1:setItemByStaticStatus(leftArtifactSecondPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(true, true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(false, true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    end
  else
    artifactPreset_leftSubSlot_1:clearItem()
    artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_Out", "")
  end
  local rightArtifactItemSSW = tempWrapper:getArtifactPresetRightArtifactItemStaticStatusWrapper(presetNo)
  local rightArtifactFirstPushedItemSSW = tempWrapper:getArtifactPresetRightFirstPushedItemStaticStatusWrapper(presetNo)
  local rightArtifactSecondPushedItemSSW = tempWrapper:getArtifactPresetRightSecondPushedItemStaticStatusWrapper(presetNo)
  local isExistRightArtifact = false
  if rightArtifactItemSSW ~= nil then
    local rightPushedItemKey_0 = ItemEnchantKey(0, 0)
    if rightArtifactFirstPushedItemSSW ~= nil then
      rightPushedItemKey_0 = rightArtifactFirstPushedItemSSW:get()._key
    end
    local rightPushedItemKey_1 = ItemEnchantKey(0, 0)
    if rightArtifactSecondPushedItemSSW ~= nil then
      rightPushedItemKey_1 = rightArtifactSecondPushedItemSSW:get()._key
    end
    local currentRightArtifactCount = tempWrapper:getArtifactItemCountFromArtifactBag(rightArtifactItemSSW:get()._key, rightPushedItemKey_0, rightPushedItemKey_1)
    if isSameBoth == true then
      if currentRightArtifactCount > 1 then
        isExistRightArtifact = true
      end
    elseif currentRightArtifactCount > 0 then
      isExistRightArtifact = true
    end
    stc_rightRedEffect:SetShow(not isExistRightArtifact)
  else
    stc_rightRedEffect:SetShow(false)
  end
  local artifactPreset_rightArtifactSlot = {}
  SlotItem.reInclude(artifactPreset_rightArtifactSlot, "ArtifactPreset_Right_Slot_", 0, stc_rightArtifactIcon, self._slotConfig)
  if rightArtifactItemSSW ~= nil then
    artifactPreset_rightArtifactSlot:setItemByStaticStatus(rightArtifactItemSSW, 1)
    if ToClient_isConsole() == false then
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(true, false," .. tostring(s64_key) .. ")")
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(false, false," .. tostring(s64_key) .. ")")
    end
    if self._isEditMode == true then
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_All_ClearPresetSlotOnce(false," .. tostring(s64_key) .. ")")
    else
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    end
  else
    artifactPreset_rightArtifactSlot:clearItem()
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_rightSubSlot_0 = {}
  SlotItem.reInclude(artifactPreset_rightSubSlot_0, "ArtifactPreset_Right_SubSlot_0_", 0, stc_rightPushedItemIcon_0, self._subSlotConfig)
  if rightArtifactFirstPushedItemSSW ~= nil then
    artifactPreset_rightSubSlot_0:setItemByStaticStatus(rightArtifactFirstPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(true, false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(false, false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    end
  else
    artifactPreset_rightSubSlot_0:clearItem()
    artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_rightSubSlot_1 = {}
  SlotItem.reInclude(artifactPreset_rightSubSlot_1, "ArtifactPreset_Right_SubSlot_1_", 0, stc_rightPushedItemIcon_1, self._subSlotConfig)
  if rightArtifactSecondPushedItemSSW ~= nil then
    artifactPreset_rightSubSlot_1:setItemByStaticStatus(rightArtifactSecondPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(true, false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(false, false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    end
  else
    artifactPreset_rightSubSlot_1:clearItem()
    artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_Out", "")
  end
  txt_presetNameEditBox:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  btn_showEffect:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
end
function PaGlobalFunc_ArtifactPreset_All_SetPresetName(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local txt_presetNameEditBox = UI.getChildControl(btn_preset, "Edit_ItemName")
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:setArtifactPresetName(presetNo, txt_presetNameEditBox:GetEditText())
  ClearFocusEdit()
end
function PaGlobalFunc_ArtifactPreset_All_SetFocusEdit(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local editName = UI.getChildControl(btn_preset, "Edit_ItemName")
  SetFocusEdit(editName)
end
function PaGlobalFunc_ArtifactPreset_All_OnClickedPresetButton(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(s64_key)
  if self._isPadSnapping == true and self._isEditMode == false then
    PaGlobalFunc_ArtifactPreset_All_OnClickedEquipButton(s64_key)
  end
end
function PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  if self._currentSelectedPresetIndex_s64 ~= nil and self._currentSelectedPresetIndex_s64 ~= s64_key then
    PaGlobalFunc_ArtifactPreset_All_SetPresetName(self._currentSelectedPresetIndex_s64)
  end
  self._currentSelectedPresetIndex_s64 = s64_key
end
function PaGlobalFunc_ArtifactPreset_All_OnClickedEquipButton(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(s64_key)
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PRESET_NOT_CHANGE"))
    return
  end
  local presetNo = Int64toInt32(s64_key)
  ToClient_requestEquipArtifactPreset(presetNo)
end
function PaGlobalFunc_ArtifactPreset_All_OnClickedClearPreset(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_All_OnClickedPresetControl(s64_key)
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:clearArtifactSlotAll(presetNo)
  self:updatePresetCount()
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content ~= nil then
    PaGlobalFunc_ArtifactPreset_All_UpdateArtifactPresetList(content, s64_key)
  end
end
function PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(isShow, isLeftArtifact, s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local stc_artifactSlotBg
  if isLeftArtifact == true then
    stc_artifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_L")
  else
    stc_artifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_R")
  end
  local stc_artifactSlotIcon = UI.getChildControl(stc_artifactSlotBg, "Static_ItemIcon")
  local presetNo = Int64toInt32(s64_key)
  local itemSSW
  if isLeftArtifact == true then
    itemSSW = tempWrapper:getArtifactPresetLeftArtifactItemStaticStatusWrapper(presetNo)
  else
    itemSSW = tempWrapper:getArtifactPresetRightArtifactItemStaticStatusWrapper(presetNo)
  end
  if itemSSW == nil then
    return
  end
  self._currentMouseOnArtifactPresetInfo.presetNo = presetNo
  self._currentMouseOnArtifactPresetInfo.isLeft = isLeftArtifact
  if ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "ArtifactPreset")
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_ArtifactPreset_All, true, false, nil, nil, nil, nil, nil, nil, "ArtifactPreset")
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactPreset_All_ClearPresetSlotOnce(isLeftArtifact, s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or s64_key == nil or isLeftArtifact == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  if self._currentSelectedPresetIndex_s64 ~= nil then
    PaGlobalFunc_ArtifactPreset_All_SetPresetName(self._currentSelectedPresetIndex_s64)
  end
  PaGlobalFunc_ArtifactPreset_All_ShowItemTooltip(false, isLeftArtifact, s64_key)
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:clearArtifactSlotOnce(isLeftArtifact, presetNo)
  self:updatePresetCount()
end
function PaGlobalFunc_ArtifactPreset_All_ShowSubItemTooltip(isShow, isLeftArtifact, s64_key, subIndex)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or isShow == nil or isLeftArtifact == nil or s64_key == nil or subIndex == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local subItemSlotBG, subItemSlot
  if subIndex == 0 then
    if isLeftArtifact == true then
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_0")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    else
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_0")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    end
  elseif subIndex == 1 then
    if isLeftArtifact == true then
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_1")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    else
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_1")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    end
  end
  local presetNo = Int64toInt32(s64_key)
  local itemSSW
  if subIndex == 0 then
    if isLeftArtifact == true then
      itemSSW = tempWrapper:getArtifactPresetLeftFirstPushedItemItemStaticStatusWrapper(presetNo)
    else
      itemSSW = tempWrapper:getArtifactPresetRightFirstPushedItemStaticStatusWrapper(presetNo)
    end
  elseif subIndex == 1 then
    if isLeftArtifact == true then
      itemSSW = tempWrapper:getArtifactPresetLeftSecondPushedItemItemStaticStatusWrapper(presetNo)
    else
      itemSSW = tempWrapper:getArtifactPresetRightSecondPushedItemStaticStatusWrapper(presetNo)
    end
  end
  if itemSSW == nil then
    return
  end
  if ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_ArtifactPreset_All, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function FromClient_ArtifactPreset_All_UpdateArtifactPresetData(isFullReload)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  if isFullReload == nil then
    return
  end
  if isFullReload == true then
    self:loadArtifactPresetList(true)
  else
    self:reloadArtifactPresetList()
  end
end
function PaGlobalFunc_ArtifactPreset_All_OnPadSnap(isOn, s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or isOn == nil or s64_key == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  local content = self._ui._list2_artifactPreset:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  if self._isPadSnapping == true then
    local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
    local editName = UI.getChildControl(btn_preset, "Edit_ItemName")
    local keyGuideX = UI.getChildControl(editName, "Static_X_ConsoleUI")
    if isOn == true and self._isEditMode == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ArtifactPreset_All_SetFocusEdit(" .. tostring(s64_key) .. ")")
      keyGuideX:SetShow(true)
    else
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      keyGuideX:SetShow(false)
    end
  end
  if isOn == true then
    PaGlobal_ArtifactPreset_All:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnPreset)
    self._lastPadSnappedPresetIndex_s64 = toInt64(0, s64_key)
  elseif PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    local presetNo = Int64toInt32(s64_key)
    PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false, presetNo)
  end
end
function PaGlobalFunc_ArtifactPreset_All_CurrentMouseOverPresetNo()
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  return self._currentMouseOnArtifactPresetInfo
end
function PaGlobalFunc_ArtifactPreset_All_AddArtifactPresetItem(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true and isPadPressed(__eJoyPadInputType_RightTrigger) == true then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  if self._currentSelectedPresetIndex_s64 == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedSelectArtifactPresetControl"))
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    return
  end
  local pushedItemKey_0 = ItemEnchantKey(0, 0)
  local pushedItemSSW_0 = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  if pushedItemSSW_0 ~= nil then
    pushedItemKey_0 = pushedItemSSW_0:get()._key
  end
  local pushedItemKey_1 = ItemEnchantKey(0, 0)
  local pushedItemSSW_1 = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  if pushedItemSSW_1 ~= nil then
    pushedItemKey_1 = pushedItemSSW_1:get()._key
  end
  if self._currentSelectedPresetIndex_s64 ~= nil then
    PaGlobalFunc_ArtifactPreset_All_SetPresetName(self._currentSelectedPresetIndex_s64)
  end
  local presetNo = Int64toInt32(self._currentSelectedPresetIndex_s64)
  tempWrapper:pushArtifactPresetData(presetNo, artifactItemSSW:get()._key, pushedItemKey_0, pushedItemKey_1)
  self:updatePresetCount()
end
function PaGlobalFunc_ArtifactPreset_All_RequestPopArtifactItem(s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true and isPadPressed(__eJoyPadInputType_RightTrigger) == true then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local inputMaxCount = ToClient_GetArtifactBagItemCount64(bagIndex)
  local popableMaxCount = ToClient_getPopableMaxCountFromLightStoneBag()
  if popableMaxCount < Int64toInt32(inputMaxCount) then
    inputMaxCount = toInt64(0, popableMaxCount)
  end
  Panel_NumberPad_Show(true, inputMaxCount, s64_key, PaGlobalFunc_ArtifactPreset_All_ReqeustPopItem)
end
function PaGlobalFunc_ArtifactPreset_All_ReqeustPopItem(popCount, s64_key)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    return
  end
  local pushedLightStoneItemSSW_0 = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local pushedLightStoneItemKey_0 = ItemEnchantKey(0, 0)
  if pushedLightStoneItemSSW_0 ~= nil then
    pushedLightStoneItemKey_0 = pushedLightStoneItemSSW_0:get()._key
  end
  local pushedLightStoneItemSSW_1 = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local pushedLightStoneItemKey_1 = ItemEnchantKey(0, 0)
  if pushedLightStoneItemSSW_1 ~= nil then
    pushedLightStoneItemKey_1 = pushedLightStoneItemSSW_1:get()._key
  end
  ToClient_requestPopItemFromArtifactBag(CppEnums.ItemWhereType.eInventory, artifactItemSSW:get()._key, pushedLightStoneItemKey_0, pushedLightStoneItemKey_1, popCount)
end
function FromClient_ArtifactPreset_All_UpdateCurrentPresetName(presetNo)
  local self = PaGlobal_ArtifactPreset_All
  if self == nil or presetNo == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._list2_artifactPreset:GetContentByKey(toInt64(0, presetNo))
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local txt_presetNameEditBox = UI.getChildControl(btn_preset, "Edit_ItemName")
  txt_presetNameEditBox:SetEditText(tempWrapper:getArtifactPresetName(presetNo))
  ClearFocusEdit()
end
