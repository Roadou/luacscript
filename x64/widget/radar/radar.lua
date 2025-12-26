local isShowOtherIcon = true
local isContentsOpenLocalWar = ToClient_IsContentsGroupOpen("43")
local isSolareInstance = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
local isMiniGameInstance = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_MiniGame)
local isGuildMatchInstance = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch)
local isHardCoreChannel = _ContentsGroup_HardCoreChannel and ToClient_isHardCoreChannel()
Panel_TimeBar:SetShow(true, false)
if false == _ContentsGroup_UsePadSnapping then
  Panel_TimeBar:RegisterShowEventFunc(true, "TimebarShowAni()")
  Panel_TimeBar:RegisterShowEventFunc(false, "TimebarHideAni()")
end
Panel_TimeBar:SetIgnore(true)
Panel_TimeBarNumber:SetIgnore(true)
Panel_Radar:SetIgnore(true)
Panel_Radar:setGlassBackground(true)
Panel_Radar:RegisterShowEventFunc(true, "RadarShowAni()")
Panel_Radar:RegisterShowEventFunc(false, "RadarHideAni()")
local radarType = {
  radarType_none = 0,
  radarType_hide = 1,
  radarType_allymonster = 2,
  radarType_normalMonster = 3,
  radarType_namedMonster = 4,
  radarType_bossMonster = 5,
  radarType_normalMonsterQuestTarget = 6,
  radarType_namedMonsterQuestTarget = 7,
  radarType_bossMonsterQuestTarget = 8,
  radarType_lordManager = 9,
  radarType_skillTrainner = 10,
  radarType_tradeMerchantNpc = 11,
  radarType_nodeManager = 12,
  radarType_normalNpc = 13,
  radarType_warehouseNpc = 14,
  radarType_potionNpc = 15,
  radarType_weaponNpc = 16,
  radarType_horseNpc = 17,
  radarType_workerNpc = 18,
  radarType_jewelNpc = 19,
  radarType_furnitureNpc = 20,
  radarType_collectNpc = 21,
  radarType_shipNpc = 22,
  radarType_alchemyNpc = 23,
  radarType_fishNpc = 24,
  radarType_guild = 25,
  radarType_guildShop = 26,
  radarType_itemTrader = 27,
  radarType_TerritorySupply = 28,
  radarType_Cook = 29,
  radarType_Wharf = 30,
  radarType_itemRepairer = 31,
  radarType_shopMerchantNpc = 32,
  radarType_ImportantNpc = 33,
  radarType_QuestAcceptable = 34,
  radarType_QuestProgress = 35,
  radarType_QuestComplete = 36,
  radarType_unknownNpc = 37,
  radarType_partyMember = 38,
  radarType_guildMember = 39,
  radarType_normalPlayer = 40,
  radarType_isHorse = 41,
  radarType_isDonkey = 42,
  radarType_isCamel = 43,
  radarType_isElephant = 44,
  radarType_isBabyElePhant = 45,
  radarType_isShip = 46,
  radarType_isCarriage = 47,
  radarType_isDragon = 48,
  radarType_installation = 49,
  radarType_kingGuildTent = 50,
  radarType_lordGuildTent = 51,
  radarType_villageGuildTent = 52,
  radarType_selfDeadBody = 53,
  radarType_advancedBase = 54,
  radarType_Raft = 55,
  radarType_Boat = 56,
  radarType_FishingBoat = 57,
  radarType_PersonalTradeShip = 58,
  radarType_GalleyShip = 59,
  radarType_PersonalBattleShip = 60,
  radarType_huntingMonster = 61,
  radarType_huntingMonsterQuestTarget = 62,
  radarType_Instrument = 63,
  radarType_LocalWarOccupation = 64,
  radarType_RoseWarGimicAdrenalinFierceBattle = 65,
  radarType_RoseWarGimicConquestFierceBattle = 66,
  radarType_Count = 67
}
local template = {
  [radarType.radarType_none] = nil,
  [radarType.radarType_hide] = UI.getChildControl(Panel_Radar, "icon_hide"),
  [radarType.radarType_allymonster] = UI.getChildControl(Panel_Radar, "icon_horse"),
  [radarType.radarType_normalMonster] = UI.getChildControl(Panel_Radar, "icon_monsterGeneral_normal"),
  [radarType.radarType_namedMonster] = UI.getChildControl(Panel_Radar, "icon_monsterNamed_normal"),
  [radarType.radarType_bossMonster] = UI.getChildControl(Panel_Radar, "icon_monsterBoss_normal"),
  [radarType.radarType_normalMonsterQuestTarget] = UI.getChildControl(Panel_Radar, "icon_monsterGeneral_quest"),
  [radarType.radarType_namedMonsterQuestTarget] = UI.getChildControl(Panel_Radar, "icon_monsterNamed_quest"),
  [radarType.radarType_bossMonsterQuestTarget] = UI.getChildControl(Panel_Radar, "icon_monsterBoss_quest"),
  [radarType.radarType_lordManager] = UI.getChildControl(Panel_Radar, "icon_npc_lordManager"),
  [radarType.radarType_skillTrainner] = UI.getChildControl(Panel_Radar, "icon_npc_skillTrainner"),
  [radarType.radarType_tradeMerchantNpc] = UI.getChildControl(Panel_Radar, "icon_npc_trader"),
  [radarType.radarType_nodeManager] = UI.getChildControl(Panel_Radar, "icon_npc_nodeManager"),
  [radarType.radarType_normalNpc] = nil,
  [radarType.radarType_warehouseNpc] = UI.getChildControl(Panel_Radar, "icon_npc_warehouse"),
  [radarType.radarType_potionNpc] = UI.getChildControl(Panel_Radar, "icon_npc_potion"),
  [radarType.radarType_weaponNpc] = UI.getChildControl(Panel_Radar, "icon_npc_storeArmor"),
  [radarType.radarType_horseNpc] = UI.getChildControl(Panel_Radar, "icon_npc_horse"),
  [radarType.radarType_workerNpc] = UI.getChildControl(Panel_Radar, "icon_npc_worker"),
  [radarType.radarType_jewelNpc] = UI.getChildControl(Panel_Radar, "icon_npc_jewel"),
  [radarType.radarType_furnitureNpc] = UI.getChildControl(Panel_Radar, "icon_npc_furniture"),
  [radarType.radarType_collectNpc] = UI.getChildControl(Panel_Radar, "icon_npc_collect"),
  [radarType.radarType_shipNpc] = UI.getChildControl(Panel_Radar, "icon_npc_ship"),
  [radarType.radarType_alchemyNpc] = UI.getChildControl(Panel_Radar, "icon_npc_alchemy"),
  [radarType.radarType_fishNpc] = UI.getChildControl(Panel_Radar, "icon_npc_fish"),
  [radarType.radarType_guild] = UI.getChildControl(Panel_Radar, "icon_npc_guild"),
  [radarType.radarType_guildShop] = UI.getChildControl(Panel_Radar, "icon_npc_guildShop"),
  [radarType.radarType_itemTrader] = UI.getChildControl(Panel_Radar, "icon_npc_itemTrader"),
  [radarType.radarType_TerritorySupply] = UI.getChildControl(Panel_Radar, "icon_npc_territorySupply"),
  [radarType.radarType_Cook] = UI.getChildControl(Panel_Radar, "icon_npc_cook"),
  [radarType.radarType_Wharf] = UI.getChildControl(Panel_Radar, "icon_npc_wharf"),
  [radarType.radarType_itemRepairer] = UI.getChildControl(Panel_Radar, "icon_npc_repairer"),
  [radarType.radarType_shopMerchantNpc] = UI.getChildControl(Panel_Radar, "icon_npc_shop"),
  [radarType.radarType_ImportantNpc] = UI.getChildControl(Panel_Radar, "icon_npc_important"),
  [radarType.radarType_QuestAcceptable] = UI.getChildControl(Panel_Radar, "icon_quest_accept"),
  [radarType.radarType_QuestProgress] = UI.getChildControl(Panel_Radar, "icon_quest_doing"),
  [radarType.radarType_QuestComplete] = UI.getChildControl(Panel_Radar, "icon_quest_clear"),
  [radarType.radarType_unknownNpc] = UI.getChildControl(Panel_Radar, "icon_npc_unknown"),
  [radarType.radarType_partyMember] = UI.getChildControl(Panel_Radar, "icon_partyMember"),
  [radarType.radarType_guildMember] = UI.getChildControl(Panel_Radar, "icon_guildMember"),
  [radarType.radarType_normalPlayer] = UI.getChildControl(Panel_Radar, "icon_player"),
  [radarType.radarType_isHorse] = UI.getChildControl(Panel_Radar, "icon_horse"),
  [radarType.radarType_isDonkey] = UI.getChildControl(Panel_Radar, "icon_donkey"),
  [radarType.radarType_isShip] = UI.getChildControl(Panel_Radar, "icon_ship"),
  [radarType.radarType_isCarriage] = UI.getChildControl(Panel_Radar, "icon_carriage"),
  [radarType.radarType_isCamel] = UI.getChildControl(Panel_Radar, "icon_camel"),
  [radarType.radarType_isElephant] = nil,
  [radarType.radarType_isBabyElePhant] = UI.getChildControl(Panel_Radar, "icon_babyElephant"),
  [radarType.radarType_installation] = UI.getChildControl(Panel_Radar, "icon_tent"),
  [radarType.radarType_kingGuildTent] = UI.getChildControl(Panel_Radar, "icon_tent"),
  [radarType.radarType_lordGuildTent] = UI.getChildControl(Panel_Radar, "icon_tent"),
  [radarType.radarType_villageGuildTent] = UI.getChildControl(Panel_Radar, "icon_tent"),
  [radarType.radarType_selfDeadBody] = UI.getChildControl(Panel_Radar, "icon_deadbody"),
  [radarType.radarType_advancedBase] = UI.getChildControl(Panel_Radar, "icon_Outpost"),
  [radarType.radarType_Raft] = UI.getChildControl(Panel_Radar, "icon_Raft"),
  [radarType.radarType_Boat] = UI.getChildControl(Panel_Radar, "icon_Boat"),
  [radarType.radarType_FishingBoat] = UI.getChildControl(Panel_Radar, "icon_FishingBoat"),
  [radarType.radarType_PersonalTradeShip] = UI.getChildControl(Panel_Radar, "icon_PersonalTradeShip"),
  [radarType.radarType_GalleyShip] = UI.getChildControl(Panel_Radar, "icon_GalleyShip"),
  [radarType.radarType_PersonalBattleShip] = UI.getChildControl(Panel_Radar, "icon_PersonalBattleShip"),
  [radarType.radarType_huntingMonster] = UI.getChildControl(Panel_Radar, "icon_monsterHunting_normal"),
  [radarType.radarType_huntingMonsterQuestTarget] = UI.getChildControl(Panel_Radar, "icon_monsterHunting_quest"),
  [radarType.radarType_Instrument] = UI.getChildControl(Panel_Radar, "icon_npc_instrument"),
  [radarType.radarType_LocalWarOccupation] = UI.getChildControl(Panel_Radar, "Static_LocalWar_Tower"),
  [radarType.radarType_RoseWarGimicAdrenalinFierceBattle] = UI.getChildControl(Panel_Radar, "icon_npc_rosewarAltar"),
  [radarType.radarType_RoseWarGimicConquestFierceBattle] = UI.getChildControl(Panel_Radar, "icon_npc_rosewarAltar")
}
local typeDepth = {
  [radarType.radarType_none] = 0,
  [radarType.radarType_hide] = 0,
  [radarType.radarType_allymonster] = -5,
  [radarType.radarType_normalMonster] = -2,
  [radarType.radarType_namedMonster] = -10,
  [radarType.radarType_bossMonster] = -12,
  [radarType.radarType_normalMonsterQuestTarget] = -3,
  [radarType.radarType_namedMonsterQuestTarget] = -11,
  [radarType.radarType_bossMonsterQuestTarget] = -13,
  [radarType.radarType_huntingMonster] = -11,
  [radarType.radarType_huntingMonsterQuestTarget] = -12,
  [radarType.radarType_lordManager] = -14,
  [radarType.radarType_skillTrainner] = -15,
  [radarType.radarType_tradeMerchantNpc] = -16,
  [radarType.radarType_nodeManager] = -17,
  [radarType.radarType_normalNpc] = -2,
  [radarType.radarType_warehouseNpc] = -7,
  [radarType.radarType_potionNpc] = -8,
  [radarType.radarType_weaponNpc] = -9,
  [radarType.radarType_horseNpc] = -6,
  [radarType.radarType_workerNpc] = -10,
  [radarType.radarType_jewelNpc] = -11,
  [radarType.radarType_furnitureNpc] = -12,
  [radarType.radarType_collectNpc] = -13,
  [radarType.radarType_shipNpc] = -5,
  [radarType.radarType_alchemyNpc] = -4,
  [radarType.radarType_fishNpc] = -3,
  [radarType.radarType_guild] = -21,
  [radarType.radarType_guildShop] = -25,
  [radarType.radarType_itemTrader] = -26,
  [radarType.radarType_TerritorySupply] = -23,
  [radarType.radarType_Cook] = -24,
  [radarType.radarType_Wharf] = -20,
  [radarType.radarType_itemRepairer] = -33,
  [radarType.radarType_shopMerchantNpc] = -34,
  [radarType.radarType_ImportantNpc] = -32,
  [radarType.radarType_QuestAcceptable] = -41,
  [radarType.radarType_QuestProgress] = -40,
  [radarType.radarType_QuestComplete] = -42,
  [radarType.radarType_unknownNpc] = -2,
  [radarType.radarType_partyMember] = -90,
  [radarType.radarType_guildMember] = -80,
  [radarType.radarType_normalPlayer] = -1,
  [radarType.radarType_isHorse] = -100,
  [radarType.radarType_isDonkey] = -100,
  [radarType.radarType_isShip] = -100,
  [radarType.radarType_isCarriage] = -100,
  [radarType.radarType_isCamel] = -100,
  [radarType.radarType_isElephant] = -100,
  [radarType.radarType_isBabyElePhant] = -100,
  [radarType.radarType_installation] = -20,
  [radarType.radarType_kingGuildTent] = -20,
  [radarType.radarType_lordGuildTent] = -20,
  [radarType.radarType_villageGuildTent] = -20,
  [radarType.radarType_selfDeadBody] = -40,
  [radarType.radarType_advancedBase] = -30,
  [radarType.radarType_Raft] = -100,
  [radarType.radarType_Boat] = -100,
  [radarType.radarType_FishingBoat] = -100,
  [radarType.radarType_PersonalTradeShip] = -100,
  [radarType.radarType_GalleyShip] = -100,
  [radarType.radarType_PersonalBattleShip] = -100,
  [radarType.radarType_Instrument] = -8,
  [radarType.radarType_LocalWarOccupation] = -100,
  [radarType.radarType_RoseWarGimicAdrenalinFierceBattle] = -10,
  [radarType.radarType_RoseWarGimicConquestFierceBattle] = -10
}
local UI_color = Defines.Color
local chaseColor = "0x42ebe1"
local colorBlindNone = {
  [radarType.radarType_allymonster] = UI_color.C_FFB22300,
  [radarType.radarType_normalMonster] = UI_color.C_FFB22300,
  [radarType.radarType_namedMonster] = UI_color.C_FFB22300,
  [radarType.radarType_bossMonster] = UI_color.C_FFB22300,
  [radarType.radarType_huntingMonster] = UI_color.C_FFB22300,
  [radarType.radarType_normalMonsterQuestTarget] = UI_color.C_FFEE9900,
  [radarType.radarType_namedMonsterQuestTarget] = UI_color.C_FFEE9900,
  [radarType.radarType_bossMonsterQuestTarget] = UI_color.C_FFEE9900,
  [radarType.radarType_huntingMonsterQuestTarget] = UI_color.C_FFEE9900
}
if true == _ContentsGroup_ChinaFontColor then
  colorBlindNone = {
    [radarType.radarType_allymonster] = UI_color.C_00FFFFFF,
    [radarType.radarType_normalMonster] = UI_color.C_00FFFFFF,
    [radarType.radarType_namedMonster] = UI_color.C_00FFFFFF,
    [radarType.radarType_bossMonster] = UI_color.C_00FFFFFF,
    [radarType.radarType_huntingMonster] = UI_color.C_00FFFFFF,
    [radarType.radarType_normalMonsterQuestTarget] = UI_color.C_FFEE9900,
    [radarType.radarType_namedMonsterQuestTarget] = UI_color.C_FFEE9900,
    [radarType.radarType_bossMonsterQuestTarget] = UI_color.C_FFEE9900,
    [radarType.radarType_huntingMonsterQuestTarget] = UI_color.C_FFEE9900
  }
end
local colorBlindRed = {
  [radarType.radarType_allymonster] = UI_color.C_FFD85300,
  [radarType.radarType_normalMonster] = UI_color.C_FFD85300,
  [radarType.radarType_namedMonster] = UI_color.C_FFD85300,
  [radarType.radarType_bossMonster] = UI_color.C_FFD85300,
  [radarType.radarType_huntingMonster] = UI_color.C_FFD85300,
  [radarType.radarType_normalMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_namedMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_bossMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_huntingMonsterQuestTarget] = UI_color.C_FFFFE866
}
local colorBlindGreen = {
  [radarType.radarType_allymonster] = UI_color.C_FFD82800,
  [radarType.radarType_normalMonster] = UI_color.C_FFD82800,
  [radarType.radarType_namedMonster] = UI_color.C_FFD82800,
  [radarType.radarType_bossMonster] = UI_color.C_FFD82800,
  [radarType.radarType_huntingMonster] = UI_color.C_FFD82800,
  [radarType.radarType_normalMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_namedMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_bossMonsterQuestTarget] = UI_color.C_FFFFE866,
  [radarType.radarType_huntingMonsterQuestTarget] = UI_color.C_FFFFE866
}
local weatherUVForNormal = {
  ["_texture"] = "new_ui_common_forlua/widget/rader/minimap_00.dds",
  [0] = {
    43,
    133,
    62,
    152
  },
  [1] = {
    171,
    187,
    188,
    205
  },
  [2] = {
    78,
    206,
    98,
    226
  }
}
local citadelUVForNormal = {
  ["_texture"] = "new_ui_common_forlua/window/guild/guild_00.dds",
  [0] = {
    312,
    31,
    332,
    51
  },
  [1] = {
    291,
    31,
    311,
    51
  },
  [2] = {
    291,
    31,
    311,
    51
  }
}
local siegeArearUVForNormal = {
  ["_texture"] = "new_ui_common_forlua/window/guild/guild_00.dds",
  [0] = {
    166,
    1,
    186,
    21
  },
  [1] = {
    187,
    1,
    207,
    21
  },
  [2] = {
    249,
    31,
    269,
    51
  }
}
local villageWarUVForNormal = {
  ["_texture"] = "New_UI_Common_forLua/Window/Guild/Guild_00.dds",
  [0] = {
    333,
    31,
    353,
    51
  },
  [1] = {
    354,
    31,
    374,
    51
  }
}
local terrainUVForNormal = {
  ["_texture"] = "new_ui_common_forlua/default/default_etc_01.dds",
  [0] = {
    73,
    170,
    93,
    190,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
  },
  [1] = {
    52,
    170,
    72,
    190,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_ROAD")
  },
  [2] = {
    108,
    177,
    128,
    197,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SNOW")
  },
  [3] = {
    129,
    177,
    149,
    197,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DESERT")
  },
  [4] = {
    150,
    177,
    170,
    197,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SWAMP")
  },
  [5] = {
    73,
    170,
    93,
    190,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OBJECT")
  },
  [6] = {
    171,
    177,
    191,
    197,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_WATER")
  },
  [7] = {
    73,
    170,
    93,
    190,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_GRASS")
  },
  [8] = {
    171,
    156,
    191,
    176,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DEEPWATER")
  },
  [9] = {
    171,
    135,
    191,
    155,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_AIR")
  },
  [10] = {
    301,
    44,
    321,
    64,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OCEAN")
  },
  [11] = {
    238,
    2,
    258,
    22,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SEAWAY")
  }
}
local glowFontForNormal = {
  _region = "BaseFont_12_Glow",
  _regionNode = "BaseFont_8_Glow",
  _regionWar = "BaseFont_8_Glow"
}
local weatherUVForRemaster = {
  ["_texture"] = "Renewal/UI_Icon/Console_Icon_03.dds",
  [0] = {
    43,
    171,
    63,
    191
  },
  [1] = {
    22,
    171,
    42,
    191
  },
  [2] = {
    1,
    171,
    21,
    191
  }
}
local citadelUVForRemaster = {
  ["_texture"] = "Renewal/UI_Icon/Console_Icon_03.dds",
  [0] = {
    64,
    129,
    84,
    149
  },
  [1] = {
    43,
    129,
    63,
    149
  },
  [2] = {
    64,
    171,
    84,
    191
  }
}
local siegeAreaUVForRemaster = {
  ["_texture"] = "Renewal/UI_Icon/Console_Icon_03.dds",
  [0] = {
    64,
    171,
    84,
    191
  },
  [1] = {
    43,
    129,
    63,
    149
  },
  [2] = {
    64,
    129,
    84,
    149
  }
}
local villageWarUVForRemaster = {
  ["_texture"] = "Renewal/UI_Icon/Console_Icon_03.dds",
  [0] = {
    1,
    129,
    21,
    149
  },
  [1] = {
    22,
    129,
    42,
    149
  }
}
local terrainUVForRemaster = {
  ["_texture"] = "Renewal/UI_Icon/Console_Icon_03.dds",
  [0] = {
    1,
    150,
    21,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
  },
  [1] = {
    22,
    150,
    42,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_ROAD")
  },
  [2] = {
    43,
    150,
    63,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SNOW")
  },
  [3] = {
    64,
    150,
    84,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DESERT")
  },
  [4] = {
    85,
    150,
    105,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SWAMP")
  },
  [5] = {
    1,
    150,
    21,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OBJECT")
  },
  [6] = {
    106,
    129,
    126,
    149,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_WATER")
  },
  [7] = {
    85,
    150,
    105,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_GRASS")
  },
  [8] = {
    85,
    129,
    105,
    149,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DEEPWATER")
  },
  [9] = {
    106,
    150,
    126,
    170,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_AIR")
  },
  [10] = {
    301,
    44,
    321,
    64,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OCEAN")
  },
  [11] = {
    238,
    2,
    258,
    22,
    PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SEAWAY")
  }
}
local glowFontForRemaster = {
  _region = "SubTitleFont_14",
  _regionNode = "BaseFont_10",
  _regionWar = "BaseFont_10"
}
local weatherUV = {}
local citadelUV = {}
local siegeAreaUV = {}
local villageWarUV = {}
local terrainUV = {}
local glowFont = {}
if true == _ContentsGroup_RemasterUI_Radar then
  weatherUV = weatherUVForRemaster
  citadelUV = citadelUVForRemaster
  siegeAreaUV = siegeAreaUVForRemaster
  villageWarUV = villageWarUVForRemaster
  terrainUV = terrainUVForRemaster
  glowFont = glowFontForRemaster
