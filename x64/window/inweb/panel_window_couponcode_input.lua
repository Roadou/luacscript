PaGlobal_CouponCode_Input = {
  _ui = {
    _edit_CouponCode = nil,
    _stc_keyGuide_bg = nil,
    _txt_BKey = nil,
    _txt_AKey = nil
  },
  _contentLabel = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode_Input_1.lua")
runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode_Input_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CouponCode_Input")
function FromClient_CouponCode_Input()
  PaGlobal_CouponCode_Input:initialize()
end
