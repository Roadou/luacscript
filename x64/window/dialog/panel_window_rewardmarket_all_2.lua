function PaGlobalFunc_RewardMarket_Open()
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RewardMarket_Close()
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RewardMarket_OnCreateMyGoodsListContents(content, key)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:onCreateMyGoodsListContents(content, key)
end
function HandleEventLUp_RewardMarket_OnClickedSelectAll()
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:selectAll()
end
function HandleEventLUp_RewardMarket_OnClickedClearSelectAll()
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:unselectAll()
end
function HandleEventLUp_RewardMarket_OnClickedRequestSell()
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  if self._selectGoodsList == nil then
    return
  end
  local validSelectedCount = 0
  for _, value in pairs(self._selectGoodsList) do
    if value ~= nil then
      validSelectedCount = validSelectedCount + 1
    end
  end
  if validSelectedCount < 1 then
    return
  end
  local function requestSell()
    for _, value in pairs(self._selectGoodsList) do
      if value ~= nil then
        local tradeKeyRaw = highFromUint64(value)
        local ii = lowFromUint64(value)
        ToClient_RequestSellToRewardMarket(tradeKeyRaw, ii)
      end
    end
  end
  local messageString
  if self._currentType == __eRewardMarketTradeType_PetToItem then
    messageString = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDMARKET_CASH_TRANSFER_CONFIRM_MSG")
  elseif self._currentType == __eRewardMarketTradeType_ItemToItem then
    messageString = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDMARKET_NORMAL_TRANSFER_CONFIRM_MSG")
  end
  if messageString ~= nil then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageString,
      functionYes = requestSell,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_RewardMarket_SelectGoolds(tradeKeyRaw, ii)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  local contentsKey = toInt64(tradeKeyRaw, ii)
  self:selectGoods(contentsKey, true)
  self:onSelectGoodsListContents()
end
function HandleEventLUp_RewardMarket_UnselectGoolds(tradeKeyRaw, ii)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  local contentsKey = toInt64(tradeKeyRaw, ii)
  local content = self._ui._lst_myGoods:GetContentByKey(contentsKey)
  local chk_goods = UI.getChildControl(content, "CheckButton_Goods")
  chk_goods:SetCheck(false)
end
function HandleEventPadLBRB_RewardMarket_ChangeTab(tradeType)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:selectTab(tradeType)
end
function HandleEventLOnOut_RewardMarket_ItemTooltip(isShow, tradeKeyRaw, ii)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemData = ToClient_GetSelfPlayerRewardMarketMaterialItemData(tradeKeyRaw, ii)
  if itemData == nil then
    return
  end
  local itemWhereType = itemData._itemWhereType
  local slotNo = itemData._slotNo
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_RewardMarket_All, false, true, nil)
end
function HandleEventLOnOut_RewardMarket_ItemRewardToolTip(isShow, key, index)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local rewardItemData = self._rewardItemList[key]
  if rewardItemData == nil then
    return
  end
  local rewardItemSSW = getItemEnchantStaticStatus(rewardItemData._itemKey)
  if rewardItemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(rewardItemSSW, self._rewardItemSlotList[index].slotControl, true, false, nil)
end
function HandleEventLOnOut_RewardMarket_CantSellTooltip(isShow, tradeKeyRaw, ii)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local contentsKey = toInt64(tradeKeyRaw, ii)
  local content = self._ui._lst_myGoods:GetContentByKey(contentsKey)
  if content == nil then
    return
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDMARKET_NOTRANSFER_TOOLTIP_DESC")
  TooltipSimple_Show(content, name, desc)
end
function FromClient_ResponseSellToRewardMarket(tradeType)
  local self = PaGlobal_RewardMarket
  if self == nil then
    return
  end
  self:selectTab(tradeType)
end
