Widget_Function_Type_Console = {
  GrowthPass = 0,
  YachtPvP = 1,
  EnterToHadumField = 2,
  SpecialPass = 3,
  Count = 4
}
PaGlobal_Widget_FunctionButton_Console = {
  _ui = {},
  _button = {
    [Widget_Function_Type_Console.GrowthPass] = nil,
    [Widget_Function_Type_Console.YachtPvP] = nil,
    [Widget_Function_Type_Console.EnterToHadumField] = nil,
    [Widget_Function_Type_Console.SpecialPass] = nil
  },
  _buttonShow = {
    [Widget_Function_Type_Console.GrowthPass] = false,
    [Widget_Function_Type_Console.YachtPvP] = false,
    [Widget_Function_Type_Console.EnterToHadumField] = false,
    [Widget_Function_Type_Console.SpecialPass] = false
  },
  _growthPassIconValue = {
    _accDeltaTime = 0,
    _showTime = 10,
    _doUpdate = false,
    _keptGrowthPassIntroBubbleTextControl = false,
    _growthPassEffectNo = nil
  },
  _yachtIconValue = {
    _accDeltaTime = 0,
    _showTime = 10,
    _doUpdate = false
  },
  _enterToHadumFieldIconValue = {
    _curUpdateTime = 0,
    _maxUpdateTime = 0.5,
    _enterToHadumFieldEffectNo = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/RightTopIcons/Renewal/Console/Panel_Widget_FunctionButton_Console_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/Renewal/Console/Panel_Widget_FunctionButton_Console_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_FunctionButton_Console_Init")
function FromClient_Widget_FunctionButton_Console_Init()
  PaGlobal_Widget_FunctionButton_Console:initialize()
end
