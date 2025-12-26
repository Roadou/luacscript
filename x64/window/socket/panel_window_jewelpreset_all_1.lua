function PaGlobal_JewelPreset:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_JewelPreset == false then
    return
  end
  self._ui.stc_TitleBarArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_TitlebarArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBarArea, "Button_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_TitleBarArea, "Button_Question")
  self._ui.stc_RadioButtonArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_RadioButtonArea")
  self._ui.btn_Console_LB = UI.getChildControl(self._ui.stc_RadioButtonArea, "Button_LB_ConsoleUI")
  self._ui.btn_Console_RB = UI.getChildControl(self._ui.stc_RadioButtonArea, "Button_RB_ConsoleUI")
  self._ui.stc_PresetArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_PresetNameArea")
  self._ui.btn_Edit = UI.getChildControl(self._ui.stc_PresetArea, "Button_Edit")
  self._ui.stc_Console_PresetGuide = UI.getChildControl(self._ui.stc_PresetArea, "Static_Guide_ConsoleUI")
  self._ui.txt_PresetName = UI.getChildControl(self._ui.stc_PresetArea, "StaticText_PresetName")
  self._ui.txt_AdjustName = UI.getChildControl(self._ui.stc_PresetArea, "StaticText_Adjust")
  self._ui.edit_PresetName = UI.getChildControl(self._ui.stc_PresetArea, "Edit_PresetName")
  self._ui.edit_PresetName:SetMaxInput(ToClient_GetJewelPresetNameMaxLength())
  self._ui.txt_LClick = UI.getChildControl(self._ui.stc_PresetArea, "StaticText_LClick")
  self._ui.txt_RClick = UI.getChildControl(self._ui.stc_PresetArea, "StaticText_RClick")
  self._ui.stc_SlotArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_SlotArea")
  for idx = 0, __eJewelSlotMaxCount - 1 do
    if idx >= 0 and idx < 9 then
      self._jewelSlotList[idx] = UI.getChildControl(self._ui.stc_SlotArea, "Static_NormalSlotBg_0" .. tostring(idx + 1))
    elseif idx >= 9 and idx < __eJewelSpecialSlotAwakenWeapon1 then
      self._jewelSlotList[idx] = UI.getChildControl(self._ui.stc_SlotArea, "Static_NormalSlotBg_" .. tostring(idx + 1))
    elseif idx >= __eJewelSpecialSlotAwakenWeapon1 and idx < __eJewelSpecialSlotEaring2 then
      self._jewelSlotList[idx] = UI.getChildControl(self._ui.stc_SlotArea, "Static_SpecialSlotBg_0" .. tostring(idx - 11))
    else
      self._jewelSlotList[idx] = UI.getChildControl(self._ui.stc_SlotArea, "Static_SpecialSlotBg_" .. tostring(idx - 11))
    end
    local slotBG = UI.getChildControl(self._jewelSlotList[idx], "Static_Slot")
    if slotBG ~= nil then
      local slot = {}
      SlotItem.new(slot, "JewelPreset_Slot_" .. tostring(idx), idx, slotBG, self._slotConfig)
      slot:createChild()
      self._jewelSlot[idx] = slot
    end
  end
  self._ui.btn_ShowTooltip = UI.getChildControl(self._ui.stc_SlotArea, "Button_ShowTooltip")
  self._ui.btn_Adjust = UI.getChildControl(self._ui.stc_SlotArea, "Button_Adjust")
  self._ui.btn_AdjustCancel = UI.getChildControl(self._ui.stc_SlotArea, "Button_AdjustCancel")
  self._ui.btn_Save = UI.getChildControl(self._ui.stc_SlotArea, "Button_Save")
  self._ui.btn_SaveAdjust = UI.getChildControl(self._ui.stc_SlotArea, "Button_SaveAndAdjust")
  self._ui.btn_Inven = UI.getChildControl(self._ui.stc_SlotArea, "Button_SwapInven")
  self._ui.stc_Console_Buttons = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_BottomConsoleButtons")
  self._ui.btn_Console_UnEquip = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_Y_ConsoleUI")
  self._ui.btn_Console_Select = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_A_ConsoleUI")
  self._ui.btn_Console_Close = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_B_ConsoleUI")
  self._ui.btn_Console_Detail = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_X_ConsoleUI")
  self._ui.btn_Console_Scroll = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_RS_ConsoleUI")
  local leftArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_LeftArea")
  self._ui.list_preset = UI.getChildControl(leftArea, "List2_Preset")
  local rightArea = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_RightArea")
  self._ui.txt_Tooltip_Title = UI.getChildControl(rightArea, "StaticText_Title")
  self._ui.Frame_Tooltip = UI.getChildControl(rightArea, "Frame_Tooltip")
  self._ui.Frame_Tooltip_Content = UI.getChildControl(self._ui.Frame_Tooltip, "Frame_1_Content")
  self._ui.Frame_Tooltip_VerticalScroll = UI.getChildControl(self._ui.Frame_Tooltip, "Frame_1_VerticalScroll")
  self._ui.txt_Tooltip_NoCrystal = UI.getChildControl(self._ui.Frame_Tooltip_Content, "StaticText_NoCrystal")
  self._ui.stc_Tooltip_CrystalGroupName = UI.getChildControl(self._ui.Frame_Tooltip_Content, "StaticText_JewelGroupName")
  self._ui.stc_Tooltip_CrystalBg = UI.getChildControl(self._ui.Frame_Tooltip_Content, "Static_CrystalBG")
  self._ui.txt_Tooltip_CrystalDesc = UI.getChildControl(self._ui.stc_Tooltip_CrystalBg, "StaticText_CrystalDesc")
  self._ui.txt_Tooltip_CrystalName = UI.getChildControl(self._ui.stc_Tooltip_CrystalBg, "StaticText_CrystalName")
  self._ui.stc_Tooltip_CrystalIcon = UI.getChildControl(self._ui.stc_Tooltip_CrystalBg, "Static_CrystalIcon")
  self._ui.stc_Tooltip_DetailBG = UI.getChildControl(self._ui.Frame_Tooltip_Content, "Static_DetailBg")
  self._ui.stc_Tooltip_SubTitle = UI.getChildControl(self._ui.stc_Tooltip_DetailBG, "StaticText_SubTitle")
  self._ui.txt_Tooltip_Desc = UI.getChildControl(self._ui.stc_Tooltip_DetailBG, "StaticText_NameTemp")
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_JewelPreset_All, "Static_BlockBg")
  if isGameTypeRussia() or isGameServiceTypeTurkey() then
    self._exeptionLanguage = true
  end
  local languageType = ToClient_getResourceType()
  if nil ~= languageType then
    self._languageTypeString = Defines.LanguageTypeToString[languageType]
    if nil ~= self._languageTypeString and ("FR" == self._languageTypeString or "SP" == self._languageTypeString or "PT" == self._languageTypeString or "ES" == self._languageTypeString or "DE" == self._languageTypeString) then
      self._exeptionLanguage = true
    end
  end
  self._originDetailBgSizeY = self._ui.stc_Tooltip_DetailBG:GetSizeY()
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  self._applyJewelPresetNo = ToClient_GetCurrentJewelPresetNo()
  self._progressBarActive = false
  self:registerEventHandler()
  self:validate()
  self:initializeControl()
  if _ContentsGroup_KingAccessory == false then
    Panel_Window_JewelPreset_All:SetSize(Panel_Window_JewelPreset_All:GetSizeX(), 765)
    self._ui.stc_SlotArea:SetSize(self._ui.stc_SlotArea:GetSizeX(), 675)
    local accessoryBG = UI.getChildControl(self._ui.stc_SlotArea, "Static_AccessoryBg")
    accessoryBG:SetShow(false)
    self._ui.btn_ShowTooltip:SetSpanSize(self._ui.btn_ShowTooltip:GetSpanSize().x, 15)
    self._ui.btn_Save:SetSpanSize(self._ui.btn_Save:GetSpanSize().x, 15)
    self._ui.btn_Adjust:SetSpanSize(self._ui.btn_Adjust:GetSpanSize().x, 15)
    self._ui.btn_AdjustCancel:SetSpanSize(self._ui.btn_AdjustCancel:GetSpanSize().x, 15)
    self._ui.btn_SaveAdjust:SetSpanSize(self._ui.btn_SaveAdjust:GetSpanSize().x, 15)
    self._ui.btn_Inven:SetSpanSize(self._ui.btn_Inven:GetSpanSize().x, 15)
    leftArea:SetSize(leftArea:GetSizeX(), 715)
    self._ui.list_preset:SetSize(self._ui.list_preset:GetSizeX(), 665)
    local leftVertical_Scroll = UI.getChildControl(self._ui.list_preset, "List2_1_VerticalScroll")
    leftVertical_Scroll:SetSize(leftVertical_Scroll, 655)
    local leftVertical_Scroll_DownButton = UI.getChildControl(leftVertical_Scroll, "List2_1_VerticalScroll_DownButton")
    leftVertical_Scroll_DownButton:SetSize(leftVertical_Scroll_DownButton, 655)
    rightArea:SetSize(rightArea:GetSizeX(), 715)
    self._ui.Frame_Tooltip:SetSize(self._ui.Frame_Tooltip:GetSizeX(), 625)
    local frameVertical_Scroll = UI.getChildControl(self._ui.Frame_Tooltip, "Frame_1_VerticalScroll")
    frameVertical_Scroll:SetSize(leftVertical_Scroll, 615)
    local frameVertical_Scroll_DownButton = UI.getChildControl(frameVertical_Scroll, "Frame_1_VerticalScroll_DownButton")
    frameVertical_Scroll_DownButton:SetSize(frameVertical_Scroll_DownButton, 615)
    local frameHorizon_Scroll = UI.getChildControl(self._ui.Frame_Tooltip, "Frame_1_HorizontalScroll")
    frameHorizon_Scroll:SetSize(frameHorizon_Scroll, 625)
  end
  self._isInitialize = true
