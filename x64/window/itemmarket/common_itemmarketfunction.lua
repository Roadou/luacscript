function PaGlobalFunc_ItemMarket_GetShow()
  return Panel_Window_ItemMarket:GetShow()
end
function PaGlobalFunc_ItemMarket_IsUISubApp()
  return Panel_Window_ItemMarket:IsUISubApp()
end
function PaGlobalFunc_ItemMarketBidDesc_GetShow()
  return Panel_ItemMarket_BidDesc:GetShow()
end
function PaGlobalFunc_ItemMarketFunction_GetShow()
  return Panel_Window_ItemMarket_Function:GetShow()
end
function PaGlobalFunc_ItemMarketAlarmList_GetShow()
  return Panel_Window_ItemMarketAlarmList_New:GetShow()
end
function PaGlobalFunc_ItemMarketAlarmList_IsUISubApp()
  return Panel_Window_ItemMarketAlarmList_New:IsUISubApp()
end
function PaGlobalFunc_ItemMarketRegistItem_GetShow()
  return Panel_Window_ItemMarket_RegistItem:GetShow()
end
function PaGlobalFunc_ItemMarketRegistItem_SetShow(isShow)
  return Panel_Window_ItemMarket_RegistItem:SetShow(isShow)
end
function PaGlobalFunc_ItemMarketBuyConfirm_GetShow()
  return Panel_Window_ItemMarket_BuyConfirm:GetShow()
end
function PaGlobalFunc_ItemMarketItemSet_GetShow()
  return Panel_Window_ItemMarket_ItemSet:GetShow()
