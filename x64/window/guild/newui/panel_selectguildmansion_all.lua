PaGlobal_SelectGuildMansion_All = {
  _ui = {
    _btn_close = nil,
    _btn_search = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _edit_familyName = nil,
    _searchedResultList = nil,
    stc_KeyGuide_Bg = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_Y = nil,
    stc_content1 = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_SelectGuildMansion_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_SelectGuildMansion_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SelectGuildMansion_All_Init")
function FromClient_SelectGuildMansion_All_Init()
  PaGlobal_SelectGuildMansion_All:initialize()
end
