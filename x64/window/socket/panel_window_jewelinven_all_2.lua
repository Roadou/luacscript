function PaGlobalFunc_JewelInven_Open(jewelInvenMode)
  PaGlobal_JewelInven:prepareOpen(jewelInvenMode)
end
function PaGlobalFunc_JewelInven_Close()
  PaGlobal_JewelInven:prepareClose()
end
function PaGlobalFunc_JewelInven_IsShow()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return false
  end
  return Panel_Window_JewelPreset_Inven_All:GetShow()
end
function PaGlobalFunc_JewelInven_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:get():isArtifact() == true then
    return true
  end
  if itemSSW:get():isLightStone() == true then
    return true
  end
  if itemSSW:get():isPushableToSocket() == true and ToClient_isLockItem(itemWrapper:getItemNoRaw()) == false then
    return false
  end
  return true
end
function PaGlobalFunc_JewelInven_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_JewelInven
  if self == nil then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local function pushJewel()
    self:pushJewel(inventoryType, slotNo)
  end
  local itemName = "[" .. itemSSW:getName() .. "]"
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemSSW)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_CRYSTALINVEN_MESSAGE_ADD", "itemname", strItemName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CRYSTALPRESET_INVEN_BTN_ADD"),
    content = messageBoxMemo,
    functionYes = pushJewel,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(isShow, index)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    if PaGlobal_JewelInven._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if isShow == nil or index == nil then
    return
  end
  if PaGlobal_JewelInven._extractionItemTable == nil or PaGlobal_JewelInven._extractionItemTable[index] == nil or PaGlobal_JewelInven._extractionItemTable[index].icon == nil then
    return
  end
  local itemStaticStatusWrapper
  if index == 0 then
    itemStaticStatusWrapper = getItemEnchantStaticStatus(PaGlobal_JewelInven._materialEnchantKey.stuffCrystalExtraction)
  elseif index == 1 then
    itemStaticStatusWrapper = getItemEnchantStaticStatus(PaGlobal_JewelInven._materialEnchantKey.stuffBlackspirit)
  else
    return
  end
  if PaGlobal_JewelInven._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStaticStatusWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemStaticStatusWrapper, Panel_Window_JewelPreset_Inven_All, true, false)
  end
end
function PaGlobalFunc_JewelInven_OnCreateJewelListContent(content, key)
  local self = PaGlobal_JewelInven
  if self == nil or content == nil or key == nil or _ContentsGroup_JewelPreset == false then
    return
  end
  PaGlobal_JewelInven:createJewelInvenContent(content, key)
end
function PaGlobalFunc_JewelInven_CheckDeleteJewel(stringJewelNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local listControl = PaGlobal_JewelInven._ui.list2_Jewel:GetContentByKey(jewelNo)
  if listControl == nil then
    return
  end
  local btn_slot = UI.getChildControl(listControl, "Button_Normal")
  local btn_special = UI.getChildControl(listControl, "Button_Special")
  if btn_slot == nil or btn_special == nil then
    return
  end
  ToClient_padSnapResetControl()
  if btn_slot:GetShow() == true then
    ToClient_PushOrPopJewelNoToDeleteList(jewelNo, true)
    ToClient_padSnapChangeToTarget(btn_special)
  elseif btn_special:GetShow() == true then
    ToClient_PushOrPopJewelNoToDeleteList(jewelNo, false)
    ToClient_padSnapChangeToTarget(btn_slot)
  end
  PaGlobal_JewelInven._ui.list2_Jewel:requestUpdateVisible()
end
function PaGlobalFunc_JewelInven_ShowJewelTooltip(isShow, stringJewelNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    if PaGlobal_JewelInven._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    TooltipSimple_Hide()
    return
  end
  if isShow == nil or stringJewelNo == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
  if jewelItemSSW == nil then
    return
  end
  local listControl = PaGlobal_JewelInven._ui.list2_Jewel:GetContentByKey(jewelNo)
  if listControl == nil then
    return
  end
  local slotBG = UI.getChildControl(listControl, "Static_SlotBg")
  if listControl == nil then
    return
  end
  local slotIcon = UI.getChildControl(slotBG, "Static_JewelList_Slot_")
  if slotIcon == nil then
    return
  end
  if PaGlobal_JewelInven._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, jewelItemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(jewelItemSSW, Panel_Window_JewelPreset_Inven_All, true, false)
  end
end
function PaGlobalFunc_JewelInven_SelectSortType(sortType)
  PaGlobal_JewelInven._jewelSortType = sortType
  PaGlobalFunc_JewelInven_Close()
  PaGlobalFunc_JewelInven_Open(PaGlobal_JewelInven._jewelInvenMode)
  if sortType == JewelSortType.SortByGroupNumber then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.rdo_SortByGroup)
  elseif sortType == JewelSortType.SortByName then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.rdo_SortByName)
  elseif sortType == JewelSortType.SortByGrade then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.rdo_SortByGrade)
  end
