PaGlobal_VillageSiegeStateWidget = {
  _ui = {
    _stc_titleBg = nil,
    _txt_title = nil,
    _btn_change = nil,
    _lst_siegeTentList = nil
  },
  _eTerritoryKeyRaw = {
    BALENOS = 0,
    SERENDIA = 1,
    CALPHEON = 2,
    MEDIA = 3,
    VALENCIA = 4,
    KAMASYLVIA = 6
  },
  _isConsole = false,
  _accumulatedDeltaTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Siege/Panel_Widget_VillageSiegeState_All_1.lua")
runLua("UI_Data/Script/Window/Siege/Panel_Widget_VillageSiegeState_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_VillageSiegeStateWidgetInit")
function FromClient_VillageSiegeStateWidgetInit()
  PaGlobal_VillageSiegeStateWidget:initialize()
end
