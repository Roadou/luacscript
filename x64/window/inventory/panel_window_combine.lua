PaGlobal_CombineBag = {
  _ui = {
    btn_close = nil,
    btn_puzzle = nil,
    stc_titleBox = nil,
    stc_noticeBox = nil,
    stc_puzzleNotice = nil,
    txt_puzzleNoticeText = nil,
    stc_keyGuide = nil
  },
  _config = {
    slotCount = 25,
    slotRows = 5,
    slotCols = 5
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _PAD_SNAP_STATE = {
    Default = 0,
    OnItem = 1,
    OnPuzzleBtn = 2
  },
  _slots = nil,
  _slotsEffect = nil,
  _tooltipSlotNo = nil,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Combine_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Combine_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitCombine")
function FromClient_InitCombine()
  PaGlobal_CombineBag:initialize()
end
