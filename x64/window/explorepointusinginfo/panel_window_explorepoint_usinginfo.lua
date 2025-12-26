PaGlobal_ExplorePoint_UsingInfo = {
  _ui = {
    _stc_emptyResult = nil,
    _stc_selectBar = nil,
    _searchedResultList = nil,
    _radioTabs = {},
    _stc_bottomArea = nil,
    _txt_usingPoint = nil,
    _txt_totalPoint = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true,
    createEnchant = true
  },
  _silverSlotConfig = {createIcon = true, createBorder = true},
  _lastMouseOnListIndex = nil,
  _isWareHouseOpen = false,
  _isWorldMapOpen = false,
  _isPadMode = false,
  _isConsole = false,
  _initialize = false,
  _SEARCHTYPE = {
    HOUSE = 1,
    NODE = 2,
    ITEM = 3,
    COUNT = 4
  },
  _searchResultCount = {},
  _sortArray = {},
  _houseType = {},
  _nodeType = {},
  _itemType = {},
  _currentSearchType = nil
}
runLua("UI_Data/Script/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo_1.lua")
runLua("UI_Data/Script/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExplorePoint_UsingInfoInit")
function FromClient_ExplorePoint_UsingInfoInit()
  PaGlobal_ExplorePoint_UsingInfo:initialize()
end
