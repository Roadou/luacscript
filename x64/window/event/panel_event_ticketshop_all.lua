PaGlobal_Event_TicketShop = {
  _ui = {
    _btn_close = nil,
    _btn_refresh = nil,
    _stc_keyGuide = nil,
    _stc_coinIcon = nil,
    _stc_loseCoinIcon = nil,
    _txt_coinCount = nil,
    _txt_loseCoinCount = nil,
    _list2_drawItemList = nil,
    _stc_unboxingBG = nil,
    _stc_unboxingBox = nil,
    _stc_unboxingBombEffect = nil,
    _stc_unboxingResult = nil,
    _stc_unboxingResultItemSlot = nil,
    _stc_unboxingResultItemName = nil,
    _btn_unboxingResultItem = nil,
    _btn_detailLink = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = false,
    createEnchant = true
  },
  _audioPlayingID = 0,
  _audioPlayingIDConsole = 0,
  _effectTimeDraw = 3,
  _animationTimeStamp = 0,
  _effectTimeResult = 1,
  _animationResultTimeStamp = 0,
  _focusDrawOrderNo = -1,
  _isRequest = false,
  _isShowEffect = false,
  _isShowResultEffect = false,
  _isConsole = false,
  _refreshTime = 0,
  _refreshCoolTime = 5000,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_TicketShop_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_TicketShop_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Event_TicketShop_Init")
function FromClient_PaGlobal_Event_TicketShop_Init()
  PaGlobal_Event_TicketShop:initialize()
end
