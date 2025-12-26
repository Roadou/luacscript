PaGlobal_Ping_All = {
  _ui = {
    _stc_pingBG = nil,
    _btn_ping = {},
    _stc_pingIcon = {},
    _stc_pingName = nil,
    _stc_mouseMove = nil,
    _stc_padMove = nil
  },
  _currentType = nil,
  _updateRate = 0.2,
  _elapsedTime = 0,
  _uiScale = 1,
  _centerPos = {},
  _prevInitMousePosInBoader = nil,
  _prevLockRStickMoveState = nil,
  _prevUIMode = nil,
  _prevWorldmapRingMenuShow = false,
  _notifyKeySelectOpenTime = 0.4,
  _notifyKeyPressTime = 0,
  _maxMoveSelect = 70,
  _isDelayOpen = false,
  _isPadSetting = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Ping/Panel_Widget_Ping_All_1.lua")
runLua("UI_Data/Script/Widget/Ping/Panel_Widget_Ping_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Ping_All_Init")
function FromClient_Ping_All_Init()
  PaGlobal_Ping_All:initialize()
end
