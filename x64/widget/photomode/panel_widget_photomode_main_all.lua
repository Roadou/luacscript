_photoModeOption = {
  help = 1,
  screenShot = 2,
  slowMode = 3,
  cameraMove = 4,
  screenLook = 5,
  noiseVignetting = 6,
  blurForce = 7,
  blurPosition = 8,
  gammaControl = 9,
  contrastControl = 10,
  zoomInzoomOut = 11,
  angleControl = 12,
  socialAction = 13,
  socialActionStart = 14,
  weather = 15,
  timeWeather = 16,
  filterChange = 17,
  optionPreset = 18
}
_sliderState = {
  eCenterTitle = 1,
  eArea = 2,
  eDesc = 3,
  eBG = 4,
  eProgress = 5,
  eSlider = 6,
  eSldier_btn = 7,
  eMin = 8,
  eCurrent = 9,
  eMax = 10
}
PaGlobal_PhotoMode = {
  _ui = {
    keyGuideArea = nil,
    txt_keyGuide = nil,
    horizon = nil,
    activateKeyOption = nil,
    bottomSetting = nil,
    btn_reset = nil,
    btn_save = nil,
    txt_socialCenterTitle = nil,
    txt_socialSubTitle = nil,
    txt_actionArea = nil,
    socialIconSelect = nil,
    btn_leftArrow = nil,
    btn_rightArrow = nil,
    txt_weatherCenterTitle = nil,
    txt_weatherArea = nil,
    txt_weatherDesc = nil,
    btn_weatherLeft = nil,
    btn_weatherRight = nil,
    weatherSelect = nil,
    txt_weatherName = nil,
    txt_timeWeatherCenterTitle = nil,
    txt_timeWeatherArea = nil,
    txt_timeWeatherDesc = nil,
    slider_timeWeatherBG = nil,
    slider_timeWeatherProgress = nil,
    slider_timeWeather = nil,
    btn_timeWeatherSlider = nil,
    txt_timeWeatherMin = nil,
    txt_timeWeatherCurrent = nil,
    txt_timeWeatherMax = nil,
    slider_timeWeatherMoon1 = nil,
    slider_timeWeatherMoon2 = nil,
    slider_timeWeatherSun = nil,
    txt_filterCenterTitle = nil,
    filterArea = nil,
    txt_filterDesc = nil,
    btn_leftFilterArrow = nil,
    btn_rightFilterArrow = nil,
    txt_filterName = nil,
    txt_vignettingCenterTitle = nil,
    vignettingArea = nil,
    txt_vignetingDesc = nil,
    btn_winClose = nil,
    btn_save = nil,
    btn_close = nil
  },
  _sliderList = {},
  _keyGuideList = {
    [_photoModeOption.help] = {
      _keyCombination = {"F1"},
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_HELP",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.screenShot] = {
      _keyCombination = {
        "Enter",
        "or",
        "PrintScreen"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_SCREENSHOT",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.slowMode] = {
      _keyCombination = {"U"},
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_SLOWMODE",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.cameraMove] = {
      _keyCombination = {
        "LeftArrow",
        "UpArrow",
        "RightArrow",
        "DownArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_MOVECAMERA",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.screenLook] = {
      _keyCombination = {"Home"},
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_LOOKATTHESCREEN",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.noiseVignetting] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "Shift",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_NOISE",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.blurForce] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_BLUR_FORCE",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.blurPosition] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "UpArrow",
        "DownArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_BLUR_POSITION",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.gammaControl] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "Alt",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_GAMMA",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.contrastControl] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "Alt",
        "+",
        "UpArrow",
        "DownArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_CONTRAST",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.zoomInzoomOut] = {
      _keyCombination = {
        "Shift",
        "+",
        "UpArrow",
        "DownArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_ZOOM",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.angleControl] = {
      _keyCombination = {
        "Shift",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_ROTATE",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.socialAction] = {
      _keyCombination = {
        "Ctrl",
        "+",
        "PageUp",
        "PageDown"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_SOCIALACTION",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.socialActionStart] = {
      _keyCombination = {"Insert"},
      _keyOptionName = "PANEL_PHOTOMODE_SOCIALACTION_DOIT",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.weather] = {
      _keyCombination = {
        "Alt",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_WEATHER",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.timeWeather] = {
      _keyCombination = {
        "Alt",
        "+",
        "UpArrow",
        "DownArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_TIME_WEATHER",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.filterChange] = {
      _keyCombination = {
        "Alt",
        "+",
        "Shift",
        "+",
        "LeftArrow",
        "RightArrow"
      },
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_FILTERCHANGE",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    },
    [_photoModeOption.optionPreset] = {
      _keyCombination = {},
      _keyOptionName = "PANEL_PHOTOMODE_KEYGUIDE_PRESET",
      _keyList = {},
      _keyGuideName = nil,
      _modeList = {}
    }
  },
  _horizonIndex = {
    _photoModeOption.noiseVignetting,
    _photoModeOption.socialAction,
    _photoModeOption.optionPreset
  },
  _initialize = false,
  _keyIndex = 0,
  _keyGuideCount = _photoModeOption.optionPreset,
  _socialIconSlot = {},
  _currentSocialActionWindowIndex = 0,
  _currentSelectedIconIndex = 0,
  _weatherRecommend = {},
  _vignettingButton = {},
  _optionPresetButton = {},
  _saveButton = {},
  _currentSelectedOptionIndex = 0,
  _blurMessageBox = false,
  _contrastMessageBox = false,
  _currentSelectedKeyGuide = 0,
  _messageBoxOpen = false,
  _isFirstOpen = false,
  _isPhotoModeFromObservation = false
}
runLua("UI_Data/Script/Widget/PhotoMode/Panel_Widget_PhotoMode_Main_All_1.lua")
runLua("UI_Data/Script/Widget/PhotoMode/Panel_Widget_PhotoMode_Main_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PhotoModeInit")
function FromClient_PhotoModeInit()
  PaGlobal_PhotoMode:initialize()
end
