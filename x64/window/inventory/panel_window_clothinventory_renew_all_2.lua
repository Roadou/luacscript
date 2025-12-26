function PaGlobalFunc_ClothInventory_Renew_All_Open()
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return true
  end
  self:prepareOpen()
end
function PaGlobalFunc_ClothInventory_Renew_All_Close()
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return true
  end
  self:prepareClose()
end
function PaGlobalFunc_ClothInventory_Renew_All_GetShow()
  if Panel_Window_ClothInventory_Renew_All == nil then
    return false
  end
  return Panel_Window_ClothInventory_Renew_All:GetShow()
end
function FromClient_ClothInventory_Renew_All_ShowInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return true
  end
  if bagType ~= __eInventoryBagType_CashRenew then
    return
  end
  self:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
end
function PaGlobalFunc_ClothInventory_Renew_All_UpdateInventoryBag()
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return true
  end
  self:updateInventoryBag()
end
function PaGloablFunc_ClothInventory_Renew_All_SetFilter(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return true
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return true
  end
  if itemWrapper == nil then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if isDuplicatedForDuel == true then
    return true
  end
  local isOriginalForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if isOriginalForDuel == true then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW:get():checkToPushToInventoryBag() == false then
    return true
  end
  if ToClient_CheckToPushToInventoryBag(self._fromWhereType, self._fromSlotNo, self._fromWhereType, slotNo) == false then
    return true
  end
  if Inventory_GetCurrentInventoryType() == 0 then
    return true
  end
  local myClass = selfPlayer:getClassType()
  local isEquipItem = itemSSW:isEquipable()
  local isUsableItem = itemSSW:get()._usableClassType:isOn(myClass)
  local isPushableItem = itemWrapper:isPushableInventoryBag()
  if isEquipItem == true and isUsableItem == true and isPushableItem == true then
    return false
  end
  return true
end
function HandleEventRUp_ClothInventory_Renew_All_InvenRClick(slotNo, selectedItemWrapper, count, inventoryType)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  if selectedItemWrapper == nil then
    return
  end
  local itemStatic = selectedItemWrapper:getStaticStatus()
  if itemStatic == nil then
    return
  end
  if itemStatic:get():checkToPushToInventoryBag() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_INPUTALERT"))
    return
  end
  local itemCount_s64 = toInt64(0, 0)
  local useNumberPad = false
  itemCount_s64 = selectedItemWrapper:get():getCount_s64()
  useNumberPad = itemStatic:isStackable() and Int64toInt32(itemCount_s64) > 1
  if useNumberPad == true then
    Panel_NumberPad_Show(true, itemCount_s64, nil, function(inputNumber)
      ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, self._fromWhereType, self._fromSlotNo, inputNumber)
    end)
  else
    ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, self._fromWhereType, self._fromSlotNo, 1)
  end
end
function HandleEventRUp_ClothInventory_Renew_All_ClothInvenRClick(fromWhereType, fromSlotNo, bagIndex, bagWhereType)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  local selectedItemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, bagIndex)
  if selectedItemWrapper == nil then
    return
  end
  local itemCount_s64 = toInt64(0, 0)
  local useNumberPad = false
  itemCount_s64 = selectedItemWrapper:get():getCount_s64()
  useNumberPad = selectedItemWrapper:getStaticStatus():isStackable() and Int64toInt32(itemCount_s64) > 1
  if useNumberPad == true then
    Panel_NumberPad_Show(true, itemCount_s64, nil, function(inputNumber)
      ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, inputNumber)
    end)
  else
    ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, 1)
  end
end
function PaGlobalFunc_ClothInventory_Renew_All_ChangeAllItem()
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  if Panel_Window_ClothInventory_Renew_All == nil then
    return
  end
  if Panel_Window_ClothInventory_Renew_All:GetShow() == false then
    return
  end
  ToClient_ReqEquipAllItemFromInventoryBag(self._fromWhereType, self._fromSlotNo)
end
function PaGlobalFunc_ClothInventory_Renew_All_ShowTooltip(isShow, fromWhereType, fromSlotNo, index)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  self._currSlotInfo.index = index
  self._currSlotInfo.fromSlotNo = fromSlotNo
  self._currSlotInfo.fromWhereType = fromWhereType
  if index == nil or fromSlotNo == nil or fromWhereType == nil then
    return
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if itemWrapper ~= nil then
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, Panel_Window_ClothInventory_Renew_All)
    else
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_ClothInventory_Renew_All, false, true, nil, nil, nil, nil, "InventoryBag", fromSlotNo)
    end
  end
end
function PaGlobalFunc_ClothInventory_Renew_All_ShowDetailToolTip(fromWhereType, fromSlotNo, index)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local index = self._currSlotInfo.index
  local fromSlotNo = self._currSlotInfo.fromSlotNo
  local fromWhereType = self._currSlotInfo.fromWhereType
  if index == nil or fromSlotNo == nil or fromWhereType == nil then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if self._isUsePadSnapping == true then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if itemWrapper ~= nil then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
  end
end
function HandleEventOnOut_ClothInventory_Renew_All_EmptySlotTooltip(slotNo, isOn)
  local self = PaGlobal_ClothInventory_Renew_All
  if self == nil then
    return
  end
  local classType = getSelfPlayer():getClassType()
  local originSlotBg = self._ui._slotBg[slotNo]
  if originSlotBg == nil then
    return
  end
  if isOn == true then
    if classType == __eClassType_ShyWaman and slotNo == 7 then
      self._ui._txt_tooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH"))
    else
      self._ui._txt_tooltip:SetText(self._slotNoIdToString[slotNo])
    end
    self._ui._txt_tooltip:SetSize(self._ui._txt_tooltip:GetTextSizeX() + 30, 20)
    self._ui._txt_tooltip:SetPosX(originSlotBg:GetPosX() - self._ui._txt_tooltip:GetTextSizeX())
    if self._ui._txt_tooltip:GetPosX() < 0 then
      self._ui._txt_tooltip:SetPosX(0)
    end
    self._ui._txt_tooltip:SetPosY(originSlotBg:GetPosY() + originSlotBg:GetSizeY() / 2 + self._ui._txt_tooltip:GetSizeY())
    self._ui._txt_tooltip:SetShow(true)
  else
    self._ui._txt_tooltip:SetShow(false)
    Panel_Tooltip_Item_hideTooltip()
  end
end
