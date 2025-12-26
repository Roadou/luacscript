local _panel = Panel_Window_Inventory
local _isInitialized = false
local UPPER_TAB_TYPE = {
  UNDEFINED = 0,
  EQUIPMENT_TAB = 1,
  COSTUME_TAB = 2,
  SERVANT_TAB = 3,
  LIFEEEQUIP_TAB = 4
}
local LOWER_TAB_TYPE = {
  UNDEFINED = 0,
  INVENTORY_TAB = 1,
  CASH_INVEN_TAB = 2
}
local WHERE_TYPE = {
  INVENTORY = CppEnums.ItemWhereType.eInventory,
  EQUIPMENT = CppEnums.ItemWhereType.eEquip,
  WAREHOUSE = CppEnums.ItemWhereType.eWarehouse,
  SERVANT_INVEN = CppEnums.ItemWhereType.eServantInventory,
  SERVANT_EQUIP = CppEnums.ItemWhereType.eServantEquip,
  GUILD_WAREHOUSE = CppEnums.ItemWhereType.eGuildWarehouse,
  CASH_INVEN = CppEnums.ItemWhereType.eCashInventory,
  INVEN_BAG = CppEnums.ItemWhereType.eInventoryBag,
  CASH_INVEN_BAG = CppEnums.ItemWhereType.eCashInventoryBag,
  FAMILY_INVENTORY = CppEnums.ItemWhereType.eFamilyInventory,
  FAMILY_EQUIP = __eItemWhereTypeFamilyEquip,
  ENCHANT_INVENTORY = CppEnums.ItemWhereType.eEnchantInventory
}
local UI_color = Defines.Color
local _isItemLock = ToClient_IsContentsGroupOpen("219")
PaGlobal_Inventory_All_ForConsole = {
  _ui = {
    stc_bg = nil,
    stc_title = nil,
    stc_tabGroup = nil,
    stc_equipGroup = nil,
    stc_servantGroup = nil,
    stc_invenGroup = nil,
    stc_bottomBG = nil,
    stc_bottomBG_setFunctor = nil,
    stc_invenSortArea = nil,
    txt_slotCount = nil,
    txt_keyGuideSort = nil,
    btn_sortOption = nil,
    chk_sort = nil,
    stc_familyInvenGroup = nil,
    stc_familyInvenSortArea = nil,
    txt_keyGuideFamilyInvenSort = nil,
    btn_familySortOption = nil,
    chk_familySort = nil,
    stc_enchantInvenGroup = nil,
    stc_enchantInvenSortArea = nil,
    txt_keyGuideEnchantInvenSort = nil,
    btn_enchantSortOption = nil,
    chk_enchantSort = nil,
    btn_valksView = nil,
    stc_invenBottomArea = nil,
    txt_Silver = nil,
    txt_Pearl = nil,
    txt_Mileage = nil,
    txt_weight = nil,
    progress2_Weight = nil,
    rdo_tabButtons = nil,
    stc_selectedLine = nil,
    stc_important = nil,
    stc_xBoxKey_LB = nil,
    stc_xBoxKey_RB = nil,
    stc_upperGroups = nil,
    stc_equipBG = nil,
    stc_equipSlotBG = {},
    slot_equips = {},
    chk_detailInfo = nil,
    btn_notationSetting = nil,
    txt_attackValue = nil,
    txt_awakenAttackValue = nil,
    txt_defenceValue = nil,
    chk_autoActive = nil,
    stc_FamilyinvenSlotArea = nil,
    stc_familyInvenSlotBG = {},
    slot_familyInven = {},
    stc_lockedFamilyInvenSlots = {},
    progress2_familyInvenWeight = nil,
    txt_familyInvenWeight = nil,
    stc_familyInvenWeightIcon = nil,
    txt_familyInvenCapacity = nil,
    scroll_familyInven = nil,
    stc_enchantInvenSlotArea = nil,
    stc_enchantInvenSlotBG = {},
    slot_enchantInven = {},
    txt_enchantInvenCapacity = nil,
    scroll_enchantInven = nil,
    stc_costumeBG = nil,
    stc_costumeSlotBG = {},
    slot_costumes = {},
    stc_lifeEquipBG = nil,
    stc_lifeEquipSlotBG = {},
    slot_lifeEquips = {},
    equipSlotTemplate = nil,
    costumeSlotTemplate = nil,
    invenSlotTemplate = nil,
    servantEquipSlotTemplate = nil,
    servantCostumeSlotTemplate = nil,
    chk_hideHelmet = nil,
    chk_openHelmet = nil,
    chk_openHelmetIcon = nil,
    chk_showUnderwear = nil,
    chk_toggleCloak = nil,
    chk_toggleNameWhenCamo = nil,
    chk_subWeapon = nil,
    frame_characterInfo = nil,
    stc_characterInfoBG = nil,
    txt_resistValues = nil,
    txt_fitnessSubtitles = nil,
    txt_fitnessValues = nil,
    setItemEffectTitleList = nil,
    setItemEffectValueList = nil,
    frame_setEffect = nil,
    stc_setEffectBG = nil,
    stc_noSetEffect = nil,
    potencialBars = {},
    scroll_servantInven = nil,
    stc_servantInfoBG = nil,
    txt_servantName = nil,
    progress2_servantWeight = nil,
    txt_servantInvenCountDisplay = nil,
    txt_servantWeightValue = nil,
    stc_horseWeight = nil,
    txt_servantEquipInfo = nil,
    txt_servantCostumeInfo = nil,
    txt_noServant = nil,
    stc_servantInvenSlotBG = {},
    slot_servantInven = {},
    stc_servantEquipSlotBG = {},
    slot_servantEquip = {},
    stc_servantCostumeSlotBG = {},
    slot_servantCostume = {},
    slot_extendedSlotInfoArray = {},
    stc_itemSlotTemplate = nil,
    stc_highlight = nil,
    txt_invenName = nil,
    scroll_inven = nil,
    stc_invenBG = nil,
    stc_plusSlot = nil,
    stc_lockedSlots = {},
    slot_inven = {},
    stc_invenSlotBG = {},
    txt_keyGuideA = nil,
    txt_keyGuideA2 = nil,
    txt_keyGuideB = nil,
    txt_keyGuideY = nil,
    txt_keyGuideSort = nil,
    txt_keyGuideRT = nil,
    txt_keyGuideLT = nil,
    txt_keyGuideRTA = nil,
    txt_keyGuideSetFunctorA = nil,
    txt_keyGuideSetFunctorY = nil,
    txt_keyGuideSetFunctorB = nil,
    txt_keyGuideSetFunctorRT = nil,
    stc_season_UpgradeBg = nil,
    stc_season_Upgrade = nil,
    stc_season_UpgradeEffect = nil,
    btn_myStat = nil,
    btn_lightStoneBag = nil,
    stc_slotBorder = UI.getChildControl(_panel, "Static_SlotBorder"),
    stc_snapEffect = UI.getChildControl(_panel, "Static_SnapHighlight"),
    ref_snapTarget = nil,
    stc_cashProductBg,
    btn_restoreProduct
  },
  _isAutoSort = false,
  _rotateVal1 = 45,
  _rotateVal2 = 0,
  _tabXGab = 80,
  _originPanelSizeY = 1080,
  _originBgSizeY = 945,
  _resistCount = 4,
  _fitnessCount = 3,
  _setItemEffectTitleCount = nil,
  _setItemEffectValueCount = nil,
  _setItemEffectData = nil,
  _invenSlotColumnMax = 9,
  _invenSlotRowMax = 8,
  _invenSlotCount = 72,
  _invenCapacity = nil,
  _invenStartSlotIndex = 0,
  _newItemAtSlot = {},
  _servantInvenStartSlot = 0,
  _servantInvenRowMax = 3,
  _servantEquipSlotMax = 6,
  _defaultXGap = 54,
  _defaultYGap = 54,
  _weightDesignatorTarget = nil,
  _weightDesignatorIsAnimating = false,
  _servantActorKeyRaw = {},
  _tooltipWhereType = nil,
  _tooltipSlotNo = nil,
  _rClickFunc = nil,
  _filterFunc = nil,
  _optionalPadEventFunc = nil,
  _optionalPadEventButton = nil,
  _otherWindowOpenFunc = nil,
  _effect = nil,
  _currentUpperTab = 0,
  _currentLowerTab = 0,
  _slotRingIndex = 0,
  _slotEarringIndex = 0,
  _showAniIsPlaying = false,
  _showAniElapsed = 0,
  _showAniDuration = 0.3,
  _monitorItemCooltime = false,
  _extendedSlotArray = {},
  _multipleSelect = {
    [CppEnums.ItemWhereType.eInventory] = {},
    [CppEnums.ItemWhereType.eCashInventory] = {}
  },
  _puzzleCompleteSlot = nil,
  _snapEffectAniFlag = false,
  _sinCurveTheta = 0,
  _deleteWhereType = nil,
  _deleteSlotNo = nil,
  _deleteCount = nil,
  _currentInvenSlotIndex = 0,
  _reuseAlchemyStoneCheckTime = 0,
  _screenGapSizeX = 0,
  _isSlotEmpty = false,
  _campActorProxy = nil,
  _isShowFamilyInven = false,
  _familyinvenShowSlotCount = 0,
  _familyInventoryIgnoreCount = 0,
  _familyInventoryTooltipSlotNo = 0,
  _familyInvenStartSlotIndex = 0,
  _isShowCoolTimeEffect = true,
  _famliyInvenMaxCapacity = 0,
  _isShowEnchantInven = false,
  _enchantInvenShowSlotCount = 0,
  _enchantInventoryIgnoreCount = 0,
  _enchantInventoryTooltipSlotNo = 0,
  _enchantInvenStartSlotIndex = 0,
  _isShowEnchantCoolTimeEffect = true,
  _enchantInvenMaxCapacity = 0,
  _multiUseCount_s64 = toInt64(0, 1),
  _multiUseInventoryType = nil,
  _multiUseSlotNo = nil
}
local _snappedOnThisPanel = false
local _avatarCheckFlag = {
  [14] = 1,
  [15] = 2,
  [16] = 4,
  [17] = 8,
  [18] = 32,
  [19] = 64,
  [20] = 16,
  [22] = 256,
  [23] = 512,
  [21] = 128,
  [3] = 65536,
  [4] = 131072,
  [5] = 262144,
  [6] = 524288,
  [0] = 2097152,
  [1] = 4194304,
  [30] = 1024
}
local _equipSlotNoIdToString = {
  [__eEquipSlotNoRightHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
  [__eEquipSlotNoLeftHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
  [__eEquipSlotNoSubTool] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
  [__eEquipSlotNoChest] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
  [__eEquipSlotNoGlove] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
  [__eEquipSlotNoBoots] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
  [__eEquipSlotNoHelm] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
  [__eEquipSlotNoNecklace] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
  [__eEquipSlotNoRing1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
  [__eEquipSlotNoRing2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
  [__eEquipSlotNoEaring1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
  [__eEquipSlotNoEaring2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
  [__eEquipSlotNoBelt] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
  [__eEquipSlotNoLantern] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
  [__eEquipSlotNoAvatarChest] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
  [__eEquipSlotNoAvatarGlove] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
  [__eEquipSlotNoAvatarBoots] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
  [__eEquipSlotNoAvatarHelm] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
  [__eEquipSlotNoAvatarWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
  [__eEquipSlotNoAvatarSubWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
  [__eEquipSlotNoAvatarUnderwear] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
  [__eEquipSlotNoFaceDecoration1] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HEAD"),
  [__eEquipSlotNoFaceDecoration2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_EYES"),
  [__eEquipSlotNoFaceDecoration3] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MOUSE"),
  [__eEquipSlotNoAlchemyStone] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
  [__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
  [__eEquipSlotNoAvatarAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon"),
  [__eEquipSlotNoQuestBook] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_QUESTBOOK"),
  [__eEquipSlotNoAxe] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_01"),
  [__eEquipSlotNoSyringe] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_02"),
  [__eEquipSlotNoHoe] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_03"),
  [__eEquipSlotNoButcheryKnife] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_04"),
  [__eEquipSlotNoSkinKnife] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_05"),
  [__eEquipSlotNoPickAx] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_06"),
  [__eEquipSlotNoFishingRod] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_07"),
  [__eEquipSlotNoBobber] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_08"),
  [__eEquipSlotNoFishingHarpoon] = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_09"),
  [__eEquipSlotNoTemp] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BACK")
}
local SERVANT_TYPE = {
  HORSE_AND_ETC = 1,
  CARRIAGE = 2,
  SMALL_SHIP = 3,
  BIG_SHIP = 4
}
local _vehicleTypeToSERVANT_TYPE = {
  [CppEnums.VehicleType.Type_Horse] = SERVANT_TYPE.HORSE_AND_ETC,
  [CppEnums.VehicleType.Type_Camel] = SERVANT_TYPE.HORSE_AND_ETC,
  [CppEnums.VehicleType.Type_Donkey] = SERVANT_TYPE.HORSE_AND_ETC,
  [CppEnums.VehicleType.Type_Elephant] = SERVANT_TYPE.HORSE_AND_ETC,
  [CppEnums.VehicleType.Type_RidableBabyElephant] = SERVANT_TYPE.HORSE_AND_ETC,
  [CppEnums.VehicleType.Type_Carriage] = SERVANT_TYPE.CARRIAGE,
  [CppEnums.VehicleType.Type_CowCarriage] = SERVANT_TYPE.CARRIAGE,
  [CppEnums.VehicleType.Type_Train] = SERVANT_TYPE.CARRIAGE,
  [CppEnums.VehicleType.Type_RepairableCarriage] = SERVANT_TYPE.CARRIAGE,
  [CppEnums.VehicleType.Type_SailingBoat] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_PersonalBattleShip] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_PersonTradeShip] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_PersonalBoat] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_CashPersonalTradeShip] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_CashPersonalBattleShip] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_Carrack] = SERVANT_TYPE.BIG_SHIP,
  [CppEnums.VehicleType.Type_Boat] = SERVANT_TYPE.SMALL_SHIP,
  [CppEnums.VehicleType.Type_Raft] = SERVANT_TYPE.SMALL_SHIP,
  [CppEnums.VehicleType.Type_FishingBoat] = SERVANT_TYPE.SMALL_SHIP,
  [CppEnums.VehicleType.Type_FastShip] = SERVANT_TYPE.SMALL_SHIP
}
local _servantData = {
  [SERVANT_TYPE.HORSE_AND_ETC] = {
    tabImageUV = {
      {
        149,
        283,
        197,
        331
      },
      {
        149,
        332,
        197,
        380
      },
      {
        149,
        332,
        197,
        380
      }
    },
    weightIconPath = "renewal/ui_icon/console_icon_00.dds",
    weightIconUV = {
      1,
      194,
      36,
      221
    },
    equipSlotNoList = {
      3,
      4,
      5,
      6,
      12
    },
    costumeSlotNoList = {
      14,
      15,
      16,
      17
    },
    moveItemToType = CppEnums.MoveItemToType.Type_Vehicle,
    pictogramUV = {
      [3] = {
        259,
        87,
        301,
        129
      },
      [4] = {
        259,
        44,
        301,
        86
      },
      [5] = {
        259,
        173,
        301,
        215
      },
      [6] = {
        259,
        130,
        301,
        172
      },
      [12] = {
        259,
        216,
        301,
        258
      },
      [14] = {
        302,
        87,
        344,
        129
      },
      [15] = {
        302,
        44,
        344,
        86
      },
      [16] = {
        302,
        173,
        344,
        215
      },
      [17] = {
        302,
        130,
        344,
        172
      }
    },
    checkFlag = {
      [3] = 1,
      [4] = 4,
      [5] = 2,
      [6] = 8,
      [14] = 16,
      [15] = 64,
      [16] = 32,
      [17] = 128
    }
  },
  [SERVANT_TYPE.CARRIAGE] = {
    tabImageUV = {
      {
        2,
        64,
        44,
        106
      },
      {
        2,
        20,
        44,
        62
      },
      {
        2,
        20,
        44,
        62
      }
    },
    weightIconPath = "renewal/ui_icon/console_icon_01.dds",
    weightIconUV = {
      62,
      221,
      97,
      248
    },
    equipSlotNoList = {
      4,
      5,
      6,
      13,
      25
    },
    costumeSlotNoList = {
      14,
      15,
      26
    },
    moveItemToType = CppEnums.MoveItemToType.Type_Vehicle,
    pictogramUV = {
      [4] = {
        173,
        173,
        215,
        215
      },
      [5] = {
        130,
        302,
        172,
        344
      },
      [6] = {
        87,
        302,
        129,
        344
      },
      [13] = {
        44,
        44,
        86,
        86
      },
      [25] = {
        173,
        216,
        215,
        258
      },
      [14] = {
        216,
        216,
        258,
        258
      },
      [15] = {
        216,
        173,
        258,
        215
      },
      [16] = {
        302,
        87,
        344,
        129
      },
      [17] = {
        302,
        87,
        344,
        129
      },
      [26] = {
        130,
        173,
        172,
        215
      }
    }
  },
  [SERVANT_TYPE.BIG_SHIP] = {
    tabImageUV = {
      {
        266,
        152,
        308,
        194
      },
      {
        266,
        108,
        308,
        150
      },
      {
        266,
        108,
        308,
        150
      }
    },
    weightIconPath = "renewal/ui_icon/console_icon_01.dds",
    weightIconUV = {
      62,
      193,
      97,
      220
    },
    equipSlotNoList = {
      3,
      4,
      5,
      12,
      25,
      7
    },
    costumeSlotNoList = {
      14,
      15,
      16,
      26
    },
    moveItemToType = CppEnums.MoveItemToType.Type_Ship,
    pictogramUV = {
      [3] = {
        87,
        259,
        129,
        301
      },
      [4] = {
        1,
        216,
        43,
        258
      },
      [5] = {
        173,
        259,
        215,
        301
      },
      [12] = {
        173,
        302,
        215,
        344
      },
      [25] = {
        1,
        259,
        43,
        301
      },
      [7] = {
        226,
        447,
        226,
        491
      },
      [14] = {
        130,
        259,
        172,
        301
      },
      [15] = {
        44,
        216,
        86,
        258
      },
      [16] = {
        216,
        259,
        258,
        301
      },
      [26] = {
        44,
        259,
        86,
        301
      }
    }
  },
  [SERVANT_TYPE.SMALL_SHIP] = {
    tabImageUV = {
      {
        266,
        152,
        308,
        194
      },
      {
        266,
        108,
        308,
        150
      },
      {
        266,
        108,
        308,
        150
      }
    },
    weightIconPath = "renewal/ui_icon/console_icon_01.dds",
    weightIconUV = {
      62,
      193,
      97,
      220
    },
    equipSlotNoList = {
      4,
      5,
      6,
      25
    },
    costumeSlotNoList = {
      15,
      16,
      14,
      26
    },
    moveItemToType = CppEnums.MoveItemToType.Type_Ship,
    pictogramUV = {
      [4] = {
        1,
        216,
        43,
        258
      },
      [5] = {
        1,
        302,
        43,
        344
      },
      [6] = {
        87,
        216,
        129,
        258
      },
      [25] = {
        1,
        259,
        43,
        301
      },
      [15] = {
        44,
        216,
        86,
        258
      },
      [16] = {
        44,
        302,
        86,
        344
      },
      [14] = {
        130,
        259,
        172,
        301
      },
      [26] = {
        44,
        259,
        86,
        301
      }
    },
    checkFlag = {
      [4] = 2,
      [5] = 4,
      [6] = 8,
      [25] = 128,
      [14] = 16,
      [15] = 32,
      [16] = 64,
      [26] = 256
    }
  }
}
local _equipPictogramUV = {
  [__eEquipSlotNoRightHand] = {
    1,
    87,
    43,
    129
  },
  [__eEquipSlotNoLeftHand] = {
    87,
    87,
    129,
    129
  },
  [__eEquipSlotNoSubTool] = {
    1,
    44,
    43,
    86
  },
  [__eEquipSlotNoChest] = {
    130,
    87,
    172,
    129
  },
  [__eEquipSlotNoGlove] = {
    130,
    44,
    172,
    86
  },
  [__eEquipSlotNoBoots] = {
    173,
    1,
    215,
    43
  },
  [__eEquipSlotNoHelm] = {
    87,
    44,
    129,
    86
  },
  [__eEquipSlotNoNecklace] = {
    130,
    1,
    172,
    43
  },
  [__eEquipSlotNoRing1] = {
    1,
    1,
    43,
    43
  },
  [__eEquipSlotNoRing2] = {
    1,
    1,
    43,
    43
  },
  [__eEquipSlotNoEaring1] = {
    44,
    1,
    86,
    43
  },
  [__eEquipSlotNoEaring2] = {
    44,
    1,
    86,
    43
  },
  [__eEquipSlotNoBelt] = {
    87,
    1,
    129,
    43
  },
  [__eEquipSlotNoLantern] = {
    44,
    44,
    86,
    86
  },
  [__eEquipSlotNoAvatarChest] = {
    44,
    130,
    86,
    172
  },
  [__eEquipSlotNoAvatarGlove] = {
    87,
    130,
    129,
    172
  },
  [__eEquipSlotNoAvatarBoots] = {
    216,
    1,
    258,
    43
  },
  [__eEquipSlotNoAvatarHelm] = {
    1,
    130,
    43,
    172
  },
  [__eEquipSlotNoAvatarWeapon] = {
    173,
    130,
    215,
    172
  },
  [__eEquipSlotNoAvatarSubWeapon] = {
    130,
    130,
    172,
    172
  },
  [__eEquipSlotNoAvatarUnderwear] = {
    216,
    44,
    258,
    86
  },
  [__eEquipSlotNoFaceDecoration1] = {
    216,
    130,
    258,
    172
  },
  [__eEquipSlotNoFaceDecoration2] = {
    1,
    173,
    43,
    215
  },
  [__eEquipSlotNoFaceDecoration3] = {
    44,
    173,
    86,
    215
  },
  [__eEquipSlotNoAlchemyStone] = {
    173,
    44,
    215,
    86
  },
  [__eEquipSlotNoAwakenWeapon] = {
    44,
    87,
    86,
    129
  },
  [__eEquipSlotNoAvatarAwakenWeapon] = {
    87,
    173,
    129,
    215
  },
  [__eEquipSlotNoQuestBook] = {
    173,
    87,
    215,
    129
  },
  [__eEquipSlotNoAxe] = {
    1,
    402,
    45,
    446
  },
  [__eEquipSlotNoSyringe] = {
    46,
    402,
    90,
    446
  },
  [__eEquipSlotNoHoe] = {
    91,
    402,
    135,
    446
  },
  [__eEquipSlotNoButcheryKnife] = {
    226,
    402,
    225,
    446
  },
  [__eEquipSlotNoSkinKnife] = {
    181,
    402,
    225,
    446
  },
  [__eEquipSlotNoPickAx] = {
    91,
    402,
    135,
    446
  },
  [__eEquipSlotNoFishingRod] = {
    91,
    447,
    90,
    491
  },
  [__eEquipSlotNoBobber] = {
    181,
    447,
    181,
    491
  },
  [__eEquipSlotNoFishingHarpoon] = {
    226,
    447,
    226,
    491
  }
}
PaGlobal_Inventory_All_ForConsole._lowerTabData = {
  [LOWER_TAB_TYPE.INVENTORY_TAB] = {
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_RENEW_INVENTORY"),
    whereType = WHERE_TYPE.INVENTORY
  },
  [LOWER_TAB_TYPE.CASH_INVEN_TAB] = {
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_RENEW_PEARLINVEN"),
    whereType = WHERE_TYPE.CASH_INVEN
  }
}
local _equipSlotNo = {
  [1] = 0,
  [2] = 6,
  [3] = 10,
  [4] = 11,
  [5] = 7,
  [6] = 27,
  [7] = 1,
  [8] = 3,
  [9] = 4,
  [10] = 8,
  [11] = 9,
  [12] = 2,
  [13] = 29,
  [14] = 5,
  [15] = 12,
  [16] = 31,
  [17] = 13
}
local _lifeEquipSlotNo = {
  [1] = __eEquipSlotNoAxe,
  [2] = __eEquipSlotNoSyringe,
  [3] = __eEquipSlotNoHoe,
  [4] = __eEquipSlotNoButcheryKnife,
  [5] = __eEquipSlotNoSkinKnife,
  [6] = __eEquipSlotNoPickAx,
  [7] = __eEquipSlotNoFishingRod,
  [8] = __eEquipSlotNoBobber,
  [9] = __eEquipSlotNoFishingHarpoon
}
local _costumeSlotNo = {
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  30,
  21,
  22,
  23,
  45
}
local KEY_GUIDE_TYPE = {
  A = 1,
  A_HOLD = 2,
  Y = 3,
  LT_Y = 4,
  LS_CLICK = 5,
  LT = 6,
  RT = 7,
  B = 8,
  RT_A = 9
}
local _keyGuideData = {
  InventoryInfo_InvenSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"),
    [KEY_GUIDE_TYPE.A_HOLD] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_HOLD_TO_MOVE"),
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_REMOVE"),
    [KEY_GUIDE_TYPE.LT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NEWBIEINVEN_TITLE"),
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.B] = PAGetString(Defines.StringSheet_GAME, "LUA_GENERIC_KEYGUIDE_XBOX_EXIT"),
    [KEY_GUIDE_TYPE.RT_A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIP_DONGUPGRADE_TITLE"),
    ["updateFunc"] = nil
  },
  InventoryInfo_EquipSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BOSSALERTSET_UNSET"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InventoryInfo_CostumeSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BOSSALERTSET_UNSET"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_KEYGUIDE_VISIBILITYTOGGLE"),
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = false,
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InventoryInfo_ServantInvenSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_NAVIGATE"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = false,
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InventoryInfo_ServantEquipSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BOSSALERTSET_UNSET"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_KEYGUIDE_VISIBILITYTOGGLE"),
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = false,
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InventoryInfo_ServantCostumeSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BOSSALERTSET_UNSET"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_KEYGUIDE_VISIBILITYTOGGLE"),
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = false,
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  CheckButton_Costume_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_KEYGUIDE_VISIBILITYTOGGLE"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InvenSortArea_ = {
    [KEY_GUIDE_TYPE.A] = false,
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  Button_DetailShow_ = {
    [KEY_GUIDE_TYPE.A] = false,
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = false,
    [KEY_GUIDE_TYPE.LT] = false,
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.RT_A] = false,
    ["updateFunc"] = nil
  },
  InventoryInfo_CategoryInvenSlotBG_ = {
    [KEY_GUIDE_TYPE.A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"),
    [KEY_GUIDE_TYPE.A_HOLD] = false,
    [KEY_GUIDE_TYPE.LS_CLICK] = "",
    [KEY_GUIDE_TYPE.Y] = false,
    [KEY_GUIDE_TYPE.LT_Y] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_REMOVE"),
    [KEY_GUIDE_TYPE.LT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NEWBIEINVEN_TITLE"),
    [KEY_GUIDE_TYPE.RT] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"),
    [KEY_GUIDE_TYPE.B] = PAGetString(Defines.StringSheet_GAME, "LUA_GENERIC_KEYGUIDE_XBOX_EXIT"),
    [KEY_GUIDE_TYPE.RT_A] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIP_DONGUPGRADE_TITLE"),
    ["updateFunc"] = nil
  }
}
PaGlobal_Inventory_All_ForConsole._isCashProductBlockOpenChcked = false
PaGlobal_Inventory_All_ForConsole._configForInven = {
  createIcon = true,
  createBorder = true,
  createCount = true,
  createEnchant = true,
  createCooltime = true,
  createExpiration = true,
  createExpirationBG = true,
  createExpiration2h = true,
  createClassEquipBG = true,
  createEnduranceIcon = true,
  createCooltimeText = true,
  createCash = true,
  createMaidActorOnly = true,
  createItemLock = true,
  createBagIcon = true,
  createSoulComplete = true,
  createBackend = true
}
local _configForEquip = {
  createIcon = true,
  createBorder = true,
  createCount = false,
  createCash = true,
  createMaidActorOnly = true,
  createExpiration = true,
  createEnchant = true,
  createEnduranceIcon = true,
  createItemLock = true,
  createBackend = true
}
local _configForCostume = {
  createIcon = true,
  createBorder = true,
  createCount = false,
  createCash = true,
  createMaidActorOnly = true,
  createExpiration = true,
  createEnchant = true,
  createEnduranceIcon = true,
  createItemLock = true,
  createBackend = true
}
local over_SlotEffect
PaGlobal_Inventory_All_ForConsole.effectScene = {
  newItem = {}
}
local backendInfoTable_Inven = {
  _backendUITable = Array.new()
}
function FromClient_luaLoadComplete_InventoryInfo_Init()
  PaGlobal_Inventory_All_ForConsole:initialize()
  local isShowSubWeapon = ToClient_IsShowSubWeapon()
  PaGlobal_Inventory_All_ForConsole._ui.chk_subWeapon:SetCheck(not isShowSubWeapon)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_InventoryInfo_Init")
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Renew_2.lua")
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Renew_3.lua")
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Renew_4.lua")
function PaGlobal_Inventory_All_ForConsole:initialize()
  _panel:setGlassBackground(true)
  _keyGuideData.InventoryInfo_InvenSlotBG_.updateFunc = Input_InventoryInfo_InvenSlotKeyGuide
  _keyGuideData.InventoryInfo_EquipSlotBG_.updateFunc = Input_InventoryInfo_EquipSlotKeyGuide
  _keyGuideData.InventoryInfo_CostumeSlotBG_.updateFunc = Input_InventoryInfo_CostumeSlotKeyGuide
  _keyGuideData.InventoryInfo_ServantInvenSlotBG_.updateFunc = Input_InventoryInfo_ServantInvenSlotKeyGuide
  _keyGuideData.InventoryInfo_ServantEquipSlotBG_.updateFunc = Input_InventoryInfo_ServantEquipSlotKeyGuide
  _keyGuideData.InventoryInfo_ServantCostumeSlotBG_.updateFunc = Input_InventoryInfo_ServantCostumeSlotKeyGuide
  _keyGuideData.CheckButton_Costume_.updateFunc = Input_InventoryInfo_ToggleFive
  _keyGuideData.InvenSortArea_.updateFunc = nil
  _keyGuideData.Button_DetailShow_.updateFunc = nil
  _keyGuideData.InventoryInfo_CategoryInvenSlotBG_.updateFunc = PaGlobal_Inventory_All_ForConsole_CategoryInvenSlotKeyGuide
  self._ui.stc_bg = UI.getChildControl(_panel, "Static_Bg")
  self._ui.stc_title = UI.getChildControl(_panel, "StaticText_Title")
  self._ui.stc_tabGroup = UI.getChildControl(_panel, "Static_TabGroup")
  self._ui.stc_equipGroup = UI.getChildControl(_panel, "Static_EquipGroup")
  self._ui.stc_servantGroup = UI.getChildControl(_panel, "Static_ServantGroup")
  self._ui.stc_familyInvenGroup = UI.getChildControl(_panel, "Static_FamilyInvenGroup")
  self._ui.stc_familyInvenSortArea = UI.getChildControl(_panel, "Static_FailyInvenSortArea")
  self._ui.stc_enchantInvenGroup = UI.getChildControl(_panel, "Static_EnchantInvenGroup")
  self._ui.stc_enchantInvenSortArea = UI.getChildControl(_panel, "Static_EnchantInvenSortArea")
  self._ui.stc_invenGroup = UI.getChildControl(_panel, "Static_InvenGroup")
  self._ui.stc_invenSortArea = UI.getChildControl(_panel, "Static_InvenSortArea")
  self._ui.stc_bottomBG = UI.getChildControl(_panel, "StaticText_KeyGuideBg_ConsoleUIRight")
  self._ui.stc_bottomBG_setFunctor = UI.getChildControl(_panel, "StaticText_KeyGuideBg_SetFunctor_ConsoleUIRight")
  self._ui.txt_titleText = UI.getChildControl(self._ui.stc_title, "StaticText_TitleIcon")
  self._ui.stc_invenBottomArea = UI.getChildControl(self._ui.stc_invenGroup, "Static_InvenBottomArea")
  self._ui.txt_Silver = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_MoneyValue")
  self._ui.txt_Pearl = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_CashValue")
  self._ui.txt_Mileage = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_MileageValue")
  self._ui.txt_Shell = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_ShellfishValue")
  self._ui.txt_HardCore = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_HardCoreMoney")
  self._ui.txt_weight = UI.getChildControl(self._ui.stc_invenBottomArea, "StaticText_WeightValue")
  self._ui.progress2_Weight = UI.getChildControl(self._ui.stc_invenBottomArea, "Progress2_TotalWeight")
  self._ui.stc_weightIcon = UI.getChildControl(self._ui.stc_invenBottomArea, "Static_WeightIcon")
  self._ui.progress2_WeightBg = UI.getChildControl(self._ui.stc_invenBottomArea, "Static_WeightProgressBg")
  self._ui.rdo_tabButtons = {}
  local radioButtonCount = 4
  if ToClient_HardCoreChannelWithContensOption() == true then
    local servantControl = UI.getChildControl(self._ui.stc_tabGroup, "RadioButton_3")
    servantControl:SetShow(false)
    radioButtonCount = 2
  end
  for ii = 1, radioButtonCount do
    self._ui.rdo_tabButtons[ii] = UI.getChildControl(self._ui.stc_tabGroup, "RadioButton_" .. ii)
  end
  local rdoBtnsStartX = _panel:GetSizeX() / 2 - self._tabXGab * radioButtonCount / 2 + self._tabXGab / 2 - self._ui.rdo_tabButtons[1]:GetSizeX() / 2
  for ii = 1, radioButtonCount do
    self._ui.rdo_tabButtons[ii]:SetPosX(rdoBtnsStartX + self._tabXGab * (ii - 1))
  end
  self._ui.stc_important = UI.getChildControl(self._ui.rdo_tabButtons[2], "Static_Important")
  self._ui.stc_important:SetShow(false)
  self._ui.stc_selectedLine = UI.getChildControl(self._ui.stc_tabGroup, "Static_SelectedLine")
  self._ui.stc_upperGroups = Array.new()
  self._ui.stc_upperGroups:push_back(self._ui.stc_equipGroup)
  self._ui.stc_upperGroups:push_back(self._ui.stc_equipGroup)
  if self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB] ~= nil then
    self._ui.stc_upperGroups:push_back(self._ui.stc_servantGroup)
  end
  if self._ui.rdo_tabButtons[UPPER_TAB_TYPE.LIFEEEQUIP_TAB] ~= nil then
    self._ui.stc_upperGroups:push_back(self._ui.stc_equipGroup)
    self._ui.rdo_tabButtons[4]:SetShow(true)
  end
  self._ui.stc_xBoxKey_LB = UI.getChildControl(self._ui.stc_tabGroup, "Static_LB_ConsoleUI")
  self._ui.stc_xBoxKey_RB = UI.getChildControl(self._ui.stc_tabGroup, "Static_RB_ConsoleUI")
  self._ui.txt_keyGuideA = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_A_ConsoleUI")
  self._ui.txt_keyGuideA2 = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_A_Hold_ConsoleUI")
  self._ui.txt_keyGuideB = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_B_ConsoleUI")
  self._ui.txt_keyGuideY = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_Y_ConsoleUI")
  self._ui.txt_keyGuideLTY = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_LTY_ConsoleUI")
  self._ui.txt_keyGuideRT = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_RT_ConsoleUI")
  self._ui.txt_keyGuideLT = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_LT_ConsoleUI")
  self._ui.txt_keyGuideRTA = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_RTX_ConsoleUI")
  self._ui.txt_slotCount = UI.getChildControl(self._ui.stc_invenSortArea, "StaticText_SlotCount")
  self._ui.txt_keyGuideSort = UI.getChildControl(self._ui.stc_invenSortArea, "StaticText_Sort_ConsoleUI")
  self._ui.btn_sortOption = UI.getChildControl(self._ui.stc_invenSortArea, "Button_Sort_Set")
  self._ui.chk_sort = UI.getChildControl(self._ui.stc_invenSortArea, "CheckButton_ItemSort")
  self._ui.txt_keyGuideSetFunctorA = UI.getChildControl(self._ui.stc_bottomBG_setFunctor, "StaticText_A_ConsoleUI")
  self._ui.txt_keyGuideSetFunctorY = UI.getChildControl(self._ui.stc_bottomBG_setFunctor, "StaticText_Y_ConsoleUI")
  self._ui.txt_keyGuideSetFunctorB = UI.getChildControl(self._ui.stc_bottomBG_setFunctor, "StaticText_B_ConsoleUI")
  self._ui.txt_keyGuideSetFunctorRT = UI.getChildControl(self._ui.stc_bottomBG_setFunctor, "StaticText_RT_ConsoleUI")
  self._ui.stc_cashProductBg = UI.getChildControl(_panel, "Static_BlockSlot")
  self._ui.btn_restoreProduct = UI.getChildControl(self._ui.stc_cashProductBg, "Button_Get_Product")
  self._ui.stc_season_UpgradeBg = UI.getChildControl(_panel, "Static_Season_KeyGuide_Bg")
  self._ui.stc_season_Upgrade = UI.getChildControl(_panel, "Button_Season_Upgrade")
  self._ui.stc_season_UpgradeEffect = UI.getChildControl(self._ui.stc_season_Upgrade, "Static_Effect")
  self._screenGapSizeX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  self._originPanelSizeY = Panel_Window_Inventory:GetSizeY()
  self._originBgSizeY = self._ui.stc_bg:GetSizeY()
  self._famliyInvenMaxCapacity = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  self._enchantInvenMaxCapacity = __eTCashInventorySlotNoMax
  self:alignKeyGuide()
  self:initEquipmentUIControls()
  self:initCostumeUIControls()
  self:initServantUIControl()
  self:initInventory()
  self:initFamilyInventory()
  self:initEnchantInventory()
  self:initFamilyEquipControls()
  self:registEventHandler()
  self:registMessageHandler()
  if nil ~= self._ui.btn_myStat then
    self._ui.btn_myStat:SetShow(true)
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.btn_myStat:SetIgnore(true)
    self._ui.btn_myStat:SetMonoTone(true)
  end
  self:categoryControlInit()
  self:initFamilyInventory_category()
  self:initEnchantInventory_category()
  _isInitialized = true
end
function PaGlobal_Inventory_All_ForConsole:alignKeyGuide()
  self._keyGuideList = {
    [KEY_GUIDE_TYPE.A] = self._ui.txt_keyGuideA,
    [KEY_GUIDE_TYPE.A_HOLD] = self._ui.txt_keyGuideA2,
    [KEY_GUIDE_TYPE.Y] = self._ui.txt_keyGuideY,
    [KEY_GUIDE_TYPE.LT_Y] = self._ui.txt_keyGuideLTY,
    [KEY_GUIDE_TYPE.LS_CLICK] = self._ui.txt_keyGuideSort,
    [KEY_GUIDE_TYPE.LT] = self._ui.txt_keyGuideLT,
    [KEY_GUIDE_TYPE.RT] = self._ui.txt_keyGuideRT,
    [KEY_GUIDE_TYPE.B] = self._ui.txt_keyGuideB,
    [KEY_GUIDE_TYPE.RT_A] = self._ui.txt_keyGuideRTA
  }
  local bottomKeyGuideList = {
    self._ui.txt_keyGuideA,
    self._ui.txt_keyGuideA2,
    self._ui.txt_keyGuideY,
    self._ui.txt_keyGuideLTY,
    self._ui.txt_keyGuideLT,
    self._ui.txt_keyGuideRT,
    self._ui.txt_keyGuideB,
    self._ui.txt_keyGuideRTA
  }
  self._ui.txt_keyGuideB:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GENERIC_KEYGUIDE_XBOX_EXIT"))
  local isFamilyInventoryActive = PaGlobalFunc_Inventory_All_familyInventoryIsActive()
  local isEnchantInventoryActive = PaGlobalFunc_Inventory_All_enchantInventoryIsActive()
  if _ContentsGroup_EnchantRemaster == true then
    if isFamilyInventoryActive == true and isEnchantInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"))
      elseif self._isShowFamilyInven == true and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY"))
      elseif self._isShowFamilyInven == false and self._isShowEnchantInven == true then
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    elseif isFamilyInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"))
      else
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    elseif isEnchantInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY"))
      else
        self._ui.txt_keyGuideRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(bottomKeyGuideList, self._ui.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 0)
  local setFunctorKeyGuideList = {
    self._ui.txt_keyGuideSetFunctorA,
    self._ui.txt_keyGuideSetFunctorY,
    self._ui.txt_keyGuideSetFunctorRT,
    self._ui.txt_keyGuideSetFunctorB
  }
  self._ui.txt_keyGuideB:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GENERIC_KEYGUIDE_XBOX_EXIT"))
  if _ContentsGroup_EnchantRemaster == true then
    if isFamilyInventoryActive == true and isEnchantInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"))
      elseif self._isShowFamilyInven == true and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY"))
      elseif self._isShowFamilyInven == false and self._isShowEnchantInven == true then
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    elseif isFamilyInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_TITLE_NEW"))
      else
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    elseif isEnchantInventoryActive == true then
      if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY"))
      else
        self._ui.txt_keyGuideSetFunctorRT:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
      end
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(setFunctorKeyGuideList, self._ui.stc_bottomBG_setFunctor, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 0)
end
function PaGlobal_Inventory_All_ForConsole:alignSubMenuUIButton()
  local uiCount = 1
  local maxWidth = 435
  if self._ui.btn_artifactBag:GetShow() == true then
    uiCount = uiCount + 1
  end
  if self._ui.btn_combineBag:GetShow() then
    uiCount = uiCount + 1
  end
  local currentUIIdex = 0
  local eachWidth = maxWidth / uiCount
  if self._ui.btn_artifactBag:GetShow() == true then
    self._ui.btn_artifactBag:SetSize(eachWidth, self._ui.btn_artifactBag:GetSizeY())
  end
  if self._ui.btn_combineBag:GetShow() then
    self._ui.btn_combineBag:SetSize(eachWidth, self._ui.btn_artifactBag:GetSizeY())
  end
end
function PaGlobal_Inventory_All_ForConsole:initEquipmentUIControls()
  self._ui.stc_equipSlotBG = {}
  if nil == self._ui.stc_equipBG then
    local stc_equipBG = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.EQUIPMENT_TAB], "Static_NormalEquipBg")
    local stc_equipArtifactBG = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.EQUIPMENT_TAB], "Static_NormalEquipBg_1")
    if false == _ContentsGroup_ArtifactItem then
      stc_equipBG:SetShow(true)
      stc_equipArtifactBG:SetShow(false)
      self._ui.stc_equipBG = stc_equipBG
    else
      stc_equipBG:SetShow(false)
      stc_equipArtifactBG:SetShow(true)
      self._ui.stc_equipBG = stc_equipArtifactBG
      _equipSlotNo[18] = 32
      _equipSlotNo[19] = 33
    end
  end
  local isClassType = getSelfPlayer():getClassType()
  for ii = 1, #_equipSlotNo do
    self._ui.stc_equipSlotBG[ii] = UI.getChildControl(self._ui.stc_equipBG, "InventoryInfo_EquipSlotBG_" .. ii)
    local slotBG = self._ui.stc_equipSlotBG[ii]
    local equipSlotNo = _equipSlotNo[ii]
    if __eEquipSlotNoLantern == equipSlotNo then
      slotBG:SetShow(false)
    end
    local pictogram = UI.getChildControl(slotBG, "Static_Pictogram")
    if nil ~= _equipSlotNo[ii] then
      self._ui.slot_equips[ii] = {}
      local slot = self._ui.slot_equips[ii]
      SlotItem.new(slot, "equipSlot_" .. ii, ii, slotBG, _configForEquip)
      slot.equipSlotNoList = _equipSlotNo[ii]
      pictogram:SetIgnore(true)
      slot.pictogram = pictogram
      slot:createChild()
      slot.icon:SetIgnore(true)
      if __eEquipSlotNoRightHand == equipSlotNo or __eEquipSlotNoLeftHand == equipSlotNo or __eEquipSlotNoAwakenWeapon == equipSlotNo then
        slot.chk_toggleButton = UI.getChildControl(slotBG, "CheckButton_View")
      end
      if slot.chk_toggleButton ~= nil then
        slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "Input_InventoryInfo_ToggleEquipEffectSwtich(" .. ii .. ")")
        slot.chk_toggleButton:SetShow(true)
        slot.chk_toggleButton:SetCheck(true)
        slotBG:SetChildOrder(slot.icon:GetKey(), slot.chk_toggleButton:GetKey())
      end
      if 13 == ii and __eClassType_ShyWaman == isClassType then
        slot.pictogram:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(slot.pictogram, 283, 48, 329, 94)
        slot.pictogram:getBaseTexture():setUV(x1, y1, x2, y2)
        slot.pictogram:setRenderTexture(slot.pictogram:getBaseTexture())
      end
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_EquipSlot(" .. equipSlotNo .. ")")
      if true == _ContentsGroup_RenewUI_Tooltip then
        slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowEquipTooltip(" .. equipSlotNo .. ", true)")
      end
      slotBG:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_equipShowFloatingTooltip(true, " .. ii .. ", true)")
      slotBG:addInputEvent("Mouse_Out", "InputMOn_InventoryInfo_equipShowFloatingTooltip(true, " .. ii .. ", false)")
      Panel_Tooltip_Item_SetPosition(_equipSlotNo[ii], slot, "equipment")
    end
  end
  local abilityArea = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.EQUIPMENT_TAB], "Static_AbilityArea")
  local notationAbilityBg = UI.getChildControl(abilityArea, "Static_NotationAbilityBg")
  self._ui.chk_detailInfo = UI.getChildControl(notationAbilityBg, "CheckButton_DetailInfo")
  self._ui.btn_notationSetting = UI.getChildControl(notationAbilityBg, "Button_NotationAbilitySetting")
  notationAbilityBg:SetShow(_ContentsGroup_RenewCharacterStatusViewMode == true)
  self._ui.txt_attackValue = UI.getChildControl(abilityArea, "StaticText_Attack")
  self._ui.txt_awakenAttackValue = UI.getChildControl(abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_defenceValue = UI.getChildControl(abilityArea, "StaticText_Defence")
  self._ui.chk_autoActive = UI.getChildControl(self._ui.stc_equipBG, "CheckBox_AlchemyStone")
  self._ui.chk_autoActive:addInputEvent("Mouse_LUp", "Input_InventoryInfo_AutoActive()")
  local autoActiveIsOn = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
  local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  if true == isSolare then
    autoActiveIsOn = true
  end
  self._ui.chk_autoActive:SetCheck(autoActiveIsOn)
end
function PaGlobal_Inventory_All_ForConsole:initCostumeUIControls()
  self._ui.stc_costumeSlotBG = {}
  if nil == self._ui.stc_costumeBG then
    self._ui.stc_costumeBG = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.COSTUME_TAB], "Static_CashEquipBg")
  end
  for ii = 1, #_costumeSlotNo do
    self._ui.stc_costumeSlotBG[ii] = UI.getChildControl(self._ui.stc_costumeBG, "InventoryInfo_CostumeSlotBG_" .. ii)
    local slotBG = self._ui.stc_costumeSlotBG[ii]
    local pictogram = UI.getChildControl(slotBG, "Static_Pictogram")
    pictogram:SetIgnore(true)
    local slot = {}
    SlotItem.new(slot, "costumeSlot_" .. ii, ii, slotBG, _configForCostume)
    slot.costumeSlotNoList = _costumeSlotNo[ii]
    slot:createChild()
    slot.icon:SetIgnore(true)
    if _ContentsGroup_UsePadSnapping or ToClient_IsDevelopment() then
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_EquipSlot(" .. _costumeSlotNo[ii] .. ")")
    end
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowEquipTooltip(" .. _costumeSlotNo[ii] .. ", true)")
    end
    slotBG:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_equipShowFloatingTooltip(false, " .. ii .. ", true)")
    slotBG:addInputEvent("Mouse_Out", "InputMOn_InventoryInfo_equipShowFloatingTooltip(false, " .. ii .. ", false)")
    slot.pictogram = pictogram
    slot.chk_toggleButton = UI.getChildControl(slotBG, "CheckButton_View")
    slot.chk_toggleButton:addInputEvent("Mouse_LUp", "Input_InventoryInfo_CostumeShowToggle(" .. ii .. ")")
    slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "Input_InventoryInfo_CostumeShowToggle(" .. ii .. ")")
    slotBG:SetChildOrder(slot.icon:GetKey(), slot.chk_toggleButton:GetKey())
    Panel_Tooltip_Item_SetPosition(_costumeSlotNo[ii], slot, "equipment")
    self._ui.slot_costumes[ii] = slot
  end
  local bottomButtonArea = UI.getChildControl(self._ui.stc_equipGroup, "Static_BottomButtonArea")
  self._ui.chk_toggleNameWhenCamo = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_1_ShowNameWhenCamouflage")
  self._ui.chk_showUnderwear = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_2_Underwear_Invisual")
  self._ui.chk_hideHelmet = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_3_Helm_Invisual")
  self._ui.chk_hideHelmetIcon = UI.getChildControl(self._ui.chk_hideHelmet, "Static_HelmetIcon")
  self._ui.chk_openHelmet = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_4_HelmOpen")
  self._ui.chk_openHelmetIcon = UI.getChildControl(self._ui.chk_openHelmet, "Static_HelmetOpenIcon")
  self._ui.chk_toggleCloak = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_5_Cloak_Invisual")
  self._ui.chk_subWeapon = UI.getChildControl(bottomButtonArea, "CheckButton_Costume_6_SubWeapon_Invisual")
  self._ui.chk_toggleNameWhenCamo:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleNameWhenCamo()")
  self._ui.chk_showUnderwear:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleUnderwear()")
  self._ui.chk_hideHelmet:addInputEvent("Mouse_LUp", "Input_InventoryInfo_HideHelmet()")
  self._ui.chk_openHelmet:addInputEvent("Mouse_LUp", "Input_InventoryInfo_OpenHelmet()")
  self._ui.chk_toggleCloak:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleCloak()")
  self._ui.chk_subWeapon:addInputEvent("Mouse_LUp", "Input_InventoryInfo_SubWeapon()")
  self._ui.btn_showDetail = UI.getChildControl(bottomButtonArea, "Button_DetailShow_1")
  self._ui.btn_showDetail:addInputEvent("Mouse_LUp", "PaGlobalFunc_InventoryInfo_DetailWindowOpenToggle()")
  self._ui.btn_myStat = UI.getChildControl(bottomButtonArea, "Button_MyStat")
  self._ui.btn_myStat:addInputEvent("Mouse_LUp", "PaGlobalFunc_InventoryInfo_MyStatOpenToggle()")
  self._ui.btn_artifactBag = UI.getChildControl(bottomButtonArea, "Button_Artifacts_Inven")
  self._ui.btn_artifactBag:SetShow(_ContentsGroup_LightStoneBag)
  if _ContentsGroup_LightStoneBag == true then
    self._ui.btn_artifactBag:addInputEvent("Mouse_LUp", "PaGlobalFunc_InventoryInfo_ArtifactBagOpenToggle()")
  end
  self._ui.btn_combineBag = UI.getChildControl(bottomButtonArea, "Button_CombineBag_Inven")
  self._ui.btn_combineBag:SetShow(_ContentsGroup_CombineBag)
  if _ContentsGroup_CombineBag == true then
    self._ui.btn_combineBag:addInputEvent("Mouse_LUp", "PaGlobalFunc_InventoryInfo_CombineBagOpenToggle()")
  end
  self._ui.btn_restoreProduct:addInputEvent("Mouse_LUp", "FGlobal_Window_PearlBox_Purchase_Restore()")
  if false == isGameTypeKorea() and false == isGameTypeTaiwan() and false == isGameTypeJapan() then
    self._ui.btn_combineBag:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YAZ_BAG_SHORT_TITLE"))
  else
    self._ui.btn_combineBag:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMBINATION_SLOT_TITLE"))
  end
  self._ui.chk_hideHelmet:SetCheck(not ToClient_IsShowHelm())
  self._ui.chk_hideHelmetIcon:SetCheck(not ToClient_IsShowHelm())
  self._ui.chk_openHelmet:SetCheck(ToClient_IsShowBattleHelm())
  self._ui.chk_openHelmetIcon:SetCheck(ToClient_IsShowBattleHelm())
  getSelfPlayer():get():setUnderwearModeInhouse(false)
  self._ui.chk_showUnderwear:SetCheck(false)
  self._ui.chk_toggleCloak:SetCheck(not ToClient_IsShowCloak())
  self._ui.chk_toggleNameWhenCamo:SetCheck(Toclient_setShowNameWhenCamouflage())
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.btn_combineBag:SetShow(false)
    self._ui.btn_artifactBag:SetShow(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:initFamilyEquipControls()
  self._ui.stc_lifeEquipSlotBG = {}
  if nil == self._ui.stc_lifeEquipBG then
    self._ui.stc_lifeEquipBG = UI.getChildControl(self._ui.stc_equipGroup, "Static_FamilyEquipBg")
  end
  for ii = 1, #_lifeEquipSlotNo do
    self._ui.stc_lifeEquipSlotBG[ii] = UI.getChildControl(self._ui.stc_lifeEquipBG, "InventoryInfo_EquipSlotBG_" .. ii)
    local slotBG = self._ui.stc_lifeEquipSlotBG[ii]
    local slotIndex = _lifeEquipSlotNo[ii]
    local pictogram = UI.getChildControl(slotBG, "Static_Pictogram")
    if nil ~= _lifeEquipSlotNo[ii] then
      self._ui.slot_lifeEquips[ii] = {}
      local slot = self._ui.slot_lifeEquips[ii]
      SlotItem.new(slot, "lifeEeuipSlot_" .. ii, ii, slotBG, _configForEquip)
      slot.equipSlotNoList = _lifeEquipSlotNo[ii]
      pictogram:SetIgnore(true)
      slot.pictogram = pictogram
      slot:createChild()
      slot.icon:SetIgnore(true)
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_EquipSlot(" .. _lifeEquipSlotNo[ii] .. ")")
      if true == _ContentsGroup_RenewUI_Tooltip then
        slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowEquipTooltip(" .. _lifeEquipSlotNo[ii] .. ", true)")
      end
      slotBG:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_LifeEquipShowFloatingTooltip(" .. ii .. ", true)")
      slotBG:addInputEvent("Mouse_Out", "InputMOn_InventoryInfo_LifeEquipShowFloatingTooltip(" .. ii .. ", false)")
      Panel_Tooltip_Item_SetPosition(_lifeEquipSlotNo[ii], slot, "equipment")
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:initServantUIControl()
  if self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB] == nil or self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB] == nil then
    return
  end
  local progressBG = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "Static_ServantWeightProgressBG")
  self._ui.txt_servantName = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "StaticText_ServantName")
  self._ui.progress2_servantWeight = UI.getChildControl(progressBG, "Progress2_ServantWeight")
  self._ui.txt_servantInvenCountDisplay = UI.getChildControl(progressBG, "StaticText_SlotCount")
  self._ui.txt_servantWeightValue = UI.getChildControl(progressBG, "StaticText_WeightValue")
  self._ui.stc_horseWeight = UI.getChildControl(progressBG, "Static_HorseWeight")
  self._ui.txt_servantEquipInfo = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "StaticText_ServantEquipSlot")
  self._ui.txt_servantCostumeInfo = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "StaticText_ServantCostumeSlot")
  self._ui.txt_noServant = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "StaticText_NoServant")
  self._ui.txt_noServant:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_WindowTradeMarket_NotVehicleNear"))
  local servantInvenBG = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "Static_ServantInvenBG")
  self._ui.servantEquipSlotTemplate = UI.getChildControl(self._ui.txt_servantEquipInfo, "Static_EquipItemSlot_Template")
  self._ui.servantCostumeSlotTemplate = UI.getChildControl(self._ui.txt_servantCostumeInfo, "Static_CostumeItemSlot_Template")
  self._ui.servantEquipSlotTemplate:SetShow(false)
  self._ui.servantCostumeSlotTemplate:SetShow(false)
  self._ui.scroll_servantInven = UI.getChildControl(self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB], "Scroll_ServantInventory")
  local slot = self._ui.slot_servantInven
  local slotBG = self._ui.stc_servantInvenSlotBG
  local columnMax = self._invenSlotColumnMax
  local slotCount = self._servantInvenRowMax * columnMax
  for ii = 1, slotCount do
    slotBG[ii] = UI.getChildControl(servantInvenBG, "InventoryInfo_ServantInvenSlotBG_" .. ii)
    slot[ii] = {}
    SlotItem.new(slot[ii], "ServantInvenSlot_" .. ii, ii, slotBG[ii], self._configForInven)
    slot[ii]:createChild()
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_ServantInvenSlot(" .. ii .. ")")
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowServantInvenTooltip(" .. ii .. ", true)")
    end
    slot[ii].icon:SetIgnore(true)
    slotBG[ii]:addInputEvent("Mouse_On", "Input_InventoryInfo_ServantInvenFloatingTooltip(" .. ii .. ", true)")
    slotBG[ii]:addInputEvent("Mouse_Out", "Input_InventoryInfo_ServantInvenFloatingTooltip(" .. ii .. ", false)")
    if ii <= columnMax then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_InventoryInfo_ServantInventory(true)")
    elseif ii > columnMax * (self._servantInvenRowMax - 1) then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_InventoryInfo_ServantInventory(false)")
    end
  end
  UIScroll.InputEvent(self._ui.scroll_servantInven, "InputScroll_InventoryInfo_ServantInventory")
  local slot_servantEquip = self._ui.slot_servantEquip
  local stc_servantEquipSlotBG = self._ui.stc_servantEquipSlotBG
  for ii = 1, self._servantEquipSlotMax do
    stc_servantEquipSlotBG[ii] = UI.cloneControl(self._ui.servantEquipSlotTemplate, self._ui.txt_servantEquipInfo, "InventoryInfo_ServantEquipSlotBG_" .. ii)
    stc_servantEquipSlotBG[ii]:SetPosX((ii - 1) * self._defaultXGap)
    slot_servantEquip[ii] = {}
    SlotItem.new(slot_servantEquip[ii], "ServantEquipSlot_" .. ii, ii, stc_servantEquipSlotBG[ii], _configForEquip)
    slot_servantEquip[ii]:createChild()
    slot_servantEquip[ii].icon:SetIgnore(true)
    stc_servantEquipSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_A, "InputMLUp_InventoryInfo_ServantEquipDropHandler()")
    stc_servantEquipSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_ServantEquipSlot(true, " .. ii .. ")")
    stc_servantEquipSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "Input_InventoryInfo_ServantEquipToggle(true, " .. ii .. ")")
    if _ContentsGroup_RenewUI_Tooltip == true then
      stc_servantEquipSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowServantEquipTooltip(true," .. ii .. ", true)")
    end
    slot_servantEquip[ii].pictogram = UI.getChildControl(stc_servantEquipSlotBG[ii], "Static_ItemPictogram")
    slot_servantEquip[ii].pictogram:SetIgnore(true)
    slot_servantEquip[ii].chk_toggleButton = UI.getChildControl(stc_servantEquipSlotBG[ii], "CheckButton_ShowToggle")
    stc_servantEquipSlotBG[ii]:addInputEvent("Mouse_On", "Input_InventoryInfo_ServantEquipShowFloatingTooltip(true," .. ii .. ", true)")
    stc_servantEquipSlotBG[ii]:addInputEvent("Mouse_Out", "Input_InventoryInfo_ServantEquipShowFloatingTooltip(true," .. ii .. ", false)")
    stc_servantEquipSlotBG[ii]:SetChildOrder(slot_servantEquip[ii].icon:GetKey(), slot_servantEquip[ii].chk_toggleButton:GetKey())
  end
  local slot_servantCostume = self._ui.slot_servantCostume
  local stc_servantCostumeSlotBG = self._ui.stc_servantCostumeSlotBG
  for ii = 1, self._servantEquipSlotMax do
    stc_servantCostumeSlotBG[ii] = UI.cloneControl(self._ui.servantCostumeSlotTemplate, self._ui.txt_servantCostumeInfo, "InventoryInfo_ServantCostumeSlotBG_" .. ii)
    stc_servantCostumeSlotBG[ii]:SetPosX((ii - 1) * self._defaultXGap)
    slot_servantCostume[ii] = {}
    SlotItem.new(slot_servantCostume[ii], "ServantCostumeSlot_" .. ii, ii, stc_servantCostumeSlotBG[ii], _configForCostume)
    slot_servantCostume[ii]:createChild()
    slot_servantCostume[ii].icon:SetIgnore(true)
    stc_servantCostumeSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_A, "InputMLUp_InventoryInfo_ServantEquipDropHandler()")
    stc_servantCostumeSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_ServantEquipSlot(false, " .. ii .. ")")
    stc_servantCostumeSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "Input_InventoryInfo_ServantEquipToggle(false, " .. ii .. ")")
    if true == _ContentsGroup_RenewUI_Tooltip then
      stc_servantCostumeSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowServantEquipTooltip(false," .. ii .. ", true)")
    end
    stc_servantCostumeSlotBG[ii]:addInputEvent("Mouse_On", "Input_InventoryInfo_ServantEquipShowFloatingTooltip(false," .. ii .. ", true)")
    stc_servantCostumeSlotBG[ii]:addInputEvent("Mouse_Out", "Input_InventoryInfo_ServantEquipShowFloatingTooltip(false," .. ii .. ", false)")
    slot_servantCostume[ii].pictogram = UI.getChildControl(stc_servantCostumeSlotBG[ii], "Static_ItemPictogram")
    slot_servantCostume[ii].pictogram:SetIgnore(true)
    slot_servantCostume[ii].chk_toggleButton = UI.getChildControl(stc_servantCostumeSlotBG[ii], "CheckButton_ShowToggle")
    stc_servantCostumeSlotBG[ii]:SetChildOrder(slot_servantCostume[ii].icon:GetKey(), slot_servantCostume[ii].chk_toggleButton:GetKey())
  end
