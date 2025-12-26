function PaGlobalFunc_Artifacts_All_Open()
  PaGlobal_Artifacts_All:prepareOpen()
end
function PaGlobalFunc_Artifacts_All_Close()
  PaGlobal_Artifacts_All:prepareClose()
  if PaGlobal_Artifacts_All._isOpenLightStoneBag == true then
    if PaGlobalFunc_LightStoneBag_Open ~= nil then
      PaGlobalFunc_LightStoneBag_Open()
    elseif PaGlobal_Artifacts_All._isOpenInven == true then
      GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
      PaGlobal_Artifacts_All._isOpenInven = false
    end
  elseif PaGlobal_Artifacts_All._isOpenInven == true then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
    PaGlobal_Artifacts_All._isOpenInven = false
  end
  PaGlobal_Artifacts_All._isOpenLightStoneBag = false
  PaGlobal_Artifacts_All._isOpenInven = false
end
function PaGlobalFunc_Artifacts_All_GetShow()
  if nil == Panel_Window_Artifacts_All then
    return false
  end
  return Panel_Window_Artifacts_All:GetShow()
end
function PaGlobalFunc_Artifacts_All_Resize()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  PaGlobal_Artifacts_All:resize()
end
function HandleEventLUp_Artifacts_All_SelectArtifactSlot(artifactIdx)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  getSocketInformation():popEquip()
  PaGlobal_Artifacts_All._selectArtifactIndex = artifactIdx
  if nil == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx] then
    PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
    PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
    return
  end
  if false == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].empty then
    local slotNo = PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slotNo
    local success = 0 == Socket_SetItemHaveSocket(CppEnums.ItemWhereType.eInventory, slotNo)
    if not success then
      PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
      PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
      return
    end
  else
    PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
    PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
  end
  PaGlobal_Artifacts_All:updateArtifactRadio()
end
function HandleEventLUp_Artifact_All_SelectArtifact(slotNo)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if nil == PaGlobal_Artifacts_All._selectArtifactIndex then
    return
  end
  for idx = 0, 1 do
    if PaGlobal_Artifacts_All._artifactItemSlotInfo[idx].slotNo == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_ALREADY_IN"))
      return
    end
  end
  local artifactIdx = PaGlobal_Artifacts_All._selectArtifactIndex
  local socketInfo = getSocketInformation()
  if false == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].empty then
    PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
    PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
    getSocketInformation():popEquip()
  end
  local success = 0 == Socket_SetItemHaveSocket(CppEnums.ItemWhereType.eInventory, slotNo)
  if not success then
    PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
    PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
    return
  end
  if true == socketInfo._setEquipItem then
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].empty = false
    PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slotNo = slotNo
    PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slot:clearItem()
    PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slot:setItem(itemWrapper)
    PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slot.icon:SetShow(true)
    if false == PaGlobal_Artifacts_All._isConsole then
      PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Artifacts_All_ArtifactSlotTooltip(" .. slotNo .. ", true, " .. artifactIdx .. ")")
      PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Artifacts_All_ArtifactSlotTooltip(" .. slotNo .. ", false, " .. artifactIdx .. ")")
    end
    PaGlobal_Artifacts_All:updateArtifactSlot(artifactIdx)
    PaGlobal_Artifacts_All:updateLightStoneSet()
  end
  local otherArtifactIdx = artifactIdx + 1
  if otherArtifactIdx > 1 then
    otherArtifactIdx = 0
  end
  if true == PaGlobal_Artifacts_All._artifactItemSlotInfo[otherArtifactIdx].empty then
    HandleEventLUp_Artifacts_All_SelectArtifactSlot(otherArtifactIdx)
  else
    PaGlobal_Artifacts_All:updateArtifactRadio()
  end
  PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
