PaGlobal_SailorPresetGroup_All = {
  _ui = {
    _btn_close = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _rdo_buttonList = Array.new()
  },
  _selectedPresetIndex = -1,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetGroup_All_1.lua")
runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetGroup_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SailorPresetGroup_All_luaLoadComplete")
function FromClient_SailorPresetGroup_All_luaLoadComplete()
  PaGlobal_SailorPresetGroup_All:initialize()
end
