PaGlobal_ReforgeStonePreset = {
  _ui = {
    btn_Close = nil,
    list_ReforgeStone = nil,
    reforgeSlotList = {},
    presetButtonList = {},
    btn_Total = nil,
    btn_Possessed = nil,
    btn_Activated = nil,
    currentActivatedList = {},
    currentActiveSkillList = {},
    btn_Apply = nil,
    btn_Save = nil,
    btn_Clear = nil,
    btn_EditName = nil,
    stc_ActivatedPreset = nil,
    stc_LeftEffectArea = nil,
    btn_TotalEffect = nil,
    stc_TotalEffectList = nil,
    stc_LineDeco = nil,
    effectDescList = {},
    stc_WeaponTooltip = nil,
    stc_ActivateEffect = nil,
    stc_ActivatedSlotBg = nil,
    stc_NoActivateText = nil,
    stc_ConsoleKey_A = nil,
    stc_ConsoleKey_B = nil,
    stc_ConsoleKey_X = nil
  },
  _isConsole,
  _reforgeStoneList = {},
  _currentSlotType = 0,
  _currentPresetNo = 0,
  _needSave = false,
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = false,
    createOriginalForDuel = true
  },
  _reforgeStoneListType = {
    total = 0,
    possessed = 1,
    activated = 2
  },
  _currentReforgeStoneListType = 0,
  _reforgeSlotTypeToEquipSlotNo = {
    [__eReforgeStoneSlotType_MainWeapon] = __eEquipSlotNoRightHand,
    [__eReforgeStoneSlotType_AwakenWeapon] = __eEquipSlotNoAwakenWeapon,
    [__eReforgeStoneSlotType_SubWeapon] = __eEquipSlotNoLeftHand
  },
  _maxActableStoneCount = 0,
  _maxBagSize = 0,
  _effectDescGapY = 5,
  _consoleTooltip = false,
  _currentSnapItemKey = nil,
  _currentSnapSlotIndex = nil,
  _totalEffectOriginSizeX = 0,
  _exeptionLanguage = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgeStonePreset_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgeStonePreset_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "Panel_Window_ReforgeStonePreset_Init")
function Panel_Window_ReforgeStonePreset_Init()
  PaGlobal_ReforgeStonePreset:initialize()
end
