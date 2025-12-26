PaGlobal_LocalWarVoiceChat = {
  _ui = {
    _arr_Teammate_Info = {},
    _btn_Close = nil,
    _listening_Volume = nil,
    _listening_VolumeSlider = nil,
    _listening_VolumeSliderBtn = nil,
    _listening_VolumeClose = nil,
    _listening_VolumeButton = nil,
    _listening_VolumeValue = nil
  },
  _MAX_MEMBER_COUNT = 30,
  _perFrameTimer = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarTeam_SetVoiceChat_All_1.lua")
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarTeam_SetVoiceChat_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LocalWarTeam_SetVoiceChat_Init")
function FromClient_LocalWarTeam_SetVoiceChat_Init()
  PaGlobal_LocalWarVoiceChat:initialize()
end
