function PaGlobal_Extraction_Artifacts_All_Open()
  PaGlobal_Extraction_Artifacts_All:prepareOpen()
end
function PaGlobal_Extraction_Artifacts_All_Close()
  HandleEventRUp_Extraction_Artifacts_All_ClearAllSlots()
  PaGlobal_Extraction_Artifacts_All:prepareClose()
end
function PaGlobalFunc_Extraction_Artifacts_All_UpdateArtifactList(control, key)
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  local listIdx = Int64toInt32(key)
  if nil == PaGlobal_Extraction_Artifacts_All._artifactList[listIdx] then
    return
  end
  local slotNo = PaGlobal_Extraction_Artifacts_All._artifactList[listIdx]
  local whereType, itemWrapper, itemKey
  if listIdx <= PaGlobal_Extraction_Artifacts_All._artifactInvenEnd then
    whereType = CppEnums.ItemWhereType.eInventory
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  else
    whereType = CppEnums.ItemWhereType.eEquip
    itemWrapper = ToClient_getEquipmentItem(slotNo)
  end
  if nil == itemWrapper then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_ExtractableItem")
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local txt_name = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local txt_equiped = UI.getChildControl(btn_list, "StaticText_Equip")
  local stc_hammer = UI.getChildControl(btn_list, "Static_Hammer")
  stc_hammer:SetShow(false)
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if enchantLevel >= 16 then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetText(enchantText .. itemWrapper:getStaticStatus():getName())
  PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  btn_list:SetCheck(false)
  txt_equiped:SetIgnore(true)
  if listIdx <= PaGlobal_Extraction_Artifacts_All._artifactInvenEnd then
    txt_equiped:SetShow(false)
  else
    txt_equiped:SetShow(true)
  end
  local slot = {}
  SlotItem.reInclude(slot, "LightStone_Extraction", 0, stc_itemIcon, PaGlobal_Extraction_Artifacts_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if listIdx <= PaGlobal_Extraction_Artifacts_All._artifactInvenEnd then
    if false == PaGlobal_Extraction_Artifacts_All._isConsole then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItem(" .. listIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(false," .. slotNo .. "," .. whereType .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(false," .. slotNo .. "," .. whereType .. ",false)")
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItem(" .. listIdx .. ")")
    else
      btn_list:addInputEvent("Mouse_On", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(true," .. listIdx .. ")")
      btn_list:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(false," .. listIdx .. ")")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(false," .. slotNo .. "," .. whereType .. ",nil)")
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItemForConsole(" .. listIdx .. ")")
    end
  else
    if false == PaGlobal_Extraction_Artifacts_All._isConsole then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_EquipItem(" .. listIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(true," .. slotNo .. "," .. whereType .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(true," .. slotNo .. "," .. whereType .. ",false)")
    else
      btn_list:addInputEvent("Mouse_On", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(true," .. listIdx .. ")")
      btn_list:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(false," .. listIdx .. ")")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(true," .. slotNo .. "," .. whereType .. ",nil)")
    end
    btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_EquipItem(" .. listIdx .. ")")
  end
end
function HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItem(listIdx)
  PaGlobal_Extraction_Artifacts_All:clearAllSlots()
  if nil == PaGlobal_Extraction_Artifacts_All._artifactList[listIdx] then
    return
  end
  if listIdx > PaGlobal_Extraction_Artifacts_All._artifactInvenEnd then
    return
  end
  local slotNo = PaGlobal_Extraction_Artifacts_All._artifactList[listIdx]
  PaGlobal_Extraction_Artifacts_All._artifactWhereType = CppEnums.ItemWhereType.eInventory
  PaGlobal_Extraction_Artifacts_All._artifactSlotNo = slotNo
  PaGlobal_Extraction_Artifacts_All:setArtifactSlot()
end
function HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItemForConsole(listIdx)
  if nil == PaGlobal_Extraction_Artifacts_All._artifactList[listIdx] then
    PaGlobal_Extraction_Artifacts_All:clearAllSlots()
    return
  end
  local slotNo = PaGlobal_Extraction_Artifacts_All._artifactList[listIdx]
  if slotNo == PaGlobal_Extraction_Artifacts_All._artifactSlotNo then
    PaGlobal_Extraction_Artifacts_All:clearAllSlots()
  else
    HandleEventLUp_Extraction_Artifacts_All_SelectArtifactItem(listIdx)
  end
end
function HandleEventRUp_Extraction_Artifacts_All_RemoveLightStone(socketIndex)
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_MESSAGE_LIGHTSTONE", "socketNum", string.format("%d", socketIndex))
  local function remove_lightStone_do()
    PaGlobal_Extraction_Artifacts_All._isRemove = true
    audioPostEvent_SystemUi(5, 7)
    _AudioPostEvent_SystemUiForXBOX(5, 7)
    Socket_PopJewelFromSocket(socketIndex - 1, CppEnums.ItemWhereType.eCount, __eTInventorySlotNoUndefined)
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = remove_lightStone_do,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    MessageBox.showMessageBox(messageboxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_Extraction_Artifacts_All_EquipItem(listIdx)
  local equipSlotNo = PaGlobal_Extraction_Artifacts_All._artifactList[listIdx]
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipSlotNo)
    else
      Equipment_RClick(equipSlotNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipSlotNo)
  end
end
function HandleEventRUp_Extraction_Artifacts_All_MaterialItem()
  PaGlobal_Extraction_Artifacts_All:clearMaterialSlot()
end
function HandleEventLUp_Extraction_Artifacts_All_SelectMaterialItem(listIdx)
  PaGlobal_Extraction_Artifacts_All:clearMaterialSlot()
  if nil == PaGlobal_Extraction_Artifacts_All._materialList[listIdx] then
    return
  end
  if nil == PaGlobal_Extraction_Artifacts_All._artifactSlotNo then
    return
  end
  local materialItemInfo = PaGlobal_Extraction_Artifacts_All._materialList[listIdx]
  local slotNo = materialItemInfo.slotNo
  local whereType = materialItemInfo.whereType
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  PaGlobal_Extraction_Artifacts_All._materialWhereType = whereType
  PaGlobal_Extraction_Artifacts_All._materialSlotNo = slotNo
  PaGlobal_Extraction_Artifacts_All:setMaterialSlot(itemWrapper, whereType, slotNo)
end
function HandleEventLUp_Extraction_Artifacts_All_SelectMaterialItemForConsole(listIdx)
  if nil == PaGlobal_Extraction_Artifacts_All._materialList[listIdx] then
    return
  end
  local materialItemInfo = PaGlobal_Extraction_Artifacts_All._materialList[listIdx]
  local slotNo = materialItemInfo.slotNo
  local whereType = materialItemInfo.whereType
  if slotNo == PaGlobal_Extraction_Artifacts_All._materialSlotNo and whereType == PaGlobal_Extraction_Artifacts_All._materialWhereType then
    HandleEventRUp_Extraction_Artifacts_All_MaterialItem()
  else
    HandleEventLUp_Extraction_Artifacts_All_SelectMaterialItem(listIdx)
  end
end
function HandleEventRUp_Extraction_Artifacts_All_ClearAllSlots()
  PaGlobal_Extraction_Artifacts_All:clearAllSlots()
end
function PaGlobalFunc_Extraction_Artifacts_All_UpdateMaterialList(control, key)
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  local listIdx = Int64toInt32(key)
  local btn_list = UI.getChildControl(control, "RadioButton_ExtractionMaterialItem")
  btn_list:SetCheck(false)
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  stc_itemIcon:SetIgnore(false)
  local txt_name = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local txt_count = UI.getChildControl(btn_list, "StaticText_ItemCount")
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    stc_itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_SelectMaterialItem(" .. listIdx .. ")")
  end
  btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Artifacts_All_SelectMaterialItemForConsole(" .. listIdx .. ")")
  local materialItemInfo = PaGlobal_Extraction_Artifacts_All._materialList[listIdx]
  local itemKey
  if __eTInventorySlotNoUndefined ~= materialItemInfo.slotNo then
    itemKey = getInventoryItemByType(materialItemInfo.whereType, materialItemInfo.slotNo):get():getKey():getItemKey()
    btn_list:SetMonoTone(false)
  else
    if CppEnums.ItemWhereType.eInventory == materialItemInfo.whereType then
      itemKey = PaGlobal_Extraction_Artifacts_All._materialEnchantKey.stuffCrystalExtraction:getItemKey()
    end
    btn_list:SetMonoTone(true)
  end
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    stc_itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey .. ",true)")
    stc_itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey .. ",false)")
  else
    btn_list:addInputEvent("Mouse_On", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuideMaterial(true," .. listIdx .. ")")
    btn_list:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuideMaterial(false," .. listIdx .. ")")
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Artifacts_All_ShowToolTip(" .. itemKey .. ",nil)")
  end
  local itemName = materialItemInfo.name
  local itemIconPath = materialItemInfo.iconPath
  local itemCount = materialItemInfo.itemCount
  local itemWrapper = getInventoryItemByType(materialItemInfo.whereType, materialItemInfo.slotNo)
  local itemSSW
  if nil ~= itemWrapper then
    itemSSW = itemWrapper:getStaticStatus()
  end
  txt_name:SetText(itemName)
  PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  txt_count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(itemCount)))
  stc_itemIcon:ChangeTextureInfoNameAsync("icon/" .. itemIconPath)
  control:ComputePos()