end
function PaGlobal_Inventory_All_ForConsole:initInventory()
  self._ui.stc_invenSlotBG = {}
  self._newItemAtSlot = {}
  self._isSlotEmpty = false
  self._ui.invenSlotTemplate = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotTemplate")
  self._ui.stc_invenBG = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotArea_10")
  local slotBG = self._ui.stc_invenSlotBG
  local slotTemplate = self._ui.invenSlotTemplate
  local xSize, ySize = self._defaultXGap - 3, self._defaultYGap - 3
  local startX, startY = 10, 5
  local columnMax = self._invenSlotColumnMax
  local rowMax = self._invenSlotRowMax
  self._ui.slot_inven = Array.new()
  local slot = self._ui.slot_inven
  for ii = 1, self._invenSlotCount do
    slotBG[ii] = UI.cloneControl(slotTemplate, self._ui.stc_invenBG, "InventoryInfo_InvenSlotBG_" .. ii)
    slotBG[ii]:SetPosX(startX + (ii - 1) % columnMax * xSize)
    slotBG[ii]:SetPosY(startY + math.floor((ii - 1) / columnMax) * ySize)
    slot[ii] = {}
    SlotItem.new(slot[ii], "InvenSlot_" .. ii, ii, slotBG[ii], self._configForInven)
    slot[ii]:createChild()
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "InputRSClick_InventoryInfo_OpenCraftNote(" .. ii .. ", false)")
    slotBG[ii]:SetEnableDragAndDrop(true)
    slot[ii].icon:SetIgnore(true)
    slotBG[ii]:addInputEvent("Mouse_PressMove", "InputDrag_InventoryInfo_invenDrag(" .. ii .. ")")
    slotBG[ii]:addInputEvent("Mouse_Out", "InputMOut_InventoryInfo_invenHideTooltip(" .. ii .. ")")
    slotBG[ii]:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_invenShowFloatingTooltip(" .. ii .. ")")
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "Input_InventoryInfo_ItemDelete(" .. ii .. ")")
    if false == _ContentsGroup_RenewUI then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadUp, "Input_InventoryInfo_CustomItemAction(" .. ii .. ")")
    end
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_InvenSlot(" .. ii .. ")")
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowTooltip(" .. ii .. ", true)")
    end
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "Input_InventoryInfo_ItemLock(" .. ii .. ")")
    UIScroll.InputEventByControl(slotBG[ii], "InputScroll_InventoryInfo_Inventory")
    UIScroll.InputEventByControl(slot[ii].icon, "InputScroll_InventoryInfo_Inventory")
    slot[ii].icon:SetPosX(1)
    slot[ii].icon:SetPosY(1)
    slot[ii].icon:SetSize(42, 42)
    slot[ii].border:SetSize(44, 44)
    slot[ii].count:ComputePos()
    slot[ii].stc_multipleSelect = UI.getChildControl(slotBG[ii], "Static_MultipleSelect")
    slotBG[ii]:SetChildOrder(slot[ii].icon:GetKey(), slot[ii].stc_multipleSelect:GetKey())
    self._ui.stc_lockedSlots[ii] = UI.createAndCopyBasePropertyControl(_panel, "Static_LockedSlot", slotBG[ii], "Static_LockedSlot_" .. ii)
    if _ContentsGroup_UsePadSnapping or ToClient_IsDevelopment() then
      if ii <= columnMax then
        slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_InventoryInfo_Inventory(true)")
      elseif ii > columnMax * (rowMax - 1) then
        slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_InventoryInfo_Inventory(false)")
      end
    end
    if true == _ContentsGroup_FamilyInventory then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Y, "InputMRUp_InventoryInfo_MoveItemToFamilyOrEnchantInventory( PaGlobal_Inventory_All_ForConsole._ui.slot_inven[" .. ii .. "].slotNo )")
    end
  end
  slotTemplate:SetShow(false)
  self._ui.scroll_inven = UI.getChildControl(self._ui.stc_invenBG, "Scroll_1")
  UIScroll.InputEvent(self._ui.scroll_inven, "InputScroll_InventoryInfo_Inventory")
  UIScroll.InputEventByControl(self._ui.stc_invenBG, "InputScroll_InventoryInfo_Inventory")
  self._ui.btn_invenPuzzle = UI.getChildControl(self._ui.stc_invenGroup, "Button_Puzzle")
  self._ui.btn_invenPuzzle:SetShow(false)
  self._ui.stc_plusSlot = UI.getChildControl(self._ui.stc_invenBG, "Static_OnlyPlus")
end
function PaGlobal_Inventory_All_ForConsole:initFamilyInventory()
  self._ui.txt_keyGuideFamilyInvenSort = UI.getChildControl(self._ui.stc_familyInvenSortArea, "StaticText_Sort_ConsoleUI")
  self._ui.btn_familySortOption = UI.getChildControl(self._ui.stc_familyInvenSortArea, "Button_Sort_Set")
  self._ui.chk_familySort = UI.getChildControl(self._ui.stc_familyInvenSortArea, "CheckButton_ItemSort")
  self._ui.stc_FamilyinvenSlotArea = UI.getChildControl(self._ui.stc_familyInvenGroup, "Static_FamilyInvenBG")
  self._ui.scroll_familyInven = UI.getChildControl(self._ui.stc_FamilyinvenSlotArea, "Scroll_FamilyInventory")
  local familyInvenProgressBG = UI.getChildControl(self._ui.stc_familyInvenGroup, "Static_FamilyWeightProgressBG")
  self._ui.progress2_familyInvenWeight = UI.getChildControl(familyInvenProgressBG, "Progress2_ServantWeight")
  self._ui.txt_familyInvenWeight = UI.getChildControl(familyInvenProgressBG, "StaticText_WeightValue")
  self._ui.txt_familyInvenCapacity = UI.getChildControl(familyInvenProgressBG, "StaticText_SlotCount")
  self._ui.stc_familyInvenWeightIcon = UI.getChildControl(familyInvenProgressBG, "Static_WeightIcon")
  self._ui.stc_familyInvenSlotBG = {}
  self._newItemAtSlot = {}
  self._isSlotEmpty = false
  self._ui.invenSlotTemplate = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotTemplate")
  self._ui.stc_invenBG = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotArea_10")
  self._ui.slot_familyInven = Array.new()
  local slotBG = self._ui.stc_familyInvenSlotBG
  local slotTemplate = self._ui.invenSlotTemplate
  local xSize, ySize = self._defaultXGap - 3, self._defaultYGap - 3
  local startX, startY = 10, 5
  local columnMax = self._invenSlotColumnMax
  local slot = self._ui.slot_familyInven
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    isTranslation = true
  }
  self._familyinvenShowSlotCount = math.floor(self._ui.stc_FamilyinvenSlotArea:GetSizeY() / self._defaultYGap) * columnMax
  local lastRowSlot = self._familyinvenShowSlotCount - self._invenSlotColumnMax
  for ii = 0, self._familyinvenShowSlotCount - 1 do
    slotBG[ii] = UI.cloneControl(slotTemplate, self._ui.stc_FamilyinvenSlotArea, "InventoryInfo_FamilyInvenSlotBG_" .. ii)
    slotBG[ii]:SetPosX(startX + ii % columnMax * xSize)
    slotBG[ii]:SetPosY(startY + math.floor(ii / columnMax) * ySize)
    slotBG[ii]:SetShow(true)
    slot[ii] = {}
    SlotItem.new(slot[ii], "FamilyInvenSlot_" .. ii, ii, slotBG[ii], slotConfig)
    slot[ii]:createChild()
    slot[ii].stc_multipleSelect = UI.getChildControl(slotBG[ii], "Static_MultipleSelect")
    slot[ii].stc_multipleSelect:SetShow(false)
    slot[ii].icon:SetIgnore(true)
    slot[ii].icon:SetPosX(1)
    slot[ii].icon:SetPosY(1)
    slot[ii].icon:SetSize(42, 42)
    slot[ii].border:SetSize(44, 44)
    slot[ii].count:ComputePos()
    self._ui.stc_lockedFamilyInvenSlots[ii] = UI.createAndCopyBasePropertyControl(_panel, "Static_LockedSlot", slotBG[ii], "Static_LockedSlot_" .. ii)
    slotBG[ii]:SetEnableDragAndDrop(true)
    slotBG[ii]:addInputEvent("Mouse_PressMove", "InputDrag_InventoryInfo_FamilyInvenDrag(" .. ii .. ")")
    slotBG[ii]:addInputEvent("Mouse_On", "Input_InventoryInfo_FamilyInvenFloatingTooltip(" .. ii .. ", true)")
    slotBG[ii]:addInputEvent("Mouse_Out", "Input_InventoryInfo_FamilyInvenFloatingTooltip(" .. ii .. ", false)")
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowFamilyInvenTooltip(" .. ii .. ", true)")
    else
      Panel_Tooltip_Item_SetPosition(ii, slot[ii], "FamilyInventory")
    end
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "InputRSClick_InventoryInfo_OpenCraftNote(" .. ii .. ", true)")
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_FamilyInvenSlot_UseItem(" .. ii .. ")")
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMRUp_InventoryInfo_FamilyInvenSlot_MoveItemFromFamilyInventory(" .. ii .. ")")
    UIScroll.InputEventByControl(slotBG[ii], "InputScroll_InventoryInfo_FamilyInventory")
  end
  UIScroll.InputEvent(self._ui.scroll_familyInven, "InputScroll_InventoryInfo_FamilyInventory")
  UIScroll.InputEventByControl(self._ui.stc_FamilyinvenSlotArea, "InputScroll_InventoryInfo_FamilyInventory")
end
function PaGlobal_Inventory_All_ForConsole:initEnchantInventory()
  self._ui.txt_keyGuideEnchantInvenSort = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "StaticText_Sort_ConsoleUI")
  self._ui.btn_enchantSortOption = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "Button_Sort_Set")
  self._ui.chk_enchantSort = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "CheckButton_ItemSort")
  self._ui.btn_valksView = UI.getChildControl(self._ui.stc_enchantInvenSortArea, "Button_ValksView")
  self._ui.stc_enchantInvenSlotArea = UI.getChildControl(self._ui.stc_enchantInvenGroup, "Static_EnchantInvenBG")
  self._ui.scroll_enchantInven = UI.getChildControl(self._ui.stc_enchantInvenSlotArea, "Scroll_EnchantInventory")
  local enchantInvenProgressBG = UI.getChildControl(self._ui.stc_enchantInvenGroup, "Static_EnchantWeightProgressBG")
  self._ui.txt_enchantInvenCapacity = UI.getChildControl(enchantInvenProgressBG, "StaticText_SlotCount")
  self._ui.stc_enchantInvenSlotBG = {}
  self._newItemAtSlot = {}
  self._isSlotEmpty = false
  self._ui.invenSlotTemplate = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotTemplate")
  self._ui.stc_invenBG = UI.getChildControl(self._ui.stc_invenGroup, "Static_ItemSlotArea_10")
  self._ui.slot_enchantInven = Array.new()
  local slotBG = self._ui.stc_enchantInvenSlotBG
  local slotTemplate = self._ui.invenSlotTemplate
  local xSize, ySize = self._defaultXGap - 3, self._defaultYGap - 3
  local startX, startY = 10, 5
  local columnMax = self._invenSlotColumnMax
  local slot = self._ui.slot_enchantInven
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    isTranslation = true
  }
  self._enchantInvenShowSlotCount = math.floor(self._ui.stc_enchantInvenSlotArea:GetSizeY() / self._defaultYGap) * columnMax
  local lastRowSlot = self._enchantInvenShowSlotCount - self._invenSlotColumnMax
  for ii = 0, self._enchantInvenShowSlotCount - 1 do
    slotBG[ii] = UI.cloneControl(slotTemplate, self._ui.stc_enchantInvenSlotArea, "InventoryInfo_EnchantInvenSlotBG_" .. ii)
    slotBG[ii]:SetPosX(startX + ii % columnMax * xSize)
    slotBG[ii]:SetPosY(startY + math.floor(ii / columnMax) * ySize)
    slotBG[ii]:SetShow(true)
    slot[ii] = {}
    SlotItem.new(slot[ii], "EnchantInvenSlot_" .. ii, ii, slotBG[ii], slotConfig)
    slot[ii]:createChild()
    slot[ii].stc_multipleSelect = UI.getChildControl(slotBG[ii], "Static_MultipleSelect")
    slot[ii].stc_multipleSelect:SetShow(false)
    slot[ii].icon:SetIgnore(true)
    slot[ii].icon:SetPosX(1)
    slot[ii].icon:SetPosY(1)
    slot[ii].icon:SetSize(42, 42)
    slot[ii].border:SetSize(44, 44)
    slot[ii].count:ComputePos()
    slotBG[ii]:SetEnableDragAndDrop(true)
    slotBG[ii]:addInputEvent("Mouse_PressMove", "InputDrag_InventoryInfo_EnchantInvenDrag(" .. ii .. ")")
    slotBG[ii]:addInputEvent("Mouse_On", "Input_InventoryInfo_EnchantInvenFloatingTooltip(" .. ii .. ", true)")
    slotBG[ii]:addInputEvent("Mouse_Out", "Input_InventoryInfo_EnchantInvenFloatingTooltip(" .. ii .. ", false)")
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_InventoryInfo_ShowEnchantInvenTooltip(" .. ii .. ", true)")
    else
      Panel_Tooltip_Item_SetPosition(ii, slot[ii], "EnchantInventory")
    end
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RSClick, "InputRSClick_InventoryInfo_OpenCraftNote(" .. ii .. ", true)")
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_EnchantInvenSlot_UseItem(" .. ii .. ")")
    slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMRUp_InventoryInfo_EnchantInvenSlot_MoveItemFromEnchantInventory(" .. ii .. ")")
    UIScroll.InputEventByControl(slotBG[ii], "InputScroll_InventoryInfo_EnchantInventory")
  end
  UIScroll.InputEvent(self._ui.scroll_enchantInven, "InputScroll_InventoryInfo_EnchantInventory")
  UIScroll.InputEventByControl(self._ui.stc_enchantInvenSlotArea, "InputScroll_InventoryInfo_EnchantInventory")
  self._ui.btn_valksView:addInputEvent("Mouse_LUp", "PaGlobalFunc_ValksList_All_Open()")
  if self._ui.btn_valksView:IsLimitText() == true then
    self._ui.btn_valksView:addInputEvent("Mouse_On", "HandleEvent_ValksList_ShowTextToolTip(true)")
    self._ui.btn_valksView:addInputEvent("Mouse_Out", "HandleEvent_ValksList_ShowTextToolTip(false)")
  end
