PaGlobal_PalaceManagement_Map = {
  _ui = {
    btn_Close = nil,
    sts_title = nil,
    sts_BlackScreen = nil,
    btn_PalaceOpen = nil,
    btn_PalaceOpenDesc = nil,
    btn_shutDown = nil,
    st_consoleKeyGuide = nil
  },
  _uiToolTip = {
    st_NodeName = nil,
    st_NodeBg = nil,
    btn_NodeWorking = nil,
    st_WorkerBg = nil,
    st_WorkerImg = nil,
    st_WorkerEmpty = nil,
    st_WorkerText = nil,
    st_ActProgressBG = nil,
    st_ActProgress = nil,
    txt_ActProgressText = nil,
    st_BoardSpace = nil,
    st_BoardText = nil,
    st_itemSlotBG = {},
    st_selectedSlot = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = false,
    createEnchant = true,
    createEnduranceIcon = false,
    createOriginalForDuel = false
  },
  _tooltipItemSlot = {},
  _tooltipBoardItemCountMAX = 10,
  _waypointUI = 0,
  _boardGroupCount = 0,
  _scale = 1,
  _boardGroupData = {},
  _boardGroupControl = {},
  _boardGroupPos = {
    [1] = {_x = 480, _y = 130},
    [2] = {_x = 1250, _y = 280},
    [3] = {_x = 530, _y = 780},
    [4] = {_x = 790, _y = 800},
    [5] = {_x = 880, _y = 490},
    [6] = {_x = 830, _y = 130},
    [7] = {_x = 840, _y = 340},
    [8] = {_x = 500, _y = 420}
  },
  _initialize = false,
  _initializeTooltip = false
}
runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_1.lua")
runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PalaceMangement_Map_Init")
function FromClient_PalaceMangement_Map_Init()
  PaGlobal_PalaceManagement_Map:initialize()
end
