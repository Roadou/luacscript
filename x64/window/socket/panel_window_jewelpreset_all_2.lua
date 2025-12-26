function PaGlobalFunc_JewelPreset_Open(presetNo)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  if PaGlobalFunc_JewelPreset_IsShow() == true then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    return
  end
  self:prepareOpen(presetNo)
end
function PaGlobalFunc_JewelPreset_Close()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_JewelPreset_IsShow()
  if Panel_Window_JewelPreset_All == nil then
    return false
  end
  return Panel_Window_JewelPreset_All:GetShow()
end
function PaGlobalFunc_JewelPreset_PopJewel(slotNo)
  PaGlobal_JewelPreset:popJewel(slotNo)
end
function PaGlobalFunc_JewelPreset_ShowJewelToolTip(isShow, slotNo)
  if Panel_Window_JewelPreset_All == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    if PaGlobal_JewelPreset._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if slotNo == nil then
    return
  end
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
  if jewelItemSSW == nil then
    return
  end
  local slot = PaGlobal_JewelPreset._jewelSlot[slotNo]
  if slot == nil then
    return
  end
  if PaGlobal_JewelPreset._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, jewelItemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(jewelItemSSW, slot.icon, true, false)
  end
end
function PaGlobalFunc_JewelPreset_ShowJewelLockedTooltip(isShow, slotNo)
  if isShow == nil or slotNo == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_JewelPreset._jewelSlotList[slotNo]
  if control == nil then
    return
  end
  local jewelLock = UI.getChildControl(control, "Static_Lock")
  if jewelLock == nil then
    return
  end
  if PaGlobal_JewelPreset._lockSlotTooltip[slotNo] == nil then
    _PA_ASSERT(false, "\236\136\152\236\160\149 \236\138\172\235\161\175(" .. tostring(slotNo) .. ")\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. _lockSlotTooltip\236\151\144 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.")
    return
  end
  local name = PaGlobal_JewelPreset._lockSlotTooltip[slotNo]._name
  local desc = PaGlobal_JewelPreset._lockSlotTooltip[slotNo]._desc
  TooltipSimple_Show(jewelLock, name, desc)
end
function PaGlobalFunc_JewelPreset_ShowPleaseSelectTabMsg()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_MESSAGEBOXALERT_1"), nil, nil, nil, nil, true)
end
function PaGlobalFunc_JewelPreset_SelectPreset(presetNo)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if self._ui.btn_Save:GetShow() == true then
    PaGlobalFunc_JewelPreset_AskNoSaveJewelPreset(presetNo, false)
    return
  end
  ToClient_SetSelectedJewelPresetInfo(presetNo)
  self._selectJewelPresetNo = presetNo
  self:update(presetNo)
end
function PaGlobalFunc_JewelPreset_ShowEditTooltip(isShow)
  if isShow == nil then
    return
  end
  if PaGlobal_JewelPreset._ui.btn_Edit == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_EDITBTN_TOOLTIP")
  TooltipSimple_Show(PaGlobal_JewelPreset._ui.btn_Edit, desc)
end
function PaGlobalFunc_JewelPreset_ApplyJewelPreset(applyPreset)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._applyPreset = applyPreset
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  if isSafeZone == false then
    ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_JewelPresetChange, 0)
    return
  end
  if self._applyPreset == true then
    ToClient_ChangeJewelPreset(self._selectJewelPresetNo)
    audioPostEvent_SystemUi(5, 89)
    _AudioPostEvent_SystemUiForXBOX(5, 89)
  else
    ToClient_ChangeJewelPreset(__eJewelNotActivatingPresetNo)
  end
