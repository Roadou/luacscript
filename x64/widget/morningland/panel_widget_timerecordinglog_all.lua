PaGlobal_TimeRecording = {
  _ui = {txt_Time = nil},
  _visibleTime = 0,
  _fadeTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All_1.lua")
runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_TimeRecording_Init")
function FromClient_PaGlobal_TimeRecording_Init()
  PaGlobal_TimeRecording:initialize()
end
