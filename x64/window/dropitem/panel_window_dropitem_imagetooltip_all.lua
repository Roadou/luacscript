PaGlobal_DropItemImageToolTip_All = {
  _ui = {
    _txt_name = nil,
    _txt_desc = nil,
    _stc_line = nil,
    _stc_image = nil
  },
  _initialize = nil
}
runLua("UI_Data/Script/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All_1.lua")
runLua("UI_Data/Script/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Init_DropItemImageToolTip_All")
function FromClient_Init_DropItemImageToolTip_All()
  PaGlobal_DropItemImageToolTip_All:initialize()
end