else
  weatherUV = weatherUVForNormal
  citadelUV = citadelUVForNormal
  siegeAreaUV = siegeArearUVForNormal
  villageWarUV = villageWarUVForNormal
  terrainUV = terrainUVForNormal
  glowFont = glowFontForNormal
end
local CGT = CppEnums.CharacterGradeType
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_RT = CppEnums.RegionType
local isDrag = false
local alphaValue = 1
local simpleUIAlpha = 0
local radarText = UI.getChildControl(Panel_Radar, "StaticText_radarText")
local radar_Background = UI.getChildControl(Panel_Radar, "radar_Background")
local radar_SizeSlider = UI.getChildControl(Panel_Radar, "Slider_MapSize")
local radar_SizeBtn = UI.getChildControl(radar_SizeSlider, "Slider_MapSize_Btn")
local radar_AlphaScrl = UI.getChildControl(Panel_Radar, "Slider_RadarAlpha")
local radar_AlphaBtn = UI.getChildControl(radar_AlphaScrl, "RadarAlpha_CtrlBtn")
local radar_OverName = UI.getChildControl(Panel_Radar, "Static_OverName")
local radar_MiniMapScl = UI.getChildControl(Panel_Radar, "Button_SizeControl")
local radar_regionName = UI.getChildControl(Panel_Radar, "StaticText_RegionName")
local radar_regionSubName = UI.getChildControl(Panel_Radar, "StaticText_RegionSubName")
local radar_regionNodeName = UI.getChildControl(Panel_Radar, "StaticText_RegionNodeName")
local radar_regionWarName = UI.getChildControl(Panel_Radar, "StaticText_RegionWarName")
local radar_DangerIcon = UI.getChildControl(Panel_Radar, "Static_DangerArea")
local radar_DangerAletText = UI.getChildControl(Panel_Radar, "StaticText_MonsterAlert")
local radar_DangerOutOfRoseWarZone = UI.getChildControl(Panel_Radar, "MultilineText_RoseWarAlert")
local radar_DangetAlertBg = UI.getChildControl(Panel_Radar, "Static_Alert")
local radar_WarAlert = UI.getChildControl(Panel_Radar, "StaticText_WarAlert")
local radar_ChangeBtn = UI.getChildControl(Panel_Radar, "Button_Swap")
local radar_SequenceAni = UI.getChildControl(Panel_Radar, "Static_SequenceAni")
radar_ChangeBtn:SetShow(_ContentsGroup_3DMiniMapOpen)
radar_SequenceAni:SetShow(_ContentsGroup_3DMiniMapOpen)
radar_regionName:SetAutoResize(true)
radar_regionName:SetTextMode(__eTextMode_AutoWrap)
radar_regionName:SetNotAbleMasking(true)
radar_regionSubName:SetAutoResize(true)
radar_regionSubName:SetTextMode(__eTextMode_AutoWrap)
radar_regionSubName:SetNotAbleMasking(true)
radar_regionNodeName:SetAutoResize(true)
radar_regionNodeName:SetNotAbleMasking(true)
radar_regionWarName:SetAutoResize(true)
radar_regionWarName:SetNotAbleMasking(true)
radar_Background:addInputEvent("Mouse_On", "FGlobal_Radar_HandleMouseOn()")
radar_DangerAletText:SetTextMode(__eTextMode_AutoWrap)
radar_DangerAletText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_NEARMONSTERALERT"))
radar_DangerAletText:SetShow(false)
radar_DangerAletText:SetDepth(-9999)
radar_DangetAlertBg:SetShow(false)
radar_DangetAlertBg:SetDepth(-9998)
if true == _ContentsGroup_ChinaFontColor then
  radar_DangerAletText:SetFontColor(Defines.Color.C_FFDE8B3A)
end
radar_DangerOutOfRoseWarZone:SetTextMode(__eTextMode_AutoWrap)
radar_DangerOutOfRoseWarZone:SetText(PAGetString(Defines.StringSheet_GAME, "ROSEWAR_MINIMAP_ALERT"))
radar_DangerOutOfRoseWarZone:SetShow(false)
radar_DangerOutOfRoseWarZone:SetDepth(-9999)
radar_WarAlert:SetTextMode(__eTextMode_AutoWrap)
radar_WarAlert:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_WAR_NO_MONSTER"))
radar_WarAlert:SetShow(false)
radar_WarAlert:SetDepth(-9999)
local SetRadarUIColorByGuildColor = function(actorKeyRaw, radarUIControl)
  if actorKeyRaw == nil or radarUIControl == nil then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if playerActorProxyWrapper == nil then
    return
  end
  local guildNoOrAllianceNo = playerActorProxyWrapper:getGuildNo_s64()
  if playerActorProxyWrapper:isGuildAllianceMember() == true then
    guildNoOrAllianceNo = playerActorProxyWrapper:getGuildAllianceNo_s64()
  end
  if _ContentsGroup_EditGuildColor == true then
    local guildColorCount = ToClient_getGuildColorCount()
    if guildColorCount > 1 then
      local guildColor = ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo)
      if guildColor ~= 0 and guildColor ~= 4294967295 then
        radarUIControl:SetColor(guildColor)
      end
    end
  else
    local guildColor = ToClient_GetGuildColorByGuildNo(guildNoOrAllianceNo)
    if guildColor ~= 0 then
      radarUIControl:SetColor(guildColor)
    end
  end
end
local SetRadarUIColorByGuildColorByGuildNo = function(s64_guildNoOrAllianceNo, radarUIControl)
  if s64_guildNoOrAllianceNo == nil or radarUIControl == nil then
    return
  end
  if _ContentsGroup_EditGuildColor == true then
    local guildColorCount = ToClient_getGuildColorCount()
    if guildColorCount > 1 then
      local guildColor = ToClient_getEditGuildColorByGuildNo(s64_guildNoOrAllianceNo)
      if guildColor ~= 0 and guildColor ~= 4294967295 then
        radarUIControl:SetColor(guildColor)
      end
    end
  else
    local guildColor = ToClient_GetGuildColorByGuildNo(s64_guildNoOrAllianceNo)
    if guildColor ~= 0 then
      radarUIControl:SetColor(guildColor)
    end
  end
end
local SetRadarUIColorByRoseWarColor = function(actorKeyRaw, radarUIControl)
  if actorKeyRaw == nil or radarUIControl == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
  if playerActorProxyWrapper == nil then
    return
  end
  local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
  local roseWarTeamNo = playerActorProxyWrapper:getRoseWarTeamNo()
  if myRoseWarTeamNo == roseWarTeamNo then
    radarUIControl:SetColor(4289457919)
  else
    radarUIControl:SetColor(4294945707)
  end
end
local function radarAlert_Resize()
  if radar_DangerAletText:GetSizeY() < radar_DangerAletText:GetTextSizeY() then
    radar_DangerAletText:SetSize(Panel_Radar:GetSizeX() - 60, radar_DangerAletText:GetSizeY() + 20)
  else
    radar_DangerAletText:SetSize(Panel_Radar:GetSizeX() - 60, radar_DangerAletText:GetSizeY())
  end
  if radar_WarAlert:GetSizeY() < radar_WarAlert:GetTextSizeY() then
    radar_WarAlert:SetSize(Panel_Radar:GetSizeX() - 60, radar_WarAlert:GetSizeY() + 20)
  else
    radar_WarAlert:SetSize(Panel_Radar:GetSizeX() - 60, radar_WarAlert:GetSizeY())
  end
  if radar_DangerOutOfRoseWarZone:GetSizeY() < radar_DangerOutOfRoseWarZone:GetTextSizeY() then
    radar_DangerOutOfRoseWarZone:SetSize(Panel_Radar:GetSizeX() - 60, radar_DangerOutOfRoseWarZone:GetSizeY() + 20)
  else
    radar_DangerOutOfRoseWarZone:SetSize(Panel_Radar:GetSizeX() - 60, radar_DangerOutOfRoseWarZone:GetSizeY())
  end
  radar_DangerAletText:SetTextMode(__eTextMode_AutoWrap)
  radar_DangerAletText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_NEARMONSTERALERT"))
  radar_DangerAletText:ComputePos()
  radar_WarAlert:SetTextMode(__eTextMode_AutoWrap)
  radar_WarAlert:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_WAR_NO_MONSTER"))
  radar_WarAlert:ComputePos()
  radar_DangerOutOfRoseWarZone:SetTextMode(__eTextMode_AutoWrap)
  radar_DangerOutOfRoseWarZone:SetText(PAGetString(Defines.StringSheet_GAME, "ROSEWAR_MINIMAP_ALERT"))
  radar_DangerOutOfRoseWarZone:ComputePos()
  radar_DangetAlertBg:SetSize(Panel_Radar:GetSizeX() - 19, Panel_Radar:GetSizeY() - 18)
  radar_DangetAlertBg:ComputePos()
end
radarAlert_Resize()
local Panel_OrigSizeX = 320
local Panel_OrigSizeY = 280
local Panel_ReciprocalOrigSizeX = 1 / Panel_OrigSizeX
local Panel_ReciprocalOrigSizeY = 1 / Panel_OrigSizeY
local wheelCount = 0.5
local cacheSimpleUI_ShowButton = true
local isMouseOn = false
local scaleMinValue = 50
local scaleMaxValue = 150
local useLanternAlertTime = 0
local beforSafeZone = false
local beforeCombatZone = false
local beforeArenaZone = false
local beforeDesertZone = false
local currentSafeZone = false
local nodeWarRegionName
local balenciaPart2 = ToClient_IsContentsGroupOpen("65")
radar_Background:SetAlpha(0)
local RadarMap_UpdatePixelRate
local radarTime = {
  controls = {
    iconNotice = UI.getChildControl(Panel_TimeBar, "StaticText_Icon_Notice"),
    commandCenter = UI.getChildControl(Panel_TimeBar, "Static_CommandCenter"),
    citadel = UI.getChildControl(Panel_TimeBar, "Static_Citadel"),
    raining = UI.getChildControl(Panel_TimeBar, "Static_Raining"),
    siegeArea = UI.getChildControl(Panel_TimeBar, "Static_SiegeArea"),
    VillageWar = UI.getChildControl(Panel_TimeBar, "Static_VillageWarArea"),
    regionType = UI.getChildControl(Panel_TimeBar, "regionType"),
    regionName = UI.getChildControl(Panel_TimeBar, "regionName"),
    terrainInfo = UI.getChildControl(Panel_TimeBar, "StaticText_Terrain"),
    serverName = UI.getChildControl(Panel_TimeBar, "StaticText_ServerName"),
    channelName = UI.getChildControl(Panel_TimeBar, "StaticText_ChannelName"),
    gameTime = UI.getChildControl(Panel_TimeBar, "StaticText_Time")
  },
  _terrainType = 0
}
radarTime.controls.regionType:SetShow(false)
radarTime.controls.regionName:SetShow(false)
local terrainNotice = UI.getChildControl(Panel_Radar, "Static_Notice")
local terrainNoticeStyle = UI.getChildControl(Panel_Radar, "StaticText_Notice")
local terrainNoticeText = UI.createControl(__ePAUIControl_StaticText, terrainNotice, "terrainNoticeText")
local textInfo = ""
Panel_Radar:SetChildIndex(terrainNotice, 9999)
CopyBaseProperty(terrainNoticeStyle, terrainNoticeText)
UI.deleteControl(terrainNoticeStyle)
terrainNoticeStyle = nil
terrainNoticeText:SetSpanSize(10, 0)
local floor = math.floor
local atan2 = math.atan2
local max = math.max
local min = math.min
local PI = math.pi
local RegionData_IngameTime = 0
local RegionData_RealIngameTime = 0
local dayCycle = 86400
local QuestArrowHalfSize = 0
local checkLoad = function()
  local radarControl = radarMap.controls
  local SPI = radarControl.icon_SelfPlayer
  UI.ASSERT(SPI:GetSizeX() == SPI:GetSizeY(), "[Radar.lua] icon_SelfPlayer MEST BE 'square'")
end
local function updateWorldMapDistance(mapRadius)
  local config = radarMap.config
  config.mapRadius = min(max(mapRadius, scaleMinValue), scaleMaxValue)
  ToClient_setRadorUIMapRadius(radarMap.config.mapRadius)
  radarMap.worldDistanceToPixelRate = config.mapRadiusByPixel / config.mapRadius
  ToClient_setRadorUIDistanceToPixelRate(radarMap.worldDistanceToPixelRate * 0.02)
  RadarMap_UpdatePixelRate()
end
function Radar_updateWorldMapDistance_Reset()
  radarMap.config.mapRadius = radarMap.config.constMapRadius
  ToClient_setRadorUIMapRadius(radarMap.config.mapRadius)
  FGlobal_Radar_updateWorldMapDistance_Relative(1.3)
end
function FGlobal_Radar_updateWorldMapDistance_Relative(value)
  updateWorldMapDistance(radarMap.config.mapRadius + radarMap.config.constMapRadius * value)
  local percents = radarMap.config.mapRadius - scaleMinValue
  percents = max(min(percents, 100), 0)
  radar_SizeSlider:SetControlPos(100 - percents)
  ToClient_SetRaderScale(radar_SizeSlider:GetControlPos())
  ToClient_SaveUiInfo(false)
end
function FGlobal_Radar_UpdateWorldMapDistance(value)
end
local function controlAlignForNomal()
  radarMap.scaleRateWidth = Panel_Radar:GetSizeX() * Panel_ReciprocalOrigSizeX
  radarMap.scaleRateHeight = Panel_Radar:GetSizeY() * Panel_ReciprocalOrigSizeY
  local scl_minus = radarMap.controls.radar_Minus
  local scl_plus = radarMap.controls.radar_Plus
  radar_SizeSlider:SetScale(radarMap.scaleRateWidth, 1)
  scl_plus:SetPosX(scl_minus:GetPosX() + scl_minus:GetSizeX() + radar_SizeSlider:GetSizeX() + 15)
  local alpha_plus = radarMap.controls.radar_AlphaPlus
  local alpha_minus = radarMap.controls.radar_AlphaMinus
  radar_AlphaScrl:SetScale(1, radarMap.scaleRateHeight)
  alpha_minus:SetPosY(alpha_plus:GetPosY() + radar_AlphaScrl:GetSizeY() + alpha_minus:GetSizeY() + 5)
  local resetIcon = radarMap.controls.radar_Reset
  resetIcon:SetVerticalBottom()
  resetIcon:SetHorizonRight()
  radar_MiniMapScl:SetVerticalBottom()
  radar_DangerIcon:ComputePos()
  radar_regionWarName:ComputePos()
end
local function controlAlignForRemaster()
  if false == Panel_Radar:GetShow() then
    return
  end
  radarMap.scaleRateWidth = Panel_Radar:GetSizeX() * Panel_ReciprocalOrigSizeX
  radarMap.scaleRateHeight = Panel_Radar:GetSizeY() * Panel_ReciprocalOrigSizeY
  local alphaScrlScaleY = radarMap.scaleRateHeight + (radarMap.scaleRateHeight - 1) * 0.5
  radar_AlphaScrl:SetScale(1, alphaScrlScaleY)
  local resetIcon = radarMap.controls.radar_Reset
  local scl_plus = radarMap.controls.radar_Plus
  local scl_minus = radarMap.controls.radar_Minus
  radar_regionName:SetHorizonCenter()
  radar_regionSubName:SetHorizonCenter()
  radar_DangerIcon:ComputePos()
  radar_regionWarName:ComputePos()
  radar_regionNodeName:ComputePos()
  scl_plus:ComputePos()
  scl_minus:ComputePos()
  radar_MiniMapScl:SetVerticalBottom()
  radar_AlphaScrl:SetPosY(scl_minus:GetPosY() + scl_minus:GetSizeY() + 10)
  resetIcon:SetPosX(scl_plus:GetPosX() + 2)
  resetIcon:SetPosY(scl_plus:GetPosY() - resetIcon:GetSizeY() - 5)
  local timeBarSizeX = Panel_Radar:GetSizeX() - 20 * radarMap.scaleRateWidth + 10
  local timeBarSizeY = Panel_Radar:GetSizeY() - 10 * radarMap.scaleRateHeight + 23
  Panel_TimeBar:SetSize(timeBarSizeX, 22)
  Panel_TimeBar:SetPosX(Panel_Radar:GetPosX() + 10 * radarMap.scaleRateWidth - 6)
  radar_MiniMapScl:SetPosX(radar_MiniMapScl:GetPosX() + 10 * radarMap.scaleRateWidth)
  radar_MiniMapScl:SetPosY(radar_MiniMapScl:GetPosY() - 10 * radarMap.scaleRateHeight)
  RadarMap_UpdatePosition()
end
local function controlAlign()
  if true == _ContentsGroup_RemasterUI_Radar then
    controlAlignForRemaster()
  else
    controlAlignForNomal()
  end
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
  end
