PaGlobal_WorldMap_FamilyCharacterList = {
  _ui = {
    _stc_titleBg = nil,
    _txt_title = nil,
    _prg_alpha = nil,
    _sld_alpha = nil,
    _stc_decalBg = nil,
    _stc_selectPlaceBg = nil,
    _txt_selectPlace = nil,
    _btn_selectClear = nil,
    _stc_listBg = nil,
    _lst_characterList = nil,
    _stc_keyGuideListConsole = nil,
    _stc_keyGuideWorldMapConsole = nil,
    _stc_keyGuideMouseL = nil,
    _stc_keyGuideMouseR = nil,
    _stc_subMenuBg = nil,
    _btn_subMenuBtnTemplate = nil,
    _subMenuButtonList = nil,
    _stc_blockBg = nil,
    _characterContentsList = {}
  },
  _subMenuEventType = {
    CHANGE = 0,
    MOVE = 1,
    INVENTORY = 2,
    ADDMEMO = 3,
    CLEARMEMO = 4,
    COUNT = 5
  },
  _beamIndexList = nil,
  _isSelected = false,
  _isGroupByRegion = false,
  _selectedRegionKeyRaw = 0,
  _selectedCharacterIndex = nil,
  _isNonNavigable = false,
  _characterDataContainer = nil,
  _constOffsetIndex = 99999,
  _isConsole = false,
  _initialize = false,
  _servantTypeMax = 1,
  _minAlpha = 0.5,
  _territoryKeyCountMax = 20,
  _currentIsGroupByRegion = false,
  _decoGap = 10,
  _decoOriginalSizeX = 0,
  _keyGuideList = {},
  _keyGuideConfig = {
    _yGap = 40,
    _B = 0,
    _X_Hold = 1,
    _X = 2,
    _LTPlusX = 3,
    _LTPlusStick = 4,
    _RS = 5,
    _LS = 6,
    _LS_Hold = 7,
    _LSC = 8,
    _RSC = 9,
    _DpadDown = 10,
    _DpadUp = 11,
    _DpadLeft = 12,
    _DpadRight = 13,
    _keyGuideCount = 14
  }
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyCharacterList_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyCharacterList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_FamilyCharacterList_Init")
function FromClient_WorldMap_FamilyCharacterList_Init()
  PaGlobal_WorldMap_FamilyCharacterList:initialize()
end
