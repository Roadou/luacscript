PaGlobal_HopeGauge_Console = {
  _ui = {
    _stc_MainBG = nil,
    _btn = Array.new(),
    _icon_Center = nil,
    _icon_grade = Array.new(),
    _stc_State = nil,
    _txt_RemainTime = nil,
    _keyGuide_Area = nil,
    _keyGuide_Y = nil,
    _keyGuide_B = nil,
    _keyGuide_A = nil,
    _keyGuide_X = nil,
    _keyGuide_LT = nil,
    _keyGuide_RT = nil,
    _keyGuide_DPad = nil,
    _stc_ItemSlots = Array.new(),
    _icon_bg = nil,
    _txt_itemName = nil
  },
  _config = {
    _slotConfig = {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createCash = true
    },
    _startX = 10,
    _startY = 50,
    _gapX = 50,
    _gapY = 40,
    _col = 5,
    _row = 2,
    _checkX = 10,
    _checkY = 5,
    _feedStaticItemCount = 5
  },
  _selectedCount = 0,
  _selectItemIndex = 0,
  _selectedPoint = 0,
  _selectedGrade = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Console/Panel_Widget_HopeGauge_Console_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Console/Panel_Widget_HopeGauge_Console_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_HopeGauge_Console")
function FromClient_PaGlobal_HopeGauge_Console()
  PaGlobal_HopeGauge_Console:initialize()
end
