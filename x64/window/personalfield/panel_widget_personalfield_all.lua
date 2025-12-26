PaGlobal_Widget_PersonalField_All = {
  _ui = {
    _stc_stateIcon = nil,
    _stc_green = nil,
    _stc_yellow = nil,
    _stc_red = nil,
    _stc_alertIcon = nil,
    _txt_name = nil,
    _txt_time = nil,
    _btn_navi = nil,
    _btn_enter = nil,
    _btn_exit = nil,
    _txt_serverBusy = nil,
    _txt_enter = nil,
    _stc_enterCondition = nil,
    _stc_itemListBg = nil,
    _stc_itemList = {}
  },
  _checkType = -1,
  _index = nil,
  _naviPos = nil,
  _remainTime = nil,
  _serverState = __ePersonalFieldServerState_NoEntry,
  _isSetAreaInfo = false,
  _isShowRemainEffect = false,
  _isNonEnterServer = false,
  _slotCount = 8,
  _itemSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_All_1.lua")
runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_PersonalField_All_Init")
function FromClient_Widget_PersonalField_All_Init()
  PaGlobal_Widget_PersonalField_All:initialize()
end
