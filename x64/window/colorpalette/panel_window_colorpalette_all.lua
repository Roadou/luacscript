PaGlobal_ColorPalette_All = {
  _ui = {
    btn_close = nil,
    stc_title = nil,
    stc_paletteBG = nil,
    stc_brightBG = nil,
    stc_paletteAllBG = nil,
    stc_palette = nil,
    stc_bright = nil,
    stc_paletteCursor = nil,
    stc_brightSlider = nil,
    txt_textInfoR = nil,
    txt_textInfoG = nil,
    txt_textInfoB = nil,
    edit_numberR = nil,
    edit_numberG = nil,
    edit_numberB = nil,
    stc_weaponColorChoice = nil,
    btn_color_select = nil,
    lightnessLevel = {},
    txt_keyguide = nil,
    txt_keyguideY = nil,
    txt_keyguideX = nil,
    txt_keyguideLB = nil,
    txt_keyguideRB = nil,
    txt_textTitleR = nil,
    txt_textTitleG = nil,
    txt_textTitleB = nil,
    stc_saveColorBG = nil,
    btn_savePresetColor = nil,
    radiobtn_colorPresetList = {},
    stc_selectedBorderUIList = {}
  },
  _colorValue = {
    hue = nil,
    saturation = nil,
    lightness = nil,
    red = nil,
    green = nil,
    blue = nil,
    lastAppliedHue = nil,
    lastAppliedSaturation = nil,
    lastAppliedLightness = nil,
    paletteType = 1
  },
  _callerInfo = {
    classType = nil,
    paramType = nil,
    paramIndex = nil
  },
  _config = {
    lightnessLevelCount = 20,
    notUsedYet = -1,
    paletteTypeCount = 8,
    pressUpdateFrequency = 2,
    updateFrequency = 0.02,
    limitAccelSpeed = 0.3,
    rStickSesitivityLimit = 0.3,
    accelStartTime = 1
  },
  _rgbType = {
    red = 0,
    green = 1,
    blue = 2
  },
  _hslType = {
    hue = 0,
    saturation = 1,
    lightness = 2
  },
  _palettePanelType = {
    hueSaturation = 0,
    lightness = 1,
    lightnessSlider = 2
  },
  _pressedPanelType = nil,
  _openType = nil,
  _lastAppliedColorPerPartList = {},
  _isColorChanged = false,
  _isSlotChanged = false,
  _isTypeChanged = false,
  _isPanelPressed = false,
  _isPanelPressedInConsole = false,
  _pressCount = 0,
  _initialize = false,
  _updateTime = 0,
  _rStickPressTime = 0,
  _accelSpeed = 0,
  _focusedEditControlIdx = 2,
  _targetPresetSlot = 1
}
runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All_1.lua")
runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ColorPalette_All_Init")
function FromClient_ColorPalette_All_Init()
  PaGlobal_ColorPalette_All:initialize()
end
