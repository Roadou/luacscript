PaGlobal_EasyBuy = {
  _ui = {
    _btn_close = nil,
    _lst_product = nil,
    _stc_descBg = nil,
    _stc_myPearlIcon = nil,
    _txt_myPearlValue = nil,
    _txt_myPearl = nil
  },
  _listCount = 20,
  _itemListPool = {},
  savedMainCategory = nil,
  savedMiddleCategory = nil,
  savedSmallCategory = -1,
  savedWayPointKey = -1,
  savedTempCashItemSSW = nil,
  deleteItemWhereType = CppEnums.ItemWhereType.eCount,
  deleteItemSlotNo = __eTInventorySlotNoUndefined,
  slotStartX = 15,
  slotStartY = 50,
  slotGapX = 335,
  slotGapY = 60,
  _immediatelyUse = false,
  _mainSlotConfing = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createClassEquipBG = true
  },
  _subSlotConfing = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createClassEquipBG = true
  },
  _easyBuyCountCache = 0,
  _subSlotCountMax = 10,
  _isInitialized = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EasyBuy_Init")
function FromClient_EasyBuy_Init()
  PaGlobal_EasyBuy:initialize()
end