end
function PaGlobal_JewelPreset:registerEventHandler()
  registerEvent("FromClient_UpdateJewelPreset", "FromClient_UpdateJewelPreset")
  registerEvent("FromClient_ShowUnlockedJewelSlotEffect", "FromClient_ShowUnlockedJewelSlotEffect")
  registerEvent("FromClient_UpdateJewelPresetName", "FromClient_UpdateJewelPresetName")
  registerEvent("FromClient_PushAndPopJewel", "FromClient_PushAndPopJewel")
  registerEvent("FromClient_SaveJewel", "FromClient_SaveJewel")
  registerEvent("FromClient_ApplyJewelPreset", "FromClient_ApplyJewelPreset")
  registerEvent("FromClient_UseJewelPresetItem", "FromClient_UseJewelPresetItem")
  registerEvent("FromClient_CreateJewelPresetShortcuts", "FromClient_CreateJewelPresetShortcuts")
  registerEvent("FromClient_FinishJewelChangeProgressBar", "FromClient_FinishJewelChangeProgressBar")
  registerEvent("FromClient_FinishJewelPresetChangeProgressBar", "FromClient_FinishJewelPresetChangeProgressBar")
  if self._isPadSnapping == true then
    Panel_Window_JewelPreset_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_JewelPreset_CloseWithESC()")
    Panel_Window_JewelPreset_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_JewelPreset:setFocusSearchText()")
  else
    self._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"crystalPreset\" )")
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_CloseWithESC()")
    self._ui.btn_Inven:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowInvenTooltip(true)")
    self._ui.btn_Inven:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowInvenTooltip(false)")
  end
  self._ui.list_preset:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_JewelPreset_CreateControlJewelPresetList")
  self._ui.list_preset:createChildContent(__ePAUIList2ElementManagerType_List)
  for idx = 0, __eJewelSlotMaxCount - 1 do
    local emptySlot = UI.getChildControl(self._jewelSlotList[idx], "Static_Empty")
    if emptySlot ~= nil then
      emptySlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_ShowPleaseSelectTabMsg()")
    end
  end
  self._ui.btn_Edit:addInputEvent("Mouse_LUp", "PaGlobal_JewelPreset:setFocusSearchText()")
  self._ui.btn_Edit:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowEditTooltip(true)")
  self._ui.btn_Edit:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowEditTooltip(false)")
  self._ui.edit_PresetName:RegistReturnKeyEvent("PaGlobal_JewelPreset:savePresetName()")
  if self._isConsole == true then
    self._ui.edit_PresetName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_JewelPreset_SaveJewelPresetConsole")
  else
    self._ui.edit_PresetName:RegistReturnKeyEvent("PaGlobal_JewelPreset:savePresetName()")
  end
  self._ui.btn_Adjust:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_ApplyJewelPreset(true)")
  self._ui.btn_AdjustCancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_ApplyJewelPreset(false)")
  self._ui.btn_Save:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_ClickSaveButton()")
  self._ui.btn_Inven:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_OpenJewelInven(false)")
  local content = UI.getChildControl(self._ui.list_preset, "List2_1_Content")
  if content ~= nil then
    for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
      PaGlobalFunc_JewelPreset_CreateControlJewelPresetList(content, idx)
    end
  end
  registerEvent("FromClient_CheckChinaProhibitedWord_SetJewelPresetName", "FromClient_CheckChinaProhibitedWord_SetJewelPresetName")
