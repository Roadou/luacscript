local _panel = Panel_Window_MarketPlaceWallet
local MarketWallet = {_moneySlot = 0, _isOpen = false}
function MarketWallet:init()
  self._moneySlot = getMoneySlotNo()
  self:registEvent()
end
function MarketWallet:registEvent()
  registerEvent("FromClient_requestMyWalletList", "FromClient_MarketPlace_RequestMyWalletList")
  registerEvent("FromClient_requestPush", "FromClient_MarketPlace_RequestPush")
  registerEvent("FromClient_requestPop", "FromClient_MarketPlace_RequestPop")
end
function MarketWallet:open()
  PaGlobalFunc_MarketPlace_MyInven_Update()
  ToClient_requestMyWalletList(__eWorldMarketKeyType_Item)
  PaGlobalFunc_MarketPlace_MyInven_Open()
  PaGlobalFunc_MarketPlace_WalletInven_Open()
  self._isOpen = true
end
function MarketWallet:close()
  PaGlobalFunc_MarketPlace_MyInven_Close()
  PaGlobalFunc_MarketPlace_WalletInven_Close()
  Panel_Tooltip_Item_hideTooltip()
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
function PaGlobalFunc_MarketWallet_Open()
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  ToClient_requestMyWalletList(__eWorldMarketKeyType_Item)
  ToClient_WorldMarketOpen()
  self:open()
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
  Panel_NumberPad_Show(true, money, self._moneySlot, InputMRUp_MarketWallet_Register_Money, false, false, false, true)
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
  Panel_NumberPad_Show(true, itemCount, itemEnchantKey, InputMRUp_MarketWallet_Withdraw, false, nil, false, 1)
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
  local isWarehouse = false
  if nil ~= PaGlobalFunc_MarketPlace_MyInven_isWarehouse then
    isWarehouse = PaGlobalFunc_MarketPlace_MyInven_isWarehouse()
  end
  if false == isWarehouse then
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  elseif nil ~= PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem then
    itemWrapper = PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem(slotNo)
  end
  if nil == itemWrapper then
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
  if true == self:warringCheck(itemWrapper) then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WARRING_REGISTITEM")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = excute,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    excute()
  end
end
function MarketWallet:warringCheck(itemWrapper)
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
function InputMRUp_MarketWallet_Register(inputNumber, slotNo)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  if nil ~= isMoney and isMoney == true and slotNo == self._moneySlot then
    fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
  else
    fromWhereType = PaGlobalFunc_MarketPlace_GetMyInvenTab()
  end
  requestMoveItemInventoryToWallet(fromWhereType, slotNo, inputNumber, PaGlobalFunc_MarketPlace_IsOpenByMaid(), PaGlobal_WareHouse_All._currentWaypointKey)
  PaGlobalFunc_FloatingTooltip_Close()
end
function InputMRUp_MarketWallet_Register_Money(inputNumber, slotNo)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
  requestMoveItemInventoryToWallet(fromWhereType, slotNo, inputNumber, PaGlobalFunc_MarketPlace_IsOpenByMaid(), PaGlobal_WareHouse_All._currentWaypointKey)
  PaGlobalFunc_FloatingTooltip_Close()
end
function InputMRUp_MarketWallet_Withdraw(inputNumber, itemEnchantKey, isSealed, toWhere)
  local self = MarketWallet
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  local isUseMaid = PaGlobalFunc_MarketPlace_IsOpenByMaid() == true or PaGlobalFunc_TotalSearch_GetShow ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true
  if 1 == toWhere or 2 == toWhere then
    requestMoveItemWalletToInventory(itemEnchantKey, inputNumber, false, CppEnums.ItemWhereType.eMoneyInventory, isUseMaid)
  else
    local toWhereType = CppEnums.ItemWhereType.eInventory
    if nil ~= PaGlobalFunc_MarketPlace_MyInven_isWarehouse and true == PaGlobalFunc_MarketPlace_MyInven_isWarehouse() then
      toWhereType = CppEnums.ItemWhereType.eWarehouse
    end
    requestMoveItemWalletToInventory(itemEnchantKey, inputNumber, isSealed, toWhereType, isUseMaid)
  end
  PaGlobalFunc_FloatingTooltip_Close()
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
  if nil ~= PaGlobalFunc_MarketPlace_GetMyInvenTab and CppEnums.ItemWhereType.eWarehouse == PaGlobalFunc_MarketPlace_GetMyInvenTab() and isMoney == false then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_COMPLETE_WAREHOUSE")
  end
  Proc_ShowMessage_Ack(msg)
  if PaGlobalFunc_TotalSearch_UpdateItemList ~= nil then
    PaGlobalFunc_TotalSearch_UpdateItemList()
  end
end
function PaGlobalFunc_MarketPlace_GetWareHouseMoneyFromMaid()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  if ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if newRegionInfo == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
    myAffiliatedTownRegionKey = newRegionInfo:getRegionKey()
    if 0 == myAffiliatedTownRegionKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
  end
  return warehouse_moneyFromRegionKey_s64(myAffiliatedTownRegionKey)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MarketWallet_Init")
