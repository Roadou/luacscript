PaGlobal_LifeRingMenu_All = {
  _ui = {
    _stc_area = {}
  },
  _config = {
    _keyPressTimeMax = 0.1,
    _keyBinding = CppEnums.VirtualKeyCode.KeyCode_OEM_7,
    _exceptKey1 = CppEnums.VirtualKeyCode.KeyCode_SHIFT,
    _exceptKey2 = CppEnums.VirtualKeyCode.KeyCode_CONTROL,
    _actionModeCount = __eActionMode_Normal + 1
  },
  _areaInfo = {
    [0] = {
      name = "Fishing",
      value = __eActionMode_FishingRod,
      itemKey = 767045,
      itemName = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_FISHING"),
      slotNo = __eEquipSlotNoFishingRod
    },
    [1] = {
      name = "Jaksal",
      value = __eActionMode_FishingHarpoon,
      itemKey = 767046,
      itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_FISHINGHARPOON"),
      slotNo = __eEquipSlotNoFishingHarpoon
    },
    [2] = {
      name = "Combat",
      value = __eActionMode_Normal,
      itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFESTANCE_COMBAT"),
      slotNo = nil
    }
  },
  _keyPressTime = 0,
  _uiScale = 0,
  _panelLeftTopPos = {},
  _screenCenterPos = {},
  _lastSelectAreaIdx = -1,
  _currentMode = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All_1.lua")
runLua("UI_Data/Script/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LifeRingMenu_All_Init")
function FromClient_LifeRingMenu_All_Init()
  PaGlobal_LifeRingMenu_All:initialize()
end
