local BattleSoundType = {
  _name = "BattleSoundType",
  _value = 1,
  _controlType = __ePAUIControl_RadioButton,
  _settingRightNow = true
}
local AudioResourceType = {
  _name = "AudioResourceType",
  _value = 0,
  _controlType = __ePAUIControl_RadioButton
}
local VolumeMaster = {
  _name = "VolumeMaster",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true
}
local EnableMusic = {
  _name = "EnableMusic",
  _value = true,
  _controlType = __ePAUIControl_CheckButton,
  _settingRightNow = true
}
local VolumeMusic = {
  _name = "VolumeMusic",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true
}
local EnableSound = {
  _name = "EnableSound",
  _value = true,
  _controlType = __ePAUIControl_CheckButton,
  _settingRightNow = true
}
local VolumeFx = {
  _name = "VolumeFx",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true
}
local VolumeHitFxVolume = {
  _name = "VolumeHitFxVolume",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true,
  _isSubSlider = true
}
local VolumeHitFxWeight = {
  _name = "VolumeHitFxWeight",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true,
  _isSubSlider = true
}
local VolumeOtherPlayer = {
  _name = "VolumeOtherPlayer",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true,
  _isSubSlider = true
}
local VolumeMusicPlay = {
  _name = "VolumeMusicPlay\t",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true,
  _isSubSlider = true
}
local EnableEnv = {
  _name = "EnableEnv",
  _value = true,
  _controlType = __ePAUIControl_CheckButton,
  _settingRightNow = true
}
local VolumeEnv = {
  _name = "VolumeEnv",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true
}
local VolumeDlg = {
  _name = "VolumeDlg",
  _value = 1,
  _controlType = __ePAUIControl_Slider,
  _sliderValueMin = 0,
  _sliderValueMax = 100,
  _settingRightNow = true
}
BattleSoundType._title = "PANEL_NEWGAMEOPTION_BattleSoundType"
BattleSoundType._desc = nil
BattleSoundType._radioButtonMapping = {
  [0] = {
    _string = "PANEL_NEWGAMEOPTION_SOUND_ONOFF_BattleSoundType_0"
  },
  [1] = {
    _string = "PANEL_NEWGAMEOPTION_SOUND_ONOFF_BattleSoundType_1"
  },
  ["_count"] = 2
}
AudioResourceType._title = "PANEL_NEWGAMEOPTION_AudioResourceType"
AudioResourceType._desc = nil
AudioResourceType._radioButtonMapping = {
  [0] = {
    _gameString = "LUA_GAMEOPTION_KOREAN"
  },
  [1] = {
    _gameString = "LUA_GAMEOPTION_ENGLISH"
  },
  [2] = {
    _gameString = "LUA_GAMEOPTION_JAPANESE"
  },
  [3] = {
    _gameString = "LUA_GAMEOPTION_TAIWAN"
  },
  ["_count"] = 4
}
VolumeMaster._title = "PANEL_NEWGAMEOPTION_VolumeMaster"
VolumeMaster._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeMaster_DESC"
EnableMusic._title = "PANEL_NEWGAMEOPTION_VolumeMusic"
EnableMusic._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeMusic_DESC"
VolumeMusic._title = nil
VolumeMusic._desc = nil
VolumeMusic._clickSound = {
  [0] = 0,
  [1] = 33
}
EnableSound._title = "PANEL_NEWGAMEOPTION_VolumeFx"
EnableSound._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeFx_DESC"
VolumeFx._title = nil
VolumeFx._desc = nil
VolumeFx._clickSound = {
  [0] = 0,
  [1] = 30
}
VolumeHitFxVolume._title = "PANEL_NEWGAMEOPTION_VolumeHitFxVolume"
VolumeHitFxVolume._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeHitFxVolume_DESC"
VolumeHitFxVolume._clickSound = {
  [0] = 0,
  [1] = 34
}
VolumeHitFxWeight._title = "PANEL_NEWGAMEOPTION_VolumeHitFxWeight"
VolumeHitFxWeight._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeHitFxWeight_DESC"
VolumeOtherPlayer._title = "PANEL_NEWGAMEOPTION_VolumeOtherPlayer"
VolumeOtherPlayer._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeOtherPlayer_DESC"
VolumeOtherPlayer._clickSound = {
  [0] = 0,
  [1] = 35
}
VolumeMusicPlay._title = "PANEL_NEWGAMEOPTION_VolumeMusicPlay"
VolumeMusicPlay._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeMusicPlay_DESC"
VolumeMusicPlay._clickSound = {
  [0] = 0,
  [1] = 37
}
EnableEnv._title = "PANEL_NEWGAMEOPTION_VolumeEnv"
EnableEnv._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeEnv_DESC"
VolumeEnv._title = nil
VolumeEnv._desc = nil
VolumeEnv._clickSound = {
  [0] = 0,
  [1] = 32
}
VolumeDlg._title = "PANEL_NEWGAMEOPTION_VolumeDlg"
VolumeDlg._desc = "PANEL_NEWGAMEOPTION_SOUND_VOLUME_VolumeDlg_DESC"
VolumeDlg._clickSound = {
  [0] = 0,
  [1] = 31
}
PaGlobal_GameoptionTutorial_All = {
  _ui = {
    _soundDesc = nil,
    _frame = nil,
    _frameContent = nil,
    _frameScroll = nil,
    _grapgicDesc = nil,
    _graphicPage = nil,
    _rbn_remaster = nil,
    _rbn_normal = nil,
    _btn_next = nil
  },
  _frames = {
    {_element = BattleSoundType},
    {_element = AudioResourceType},
    {_element = VolumeMaster},
    {_element = EnableMusic},
    {_element = VolumeMusic},
    {_element = EnableSound},
    {_element = VolumeFx},
    {_element = VolumeHitFxVolume},
    {_element = VolumeHitFxWeight},
    {_element = VolumeOtherPlayer},
    {_element = VolumeMusicPlay, _contentsOption = _ContentsGroup_InstrumentPerformance},
    {_element = EnableEnv},
    {_element = VolumeEnv},
    {_element = VolumeDlg}
  },
  _controls = {},
  _remasterMode = true,
  _currentPage = 1,
  _lastPage = 2,
  _characterIndex = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/c_Option/Panel_Window_Gameoption_Tutorial_All_1.lua")
runLua("UI_Data/Script/Window/c_Option/Panel_Window_Gameoption_Tutorial_All_2.lua")
