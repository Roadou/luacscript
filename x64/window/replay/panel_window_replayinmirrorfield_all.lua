PaGlobal_ReplayControllerInMirrorField = {
  _ui = {
    _stc_replayControllerBg = nil,
    _stc_timeLineBar = nil,
    _btn_timeLine = nil,
    _btn_timeLineEventTemplate = nil,
    _stc_timeLineEventPool = nil,
    _btn_left = nil,
    _btn_right = nil,
    _cbx_play = nil,
    _btn_stop = nil,
    _txt_replayName = nil,
    _txt_replayTime = nil,
    _stc_commandBg = nil
  },
  _replayRecordType = nil,
  _replayLength = 0,
  _currentTime = 0,
  _isFinishLoadReplay = false,
  _timeLineEventPoolCount = 0,
  _prevUIMode = nil,
  _renderMode = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayInMirrorField_All_2.lua")
runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayInMirrorField_All_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitInstanceContentsReplay")
function FromClient_InitInstanceContentsReplay()
  PaGlobal_ReplayControllerInMirrorField:initialize()
end