end
function HandleEventLUp_Artifact_All_SelectLightStone(slotNo)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if nil == PaGlobal_Artifacts_All._selectArtifactIndex then
    return
  end
  local artifactIdx = PaGlobal_Artifacts_All._selectArtifactIndex
  PaGlobal_Artifacts_All:updateArtifactRadio()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  local socketInfo = getSocketInformation()
  local rv = Socket_SetItemHaveSocket(CppEnums.ItemWhereType.eInventory, slotNo)
  local success = 0 == rv
  if not success then
    if 2896446944 ~= rv then
      getSocketInformation():popEquip()
      PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
    end
    PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
    return
  end
  local rv = socketInfo:checkPushJewelToEmptySoket(CppEnums.ItemWhereType.eInventory, slotNo)
  PaGlobal_Artifacts_All._isItemLock = ToClient_Inventory_CheckItemLock(PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slotNo)
  if 0 == rv then
    local index = socketInfo._indexPush
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_TITLE")
    local stringId = "LUA_LIGHTSTONE_INSERT_MESSAGE_" .. tostring(artifactIdx)
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, stringId, "socketNum", string.format("%d", index + 1), "itemName", itemWrapper:getStaticStatus():getName())
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = PaGlobalFunc_Artifacts_All_PushConfirm,
      functionCancel = PaGlobalFunc_Artifacts_All_PushDeny,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventRUp_Artifacts_All_ClearAllSlots()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  PaGlobal_Artifacts_All:clearAllSlots()
end
function HandleEventRUp_Artifacts_All_ClearArtifactSlot(artifactIdx)
  Panel_Tooltip_Item_hideTooltip()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  PaGlobal_Artifacts_All:clearArtifactSlot(artifactIdx)
  if PaGlobal_Artifacts_All._selectArtifactIndex ~= artifactIdx then
    HandleEventLUp_Artifacts_All_SelectArtifactSlot(artifactIdx)
  end
  PaGlobal_Artifacts_All._ui.list_artifact:requestUpdateVisible()
end
function HandleEventLUp_Artifacts_All_SelectTab(tabIdx)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  PaGlobal_Artifacts_All:selectTab(tabIdx)
end
function HandleEventRUp_Artifacts_All_RemoveLightStone(artifactIndex, socketIndex, lightStoneIdx)
  if true == PaGlobal_Artifacts_All._ui.stc_lightStoneInfo[lightStoneIdx].empty then
    return
  end
  if nil == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIndex] then
    return
  end
  if true == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIndex].empty then
    return
  end
  if PaGlobal_Artifacts_All._selectArtifactIndex ~= artifactIndex then
    HandleEventLUp_Artifacts_All_SelectArtifactSlot(artifactIndex)
  end
  PaGlobal_Artifacts_All._slotNoPopArtifact = PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIndex].slotNo
  PaGlobal_Artifacts_All._indexPopSocket = socketIndex - 1
  PaGlobal_Artifacts_All._lightStoneIndexPop = lightStoneIdx
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_MESSAGE_LIGHTSTONE", "socketNum", string.format("%d", socketIndex))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = PaGlobalFunc_Artifacts_All_LightStonePop,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_Artifacts_All._isConsole then
    MessageBox.showMessageBox(messageboxData, nil, nil, false)
  else
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLBRB_Artifacts_All_MoveTab(value)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local currentTab = PaGlobal_Artifacts_All._selectTab
  currentTab = currentTab + value
  if currentTab < 1 then
    currentTab = 2
  elseif currentTab > 2 then
    currentTab = 1
  end
  HandleEventLUp_Artifacts_All_SelectTab(currentTab)
  Panel_Tooltip_Item_hideTooltip()
  ToClient_padSnapResetControl()
end
function FromClient_Artifacts_All_updateArtifactList()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if PaGlobal_Artifacts_All._selectTab == PaGlobal_Artifacts_All._TAB.ARTIFACT then
    PaGlobal_Artifacts_All:updateArtifactList()
  elseif PaGlobal_Artifacts_All._selectTab == PaGlobal_Artifacts_All._TAB.LIGHTSTONE then
    PaGlobal_Artifacts_All:updateLightStoneList()
  end
end
function FromClient_Artifacts_All_ChangeArtifactSocket()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if false == Panel_Window_Artifacts_All:GetShow() then
    return
  end
  PaGlobal_Artifacts_All:updateArtifactSlot(PaGlobal_Artifacts_All._selectArtifactIndex)
  if PaGlobal_Artifacts_All._selectTab == PaGlobal_Artifacts_All._TAB.ARTIFACT then
    PaGlobal_Artifacts_All:updateArtifactList()
  elseif PaGlobal_Artifacts_All._selectTab == PaGlobal_Artifacts_All._TAB.LIGHTSTONE then
    PaGlobal_Artifacts_All:updateLightStoneList()
  end
  PaGlobal_Artifacts_All:updateLightStoneSet()
