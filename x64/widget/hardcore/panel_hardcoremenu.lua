PaGlobal_HardCoreMenu = {
  _ui = {
    _btn_CharacterInfo = nil,
    _btn_Skill = nil,
    _btn_Ranking = nil,
    _btn_UISetting = nil,
    _btn_Escape = nil,
    _btn_RingMenu_Option = nil,
    _stc_line = nil,
    _btn_Option = nil,
    _btn_GameExit = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/HardCore/Panel_HardCoreMenu_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_HardCoreMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreEscMenu_Init")
function FromClient_HardCoreEscMenu_Init()
  PaGlobal_HardCoreMenu:initialize()
end
