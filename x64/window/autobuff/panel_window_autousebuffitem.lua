PaGlobal_AutoUseBuffItem = {
  _ui = {
    _stc_titleArea = nil,
    _stc_topArea = nil,
    _btn_onOffToggle = nil,
    _stc_toggleStateText = nil,
    _stc_checkCountText = nil,
    _btn_clearPreset = nil,
    _btn_checkSafeRegion = nil,
    _stc_mainArea = nil,
    _frm_mainFrame = nil,
    _frm_mainFrameContent = nil,
    _template_itemGroup = nil,
    _stc_descArea = nil,
    _btn_confirm = nil,
    _btn_close = nil,
    _stc_keyGuideArea = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCooltime = true,
    createCooltimeText = true
  },
  _itemGroupDataList = nil,
  _presetButtonList = nil,
  _currentPresetIndex = 0,
  _presetMaxSize = 0,
  _isOpenedByFairy = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/AutoBuff/Panel_Window_AutoUseBuffItem_1.lua")
runLua("UI_Data/Script/Window/AutoBuff/Panel_Window_AutoUseBuffItem_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AutoUseBuffItemInit")
function FromClient_AutoUseBuffItemInit()
  PaGlobal_AutoUseBuffItem:initialize()
end
