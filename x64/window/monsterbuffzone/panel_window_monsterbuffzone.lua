PaGlobal_MonsterBuffZone = {
  _ui = {
    stc_effectBG = nil,
    stc_alertMessage = nil,
    txt_endurance = nil,
    btn_deactive = nil,
    prg_endurance = nil,
    txt_distance = nil,
    txt_distanceGlow = nil
  },
  _effectId = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone_1.lua")
runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MonsterBuffZoneInit")
function FromClient_MonsterBuffZoneInit()
  PaGlobal_MonsterBuffZone:initialize()
end
