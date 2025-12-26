PaGlobal_ServantSimulatorSubView = {
  _ui = {
    _btn_all = nil,
    _btn_mine = nil,
    _stc_selectLine = nil,
    _btn_close = nil,
    _frm_selectList = nil,
    _frmContent_selectList = nil,
    _stc_frameGroupTemplate = nil,
    _stc_frameHorseTemplate = nil,
    _stc_keyGuideLB = nil,
    _stc_keyGuideRB = nil,
    _stc_keyGuideBg = nil,
    _stc_keyGuide_A = nil,
    _stc_keyGuide_B = nil
  },
  _tabType = {
    ALL = 0,
    MINE = 1,
    COUNT = 2
  },
  _currentTabIndex = nil,
  _showTabList = nil,
  _tabList = {},
  _groupList = nil,
  _isOnlyMyHorse = nil,
  _openType = nil,
  _maleType = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantSimulatorSubViewInit")
function FromClient_ServantSimulatorSubViewInit()
  PaGlobal_ServantSimulatorSubView:initialize()
end
