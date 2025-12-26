PaGlobal_SetupRepair_All = {
  _ui = {
    chk_button = {},
    stc_mainArea = nil,
    btn_save = nil,
    btn_close = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideY = nil,
    stc_keyGuideB = nil
  },
  _initialize = false,
  _isCamping = false
}
runLua("UI_Data/Script/Window/Repair/Panel_Window_SetupRepair_All_1.lua")
runLua("UI_Data/Script/Window/Repair/Panel_Window_SetupRepair_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SetupRepair_All_Init")
function FromClient_SetupRepair_All_Init()
  PaGlobal_SetupRepair_All:initialize()
end