end
function PaGlobalFunc_JewelPreset_ApplyJewelPresetByShortcuts(presetNo)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if presetNo >= ToClient_GetJewelPresetCount() then
    return
  end
  if self._progressBarActive == true then
    return
  end
  local currentJewelPresetNo = ToClient_GetCurrentJewelPresetNo()
  if currentJewelPresetNo == presetNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_JEWELPRESET_ALREADY_SET"))
    return
  end
  if self._ui.btn_Save:GetShow() == true then
    PaGlobalFunc_JewelPreset_AskNoSaveJewelPreset(presetNo, true)
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self._applyPreset = true
  self._selectJewelPresetNo = presetNo
  self._applyProgressJewelPresetNo = presetNo
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  if isSafeZone == false then
    ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_JewelPresetChange, 0)
    return
  end
  ToClient_ChangeJewelPreset(presetNo)
end
function PaGlobalFunc_JewelPreset_SetProgressBarActive(isProgressBarActive)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._progressBarActive = isProgressBarActive
end
function PaGlobalFunc_JewelPreset_SaveJewel()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  local isCurrentPreset = PaGlobal_JewelPreset._selectJewelPresetNo == ToClient_GetCurrentJewelPresetNo()
  if isSafeZone == true or isCurrentPreset == false then
    ToClient_ApplyJewelChanges(PaGlobal_JewelPreset._selectJewelPresetNo)
  else
    ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_JewelChange, 0)
  end
  audioPostEvent_SystemUi(5, 89)
  _AudioPostEvent_SystemUiForXBOX(5, 89)
end
function PaGlobalFunc_JewelPreset_judgeJewelSlotChange(presetNo)
  if presetNo == __eJewelNotActivatingPresetNo then
    return false
  end
  for slotNo = 0, __eJewelSlotMaxCount - 1 do
    local beforeJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
    local afterJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
    if beforeJewelItemSSW ~= nil and afterJewelItemSSW ~= nil then
      local beforeItemKey = beforeJewelItemSSW:getItemKey()
      local afterItemKey = afterJewelItemSSW:getItemKey()
      if beforeItemKey ~= afterItemKey then
        return true
      end
    elseif beforeJewelItemSSW == nil and afterJewelItemSSW == nil then
    else
      return true
    end
  end
  return false
end
function PaGlobalFunc_JewelPreset_judgeJewelChanges()
  if presetNo == __eJewelNotActivatingPresetNo then
    return false
  end
  local beforeJewelKeyList = {}
  local afterJewelKeyList = {}
  local beforeJewelKeyListCount = 0
  local afterJewelKeyListCount = 0
  for slotNo = 0, __eJewelSlotMaxCount - 1 do
    local beforeJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(PaGlobal_JewelPreset._selectJewelPresetNo, slotNo)
    if beforeJewelItemSSW ~= nil then
      local itemKey = beforeJewelItemSSW:getItemKey()
      beforeJewelKeyList[beforeJewelKeyListCount] = itemKey
      beforeJewelKeyListCount = beforeJewelKeyListCount + 1
    end
    local afterJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
    if afterJewelItemSSW ~= nil then
      local itemKey = afterJewelItemSSW:getItemKey()
      afterJewelKeyList[afterJewelKeyListCount] = itemKey
      afterJewelKeyListCount = afterJewelKeyListCount + 1
    end
  end
  local beforeCount = beforeJewelKeyListCount
  local afterCount = afterJewelKeyListCount
  for beforeNum = 0, beforeCount - 1 do
    for afterNum = 0, afterCount - 1 do
      if beforeJewelKeyList[beforeNum] ~= nil and afterJewelKeyList[afterNum] ~= nil then
        local beforeJewelKey = beforeJewelKeyList[beforeNum]
        local afterJewelKey = afterJewelKeyList[afterNum]
        if beforeJewelKey == afterJewelKey then
          beforeJewelKeyList[beforeNum] = nil
          afterJewelKeyList[afterNum] = nil
          beforeJewelKeyListCount = beforeJewelKeyListCount - 1
          afterJewelKeyListCount = afterJewelKeyListCount - 1
        end
      end
    end
  end
  if beforeJewelKeyListCount > 0 or afterJewelKeyListCount > 0 then
    return true
  else
    return false
  end