end
function PaGlobal_JewelPreset:initializeControl()
  if self._isPadSnapping == true then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Question:SetShow(false)
    self._ui.btn_Console_LB:SetShow(true)
    self._ui.btn_Console_RB:SetShow(true)
    self._ui.txt_RClick:SetShow(false)
    self._ui.txt_LClick:SetShow(false)
    self._ui.stc_Console_Buttons:SetSize(Panel_Window_JewelPreset_All:GetSizeX(), self._ui.stc_Console_Buttons:GetSizeY())
    self._ui.stc_Console_Buttons:SetPosX(0)
    self._ui.stc_Console_Buttons:SetShow(true)
    self._ui.stc_Console_PresetGuide:SetShow(true)
    local keyGuideList = {
      self._ui.btn_Console_UnEquip,
      self._ui.btn_Console_Select,
      self._ui.btn_Console_Close,
      self._ui.btn_Console_Detail,
      self._ui.btn_Console_Scroll
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    self._ui.btn_Close:SetShow(true)
    self._ui.btn_Question:SetShow(true)
    self._ui.btn_Console_LB:SetShow(false)
    self._ui.btn_Console_RB:SetShow(false)
    self._ui.txt_RClick:SetShow(true)
    self._ui.txt_LClick:SetShow(true)
    self._ui.txt_RClick:SetSpanSize(self._ui.txt_RClick:GetSizeX() + self._ui.txt_RClick:GetTextSizeX(), self._ui.txt_RClick:GetSpanSize().y)
    self._ui.txt_LClick:SetSpanSize(self._ui.txt_LClick:GetSizeX() + self._ui.txt_LClick:GetTextSizeX() + self._ui.txt_RClick:GetSpanSize().x, self._ui.txt_RClick:GetSpanSize().y)
    self._ui.stc_Console_Buttons:SetShow(false)
    self._ui.stc_Console_PresetGuide:SetShow(false)
  end
  self._jewelSlotList[__eJewelSpecialSlot1MorningLand]:SetShow(_ContentsGroup_MorningLand == true)
  self._jewelSlotList[__eJewelSpecialSlot2MorningLand]:SetShow(_ContentsGroup_MorningLand == true)
  self._jewelSlotList[__eJewelSpecialSlotNecklace]:SetShow(_ContentsGroup_KingAccessory == true)
  self._jewelSlotList[__eJewelSpecialSlotRing1]:SetShow(_ContentsGroup_KingAccessory == true)
  self._jewelSlotList[__eJewelSpecialSlotRing2]:SetShow(_ContentsGroup_KingAccessory == true)
  self._jewelSlotList[__eJewelSpecialSlotEaring1]:SetShow(_ContentsGroup_KingAccessory == true)
  self._jewelSlotList[__eJewelSpecialSlotEaring2]:SetShow(_ContentsGroup_KingAccessory == true)
  self._jewelSlotList[__eJewelSpecialSlotBelt]:SetShow(_ContentsGroup_KingAccessory == true)
  self._ui.txt_Tooltip_CrystalDesc:SetShow(false)
  self._ui.stc_Tooltip_DetailBG:SetShow(true)
  self:createJewelPresetControl()
  self._ui.stc_blockBg:SetIgnore(false)
  self._ui.stc_blockBg:SetAlpha(0)
end
function PaGlobal_JewelPreset:prepareOpen(presetNo)
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  if PaGlobal_JewelPreset._isPadSnapping == true then
    if PaGlobalFunc_InventoryInfo_Close ~= nil and Panel_Window_Inventory:IsShow() == true then
      PaGlobalFunc_InventoryInfo_Close()
    end
  elseif Panel_Window_Inventory_All:GetShow() == true then
    PaGlobalFunc_Inventory_All_SetShow(false)
  end
  if Panel_Npc_Dialog_All ~= nil then
    Panel_Window_JewelPreset_All:SetPosXY((getScreenSizeX() - Panel_Window_JewelPreset_All:GetSizeX()) * 0.5, (getScreenSizeY() - Panel_Window_JewelPreset_All:GetSizeY()) * 0.5)
  end
  self:clearFocusEdit()
  self._applyJewelPresetNo = ToClient_GetCurrentJewelPresetNo()
  if self._progressBarActive == true and self._applyProgressJewelPresetNo ~= __eJewelNotActivatingPresetNo then
    ToClient_SetSelectedJewelPresetInfo(self._applyProgressJewelPresetNo)
    self._selectJewelPresetNo = self._applyProgressJewelPresetNo
    self:update(self._selectJewelPresetNo)
  elseif self._closeByJewelInven == true then
    self:update(self._selectJewelPresetNo)
  elseif presetNo ~= nil then
    ToClient_SetSelectedJewelPresetInfo(presetNo)
    if presetNo ~= __eJewelNotActivatingPresetNo then
      self._selectJewelPresetNo = presetNo
    else
      self._selectJewelPresetNo = 0
    end
    self:update(presetNo)
  elseif self._applyJewelPresetNo ~= __eJewelNotActivatingPresetNo then
    ToClient_SetSelectedJewelPresetInfo(self._applyJewelPresetNo)
    self._selectJewelPresetNo = self._applyJewelPresetNo
    self:update(self._selectJewelPresetNo)
  else
    ToClient_SetSelectedJewelPresetInfo(self._selectJewelPresetNo)
    self:update(self._selectJewelPresetNo)
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self._selectedJewelSlot = -1
  self._closeByJewelInven = false
  self:open()
end
function PaGlobal_JewelPreset:open()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  Panel_Window_JewelPreset_All:SetShow(true)
end
function PaGlobal_JewelPreset:prepareClose()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  if self._closeByJewelInven == false then
    ToClient_clearSelectedJewelPresetInfo()
  end
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self._progressBarActive = false
  if _ContentsOption_CH_CheckProhibitedWord == true then
    self._ui.edit_PresetName:RegistReturnKeyEvent("PaGlobal_JewelPreset:savePresetName()")
  end
  self:close()
end
function PaGlobal_JewelPreset:close()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  Panel_Window_JewelPreset_All:SetShow(false)
end
function PaGlobal_JewelPreset:clearFocusEdit()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  ClearFocusEdit()
  self._ui.edit_PresetName:SetShow(false)
  self._ui.txt_PresetName:SetShow(true)
  self._ui.txt_AdjustName:SetShow(true)
  if self._isPadSnapping == true then
    self._ui.stc_Console_PresetGuide:SetShow(true)
  end
end
function PaGlobal_JewelPreset:update(presetNo)
  self:clearFocusEdit()
  ToClient_CheckUnlockedJewelSlot()
  self:updateJewelControl()
  self:updateJewelPresetName(presetNo)
  for index = 0, __eJewelSlotMaxCount do
    self:updateJewelPresetInfo(index)
  end
  self:updateJewelTooltip()
  if self._isPadSnapping == true then
    local slotControl = self._jewelSlotList[0]
    if slotControl ~= nil then
      ToClient_padSnapChangeToTarget(slotControl)
    end
  end
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_JewelPreset:updateJewelPresetInfo(slotNo)
  local slotControl = self._jewelSlotList[slotNo]
  if slotControl == nil then
    return
  end
  local emptySlot = UI.getChildControl(slotControl, "Static_Empty")
  if emptySlot == nil then
    return
  end
  local emptyIcon = UI.getChildControl(slotControl, "Static_EmptyIcon")
  if emptyIcon == nil then
    return
  end
  local slot = self._jewelSlot[slotNo]
  if slot == nil then
    return
  end
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
  local isActivatingJewel = ToClient_isActivatingJewel(slotNo)
  if slotNo < __eJewelSpecialSlotAwakenWeapon1 then
    if jewelItemSSW == nil then
      slot:clearItem()
      emptySlot:SetShow(true)
      emptyIcon:SetShow(true)
      emptySlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectJewelSlot(" .. slotNo .. ")")
      emptySlot:removeInputEvent("Mouse_RUp")
      slot.icon:removeInputEvent("Mouse_On")
      slot.icon:removeInputEvent("Mouse_Out")
      if self._isPadSnapping == true then
        emptySlot:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 1 .. ")")
      end
    else
      slot:setItemByStaticStatus(jewelItemSSW)
      emptySlot:SetShow(false)
      emptyIcon:SetShow(false)
      emptySlot:removeInputEvent("Mouse_LUp")
      if self._isPadSnapping == true then
        slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 2 .. ")")
        slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
        slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
        slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
      else
        slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
        slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
        slot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
      end
    end
  else
    local jewelLock = UI.getChildControl(slotControl, "Static_Lock")
    if slotNo > ToClient_GetJewelVisibleSlotCount() then
      slotControl:SetShow(false)
      emptySlot:SetShow(false)
      jewelLock:SetShow(true)
    elseif slotNo == __eJewelSpecialSlot1MorningLand and _ContentsGroup_MorningLand == false or slotNo == __eJewelSpecialSlot2MorningLand and _ContentsGroup_MorningLand == false or slotNo == __eJewelSpecialSlotNecklace and _ContentsGroup_KingAccessory == false or slotNo == __eJewelSpecialSlotRing1 and _ContentsGroup_KingAccessory == false or slotNo == __eJewelSpecialSlotRing2 and _ContentsGroup_KingAccessory == false or slotNo == __eJewelSpecialSlotEaring1 and _ContentsGroup_KingAccessory == false or slotNo == __eJewelSpecialSlotEaring2 and _ContentsGroup_KingAccessory == false or slotNo == __eJewelSpecialSlotBelt and _ContentsGroup_KingAccessory == false then
      slotControl:SetShow(false)
      emptySlot:SetShow(false)
      jewelLock:SetShow(true)
    else
      slotControl:SetShow(true)
      if jewelItemSSW == nil then
        if isActivatingJewel == true then
          slot:clearItem()
          emptySlot:SetShow(true)
          emptyIcon:SetShow(true)
          jewelLock:SetShow(false)
          emptySlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectJewelSlot(" .. slotNo .. ")")
          jewelLock:removeInputEvent("Mouse_On")
          jewelLock:removeInputEvent("Mouse_Out")
          slot.icon:removeInputEvent("Mouse_On")
          slot.icon:removeInputEvent("Mouse_Out")
          if self._isPadSnapping == true then
            emptySlot:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 1 .. ")")
          end
        else
          slot:clearItem()
          emptySlot:SetShow(false)
          emptyIcon:SetShow(false)
          jewelLock:SetShow(true)
          emptySlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectJewelSlot(" .. slotNo .. ")")
          if self._isPadSnapping == true then
            jewelLock:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 3 .. ")")
            slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelPreset_ShowJewelLockedTooltip(true, " .. slotNo .. ")")
            jewelLock:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelLockedTooltip(false, " .. slotNo .. ")")
          else
            jewelLock:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowJewelLockedTooltip(true, " .. slotNo .. ")")
            jewelLock:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelLockedTooltip(false, " .. slotNo .. ")")
          end
          slot.icon:removeInputEvent("Mouse_On")
          slot.icon:removeInputEvent("Mouse_Out")
        end
      elseif isActivatingJewel == true then
        slot:setItemByStaticStatus(jewelItemSSW)
        emptySlot:SetShow(false)
        emptyIcon:SetShow(false)
        jewelLock:SetShow(false)
        slot.icon:SetMonoTone(false)
        slot.icon:SetPosX(slot.icon:getParent():GetSizeX() / 2 - slot.icon:GetSizeX() / 2)
        slot.icon:SetPosY(slot.icon:getParent():GetSizeY() / 2 - slot.icon:GetSizeY() / 2)
        if self._isPadSnapping == true then
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 2 .. ")")
          slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
          slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
        else
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
        end
      else
        slot:setItemByStaticStatus(jewelItemSSW)
        emptySlot:SetShow(false)
        emptyIcon:SetShow(false)
        jewelLock:SetShow(false)
        slot.icon:SetMonoTone(true)
        slot.icon:SetPosX(slot.icon:getParent():GetSizeX() / 2 - slot.icon:GetSizeX() / 2)
        slot.icon:SetPosY(slot.icon:getParent():GetSizeY() / 2 - slot.icon:GetSizeY() / 2)
        if self._isPadSnapping == true then
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 2 .. ")")
          slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
          slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
        else
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(true, " .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowJewelToolTip(false, " .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_JewelPreset_PopJewel(" .. slotNo .. ")")
        end
      end
    end
  end
end
function PaGlobal_JewelPreset:pushJewel(jewelNo)
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  if self._selectedJewelSlot == -1 then
    return
  end
  ToClient_PushJewelToJewelPresetBeforApply(self._selectJewelPresetNo, self._selectedJewelSlot, jewelNo)
  if self._jewelSlotList[self._selectedJewelSlot] ~= nil then
    local slotControl = self._jewelSlotList[self._selectedJewelSlotForPadControl]
    if slotControl ~= nil then
      slotControl:AddEffect("fUI_Crystal_Box_01A")
      if self._isPadSnapping == true then
        ToClient_padSnapResetControl()
        ToClient_padSnapChangeToTarget(slotControl)
      end
    end
  end
  audioPostEvent_SystemUi(0, 29)
  _AudioPostEvent_SystemUiForXBOX(0, 29)
end
function PaGlobal_JewelPreset:popJewel(slotNo)
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  ToClient_PopJewelFromJewelPresetBeforApply(self._selectJewelPresetNo, slotNo)
  if self._jewelSlotList[slotNo] ~= nil then
    local slotControl = UI.getChildControl(self._jewelSlotList[slotNo], "Static_Slot")
    if slotControl ~= nil then
      slotControl:AddEffect("fUI_Crystal_Box_01A")
    end
  end
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
end
function PaGlobal_JewelPreset:setFocusSearchText()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  self._ui.edit_PresetName:SetShow(true)
  self._ui.txt_PresetName:SetShow(false)
  self._ui.txt_AdjustName:SetShow(false)
  SetFocusEdit(self._ui.edit_PresetName)
  self._ui.edit_PresetName:SetEditText("")
  if self._isPadSnapping == true then
    self._ui.stc_Console_PresetGuide:SetShow(false)
    ToClient_padSnapChangeToTarget(self._ui.txt_PresetName)
  end
end
function PaGlobal_JewelPreset:savePresetName()
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  local presetName = self._ui.edit_PresetName:GetText()
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(presetName, __eSceneIdSetJewelPresetName)
    if result == true then
      self._ui.edit_PresetName:RegistReturnKeyEvent("")
    end
    return
  end
  self._ui.edit_PresetName:SetShow(false)
  self._ui.txt_PresetName:SetShow(true)
  self._ui.txt_AdjustName:SetShow(true)
  ToClient_SaveJewelPresetName(self._selectJewelPresetNo, presetName)
  if self._isPadSnapping == true then
    self._ui.stc_Console_PresetGuide:SetShow(true)
    ToClient_padSnapChangeToTarget(Panel_Window_JewelPreset_All)
  end
end
function PaGlobal_JewelPreset:updateJewelPresetName(presetNo)
  local presetName = ToClient_GetJewelPresetName(presetNo)
  if presetName == nil then
    presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", presetNo + 1)
  end
  self._ui.txt_PresetName:SetText("<PAColor0xffffc340>" .. presetName .. "<PAOldColor>")
  if self._applyJewelPresetNo == __eJewelNotActivatingPresetNo then
    local applyPresetName = ToClient_GetJewelPresetName(self._applyJewelPresetNo)
    self._ui.txt_AdjustName:SetText("<PAColor0xffffc340>" .. "[" .. applyPresetName .. "]" .. "<PAOldColor>")
  else
    local applyPresetName = ToClient_GetJewelPresetName(self._applyJewelPresetNo)
    if applyPresetName == nil then
      applyPresetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", self._applyJewelPresetNo + 1)
    end
    self._ui.txt_AdjustName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_APPLYPRESET", "presetName", "<PAColor0xffffc340>" .. "[" .. applyPresetName .. "]" .. "<PAOldColor>"))
  end
  local presetControl = self._ui.list_preset:GetContentByKey(presetNo)
  if presetControl ~= nil then
    local radioButton_template = UI.getChildControl(presetControl, "RadioButton_Template")
    local txt_PresetName = UI.getChildControl(radioButton_template, "StaticText_PresetName")
    if txt_PresetName ~= nil then
      txt_PresetName:SetText(presetName)
      txt_PresetName:SetShow(true)
    end
  end
  self._ui.txt_Tooltip_Title:SetText(presetName)
  if self._isPadSnapping == true then
    self._ui.stc_Console_PresetGuide:SetPosX(self._ui.txt_PresetName:GetPosX() + self._ui.txt_PresetName:GetTextSizeX() + 10)
    self._ui.txt_AdjustName:SetSize(self._ui.txt_AdjustName:GetTextSizeX(), self._ui.txt_AdjustName:GetSizeY())
    self._ui.txt_AdjustName:SetPosX(self._ui.stc_PresetArea:GetSizeX() / 2 - self._ui.txt_AdjustName:GetSizeX() / 2)
    if self._ui.stc_Console_PresetGuide:GetPosX() + self._ui.stc_Console_PresetGuide:GetSizeX() > self._ui.txt_AdjustName:GetPosX() then
      self._ui.txt_AdjustName:SetPosX(self._ui.stc_Console_PresetGuide:GetPosX() + self._ui.stc_Console_PresetGuide:GetSizeX() + 10)
    end
  end
end
function PaGlobal_JewelPreset:updateJewelControl()
  local currentPresetNo = ToClient_GetCurrentJewelPresetNo()
  if currentPresetNo == self._selectJewelPresetNo then
    self._ui.btn_Adjust:SetShow(false)
    self._ui.btn_AdjustCancel:SetShow(true)
    self._ui.btn_Save:SetShow(false)
  else
    self._ui.btn_Adjust:SetShow(true)
    self._ui.btn_AdjustCancel:SetShow(false)
    self._ui.btn_Save:SetShow(false)
  end
  local updateJewel = PaGlobalFunc_JewelPreset_judgeJewelSlotChange(self._selectJewelPresetNo) and PaGlobalFunc_JewelPreset_IsShow() == true
  if updateJewel == true then
    self._ui.btn_Adjust:SetShow(false)
    self._ui.btn_AdjustCancel:SetShow(false)
    self._ui.btn_Save:SetShow(true)
  else
    self._ui.btn_Save:SetShow(false)
  end
  self:updateJewelRadioButton()
end
function PaGlobal_JewelPreset:updateJewelRadioButton()
  if self._ui.list_preset ~= nil then
    for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
      local content = self._ui.list_preset:GetContentByKey(idx)
      if content ~= nil then
        local radioButton_template = UI.getChildControl(content, "RadioButton_Template")
        if idx == self._selectJewelPresetNo then
          radioButton_template:SetCheck(true)
        else
          radioButton_template:SetCheck(false)
        end
      end
    end
  end
end
function PaGlobal_JewelPreset:createJewelPresetControl()
  if self._ui.list_preset ~= nil then
    self._ui.list_preset:getElementManager():clearKey()
    for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
      self._ui.list_preset:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
function PaGlobal_JewelPreset:confirmMessageBox()
  if self._isConsole == true then
    return
  end
  local easyBuyPreset = function()
    PaGlobalFunc_EasyBuy_Open(94)
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_EXTENDMSG")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = messageBoxMemo,
    functionYes = easyBuyPreset,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_UpdateJewelPreset(presetNo)
  PaGlobal_JewelPreset:update(presetNo)
end
function FromClient_UpdateJewelPresetName(presetNo)
  PaGlobal_JewelPreset:updateJewelPresetName(presetNo)
  PaGlobal_TotalPreset_UpdatePreset()
end
function FromClient_FinishJewelChangeProgressBar()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._progressBarActive = false
  ToClient_ApplyJewelChangesInDangerousZone(self._selectJewelPresetNo)
end
function FromClient_FinishJewelPresetChangeProgressBar()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._progressBarActive = false
  if self._applyPreset == true then
    ToClient_ChangeJewelPresetInDangerousZone(self._selectJewelPresetNo)
    audioPostEvent_SystemUi(5, 89)
    _AudioPostEvent_SystemUiForXBOX(5, 89)
  else
    ToClient_ChangeJewelPresetInDangerousZone(__eJewelNotActivatingPresetNo)
  end
end
function FromClient_PushAndPopJewel()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  Panel_Window_JewelPreset_All:SetShow(true)
  self._closeByJewelInven = false
  for index = 0, __eJewelSlotMaxCount do
    self:updateJewelPresetInfo(index)
  end
  self:updateJewelTooltip()
  self:updateJewelControl()
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function FromClient_SaveJewel()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self:updateJewelControl()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CRYSTALSAVE_NOTIFICATION"))
end
function FromClient_ApplyJewelPreset(presetNo)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._applyJewelPresetNo = ToClient_GetCurrentJewelPresetNo()
  self:updateJewelPresetName(self._selectJewelPresetNo)
  self:updateJewelControl()
  for index = 0, __eJewelSlotMaxCount do
    self:updateJewelPresetInfo(index)
  end
  self:updateJewelTooltip()
  if self._applyJewelPresetNo ~= __eJewelNotActivatingPresetNo then
    local presetName = ToClient_GetJewelPresetName(self._applyJewelPresetNo)
    if presetName == nil then
      presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", self._applyJewelPresetNo + 1)
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOTKEY_PRESETALERT", "presetName", presetName))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOTKEY_PRESETCANCEL"))
  end
  self._progressBarActive = false
  self._applyProgressJewelPresetNo = __eJewelNotActivatingPresetNo
