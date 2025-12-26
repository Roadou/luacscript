PaGlobal_HardCoreCompass = {
  _ui = {
    _stc_line = nil,
    _stc_direction = {}
  },
  DirectionType = {
    NORTH = 0,
    EAST = 1,
    SOUTH = 2,
    WEST = 3,
    COUNT = 4
  },
  _bossMax = 2,
  _bossIcon = {},
  _bossData = {},
  _rankerMax = 10,
  _rankerIcon = {},
  _rankerData = {},
  _rankerVisibleMax = 3,
  _rankerDistanceHide = 300,
  _npcMax = 2,
  _npcIcon = {},
  _npcData = {},
  _npcDistanceHide = 500,
  _initialize = false,
  _lineSize = 1,
  _hideAngle = 175
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Compass_Hardcore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Compass_Hardcore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_HardCoreCompass_Init")
function FromClient_PaGlobal_HardCoreCompass_Init()
  PaGlobal_HardCoreCompass:initialize()
end