end
function PaGlobalFunc_JewelPreset_ShowInvenTooltip(isShow)
  if isShow == nil then
    return
  end
  if PaGlobal_JewelPreset._ui.btn_Inven == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_INVENBTN_TOOLTIPNAME")
  TooltipSimple_Show(PaGlobal_JewelPreset._ui.btn_Inven, desc, nil, false)
end
function PaGlobalFunc_JewelPreset_PushJewel(stringJewelNo)
  if PaGlobal_JewelPreset._selectedJewelSlot == -1 then
    return
  end
  local jewelNo = tonumber(stringJewelNo)
  PaGlobal_JewelPreset:pushJewel(jewelNo)
  PaGlobalFunc_JewelInven_Close()
end
function PaGlobalFunc_JewelPreset_OpenJewelInven(isOpenFromInventory)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if Panel_Window_Extraction_All ~= nil and Panel_Window_Extraction_All:GetShow() == true then
    HandleEventLUp_Extraction_All_Button_ExtractionCrystal_Click()
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    if PaGlobalFunc_Inventory_All_SetShow ~= nil then
      PaGlobalFunc_Inventory_All_SetShow(true)
    end
    if Panel_Window_Inventory_All ~= nil and Panel_Npc_Dialog_All ~= nil and isOpenFromInventory == false then
      Panel_Window_Inventory_All:SetPosY((getScreenSizeY() - Panel_Npc_Dialog_All:GetSizeY() - Panel_Window_Inventory_All:GetSizeY()) * 0.5)
    end
  elseif PaGlobalFunc_InventoryInfo_Open ~= nil then
    PaGlobalFunc_InventoryInfo_Open(1, false, 0, false)
  end
  if PaGlobalFunc_JewelInven_Open ~= nil then
    PaGlobalFunc_JewelInven_Open(JewelInvenMode.InventoryMode)
    PaGlobalFunc_JewelPreset_Close()
  end
  self._selectedJewelSlot = -1
end
function PaGlobalFunc_JewelPreset_CloseWithESC()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if Panel_Window_JewelPreset_All == nil or Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
    return
  end
  if PaGlobal_JewelInven._isPadSnapping == true then
    if PaGlobal_InventoryEquip_Detail_Renew_Close ~= nil and Panel_Window_Inventory_Detail ~= nil and Panel_Window_Inventory_Detail:GetShow() == true then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
      return
    end
    if Panel_Window_TrashBoxConfirm_All ~= nil and Panel_Window_TrashBoxConfirm_All:GetShow() == true and PaGlobalFunc_TrashBoxConfirm_All_Close ~= nil then
      PaGlobalFunc_TrashBoxConfirm_All_Close()
      return
    end
    if Panel_Window_WebPurchaseConfirm_All ~= nil and Panel_Window_WebPurchaseConfirm_All:GetShow() == true and PaGlobalFunc_WebPurchaseConfirm_All_Close ~= nil then
      PaGlobalFunc_WebPurchaseConfirm_All_Close()
      return
    end
  end
  if PaGlobal_JewelInven._jewelInvenMode == JewelInvenMode.ExtractMode and PaGlobalFunc_JewelInven_Close ~= nil and PaGlobalFunc_JewelInven_IsShow() == true then
    PaGlobalFunc_JewelInven_Close()
    return
  end
  if PaGlobalFunc_JewelInven_IsShow ~= nil and PaGlobalFunc_JewelInven_IsShow() == true then
    if PaGlobal_JewelInven._isOpenFromInventory == true then
      if false == PaGlobal_JewelInven._isPadSnapping then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetShow(true)
        else
          Equipment_SetShow(true)
        end
      end
      PaGlobalFunc_JewelPreset_OpenJewelInven(true)
      PaGlobalFunc_JewelInven_Close()
      PaGlobalFunc_JewelInven_IsOpenFromInventory(false)
      Inventory_SetFunctor(nil, nil, nil, nil)
      return
    end
    PaGlobalFunc_JewelPreset_Open(self._selectedJewelSlot)
    PaGlobalFunc_JewelInven_Close()
    if self._isPadSnapping == true then
      PaGlobalFunc_InventoryInfo_Close()
    else
      PaGlobalFunc_Inventory_All_SetShow(false)
    end
    if self._isPadSnapping == true then
      local slotControl = self._jewelSlotList[self._selectedJewelSlotForPadControl]
      if slotControl ~= nil then
        ToClient_padSnapChangeToTarget(slotControl)
      end
    end
    return
  end
  if self._ui.btn_Save:GetShow() == true then
    PaGlobalFunc_JewelPreset_AskNoSaveJewelPreset()
    return
  end
  if Panel_Window_JewelPreset_All:GetShow() == true then
    PaGlobalFunc_JewelPreset_Close()
    if dialog_isTalking() == true then
      HandleEventLUp_DialogMain_All_BackClick()
    end
    return
  end