end
local MAX_WIDTH = 512
local MAX_HEIGHT = 512
function PaGlobalFunc_SetMiniMapHardCoreBlackFieldArea(isShow)
  if isHardCoreChannel == false then
    return
  end
  local areaControl = radarMap.hardCoreBlackFieldArea.control
  if areaControl == nil or isShow == nil then
    return
  end
  if isShow == false or ToClient_IsHardCorePlayerInBlackField() == false then
    areaControl:SetShow(false)
    return
  end
  local position = ToClient_GetBattleRoyalRegionCenterPosition()
  radarMap.hardCoreBlackFieldArea.x = position.x
  radarMap.hardCoreBlackFieldArea.y = position.y
  radarMap.hardCoreBlackFieldArea.z = position.z
  radarMap.hardCoreBlackFieldArea.radius = ToClient_GetBattleRoyalRegionRadius()
  local pixelRate = radarMap.worldDistanceToPixelRate * 0.02
  local size = floor(pixelRate * radarMap.hardCoreBlackFieldArea.radius) * 2
  areaControl:SetSize(size, size)
  areaControl:SetShow(true)
end
function FromClient_ChangeRadarSettingForGuildSiege()
  if nil == Panel_Radar then
    return
  end
  Panel_Radar_ShowToggle()
  isShowOtherIcon = false
  radar_regionName:SetShow(false)
  radar_regionSubName:SetShow(false)
  radar_regionWarName:SetShow(false)
  radar_regionNodeName:SetShow(false)
  radar_MiniMapScl:SetShow(false)
  radar_ChangeBtn:SetShow(false)
  MAX_WIDTH = 614.4
  MAX_HEIGHT = 614.4
  Panel_Radar:SetSize(MAX_WIDTH, MAX_HEIGHT)
  radarMap.controls.radar_Background:SetSize(MAX_WIDTH, MAX_HEIGHT)
  Panel_Radar:SetHorizonCenter()
  Panel_Radar:SetVerticalMiddle()
  radarMap.controls.radar_Background:SetHorizonCenter()
  radarMap.controls.radar_Background:SetVerticalMiddle()
  for _, areaQuest in pairs(radarMap.areaQuests) do
    if nil ~= areaQuest.icon_QuestArea then
      areaQuest.icon_QuestArea:SetShow(false)
    end
    if nil ~= areaQuest.icon_QuestArrow then
      areaQuest.icon_QuestArrow:SetShow(false)
    end
  end
  radarMap.controls.icon_SelfPlayer:SetShow(false)
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  controlAlign()
  Panel_NpcNavi_All:SetShow(false)
  if nil ~= Panel_Widget_TownNpcNavi then
    Panel_Widget_TownNpcNavi:SetShow(false)
  end
  if nil ~= Panel_QuestInfo then
    Panel_QuestInfo:SetShow(false)
  end
  radarMap.template.area_quest:SetShow(false)
  radarMap.template.area_quest_guideArrow:SetShow(false)
  if nil ~= PaGlobal_KeyboardGuideButton then
    PaGlobal_KeyboardGuideButton_Position()
  end
  Panel_PlayerEndurance_Position()
  Panel_CarriageEndurance_Position()
  Panel_HorseEndurance_Position()
  Panel_ShipEndurance_Position()
  Panel_SailShipEndurance_Position()
  if nil ~= FromClient_Widget_TownSimpleNavi_All_OnScreenResize then
    FromClient_Widget_TownSimpleNavi_All_OnScreenResize()
  end
  if nil ~= Panel_Widget_BetterEquipment then
    PaGlobalFunc_BetterEquipment_OnScreenResize()
  end
  if nil ~= Panel_CommonGameScreenUI then
    PaGlobal_BossCamera_Repos()
  end
  FromClient_MainQuestWidget_ResetPosition()
  if true == _ContentsGroup_AccesoryQuest and nil ~= Panel_Widget_AccesoryQuest then
    PaGlobalFunc_AccesoryQuest_OnScreenResize()
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    PaGlobal_HardCoreQuest_UpdateWidgetPosition()
  end
  if false == _ContentsGroup_RemasterUI_QuestWidget then
    PaGlobalFunc_Quest_UpdatePosition()
  end
  ToClient_SaveUiInfo(false)
  radarAlert_Resize()
  RadarMap_HideIconWithOutPlayerIcon()
  radarMap.controls.radar_Plus:SetShow(false)
  radarMap.controls.radar_Minus:SetShow(false)
  radarMap.controls.radar_AlphaPlus:SetShow(false)
  radarMap.controls.radar_AlphaMinus:SetShow(false)
  radarMap.controls.radar_Reset:SetShow(false)
  radarMap.controls.radar_Close:SetShow(false)
  radarMap.controls.timeNum:SetShow(false)
  HandleClicked_RadarResize()
end
function FromClient_MapSizeScale()
  local origEndX = Panel_Radar:GetPosX() + Panel_Radar:GetSizeX()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if MAX_WIDTH >= origEndX - mousePosX and origEndX - mousePosX >= Panel_OrigSizeX then
    Panel_Radar:SetPosX(mousePosX)
    Panel_Radar:SetSize(origEndX - mousePosX, Panel_Radar:GetSizeY())
    radarMap.controls.radar_Background:SetPosX(0)
    radarMap.controls.radar_Background:SetSize(origEndX - mousePosX, Panel_Radar:GetSizeY())
  end
  if MAX_HEIGHT >= mousePosY - Panel_Radar:GetPosY() and mousePosY - Panel_Radar:GetPosY() >= Panel_OrigSizeY then
    Panel_Radar:SetSize(Panel_Radar:GetSizeX(), mousePosY - Panel_Radar:GetPosY())
    radarMap.controls.radar_Background:SetSize(Panel_Radar:GetSizeX(), mousePosY - Panel_Radar:GetPosY())
  end
  local SPI = radarMap.controls.icon_SelfPlayer
  local halfSelfSizeX = SPI:GetSizeX() / 2
  local halfSelfSizeY = SPI:GetSizeY() / 2
  local halfSizeX = Panel_Radar:GetSizeX() / 2
  local halfSizeY = Panel_Radar:GetSizeY() / 2
  SPI:SetPosX(halfSizeX - halfSelfSizeX)
  SPI:SetPosY(halfSizeY - halfSelfSizeY)
  radarMap.pcPosBaseControl.x = SPI:GetPosX() + halfSelfSizeX
  radarMap.pcPosBaseControl.y = SPI:GetPosY() + halfSelfSizeY
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  controlAlign()
  PaGlobal_NpcNavi_All_ResetPosistion()
  TownNpcIcon_Resize()
  if nil ~= PaGlobal_KeyboardGuideButton then
    PaGlobal_KeyboardGuideButton_Position()
  end
  Panel_PlayerEndurance_Position()
  Panel_CarriageEndurance_Position()
  Panel_HorseEndurance_Position()
  Panel_ShipEndurance_Position()
  Panel_SailShipEndurance_Position()
  if nil ~= Panel_Widget_BetterEquipment then
    PaGlobalFunc_BetterEquipment_OnScreenResize()
  end
  if nil ~= Panel_CommonGameScreenUI then
    PaGlobal_BossCamera_Repos()
  end
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    FGlobal_PersonalIcon_ButtonPosUpdate()
  else
    FromClient_Widget_FunctionButton_Resize()
  end
  FromClient_MainQuestWidget_ResetPosition()
  FromClient_questWidget_ResetPosition()
  if true == _ContentsGroup_AccesoryQuest and nil ~= Panel_Widget_AccesoryQuest then
    PaGlobalFunc_AccesoryQuest_OnScreenResize()
  end
  if nil ~= FromClient_Widget_TownSimpleNavi_All_OnScreenResize then
    FromClient_Widget_TownSimpleNavi_All_OnScreenResize()
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    PaGlobal_HardCoreQuest_UpdateWidgetPosition()
  end
  if false == _ContentsGroup_RemasterUI_QuestWidget then
    PaGlobalFunc_Quest_UpdatePosition()
  end
  ToClient_SaveUiInfo(false)
  radarAlert_Resize()
  if nil ~= Panel_GuildInvite_Alert then
    PaGlobal_GuildInviteAlert_SetPos()
  end
end
function Radar_IconsSetAlpha(alpha)
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
    return
  end
  local actorAlpha = max(min(alpha + 0.2, 1), 0.7)
  for _, areaQuest in pairs(radarMap.areaQuests) do
    areaQuest.icon_QuestArea:SetAlpha(actorAlpha)
    areaQuest.icon_QuestArrow:SetAlpha(actorAlpha)
  end
  radarMap.controls.icon_SelfPlayer:SetAlpha(actorAlpha)
  RadarMapBG_SetAlphaValue(alphaValue)
  FGlobal_PositionGuideSetAlpha(actorAlpha)
end
function Radar_CalcAlaphValue(alpha)
  alphaValue = max(min(alpha, 1), 0)
  radar_AlphaScrl:SetControlPos(100 * (1 - alphaValue))
  alphaValue = alphaValue + (1 - alphaValue) * 0.5
  return alphaValue
end
function Radar_updateWorldMap_AlphaControl(alpha)
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
    return
  end
  alphaValue = Radar_CalcAlaphValue(1 - radar_AlphaScrl:GetControlPos() + alpha)
  Radar_IconsSetAlpha(alphaValue)
  ToClient_SetRaderAlpha(radar_AlphaScrl:GetControlPos())
  ToClient_SaveUiInfo(false)
end
function FGlobal_ReloadRadarAlphaValue()
  alphaValue = Radar_CalcAlaphValue(alphaValue)
  Radar_IconsSetAlpha(alphaValue)
end
function Radar_updateWorldMap_AlphaControl_Init()
  local alphaSlideValue = 1 - radar_AlphaScrl:GetControlPos()
  alphaSlideValue = Radar_CalcAlaphValue(alphaSlideValue)
  Radar_IconsSetAlpha(alphaSlideValue)
  alphaValue = alphaSlideValue
end
function Radar_updateWorldMap_AlphaControl_Scrl()
  Radar_updateWorldMap_AlphaControl_Init()
  ToClient_SetRaderAlpha(radar_AlphaScrl:GetControlPos())
  ToClient_SaveUiInfo(false)
end
function Radar_updateWorldMap_ScaleControl_Scrl()
  local scaleSlideValue = 1 - radar_SizeSlider:GetControlPos()
  updateWorldMapDistance(scaleMinValue + scaleSlideValue * 100)
  PaGlobal_NpcNavi_All_ResetPosistion()
  ToClient_SetRaderScale(radar_SizeSlider:GetControlPos())
  ToClient_SaveUiInfo(false)
end
function Radar_updateWorldMap_ScaleControl_Wheel(isUp)
  if true == isUp then
    if wheelCount > 0 then
      wheelCount = wheelCount - 0.05
      updateWorldMapDistance(radarMap.config.mapRadius + wheelCount * 100)
    end
  elseif wheelCount < 1 then
    wheelCount = wheelCount + 0.05
    updateWorldMapDistance(radarMap.config.mapRadius + wheelCount * 100)
  end
  local percents = wheelCount * 100
  radar_SizeSlider:SetControlPos(100 - percents)
  PaGlobal_NpcNavi_All_ResetPosistion()
end
function Radar_SetRotateMode(isRotate)
  radarMap.isRotateMode = isRotate
  local rot = 0
  if isRotate then
    rot = PI
  else
    resetRadarActorListRotateValue()
    resetPinRotate()
  end
  local radarControl = radarMap.controls
  radarControl.radar_Background:SetParentRotCalc(isRotate)
  radarControl.icon_SelfPlayer:SetRotate(rot)
  FGlobal_GuildPinRotateMode(isRotate)
  FGlobal_PinRotateMode(isRotate)
  RadarBackground_SetRotateMode(isRotate)
  Radar_UpdateQuestList()
end
function FromClient_ChangeRadarArrow(isShowRadarArrow)
  radarMap.isShowRadarArrow = isShowRadarArrow
end
local pinX, pinZ
function Radar_PinUpdate(isAlways)
  SendPingInfo_ToClient(isAlways)
end
function Radar_MouseOn()
  isMouseOn = true
end
function Radar_MouseOut()
  isMouseOn = false
end
function FGlobal_Radar_HandleMouseOn()
  if false == isShowOtherIcon then
    return
  end
  PaGlobal_TutorialManager:handleRadarMouseOn()
end
GLOBAL_CHECK_WORLDMINIMAP = false
function RadarMap_Background_MouseRUp()
  if true == GLOBAL_CHECK_WORLDMINIMAP then
    return
  end
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local posX = mousePosX - Panel_Radar:GetPosX()
  local posZ = mousePosY - Panel_Radar:GetPosY() - Panel_Radar:GetSizeY()
  if true == _ContentsGroup_InstanceHorseRacing and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACING_CANT_WAYPOINT"))
    return
  end
  if 0 ~= ToClient_GetMyTeamNoRedBattleField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_LOCALWAR_CANTNAVI_ACK"))
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TUTORIAL_PROGRSS_ACK"))
    FGlobal_QuestWidget_UpdateList()
    return
  end
  if NaviGuidePanel ~= nil then
    local guideControl = UI.getChildControl(NaviGuidePanel, "MultilineText_Guide")
    guideControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAVI_AUTORUN_GUIDE"))
  end
  if nil ~= PaGlobalFunc_SetLastFindNodeKey then
    PaGlobalFunc_SetLastFindNodeKey(nil)
  end
  if ToClient_IsShowNaviGuideGroup(0) then
    radar_MiniMapScl:AddEffect("fUI_Button_Hide", false, posX, posZ)
    ToClient_DeleteNaviGuideByGroup(0)
  else
    radar_MiniMapScl:AddEffect("fUI_Button_Hide", false, posX, posZ)
    local posX = mousePosX - Panel_Radar:GetPosX()
    local posY = mousePosY - Panel_Radar:GetPosY()
    local intervalX = posX - (radarMap.controls.icon_SelfPlayer:GetPosX() + radarMap.controls.icon_SelfPlayer:GetSizeX() / 2)
    local intervalZ = radarMap.controls.icon_SelfPlayer:GetPosY() + radarMap.controls.icon_SelfPlayer:GetSizeY() / 2 - posY
    intervalX = intervalX * (100 / (radarMap.worldDistanceToPixelRate * 2))
    intervalZ = intervalZ * (100 / (radarMap.worldDistanceToPixelRate * 2))
    local selfPlayerControlPos = radarMap.pcPosBaseControl
    local dist = intervalX - selfPlayerControlPos.x
    local disty = intervalZ - selfPlayerControlPos.y
    local tempPos = float2(dist, disty)
    local camRot = getCameraRotation()
    if radarMap.isRotateMode then
      tempPos:rotate(camRot + PI)
    end
    local selfPosition = getSelfPlayer():get3DPos()
    local float3Pos = float3(selfPosition.x + tempPos.x, 0, selfPosition.z + tempPos.y)
    float3Pos.y = selfPosition.y
    ToClient_WorldMapNaviStart(float3Pos, NavigationGuideParam(), false, true)
    audioPostEvent_SystemUi(0, 14)
    _AudioPostEvent_SystemUiForXBOX(0, 14)
  end
end
local function controlInit()
  local radarControl = radarMap.controls
  radarControl.timeNum:SetShow(false)
  radarControl.timeNum:SetIgnore(true)
  local SPI = radarControl.icon_SelfPlayer
  radarMap.pcPosBaseControl.x = SPI:GetPosX() + SPI:GetSizeX() / 2
  radarMap.pcPosBaseControl.y = SPI:GetPosY() + SPI:GetSizeY() / 2
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  radarTime.controls.terrainInfo:addInputEvent("Mouse_On", "TerrainInfo_ShowBubble(true)")
  radarTime.controls.terrainInfo:addInputEvent("Mouse_Out", "TerrainInfo_ShowBubble(false)")
  radarTime.controls.raining:addInputEvent("Mouse_On", "Radar_Icon_Help_BubbleShowFunc(" .. 0 .. ", true )")
  radarTime.controls.raining:addInputEvent("Mouse_Out", "Radar_Icon_Help_BubbleShowFunc(" .. 0 .. ", false )")
  radarTime.controls.citadel:addInputEvent("Mouse_On", "Radar_Icon_Help_BubbleShowFunc(" .. 1 .. ", true )")
  radarTime.controls.citadel:addInputEvent("Mouse_Out", "Radar_Icon_Help_BubbleShowFunc(" .. 1 .. ", false )")
  radarTime.controls.siegeArea:addInputEvent("Mouse_On", "Radar_Icon_Help_BubbleShowFunc(" .. 2 .. ", true )")
  radarTime.controls.siegeArea:addInputEvent("Mouse_Out", "Radar_Icon_Help_BubbleShowFunc(" .. 2 .. ", false )")
  radarTime.controls.VillageWar:addInputEvent("Mouse_On", "Radar_Icon_Help_BubbleShowFunc(" .. 3 .. ", true )")
  radarTime.controls.VillageWar:addInputEvent("Mouse_Out", "Radar_Icon_Help_BubbleShowFunc(" .. 3 .. ", false )")
  radarTime.controls.gameTime:addInputEvent("Mouse_On", "Radar_Time_Tooltip(true)")
  radarTime.controls.gameTime:addInputEvent("Mouse_Out", "Radar_Time_Tooltip(false)")
  radar_DangerIcon:addInputEvent("Mouse_On", "Radar_Icon_Help_BubbleShowFunc(" .. 4 .. ", true )")
  radar_DangerIcon:addInputEvent("Mouse_Out", "Radar_Icon_Help_BubbleShowFunc(" .. 4 .. ", false )")
  Panel_Radar:RegisterUpdateFunc("RadarMap_UpdatePerFrame")
  radarControl.radar_Plus:addInputEvent("Mouse_LUp", "FGlobal_Radar_updateWorldMapDistance_Relative(-0.1)")
  radarControl.radar_Minus:addInputEvent("Mouse_LUp", "FGlobal_Radar_updateWorldMapDistance_Relative(0.1)")
  radar_SizeBtn:addInputEvent("Mouse_LPress", "Radar_updateWorldMap_ScaleControl_Scrl()")
  radar_SizeSlider:addInputEvent("Mouse_LPress", "Radar_updateWorldMap_ScaleControl_Scrl()")
  radarControl.radar_AlphaPlus:addInputEvent("Mouse_LUp", "Radar_updateWorldMap_AlphaControl(0.05)")
  radarControl.radar_AlphaMinus:addInputEvent("Mouse_LUp", "Radar_updateWorldMap_AlphaControl(-0.05)")
  radar_AlphaBtn:addInputEvent("Mouse_LPress", "Radar_updateWorldMap_AlphaControl_Scrl()")
  radar_AlphaScrl:addInputEvent("Mouse_LPress", "Radar_updateWorldMap_AlphaControl_Scrl()")
  radar_AlphaScrl:SetControlPos(100 - alphaValue * 100)
  radarControl.radar_Reset:addInputEvent("Mouse_LUp", "Radar_updateWorldMapDistance_Reset()")
  radarControl.radar_Close:addInputEvent("Mouse_LDown", "Panel_Radar_ShowToggle()")
  radarControl.radar_Background:SetSize(Panel_Radar:GetSizeX(), Panel_Radar:GetSizeY())
  radarControl.radar_Background:addInputEvent("Mouse_LDown", "Radar_PinUpdate(false)")
  radarControl.radar_Background:addInputEvent("Mouse_LDClick", "Radar_PinUpdate(true)")
  radarControl.radar_Background:addInputEvent("Mouse_UpScroll", "FGlobal_Radar_updateWorldMapDistance_Relative(-0.1)")
  radarControl.radar_Background:addInputEvent("Mouse_RUp", "RadarMap_Background_MouseRUp()")
  radarControl.radar_Background:addInputEvent("Mouse_DownScroll", "FGlobal_Radar_updateWorldMapDistance_Relative(0.1)")
  radar_MiniMapScl:addInputEvent("Mouse_LPress", "FromClient_MapSizeScale()")
  radar_MiniMapScl:addInputEvent("Mouse_On", "RadarScale_SimpleTooltips( true )")
  radar_MiniMapScl:addInputEvent("Mouse_Out", "RadarScale_SimpleTooltips( false )")
  radar_MiniMapScl:addInputEvent("Mouse_LUp", "HandleClicked_RadarResize()")
  radar_MiniMapScl:setTooltipEventRegistFunc("RadarScale_SimpleTooltips( true )")
  radar_MiniMapScl:setClickMouseCursorType(__eMouseCursorType_ResizeLeft)
  radar_MiniMapScl:setOnMouseCursorType(__eMouseCursorType_ResizeLeft)
  radarTime.controls.channelName:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServerSelct_Open()")
  controlAlign()
  RadarMap_Init()
  Radar_RecoveryDefaultMaskingTexture()
  Panel_Radar:setMaskingChild(true)
  radarControl.radar_Plus:SetNotAbleMasking(true)
  radarControl.radar_Minus:SetNotAbleMasking(true)
  radar_SizeBtn:SetNotAbleMasking(true)
  radar_SizeSlider:SetNotAbleMasking(true)
  radarControl.radar_AlphaPlus:SetNotAbleMasking(true)
  radarControl.radar_AlphaMinus:SetNotAbleMasking(true)
  radar_AlphaBtn:SetNotAbleMasking(true)
  radar_AlphaScrl:SetNotAbleMasking(true)
  radarControl.radar_Reset:SetNotAbleMasking(true)
  radarControl.radar_Close:SetNotAbleMasking(true)
  radar_MiniMapScl:SetNotAbleMasking(true)
  radar_ChangeBtn:SetNotAbleMasking(true)
  radar_ChangeBtn:addInputEvent("Mouse_LUp", "PaGlobal_changeRadarUI()")
  radar_ChangeBtn:SetDepth(-9999)
  radar_SequenceAni:SetNotAbleMasking(true)
  radarControl.radar_Plus:SetAlpha(0)
  radarControl.radar_Minus:SetAlpha(0)
  radar_SizeBtn:SetAlpha(0)
  radar_SizeSlider:SetAlpha(0)
  radarControl.radar_AlphaPlus:SetAlpha(0)
  radarControl.radar_AlphaMinus:SetAlpha(0)
  radar_AlphaBtn:SetAlpha(0)
  radar_AlphaScrl:SetAlpha(0)
  radarControl.radar_Reset:SetAlpha(0)
  radarControl.radar_Close:SetAlpha(0)
  radar_MiniMapScl:SetAlpha(0)
  radar_ChangeBtn:SetAlpha(1)
  radar_SequenceAni:SetAlpha(0)
  radarControl.icon_SelfPlayer:SetRotate(PI)
  radar_AlphaScrl:SetControlPos(ToClient_GetRaderAlpha() * 100)
  Radar_updateWorldMap_AlphaControl_Init()
  radar_SizeSlider:SetControlPos(ToClient_GetRaderScale() * 100)
  local scaleSlideValue = 1 - radar_SizeSlider:GetControlPos()
  updateWorldMapDistance(scaleMinValue + scaleSlideValue * 100)
  radarAlert_Resize()
