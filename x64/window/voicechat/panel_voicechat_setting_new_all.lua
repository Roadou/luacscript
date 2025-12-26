PaGlobal_VoiceChat_Setting_New = {
  _ui = {
    _stc_insideBG = nil,
    _combo_channel = nil,
    _chk_speakerOnOff = nil,
    _chk_MICOnOff = nil,
    _chk_pushToTalk = nil,
    _slider_MIC = nil,
    _slider_MIC_Text = nil,
    _slider_MIC_Btn = nil,
    _slider_MICSense = nil,
    _slider_MICSense_Text = nil,
    _slider_MICSense_Btn = nil,
    _slider_speaker = nil,
    _slider_speaker_Text = nil,
    _slider_speaker_Btn = nil,
    _btn_confirm = nil,
    _btn_cancel = nil,
    _stc_keyGuide = nil,
    _txt_keyGuideA = nil,
    _txt_keyGuideB = nil,
    _txt_keyGuideY = nil,
    _btn_close = nil
  },
  _arr_comboListValue = nil,
  _initialize = false,
  _isSetUpPTT = false,
  _isPadMode = false
}
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Setting_New_All_1.lua")
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Setting_New_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_VoiceChat_Setting_New_Init")
function FromClient_VoiceChat_Setting_New_Init()
  PaGlobal_VoiceChat_Setting_New:initialize()
end