end
function FromClient_UseJewelPresetItem()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self:createJewelPresetControl()
  PaGlobal_TotalPreset_UpdatePreset()
end
function FromClient_CreateJewelPresetShortcuts()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self:createJewelPresetControl()
  local content = UI.getChildControl(self._ui.list_preset, "List2_1_Content")
  if content ~= nil then
    for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
      PaGlobalFunc_JewelPreset_CreateControlJewelPresetList(content, idx)
    end
  end
end
function FromClient_ShowUnlockedJewelSlotEffect(slotNo)
  if PaGlobal_JewelPreset._jewelSlotList[slotNo] == nil then
    return
  end
  local slotControl = PaGlobal_JewelPreset._jewelSlotList[slotNo]
  if slotControl == nil then
    return
  end
  local emptySlot = UI.getChildControl(slotControl, "Static_Empty")
  if emptySlot == nil then
    return
  end
  local emptyIcon = UI.getChildControl(slotControl, "Static_EmptyIcon")
  if emptyIcon == nil then
    return
  end
  local jewelLock = UI.getChildControl(slotControl, "Static_Lock")
  if emptyIcon == nil then
    return
  end
  slotControl:SetShow(true)
  emptySlot:SetShow(true)
  emptyIcon:SetShow(true)
  jewelLock:SetShow(false)
  slotControl:AddEffect("fUI_Crystal_Box_02A", false, 0, 0)
  audioPostEvent_SystemUi(5, 89)
  _AudioPostEvent_SystemUiForXBOX(5, 89)
