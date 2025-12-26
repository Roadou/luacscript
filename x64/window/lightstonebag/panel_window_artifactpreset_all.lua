PaGlobal_ArtifactPreset_All = {
  _ui = {
    _btn_editPreset = nil,
    _txt_editPreset = nil,
    _txt_presetCount = nil,
    _btn_presetBuy = nil,
    _list2_artifactPreset = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuide_LTA = nil,
    _stc_keyGuide_RTX = nil,
    _stc_keyGuide_Y = nil,
    _stc_keyGuide_A = nil,
    _stc_keyGuide_B = nil,
    _stc_keyGuide_X = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _subSlotConfig = {createIcon = true},
  _currentMouseOnArtifactPresetInfo = {presetNo = nil, isLeft = nil},
  _currentSelectedPresetIndex_s64 = nil,
  _beforePadSnapState = nil,
  _currentPadSnapState = nil,
  _closeType = {_closePanel = 0, _changeTab = 1},
  _currentCloseType = nil,
  _isEditMode = false,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_ArtifactPreset_All_1.lua")
runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_ArtifactPreset_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ArtifactPreset_Initialize")
function FromClient_ArtifactPreset_Initialize()
  PaGlobal_ArtifactPreset_All:initialize()
end
