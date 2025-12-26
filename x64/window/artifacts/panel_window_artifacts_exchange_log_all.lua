PaGlobal_ArtifactsExchangeLog = {
  _ui = {
    stc_TopBg = nil,
    txt_Title = nil,
    button_Close = nil,
    stc_blockBg = nil,
    stc_mainBg = nil,
    stc_bg = nil,
    list2_lightStone = nil,
    btn_exchange = nil,
    btn_cancel = nil,
    stc_bottomBg = nil,
    btn_KeyGuideConfirm = nil,
    btn_KeyGuideCancel = nil
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _maxSlotCount = 30,
  _itemSlot = {},
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_Log_All_1.lua")
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_Log_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Artifacts_ExchangeLog_All_Init")
function FromClient_Artifacts_ExchangeLog_All_Init()
  PaGlobal_ArtifactsExchangeLog:initialize()
end