end
function PaGlobalFunc_JewelInven_SelectJewelSlot(slotNo)
  PaGlobal_JewelPreset._selectedJewelSlot = slotNo
  PaGlobal_JewelPreset._selectedJewelSlotForPadControl = slotNo
  if ToClient_GetJewelListSize() == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_MESSAGEBOXALERT_2"), nil, nil, nil, nil, true)
  else
    PaGlobalFunc_JewelInven_Open(JewelInvenMode.PushOrPopMode)
    PaGlobalFunc_JewelPreset_Close()
  end
end
function PaGlobalFunc_JewelPreset_SelectPresetInConsole(isLeft)
  if isLeft == true then
    PaGlobal_JewelPreset._selectJewelPresetNo = PaGlobal_JewelPreset._selectJewelPresetNo - 1
  else
    PaGlobal_JewelPreset._selectJewelPresetNo = PaGlobal_JewelPreset._selectJewelPresetNo + 1
  end
  if PaGlobal_JewelPreset._selectJewelPresetNo < 0 then
    PaGlobal_JewelPreset._selectJewelPresetNo = 0
  end
  local jewelPresetCount = ToClient_GetJewelPresetCount()
  if jewelPresetCount <= PaGlobal_JewelPreset._selectJewelPresetNo then
    PaGlobal_JewelPreset._selectJewelPresetNo = jewelPresetCount - 1
  end
  PaGlobalFunc_JewelPreset_SelectPreset(PaGlobal_JewelPreset._selectJewelPresetNo)
