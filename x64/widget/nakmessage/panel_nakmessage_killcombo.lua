PaGlobal_NakMessage_KillCombo = {
  _ui = {
    _stc_firstKill = nil,
    _txt_firstKill = nil,
    _stc_doubleKill = nil,
    _stc_tripleKill = nil,
    _stc_quadraKill = nil,
    _stc_pentaKill = nil
  },
  _showingInfo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_KillCombo_1.lua")
runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_KillCombo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_NakMessage_KillComboInit")
function FromClient_NakMessage_KillComboInit()
  PaGlobal_NakMessage_KillCombo:initialize()
end
