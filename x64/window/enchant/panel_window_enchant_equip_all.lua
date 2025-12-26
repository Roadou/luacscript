PaGlobal_EnchantEquip_All = {
  _ui = {
    stc_titleBox = nil,
    radiobtn_Bg = nil,
    rdo_inven = nil,
    rdo_pearlInven = nil,
    stc_selectBar = nil,
    radiobtn_slot = nil,
    radiobtn_list = nil,
    frame_itemList = nil,
    frame_content = nil,
    stc_listGroup = nil,
    stc_slotGroup = nil,
    txt_noItem = nil,
    stc_keyGuide = nil,
    scroll_vertical = nil,
    scroll_vertical_btn = nil
  },
  _listItemSlots = {},
  _categoryList = {},
  _inventoryWhereType = CppEnums.ItemWhereType.eInventory,
  _isConsole = false,
  COLUMN_PER_ROW = 8,
  CONTENT_MIN_HEIGHT = 160,
  SLOT_OFFSET = 15,
  CATEGORY_OFFSET = 15,
  SLOT_SIZE = 52,
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnduranceIcon = true
  }
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Equip_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Equip_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantEquip_All_Init")
function FromClient_EnchantEquip_All_Init()
  PaGlobal_EnchantEquip_All:initialize()
end
