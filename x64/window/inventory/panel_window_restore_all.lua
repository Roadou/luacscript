PaGlobal_Restore_All = {
  _ui = {
    _btn_normal = nil,
    _btn_radioBtnBg = nil,
    _btn_jewel = nil,
    _stc_selectbar = nil,
    _stc_restoreNum = nil,
    _btn_close = nil,
    _btn_restore = nil,
    _list2_item = nil,
    _list2_jewel = nil,
    _stc_descBg = nil,
    _stc_txtDescItem = nil,
    _stc_txtDescJewel = nil,
    _stc_subFrameBg = nil
  },
  _ui_console = {
    _stc_keyGuideBg = nil,
    _stc_keyGuideA = nil,
    _stc_keyGuideB = nil,
    _stc_keyGuideX = nil,
    _stc_lbConsole = nil,
    _stc_rbConsole = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createMaidActorOnly = true
  },
  _restoreCategoryTable = {__eItem = 0, __eJewel = 1},
  _selectSlotNo = nil,
  _restoreType = nil,
  _addItemDescSizeY = 0,
  _addJewelDescSizeY = 0,
  _originStcDescBgSizeY = 0,
  _originStcSubFrameBg = 0,
  _originPanelSizeY = 0,
  _currentTab = 0,
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Restore_All_Init")
function FromClient_Restore_All_Init()
  PaGlobal_Restore_All:initialize()
end