end
function PaGlobalFunc_JewelInven_SelectJewelToBeDeleted()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  local consoleButtonPosY = 0
  local panelSizeY = 0
  if PaGlobal_JewelInven._ui.chk_TrashButton:IsCheck() == true then
    Panel_Window_JewelPreset_Inven_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelInven_DeleteJewel()")
    PaGlobal_JewelInven._ui.stc_TrashArea:SetShow(true)
    PaGlobal_JewelInven._ui.stc_DescArea:SetShow(false)
    PaGlobal_JewelInven._ui.rdo_SortByName:SetShow(false)
    PaGlobal_JewelInven._ui.rdo_SortByGroup:SetShow(false)
    PaGlobal_JewelInven._ui.rdo_SortByGrade:SetShow(false)
    if PaGlobal_JewelInven._isPadSnapping == true then
      PaGlobalFunc_InventoryInfo_Close()
    else
      PaGlobalFunc_Inventory_All_SetShow(false)
    end
    if PaGlobal_JewelInven._jewelViewType == JewelViewType.List then
      PaGlobal_JewelInven._ui.stc_TrashArea:SetPosY(PaGlobal_JewelInven._ui.stc_ListBG:GetPosY() + PaGlobal_JewelInven._ui.stc_ListBG:GetSizeY() + 5)
      panelSizeY = PaGlobal_JewelInven._ui.stc_TitleBarArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_TopArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_ListBG:GetSizeY() + PaGlobal_JewelInven._ui.stc_TrashArea:GetSizeY() + 20
    else
      PaGlobal_JewelInven._ui.stc_TrashArea:SetPosY(PaGlobal_JewelInven._ui.stc_SlotBG:GetPosY() + PaGlobal_JewelInven._ui.stc_SlotBG:GetSizeY() + 5)
      panelSizeY = PaGlobal_JewelInven._ui.stc_TitleBarArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_TopArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_SlotBG:GetSizeY() + PaGlobal_JewelInven._ui.stc_TrashArea:GetSizeY() + 20
    end
    Panel_Window_JewelPreset_Inven_All:SetSize(Panel_Window_JewelPreset_Inven_All:GetSizeX(), panelSizeY)
    PaGlobal_JewelInven._ui.stc_Console_Buttons:SetPosY(panelSizeY)
    PaGlobal_JewelInven._ui.stc_TrashDesc:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_JewelInven._ui.stc_TrashDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CRYSTALPRESETINVEN_DELETEDESC"))
    ToClient_ShowMouseCursor()
    PaGlobal_JewelInven._ui.btn_Console_Select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
  else
    Panel_Window_JewelPreset_Inven_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    PaGlobal_JewelInven._ui.stc_TrashArea:SetShow(false)
    PaGlobal_JewelInven._ui.stc_DescArea:SetShow(true)
    PaGlobal_JewelInven._ui.rdo_SortByName:SetShow(true)
    PaGlobal_JewelInven._ui.rdo_SortByGroup:SetShow(true)
    PaGlobal_JewelInven._ui.rdo_SortByGrade:SetShow(true)
    if PaGlobal_JewelInven._isPadSnapping == false then
      if PaGlobalFunc_Inventory_All_SetShow ~= nil then
        PaGlobalFunc_Inventory_All_SetShow(true)
      end
      if Panel_Window_Inventory_All ~= nil and Panel_Npc_Dialog_All ~= nil and PaGlobal_JewelInven._isOpenFromInventory == false then
        Panel_Window_Inventory_All:SetPosY((getScreenSizeY() - Panel_Npc_Dialog_All:GetSizeY() - Panel_Window_Inventory_All:GetSizeY()) * 0.5)
      end
    elseif PaGlobalFunc_InventoryInfo_Open ~= nil then
      PaGlobalFunc_InventoryInfo_Open(1, false, 0, false)
    end
    Inventory_SetFunctor(PaGlobalFunc_JewelInven_Filter, PaGlobalFunc_JewelInven_RClickFunction, nil, nil)
    if PaGlobal_JewelInven._jewelViewType == JewelViewType.List then
      PaGlobal_JewelInven._ui.stc_DescArea:SetPosY(PaGlobal_JewelInven._ui.stc_ListBG:GetPosY() + PaGlobal_JewelInven._ui.stc_ListBG:GetSizeY() + 5)
      panelSizeY = PaGlobal_JewelInven._ui.stc_TitleBarArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_TopArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_ListBG:GetSizeY() + PaGlobal_JewelInven._ui.stc_DescArea:GetSizeY() + 20
    else
      PaGlobal_JewelInven._ui.stc_DescArea:SetPosY(PaGlobal_JewelInven._ui.stc_SlotBG:GetPosY() + PaGlobal_JewelInven._ui.stc_SlotBG:GetSizeY() + 5)
      panelSizeY = PaGlobal_JewelInven._ui.stc_TitleBarArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_TopArea:GetSizeY() + PaGlobal_JewelInven._ui.stc_SlotBG:GetSizeY() + PaGlobal_JewelInven._ui.stc_DescArea:GetSizeY() + 20
    end
    Panel_Window_JewelPreset_Inven_All:SetSize(Panel_Window_JewelPreset_Inven_All:GetSizeX(), panelSizeY)
    PaGlobal_JewelInven._ui.stc_Console_Buttons:SetPosY(panelSizeY)
    PaGlobal_JewelInven._ui.btn_Console_Select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
  end
  PaGlobal_JewelInven:update()
  if PaGlobal_JewelInven._isPadSnapping == true then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.chk_TrashButton)
  end
