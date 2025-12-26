local _panel = Panel_Window_MarketPlaceWallet
local MarketWallet = {
  _moneySlot = 0,
  _mileageSlot = 0,
  _isOpen = false
}
local _isInventoryOpen = false
function MarketWallet:init()
  self._moneySlot = getMoneySlotNo()
  self._mileageSlot = getMileageSlotNo()
  self:registEvent()
end
function MarketWallet:registEvent()
  registerEvent("FromClient_requestMyWalletList", "FromClient_MarketPlace_RequestMyWalletList")
  registerEvent("FromClient_requestPush", "FromClient_MarketPlace_RequestPush")
  registerEvent("FromClient_requestPop", "FromClient_MarketPlace_RequestPop")
end
function MarketWallet:open(isWaretype)
  PaGlobalFunc_MarketPlace_MyInven_Update()
  ToClient_requestMyWalletList(__eWorldMarketKeyType_Item)
  if _ContentsGroup_UsePadSnapping == false and Panel_Window_Inventory_All:GetShow() == true then
    _isInventoryOpen = true
    PaGlobalFunc_Inventory_All_Close()
  end
  PaGlobalFunc_MarketPlace_MyInven_Open(isWaretype)
  PaGlobalFunc_MarketPlace_WalletInven_Open()
  self._isOpen = true
end
function MarketWallet:close()
  PaGlobalFunc_MarketPlace_MyInven_Close()
  PaGlobalFunc_MarketPlace_WalletInven_Close()
  Panel_Tooltip_Item_hideTooltip()
  if _isInventoryOpen == true then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
    _isInventoryOpen = false
  end
  self._isOpen = false
end
function PaGlobalFunc_MarketWallet_GetShow()
  return true == PaGlobalFunc_MarketPlace_WalletInven_GetShow() or true == PaGlobalFunc_MarketPlace_MyInven_GetShow()
end
function PaGlobalFunc_MarketWallet_Init()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  self:init()
end
function PaGlobalFunc_MarketWallet_Open(isWaretype)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if isWaretype == nil then
    PaGlobal_Warehouse_All_ResetCurrentWaypoint()
  end
  ToClient_requestMyWalletList(__eWorldMarketKeyType_Item)
  ToClient_WorldMarketOpen()
  self:open(isWaretype)
end
function PaGlobalFunc_MarketWallet_ForceClose()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  ToClient_WorldMarketClose()
  self:close()
end
function PaGlobalFunc_MarketWallet_Close()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
    PaGlobalFunc_MarketPlace_CloseFromMaid()
    return
  end
  ToClient_WorldMarketClose()
  self:close()
end
function InputMRUp_MarketWallet_RegisterMoney()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local money = Defines.s64_const.s64_0
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, self._moneySlot)
  if nil ~= moneyItemWrapper then
    money = moneyItemWrapper:get():getCount_s64()
  end
  Panel_NumberPad_Show(true, money, self._moneySlot, InputMRUp_MarketWallet_Register, false, false, false, true)
end
function InputMRUp_MarketWallet_WithdrawMoney()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local itemMysilverInfo = getWorldMarketSilverInfo()
  local itemCount = itemMysilverInfo:getItemCount()
  local itemEnchantKey = itemMysilverInfo:getEnchantKey()
  Panel_NumberPad_Show(true, itemCount, itemEnchantKey, InputMRUp_MarketWallet_Withdraw, false)
end
function InputMRUp_MarketWallet_WithdrawMoney_WithCaution()
  if MarketWallet == nil then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local itemMysilverInfo = getWorldMarketSilverInfo()
  local itemCount = itemMysilverInfo:getItemCount()
  local itemEnchantKey = itemMysilverInfo:getEnchantKey()
  Panel_NumberPad_Show(true, itemCount, itemEnchantKey, InputMRUp_MarketWallet_WithdrawMoney_WithCaution_CallBack, false)
end
function InputMRUp_MarketWallet_WithdrawMoney_WithCaution_CallBack(inputNumber, param0)
  local function doFunction()
    InputMRUp_MarketWallet_Withdraw(inputNumber, param0)
  end
  local availableMaidCount = ToClient_getUsableMaidCountByType(true)
  if availableMaidCount == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_MESSAGE", "count", availableMaidCount)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = doFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function InputMLUp_MarketWallet_RegisterMileage()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if false == _ContentsGroup_OldMoonSmelting then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  Panel_NumberPad_Show(true, selfPlayer:getMileage(), self._mileageSlot, InputMRUp_MarketWallet_Register, false, true, false, false)
