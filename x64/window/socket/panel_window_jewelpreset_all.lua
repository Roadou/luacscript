PaGlobal_JewelPreset = {
  _ui = {
    stc_TitleBarArea = nil,
    btn_Question = nil,
    btn_Close = nil,
    stc_RadioButtonArea = nil,
    btn_Console_LB = nil,
    btn_Console_RB = nil,
    stc_PresetArea = nil,
    btn_Edit = nil,
    stc_Console_PresetGuide = nil,
    txt_PresetName = nil,
    txt_AdjustName = nil,
    edit_PresetName = nil,
    txt_LClick = nil,
    txt_RClick = nil,
    stc_SlotArea = nil,
    btn_ShowTooltip = nil,
    btn_Adjust = nil,
    btn_AdjustCancel = nil,
    btn_Save = nil,
    btn_SaveAdjust = nil,
    btn_Inven = nil,
    stc_Console_Buttons = nil,
    btn_Console_UnEquip = nil,
    btn_Console_Select = nil,
    btn_Console_Close = nil,
    btn_Console_Detail = nil,
    btn_Console_Scroll = nil,
    list_preset = nil,
    Frame_Tooltip = nil,
    Frame_Tooltip_Content = nil,
    Frame_Tooltip_VerticalScroll = nil,
    txt_Tooltip_Title = nil,
    txt_Tooltip_NoCrystal = nil,
    txt_Tooltip_LeftButtonDesc = nil,
    stc_Tooltip_CrystalGroupName = nil,
    stc_Tooltip_CrystalBg = nil,
    txt_Tooltip_CrystalDesc = nil,
    txt_Tooltip_CrystalName = nil,
    stc_Tooltip_CrystalIcon = nil,
    stc_Tooltip_DetailBG = nil,
    stc_Tooltip_SubTitle = nil,
    txt_Tooltip_Desc = nil,
    stc_blockBg = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _lockSlotTooltip = {
    [__eJewelSpecialSlotAwakenWeapon1] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME_13")
    },
    [__eJewelSpecialSlotAwakenWeapon2] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME_14")
    },
    [__eJewelSpecialSlotPearlAvatarChest] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME_15"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_DESC_15")
    },
    [__eJewelSpecialSlot1MorningLand] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_DESC_16")
    },
    [__eJewelSpecialSlot2MorningLand] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_DESC_17")
    },
    [__eJewelSpecialSlotNecklace] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_1")
    },
    [__eJewelSpecialSlotRing1] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_2")
    },
    [__eJewelSpecialSlotRing2] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_2")
    },
    [__eJewelSpecialSlotEaring1] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_4")
    },
    [__eJewelSpecialSlotEaring2] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_4")
    },
    [__eJewelSpecialSlotBelt] = {
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_SLOT_TOOLTIP_DISUSABLE_NAME"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_ACCESSORY_TOOLTIP_3")
    }
  },
  _jewelSlotList = {},
  _jewelSlot = {},
  _jewelPresetRadioControlList = {},
  _jewelPresetRadioControlLockList = {},
  _selectedJewelSlot = -1,
  _selectedJewelSlotForPadControl = -1,
  _selectJewelPresetNo = 0,
  _applyJewelPresetNo = __eJewelNotActivatingPresetNo,
  _applyProgressJewelPresetNo = __eJewelNotActivatingPresetNo,
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false,
  _totalDesc = {},
  _exeptionLanguage = false,
  _buffCount = 0,
  _separationCharater = "&",
  _startIndex = 2,
  _isDetail = true,
  _listCrystalSize = 0,
  _listCrystal = {},
  _usingCrystalUICount = 0,
  _listCrystalGroupNameSize = 0,
  _listCrystalGroupName = {},
  _usingCrystalGroupNumberUICount = 0,
  _lastJewelGroupNumber = -1,
  _posY = 0,
  _beforeCount = -1,
  _effectDesc = {},
  _languageTypeString = "",
  _updateJewel = false,
  _applyPreset = false,
  _closeByJewelInven = false,
  _progressBarActive = false,
  _conetneSizeY = 0,
  _originDetailBgSizeY = 0,
  _tooltipOrderTable = {
    __eJewelSpecialSlotNecklace,
    __eJewelSpecialSlotRing1,
    __eJewelSpecialSlotRing2,
    __eJewelSpecialSlotEaring1,
    __eJewelSpecialSlotEaring2,
    __eJewelSpecialSlotBelt,
    __eJewelSpecialSlot1MorningLand,
    __eJewelSpecialSlot2MorningLand,
    __eJewelSpecialSlotAwakenWeapon1,
    __eEquipSlotNoRightHand,
    __eJewelSpecialSlotAwakenWeapon2,
    __eEquipSlotNoLeftHand,
    __eEquipSlotNoSubTool,
    __eEquipSlotNoChest,
    __eEquipSlotNoGlove,
    __eEquipSlotNoBoots,
    __eEquipSlotNoAvatarChest,
    __eEquipSlotNoHelm,
    __eEquipSlotNoNecklace,
    __eEquipSlotNoRing1,
    __eEquipSlotNoRing2,
    __eEquipSlotNoEaring1,
    __eEquipSlotNoEaring2
  },
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelPreset_All_1.lua")
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelPreset_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_JewelPresetInit")
function FromClient_JewelPresetInit()
  PaGlobal_JewelPreset:initialize()
end
