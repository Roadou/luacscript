PaGlobal_Memo_All = {
  _ui = {
    _stc_TitleBg = nil,
    _btn_Close = nil,
    _btn_AddMemo = nil,
    _btn_AllRemove = nil,
    _List2 = nil,
    _stcText_NoMemoAlert = nil
  },
  _id = {},
  _stickyMemoList = {},
  _currentFocusId = nil,
  _currentFocusContent = nil,
  _SaveMode = {
    TEXT = 0,
    SETTING = 1,
    ALL = 2
  },
  _ResizeType = {
    Vertical = 0,
    Horizontal = 1,
    Diagonal = 2
  },
  _memoTitleBG_OrgSizeX = 0,
  _removeMemoBtn_OrgPosX = 0,
  _BASE_LINE = 9,
  _MAX_LINE = 100,
  _MAX_TEXT = 2000,
  _MAX_TEXT_CH = 350,
  _orgMouseX = nil,
  _orgMouseY = nil,
  _orgPanelPosX = nil,
  _orgPanelSizeX = nil,
  _orgPanelSizeY = nil,
  _orgSubPanelSizeX = nil,
  _orgSubPanelSizeY = nil,
  _currentSaveMode = nil,
  _isClose = false,
  _initialize = false,
  _fontColorCode = {
    "0xff800000",
    "0xffff6600",
    "0xff808000",
    "0xff008000",
    "0xff008080",
    "0xff0000ff",
    "0xff666699",
    "0xff7a869a",
    "0xffff0000",
    "0xffff9900",
    "0xff99cc00",
    "0xff339966",
    "0xff33cccc",
    "0xff3366ff",
    "0xff800080",
    "0xff000000",
    "0xffff00ff",
    "0xffffcc00",
    "0xffffff00",
    "0xff00ff00",
    "0xff00ffff",
    "0xff00ccff",
    "0xff993366",
    "0xffc4bebe",
    "0xffff99cc",
    "0xffffcc99",
    "0xffffff99",
    "0xffccffcc",
    "0xffccffff",
    "0xff99ccff",
    "0xffcc99ff",
    "0xffffffff"
  },
  _stickyMinSizeY = 212,
  _stickyMinSizeX = 300
}
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_1.lua")
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_2.lua")
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Memo_Main_Init")
function PaGlobal_Memo_Main_Init()
  PaGlobal_Memo_All:initialize()
end