end
function InputMLUp_MarketWallet_WithdrawMileage()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if false == _ContentsGroup_OldMoonSmelting then
    return
  end
  local itemMyMileageInfo = getWorldMarketMileageInfo()
  local itemCount = itemMyMileageInfo:getItemCount()
  local itemEnchantKey = itemMyMileageInfo:getEnchantKey()
  Panel_NumberPad_Show(true, itemCount, itemEnchantKey, InputMRUp_MarketWallet_WithdrawForMileage)
end
function InputMRUp_MarketWallet_MoveInvenToWallet(slotNo)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local itemCount = Defines.s64_const.s64_0
  local itemWrapper
  local whereType = PaGlobalFunc_MarketPlace_GetMyInvenTab()
  if whereType == CppEnums.ItemWhereType.eWarehouse then
    local warehouseWrapper = warehouse_get(PaGlobal_Warehouse_All_GetCurrentWaypoint())
    if nil == warehouseWrapper then
      return
    end
    itemWrapper = warehouseWrapper:getItem(slotNo)
  else
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if nil == itemWrapper then
    _PA_ASSERT(false, "\236\149\132\236\157\180\237\133\156 \234\179\160\236\160\149 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.!! : MarketWallet")
    return
  end
  local function excute()
    local isStackable = itemWrapper:getStaticStatus():isStackable()
    if false == isStackable and false == _ContentsGroup_MoveNonStackItem then
      InputMRUp_MarketWallet_Register(1, slotNo)
      return
    end
    if true == _ContentsGroup_MoveNonStackItem and false == isStackable then
      itemCount = toInt64(0, ToClient_getNonStackItemCount(whereType, slotNo, true, PaGlobal_WareHouse_All._currentWaypointKey))
      if itemCount < toInt64(0, 1) then
        InputMRUp_MarketWallet_Register(1, slotNo)
        return
      end
    else
      itemCount = itemWrapper:get():getCount_s64()
    end
    if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
      local weight = itemWrapper:getStaticStatus():getWorldMarketVolume()
      if toInt64(0, 0) ~= weight then
        local buffRate = 1
        local applyStarter = getSelfPlayer():get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
        if true == _ContentsGroup_Kamasilv_TradeBuff and true == applyStarter then
          buffRate = 2
        end
        local maxCountByWeight = toInt64(0, __eTWorldTradeMarketMaxVolumeByMaid * buffRate) / weight
        if true == _ContentsGroup_UseMultiMaid and true == PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(true) then
          local availableMaidCount = ToClient_getUsableMaidCountByType(true)
          if 0 == availableMaidCount then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
            return
          end
          if false == isStackable then
            maxCountByWeight = toInt64(0, availableMaidCount)
          else
            local possibleCountPerOnceMaid = __eTWorldTradeMarketMaxVolumeByMaid * buffRate
            maxCountByWeight = toInt64(0, possibleCountPerOnceMaid * availableMaidCount) / weight
          end
        elseif true == _ContentsGroup_UseMultiMaid and false == PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(true) and false == isStackable then
          InputMRUp_MarketWallet_Register(1, slotNo)
          return
        end
        if maxCountByWeight < itemCount then
          itemCount = maxCountByWeight
        end
      elseif false == PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(true) and false == isStackable then
        InputMRUp_MarketWallet_Register(1, slotNo)
        return
      end
    end
    Panel_NumberPad_Show(true, itemCount, slotNo, InputMRUp_MarketWallet_Register)
  end
  if true == self:warringCheck(itemWrapper, slotNo) then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WARRING_REGISTITEM")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = excute,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle", false, _ContentsGroup_UsePadSnapping)
  else
    excute()
  end
  if nil ~= self._newItemData and nil ~= self._newItemData._effectId and nil ~= self._newItemData._slotNo and nil ~= self._slotInvenBgData then
    local savedSlotBgIdx = self._newItemData._slotNo
    if nil ~= self._slotInvenBgData[0] then
      local slotBg = self._slotInvenBgData[savedSlotBgIdx]
      slotBg.base:EraseAllEffect()
      self._newItemData = nil
    end
  end