end
function PaGlobal_Inventory_All_ForConsole:registEventHandler()
  for ii = 1, #self._ui.rdo_tabButtons do
    self._ui.rdo_tabButtons[ii]:addInputEvent("Mouse_LUp", "PaGlobalFunc_InventoryInfo_SetUpperTabTo(" .. ii .. ")")
  end
  _panel:registerPadEvent(__eConsoleUIPadEvent_LB, "Toggle_InventoryTab_forPadEventFunc(-1)")
  _panel:registerPadEvent(__eConsoleUIPadEvent_RB, "Toggle_InventoryTab_forPadEventFunc(1)")
  if _ContentsGroup_EnchantRemaster == true then
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobal_InventoryShowToggle()")
  else
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobal_FamilyInvnetoryShowToggle()")
  end
  if ToClient_isShowBlackSpiritInventory() == true then
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobalFunc_NewbieInventory_Open()")
  end
  self._ui.stc_xBoxKey_LB:addInputEvent("Mouse_LUp", "Input_InventoryInfo_SetUpperTabLeft()")
  self._ui.stc_xBoxKey_RB:addInputEvent("Mouse_LUp", "Input_InventoryInfo_SetUpperTabRight()")
  self._ui.btn_sortOption:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleSortOption(false,false)")
  self._ui.btn_sortOption:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_UpdateSortAreaKeyGuide()")
  self._ui.chk_sort:addInputEvent("Mouse_On", "InputMOn_InventoryInfo_UpdateSortAreaKeyGuide()")
  _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_InventoryInfo_ToggleCheckSort(false,false)")
  self._ui.btn_familySortOption:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleSortOption(true,false)")
  self._ui.btn_enchantSortOption:addInputEvent("Mouse_LUp", "Input_InventoryInfo_ToggleSortOption(false,true)")
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    self._ui.chk_detailInfo:addInputEvent("Mouse_LUp", "InputLUp_InventoryInfo_ClickDetailInfo()")
    self._ui.chk_detailInfo:addInputEvent("Mouse_On", "InputOnOut_InventoryInfo_ClickDetailInfo(true)")
    self._ui.chk_detailInfo:addInputEvent("Mouse_Out", "InputOnOut_InventoryInfo_ClickDetailInfo(false)")
    self._ui.btn_notationSetting:addInputEvent("Mouse_LUp", "InputLUp_InventoryInfo_NotationSetting()")
    self._ui.btn_notationSetting:addInputEvent("Mouse_On", "InputOnOut_InventoryInfo_NotationSetting(true)")
    self._ui.btn_notationSetting:addInputEvent("Mouse_Out", "InputOnOut_InventoryInfo_NotationSetting(false)")
    self._ui.btn_notationSetting:setButtonShortcutsWithEvent("InputLUp_InventoryInfo_NotationSetting()", "PANEL_NOTATION_ABILITY_TITLE")
  end
end
function PaGlobal_Inventory_All_ForConsole:registMessageHandler()
  _panel:RegisterShowEventFunc(true, "PaGlobalFunc_InventoryInfo_ShowAni()")
  _panel:RegisterShowEventFunc(false, "PaGlobalFunc_InventoryInfo_HideAni()")
  _panel:RegisterUpdateFunc("PaGlobalFunc_Window_InventoryInfo_PerFrameUpdate")
  registerEvent("FromClient_PadSnapChangePanel", "FromClient_InventoryInfo_PadSnapChangePanel")
  registerEvent("FromClient_PadSnapChangeTarget", "FromClient_InventoryInfo_PadSnapChangeTarget")
  registerEvent("onScreenResize", "FromClient_InventoryInfo_OnScreenResize")
  registerEvent("EventEquipmentUpdate", "FromClient_InventoryInfo_EquipmentHaveChanged")
  registerEvent("EventEquipItem", "FromClient_InventoryInfo_EventEquipItem")
  registerEvent("EventPCEquipSetShow", "FromClient_InventoryInfo_EventPCEquipSetShow")
  registerEvent("FromClient_WeightChanged", "FromClient_InventoryInfo_WeightChanged")
  registerEvent("FromClient_InventoryUpdate", "FromClient_InventoryInfo_updateInvenSlot")
  registerEvent("EventInventorySetShow", "FromClient_InventoryInfo_SetShow")
  registerEvent("EventInventorySetShowWithFilter", "FromClient_InventoryInfo_SetShowWithFilter")
  registerEvent("EventUnEquipItemToInventory", "FromClient_InventoryInfo_UnequipItem")
  registerEvent("FromClient_UseItemAskFromOtherPlayer", "FromClient_InventoryInfo_UseItemAskFromOtherPlayer")
  registerEvent("FromClient_ResponseMailGetItem", "FromClient_InventoryInfo_ResponseMailGetItem")
  registerEvent("FromClient_NotifyCompleteBuyProduct", "FromClient_InventoryInfo_NotifyCompleteBuyProduct")
  registerEvent("FromClient_FindExchangeItemNPC", "FromClient_InventoryInfo_FindExchangeItemNPC")
  registerEvent("FromClient_InventoryUpdatebyAddItem", "FromClient_InventoryInfo_updateInvenSlot")
  registerEvent("FromClient_UpdateInventoryBag", "FromClient_InventoryInfo_updateInvenSlot")
  registerEvent("FromClient_ServantInventoryOpenWithInventory", "FromClient_InventoryInfo_OpenServantInven")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_InventoryInfo_ServantEquipChanged")
  registerEvent("FromClient_UpdateCannonBallCount", "FromClient_InventoryInfo_ServantEquipChanged")
  registerEvent("EventSelfServantUpdate", "PaGlobalFunc_InventoryInfo_UpdateServantTab")
  registerEvent("EventServantEquipmentUpdate", "FromClient_InventoryInfo_ServantEquipChanged")
  registerEvent("EventServantEquipItem", "FromClient_InventoryInfo_ServantEquipOn")
  registerEvent("FromClient_UpdateTolerance", "FromClient_InventoryInfo_ResistChanged")
  registerEvent("FromClient_UpdateSelfPlayerStatPoint", "FromClient_InventoryInfo_PotentialChanged")
  registerEvent("FromClientFitnessUp", "FromClient_InventoryInfo_FitnessChanged")
  if _ContentsGroup_ItemBackEndLoading == true then
    registerEvent("FromClient_ItemBackEndLoadComplete", "FromClient_InventoryInfo_BackEndLoadComplete")
  end
  registerEvent("FromClient_ShowUseMapaeItemGuideMessageBox", "FromClient_InventoryInfo_ShowUseMapaeItemGuideMessageBox")
end
function FromClient_InventoryInfo_ShowUseMapaeItemGuideMessageBox()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MAPAE_USE"),
    functionYes = MessageBox_Empty_function,
    functionCancel = nil,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_InventoryInfo_BackEndLoadComplete(loadedItemKey, loadedEnchantLevel)
  if _ContentsGroup_ItemBackEndLoading == false then
    return
  end
  if _panel:GetShow() == false then
    return
  end
  for idx = 1, #backendInfoTable_Inven._backendUITable do
    if backendInfoTable_Inven._backendUITable[idx] ~= nil then
      local infoTable = backendInfoTable_Inven._backendUITable[idx]
      if loadedItemKey == infoTable._itemKey then
        PaGlobal_Inventory_All_ForConsole:refreshInventoryByBackEnd(ignorePanelVisibility, loadedItemKey)
        table.remove(backendInfoTable_Inven._backendUITable, idx)
      end
    end
  end
end
function FromClient_InventoryInfo_ResponseMailGetItem(itemKey, itemCount_s64, immediateItem, isRelay)
  if nil == itemKey or nil == immediateItem then
    UI.ASSERT_NAME(false, "itemKey, immediateItem\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\234\185\128\236\157\152\236\167\132")
  end
  if 1 == itemKey or 0 == itemKey then
    return
  end
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemESSW then
    return
  end
  if true == immediateItem then
    return
  end
  if false == itemESSW:get():isCash() then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  if true == self._ui.stc_important:GetShow() then
    return
  end
  self._ui.stc_important:SetShow(true)
end
function FromClient_InventoryInfo_NotifyCompleteBuyProduct()
  local self = PaGlobal_Inventory_All_ForConsole
  if true == self._ui.stc_important:GetShow() then
    return
  end
  self._ui.stc_important:SetShow(true)
end
function PaGlobalFunc_InventoryInfo_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_InventoryInfo_Open(openType, isFold, servantType, ignoreSnap)
  PaGlobal_Inventory_All_ForConsole:open(openType, isFold, servantType, ignoreSnap)
end
function PaGlobal_Inventory_All_ForConsole:open(openType, isFold, servantType, ignoreSnap)
  if PaGlobalFunc_BetterEquipment_Close ~= nil then
    PaGlobalFunc_BetterEquipment_Close()
  end
  if servantType == nil then
    self:setServantTabPictogram(0)
  else
    self:setServantTabPictogram(servantType)
  end
  self._ui.stc_xBoxKey_LB:SetShow(not PaGlobalFunc_CampWarehouse_All_GetShow())
  self._ui.stc_xBoxKey_RB:SetShow(not PaGlobalFunc_CampWarehouse_All_GetShow())
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.ColsoleInventory, _panel, self._ui.btn_sortOption, self._ui.chk_sort, self._ui.btn_categoryView, self._ui.btn_slotView, "Static_SortComponent_Inventory")
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ColsoleInventory)
  _panel:SetShow(true, false)
  _AudioPostEvent_SystemUiForXBOX(1, 30)
  if nil == isFold then
    self._isFold = false
  else
    self._isFold = isFold
  end
  if _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Close()
  end
  if nil ~= Panel_Window_PreOrder and false == Panel_Window_PreOrder:GetShow() then
    PaGlobalFunc_PreOrder_Open(_panel)
    if true == _ContentsGroup_Season_EquipmentUpgrade then
      local gap = 10
      self._ui.stc_season_Upgrade:SetPosY(Panel_Window_PreOrder:GetSizeY() + gap)
      self._ui.stc_season_UpgradeBg:SetPosY(Panel_Window_PreOrder:GetSizeY() + gap + 11)
    end
  end
  if Defines.UIMode.eUIMode_Default == GetUIMode() then
    if ToClient_isConsole() == true and true == PaGlobalFunc_Quest_All_GetShow() then
      PaGlobalFunc_Quest_All_Close()
    else
    end
  elseif Defines.UIMode.eUIMode_WorldMap == GetUIMode() then
    self:close()
  end
  if nil ~= openType then
    self._ui.rdo_tabButtons[openType]:SetCheck(true)
    self:setTabTo(openType)
    if true == _ContentsGroup_Season_EquipmentUpgrade then
      if UPPER_TAB_TYPE.EQUIPMENT_TAB == openType then
        PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(true, true)
      else
        PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(false, false)
      end
    end
  else
    self._ui.rdo_tabButtons[UPPER_TAB_TYPE.EQUIPMENT_TAB]:SetCheck(true)
    self:setTabTo(UPPER_TAB_TYPE.EQUIPMENT_TAB)
    PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(false, false)
  end
  local snappedControl = ToClient_getSnappedControl()
  if nil == self._filterFunc and nil == self._rClickFunc or nil ~= snappedControl and false == _snappedOnThisPanel then
    self._ui.stc_bottomBG_setFunctor:SetShow(false)
    self._ui.stc_bottomBG:SetShow(true)
  end
  self:initMultipleSelect()
  self:updateInventory()
  self:updateWeight()
  self._monitorItemCooltime = true
  PaGlobal_Inventory_All_ForConsole:FoldEquipWindow(isFold)
  if ignoreSnap == nil or ignoreSnap ~= true then
    self:forceSetSnapToInventory()
  end
  PaGlobal_Inventory_All_ForConsole._isCashProductBlockOpenChcked = false
  PaGlobal_Inventory_All_ForConsole_cashProductRestoreBgOpen()
end
function PaGlobal_Inventory_All_ForConsole:forceSetSnapToInventory()
  if _panel == nil then
    return
  end
  if _panel:GetShow() == false then
    return
  end
  for ii = 1, self._invenSlotCount do
    local slotBG = self._ui.stc_invenSlotBG[ii]
    if slotBG ~= nil then
      ToClient_padSnapChangeToTarget(slotBG)
      return
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:FoldEquipWindow(isFold)
  if isFold == true then
    self._ui.stc_equipGroup:SetShow(false)
    self._ui.stc_servantGroup:SetShow(false)
    self._ui.stc_invenGroup:SetPosY(self._ui.stc_equipGroup:GetPosY() + self._ui.stc_invenSortArea:GetSizeY())
    Panel_Window_Inventory:SetSize(Panel_Window_Inventory:GetSizeX(), self._originPanelSizeY - self._ui.stc_equipGroup:GetSizeY())
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._originBgSizeY - self._ui.stc_equipGroup:GetSizeY())
  else
    self._ui.stc_invenGroup:SetPosY(self._ui.stc_equipGroup:GetPosY() + self._ui.stc_equipGroup:GetSizeY() + self._ui.stc_invenSortArea:GetSizeY() + 1)
    Panel_Window_Inventory:SetSize(Panel_Window_Inventory:GetSizeX(), self._originPanelSizeY)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._originBgSizeY)
  end
end
function PaGlobalFunc_InventoryInfo_Close()
  PaGlobal_Inventory_All_ForConsole:close()
end
function PaGlobal_Inventory_All_ForConsole:close()
  if _panel:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(1, 31)
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  end
  TooltipSimple_Hide()
  if nil ~= self._otherWindowOpenFunc then
    local callFunc = self._otherWindowOpenFunc
    self._otherWindowOpenFunc = nil
    callFunc()
  end
  if nil ~= Panel_EnchantExtraction_Renew and true == Panel_EnchantExtraction_Renew:GetShow() then
    Panel_EnchantExtraction_Renew_Close()
  end
  if nil ~= PaGlobalFunc_CampWarehouse_All_GetShow and true == PaGlobalFunc_CampWarehouse_All_GetShow() and nil ~= PaGlobalFunc_CampWarehouse_All_Close then
    PaGlobalFunc_CampWarehouse_All_Close()
  end
  if PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow ~= nil and PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
    PaGlobalFunc_MonsterBuffZoneItemRepair_Close()
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.ColsoleInventory) == true or PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.ColsoleFamilyInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    PaGlobalFunc_NotationAbility_CloseIfShow()
  end
  Inventory_SetFunctor(nil, nil, nil, nil, nil)
  _panel:SetShow(false, false)
  Panel_Tooltip_Item_hideTooltip()
  if Defines.UIMode.eUIMode_Default == GetUIMode() then
    if ToClient_isConsole() == true and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      if true == PaGlobalFunc_Quest_All_GetShow() then
        FGlobal_Panel_Radar_Show(true, false)
        PaGlobalFunc_Panel_TimeBar_Show(true, false)
        FGlobal_QuestWidget_Open()
      end
    elseif false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      FGlobal_Panel_Radar_Show(true, false)
      PaGlobalFunc_Panel_TimeBar_Show(true, false)
      FGlobal_QuestWidget_Open()
    end
  end
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
  PaGlobalFunc_MultiButtonPopup_Close()
  if true == _ContentsGroup_RenewUI_Tutorial then
    PaGlobal_TutorialManager:handleClosedInventory()
  end
  if nil ~= Panel_Window_PreOrder and true == Panel_Window_PreOrder:GetShow() then
    PaGlobalFunc_PreOrder_Close(_panel)
  end
  if nil ~= Panel_Window_Inventory_Detail and true == Panel_Window_Inventory_Detail:GetShow() then
    PaGlobal_InventoryEquip_Detail_Renew_Close()
  end
  if _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  if _ContentsGroup_CombineBag == true and PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if _ContentsGroup_NewUI_Dye_All == true and Panel_Window_Palette_All ~= nil and Panel_Window_Palette_All:GetShow() == true then
    PaGlobal_Palette_All_Close()
  end
  if _ContentsGroup_StaticSlot == true then
    if Panel_Window_NewbieInventory_StaticSlot_All ~= nil and Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
      PaGlobalFunc_NewbieInventory_Close()
    end
  elseif Panel_Window_NewbieInventory_All ~= nil and Panel_Window_NewbieInventory_All:GetShow() == true then
    PaGlobalFunc_NewbieInventory_Close()
  end
  if PaGlobalFunc_ValksList_All_IsShow ~= nil and PaGlobalFunc_ValksList_All_IsShow() == true then
    PaGlobalFunc_ValksList_All_Close()
  end
  self._weightDesignatorTarget = getScreenSizeY()
  self._weightDesignatorIsAnimating = true
  self._monitorItemCooltime = false
  self._slotRingIndex = 0
  self._slotEarringIndex = 0
  self._isShowFamilyInven = false
  self._familyInvenStartSlotIndex = 0
  self._isShowEnchantInven = false
  self._enchantInvenStartSlotIndex = 0
  if _ContentsGroup_ItemBackEndLoading == true then
    backendInfoTable_Inven._backendUITable = Array.new()
  end
end
function PaGlobalFunc_Inventory_All_CloseSideUI(exceptFunctionType)
  if exceptFunctionType == nil then
    return
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.AlchemyFigureHead and PaGlobal_AlchemyFigureHead_All_IsShow() == true then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.AlchemyStone then
    if _ContentsGroup_AlchemyStoneRenewal == true then
      if PaGlobalFunc_AlchemyStone_Renewal_All_IsShow() == true then
        PaGlobalFunc_AlchemyStone_Renewal_All_Close()
      end
    elseif _ContentsGroup_NewUI_AlchemyStone_All == true and PaGlobalFunc_AlchemyStone_All_IsShow() == true then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.Manufacture and PaGlobalFunc_Manufacture_All_IsShow() == true and (_ContentsGroup_UsePadSnapping == false or Panel_Npc_Dialog_All:GetShow() == false) then
    PaGlobalFunc_Manufacture_All_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.Palette then
    if _ContentsGroup_NewUI_Dye_All == true then
      if Panel_Window_Palette_All ~= nil and PaGlobal_Palette_All_IsShow() == true then
        PaGlobal_Palette_All_Close()
      end
    elseif _ContentsGroup_NewUI_Dye_Palette_All == true then
      if Panel_Window_Dye_Palette_All ~= nil and PaGlobal_Dye_Palette_All_IsShow() == true then
        PaGlobal_Dye_Palette_All_Close()
      end
    elseif Panel_DyePalette ~= nil and FGlobal_DyePalette_IsShow() == true then
      FGlobal_DyePalette_Close()
    end
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.LightStoneBag and _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.FamilyInventory and _ContentsGroup_FamilyInventory == true and PaGlobal_FamilyInvnetory_IsShow() == true then
    PaGlobal_FamilyInvnetory_Close(true)
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.JewelPreset and _ContentsGroup_JewelPreset == true and PaGlobalFunc_JewelPreset_IsShow() == true then
    PaGlobalFunc_JewelPreset_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.RepairDekia and _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true and PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
    PaGlobalFunc_MonsterBuffZoneItemRepair_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.CombineBag and PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
end
function PaGlobalFunc_InventoryInfo_ShowAni()
  _AudioPostEvent_SystemUiForXBOX(1, 15)
  local self = PaGlobal_Inventory_All_ForConsole
  self._showAniIsPlaying = true
  _panel:ResetVertexAni()
  local aniInfo1 = _panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(getScreenSizeX(), 0)
  aniInfo1:SetEndPosition(getScreenSizeX() - _panel:GetSizeX(), 0)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(false)
  aniInfo1:SetDisableWhileAni(true)
  aniInfo1:SetIgnoreUpdateSnapping(true)
  _panel:ResetVertexAni()
  _panel:SetVertexAniRun("Show_Color", true)
  _panel:SetVertexAniRun("Show_Ani_Scale", true)
end
function PaGlobalFunc_InventoryInfo_HideAni()
  _AudioPostEvent_SystemUiForXBOX(1, 16)
  _panel:ResetVertexAni()
  local aniInfo1 = _panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartPosition(_panel:GetPosX(), 0)
  aniInfo1:SetEndPosition(_panel:GetPosX() + 600, 0)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  aniInfo1:SetIgnoreUpdateSnapping(true)
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  end
  TooltipSimple_Hide()
end
function PaGlobal_Inventory_All_ForConsole:updateAllUpperTab()
  self:updateEquipment()
  self:updateCostume()
  self:updateInformation()
  self:updateServant()
end
function PaGlobal_Inventory_All_ForConsole:updateSilverPearlMileage()
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.txt_Silver:SetShow(false)
    self._ui.txt_Pearl:SetShow(false)
    self._ui.txt_Mileage:SetShow(false)
    self._ui.txt_Shell:SetShow(false)
    self._ui.txt_HardCore:SetShow(true)
    local hardCoreCoinValue = Defines.s64_const.s64_0
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_HardCore)
    if nil ~= priceItemWrapper then
      hardCoreCoinValue = priceItemWrapper:get():getCount_s64()
    end
    self._ui.txt_HardCore:SetText(makeDotMoney(hardCoreCoinValue))
    return
  end
  local silver = Defines.s64_const.s64_0
  local pearl = Defines.s64_const.s64_0
  local mileage = Defines.s64_const.s64_0
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, getMoneySlotNo())
  if nil ~= moneyItemWrapper then
    silver = moneyItemWrapper:get():getCount_s64()
  end
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  if nil ~= pearlItemWrapper then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  local mileagelItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
  if nil ~= mileagelItemWrapper then
    mileage = mileagelItemWrapper:get():getCount_s64()
  end
  self._ui.txt_Silver:SetText(makeDotMoney(silver))
  self._ui.txt_Pearl:SetText(makeDotMoney(pearl))
  self._ui.txt_Mileage:SetText(makeDotMoney(mileage))
  if true == _ContentsGroup_Barter then
    shellValue = Defines.s64_const.s64_0
    local shellItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
    if nil ~= shellItemWrapper then
      shellValue = shellItemWrapper:get():getCount_s64()
    end
    self._ui.txt_Shell:SetText(makeDotMoney(shellValue))
    self._ui.txt_Shell:SetShow(true)
  end
  self:updateSilverIcon(self._ui.txt_Silver, silver)
end
function PaGlobal_Inventory_All_ForConsole:updateSilverIcon(control, silver)
  if 100000 <= Int64toInt32(silver) then
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver4.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 30, 30)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver4_Over.dds")
    control:ChangeClickTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver4_Over.dds")
  elseif Int64toInt32(silver) >= 20000 then
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver3.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 30, 30)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver3_Over.dds")
    control:ChangeClickTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver3_Over.dds")
  elseif Int64toInt32(silver) >= 5000 then
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver2.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 30, 30)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver2_Over.dds")
    control:ChangeClickTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver2_Over.dds")
  else
    control:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver1.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 30, 30)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:ChangeOnTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver1_Over.dds")
    control:ChangeClickTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Silver1_Over.dds")
  end
end
function PaGlobal_Inventory_All_ForConsole:updateUpperTab(tab)
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  end
  TooltipSimple_Hide()
  if tab == UPPER_TAB_TYPE.EQUIPMENT_TAB then
    self:updateEquipment()
  elseif tab == UPPER_TAB_TYPE.COSTUME_TAB then
    if true == self._ui.stc_important:GetShow() then
      self._ui.stc_important:SetShow(false)
    end
    self:updateCostume()
  elseif tab == UPPER_TAB_TYPE.INFORMATION_TAB then
    self:updateInformation()
  elseif tab == UPPER_TAB_TYPE.SERVANT_TAB then
    self:updateServant()
  elseif tab == UPPER_TAB_TYPE.LIFEEEQUIP_TAB then
    self:updateLifeEquipment()
  end
end
function PaGlobal_Inventory_All_ForConsole:updateEquipment(isMustUpdate)
  if (nil == isMustUpdate or false == isMustUpdate) and (not _isInitialized or not _panel:GetShow()) then
    return
  end
  self._extendedSlotArray = {}
  for ii = 1, #_costumeSlotNo do
    local slotIndex = _costumeSlotNo[ii]
    local itemWrapper = ToClient_getEquipmentItem(slotIndex)
    if nil ~= itemWrapper then
      self:extendedSlotInfo(itemWrapper, slotIndex)
    end
  end
  for ii = 1, #_equipSlotNo do
    local slot = self._ui.slot_equips[ii]
    local equipSlotNo = _equipSlotNo[ii]
    local itemWrapper = ToClient_getEquipmentItem(equipSlotNo)
    if nil ~= slot.upgradeEffect then
      slot.icon:EraseEffect(slot.upgradeEffect)
    end
    if nil ~= itemWrapper then
      self:extendedSlotInfo(itemWrapper, equipSlotNo)
      slot:setItem(itemWrapper, equipSlotNo, true)
      slot.pictogram:SetShow(false)
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(false)
      slot.enchantText:SetMonoTone(false)
      if true == _ContentsGroup_Season_EquipmentUpgrade then
        local panelShow = PaGlobal_SeasonEquipment_Upgrade_GetShow()
        if true == panelShow then
          if true == PaGlobal_InventoryEquip_ShowSeasonUpgradePossibleEffect(itemWrapper) then
            slot.icon:EraseAllEffect()
            slot.upgradeEffect = slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
          else
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
          end
        end
      end
      if _ContentsGroup_ItemSkillOption == true and slot.chk_toggleButton ~= nil then
        local itemSSW = itemWrapper:getStaticStatus()
        local contentsEventType = itemSSW:get():getContentsEventType()
        local isShow = contentsEventType == __eContentsType_ItemSkillOption
        if isShow == true and __eEquipSlotNoAwakenWeapon == equipSlotNo and __eClassType_ShyWaman == getSelfPlayer():getClassType() then
          isShow = false
        end
        slot.chk_toggleButton:SetShow(isShow)
        local isSet = ToClient_isSetUniqueEquipEffectSlotFlag(equipSlotNo)
        slot.chk_toggleButton:SetCheck(isSet == true)
      end
    else
      slot:clearItem()
      slot.pictogram:SetShow(true)
      if slot.chk_toggleButton ~= nil then
        slot.chk_toggleButton:SetShow(false)
      end
    end
  end
  for childSlot, parentSlot in pairs(self._extendedSlotArray) do
    local itemWrapper = ToClient_getEquipmentItem(parentSlot)
    local index = self:getIndexFromEquipSlotNo(childSlot)
    if nil ~= index then
      slot = self._ui.slot_equips[index]
      if nil ~= slot then
        self._ui.slot_equips[index].pictogram:SetShow(false)
        self:setItemInfoUseWrapper(slot, itemWrapper, true, true)
      end
    end
  end
  local alchemyStoneItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAlchemyStone)
  if nil == alchemyStoneItemWrapper then
    self._ui.chk_autoActive:SetShow(false)
    self._ui.chk_autoActive:SetCheck(false)
  elseif true == Panel_Dialog_Repair_Function_All:GetShow() then
    self._ui.chk_autoActive:SetShow(false)
  else
    self._ui.chk_autoActive:SetShow(true)
  end
  self:updateAttackStat(false)
  if self:isSnappedOn("Static_EquipSlot_") then
    self:setKeyGuide("Static_EquipSlot_")
  elseif self:isSnappedOn("Button_DetailShow_") then
    self:setKeyGuide("Button_DetailShow_")
  end
  self:checkUnderwearState()
end
function PaGlobal_Inventory_All_ForConsole:updateLifeEquipment(isMustUpdate)
  if (nil == isMustUpdate or false == isMustUpdate) and (not _isInitialized or not _panel:GetShow()) then
    return
  end
  for ii = 1, #_lifeEquipSlotNo do
    local slot = self._ui.slot_lifeEquips[ii]
    local slotIndex = _lifeEquipSlotNo[ii]
    local itemWrapper = ToClient_getEquipmentItem(slotIndex)
    if nil ~= slot.upgradeEffect then
      slot.icon:EraseEffect(slot.upgradeEffect)
    end
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper, slotIndex, true)
      slot.pictogram:SetShow(false)
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(false)
      slot.enchantText:SetMonoTone(false)
      if true == _ContentsGroup_Season_EquipmentUpgrade then
        local panelShow = PaGlobal_SeasonEquipment_Upgrade_GetShow()
        if true == panelShow then
          if true == PaGlobal_InventoryEquip_ShowSeasonUpgradePossibleEffect(itemWrapper) then
            slot.icon:EraseAllEffect()
            slot.upgradeEffect = slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
          else
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
          end
        end
      end
    else
      slot:clearItem()
      slot.pictogram:SetShow(true)
    end
  end
  if self:isSnappedOn("Static_EquipSlot_") then
    self:setKeyGuide("Static_EquipSlot_")
  elseif self:isSnappedOn("Button_DetailShow_") then
    self:setKeyGuide("Button_DetailShow_")
  end
end
function PaGlobal_Inventory_All_ForConsole:updateAttackStat(showWithEffect)
  local currentMyAtk = 0
  local currentMyAwakenAtk = 0
  local currentMyDef = 0
  local doUpdateColor = false
  if _ContentsGroup_RenewCharacterStatusViewMode == true and PaGlobalFunc_NotationAbility_IsLateInitialized ~= nil and PaGlobalFunc_NotationAbility_IsLateInitialized() == true then
    local viewType = ToClient_GetNotationAbilityOption_ViewType()
    self._ui.chk_detailInfo:SetCheck(viewType == __eUINotationAbilityViewType_Total)
    currentMyAtk = PaGlobalFunc_NotationAbility_GetMyAtk()
    currentMyAwakenAtk = PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
    currentMyDef = PaGlobalFunc_NotationAbility_GetMyDef()
    doUpdateColor = true
  else
    ToClient_updateAttackStat()
    currentMyAtk = ToClient_getOffence()
    currentMyAwakenAtk = ToClient_getAwakenOffence()
    currentMyDef = ToClient_getDefence()
  end
  if doUpdateColor == true then
    local fontColor = PaGlobalFunc_NotationAbility_GetFontColor()
    local glowFontColor = PaGlobalFunc_NotationAbility_GetGlowFontColor()
    local iconColor = PaGlobalFunc_NotationAbility_GetIconColor()
    self._ui.txt_attackValue:SetColor(iconColor)
    self._ui.txt_awakenAttackValue:SetColor(iconColor)
    self._ui.txt_defenceValue:SetColor(iconColor)
    self._ui.txt_attackValue:SetFontColor(fontColor)
    self._ui.txt_attackValue:useGlowFont(true, "RealFont_25_Base", glowFontColor)
    self._ui.txt_awakenAttackValue:SetFontColor(fontColor)
    self._ui.txt_awakenAttackValue:useGlowFont(true, "RealFont_25_Base", glowFontColor)
    self._ui.txt_defenceValue:SetFontColor(fontColor)
    self._ui.txt_defenceValue:useGlowFont(true, "RealFont_25_Base", glowFontColor)
  end
  local attackValOld = tonumber(self._ui.txt_attackValue:GetText())
  local awakenAttackValOld = tonumber(self._ui.txt_awakenAttackValue:GetText())
  local defenceAttackValOld = tonumber(self._ui.txt_defenceValue:GetText())
  self._ui.txt_attackValue:SetText(currentMyAtk)
  self._ui.txt_awakenAttackValue:SetText(currentMyAwakenAtk)
  self._ui.txt_defenceValue:SetText(currentMyDef)
  local classType = getSelfPlayer():getClassType()
  local equippedAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  if PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) == true and equippedAwakenWeapon ~= nil then
    self._ui.txt_attackValue:SetSpanSize(-150, 10)
    self._ui.txt_defenceValue:SetSpanSize(100, 10)
    self._ui.txt_awakenAttackValue:SetShow(true)
  else
    self._ui.txt_attackValue:SetSpanSize(-100, 10)
    self._ui.txt_defenceValue:SetSpanSize(50, 10)
    self._ui.txt_awakenAttackValue:SetShow(false)
  end
  if showWithEffect == false then
    return
  end
  if attackValOld ~= currentMyAtk then
    self._ui.txt_attackValue:AddEffect("fUI_SkillButton01", false, 0, 0)
    self._ui.txt_attackValue:AddEffect("UI_SkillButton01", false, 0, 0)
  end
  if awakenAttackValOld ~= currentMyAwakenAtk then
    self._ui.txt_awakenAttackValue:AddEffect("fUI_SkillButton01", false, 0, 0)
    self._ui.txt_awakenAttackValue:AddEffect("UI_SkillButton01", false, 0, 0)
  end
  if defenceAttackValOld ~= currentMyDef then
    self._ui.txt_defenceValue:AddEffect("fUI_SkillButton01", false, 0, 0)
    self._ui.txt_defenceValue:AddEffect("UI_SkillButton01", false, 0, 0)
  end
end
function PaGlobal_Inventory_All_ForConsole:updateUnderwearSlot(slotNo)
  if __eEquipSlotNoAvatarUnderwear ~= slotNo then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:get():isWearingUnderwear() then
    if true == selfPlayer:get():getSwimmingSuitMode() then
      selfPlayer:get():setSwimmingSuitMode(false)
      self._ui.chk_showUnderwear:SetCheck(false)
    end
  elseif true == selfPlayer:get():isWearingSwimmingSuit() and true == selfPlayer:get():getUnderwearModeInhouse() then
    selfPlayer:get():setUnderwearModeInhouse(false)
    self._ui.chk_showUnderwear:SetCheck(false)
  end
end
function PaGlobal_Inventory_All_ForConsole:updateCostume()
  if not _isInitialized or not _panel:GetShow() then
    return
  end
  local rightHandItemWrapper = ToClient_getEquipmentItem(0)
  local primWeaponIsSpecialTool
  if nil ~= rightHandItemWrapper then
    local equipType = rightHandItemWrapper:getStaticStatus():getEquipType()
    primWeaponIsSpecialTool = 43 == equipType or 44 == equipType or 45 == equipType or 47 == equipType
  end
  self._extendedSlotArray = {}
  for ii = 1, #_equipSlotNo do
    local slotIndex = _equipSlotNo[ii]
    local itemWrapper = ToClient_getEquipmentItem(slotIndex)
    if nil ~= itemWrapper then
      self:extendedSlotInfo(itemWrapper, slotIndex)
    end
  end
  for ii = 1, #_costumeSlotNo do
    local slotIndex = _costumeSlotNo[ii]
    local slot = self._ui.slot_costumes[ii]
    local isShow = true
    local itemWrapper = ToClient_getEquipmentItem(slotIndex)
    if nil ~= itemWrapper then
      self:extendedSlotInfo(itemWrapper, slotIndex)
      slot:setItem(itemWrapper, slotIndex, true)
      isShow = ToClient_IsSetAvatarEquipSlotFlag(slotIndex)
      slot.pictogram:SetShow(false)
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(false)
      slot.enchantText:SetMonoTone(false)
      slot.chk_toggleButton:SetShow(true)
    else
      slot:clearItem()
      slot.pictogram:SetShow(true)
      slot.chk_toggleButton:SetShow(false)
    end
    slot.chk_toggleButton:SetCheck(isShow)
  end
  self:checkUnderwearState()
  if primWeaponIsSpecialTool then
    local specialToolWrapper = ToClient_getEquipmentItem(0)
    local index = self:getIndexFromCostumeSlotNo(18)
    self._ui.slot_costumes[index].pictogram:SetShow(false)
    self:setItemInfoUseWrapper(self._ui.slot_costumes[index], specialToolWrapper, true, true)
    index = self:getIndexFromCostumeSlotNo(19)
    self._ui.slot_costumes[index].pictogram:SetShow(false)
    self:setItemInfoUseWrapper(self._ui.slot_costumes[index], specialToolWrapper, true, true)
  end
  for childSlot, parentSlot in pairs(self._extendedSlotArray) do
    local itemWrapper = ToClient_getEquipmentItem(parentSlot)
    local index = self:getIndexFromCostumeSlotNo(childSlot)
    if nil ~= index then
      slot = self._ui.slot_costumes[index]
      if nil ~= slot then
        self._ui.slot_costumes[index].pictogram:SetShow(false)
        self:setItemInfoUseWrapper(slot, itemWrapper, true, true)
      end
    end
  end
  if self:isSnappedOn("InventoryInfo_CostumeSlotBG_") then
    self:setKeyGuide("InventoryInfo_CostumeSlotBG_")
  elseif self:isSnappedOn("Button_DetailShow_") then
    self:setKeyGuide("Button_DetailShow_")
  end
end
function PaGlobal_Inventory_All_ForConsole:checkUnderwearState()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local equippedUnderwearWrapper = ToClient_getEquipmentItem(20)
  if nil ~= equippedUnderwearWrapper then
    self._ui.chk_showUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse() or selfPlayer:get():getSwimmingSuitMode())
    self._ui.chk_showUnderwear:SetEnable(true)
    self._ui.chk_showUnderwear:SetMonoTone(false)
    self._ui.slot_costumes[self:getIndexFromCostumeSlotNo(20)].chk_toggleButton:SetCheck(ToClient_IsSetAvatarEquipSlotFlag(20))
  else
    if selfPlayer:get():getUnderwearModeInhouse() or selfPlayer:get():getSwimmingSuitMode() then
      selfPlayer:get():setUnderwearModeInhouse(false)
      selfPlayer:get():setSwimmingSuitMode(false)
      Toclient_setShowAvatarEquip()
    end
    self._ui.chk_showUnderwear:SetCheck(false)
    self._ui.chk_showUnderwear:SetEnable(false)
    self._ui.chk_showUnderwear:SetMonoTone(true)
    self._ui.slot_costumes[self:getIndexFromCostumeSlotNo(20)].chk_toggleButton:SetCheck(true)
  end
