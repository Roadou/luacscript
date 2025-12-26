PaGlobal_CashShopBuyHistory = {
  _ui = {
    _historyTemplate = nil,
    _scroll = nil,
    _btn_scrollUp = nil,
    _btn_scrollDown = nil,
    _btn_scroll = nil,
    _stc_pearBox = nil,
    _stc_pearIcon = nil,
    _txt_totalCount = nil,
    _txt_nowCount = nil,
    _stc_topDescBG = nil,
    _stc_topDes = nil,
    _txt_refundCount = nil,
    _btn_refundInfo = nil,
    _frame = nil,
    _frameScroll = nil
  },
  _historyList = {},
  _historyCount = 0,
  _realHistoryCount = 0,
  _remainSizeY = 100,
  _maxHistoryCount = 0,
  _currentSlotIndex = 1,
  _leftRefundCount = 1,
  _dontUseRefund = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyHistory_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyHistory_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CashShopBuyHistoryInit")
function FromClient_CashShopBuyHistoryInit()
  PaGlobal_CashShopBuyHistory:initialize()
end
