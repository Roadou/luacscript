PaGlobal_PersonalField_Main_All = {
  _ui = {
    _txt_titleArea = nil,
    _txt_titelIcon = nil,
    _stc_green = nil,
    _stc_yellow = nil,
    _stc_red = nil,
    _btn_close = nil,
    _stc_mainBG = nil,
    _fieldList = nil,
    _stc_alertMainBG = nil,
    _txt_alertBG = nil,
    _txt_alertDesc = nil,
    _btn_serverSelect = nil,
    _stc_desc = nil,
    _txt_desc = nil,
    _txt_timeTitle = nil,
    _txt_time = nil,
    _txt_serverBusy = nil,
    _btn_uiOnOff = nil,
    _rdo_shallow = nil,
    _rdo_deep = nil,
    _stc_selectLine = nil,
    _stc_keyLB = nil,
    _stc_keyRB = nil,
    _stc_keyGuide = nil,
    _txt_keyGuideA = nil,
    _txt_keyGuideB = nil,
    _txt_keyGuideX = nil,
    _btn_serverSelectAlwaysOn = nil
  },
  _enterIndex = nil,
  _selectIndex = nil,
  _selectKey = nil,
  _naviPosList = {},
  _serverState = __ePersonalFieldServerState_NoEntry,
  _basePanelSizeY = 0,
  _baseMainBGSizeY = 0,
  _baseDescBGSizeY = 0,
  _baseAlertDescSizeY = 0,
  _baseAlertDescSpanY = 0,
  _isNonEnterServer = false,
  _isDeepInfoExist = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PersonalField/Panel_Window_PersonalField_Main_All_1.lua")
runLua("UI_Data/Script/Window/PersonalField/Panel_Window_PersonalField_Main_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Widget_PersonalField_All_Init")
function FromClient_Panel_Widget_PersonalField_All_Init()
  PaGlobal_PersonalField_Main_All:initialize()
end