end
function PaGlobal_JewelPreset:updateJewelTooltip()
  self._totalDesc = {}
  self._buffCount = 0
  self._usingCrystalUICount = 0
  self._posY = 0
  self._lastJewelGroupNumber = -1
  self._usingCrystalGroupNumberUICount = 0
  local classType = getSelfPlayer():getClassType()
  local jewelBuffTable = {}
  for idx, value in pairs(self._tooltipOrderTable) do
    local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(value)
    local needToShow = true
    local equipItemWrapper
    local socketCount = 0
    if value == __eJewelSpecialSlotAwakenWeapon1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 1 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotAwakenWeapon2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 2 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotPearlAvatarChest then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAvatarChest)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 1 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotNecklace then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoNecklace)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotRing1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing1)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotRing2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing2)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotEaring1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring1)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotEaring2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring2)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotBelt then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoBelt)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    end
    if jewelItemSSW ~= nil and needToShow == true then
      local data = {
        slotNo = value,
        groupNumber = jewelItemSSW:getJewelGroupNumber()
      }
      table.insert(jewelBuffTable, data)
    end
  end
  local sortFunction = function(data1, data2)
    if data1.groupNumber == data2.groupNumber then
      return data1.slotNo < data2.slotNo
    else
      return data1.groupNumber < data2.groupNumber
    end
  end
  table.sort(jewelBuffTable, sortFunction)
  for idx, value in pairs(self._listCrystal) do
    value.stc_Tooltip_CrystalBg:SetShow(false)
  end
  for idx, value in pairs(self._listCrystalGroupName) do
    value:SetShow(false)
  end
  for idx, data in pairs(jewelBuffTable) do
    if self._isDetail == true then
      self:createDetailJewelTooltipUI(data.slotNo, classType)
    else
      self:createSimpleJewelTooltipUI(data.slotNo, classType)
    end
    self._usingCrystalUICount = self._usingCrystalUICount + 1
  end
  self._ui.txt_Tooltip_NoCrystal:SetShow(false)
  self:jewelTooltipDetail()
  self:resizeJewelTooltip()