end
function HandleEventOn_Extraction_Artifacts_All_ShowToolTip(key, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == Panel_Window_Extraction_Artifacts_All or nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Artifacts_All, true, false)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOn_Extraction_Artifacts_All_ShowListToolTip(isEquip, idx, whereType, isShow)
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  else
    itemWrapper = getInventoryItemByType(whereType, idx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Artifacts_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    if true == isEquip then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    end
  end
end
function HandleEventLUp_Extraction_Artifacts_All_ExtractionLightStone(socketIndex)
  if true == PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[socketIndex].isEmpty then
    return
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_ARTIFACTS_EXTRACT")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_EXTRACTION_MESSAGE_LIGHTSTONE", "socketNum", string.format("%d", socketIndex))
  local function ExtractionLightStone_Confirm()
    audioPostEvent_SystemUi(5, 7)
    _AudioPostEvent_SystemUiForXBOX(5, 7)
    PaGlobal_Extraction_Artifacts_All._isRemove = false
    Socket_PopJewelFromSocket(socketIndex - 1, PaGlobal_Extraction_Artifacts_All._materialWhereType, PaGlobal_Extraction_Artifacts_All._materialSlotNo)
    PaGlobal_Extraction_Artifacts_All_UpdateList()
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = ExtractionLightStone_Confirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandlePadEventOn_Extraction_Artifacts_All_SocketOnTextureChange(socketIndex, isOn)
  local control = PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[socketIndex].stc_lightStone
  if nil == control then
    return
  end
  if false == isOn then
    control:setRenderTexture(control:getBaseTexture())
  else
    control:setRenderTexture(control:getOnTexture())
  end
