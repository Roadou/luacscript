local isEnableSupplyTrade = ToClient_IsContentsGroupOpen("22")
function EventNotifyResponseAuctionInfo(goodsType, sendType, tempStr, tempStr2, bidRv, param1)
  local strGoodsType = ""
  local msg = ""
  if goodsType == CppEnums.AuctionType.AuctionGoods_House then
    if not ToClient_IsContentsGroupOpen("36") then
      return
    end
    strGoodsType = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_STRGOODSTYPE")
    if sendType == 0 then
      msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_SENDTYPE0_MSG", "tempStr", tempStr) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_7")
    elseif sendType == 1 then
      if 0 == bidRv then
        msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_SENDTYPE1_MSG1", "tempStr", tempStr, "tempStr2", tempStr2)
      else
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_SENDTYPE1_MSG2", "tempStr", tempStr)
      end
    else
      _PA_ASSERT(false, "\236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148")
    end
  elseif goodsType == CppEnums.AuctionType.AuctionGoods_Villa then
    strGoodsType = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_15")
    if sendType == 0 then
      msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_AUCTION", "tempStr", tempStr, "strGoodsType", strGoodsType) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_7")
    elseif sendType == 1 then
      msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_AUCTION", "tempStr", tempStr, "strGoodsType", strGoodsType) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_8")
    else
      _PA_ASSERT(false, "\236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148")
    end
  elseif goodsType == CppEnums.AuctionType.AuctionGoods_Item then
    strGoodsType = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_16")
    if sendType == 0 then
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_STARTMSG")
    elseif sendType == 1 then
      local itemKey = param1
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      if nil == itemSSW then
        return
      end
      local itemName = itemSSW:getName()
      if 0 == bidRv then
        local moneyString = "0"
        if tempStr2 ~= nil then
          moneyString = makeDotMoney(tonumber64(tempStr2))
        end
        msg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_MASTERPIECE_AUCTION_SUCCESS", "itemName", itemName, "AuctionPrice", moneyString, "familyName", tempStr)
      else
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MASTERPIECE_AUCTION_FAIL", "itemName", itemName)
      end
    else
      _PA_ASSERT(false, "\236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148")
    end
    local message = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_AUCTION_MSG_MAIN", "strGoodsType", strGoodsType),
      sub = msg,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 3, 68)
    return
  else
    _PA_ASSERT(false, "\236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148")
  end
  if nil ~= Panel_Widget_ServantIcon then
    Panel_MyHouseNavi_Update(true)
  end
  local message = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_AUCTION_MSG_MAIN", "strGoodsType", strGoodsType),
    sub = msg,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 3, 7)
end
function EventNotifyBidAuctionGoods(goodsType, param1, param2)
  if goodsType == 2 then
    local text = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_NOTIFYBIDAUCTIONGOODS")
    Proc_ShowMessage_Ack(text)
  end
end
function FromClientNotifySupplyTradeStart()
  if false == ToClient_IsContentsGroupOpen("26") then
    return
  end
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_IMPERIAL_START"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_MESSAGE_10"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 3, 8)
end
function FromClientNotifySupplyShopReset()
  if false == isEnableSupplyTrade then
    return
  end
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_MSG_MAIN_2"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_MSG_SUB_2"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 3, 8)
end
registerEvent("FromClientNotifySupplyTradeStart", "FromClientNotifySupplyTradeStart")
registerEvent("FromClient_BidAuctionGoods", "EventNotifyBidAuctionGoods")
registerEvent("FromClientNotifySupplyShopReset", "FromClientNotifySupplyShopReset")
registerEvent("FromClient_ResponseAuctionInfo", "EventNotifyResponseAuctionInfo")