end
function PaGlobal_JewelPreset:createDetailJewelTooltipUI(slotNo, classType)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewTooltipGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:createNewTooltipSlotUI()
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:getBaseTexture())
  local buffList = ""
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    if buffList == nil or buffList == "" then
      buffList = desc
    else
      buffList = buffList .. " / " .. desc
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
        local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              else
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._buffCount = self._buffCount + 1
              end
            end
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + self._startIndex, -1)
            self._buffCount = self._buffCount + 1
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      if buffList == nil or buffList == "" then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
  end
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemEnchantSSW:getName(), itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_Tooltip_CrystalName:SetText(strItemName .. [[

<PAColor0xffc4bebe>]] .. buffList .. "<PAOldColor>")
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalBg:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_Tooltip_CrystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalBg:SetShow(true)
end
function PaGlobal_JewelPreset:createSimpleJewelTooltipUI(slotNo, classType)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewTooltipGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:createNewTooltipSlotUI()
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemEnchantSSW:getName(), itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_Tooltip_CrystalName:SetText(strItemName)
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_Tooltip_CrystalDesc:SetText(" ")
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
        local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              else
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._buffCount = self._buffCount + 1
              end
            end
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + self._startIndex, -1)
            self._buffCount = self._buffCount + 1
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      if buffList == nil or buffList == "" then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
  end
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalBg:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_Tooltip_CrystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_Tooltip_CrystalBg:SetShow(true)
end
function PaGlobal_JewelPreset:jewelTooltipDetail()
  self._ui.stc_Tooltip_DetailBG:SetSize(self._ui.stc_Tooltip_DetailBG:GetSizeX(), self._originDetailBgSizeY)
  if self._buffCount <= 0 then
    self._ui.txt_Tooltip_Desc:SetText("")
    self._ui.stc_Tooltip_DetailBG:SetShow(false)
    self._ui.stc_Tooltip_DetailBG:SetSize(self._ui.stc_Tooltip_DetailBG:GetSizeX(), 0)
    return
  end
  self._ui.stc_Tooltip_DetailBG:SetShow(true)
  local temp1, temp2, temp3 = {}, {}, {}
  for index = 0, #self._totalDesc do
    local cIndex1, cIndex2 = string.find(self._totalDesc[index], "+")
    if nil ~= cIndex1 or nil ~= cIndex2 then
      temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
      local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
      temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
    else
      cIndex1, cIndex2 = string.find(self._totalDesc[index], "-")
      if nil ~= cIndex1 or nil ~= cIndex2 then
        temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
        local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
        temp2[index] = tonumber(string.match(backString, "[%d%.]+")) * -1
      else
        cIndex1, cIndex2 = string.find(self._totalDesc[index], "[%d%.]")
        if nil ~= cIndex1 then
          temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
          local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
          temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
        end
      end
    end
  end
  local temp = {}
  local buffCategoryCount = 0
  for index = 0, #self._totalDesc do
    if buffCategoryCount > 0 then
      local isSame = false
      for ii = 0, buffCategoryCount - 1 do
        local compareIndex = temp[ii]
        if temp1[compareIndex] == temp1[index] and false == isSame then
          if nil ~= temp3[ii] then
            temp3[ii] = temp3[ii] + temp2[index]
          end
          isSame = true
        end
      end
      if false == isSame then
        temp[buffCategoryCount] = index
        temp3[buffCategoryCount] = temp2[index]
        buffCategoryCount = buffCategoryCount + 1
      end
    else
      temp[buffCategoryCount] = index
      temp3[buffCategoryCount] = temp2[index]
      buffCategoryCount = buffCategoryCount + 1
    end
  end
  local function jewelSubUICreate(index)
    if nil == self._effectDesc[index] then
      self._effectDesc[index] = UI.createAndCopyBasePropertyControl(self._ui.stc_Tooltip_DetailBG, "StaticText_NameTemp", self._ui.stc_Tooltip_DetailBG, "StaticText_EffectDesc_" .. index)
      self._effectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
    end
  end
  if 0 < self._beforeCount then
    for index = 0, self._beforeCount - 1 do
      self._effectDesc[index]:SetShow(false)
    end
  end
  for index = 0, buffCategoryCount - 1 do
    if nil ~= temp3[index] then
      if temp3[index] >= 0 then
        local minusCount = select(2, string.gsub(self._totalDesc[temp[index]], "-[%d%.]", "-[%d%.]"))
        if minusCount > 0 then
          for ii = 1, minusCount do
            if minusCount == ii then
              self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "+")
            end
          end
        end
        local plusCount = select(2, string.gsub(self._totalDesc[temp[index]], "+", "+"))
        if plusCount > 0 then
          local index1, index2 = string.find(self._totalDesc[temp[index]], "+")
          local frontString = string.sub(self._totalDesc[temp[index]], 1, index1 - 1)
          local backString = string.sub(self._totalDesc[temp[index]], index2, string.len(self._totalDesc[temp[index]]))
          backString = string.gsub(backString, "[%d%.]+", temp3[index])
          self._totalDesc[temp[index]] = frontString .. backString
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "<PAColor0xffffec80>+")
        else
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>+" .. temp3[index])
        end
      else
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>" .. temp3[index])
      end
      self._totalDesc[temp[index]] = self._totalDesc[temp[index]] .. "<PAOldColor>"
    end
    if index >= self._beforeCount then
      jewelSubUICreate(index)
    end
    self._effectDesc[index]:SetText(self._totalDesc[temp[index]])
    if index == 0 then
      self._effectDesc[index]:SetPosY(self._ui.txt_Tooltip_Desc:GetPosY())
    else
      local addGap = 0
      if 0 == index % 3 then
        addGap = 10
      end
      self._effectDesc[index]:SetPosY(self._effectDesc[index - 1]:GetPosY() + math.max(20, self._effectDesc[index - 1]:GetTextSizeY()) + addGap)
    end
    self._effectDesc[index]:SetShow(true)
  end
  self._beforeCount = buffCategoryCount
  self._ui.stc_Tooltip_DetailBG:SetSize(self._ui.stc_Tooltip_DetailBG:GetSizeX(), self._effectDesc[buffCategoryCount - 1]:GetPosY() + math.max(20, self._effectDesc[buffCategoryCount - 1]:GetTextSizeY()) + 10)