end
function FromClient_Extraction_Artifacts_All_ReSizePanel()
  if false == PaGlobal_Extraction_Artifacts_All._isConsole then
    PaGlobal_Extraction_Artifacts_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Extraction_Artifacts_All._ui_pc.btn_close:ComputePos()
  else
  end
  PaGlobal_Extraction_Artifacts_All._ui.txt_desc:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.list2_extractableItem:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.list2_materialItem:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.stc_materialItemSlot:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.stc_extractionItemSlot:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.stc_extractImage:ComputePos()
  PaGlobal_Extraction_Artifacts_All._ui.txt_noItem:ComputePos()
  for idx = 1, 2 do
    PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[idx].txt_name:ComputePos()
    PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[idx].txt_desc:ComputePos()
    PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[idx].btn_extraction:ComputePos()
    PaGlobal_Extraction_Artifacts_All._ui.stc_lightStoneInfo[idx].stc_itemSlot:ComputePos()
  end
end
function FromClient_Extraction_Artifacts_All_UpdateList()
  if false == Panel_Window_Extraction_Artifacts_All:GetShow() then
    return
  end
  PaGlobal_Extraction_Artifacts_All_UpdateList()
end
function PaGlobal_Extraction_Artifacts_All_UpdateList()
  PaGlobal_Extraction_Artifacts_All:updateExtractionList()
  PaGlobal_Extraction_Artifacts_All:updateMaterialList()
  if nil ~= PaGlobal_Extraction_Artifacts_All._lastIndex then
    PaGlobal_Extraction_Artifacts_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_Artifacts_All._lastIndex)
  end