end
function Radar_RecoveryDefaultMaskingTexture()
  if false == _ContentsGroup_RemasterUI_Radar then
    Panel_Radar:ChangeSpecialTextureInfoName("New_UI_Common_forLua/Widget/Rader/Minimap_Mask.dds")
  else
    Panel_Radar:ChangeSpecialTextureInfoName("Renewal/Function/Console_Minimap_Mask.dds")
  end
end
local weatherTooltip = 0
local buildingTooltip = 0
local siegeTooltip = 0
local VillageWarTooltip = 0
function Radar_Icon_Help_BubbleShowFunc(iconNo, isOn)
  if iconNo == 0 then
    if 0 == weatherTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_WEATHER_RAIN_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_REDUCED_DAMAGE_REASON_RAIN")
      uiControl = radarTime.controls.raining
    elseif 2 == weatherTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_WEATHER_SNOW_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_REDUCED_DAMAGE_REASON_SNOW")
      uiControl = radarTime.controls.raining
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_WEATHER_CLEAR_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_WEATHER_CLEAR_DESC")
      uiControl = radarTime.controls.raining
    end
  elseif iconNo == 1 then
    if 1 == buildingTooltip or 2 == buildingTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_COMBATPOSSIBLE_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_COMBATPOSSIBLE_DESC")
      uiControl = radarTime.controls.citadel
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_COMBATIMPOSSIBLE_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_COMBATIMPOSSIBLE_DESC")
      uiControl = radarTime.controls.citadel
    end
  elseif iconNo == 2 then
    if 0 == siegeTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEPOSSIBLE1_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEPOSSIBLE1_DESC")
      uiControl = radarTime.controls.siegeArea
    elseif 1 == siegeTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEPOSSIBLE2_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEPOSSIBLE2_DESC")
      uiControl = radarTime.controls.siegeArea
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEIMPOSSIBLE_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_SIEGEIMPOSSIBLE_DESC")
      uiControl = radarTime.controls.siegeArea
    end
  elseif iconNo == 3 then
    if 0 == VillageWarTooltip then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_VILLAGEWARABLE_NAME")
      if "" ~= nodeWarRegionName then
        desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_VILLAGEWARABLE_DESC_RENEW", "nodeWarRegionName", nodeWarRegionName)
      else
        desc = ""
      end
      uiControl = radarTime.controls.VillageWar
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_VILLAGEWARDISABLE_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_VILLAGEWARDISABLE_DESC")
      uiControl = radarTime.controls.VillageWar
    end
  elseif 4 == iconNo then
    local player = getSelfPlayer()
    if nil == player then
      return
    end
    local playerGet = player:get()
    local ChaTendency = playerGet:getTendency()
    name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_INTO_DESERT_TITLE")
    desc = ""
    if ChaTendency < 0 then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_INTO_COMBATZONE_FOR_CAOTIC_DESC")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_INTO_DESERT_DESC")
    end
    uiControl = radar_DangerIcon
  end
  if isOn == true then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Radar_Time_Tooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, uiControl
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_GAMETIME_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_GAMETIME_DESC")
  local uiControl = radarTime.controls.gameTime
  TooltipSimple_Show(uiControl, name, desc)
end
function TerrainInfo_ShowBubble(isShow)
  local terraintype = selfPlayerNaviMaterial()
  local radarControl = radarTime.controls
  if terraintype == 0 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_NORMAL")
  elseif terraintype == 1 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_ROAD")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_ROAD")
  elseif terraintype == 2 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SNOW")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_SNOW")
  elseif terraintype == 3 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DESERT")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_DESERT")
  elseif terraintype == 4 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SWAMP")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_SWAMP")
  elseif terraintype == 5 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OBJECT")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_OBJECT")
  elseif terraintype == 6 then
    local speed = ToClient_GetCurrentOceanW()
    if speed >= 1.7 then
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_SEAWAY")
      roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_SEAWAY")
    elseif speed >= 1.25 then
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DEEP_WATER")
      roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_DEEP_WATER")
    else
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_WATER")
      roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_WATER")
    end
  elseif terraintype == 7 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_GRASS")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_GRASS")
  elseif terraintype == 8 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_DEEPWATER")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_DEEPWATER")
  elseif terraintype == 9 then
    textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_AIR")
    roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_AIR")
  else
    if nil ~= getSelfPlayer() then
      return
    end
    local isOcean = getSelfPlayer():getCurrentRegionInfo():isOcean()
    if isOcean then
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OCEAN")
      roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_OCEAN")
    else
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
      roadInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAINTYPE_NORMAL")
    end
  end
  name = roadInfo
  desc = textInfo
  if _ContentsGroup_ViewRate == true then
    desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_TIMEBAR_VIEW_INFO")
  end
  uiControl = radarTime.controls.terrainInfo
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function RadarScale_SimpleTooltips(isShow)
  local name, desc, uiControl
  name = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_RADER_MINIMAP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TOOLTIP_RADER_MINIMAP_DESC")
  uiControl = radar_MiniMapScl
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function RadarShowAni()
  Panel_Radar:ResetVertexAni()
  local aniInfo1 = Panel_Radar:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(getScreenSizeX(), Panel_Radar:GetPosY())
  aniInfo1:SetEndPosition(getScreenSizeX() - Panel_Radar:GetSizeX() - Panel_Radar:GetSpanSize().x, Panel_Radar:GetPosY())
  aniInfo1.IsChangeChild = true
end
function RadarHideAni()
  Panel_Radar:ResetVertexAni()
  local aniInfo1 = Panel_Radar:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartPosition(Panel_Radar:GetPosX(), Panel_Radar:GetPosY())
  aniInfo1:SetEndPosition(Panel_Radar:GetPosX() + 600, Panel_Radar:GetPosY())
  aniInfo1.IsChangeChild = true
end
local _timeBarIsHiding = false
function TimebarShowAni()
  _timeBarIsHiding = false
  Panel_TimeBar:ResetVertexAni()
  local aniInfo1 = Panel_TimeBar:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(getScreenSizeX(), Panel_TimeBar:GetPosY())
  aniInfo1:SetEndPosition(getScreenSizeX() - Panel_TimeBar:GetSizeX() - Panel_TimeBar:GetSpanSize().x, Panel_TimeBar:GetPosY())
  aniInfo1.IsChangeChild = true
end
function TimebarHideAni()
  _timeBarIsHiding = true
  Panel_TimeBar:ResetVertexAni()
  local aniInfo1 = Panel_TimeBar:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartPosition(Panel_TimeBar:GetPosX(), Panel_TimeBar:GetPosY())
  aniInfo1:SetEndPosition(Panel_TimeBar:GetPosX() + 600, Panel_TimeBar:GetPosY())
  aniInfo1.IsChangeChild = true
end
function SortRadar_IconIndex()
  local mapButton = radarMap.controls
  Panel_Radar:SetChildIndex(radar_SizeSlider, 9999)
  Panel_Radar:SetChildIndex(radar_AlphaScrl, 9999)
  Panel_Radar:SetChildIndex(mapButton.radar_Reset, 9999)
  Panel_Radar:SetChildIndex(radar_MiniMapScl, 9999)
end
function radarMap:getIdleIcon()
  local iconPool = self.iconPool
  if 0 < iconPool:length() then
    return iconPool:pop_back()
  else
    self.iconCreateCount = self.iconCreateCount + 1
    local make_Icon = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_Icon_" .. self.iconCreateCount)
    return make_Icon
  end
end
function radarMap:returnIconToPool(icon)
  self.iconPool:push_back(icon)
end
function radarMap:getIdleQuest()
  local questPool = self.questIconPool
  if 0 < questPool:length() then
    return questPool:pop_back()
  else
    self.questCreateCount = self.questCreateCount + 1
    local iconQuestArea = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_QuestArea_" .. self.questCreateCount)
    local iconQuestArrow = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_QuestArrow_" .. self.questCreateCount)
    CopyBaseProperty(self.template.area_quest, iconQuestArea)
    CopyBaseProperty(self.template.area_quest_guideArrow, iconQuestArrow)
    iconQuestArea:SetShow(false)
    iconQuestArrow:SetShow(false)
    iconQuestArea:SetSize(self.template.area_quest:GetSizeX(), self.template.area_quest:GetSizeY())
    iconQuestArrow:SetPosX(self.pcPosBaseControl.x - iconQuestArrow:GetSizeX() / 2)
    iconQuestArrow:SetPosY(self.pcPosBaseControl.y - iconQuestArrow:GetSizeY() / 2)
    iconQuestArrow:SetSize(self.template.area_quest_guideArrow:GetSizeX(), self.template.area_quest_guideArrow:GetSizeY())
    QuestArrowHalfSize = iconQuestArrow:GetSizeY() / 2
    local questIcon = {icon_QuestArea = iconQuestArea, icon_QuestArrow = iconQuestArrow}
    return questIcon
  end
end
function radarMap:returnQuestToPool(questIcon)
  self.questIconPool:push_back(questIcon)
end
function Panel_TimeBar_ShowToggle()
  local isShow = Panel_TimeBar:IsShow()
  if isShow then
    Panel_TimeBarNumber:SetShow(false)
    Panel_TimeBar:SetShow(false)
  else
    Panel_TimeBar:SetShow(true)
  end
end
function PaGlobalFunc_Panel_TimeBar_Show(isShow, withAni)
  if true == isShow and 0 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_TimeBar, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
    Panel_TimeBar:SetShow(false)
    return
  end
  if nil ~= withAni then
    Panel_TimeBar:SetShow(isShow, withAni)
  else
    Panel_TimeBar:SetShow(isShow)
  end
end
function RadarMap_updateRegion(isSafeZone, isArenaZone, isDesert, isAtoraxion, regionType, regionKey, areaName, territoryName)
  RadarMap_HidePanelConditionCheck()
  local radarControl = radarTime.controls
  local isHideNak = false
  if isSolareInstance == true or isGuildMatchInstance == true or isHardCoreChannel == true then
    isHideNak = true
  end
  currentSafeZone = isSafeZone
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local playerPos = playerWrapper:get3DPos()
  local linkedSiegeRegionInfoWrapper = ToClient_getInstallableVillageSiegeRegionInfoWrapper(playerPos)
  local isVillageWarZone = linkedSiegeRegionInfoWrapper:isVillageWarZone()
  local control = radarTime.controls.VillageWar
  control:ChangeTextureInfoNameAsync(villageWarUV._texture)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if isVillageWarZone == true then
    VillageWarTooltip = 0
  else
    VillageWarTooltip = 1
  end
  x1, y1, x2, y2 = setTextureUV_Func(control, villageWarUV[VillageWarTooltip][1], villageWarUV[VillageWarTooltip][2], villageWarUV[VillageWarTooltip][3], villageWarUV[VillageWarTooltip][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  radar_regionName:SetFontColor(UI_color.C_FFEFEFEF)
  radar_regionName:useGlowFont(false)
  radar_regionSubName:SetFontColor(UI_color.C_FFEFEFEF)
  radar_regionSubName:useGlowFont(false)
  radar_regionNodeName:SetFontColor(UI_color.C_FFEFEFEF)
  radar_regionNodeName:useGlowFont(false)
  radar_regionWarName:SetFontColor(UI_color.C_FFEFEFEF)
  radar_regionWarName:useGlowFont(false)
  radar_DangerIcon:SetShow(false)
  local ChaTendency = playerWrapper:getTendency()
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  if isSafeZone and false == isLocalWar then
    radar_regionName:SetFontColor(4292276981)
    radar_regionName:useGlowFont(true, glowFont._region, 4281961144)
    radar_regionNodeName:SetFontColor(4292276981)
    radar_regionNodeName:useGlowFont(true, glowFont._regionNode, 4281961144)
    radar_regionWarName:SetFontColor(4292276981)
    radar_regionWarName:useGlowFont(true, glowFont._regionWar, 4281961144)
    if true == beforeCombatZone then
      local msg = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_ISSAFETYZONE_ACK_MAIN"),
        sub = ""
      }
      if false == isHideNak then
        ToClient_RequestNakMessageRenewel(__eNakMessage_SafetyArea)
      end
      if nil ~= FGlobal_LevelupGuide_Open then
        FGlobal_LevelupGuide_Open()
      end
    end
    beforSafeZone = true
    beforeCombatZone = false
    beforeArenaZone = false
    beforeDesertZone = false
  elseif isArenaZone then
    if true == _ContentsGroup_ChinaFontColor then
      radar_regionName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionName:useGlowFont(true, glowFont._region, 4286580487)
      radar_regionNodeName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionNodeName:useGlowFont(true, glowFont._regionNode, 4286580487)
      radar_regionWarName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionWarName:useGlowFont(true, glowFont._regionWar, 4286580487)
    else
      radar_regionName:SetFontColor(4294495693)
      radar_regionName:useGlowFont(true, glowFont._region, 4286580487)
      radar_regionNodeName:SetFontColor(4294495693)
      radar_regionNodeName:useGlowFont(true, glowFont._regionNode, 4286580487)
      radar_regionWarName:SetFontColor(4294495693)
      radar_regionWarName:useGlowFont(true, glowFont._regionWar, 4286580487)
    end
    beforSafeZone = false
    beforeCombatZone = false
    beforeArenaZone = true
    beforeDesertZone = false
  else
    if true == _ContentsGroup_ChinaFontColor then
      radar_regionName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionName:useGlowFont(true, glowFont._region, 4286580487)
      radar_regionNodeName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionNodeName:useGlowFont(true, glowFont._regionNode, 4286580487)
      radar_regionWarName:SetFontColor(Defines.Color.C_FFFF9C00)
      radar_regionWarName:useGlowFont(true, glowFont._regionWar, 4286580487)
    else
      radar_regionName:SetFontColor(4294495693)
      radar_regionName:useGlowFont(true, glowFont._region, 4286580487)
      radar_regionNodeName:SetFontColor(4294495693)
      radar_regionNodeName:useGlowFont(true, glowFont._regionNode, 4286580487)
      radar_regionWarName:SetFontColor(4294495693)
      radar_regionWarName:useGlowFont(true, glowFont._regionWar, 4286580487)
    end
    if nil ~= Panel_Widget_HopeGaugeOnOff and PaGlobal_HopeGaugeOnOff_showByToday() == true then
      HandleEventLUp_HopeGaugeOnOff_Open()
    end
    local msg = ""
    if false == isHideNak then
      if ChaTendency >= 0 then
        if balenciaPart2 then
          if isDesert then
            ToClient_RequestNakMessageRenewel(__eNakMessage_DesertArea)
            radar_DangerIcon:SetShow(true)
            Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
          else
            ToClient_RequestNakMessageRenewel(__eNakMessage_CombatArea)
            radar_DangerIcon:SetShow(false)
            Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
          end
        else
          ToClient_RequestNakMessageRenewel(__eNakMessage_CombatArea)
          radar_DangerIcon:SetShow(false)
          Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
        end
      elseif balenciaPart2 then
        if isDesert then
          ToClient_RequestNakMessageRenewel(__eNakMessage_CombatArea)
          radar_DangerIcon:SetShow(false)
          Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
        else
          ToClient_RequestNakMessageRenewel(__eNakMessage_DesertAreaTendencyLowPlayer)
          radar_DangerIcon:SetShow(true)
          Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
        end
      else
        ToClient_RequestNakMessageRenewel(__eNakMessage_CombatArea)
        radar_DangerIcon:SetShow(false)
        Panel_Radar:SetChildIndex(radar_DangerIcon, 9999)
      end
    end
    beforSafeZone = not isDesert
    beforeCombatZone = not isDesert
    beforeArenaZone = not isDesert
    beforeDesertZone = isDesert
  end
  local regionNameSizeX = radar_Background:GetSizeX() - radar_ChangeBtn:GetSizeX() * 3 - radar_SizeBtn:GetSizeX()
  radar_regionName:SetSize(regionNameSizeX, radar_regionName:GetSizeY() + 3)
  radar_regionName:ComputePos()
  radarMap.regionTypeValue = regionType
  nodeWarRegionName = ""
  if linkedSiegeRegionInfoWrapper ~= nil then
    if isVillageWarZone == true then
      nodeWarRegionName = linkedSiegeRegionInfoWrapper:getAreaName()
    end
    radar_regionName:SetText(areaName)
  end
end
function NodeLevelRegionNameShow(wayPointKey)
  if false == isShowOtherIcon then
    return
  end
  local nodeName = ToClient_GetNodeNameByWaypointKey(wayPointKey)
  if "" == nodeName or nil == nodeName or true == _ContentsGroup_UsePadSnapping then
    radar_regionNodeName:SetShow(false)
  else
    radar_regionNodeName:SetShow(true)
    radar_regionNodeName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_REGIONNODENAME", "getName", nodeName))
    radar_regionNodeName:SetSize(radar_regionNodeName:GetTextSizeX() + 40, radar_regionNodeName:GetSizeY() + 3)
    radar_regionNodeName:ComputePos()
  end
  if "" == nodeWarRegionName or nil == nodeWarRegionName or true == _ContentsGroup_UsePadSnapping then
    radar_regionWarName:SetShow(false)
  else
    radar_regionWarName:SetShow(true)
    radar_regionWarName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_VILLAGEWARABLE_NAME", "regionName", nodeWarRegionName))
    radar_regionWarName:SetSize(radar_regionWarName:GetTextSizeX() + 40, radar_regionWarName:GetSizeY() + 3)
    radar_regionWarName:ComputePos()
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    radar_regionNodeName:SetShow(false)
    radar_regionWarName:SetShow(false)
  end
end
registerEvent("FromClint_EventChangedExplorationNode", "NodeLevelRegionNameShow")
local _nightCheck = 0
local _nightAlertCheck = 0
function RadarMap_UpdateTimePerFrame()
  local ingameTime = getIngameTime_variableSecondforLua()
  if ingameTime < 0 then
    return
  end
  if ingameTime > dayCycle then
    ingameTime = ingameTime % dayCycle
  end
  local showGameTime = GetUIMode() ~= Defines.UIMode.eUIMode_SkillWindow
  if ingameTime ~= RegionData_IngameTime and showGameTime then
    RegionData_IngameTime = ingameTime
    local minute = floor(ingameTime / 60) % 60
    local hour = floor(ingameTime / 3600)
    local calcMinute = "00"
    if minute < 10 then
      calcMinute = "0" .. minute
    else
      calcMinute = tostring(minute)
    end
    local radarControl = radarTime.controls
    if hour == 12 then
      radarControl.gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_AFTERNOON") .. " " .. tostring(hour) .. " : " .. calcMinute)
    elseif hour == 0 then
      local calcHour = hour + 12
      radarControl.gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. tostring(calcHour) .. " : " .. calcMinute)
    elseif hour == 24 then
      local calcHour = hour
      radarControl.gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. "0" .. " : " .. calcMinute)
    elseif hour > 11 then
      local calcHour = hour - 12
      radarControl.gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_AFTERNOON") .. " " .. tostring(calcHour) .. " : " .. calcMinute)
    else
      radarControl.gameTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " " .. tostring(hour) .. " : " .. calcMinute)
    end
  end
  local radarTimeControl = radarTime.controls
  local realInGameTime = getIngameTime_minute()
  if RegionData_RealIngameTime ~= realInGameTime then
    if realInGameTime > 1440 then
      realInGameTime = realInGameTime % 1440
    end
    local minute = floor(realInGameTime % 60)
    local hour = floor(realInGameTime / 60)
    if 22 == hour and 0 == minute / 60 then
      _nightCheck = 22
      if _nightCheck ~= _nightAlertCheck then
        Night_Alert(_nightCheck)
        _nightAlertCheck = _nightCheck
      end
    end
    if 2 == hour and 0 == minute / 60 then
      _nightCheck = 2
      if _nightCheck ~= _nightAlertCheck then
        Night_Alert(_nightCheck)
        _nightAlertCheck = _nightCheck
      end
    end
    if hour > 21 or hour < 2 then
      showUseLanternToolTip(true)
    else
      showUseLanternToolTip(false)
      useLanternAlertTime = 0
    end
  end
