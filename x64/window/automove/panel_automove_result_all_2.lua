function HandleEventLUp_ClickAutoMove()
  local actorKeyRaw = PaGlobal_WareHouse_All._targetActorKeyRaw
  local installationActorKeyRaw = 0
  if PaGlobal_WareHouse_All:isInstallation() == true then
    installationActorKeyRaw = PaGlobal_WareHouse_All._installationActorKeyRaw
  end
  local function requestMoveItems()
    if PaGlobal_AutoMove_Result_All._isCurrentWarehouse == true then
      PaGlobal_AutoMove_Result_All:updateMoveItemCount_XXX(ToClient_requestMoveItemsInventoryToWarehouse(actorKeyRaw, Inventory_GetCurrentInventoryType(), installationActorKeyRaw, PaGlobal_Warehouse_All_OpenByMaidCheck()))
    else
      local currentWaypointKey = PaGlobal_WareHouse_All._currentWaypointKey
      PaGlobal_AutoMove_Result_All:updateMoveItemCount_XXX(ToClient_requestMoveAllItemsInventoryToWarehouse(actorKeyRaw, PaGlobal_WareHouse_All._currentWaypointKey, Inventory_GetCurrentInventoryType(), installationActorKeyRaw, PaGlobal_Warehouse_All_OpenByMaidCheck()))
    end
    PaGlobal_AutoMove_Result_All:prepareClose()
  end
  if PaGlobal_Warehouse_All_OpenByMaidCheck() == true then
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_TO_WAREHOUSE_BY_MAID_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(false)))
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = requestMoveItems,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    requestMoveItems()
  end
end
function HandleEventLUp_SelectRadioAll()
  if PaGlobal_AutoMove_Result_All._isCurrentWarehouse == false then
    return
  end
  PaGlobal_AutoMove_Result_All:updateAutoMove(false)
end
function HandleEventLUp_ClickClose()
  PaGlobal_AutoMove_Result_All:prepareClose()
end
function PaGloabl_AutoMove_Result_ShowAni()
  if Panel_AutoMove_Result_All == nil then
    return
  end
end
function PaGloabl_AutoMove_Result_HideAni()
  if Panel_AutoMove_Result_All == nil then
    return
  end
end
function PaGlobal_AutoMove_Result_All:SetData(actorKeyRaw, waypointKeyTable)
  if PaGlobal_AutoMove_Result_All._itemData == nil then
    PaGlobal_AutoMove_Result_All._itemData = {}
  end
  for wIdx, waypointKey in ipairs(waypointKeyTable) do
    if PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey] == nil then
      PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey] = {}
      local tempContent = UI.createAndCopyBasePropertyControl(PaGlobal_AutoMove_Result_All._ui._frame_content, "Static_Group", PaGlobal_AutoMove_Result_All._ui._frame_content, "wg_" .. waypointKey)
      local tempTitle = UI.createAndCopyBasePropertyControl(PaGlobal_AutoMove_Result_All._ui._frame_content_stc_group, "StaticText_GroupTitle", tempContent, "wg_" .. waypointKey .. "_title")
      tempTitle:SetTextMode(__eTextMode_AutoWrap)
      tempTitle:SetText(getRegionNameByWaypointKey(waypointKey))
      tempContent:SetShow(false)
      PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content = tempContent
      PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].tempTitle = tempTitle
    end
    local listCount = ToClient_getAutoMoveItemInfoListCount(actorKeyRaw, waypointKey)
    if PaGlobal_AutoMove_Result_All._itemData[waypointKey] == nil then
      PaGlobal_AutoMove_Result_All._itemData[waypointKey] = {}
    end
    for listIdx = 1, listCount do
      local itemKey = ToClient_getAutoMoveItemKeyByIndex(actorKeyRaw, waypointKey, listIdx - 1)
      local itemCount = ToClient_getAutoMoveItemCountByIndex(actorKeyRaw, waypointKey, listIdx - 1)
      local isSealed = ToClient_getAutoMoveItemSealedByIndex(actorKeyRaw, waypointKey, listIdx - 1)
      if itemKey ~= __eItemKeyUndefined and itemCount ~= -1 then
        PaGlobal_AutoMove_Result_All._itemData[waypointKey][listIdx] = {}
        PaGlobal_AutoMove_Result_All._itemData[waypointKey][listIdx].itemKey = itemKey
        PaGlobal_AutoMove_Result_All._itemData[waypointKey][listIdx].itemCount = itemCount
        PaGlobal_AutoMove_Result_All._itemData[waypointKey][listIdx].isSealed = isSealed
      end
    end
  end
