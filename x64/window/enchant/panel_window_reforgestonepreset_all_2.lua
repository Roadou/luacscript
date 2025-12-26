function FromClient_ReforgeStonePreset_All_UpdateList2MatItem(content, key)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  local itemKey = Int64toInt32(key)
  if self._reforgeStoneList[itemKey] == nil then
    return
  end
  local btn_list = UI.getChildControl(content, "CheckButton_ItemSkill_Templete")
  local itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local stc_ItemName = UI.getChildControl(btn_list, "StaticText_Item_Name")
  local stc_SkillText = UI.getChildControl(btn_list, "StaticText_Item_Effect")
  local btn_Add = UI.getChildControl(btn_list, "Button_AddItem")
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "ReforgeStoneItemIcon_", 0, itemSlotBg, self._slotConfig)
  itemSlot:clearItem()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, 0))
  if itemSSW == nil then
    return
  end
  itemSlot:setItemByStaticStatus(itemSSW)
  stc_ItemName:SetText(itemSSW:getName())
  stc_ItemName:SetIgnore(true)
  stc_SkillText:SetTextMode(__eTextMode_LimitText)
  stc_SkillText:SetText(self:getSkillTextByItemKey(itemKey))
  btn_list:SetMonoTone(false)
  btn_list:SetCheck(false)
  btn_list:SetIgnore(false)
  btn_Add:SetShow(false)
  btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_SetReforgeStoneToPreset(" .. tostring(itemKey) .. ")")
  itemSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_SetReforgeStoneToPreset(" .. tostring(itemKey) .. ")")
  itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_ShowToolTip(" .. tostring(itemKey) .. ", true, false)")
  itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_ShowToolTip(" .. tostring(itemKey) .. ",false, false)")
  if self._isConsole == true then
    itemSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ReforgeStonePreset_All_ShowToolTip(" .. tostring(itemKey) .. ", true, true)")
  end
  if self._reforgeStoneList[itemKey]._state == __eReforgeStoneState_Activated then
    btn_list:SetCheck(true)
  elseif self._reforgeStoneList[itemKey]._state == __eReforgeStoneState_InBag then
  elseif self._reforgeStoneList[itemKey]._slotNo ~= -1 then
    btn_list:SetMonoTone(true)
    btn_Add:SetShow(true)
    btn_Add:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_AddReforgeStoneToBag(" .. tostring(itemKey) .. ")")
    btn_Add:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_AddButtonToolTip(" .. tostring(itemKey) .. ",true)")
    btn_Add:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_AddButtonToolTip(" .. tostring(itemKey) .. ",false)")
    btn_Add:SetMonoTone(false)
  else
    btn_list:SetMonoTone(true)
  end
end
function FromClient_ReforgeStonePreset_All_UpdateReforgeStoneBag()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  self:updateReforgeStoneList(true)
  self:updateReforgeSlotApplyActiveCountAll()
end
function FromClient_ReforgeStonePreset_All_UpdateCurrentActivatedList(showMessage)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  self:updateCurrentActivatedList()
  self:updateReforgeStoneList(true)
  if self._currentReforgeStoneListType ~= self._reforgeStoneListType.total then
    self:refreshReforgeStoneListKey()
  end
  if showMessage == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_PRESETCOMPLETE"))
  end
  self:addActiveEffect()
end
function FromClient_ReforgeStonePreset_All_AddActivateEffect(index, isActive)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  self:addActiveEffect(index, isActive)
end
function FromClient_ReforgeStonePreset_All_ClearPreset()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  ToClient_SetCurrentActivatedReforgeStone(self._currentPresetNo, self._currentSlotType)
  self:updateCurrentActivatedList()
  self:updateReforgeStoneList(true)
  if self._currentReforgeStoneListType ~= self._reforgeStoneListType.total then
    self:refreshReforgeStoneListKey()
  end