end
function showUseLanternToolTip(param)
  local isReplayStreamMode = ToClient_IsReplayStreamingMode()
  if true == isReplayStreamMode then
    return
  end
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  local itemWrapper = ToClient_getEquipmentItem(13)
  if nil == itemWrapper and true == param and useLanternAlertTime < 100 then
    FGlobal_ShowUseLantern(true)
    useLanternAlertTime = useLanternAlertTime + 1
  else
    FGlobal_ShowUseLantern(false)
  end
end
Panel_Radar_NightAlert:SetShow(false, false)
Panel_Radar_NightAlert:setMaskingChild(true)
Panel_Radar_NightAlert:RegisterShowEventFunc(true, "Radar_NightAlert_ShowAni()")
Panel_Radar_NightAlert:RegisterShowEventFunc(false, "Radar_NightAlert_HideAni()")
local Night_AlertPanel = UI.getChildControl(Panel_Radar_NightAlert, "Static_AlertPanel")
local Night_AlertText = UI.getChildControl(Panel_Radar_NightAlert, "StaticText_Alert_NoticeText")
local Night_AlertTextConsole = UI.getChildControl(Panel_Radar_NightAlert, "StaticText_Alert_NoticeTextConsole")
function Night_Alert(_nightCheck)
  local isReplayStreamMode = ToClient_IsReplayStreamingMode()
  if true == isReplayStreamMode then
    return
  end
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  local message = ""
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local control = Night_AlertText
  if _ContentsGroup_UsePadSnapping then
    Night_AlertText:SetShow(false)
    Night_AlertTextConsole:SetShow(true)
    control = Night_AlertTextConsole
  else
    Night_AlertText:SetShow(true)
    Night_AlertTextConsole:SetShow(false)
  end
  if 0 == isColorBlindMode then
    control:SetFontColor(UI_color.C_FFFF0000)
    if true == _ContentsGroup_ChinaFontColor then
      control:SetFontColor(UI_color.C_FFB08B29)
    end
  elseif 1 == isColorBlindMode then
    control:SetFontColor(UI_color.C_FF0096FF)
  elseif 2 == isColorBlindMode then
    control:SetFontColor(UI_color.C_FF0096FF)
  end
  if 22 == _nightCheck then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_RADER_NIGHT_ALERT_TEXT1"))
  elseif 2 == _nightCheck then
    control:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_RADER_NIGHT_ALERT_TEXT2"))
  else
    return
  end
  Night_AlertPanel:SetSize(control:GetTextSizeX() + 20, control:GetTextSizeY() + 20)
  Night_AlertPanel:ComputePos()
  control:ComputePos()
  Panel_Radar_NightAlert:SetShow(true, true)
  Night_AlertPanel:SetShow(true)
end
local _cumulateTime = 0
function Radar_NightAlert_Close(fDeltaTime)
  _cumulateTime = _cumulateTime + fDeltaTime
  if _cumulateTime >= 9 then
    Panel_Radar_NightAlert:SetShow(false, true)
    _cumulateTime = 0
  end
end
Panel_Radar_NightAlert:RegisterUpdateFunc("Radar_NightAlert_Close")
function Radar_NightAlert_ShowAni()
  audioPostEvent_SystemUi(1, 9)
  _AudioPostEvent_SystemUiForXBOX(1, 9)
  UIAni.fadeInSCR_MidOut(Panel_Radar_NightAlert)
end
function Radar_NightAlert_HideAni()
  Panel_Radar_NightAlert:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo6 = Panel_Radar_NightAlert:addColorAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo6:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo6.IsChangeChild = true
  aniInfo6:SetHideAtEnd(true)
  aniInfo6:SetDisableWhileAni(true)
end
function RadarMap_UpdateSelfPlayerPerFrame()
  local pcInfo = radarMap.pcInfo
  local selfPlayerPos = pcInfo.position
  selfPlayerPos.x = ToClient_getSelfPlayerPositionX()
  selfPlayerPos.y = ToClient_getSelfPlayerPositionY()
  selfPlayerPos.z = ToClient_getSelfPlayerPositionZ()
  ToClient_RadarMapUpdateSelfPlayerPerFrame()
end
function FromClient_setSiegeAttackAreaPosition(position)
end
local getPosBaseControl = function(actorPosition)
  local selfPlayerPos = radarMap.pcInfo.position
  local selfPlayerControlPos = radarMap.pcPosBaseControl
  local dx = (actorPosition.x - selfPlayerPos.x) * 0.01
  local dz = (selfPlayerPos.z - actorPosition.z) * 0.01
  local distanceSq = dx * dx + dz * dz
  local dxPerPixel = dx * radarMap.worldDistanceToPixelRate + selfPlayerControlPos.x
  local dyPerPixel = dz * radarMap.worldDistanceToPixelRate + selfPlayerControlPos.y
  local radius = radarMap.config.mapRadius
  local radiusSq = radius * radius
  return distanceSq < radiusSq, dxPerPixel, dyPerPixel
end
local getPosQuestControl = function(areaQuest)
  local selfPlayerPos = radarMap.pcInfo.position
  local selfPlayerControlPos = radarMap.pcPosBaseControl
  local dx = (areaQuest.x - selfPlayerPos.x) * 0.01
  local dz = (selfPlayerPos.z - areaQuest.z) * 0.01
  local distanceSq = dx * dx + dz * dz
  local dxPerPixel = dx * radarMap.worldDistanceToPixelRate * 2 + selfPlayerControlPos.x
  local dyPerPixel = dz * radarMap.worldDistanceToPixelRate * 2 + selfPlayerControlPos.y
  local radius = radarMap.config.mapRadius + areaQuest.radius * 0.01
  return distanceSq <= radius * radius, dxPerPixel, dyPerPixel
end
function RadarMap_UpdateHardCoreBlackField()
  if isHardCoreChannel == false then
    return
  end
  local areaControl = radarMap.hardCoreBlackFieldArea.control
  if areaControl == nil or areaControl:GetShow() == false then
    return
  end
  local isShow, posX, posY = getPosQuestControl(radarMap.hardCoreBlackFieldArea)
  if isShow == false then
    areaControl:SetShow(false)
    return
  end
  local sizeX = Panel_Radar:GetSizeX()
  local sizeY = Panel_Radar:GetSizeY()
  local radarPosX = Panel_Radar:GetPosX()
  local radarPosY = Panel_Radar:GetPosY()
  local areaSize = areaControl:GetSizeX()
  local areaHalfSize = areaSize * 0.5
  local floorAreaHalfSize = floor(areaHalfSize)
  posX = posX - floorAreaHalfSize
  posY = posY - floorAreaHalfSize
  areaControl:SetPosX(posX)
  areaControl:SetPosY(posY)
  areaControl:SetRectClip(float2(-posX, -posY), float2(radarPosX + sizeX - areaControl:GetParentPosX(), radarPosY + sizeY - areaControl:GetPosY()))
end
local RadarMap_DestoryQuestIcons = function()
  for idx, areaQuest in pairs(radarMap.areaQuests) do
    if nil ~= areaQuest then
      areaQuest.icon_QuestArea:SetShow(false)
      areaQuest.icon_QuestArrow:SetShow(false)
      radarMap:returnQuestToPool(areaQuest)
    end
  end
  radarMap.areaQuests = {}
  radarMap.updateQuestUIIndex = {}
end
function regeistTooltipInfo(index, isArrow)
  if nil == Panel_QuestInfo then
    return
  end
  if isArrow then
    registTooltipControl(radarMap.areaQuests[index].icon_QuestArrow, Panel_QuestInfo)
  else
    registTooltipControl(radarMap.areaQuests[index].icon_QuestArea, Panel_QuestInfo)
  end
end
function QuestTooltipForHandle(index, controlIdx, IsArrow)
  regeistTooltipInfo(controlIdx, IsArrow)
  if nil ~= QuestInfoData then
    QuestInfoData.questDescShowWindowForLeft(index)
  end
  if nil ~= FGlobal_QuestTooltip_MouseIconOff then
    FGlobal_QuestTooltip_MouseIconOff()
  end
end
function Radar_UpdateQuestList()
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
    return
  end
  if isSolareInstance == true then
    return
  end
  RadarMap_DestoryQuestIcons()
  local questCount = questList_getCheckedProgressQuestCount()
  local controlCount = 1
  local pixelRate = radarMap.worldDistanceToPixelRate * 0.02
  for index = 1, questCount do
    local progressQuest = questList_getCheckedProgressQuestAt(index - 1)
    if nil ~= progressQuest then
      local showQuest = true
      if ToClient_HardCoreChannelWithContensOption() == true and progressQuest:isHardCoreQuest() == false then
        showQuest = false
      end
      if showQuest == true then
        local questGroupId = progressQuest:getQuestNo()._group
        local questId = progressQuest:getQuestNo()._quest
        local questCondition = 0
        if true == progressQuest:isSatisfied() then
          questCondition = 0
        else
          questCondition = 1
        end
        local positionCount = progressQuest:getQuestPositionCount()
        if 0 ~= positionCount and not progressQuest:isSatisfied() then
          for posIndex = 1, positionCount do
            local questPosition = progressQuest:getQuestPositionAt(posIndex - 1)
            local areaQuest = radarMap:getIdleQuest()
            areaQuest.index = index - 1
            areaQuest.icon_QuestArea:addInputEvent("Mouse_On", "QuestTooltipForHandle(" .. index - 1 .. ", " .. controlCount .. ", false)")
            areaQuest.icon_QuestArea:addInputEvent("Mouse_Out", "QuestInfoData.questDescHideWindow()")
            areaQuest.icon_QuestArea:addInputEvent("Mouse_LUp", "HandleClicked_QuestWidget_FindTarget(" .. questGroupId .. ", " .. questId .. ", " .. questCondition .. ", false)")
            areaQuest.icon_QuestArea:addInputEvent("Mouse_RUp", "RadarMap_Background_MouseRUp()")
            areaQuest.icon_QuestArea:setTooltipEventRegistFunc("QuestTooltipForHandle(" .. index - 1 .. ", " .. controlCount .. ", false)")
            areaQuest.icon_QuestArrow:addInputEvent("Mouse_On", "QuestTooltipForHandle(" .. index - 1 .. ", " .. controlCount .. ", true)")
            areaQuest.icon_QuestArrow:addInputEvent("Mouse_Out", "QuestInfoData.questDescHideWindow()")
            areaQuest.icon_QuestArrow:addInputEvent("Mouse_LUp", "HandleClicked_QuestWidget_FindTarget(" .. questGroupId .. ", " .. questId .. ", " .. questCondition .. ", false)")
            areaQuest.icon_QuestArrow:addInputEvent("Mouse_RUp", "RadarMap_Background_MouseRUp()")
            areaQuest.icon_QuestArrow:setTooltipEventRegistFunc("QuestTooltipForHandle(" .. index - 1 .. ", " .. controlCount .. ", false)")
            areaQuest.x = questPosition._position.x
            areaQuest.y = questPosition._position.y
            areaQuest.z = questPosition._position.z
            areaQuest.radius = questPosition._radius
            local size = floor(pixelRate * areaQuest.radius) * 2
            areaQuest.icon_QuestArea:SetSize(size, size)
            areaQuest.icon_QuestArea:SetParentRotCalc(radarMap.isRotateMode)
            radarMap.areaQuests[controlCount] = areaQuest
            local questNoRaw = questId * 65536 + questGroupId
            local questUIIndex = radarMap.updateQuestUIIndex[questNoRaw]
            if nil == questUIIndex then
              radarMap.updateQuestUIIndex[questNoRaw] = {}
              radarMap.updateQuestUIIndex[questNoRaw][posIndex] = controlCount
            else
              radarMap.updateQuestUIIndex[questNoRaw][posIndex] = controlCount
            end
            controlCount = controlCount + 1
          end
        end
      end
    end
  end
  for idx, areaQuest in pairs(radarMap.areaQuests) do
    if nil ~= areaQuest then
      Panel_Radar:SetChildIndex(areaQuest.icon_QuestArrow, 9998)
    end
  end
  for actorKeyRaw, _ in pairs(radarMap.actorIcons) do
    RadarMap_DestoryOtherActor(actorKeyRaw)
  end
  RadarMap_UpdatePixelRate()
end
function Radar_UpdateQuestListAtKey(questNoRaw)
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
    return
  end
  if isSolareInstance == true then
    return
  end
  if questNoRaw == nil then
    Radar_UpdateQuestList()
    return
  end
  local pixelRate = radarMap.worldDistanceToPixelRate * 0.02
  local progressQuest = ToClient_getProgressingQuestAtKey(questNoRaw)
  if nil ~= progressQuest then
    local questGroupId = progressQuest:getQuestNo()._group
    local questId = progressQuest:getQuestNo()._quest
    local questCondition = 0
    if true == progressQuest:isSatisfied() then
      questCondition = 0
    else
      questCondition = 1
    end
    local positionCount = progressQuest:getQuestPositionCount()
    if 0 ~= positionCount then
      for posIndex = 1, positionCount do
        local questPosition = progressQuest:getQuestPositionAt(posIndex - 1)
        local progressQuestNo = questNoRaw
        local uiIndexTable = radarMap.updateQuestUIIndex[progressQuestNo]
        if nil == uiIndexTable then
          return
        end
        local controlIndex = uiIndexTable[posIndex]
        local areaQuest
        if uiIndexTable ~= nil then
          areaQuest = radarMap.areaQuests[controlIndex]
        end
        if questCondition == 0 and areaQuest ~= nil then
          areaQuest.icon_QuestArea:SetShow(false)
          areaQuest.icon_QuestArrow:SetShow(false)
          radarMap:returnQuestToPool(areaQuest)
          radarMap.areaQuests[controlIndex] = nil
        else
          areaQuest.x = questPosition._position.x
          areaQuest.y = questPosition._position.y
          areaQuest.z = questPosition._position.z
          areaQuest.radius = questPosition._radius
          local size = floor(pixelRate * areaQuest.radius) * 2
          areaQuest.icon_QuestArea:SetSize(size, size)
          areaQuest.icon_QuestArea:SetParentRotCalc(radarMap.isRotateMode)
        end
      end
    end
  end
  RadarMap_UpdatePixelRate()
end
function RadarMap_UpdatePixelRate()
  local pixelRate = radarMap.worldDistanceToPixelRate * 0.02
  for _, areaQuest in pairs(radarMap.areaQuests) do
    local size = floor(pixelRate * areaQuest.radius)
    areaQuest.icon_QuestArea:SetSize(size, size)
  end
  if isHardCoreChannel == true and radarMap.hardCoreBlackFieldArea.control:GetShow() == true then
    local blackFieldSize = floor(pixelRate * radarMap.hardCoreBlackFieldArea.radius) * 2
    radarMap.hardCoreBlackFieldArea.control:SetSize(blackFieldSize, blackFieldSize)
  end
end
function RadarMap_UpdateQuestAreaPositionPerFrame()
  if false == isShowOtherIcon then
    return
  end
  local enableHalfSize = 12
  local sizeX = Panel_Radar:GetSizeX()
  local sizeY = Panel_Radar:GetSizeY()
  local halfSizeX = sizeX * 0.5
  local halfSizeY = sizeY * 0.5
  local halfSizeXSq = halfSizeX * halfSizeX
  local camRot = getCameraRotation()
  local camRotAddedPI = camRot + PI
  local radarPosX = Panel_Radar:GetPosX()
  local radarPosY = Panel_Radar:GetPosY()
  local selfPlayerControlPos = radarMap.pcPosBaseControl
  local rotateMode = radarMap.isRotateMode
  local selfPcInfo = radarMap.pcInfo
  local selfPlayerPos = selfPcInfo.position
  local isSelfPlayerShow = ToClient_IsViewSelfPlayer(selfPlayerPos)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local centerPosX = radarPosX + halfSizeX - 5
  local centerPosY = radarPosY + halfSizeY + 15
  local distancex = mousePosX - centerPosX
  local distancey = mousePosY - centerPosY
  local distanceSq = distancex * distancex + distancey * distancey
  local areaQuestsContainer = radarMap.areaQuests
  for _, areaQuest in pairs(areaQuestsContainer) do
    local questAreaIcon = areaQuest.icon_QuestArea
    local questArrowIcon = areaQuest.icon_QuestArrow
    local isShow, posX, posY = getPosQuestControl(areaQuest)
    if isShow then
      local areaSize = questAreaIcon:GetSizeX()
      local areaHalfSize = areaSize * 0.5
      local distx = posX - selfPlayerControlPos.x
      local disty = posY - selfPlayerControlPos.y
      local tempPos = float2(distx, disty)
      if rotateMode then
        tempPos:rotate(camRotAddedPI)
      end
      local floorAreaHalfSize = floor(areaHalfSize)
      posX = posX - floorAreaHalfSize
      posY = posY - floorAreaHalfSize
      questAreaIcon:SetPosX(posX)
      questAreaIcon:SetPosY(posY)
      questAreaIcon:SetEnableArea(tempPos.x - distx, tempPos.y - disty, tempPos.x - distx + areaSize, tempPos.y - disty + areaSize)
      questAreaIcon:SetRectClip(float2(-posX, -posY), float2(radarPosX + sizeX - questAreaIcon:GetParentPosX(), radarPosY + sizeY - questAreaIcon:GetPosY()))
      questArrowIcon:SetShow(false)
    elseif radarMap.isShowRadarArrow == true and isSelfPlayerShow == true then
      questArrowIcon:SetPosX((sizeX - questArrowIcon:GetSizeX()) * 0.5)
      questArrowIcon:SetPosY((sizeY - questArrowIcon:GetSizeY()) * 0.5)
      local dx = selfPlayerPos.x - areaQuest.x
      local dy = selfPlayerPos.z - areaQuest.z
      local radian = atan2(dx, dy)
      local arrowIconRotate = radian
      local arrowCalcRotate = -radian
      if rotateMode then
        arrowIconRotate = radian - camRotAddedPI
        arrowCalcRotate = -radian - camRotAddedPI
      end
      questArrowIcon:SetRotate(arrowIconRotate)
      questAreaIcon:SetParentRotCalc(rotateMode)
      local tempPos = float2(0, QuestArrowHalfSize)
      tempPos:rotate(-arrowIconRotate)
      questArrowIcon:SetEnableArea(QuestArrowHalfSize + tempPos.x - enableHalfSize, QuestArrowHalfSize + tempPos.y - enableHalfSize, QuestArrowHalfSize + tempPos.x + enableHalfSize, QuestArrowHalfSize + tempPos.y + enableHalfSize)
      questArrowIcon:SetShow(true)
    else
      questArrowIcon:SetShow(false)
    end
    if halfSizeXSq > distanceSq then
      questAreaIcon:SetIgnore(false)
      if isQuestDescShow then
        Panel_QuestInfo:SetShow(true, true)
      end
    else
      questAreaIcon:SetIgnore(true)
    end
    questAreaIcon:SetShow(isShow)
  end
