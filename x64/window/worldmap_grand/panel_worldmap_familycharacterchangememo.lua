PaGlobal_WorldMap_FamilyCharacterChangeMemo = {
  _ui = {
    stc_blockBg = nil,
    stc_titleBg = nil,
    btn_close = nil,
    stc_subFrame = nil,
    edit_memo = nil,
    btn_apply = nil,
    btn_reset = nil,
    txt_desc = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideY = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideX = nil
  },
  _isConsole = false,
  _initialize = false,
  _maxInput = 14,
  _currentCharacterIndex = nil
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyCharacterChangeMemo_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyCharacterChangeMemo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_FamilyCharacterChangeMemo_Init")
function FromClient_WorldMap_FamilyCharacterChangeMemo_Init()
  PaGlobal_WorldMap_FamilyCharacterChangeMemo:initialize()
end
