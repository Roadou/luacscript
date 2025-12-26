PaGlobal_Alchemy_RateViewList = {
  NORMAL_DROP = 0,
  EVENT_DROP = 1,
  DROP_COUNT = 2,
  _ui = {
    _stc_topGroup = nil,
    _stc_btn_close = nil,
    _stc_contentGroup = nil,
    _stc_frame = nil,
    _stc_frameContent = nil,
    _scroll_vertical = nil,
    _txt_lifeTitle = nil,
    _stc_group = nil,
    _stc_itemSlotBG = nil,
    _txt_itemName = nil,
    _stc_horizonLine = nil,
    _console_keyGuide = nil,
    _stc_console_detail = nil,
    _stc_console_close = nil
  },
  _list = {},
  _groupPoolCount = 40,
  _lifeType = nil,
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true,
    createEnchant = true
  },
  _normalTotalSizeY = 0,
  _normalTotalCount = 0,
  _eventTotalSizeY = 0,
  _eventTotalCount = 0,
  _isEventDropOpen = false,
  _isPadMode = ToClient_isUsePadSnapping(),
  _isConsole = ToClient_isConsole(),
  _initialize = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Alchemy_RateViewList_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Alchemy_RateViewList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Alchemy_RateViewList_Init")
function FromClient_Alchemy_RateViewList_Init()
  PaGlobal_Alchemy_RateViewList:initialize()
end
