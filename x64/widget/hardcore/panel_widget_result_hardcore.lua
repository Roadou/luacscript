PaGlobal_HardCoreResult = {
  _ui = {
    _stc_CenterArea = nil,
    _txt_CharacterName = nil,
    _txt_PlayTime = nil,
    _stc_PlayTimeIcon = nil,
    _txt_GetPoint = nil,
    _stc_PointIcon = nil,
    _stc_HorizonArrow = nil,
    _txt_AfterPoint = nil,
    _txt_PointStatusDesc = nil,
    _stc_RankPointProgress = nil,
    _stc_CoinPointProgress = nil,
    _btn_Cinfirm = nil,
    _btn_Close = nil,
    _txt_ExchangeCoinCount = nil
  },
  _initialize = false,
  _selfPlayer = nil
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Result_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Result_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreResult_Init")
function FromClient_HardCoreResult_Init()
  PaGlobal_HardCoreResult:initialize()
end