end
function PaGlobal_Inventory_All_ForConsole:updateInformation()
  if not _isInitialized then
    return
  end
  if UPPER_TAB_TYPE.INFORMATION_TAB ~= self._currentUpperTab then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local potentialType = {
    move = 0,
    attack = 1,
    cast = 2
  }
  local potencialValues = {
    [1] = selfPlayer:characterStatPointSpeed(potentialType.attack),
    [2] = selfPlayer:characterStatPointSpeed(potentialType.move),
    [3] = selfPlayer:characterStatPointCritical(),
    [4] = selfPlayer:getCharacterStatPointFishing(),
    [5] = selfPlayer:getCharacterStatPointCollection(),
    [6] = selfPlayer:getCharacterStatPointDropItem()
  }
  local potencialValueLimit = {
    [1] = selfPlayer:characterStatPointLimitedSpeed(potentialType.attack),
    [2] = selfPlayer:characterStatPointLimitedSpeed(potentialType.move),
    [3] = selfPlayer:characterStatPointLimitedCritical(),
    [4] = selfPlayer:getCharacterStatPointLimitedFishing(),
    [5] = selfPlayer:getCharacterStatPointLimitedCollection(),
    [6] = selfPlayer:getCharacterStatPointLimitedDropItem()
  }
  local classType = selfPlayer:getClassType()
  local battleSpeed = NewClassData.newClass_CategoryType[classType]._battleSpeed
  if battleSpeed == CppEnums.BattleSpeedType.SpeedType_Cast then
    potencialValues[1] = selfPlayer:characterStatPointSpeed(potentialType.cast)
    potencialValueLimit[1] = selfPlayer:characterStatPointLimitedSpeed(potentialType.cast)
  end
  for ii = 1, #potencialValues do
    if potencialValues[ii] > potencialValueLimit[ii] then
      potencialValues[ii] = potencialValueLimit[ii]
    end
    if ii < 3 then
      potencialValues[ii] = potencialValues[ii] - 5
    end
    local displayBarTemp = {}
    for jj = 1, 5 do
      displayBarTemp[jj] = UI.getChildControl(self._ui.potencialBars[ii], "Static_Potencial_" .. jj - 1)
      displayBarTemp[jj]:SetShow(jj <= potencialValues[ii])
    end
  end
  local resistData = {
    [1] = selfPlayer:getStunResistance(),
    [2] = selfPlayer:getKnockdownResistance(),
    [3] = selfPlayer:getCatchResistance(),
    [4] = selfPlayer:getKnockbackResistance()
  }
  for ii = 1, self._resistCount do
    self._ui.txt_resistValues[ii]:SetText(tostring(resistData[ii] / 10000) .. " %")
  end
  self._ui.txt_fitnessSubtitles[1]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STAMINA_TITLE"))
  self._ui.txt_fitnessSubtitles[2]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_STRENGTH_TITLE"))
  self._ui.txt_fitnessSubtitles[3]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_FITNESS_HEALTH_TITLE"))
  local selfProxy = selfPlayer:get()
  for ii = 1, self._fitnessCount do
    self._ui.txt_fitnessValues[ii]:SetText("Lv. " .. tostring(selfProxy:getFitnessLevel(ii - 1)))
    if ii == 2 then
      self._ui.txt_fitnessSubtitles[ii]:SetText(self._ui.txt_fitnessSubtitles[ii]:GetText() .. " " .. tostring(ToClient_GetFitnessLevelStatus(ii - 1) / 10000))
    else
      self._ui.txt_fitnessSubtitles[ii]:SetText(self._ui.txt_fitnessSubtitles[ii]:GetText() .. " " .. tostring(ToClient_GetFitnessLevelStatus(ii - 1)))
    end
  end
  local sortedInfoList = ToClient_GetSkillPieceInfo()
  if not sortedInfoList then
    self._ui.stc_noSetEffect:SetShow(true)
    self._ui.frame_setEffect:SetShow(false)
    return
  else
    self._ui.stc_noSetEffect:SetShow(false)
    self._ui.frame_setEffect:SetShow(true)
  end
  self._setItemEffectData = {}
  self._setItemEffectTitleCount = 1
  self._setItemEffectValueCount = 1
  local function containGroup(title)
    for ii = 1, #self._setItemEffectData do
      if nil ~= self._setItemEffectData[ii] and title == self._setItemEffectData[ii] then
        return true
      end
    end
    return false
  end
  local data = {}
  local txt_titles = self._ui.setItemEffectTitleList
  local txt_values = self._ui.setItemEffectValueList
  for ii = 1, #txt_titles do
    txt_titles[ii]:SetShow(false)
  end
  for ii = 1, #txt_values do
    txt_values[ii]:SetShow(false)
  end
  local startY = 10
  for ii = 1, #sortedInfoList + 1 do
    data[ii] = {}
    data[ii].skillNo = sortedInfoList[ii - 1]:getSkillNo()
    data[ii].groupTitle = sortedInfoList[ii - 1]:getGroupTitle()
    data[ii].isApplied = sortedInfoList[ii - 1]:getApply()
    data[ii].point = sortedInfoList[ii - 1]:getPoint()
    data[ii].descTitle = sortedInfoList[ii - 1]:getDescTitle()
    data[ii].desc = sortedInfoList[ii - 1]:getDesc()
    if not containGroup(data[ii].groupTitle) then
      if nil == txt_titles[self._setItemEffectTitleCount] then
        txt_titles[self._setItemEffectTitleCount] = UI.createAndCopyBasePropertyControl(self._ui.frame_setEffect:GetFrameContent(), "StaticText_SetItemEffectTitle", self._ui.frame_setEffect:GetFrameContent(), "StaticText_SetItemEffectTitle" .. ii)
      end
      txt_titles[self._setItemEffectTitleCount]:SetShow(true)
      txt_titles[self._setItemEffectTitleCount]:SetTextMode(__eTextMode_AutoWrap)
      txt_titles[self._setItemEffectTitleCount]:SetText(data[ii].groupTitle)
      txt_titles[self._setItemEffectTitleCount]:SetPosX(50)
      txt_titles[self._setItemEffectTitleCount]:SetPosY(startY)
      startY = startY + txt_titles[self._setItemEffectTitleCount]:GetTextSizeY() + 12
      self._setItemEffectData[self._setItemEffectTitleCount] = data[ii].groupTitle
      self._setItemEffectTitleCount = self._setItemEffectTitleCount + 1
    end
    if nil == txt_values[self._setItemEffectValueCount] then
      txt_values[self._setItemEffectValueCount] = UI.createAndCopyBasePropertyControl(self._ui.frame_setEffect:GetFrameContent(), "StaticText_SetItemEffectValue", self._ui.frame_setEffect:GetFrameContent(), "StaticText_SetItemEffectValue" .. ii)
    end
    txt_values[self._setItemEffectValueCount]:SetShow(true)
    if true == data[ii].isApplied then
      txt_values[self._setItemEffectValueCount]:SetFontColor(Defines.Color.C_FF96D4FC)
    else
      txt_values[self._setItemEffectValueCount]:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    txt_values[self._setItemEffectValueCount]:SetTextMode(__eTextMode_AutoWrap)
    txt_values[self._setItemEffectValueCount]:SetText(data[ii].descTitle .. " : " .. data[ii].desc)
    txt_values[self._setItemEffectValueCount]:SetPosX(50)
    txt_values[self._setItemEffectValueCount]:SetPosY(startY)
    startY = startY + txt_values[self._setItemEffectValueCount]:GetTextSizeY() + 12
    self._setItemEffectValueCount = self._setItemEffectValueCount + 1
  end
  self._ui.frame_setEffect:UpdateContentPos()
  local content = self._ui.frame_setEffect:GetFrameContent()
  self._ui.stc_characterInfoBG:SetSize(content:GetSizeX(), startY)
  content:SetSize(content:GetSizeX(), startY)
  if content:GetSizeY() > self._ui.frame_setEffect:GetSizeY() then
    self._ui.frame_setEffect:GetVScroll():SetShow(true)
    self._ui.frame_setEffect:UpdateContentScroll()
    self._ui.frame_setEffect:GetVScroll():SetControlPos(0)
    self._ui.frame_setEffect:UpdateContentPos()
  else
    self._ui.frame_setEffect:GetVScroll():SetShow(false)
  end
end
function PaGlobalFunc_InventoryInfo_UpdateServantTab()
  PaGlobal_Inventory_All_ForConsole:updateServant()
end
function PaGlobal_Inventory_All_ForConsole:setServantTabPictogram(servantType)
  if servantType == 0 then
    self._servantActorKeyRaw = self:getNearbyServantsActorKeys()
    if nil ~= self._servantActorKeyRaw and nil ~= self._servantActorKeyRaw[1] then
      local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
      if nil == servantWrapper then
        return
      end
      local vehicleType = servantWrapper:getVehicleType()
      if CppEnums.VehicleType.Type_CampingTent == vehicleType then
        return
      end
    end
  end
  if servantType ~= 0 or 0 < #self._servantActorKeyRaw then
    local dataType
    if servantType == 0 then
      local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
      if nil == servantWrapper then
        self._servantActorKeyRaw = {}
      end
      local vehicleType = servantWrapper:getVehicleType()
      dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
      if dataType == nil or dataType < 1 or dataType > 4 then
        dataType = SERVANT_TYPE.HORSE_AND_ETC
      end
    else
      dataType = servantType
    end
    local control = self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB]
    control:ChangeTextureInfoNameAsync("renewal/button/console_tapbtn_00.dds")
    do
      local x1, y1, x2, y2 = setTextureUV_Func(control, _servantData[dataType].tabImageUV[1][1], _servantData[dataType].tabImageUV[1][2], _servantData[dataType].tabImageUV[1][3], _servantData[dataType].tabImageUV[1][4])
      control:getBaseTexture():setUV(x1, y1, x2, y2)
      control:setRenderTexture(control:getBaseTexture())
    end
    do
      local x1, y1, x2, y2 = setTextureUV_Func(control, _servantData[dataType].tabImageUV[2][1], _servantData[dataType].tabImageUV[2][2], _servantData[dataType].tabImageUV[2][3], _servantData[dataType].tabImageUV[2][4])
      control:getOnTexture():setUV(x1, y1, x2, y2)
    end
    local x1, y1, x2, y2 = setTextureUV_Func(control, _servantData[dataType].tabImageUV[3][1], _servantData[dataType].tabImageUV[3][2], _servantData[dataType].tabImageUV[3][3], _servantData[dataType].tabImageUV[3][4])
    control:getClickTexture():setUV(x1, y1, x2, y2)
  end
  return self._servantActorKeyRaw
end
function PaGlobal_Inventory_All_ForConsole:updateServant()
  if not _isInitialized or not _panel:GetShow() then
    return
  end
  if UPPER_TAB_TYPE.SERVANT_TAB ~= PaGlobal_Inventory_All_ForConsole._currentUpperTab then
    return
  end
  local actorKeysRaw = self:getNearbyServantsActorKeys()
  local self = PaGlobal_Inventory_All_ForConsole
  self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(false)
  if nil ~= self._servantActorKeyRaw and nil ~= self._servantActorKeyRaw[1] then
    local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
    if nil == servantWrapper then
      return
    end
    local vehicleType = servantWrapper:getVehicleType()
    if nil == actorKeysRaw or CppEnums.VehicleType.Type_CampingTent == vehicleType then
      self._servantActorKeyRaw[1] = self._campActorProxy
      return
    end
  end
  if PaGlobalFunc_CampWarehouse_All_GetShow() then
    self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(false)
    self._servantActorKeyRaw[1] = self._campActorProxy
    return
  end
  if #actorKeysRaw > 0 then
    if false == self._isFold and false == self._isShowFamilyInven and self._isShowEnchantInven == false then
      self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(true)
    end
    self._ui.txt_noServant:SetShow(false)
    self:updateServantInven(actorKeysRaw[1])
    self._servantActorKeyRaw = actorKeysRaw
  else
    self._ui.stc_upperGroups[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(false)
    self._ui.txt_noServant:SetShow(true)
    self._servantActorKeyRaw = nil
    return
  end
  self:updateServantEquipOrCostume(true)
  self:updateServantEquipOrCostume(false)
end
function PaGlobal_Inventory_All_ForConsole:updateServantInven(actorKeyRaw)
  if not _isInitialized or not _panel:GetShow() then
    return
  end
  local areaYSize = 0
  if nil == actorKeyRaw then
    return
  end
  local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local vehicleInven = vehicleActor:getInventory()
  if nil == vehicleInven then
    return
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local s64_weightAll_div = s64_weightAll / Defines.s64_const.s64_100
  self._ui.progress2_servantWeight:SetProgressRate(Int64toInt32(s64_weightAll / s64_weightMax_div))
  local allWeight = string.format("%.1f", Int64toInt32(s64_weightAll_div) / 100)
  local maxWeight = string.format("%.0f", Int64toInt32(s64_weightMax_div) / 100)
  self._ui.txt_servantWeightValue:SetText(allWeight .. " /" .. maxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  local capacity = vehicleInven:size() - __eTInventorySlotNoUseStart
  local freeCount = vehicleInven:getFreeCount()
  if capacity > 0 then
    self._ui.txt_servantInvenCountDisplay:SetText(tostring(capacity - freeCount .. "/" .. capacity))
  else
    self._ui.txt_servantInvenCountDisplay:SetText("")
  end
  for ii = 1, #self._ui.stc_servantInvenSlotBG do
    self._ui.stc_servantInvenSlotBG[ii]:SetShow(false)
  end
  local slotCount = self._servantInvenRowMax * self._invenSlotColumnMax
  for ii = 1, slotCount do
    local slotBG = self._ui.stc_servantInvenSlotBG[ii]
    local slot = self._ui.slot_servantInven[ii]
    slot:clearItem()
    local index = ii + self._servantInvenStartSlot
    if capacity >= index then
      local itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, index - 1 + __eTInventorySlotNoUseStart)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper)
      end
      slotBG:SetShow(true)
    else
      slotBG:SetShow(false)
    end
  end
  local lastSlot = self._ui.stc_servantInvenSlotBG[slotCount]
  UIScroll.SetButtonSize(self._ui.scroll_servantInven, slotCount, capacity)
  if self:isSnappedOn("InventoryInfo_ServantInvenSlotBG_") then
    self:setKeyGuide("InventoryInfo_ServantInvenSlotBG_")
  end
  return lastSlot:GetSizeY() + lastSlot:GetPosY()
end
function PaGlobal_Inventory_All_ForConsole:getRealFamilyInvenSlotNo(slotIndex)
  if PaGlobal_Inventory_All_ForConsole_IsFamilyInvenCategoryShow() == true then
    return __eTInventorySlotNoUndefined
  end
  if false == PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleFamilyInventory) then
    return slotIndex + __eTInventorySlotNoUseStart + self._familyInvenStartSlotIndex
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return __eTInventorySlotNoUndefined
  end
  local inventory = selfPlayerWrapper:get():getInventoryByType(CppEnums.ItemWhereType.eFamilyInventory)
  if slotIndex >= inventory:size() then
    return __eTInventorySlotNoUndefined
  end
  local maxSlotCount = ToClient_GetFamilyInvenotryMaxSlotCount() - __eTInventorySlotNoUseStart
  if maxSlotCount <= slotIndex + self._familyInvenStartSlotIndex then
    return __eTInventorySlotNoUndefined
  end
  return selfPlayerWrapper:get():getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ColsoleFamilyInventory), slotIndex + self._familyInvenStartSlotIndex)
end
function PaGlobal_Inventory_All_ForConsole:updateFamilyInventory()
  if self._initialize == false then
    return
  end
  if self._ui.stc_familyInvenGroup == false then
    return
  end
  if self._isShowFamilyInven == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  if _ContentsGroup_CombineBag == true and PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eFamilyInventory)
  local usableSlotCount = inventory:size() - __eTInventorySlotNoUseStart
  local lastRowSlot = self._familyinvenShowSlotCount - self._invenSlotColumnMax
  local showSlotRow = math.ceil(self._familyinvenShowSlotCount / self._invenSlotColumnMax)
  local maxSlotRows = math.ceil(self._famliyInvenMaxCapacity / self._invenSlotColumnMax)
  local isSortedFamilyInventory = PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleFamilyInventory)
  if isSortedFamilyInventory == true then
    PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ColsoleFamilyInventory, false)
  end
  local isCategoryView = PaGlobal_Inventory_All_ForConsole_IsFamilyInvenCategoryShow()
  PaGlobal_Inventory_All_ForConsole_FamilyInvenCategoryShow(isCategoryView)
  if isCategoryView == true then
  else
    for ii = 0, self._familyinvenShowSlotCount - 1 do
      local slotBG = self._ui.stc_familyInvenSlotBG[ii]
      local slot = self._ui.slot_familyInven[ii]
      if nil ~= slotBG and nil ~= slot then
        local slotNo = self:getRealFamilyInvenSlotNo(ii)
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
        if nil == itemWrapper then
          slot:clearItem(true)
        else
          slot:setItem(itemWrapper, slotNo)
        end
        slot.cooltimeText:SetShow(false)
        slot.cooltime:SetShow(false)
        self._ui.stc_lockedFamilyInvenSlots[ii]:SetShow(usableSlotCount <= slotNo - __eTInventorySlotNoUseStart)
        if 0 ~= self._familyInvenStartSlotIndex and ii < self._invenSlotColumnMax then
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_InventoryInfo_FamilyInventory(true)")
        else
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
        end
        if ii >= lastRowSlot and self._familyInvenStartSlotIndex < self._invenSlotColumnMax * (maxSlotRows - showSlotRow) then
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_InventoryInfo_FamilyInventory(false)")
        else
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
        end
      end
    end
  end
  local s64_allWeight = inventory:getWeight_s64()
  local s64_maxWeight = ToClient_GetFamilyInventoryMaxWeight_s64()
  local progressRate = Int64toInt32(s64_allWeight) / Int64toInt32(s64_maxWeight) * 100
  self._ui.progress2_familyInvenWeight:SetProgressRate(progressRate)
  self._ui.txt_familyInvenWeight:SetText(makeWeightString(s64_allWeight, 1) .. " / " .. makeWeightString(s64_maxWeight, 0) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  if progressRate >= 80 then
    self._ui.stc_familyInvenWeightIcon:SetColor(Defines.Color.C_FFD05D48)
  else
    self._ui.stc_familyInvenWeightIcon:SetColor(Defines.Color.C_FFFFEDD4)
  end
  local freeCount = inventory:getFreeCount()
  local useSlotCount = usableSlotCount - freeCount
  local leftCountPercent = useSlotCount / usableSlotCount * 100
  if leftCountPercent >= 100 then
    fontColor = "<PAColor0xFFF03838>"
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  self._ui.txt_familyInvenCapacity:SetText(fontColor .. tostring(useSlotCount) .. "/" .. tostring(usableSlotCount) .. "<PAOldColor>")
end
function PaGlobal_Inventory_All_ForConsole:getRealEnchantInvenSlotNo(slotIndex)
  if PaGlobal_Inventory_All_ForConsole_IsEnchantInvenCategoryShow() == true then
    return __eTInventorySlotNoUndefined
  end
  if false == PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ConsoleEnchantInventory) then
    return slotIndex + __eTInventorySlotNoUseStart + self._enchantInvenStartSlotIndex
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return __eTInventorySlotNoUndefined
  end
  local inventory = selfPlayerWrapper:get():getInventoryByType(CppEnums.ItemWhereType.eEnchantInventory)
  if slotIndex >= inventory:size() then
    return __eTInventorySlotNoUndefined
  end
  local maxSlotCount = __eTCashInventorySlotNoMax
  if maxSlotCount <= slotIndex + self._enchantInvenStartSlotIndex then
    return __eTInventorySlotNoUndefined
  end
  return selfPlayerWrapper:get():getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ConsoleEnchantInventory), slotIndex + self._enchantInvenStartSlotIndex)
end
function PaGlobal_Inventory_All_ForConsole:updateEnchantInventory()
  if self._initialize == false then
    return
  end
  if self._ui.stc_enchantInvenGroup == false then
    return
  end
  if self._isShowEnchantInven == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  if _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  if _ContentsGroup_CombineBag == true and PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eEnchantInventory)
  local usableSlotCount = inventory:size() - __eTInventorySlotNoUseStart
  local lastRowSlot = self._enchantInvenShowSlotCount - self._invenSlotColumnMax
  local showSlotRow = math.ceil(self._enchantInvenShowSlotCount / self._invenSlotColumnMax)
  local maxSlotRows = math.ceil(self._enchantInvenMaxCapacity / self._invenSlotColumnMax)
  local isSortedEnchantInventory = PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ConsoleEnchantInventory)
  if isSortedEnchantInventory == true then
    PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ConsoleEnchantInventory, false)
  end
  local isCategoryView = PaGlobal_Inventory_All_ForConsole_IsEnchantInvenCategoryShow()
  PaGlobal_Inventory_All_ForConsole_EnchantInvenCategoryShow(isCategoryView)
  if isCategoryView == true then
  else
    for ii = 0, self._enchantInvenShowSlotCount - 1 do
      local slotBG = self._ui.stc_enchantInvenSlotBG[ii]
      local slot = self._ui.slot_enchantInven[ii]
      if nil ~= slotBG and nil ~= slot then
        local slotNo = self:getRealEnchantInvenSlotNo(ii)
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
        if nil == itemWrapper then
          slot:clearItem(true)
        else
          slot:setItem(itemWrapper, slotNo)
        end
        slot.cooltimeText:SetShow(false)
        slot.cooltime:SetShow(false)
        if 0 ~= self._enchantInvenStartSlotIndex and ii < self._invenSlotColumnMax then
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_InventoryInfo_EnchantInventory(true)")
        else
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "")
        end
        if ii >= lastRowSlot and self._enchantInvenStartSlotIndex < self._invenSlotColumnMax * (maxSlotRows - showSlotRow) then
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_InventoryInfo_EnchantInventory(false)")
        else
          slotBG:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "")
        end
      end
    end
  end
  local freeCount = inventory:getFreeCount()
  local useSlotCount = usableSlotCount - freeCount
  local leftCountPercent = useSlotCount / usableSlotCount * 100
  if leftCountPercent >= 100 then
    fontColor = "<PAColor0xFFF03838>"
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  self._ui.txt_enchantInvenCapacity:SetText(fontColor .. tostring(useSlotCount) .. "/" .. tostring(usableSlotCount) .. "<PAOldColor>")
end
function PaGlobal_Inventory_All_ForConsole:updateServantEquipOrCostume(isEquip)
  if nil == self._servantActorKeyRaw then
    return
  end
  if nil == self._servantActorKeyRaw[1] then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == dataType then
    return
  end
  self._ui.stc_horseWeight:ChangeTextureInfoNameAsync(_servantData[dataType].weightIconPath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_horseWeight, _servantData[dataType].weightIconUV[1], _servantData[dataType].weightIconUV[2], _servantData[dataType].weightIconUV[3], _servantData[dataType].weightIconUV[4])
  self._ui.stc_horseWeight:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_horseWeight:setRenderTexture(self._ui.stc_horseWeight:getBaseTexture())
  local equipOrCostumeSlots, equipOrCostumeSlotsBG, slotNoList
  local extendedSlotCount = 0
  self._extendedSlotArray = {}
  local group
  if true == isEquip then
    equipOrCostumeSlots = self._ui.slot_servantEquip
    equipOrCostumeSlotsBG = self._ui.stc_servantEquipSlotBG
    slotNoList = _servantData[dataType].equipSlotNoList
    group = self._ui.txt_servantEquipInfo
  else
    equipOrCostumeSlots = self._ui.slot_servantCostume
    equipOrCostumeSlotsBG = self._ui.stc_servantCostumeSlotBG
    slotNoList = _servantData[dataType].costumeSlotNoList
    group = self._ui.txt_servantCostumeInfo
  end
  local checkFlagList = _servantData[dataType].checkFlag
  local UV = _servantData[dataType].pictogramUV
  local slotCount = #slotNoList
  local showFishingSlot = true
  if isEquip == true and (_ContentsGroup_EmployeeAutoFishing == false or _ContentsGroup_EmployeeAutoFishing == true and dataType == SERVANT_TYPE.BIG_SHIP and 0 >= ToClient_getEmployeePresetJobCount(servantWrapper:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing)) then
    showFishingSlot = false
    slotCount = slotCount - 1
  end
  local startX = group:GetSizeX() / 2 - ((slotCount - 1) * self._defaultXGap + equipOrCostumeSlotsBG[1]:GetSizeX()) / 2
  for ii = 1, self._servantEquipSlotMax do
    local slot = equipOrCostumeSlots[ii]
    local slotBG = equipOrCostumeSlotsBG[ii]
    if ii <= slotCount then
      slotBG:SetShow(true)
      slotBG:SetPosX(startX + (ii - 1) * self._defaultXGap)
      local slotNo = slotNoList[ii]
      if dataType == SERVANT_TYPE.BIG_SHIP and showFishingSlot == false and ii == 6 then
        slotBG:SetShow(false)
      end
      local itemWrapper = servantWrapper:getEquipItem(slotNo)
      if nil == slot.pictogram then
        slot.pictogram = UI.getChildControl(slotBG, "Static_ItemPictogram")
      end
      if nil == slot.chk_toggleButton then
        slot.chk_toggleButton = UI.getChildControl(slotBG, "CheckButton_ShowToggle")
      end
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo)
        slot.icon:SetMonoTone(false)
        slot.pictogram:SetShow(false)
        if CppEnums.VehicleType.Type_Elephant == vehicleType then
          slot.chk_toggleButton:SetShow(false)
        elseif dataType == SERVANT_TYPE.SMALL_SHIP then
          slot.chk_toggleButton:SetShow(6 == slotNo)
          local checkBool = ToClient_IsSetVehicleEquipSlotFlag(self._servantActorKeyRaw[1], slotNo)
          slot.chk_toggleButton:SetCheck(not checkBool)
        elseif nil == checkFlagList or nil == checkFlagList[slotNo] then
          slot.chk_toggleButton:SetShow(false)
        else
          slot.chk_toggleButton:SetShow(true)
          local checkBool = ToClient_IsSetVehicleEquipSlotFlag(self._servantActorKeyRaw[1], slotNo)
          slot.chk_toggleButton:SetCheck(not checkBool)
        end
        extendedSlotCount = extendedSlotCount + self:getExtendedSlotCountInfo(itemWrapper, slotNo)
      else
        slot:clearItem()
        slot.chk_toggleButton:SetShow(false)
        slot.pictogram:SetShow(true)
        if dataType == SERVANT_TYPE.BIG_SHIP and showFishingSlot == true and ii == 6 then
          slot.pictogram:ChangeTextureInfoTextureIDAsync("Combine_Etc_Equip_Life_Icon_FishingRod", 0)
          slot.pictogram:setRenderTexture(slot.pictogram:getBaseTexture())
        else
          slot.pictogram:ChangeTextureInfoNameAsync("renewal/ui_icon/console_icon_equip.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(slot.pictogram, UV[slotNo][1], UV[slotNo][2], UV[slotNo][3], UV[slotNo][4])
          slot.pictogram:getBaseTexture():setUV(x1, y1, x2, y2)
          slot.pictogram:setRenderTexture(slot.pictogram:getBaseTexture())
        end
      end
    else
      slotBG:SetShow(false)
    end
  end
  if extendedSlotCount > 0 then
    for extendSlotNo, parentSlotNo in pairs(self._extendedSlotArray) do
      local itemWrapper = servantWrapper:getEquipItem(parentSlotNo)
      local slotNo = self:getIndexFromServantCostumeSlotNo(dataType, extendSlotNo)
      if nil ~= itemWrapper then
        extendSlot = equipOrCostumeSlots[slotNo]
        if nil ~= extendSlot then
          equipOrCostumeSlots[slotNo].pictogram:SetShow(false)
          self:setItemInfoUseWrapper(extendSlot, itemWrapper, true, true)
        end
      end
    end
  end
  if self:isSnappedOn("InventoryInfo_ServantEquipSlotBG_") then
    self:setKeyGuide("InventoryInfo_ServantEquipSlotBG_")
  elseif self:isSnappedOn("InventoryInfo_ServantCostumeSlotBG_") then
    self:setKeyGuide("InventoryInfo_ServantCostumeSlotBG_")
  end
end
function PaGlobal_Inventory_All_ForConsole:clearBackendInfo()
  if _ContentsGroup_ItemBackEndLoading == false then
    return
  end
  for idx = 1, #backendInfoTable_Inven._backendUITable do
    if backendInfoTable_Inven._backendUITable[idx] ~= nil then
      table.remove(backendInfoTable_Inven._backendUITable, idx)
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:saveBackendInfo(itemSS, itemKey, whereType, slotNo, slot)
  if _ContentsGroup_ItemBackEndLoading == false then
    return false
  end
  if _panel:GetShow() == false then
    return false
  end
  local needBackEndLoad = nil ~= slot.quickslotBagIcon or nil ~= slot.bagIcon or nil ~= slot.isCash
  if needBackEndLoad == true and slot ~= nil then
    local isLoaded = itemSS:isLoadBackEndStaticStatus()
    if isLoaded == false then
      local tempTable = {_itemKey = itemKey, _whereType = whereType}
      backendInfoTable_Inven._backendUITable:push_back(tempTable)
      local isAlreadyRequest = false
      for idx = 1, #backendInfoTable_Inven._backendUITable do
        if backendInfoTable_Inven._backendUITable[idx] ~= nil then
          local infoTable = backendInfoTable_Inven._backendUITable[idx]
          if itemKey == infoTable._itemKey then
            isAlreadyRequest = true
          end
        end
      end
      if isAlreadyRequest == false then
        itemSS:reqLoadBackEndStaticStatus()
      end
      if slot.backEndLoadingIcon ~= nil then
      end
      return true
    end
  end
  return false
end
function PaGlobal_Inventory_All_ForConsole:refreshInventoryByBackEnd(ignorePanelVisibility, targetItemKey)
  if not ignorePanelVisibility and (not _isInitialized or not _panel:GetShow()) then
    return
  end
  if not ignorePanelVisibility and LOWER_TAB_TYPE.UNDEFINED == self._currentLowerTab then
    return
  end
  if ignorePanelVisibility then
    self._currentLowerTab = LOWER_TAB_TYPE.INVENTORY_TAB
  end
  if not _isInitialized then
    return
  end
  local selfPlayer = getSelfPlayer()
  local useStartSlot = __eTInventorySlotNoUseStart
  local inventory = Inventory_GetCurrentInventory()
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local invenMaxSize = inventory:sizeXXX()
  self._isAutoSort = PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory)
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == true then
    PaGlobal_Inventory_All_ForConsole_CategoryShow(true)
  else
    for ii = 1, self._invenSlotCount do
      local slot = self._ui.slot_inven[ii]
      local slotNo = ii + 1 + self._invenStartSlotIndex
      if true == self._isAutoSort then
        slotNo = selfPlayer:get():getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ColsoleInventory), ii + self._invenStartSlotIndex - 1)
      end
      local itemWrapper
      if nil ~= PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType and nil ~= slotNo then
        itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
      end
      local needUpdate = true
      if _ContentsGroup_ItemBackEndLoading == true and nil ~= itemWrapper and nil ~= slotNo then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        if targetItemKey ~= nil and targetItemKey ~= itemKey then
          needUpdate = false
        end
      end
      if needUpdate == true then
        slot:clearItem()
        slot.slotNo = slotNo
        slot.icon:EraseAllEffect()
        slot.stc_multipleSelect:SetShow(false)
        if nil ~= itemWrapper and nil ~= slotNo then
          local itemSSW = itemWrapper:getStaticStatus()
          local itemKey = itemWrapper:get():getKey():getItemKey()
          slot.icon:SetColor(UI_color.C_FFFFFFFF)
          slot:setItem(itemWrapper, slotNo)
          slot.isEmpty = false
          local isFiltered = false
          if nil ~= self._filterFunc and "function" == type(self._filterFunc) then
            isFiltered = self._filterFunc(slotNo, itemWrapper, currentWhereType)
          end
          slot.icon:SetEnable(not isFiltered)
          slot.icon:SetMonoTone(isFiltered)
          if isFiltered then
            slot.icon:SetAlpha(0.5)
            slot.icon:EraseAllEffect()
          elseif nil ~= self._filterFunc and "function" == type(self._filterFunc) then
            slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          end
          if true == self._multipleSelect[currentWhereType][slotNo] then
            slot.stc_multipleSelect:SetShow(true)
          end
        end
      end
    end
  end
  self:findPuzzle()
