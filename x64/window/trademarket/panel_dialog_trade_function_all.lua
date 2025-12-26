PaGlobal_TradeFunction_All = {
  _ui = {
    _rdo_Sell = nil,
    _rdo_Exit = nil,
    _stc_KeyGuide_LB = nil,
    _stc_KeyGuide_RB = nil,
    _stc_SelectBar = nil,
    _stc_KeyGuide_A = nil,
    _tabGroups = nil
  },
  _global = {_isTrading = false, _isTerritorySupply = false},
  _territorySupplyCheck = false,
  _territoryCount = nil,
  _ENUM_TAB_SELL = 1,
  _ENUM_TAB_EXIT = 2,
  _currentTab = nil,
  _initialize = false,
  _isConsole = false,
  _ENUM_TRADENPCTYPE = {
    TRADENPCTYPE_OnlyBuy = 0,
    TRADENPCTYPE_OnlySell = 1,
    TRADENPCTYPE_Count = 2
  }
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Function_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Function_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TradeFunctionAll_init")
function FromClient_TradeFunctionAll_init()
  PaGlobal_TradeFunction_All:initialize()
end
