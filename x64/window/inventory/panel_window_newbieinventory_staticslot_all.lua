PaGlobal_NewbieInventory = {
  _ui = {
    _stc_body = nil,
    _arrowEffect = nil,
    _stc_title = nil,
    _btn_close = nil,
    _stc_topItemSortBG = nil,
    _btn_sort_set = nil,
    _chk_itemSort = nil,
    _stc_capacity = nil,
    _stc_mainSlotBG = nil,
    _stc_scrollArea = nil,
    _scroll = nil,
    _stc_WeightArea = nil,
    _txt_Weight = nil,
    _stc_block = nil,
    _btn_send = nil,
    _stc_keyGuide = nil,
    _btn_moveItem = nil
  },
  _showStartSlot = 0,
  _maxSlotCount = 50,
  _slotCols = 8,
  _showSlotCount = 0,
  _staticSlots = nil,
  _slotsBG = nil,
  _capacity = 0,
  _tooltipSlotNo = nil,
  _isPadMode = false,
  _initialize = false,
  _restrictOpen = false,
  _canMoveItem = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_NewbieInventory")
function FromClient_NewbieInventory()
  PaGlobal_NewbieInventory:initialize()
end