end
function PaGlobal_Inventory_All_ForConsole:updateInventory(ignorePanelVisibility)
  if not ignorePanelVisibility and (not _isInitialized or not _panel:GetShow()) then
    return
  end
  if not ignorePanelVisibility and LOWER_TAB_TYPE.UNDEFINED == self._currentLowerTab then
    return
  end
  if ignorePanelVisibility then
    self._currentLowerTab = LOWER_TAB_TYPE.INVENTORY_TAB
  end
  if not _isInitialized then
    return
  end
  self:updateSilverPearlMileage()
  local playerLevel = getSelfPlayer():get():getLevel()
  local selfPlayer = getSelfPlayer()
  local invenUseSize = selfPlayer:get():getInventorySlotCount(LOWER_TAB_TYPE.CASH_INVEN_TAB == self._currentLowerTab)
  local useStartSlot = __eTInventorySlotNoUseStart
  local inventory = Inventory_GetCurrentInventory()
  local currentWhereType = Inventory_GetCurrentInventoryType()
  local invenMaxSize = inventory:sizeXXX()
  local classType = selfPlayer:getClassType()
  self._isAutoSort = PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory)
  local isEmptyArtifact = false
  if true == _ContentsGroup_ArtifactItem then
    local artifactItemWrapper1 = ToClient_getEquipmentItem(__eEquipSlotNoArtifact1)
    local artifactItemWrapper2 = ToClient_getEquipmentItem(__eEquipSlotNoArtifact2)
    if nil == artifactItemWrapper1 or nil == artifactItemWrapper2 then
      isEmptyArtifact = true
    end
  end
  Panel_Inventory_isBlackStone_16001 = false
  Panel_Inventory_isBlackStone_16002 = false
  Panel_Inventory_isSocketItem = false
  self._ui.stc_plusSlot:SetShow(false)
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectClear()
  end
  local freeCount = inventory:getFreeCount()
  self._ui.txt_slotCount:SetShow(true)
  self._ui.txt_slotCount:SetText(tostring(invenUseSize - useStartSlot - freeCount) .. "/" .. tostring(invenUseSize - useStartSlot))
  PaGlobal_TutorialManager:handleOpenedInventory()
  if "QuickSlot" == Panel_Tooltip_Item_GetCurrentSlotType() then
    Panel_Tooltip_Item_Refresh(_panel:GetPosX() - 20, getScreenSizeY() - 100)
  end
  if true == _panel:GetShow() then
    Panel_Tooltip_Item_Refresh(_panel:GetPosX() - 20, getScreenSizeY() - 100)
  end
  FGlobal_Inventory_WeightCheck()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
  end
  if true == _ContentsGroup_RenewUI then
    if nil ~= PaGlobalFunc_TopIcon_Servant_GetShow and true == PaGlobalFunc_TopIcon_Servant_GetShow() then
      PaGlobalFunc_TopIcon_Servant_Update()
    end
  elseif nil ~= Panel_Window_Servant_GetShow and true == Panel_Window_Servant_GetShow() then
    Panel_Window_Servant_Update()
  end
  if self:isSnappedOn("InventoryInfo_InvenSlotBG_") then
    self:setKeyGuide("InventoryInfo_InvenSlotBG_")
  end
  self._isSlotEmpty = false
  local itemWrapperTemp = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, self._currentInvenSlotIndex)
  if nil ~= itemWrapperTemp and toInt64(0, 0) == itemWrapperTemp:get():getCount_s64() then
    self._isSlotEmpty = true
  end
  InputMOn_InventoryInfo_invenShowFloatingTooltip(self._currentInvenSlotIndex)
  local isCategoryView = PaGlobal_Inventory_All_ForConsole_IsCategoryShow()
  PaGlobal_Inventory_All_ForConsole_CategoryShow(isCategoryView)
  if isCategoryView == true then
  else
    self._invenCapacity = invenUseSize - useStartSlot
    for ii = 1, self._invenSlotCount do
      local slot = self._ui.slot_inven[ii]
      local slotNo = ii + 1 + self._invenStartSlotIndex
      if true == self._isAutoSort then
        slotNo = selfPlayer:get():getRealInventorySlotNoNew(PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(InvenSortLinkPanelIndex.ColsoleInventory), ii + self._invenStartSlotIndex - 1)
      end
      local itemWrapper
      if nil ~= PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType and nil ~= slotNo then
        itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
      end
      local realInvenMaxSize = invenMaxSize - useStartSlot
      if realInvenMaxSize < self._invenStartSlotIndex + ii then
        self._ui.stc_invenSlotBG[ii]:SetShow(false)
      else
        self._ui.stc_invenSlotBG[ii]:SetShow(true)
      end
      self._ui.stc_lockedSlots[ii]:SetShow(false)
      if ii - 1 + self._invenStartSlotIndex == self._invenCapacity then
        local posX = (ii - 1) % self._invenSlotColumnMax * self._defaultXGap
        local posY = math.floor((ii - 1) / self._invenSlotColumnMax) * self._defaultYGap
        if false == _ContentsGroup_ForXBoxFinalCert then
          self._ui.stc_lockedSlots[ii]:SetShow(true)
          self._ui.stc_plusSlot:SetShow(false)
        else
          self._ui.stc_plusSlot:SetPosX(posX + 1)
          self._ui.stc_plusSlot:SetPosY(posY + 1)
          self._ui.stc_plusSlot:SetShow(true)
          self._ui.stc_lockedSlots[ii]:SetShow(false)
        end
      elseif ii + self._invenStartSlotIndex > self._invenCapacity then
        self._ui.stc_lockedSlots[ii]:SetShow(true)
      end
      slot:clearItem()
      slot.slotNo = slotNo
      slot.icon:EraseAllEffect()
      slot.stc_multipleSelect:SetShow(false)
      slot._isLockedItem = false
      if nil ~= itemWrapper and nil ~= slotNo then
        local itemSSW = itemWrapper:getStaticStatus()
        local itemKey = itemWrapper:get():getKey():getItemKey()
        slot.icon:SetColor(UI_color.C_FFFFFFFF)
        local needLoadBackEnd = PaGlobal_Inventory_All_ForConsole:saveBackendInfo(itemSSW, itemKey, PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo, slot)
        if needLoadBackEnd == true then
          slot:setItemWhileLoad(itemSSW)
        else
          slot:setItem(itemWrapper, slotNo)
          slot.isEmpty = false
          local isFiltered = false
          if nil ~= self._filterFunc and "function" == type(self._filterFunc) then
            isFiltered = self._filterFunc(slotNo, itemWrapper, currentWhereType)
          end
          local isFilteredSequenceItem = ToClient_SequenceItemConditionCheck(currentWhereType, slotNo)
          if isFilteredSequenceItem == true then
            isFiltered = true
          end
          slot.icon:SetEnable(not isFiltered)
          slot.icon:SetMonoTone(isFiltered)
          if isFiltered then
            slot.icon:SetAlpha(0.5)
            slot.icon:EraseAllEffect()
          elseif nil ~= self._filterFunc and "function" == type(self._filterFunc) then
            slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          end
          local isUseSequenceOnlyItem = itemWrapper:getStaticStatus():isSequenceOnlyItem()
          local allowClickOrDragSequenceItem = self.filterFunc == PaGlobal_Inventory_All_CheckDeletableItem or self.filterFunc == nil
          if isUseSequenceOnlyItem == true and isFilteredSequenceItem == true and allowClickOrDragSequenceItem == true then
            slot.icon:SetEnable(true)
          end
          if true == self._multipleSelect[currentWhereType][slotNo] then
            slot.stc_multipleSelect:SetShow(true)
          end
          PaGlobal_TutorialManager:handleUpdateInventorySlotData(slot, itemKey, currentWhereType)
          if slotNo < self._invenSlotCount and true == self._newItemAtSlot[slotNo] then
            local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            PaGlobal_Inventory_All_ForConsole.effectScene.newItem[slotNo] = newItemEffectSceneId
          end
          if true == itemSSW:isEquipable() then
            local offencePoint = 0
            local defencePoint = 0
            local equipOffencePoint = 0
            local equipDefencePoint = 0
            local matchEquip = false
            local isAccessory = false
            local isUsableServant = itemSSW:isUsableServant()
            offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = self:compareSpec(currentWhereType, slotNo, isAccessory)
            local currentEndurance = itemWrapper:get():getEndurance()
            if not isUsableServant and not Panel_Window_Exchange:GetShow() then
              if nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
                slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
                local equipPos = itemSSW:getEquipSlotNo()
                if false == _ContentsGroup_RemasterUI_Main_Alert then
                  Panel_NewEquip_Update(equipPos)
                end
                if false == isAccessory then
                  PaGlobal_TutorialManager:handleNewEquipInInventory(slot)
                end
              end
              if true == itemSSW:get():isArtifact() and currentEndurance > 0 and true == isEmptyArtifact then
                slot.icon:AddEffect("fUI_BetterItemAura01", true, 0, 0)
              end
            end
            if (itemSSW:get():isWeapon() or itemSSW:get():isSubWeapon() or itemSSW:get():isAwakenWeapon()) and false == itemSSW:get()._usableClassType:isOn(classType) then
              slot.icon:SetColor(UI_color.C_FFD20000)
            end
          elseif true == itemSSW:get():isPushableToSocket() then
            Panel_Inventory_isSocketItem = true
          elseif itemWrapper:isSoulCollector() then
            local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
            local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
            local itemIconPath = itemSSW:getIconPath()
            if isCurrentSoulCount == 0 then
              slot.icon:ChangeTextureInfoNameAsync("icon/" .. itemIconPath)
            elseif isCurrentSoulCount > 0 and isCurrentSoulCount < isMaxSoulCount then
              slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
            else
              slot.icon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
            end
            local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
            slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
            slot.icon:setRenderTexture(slot.icon:getBaseTexture())
          else
            Panel_Inventory_isBlackStone_16002 = self:addEffectBlackStone(ii, isFiltered, slotNo)
            self:autoSetPotion(playerLevel, itemKey, currentWhereType, slotNo)
            if false == _ContentsGroup_RenewUI_Tutorial and true == PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() and not FGlobal_FirstSummonItemUse() and (42000 == itemKey or 42001 == itemKey or 41607 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey) then
              slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
            if 42405 == itemKey and questList_hasProgressQuest(4015, 6) then
              slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
          end
          local itemBindType = itemSSW:get()._vestedType:getItemKey()
          if Panel_Window_Exchange:GetShow() and itemBindType > 0 then
            slot.icon:SetColor(UI_color.C_FFD20000)
          end
        end
        if self._ui.stc_lockedSlots[ii]:GetShow() == true then
          slot.icon:SetAlpha(0.5)
          slot.icon:SetMonoTone(true)
          slot.icon:EraseAllEffect()
          slot._isLockedItem = true
        end
      end
    end
  end
  self:findPuzzle()
end
function PaGlobal_Inventory_All_ForConsole:findPuzzle()
  self._ui.btn_invenPuzzle:SetShow(false)
  self._puzzleCompleteSlot = nil
  if true == self._isAutoSort then
    return
  end
  if LOWER_TAB_TYPE.UNDEFINED == self._currentLowerTab then
    return
  end
  local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local isFind = findPuzzleAndReadyMake(whereType)
  if not isFind or PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory) == true then
    return
  end
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == true then
    return
  end
  local count = getPuzzleSlotCount()
  for ii = 1, count do
    local puzzleSlotNo = getPuzzleSlotAt(ii - 1)
    local showSlotIndex = puzzleSlotNo - 1 - self._invenStartSlotIndex
    if showSlotIndex > 0 and showSlotIndex < self._invenSlotCount then
      if 1 == ii then
        local bg = self._ui.stc_invenSlotBG[showSlotIndex]
        local spanX = self._ui.stc_invenBG:GetSpanSize().x
        local spanY = self._ui.stc_invenBG:GetSpanSize().y
        self._ui.btn_invenPuzzle:SetShow(true)
        self._ui.btn_invenPuzzle:SetPosX(bg:GetPosX() + spanX + 30)
        self._ui.btn_invenPuzzle:SetPosY(bg:GetPosY() + spanY + 30)
        self._puzzleCompleteSlot = puzzleSlotNo
        self._ui.btn_invenPuzzle:addInputEvent("Mouse_LUp", "Input_InventoryInfo_CompletePuzzle()")
      end
      self._ui.slot_inven[showSlotIndex].icon:AddEffect("UI_Item_MineCraft", true, 0, 0)
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:updateWeight()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local _const = Defines.s64_const
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local s64_allWeight_div = s64_allWeight / _const.s64_100
  local s64_maxWeight_div = s64_maxWeight / _const.s64_100
  local allWeight = string.format("%.1f", Int64toInt32(s64_allWeight_div) / 100)
  local maxWeight = string.format("%.0f", Int64toInt32(s64_maxWeight_div) / 100)
  local weightLength = Int64toInt32(s64_allWeight / s64_maxWeight_div)
  if Int64toInt32(s64_allWeight) <= Int64toInt32(s64_maxWeight) then
    self._ui.progress2_Weight:SetProgressRate(weightLength)
  else
    self._ui.progress2_Weight:SetProgressRate(weightLength)
  end
  local val = self._ui.progress2_Weight:GetProgressRate()
  self._weightDesignatorTarget = self._ui.progress2_Weight:GetSizeY() - self._ui.progress2_Weight:GetSizeY() * (val / 100)
  self._weightDesignatorIsAnimating = true
  self._ui.txt_weight:SetText(allWeight .. " / " .. maxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
local _slotCoolTimeTable = {}
function PaGlobalFunc_Window_InventoryInfo_PerFrameUpdate(deltaTime)
  local self = PaGlobal_Inventory_All_ForConsole
  if deltaTime <= 0 then
    return
  end
  if true == self._snapEffectAniFlag and nil ~= self._ui.ref_snapTarget then
    local value = math.sin(self._sinCurveTheta)
    local adjustedValue = value * 15
    self._ui.stc_snapEffect:SetSize(self._ui.ref_snapTarget:GetSizeX() + 9 + adjustedValue * 2, self._ui.ref_snapTarget:GetSizeY() + 9 + adjustedValue * 2)
    self._ui.stc_snapEffect:SetPosX(self._ui.ref_snapTarget:GetParentPosX() - _panel:GetPosX() - 4 - adjustedValue)
    self._ui.stc_snapEffect:SetPosY(self._ui.ref_snapTarget:GetParentPosY() - _panel:GetPosY() - 4 - adjustedValue)
    self._ui.stc_snapEffect:SetAlpha(1 - value)
    self._sinCurveTheta = self._sinCurveTheta + deltaTime * 4
    if math.pi / 2 < self._sinCurveTheta then
      self._sinCurveTheta = 0
      self._snapEffectAniFlag = false
    end
  end
  if true == self._weightDesignatorIsAnimating then
  end
  if true == self._showAniIsPlaying then
    self._showAniElapsed = self._showAniElapsed + deltaTime
    if self._showAniElapsed > self._showAniDuration then
      self._showAniIsPlaying = false
    end
  end
  if false == self._monitorItemCooltime then
    return
  end
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == true then
    PaGlobal_Inventory_All_ForConsole_categoryInvenPerFrameUpdate(deltaTime)
  else
    for ii = 1, self._invenSlotCount do
      local slot = self._ui.slot_inven[ii]
      if true == _slotCoolTimeTable[ii] then
        local slotNo = slot.slotNo
        local remainTime = getItemCooltime(Inventory_GetCurrentInventoryType(), slotNo)
        if remainTime > 0 then
          if false == slot.cooltime:GetShow() then
            slot.cooltime:SetShow(true)
          end
          slot.cooltime:UpdateCoolTime(remainTime)
          local itemReuseTime = getItemReuseCycle(Inventory_GetCurrentInventoryType(), slotNo)
          local realRemainTime = remainTime * itemReuseTime
          local intRemainTime = realRemainTime - realRemainTime % 1 + 1
          if itemReuseTime >= intRemainTime then
            slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
            if false == slot.cooltimeText:GetShow() then
              slot.cooltimeText:SetShow(true)
            end
          else
            slot.cooltimeText:SetShow(false)
          end
        else
          _slotCoolTimeTable[ii] = false
        end
      end
    end
  end
  if true == self._isShowFamilyInven then
    if PaGlobal_Inventory_All_ForConsole_IsFamilyInvenCategoryShow() == true then
      PaGlobal_Inventory_All_ForConsole_categoryFamilyInvenPerFrameUpdate(deltaTime)
    else
      for ii = 0, self._familyinvenShowSlotCount - 1 do
        local slot = self._ui.slot_familyInven[ii]
        local slotNo = self:getRealFamilyInvenSlotNo(ii)
        local remainTime = 0
        local itemReuseTime = 0
        local realRemainTime = 0
        local intRemainTime = 0
        if __eTInventorySlotNoUndefined ~= slotNo then
          remainTime = getItemCooltime(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
        end
        if remainTime > 0 then
          itemReuseTime = getItemReuseCycle(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
          realRemainTime = remainTime * itemReuseTime
          intRemainTime = realRemainTime - realRemainTime % 1 + 1
          slot.cooltime:UpdateCoolTime(remainTime)
          slot.cooltime:SetShow(true)
          slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if itemReuseTime >= intRemainTime then
            slot.cooltimeText:SetShow(true)
          else
            slot.cooltimeText:SetShow(false)
          end
        elseif slot.cooltime:GetShow() then
          slot.cooltime:SetShow(false)
          slot.cooltimeText:SetShow(false)
          local skillSlotItemPosX = slot.cooltime:GetParentPosX()
          local skillSlotItemPosY = slot.cooltime:GetParentPosY()
          if true == self._isShowCoolTimeEffect then
            audioPostEvent_SystemUi(2, 1)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
            Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
          end
        end
      end
    end
  end
  if true == self._isShowEnchantInven then
    if PaGlobal_Inventory_All_ForConsole_IsEnchantInvenCategoryShow() == true then
      PaGlobal_Inventory_All_ForConsole_categoryEnchantInvenPerFrameUpdate(deltaTime)
    else
      for ii = 0, self._enchantInvenShowSlotCount - 1 do
        local slot = self._ui.slot_enchantInven[ii]
        local slotNo = self:getRealEnchantInvenSlotNo(ii)
        local remainTime = 0
        local itemReuseTime = 0
        local realRemainTime = 0
        local intRemainTime = 0
        if __eTInventorySlotNoUndefined ~= slotNo then
          remainTime = getItemCooltime(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
        end
        if remainTime > 0 then
          itemReuseTime = getItemReuseCycle(CppEnums.ItemWhereType.eEnchantInventory, slotNo)
          realRemainTime = remainTime * itemReuseTime
          intRemainTime = realRemainTime - realRemainTime % 1 + 1
          slot.cooltime:UpdateCoolTime(remainTime)
          slot.cooltime:SetShow(true)
          slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if itemReuseTime >= intRemainTime then
            slot.cooltimeText:SetShow(true)
          else
            slot.cooltimeText:SetShow(false)
          end
        elseif slot.cooltime:GetShow() then
          slot.cooltime:SetShow(false)
          slot.cooltimeText:SetShow(false)
          local skillSlotItemPosX = slot.cooltime:GetParentPosX()
          local skillSlotItemPosY = slot.cooltime:GetParentPosY()
          if true == self._isShowCoolTimeEffect then
            audioPostEvent_SystemUi(2, 1)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
            Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
            Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
          end
        end
      end
    end
  end
end
function PaGlobalFunc_InventoryInfo_SearchCooltime()
  if not _isInitialized then
    return
  end
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == true then
    PaGlobal_Inventory_All_ForConsole_categoryInvenSearchCooltimeItems()
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local currentWhereType = Inventory_GetCurrentInventoryType()
  for ii = 1, self._invenSlotCount do
    local slot = self._ui.slot_inven[ii]
    local slotNo = slot.slotNo
    local remainTime = 0
    if nil ~= slotNo and __eTInventorySlotNoUndefined ~= slotNo then
      remainTime = getItemCooltime(currentWhereType, slotNo)
      if remainTime > 0 then
        _slotCoolTimeTable[ii] = true
      else
        _slotCoolTimeTable[ii] = false
        if slot.cooltime:GetShow() then
          self:onItemCooltimeEnd(ii)
        end
      end
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:onItemCooltimeEnd(index)
  local slot = self._ui.slot_inven[index]
  slot.cooltime:SetShow(false)
  slot.cooltimeText:SetShow(false)
  local skillSlotItemPosX = slot.cooltime:GetParentPosX()
  local skillSlotItemPosY = slot.cooltime:GetParentPosY()
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetShow(true, true)
  Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("UI_Button_Hide", false, 2.5, 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:AddEffect("fUI_Button_Hide", false, 2.5, 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosX(skillSlotItemPosX - 7)
  Panel_Inventory_CoolTime_Effect_Item_Slot:SetPosY(skillSlotItemPosY - 10)
  _AudioPostEvent_SystemUiForXBOX(2, 1)
end
function PaGlobal_Inventory_All_ForConsole:animateWeightDesignator()
  local designtorY = self._ui.stc_designator:GetPosY()
  local difference = self._weightDesignatorTarget - designtorY
  if math.abs(difference) > 1 then
    local moveAmount = difference * 0.1
    self._ui.stc_designator:SetPosY(designtorY + moveAmount)
  else
    self._ui.stc_designator:SetPosY(self._weightDesignatorTarget)
    self._weightDesignatorIsAnimating = false
  end
  local showFlipped = designtorY > getScreenSizeY() - 50
  self._ui.stc_designatorImage:SetShow(not showFlipped)
  self._ui.stc_designatorFlippedImage:SetShow(showFlipped)
  if showFlipped then
    self._ui.txt_weight:SetPosY(-53)
  else
    self._ui.txt_weight:SetPosY(28)
  end
end
function PaGlobal_Inventory_All_ForConsole:refreshSortKeyguide()
  local RSKeyguideX = 2
  local isShotFamilyInven = self._isShowFamilyInven
  if isShotFamilyInven == nil then
    isShotFamilyInven = false
  end
  local isShowEnchantInven = self._isShowEnchantInven
  if isShowEnchantInven == nil then
    isShowEnchantInven = false
  end
  if isShotFamilyInven == true then
    self._ui.txt_keyGuideSort:SetShow(false)
    RSKeyguideX = RSKeyguideX + self._ui.txt_keyGuideSort:GetSpanSize().x
    _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_InventoryInfo_ToggleCheckSort(true,false)")
  elseif isShowEnchantInven == true then
    self._ui.txt_keyGuideSort:SetShow(false)
    RSKeyguideX = RSKeyguideX + self._ui.txt_keyGuideSort:GetSpanSize().x
    _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_InventoryInfo_ToggleCheckSort(false,true)")
  else
    self._ui.txt_keyGuideSort:SetShow(true)
    RSKeyguideX = RSKeyguideX + self._ui.txt_keyGuideSort:GetSpanSize().x + self._ui.txt_keyGuideSort:GetSizeX()
    _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "Input_InventoryInfo_ToggleCheckSort(false,false)")
  end
  self._ui.btn_sortOption:SetSpanSize(RSKeyguideX, self._ui.btn_sortOption:GetSpanSize().y)
  self._ui.chk_sort:SetSpanSize(self._ui.btn_sortOption:GetSpanSize().x + 3, self._ui.chk_sort:GetSpanSize().y)
end
function PaGlobal_Inventory_All_ForConsole:setTabTo(tabIndex)
  self._currentUpperTab = tabIndex
  self._updateSnappingSlot = true
  for ii = 1, #self._ui.stc_upperGroups do
    self._ui.stc_upperGroups[ii]:SetShow(false)
    self._ui.rdo_tabButtons[ii]:SetCheck(false)
  end
  local radioButtonCount = 3
  self._ui.rdo_tabButtons[tabIndex]:SetCheck(true)
  if false == self._isFold then
    if self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB] ~= nil then
      self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(true)
    end
    self._ui.stc_upperGroups[tabIndex]:SetShow(not self._isShowFamilyInven and self._isShowEnchantInven == false)
    self._ui.stc_familyInvenGroup:SetShow(self._isShowFamilyInven)
    self._ui.stc_familyInvenSortArea:SetShow(self._isShowFamilyInven)
    self._ui.stc_enchantInvenGroup:SetShow(self._isShowEnchantInven)
    self._ui.stc_enchantInvenSortArea:SetShow(self._isShowEnchantInven)
    self._ui.btn_valksView:SetShow(self._isShowEnchantInven == true and Panel_Widget_Enchant_Main_All ~= nil and Panel_Widget_Enchant_Main_All:GetShow() == false)
    if true == _ContentsGroup_Season_EquipmentUpgrade then
      if true == self._isShowFamilyInven then
        PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(false, false)
      elseif self._isShowEnchantInven == true then
        PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(false, false)
      else
        PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(true, true)
      end
    end
  else
    if self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB] ~= nil then
      self._ui.rdo_tabButtons[UPPER_TAB_TYPE.SERVANT_TAB]:SetShow(false)
    end
    radioButtonCount = 2
  end
  radioButtonCount = radioButtonCount + 1
  if ToClient_HardCoreChannelWithContensOption() == true then
    radioButtonCount = 2
  end
  local rdoBtnsStartX = _panel:GetSizeX() / 2 - self._tabXGab * radioButtonCount / 2 + self._tabXGab / 2 - self._ui.rdo_tabButtons[1]:GetSizeX() / 2
  for ii = 1, radioButtonCount do
    self._ui.rdo_tabButtons[ii]:SetPosX(rdoBtnsStartX + self._tabXGab * (ii - 1))
  end
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.ColsoleInventory, _panel, self._ui.btn_sortOption, self._ui.chk_sort, self._ui.btn_categoryView, self._ui.btn_slotView, "Static_SortComponent_Inventory")
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.ColsoleInventory) == true or PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.ColsoleFamilyInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ColsoleInventory)
  self:updateUpperTab(tabIndex)
  if self._ui.txt_noServant ~= nil then
    self._ui.txt_noServant:SetShow(false)
  end
  if tabIndex == UPPER_TAB_TYPE.COSTUME_TAB then
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.CASH_INVEN_TAB)
    self._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_INVENTORY_BTN_CASHINVENTORY"))
    self._ui.stc_equipBG:SetShow(false)
    self._ui.stc_costumeBG:SetShow(true)
    self._ui.stc_lifeEquipBG:SetShow(false)
  elseif tabIndex == UPPER_TAB_TYPE.EQUIPMENT_TAB then
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.INVENTORY_TAB)
    self._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
    self._ui.stc_equipBG:SetShow(true)
    self._ui.stc_costumeBG:SetShow(false)
    self._ui.stc_lifeEquipBG:SetShow(false)
  elseif tabIndex == UPPER_TAB_TYPE.SERVANT_TAB then
    self._servantInvenStartSlot = 0
    self._ui.scroll_servantInven:SetControlTop(0)
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.INVENTORY_TAB)
    self._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_SERVANTINVENTORY_TITLE"))
  elseif tabIndex == UPPER_TAB_TYPE.LIFEEEQUIP_TAB then
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.INVENTORY_TAB)
    self._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INVENTORY_TEXT_TITLE"))
    self._ui.stc_equipBG:SetShow(false)
    self._ui.stc_costumeBG:SetShow(false)
    self._ui.stc_lifeEquipBG:SetShow(true)
  end
  self._ui.stc_selectedLine:SetPosX(self._ui.rdo_tabButtons[tabIndex]:GetPosX() + self._ui.rdo_tabButtons[tabIndex]:GetSizeX() * 0.5 - self._ui.stc_selectedLine:GetSizeX() * 0.5)
  self:setKeyGuideWithTab()
  if Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true then
    PaGlobal_AutoMove_Result_All:prepareClose()
  end
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
end
function PaGlobalFunc_GetCurrentConsoleInventoryType()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return nil
  end
  if _panel:GetShow() == false then
    return nil
  end
  if self._currentUpperTab == UPPER_TAB_TYPE.COSTUME_TAB then
    return CppEnums.ItemWhereType.eCashInventory
  else
    return CppEnums.ItemWhereType.eInventory
  end
end
function PaGlobalFunc_InventoryInfo_SetUpperTabTo(tabIndex)
  PaGlobal_Inventory_All_ForConsole:setTabTo(tabIndex)
end
function PaGlobalFunc_InventoryInfo_IsCurrentItemlock()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index then
    return false
  end
  if nil == self._ui.slot_inven[index] then
    return false
  end
  local slotNo = self._ui.slot_inven[index].slotNo
  local whereType = Inventory_GetCurrentInventoryType()
  local islock = ToClient_Inventory_CheckItemLock(slotNo, whereType)
  return islock
end
function PaGlobalFunc_InventoryInfo_IsItemlockable()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if index == nil then
    return false
  end
  local slotNo = 0
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == false then
    if self._ui.slot_inven[index] == nil then
      return false
    end
    slotNo = self._ui.slot_inven[index].slotNo
  else
    slotNo = index
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return false
  end
  local isCash = itemWrapper:isCash()
  local checks = {
    [1] = nil ~= Panel_Window_ItemMarket_Function and Panel_Window_ItemMarket_Function:GetShow(),
    [2] = nil ~= Panel_Window_ItemMarket_RegistItem and Panel_Window_ItemMarket_RegistItem:GetShow(),
    [3] = nil ~= Panel_Repair_Renew and Panel_Repair_Renew:GetShow(),
    [4] = nil ~= Panel_Window_Warehouse and Panel_Window_Warehouse:GetShow(),
    [5] = nil ~= Panel_Window_Manufacture and Panel_Window_Manufacture:GetShow(),
    [6] = Defines.UIMode.eUIMode_NpcDialog == GetUIMode(),
    [7] = nil ~= Panel_FixMaxEndurance_Renew and Panel_FixMaxEndurance_Renew:GetShow(),
    [8] = nil ~= Panel_Window_Enchant_Renew and Panel_Window_Enchant_Renew:GetShow(),
    [9] = nil ~= Panel_Window_Socket_Renew and Panel_Window_Socket_Renew:GetShow(),
    [10] = nil ~= Panel_Window_Improvement_Renew and Panel_Window_Improvement_Renew:GetShow(),
    [11] = nil ~= Panel_Window_Alchemy and Panel_Window_Alchemy:GetShow(),
    [12] = false == _isItemLock,
    [13] = true == itemWrapper:getStaticStatus():isStackable(),
    [14] = true == itemWrapper:isSoulCollector(),
    [15] = true == isCash and itemWrapper:getStaticStatus():isEquipable() == false,
    [16] = nil ~= PaGlobalFunc_MainDialog_IsShow and PaGlobalFunc_MainDialog_IsShow(),
    [17] = nil ~= Panel_Npc_Dialog_All and Panel_Npc_Dialog_All:GetShow(),
    [18] = nil ~= Panel_Window_Alchemy_All and Panel_Window_Alchemy_All:GetShow(),
    [19] = nil ~= Panel_Window_Manufacture_All and Panel_Window_Manufacture_All:GetShow(),
    [20] = nil ~= Panel_Dialog_Repair_Function_All and Panel_Dialog_Repair_Function_All:GetShow()
  }
  local function CheckList()
    for index = 1, #checks do
      if true == checks[index] then
        return true
      end
    end
    return false
  end
  if true == CheckList() then
    return false
  elseif nil ~= Panel_Window_Improvement_All and Panel_Window_Improvement_All:GetShow() or nil ~= Panel_Window_Socket_All and Panel_Window_Socket_All:GetShow() then
    return false
  else
    return true
  end
end
function Input_InventoryInfo_ItemLock(index)
  PaGlobalFunc_NewbieInventory_SetRestrictOpen(true)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self._ui.slot_inven[index].slotNo
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  if false == PaGlobalFunc_InventoryInfo_IsItemlockable() then
    return
  end
  if false == itemWrapper:getStaticStatus():isStackable() and false == itemWrapper:isSoulCollector() then
    if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
      ToClient_Inventory_RemoveItemLock(slotNo, whereType)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
    else
      ToClient_Inventory_InsertItemLock(slotNo, whereType)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMLOCK"))
    end
  elseif ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    ToClient_Inventory_RemoveItemLock(slotNo, whereType)
    Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANNOT_ITEMLOCK"))
  end
  Inventory_updateSlotData()
  InputMOn_InventoryInfo_invenShowFloatingTooltip(self._currentInvenSlotIndex)
end
function Input_InventoryInfo_SetUpperTabLeft()
  local self = PaGlobal_Inventory_All_ForConsole
  self._currentUpperTab = self._currentUpperTab - 1
  local endTabNo = #self._ui.rdo_tabButtons
  if true == self._isFold then
    endTabNo = #self._ui.rdo_tabButtons - 1
  end
  if self._currentUpperTab < 1 then
    self._currentUpperTab = endTabNo
  end
  self:setTabTo(self._currentUpperTab)
end
function Toggle_InventoryTab_forPadEventFunc(value)
  local self = PaGlobal_Inventory_All_ForConsole
  if PaGlobalFunc_CampWarehouse_All_GetShow() then
    return
  end
  if PaGlobal_ArtifactExchange_GetShow ~= nil and PaGlobal_ArtifactExchange_GetShow() == true then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  if 1 == value then
    Input_InventoryInfo_SetUpperTabRight()
  else
    Input_InventoryInfo_SetUpperTabLeft()
  end
end
function Input_InventoryInfo_SetUpperTabRight()
  local self = PaGlobal_Inventory_All_ForConsole
  self._currentUpperTab = self._currentUpperTab + 1
  local endTabNo = #self._ui.rdo_tabButtons
  if true == self._isFold then
    endTabNo = #self._ui.rdo_tabButtons - 1
  end
  if endTabNo < self._currentUpperTab then
    self._currentUpperTab = 1
  end
  self:setTabTo(self._currentUpperTab)
end
function Input_InventoryInfo_SetLowerTabLeft()
  local self = PaGlobal_Inventory_All_ForConsole
  self._currentLowerTab = self._currentLowerTab - 1
  if self._currentLowerTab < 1 then
    self._currentLowerTab = #PaGlobal_Inventory_All_ForConsole._lowerTabData
  end
  self:updateInventory()
end
function Input_InventoryInfo_SetLowerTabRight()
  local self = PaGlobal_Inventory_All_ForConsole
  self._currentLowerTab = self._currentLowerTab + 1
  if self._currentLowerTab > #PaGlobal_Inventory_All_ForConsole._lowerTabData then
    self._currentLowerTab = 1
  end
  self:updateInventory()
end
function Input_InventoryInfo_SetLowerTabTo(tabIndex)
  local self = PaGlobal_Inventory_All_ForConsole
  local isNeedUpdate = false
  if tabIndex ~= self._currentLowerTab then
    self._invenStartSlotIndex = 0
    self._ui.scroll_inven:SetControlPos(0)
    self._currentLowerTab = tabIndex
    InputMOn_InventoryInfo_invenShowFloatingTooltip(self._currentInvenSlotIndex)
    isNeedUpdate = true
  end
  if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory) == true then
    isNeedUpdate = true
  end
  if true == self._isShowFamilyInven then
    if _ContentsGroup_EnchantRemaster == true then
      if Panel_Window_Enchant_StackExtraction_All:GetShow() == true then
        Inventory_SetFunctor(PaGlobalFunc_StackExtraction_All_FilterForBookExtraction, PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem, PaGlobalFunc_StackExtraction_All_Close, nil, nil)
      elseif Panel_Widget_Enchant_Main_All:GetShow() == true then
        Inventory_SetFunctor(nil, PaGlobal_Enchant_All_RClickInventory, nil, nil, nil)
      else
        Inventory_SetFunctor(PaGlobal_FamilyInvnetory_IsMoveableItem, Inventory_UseItemTargetSelfForFamilyInven, nil, nil, nil)
      end
    else
      Inventory_SetFunctor(PaGlobal_FamilyInvnetory_IsMoveableItem, Inventory_UseItemTargetSelfForFamilyInven, nil, nil, nil)
    end
    return
  elseif self._isShowEnchantInven == true then
    if _ContentsGroup_EnchantRemaster == true then
      if Panel_Window_Enchant_StackExtraction_All:GetShow() == true then
        Inventory_SetFunctor(PaGlobalFunc_StackExtraction_All_FilterForBookExtraction, PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem, PaGlobalFunc_StackExtraction_All_Close, nil, nil)
      elseif Panel_Widget_Enchant_Main_All:GetShow() == true then
        Inventory_SetFunctor(nil, PaGlobal_Enchant_All_RClickInventory, nil, nil, nil)
      else
        Inventory_SetFunctor(PaGlobal_EnchantInventory_IsMoveableItem, nil, nil, nil, nil)
      end
    else
      Inventory_SetFunctor(PaGlobal_EnchantInventory_IsMoveableItem, nil, nil, nil, nil)
    end
    return
  elseif PaGlobal_FamilyInvnetory_IsMoveableItem == self._filterFunc then
    Inventory_SetFunctor(nil, nil, nil, nil, nil)
    return
  elseif PaGlobal_EnchantInventory_IsMoveableItem == self._filterFunc then
    Inventory_SetFunctor(nil, nil, nil, nil, nil)
    return
  elseif _ContentsGroup_EnchantRemaster == true then
    if Panel_Window_Enchant_StackExtraction_All:GetShow() == true then
      Inventory_SetFunctor(PaGlobalFunc_StackExtraction_All_FilterForBookExtraction, PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem, PaGlobalFunc_StackExtraction_All_Close, nil, nil)
      return
    elseif Panel_Widget_Enchant_Main_All:GetShow() == true then
      Inventory_SetFunctor(nil, PaGlobal_Enchant_All_RClickInventory, nil, nil, nil)
      return
    end
  end
  if true == isNeedUpdate then
    self:updateInventory()
  end
end
function InputMRUp_InventoryInfo_EquipSlot(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
  else
    if DragManager:isDragging() then
      InputMLUp_InventoryInfo_EquipSlot(slotNo)
      return
    end
    local itemWrapper = ToClient_getEquipmentItem(slotNo)
    if nil ~= itemWrapper then
      if Defines.UIMode.eUIMode_Repair == GetUIMode() then
        if true == Panel_Dialog_Repair_Function_All:GetShow() then
          if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
            equipmentDoUnequip(slotNo)
          else
            PaGlobalFunc_RepairFunc_All_EquipWindowRClick(slotNo, itemWrapper)
          end
        end
      else
        equipmentDoUnequip(slotNo)
      end
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
      elseif nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
        Panel_Tooltip_Item_hideTooltip()
        PaGlobalFunc_FloatingTooltip_Close()
      end
    end
    local itemWrapper = ToClient_getEquipmentItem(slotNo)
    if nil == itemWrapper then
      HandleEventLUp_Equipment_All_ItemAcquireHelper(slotNo)
    end
  end
end
function InputMLUp_InventoryInfo_EquipSlot(targetEquipSlotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  if DragManager.dragStartPanel == _panel then
    local dragSlotNo = DragManager.dragSlotInfo
    local dragFromWhere = DragManager.dragWhereTypeInfo
    local itemWrapper = getInventoryItemByType(dragFromWhere, dragSlotNo)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus()
      if itemStatic:isEquipable() then
        local equipItem = function()
          inventoryUseItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, nil)
          DragManager:clearInfo()
        end
        if false == itemWrapper:get():isVested() and true == itemWrapper:isCash() then
          local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
          local messageboxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
            content = messageContent,
            functionYes = equipItem,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageboxData)
        else
          if 21 == targetEquipSlotNo or 23 == targetEquipSlotNo then
            Inventory_UseItemTargetSelf(Inventory_GetCurrentInventoryType(), dragSlotNo, targetEquipSlotNo)
          else
            inventoryUseItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, nil)
          end
          DragManager:clearInfo()
        end
      end
    end
  end
end
function Input_InventoryInfo_ToggleEquipEffectSwtich(slotNo)
  local toggle = PaGlobal_Inventory_All_ForConsole._ui.slot_equips[slotNo].chk_toggleButton
  local equipSlotNo = _equipSlotNo[slotNo]
  local isSet = ToClient_isSetUniqueEquipEffectSlotFlag(equipSlotNo)
  if isSet == true then
    ToClient_resetUniqueEquipEffectSlotFlag(equipSlotNo)
  else
    ToClient_setUniqueEquipEffectSlotFlag(equipSlotNo)
  end
  toggle:SetCheck(isSet == false)
end
function Input_InventoryInfo_AutoActive()
  local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  if isSolare == false then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eAlchemyStone, PaGlobal_Inventory_All_ForConsole._ui.chk_autoActive:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_Character)
  end
end
function Input_InventoryInfo_HideHelmet()
  selfPlayerShowHelmet(not ToClient_IsShowHelm())
  PaGlobal_Inventory_All_ForConsole._ui.chk_hideHelmetIcon:SetCheck(not ToClient_IsShowHelm())
end
function Input_InventoryInfo_SubWeapon()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_HIDEWEAPON"))
    PaGlobal_Inventory_All_ForConsole._ui.chk_subWeapon:SetCheck(not PaGlobal_Inventory_All_ForConsole._ui.chk_subWeapon:IsCheck())
    return
  end
  selfPlayerShowSubWeapon(not PaGlobal_Inventory_All_ForConsole._ui.chk_subWeapon:IsCheck())
end
function Input_InventoryInfo_OpenHelmet()
  selfPlayerShowBattleHelmet(not ToClient_IsShowBattleHelm())
  PaGlobal_Inventory_All_ForConsole._ui.chk_openHelmetIcon:SetCheck(ToClient_IsShowBattleHelm())