end
function FromClient_ReforgeStonePreset_All_UpdateReforgeSlot()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  self:updateReforgeSlotControls()
end
function FromClient_ReforgeStonePreset_All_UpdateReforgeStonePresetNo(presetNo)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if presetNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_PRESETCANCEL"))
  else
    local presetName = ToClient_GetReforgeStonePresetName(presetNo)
    if presetName == nil or presetName == "" then
      presetName = tostring(presetNo + 1)
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOTKEY_PRESETALERT", "presetName", presetName))
  end
  self:updateBottomButtons()
  self:updateCurrentReforgeStonePresetName()
end
function FromClient_ReforgeStonePreset_All_UpdatePresetName(presetNo, presetName)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if presetName == nil or presetName == "" then
    presetName = tostring(presetNo + 1)
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTAL_PRESET_NAME_CONFIRM", "name", presetName))
  self:updateReforgeStonePresetButtonName()
  self:updateCurrentReforgeStonePresetName()
  PaGlobal_TotalPreset_UpdatePreset()
end
function HandleEventLUp_ReforgeStonePreset_All_SetReforgeStoneToPreset(itemKey)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  local stoneInfo = self._reforgeStoneList[itemKey]
  if stoneInfo == nil then
    return
  end
  if stoneInfo._state == __eReforgeStoneState_InBag then
    ToClient_AddCurrentActivatedReforgeStone(self._currentSlotType, itemKey)
  elseif stoneInfo._state == __eReforgeStoneState_Activated then
    ToClient_RemoveCurrentActivatedReforgeStone(self._currentSlotType, itemKey)
  elseif self._isConsole == true and self._reforgeStoneList[itemKey]._slotNo ~= -1 then
    HandleEventLUp_ReforgeStonePreset_All_AddReforgeStoneToBag(itemKey)
  elseif self._reforgeStoneList[itemKey]._slotNo == -1 and ToClient_isConsole() == false then
    local mainIndex, subIndex = PaGlobalFunc_ItemAcquireHelper_FindItemMarketCategoryIndex(30, 3)
    PaGlobal_ItemAcquireHelper_SetItemMarketData(mainIndex, subIndex, PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_GOTOITEMMARKET"))
  end
end
function HandleEventLUp_ReforgeStonePreset_All_RemoveCurrentActivated(slotIndex)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  local itemKey = ToClient_GetCurrentActivatedReforgeStoneByIndex(slotIndex)
  if itemKey == 0 then
    return
  end
  local stoneInfo = self._reforgeStoneList[itemKey]
  if stoneInfo == nil then
    return
  end
  if stoneInfo._state == __eReforgeStoneState_Activated then
    ToClient_RemoveCurrentActivatedReforgeStone(self._currentSlotType, itemKey)
  end
end
function HandleEventLUp_ReforgeStonePreset_All_AddReforgeStoneToBag(itemKey)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if self._reforgeStoneList[itemKey] == nil then
    return
  end
  local slotNo = self._reforgeStoneList[itemKey]._slotNo
  if slotNo == -1 then
    return
  end
  local function addReforgeStoneToBag()
    ToClient_RequestAddReforgeStoneToBag(slotNo, self._currentSlotType)
  end
  weaponTypeText = ""
  if self._currentSlotType == __eReforgeStoneSlotType_MainWeapon then
    weaponTypeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_MAINWEAPON")
  elseif self._currentSlotType == __eReforgeStoneSlotType_AwakenWeapon then
    weaponTypeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_AWAKENWEAPON")
  elseif self._currentSlotType == __eReforgeStoneSlotType_SubWeapon then
    weaponTypeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_SUBWEAPON")
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_ADDSTONE_TOOLTIP"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_REGIST", "weapontype", weaponTypeText),
    functionApply = addReforgeStoneToBag,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function HandleEventLUp_ReforgeStonePreset_All_ChangeReforgeStoneListType(type)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  self._currentReforgeStoneListType = type
  self:refreshReforgeStoneListKey()
