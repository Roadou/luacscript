LightStoneBagTabIndex = {
  Default = 0,
  TabCount = 2,
  Artifact = 0,
  LightStone = 1
}
LightStoneBagConsoleSnapState = {
  SnapOnBag = 0,
  SnapOnPreset = 1,
  SnapOnEditMode = 2
}
PaGlobal_LightStoneBag = {
  _ui = {
    _btn_tab_artifact = nil,
    _stc_selectedLine_artifact = nil,
    _btn_tab_lightStone = nil,
    _stc_selectedLine_lightStone = nil,
    _stc_keyGuide_LB = nil,
    _stc_keyGuide_RB = nil,
    _stc_artifactBagArea = nil,
    _artifactBagList = nil,
    _artifactPresetList = nil,
    _txt_slotCount = nil,
    _stc_lightStoneBagArea = nil,
    _stc_lightStoneSubTabGroup = nil,
    _lightStoneTypeCheckButtonList = nil,
    _lightStoneBagList = nil,
    _stc_bottomButtonArea = nil,
    _btn_showEquipLightStoneUI = nil,
    _btn_getAllItemFromInventory = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuide_LTA = nil,
    _stc_keyGuide_RTY = nil,
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
  _lightStoneTypeFilter = {},
  _artifactInventorySlotCountMax = 0,
  _artifactInventoryPresetCountMax = 0,
  _currentMouseOnArtifactBagIndex = nil,
  _beforePadSnapState = nil,
  _currentPadSnapState = nil,
  _currentTabIndex = LightStoneBagTabIndex.Default,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_LightStoneBag_1.lua")
runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_LightStoneBag_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitLightStoneBag")
function FromClient_InitLightStoneBag()
  PaGlobal_LightStoneBag:initialize()
end
