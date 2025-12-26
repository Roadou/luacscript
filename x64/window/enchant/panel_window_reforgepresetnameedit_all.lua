PaGlobal_ReforgePresetNameEdit = {
  _ui = {
    btn_Close = nil,
    rdo_Button = {},
    txt_PresetName = nil,
    edit_Name = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    btn_Reset = nil,
    stc_BottomBG = nil,
    txt_ChangeName = nil,
    txt_Confirm = nil,
    txt_Cancel = nil,
    txt_SelectPreset = nil,
    txt_ResetName = nil
  },
  _presetCount = 5,
  _indexForConsole = 0,
  _btnGapX = 5,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReforgePresetNameEdit_All_Init")
function FromClient_ReforgePresetNameEdit_All_Init()
  PaGlobal_ReforgePresetNameEdit:initialize()
end