end
function HandleEventOnOut_ReforgeStonePreset_All_ShowToolTip(itemKey, isShow, consoleTrigger)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    if self._isConsole == true then
      self._currentSnapItemKey = nil
      self:updateConsoleAKeyText()
    end
    Panel_Tooltip_Item_hideTooltip()
    if Panel_Tooltip_SimpleText:GetShow() == true then
      TooltipSimple_Hide()
    end
    return
  end
  if self._isConsole == true then
    self._currentSnapItemKey = itemKey
    self:updateConsoleAKeyText()
    if consoleTrigger == true and isPadPressed(__eJoyPadInputType_LeftTrigger) == false then
      self:changeConsoleTooltipShow()
    end
    if self._consoleTooltip == false then
      return
    end
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemWrapper == nil then
    return
  end
  local content = self._ui.list_ReforgeStone:GetContentByKey(toInt64(0, itemKey))
  if content == nil then
    return
  end
  local btn_list = UI.getChildControl(content, "CheckButton_ItemSkill_Templete")
  local itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  if _ContentsGroup_RenewUI_Tooltip == false then
    Panel_Tooltip_Item_Show(itemWrapper, itemSlotBg, true, false)
  else
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
  local stc_ItemName = UI.getChildControl(btn_list, "StaticText_Item_Name")
  if stc_ItemName:IsLimitText() == true then
    TooltipSimple_Show(stc_ItemName, itemWrapper:getName())
  end
end
function HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(slotIndex, isShow, consoleTrigger)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if self._isConsole == true then
    self._currentSnapSlotIndex = nil
    self._currentSnapItemKey = nil
    self:updateConsoleAKeyText()
  end
  if isShow == nil or isShow == false or self._ui.currentActivatedList[slotIndex] == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemKey = ToClient_GetCurrentActivatedReforgeStoneByIndex(slotIndex)
  if itemKey == 0 then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemWrapper == nil then
    return
  end
  if self._isConsole == true then
    self._currentSnapSlotIndex = slotIndex
    self._currentSnapItemKey = itemKey
    self:updateConsoleAKeyText()
    if consoleTrigger == true and isPadPressed(__eJoyPadInputType_LeftTrigger) == false then
      self:changeConsoleTooltipShow()
    end
    if self._consoleTooltip == false then
      return
    end
  end
  if _ContentsGroup_RenewUI_Tooltip == false then
    Panel_Tooltip_Item_Show(itemWrapper, self._ui.currentActivatedList[slotIndex], true, false)
  else
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_ReforgeStonePreset_All_ReforgeSlotItemToolTip(slotIndex, isShow, consoleTrigger)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if isShow == nil or isShow == false or self._ui.reforgeSlotList[slotIndex] == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if self._isConsole == true then
    if consoleTrigger == true and isPadPressed(__eJoyPadInputType_LeftTrigger) == false then
      self:changeConsoleTooltipShow()
    end
    if self._consoleTooltip == false then
      return
    end
  end
  local itemWrapper = ToClient_getEquipmentItem(self._reforgeSlotTypeToEquipSlotNo[slotIndex])
  if itemWrapper == nil then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil or itemSSW:get():getContentsEventType() ~= __eContentsType_ItemSkillOption then
    return
  end
  local stc_ItemSlot = UI.getChildControl(self._ui.reforgeSlotList[slotIndex], "Static_ItemSlot")
  if stc_ItemSlot == nil then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip == false then
    Panel_Tooltip_Item_Show(itemSSW, stc_ItemSlot, true, false)
  else
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentPresetNo(presetNo)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if presetNo == nil or self._currentPresetNo == presetNo then
    return
  end
  if self._needSave == true then
    PaGlobalFunc_ReforgeStonePreset_AskNoSaveReforgeStonePreset(presetNo, nil)
    return
  end
  self._currentPresetNo = presetNo
  ToClient_SetCurrentActivatedReforgeStone(self._currentPresetNo, self._currentSlotType)
  self:updateCurrentActivatedList()
  self:updateReforgeStonePresetButtons()
  self:updateReforgeStoneList(true)
  if self._currentReforgeStoneListType ~= self._reforgeStoneListType.total then
    self:refreshReforgeStoneListKey()
  end
  self:updateReforgeSlotControls()
  self:updateReforgeSlotApplyActiveCountAll()