end
function MarketWallet:warringCheck(itemWrapper, slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local dyeAble = itemSSW:isDyeable()
  local _isSealed = itemWrapper:get():isSealed() and itemSSW:isEquipable() and not itemSSW:get():isCash()
  local hasEffect = itemWrapper:hasPurchasedItemEffect()
  if true == dyeAble then
    local dyeingPartCount = itemWrapper:getDyeingPartCount()
    for dyeingPart_Index = 0, dyeingPartCount - 1 do
      local bEmpty = itemWrapper:isEmptyDyeingPartColorAt(dyeingPart_Index)
      if not itemWrapper:isAllreadyDyeingSlot(dyeingPart_Index) then
        bEmpty = true
      end
      if false == bEmpty then
        return true
      end
    end
  end
  if true == _isSealed then
    return true
  end
  if hasEffect == true then
    return true
  end
  if 32 == itemSSW:get():getContentsEventType() or 37 == itemSSW:get():getContentsEventType() then
    local alchemystoneExp = itemWrapper:getExperience() / 10000
    if alchemystoneExp > 0 then
      return true
    end
  end
  return false
end
function InputMRUp_MarketWallet_MoveWalletToInven(slotIdx)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotIdx)
  local itemCount = 0
  local itemEnchantKey = itemMyWalletInfo:getEnchantKey()
  local isSealed = itemMyWalletInfo:isSealed()
  local itemSSW = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
  if nil == itemSSW then
    _PA_ASSERT(false, "\236\149\132\236\157\180\237\133\156 \234\179\160\236\160\149 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.!! : MarketWallet")
    return
  end
  local isStackable = itemSSW:isStackable()
  if false == isStackable and false == _ContentsGroup_MoveNonStackItem then
    InputMRUp_MarketWallet_Withdraw(1, itemEnchantKey, isSealed)
    return
  end
  if false == isStackable and true == itemSSW:isNamingAbleItem() then
    InputMRUp_MarketWallet_Withdraw(1, itemEnchantKey, isSealed)
    return
  end
  itemCount = itemMyWalletInfo:getItemCount()
  if false == isStackable and itemCount < toInt64(0, 1) then
    InputMRUp_MarketWallet_Withdraw(1, itemEnchantKey, isSealed)
    return
  end
  if false == isStackable and itemCount > toInt64(0, __eConcurrentProcessingItemCount) then
    itemCount = toInt64(0, __eConcurrentProcessingItemCount)
  end
  local doFunctionFromTotalSearch = PaGlobalFunc_TotalSearch_GetShow ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true
  if PaGlobalFunc_MarketPlace_IsOpenByMaid() == true or doFunctionFromTotalSearch == true then
    local isUseMultiMaid = true == _ContentsGroup_UseMultiMaid and true == PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(true)
    local weight = itemSSW:getWorldMarketVolume()
    if doFunctionFromTotalSearch == true then
      isUseMultiMaid = false
    end
    if false == isUseMultiMaid and false == isStackable then
      InputMRUp_MarketWallet_Withdraw(1, itemEnchantKey, isSealed)
      return
    end
    if toInt64(0, 0) ~= weight then
      local buffRate = 1
      local applyStarter = getSelfPlayer():get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
      if true == _ContentsGroup_Kamasilv_TradeBuff and true == applyStarter then
        buffRate = 2
      end
      local maxCountByWeight = toInt64(0, __eTWorldTradeMarketMaxVolumeByMaid * buffRate) / weight
      if true == isUseMultiMaid then
        local availableMaidCount = ToClient_getUsableMaidCountByType(true)
        if 0 == availableMaidCount then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
          return
        end
        if false == isStackable then
          maxCountByWeight = toInt64(0, availableMaidCount)
        else
          local possibleCountPerOnceMaid = __eTWorldTradeMarketMaxVolumeByMaid * buffRate
          maxCountByWeight = toInt64(0, possibleCountPerOnceMaid * availableMaidCount) / weight
        end
      end
      if itemCount > maxCountByWeight then
        itemCount = maxCountByWeight
      end
    end
  end
  Panel_NumberPad_Show(true, itemCount, itemEnchantKey, InputMRUp_MarketWallet_Withdraw, nil, isSealed)