end
function RadarMap_DestoryOtherActor(actorKeyRaw)
  local actorIcon = radarMap.actorIcons[actorKeyRaw]
  if nil ~= actorIcon then
    actorIcon:SetShow(false)
    radarMap:returnIconToPool(actorIcon)
    radarMap.actorIcons[actorKeyRaw] = nil
  end
end
function Radar_ChangeTexture_On()
  RadarText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_RADER_RADER") .. "-" .. PAGetString(Defines.StringSheet_GAME, "PANEL_RADER_MOVE_DRAG"))
end
function Radar_ChangeTexture_Off()
  RadarText:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_RADER_RADER"))
end
function Panel_Radar_ShowToggle()
  local isShow = Panel_Radar:IsShow()
  if isShow then
    Panel_Radar:SetShow(false)
    RadarBackground_Hide()
  else
    Panel_Radar:SetShow(true)
    RadarBackground_Show()
  end
end
function RadarMap_UpdateTerrainInfo()
  local terraintype = selfPlayerNaviMaterial()
  if terraintype == radarTime._terrainType and terraintype ~= 6 and terraintype ~= 9 then
    return
  end
  radarTime._terrainType = terraintype
  local radarControl = radarTime.controls.terrainInfo
  radarControl:ChangeTextureInfoNameAsync(terrainUV._texture)
  local x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[terraintype][1], terrainUV[terraintype][2], terrainUV[terraintype][3], terrainUV[terraintype][4])
  textInfo = terrainUV[terraintype][5]
  if terraintype == 6 then
    local speed = ToClient_GetCurrentOceanW()
    if speed >= 1.7 then
      radarControl:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Main_00.dds")
      x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[11][1], terrainUV[11][2], terrainUV[11][3], terrainUV[11][4])
      textInfo = terrainUV[11][5]
    elseif speed >= 1.25 then
      radarControl:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Main_00.dds")
      x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[10][1], terrainUV[10][2], terrainUV[10][3], terrainUV[10][4])
      textInfo = terrainUV[10][5]
    end
  end
  if terraintype > 9 then
    local isOcean = ToClient_getCurrentRegionIsOcean()
    if isOcean then
      x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[6][1], terrainUV[6][2], terrainUV[6][3], terrainUV[6][4])
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_OCEAN")
    else
      x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[0][1], terrainUV[0][2], terrainUV[0][3], terrainUV[0][4])
      textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
    end
    if true == _ContentsGroup_RemasterUI_Radar then
      if isOcean then
        x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[10][1], terrainUV[10][2], terrainUV[10][3], terrainUV[10][4])
        textInfo = terrainUV[10][5]
      else
        x1, y1, x2, y2 = setTextureUV_Func(radarControl, terrainUV[0][1], terrainUV[0][2], terrainUV[0][3], terrainUV[0][4])
        textInfo = PAGetString(Defines.StringSheet_GAME, "LUA_RADAR_TERRAININFO_NORMAL")
      end
    end
  end
  local baseTexture = radarControl:getBaseTexture()
  baseTexture:setUV(x1, y1, x2, y2)
  radarControl:setRenderTexture(baseTexture)
end
function RadarMap_UpdatePosition()
  if false == Panel_TimeBar:GetShow() or true == _timeBarIsHiding then
    return
  end
  local radarTimeControl = radarTime.controls
  local gapX = 15
  local regionNameSpanY = 0
  local posX = radarTimeControl.gameTime:GetTextSizeX() + gapX
  radarTimeControl.channelName:SetSpanSize(posX - 3, regionNameSpanY)
  posX = posX + radarTimeControl.channelName:GetTextSizeX()
  radarTimeControl.serverName:SetSpanSize(posX, regionNameSpanY)
  radarTimeControl.terrainInfo:ComputePos()
  posX = radarTimeControl.terrainInfo:GetSizeX() + 5
  local iconSize = 20
  radarTimeControl.raining:SetSpanSize(posX, regionNameSpanY + 1)
  posX = posX + iconSize
  radarTimeControl.VillageWar:SetSpanSize(posX, regionNameSpanY + 1)
  posX = posX + iconSize
  radarTimeControl.citadel:SetSpanSize(posX, regionNameSpanY + 1)
  posX = posX + iconSize
  radarTimeControl.siegeArea:SetSpanSize(posX, regionNameSpanY + 1)
  radarTimeControl.gameTime:ComputePos()
  radarTimeControl.channelName:ComputePos()
  radarTimeControl.serverName:ComputePos()
  radarTimeControl.terrainInfo:ComputePos()
  radarTimeControl.raining:ComputePos()
  radarTimeControl.citadel:ComputePos()
  radarTimeControl.siegeArea:SetPosX(radarTimeControl.citadel:GetPosX())
  radarTimeControl.VillageWar:ComputePos()
  radarTimeControl.commandCenter:ComputePos()
  radar_regionName:ComputePos()
  radar_regionSubName:ComputePos()
  radar_regionNodeName:ComputePos()
  Panel_Radar:ComputePos()
end
function PaGlobalFunc_Radar_All_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
    local isMasters = true == isGuildSubMaster or true == isGuildMaster
    if __eGuildRightType_Tent == eRightType then
      return isMasters
    end
    return false
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
local _isSiegeArea = false
local buildingType = ""
function RadarMap_UpdateIcon()
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
  end
  if false == Panel_TimeBar:GetShow() or true == _timeBarIsHiding then
    return
  end
  local radarTimeControl = radarTime.controls
  radarTimeControl.raining:ChangeTextureInfoNameAsync(weatherUV._texture)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if 0 < getWeatherInfoBySelfPos(CppEnums.WEATHER_SYSTEM_FACTOR_TYPE.eWSFT_RAIN_AMOUNT) then
    if 0 > getWeatherInfoBySelfPos(CppEnums.WEATHER_SYSTEM_FACTOR_TYPE.eWSFT_CELSIUS) then
      weatherTooltip = 2
    else
      weatherTooltip = 0
    end
  else
    weatherTooltip = 1
  end
  x1, y1, x2, y2 = setTextureUV_Func(radarTimeControl.raining, weatherUV[weatherTooltip][1], weatherUV[weatherTooltip][2], weatherUV[weatherTooltip][3], weatherUV[weatherTooltip][4])
  radarTimeControl.raining:getBaseTexture():setUV(x1, y1, x2, y2)
  radarTimeControl.raining:setRenderTexture(radarTimeControl.raining:getBaseTexture())
  radarTimeControl.raining:SetShow(true)
  radarTimeControl.VillageWar:SetShow(true)
  radarTimeControl.citadel:SetShow(false)
  local function CheckSiegeArea(installType)
    local isRightSiegeTent = false
    if _ContentsGroup_GuildAuthoritySeparation == true then
      isRightSiegeTent = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Tent)
    else
      isRightSiegeTent = PaGlobalFunc_Radar_All_RightCheck(__eGuildRightType_Tent)
    end
    local isCurrentSiegeCanInstall = selfPlayerCurrentSiegeCanInstall()
    if UI_RT.eRegionType_Fortress == installType and isCurrentSiegeCanInstall == true then
      if ToClient_GetMinorSiegeMode() == __eMinorSiegeModeOccupy or ToClient_getSiegeTerritoryType() == __eSiegeTerritoryType_Ocean then
        radarTimeControl.siegeArea:SetShow(false)
        return
      end
      buildingType = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_BULDINGTYPE_FORTRESS")
      siegeTooltip = 0
      if _isSiegeArea == false then
        _isSiegeArea = true
        if isRightSiegeTent == true then
          local mainStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_BULDIN_POSSIBLE", "buildingType", buildingType)
          ToClient_RequestNakMessageRenewelWithString(__eNakMessage_InSiegeArea, mainStr)
        end
      end
    elseif UI_RT.eRegionType_Siege == installType and isCurrentSiegeCanInstall == true then
      buildingType = PAGetString(Defines.StringSheet_GAME, "LUA_RADER_BULDINGTYPE_SIEGE")
      siegeTooltip = 1
      if _isSiegeArea == false then
        _isSiegeArea = true
        if isRightSiegeTent == true then
          local mainStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_BULDIN_POSSIBLE", "buildingType", buildingType)
          ToClient_RequestNakMessageRenewelWithString(__eNakMessage_InSiegeArea, mainStr)
        end
      end
    elseif buildingType ~= nil then
      siegeTooltip = 2
      if _isSiegeArea == true then
        _isSiegeArea = false
        if isRightSiegeTent == true then
          local mainStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RADER_BULDIN_IMPOSSIBLE", "buildingType", buildingType)
          ToClient_RequestNakMessageRenewelWithString(__eNakMessage_OutSiegeArea, mainStr)
        end
      end
    end
    local radarTimeControl = radarTime.controls
    radarTimeControl.siegeArea:ChangeTextureInfoNameAsync(siegeAreaUV._texture)
    x1, y1, x2, y2 = setTextureUV_Func(radarTimeControl.siegeArea, siegeAreaUV[siegeTooltip][1], siegeAreaUV[siegeTooltip][2], siegeAreaUV[siegeTooltip][3], siegeAreaUV[siegeTooltip][4])
    radarTimeControl.siegeArea:getBaseTexture():setUV(x1, y1, x2, y2)
    radarTimeControl.siegeArea:setRenderTexture(radarTimeControl.siegeArea:getBaseTexture())
    radarTimeControl.siegeArea:SetShow(true)
  end
  radarTimeControl.commandCenter:SetShow(false)
  CheckSiegeArea(radarMap.regionTypeValue)
  if false == _ContentsGroup_RemasterUI_Radar then
    Panel_TimeBar:SetSize(295, 22)
    Panel_TimeBar:ComputePos()
  end
end
RadarMap_UpdateIcon()
RadarMap_UpdatePosition()
local function RadarMap_MouseOnOffAnimation(deltaTime)
  if true == _ContentsGroup_UsePadSnapping then
    return
  end
  if false == isShowOtherIcon then
    return
  end
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode == getInputMode() or CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode == getInputMode()
  local IsMouseOver = mousePosX > Panel_Radar:GetPosX() - 20 and mousePosX < Panel_Radar:GetPosX() + Panel_Radar:GetSizeX() + 20 and mousePosY > Panel_Radar:GetPosY() - 20 and mousePosY < Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 20
  if IsMouseOver and isUiMode then
    simpleUIAlpha = 1
  else
    simpleUIAlpha = 0
  end
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.timeNum, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Plus, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Minus, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Reset, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_AlphaScrl, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_AlphaBtn, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_MiniMapScl, 5 * deltaTime)
  if false == _ContentsGroup_RemasterUI_Radar then
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_AlphaPlus, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_AlphaMinus, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_SizeSlider, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_SizeBtn, 5 * deltaTime)
  end
  if _ContentsGroup_3DMiniMapOpen then
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_SequenceAni, 5 * deltaTime)
  end
end
local iconPartyMemberArrow = {}
local function partyMemberArrowIcon(index, isShow)
  if nil == iconPartyMemberArrow[index] then
    if false == isShow then
      return
    end
    iconPartyMemberArrow[index] = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_PartyMemberArrow_" .. index)
    CopyBaseProperty(radarMap.template.area_quest_guideArrow, iconPartyMemberArrow[index])
    iconPartyMemberArrow[index]:SetColor(Defines.Color.C_FF00C0D7)
    iconPartyMemberArrow[index]:SetEnable(true)
    iconPartyMemberArrow[index]:SetIgnore(true)
    Panel_Radar:SetChildIndex(iconPartyMemberArrow[index], 9999)
    iconPartyMemberArrow[index]:SetParentRotCalc(radarMap.isRotateMode)
  end
  iconPartyMemberArrow[index]:SetShow(isShow)
  if true == isShow then
    iconPartyMemberArrow[index]:SetPosX(radarMap.pcPosBaseControl.x - iconPartyMemberArrow[index]:GetSizeX() / 2)
    iconPartyMemberArrow[index]:SetPosY(radarMap.pcPosBaseControl.y - iconPartyMemberArrow[index]:GetSizeY() / 2)
    iconPartyMemberArrow[index]:SetSize(radarMap.template.area_quest_guideArrow:GetSizeX(), radarMap.template.area_quest_guideArrow:GetSizeY())
    local memberData = RequestParty_getPartyMemberAt(index)
    local dx = radarMap.pcInfo.position.x - memberData:getPositionX()
    local dy = radarMap.pcInfo.position.z - memberData:getPositionZ()
    local radian = atan2(dx, dy)
    iconPartyMemberArrow[index]:SetRotate(radian)
    iconPartyMemberArrow[index]:SetParentRotCalc(radarMap.isRotateMode)
    Panel_Radar:SetChildIndex(iconPartyMemberArrow[index], 9999)
  end
end
function partyMemberIconPerFrame()
  local partyIsShow = false
  local partyMemberCount = 0
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    partyIsShow = PaGlobalFunc_Widget_Party_All_GetShow()
    partyMemberCount = PaGlobalFunc_Widget_Party_All_GetMemberCount()
  elseif true == _ContentsGroup_RenewUI then
    partyIsShow = Panel_Party:GetShow()
    partyMemberCount = FGlobal_PartyMemberCount()
  else
    partyIsShow = PaGlobalFunc_PartyWidget_GetShow()
    partyMemberCount = FGlobal_PartyMemberCount()
  end
  if true == _ContentsGroup_Solare and true == isSolareInstance then
    partyIsShow = true
  end
  for i = 0, 4 do
    partyMemberArrowIcon(i, false)
  end
  if partyMemberCount <= 0 or false == partyIsShow then
    return
  end
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil ~= memberData then
      local isNearPartyMember = getPlayerActor(memberData:getActorKey())
      if nil == isNearPartyMember then
        partyMemberArrowIcon(index, true)
      else
        partyMemberArrowIcon(index, false)
      end
    else
      partyMemberArrowIcon(index, false)
    end
  end
end
local getPosBaseControl2 = function(actorPosition)
  local selfPlayerPos = radarMap.pcInfo.position
  local selfPlayerControlPos = radarMap.pcPosBaseControl
  local dx = (actorPosition.x - selfPlayerPos.x) * 0.01
  local dz = (selfPlayerPos.z - actorPosition.z) * 0.01
  local distanceSq = (dx * dx + dz * dz) * 2
  local dxPerPixel = dx * radarMap.worldDistanceToPixelRate * 2 + selfPlayerControlPos.x
  local dyPerPixel = dz * radarMap.worldDistanceToPixelRate * 2 + selfPlayerControlPos.y
  local radius = radarMap.config.mapRadius
  local radiusSq = radius * radius
  return distanceSq < radiusSq, dxPerPixel, dyPerPixel
end
function RadarMap_UpdateSelfPlayerNavigationGuide()
  if false == isShowOtherIcon then
    RadarMap_HideIconWithOutPlayerIcon()
    return
  end
  ToClient_RadarMapUpdateSelfPlayerNavigationGuide(isShowOtherIcon)
  do return end
  local color = float4(1, 0.8, 0.6, 1)
  local colorBG = float4(0.6, 0.2, 0.2, 0.3)
  local radarBackground = radarMap.controls.radar_Background
  ToClient_clearShowAALineList()
  local pathSize = ToClient_getRenderPathSize()
  local getRenderPathByIndexFunc = ToClient_getRenderPathByIndex
  local unRenderCount = 0
  for ii = 0, pathSize - 1 do
    local pathPosition = getRenderPathByIndexFunc(ii)
    local isShow, posX, posY = getPosBaseControl2(pathPosition)
    ToClient_addShowAALineList(float3(posX, posY, 0))
    if not isShow then
      unRenderCount = unRenderCount + 1
      if unRenderCount >= 5 then
        break
      end
    else
      unRenderCount = 0
    end
  end
  ToClient_setColorShowAALineList(color)
  ToClient_setBGColorShowAALineList(colorBG)
end
local chattingAlertTimeCheck = 60
local strongMonsterCheckDistance = 3500
function RadarMap_HideIconWithOutPlayerIcon()
  for Key, value in pairs(typeDepth) do
    local RadarIconActorList = FromClient_getRadarIconActorList(Key)
    local RadarIconList = FromClient_getRadarIconList(Key)
    for key2, actor in pairs(RadarIconActorList) do
      if false == actor:isPlayer() and nil ~= RadarIconList[key2] then
        RadarIconList[key2]:SetShow(false)
      end
    end
  end
end
function RadarMap_UpdatePerFrame(deltaTime)
  RadarMap_UpdateSelfPlayerPerFrame()
  RadarMap_UpdateSelfPlayerNavigationGuide()
  if ToClient_IsAnySiegeBeingOfMyChannel() == false or ToClient_getSiegeParticipant() == false then
    RadarMap_UpdateQuestAreaPositionPerFrame()
  end
  RadarMap_UpdateTerrainInfo()
  if _ContentsGroup_UsePadSnapping == false then
    RadarMap_MouseOnOffAnimation(deltaTime)
  end
  local SPI = radarMap.controls.icon_SelfPlayer
  local halfSelfSizeX = SPI:GetSizeX() / 2
  local halfSelfSizeY = SPI:GetSizeY() / 2
  local halfSizeX = Panel_Radar:GetSizeX() / 2
  local halfSizeY = Panel_Radar:GetSizeY() / 2
  SPI:SetPosX(halfSizeX - halfSelfSizeX)
  SPI:SetPosY(halfSizeY - halfSelfSizeY)
  radarMap.pcPosBaseControl.x = SPI:GetPosX() + halfSelfSizeX
  radarMap.pcPosBaseControl.y = SPI:GetPosY() + halfSelfSizeY
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  ToClient_SetRadarCenterPos(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  FGlobal_UpdateRadarPin()
  RadarBackground_updatePerFrame(radarMap.pcInfo.position, deltaTime)
  partyMemberIconPerFrame()
  local playerLevel = ToClient_getSelfPlayerLevel()
  if not ToClient_GetMessageFilter(10) and playerLevel >= 10 then
    StrongMonsterByNear(deltaTime)
    if FromClient_DetectsOfStrongMonster(strongMonsterCheckDistance) then
      chattingAlertTimeCheck = chattingAlertTimeCheck + deltaTime
      if chattingAlertTimeCheck > 60 then
        chattingAlertTimeCheck = 0
        chatting_sendMessage("", PAGetString(Defines.StringSheet_GAME, "LUA_RADER_NEARMONSTER_CHATALERT"), CppEnums.ChatType.System)
      end
    end
  else
    radar_DangerAletText:SetShow(false)
    radar_DangetAlertBg:SetShow(false)
  end
  if ToClient_CheckFamilyCharacterLevel(10) == false then
    radar_ChangeBtn:SetShow(false)
    radar_SequenceAni:SetShow(false)
  elseif true == isShowOtherIcon then
    radar_ChangeBtn:SetShow(_ContentsGroup_3DMiniMapOpen)
    radar_SequenceAni:SetShow(_ContentsGroup_3DMiniMapOpen)
  end
  if ToClient_IsParticipateInRoseWar() == true then
    radar_DangerOutOfRoseWarZone:SetShow(ToClient_IsInRoseWarZone() == false)
  else
    radar_DangerOutOfRoseWarZone:SetShow(false)
  end
  RadarMap_UpdateHardCoreBlackField()
end
function TimeBar_UpdatePerFrame(deltaTime)
  RadarMap_UpdateTimePerFrame()
  RadarMap_UpdatePosition()
  RadarMap_UpdateIcon()
end
local textAniTime = 0
local isAnimation = false
function StrongMonsterByNear(deltaTime)
  textAniTime = textAniTime + deltaTime
  if FromClient_DetectsOfStrongMonster(strongMonsterCheckDistance) then
    if textAniTime < 2 and false == isAnimation and not currentSafeZone then
      radar_DangerAletText:SetShow(true)
      local aniInfo = UIAni.AlphaAnimation(1, radar_DangerAletText, 0, 0.4)
      isAnimation = true
    elseif textAniTime > 2 and textAniTime < 5 and isAnimation then
      local aniInfo = UIAni.AlphaAnimation(0, radar_DangerAletText, 0, 0.4)
      aniInfo:SetHideAtEnd(true)
      isAnimation = false
    elseif textAniTime > 5 then
      textAniTime = 0
    end
    if not radar_DangetAlertBg:GetShow() and not currentSafeZone then
      radar_DangetAlertBg:SetShow(true)
    end
  else
    radar_DangerAletText:SetShow(false)
    radar_DangetAlertBg:SetShow(false)
  end
end
function RadarMap_SimpleUIUpdatePerFrame(deltaTime)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode == getInputMode() or CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode == getInputMode()
  local IsMouseOver = mousePosX > Panel_Radar:GetPosX() - 20 and mousePosX < Panel_Radar:GetPosX() + Panel_Radar:GetSizeX() + 20 and mousePosY > Panel_Radar:GetPosY() - 20 and mousePosY < Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 20
  isUiMode = isUiMode and IsMouseOver
  if IsMouseOver then
    simpleUIAlpha = 1
  end
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.timeNum, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Plus, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Minus, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_Reset, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_AlphaScrl, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_AlphaBtn, 5 * deltaTime)
  UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_MiniMapScl, 5 * deltaTime)
  if false == _ContentsGroup_RemasterUI_Radar then
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_AlphaPlus, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radarMap.controls.radar_AlphaMinus, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_SizeSlider, 5 * deltaTime)
    UIAni.perFrameAlphaAnimation(simpleUIAlpha, radar_SizeBtn, 5 * deltaTime)
  end
