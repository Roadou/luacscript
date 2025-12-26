PaGlobal_CameraMode_All = {
  _ui = {
    stc_title = nil,
    txt_distance = nil,
    stc_line = {},
    stc_dot = {}
  },
  _sequence = {
    LEFT_TOP = 1,
    RIGHT_TOP = 2,
    LEFT_BOTTOM = 3,
    RIGHT_BOTTOM = 4
  },
  _dotLine = {},
  _distanceCheckInterval = 0,
  _distanceCheckTime = 0.05,
  _distancePer = 0,
  _minDistance = 0,
  _maxDistance = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camera/Panel_Widget_Camera_Mode_All_1.lua")
runLua("UI_Data/Script/Widget/Camera/Panel_Widget_Camera_Mode_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CameraMode_All_Init")
function FromClient_CameraMode_All_Init()
  PaGlobal_CameraMode_All:initialize()
end