end
function FromClient_notifyItemMarketMessage(msgType, strParam1, param1, param2, param3, param4)
  if 0 == msgType then
    if 0 == param1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_BUYCOMPLETEITEM"))
    elseif 1 == param1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_BUYBIDDINGITEM"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_BUYCOMPLETEITEM"))
    end
  elseif 1 == msgType then
    local territoryNameArray = {
      [0] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_0")),
      [1] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_1")),
      [2] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_2")),
      [3] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_3")),
      [4] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_4")),
      [5] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_5")),
      [6] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6")),
      [7] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_7"))
    }
    if param2 < 0 or param2 > 6 then
      return
    end
    local territoryName = territoryNameArray[param2]
    local issw = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if issw == nil then
      return
    end
    local itemName = issw:getName()
    local enchantLevel = issw:get()._key:getEnchantLevel()
    local isCash = issw:get():isCash()
    if enchantLevel > 0 and 4 ~= issw:getItemClassify() then
      strParam1 = "+" .. enchantLevel .. " " .. itemName
    end
    if enchantLevel >= 16 then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel)
      strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
    elseif enchantLevel > 0 and enchantLevel < 16 and 4 ~= issw:getItemClassify() then
      if true == isCash then
        strParam1 = itemName
      else
        strParam1 = "+" .. enchantLevel .. " " .. itemName
      end
    elseif 4 == issw:getItemClassify() then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel + 15)
      if 0 == enchantLevel then
        strParam1 = itemName
      else
        strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
      end
    else
      strParam1 = itemName
    end
    local subStr
    if param4 then
      subStr = "LUA_ITEMMARKET_REGIST_ITEMMARKET"
    else
      subStr = "LUA_ITEMMARKET_STANDBY_ITEMMARKET"
    end
    local mainStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMMARKET_NOTIFYITEMMARKETMSG_MAIN", "strParam1", strParam1, "param3", makeDotMoney(param3))
    local subStr = PAGetString(Defines.StringSheet_GAME, subStr)
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
  elseif 2 == msgType then
    local message = ""
    if param2 == 1 then
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMMARKET_SELLITEM", "strParam1", strParam1, "param1", param1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMMARKET_SELLITEMONE", "strParam1", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 3 == msgType then
    PaGlobal_ItemmarketRegistItem_Update()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_AFTERREGIST_ACK"))
  elseif 4 == msgType then
    PaGlobalFunc_ItemMarket_UpdateForNotice()
  elseif 5 == msgType then
    local issw = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if issw == nil then
      return
    end
    FGlobal_ItemMarketAlarm_Open(ItemEnchantKey(param1))
  elseif 6 == msgType then
    local issw = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if issw == nil then
      return
    end
    local itemName = issw:getName()
    local enchantLevel = issw:get()._key:getEnchantLevel()
    local isCash = issw:get():isCash()
    if enchantLevel > 0 and 4 ~= issw:getItemClassify() then
      strParam1 = "+" .. enchantLevel .. " " .. itemName
    end
    if enchantLevel >= 16 then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel)
      strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
    elseif enchantLevel > 0 and enchantLevel < 16 and 4 ~= issw:getItemClassify() then
      if true == isCash then
        strParam1 = itemName
      else
        strParam1 = "+" .. enchantLevel .. " " .. itemName
      end
    elseif 4 == issw:getItemClassify() then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel + 15)
      if 0 == enchantLevel then
        strParam1 = itemName
      else
        strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
      end
    else
      strParam1 = itemName
    end
    local mainStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMMARKET_NOTIFYITEMMARKETMSG_MAIN", "strParam1", strParam1, "param3", makeDotMoney(param3))
    local subStr = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_STANDBY_ITEMMARKETBYPARTY")
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
  elseif 7 == msgType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_SELLCOMPLETEBYRESERVATION"))
  elseif 8 == msgType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_RESERVATIONSUCCESS"))
    FGlobal_ItemMarketPreBid_Close()
  elseif 9 == msgType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_CANCELRESERVATIONSUCCESS"))
  elseif 10 == msgType then
    local territoryNameArray = {
      [0] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_0")),
      [1] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_1")),
      [2] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_2")),
      [3] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_3")),
      [4] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_4")),
      [5] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_5")),
      [6] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6")),
      [7] = tostring(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_7"))
    }
    if param2 < 0 or param2 > 6 then
      return
    end
    local territoryName = territoryNameArray[param2]
    local issw = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if issw == nil then
      return
    end
    local itemName = issw:getName()
    local enchantLevel = issw:get()._key:getEnchantLevel()
    local isCash = issw:get():isCash()
    if enchantLevel > 0 and 4 ~= issw:getItemClassify() then
      strParam1 = "+" .. enchantLevel .. " " .. itemName
    end
    if enchantLevel >= 16 then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel)
      strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
    elseif enchantLevel > 0 and enchantLevel < 16 and 4 ~= issw:getItemClassify() then
      if true == isCash then
        strParam1 = itemName
      else
        strParam1 = "+" .. enchantLevel .. " " .. itemName
      end
    elseif 4 == issw:getItemClassify() then
      local enchantString = HighRomaEnchantLevel_ReplaceString(enchantLevel + 15)
      if 0 == enchantLevel then
        strParam1 = itemName
      else
        strParam1 = enchantString .. " " .. HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
      end
    else
      strParam1 = itemName
    end
    local mainStr = strParam1
    local subStr = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_SELLCOMPLETEBYRESERVATION")
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
  elseif 11 == msgType then
    local issw = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if issw == nil then
      return
    end
    local itemName = issw:getName()
    local enchantLevel = issw:get()._key:getEnchantLevel()
    local itemType = issw:getItemType()
    local itemClassify = issw:getItemClassify()
    local itemNameStr = PaGlobalFunc_MarketPlace_setNameAndEnchantLevel(enchantLevel, itemType, itemName, itemClassify, issw:isSpecialEnchantItem(), issw:isSpecialAccessory())
    local mainStr, subStr
    if 0 == param2 then
      mainStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMMARKET_NOTIFYITEMMARKETMSG_MAIN", "strParam1", itemNameStr, "param3", makeDotMoney(param3))
      subStr = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPALCE_SELLNOTICETITLE")
      ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
    elseif 1 == param2 then
      mainStr = tostring(itemNameStr)
      subStr = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_BUYBIDDING_SUCCESS")
      ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
    elseif 4 == param2 then
      mainStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMMARKET_NOTIFYITEMMARKETMSG_MAIN", "strParam1", itemNameStr, "param3", makeDotMoney(param3))
      subStr = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPALCE_SELLNOTICETITLE")
      ToClient_RequestNakMessageRenewelWithString(__eNakMessage_ItemMarket, mainStr, subStr)
    end
  end
end
function PaGlobalFunc_MarketPlace_CommonInit()
  registerEvent("FromClient_notifyItemMarketMessage", "FromClient_notifyItemMarketMessage")
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MarketPlace_CommonInit")
