PaGlobal_RadioPlayer = {
  _initialize = false,
  _uiMain = {
    topBG,
    waveBG,
    btn_Min,
    btn_Close,
    chk_Onoff,
    txt_ChannelName,
    txt_Title,
    chk_IconVolume,
    slider_1,
    slider_1_btn,
    progress2_2,
    btn_ChannelL,
    btn_ChannelPlay,
    btn_ChannelPause,
    btn_ChannelR,
    chk_AutoOn,
    progressBG,
    progress2_1,
    progress2_1_Bar,
    txt_PlayTime
  },
  _uiMini = {
    topBG,
    btn_Max,
    btn_Close,
    chk_Onoff,
    txt_ChannelName,
    txt_Title,
    btn_ChannelL,
    btn_ChannelPlay,
    btn_ChannelPause,
    btn_ChannelR
  },
  _uiMasking = {txt_ChannelName1, txt_ChannelName2},
  _isLargeVersion,
  _timeUpdateDelta = 1,
  _currentTime = 0,
  _audioLength = 0,
  _needChannelMove = false,
  _mainPosX = 0,
  _mainPosY = 0,
  _miniPosX = 0,
  _miniPosY = 0,
  _isMaskingUpdate = false,
  _volume = 0
}
runLua("UI_Data/Script/Widget/RadioPlayer/Panel_Widget_RadioPlayer_All_1.lua")
runLua("UI_Data/Script/Widget/RadioPlayer/Panel_Widget_RadioPlayer_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RadioPlayerInit")
function FromClient_RadioPlayerInit()
  PaGlobal_RadioPlayer:initialize()
end
