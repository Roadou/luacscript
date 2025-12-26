PaGlobal_VoiceChat_List_New = {
  _ui = {
    _stc_channelBG = nil,
    _txt_channelName = nil,
    _txt_myName = nil,
    _txt_myNameTalk = nil,
    _stc_myClassType = nil,
    _chk_myMic = nil,
    _chk_myListen = nil,
    _list2_memberList = nil,
    _btn_setting = nil,
    _chk_sticker = nil,
    _btn_close = nil,
    _mulTxt_noBody = nil,
    _slider_personalVolume_BG = nil,
    _slider_personalVolume = nil,
    _slider_personalVolume_BTN = nil,
    _slider_personalVolume_TXT = nil,
    _slider_personalVolume_EXIT = nil,
    _stc_subMenu_BG = nil,
    _btn_mute = nil,
    _btn_whisper = nil,
    _btn_party = nil,
    _stc_keyGuideBG = nil,
    _btn_padY = nil,
    _btn_padA = nil,
    _btn_padB = nil,
    _btn_padLB = nil,
    _btn_padRB = nil
  },
  _targetFunctionIndex = nil,
  _personalVolumeTargetUserNo = nil,
  _personalVolumeTargetIndex = nil,
  _isPadMode = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_List_New_1.lua")
runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_List_New_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_VoiceChat_List_New_Init")
function FromClient_VoiceChat_List_New_Init()
  PaGlobal_VoiceChat_List_New:initialize()
end