end
function HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentSlotType(slotType)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if slotType == nil or self._currentSlotType == slotType then
    return
  end
  if self._needSave == true then
    PaGlobalFunc_ReforgeStonePreset_AskNoSaveReforgeStonePreset(nil, slotType)
    return
  end
  self._currentSlotType = slotType
  ToClient_SetCurrentActivatedReforgeStone(self._currentPresetNo, self._currentSlotType)
  self:updateCurrentActivatedList()
  self:updateReforgeStoneList(true)
  if self._currentReforgeStoneListType ~= self._reforgeStoneListType.total then
    self:refreshReforgeStoneListKey()
  end
  self:updateReforgeSlotControls()
  self:addReforgeSlotSelectEffect()
end
function HandleEventLUp_ReforgeStonePreset_All_SaveCurrentActiveList()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  ToClient_RequestSetReforgeStonePresetActiveList(self._currentPresetNo, self._currentSlotType)
end
function HandleEventLUp_ReforgeStonePreset_All_ApplyCurrentPreset()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if self._currentPresetNo == ToClient_GetCurrentReforgeStonePresetNo() then
    ToClient_RequestSetReforgeStoneCharacterPresetNo(-1)
  else
    ToClient_RequestSetReforgeStoneCharacterPresetNo(self._currentPresetNo)
  end
end
function HandleEventLUp_ReforgeStonePreset_All_ClearCurrentPreset()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  local function clearReforgeStonePreset()
    ToClient_RequestClearReforgeStonePreset(self._currentPresetNo)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOTALPRESET_RESET"),
    functionApply = clearReforgeStonePreset,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_ReforgeStonePreset_Open()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if Panel_Window_ReforgeStonePreset_All:GetShow() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobal_ReforgeStonePreset_Close()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
    return
  end
  if self._needSave == true then
    PaGlobalFunc_ReforgeStonePreset_AskNoSaveReforgeStonePreset(nil, nil)
    return
  end
  self:prepareClose()
end
function PaGlobal_ReforgeStonePreset_GetShow()
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  return Panel_Window_ReforgeStonePreset_All:GetShow()
end
function PaGlobalFunc_ReforgeStonePreset_AskNoSaveReforgeStonePreset(presetNo, slotType)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  local function closeReforgeStonePreset()
    self._ui.btn_Save:SetMonoTone(true)
    self._ui.btn_Save:SetIgnore(true)
    self._needSave = false
    PaGlobal_ReforgeStonePreset_Close()
  end
  local function selectReforgeStonePreset()
    self._ui.btn_Save:SetMonoTone(true)
    self._ui.btn_Save:SetIgnore(true)
    self._needSave = false
    HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentPresetNo(presetNo)
  end
  local function selectReforgeStoneSlotType()
    self._ui.btn_Save:SetMonoTone(true)
    self._ui.btn_Save:SetIgnore(true)
    self._needSave = false
    HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentSlotType(slotType)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOTALPRESET_SAVE"),
    functionApply = HandleEventLUp_ReforgeStonePreset_All_SaveCurrentActiveList,
    functionNo = closeReforgeStonePreset,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if presetNo ~= nil then
    messageData.functionNo = selectReforgeStonePreset
  elseif slotType ~= nil then
    messageData.functionNo = selectReforgeStoneSlotType
  end
  MessageBox.showMessageBox(messageData)
end
function HandleEventOnOut_ReforgeStonePreset_All_WeaponToolTip(isShow)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOOLTIP")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOOLTIP_DESC")
  TooltipSimple_Show(self._ui.stc_WeaponTooltip, title, desc, false)
end
function HandleEventOnOut_ReforgeStonePreset_All_AddButtonToolTip(itemKey, isShow)
  local self = PaGlobal_ReforgeStonePreset
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local content = self._ui.list_ReforgeStone:GetContentByKey(toInt64(0, itemKey))
  if content == nil then
    return
  end
  local btn_list = UI.getChildControl(content, "CheckButton_ItemSkill_Templete")
  local btn_Add = UI.getChildControl(btn_list, "Button_AddItem")
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_ADDSTONE_TOOLTIP")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_ADDSTONE_TOOLTIP_DESC")
  TooltipSimple_Show(btn_Add, title, desc, false)
end
