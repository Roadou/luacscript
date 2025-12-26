PaGlobal_ValksList_All = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_mainSlotBG = nil,
    stc_listArea = nil,
    frame_itemList = nil,
    frame_content = nil,
    scroll_vertical = nil,
    stc_keyGuide = nil,
    stc_keyGuide_B = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  COLUMN_PER_ROW = 8,
  SLOT_OFFSET = 15,
  SLOT_SIZE = 53,
  _listItemSlots = {},
  _isConsole = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ValksList_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ValksList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ValksList_All_Init")
function FromClient_ValksList_All_Init()
  PaGlobal_ValksList_All:initialize()
end
