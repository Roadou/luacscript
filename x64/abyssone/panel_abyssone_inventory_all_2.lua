function PaGlobal_AbyssOne_Inventory_All_Open()
  PaGlobal_AbyssOne_Inventory_All:prepareOpen()
end
function PaGlobal_AbyssOne_Inventory_All_GetOpen()
  return Panel_AbyssOne_EquipPresetList:GetShow()
end
function PaGlobal_AbyssOne_Inventory_All_Close()
  PaGlobal_AbyssOne_Inventory_All:prepareClose()
end
function PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl()
  PaGlobal_AbyssOne_Inventory_All:updateInvenControl()
end
function PaGlobal_AbyssOne_Inventory_All_ClearPadSnap()
  local self = PaGlobal_AbyssOne_Inventory_All
  if self == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self:clerPadSnap()
end
function PaGlobal_AbyssOne_Inventory_All_SetShowWithFilter(actorTypeRaw)
  local self = PaGlobal_AbyssOne_Inventory_All
  if self == nil then
    return
  end
  PaGlobal_AbyssOne_Inventory_All_Open()
  if CppEnums.ActorType.ActorType_Player == actorTypeRaw or CppEnums.ActorType.ActorType_Deadbody == actorTypeRaw then
    AbyssOne_Inventory_SetFunctor(PaGlobal_AbyssOne_Inventory_All_FilterDead, PaGlobal_AbyssOne_Inventory_All_UseItemTarget, PaGlobal_AbyssOne_Inventory_All_Close, nil)
  elseif CppEnums.ActorType.ActorType_Vehicle == actorTypeRaw then
    AbyssOne_Inventory_SetFunctor(PaGlobal_AbyssOne_Inventory_All_FilterFodder, PaGlobal_AbyssOne_Inventory_All_UseItemTarget, PaGlobal_AbyssOne_Inventory_All_Close, nil)
  elseif CppEnums.ActorType.ActorType_Npc == actorTypeRaw then
    AbyssOne_Inventory_SetFunctor(PaGlobal_AbyssOne_Inventory_All_FilterFuel, PaGlobal_AbyssOne_Inventory_All_UseFuelItem, PaGlobal_AbyssOne_Inventory_All_Close, nil)
  end
end
function AbyssOne_Inventory_SetFunctor(filterFunction, rClickFunction, otherWindowOpenFunction, effect)
  local self = PaGlobal_AbyssOne_Inventory_All
  if self == nil then
    return
  end
  if self._otherWindowOpenFunc ~= nil and otherWindowOpenFunction ~= nil then
    local otherWindowOpenFuncDiff = self._otherWindowOpenFunc ~= otherWindowOpenFunction
    if otherWindowOpenFuncDiff == true and (filterFunction ~= nil or rClickFunction ~= nil or otherWindowOpenFunction ~= nil) then
      self._otherWindowOpenFunc()
    end
  end
  if filterFunction ~= nil and "function" ~= type(filterFunction) then
    filterFunction = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if rClickFunction ~= nil and "function" ~= type(rClickFunction) then
    rClickFunction = nil
    UI.ASSERT(false, "Param 2 must be Function type")
  end
  if effect ~= nil and "function" ~= type(effect) then
    effect = nil
    UI.ASSERT(false, "Param 4 must be Function type")
  end
  self._filterFunc = filterFunction
  self._rClickFunc = rClickFunction
  self._otherWindowOpenFunc = otherWindowOpenFunction
  self._effect = effect
  if PaGlobal_AbyssOne_Inventory_All_GetOpen() == true then
    PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl()
  end
end
function PaGlobal_AbyssOne_Inventory_All_FilterDead(slotNo, itemWrapper)
  if itemWrapper == nil then
    return true
  end
  if itemWrapper:getStaticStatus():get()._key:getItemKey() == 54002 then
    if ToClient_IsAnySiegeBeingOfMyChannel() == true then
      return true
    else
      return false
    end
  end
  return itemWrapper:getStaticStatus():get():isItemTargetAlive() == true or itemWrapper:checkConditions() == false
end
function PaGlobal_AbyssOne_Inventory_All_FilterFodder(slotNo, itemWrapper)
  if itemWrapper == nil then
    return true
  end
  return itemWrapper:getStaticStatus():get():isUseToVehicle() == false or itemWrapper:checkConditions() == false
end
function PaGlobal_AbyssOne_Inventory_All_FilterFuel(slotNo, itemWrapper)
  if itemWrapper == nil then
    return true
  end
  return isFusionItem(Inventory_GetCurrentInventoryType(), slotNo) == false
end
function PaGlobal_AbyssOne_Inventory_All_UseItemTarget(slotNo, itemWrapper, count_s64, inventoryType)
  if checkManufactureAction() == true or checkAlchemyAction() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  local isTargetSelfPlayer = false
  inventoryUseItem(inventoryType, slotNo, isTargetSelfPlayer)
end
function PaGlobal_AbyssOne_Inventory_All_UseFuelItem(slotNo, itemWrapper, count_s64, inventoryType)
  burnItemToActor(inventoryType, slotNo, 1, false)
end
function PaGlobal_AbyssOne_Inventory_All_Reset()
  PaGlobal_AbyssOne_Inventory_All:reset()
end
function PaGlobal_AbyssOne_Inventory_All_SetScrolShow(isShow)
  PaGlobal_AbyssOne_Inventory_All:SetScrolShow(isShow)
