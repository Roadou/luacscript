function HandleEventLUp_Restore_All_Close()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:prepareClose()
end
function PaGlobalFunc_Restore_All_Open()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:prepareOpen(__eRestoreItemType_InGame)
end
function HandleEventLUp_Restore_All_RestoreItem()
  if nil == PaGlobal_Restore_All._selectSlotNo then
    return
  end
  local itemName = MakeUpItemNameWithEnchantLevel(PaGlobal_Restore_All._restoreType, PaGlobal_Restore_All._selectSlotNo)
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_TITLE")
  local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_CONTENT", "itemName", itemName)
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = RestoreItem_Yes,
    functionNo = RestoreItem_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Restore_All_RestoreJewel()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_TITLE")
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_JEWEL_RESTORATION_POPUP_CONTENT")
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = RestoreJewel_Yes,
    functionNo = RestoreJewel_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if self._isPadSnapping == false then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData)
  end
end
function MakeUpItemNameWithEnchantLevel(restoreType, selectNo)
  local itemSSW = ToClient_RequestRestoreItemEnchantStaticStatusWrapperAt(restoreType, selectNo)
  if itemSSW == nil then
    return
  end
  local itemName = ""
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if ToClient_IsSpecialEnchantItem(itemSSW:get()._key) == true and itemSSW:isSpecialAccessory() == false then
    enchantLevel = 0
  end
  if enchantLevel ~= 0 then
    if itemSSW:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory then
      enchantLevel = enchantLevel + 15
    end
    itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemSSW:getName()
  else
    itemName = itemSSW:getName()
  end
  local resultItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemSSW)
  return resultItemName
end
function RestoreItem_Yes()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  local restoreType = self._restoreType
  local selectNo = self._selectSlotNo
  ToClient_RequestRestoreItem(restoreType, selectNo)
  self:updateRestoreButton(self._restoreCategoryTable.__eItem)
end
function RestoreItem_No()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:updateRestoreButton(self._restoreCategoryTable.__eItem)
end
function RestoreJewel_Yes()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  local selectNo = self._selectSlotNo
  ToClient_RestoreJewelByItemRestoration(selectNo)
  self:updateRestoreButton(self._restoreCategoryTable.__eJewel)
end
function RestoreJewel_No()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:updateRestoreButton(self._restoreCategoryTable.__eJewel)
end
function HandleEventLUp_Restore_All_Select(selectNo, restoreCategory)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self._selectSlotNo = selectNo
  self:updateRestoreButton(restoreCategory)
  if self._isPadSnapping then
    if restoreCategory == self._restoreCategoryTable.__eItem then
      HandleEventLUp_Restore_All_RestoreItem()
    elseif restoreCategory == self._restoreCategoryTable.__eJewel then
      HandleEventLUp_Restore_All_RestoreJewel()
    else
      UI.ASSERT_NAME(false, "\235\179\181\234\181\172 \236\185\180\237\133\140\234\179\160\235\166\172\234\176\128 \236\182\148\234\176\128\235\144\152\235\169\180 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
    end
  end
end
function HandleEventLUp_Restore_All_SelectRestoreCategory(restoreCategory)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:selectRestoreCategory(restoreCategory)
end
function HandleEventLUp_Restore_All_ShowJewelTooltip(isShow, groupIndex, jewelIndex)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  if Panel_Window_Restore_All == nil then
    return
  end
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local jewelItemSSW = ToClient_GetJewelDestroyedItemStaticStatusWrapper(groupIndex, jewelIndex)
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, jewelItemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(jewelItemSSW, Panel_Window_Restore_All, true, false)
  end
end
function HandleEventOnOut_Restore_All_ShowCantRestoreTooltip(isShow, index)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESTORATION")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHAOCHARACTER_JEWEL_NORECOVERY")
  local control = self._ui._list2_jewel:GetContentByKey(index)
  local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
  local uiControl = UI.getChildControl(list2_btn_radio, "StaticText_CantRestore")
  if uiControl == nil then
    UI.ASSERT(false, "uiControl is nil")
    return
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventLUp_Restore_All_SetUpperTab(value)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self._currentTab = self._currentTab + value
  if self._currentTab < 0 then
    self._currentTab = self._restoreCategoryTable.__eItem
  end
  if self._currentTab > #self._restoreCategoryTable then
    self._currentTab = self._restoreCategoryTable.__eJewel
  end
  self:selectRestoreCategory(self._currentTab)