end
function PaGlobalFunc_JewelInven_ShowTrashButtonTooltip(isShow)
  if isShow == nil then
    return
  end
  if PaGlobal_JewelInven._ui.stc_TrashArea == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_TRASHBTN_TOOLTIPNAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_TRASHBTN_TOOLTIPDESC")
  TooltipSimple_Show(PaGlobal_JewelInven._ui.stc_TrashArea, name, desc)
end
function PaGlobalFunc_JewelInven_DeleteJewel()
  if PaGlobal_JewelInven._jewelInvenMode ~= JewelInvenMode.InventoryMode then
    return
  end
  if PaGlobal_JewelInven._ui.chk_TrashButton:IsCheck() == true then
    local jewelNoDeleteSize = ToClient_GetJewelDeleteListSize()
    if jewelNoDeleteSize == 0 then
      return
    end
    if PaGlobalFunc_TrashBoxConfirm_All_Open ~= nil then
      PaGlobalFunc_TrashBoxConfirm_All_Open(PaGlobal_TrashBoxMode.JewelInvenMode)
    end
    PaGlobalFunc_TrashBoxConfirm_All_ClearItemList()
    for idx = 0, jewelNoDeleteSize - 1 do
      local jewelNo = ToClient_GetDeleteJewelNoByIndex(idx)
      if jewelNo ~= nil or jewelNo ~= -1 then
        PaGlobalFunc_TrashBoxConfirm_All_PushJewelItem(jewelNo)
      end
    end
  else
    PaGlobal_JewelInven._ui.chk_TrashButton:SetCheck(true)
    PaGlobalFunc_JewelInven_SelectJewelToBeDeleted()
  end
end
function PaGlobalFunc_JewelInven_ExtractJewel(stringJewelNo)
  local jewelNo = tonumber64(stringJewelNo)
  PaGlobal_JewelInven:extractJewel(jewelNo)
end
function PaGlobalFunc_JewelInven_CancelDeleteJewel()
  PaGlobal_JewelInven._ui.chk_TrashButton:SetCheck(false)
  PaGlobalFunc_JewelInven_SelectJewelToBeDeleted()
end
function PaGlobalFunc_JewelInven_IsOpenFromInventory(isOpenFromInventory)
  PaGlobal_JewelInven._isOpenFromInventory = isOpenFromInventory
end
function PaGlobalFunc_JewelInven_IsTrashButtonCheck()
  if PaGlobal_JewelInven._ui.chk_TrashButton == nil then
    return false
  end
  return PaGlobal_JewelInven._ui.chk_TrashButton:IsCheck()
end
function PaGlobalFunc_JewelInven_SelectViewType(viewType)
  PaGlobal_JewelInven._jewelViewType = viewType
  PaGlobalFunc_JewelInven_Close()
  PaGlobalFunc_JewelInven_Open(PaGlobal_JewelInven._jewelInvenMode)
  if viewType == JewelViewType.List then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.rdo_ViewByList)
  elseif viewType == JewelViewType.Slot then
    ToClient_padSnapResetControl()
    ToClient_padSnapChangeToTarget(PaGlobal_JewelInven._ui.rdo_ViewBySlot)
  end
