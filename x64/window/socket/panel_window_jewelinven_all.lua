JewelInvenMode = {
  PushOrPopMode = 0,
  ExtractMode = 1,
  InventoryMode = 2
}
JewelSortType = {
  SortByGroupNumber = 0,
  SortByName = 1,
  SortByGrade = 2
}
JewelViewType = {List = 0, Slot = 1}
PaGlobal_JewelInven = {
  _ui = {
    stc_TitleBarArea = nil,
    btn_Question = nil,
    btn_Close = nil,
    stc_TopArea = nil,
    stc_JewelCount = nil,
    rdo_SortByName = nil,
    rdo_SortByGroup = nil,
    rdo_SortByGrade = nil,
    chk_TrashButton = nil,
    rdo_ViewByList = nil,
    rdo_ViewBySlot = nil,
    stc_ListBG = nil,
    list2_Jewel = nil,
    list2_JewelContent = nil,
    scroll_Vertical = nil,
    stc_SlotBG = nil,
    stc_Frame = nil,
    stc_FrameContent = nil,
    stc_VerticalScroll = nil,
    stc_BottomArea = nil,
    btn_AddJewel = nil,
    rdo_ExtractByTool = nil,
    rdo_ExtractByBlackSpirit = nil,
    stc_DescArea = nil,
    stc_Desc = nil,
    stc_TrashArea = nil,
    stc_TrashDesc = nil,
    btn_Delete = nil,
    btn_Cancel = nil,
    stc_Console_Buttons = nil,
    btn_Console_Delete = nil,
    btn_Console_Select = nil,
    btn_Console_Cancel = nil,
    btn_Console_Detail = nil,
    btn_Console_PresetList = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCheckBox = true
  },
  _extractionSlotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true
  },
  _materialItemInfo = {
    slotNo = {},
    whereType = {}
  },
  _materialEnchantKey = {
    stuffCrystalExtraction = ItemEnchantKey(16000),
    stuffBlackspirit = ItemEnchantKey(17000)
  },
  _extractionItemTable = {},
  _jewelInvenMode = JewelInvenMode.PushOrPopMode,
  _jewelSortType = JewelSortType.SortByGroupNumber,
  _jewelViewType = JewelViewType.List,
  _deleteJewelList = {},
  _isOpenFromInventory = false,
  _jewelSlotList = {},
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelInven_All_1.lua")
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelInven_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_JewelInvenInit")
function FromClient_JewelInvenInit()
  PaGlobal_JewelInven:initialize()
end
