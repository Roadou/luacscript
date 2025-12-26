PaGlobal_Extraction_Artifacts_All = {
  _ui = {
    txt_desc = nil,
    stc_lightStoneInfo = {
      [1] = {
        stc_lightStone = nil,
        txt_name = nil,
        txt_desc = nil,
        btn_extraction = nil,
        stc_itemSlot = nil,
        isEmpty = true
      },
      [2] = {
        stc_lightStone = nil,
        txt_name = nil,
        txt_desc = nil,
        btn_extraction = nil,
        stc_itemSlot = nil,
        isEmpty = true
      }
    },
    list2_extractableItem = nil,
    list2_materialItem = nil,
    txt_noItem = nil,
    stc_materialItemSlot = nil,
    stc_extractionItemSlot = nil,
    stc_extractImage = nil
  },
  _ui_pc = {btn_question = nil, btn_close = nil},
  _ui_console = {
    stc_guideBg = nil,
    stc_iconX = nil,
    stc_iconA = nil,
    stc_iconB = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createOriginalForDuel = true
  },
  _listSlotConfig = {
    createIcon = false,
    createEnchant = true,
    createOriginalForDuel = true
  },
  _extractionItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    itemEnchantLevle = {},
    isExtractionEquip = {false}
  },
  _materialItemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    whereType = {},
    isExtractionEquip = {false},
    itemCnt = {}
  },
  _materialEnchantKey = {
    stuffCrystalExtraction = ItemEnchantKey(757561)
  },
  _artifactList = {},
  _artifactInvenEnd = -1,
  _artifactWhereType = nil,
  _artifactSlotNo = nil,
  _materialList = {},
  _materialCount = 0,
  _materialWhereType = nil,
  _materialSlotNo = nil,
  _isRemove = false,
  _resultShowTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All_1.lua")
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Extraction_Artifacts_All_Init")
function FromClient_Extraction_Artifacts_All_Init()
  PaGlobal_Extraction_Artifacts_All:initialize()
end