end
function PaGlobalFunc_JewelInven_ShowViewTypeTooltip(isShow, viewType)
  if isShow == nil then
    return
  end
  if PaGlobal_JewelInven._ui.rdo_ViewByList == nil or PaGlobal_JewelInven._ui.rdo_ViewBySlot == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if viewType == JewelViewType.List then
    control = PaGlobal_JewelInven._ui.rdo_ViewByList
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_RADIOBTN_LISTTOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_RADIOBTN_LISTTOOLTIP_DESC")
  else
    control = PaGlobal_JewelInven._ui.rdo_ViewBySlot
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_RADIOBTN_SLOTTOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_RADIOBTN_SLOTTOOLTIP_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(isShow, stringJewelNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if isShow == nil or stringJewelNo == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
  if jewelItemSSW == nil then
    return
  end
  local listControl = PaGlobal_JewelInven._ui.list2_Jewel:GetContentByKey(jewelNo)
  if listControl == nil then
    return
  end
  local isUseJewelControl = UI.getChildControl(listControl, "Static_IsUse")
  if isUseJewelControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_ADJUSTTOOLTIP_NAME")
  local desc = ""
  for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
    local isShow = ToClient_IsJewelInThatPreset(idx, jewelNo)
    if isShow == true then
      local presetName = ToClient_GetJewelPresetName(idx)
      if presetName == nil then
        presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", idx + 1)
      end
      if desc == "" then
        desc = "[" .. presetName .. "] "
      else
        desc = desc .. ", [" .. presetName .. "]"
      end
    end
  end
  TooltipSimple_Show(isUseJewelControl, name, desc)
end
function PaGlobalFunc_JewelInven_ShowJewelInvenIncreaseItemTooltip(isShow, index)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if isShow == nil or index == nil then
    return
  end
  local control = PaGlobal_JewelInven._jewelSlotList[index]
  if control == nil then
    return
  end
  local addControl = control.add
  if addControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_ADDSLOTTOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_ADDSLOTTOOLTIP_DESC")
  TooltipSimple_Show(addControl, name, desc)
end
function PaGlobalFunc_JewelInven_ShowJewelSlotTooltip(isShow, stringJewelNo, index)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    if PaGlobal_JewelInven._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    TooltipSimple_Hide()
    return
  end
  if isShow == nil or stringJewelNo == nil or index == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
  if jewelItemSSW == nil then
    return
  end
  local slot = PaGlobal_JewelInven._jewelSlotList[index]
  if slot == nil then
    return
  end
  local jewelIcon = slot.jewelItem.icon
  if jewelIcon == nil then
    return
  end
  if PaGlobal_JewelInven._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, jewelItemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(jewelItemSSW, Panel_Window_JewelPreset_Inven_All, true, false)
  end
end
function PaGlobalFunc_JewelInven_CheckDeleteJewelBySlotMode(stringJewelNo, index, needDelete)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if PaGlobal_JewelInven._ui.chk_TrashButton:IsCheck() == false then
    return
  end
  local slot = PaGlobal_JewelInven._jewelSlotList[index]
  if slot == nil then
    return
  end
  local checkControl = slot.check
  if checkControl == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  if needDelete == true then
    checkControl:SetShow(true)
    ToClient_PushOrPopJewelNoToDeleteList(jewelNo, true)
  else
    checkControl:SetShow(false)
    ToClient_PushOrPopJewelNoToDeleteList(jewelNo, false)
  end
end
function PaGlobalFunc_JewelInven_updateKeyGuideDeleteMode(stringJewelNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  PaGlobal_JewelInven:updateKeyGuideDeleteMode(stringJewelNo)
end
function PaGlobalFunc_JewelInven_BuyJewelInvenItem()
  if PaGlobal_JewelInven._isConsole == true then
    return
  end
  PaGlobalFunc_EasyBuy_Open(93)
end
function PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltipBySlot(isShow, stringJewelNo, index)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if isShow == nil or stringJewelNo == nil or index == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
  if jewelItemSSW == nil then
    return
  end
  local slot = PaGlobal_JewelInven._jewelSlotList[index]
  if slot == nil then
    return
  end
  local isUseControl = UI.getChildControl(slot.empty, "Static_IsUse")
  if isUseControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_ADJUSTTOOLTIP_NAME")
  local desc = ""
  for idx = 0, ToClient_GetJewelPresetMaxCount() - 1 do
    local isShow = ToClient_IsJewelInThatPreset(idx, jewelNo)
    if isShow == true then
      local presetName = ToClient_GetJewelPresetName(idx)
      if presetName == nil then
        presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", idx + 1)
      end
      if desc == "" then
        desc = "[" .. presetName .. "] "
      else
        desc = desc .. ", [" .. presetName .. "]"
      end
    end
  end
  TooltipSimple_Show(isUseControl, name, desc)
end
function PaGlobalFunc_JewelInven_ResetListIndex()
  PaGlobal_JewelInven._ui.list2_Jewel:moveIndex(0)
  PaGlobal_JewelInven._ui.scroll_Vertical:SetControlTop()
end
