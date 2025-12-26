PaGlobal_TrashBoxMode = {InventoryMode = 0, JewelInvenMode = 1}
PaGlobal_TrashBoxConfirm_All = {
  _ui = {
    _btn_close = nil,
    _btn_yes = nil,
    _btn_no = nil
  },
  _config = {_INVEN_MAX_SLOTNO = 194},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true
  },
  _deleteItemInfoList = {},
  _deleteMode = PaGlobal_TrashBoxMode.InventoryMode,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_TrashBoxConfirm_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_TrashBoxConfirm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TrashBoxConfirm_Init")
function FromClient_TrashBoxConfirm_Init()
  PaGlobal_TrashBoxConfirm_All:initialize()
end