end
function PaGloabl_Artifacts_All_ShowAni()
  if nil == Panel_Window_Artifacts_All then
    return
  end
end
function PaGloabl_Artifacts_All_HideAni()
  if nil == Panel_Window_Artifacts_All then
    return
  end
end
function PaGlobalFunc_Artifacts_All_UpdateArtifactList(control, key)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local listIdx = Int64toInt32(key)
  if nil == PaGlobal_Artifacts_All._artifactList[listIdx] then
    return
  end
  local slotNo = PaGlobal_Artifacts_All._artifactList[listIdx]
  local artifactSlotNo = -1
  local itemWrapper, itemKey
  if listIdx <= PaGlobal_Artifacts_All._indexInvenEnd then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  else
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
  local stc_onoff = {}
  for artifactIdx = 0, PaGlobal_Artifacts_All._artifactSlotCount - 1 do
    stc_onoff[artifactIdx] = {}
    stc_onoff[artifactIdx].stc_off = UI.getChildControl(btn_list, "Static_Off_" .. tostring(artifactIdx + 1))
    stc_onoff[artifactIdx].stc_on = UI.getChildControl(stc_onoff[artifactIdx].stc_off, "Static_On_" .. tostring(artifactIdx + 1))
    stc_onoff[artifactIdx].stc_off:SetShow(false)
    stc_onoff[artifactIdx].stc_on:SetShow(false)
    if listIdx <= PaGlobal_Artifacts_All._indexInvenEnd and false == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].empty and slotNo == PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIdx].slotNo then
      artifactSlotNo = artifactIdx
    end
  end
  if -1 ~= artifactSlotNo then
    for artifactIdx = 0, PaGlobal_Artifacts_All._artifactSlotCount - 1 do
      stc_onoff[artifactIdx].stc_off:SetShow(true)
      if artifactIdx == artifactSlotNo then
        stc_onoff[artifactIdx].stc_on:SetShow(true)
      end
    end
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if enchantLevel >= 16 then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(enchantText .. itemWrapper:getStaticStatus():getName())
  PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  btn_list:SetCheck(false)
  txt_equiped:SetIgnore(true)
  if listIdx <= PaGlobal_Artifacts_All._indexInvenEnd then
    txt_equiped:SetShow(false)
  else
    txt_equiped:SetShow(true)
  end
  btn_list:setNotImpactScrollEvent(true)
  local slot = {}
  SlotItem.reInclude(slot, "ArtifactListSlot_", 0, stc_itemIcon, PaGlobal_Artifacts_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if listIdx <= PaGlobal_Artifacts_All._indexInvenEnd then
    if false == PaGlobal_Artifacts_All._isConsole then
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifact_All_SelectArtifact(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifact_All_SelectArtifact(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", false)")
    else
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Artifact_All_SelectArtifact(" .. slotNo .. ")")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", true)")
    end
  elseif false == PaGlobal_Artifacts_All._isConsole then
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_EquipmentRelese(" .. slotNo .. ")")
    btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_All_EquipmentRelese(" .. slotNo .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Artifacts_All_ListTooltip(true," .. listIdx .. "," .. slotNo .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Artifacts_All_ListTooltip(true," .. listIdx .. "," .. slotNo .. ", false)")
  else
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Artifacts_All_EquipmentRelese(" .. slotNo .. ")")
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Artifacts_All_ListTooltip(true," .. listIdx .. "," .. slotNo .. ", true)")
  end
  PaGlobal_Artifacts_All._slotIconList[listIdx] = slot.icon
end
function PaGlobalFunc_Artifacts_All_UpdateLightStoneList(control, key)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local listIdx = Int64toInt32(key)
  if nil == PaGlobal_Artifacts_All._lightStoneList[listIdx] then
    return
  end
  local slotNo = PaGlobal_Artifacts_All._lightStoneList[listIdx]
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_ExtractionMaterialItem")
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local txt_name = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if enchantLevel >= 16 then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(enchantText .. itemWrapper:getStaticStatus():getName())
  PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  btn_list:SetCheck(false)
  btn_list:setNotImpactScrollEvent(true)
  local slot = {}
  SlotItem.reInclude(slot, "LightStoneListSlot_", 0, stc_itemIcon, PaGlobal_Artifacts_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if false == PaGlobal_Artifacts_All._isConsole then
    btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifact_All_SelectLightStone(" .. slotNo .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifact_All_SelectLightStone(" .. slotNo .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", false)")
  else
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Artifact_All_SelectLightStone(" .. slotNo .. ")")
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Artifacts_All_ListTooltip(false," .. listIdx .. "," .. slotNo .. ", true)")
  end
  PaGlobal_Artifacts_All._slotIconList[listIdx] = slot.icon
end
function PaGlobalFunc_Artifacts_All_PushConfirm()
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local socketInfo = getSocketInformation()
  local index = socketInfo._indexPush
  local artifactIdx = PaGlobal_Artifacts_All._selectArtifactIndex
  if false == PaGlobal_Artifacts_All._isItemLock then
    local lightStoneIdx = artifactIdx * PaGlobal_Artifacts_All._artifactSlotCount + index + 1
    PaGlobal_Artifacts_All._ui.stc_lightStoneSlot[lightStoneIdx]:AddEffect("fUI_ItemJewel_01B", false, 0, 0)
    audioPostEvent_SystemUi(5, 6)
    _AudioPostEvent_SystemUiForXBOX(5, 6)
  end
  Socket_ConfirmPushJewel(true)
  DragManager:clearInfo()
end
function PaGlobalFunc_Artifacts_All_PushDeny()
  Socket_ConfirmPushJewel(false)
end
function PaGlobalFunc_Artifacts_All_LightStonePop()
  audioPostEvent_SystemUi(5, 7)
  _AudioPostEvent_SystemUiForXBOX(5, 7)
  PaGlobal_Artifacts_All._ui.stc_lightStoneInfo[PaGlobal_Artifacts_All._lightStoneIndexPop].empty = true
  Socket_PopLightStoneFromSocket(PaGlobal_Artifacts_All._slotNoPopArtifact, PaGlobal_Artifacts_All._indexPopSocket)
end
function HandleEventOnOut_Artifacts_All_ListTooltip(isEquip, listIndex, slotNo, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == slotNo then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(slotNo)
  else
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Artifacts_All._isConsole then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_Artifacts_All._slotIconList[listIndex], false, true, nil)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Artifacts_All_LightStoneSlotTooltip(itemKey, isShow, lightStoneIndex)
  if nil == Panel_Window_Artifacts_All then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == itemKey or nil == lightStoneIndex then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    return
  end
  if false == PaGlobal_Artifacts_All._isConsole then
    Panel_Tooltip_Item_Show(itemSSW, PaGlobal_Artifacts_All._ui.stc_lightStoneInfo[lightStoneIndex].slot.icon, true, false)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Artifacts_All_ArtifactSlotTooltip(slotNo, isShow, artifactIndex)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == slotNo then
    return
  end
  if nil == Panel_Window_Artifacts_All then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Artifacts_All._isConsole then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_Artifacts_All._artifactItemSlotInfo[artifactIndex].slot.icon, false, true, nil)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_Artifacts_All_EquipmentRelese(slotNo)
  if nil == slotNo then
    UI.ASSERT_NAME(nil ~= slotNo, "slotNo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if false == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
    else
      InputMRUp_InventoryInfo_EquipSlot(slotNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(slotNo)
  end
end
function HandleEventOn_Artifacts_All_MainSlot(isOn)
  local self = PaGlobal_Artifacts_All
  if self == nil or isOn == nil then
    return
  end
  if isOn == true then
    self:changePadSnapState(self._PAD_SNAP_STATE.OnMainSlot)
  else
    self:changePadSnapState(self._PAD_SNAP_STATE.Default)
  end
end
function HandleEventOn_Artifacts_All_LightStoneSlot(isOn)
  local self = PaGlobal_Artifacts_All
  if self == nil or isOn == nil then
    return
  end
  if isOn == true then
    self:changePadSnapState(self._PAD_SNAP_STATE.OnSubSlot)
  else
    self:changePadSnapState(self._PAD_SNAP_STATE.Default)
  end
end
function PaGlobalFunc_Artifacts_All_OpenAllList()
  local url = "https://www.console.playblackdesert.com/Wiki/Default?wikiNo=245"
  if ToClient_isPS4() == true then
    ToClient_OpenNativeWebBrowserPS4(url)
  else
    ToClient_OpenNativeWebBrowserXB1(url, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIGHTSTONE_COMBINATION"))
  end
end