end
function Input_InventoryInfo_ToggleUnderwear()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:get():isWearingUnderwear() and false == selfPlayer:get():isWearingSwimmingSuit() then
    PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(false)
    return
  end
  if selfPlayer:get():isWearingBack() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UNDERWEAR_BACKSLOT_NO"))
    PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(false)
    return
  end
  if true == selfPlayer:get():isWearingSwimmingSuit() then
    if false == IsSelfPlayerWaitAction() and false == IsSelfPlayerSwimmingWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SWIMMINGSUIT"))
      PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if true == isSafeZone or true == IsSelfPlayerSwimmingWaitAction() then
      if true == selfPlayer:get():getSwimmingSuitMode() then
        selfPlayer:get():setSwimmingSuitMode(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setSwimmingSuitMode(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_SWIMMINGSUIT_ALERT"))
      PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode()))
    end
  else
    if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_UNDERWEAR"))
      PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if isSafeZone then
      if selfPlayer:get():getUnderwearModeInhouse() then
        selfPlayer:get():setUnderwearModeInhouse(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setUnderwearModeInhouse(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_UNDERWARE_ALERT"))
      PaGlobal_Inventory_All_ForConsole._ui.chk_showUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
    end
  end
  FGlobal_CheckUnderwear()
end
function Input_InventoryInfo_ToggleCloak()
  selfPlayerShowCloak(not ToClient_IsShowCloak())
end
function Input_InventoryInfo_ToggleNameWhenCamo()
  local chkBtn = PaGlobal_Inventory_All_ForConsole._ui.chk_toggleNameWhenCamo
  Toclient_setShowNameWhenCamouflage(chkBtn:IsCheck())
end
function InputMOn_InventoryInfo_ToggleButton()
  PaGlobal_Inventory_All_ForConsole:setKeyGuide("CheckButton_Costume_")
end
function InputMRUp_InventoryInfo_ServantInvenSlot(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if PaGlobalFunc_CampWarehouse_All_GetShow() then
    self._servantActorKeyRaw[1] = self._campActorProxy
  end
  if InputMLUp_InventoryInfo_ServantInvenDropHandler() then
    return
  end
  if nil == self._servantActorKeyRaw[1] then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  if __eVehicleType_CampingTent == vehicleType then
    local moveToType = CppEnums.MoveItemToType.Type_CampingTent
    FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, index + self._servantInvenStartSlot - 1 + __eTInventorySlotNoUseStart, moveToType, self._servantActorKeyRaw[1], true)
    return
  end
  local servantType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == servantType then
    return
  end
  local moveToType = _servantData[servantType].moveItemToType
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, index + self._servantInvenStartSlot - 1 + __eTInventorySlotNoUseStart, moveToType, self._servantActorKeyRaw[1], true)
  Input_InventoryInfo_ServantInvenFloatingTooltip(index + self._servantInvenStartSlot)
end
function InputMLUp_InventoryInfo_ServantInvenDropHandler()
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == DragManager.dragStartPanel then
    return false
  end
  if nil == self._servantActorKeyRaw[1] then
    return false
  end
  local actorKeyRaw = self._servantActorKeyRaw[1]
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return false
  end
  local vehicleType = servantWrapper:getVehicleType()
  if __eVehicleType_CampingTent == vehicleType then
    if false == _ContentsGroup_RenewUI and true == _ContentsGroup_UsePadSnapping then
      local moveToType = CppEnums.MoveItemToType.Type_CampingTent
      DragManager:itemDragMove(moveToType, actorKeyRaw)
    end
    return
  end
  local servantType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == servantType then
    return
  end
  local moveToType = _servantData[servantType].moveItemToType
  return (DragManager:itemDragMove(moveToType, actorKeyRaw))
end
function Input_InventoryInfo_ServantInvenFloatingTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if false == _ContentsGroup_RenewUI_Tooltip then
    if nil ~= self._servantActorKeyRaw[1] then
      Panel_Tooltip_Item_SetPosition(index - 1 + __eTInventorySlotNoUseStart, self._ui.slot_servantInven[index], "servant_inventory")
      Panel_Tooltip_Item_Show_GeneralNormal(index - 1 + __eTInventorySlotNoUseStart, "servant_inventory", isShow, nil, _panel:GetPosX(), 20)
    else
      Panel_Tooltip_Item_Show_GeneralNormal(index - 1 + __eTInventorySlotNoUseStart, "servant_inventory", false)
    end
    return
  end
  if isShow and nil ~= self._servantActorKeyRaw[1] then
    local itemWrapper = getServantInventoryItemBySlotNo(self._servantActorKeyRaw[1], index + self._servantInvenStartSlot - 1 + __eTInventorySlotNoUseStart)
    if nil ~= itemWrapper then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, self._ui.stc_servantInvenSlotBG[index], "Inventory")
      setPositionFloatingTooltip(self)
    end
    self:setKeyGuide("InventoryInfo_ServantInvenSlotBG_")
  else
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function InputMRUp_InventoryInfo_ServantEquipSlot(isEquipment, index)
  local self = PaGlobal_Inventory_All_ForConsole
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == dataType then
    return
  end
  local slotNo = _servantData[dataType].equipSlotNoList[index]
  if true == isEquipment then
    slotNo = _servantData[dataType].equipSlotNoList[index]
  else
    slotNo = _servantData[dataType].costumeSlotNoList[index]
  end
  if DragManager:isDragging() and _panel == DragManager.dragStartPanel then
    local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if true == itemSSW:isVehicleItem() then
        local equipItem = function()
          inventoryUseItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, nil)
          DragManager:clearInfo()
        end
        if false == itemWrapper:get():isVested() and true == itemWrapper:isCash() then
          local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
          local messageboxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
            content = messageContent,
            functionYes = equipItem,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageboxData)
        else
          inventoryUseItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, nil)
          DragManager:clearInfo()
        end
        if true == _ContentsGroup_RenewUI_Tooltip then
          PaGlobalFunc_FloatingTooltip_Close()
        end
      end
    end
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil ~= itemWrapper then
    servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Close()
    end
  elseif isEquipment then
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.INVENTORY_TAB)
  else
    Input_InventoryInfo_SetLowerTabTo(LOWER_TAB_TYPE.CASH_INVEN_TAB)
  end
end
function InputMLUp_InventoryInfo_ServantEquipDropHandler()
  local self = PaGlobal_Inventory_All_ForConsole
  if _panel ~= DragManager.dragStartPanel then
    return
  end
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:isVehicleItem() then
    inventoryUseItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, nil)
  end
end
function Input_InventoryInfo_ServantEquipToggle(isEquipment, index)
  local self = PaGlobal_Inventory_All_ForConsole
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == dataType then
    return
  end
  local slotNo, check
  if true == isEquipment then
    slotNo = _servantData[dataType].equipSlotNoList[index]
    check = self._ui.slot_servantEquip[index].chk_toggleButton
  else
    slotNo = _servantData[dataType].costumeSlotNoList[index]
    check = self._ui.slot_servantCostume[index].chk_toggleButton
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  if true == ToClient_IsSetVehicleEquipSlotFlag(self._servantActorKeyRaw[1], slotNo) then
    ToClient_ResetVehicleEquipSlotFlag(self._servantActorKeyRaw[1], slotNo)
    check:SetCheck(true)
  else
    ToClient_SetVehicleEquipSlotFlag(self._servantActorKeyRaw[1], slotNo)
    check:SetCheck(false)
  end
end
function Input_InventoryInfo_ServantEquipShowFloatingTooltip(isEquipment, index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if false == isShow and true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  local slotNo = _servantData[dataType].equipSlotNoList[index]
  local slot = self._ui.slot_servantEquip[index]
  local slotBG = self._ui.stc_servantEquipSlotBG[index]
  if false == isEquipment then
    slotNo = _servantData[dataType].costumeSlotNoList[index]
    slot = self._ui.slot_servantCostume[index]
    slotBG = self._ui.stc_servantCostumeSlotBG[index]
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil ~= itemWrapper then
    if false == _ContentsGroup_RenewUI_Tooltip then
      local itemSSW = itemWrapper:getStaticStatus()
      Panel_Tooltip_Item_Show(itemSSW, _panel, true, false)
    else
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, slotBG, "Inventory")
      setPositionFloatingTooltip(self)
    end
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_FloatingTooltip_Close()
  end
  self:setKeyGuide(slotBG:GetID())
end
function InputMRUp_InventoryInfo_InvenSlot(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil ~= Panel_Gacha_Roulette and true == Panel_Gacha_Roulette:GetShow() then
    return
  end
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
  elseif Defines.UIMode.eUIMode_Repair == GetUIMode() then
    local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
    local slotNo = self._ui.slot_inven[index].slotNo
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if nil ~= itemWrapper and true == Panel_Dialog_Repair_Function_All:GetShow() then
      PaGlobalFunc_RepairFunc_All_InvenRClick(slotNo, itemWrapper, nil, whereType)
    end
  elseif DragManager:isDragging() then
    InputDrag_InventoryInfo_invenDragEnd(index)
  else
    self:onInventoryItemRClick(index)
  end
  InputMOn_InventoryInfo_invenShowFloatingTooltip(index)
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
    PaGlobalFunc_TooltipInfo_Close()
  elseif nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InputRSClick_InventoryInfo_OpenCraftNote(index, isFamilyInven)
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  local slotNo = __eTInventorySlotNoUndefined
  local inventoryType = WHERE_TYPE.INVENTORY
  if false == isFamilyInven then
    inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
    slotNo = self._ui.slot_inven[index].slotNo
  else
    inventoryType = WHERE_TYPE.FAMILY_INVENTORY
    slotNo = self:getRealFamilyInvenSlotNo(index)
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil ~= itemWrapper then
    Note_On(itemWrapper:get():getKey():getItemKey())
  end
end
function ConsoleInventory_updateSlotData()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  self:updateInventory()
end
function ConsoleFamilyInventory_updateSlotData()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  self:updateFamilyInventory()
end
function ConsoleEnchantInventory_updateSlotData()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  self:updateEnchantInventory()
end
function InputMOn_InventoryInfo_UpdateSortAreaKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  self:setKeyGuide("InvenSortArea_")
end
function Input_InventoryInfo_ToggleSortOption(isFamilyInventorySortButton, isEnchantInventorySortButton)
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  if isFamilyInventorySortButton == nil or isEnchantInventorySortButton == nil then
    return
  end
  DragManager:clearInfo()
  if isFamilyInventorySortButton == true then
    if self._isShowFamilyInven == true then
      self._isShowCoolTimeEffect = false
      PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.ColsoleFamilyInventory)
    end
  elseif isEnchantInventorySortButton == true then
    if self._isShowEnchantInven == true then
      self._isShowEnchantCoolTimeEffect = false
      PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.ConsoleEnchantInventory)
    end
  else
    self._ui.btn_invenPuzzle:SetShow(false)
    self._puzzleCompleteSlot = nil
    PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.ColsoleInventory)
  end
end
function Input_InventoryInfo_ToggleCheckSort(isFamilyInventorySortButton, isEnchantInventorySortButton)
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  if isFamilyInventorySortButton == nil or isEnchantInventorySortButton == nil then
    return
  end
  DragManager:clearInfo()
  if isFamilyInventorySortButton == true then
    if self._isShowFamilyInven == true then
      self._isShowCoolTimeEffect = false
      HandleLUp_AutoSortFunctionPanel_ToggleUseSort(InvenSortLinkPanelIndex.ColsoleFamilyInventory, true)
    end
  elseif isEnchantInventorySortButton == true then
    if self._isShowEnchantInven == true then
      self._isShowEnchantCoolTimeEffect = false
      HandleLUp_AutoSortFunctionPanel_ToggleUseSort(InvenSortLinkPanelIndex.ConsoleEnchantInventory, true)
    end
  else
    self._ui.btn_invenPuzzle:SetShow(false)
    self._puzzleCompleteSlot = nil
    HandleLUp_AutoSortFunctionPanel_ToggleUseSort(InvenSortLinkPanelIndex.ColsoleInventory, true)
  end
end
function InputMOn_InventoryInfo_invenShowFloatingTooltip(index)
  PaGlobal_UseItem_All_NotifyInventorySlotChanged(0)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == self._showAniIsPlaying or not _isInitialized or nil == self._invenCapacity then
    return
  end
  if self._isSlotEmpty then
    return
  end
  local slotNo
  if nil == self._ui.slot_inven[index] or nil == self._ui.slot_inven[index].slotNo then
    return
  end
  if index + self._invenStartSlotIndex <= self._invenCapacity then
    slotNo = self._ui.slot_inven[index].slotNo
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local itemWrapper
  if slotNo ~= nil then
    self._newItemAtSlot[slotNo] = false
    if nil ~= PaGlobal_Inventory_All_ForConsole.effectScene.newItem[slotNo] then
      self._ui.slot_inven[index].icon:EraseEffect(PaGlobal_Inventory_All_ForConsole.effectScene.newItem[slotNo])
    end
    itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
  elseif true == _ContentsGroup_ForXBoxXR and true == _ContentsGroup_ForXBoxFinalCert and index + self._invenStartSlotIndex == self._invenCapacity + 1 then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_NAME")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_DESC")
    local control = self._ui.slot_inven[index].icon
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
  self._tooltipWhereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  self._tooltipSlotNo = slotNo
  if nil ~= slotNo and nil ~= itemWrapper then
    PaGlobal_UseItem_All_NotifyInventorySlotChanged(itemWrapper:getStaticStatus():getItemKey())
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNote, self._ui.stc_invenSlotBG[index], "Inventory")
      setPositionFloatingTooltip(self)
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_SetPosition(index, self._ui.slot_inven[index], "inventory")
      Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", true, false, _panel:GetPosX(), 20)
    end
  elseif true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
  if self:isSnappedOn("InventoryInfo_InvenSlotBG_") == true then
    self:setKeyGuide("InventoryInfo_InvenSlotBG_")
  elseif true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  if self._ui.slot_inven[index]._isLockedItem == true then
    self._ui.slot_inven[index].icon:SetAlpha(1)
    self._ui.slot_inven[index].icon:SetMonoTone(false)
    self._ui.slot_inven[index].icon:EraseAllEffect()
  end
  self._currentInvenSlotIndex = index
end
function InputLUp_InventoryInfo_ClickDetailInfo()
  if PaGlobal_Inventory_All_ForConsole == nil then
    return
  end
  PaGlobalFunc_NotationAbility_ChangeViewTypeByCheckButton(PaGlobal_Inventory_All_ForConsole._ui.chk_detailInfo)
  InputOnOut_InventoryInfo_ClickDetailInfo(true)
end
function InputOnOut_InventoryInfo_ClickDetailInfo(isOn)
  if PaGlobal_Inventory_All_ForConsole == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_Inventory_All_ForConsole._ui.chk_detailInfo
    local name = ""
    local desc = ""
    if control:IsCheck() == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_EQUIPSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_DD")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_RECOMMAND_MONSTERATT_SUM")
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function InputLUp_InventoryInfo_NotationSetting()
  if PaGlobal_Inventory_All_ForConsole == nil then
    return
  end
  PaGlobalFunc_NotationAbility_ToggleShow(_panel)
end
function InputOnOut_InventoryInfo_NotationSetting(isOn)
  if PaGlobal_Inventory_All_ForConsole == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_Inventory_All_ForConsole._ui.btn_notationSetting
    local childControl = UI.getChildControl(control, "Static_Icon")
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NOTATION_ABILITY_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    if _ContentsGroup_UsePadSnapping == true then
      desc = nil
    end
    TooltipSimple_Show(control, name, desc, childControl)
  else
    TooltipSimple_Hide()
  end
end
function InputMOut_InventoryInfo_invenHideTooltip(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil ~= over_SlotEffect then
    self._ui.slot_inven[index].icon:EraseEffect(over_SlotEffect)
  end
  self._tooltipWhereType = nil
  self._tooltipSlotNo = nil
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  elseif true == _ContentsGroup_NewUI_Tooltip_All or nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", false, false)
    Panel_Tooltip_Item_hideTooltip()
  end
  TooltipSimple_Hide()
  if self._ui.slot_inven[index]._isLockedItem == true then
    self._ui.slot_inven[index].icon:SetAlpha(0.5)
    self._ui.slot_inven[index].icon:SetMonoTone(true)
    self._ui.slot_inven[index].icon:EraseAllEffect()
  end
end
function InputDrag_InventoryInfo_invenDrag(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == self._ui.slot_inven[index] then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory) == true then
    DragManager:clearInfo()
    return
  end
  local slotNo = self._ui.slot_inven[index].slotNo
  if nil ~= inventoryDragNoUseList and inventoryDragNoUseList:IsShow() then
    return
  end
  if nil ~= self._filterFunc or nil ~= self._rClickFunc then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
  else
    local itemSSW = itemWrapper:getStaticStatus()
    local itemType = itemSSW:getItemType()
    local isTradeItem = itemSSW:isTradeAble()
    DragManager:setDragInfo(_panel, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), Inventory_GroundClick, getSelfPlayer():getActorKey())
    if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() then
      QuickSlot_ShowBackGround()
    end
    Item_Move_Sound(itemWrapper)
  end
end
function InputDrag_InventoryInfo_invenDragEnd(index)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self._ui.slot_inven[index].slotNo
  if nil == DragManager.dragStartPanel then
    return false
  end
  if PaGlobal_Inventory_All_ForConsole:checkRestrictedAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM"))
    return false
  end
  if MessageBoxGetShow() then
    DragManager:clearInfo()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM_WHILE_UI"))
    return false
  end
  if _panel == DragManager.dragStartPanel then
    if DragManager.dragWhereTypeInfo == PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType then
      inventory_swapItem(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, DragManager.dragSlotInfo, slotNo)
    end
    DragManager:clearInfo()
  else
    return (DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey()))
  end
  return true
end
local INVEN_MAX_COUNT = 192
function InputScroll_InventoryInfo_Inventory(isUp)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotBG = self._ui.stc_invenSlotBG
  local inventory = Inventory_GetCurrentInventory()
  local maxSize = inventory:sizeXXX() - __eTInventorySlotNoUseStart
  local maxUISize = maxSize + 6
  local prevSlotIndex = self._invenStartSlotIndex
  self._invenStartSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_inven, isUp, self._invenSlotRowMax, maxUISize, self._invenStartSlotIndex, self._invenSlotColumnMax)
  local intervalSlotIndex = INVEN_MAX_COUNT - self._invenSlotCount
  if prevSlotIndex == 0 and self._invenStartSlotIndex == 0 or prevSlotIndex == intervalSlotIndex and self._invenStartSlotIndex == intervalSlotIndex then
    return
  end
  if _ContentsGroup_UsePadSnapping or ToClient_IsDevelopment() then
    ToClient_padSnapIgnoreGroupMove()
  end
  self:updateInventory()
  InputMOut_InventoryInfo_invenHideTooltip(self._currentInvenSlotIndex)
  InputMOn_InventoryInfo_invenShowFloatingTooltip(self._currentInvenSlotIndex)
end
function InputScroll_InventoryInfo_ServantInventory(isUp)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == self._servantActorKeyRaw or nil == self._servantActorKeyRaw[1] then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._servantActorKeyRaw[1])
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local vehicleInven = vehicleActor:getInventory()
  if nil == vehicleInven then
    return
  end
  local capacity = vehicleInven:size() - __eTInventorySlotNoUseStart
  local slotCount = self._servantInvenRowMax * self._invenSlotColumnMax
  local extraRow = 0
  if capacity > slotCount then
    extraRow = math.ceil((capacity - slotCount) / self._invenSlotColumnMax)
  end
  local prevSlotIndex = self._servantInvenStartSlot
  self._servantInvenStartSlot = UIScroll.ScrollEvent(self._ui.scroll_servantInven, isUp, self._servantInvenRowMax, slotCount + extraRow * self._invenSlotColumnMax, self._servantInvenStartSlot, self._invenSlotColumnMax)
  if prevSlotIndex == self._servantInvenStartSlot then
    return
  end
  if _ContentsGroup_UsePadSnapping or ToClient_IsDevelopment() then
    ToClient_padSnapIgnoreGroupMove()
  end
  self:updateServantInven(self._servantActorKeyRaw[1])
end
function PaGlobal_Inventory_All_ForConsole:onInventoryItemRClick(index)
  if nil == self._ui.slot_inven[index] or nil == self._ui.slot_inven[index].slotNo then
    return
  end
  local inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local slot = self._ui.slot_inven[index]
  local slotNo = slot.slotNo
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil == itemStatic then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local itemConnectUi = itemEnchantWrapper:getConnectUi()
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  if nil ~= itemWrapper and slot.icon:IsEnable() then
    if false == slot.icon:IsEnable() then
      return
    end
    if selfProxy:doRideMyVehicle() then
      local isMaidCheck = PaGlobal_Warehouse_All_OpenByMaidCheck()
      local isUpperServantTab = UPPER_TAB_TYPE.SERVANT_TAB == PaGlobal_Inventory_All_ForConsole._currentUpperTab
      if false == isMaidCheck and false == isUpperServantTab and itemStatic:isUseToVehicle() and (nil == self._rClickFunc or 50823 ~= itemWrapper:get():getKey():getItemKey()) then
        inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
        return
      end
    end
    if nil ~= self._rClickFunc then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
      self._rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    if PaGlobalFunc_CampWarehouse_All_GetShow() then
      self._servantActorKeyRaw[1] = self._campActorProxy
    end
    if nil ~= self._servantActorKeyRaw and nil ~= self._servantActorKeyRaw[1] then
      local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
      if nil == servantWrapper then
        return
      end
      local vehicleType = servantWrapper:getVehicleType()
      if CppEnums.VehicleType.Type_CampingTent == vehicleType and UPPER_TAB_TYPE.SERVANT_TAB == self._currentUpperTab and false == Panel_Window_CampWarehouse_All:GetShow() then
        inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
        return
      end
    end
    if UPPER_TAB_TYPE.SERVANT_TAB == self._currentUpperTab and nil ~= self._servantActorKeyRaw and #self._servantActorKeyRaw > 0 then
      self:onInventoryItemRClickAtServant(index)
      return
    end
    if slotNo == self._puzzleCompleteSlot then
      Input_InventoryInfo_CompletePuzzle()
      return
    end
    PaGlobal_TutorialManager:handleInventorySlotRClick(itemWrapper:get():getKey():getItemKey())
    PaGlobal_TutorialManager:handleInventorySlotRClickgetSlotNo(slotNo)
    if nil ~= Panel_Auction_Regist_Popup and Panel_Auction_Regist_Popup:GetShow() then
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Auction_RegisterItemFromInventory)
      else
        Auction_RegisterItemFromInventory(1, slotNo)
      end
      return
    elseif nil ~= Panel_Window_FairySetting and Panel_Window_FairySetting:GetShow() then
      PaGlobal_FairySetting_SetPortion(itemWrapper:get():getKey())
    elseif nil ~= Panel_FairyInfo and Panel_Window_FairyUpgrade:GetShow() then
      if true == itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobal_FairyUpgrade_RClickItemByNumberPad, false, itemWrapper:get():getKey())
      else
        PaGlobal_FairyUpgrade_RClickItem(itemWrapper:get():getKey(), slotNo, 1)
      end
    elseif true == PaGlobalFunc_DialogMain_All_GetAuctionState() then
      return
    elseif 2 == itemEnchantWrapper:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local function bindingItemUse()
        Inventory_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local messageContent
      if itemEnchantWrapper:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = bindingItemUse,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "inventory", false, false)
      if eConnectUiType.eConnectUi_Letter == itemConnectUi then
        ConnectLetterUI(itemWrapper:get():getKey():getItemKey())
      else
        ConnectUI(itemConnectUi, itemWrapper:get():getKey():getItemKey())
      end
    elseif itemWrapper:getStaticStatus():getItemType() == 8 then
      return
    elseif true == _ContentsGroup_HopeGauge and true == itemStatic:isItemCollectionScroll() then
      Panel_Tooltip_Item_hideTooltip()
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
      PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(inventoryType, slotNo, itemEnchantWrapper:getGradeType())
    elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox or itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
      if ToClient_CheckAndNotifyNecessarySlotForOpenItemBox(inventoryType, slotNo, 1) ~= 0 then
        return
      end
      self._multiUseCount_s64 = itemWrapper:getCount()
      self._multiUseInventoryType = inventoryType
      self._multiUseSlotNo = slotNo
      if itemEnchantWrapper:getContentsEventParam2() == __eBoxItemUiType_NotUseMultiBoxItem then
        self._multiUseCount_s64 = toInt64(0, 1)
      elseif itemEnchantWrapper:isStackable() == false and itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox then
        self._multiUseCount_s64 = ToClient_InventoryFindSlotListSize(inventoryType, itemWrapper:get():getKey())
      end
      if itemEnchantWrapper:isPopupItem() == true then
        Panel_Tooltip_Item_hideTooltip()
        if true == _ContentsGroup_RenewUI_Tooltip then
          PaGlobalFunc_TooltipInfo_Close()
          PaGlobalFunc_FloatingTooltip_Close()
        end
        if itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
        else
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo, HandleClicked_Inventory_All_UseMultiBoxes)
        end
        return
      elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
        Inventory_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
        return
      end
      HandleClicked_Inventory_All_UseMultiBoxes()
    elseif itemEnchantWrapper:isPopupItem() then
      Panel_Tooltip_Item_hideTooltip()
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
      PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
    elseif _ContentsGroup_RepeatCollect == true and itemWrapper:getStaticStatus():get():getContentsEventType() == __eContentsType_CollectByTool then
      local invenPopupConfig = {
        [1] = {
          func = HandleClickedUseItem,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ONCE_USE"),
          enable = true
        },
        [2] = {
          func = HandleClickedRepeatUseItem,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CONTINUITY_USE"),
          enable = true
        }
      }
      if not PaGlobalFunc_MultiButtonPopup_IsOpened() then
        PaGlobalFunc_MultiButtonPopup_Open(invenPopupConfig, getMousePosX(), getMousePosY())
      else
        PaGlobalFunc_MultiButtonPopup_Close()
      end
      return
    elseif itemEnchantWrapper:isExchangeItemNPC() or itemWrapper:isSoulCollector() or 17 == itemWrapper:getStaticStatus():getItemType() then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if nil == itemKey then
        return
      end
      local invenPopupConfig = {
        [1] = {
          func = HandleClickedWidget,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
          enable = true
        },
        [2] = {
          func = HandleClickedWayPoint,
          param = slotNo,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHENCYCLOPEDIA_BTN_FISHLOCATION"),
          enable = true
        }
      }
      if 17 == itemWrapper:getStaticStatus():getItemType() and false == itemEnchantWrapper:isExchangeItemNPC() then
        invenPopupConfig = {
          [1] = {
            func = HandleClickedWidget,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
            enable = true
          },
          [2] = {
            func = FindNearestNPCShop,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_USELESSITEM_WAYPOINT_BTN"),
            enable = true
          }
        }
      end
      if true == itemWrapper:isSoulCollector() then
        invenPopupConfig = {
          [1] = {
            func = HandleClickedWidget,
            param = slotNo,
            icon = nil,
            desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
            enable = true
          }
        }
      end
      if true == whereUseItem_isSameItem(itemKey) then
        invenPopupConfig[1] = {
          func = WhereUseItemDirectionClose,
          param = nil,
          icon = nil,
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_0"),
          enable = true
        }
      end
      if not PaGlobalFunc_MultiButtonPopup_IsOpened() then
        PaGlobalFunc_MultiButtonPopup_Open(invenPopupConfig, getMousePosX(), getMousePosY())
      else
        PaGlobalFunc_MultiButtonPopup_Close()
      end
    elseif not itemStatic:isUseToVehicle() then
      local function useTradeItem()
        Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
      end
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      if 2 == item_type and true == itemSSW:get():isForJustTrade() then
        local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_CONTENT")
        local messageboxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_TITLE"),
          content = messageContent,
          functionYes = useTradeItem,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      else
        if true == itemSSW:get():isEquipable() and false == itemSSW:isUsableServant() and false == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) then
          PaGlobalFunc_MessageBox_SeasonItem_All_Open()
        end
        local equipType = itemWrapper:getStaticStatus():getEquipType()
        if 16 == equipType or 17 == equipType then
          local accSlotNo = FGlobal_AccSlotNo(itemWrapper, true)
          Inventory_UseItemTargetSelf(inventoryType, slotNo, accSlotNo)
        else
          Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
        end
      end
    end
  end
end
function PaGlobal_Inventory_All_ForConsole:onInventoryItemRClickAtServant(index)
  if nil == self._ui.slot_inven[index] or nil == self._ui.slot_inven[index].slotNo then
    return
  end
  local slotNo = self._ui.slot_inven[index].slotNo
  local inventoryType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper or nil == slotNo or nil == itemWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  if __eVehicleType_CampingTent == vehicleType then
    FGlobal_PopupMoveItem_Init(inventoryType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
    return
  end
  local servantType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  local moveToType = _servantData[servantType].moveItemToType
  FGlobal_PopupMoveItem_Init(inventoryType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
end
function InputMOn_InventoryInfo_equipShowFloatingTooltip(isEquip, index, isOn)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobal_Inventory_All_ForConsole._showAniIsPlaying then
    return
  end
  if false == isOn and true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local slotBG, slotNo, slot
  if isEquip then
    slotBG = self._ui.stc_equipSlotBG[index]
    slotNo = _equipSlotNo[index]
    slot = self._ui.slot_equips[index]
  else
    slotBG = self._ui.stc_costumeSlotBG[index]
    slotNo = _costumeSlotNo[index]
    slot = self._ui.slot_costumes[index]
  end
  InputMOn_InventoryInfo_equipShowFloatingTooltipShow(slotBG, slotNo, slot, isOn)
end
function InputMOn_InventoryInfo_LifeEquipShowFloatingTooltip(index, isOn)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobal_Inventory_All_ForConsole._showAniIsPlaying then
    return
  end
  if false == isOn and true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local slotBG = self._ui.stc_lifeEquipSlotBG[index]
  local slotNo = _lifeEquipSlotNo[index]
  local slot = self._ui.slot_lifeEquips[index]
  InputMOn_InventoryInfo_equipShowFloatingTooltipShow(slotBG, slotNo, slot, isOn)
end
function InputMOn_InventoryInfo_equipShowFloatingTooltipShow(slotBG, slotNo, slot, isOn)
  local self = PaGlobal_Inventory_All_ForConsole
  if slotBG == nil or slotNo == nil or slot == nil then
    return
  end
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "equipment", isOn, false, _panel:GetPosX(), 20)
    else
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, slotBG, "Inventory")
      setPositionFloatingTooltip(self)
    end
  elseif true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_Show_GeneralNormal(1, "equipment", false, false)
  end
  if self:isSnappedOn("InventoryInfo_EquipSlotBG_") then
    self:setKeyGuide("InventoryInfo_EquipSlotBG_")
  elseif self:isSnappedOn("InventoryInfo_CostumeSlotBG_") then
    self:setKeyGuide("InventoryInfo_CostumeSlotBG_")
  end
end
function Input_InventoryInfo_CostumeShowToggle(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil ~= self._rClickFunc or nil ~= self._filterFunc then
    return
  end
  local toggle = self._ui.slot_costumes[index].chk_toggleButton
  local isCheck = toggle:IsCheck()
  if false == isCheck then
    ToClient_SetAvatarEquipSlotFlag(_costumeSlotNo[index])
    toggle:SetCheck(true)
    if getSelfPlayer():get():getUnderwearModeInhouse() then
      getSelfPlayer():get():setUnderwearModeInhouse(false)
      Toclient_setShowAvatarEquip()
      self._ui.chk_showUnderwear:SetCheck(false)
    end
  else
    ToClient_ResetAvatarEquipSlotFlag(_costumeSlotNo[index])
    toggle:SetCheck(false)
  end
  Toclient_setShowAvatarEquip()
end
function Input_InventoryInfo_CompletePuzzle()
  PaGlobal_Inventory_All_ForConsole._ui.btn_invenPuzzle:SetShow(false)
  requestMakePuzzle()
end
function Input_InventoryInfo_ItemDelete(index)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil ~= self._filterFunc or nil ~= self._rClickFunc then
    return
  end
  local slotNo = self._ui.slot_inven[index].slotNo
  if nil == slotNo then
    return
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  if isPadPressed(__eJoyPadInputType_A) then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    Inventory_ItemDelete_Check(Defines.s64_const.s64_1, slotNo, whereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, Inventory_ItemDelete_Check, nil, whereType)
  end
end
function Input_InventoryInfo_ShowTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, self._ui.slot_inven[index].slotNo), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function Input_InventoryInfo_ShowEquipTooltip(slotNo, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_getEquipmentItem(slotNo), Defines.TooltipTargetType.ItemWithoutCompare, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory", true)
  PaGlobalFunc_FloatingTooltip_Close()
end
function Input_InventoryInfo_ShowServantInvenTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if nil ~= self._servantActorKeyRaw[1] then
    local itemWrapper = getServantInventoryItemBySlotNo(self._servantActorKeyRaw[1], index + self._servantInvenStartSlot - 1 + __eTInventorySlotNoUseStart)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function Input_InventoryInfo_ShowServantEquipTooltip(isEquipment, index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if nil ~= self._servantActorKeyRaw[1] then
    local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
    if nil ~= servantWrapper then
      local slotNo
      local vehicleType = servantWrapper:getVehicleType()
      local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
      if true == isEquipment then
        slotNo = _servantData[dataType].equipSlotNoList[index]
      else
        slotNo = _servantData[dataType].costumeSlotNoList[index]
      end
      local itemWrapper = servantWrapper:getEquipItem(slotNo)
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
      PaGlobalFunc_FloatingTooltip_Close()
    end
  end
end
function PaGlobal_FamilyInvnetoryShowToggle()
  if PaGlobalFunc_Inventory_All_familyInventoryIsActive() == false then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayerGet = getSelfPlayer():get()
  if nil == selfPlayerGet then
    return
  end
  if true == _ContentsGroup_Season_EquipmentUpgrade and true == PaGlobal_SeasonEquipment_Upgrade_GetShow() then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    if _ContentsGroup_StaticSlot == true then
      if Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
        return
      end
    elseif Panel_Window_NewbieInventory_All:GetShow() == true then
      return
    end
  end
  local self = PaGlobal_Inventory_All_ForConsole
  if false == self._isShowFamilyInven then
    if false == _panel:GetShow() then
      self:open(UPPER_TAB_TYPE.EQUIPMENT_TAB, false, nil, true)
    end
    self._ui.scroll_familyInven:SetControlPos(0)
  end
  self._isShowFamilyInven = not self._isShowFamilyInven
  if self._isShowFamilyInven == true then
    PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.ColsoleFamilyInventory, _panel, self._ui.btn_familySortOption, self._ui.chk_familySort, self._ui.btn_familyInvenCategoryView, self._ui.btn_familyInvenSlotView, "Static_SortComponent_FamilyInventory")
    PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ColsoleFamilyInventory)
  end
  self:setTabTo(self._currentUpperTab)
  self:refreshSortKeyguide()
end
function PaGlobal_EnchantInventoryShowToggle()
  if PaGlobalFunc_Inventory_All_enchantInventoryIsActive() == false then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayerGet = getSelfPlayer():get()
  if nil == selfPlayerGet then
    return
  end
  if true == _ContentsGroup_Season_EquipmentUpgrade and true == PaGlobal_SeasonEquipment_Upgrade_GetShow() then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    if _ContentsGroup_StaticSlot == true then
      if Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
        return
      end
    elseif Panel_Window_NewbieInventory_All:GetShow() == true then
      return
    end
  end
  local self = PaGlobal_Inventory_All_ForConsole
  if false == self._isShowEnchantInven then
    if false == _panel:GetShow() then
      self:open(UPPER_TAB_TYPE.EQUIPMENT_TAB, false, nil, true)
    end
    self._ui.scroll_enchantInven:SetControlPos(0)
  end
  self._isShowEnchantInven = not self._isShowEnchantInven
  if self._isShowEnchantInven == true then
    PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.ConsoleEnchantInventory, _panel, self._ui.btn_enchantSortOption, self._ui.chk_enchantSort, self._ui.btn_enchantInvenCategoryView, self._ui.btn_enchantInvenSlotView, "Static_SortComponent_EnchantInventory")
    PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.ConsoleEnchantInventory)
  end
  self:setTabTo(self._currentUpperTab)
  self:refreshSortKeyguide()
end
function PaGlobal_InventoryShowToggle()
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  if PaGlobalFunc_Inventory_All_familyInventoryIsActive() == true then
    if self._isShowFamilyInven == false and self._isShowEnchantInven == false then
      PaGlobal_FamilyInvnetoryShowToggle()
    elseif self._isShowFamilyInven == true and self._isShowEnchantInven == false then
      PaGlobal_FamilyInvnetoryShowToggle()
      PaGlobal_EnchantInventoryShowToggle()
    elseif self._isShowFamilyInven == false and self._isShowEnchantInven == true then
      PaGlobal_EnchantInventoryShowToggle()
    end
  else
    PaGlobal_EnchantInventoryShowToggle()
  end
end
function Input_InventoryInfo_FamilyInvenFloatingTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if false == isShow then
    self._familyInventoryTooltipSlotNo = nil
  else
    self._familyInventoryTooltipSlotNo = self:getRealFamilyInvenSlotNo(index)
  end
  if nil == self._familyInventoryTooltipSlotNo then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show_GeneralNormal(index, "FamilyInventory", false, false)
      TooltipSimple_Hide()
    else
      PaGlobalFunc_FloatingTooltip_Close()
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "FamilyInventory", true, false, _panel:GetPosX(), 20)
  else
    local itemWrapper = getInventoryItemByType(WHERE_TYPE.FAMILY_INVENTORY, PaGlobal_Inventory_All_ForConsole._familyInventoryTooltipSlotNo)
    if nil ~= itemWrapper then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNoteNoLock, self._ui.stc_familyInvenSlotBG[index], "Inventory")
      setPositionFloatingTooltip(self)
    end
  end
end
function Input_InventoryInfo_EnchantInvenFloatingTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if false == isShow then
    self._enchantInventoryTooltipSlotNo = nil
  else
    self._enchantInventoryTooltipSlotNo = self:getRealEnchantInvenSlotNo(index)
  end
  if nil == self._enchantInventoryTooltipSlotNo then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show_GeneralNormal(index, "EnchantInventory", false, false)
      TooltipSimple_Hide()
    else
      PaGlobalFunc_FloatingTooltip_Close()
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "EnchantInventory", true, false, _panel:GetPosX(), 20)
  else
    local itemWrapper = getInventoryItemByType(WHERE_TYPE.ENCHANT_INVENTORY, PaGlobal_Inventory_All_ForConsole._enchantInventoryTooltipSlotNo)
    if nil ~= itemWrapper then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithCraftNoteNoLock, self._ui.stc_enchantInvenSlotBG[index], "Inventory")
      setPositionFloatingTooltip(self)
    end
  end