end
function PaGlobal_JewelPreset:createNewTooltipSlotUI()
  if self._usingCrystalUICount + 1 > self._listCrystalSize then
    self._listCrystal[self._usingCrystalUICount] = self:getNewTooltipCrystalCopy(self._usingCrystalUICount)
    self._listCrystalSize = self._listCrystalSize + 1
  end
end
function PaGlobal_JewelPreset:getNewTooltipCrystalCopy(idx)
  local _crystalCopy = {
    stc_Tooltip_CrystalBg,
    stc_Tooltip_CrystalIcon,
    txt_Tooltip_CrystalName,
    txt_Tooltip_CrystalDesc
  }
  _crystalCopy.stc_Tooltip_CrystalBg = UI.createAndCopyBasePropertyControl(self._ui.Frame_Tooltip_Content, "Static_CrystalBG", self._ui.Frame_Tooltip_Content, "Static_CrystalBG_No" .. idx)
  _crystalCopy.stc_Tooltip_CrystalIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_Tooltip_CrystalBg, "Static_CrystalIcon", _crystalCopy.stc_Tooltip_CrystalBg, "Static_CrystalIcon_No" .. idx)
  _crystalCopy.txt_Tooltip_CrystalName = UI.createAndCopyBasePropertyControl(self._ui.stc_Tooltip_CrystalBg, "StaticText_CrystalName", _crystalCopy.stc_Tooltip_CrystalBg, "StaticText_CrystalName_No" .. idx)
  _crystalCopy.txt_Tooltip_CrystalDesc = UI.createAndCopyBasePropertyControl(self._ui.stc_Tooltip_CrystalBg, "StaticText_CrystalDesc", _crystalCopy.stc_Tooltip_CrystalBg, "StaticText_CrystalDesc_No" .. idx)
  _crystalCopy.txt_Tooltip_CrystalDesc:SetText("")
  _crystalCopy.txt_Tooltip_CrystalDesc:SetTextMode(__eTextMode_AutoWrap)
  _crystalCopy.txt_Tooltip_CrystalName:SetTextMode(__eTextMode_AutoWrap)
  return _crystalCopy