end
function PaGlobal_AutoMove_Result_All:ResetSlot()
  if PaGlobal_AutoMove_Result_All == nil then
    return
  end
  for waypointKey, itemSlot in pairs(PaGlobal_AutoMove_Result_All._itemSlot) do
    if itemSlot ~= nil then
      for slotIndex, slotData in ipairs(itemSlot) do
        if slotData ~= nil then
          Panel_Tooltip_Item_Show_GeneralStatic(slotData._item, "autoMove", false, false)
          slotData:clearItem()
          slotData.iconBg:SetShow(false)
          if PaGlobal_AutoMove_Result_All._isConsole == true then
            _PA_LOG("\234\185\128\236\160\149\235\175\188", "PaGlobal_AutoMove_Result_All:ResetSlot console \236\157\180\235\178\164\237\138\184 \236\160\156\234\177\176")
          else
            slotData.icon:addInputEvent("Mouse_On", "")
            slotData.icon:addInputEvent("Mouse_Out", "")
          end
        end
      end
    end
  end
end
function PaGlobal_AutoMove_Result_All:UpdateAutoMoveResult(actorKeyRaw, waypointKeyTable)
  local nextPosY = 0
  for wIdx, group in pairs(PaGlobal_AutoMove_Result_All._waypointGroup) do
    group.content:SetShow(false)
  end
  for wIdx, waypointKey in ipairs(waypointKeyTable) do
    local listCount = ToClient_getAutoMoveItemInfoListCount(actorKeyRaw, waypointKey)
    if listCount ~= 0 then
      PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content:SetShow(true)
      local waypointName = getRegionNameByWaypointKey(waypointKey)
      for listIndex = 1, listCount do
        local item = PaGlobal_AutoMove_Result_All._itemData[waypointKey][listIndex]
        if item == nil then
          return
        end
        local row = math.floor((listIndex - 1) / PaGlobal_AutoMove_Result_All._COL_SLOT_COUNT)
        local col = (listIndex - 1) % PaGlobal_AutoMove_Result_All._COL_SLOT_COUNT
        PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content:SetSize(PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content:GetSizeX(), 100 + (PaGlobal_AutoMove_Result_All._ICON_SIZE + 10) * row)
        if PaGlobal_AutoMove_Result_All._itemSlot[waypointKey] == nil then
          PaGlobal_AutoMove_Result_All._itemSlot[waypointKey] = {}
        end
        local slot = PaGlobal_AutoMove_Result_All._itemSlot[waypointKey][listIndex]
        if slot == nil then
          local itemSlotBagckground = UI.createAndCopyBasePropertyControl(PaGlobal_AutoMove_Result_All._ui._frame_content_stc_group, "Static_ItemSlotBg", PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content, "wg_" .. waypointKey .. "_slotBG_" .. listIndex)
          local itemSlot = {}
          SlotItem.new(itemSlot, "wg_" .. waypointKey .. "_slot_" .. listIndex, listIndex, itemSlotBagckground, PaGlobal_AutoMove_Result_All._SLOT_CONFIG)
          itemSlot:createChild()
          itemSlot.iconBg = itemSlotBagckground
          itemSlotBagckground:SetPosX(15 + (PaGlobal_AutoMove_Result_All._ICON_SIZE + 10) * col)
          itemSlotBagckground:SetPosY(45 + (PaGlobal_AutoMove_Result_All._ICON_SIZE + 10) * row)
          itemSlotBagckground:SetShow(true)
          itemSlot.icon:SetAutoDisableTime(0.5)
          PaGlobal_AutoMove_Result_All._itemSlot[waypointKey][listIndex] = itemSlot
          slot = itemSlot
        end
        local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(item.itemKey))
        if itemStatic == nil then
          return
        end
        slot.iconBg:SetShow(true)
        slot:setItemByStaticStatus(itemStatic, item.itemCount, nil, nil, nil, nil, nil, nil, nil, nil, item.isSealed, nil, nil, true)
        slot.count:SetText(tostring(item.itemCount))
        slot.count:SetShow(true)
        slot._item = item.itemKey
        Panel_Tooltip_Item_SetPosition(item.itemKey, slot, "autoMove")
        if PaGlobal_AutoMove_Result_All._isConsole == true then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_All(" .. waypointKey .. "," .. listIndex .. ", true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_All(" .. waypointKey .. "," .. listIndex .. ", false)")
          if true == _ContentsGroup_RenewUI_Tooltip then
            slot.iconBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_Detail(" .. waypointKey .. "," .. listIndex .. ", true)")
          end
        else
          local evtMouseOn = "Mouse_On"
          local evtMouseOut = "Mouse_Out"
          slot.icon:addInputEvent(evtMouseOn, "HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_All(" .. waypointKey .. "," .. listIndex .. ", true)")
          slot.icon:addInputEvent(evtMouseOut, "HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_All(" .. waypointKey .. "," .. listIndex .. ", false)")
        end
      end
      PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content:SetPosY(nextPosY)
      nextPosY = nextPosY + PaGlobal_AutoMove_Result_All._waypointGroup[waypointKey].content:GetSizeY()
      PaGlobal_AutoMove_Result_All._ui._frame_content:SetSize(PaGlobal_AutoMove_Result_All._ui._frame_content:GetSizeX(), nextPosY)
    end
  end
  if nextPosY <= 0 then
    PaGlobal_AutoMove_Result_All._ui._frame_content_verticalScroll:SetShow(false)
    return
  end
  local tempSizeY = PaGlobal_AutoMove_Result_All._ui._frame_content_verticalScroll:GetSizeY() * (PaGlobal_AutoMove_Result_All._CONTENT_FRAME_SIZE_Y / nextPosY)
  PaGlobal_AutoMove_Result_All._ui._frame_content_verticalScroll_ctrlButton:SetSize(PaGlobal_AutoMove_Result_All._ui._frame_content_verticalScroll_ctrlButton:GetSizeX(), tempSizeY)
  PaGlobal_AutoMove_Result_All._ui._frame_autoMove:UpdateContentScroll()
  PaGlobal_AutoMove_Result_All._ui._frame_autoMove:UpdateContentPos()
  PaGlobal_AutoMove_Result_All._ui._frame_content_verticalScroll:SetControlTop()
end
local ShowAutoMovePreview = function(isCurrentWarehouse)
  local actorKeyRaw = PaGlobal_WareHouse_All._targetActorKeyRaw
  local currentWaypointKey = PaGlobal_WareHouse_All._currentWaypointKey
  local waypointKeyTable
  if isCurrentWarehouse == true then
    waypointKeyTable = {}
    table.insert(waypointKeyTable, currentWaypointKey)
  else
    waypointKeyTable = {}
    for index = 0, PaGlobal_WareHouse_All._maxTerritoryKeyCount - 1 do
      if PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index] ~= nil then
        for wIndex = 1, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index]._count do
          table.insert(waypointKeyTable, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index][wIndex])
        end
      end
    end
  end
  if actorKeyRaw == nil then
    actorKeyRaw = 0
  end
  if ToClient_requestAutoMovePreview(actorKeyRaw, waypointKeyTable, currentWaypointKey, Inventory_GetCurrentInventoryType(), PaGlobal_Warehouse_All_OpenByMaidCheck()) == 0 then
    PaGlobal_AutoMove_Result_All:ResetSlot()
    PaGlobal_AutoMove_Result_All:SetData(actorKeyRaw, waypointKeyTable)
    PaGlobal_AutoMove_Result_All:UpdateAutoMoveResult(actorKeyRaw, waypointKeyTable)
    PaGlobal_AutoMove_Result_All:open()
  else
  end
