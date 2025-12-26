function PaGlobalFunc_ClothInventory_All_Open()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  PaGlobal_ClothInventory_All:prepareOpen()
end
function PaGlobalFunc_ClothInventory_All_Close()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  PaGlobal_ClothInventory_All:prepareClose()
  PaGlobalFunc_ClothInventory_Renew_All_Close()
end
function PaGlobalFunc_ClothInventory_All_GetShow()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  return Panel_Window_ClothInventory_All:GetShow()
end
function FromClient_ClothInventory_All_ShowInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  UI.ASSERT_NAME(nil ~= bagType, "FromClient_ClothInventory_All_ShowInventoryBag bagType nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= bagSize, "FromClient_ClothInventory_All_ShowInventoryBag bagSize nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= fromWhereType, "FromClient_ClothInventory_All_ShowInventoryBag fromWhereType nil", "\235\176\149\236\132\156\236\156\164")
  UI.ASSERT_NAME(nil ~= fromSlotNo, "FromClient_ClothInventory_All_ShowInventoryBag fromSlotNo nil", "\235\176\149\236\132\156\236\156\164")
  if bagType == __eInventoryBagType_CashRenew then
    return
  end
  PaGlobal_ClothInventory_All:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
end
function PaGlobalFunc_ClothInventory_All_UpdateInventoryBag()
  if false == Panel_Window_ClothInventory_All:GetShow() then
    return
  end
  PaGlobal_ClothInventory_All:updateInventoryBag()
end
function PaGloablFunc_ClothInventory_All_SetFilter(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_ClothInventory_All
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
  if __eInventoryBagType_Misc == self._inventoryBagType and itemSSW:isUserVested() == false and itemWrapper:get():isVested() == true then
    return true
  end
  if ToClient_CheckToPushToInventoryBag(self._fromWhereType, self._fromSlotNo, self._fromWhereType, slotNo) == false then
    return true
  end
  if self._bagType == CppEnums.ItemWhereType.eCashInventory then
    if Inventory_GetCurrentInventoryType() == 0 then
      return true
    end
  elseif self._bagType == CppEnums.ItemWhereType.eInventory and Inventory_GetCurrentInventoryType() == 17 then
    return true
  end
  if self._inventoryBagType == __eInventoryBagType_Misc or self._inventoryBagType == __eInventoryBagType_MiscForCash then
    if 0 < itemSSW:get()._expirationPeriod then
      return true
    end
    return false
  elseif self._inventoryBagType == __eInventoryBagType_Cash or self._inventoryBagType == __eInventoryBagType_Equipment or self._inventoryBagType == __eInventoryBagType_CashBig then
    local myClass = selfPlayer:getClassType()
    local isEquipItem = itemSSW:isEquipable()
    local isUsableItem = itemSSW:get()._usableClassType:isOn(myClass)
    local isPushableItem = itemWrapper:isPushableInventoryBag()
    if isEquipItem == true and isUsableItem == true and isPushableItem == true then
      return false
    end
  elseif self._inventoryBagType == __eInventoryBagType_Seed then
    local isSeed = itemSSW:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Seed
    if isSeed == true then
      return false
    end
  elseif self._inventoryBagType == __eInventoryBagType_Fish then
    local isFishItemNotDried = itemSSW:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Fish and 0 < itemSSW:get()._expirationPeriod
    local s64_remainingTime = getLeftSecond_s64(itemWrapper:getExpirationDate())
    if isFishItemNotDried == true and s64_remainingTime ~= Defines.s64_const.s64_0 then
      return false
    end
  else
    _PA_ASSERT(false, "\236\149\132\236\157\180\237\133\156 \234\176\128\235\176\169 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.")
  end
  return true
end
function HandleEventRUp_ClothInventory_All_InvenRClick(slotNo, selectedItemWrapper, count, inventoryType)
  local self = PaGlobal_ClothInventory_All
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
  local isFishBag = self._inventoryBagType == __eInventoryBagType_Fish
  local isSeedBag = self._inventoryBagType == __eInventoryBagType_Seed
  if isFishBag == true or isSeedBag == true then
    local bagFreeCount = getInventoryBagFreeCount(self._fromWhereType, self._fromSlotNo)
    if bagFreeCount == 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventorySlotMax"))
      return
    end
    local inventory = getSelfPlayer():get():getInventoryByType(self._fromWhereType)
    if inventory == nil then
      return
    end
    itemCount_s64 = toInt64(0, 1)
    local selectedItemNoRaw = selectedItemWrapper:getItemNoRaw()
    local selectedItemKey = selectedItemWrapper:get():getKey():getItemKey()
    local invenMaxSize = inventory:sizeXXX()
    for ii = 0, invenMaxSize - 1 do
      local itemWrapper = getInventoryItemByType(self._fromWhereType, ii)
      if itemWrapper ~= nil and itemWrapper:getItemNoRaw() ~= selectedItemNoRaw then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        if itemKey == selectedItemKey then
          if isFishBag == true then
            local s64_remainingTime = getLeftSecond_s64(itemWrapper:getExpirationDate())
            if s64_remainingTime ~= Defines.s64_const.s64_0 then
              itemCount_s64 = itemCount_s64 + toInt64(0, 1)
            end
          else
            itemCount_s64 = itemCount_s64 + toInt64(0, 1)
          end
        end
      end
    end
    if bagFreeCount < Int64toInt32(itemCount_s64) then
      itemCount_s64 = toInt64(0, bagFreeCount)
    end
    if __eConcurrentProcessingItemCount < Int64toInt32(itemCount_s64) then
      itemCount_s64 = toInt64(0, __eConcurrentProcessingItemCount)
    end
    useNumberPad = 1 < Int64toInt32(itemCount_s64)
  else
    itemCount_s64 = selectedItemWrapper:get():getCount_s64()
    useNumberPad = itemStatic:isStackable() and 1 < Int64toInt32(itemCount_s64)
  end
  if useNumberPad == true then
    Panel_NumberPad_Show(true, itemCount_s64, nil, function(inputNumber)
      ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, self._fromWhereType, self._fromSlotNo, inputNumber)
    end)
  else
    ToClient_ReqPushInventoryItemToInventoryBag(inventoryType, slotNo, self._fromWhereType, self._fromSlotNo, 1)
  end
