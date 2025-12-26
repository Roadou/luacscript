PaGlobal_IngameCashShop_Desc = {
  _ui = {
    _txt_desc = nil,
    _stc_keyGuide = nil,
    _btn_close = nil,
    _btn_confirm = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Desc_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Desc_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_IngameCashShop_DescInit")
function FromClient_IngameCashShop_DescInit()
  PaGlobal_IngameCashShop_Desc:initialize()
end
