PaGlobal_SailorPreset_NameEdit_All = {
  _ui = {
    _btn_close = nil,
    _rdo_buttonList = Array.new(),
    _txt_presetName = nil,
    _edit_name = nil,
    _stc_bottomButton = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _stc_BottomBG = nil,
    _txt_ChangeName = nil,
    _txt_Confirm = nil,
    _txt_Cancel = nil,
    _txt_SelectGroup = nil
  },
  _indexForConsole = 1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All_1.lua")
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SailorPreset_NameEdit_All_luaLoadComplete")
function FromClient_SailorPreset_NameEdit_All_luaLoadComplete()
  PaGlobal_SailorPreset_NameEdit_All:initialize()
end
