PaGlobal_Artifacts_All = {
  _ui = {
    stc_titlebarArea = nil,
    stc_leftMainArea = nil,
    stc_tabTypeBg = nil,
    stc_rightTopArea = nil,
    stc_rightBottomArea = nil,
    stc_consoleArea = nil,
    stc_imageArea = nil,
    txt_desc = nil,
    stc_setOn = nil,
    txt_setTitle = nil,
    txt_setDesc = nil,
    stc_setOff = nil,
    txt_setNone = nil,
    btn_artifact = {},
    stc_artifactsSlotBg = {},
    stc_artifactSlot = {},
    stc_lightStoneInfoBg = {},
    stc_lightStoneInfo = {},
    stc_lightStoneSlotBg = {},
    stc_lightStoneSlot = {},
    list_artifact = nil,
    list_lightStone = nil,
    vscroll_artifactList = nil,
    vscroll_lightStoneList = nil,
    txt_emptyArtifact = nil,
    txt_emptyLightStone = nil,
    btn_showList = nil,
    btn_tab = {},
    stc_selectBar = nil
  },
  _ui_pc = {
    btn_question = nil,
    btn_close = nil,
    stc_LClick = nil,
    stc_RClick = nil
  },
  _ui_console = {
    stc_guideBg = nil,
    stc_iconLB = nil,
    stc_iconRB = nil,
    stc_select = nil,
    stc_cancle = nil,
    stc_detail = nil,
    stc_remove_lightStone = nil,
    stc_remove_artifact = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createDuplicatedForDuel = true,
    createOriginalForDuel = true
  },
  _TAB = {ARTIFACT = 1, LIGHTSTONE = 2},
  _crystalSlotBgUV = {
    normal = {
      x1 = 256,
      y1 = 1,
      x2 = 306,
      y2 = 51
    },
    disable = {
      x1 = 460,
      y1 = 205,
      x2 = 510,
      y2 = 255
    }
  },
  _PAD_SNAP_STATE = {
    Default = 0,
    OnMainSlot = 1,
    OnSubSlot = 2
  },
  _artifactSlotCount = 2,
  _lightStoneSlotCount = 2,
  _tabCount = 2,
  _artifactItemSlotInfo = {},
  _artifactList = {},
  _lightStoneList = {},
  _slotIconList = {},
  _slotNo = -1,
  _selectTab = 1,
  _selectArtifactIndex = 0,
  _whereType = CppEnums.ItemWhereType.eInventory,
  _indexInvenEnd = -1,
  _indexPopSocket = -1,
  _slotNoPopArtifact = -1,
  _lightStoneIndexPop = -1,
  _panelSizeY = nil,
  _isItemLock = false,
  _isOpenInven = false,
  _isOpenLightStoneBag = false,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_All_1.lua")
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Artifacts_All_Init")
function FromClient_Artifacts_All_Init()
  PaGlobal_Artifacts_All:initialize()
end