end
function HandleEventRUp_ClothInventory_All_ClothInvenRClick(fromWhereType, fromSlotNo, bagIndex, bagWhereType)
  local self = PaGlobal_ClothInventory_All
  if self == nil then
    return
  end
  local selectedItemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, bagIndex)
  if selectedItemWrapper == nil then
    return
  end
  local itemCount_s64 = toInt64(0, 0)
  local useNumberPad = false
  if self._inventoryBagType == __eInventoryBagType_Fish or self._inventoryBagType == __eInventoryBagType_Seed then
    local inventory = getSelfPlayer():get():getInventoryByType(self._fromWhereType)
    if inventory == nil then
      return
    end
    local inventoryFreeCount = inventory:getFreeCount()
    if inventoryFreeCount == 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventorySlotMax"))
      return
    end
    local selectedItemKey = selectedItemWrapper:get():getKey():getItemKey()
    for index = 0, self._bagSize - 1 do
      local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, index)
      if itemWrapper ~= nil then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        if itemKey == selectedItemKey then
          itemCount_s64 = itemCount_s64 + toInt64(0, 1)
        end
      end
    end
    if inventoryFreeCount < Int64toInt32(itemCount_s64) then
      itemCount_s64 = toInt64(0, inventoryFreeCount)
    end
    if __eConcurrentProcessingItemCount < Int64toInt32(itemCount_s64) then
      itemCount_s64 = toInt64(0, __eConcurrentProcessingItemCount)
    end
    useNumberPad = 1 < Int64toInt32(itemCount_s64)
  else
    itemCount_s64 = selectedItemWrapper:get():getCount_s64()
    useNumberPad = selectedItemWrapper:getStaticStatus():isStackable() and 1 < Int64toInt32(itemCount_s64)
  end
  if useNumberPad == true then
    Panel_NumberPad_Show(true, itemCount_s64, nil, function(inputNumber)
      ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, inputNumber)
    end)
  else
    ToClient_ReqPopInventoryBagItemToInventory(fromWhereType, fromSlotNo, bagIndex, bagWhereType, 1)
  end
end
function PaGlobalFunc_ClothInventory_All_ChangeAllItem()
  local self = PaGlobal_ClothInventory_All
  if self == nil then
    return
  end
  if PaGlobalFunc_ClothInventory_All_GetShow() == false then
    return
  end
  ToClient_ReqEquipItemFromInventoryBag(self._fromWhereType, self._fromSlotNo)
end
function PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(isShow, fromWhereType, fromSlotNo, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  PaGlobal_ClothInventory_All._currSlotInfo.index = index
  PaGlobal_ClothInventory_All._currSlotInfo.fromSlotNo = fromSlotNo
  PaGlobal_ClothInventory_All._currSlotInfo.fromWhereType = fromWhereType
  if nil == fromWhereType or nil == fromSlotNo or nil == index then
    return
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if nil ~= itemWrapper then
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, PaGlobal_ClothInventory_All._slot[index].icon)
    else
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_ClothInventory_All._slot[index].icon, false, true, nil, nil, nil, nil, "InventoryBag", fromSlotNo)
    end
  end
end
function PaGlobalFunc_ClothInventory_All_ShowDetailToolTip(fromWhereType, fromSlotNo, index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local index = PaGlobal_ClothInventory_All._currSlotInfo.index
  local fromSlotNo = PaGlobal_ClothInventory_All._currSlotInfo.fromSlotNo
  local fromWhereType = PaGlobal_ClothInventory_All._currSlotInfo.fromWhereType
  if nil == fromWhereType or nil == fromSlotNo or nil == index then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_ClothInventory_All._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
  end
end