end
registerEvent("SimpleUI_UpdatePerFrame", "RadarMap_SimpleUIUpdatePerFrame")
registerEvent("FromClient_setSiegeAttackAreaPosition", "FromClient_setSiegeAttackAreaPosition")
function RadarMap_GetDistanceToPixelRate()
  return radarMap.worldDistanceToPixelRate
end
function RadarMap_GetSelfPosInRadar()
  return radarMap.pcPosBaseControl
end
function RadarMap_GetScaleRateWidth()
  return radarMap.scaleRateWidth
end
function RadarMap_GetScaleRateHeight()
  return radarMap.scaleRateHeight
end
function HandleClicked_RadarResize()
  ToClient_SaveUiInfo(false)
end
function RadarMap_InitPanel()
  ToClient_setRadarType(false)
  ToClient_setRadorUIPanel(Panel_Radar)
  ToClient_setRadorUISelfIcon(radarMap.controls.icon_SelfPlayer)
  ToClient_setRadorUIViewDistanceRate(7225)
  ToClient_setRadorUIMapRadius(radarMap.config.mapRadius)
  ToCleint_InitializeRadarActorPool(1000)
  radar_Background:SetSize(Panel_Radar:GetSizeX(), Panel_Radar:GetSizeY())
  RadarMap_HidePanelConditionCheck()
  ToClient_InsertRoseWarObserverModePanel(Panel_Radar)
end
function RadarMap_HidePanelConditionCheck()
  if nil == Panel_Radar or nil == Panel_TimeBar then
    _PA_ASSERT_NAME(false, "Panel_Radar \235\152\144\235\138\148 Panel_TimeBar\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_PersonalAtoraxion),
    ToClient_RestrictContentsByRegion(__eRestrictContentsType_MiniMap)
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_Radar:SetRenderAndEventHide(true)
    Panel_TimeBar:SetRenderAndEventHide(true)
  else
    Panel_Radar:SetRenderAndEventHide(false)
    Panel_TimeBar:SetRenderAndEventHide(false)
  end
end
checkLoad()
controlInit()
Radar_UpdateQuestList()
RadarMap_InitPanel()
registerEvent("selfPlayer_regionChanged", "RadarMap_updateRegion")
registerEvent("EventActorDelete", "RadarMap_DestoryOtherActor")
registerEvent("EventQuestListChanged", "Radar_UpdateQuestList")
registerEvent("updateProgressQuestList", "Radar_UpdateQuestList")
Panel_Radar:addInputEvent("Mouse_On", "Radar_ChangeTexture_On()")
Panel_Radar:addInputEvent("Mouse_Out", "Radar_ChangeTexture_Off()")
Panel_Radar:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
function RadarMap_EnableSimpleUI_Force_Over()
  RadarMap_EnableSimpleUI(true)
end
function RadarMap_EnableSimpleUI_Force_Out()
  RadarMap_EnableSimpleUI(false)
end
registerEvent("EventSimpleUIEnable", "RadarMap_EnableSimpleUI_Force_Over")
registerEvent("EventSimpleUIDisable", "RadarMap_EnableSimpleUI_Force_Out")
function RadarMap_EnableSimpleUI(isEnable)
  cacheSimpleUI_ShowButton = true
end
if getEnableSimpleUI() then
end
function RadarMap_SetDragMode(isSet)
  isDrag = isSet
end
function resetRadarActorListRotateValue()
  local actorList
  for Key, value in pairs(typeDepth) do
    actorList = FromClient_getRadarIconList(Key)
    for key, control in pairs(actorList) do
      control:SetRotate(0)
    end
  end
end
function FGlobal_Radar_SetColorBlindMode()
  if true == isShowOtherIcon then
    return
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local colorBlindList
  if 0 == isColorBlindMode then
    colorBlindList = colorBlindNone
  elseif 1 == isColorBlindMode then
    colorBlindList = colorBlindRed
  elseif 2 == isColorBlindMode then
    colorBlindList = colorBlindGreen
  else
    return
  end
  for key, value in pairs(colorBlindList) do
    local ActorIconList = FromClient_getRadarIconList(key)
    for key2, control in pairs(ActorIconList) do
      local isChase = false
      if true == _ContentsGroup_ChaseMonster and (radarType.radarType_allymonster == key or radarType.radarType_normalMonster == key or radarType.radarType_namedMonster == key or radarType.radarType_bossMonster == key or radarType.radarType_huntingMonster == key) then
        local ActorList = FromClient_getRadarIconActorList(key)
        local actorProxy = ActorList[key2]
        if nil ~= actorProxy and true == actorProxy:isMonster() then
          local actorProxyWrapper = getActor(actorProxy:getActorKeyRaw())
          if nil ~= actorProxyWrapper and true == ToClient_isChaseMonster(actorProxyWrapper:getCharacterKeyRaw()) then
            isChase = true
          end
        end
      end
      if true == isChase then
        control:SetColor(chaseColor)
      else
        control:SetColor(value)
      end
    end
  end
end
function Fromclient_RadarChangePlayerIconColor()
  for Key, value in pairs(typeDepth) do
    local defaultColor = 0
    if Key == radarType.radarType_normalPlayer then
      defaultColor = 4294967295
    elseif Key == radarType.radarType_partyMember then
      defaultColor = 4280867697
    elseif Key == radarType.radarType_guildMember then
      defaultColor = 4278236415
    end
    local RadarIconActorList = FromClient_getRadarIconActorList(Key)
    local RadarIconList = FromClient_getRadarIconList(Key)
    for key2, actor in pairs(RadarIconActorList) do
      if defaultColor ~= 0 and RadarIconList[key2] ~= nil then
        RadarIconList[key2]:SetColor(defaultColor)
      end
      if actor:isPlayer() == true then
        SetRadarUIColorByGuildColor(actor:getActorKeyRaw(), RadarIconList[key2])
      end
      if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start and actor:isPlayer() == true and actor:isParticipateInRoseWar() == true then
        SetRadarUIColorByRoseWarColor(actor:getActorKeyRaw(), RadarIconList[key2])
      end
      if actor:isNeedHideNameForEdaniaInstanceField() == true then
        RadarIconList[key2]:SetColor(defaultColor)
      end
    end
  end
  RadarMap_HideIconWithOutPlayerIcon()
end
function FGlobal_Radar_UpdateActorIconColor()
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local colorBlindList
  if 0 == isColorBlindMode then
    colorBlindList = colorBlindNone
  elseif 1 == isColorBlindMode then
    colorBlindList = colorBlindRed
  elseif 2 == isColorBlindMode then
    colorBlindList = colorBlindGreen
  else
    return
  end
  for key, value in pairs(colorBlindList) do
    local ActorIconList = FromClient_getRadarIconList(key)
    for key2, control in pairs(ActorIconList) do
      local isChase = false
      if true == _ContentsGroup_ChaseMonster and (radarType.radarType_allymonster == key or radarType.radarType_normalMonster == key or radarType.radarType_namedMonster == key or radarType.radarType_bossMonster == key or radarType.radarType_huntingMonster == key) then
        local ActorList = FromClient_getRadarIconActorList(key)
        local actorProxy = ActorList[key2]
        if nil ~= actorProxy and true == actorProxy:isMonster() then
          local actorProxyWrapper = getActor(actorProxy:getActorKeyRaw())
          if nil ~= actorProxyWrapper and true == ToClient_isChaseMonster(actorProxyWrapper:getCharacterKeyRaw()) then
            isChase = true
          end
        end
      end
      if true == isChase then
        control:SetColor(chaseColor)
      else
        control:SetColor(value)
      end
    end
  end
  if true == isContentsOpenLocalWar then
    local selfPlayerLocalWarTeam = ToClient_GetMyTeamNoRedBattleField()
    if 0 ~= selfPlayerLocalWarTeam then
      local localWarBlindTypeList = {
        radarType.radarType_partyMember,
        radarType.radarType_guildMember,
        radarType.radarType_normalPlayer
      }
      for _, key in pairs(localWarBlindTypeList) do
        local ActorIconList = FromClient_getRadarIconList(key)
        for key2, control in pairs(ActorIconList) do
          local ActorList = FromClient_getRadarIconActorList(key)
          local actorProxy = ActorList[key2]
          if nil ~= actorProxy and true == actorProxy:isPlayer() then
            local teamNo = ToClient_GetTeamNoRedBattleFieldByActorProxyRaw(actorProxy:getActorKeyRaw())
            if 0 ~= teamNo and teamNo ~= selfPlayerLocalWarTeam then
              if 0 == isColorBlindMode then
                control:SetColor(4294930775)
              else
                control:SetColor(4286432511)
              end
            end
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    local solareMyTeamNo = ToClient_GetSolareMyTeamType()
    if -1 ~= solareMyTeamNo then
      local localWarBlindTypeList = {
        radarType.radarType_partyMember,
        radarType.radarType_guildMember,
        radarType.radarType_normalPlayer
      }
      for _, key in pairs(localWarBlindTypeList) do
        local ActorIconList = FromClient_getRadarIconList(key)
        for key2, control in pairs(ActorIconList) do
          local ActorList = FromClient_getRadarIconActorList(key)
          local actorProxy = ActorList[key2]
          if nil ~= actorProxy and true == actorProxy:isPlayer() then
            local playerActorProxyWrapper = getPlayerActor(actorProxy:getActorKeyRaw())
            if nil == playerActorProxyWrapper then
              return
            end
            local teamNo = playerActorProxyWrapper:getInstanceTeamNo()
            if -1 ~= teamNo and teamNo ~= solareMyTeamNo then
              if 0 == isColorBlindMode then
                control:SetColor(4294930775)
              else
                control:SetColor(4286432511)
              end
            end
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_MiniGame) then
    local miniGameMyTeamNo = -1
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    miniGameMyTeamNo = selfPlayer:getInstanceTeamNo()
    if -1 ~= miniGameMyTeamNo then
      local localWarBlindTypeList = {
        radarType.radarType_partyMember,
        radarType.radarType_guildMember,
        radarType.radarType_normalPlayer
      }
      for _, key in pairs(localWarBlindTypeList) do
        local ActorIconList = FromClient_getRadarIconList(key)
        for key2, control in pairs(ActorIconList) do
          local ActorList = FromClient_getRadarIconActorList(key)
          local actorProxy = ActorList[key2]
          if nil ~= actorProxy and true == actorProxy:isPlayer() then
            local playerActorProxyWrapper = getPlayerActor(actorProxy:getActorKeyRaw())
            if nil == playerActorProxyWrapper then
              return
            end
            local teamNo = playerActorProxyWrapper:getInstanceTeamNo()
            if -1 ~= teamNo and teamNo ~= miniGameMyTeamNo then
              if 0 == isColorBlindMode then
                control:SetColor(4294930775)
              else
                control:SetColor(4286432511)
              end
            end
          end
        end
      end
    end
  end
  if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if selfPlayer:isParticipateInRoseWar() == true then
      local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
      if myRoseWarTeamNo == __eRoseWarTeam_Kamasylvia or myRoseWarTeamNo == __eRoseWarTeam_Odyllita then
        local localWarBlindTypeList = {
          radarType.radarType_normalPlayer,
          radarType.radarType_normalMonster,
          radarType.radarType_namedMonster,
          radarType.radarType_bossMonster
        }
        for _, key in pairs(localWarBlindTypeList) do
          local ActorIconList = FromClient_getRadarIconList(key)
          for key2, control in pairs(ActorIconList) do
            local ActorList = FromClient_getRadarIconActorList(key)
            local actorProxy = ActorList[key2]
            if actorProxy ~= nil then
              local playerActorProxyWrapper = getPlayerActor(actorProxy:getActorKeyRaw())
              if playerActorProxyWrapper ~= nil and playerActorProxyWrapper:isParticipateInRoseWar() == true then
                local teamNo = playerActorProxyWrapper:getRoseWarTeamNo()
                if myRoseWarTeamNo == teamNo then
                  control:SetColor(4289457919)
                else
                  control:SetColor(4294945707)
                end
              end
              if actorProxy:isMonster() == true then
                local actorProxyWrapper = getActor(actorProxy:getActorKeyRaw())
                if actorProxyWrapper ~= nil and actorProxyWrapper:isParticipateInRoseWar() == true then
                  local teamNo = actorProxyWrapper:getRoseWarTeamNo()
                  if myRoseWarTeamNo == teamNo then
                    control:SetColor(4289457919)
                  else
                    control:SetColor(4294945707)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function FromClient_RadarUICreated(actorKeyRaw, control, actorProxyWrapper, radarTypeValue, isSelfPlayerCloneIcon)
  control:SetSize(10, 10)
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) and radarType.radarType_LocalWarOccupation == radarTypeValue and nil ~= PaGlobalFunc_LocalWarOccupation_AddRadarControl then
    PaGlobalFunc_LocalWarOccupation_AddRadarControl(actorKeyRaw, control)
  end
  if ToClient_namelessPVPServer() == true and actorProxyWrapper ~= nil and (actorProxyWrapper:get():isPlayer() == true or actorProxyWrapper:get():isSubPlayer() == true) and actorProxyWrapper:IsNeedHideNameForPVPServer() == true then
    radarTypeValue = radarType.radarType_normalPlayer
  end
  local base = template[radarTypeValue]
  local isColorBlindType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local color
  if true == isContentsOpenLocalWar then
    local selfPlayerLocalWarTeam = ToClient_GetMyTeamNoRedBattleField()
    if 0 ~= selfPlayerLocalWarTeam and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local teamNo = 0
      local subPlayerActorType = 0
      local tempActorWrapper = getActor(actorKeyRaw)
      if tempActorWrapper ~= nil then
        subPlayerActorType = tempActorWrapper:get():getSubActorType()
      end
      if subPlayerActorType == __eSubPlayerActorType_Clone then
        teamNo = ToClient_GetTeamNoRedBattleFieldByActorProxyRaw(tempActorWrapper:get():getOwnerActorKeyRaw())
        if teamNo == selfPlayerLocalWarTeam then
          teamNo = 0
        end
      else
        teamNo = ToClient_GetTeamNoRedBattleFieldByActorProxyRaw(actorKeyRaw)
      end
      if teamNo ~= 0 then
        base = template[radarType.radarType_normalPlayer]
        if teamNo ~= selfPlayerLocalWarTeam then
          if 0 == isColorBlindType then
            color = 4294930775
          else
            color = 4286432511
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    local solareMyTeamNo = ToClient_GetSolareMyTeamType()
    if -1 ~= solareMyTeamNo and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local teamNo = -1
      local subPlayerActorType = 0
      local tempActorWrapper = getActor(actorKeyRaw)
      if tempActorWrapper ~= nil then
        subPlayerActorType = tempActorWrapper:get():getSubActorType()
        if subPlayerActorType == __eSubPlayerActorType_Clone then
          local ownerActorKey = tempActorWrapper:get():getOwnerActorKeyRaw()
          local ownerActorWrapper = getPlayerActor(ownerActorKey)
          if ownerActorWrapper ~= nil then
            teamNo = ownerActorWrapper:getInstanceTeamNo()
          end
        else
          local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
          if playerActorProxyWrapper ~= nil then
            teamNo = playerActorProxyWrapper:getInstanceTeamNo()
          end
        end
      end
      if -1 ~= teamNo then
        base = template[radarType.radarType_normalPlayer]
        if teamNo ~= solareMyTeamNo then
          if 0 == isColorBlindType then
            color = 4294930775
          else
            color = 4286432511
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_MiniGame) then
    local miniGameMyTeamNo = -1
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    miniGameMyTeamNo = selfPlayer:getInstanceTeamNo()
    if -1 ~= miniGameMyTeamNo and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      if nil ~= playerActorProxyWrapper then
        local teamNo = playerActorProxyWrapper:getInstanceTeamNo()
        if -1 ~= teamNo then
          base = template[radarType.radarType_normalPlayer]
          if teamNo ~= miniGameMyTeamNo then
            if 0 == isColorBlindType then
              color = 4294930775
            else
              color = 4286432511
            end
          end
        end
      end
    end
  end
  if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if selfPlayer:isParticipateInRoseWar() == true then
      local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
      if (myRoseWarTeamNo == __eRoseWarTeam_Kamasylvia or myRoseWarTeamNo == __eRoseWarTeam_Odyllita) and radarType.radarType_normalPlayer == radarTypeValue then
        local isClone = false
        local tempActorWrapper = getActor(actorKeyRaw)
        if tempActorWrapper ~= nil then
          local subPlayerActorType = tempActorWrapper:get():getSubActorType()
          if subPlayerActorType == __eSubPlayerActorType_Clone then
            isClone = true
          end
        end
        local actorTeamNo = -1
        if isClone == true then
          local ownerActorKey = tempActorWrapper:get():getOwnerActorKeyRaw()
          local ownerActorWrapper = getPlayerActor(ownerActorKey)
          if ownerActorWrapper ~= nil and ownerActorWrapper:isParticipateInRoseWar() == true then
            actorTeamNo = ownerActorWrapper:getRoseWarTeamNo()
          end
        else
          local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
          if playerActorProxyWrapper ~= nil and playerActorProxyWrapper:isParticipateInRoseWar() == true then
            actorTeamNo = playerActorProxyWrapper:getRoseWarTeamNo()
          end
        end
        if actorTeamNo > -1 then
          if myRoseWarTeamNo == actorTeamNo then
            color = 4289457919
          else
            color = 4294945707
          end
        end
      end
    end
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true then
    local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if playerActorProxyWrapper ~= nil and playerActorProxyWrapper:get():isNeedHideNameForEdaniaInstanceField() == true then
      color = 4294967295
    end
  end
  if nil ~= base then
    CopyBaseProperty(base, control)
    control:SetShow(true)
    if radarType.radarType_allymonster == radarTypeValue or radarType.radarType_normalMonster == radarTypeValue or radarType.radarType_namedMonster == radarTypeValue or radarType.radarType_bossMonster == radarTypeValue or radarType.radarType_huntingMonster == radarTypeValue then
      local isChaseMonster = false
      if true == _ContentsGroup_ChaseMonster then
        local actorCharacterKey = actorProxyWrapper:getCharacterKeyRaw()
        if true == ToClient_isChaseMonster(actorCharacterKey) then
          isChaseMonster = true
        end
      end
      if true == isChaseMonster then
        color = chaseColor
      elseif 0 == isColorBlindType then
        if true == _ContentsGroup_ChinaFontColor then
          color = UI_color.C_00FFFFFF
        else
          color = UI_color.C_FFB22300
        end
      elseif 1 == isColorBlindType then
        color = UI_color.C_FFD85300
      elseif 2 == isColorBlindType then
        color = UI_color.C_FFD82800
      end
      if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start then
        local selfPlayer = getSelfPlayer()
        if nil == selfPlayer then
          return
        end
        if selfPlayer:isParticipateInRoseWar() == true and actorProxyWrapper:isParticipateInRoseWar() == true then
          local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
          local actorTeamNo = actorProxyWrapper:getRoseWarTeamNo()
          if myRoseWarTeamNo == actorTeamNo then
            color = 4289457919
          else
            color = 4294945707
          end
        end
      end
    elseif radarType.radarType_normalMonsterQuestTarget == radarTypeValue or radarType.radarType_namedMonsterQuestTarget == radarTypeValue or radarType.radarType_bossMonsterQuestTarget == radarTypeValue or radarType.radarType_huntingMonsterQuestTarget == radarTypeValue then
      if 0 == isColorBlindType then
        if true == isChaseMonster then
          if true == _ContentsGroup_ChinaFontColor then
            color = UI_color.C_00FFFFFF
          else
            color = chaseColor
          end
        else
          color = UI_color.C_FFEE9900
        end
      elseif 1 == isColorBlindType then
        color = UI_color.C_FFFFE866
      elseif 2 == isColorBlindType then
        color = UI_color.C_FFFFE866
      end
    end
    if color ~= nil then
      control:SetColor(color)
    elseif radarTypeValue == radarType.radarType_partyMember then
      control:SetColor(4280867697)
    elseif radarTypeValue == radarType.radarType_guildMember then
      control:SetColor(4278236415)
    end
    if ToClient_IsAnySiegeBeingOfMyChannel() == true then
      SetRadarUIColorByGuildColor(actorKeyRaw, control)
    end
    if isSelfPlayerCloneIcon ~= nil and isSelfPlayerCloneIcon == true then
      if isColorBlindType == 0 then
        control:SetColor(4294934966)
      else
        control:SetColor(4285395186)
      end
    end
  else
    control:SetShow(false)
  end
  monsterTitle = nil
  SortRadar_IconIndex()
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  control:SetDepth(typeDepth[radarTypeValue])
  control:addInputEvent("Mouse_RUp", "RadarMap_Background_MouseRUp()")