end
function Input_InventoryInfo_ShowFamilyInvenTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(WHERE_TYPE.FAMILY_INVENTORY, self:getRealFamilyInvenSlotNo(index)), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function Input_InventoryInfo_ShowEnchantInvenTooltip(index, isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(WHERE_TYPE.ENCHANT_INVENTORY, self:getRealEnchantInvenSlotNo(index)), Defines.TooltipTargetType.Item, _panel:GetPosX() - self._screenGapSizeX, nil, "Inventory")
  PaGlobalFunc_FloatingTooltip_Close()
end
function InputDrag_InventoryInfo_FamilyInvenDrag(index)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self:getRealFamilyInvenSlotNo(index)
  if MessageBoxGetShow() then
    return
  end
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local whereType = WHERE_TYPE.FAMILY_INVENTORY
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemType = itemSSW:getItemType()
    local isTradeItem = itemSSW:isTradeAble()
    DragManager:setDragInfo(_panel, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), Inventory_GroundClick, getSelfPlayer():getActorKey())
    if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() then
      QuickSlot_ShowBackGround()
    end
    Item_Move_Sound(itemWrapper)
  end
end
function InputDrag_InventoryInfo_EnchantInvenDrag(index)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self:getRealEnchantInvenSlotNo(index)
  if MessageBoxGetShow() then
    return
  end
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local whereType = WHERE_TYPE.ENCHANT_INVENTORY
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemType = itemSSW:getItemType()
    local isTradeItem = itemSSW:isTradeAble()
    DragManager:setDragInfo(_panel, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), Inventory_GroundClick, getSelfPlayer():getActorKey())
    if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() then
      QuickSlot_ShowBackGround()
    end
    Item_Move_Sound(itemWrapper)
  end
end
function InputMRUp_InventoryInfo_FamilyInvenSlot_UseItem(index)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self:getRealFamilyInvenSlotNo(index)
  if DragManager:isDragging() then
    if DragManager.dragWhereTypeInfo == CppEnums.ItemWhereType.eFamilyInventory and PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleFamilyInventory) == false then
      inventory_swapItem(CppEnums.ItemWhereType.eFamilyInventory, DragManager.dragSlotInfo, slotNo)
    end
    DragManager:clearInfo()
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper or true == itemWrapper:empty() then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  local itemStatic = itemEnchantWrapper:get()
  if nil ~= itemStatic then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  if selfPlayerWrapper:get():doRideMyVehicle() and itemStatic:isUseToVehicle() then
    inventoryUseItem(itemWhereType, slotNo, itemEnchantWrapper:getEquipSlotNo(), false)
    return
  end
  if true == _ContentsGroup_HopeGauge and true == itemStatic:isItemCollectionScroll() then
    Panel_Tooltip_Item_hideTooltip()
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_TooltipInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
    PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(itemWhereType, slotNo, itemEnchantWrapper:getGradeType())
  elseif true == itemEnchantWrapper:isPopupItem() then
    PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, itemWhereType, slotNo, nil)
  elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
    ConnectUI(itemWrapper:getStaticStatus():getConnectUi(), itemWrapper:get():getKey():getItemKey())
  elseif false == itemStatic:isUseToVehicle() then
    Inventory_UseItemTargetSelf(itemWhereType, slotNo, nil)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
  end
end
function InputMRUp_InventoryInfo_EnchantInvenSlot_UseItem(index)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local slotNo = self:getRealEnchantInvenSlotNo(index)
  if DragManager:isDragging() then
    if DragManager.dragWhereTypeInfo == CppEnums.ItemWhereType.eEnchantInventory and PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ConsoleEnchantInventory) == false then
      inventory_swapItem(CppEnums.ItemWhereType.eEnchantInventory, DragManager.dragSlotInfo, slotNo)
    end
    DragManager:clearInfo()
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper or true == itemWrapper:empty() then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  local itemStatic = itemEnchantWrapper:get()
  if nil ~= itemStatic then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  if selfPlayerWrapper:get():doRideMyVehicle() and itemStatic:isUseToVehicle() then
    inventoryUseItem(itemWhereType, slotNo, itemEnchantWrapper:getEquipSlotNo(), false)
    return
  end
  if true == _ContentsGroup_HopeGauge and true == itemStatic:isItemCollectionScroll() then
    Panel_Tooltip_Item_hideTooltip()
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_TooltipInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
    PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(itemWhereType, slotNo, itemEnchantWrapper:getGradeType())
  elseif self._rClickFunc ~= nil then
    self._rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), __eItemWhereTypeEnchantInventory)
  elseif true == itemEnchantWrapper:isPopupItem() then
    PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, itemWhereType, slotNo, nil)
  elseif eConnectUiType.eConnectUi_Undefined ~= itemWrapper:getStaticStatus():getConnectUi() then
    ConnectUI(itemWrapper:getStaticStatus():getConnectUi(), itemWrapper:get():getKey():getItemKey())
  elseif false == itemStatic:isUseToVehicle() then
    Inventory_UseItemTargetSelf(itemWhereType, slotNo, nil)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
  end
end
function InputMRUp_InventoryInfo_MoveItemToFamilyOrEnchantInventory(slotNo)
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  if PaGlobal_Inventory_All_ForConsole._isShowFamilyInven == true then
    local itemCount = 0
    local itemWhereType = Inventory_GetCurrentInventoryType()
    local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
    if nil == itemWrapper then
      return
    end
    itemCount = itemWrapper:get():getCount_s64()
    if Defines.s64_const.s64_1 == itemCount then
      PaGlobal_FamilyInvnetory_PushItemToFamilyInventory(1, slotNo, itemWhereType)
    else
      Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FamilyInvnetory_PushItemToFamilyInventory, false, itemWhereType)
    end
  elseif PaGlobal_Inventory_All_ForConsole._isShowEnchantInven == true then
    local itemCount = 0
    local itemWhereType = Inventory_GetCurrentInventoryType()
    local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
    if nil == itemWrapper then
      return
    end
    itemCount = itemWrapper:get():getCount_s64()
    if Defines.s64_const.s64_1 == itemCount then
      PaGlobal_EnchantInventory_PushItemToEnchantInventory(1, slotNo, itemWhereType)
    else
      Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_EnchantInventory_PushItemToEnchantInventory, false, itemWhereType)
    end
  end
end
function InputMRUp_InventoryInfo_FamilyInvenSlot_MoveItemFromFamilyInventory(index)
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local slotNo = PaGlobal_Inventory_All_ForConsole:getRealFamilyInvenSlotNo(index)
  local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(1, slotNo)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory)
  end
end
function InputMRUp_InventoryInfo_EnchantInvenSlot_MoveItemFromEnchantInventory(index)
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  local slotNo = PaGlobal_Inventory_All_ForConsole:getRealEnchantInvenSlotNo(index)
  local itemWhereType = CppEnums.ItemWhereType.eEnchantInventory
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_EnchantInventory_PopItemFromEnchantInventory(1, slotNo)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_EnchantInventory_PopItemFromEnchantInventory)
  end
end
function InputScroll_InventoryInfo_FamilyInventory(isUp)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotRows = math.ceil(self._familyinvenShowSlotCount / self._invenSlotColumnMax)
  local extraSlotCount = self._invenSlotColumnMax - self._famliyInvenMaxCapacity % self._invenSlotColumnMax
  local prevSlotIndex = self._familyInvenStartSlotIndex
  local nextSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_familyInven, isUp, slotRows, self._famliyInvenMaxCapacity + extraSlotCount, self._familyInvenStartSlotIndex, self._invenSlotColumnMax)
  if prevSlotIndex == nextSlotIndex then
    return
  end
  self._familyInvenStartSlotIndex = nextSlotIndex
  ToClient_padSnapIgnoreGroupMove()
  self:updateFamilyInventory()
end
function InputScroll_InventoryInfo_EnchantInventory(isUp)
  local self = PaGlobal_Inventory_All_ForConsole
  local slotRows = math.ceil(self._enchantInvenShowSlotCount / self._invenSlotColumnMax)
  local extraSlotCount = self._invenSlotColumnMax - self._enchantInvenMaxCapacity % self._invenSlotColumnMax
  local prevSlotIndex = self._enchantInvenStartSlotIndex
  local nextSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_enchantInven, isUp, slotRows, self._enchantInvenMaxCapacity + extraSlotCount, self._enchantInvenStartSlotIndex, self._invenSlotColumnMax)
  if prevSlotIndex == nextSlotIndex then
    return
  end
  self._enchantInvenStartSlotIndex = nextSlotIndex
  ToClient_padSnapIgnoreGroupMove()
  self:updateEnchantInventory()
end
function Inventory_ItemDelete_Check(count, slotNo, whereType)
  local self = PaGlobal_Inventory_All_ForConsole
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local itemName = itemWrapper:getStaticStatus():getName()
  self._deleteWhereType = whereType
  self._deleteSlotNo = slotNo
  self._deleteCount = count
  DragManager:clearInfo()
  local luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(count))
  local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  if ToClient_isTempCashItem(itemWrapper:getStaticStatus():get()._key) == true and itemWrapper:checkTimeover() == true then
    luaDeleteItemMsg = luaDeleteItemMsg .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_BUY_PERMANENTUSE_ITEM")
  end
  local messageContent = luaDeleteItemMsg
  local messageboxData = {
    title = luaDelete,
    content = messageContent,
    functionYes = Inventory_Delete_Yes,
    functionNo = Inventory_Delete_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function Inventory_Delete_Yes()
  local self = PaGlobal_Inventory_All_ForConsole
  if self._deleteSlotNo == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(self._deleteWhereType, self._deleteSlotNo)
  if nil == itemWrapper then
    return
  end
  if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local bagType = itemWrapper:getStaticStatus():getContentsEventParam1()
    local bagSize = itemWrapper:getStaticStatus():getContentsEventParam2()
    local isEmptyBag = false
    for index = 0, bagSize - 1 do
      local bagItemWrapper = getInventoryBagItemByType(self._deleteWhereType, self._deleteSlotNo, index)
      if nil ~= bagItemWrapper then
        if __eInventoryBagType_Cash == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT"))
        elseif __eInventoryBagType_Equipment == bagType then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT2"))
        else
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DELETEITEM_ALERT3"))
        end
        DragManager:clearInfo()
        Inventory_DropEscape()
        return
      end
    end
  end
  if itemWrapper:isCash() then
    PaymentPassword(Inventory_Delete_YesXXX)
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  Inventory_Delete_YesXXX()
  PaGlobal_TutorialManager:handleInventoryDelete(itemWrapper, self._deleteWhereType, self._deleteSlotNo)
end
function Inventory_Delete_YesXXX()
  local self = PaGlobal_Inventory_All_ForConsole
  if self._deleteSlotNo == nil then
    return
  end
  deleteItem(getSelfPlayer():getActorKey(), self._deleteWhereType, self._deleteSlotNo, self._deleteCount)
  local itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, self._deleteSlotNo)
  if nil ~= itemWrapper and itemWrapper:get():getCount_s64() == self._deleteCount then
    self._isSlotEmpty = true
  end
  Inventory_DropEscape()
  DragManager:clearInfo()
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Close()
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function Inventory_Delete_No()
  local self = PaGlobal_Inventory_All_ForConsole
  self._deleteWhereType = nil
  self._deleteSlotNo = nil
  DragManager:clearInfo()
end
function FromClient_InventoryInfo_EquipmentHaveChanged()
  local self = PaGlobal_Inventory_All_ForConsole
  self:updateEquipment()
  self:updateCostume()
  self:updateInventory()
  self:updateLifeEquipment()
end
function FromClient_InventoryInfo_EventEquipItem(slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  local type, index = PaGlobal_Inventory_All_ForConsole:getIndexFromSlotNo(slotNo)
  if type == nil or index == nil then
    return
  end
  local slot = {}
  if 0 == type then
    if nil ~= index then
      slot = self._ui.slot_equips[index]
      slot.icon:AddEffect("UI_ItemInstall", false, 0, 0)
    end
  elseif 1 == type then
    slot = self._ui.slot_costumes[index]
    slot.icon:AddEffect("UI_ItemInstall_Cash", false, 0, 0)
  elseif 2 == type then
    slot = self._ui.slot_lifeEquips[index]
    slot.icon:AddEffect("UI_ItemInstall", false, 0, 0)
  end
  slot.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
  self:updateAttackStat(true)
  self:updateUnderwearSlot(slotNo)
  if __eEquipSlotNoAlchemyStone == slotNo then
    local autoActiveIsOn = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
    if true == autoActiveIsOn and nil ~= ToClient_getEquipmentItem(__eEquipSlotNoAlchemyStone) then
      ToClient_SetAlchemyStoneReuseNextTick(0)
    end
  end
end
function FromClient_InventoryInfo_OpenServantInven(actorKeyRaw)
  local self = PaGlobal_Inventory_All_ForConsole
  local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local siegeVehicle = {
    [1] = CppEnums.VehicleType.Type_ThrowStone,
    [2] = CppEnums.VehicleType.Type_PracticeCannon,
    [3] = CppEnums.VehicleType.Type_ThrowFire
  }
  local actorType = vehicleActor:getVehicleType()
  for index = 1, #siegeVehicle do
    if (vehicleActor:isCannon() or actorType == siegeVehicle[index]) and CppEnums.VehicleType.Type_SailingBoat ~= actorType then
      PaGlobalFunc_CannonInven_Open(actorKeyRaw)
      return
    end
  end
  if actorType == CppEnums.VehicleType.Type_CampingTent and nil ~= Panel_Window_CampWarehouse_All then
    PaGlobalFunc_CampWarehouse_All_Open(actorKeyRaw)
    self._campActorProxy = actorKeyRaw
    self._servantActorKeyRaw = {}
    self._servantActorKeyRaw[1] = self._campActorProxy
    PaGlobal_Inventory_All_ForConsole:open(UPPER_TAB_TYPE.SERVANT_TAB, nil, nil, false)
    return
  end
  self._servantActorKeyRaw = {}
  self._servantActorKeyRaw[1] = actorKeyRaw
  PaGlobal_Inventory_All_ForConsole:open(UPPER_TAB_TYPE.SERVANT_TAB, nil, nil, false)
end
function FromClient_InventoryInfo_ServantEquipOn(slotNo)
end
function FromClient_InventoryInfo_ServantEquipChanged()
  PaGlobal_Inventory_All_ForConsole:updateInventory()
  if nil ~= PaGlobal_Inventory_All_ForConsole._servantActorKeyRaw and nil ~= PaGlobal_Inventory_All_ForConsole._servantActorKeyRaw[1] then
    PaGlobal_Inventory_All_ForConsole:updateServantInven(PaGlobal_Inventory_All_ForConsole._servantActorKeyRaw[1])
    PaGlobal_Inventory_All_ForConsole:updateServantEquipOrCostume(true)
    PaGlobal_Inventory_All_ForConsole:updateServantEquipOrCostume(false)
  end
end
function FromClient_InventoryInfo_OnScreenResize()
  local self = PaGlobal_Inventory_All_ForConsole
  local screenY = getScreenSizeY()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
  end
  _panel:SetSize(_panel:GetSizeX(), screenY)
  self._screenGapSizeX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
end
function FromClient_InventoryInfo_WeightChanged()
  PaGlobal_Inventory_All_ForConsole:updateWeight()
end
function FromClient_InventoryInfo_updateInvenSlot()
  PaGlobal_Inventory_All_ForConsole:updateInventory()
  PaGlobal_Inventory_All_ForConsole:updateWeight()
  PaGlobal_Inventory_All_ForConsole:updateFamilyInventory()
  PaGlobal_Inventory_All_ForConsole:updateEnchantInventory()
end
function FromClient_InventoryInfo_SetShow(isShow)
  if false == isShow then
    PaGlobalFunc_Window_InventoryInfo_Close()
  else
    PaGlobal_Inventory_All_ForConsole:open(nil, nil, nil, false)
  end
end
function FromClient_InventoryInfo_SetShowWithFilter(actorType)
  PaGlobalFunc_InventoryInfo_Open()
  if CppEnums.ActorType.ActorType_Player == actorType or CppEnums.ActorType.ActorType_Deadbody == actorType then
    Inventory_SetFunctor(InvenFiler_InterActionDead, Inventory_UseItemTarget, InventoryWindow_Close, nil)
  elseif CppEnums.ActorType.ActorType_Vehicle == actorType then
    Inventory_SetFunctor(InvenFiler_InterActionFodder, Inventory_UseItemTarget, InventoryWindow_Close, nil)
  elseif CppEnums.ActorType.ActorType_Npc == actorType then
    Inventory_SetFunctor(InvenFiler_InterActionFuel, Inventory_UseFuelItem, InventoryWindow_Close, nil)
  end
end
function FromClient_InventoryInfo_UnequipItem(whereType, slotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil == itemStatic then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(2, 0)
end
function FromClient_InventoryInfo_UseItemAskFromOtherPlayer(fromName)
  if MessageBoxGetShow() then
    MessageBox_Empty_function()
    allClearMessageData()
  end
  local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_REQUEST", "for_name", fromName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_TITLE"),
    content = messageboxMemo,
    functionYes = UseItemFromOtherPlayer_Yes,
    functionCancel = UseItemFromOtherPlayer_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function UseItemFromOtherPlayer_Yes()
  useItemFromOtherPlayer(true)
end
function UseItemFromOtherPlayer_No()
  useItemFromOtherPlayer(false)
end
function FromClient_InventoryInfo_FindExchangeItemNPC()
  local itemEnchantKey = getSelfPlayer():get():getCurrentFindExchangeItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil == itemSSW then
    return
  end
  FindExchangeItemNPC(itemSSW)
end
function FromClient_InventoryInfo_updateSlotDatabyAddItem()
  if true == PaGlobalFunc_Window_InventoryInfo_isOpened() then
    Inventory_updateSlotData()
  end
end
function FromClient_InventoryInfo_ResistChanged()
  PaGlobal_Inventory_All_ForConsole:updateInformation()
end
function FromClient_InventoryInfo_PotentialChanged()
  PaGlobal_Inventory_All_ForConsole:updateInformation()
end
function FromClient_InventoryInfo_FitnessChanged()
  PaGlobal_Inventory_All_ForConsole:updateInformation()
end
function FromClient_InventoryInfo_PadSnapChangePanel(fromPanel, toPanel)
  if nil ~= toPanel and true == _panel:GetShow() then
    if _panel:GetKey() ~= toPanel:GetKey() then
      if true == _ContentsGroup_RenewUI_Tooltip then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
      _snappedOnThisPanel = false
      _panel:registerPadEvent(__eConsoleUIPadEvent_LB, "")
      _panel:registerPadEvent(__eConsoleUIPadEvent_RB, "")
      _panel:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
    else
      _snappedOnThisPanel = true
      _panel:registerPadEvent(__eConsoleUIPadEvent_LB, "Toggle_InventoryTab_forPadEventFunc(-1)")
      _panel:registerPadEvent(__eConsoleUIPadEvent_RB, "Toggle_InventoryTab_forPadEventFunc(1)")
      PaGlobal_Inventory_All_ForConsole:refreshSortKeyguide()
    end
  end
end
function FromClient_InventoryInfo_PadSnapChangeTarget(fromControl, toControl)
  local self = PaGlobal_Inventory_All_ForConsole
  self._ui.ref_snapTarget = toControl
  if nil == toControl or false == toControl:GetShow() or _panel:GetID() ~= toControl:GetParentPanel():GetID() or UPPER_TAB_TYPE.INFORMATION_TAB == self._currentUpperTab then
    self._ui.stc_snapEffect:SetShow(false)
    self:setKeyGuide(nil)
  else
    self:setKeyGuide(toControl:GetID())
    self._snapEffectAniFlag = true
    self._sinCurveTheta = 0
    self._ui.stc_snapEffect:SetShow(true)
  end
end
function PaGlobal_Inventory_All_ForConsole:setKeyGuideWithTab()
  if nil ~= self._filterFunc or nil ~= self._rClickFunc then
    self._ui.stc_bottomBG:SetShow(false)
    self._ui.stc_bottomBG_setFunctor:SetShow(true)
  else
    self._ui.stc_bottomBG:SetShow(true)
    self._ui.stc_bottomBG_setFunctor:SetShow(false)
  end
  self:alignKeyGuide()
end
function PaGlobal_Inventory_All_ForConsole:hideKeyGuide()
  self._ui.stc_bottomBG:SetShow(false)
  self._ui.stc_bottomBG_setFunctor:SetShow(false)
end
function PaGlobal_Inventory_All_ForConsole:setKeyGuide(controlName)
  if nil == controlName then
    self:hideKeyGuide()
  else
    self:setKeyGuideWithTab()
    local numStart, numEnd = string.find(controlName, "%d+")
    if nil ~= numStart then
      controlName = string.sub(controlName, 1, numStart - 1)
    end
    local data = _keyGuideData[controlName]
    if nil == data then
      return
    end
    for ii = 1, #self._keyGuideList do
      if nil == data[ii] then
        self._keyGuideList[ii]:SetShow(true)
        self._keyGuideList[ii]:SetText(_keyGuideData.InventoryInfo_InvenSlotBG_[ii])
      elseif false == data[ii] then
        self._keyGuideList[ii]:SetShow(false)
      elseif ii == KEY_GUIDE_TYPE.RT then
        self._keyGuideList[ii]:SetShow(PaGlobalFunc_Inventory_All_familyInventoryIsActive() or _ContentsGroup_EnchantRemaster == true)
        self._keyGuideList[ii]:SetText(data[ii])
      elseif ii == KEY_GUIDE_TYPE.LS_CLICK then
        self._keyGuideList[ii]:SetShow(not self._isShowFamilyInven and not self._isShowEnchantInven)
      elseif ii == KEY_GUIDE_TYPE.LT then
        self._keyGuideList[ii]:SetShow(ToClient_isShowBlackSpiritInventory())
      elseif ii == KEY_GUIDE_TYPE.RT_A then
        if _ContentsGroup_AccessoryStepUp == true and PaGlobal_Window_Accessory_StepUp_All_CheckDoAccessoryStepUp() == true then
          self._keyGuideList[ii]:SetShow(true)
          _panel:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "PaGlobal_Window_Accessory_StepUp_All_Open()")
        else
          self._keyGuideList[ii]:SetShow(false)
          _panel:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "")
        end
      else
        self._keyGuideList[ii]:SetText(data[ii])
        self._keyGuideList[ii]:SetShow(true)
      end
    end
    if nil ~= data.updateFunc and "function" == type(data.updateFunc) then
      data.updateFunc()
    end
  end
  self:alignKeyGuide()
end
function Input_InventoryInfo_InvenSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index or nil == self._ui.slot_inven[index] or nil == self._ui.slot_inven[index].slotNo then
    return
  end
  local slotNo = self._ui.slot_inven[index].slotNo
  local itemWrapper = getInventoryItemByType(PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType, slotNo)
  local selectable = nil ~= slotNo and nil ~= itemWrapper and self._ui.slot_inven[index].icon:IsEnable() and self._ui.slot_inven[index].icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideA2:SetShow(selectable and PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.ColsoleInventory) == false)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_InvenSlotBG_[KEY_GUIDE_TYPE.A])
  self._ui.txt_keyGuideLTY:SetShow(selectable)
end
function Input_InventoryInfo_EquipSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index then
    return
  end
  local slotNo = _equipSlotNo[index]
  local slot = self._ui.slot_equips[index]
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  local selectable = nil ~= itemWrapper and nil ~= slot and slot.icon:IsEnable() and slot.icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_InvenSlotBG_[KEY_GUIDE_TYPE.A])
  if Defines.UIMode.eUIMode_Repair == GetUIMode() then
    if Panel_Window_Endurance_Recovery_All:GetShow() and selectable then
      self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_InvenSlotBG_[KEY_GUIDE_TYPE.A])
    elseif selectable then
      self._ui.txt_keyGuideSetFunctorA:SetText(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_REPAIR"))
    end
  end
  local isEffectKeyGuideShow = slot.chk_toggleButton ~= nil and slot.chk_toggleButton:GetShow() == true
  self._ui.txt_keyGuideY:SetShow(isEffectKeyGuideShow)
  if isEffectKeyGuideShow == true then
    self._ui.txt_keyGuideY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CONSOLE_EQUIP_INVENTORY_EFFECTSWITCH"))
  end
end
function Input_InventoryInfo_CostumeSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index then
    return
  end
  local slotNo = _costumeSlotNo[index]
  local slot = self._ui.slot_costumes[index]
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  local selectable = nil ~= itemWrapper and nil ~= slot and slot.icon:IsEnable() and slot.icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideY:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_CostumeSlotBG_[KEY_GUIDE_TYPE.A])
end
function Input_InventoryInfo_ServantInvenSlotKeyGuide()
  if not _isInitialized then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index or nil == self._servantActorKeyRaw or nil == self._servantActorKeyRaw[1] then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._servantActorKeyRaw[1])
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local vehicleInven = vehicleActor:getInventory()
  if nil == vehicleInven then
    return
  end
  local fullCount = vehicleInven:size() - __eTInventorySlotNoUseStart
  if index > fullCount then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(self._servantActorKeyRaw[1], index - 1 + __eTInventorySlotNoUseStart)
  local selectable = nil ~= itemWrapper and self._ui.slot_servantInven[index].icon:IsEnable() and self._ui.slot_servantInven[index].icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_ServantInvenSlotBG_[KEY_GUIDE_TYPE.A])
end
function Input_InventoryInfo_ServantEquipSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index or nil == self._servantActorKeyRaw or nil == self._servantActorKeyRaw[1] then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local slot = self._ui.slot_servantEquip[index]
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == dataType then
    return
  end
  local slotNo = _servantData[dataType].equipSlotNoList[index]
  if nil == slotNo then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  local selectable = nil ~= itemWrapper and slot.icon:IsEnable() and slot.icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_ServantEquipSlotBG_[KEY_GUIDE_TYPE.A])
  chkButton = self._ui.slot_servantEquip[index].chk_toggleButton
  self._ui.txt_keyGuideY:SetShow(selectable and chkButton:GetShow())
end
function Input_InventoryInfo_ServantCostumeSlotKeyGuide()
  local self = PaGlobal_Inventory_All_ForConsole
  local index = self:getSnappedControlsIndex()
  if nil == index or nil == self._servantActorKeyRaw or nil == self._servantActorKeyRaw[1] then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKeyRaw[1])
  if nil == servantWrapper then
    return
  end
  local slot = self._ui.slot_servantCostume[index]
  local vehicleType = servantWrapper:getVehicleType()
  local dataType = _vehicleTypeToSERVANT_TYPE[vehicleType]
  if nil == dataType then
    return
  end
  local slotNo = _servantData[dataType].costumeSlotNoList[index]
  if nil == slotNo then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  local selectable = nil ~= itemWrapper and slot.icon:IsEnable() and slot.icon:GetShow()
  self._ui.txt_keyGuideA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetShow(selectable)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.InventoryInfo_ServantCostumeSlotBG_[KEY_GUIDE_TYPE.A])
  chkButton = self._ui.slot_servantCostume[index].chk_toggleButton
  self._ui.txt_keyGuideY:SetShow(selectable and chkButton:GetShow())
end
function Input_InventoryInfo_ToggleFive()
  local self = PaGlobal_Inventory_All_ForConsole
  self._ui.txt_keyGuideA:SetShow(true)
  self._ui.txt_keyGuideSetFunctorA:SetShow(true)
  self._ui.txt_keyGuideSetFunctorA:SetText(_keyGuideData.CheckButton_Costume_[KEY_GUIDE_TYPE.A])
end
function Inventory_SetShow(isInvenShow)
  if not isInvenShow then
    InventoryWindow_Close()
    Panel_Tooltip_Item_hideTooltip()
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_TooltipInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
    PaGlobal_TutorialUiManager:getUiMasking():hideQuestMasking()
  else
    InventoryWindow_Show()
  end
end
function PaGlobalFunc_InventoryInfo_InitMultipleSelect()
  return PaGlobal_Inventory_All_ForConsole:initMultipleSelect()
end
function PaGlobal_Inventory_All_ForConsole:initMultipleSelect(updateInventory)
  self._multipleSelect = {}
  self._multipleSelect = {
    [CppEnums.ItemWhereType.eInventory] = {},
    [CppEnums.ItemWhereType.eCashInventory] = {}
  }
  for ii = 1, __eTInventorySlotNoMax do
    self._multipleSelect[CppEnums.ItemWhereType.eInventory][ii] = false
  end
  for ii = 1, __eTCashInventorySlotNoMax do
    self._multipleSelect[CppEnums.ItemWhereType.eCashInventory][ii] = false
  end
  if updateInventory and true == _panel:GetShow() and UPPER_TAB_TYPE.INFORMATION_TAB ~= self._currentUpperTab then
    self:updateInventory()
  end
