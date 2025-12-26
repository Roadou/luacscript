PaGlobal_EnchantInventory_All = {
  _ui = {
    _btn_sortOption = nil,
    _chkSort = nil,
    _stcCapacity = nil,
    _stc_scrollArea = nil,
    _scroll = nil,
    _btnBuyWeight = nil,
    _progressWeight = nil,
    _stcWeight = nil,
    _stcWeightIcon = nil
  },
  _maxSlotCount = 0,
  _showStartSlot = 0,
  _showSlotCount = 0,
  _slotCols = 8,
  _slotsBG = nil,
  _slots = nil,
  _capacity = nil,
  _tooltipSlotNo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_EnchantInventory_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_EnchantInventory_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantInventory_All_Init")
function FromClient_EnchantInventory_All_Init()
  PaGlobal_EnchantInventory_All:initialize()
end
