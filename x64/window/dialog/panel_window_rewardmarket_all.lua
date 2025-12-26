PaGlobal_RewardMarket = {
  _ui = {
    _btn_close = nil,
    _rdo_petList = nil,
    _rdo_itemList = nil,
    _stc_selectLine = nil,
    _stc_keyGuideLB = nil,
    _stc_keyGuideRB = nil,
    _lst_myGoods = nil,
    _btn_selectAll = nil,
    _btn_clearSelectAll = nil,
    _btn_requestSell = nil,
    _stc_rewardArea = nil,
    _frm_reward = nil,
    _frmContent_reward = nil,
    _stc_rewardTemplate = nil
  },
  _gradeColorConfig = {
    [0] = Defines.Color.C_FFEFEFEF,
    [1] = Defines.Color.C_FFB5FF6D,
    [2] = Defines.Color.C_FF008AFF,
    [3] = Defines.Color.C_FFFFCE22,
    [4] = Defines.Color.C_FFD05D48
  },
  _itemSlotConfing = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createMaidActorOnly = true,
    createClassEquipBG = true
  },
  _selectGoodsList = nil,
  _rewardItemList = nil,
  _rewardItemSlotList = nil,
  _currentType = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dialog/Panel_Window_RewardMarket_All_1.lua")
runLua("UI_Data/Script/Window/Dialog/Panel_Window_RewardMarket_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RewardMarketInit")
function FromClient_RewardMarketInit()
  PaGlobal_RewardMarket:initialize()
end
