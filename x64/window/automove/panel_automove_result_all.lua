PaGlobal_AutoMove_Result_All = {
  _ui = {
    _stc_topGroup = nil,
    _stc_topGroup_stc_deco = nil,
    _stc_topGroup_txt_title = nil,
    _btn_close = nil,
    _stc_contentGroup = nil,
    _frame_autoMove = nil,
    _frame_content = nil,
    _frame_content_stc_group = nil,
    _frame_content_stc_group_txt_groupTitle = nil,
    _frame_content_stc_group_txt_groupTitle_stc_1 = nil,
    _frame_content_stc_group_stc_itemSlotBg = nil,
    _frame_content_verticalScroll = nil,
    _frame_content_verticalScroll_btn_frame_1_verticalScroll_upButton = nil,
    _frame_content_verticalScroll_btn_frame_1_verticalScroll_downButton = nil,
    _frame_content_verticalScroll_ctrlButton = nil,
    _frame_autoMove_scroll_frame_1_horizontalScroll = nil,
    _frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_upButton = nil,
    _frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_downButton = nil,
    _frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_ctrlButton = nil,
    _stc_functionButton = nil,
    _radioButton_current = nil,
    _radioButton_all = nil,
    _btn_autoMove = nil,
    _stc_desc = nil,
    _stc_desc_txt_desc = nil,
    _stc_key_guide_consoleUI = nil,
    _stc_key_guide_consoleUI_txt_coin_consoleUI = nil,
    _stc_key_guide_consoleUI_txt_close_consoleUI = nil,
    _frame_content = nil
  },
  _isCurrentWarehouse = true,
  _waypointGroup = {},
  _itemData = {},
  _itemSlot = {},
  _COL_SLOT_COUNT = 7,
  _ICON_SIZE = 46,
  _CONTENT_FRAME_SIZE_Y = 420,
  _ORIGIN_PANEL_SIZE_Y = 710,
  _SLOT_CONFIG = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnduranceIcon = true
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/AutoMove/Panel_AutoMove_Result_All_1.lua")
runLua("UI_Data/Script/Window/AutoMove/Panel_AutoMove_Result_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AutoMove_Result_All_Init")
function FromClient_AutoMove_Result_All_Init()
  PaGlobal_AutoMove_Result_All:initialize()
end