end
function PaGlobalFunc_Restore_All_UpdateConsoleKeyGuide(state)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local keyGuideList = {}
  self._ui_console._stc_keyGuideA:SetShow(false)
  self._ui_console._stc_keyGuideB:SetShow(false)
  self._ui_console._stc_keyGuideX:SetShow(false)
  if state == 1 then
    self._ui_console._stc_keyGuideA:SetShow(true)
    self._ui_console._stc_keyGuideB:SetShow(true)
    self._ui_console._stc_keyGuideX:SetShow(false)
    keyGuideList = {
      self._ui_console._stc_keyGuideA,
      self._ui_console._stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  elseif state == 2 then
    self._ui_console._stc_keyGuideA:SetShow(false)
    self._ui_console._stc_keyGuideB:SetShow(true)
    self._ui_console._stc_keyGuideX:SetShow(true)
    keyGuideList = {
      self._ui_console._stc_keyGuideB,
      self._ui_console._stc_keyGuideX
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  elseif state == 3 then
    self._ui_console._stc_keyGuideA:SetShow(false)
    self._ui_console._stc_keyGuideB:SetShow(true)
    self._ui_console._stc_keyGuideX:SetShow(false)
    keyGuideList = {
      self._ui_console._stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function HandleEventLUp_Restore_All_ShowTextTooltip(isShow, controlType, index, descTime)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._list2_jewel:GetContentByKey(index)
  local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
  local uiControl = nilcheckCount
  local title = ""
  local desc = os.date("%Y-%m-%d %H:%M", descTime)
  if controlType == 1 then
    uiControl = UI.getChildControl(list2_btn_radio, "StaticText_Time")
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_DESTROYEDTIME")
  elseif controlType == 2 then
    uiControl = UI.getChildControl(list2_btn_radio, "StaticText_CantRestore")
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_RESTOREDTIME")
  end
  if uiControl == nil then
    UI.ASSERT(false, "uiControl is nil")
    return
  end
  TooltipSimple_Show(uiControl, title, desc)
end
function FromClient_Restore_All_UpdateList(restoreType)
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self._restoreType = restoreType
  self:updateList()
  self:updateInfo(self._restoreCategoryTable.__eItem)
  self:selectRestoreCategory(self._restoreCategoryTable.__eItem)
end
function FromClient_Restore_All_UpdateJewelList()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:updateJewelList()
  if self._ui._btn_jewel:IsCheck() == true then
    self:updateInfo(self._restoreCategoryTable.__eJewel)
  end
end
function FromClient_Restore_All_UpdateInfo()
  if nil == Panel_Window_Restore_All then
    return
  end
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:updateInfo(self._restoreCategoryTable.__eItem)
end
function FromClient_Restore_All_ChangedRestoreReq()
  if nil == Panel_Window_Restore_All then
    return
  end
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  self:updateRestoreButton(self._restoreCategoryTable.__eItem)
end
function FromClient_Restore_All_Reposition()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:reposition()
end
function FromClient_RestoreJewelByItemRestoration()
  local self = PaGlobal_Restore_All
  if self == nil then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_JEWEL_RESTORATION_SUCCESS"))
  ToClient_RequestJewelDestroyedList()
end
function PaGloabl_Restore_All_ShowAni()
  if nil == Panel_Window_Restore_All then
    return
  end
end
function PaGloabl_Restore_All_HideAni()
  if nil == Panel_Window_Restore_All then
    return
  end
end
function PaGlobal_Restore_All_CreateListControl(control, key)
  PaGlobal_Restore_All:createList(control, key)
end
function PaGlobal_Restore_All_CreateJewelListControl(control, key)
  PaGlobal_Restore_All:createJewelList(control, key)
end
function PaGloabl_Restore_All_Close()
  PaGlobal_Restore_All:prepareClose()
end
