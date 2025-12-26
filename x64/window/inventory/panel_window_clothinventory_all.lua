PaGlobal_ClothInventory_All = {
  _ui = {
    stc_TitleBg = nil,
    stc_BlackBg = nil,
    stc_DescBg = nil,
    stc_itemSlotFrame = nil,
    stc_itemSlotFrameContent = nil,
    stc_SlotArea = nil,
    txt_Title = nil,
    txt_Desc = nil,
    stc_SlotBg = nil,
    btn_Close = nil,
    btn_ChangeAll = nil,
    stc_KeyGuide = nil
  },
  _config = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnduranceIcon = true
  },
  _currSlotInfo = {
    index = nil,
    fromSlotNo = nil,
    fromWhereType = nil
  },
  _bagType = nil,
  _bagSize = nil,
  _fromWhereType = nil,
  _fromSlotNo = nil,
  _inventoryBagType = nil,
  _slotColCount = nil,
  _slotBg = {},
  _slot = {},
  _titleOriginSizeX = 0,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_ClothInventory_All_Init")
function FromClient_ClothInventory_All_Init()
  PaGlobal_ClothInventory_All:initialize()
end
