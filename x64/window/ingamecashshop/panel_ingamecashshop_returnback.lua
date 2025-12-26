PaGlobal_IngameCashSHop_ReturnBack = {
  _ui = {
    _btn_close = nil,
    _stc_productArea = nil,
    _stc_itemSlotBG = nil,
    _stc_txtMoonBlessing = nil,
    _stc_productIcon = nil,
    _stc_productName = nil,
    _stc_productPrice = nil,
    _stc_productCount = nil,
    _stc_couponSlotBG = nil,
    _stc_couponIcon = nil,
    _stc_couponName = nil,
    _stc_couponCount = nil,
    _list2 = nil,
    _btn_confirm = nil,
    _btn_cancle = nil,
    _stc_keyGuidBG = nil,
    _stc_check = nil,
    _edit_check = nil,
    _txt_xButton = nil,
    _stc_editIcon = nil,
    _stc_DescBG = nil,
    _txt_desc = nil
  },
  _panelSizeY = 0,
  _productSizeY = 0,
  _editPosY = 0,
  _descPosY = 0,
  _selectIndex = -1,
  _subSlot = {},
  _subSlotForEvent = {},
  _selectControlIndex = -1,
  _selectPrepareIndex = -1,
  _moonBlessingSlot = {},
  _COL_SLOT_COUNT = 17,
  _ICONSIZE = 32,
  _moonblessingGab = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_IngameCashSHop_ReturnBackInit")
function FromClient_IngameCashSHop_ReturnBackInit()
  PaGlobal_IngameCashSHop_ReturnBack:initialize()
end
