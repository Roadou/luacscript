PaGlobal_Widget_Tutorial_GuideUI = {
  _ui = {
    _stc_image = UI.getChildControl(Panel_Widget_Tutorial_GuideUI, "Static_Image"),
    _stc_focus = UI.getChildControl(Panel_Widget_Tutorial_GuideUI, "Static_EffectArea")
  },
  _blackBGList = {
    LT = 0,
    CT = 0,
    RT = 0,
    RC = 0,
    RB = 0,
    CB = 0,
    LB = 0,
    LC = 0,
    CC = 0
  },
  _whiteBGList = {
    LT = 0,
    CT = 0,
    RT = 0,
    RC = 0,
    RB = 0,
    CB = 0,
    LB = 0,
    LC = 0,
    CC = 0
  },
  _effectInfo = nil,
  _toTime = 0,
  _findControl = nil,
  _selectedPanel = nil,
  _joyPadKey = {
    __eJoyPadInputType_LeftStick_Up,
    __eJoyPadInputType_LeftStick_Down,
    __eJoyPadInputType_LeftStick_Left,
    __eJoyPadInputType_LeftStick_Right,
    __eJoyPadInputType_RightStick_Up,
    __eJoyPadInputType_RightStick_Down,
    __eJoyPadInputType_RightStick_Left,
    __eJoyPadInputType_RightStick_Right,
    __eJoyPadInputType_LeftTrigger,
    __eJoyPadInputType_RightTrigger,
    __eJoyPadInputType_DPad_Up,
    __eJoyPadInputType_DPad_Down,
    __eJoyPadInputType_DPad_Left,
    __eJoyPadInputType_DPad_Right,
    __eJoyPadInputType_Start,
    __eJoyPadInputType_Back,
    __eJoyPadInputType_LeftThumb,
    __eJoyPadInputType_RightThumb,
    __eJoyPadInputType_LeftShoulder,
    __eJoyPadInputType_RightShoulder,
    __eJoyPadInputType_A,
    __eJoyPadInputType_B,
    __eJoyPadInputType_X,
    __eJoyPadInputType_Y
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI_1.lua")
runLua("UI_Data/Script/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Widget_Tutorial_GuideUI_Init")
function FromClient_PaGlobal_Widget_Tutorial_GuideUI_Init()
  PaGlobal_Widget_Tutorial_GuideUI:initialize()
end