end
function InputMRUp_MarketWallet_Register(inputNumber, slotNo, isMileage, isMoney)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local fromWhereType = PaGlobalFunc_MarketPlace_GetMyInvenTab()
  if nil ~= isMoney and isMoney == true and slotNo == self._moneySlot then
    fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
  end
  if nil ~= isMileage and true == isMileage and slotNo == self._mileageSlot then
    fromWhereType = CppEnums.ItemWhereType.eCashInventoryForUser
  end
  requestMoveItemInventoryToWallet(fromWhereType, slotNo, inputNumber, PaGlobalFunc_MarketPlace_IsOpenByMaid(), PaGlobal_WareHouse_All._currentWaypointKey)
end
function InputMRUp_MarketWallet_Withdraw(inputNumber, itemEnchantKey, isSealed, toWhere)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if nil == isSealed then
    isSealed = false
  end
  local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
  if itemWrapper == nil then
    return
  end
  local toWhereType = CppEnums.ItemWhereType.eInventory
  if true == itemWrapper:isMoney() then
    toWhereType = CppEnums.ItemWhereType.eMoneyInventory
  elseif true == PaGlobalFunc_MarketPlace_GetWareHouseCheck() then
    toWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  local isUseMaid = PaGlobalFunc_MarketPlace_IsOpenByMaid() == true or PaGlobalFunc_TotalSearch_GetShow ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true
  requestMoveItemWalletToInventory(itemEnchantKey, inputNumber, isSealed, toWhereType, isUseMaid)
end
function InputMRUp_MarketWallet_WithdrawForMileage(inputNumber, itemEnchantKey)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  requestMoveItemWalletToInventory(itemEnchantKey, inputNumber, false, CppEnums.ItemWhereType.eInventory, PaGlobalFunc_MarketPlace_IsOpenByMaid())
end
function FromClient_MarketPlace_RequestMyWalletList()
  PaGlobalFunc_MarketPlace_UpdateWalletInfo()
  PaGlobalFunc_MarketPlace_UpdateWalletList()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  PaGlobalFunc_MarketPlace_WalletInven_Update()
  PaGlobalFunc_Wallet_UpdatePearlItemLimitCount()
end
function FromClient_MarketPlace_RequestPush()
  PaGlobalFunc_MarketPlace_UpdateWalletInfo()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if true == self._isOpen and false == PaGlobalFunc_MarketPlace_WalletInven_GetShow() then
    PaGlobalFunc_MarketPlace_WalletInven_Open()
  end
  PaGlobalFunc_MarketPlace_WalletInven_Update()
  PaGlobalFunc_MarketPlace_MyInven_Update()
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_REGISTITEM")
  Proc_ShowMessage_Ack(msg)
  FromClient_MaidList_All_NoticeLeftCount(true)
  ToClient_requestMyWalletList(__eWorldMarketKeyType_Item)
end
function FromClient_MarketPlace_RequestPop(isMoney)
  PaGlobalFunc_MarketPlace_UpdateWalletInfo()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if true == self._isOpen and false == PaGlobalFunc_MarketPlace_MyInven_GetShow() then
    PaGlobalFunc_MarketPlace_MyInven_Open()
  end
  PaGlobalFunc_MarketPlace_WalletInven_Update()
  PaGlobalFunc_MarketPlace_MyInven_Update()
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WITHDRAWITEM")
  Proc_ShowMessage_Ack(msg)
  FromClient_MaidList_All_NoticeLeftCount(true)
  if PaGlobalFunc_TotalSearch_UpdateItemList ~= nil then
    PaGlobalFunc_TotalSearch_UpdateItemList()
  end
end
function PaGlobalFunc_MarketPlace_GetWareHouseMoneyFromMaid()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    _PA_ASSERT(false, "\236\167\128\236\151\173 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Panel_Window_MarketPlaceWallet")
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  if ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if newRegionInfo == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WALLETMANAGER_NO_REGION_WAREHOUSE"))
      return
    end
    myAffiliatedTownRegionKey = newRegionInfo:getRegionKey()
    if 0 == myAffiliatedTownRegionKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WALLETMANAGER_NO_REGION_WAREHOUSE"))
      return
    end
  end
  return warehouse_moneyFromRegionKey_s64(myAffiliatedTownRegionKey)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MarketWallet_Init")