end
function FromClient_Extraction_Artifacts_All_ChangeArtifactSocket()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
  if false == Panel_Window_Extraction_Artifacts_All:GetShow() then
    return
  end
  PaGlobal_ExtractionResult:resetChildControl()
  PaGlobal_ExtractionResult:resetAnimation()
  if false == PaGlobal_ExtractionResult:getShow() then
    if false == PaGlobal_Extraction_Artifacts_All._isRemove then
      local itemSSW
      if nil ~= PaGlobal_Extraction_Artifacts_All._extractionKey then
        itemSSW = getItemEnchantStaticStatus(PaGlobal_Extraction_Artifacts_All._extractionKey)
      end
      if nil ~= itemSSW then
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_DESC_ARTIFACTS"), itemSSW:getName(), itemSSW)
      else
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_DESC_ARTIFACTS"))
      end
    else
      PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_DELETE_DESC_ARTIFACTS"))
    end
  end
  PaGlobal_Extraction_Artifacts_All._resultShowTime = 0
  getSocketInformation():clearData()
  PaGlobal_Extraction_Artifacts_All:setArtifactSlot()
  PaGlobal_Extraction_Artifacts_All:clearMaterialSlot()
  PaGlobal_Extraction_Artifacts_All_UpdateList()
  Panel_Window_Extraction_Result:RegisterUpdateFunc("PaGlobal_Extraction_Artifacts_All_CheckResultMsgShowTime")
end
function PaGlobal_Extraction_Artifacts_All_CheckResultMsgShowTime(delta)
  PaGlobal_Extraction_Artifacts_All._resultShowTime = PaGlobal_Extraction_Artifacts_All._resultShowTime + delta
  if PaGlobal_Extraction_Artifacts_All._resultShowTime > 3 and true == Panel_Window_Extraction_Result:GetShow() then
    Panel_Window_Extraction_Result:SetShow(false)
  end
  if PaGlobal_Extraction_Artifacts_All._resultShowTime > 5 then
    PaGlobal_Extraction_Artifacts_All._resultShowTime = 0
    Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuide(isShow, listIdx, socketIndex)
  PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconX:SetShow(isShow)
  if nil ~= socketIndex then
    HandlePadEventOn_Extraction_Artifacts_All_SocketOnTextureChange(socketIndex, isShow)
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetShow(false)
  else
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetShow(true)
  end
  if false == isShow then
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Extraction_Artifacts_All._artifactList[listIdx]
    if PaGlobal_Extraction_Artifacts_All._artifactSlotNo == slotNo then
      PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_Artifacts_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Artifacts_All_ShowDetailKeyGuideMaterial(isShow, key)
  PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local materialItemInfo = PaGlobal_Extraction_Artifacts_All._materialList[key]
    local slotNo = materialItemInfo.slotNo
    local whereType = materialItemInfo.whereType
    if PaGlobal_Extraction_Artifacts_All._materialWhereType == whereType and PaGlobal_Extraction_Artifacts_All._materialSlotNo == slotNo then
      PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_Artifacts_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Artifacts_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconX,
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconA,
    PaGlobal_Extraction_Artifacts_All._ui_console.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Extraction_Artifacts_All._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Extraction_Artifacts_All_ShowAni()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
end
function PaGlobal_Extraction_Artifacts_All_HideAni()
  if nil == Panel_Window_Extraction_Artifacts_All then
    return
  end
end
