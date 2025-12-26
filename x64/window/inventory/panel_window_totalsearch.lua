PaGlobal_TotalSearch = {
  _ui = {
    _edt_search = nil,
    _stc_keyGuideX = nil,
    _btn_search = nil,
    _btn_reset = nil,
    _stc_emptyResult = nil,
    _stc_defaultGuideText = nil,
    _stc_keyGuideArea = nil,
    _stc_keyGuide_Y = nil,
    _stc_keyGuide_A = nil,
    _stc_bottomArea = nil,
    _stc_left = nil,
    _stc_right = nil,
    _stc_leftIcon = nil,
    _stc_rightIcon = nil,
    _stc_selectBar = nil,
    _txt_warehouseMaidCount = nil,
    _txt_marketPlaceMaidCount = nil,
    _chk_useShortCutKey = nil,
    _searchedResultList = nil,
    _stc_bubbleBox = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnchant = true,
    createDuplicatedForDuel = true,
    createOriginalForDuel = true,
    isTranslation = true
  },
  _silverSlotConfig = {createIcon = true, createBorder = true},
  _lastMouseOnListIndex = nil,
  _isWareHouseOpen = false,
  _isWorldMapOpen = false,
  _isPadMode = false,
  _isConsole = false,
  _initialize = false,
  _searchResultCount = 0,
  _inputText = nil
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_TotalSearch_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_TotalSearch_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TotalSearchInit")
function FromClient_TotalSearchInit()
  PaGlobal_TotalSearch:initialize()
end