end
function PaGlobal_JewelPreset:createNewTooltipGroupNameSlotUI(groupNumber)
  local isNewJewelGroup = false
  if self._lastJewelGroupNumber ~= groupNumber then
    isNewJewelGroup = true
    self._lastJewelGroupNumber = groupNumber
  else
    isNewJewelGroup = false
  end
  if self._usingCrystalGroupNumberUICount + 1 > self._listCrystalGroupNameSize and isNewJewelGroup == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount] = self:getNewTooltipCrystalGroupNameCopy(self._usingCrystalGroupNumberUICount)
    self._listCrystalGroupNameSize = self._listCrystalGroupNameSize + 1
  end
  return isNewJewelGroup
end
function PaGlobal_JewelPreset:getNewTooltipCrystalGroupNameCopy(idx)
  local _crystalGroupNameCopy = UI.createAndCopyBasePropertyControl(self._ui.Frame_Tooltip_Content, "StaticText_JewelGroupName", self._ui.Frame_Tooltip_Content, "StaticText_JewelGroupName_No" .. idx)
  return _crystalGroupNameCopy
end
function PaGlobal_JewelPreset:resizeJewelTooltip()
  local crysitalBgSizeY = 0
  local groupNameSizeY = 0
  self._ui.stc_Tooltip_DetailBG:SetPosY(0)
  local crystalDetailBgSizeY = self._ui.stc_Tooltip_DetailBG:GetSizeY() + 20
  for i = 0, self._usingCrystalUICount - 1 do
    crysitalBgSizeY = crysitalBgSizeY + self._listCrystal[i].txt_Tooltip_CrystalName:GetTextSizeY()
    self._listCrystal[i].stc_Tooltip_CrystalBg:SetPosY(self._listCrystal[i].stc_Tooltip_CrystalBg:GetPosY() + crystalDetailBgSizeY)
  end
  for i = 0, self._usingCrystalGroupNumberUICount - 1 do
    groupNameSizeY = groupNameSizeY + self._listCrystalGroupName[i]:GetSizeY()
    self._listCrystalGroupName[i]:SetPosY(self._listCrystalGroupName[i]:GetPosY() + crystalDetailBgSizeY)
  end
  self._conetneSizeY = crystalDetailBgSizeY + crysitalBgSizeY + groupNameSizeY
  self._ui.Frame_Tooltip_Content:SetSize(self._ui.Frame_Tooltip_Content:GetSizeX(), self._conetneSizeY)
  if self._conetneSizeY > self._ui.Frame_Tooltip:GetSizeY() then
    self._ui.Frame_Tooltip_VerticalScroll:GetControlButton():SetSize(self._ui.Frame_Tooltip_VerticalScroll:GetControlButton():GetSizeX(), math.min(600, 600 / self._conetneSizeY * 500))
    self._ui.Frame_Tooltip_VerticalScroll:SetInterval(self._conetneSizeY / 100 * 1.2)
    self._ui.Frame_Tooltip:UpdateContentScroll()
    self._ui.Frame_Tooltip_VerticalScroll:SetControlTop()
    self._ui.Frame_Tooltip:UpdateContentPos()
    self._ui.Frame_Tooltip_VerticalScroll:ComputePos()
    self._ui.Frame_Tooltip_VerticalScroll:SetShow(true)
    if self._isPadSnapping == true then
      self._ui.btn_Console_Scroll:SetShow(true)
    end
  else
    self._ui.Frame_Tooltip:UpdateContentScroll()
    self._ui.Frame_Tooltip_VerticalScroll:SetControlTop()
    self._ui.Frame_Tooltip:UpdateContentPos()
    self._ui.Frame_Tooltip_VerticalScroll:ComputePos()
    self._ui.Frame_Tooltip_VerticalScroll:SetShow(false)
    if self._isPadSnapping == true then
      self._ui.btn_Console_Scroll:SetShow(false)
    end
  end
end
function PaGlobal_JewelPreset:validate()
  self._ui.stc_TitleBarArea:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_RadioButtonArea:isValidate()
  for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
    local content = self._ui.list_preset:GetContentByKey(idx)
    if content ~= nil then
      content:isValidate()
    end
  end
  self._ui.btn_Console_LB:isValidate()
  self._ui.btn_Console_RB:isValidate()
  self._ui.stc_PresetArea:isValidate()
  self._ui.btn_Edit:isValidate()
  self._ui.stc_Console_PresetGuide:isValidate()
  self._ui.txt_PresetName:isValidate()
  self._ui.txt_AdjustName:isValidate()
  self._ui.edit_PresetName:isValidate()
  self._ui.txt_LClick:isValidate()
  self._ui.txt_RClick:isValidate()
  for idx, value in pairs(self._jewelSlotList) do
    value:isValidate()
  end
  self._ui.btn_Adjust:isValidate()
  self._ui.btn_AdjustCancel:isValidate()
  self._ui.btn_Save:isValidate()
  self._ui.btn_Inven:isValidate()
  self._ui.stc_Console_Buttons:isValidate()
  self._ui.btn_Console_UnEquip:isValidate()
  self._ui.btn_Console_Select:isValidate()
  self._ui.btn_Console_Close:isValidate()
  self._ui.btn_Console_Detail:isValidate()
  self._ui.btn_Console_Scroll:isValidate()
  self._ui.Frame_Tooltip:isValidate()
  self._ui.Frame_Tooltip_Content:isValidate()
  self._ui.Frame_Tooltip_VerticalScroll:isValidate()
  self._ui.txt_Tooltip_Title:isValidate()
  self._ui.txt_Tooltip_NoCrystal:isValidate()
  self._ui.stc_Tooltip_CrystalGroupName:isValidate()
  self._ui.stc_Tooltip_CrystalBg:isValidate()
  self._ui.txt_Tooltip_CrystalDesc:isValidate()
  self._ui.txt_Tooltip_CrystalName:isValidate()
  self._ui.stc_Tooltip_CrystalIcon:isValidate()
end
