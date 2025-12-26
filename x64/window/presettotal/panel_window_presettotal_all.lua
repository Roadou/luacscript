PaGlobal_TotalPreset = {
  _ui = {
    btn_Close = nil,
    stc_Frame = nil,
    stc_FrameContent = nil,
    btn_ComboBox = nil,
    presetControl = {},
    btn_ChangeName = nil,
    btn_ApplyPreset = nil,
    btn_PresetTemplate = nil,
    stc_Class = nil
  },
  _currentPresetKey = 1,
  _selectPresetList = {},
  _initialize = false,
  _isConsole = false,
  _undefinedPresetNo = -1,
  _frameSizeY = 0,
  _skillType = 0,
  _classType = 0
}
runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotal_All_1.lua")
runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "Panel_Window_TotalPreset_Init")
function Panel_Window_TotalPreset_Init()
  PaGlobal_TotalPreset:initialize()
end