end
function FromClient_radarTypeChanged(actorKeyRaw, targetUI, radarTypeValue)
  if ToClient_namelessPVPServer() == true then
    local actorProxyWrapper = getActor(actorKeyRaw)
    if actorProxyWrapper ~= nil and (actorProxyWrapper:get():isPlayer() == true or actorProxyWrapper:get():isSubPlayer() == true) and actorProxyWrapper:IsNeedHideNameForPVPServer() == true and radarTypeValue ~= radarType.radarType_hide then
      radarTypeValue = radarType.radarType_normalPlayer
    end
  end
  local templateUI = template[radarTypeValue]
  local isColorBlindType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local color
  if true == isContentsOpenLocalWar then
    local selfPlayerLocalWarTeam = ToClient_GetMyTeamNoRedBattleField()
    if 0 ~= selfPlayerLocalWarTeam and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local teamNo = ToClient_GetTeamNoRedBattleFieldByActorProxyRaw(actorKeyRaw)
      if 0 ~= teamNo then
        templateUI = template[radarType.radarType_normalPlayer]
        if teamNo ~= selfPlayerLocalWarTeam then
          if 0 == isColorBlindType then
            color = 4294930775
          else
            color = 4286432511
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    local solareMyTeamNo = ToClient_GetSolareMyTeamType()
    if -1 ~= solareMyTeamNo and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      if nil ~= playerActorProxyWrapper then
        local teamNo = playerActorProxyWrapper:getInstanceTeamNo()
        if -1 ~= teamNo then
          base = template[radarType.radarType_normalPlayer]
          if teamNo ~= solareMyTeamNo then
            if 0 == isColorBlindType then
              color = 4294930775
            else
              color = 4286432511
            end
          end
        end
      end
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_MiniGame) then
    local miniGameMyTeamNo = -1
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    miniGameMyTeamNo = selfPlayer:getInstanceTeamNo()
    if -1 ~= miniGameMyTeamNo and (radarType.radarType_partyMember == radarTypeValue or radarType.radarType_guildMember == radarTypeValue or radarType.radarType_normalPlayer == radarTypeValue) then
      local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
      if nil ~= playerActorProxyWrapper then
        local teamNo = playerActorProxyWrapper:getInstanceTeamNo()
        if -1 ~= teamNo then
          base = template[radarType.radarType_normalPlayer]
          if teamNo ~= miniGameMyTeamNo then
            if 0 == isColorBlindType then
              color = 4294930775
            else
              color = 4286432511
            end
          end
        end
      end
    end
  end
  if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if selfPlayer:isParticipateInRoseWar() == true then
      local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
      if (myRoseWarTeamNo == __eRoseWarTeam_Kamasylvia or myRoseWarTeamNo == __eRoseWarTeam_Odyllita) and radarType.radarType_normalPlayer == radarTypeValue then
        local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
        if playerActorProxyWrapper ~= nil and playerActorProxyWrapper:isParticipateInRoseWar() == true then
          local actorTeamNo = playerActorProxyWrapper:getRoseWarTeamNo()
          if myRoseWarTeamNo == actorTeamNo then
            color = 4289457919
          else
            color = 4294945707
          end
        end
      end
    end
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true then
    local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
    if playerActorProxyWrapper ~= nil and playerActorProxyWrapper:get():isNeedHideNameForEdaniaInstanceField() == true then
      color = 4294967295
    end
  end
  if nil == templateUI then
    targetUI:SetShow(false)
    return
  end
  CopyBaseProperty(templateUI, targetUI)
  if radarType.radarType_allymonster == radarTypeValue or radarType.radarType_normalMonster == radarTypeValue or radarType.radarType_namedMonster == radarTypeValue or radarType.radarType_bossMonster == radarTypeValue or radarType.radarType_huntingMonster == radarTypeValue then
    local isChaseMonster = false
    if true == _ContentsGroup_ChaseMonster then
      local actorProxyWrapper = getActor(actorKeyRaw)
      if nil ~= actorProxyWrapper then
        isChaseMonster = ToClient_isChaseMonster(actorProxyWrapper:getCharacterKeyRaw())
      end
    end
    if true == isChaseMonster then
      color = chaseColor
    elseif 0 == isColorBlindType then
      if true == _ContentsGroup_ChinaFontColor then
        color = UI_color.C_00FFFFFF
      else
        color = UI_color.C_FFB22300
      end
    elseif 1 == isColorBlindType then
      color = UI_color.C_FFD85300
    elseif 2 == isColorBlindType then
      color = UI_color.C_FFD82800
    end
    if _ContentsGroup_RoseWar == true and ToClient_GetRoseWarState() == __eRoseWar_Start then
      local selfPlayer = getSelfPlayer()
      if nil == selfPlayer then
        return
      end
      if selfPlayer:isParticipateInRoseWar() == true then
        local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
        local actorProxyWrapper = getActor(actorKeyRaw)
        if actorProxyWrapper ~= nil and actorProxyWrapper:isParticipateInRoseWar() == true then
          local actorTeamNo = actorProxyWrapper:getRoseWarTeamNo()
          if myRoseWarTeamNo == actorTeamNo then
            color = 4289457919
          else
            color = 4294945707
          end
        end
      end
    end
  elseif radarType.radarType_normalMonsterQuestTarget == radarTypeValue or radarType.radarType_namedMonsterQuestTarget == radarTypeValue or radarType.radarType_bossMonsterQuestTarget == radarTypeValue or radarType.radarType_huntingMonsterQuestTarget == radarTypeValue then
    local isChaseMonster = false
    if true == _ContentsGroup_ChaseMonster then
      local actorProxyWrapper = getActor(actorKeyRaw)
      if nil ~= actorProxyWrapper then
        isChaseMonster = ToClient_isChaseMonster(actorProxyWrapper:getCharacterKeyRaw())
      end
    end
    if 0 == isColorBlindType then
      if true == isChaseMonster then
        if true == _ContentsGroup_ChinaFontColor then
          color = UI_color.C_00FFFFFF
        else
          color = chaseColor
        end
      else
        color = UI_color.C_FFEE9900
      end
    elseif 1 == isColorBlindType then
      color = UI_color.C_FFFFE866
    elseif 2 == isColorBlindType then
      color = UI_color.C_FFFFE866
    end
  end
  if color ~= nil then
    targetUI:SetColor(color)
  elseif radarTypeValue == radarType.radarType_partyMember then
    targetUI:SetColor(4280867697)
  elseif radarTypeValue == radarType.radarType_guildMember then
    targetUI:SetColor(4278236415)
  end
  if ToClient_IsAnySiegeBeingOfMyChannel() == true then
    SetRadarUIColorByGuildColor(actorKeyRaw, targetUI)
  end
  targetUI:SetDepth(typeDepth[radarTypeValue])
end
registerEvent("FromClient_RadorTypeChanged", "FromClient_radarTypeChanged")
registerEvent("FromClient_RadorUICreated", "FromClient_RadarUICreated")
registerEvent("FromClient_RadarChangePlayerIconColor", "Fromclient_RadarChangePlayerIconColor")
registerEvent("FromClient_ChangeRadarSettingForGuildSiege", "FromClient_ChangeRadarSettingForGuildSiege")
local function check_ServerChannel()
  local radarTimeControl = radarTime.controls
  radarTimeControl.serverName:SetText(getCurrentWolrdName())
  local curChannelData = getCurrentChannelServerData()
  if isGameTypeRussia() then
    radarTimeControl.serverName:SetShow(true)
  else
    radarTimeControl.serverName:SetShow(false)
  end
  local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
  radarTimeControl.channelName:SetText("<PAColor0xFFb0cd61>" .. channelName .. "<PAOldColor>")
end
check_ServerChannel()
function CalcPositionUseToTextUI(targetUIposX, targetUIposY, textUI)
  if Panel_Radar:GetSizeX() < targetUIposX + textUI:GetTextSizeX() then
    textUI:SetPosX(Panel_Radar:GetSizeX() - textUI:GetTextSizeX())
  else
    textUI:SetPosX(targetUIposX)
  end
  if Panel_Radar:GetPosY() > targetUIposY - textUI:GetTextSizeY() then
    textUI:SetPosY(Panel_Radar:GetPosY())
  else
    textUI:SetPosY(targetUIposY - textUI:GetTextSizeY())
  end
end
function FromClient_setNameOfMouseOverIcon(actorProxyWrapper, targetUI, targetUIposX, targetUIposY)
  if true == _ContentsGroup_UsePadSnapping then
    radar_OverName:SetShow(false)
    return
  end
  if false == isShowOtherIcon then
    radar_OverName:SetShow(false)
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) and true == ToClient_IsOccupationModeInRedBattleField() then
    return
  end
  local actorName = ""
  if actorProxyWrapper:get():isNpc() then
    if "" ~= actorProxyWrapper:getCharacterTitle() then
      actorName = actorProxyWrapper:getName() .. " " .. actorProxyWrapper:getCharacterTitle()
    else
      actorName = actorProxyWrapper:getName()
    end
  elseif actorProxyWrapper:get():isHouseHold() then
    actorName = getHouseHoldName(actorProxyWrapper:get())
  else
    if actorProxyWrapper:get():isPlayer() then
      local playerActorProxyWrapper = getPlayerActor(actorProxyWrapper:getActorKey())
      if nil ~= playerActorProxyWrapper and playerActorProxyWrapper:get():isVolunteer() then
        return
      end
    end
    if actorProxyWrapper:get():isPlayer() == true and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
      local playerActorProxyWrapper = getPlayerActor(actorProxyWrapper:getActorKey())
      if nil ~= playerActorProxyWrapper then
        actorName = playerActorProxyWrapper:getUserNickname()
      end
    else
      actorName = actorProxyWrapper:getName()
    end
  end
  if actorProxyWrapper:IsNeedHideNameForPVPServer() == true then
    actorName = PaGlobalFunc_getAnonymousNameString(0)
  end
  if radarMap.isRotateMode then
    targetUIposY = targetUIposY - targetUI:GetSizeY() * 2 - targetUI:GetSizeY() / 2
  else
    targetUIposX = targetUI:GetPosX()
    targetUIposY = targetUI:GetPosY()
  end
  radar_OverName:SetShow(true)
  radar_OverName:SetText(actorName)
  radar_OverName:SetSize(radar_OverName:GetTextSizeX() + 15, radar_OverName:GetTextSizeY() + radar_OverName:GetSpanSize().y)
  Panel_Radar:SetChildIndex(radar_OverName, 9999)
  CalcPositionUseToTextUI(targetUIposX, targetUIposY, radar_OverName)
  radar_OverName:SetDepth(-1000)
end
function FromClient_NameOff()
  if nil == radar_OverName then
    return
  end
  if radar_OverName:GetShow() then
    radar_OverName:SetShow(false)
  end
end
function PaGlobal_Radar_WarAlert(isShow)
  radar_WarAlert:SetShow(isShow)
end
function RadarResizeByReset(resetRadarScale)
  if false == resetRadarScale then
    local RadarCurrentSizeX = Panel_Radar:GetSizeX()
    local RadarCurrentSizeY = Panel_Radar:GetSizeY()
    Panel_Radar:SetSize(RadarCurrentSizeX, RadarCurrentSizeY)
  else
    Panel_Radar:SetSize(Panel_OrigSizeX, Panel_OrigSizeY)
  end
  radarMap.controls.radar_Background:SetPosX(0)
  radarMap.controls.radar_Background:SetSize(Panel_OrigSizeX, Panel_OrigSizeY)
  Panel_Radar:ComputePos()
  local SPI = radarMap.controls.icon_SelfPlayer
  local halfSelfSizeX = SPI:GetSizeX() / 2
  local halfSelfSizeY = SPI:GetSizeY() / 2
  local halfSizeX = Panel_Radar:GetSizeX() / 2
  local halfSizeY = Panel_Radar:GetSizeY() / 2
  SPI:SetPosX(halfSizeX - halfSelfSizeX)
  SPI:SetPosY(halfSizeY - halfSelfSizeY)
  radarMap.pcPosBaseControl.x = SPI:GetPosX() + halfSelfSizeX
  radarMap.pcPosBaseControl.y = SPI:GetPosY() + halfSelfSizeY
  ToClient_setRadorUICenterPosition(radarMap.pcPosBaseControl.x, radarMap.pcPosBaseControl.y)
  controlAlign()
  PaGlobal_NpcNavi_All_ResetPosistion()
  TownNpcIcon_Resize()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    if nil ~= PaGlobal_KeyboardGuideButton then
      PaGlobal_KeyboardGuideButton_Position()
    end
    Panel_PlayerEndurance_Position()
    Panel_CarriageEndurance_Position()
    Panel_HorseEndurance_Position()
    Panel_ShipEndurance_Position()
    Panel_SailShipEndurance_Position()
    if nil ~= Panel_Widget_BetterEquipment then
      PaGlobalFunc_BetterEquipment_OnScreenResize()
    end
    if nil ~= Panel_CommonGameScreenUI then
      PaGlobal_BossCamera_Repos()
    end
  end
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    FGlobal_PersonalIcon_ButtonPosUpdate()
  else
    FromClient_Widget_FunctionButton_Resize()
  end
  FromClient_MainQuestWidget_ResetPosition()
  FromClient_questWidget_ResetPosition()
  if false == _ContentsGroup_RemasterUI_QuestWidget then
    PaGlobalFunc_Quest_UpdatePosition()
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    PaGlobal_HardCoreQuest_UpdateWidgetPosition()
  end
  ToClient_SaveUiInfo(false)
  radarAlert_Resize()
  if nil ~= Panel_GuildInvite_Alert then
    PaGlobal_GuildInviteAlert_SetPos()
  end
  if nil ~= FromClient_Widget_TownSimpleNavi_All_OnScreenResize then
    FromClient_Widget_TownSimpleNavi_All_OnScreenResize()
  end
end
function FGlobal_ResetTimeBar()
  Panel_TimeBar:SetSize(295, 22)
  Panel_TimeBar:ComputePos()
end
function FGlobal_ResetRadarUI(resetRadarScale)
  RadarResizeByReset(resetRadarScale)
  radar_AlphaScrl:SetControlPos(ToClient_GetRaderAlpha() * 100)
  Radar_updateWorldMap_AlphaControl_Init()
  radar_SizeSlider:SetControlPos(ToClient_GetRaderScale() * 100)
  local scaleSlideValue = 1 - radar_SizeSlider:GetControlPos()
  updateWorldMapDistance(scaleMinValue + scaleSlideValue * 100)
end
function Radar_luaLoadComplete()
  controlAlign()
  radarAlert_Resize()
  if false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap) then
    if 0 <= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_RadarMap, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      Panel_Radar:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_RadarMap, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
    else
      Panel_Radar:SetShow(true, false)
    end
  end
  if 0 <= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_TimeBar, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
    Panel_TimeBar:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_TimeBar, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  else
    Panel_TimeBar:SetShow(true, false)
  end
  RadarMap_UpdatePosition()
end
function PaGlobalFunc_CheckisInstanceContents()
  local isMapHide = true
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    isMapHide = false
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_FreeBattleField) then
    isMapHide = false
  end
  return isMapHide
end
function PaGlobalFunc_Radar_Resize()
  controlAlign()
  radarAlert_Resize()
  if nil ~= PaGlobal_WorldMiniMap then
    PaGlobal_WorldMiniMap:setTimebarSize()
  end
end
function PaGlobalFunc_ServerSelct_Open()
  if true == ToClient_IsRemoteInstallMode() then
    return
  end
  if nil ~= Panel_ChannelSelect_All then
    PaGlobalFunc_ChannelSelect_All_Open()
  end
end
function PaGlobalFunc_Radar_SetRegionSubNameText(text)
  radar_regionSubName:SetText(text)
  radar_regionSubName:ComputePos()
  radar_regionSubName:SetShow(true)
end
function PaGlobalFunc_Radar_ClearRegionSubNameText()
  radar_regionSubName:SetText("")
  radar_regionSubName:SetShow(false)
end
registerEvent("FromClient_luaLoadComplete", "Radar_luaLoadComplete")
registerEvent("FromClient_setNameOfMouseOverIcon", "FromClient_setNameOfMouseOverIcon")
registerEvent("FromClient_NameOff", "FromClient_NameOff")
registerEvent("FromClient_ChangeRadarArrow", "FromClient_ChangeRadarArrow")
registerEvent("FromClient_ChangeRadarRotateMode", "Radar_SetRotateMode")
registerEvent("onScreenResize", "PaGlobalFunc_Radar_Resize")
registerEvent("FromClient_ApplyUISettingPanelInfo", "PaGlobalFunc_Radar_Resize")
registerEvent("FromClient_UpdateActorIconColor", "FGlobal_Radar_UpdateActorIconColor")
registerEvent("FromClient_SetMiniMapBlackFieldArea", "PaGlobalFunc_SetMiniMapHardCoreBlackFieldArea")
changePositionBySever(Panel_TimeBar, CppEnums.PAGameUIType.PAGameUIPanel_TimeBar, true, false, false)
Panel_Radar:SetSpanSize(7, 20)