end
local SetRadioButton = function(isCurrentWarehouse)
  if isCurrentWarehouse == true then
  else
  end
  PaGlobal_AutoMove_Result_All._isCurrentWarehouse = isCurrentWarehouse
end
function PaGlobal_AutoMove_Result_All:Update_SelectRadio(isCurrentWarehouse)
  if Panel_AutoMove_Result_All == nil then
    return
  end
  SetRadioButton(isCurrentWarehouse)
  ShowAutoMovePreview(isCurrentWarehouse)
end
function PaGlobal_AutoMove_Result_All:GetWayPointKeyTable_XXX()
  local waypointKeyTable = {}
  for index = 0, PaGlobal_WareHouse_All._maxTerritoryKeyCount - 1 do
    if PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index] ~= nil then
      for wIndex = 1, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index]._count do
        table.insert(waypointKeyTable, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index][wIndex])
      end
    end
  end
  return waypointKeyTable
end
function PaGlobal_AutoMove_Result_All:updateMoveItemCount_XXX(moveItemCount)
  if moveItemCount == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_EMPTY"))
  else
    PaGlobal_ItemMoveSet._fromItemCount = moveItemCount
  end
end
function HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_All(waypointKey, index, isOn)
  if PaGlobal_AutoMove_Result_All._itemData[waypointKey] == nil or PaGlobal_AutoMove_Result_All._itemData[waypointKey][index] == nil then
    return
  end
  local panelPosX = Panel_AutoMove_Result_All:GetPosX()
  local panelSizeX = Panel_AutoMove_Result_All:GetSizeX()
  local screenSizeX = getScreenSizeX()
  local tooltipX = 0
  local tooltipPanel
  if _ContentsGroup_NewUI_Tooltip_All == true then
    tooltipPanel = Panel_Widget_Tooltip_Item_All
  else
    tooltipPanel = Panel_Tooltip_Item
  end
  if _ContentsGroup_NewUI_Tooltip_All == true then
    if screenSizeX < panelPosX + panelSizeX + tooltipPanel:GetSizeX() then
      tooltipX = panelPosX - tooltipPanel:GetSizeX()
    else
      tooltipX = panelPosX + panelSizeX
    end
  elseif screenSizeX < panelPosX + panelSizeX + tooltipPanel:GetSizeX() then
    tooltipX = panelPosX - tooltipPanel:GetSizeX()
  else
    tooltipX = panelPosX + panelSizeX
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    else
      local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_AutoMove_Result_All._itemData[waypointKey][index].itemKey))
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, PaGlobal_AutoMove_Result_All._itemSlot[waypointKey][index].icon, "WareHouse")
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  Panel_Tooltip_Item_Show_GeneralStatic(PaGlobal_AutoMove_Result_All._itemData[waypointKey][index].itemKey, "autoMove", isOn, false, tooltipX, Panel_AutoMove_Result_All:GetPosY())
end
function HandleEventOn_PaGlobal_AutoMove_Result_SlotTooltip_Detail(waypointKey, index, isOn)
  if PaGlobal_AutoMove_Result_All._itemData[waypointKey] == nil or PaGlobal_AutoMove_Result_All._itemData[waypointKey][index] == nil then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    else
      local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_AutoMove_Result_All._itemData[waypointKey][index].itemKey))
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "WareHouse")
    end
    return
  end
end
