PaGlobal_QuickTimeEvent_CircleKeyDown = {
  _MANAGER = PaGlobal_QuickTimeEvent_Manager,
  _ui = {},
  _initialize = false,
  _sizeScale = 1000,
  _keyEventControlList = {},
  MAX_CONTROL_COUNT = 20,
  _initialize = false
}
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_CircleKeyDown_1.lua")
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_CircleKeyDown_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_QuickTimeEvent_CircleKeyDown_Init")
function FromClient_QuickTimeEvent_CircleKeyDown_Init()
  PaGlobal_QuickTimeEvent_CircleKeyDown:initialize()
end