end
function HandleEventScroll_AbyssOne_Inventory_All_UpdateScroll(isUp)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local useStartSlot = inventorySlotNoUserStart()
  local currentWhereType = CppEnums.ItemWhereType.eInstanceInventory
  local inventory = selfPlayer:getInventoryByType(currentWhereType)
  local inventoryMaxSize = inventory:sizeXXX()
  local maxSize = inventoryMaxSize - useStartSlot
  local prevSlotIndex = PaGlobal_AbyssOne_Inventory_All._startSlotIndex
  PaGlobal_AbyssOne_Inventory_All._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_AbyssOne_Inventory_All._ui.scroll_inven, isUp, PaGlobal_AbyssOne_Inventory_All.config.slotRows, maxSize, PaGlobal_AbyssOne_Inventory_All._startSlotIndex, PaGlobal_AbyssOne_Inventory_All.config.slotCols)
  local intervalSlotIndex = PaGlobal_AbyssOne_Inventory_All.INVEN_MAX_COUNT - PaGlobal_AbyssOne_Inventory_All.INVEN_CURRENTSLOT_COUNT
  if prevSlotIndex == 0 and PaGlobal_AbyssOne_Inventory_All._startSlotIndex == 0 or prevSlotIndex == intervalSlotIndex and PaGlobal_AbyssOne_Inventory_All._startSlotIndex == intervalSlotIndex then
    return
  end
  PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl()
end
function HandleEventOnOut_AbyssOne_Inventory_All_ShowTooltip(isShow, index)
  if isShow == nil or index == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local slot = PaGlobal_AbyssOne_Inventory_All.slots[index]
  if slot == nil then
    return
  end
  local slotNo = slot._slotNo
  if slotNo == nil then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInstanceInventory
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if itemWrapper == nil then
    return
  end
  if PaGlobal_AbyssOne_EquipPreset._isPad == true then
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = nil
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = slotNo
    if PaGlobal_AbyssOne_EquipPreset._isConsole == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = PaGlobalFunc_TooltipInfo_Open
    else
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = Panel_Tooltip_Item_Show
    end
  else
    Panel_Tooltip_Item_Show(itemWrapper, Panel_AbyssOne_EquipPresetList, false, true)
  end
end
function HandleEventRUp_AbyssOne_Inventory_All_RUpEvent(index)
  if index == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local slotNo = PaGlobal_AbyssOne_Inventory_All.slots[index]._slotNo
  local whereType = CppEnums.ItemWhereType.eInstanceInventory
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local inventory = selfPlayer:getInventoryByType(currentWhereType)
  local invenUseSize = inventory:size()
  if nil == itemWrapper then
    return
  end
  if invenUseSize < slotNo + 1 then
    return
  end
  if nil ~= itemWrapper then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    if nil == itemEnchantWrapper then
      return
    end
    local itemStatic = itemWrapper:getStaticStatus():get()
    if PaGlobal_AbyssOne_Inventory_All._rClickFunc ~= nil then
      PaGlobal_AbyssOne_Inventory_All._rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), whereType)
      return
    end
    if itemEnchantWrapper:get()._vestedType:getItemKey() == 2 and itemWrapper:get():isVested() == false then
    elseif itemWrapper:getStaticStatus():getItemType() == 8 then
    elseif itemEnchantWrapper:isPopupItem() == true then
    elseif itemEnchantWrapper:isExchangeItemNPC() or itemWrapper:isSoulCollector() or 17 == itemWrapper:getStaticStatus():getItemType() then
    elseif itemStatic:isUseToVehicle() == false then
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      if 2 == item_type and true == itemSSW:get():isForJustTrade() then
      else
        local equipType = itemWrapper:getStaticStatus():getEquipType()
        if 16 == equipType or 17 == equipType or 92 == equipType and true == _ContentsGroup_ArtifactItem then
        else
          PaGlobalFunc_AbyssOne_Inventory_All_UseItemTargetSelf(whereType, slotNo, nil)
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
    end
  end
end
function PaGlobalFunc_AbyssOne_Inventory_All_UseItemTargetSelf(whereType, slotNo, equipSlotNo)
  if nil == equipSlotNo then
    equipSlotNo = __eEquipSlotNoCount
  end
  inventoryUseItem(whereType, slotNo, equipSlotNo, true)
end
function PaGlobalFunc_AbyssOne_Inventory_All_UpdatePerFrame(deltaTime)
  if deltaTime <= 0 then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local currentWhereType = CppEnums.ItemWhereType.eInstanceInventory
  for ii = 0, PaGlobal_AbyssOne_Inventory_All.config.slotCount - 1 do
    local slot = PaGlobal_AbyssOne_Inventory_All.slots[ii]
    local slotNo = slot._slotNo
    local remainTime = 0
    local itemReuseTime = 0
    local realRemainTime = 0
    local intRemainTime = 0
    if slotNo ~= __eTInventorySlotNoUndefined and slotNo ~= nil then
      remainTime = getItemCooltime(currentWhereType, slotNo)
      itemReuseTime = getItemReuseCycle(currentWhereType, slotNo)
      realRemainTime = remainTime * itemReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
    end
    if remainTime > 0 then
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if itemReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
    elseif slot.cooltime:GetShow() then
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
      audioPostEvent_SystemUi(2, 1)
    end
  end
end
function FromClient_AbyssOneInventory_All_AddItem(itemKey, slotNo, itemCount, whereType)
  if whereType ~= CppEnums.ItemWhereType.eInstanceInventory then
    return
  end
  PaGlobal_AbyssOne_Inventory_All_UpdateInvenControl()
end
