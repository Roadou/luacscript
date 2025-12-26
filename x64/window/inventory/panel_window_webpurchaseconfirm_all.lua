PaGlobal_WebPurchaseConfirm_All = {
  _ui = {
    _stc_mainBG = nil,
    _btn_close = nil,
    _btn_yes = nil,
    _btn_no = nil,
    _desc_edge = nil,
    _stc_text_desc = nil,
    _stc_consolebg = nil,
    _itemList = Array.new()
  },
  _txt_btn_yes = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_WebPurchaseConfirm_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_WebPurchaseConfirm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WebPurchaseConfirm_Init")
function FromClient_WebPurchaseConfirm_Init()
  PaGlobal_WebPurchaseConfirm_All:initialize()
end
