PaGlobal_RoseWarMissionWidget = {
  _ui = {
    _stc_progressMissionArea = nil,
    _stc_typeIcon = nil,
    _stc_missionName = nil,
    _stc_remainTimeIcon = nil,
    _txt_remainTime = nil,
    _btn_navi = nil,
    _stc_result_complete = nil,
    _stc_result_fail = nil
  },
  _eResultType = {
    COMPLTE = 0,
    FAIL = 1,
    COUNT = 2
  },
  _checkResultShowTime = false,
  _showResultTimeSec = 0,
  _showResultTimeSecMax = 5,
  _currentProgressMissionKey = nil,
  _remainTime = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionWidget_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionWidget_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FromClient_RoseWarMissionWidgetInit")
function FromClient_FromClient_RoseWarMissionWidgetInit()
  PaGlobal_RoseWarMissionWidget:initialize()
end
