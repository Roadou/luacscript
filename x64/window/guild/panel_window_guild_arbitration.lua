PaGlobal_Guild_Arbitration = {
  _ui = {
    _stc_infoBG = nil,
    _stc_enemyGuildName = nil,
    _stc_myGuildName = nil,
    _btn_confirm = nil,
    _btn_refuse = nil,
    _txt_myGuildSign = nil,
    _stc_enemyGuildMark = nil,
    _stc_myGuildMark = nil,
    _txt_desc = nil,
    _stc_frame = nil,
    _stc_frameContent = nil,
    _scroll_vertical = nil
  },
  UNDEFINED_INDEX = -1,
  _enemyGuildWarringInfoIndex = UNDEFINED_INDEX,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_Arbitration_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_Arbitration_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_Arbitration_Init")
function FromClient_Guild_Arbitration_Init()
  PaGlobal_Guild_Arbitration:initialize()
end