end
function PaGlobalFunc_JewelPreset_UpdateConsoleButtons(state)
  if PaGlobal_JewelPreset._isPadSnapping == false then
    return
  end
  local keyGuideList = {}
  PaGlobal_JewelPreset._ui.btn_Console_UnEquip:SetShow(false)
  PaGlobal_JewelPreset._ui.btn_Console_Select:SetShow(false)
  PaGlobal_JewelPreset._ui.btn_Console_Close:SetShow(false)
  PaGlobal_JewelPreset._ui.btn_Console_Detail:SetShow(false)
  PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(false)
  if state == 1 then
    PaGlobal_JewelPreset._ui.btn_Console_Select:SetShow(true)
    PaGlobal_JewelPreset._ui.btn_Console_Close:SetShow(true)
    if PaGlobal_JewelPreset._conetneSizeY > PaGlobal_JewelPreset._ui.Frame_Tooltip:GetSizeY() then
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(true)
    else
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(false)
    end
    keyGuideList = {
      PaGlobal_JewelPreset._ui.btn_Console_Scroll,
      PaGlobal_JewelPreset._ui.btn_Console_Select,
      PaGlobal_JewelPreset._ui.btn_Console_Close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_JewelPreset._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  elseif state == 2 then
    PaGlobal_JewelPreset._ui.btn_Console_UnEquip:SetShow(true)
    PaGlobal_JewelPreset._ui.btn_Console_Detail:SetShow(true)
    PaGlobal_JewelPreset._ui.btn_Console_Close:SetShow(true)
    if PaGlobal_JewelPreset._conetneSizeY > PaGlobal_JewelPreset._ui.Frame_Tooltip:GetSizeY() then
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(true)
    else
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(false)
    end
    keyGuideList = {
      PaGlobal_JewelPreset._ui.btn_Console_Scroll,
      PaGlobal_JewelPreset._ui.btn_Console_UnEquip,
      PaGlobal_JewelPreset._ui.btn_Console_Detail,
      PaGlobal_JewelPreset._ui.btn_Console_Close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_JewelPreset._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  elseif state == 3 then
    PaGlobal_JewelPreset._ui.btn_Console_Detail:SetShow(true)
    PaGlobal_JewelPreset._ui.btn_Console_Close:SetShow(true)
    if PaGlobal_JewelPreset._conetneSizeY > PaGlobal_JewelPreset._ui.Frame_Tooltip:GetSizeY() then
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(true)
    else
      PaGlobal_JewelPreset._ui.btn_Console_Scroll:SetShow(false)
    end
    keyGuideList = {
      PaGlobal_JewelPreset._ui.btn_Console_Scroll,
      PaGlobal_JewelPreset._ui.btn_Console_Detail,
      PaGlobal_JewelPreset._ui.btn_Console_Close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_JewelPreset._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobalFunc_JewelPreset_SaveJewelPresetConsole(str)
  PaGlobal_JewelPreset._ui.edit_PresetName:SetEditText(str)
  PaGlobal_JewelPreset:savePresetName()
end
function PaGlobalFunc_JewelPreset_ShowLockPresetTooltip(presetNo, isShow)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local content = self._ui.list_preset:GetContentByKey(presetNo)
  local maxPresetCount = tonumber(ToClient_GetJewelPresetMaxCount())
  local questCount = 1
  local mileCount = 1
  local pearlCount = maxPresetCount - questCount - mileCount - __eJewelSlotDefaultCount
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_RADIOLOCKICONTOOLTIP_NAME")
  local desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_RADIOLOCKICONTOOLTIP_DESC", "maxCount", maxPresetCount, "questCount", questCount, "mileCount", mileCount, "pearlCount", pearlCount)
  TooltipSimple_Show(content, name, desc)
end
function PaGlobalFunc_JewelPreset_BuyPresetIncreaseItem()
  local maxPresetCount = tonumber(ToClient_GetJewelPresetMaxCount())
  local questCount = 1
  local mileCount = 1
  local pearlCount = maxPresetCount - questCount - mileCount - __eJewelSlotDefaultCount
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_RADIOLOCKICONTOOLTIP_DESC", "maxCount", maxPresetCount, "questCount", questCount, "mileCount", mileCount, "pearlCount", pearlCount),
    functionApply = PaGlobalFunc_JewelPreset_ConfirmMessageBox,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobalFunc_JewelPreset_ConfirmMessageBox()
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self:confirmMessageBox()
end
function PaGlobalFunc_JewelPreset_SetBlockBg(isBlock)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  if self._ui.stc_blockBg ~= nil then
    if isBlock == true then
      self._ui.stc_blockBg:SetShow(true)
      self._ui.stc_blockBg:SetIgnore(false)
    else
      self._ui.stc_blockBg:SetShow(false)
      self._ui.stc_blockBg:SetIgnore(true)
    end
  end
end
function PaGlobalFunc_JewelPreset_ClickSaveButton()
  local isJewelChanges = PaGlobalFunc_JewelPreset_judgeJewelChanges()
  if isJewelChanges == true then
    PaGlobalFunc_MessageBox_CrystalSet_All_Open()
  else
    PaGlobalFunc_JewelPreset_SaveJewel()
  end
end
function PaGlobalFunc_JewelPreset_CreateControlJewelPresetList(contents, key)
  local self = PaGlobal_JewelPreset
  if nil == self then
    return
  end
  local idx = Int64toInt32(key)
  local radioButton_template = UI.getChildControl(contents, "RadioButton_Template")
  local lockSlot_template = UI.getChildControl(contents, "Static_LockSlot_Template")
  local txt_PresetName = UI.getChildControl(radioButton_template, "StaticText_PresetName")
  if idx < ToClient_GetJewelPresetCount() then
    lockSlot_template:SetShow(false)
    lockSlot_template:SetIgnore(true)
    radioButton_template:SetShow(true)
    radioButton_template:SetIgnore(false)
    radioButton_template:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_SelectPreset(" .. idx .. ")")
    if self._isPadSnapping == true then
      radioButton_template:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 1 .. ")")
    end
    local presetNo = tostring(idx + 1)
    local shortcutsID = "PANEL_HOTKEY_PRESETNAME_" .. presetNo
    local func = "PaGlobalFunc_JewelPreset_ApplyJewelPresetByShortcuts(" .. idx .. ")"
    radioButton_template:setButtonShortcutsWithEvent(func, shortcutsID)
    local presetName = ToClient_GetJewelPresetName(idx)
    if presetName == nil then
      presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", idx + 1)
    end
    txt_PresetName:SetText(presetName)
    txt_PresetName:SetShow(true)
  else
    radioButton_template:SetShow(false)
    radioButton_template:SetIgnore(true)
    lockSlot_template:SetShow(true)
    lockSlot_template:SetIgnore(false)
    lockSlot_template:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_BuyPresetIncreaseItem()")
    lockSlot_template:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_ShowLockPresetTooltip(" .. idx .. ", true)")
    lockSlot_template:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelPreset_ShowLockPresetTooltip(" .. idx .. ", false)")
    if self._isPadSnapping == true then
      lockSlot_template:addInputEvent("Mouse_On", "PaGlobalFunc_JewelPreset_UpdateConsoleButtons(" .. 1 .. ")")
    end
  end
end
function PaGlobalFunc_JewelPreset_AskNoSaveJewelPreset(presetNo, isApply)
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  local function closeJewelPreset()
    self._ui.btn_Save:SetShow(false)
    PaGlobalFunc_JewelPreset_CloseWithESC()
  end
  local function selectJewelPreset()
    self._ui.btn_Save:SetShow(false)
    PaGlobalFunc_JewelPreset_SelectPreset(presetNo)
  end
  local function applyJewelPreset()
    self._ui.btn_Save:SetShow(false)
    PaGlobalFunc_JewelPreset_ApplyJewelPresetByShortcuts(presetNo)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_JEWEL_OUTPAGE_WARNING_DESC"),
    functionApply = PaGlobalFunc_JewelPreset_ClickSaveButton,
    functionNo = closeJewelPreset,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if presetNo ~= nil then
    if isApply == true then
      messageData.functionNo = applyJewelPreset
    else
      messageData.functionNo = selectJewelPreset
      self:updateJewelRadioButton()
    end
  end
  MessageBox.showMessageBox(messageData)
end
function FromClient_CheckChinaProhibitedWord_SetJewelPresetName(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_JewelPreset
  if self == nil then
    return
  end
  self._ui.edit_PresetName:RegistReturnKeyEvent("PaGlobal_JewelPreset:savePresetName()")
  if isPass == true then
    self._ui.edit_PresetName:SetShow(false)
    self._ui.txt_PresetName:SetShow(true)
    self._ui.txt_AdjustName:SetShow(true)
    ToClient_SaveJewelPresetName(self._selectJewelPresetNo, filteredText)
    if self._isPadSnapping == true then
      self._ui.stc_Console_PresetGuide:SetShow(true)
      ToClient_padSnapChangeToTarget(Panel_Window_JewelPreset_All)
    end
  end
end
