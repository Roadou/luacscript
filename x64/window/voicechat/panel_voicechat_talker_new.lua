PaGlobal_VoiceChat_Talker_New = {
  _ui = {
    _arr_control = {}
  },
  _selfPlayerUserNickname = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Talker_New_1.lua")
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Talker_New_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_VoiceChat_Talker_New")
function FromClient_VoiceChat_Talker_New()
  PaGlobal_VoiceChat_Talker_New:initialize()
end
