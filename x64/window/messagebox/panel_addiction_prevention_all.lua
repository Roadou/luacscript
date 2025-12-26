PaGlobal_AddictionPrevent = {
  _ui = {
    stc_titleArea = nil,
    stc_blackBG = nil,
    txt_title = nil,
    txt_desc = nil,
    btn_exit = nil
  },
  _customArgument = 0,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AddictionPreventInit")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_AddictionPreventInit")
function FromClient_AddictionPreventInit()
  PaGlobal_AddictionPrevent:initialize()
end
FromClient_AddictionPreventInit()