end
function PaGlobal_Inventory_All_ForConsole:getMultipleSelect()
  local rv = {}
  for ii = 1, #self._multipleSelect[CppEnums.ItemWhereType.eInventory] do
    if true == self._multipleSelect[CppEnums.ItemWhereType.eInventory] then
      rv[#rv + 1] = {}
      rv[#rv + 1].slotNo = ii
      rv[#rv + 1].whereType = CppEnums.ItemWhereType.eInventory
    end
  end
  for ii = 1, #self._multipleSelect[CppEnums.ItemWhereType.eCashInventory] do
    if true == self._multipleSelect[CppEnums.ItemWhereType.eCashInventory] then
      rv[#rv + 1] = {}
      rv[#rv + 1].slotNo = ii
      rv[#rv + 1].whereType = CppEnums.ItemWhereType.eCashInventory
    end
  end
  return rv
end
function PaGlobal_Inventory_All_ForConsole:handleCompleteMultipleSelection()
  if not self._optionalPadEventFunc then
    return
  end
  local multipleSelectInfo = self:getMultipleSelect()
  self._optionalPadEventFunc(multipleSelectInfo)
end
function PaGlobalFunc_InventoryInfo_HandleCompleteMultipleSelection()
  return PaGlobal_Inventory_All_ForConsole:handleCompleteMultipleSelection()
end
function PaGlobalFunc_InventoryInfo_ToggleMultipleSelect(slotNo, whereType)
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == slotNo or nil == whereType then
    return
  end
  if nil == self._multipleSelect[whereType] then
    return
  end
  self._multipleSelect[whereType][slotNo] = true ~= self._multipleSelect[whereType][slotNo]
  self:updateInventory()
end
function Inventory_SetFunctor(filterFunction, rClickFunction, otherWindowOpenFunction, effect, optionalPadEvent)
  if _ContentsGroup_SpiritGroupEnchant == true and ToClient_IsGroupEnchantAble() == true and PaGlobal_PartyEnchant._isAnimating == true and filterFunction == nil then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  DragManager:clearInfo()
  if nil ~= self._otherWindowOpenFunc and nil ~= otherWindowOpenFunction then
    local otherWindowOpenFuncDiff = otherWindowOpenFunction ~= self._otherWindowOpenFunc
    if otherWindowOpenFuncDiff and (nil ~= filterFunction or nil ~= rClickFunction or nil ~= otherWindowOpenFunction) then
      self._otherWindowOpenFunc()
    end
  end
  if nil ~= filterFunction and "function" ~= type(filterFunction) then
    filterFunction = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= rClickFunction and "function" ~= type(rClickFunction) then
    rClickFunction = nil
    UI.ASSERT(false, "Param 2 must be Function type")
  end
  if nil ~= otherWindowOpenFunction and "function" ~= type(otherWindowOpenFunction) then
    otherWindowOpenFunction = nil
    UI.ASSERT(false, "Param 3 must be Function type")
  end
  if nil ~= effect and "function" ~= type(effect) then
    effect = nil
    UI.ASSERT(false, "Param 4 must be Function type")
  end
  if nil ~= rClickFunction and "function" == type(rClickFunction) then
    self._ui.stc_bottomBG:SetShow(false)
    if nil ~= optionalPadEvent and nil ~= optionalPadEvent.func and "function" == type(optionalPadEvent.func) then
      self._optionalPadEventFunc = optionalPadEvent.func
      self._optionalPadEventButton = __eConsoleUIPadEvent_Y
      _panel:registerPadEvent(self._optionalPadEventButton, "PaGlobalFunc_InventoryInfo_HandleCompleteMultipleSelection()")
      PaGlobalFunc_SetKeyGuideUVTo(self._ui.txt_keyGuideSetFunctorY, self._optionalPadEventButton)
      self._ui.txt_keyGuideSetFunctorY:SetShow(true)
      self._ui.txt_keyGuideSetFunctorY:SetText(PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK"))
      if nil ~= optionalPadEvent.keyGuideString then
        self._ui.txt_keyGuideSetFunctorY:SetText(tostring(optionalPadEvent.keyGuideString))
      end
    end
  else
    self._ui.stc_bottomBG:SetShow(true)
  end
  if nil == optionalPadEvent then
    if nil ~= self._optionalPadEventButton then
      _panel:registerPadEvent(self._optionalPadEventButton, "")
    end
    self._optionalPadEventFunc = nil
    self._optionalPadEventButton = nil
    self._ui.txt_keyGuideSetFunctorY:SetShow(false)
  end
  local isEnchantOpen = _ContentsGroup_EnchantRemaster and Panel_Widget_Enchant_Main_All:GetShow()
  if isEnchantOpen == false and (self._isShowFamilyInven == true or self._isShowEnchantInven == true) then
    self._ui.txt_keyGuideSetFunctorRT:SetShow(true)
    self._ui.txt_keyGuideSetFunctorY:SetShow(true)
    self._ui.txt_keyGuideSetFunctorY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAMILYINVENTORY_MOVEITEM"))
  else
    self._ui.txt_keyGuideSetFunctorRT:SetShow(PaGlobalFunc_Inventory_All_familyInventoryIsActive() or _ContentsGroup_EnchantRemaster == true)
    if Panel_Window_ItemMoveSet ~= nil and Panel_Window_ItemMoveSet:GetShow() == true then
      self._ui.txt_keyGuideSetFunctorRT:SetShow(false)
    end
  end
  self._otherWindowOpenFunc = otherWindowOpenFunction
  self._rClickFunc = rClickFunction
  self._filterFunc = filterFunction
  self._effect = effect
  if PaGlobalFunc_InventoryInfo_GetShow() then
    self:updateInventory()
  end
end
local inventoryDragNoUseList
function FGlobal_SetInventoryDragNoUse(pPanel)
  inventoryDragNoUseList = pPanel
end
function Input_InventoryInfo_CustomItemAction(index)
  if true == _ContentsGroup_RenewUI then
    return
  end
  if false == isGameTypeKorea() then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local slotNo = self._ui.slot_inven[index].slotNo
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  if true == itemWrapper:empty() then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local itemConnectUi = itemEnchantWrapper:getConnectUi()
  local itemKey = itemWrapper:get():getKey():getItemKey()
end
function PaGlobalFunc_InventoryInfo_CurrentTabIsServant()
  return UPPER_TAB_TYPE.SERVANT_TAB == PaGlobal_Inventory_All_ForConsole._currentUpperTab
end
function Inventory_GetToopTipItem()
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == self._tooltipWhereType then
    return nil
  end
  if nil == self._tooltipSlotNo then
    return nil
  end
  local wrapper = getInventoryItemByType(self._tooltipWhereType, self._tooltipSlotNo)
  if nil == wrapper then
  end
  return wrapper
end
function Inventory_GetToolTipItemSlotNo()
  local self = PaGlobal_Inventory_All_ForConsole
  if nil == self._tooltipWhereType then
    return nil
  end
  if nil == self._tooltipSlotNo then
    return nil
  end
  return self._tooltipSlotNo
end
function FGlobal_CheckUnderwear()
  local self = PaGlobal_Inventory_All_ForConsole
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  if not isSafeZone then
    self._ui.chk_showUnderwear:SetCheck(false)
  end
end
function PaGlobalFunc_InventoryInfo_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, getInventoryItemByType, Inventory_GetCurrentInventoryType())
end
function Inventory_GetCurrentInventory()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(Inventory_GetCurrentInventoryType())
  return inventory
end
function Inventory_GetCurrentInventoryType()
  local self = PaGlobal_Inventory_All_ForConsole
  if LOWER_TAB_TYPE.UNDEFINED == self._currentLowerTab then
    return PaGlobal_Inventory_All_ForConsole._lowerTabData[LOWER_TAB_TYPE.INVENTORY_TAB].whereType
  else
    return PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  end
end
function Inventory_GetStartIndex()
  return PaGlobal_Inventory_All_ForConsole._invenStartSlotIndex
end
function getInventory_RealSlotNo(index)
  local self = PaGlobal_Inventory_All_ForConsole
  local isCategoryView = PaGlobal_Inventory_All_ForConsole_IsCategoryShow()
  if isCategoryView == true then
    return index
  end
  if nil == self._ui.slot_inven[index] then
    return index
  end
  return self._ui.slot_inven[index].slotNo
end
function Global_GetInventorySlotNoByNotSorted(fromIndex)
  if nil == fromIndex then
    return
  end
  local isCategoryView = PaGlobal_Inventory_All_ForConsole_IsCategoryShow()
  if isCategoryView == true then
    return fromIndex
  end
  if fromIndex > PaGlobal_Inventory_All_ForConsole._invenSlotCount then
    return nil
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local toSlotNo = self._ui.slot_inven[fromIndex].slotNo
  return toSlotNo
end
function FGlobal_AccSlotNo(itemWrapper, isChange)
  local self = PaGlobal_Inventory_All_ForConsole
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  local firstRingOffence = 0
  local firstRingDeffence = 0
  local secondRingOffence = 0
  local secondRingDeffence = 0
  local acc
  if 16 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(8)
    equipItemWrapper2 = ToClient_getEquipmentItem(9)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 8 + self._slotRingIndex
      if isChange then
        if 0 == self._slotRingIndex then
          self._slotRingIndex = 1
        else
          self._slotRingIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      self._slotRingIndex = 0
      acc = 8
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      self._slotRingIndex = 0
      acc = 9
    else
      self._slotRingIndex = 0
      acc = 8
    end
  elseif 17 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(10)
    equipItemWrapper2 = ToClient_getEquipmentItem(11)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 10 + self._slotEarringIndex
      if isChange then
        if 0 == self._slotEarringIndex then
          self._slotEarringIndex = 1
        else
          self._slotEarringIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 10
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = 11
    else
      acc = 10
    end
  end
  return acc
end
local isFirstSummonItemUse = false
function Inventory_UseItemTargetSelf(whereType, slotNo, equipSlotNo)
  local self = PaGlobal_Inventory_All_ForConsole
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if itemKey >= 41548 and itemKey <= 41570 or itemKey >= 42000 and itemKey <= 42010 or itemKey >= 42034 and itemKey <= 42040 or 42053 == itemKey or 42054 == itemKey then
    _AudioPostEvent_SystemUiForXBOX(0, 14)
  end
  if nil == equipSlotNo then
    equipSlotNo = __eEquipSlotNoCount
  end
  inventoryUseItem(whereType, slotNo, equipSlotNo, true)
  if (42000 == itemKey or 42001 == itemKey or 42002 == itemKey or 42010 == itemKey or 42003 == itemKey or 42004 == itemKey or 42034 == itemKey or 42035 == itemKey or 42037 == itemKey or 42036 == itemKey or 42006 == itemKey or 42008 == itemKey or 42039 == itemKey or 42038 == itemKey or 42007 == itemKey or 42053 == itemKey or 41610 == itemKey or 42009 == itemKey or 42054 == itemKey or 42057 == itemKey or 42061 == itemKey or 42066 == itemKey or 42055 == itemKey or 42056 == itemKey) and false == _ContentsGroup_RenewUI_Tutorial and PaGlobal_SummonBossTutorial_Manager:isDoingSummonBossTutorial() then
    isFirstSummonItemUse = true
  end
  if itemKey == 724051 and PaGlobalFunc_AbyssOne_SkillNakMessage_Open ~= nil then
    PaGlobalFunc_AbyssOne_SkillNakMessage_Open(5)
  end
end
function Inventory_UseItemTargetSelfForFamilyInven(slotNo, itemWrapper, count_s64, inventoryType)
  if PaGlobal_Inventory_All_ForConsole:checkRestrictedAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
end
function FGlobal_FirstSummonItemUse()
  return isFirstSummonItemUse
end
function Inventory_UseItemTarget(slotNo, itemWrapper, count_s64, inventoryType)
  if PaGlobal_Inventory_All_ForConsole:checkRestrictedAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  local isTargetSelfPlayer = false
  inventoryUseItem(inventoryType, slotNo, isTargetSelfPlayer)
end
function PaGlobal_Inventory_All_ForConsole:addEffectBlackStone(ii, isFiltered, slotNo)
  local slot = self._ui.slot_inven[ii]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  local Panel_Inventory_isBlackStone_16002 = false
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if 16001 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura01", true, 0, 0)
    end
    Panel_Inventory_isBlackStone_16001 = true
  elseif 16002 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura02", true, 0, 0)
    end
    Panel_Inventory_isBlackStone_16002 = true
  end
  return Panel_Inventory_isBlackStone_16002
end
function PaGlobal_Inventory_All_ForConsole:addEffectMapea(ii, slotNo)
  local slot = self._ui.slot_inven[ii]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  if GetUIMode() == Defines.UIMode.eUIMode_Stable and not EffectFilter_Mapae(slotNo, itemWrapper) then
    slot.icon:AddEffect("fUI_HorseNameCard01", true, 0, 0)
  end
end
local _hpPotionKeys = {
  502,
  513,
  514,
  517,
  518,
  519,
  524,
  525,
  528,
  529,
  530,
  538,
  551,
  552,
  553,
  554,
  555,
  17568,
  17569,
  19932,
  19933,
  19934,
  19935
}
local _mpPotionKeys = {
  503,
  515,
  516,
  520,
  521,
  522,
  526,
  527,
  531,
  532,
  533,
  540,
  561,
  562,
  563,
  564,
  565,
  17570,
  17571,
  19936,
  19937,
  19938
}
function PaGlobal_Inventory_All_ForConsole:autoSetPotion(playerLevel, itemKey, currentWhereType, slotNo)
  if playerLevel <= 10 then
    local hpPotionFound = false
    for ii = 1, #_hpPotionKeys do
      if itemKey == _hpPotionKeys[ii] then
        hpPotionFound = true
        break
      end
    end
    if hpPotionFound then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 0)
      return
    end
    local mpPotionFound = false
    for ii = 1, #_mpPotionKeys do
      if itemKey == _mpPotionKeys[ii] then
        mpPotionFound = true
        break
      end
    end
    if mpPotionFound then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 1)
    end
  end
end
function InvenFiler_InterActionDead(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return itemWrapper:getStaticStatus():get():isItemTargetAlive() or not itemWrapper:checkConditions()
end
function InvenFiler_InterActionFodder(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not itemWrapper:getStaticStatus():get():isUseToVehicle() or not itemWrapper:checkConditions()
end
function InvenFiler_InterActionFuel(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not isFusionItem(Inventory_GetCurrentInventoryType(), slotNo)
end
function Inventory_UseFuelItem(slotNo, itemWrapper, count_s64, inventoryType)
  burnItemToActor(inventoryType, slotNo, 1, false)
end
Panel_Inventory_CoolTime_Effect_Item_Slot:RegisterShowEventFunc(true, "Inventory_ItemCoolTimeEffect_ShowAni()")
function Inventory_ItemCoolTimeEffect_ShowAni()
  local coolTime_Hide = UIAni.AlphaAnimation(0, Panel_Inventory_CoolTime_Effect_Item_Slot, 0, 0.7)
  coolTime_Hide:SetHideAtEnd(true)
end
function FindExchangeItemNPC(itemSSW)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local selfPosition = float3(selfProxy:getPositionX(), selfProxy:getPositionY(), selfProxy:getPositionZ())
  local itemKey = itemSSW:get()._key:get()
  local npcPosition = {}
  local minIndex = 0
  local minDistance = 0
  ToClient_DeleteNaviGuideByGroup(0)
  local count = itemSSW:getExchangeItemNPCInfoListCount()
  for index = 0, count - 1 do
    local spawnData = npcByCharacterKey_getNpcInfo(itemSSW:getCharacterKeyByIdx(index), itemSSW:getDialogIndexByIdx(index))
    if nil ~= spawnData then
      local npcPos = spawnData:getPosition()
      npcPosition[index] = npcPos
      local distance = Util.Math.calculateDistance(selfPosition, npcPos)
      if 0 == index then
        minDistance = distance
      elseif distance < minDistance then
        minIndex = index
        minDistance = distance
      end
    end
  end
  for ii = 0, count - 1 do
    if ii ~= minIndex and nil ~= npcPosition[ii] then
      worldmapNavigatorStart(float3(npcPosition[ii].x, npcPosition[ii].y, npcPosition[ii].z), NavigationGuideParam(), false, false, true)
    end
  end
  if nil ~= npcPosition[minIndex] then
    worldmapNavigatorStart(float3(npcPosition[minIndex].x, npcPosition[minIndex].y, npcPosition[minIndex].z), NavigationGuideParam(), false, false, true)
  end
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  selfProxy:setCurrentFindExchangeItemEnchantKey(itemKey)
end
function PaGlobal_Inventory_All_ForConsole:compareSpec(whereType, slotNo, isAccessory)
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
  local offencePoint = (itemWrapper:getStaticStatus():getMinDamage(0) + itemWrapper:getStaticStatus():getMaxDamage(0)) / 2
  local defencePoint = itemWrapper:getStaticStatus():getDefence(0)
  local equipOffencePoint = 0
  local equipDefencePoint = 0
  local matchEquip = false
  local isEquip = itemWrapper:getStaticStatus():get()._usableClassType:isOn(classType)
  local isAwakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  if nil == isAwakenWeaponContentsOpen then
    isAwakenWeaponContentsOpen = false
  end
  if isEquip and not Panel_Window_Exchange:GetShow() then
    local equipType = itemWrapper:getStaticStatus():getEquipType()
    local firstRingOffence = 0
    local firstRingDeffence = 0
    local secondRingOffence = 0
    local secondRingDeffence = 0
    local matchEquip = true
    if 16 == equipType or 17 == equipType then
      local accSlotNo = FGlobal_AccSlotNo(itemWrapper, false)
      local equipItemWrapper = ToClient_getEquipmentItem(accSlotNo)
      if nil ~= equipItemWrapper then
        equipOffencePoint = (equipItemWrapper:getStaticStatus():getMinDamage(0) + equipItemWrapper:getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = equipItemWrapper:getStaticStatus():getDefence()
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      else
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      end
    elseif 15 == equipType or 18 == equipType then
      equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
      if nil ~= equipItemWrapper then
        equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(0) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence()
        matchEquip = true
      else
        equipOffencePoint = 0
        equipDefencePoint = 0
        matchEquip = true
      end
      return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
    end
    equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
    if nil ~= equipItemWrapper then
      equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence(0)
      if isEquip then
        local attackType = PaGlobal_Inventory_All_ForConsole:getClassAttackType(classType)
        if nil ~= attackType then
          offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
          equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(attackType) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(attackType)) / 2
          if __eClassType_Warrior == classType or __eClassType_Valkyrie == classType then
            defencePoint = itemWrapper:getStaticStatus():getDefence(0)
          end
          matchEquip = true
        end
      end
    elseif isEquip then
      local attackType = PaGlobal_Inventory_All_ForConsole:getClassAttackType(classType)
      if nil ~= attackType then
        offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
        defencePoint = itemWrapper:getStaticStatus():getDefence(0)
        matchEquip = true
      end
    end
    isAccessory = false
    return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory
  end
end
function PaGlobal_Inventory_All_ForConsole:getClassAttackType(classType)
  return NewClassData.newClass_CategoryType[classType]._attackType
end
function Inventory_updateSlotData(ignorePanelVisibility)
  PaGlobal_Inventory_All_ForConsole:updateInventory(ignorePanelVisibility)
end
function FGlobal_UpdateInventoryWeight()
  PaGlobal_Inventory_All_ForConsole:updateWeight()
end
function InventoryWindow_Close()
  PaGlobalFunc_InventoryInfo_Close()
end
function HandleClicked_InventoryWindow_Close()
  PaGlobalFunc_InventoryInfo_Close()
end
function Inven_FindPuzzle()
  PaGlobal_Inventory_All_ForConsole:findPuzzle()
end
function InventoryWindow_Show()
  PaGlobalFunc_InventoryInfo_Open()
end
function PaGlobal_Inventory_All_ForConsole:checkRestrictedAction()
  local isRestricted = checkManufactureAction() or checkAlchemyAction()
  return isRestricted
end
function Manufacture_On(slotNo)
  if nil ~= Panel_Window_Manufacture_All and Panel_Window_Manufacture_All:GetShow() then
    return
  end
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
    return
  end
  if 0 ~= ToClient_GetMyTeamNoRedBattleField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  end
  PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
end
function Note_On(itemKey)
  ProductNote_Item_ShowToggle(itemKey)
end
function HandleClickedWayPoint(slotNo)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  if not inventory:empty(slotNo) then
    local itemWrapper = getInventoryItem(slotNo)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    FindExchangeItemNPC(itemSSW)
  end
end
function FindNearestNPCShop()
  HandleClicked_TownNpcIcon_NaviStart(16, false)
end
function FindExchangeItemNPC(itemSSW)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local selfPosition = float3(selfProxy:getPositionX(), selfProxy:getPositionY(), selfProxy:getPositionZ())
  local itemKey = itemSSW:get()._key:get()
  local npcPosition = {}
  local minIndex = 0
  local minDistance = 0
  ToClient_DeleteNaviGuideByGroup(0)
  local count = itemSSW:getExchangeItemNPCInfoListCount()
  for index = 0, count - 1 do
    local spawnData = npcByCharacterKey_getNpcInfo(itemSSW:getCharacterKeyByIdx(index), itemSSW:getDialogIndexByIdx(index))
    if nil ~= spawnData then
      local npcPos = spawnData:getPosition()
      npcPosition[index] = npcPos
      local distance = Util.Math.calculateDistance(selfPosition, npcPos)
      if 0 == index then
        minDistance = distance
      elseif distance < minDistance then
        minIndex = index
        minDistance = distance
      end
    end
  end
  for ii = 0, count - 1 do
    if ii ~= minIndex and nil ~= npcPosition[ii] then
      worldmapNavigatorStart(float3(npcPosition[ii].x, npcPosition[ii].y, npcPosition[ii].z), NavigationGuideParam(), false, false, true)
    end
  end
  if nil ~= npcPosition[minIndex] then
    worldmapNavigatorStart(float3(npcPosition[minIndex].x, npcPosition[minIndex].y, npcPosition[minIndex].z), NavigationGuideParam(), false, false, true)
  end
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  selfProxy:setCurrentFindExchangeItemEnchantKey(itemKey)
end
function HandleClickedWidget(slotNo)
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  whereUseItemSlotNo = slotNo
  whereUseItemSSW = itemSSW
  FGlobal_WhereUseITemDirectionOpen(itemSSW, slotNo)
end
function HandleClickedUseItem(slotNo)
  if slotNo == nil then
    return
  end
  local inventoryType = Inventory_GetCurrentInventoryType()
  if inventoryType == nil then
    return
  end
  DrawWater_Check(false)
  Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
end
function HandleClickedRepeatUseItem(slotNo)
  if slotNo == nil then
    return
  end
  local inventoryType = Inventory_GetCurrentInventoryType()
  if inventoryType == nil then
    return
  end
  DrawWater_Check(true)
  Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
end
PaGlobal_Inventory = {_itemKeyForTutorial = nil, _isItemSlotRClickedForTutorial = false}
function PaGlobal_Inventory:addSlotEffectForTutorial(slot, effectString, isLoop, posX, posY)
  slot.icon:AddEffect(effectString, isLoop, posX, posY)
  PaGlobal_TutorialUiManager:getUiMasking():showInventoryMasking(slot.cooltime:GetParentPosX() - 8, slot.cooltime:GetParentPosY() - 8)
end
function PaGlobal_Inventory:setItemKeyForTutorial(itemKey)
  self._itemKeyForTutorial = itemKey
end
function PaGlobal_Inventory:clearItemKeyForTutorial(itemKey)
  self._itemKeyForTutorial = nil
end
function PaGlobal_Inventory:isItemSlotRClickedForTutorial()
  return self._isItemSlotRClickedForTutorial
end
function PaGlobal_Inventory:setIsitemSlotRClickedForTutorial(bool)
  PaGlobal_Inventory._isItemSlotRClickedForTutorial = bool
end
function PaGlobal_Inventory:findItemWrapper(itemWhereType, targetItemKey, targetEnchantLevel)
  local inventory = getSelfPlayer():get():getInventoryByType(itemWhereType)
  if nil == inventory then
    return false
  end
  local invenMaxSize = inventory:sizeXXX()
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItem(ii)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
      if itemKey == targetItemKey then
        if nil == targetEnchantLevel then
          return itemWrapper
        elseif nil ~= targetEnchantLevel and enchantLevel == targetEnchantLevel then
          return itemWrapper
        end
      end
    end
  end
  return nil
end
function FGlobal_UpdateInventorySlotData()
  PaGlobal_Inventory_All_ForConsole:updateInventory()
end
function Servant_GetActorKeyFromItemToolTip()
  PaGlobalFunc_InventoryInfo_GetServantActorKey()
end
function PaGlobalFunc_InventoryInfo_GetServantActorKey()
  if nil ~= PaGlobal_Inventory_All_ForConsole._servantActorKeyRaw then
    return PaGlobal_Inventory_All_ForConsole._servantActorKeyRaw[1]
  else
    return nil
  end
end
function FGlobal_AlchemyStonCheck()
  if false == PaGlobal_Inventory_All_ForConsole._ui.chk_autoActive:IsCheck() then
    return 0
  end
  local coolTime = PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()
  if coolTime > -1 then
    return coolTime + 3
  end
  coolTime = 0
  local equipAlchemyStoneCoolTime = ToClient_GetEquipAlchemyStoneCoolTime()
  if 0 == equipAlchemyStoneCoolTime then
    return coolTime
  end
  coolTime = equipAlchemyStoneCoolTime / 1000 + 2
  return coolTime
end
function PaGlobalFunc_Equipment_IsReuseTime(deltaTime)
  if 3 <= PaGlobal_Inventory_All_ForConsole._reuseAlchemyStoneCheckTime then
    PaGlobal_Inventory_All_ForConsole._reuseAlchemyStoneCheckTime = 0
    return true
  end
  PaGlobal_Inventory_All_ForConsole._reuseAlchemyStoneCheckTime = PaGlobal_Inventory_All_ForConsole._reuseAlchemyStoneCheckTime + deltaTime
  return false
end
function PaGlobalFunc_InventoryInfo_DetailWindowOpenToggle()
  if Panel_Window_Inventory_Detail == nil then
    return
  end
  if ToClient_isPlayingSequence() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if Panel_Window_Inventory_Detail:GetShow() == true then
    PaGlobal_InventoryEquip_Detail_Renew_Close()
  else
    if Panel_Npc_Dialog_All == nil or Panel_Npc_Dialog_All:GetShow() == false then
      PaGlobalFunc_Inventory_All_CloseSideUI(-1)
    end
    if Panel_CharacterInfo_All ~= nil and Panel_CharacterInfo_All:GetShow() == true then
      PaGlobal_CharacterStatNew_Close()
    end
    if PaGlobalFunc_InventoryInfo_GetShow() == false then
      InventoryWindow_Show()
    end
    PaGlobal_InventoryEquip_Detail_Renew_Open()
  end
end
function PaGlobalFunc_InventoryInfo_MyStatOpenToggle()
  if Panel_Window_StatNew_All == nil then
    return
  end
  if ToClient_isPlayingSequence() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  PaGlobal_CharacterStatNew_Toggle()
end
function PaGlobalFunc_InventoryInfo_ArtifactBagOpenToggle()
  if Panel_Window_Inventory_Detail == nil then
    return
  end
  if ToClient_isPlayingSequence() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  else
    if Panel_Npc_Dialog_All ~= nil and Panel_Npc_Dialog_All:GetShow() == true then
      return
    end
    PaGlobalFunc_Inventory_All_CloseSideUI(InventoryBottomOpenUIButtonIndex.LightStoneBag)
    if PaGlobal_Inventory_All_ForConsole._isShowFamilyInven == true then
      PaGlobal_FamilyInvnetoryShowToggle()
    end
    if PaGlobal_Inventory_All_ForConsole._isShowEnchantInven == true then
      PaGlobal_EnchantInventoryShowToggle()
    end
    if PaGlobal_WareHouse_All_GetShow() == true then
      PaGlobal_Warehouse_All_Close()
    end
    if Panel_Window_Inventory_Detail ~= nil and Panel_Window_Inventory_Detail:GetShow() == true then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
    end
    if PaGlobalFunc_InventoryInfo_GetShow() == false then
      InventoryWindow_Show()
    end
    PaGlobalFunc_LightStoneBag_Open()
  end
end
function PaGlobalFunc_InventoryInfo_CombineBagOpenToggle()
  if PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  else
    if Panel_Npc_Dialog_All ~= nil and Panel_Npc_Dialog_All:GetShow() == true then
      return
    end
    PaGlobalFunc_Inventory_All_CloseSideUI(InventoryBottomOpenUIButtonIndex.CombineBag)
    if PaGlobal_WareHouse_All_GetShow() == true then
      PaGlobal_Warehouse_All_Close()
    end
    if PaGlobal_Inventory_All_ForConsole._isShowFamilyInven == true then
      PaGlobal_FamilyInvnetoryShowToggle()
    end
    if PaGlobal_Inventory_All_ForConsole._isShowEnchantInven == true then
      PaGlobal_EnchantInventoryShowToggle()
    end
    if Panel_Window_Inventory_Detail ~= nil and Panel_Window_Inventory_Detail:GetShow() == true then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
    end
    if PaGlobalFunc_InventoryInfo_GetShow() == false then
      InventoryWindow_Show()
    end
    PaGlobalFunc_CombineBag_Open()
  end
end
function Inventory_PosSaveMemory()
end
function Inventory_PosLoadMemory()
end
function Inventory_SetIgnoreMoneyButton()
end
function inventory_FlushRestoreFunc()
end
function EquipmentWindow_Close()
end
function Equipment_PosSaveMemory()
end
function Equipment_PosLoadMemory()
end
function Inventory_DropEscape()
end
function PaGlobal_Inventory_All_ForConsole:slotNoIsCostume(slotIndex)
  for ii = 1, #_costumeSlotNo do
    if slotIndex == _costumeSlotNo[ii] then
      return true
    end
  end
  return false
end
function PaGlobal_Inventory_All_ForConsole:getIndexFromEquipSlotNo(slotIndex)
  for ii = 1, #_equipSlotNo do
    if slotIndex == _equipSlotNo[ii] then
      return ii
    end
  end
  return nil
end
function PaGlobal_Inventory_All_ForConsole:getIndexFromCostumeSlotNo(slotIndex)
  for ii = 1, #_costumeSlotNo do
    if slotIndex == _costumeSlotNo[ii] then
      return ii
    end
  end
  return nil
end
function PaGlobal_Inventory_All_ForConsole:getIndexFromSlotNo(slotIndex)
  for ii = 1, #_equipSlotNo do
    if slotIndex == _equipSlotNo[ii] then
      return 0, ii
    end
  end
  for ii = 1, #_costumeSlotNo do
    if slotIndex == _costumeSlotNo[ii] then
      return 1, ii
    end
  end
  for ii = 1, #_lifeEquipSlotNo do
    if slotIndex == _lifeEquipSlotNo[ii] then
      return 2, ii
    end
  end
  return nil
end
function PaGlobal_Inventory_All_ForConsole:getIndexFromServantCostumeSlotNo(dataType, slotIndex)
  local slotNoList = _servantData[dataType].costumeSlotNoList
  for ii = 1, #slotNoList do
    if slotIndex == slotNoList[ii] then
      return ii
    end
  end
  return nil
end
function PaGlobal_Inventory_All_ForConsole:getNearbyServantsActorKeys()
  local keys = {}
  if self._currentUpperTab == UPPER_TAB_TYPE.SERVANT_TAB then
    local actorProxyWrapper = interaction_getInteractable()
    if nil ~= actorProxyWrapper then
      local actorKeyRaw = actorProxyWrapper:get():getActorKeyRaw()
      local servantInfo = getServantInfoFromActorKey(actorKeyRaw)
      if nil ~= servantInfo then
        keys[1] = actorKeyRaw
      end
    elseif not getSelfPlayer():get():doRideMyVehicle() then
      keys[1] = self._campActorProxy
      return keys
    end
  end
  for ii = 1, __eServantTypeCount do
    if servant_checkDistance(ii - 1) then
      local vehicle = getTemporaryInformationWrapper():getUnsealVehicle(ii - 1)
      if nil ~= vehicle and 0 < vehicle:getInventory():size() and vehicle:getVehicleType() ~= CppEnums.VehicleType.Type_CampingTent then
        keys[#keys + 1] = vehicle:getActorKeyRaw()
      end
    end
  end
  return keys
end
function PaGlobal_Inventory_All_ForConsole:extendedSlotInfo(itemWrapper, slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local slotNoMax = itemSSW:getExtendedSlotCount()
  local ret = false
  for i = 1, slotNoMax do
    local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
    if slotNoMax ~= extendSlotNo then
      self._extendedSlotArray[extendSlotNo] = slotNo
      ret = true
    end
  end
  return ret
end
function PaGlobal_Inventory_All_ForConsole:getExtendedSlotCountInfo(itemWrapper, slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local slotCount = itemSSW:getExtendedSlotCount()
  local extendedCount = 0
  for index = 1, slotCount do
    local extendSlotNo = itemSSW:getExtendedSlotIndex(index - 1)
    if slotCount ~= extendSlotNo then
      self._extendedSlotArray[extendSlotNo] = slotNo
      extendedCount = extendedCount + 1
    end
  end
  return extendedCount
end
function PaGlobal_Inventory_All_ForConsole:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantCount = itemSSW:get()._key:getEnchantLevel()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantCount = ToClient_getSpecialEnchantDisplayLevel(iitemSSW:get()._key)
  end
  if isExtended == false and enchantCount > 0 and enchantCount < 26 then
    slot.enchantText:SetText(HighRomaEnchantLevel_ReplaceString(enchantCount))
    slot.enchantText:SetShow(true)
  else
    slot.enchantText:SetShow(false)
  end
  if itemSSW:get():isCash() then
    slot.enchantText:SetShow(false)
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify() and (itemSSW:isSpecialEnchantItem() == false or itemSSW:isSpecialAccessory() == true) and isExtended == false then
    slot.enchantText:SetText(HighRomaEnchantLevel_ReplaceString(enchantCount + 15))
    slot.enchantText:SetShow(true)
  end
  if false == isExtended then
    slot.icon:SetEnable(true)
  else
    slot.icon:SetEnable(false)
  end
  if true == isMono then
    slot.icon:SetMonoTone(true)
    slot.enchantText:SetMonoTone(true)
  elseif false == isMono then
    slot.icon:SetMonoTone(false)
    slot.enchantText:SetMonoTone(false)
  end
end
function PaGlobalFunc_InventoryInfo_GetSlotBorder()
  return PaGlobal_Inventory_All_ForConsole._ui.stc_slotBorder
end
function HandleClicked_Inventory_Palette_Open()
  if ToClient_isConsole() == true then
    _AudioPostEvent_SystemUiForXBOX(1, 24)
    PaGlobalFunc_Dyeing_Open()
    return
  end
  if _ContentsGroup_NewUI_Dye_All == false or Panel_Window_Palette_All:GetShow() == true then
    return
  end
  PaGlobal_Palette_All_Open()
  Panel_Window_Palette_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  ToClient_padSnapSetTargetPanel(_panel)
end
local _depositPossible = true
function PaGlobalFunc_InventoryInfo_PopMoney()
  if false == PaGlobal_WareHouse_All_GetShow() or false == _depositPossible then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local whereType = CppEnums.ItemWhereType.eMoneyInventory
  local slotNo = getMoneySlotNo()
  FGlobal_PopupMoveItem_Init(whereType, slotNo, CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey(), true)
end
function PaGlobalFunc_InventoryInfo_SetMoneyButton(setUp)
  local self = PaGlobal_Inventory_All_ForConsole
  if true == setUp then
    _depositPossible = true
    self._ui.txt_keyGuideSetFunctorY:SetMonoTone(false)
  else
    _depositPossible = false
    self._ui.txt_keyGuideSetFunctorY:SetMonoTone(true)
  end
end
function PaGlobalFunc_Inventory_CompareSpec(whereType, slotNo, isAccessory)
  return PaGlobal_Inventory_All_ForConsole:compareSpec(whereType, slotNo, isAccessory)
end
function PaGlobal_Inventory_All_ForConsole:isSnappedOn(controlID)
  local control = ToClient_getSnappedControl()
  if nil == control then
    return false
  end
  local numStart, numEnd = string.find(control:GetID(), "%d+")
  local snappedControlID
  if nil ~= numStart then
    snappedControlID = string.sub(control:GetID(), 1, numStart - 1)
  end
  if nil == snappedControlID then
    return false
  end
  return snappedControlID == controlID
end
function PaGlobal_Inventory_All_ForConsole:getSnappedControlsIndex()
  local control = ToClient_getSnappedControl()
  if nil == control then
    return nil
  end
  local numStart, numEnd = string.find(control:GetID(), "%d+")
  local index
  if nil ~= numStart then
    index = tonumber(string.sub(control:GetID(), numStart, numEnd))
  end
  return index
end
function PaGlobalFunc_Inventory_RequestMoveItemsInventoryToWarehouse(isCurrentWarehouse)
  PaGlobal_WareHouse_All._targetActorKeyRaw = getSelfPlayer():getActorKey()
  PaGlobal_AutoMove_Result_All:prepareOpen(isCurrentWarehouse)
end
local _buttonUV = {
  [__eConsoleUIPadEvent_X] = {
    136,
    1,
    180,
    45
  },
  [__eConsoleUIPadEvent_Up_X] = {
    136,
    1,
    180,
    45
  },
  [__eConsoleUIPadEvent_Y] = {
    46,
    1,
    90,
    45
  },
  [__eConsoleUIPadEvent_Up_Y] = {
    46,
    1,
    90,
    45
  },
  [__eConsoleUIPadEvent_A] = {
    1,
    1,
    45,
    45
  },
  [__eConsoleUIPadEvent_Up_A] = {
    1,
    1,
    45,
    45
  },
  [__eConsoleUIPadEvent_Empty] = {
    0,
    0,
    2,
    2
  }
}
function PaGlobalFunc_SetKeyGuideUVTo(control, buttonIndex)
  control:ChangeTextureInfoNameAsync("renewal/ui_icon/console_xboxkey_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, _buttonUV[buttonIndex][1], _buttonUV[buttonIndex][2], _buttonUV[buttonIndex][3], _buttonUV[buttonIndex][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobalFunc_Inventory_GetFirstItemCount()
  local aCount = 0
  for ii = 1, PaGlobal_Inventory_All_ForConsole._invenSlotCount do
    if nil ~= PaGlobal_Inventory_All_ForConsole._newItemAtSlot[ii] and true == PaGlobal_Inventory_All_ForConsole._newItemAtSlot[ii] then
      aCount = aCount + 1
    end
  end
  return aCount
end
function PaGlobalFunc_Inventory_All_familyInventoryButtonActive(isActive)
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  if true == isActive then
    PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount = PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount - 1
  else
    PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount = PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount + 1
  end
  if PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount > 0 then
    PaGlobal_FamilyInvnetory_Close(false)
  else
    PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount = 0
  end
end
function PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(isActive)
  if false == _ContentsGroup_EnchantRemaster then
    return
  end
  if true == isActive then
    PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount = PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount - 1
  else
    PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount = PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount + 1
  end
  if PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount > 0 then
    PaGlobal_EnchantInventory_Close(false)
  else
    PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount = 0
  end
end
function PaGlobalFunc_Inventory_All_familyInventoryIsActive()
  if false == _ContentsGroup_FamilyInventory then
    return false
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    return false
  end
  if false == ToClient_isOpenFamilyInventory() then
    return false
  end
  return 0 == PaGlobal_Inventory_All_ForConsole._familyInventoryIgnoreCount
end
function PaGlobalFunc_Inventory_All_enchantInventoryIsActive()
  if _ContentsGroup_EnchantRemaster == false then
    return false
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    return false
  end
  return 0 == PaGlobal_Inventory_All_ForConsole._enchantInventoryIgnoreCount
end
function PaGlobal_FamilyInvnetory_Close(isOpenEquip)
  if false == _ContentsGroup_FamilyInventory then
    return
  end
end
function PaGlobal_FamilyInvnetory_IsShow()
  if false == _ContentsGroup_FamilyInventory then
    return
  end
end
function PaGlobal_FamilyInvnetory_GetToopTipItem()
  if nil == PaGlobal_Inventory_All_ForConsole._familyInventoryTooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(WHERE_TYPE.FAMILY_INVENTORY, PaGlobal_Inventory_All_ForConsole._familyInventoryTooltipSlotNo)
end
function PaGlobal_EnchantInventory_GetToopTipItem()
  if nil == PaGlobal_Inventory_All_ForConsole._enchantInventoryTooltipSlotNo then
    return nil
  end
  return getInventoryItemByType(WHERE_TYPE.ENCHANT_INVENTORY, PaGlobal_Inventory_All_ForConsole._enchantInventoryTooltipSlotNo)
end
function PaGlobal_FamilyInvnetory_PushItemToFamilyInventory(itemCount, slotNo, itemwhereType)
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  ToClient_RequestPopInventoryItemToFamilyInventory(itemwhereType, slotNo, itemCount)
end
function PaGlobal_FamilyInvnetory_PopItemFromFamilyInventory(itemCount, slotNo)
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  ToClient_RequestPushFamilyInventoryItemToInventory(slotNo, itemCount)
end
function PaGlobal_FamilyInvnetory_IsMoveableItem(idx, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return not itemWrapper:checkPushFamilyInventory()
end
function PaGlobal_EnchantInventory_PushItemToEnchantInventory(itemCount, slotNo, itemwhereType)
  if false == _ContentsGroup_EnchantRemaster then
    return
  end
  ToClient_PushEnchantInventoryFromInventory(itemwhereType, slotNo, itemCount)
end
function PaGlobal_EnchantInventory_PopItemFromEnchantInventory(itemCount, slotNo)
  if false == _ContentsGroup_EnchantRemaster then
    return
  end
  ToClient_PopEnchantInventoryToInventory(slotNo, itemCount)
end
function PaGlobal_EnchantInventory_IsMoveableItem(idx, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  return itemWrapper:checkPushEnchantInventory() == false
end
function PaGlobal_InventoryInfo_ChangeInventoryItemSlotRUpEvent(isChange)
  if false == _ContentsGroup_ItemMove then
    return
  end
  if PaGlobal_Inventory_All_ForConsole_IsCategoryShow() == true then
    PaGlobal_Inventory_All_ForConsole_CategoryInvenAutoInsertRegisterEvent(isChange)
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  for ii = 1, self._invenSlotCount do
    local slotBG = self._ui.stc_invenSlotBG[ii]
    if true == isChange then
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_ItemMoveSetExceptionItemKey(" .. ii .. ")")
    else
      slotBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMRUp_InventoryInfo_InvenSlot(" .. ii .. ")")
    end
  end
end
function InputMRUp_InventoryInfo_ItemMoveSetExceptionItemKey(index)
  if false == _ContentsGroup_ItemMove then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local whereType = PaGlobal_Inventory_All_ForConsole._lowerTabData[self._currentLowerTab].whereType
  local slotNo = self._ui.slot_inven[index].slotNo
  if false == PaGlobal_ItemMoveSet_BasicItemFilter(slotNo, nil, whereType) then
    PaGlobal_ItemMoveSet:setExceptionItemKey(whereType, slotNo)
  end
end
function PaGlobal_InventoryInfo_GotoSnappingItemSlotBG()
  if false == _ContentsGroup_ItemMove then
    return
  end
  if false == _panel:GetShow() then
    return
  end
  local self = PaGlobal_Inventory_All_ForConsole
  local slotBG = self._ui.stc_invenSlotBG[1]
  ToClient_padSnapSetTargetPanel(_panel)
  ToClient_padSnapChangeToTarget(slotBG)
end
function PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(isBGShow, isEffectShow)
  if false == _ContentsGroup_Season_EquipmentUpgrade then
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_Upgrade:SetShow(false)
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeBg:SetShow(false)
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeEffect:EraseAllEffect()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:get():isSeasonCharacter() or selfPlayer:get():getLevel() < 10 then
    return
  end
  local equipInven = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eEquip)
  local Inventory = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eInventory)
  PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeEffect:EraseAllEffect()
  if true == isBGShow and (true == equipInven or true == Inventory) then
    if true == _snappedOnThisPanel then
      _panel:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobal_SeasonEquipment_Upgrade_Open()")
    end
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_Upgrade:SetShow(true)
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeBg:SetShow(true)
  else
    _panel:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_Upgrade:SetShow(false)
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeBg:SetShow(false)
  end
  if true == isEffectShow and (true == equipInven or true == Inventory) then
    PaGlobal_Inventory_All_ForConsole._ui.stc_season_UpgradeEffect:AddEffect("fUI_Equipment_UP_01A", true, 0, 0)
  end
  PaGlobal_Inventory_All_ForConsole:updateEquipment(true)
end
function PaGlobal_InventoryEquip_ShowSeasonUpgradePossibleEffect(itemWrapper)
  if false == _ContentsGroup_Season_EquipmentUpgrade then
    return false
  end
  if nil == itemWrapper then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return false
  end
  if nil == itemSSW:get() then
    return false
  end
  return itemSSW:get():isChangeEquipItem()
end
function HandleClicked_Inventory_All_UseMultiBoxes()
  Panel_NumberPad_Show(true, PaGlobal_Inventory_All_ForConsole._multiUseCount_s64, PaGlobal_Inventory_All_ForConsole._multiUseInventoryType, HandleEvent_Inventory_All_UseMultiItems, false, PaGlobal_Inventory_All_ForConsole._multiUseSlotNo, false, nil, nil)
end
function HandleEvent_Inventory_All_UseMultiItems(count, inventoryType, slotNo)
  if Int64toInt32(count) <= 0 then
    return
  end
  ToClient_SetMultiUseItemCount(count)
  Inventory_UseItemTargetSelf(inventoryType, slotNo, nil)
  ToClient_SetMultiUseItemCount(1)
  PaGlobal_Inventory_All_ForConsole._multiUseCount_s64 = toInt64(0, 1)
  PaGlobal_Inventory_All_ForConsole._multiUseInventoryType = nil
  PaGlobal_Inventory_All_ForConsole._multiUseSlotNo = nil
end
function HandleEvent_ValksList_ShowTextToolTip(isShow)
  local self = PaGlobal_Inventory_All_ForConsole
  if self == nil then
    return
  end
  if isShow == true then
    TooltipSimple_Show(self._ui.btn_valksView, self._ui.btn_valksView:GetText())
  else
    TooltipSimple_Hide()
  end
end
function setPositionFloatingTooltip(self)
  local tooltipPanel = PaGlobalFunc_FloatingTooltip_GetPanel()
  local defaultToolTipGap = PaGlobalFunc_FloatingTooltip_GetDefaultGap()
  local defaultXPos = self._ui.stc_title:GetParentPosX() - tooltipPanel:GetSizeX() - defaultToolTipGap
  local defaultYPos = self._ui.stc_title:GetParentPosY()
  tooltipPanel:SetPosX(math.max(defaultToolTipGap, defaultXPos))
  tooltipPanel:SetPosY(math.max(defaultToolTipGap, defaultYPos))
end
