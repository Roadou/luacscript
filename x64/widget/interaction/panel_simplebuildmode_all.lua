PaGlobal_SimpleBuildMode_All = {
  _ui = {
    _stc_commandBg = nil,
    _stc_showCommandBg = nil,
    _btn_showCommand = nil,
    _keyGuideArray = {}
  },
  _eKeyGuideType = {
    FIX = 0,
    MOVE_CLICK = 1,
    ROTATE_LEFT = 2,
    ROTATE_RIGHT = 3,
    ROTATE_FAST_LEFT = 4,
    ROTATE_FAST_RIGHT = 5,
    CHANGE_CAMERA_MODE = 6,
    INSTALL = 7,
    CANCLE = 8,
    COUNT = 9
  },
  _prevCameraPitch = nil,
  _isShowCommond = false,
  _isShowSkillCommond = false,
  _isCheckDelay = false,
  _isChangeCameraMode = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Interaction/Panel_SimpleBuildMode_All_1.lua")
runLua("UI_Data/Script/Widget/Interaction/Panel_SimpleBuildMode_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SimpleBuildMode_All_Init")
function FromClient_SimpleBuildMode_All_Init()
  PaGlobal_SimpleBuildMode_All:initialize()
end
