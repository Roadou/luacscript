local _panel = Panel_Window_QuestBranch
local _questType = {
  calpheon = 0,
  media = 1,
  balenos = 2,
  blackStar = 3,
  blackStarArmor = 4,
  blackStarHelm = 5,
  blackStarGlove = 6,
  blackStarAwaken = 7,
  blackStarBoots = 8,
  astrologer_1 = 9,
  astrologer_2 = 10,
  astrologer_3 = 11,
  astrologer_4 = 12,
  astrologer_5 = 13,
  astrologer_6 = 14,
  astrologer_7 = 15,
  astrologer_8 = 16,
  astrologer_9 = 17,
  sageAwaken = 18,
  seasonQuick = 19,
  lv1Start = 20,
  firstBaseQuest = 21,
  blackStarSubHand = 22,
  winterMountain = 23,
  rebalenos_1 = 24,
  rebalenos_2 = 25,
  rebalenos_3 = 26,
  rebalenos_4 = 27,
  rebalenos_seasonQuick = 28,
  rebalenos_completeQuick_1 = 29,
  rebalenos_completeQuick_2 = 30,
  character_story_1 = 31,
  summer_festival_1 = 32,
  A1_4041 = 33,
  rebalenos_2_CH = 34,
  rebalenos_4_CH = 35,
  Morning_03_22 = 36,
  Morning_07_19 = 37,
  Morning_05_21 = 38,
  Morning_12_11 = 39,
  Morning_13_11 = 40,
  Morning_06_19 = 41,
  Morning_04_20 = 42,
  Morning_GabDol_01 = 43,
  RoseWar = 44,
  blackStar_improve = 45,
  blackStarArmor_improve = 46,
  blackStarHelm_improve = 47,
  blackStarGlove_improve = 48,
  blackStarAwaken_improve = 49,
  blackStarBoots_improve = 50,
  blackStarSubHand_improve = 51,
  storyReboot_SerenCalph_NorthCamp = 52,
  storyReboot_SerenCalph_Fogan = 53,
  storyReboot_SerenCalph_Harpy = 54,
  storyReboot_SerenCalph_Troll = 55,
  Media_After = 56,
  Morning_8532_23 = 57,
  Morning_8534_18 = 58,
  Morning_8529_15 = 59,
  Morning_8536_18 = 60,
  Morning_8531_27 = 61,
  Morning_8530_20 = 62,
  Morning_8535_22 = 63,
  Morning_8533_26 = 64
}
local isClearedQuestList = {
  [_questType.calpheon] = {questGroupNo = 21003, questNo = 10},
  [_questType.media] = {questGroupNo = 21403, questNo = 6},
  [_questType.blackStar] = {questGroupNo = 3408, questNo = 8},
  [_questType.balenos] = {questGroupNo = 21002, questNo = 6},
  [_questType.blackStarArmor] = {questGroupNo = 3505, questNo = 10},
  [_questType.blackStarHelm] = {questGroupNo = 3508, questNo = 10},
  [_questType.blackStarGlove] = {questGroupNo = 3514, questNo = 10},
  [_questType.blackStarAwaken] = {questGroupNo = 3517, questNo = 11},
  [_questType.blackStarBoots] = {questGroupNo = 3433, questNo = 10},
  [_questType.astrologer_1] = {questGroupNo = 9022, questNo = 1},
  [_questType.astrologer_2] = {questGroupNo = 9022, questNo = 2},
  [_questType.astrologer_3] = {questGroupNo = 9022, questNo = 3},
  [_questType.astrologer_4] = {questGroupNo = 9022, questNo = 4},
  [_questType.astrologer_5] = {questGroupNo = 9022, questNo = 5},
  [_questType.astrologer_6] = {questGroupNo = 9022, questNo = 6},
  [_questType.astrologer_7] = {questGroupNo = 9022, questNo = 7},
  [_questType.astrologer_8] = {questGroupNo = 9022, questNo = 8},
  [_questType.astrologer_9] = {questGroupNo = 9022, questNo = 9},
  [_questType.sageAwaken] = {questGroupNo = 368, questNo = 29},
  [_questType.seasonQuick] = {questGroupNo = 21121, questNo = 2},
  [_questType.lv1Start] = {questGroupNo = 7501, questNo = 1},
  [_questType.firstBaseQuest] = {questGroupNo = 7502, questNo = 1},
  [_questType.blackStarSubHand] = {questGroupNo = 3441, questNo = 10},
  [_questType.winterMountain] = {questGroupNo = 7500, questNo = 80},
  [_questType.rebalenos_1] = {questGroupNo = 21125, questNo = 21},
  [_questType.rebalenos_2] = {questGroupNo = 21125, questNo = 29},
  [_questType.rebalenos_3] = {questGroupNo = 21125, questNo = 56},
  [_questType.rebalenos_4] = {questGroupNo = 21125, questNo = 67},
  [_questType.rebalenos_seasonQuick] = {questGroupNo = 21125, questNo = 41},
  [_questType.rebalenos_completeQuick_1] = {questGroupNo = 21125, questNo = 97},
  [_questType.rebalenos_completeQuick_2] = {questGroupNo = 21125, questNo = 100},
  [_questType.character_story_1] = {questGroupNo = 22226, questNo = 19},
  [_questType.summer_festival_1] = {questGroupNo = 11434, questNo = 3},
  [_questType.A1_4041] = {questGroupNo = 12108, questNo = 4},
  [_questType.rebalenos_2_CH] = {questGroupNo = 21125, questNo = 115},
  [_questType.rebalenos_4_CH] = {questGroupNo = 21125, questNo = 119},
  [_questType.Morning_03_22] = {questGroupNo = 8503, questNo = 22},
  [_questType.Morning_07_19] = {questGroupNo = 8507, questNo = 19},
  [_questType.Morning_05_21] = {questGroupNo = 8505, questNo = 21},
  [_questType.Morning_12_11] = {questGroupNo = 8512, questNo = 11},
  [_questType.Morning_13_11] = {questGroupNo = 8513, questNo = 11},
  [_questType.Morning_06_19] = {questGroupNo = 8506, questNo = 19},
  [_questType.Morning_04_20] = {questGroupNo = 8504, questNo = 20},
  [_questType.Morning_GabDol_01] = {questGroupNo = 8809, questNo = 4},
  [_questType.RoseWar] = {questGroupNo = 21605, questNo = 1},
  [_questType.blackStar_improve] = {questGroupNo = 3408, questNo = 31},
  [_questType.blackStarArmor_improve] = {questGroupNo = 3505, questNo = 32},
  [_questType.blackStarHelm_improve] = {questGroupNo = 3508, questNo = 32},
  [_questType.blackStarGlove_improve] = {questGroupNo = 3514, questNo = 32},
  [_questType.blackStarBoots_improve] = {questGroupNo = 3433, questNo = 32},
  [_questType.blackStarAwaken_improve] = {questGroupNo = 3517, questNo = 32},
  [_questType.blackStarSubHand_improve] = {questGroupNo = 3441, questNo = 32},
  [_questType.storyReboot_SerenCalph_NorthCamp] = {questGroupNo = 21130, questNo = 4},
  [_questType.storyReboot_SerenCalph_Fogan] = {questGroupNo = 21130, questNo = 81},
  [_questType.storyReboot_SerenCalph_Harpy] = {questGroupNo = 21136, questNo = 11},
  [_questType.storyReboot_SerenCalph_Troll] = {questGroupNo = 21139, questNo = 77},
  [_questType.Media_After] = {questGroupNo = 21411, questNo = 14},
  [_questType.Morning_8532_23] = {questGroupNo = 8532, questNo = 23},
  [_questType.Morning_8534_18] = {questGroupNo = 8534, questNo = 18},
  [_questType.Morning_8529_15] = {questGroupNo = 8529, questNo = 15},
  [_questType.Morning_8536_18] = {questGroupNo = 8536, questNo = 18},
  [_questType.Morning_8531_27] = {questGroupNo = 8531, questNo = 27},
  [_questType.Morning_8530_20] = {questGroupNo = 8530, questNo = 20},
  [_questType.Morning_8535_22] = {questGroupNo = 8535, questNo = 22},
  [_questType.Morning_8533_26] = {questGroupNo = 8533, questNo = 26}
}
local questData = {
  [_questType.calpheon] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_21004_1.dds",
      texturePathClear = "Icon/Quest/questBranch_21004_1_clear.dds",
      startGroupNo = 21004,
      startQuestNo = 1,
      clearQuestGroupNo = 21100,
      clearQuestNo = 4,
      clearQuestGroupNo_2 = 21101,
      clearQuestNo_2 = 4,
      spanSizeX = -330,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_21201_1.dds",
      texturePathClear = "Icon/Quest/questBranch_21201_1_clear.dds",
      startGroupNo = 21201,
      startQuestNo = 1,
      clearQuestGroupNo = 21100,
      clearQuestNo = 5,
      clearQuestGroupNo_2 = 21101,
      clearQuestNo_2 = 4,
      spanSizeX = 0,
      branchcleared = false
    },
    [2] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DIALOG_3"),
      texturePath = "Icon/Quest/questBranch_21301_1.dds",
      texturePathClear = "Icon/Quest/questBranch_21301_1_clear.dds",
      startGroupNo = 21301,
      startQuestNo = 1,
      clearQuestGroupNo = 21101,
      clearQuestNo = 8,
      clearQuestGroupNo_2 = nil,
      clearQuestNo_2 = nil,
      spanSizeX = 330,
      branchcleared = false
    },
    ["_branchCount"] = 3,
    ["_completeQuestGroupNo"] = 21108,
    ["_completeQuestNo"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.media] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_21404_1.dds",
      texturePathClear = "Icon/Quest/questBranch_21404_1_clear.dds",
      startGroupNo = 21404,
      startQuestNo = 1,
      clearQuestGroupNo = 21100,
      clearQuestNo = 4,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_21501_1.dds",
      texturePathClear = "Icon/Quest/questBranch_21501_1_clear.dds",
      startGroupNo = 21501,
      startQuestNo = 1,
      clearQuestGroupNo = 21100,
      clearQuestNo = 5,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStar] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3408,
      startQuestNo = 9,
      clearQuestGroupNo = 3408,
      clearQuestNo = 9,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3417,
      startQuestNo = 1,
      clearQuestGroupNo = 3417,
      clearQuestNo = 5,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.balenos] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_21002_6_A.dds",
      texturePathClear = "Icon/Quest/questBranch_21002_6_A_clear.dds",
      startGroupNo = 21002,
      startQuestNo = 7,
      clearQuestGroupNo = 21002,
      clearQuestNo = 9,
      spanSizeX = -330,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALENOS_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_21002_6_B.dds",
      texturePathClear = "Icon/Quest/questBranch_21002_6_B_clear.dds",
      startGroupNo = 21002,
      startQuestNo = 29,
      clearQuestGroupNo = 21002,
      clearQuestNo = 9,
      spanSizeX = 0,
      branchcleared = false
    },
    [2] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALLENOS_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALLENOS_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BALLENOS_DIALOGUE_3"),
      texturePath = "Icon/Quest/QuestBranch_21002_33.dds",
      texturePathClear = "Icon/Quest/QuestBranch_21002_33_clear.dds",
      startGroupNo = 21002,
      startQuestNo = 33,
      clearQuestGroupNo = 21002,
      clearQuestNo = 9,
      spanSizeX = 330,
      branchcleared = false
    },
    ["_branchCount"] = 3,
    ["_contentConsole"] = true
  },
  [_questType.blackStarArmor] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3505,
      startQuestNo = 11,
      clearQuestGroupNo = 3505,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3505,
      startQuestNo = 17,
      clearQuestGroupNo = 3505,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarHelm] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3508,
      startQuestNo = 11,
      clearQuestGroupNo = 3508,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3508,
      startQuestNo = 17,
      clearQuestGroupNo = 3508,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarGlove] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3514,
      startQuestNo = 11,
      clearQuestGroupNo = 3514,
      clearQuestNo = 12,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3514,
      startQuestNo = 17,
      clearQuestGroupNo = 3514,
      clearQuestNo = 12,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarAwaken] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3517,
      startQuestNo = 12,
      clearQuestGroupNo = 3517,
      clearQuestNo = 18,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3517,
      startQuestNo = 19,
      clearQuestGroupNo = 3517,
      clearQuestNo = 18,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarBoots] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3433,
      startQuestNo = 11,
      clearQuestGroupNo = 3433,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3433,
      startQuestNo = 17,
      clearQuestGroupNo = 3433,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_1] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_9023_1.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_1_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 1,
      clearQuestGroupNo = 9024,
      clearQuestNo = 1,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_2] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_9023_2.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_2_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 2,
      clearQuestGroupNo = 9024,
      clearQuestNo = 2,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_3] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_3"),
      texturePath = "Icon/Quest/questBranch_9023_3.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_3_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 3,
      clearQuestGroupNo = 9024,
      clearQuestNo = 3,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_4] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_4"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_4"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_4"),
      texturePath = "Icon/Quest/questBranch_9023_4.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_4_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 4,
      clearQuestGroupNo = 9024,
      clearQuestNo = 4,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_5] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_5"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_5"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_5"),
      texturePath = "Icon/Quest/questBranch_9023_5.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_5_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 5,
      clearQuestGroupNo = 9024,
      clearQuestNo = 5,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_6] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_6"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_6"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_6"),
      texturePath = "Icon/Quest/questBranch_9023_6.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_6_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 6,
      clearQuestGroupNo = 9024,
      clearQuestNo = 6,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_7] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_7"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_7"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_7"),
      texturePath = "Icon/Quest/questBranch_9023_7.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_7_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 7,
      clearQuestGroupNo = 9024,
      clearQuestNo = 7,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_8] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_8"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_8"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_8"),
      texturePath = "Icon/Quest/questBranch_9023_8.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_8_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 8,
      clearQuestGroupNo = 9024,
      clearQuestNo = 8,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.astrologer_9] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_9"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DESC_9"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_AstrologerEvent_DIALOG_9"),
      texturePath = "Icon/Quest/questBranch_9023_9.dds",
      texturePathClear = "Icon/Quest/questBranch_9023_9_clear.dds",
      startGroupNo = 9023,
      startQuestNo = 9,
      clearQuestGroupNo = 9024,
      clearQuestNo = 9,
      spanSizeX = 0,
      branchcleared = false
    },
    ["_branchCount"] = 1,
    ["_contentConsole"] = true
  },
  [_questType.sageAwaken] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_368_31.dds",
      texturePathClear = "Icon/Quest/questBranch_368_31.dds",
      startGroupNo = 368,
      startQuestNo = 31,
      clearQuestGroupNo = 368,
      clearQuestNo = 28,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SAGEAWAKEN_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_368_32.dds",
      texturePathClear = "Icon/Quest/questBranch_368_32.dds",
      startGroupNo = 368,
      startQuestNo = 32,
      clearQuestGroupNo = 368,
      clearQuestNo = 28,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.seasonQuick] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_1"),
      texturePath = "Icon/Quest/questbranch_fugas1.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas1.dds",
      startGroupNo = 21121,
      startQuestNo = 3,
      clearQuestGroupNo = 21121,
      clearQuestNo = 14,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_2"),
      texturePath = "Icon/Quest/questbranch_fugas2.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas2.dds",
      startGroupNo = 40022,
      startQuestNo = 1,
      clearQuestGroupNo = 40022,
      clearQuestNo = 14,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.lv1Start] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1START_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_7501_2.dds",
      texturePathClear = "Icon/Quest/questBranch_7501_2_clear.dds",
      startGroupNo = 7501,
      startQuestNo = 2,
      clearQuestGroupNo = 7500,
      clearQuestNo = 1,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1START_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_7501_3.dds",
      texturePathClear = "Icon/Quest/questBranch_7501_3_clear.dds",
      startGroupNo = 7501,
      startQuestNo = 3,
      clearQuestGroupNo = 7500,
      clearQuestNo = 1,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.firstBaseQuest] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DIALOG_3"),
      texturePath = "Icon/Quest/questBranch_7502_2.dds",
      texturePathClear = "Icon/Quest/questBranch_7502_2_clear.dds",
      startGroupNo = 7502,
      startQuestNo = 2,
      clearQuestGroupNo = 7500,
      clearQuestNo = 1,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_LV1STAR_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_7501_3.dds",
      texturePathClear = "Icon/Quest/questBranch_7501_3_clear.dds",
      startGroupNo = 7502,
      startQuestNo = 3,
      clearQuestGroupNo = 7500,
      clearQuestNo = 1,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarSubHand] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3441,
      startQuestNo = 11,
      clearQuestGroupNo = 3441,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3441,
      startQuestNo = 17,
      clearQuestGroupNo = 3441,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.winterMountain] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_7500_81.dds",
      texturePathClear = "Icon/Quest/questBranch_7500_81_clear.dds",
      startGroupNo = 7500,
      startQuestNo = 81,
      clearQuestGroupNo = 7500,
      clearQuestNo = 83,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ETERNALWINTER_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_7500_82.dds",
      texturePathClear = "Icon/Quest/questBranch_7500_82_clear.dds",
      startGroupNo = 7500,
      startQuestNo = 82,
      clearQuestGroupNo = 7500,
      clearQuestNo = 83,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_1] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_21125_22.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_22_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 22,
      clearQuestGroupNo = 21125,
      clearQuestNo = 26,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_21125_24.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_24_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 24,
      clearQuestGroupNo = 21125,
      clearQuestNo = 26,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_2] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_3"),
      texturePath = "Icon/Quest/questBranch_21125_30.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_30_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 30,
      clearQuestGroupNo = 21125,
      clearQuestNo = 32,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_4"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_4"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_4"),
      texturePath = "Icon/Quest/questBranch_21125_31.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_31_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 31,
      clearQuestGroupNo = 21125,
      clearQuestNo = 32,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_3] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_5"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_5"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_5"),
      texturePath = "Icon/Quest/questBranch_21125_57.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_57_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 57,
      clearQuestGroupNo = 21125,
      clearQuestNo = 63,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_6"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_6"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_6"),
      texturePath = "Icon/Quest/questBranch_21125_60.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_60_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 60,
      clearQuestGroupNo = 21125,
      clearQuestNo = 63,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_4] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_7"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_7"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_7"),
      texturePath = "Icon/Quest/questBranch_21125_68.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_68_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 68,
      clearQuestGroupNo = 21125,
      clearQuestNo = 74,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_8"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_8"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_8"),
      texturePath = "Icon/Quest/questBranch_21125_71.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_71_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 71,
      clearQuestGroupNo = 21125,
      clearQuestNo = 74,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_seasonQuick] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_1"),
      texturePath = "Icon/Quest/questbranch_fugas1.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas1.dds",
      startGroupNo = 21125,
      startQuestNo = 102,
      clearQuestGroupNo = 21125,
      clearQuestNo = 96,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_2"),
      texturePath = "Icon/Quest/questbranch_fugas2.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas2.dds",
      startGroupNo = 40022,
      startQuestNo = 1,
      clearQuestGroupNo = 40022,
      clearQuestNo = 14,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_completeQuick_1] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_3"),
      texturePath = "Icon/Quest/questbranch_Kirkley.dds",
      texturePathClear = "Icon/Quest/questbranch_Kirkley.dds",
      startGroupNo = 21130,
      startQuestNo = 88,
      clearQuestGroupNo = 21130,
      clearQuestNo = 88,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_4"),
      texturePath = "Icon/Quest/questbranch_fugas2.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas2.dds",
      startGroupNo = 40022,
      startQuestNo = 1,
      clearQuestGroupNo = 40022,
      clearQuestNo = 14,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_completeQuick_2] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_3"),
      texturePath = "Icon/Quest/questbranch_Kirkley.dds",
      texturePathClear = "Icon/Quest/questbranch_Kirkley.dds",
      startGroupNo = 21130,
      startQuestNo = 88,
      clearQuestGroupNo = 21130,
      clearQuestNo = 88,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_FUGAR_DIALOG_4"),
      texturePath = "Icon/Quest/questbranch_fugas2.dds",
      texturePathClear = "Icon/Quest/questbranch_fugas2.dds",
      startGroupNo = 40022,
      startQuestNo = 1,
      clearQuestGroupNo = 40022,
      clearQuestNo = 14,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.character_story_1] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_22226_20.dds",
      texturePathClear = "Icon/Quest/questBranch_22226_20_clear.dds",
      startGroupNo = 22226,
      startQuestNo = 20,
      clearQuestGroupNo = 22226,
      clearQuestNo = 23,
      spanSizeX = -330,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_22226_21.dds",
      texturePathClear = "Icon/Quest/questBranch_22226_21_clear.dds",
      startGroupNo = 22226,
      startQuestNo = 21,
      clearQuestGroupNo = 22226,
      clearQuestNo = 23,
      spanSizeX = 0,
      branchcleared = false
    },
    [2] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CHARACTER_STORY1_DIALOG_3"),
      texturePath = "Icon/Quest/questBranch_22226_22.dds",
      texturePathClear = "Icon/Quest/questBranch_22226_22_clear.dds",
      startGroupNo = 22226,
      startQuestNo = 22,
      clearQuestGroupNo = 22226,
      clearQuestNo = 23,
      spanSizeX = 330,
      branchcleared = false
    },
    ["_branchCount"] = 3,
    ["_completeQuestGroupNo"] = 22226,
    ["_completeQuestNo"] = 23,
    ["_contentConsole"] = true
  },
  [_questType.summer_festival_1] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_DIALOG_1"),
      texturePath = "Icon/Quest/questbranch_TerPapu.dds",
      texturePathClear = "Icon/Quest/questbranch_TerPapu_Clear.dds",
      startGroupNo = 11496,
      startQuestNo = 3,
      clearQuestGroupNo = 11496,
      clearQuestNo = 3,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SUMMERFES_DIALOG_2"),
      texturePath = "Icon/Quest/questbranch_TerCrio.dds",
      texturePathClear = "Icon/Quest/questbranch_TerCrio_Clear.dds",
      startGroupNo = 11496,
      startQuestNo = 4,
      clearQuestGroupNo = 11496,
      clearQuestNo = 4,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.A1_4041] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_DIALOG_1"),
      texturePath = "Icon/Quest/A1_4041_A.dds",
      texturePathClear = "Icon/Quest/A1_4041_A.dds",
      startGroupNo = 12108,
      startQuestNo = 5,
      clearQuestGroupNo = 12108,
      clearQuestNo = 8,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_A1_4041_DIALOG_2"),
      texturePath = "Icon/Quest/A1_4041_B.dds",
      texturePathClear = "Icon/Quest/A1_4041_B.dds",
      startGroupNo = 12108,
      startQuestNo = 22,
      clearQuestGroupNo = 12108,
      clearQuestNo = 8,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_2_CH] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_3_CH"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_3_CH"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_3_CH"),
      texturePath = "Icon/Quest/questBranch_21125_116.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_116_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 116,
      clearQuestGroupNo = 21125,
      clearQuestNo = 32,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_4"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_4"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_4"),
      texturePath = "Icon/Quest/questBranch_21125_31.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_31_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 126,
      clearQuestGroupNo = 21125,
      clearQuestNo = 127,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.rebalenos_4_CH] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_7"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_7"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_7"),
      texturePath = "Icon/Quest/questBranch_21125_68.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_68_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 68,
      clearQuestGroupNo = 21125,
      clearQuestNo = 74,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_8"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DESC_8"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_REBALENOS_DIALOG_8"),
      texturePath = "Icon/Quest/questBranch_21125_71.dds",
      texturePathClear = "Icon/Quest/questBranch_21125_71_clear.dds",
      startGroupNo = 21125,
      startQuestNo = 71,
      clearQuestGroupNo = 21125,
      clearQuestNo = 74,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_03_22] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_DIALOG_1"),
      texturePath = "Icon/Quest/8503_22_A.dds",
      texturePathClear = "Icon/Quest/8503_22_A_Gray.dds",
      startGroupNo = 8503,
      startQuestNo = 23,
      clearQuestGroupNo = 8503,
      clearQuestNo = 29,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_03_22_DIALOG_2"),
      texturePath = "Icon/Quest/8503_22_B.dds",
      texturePathClear = "Icon/Quest/8503_22_B_Gray.dds",
      startGroupNo = 8503,
      startQuestNo = 26,
      clearQuestGroupNo = 8503,
      clearQuestNo = 29,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_07_19] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_DIALOG_1"),
      texturePath = "Icon/Quest/8507_19_A.dds",
      texturePathClear = "Icon/Quest/8507_19_A_Gray.dds",
      startGroupNo = 8507,
      startQuestNo = 20,
      clearQuestGroupNo = 8507,
      clearQuestNo = 23,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_07_19_DIALOG_2"),
      texturePath = "Icon/Quest/8507_19_B.dds",
      texturePathClear = "Icon/Quest/8507_19_B_Gray.dds",
      startGroupNo = 8507,
      startQuestNo = 24,
      clearQuestGroupNo = 8507,
      clearQuestNo = 26,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_05_21] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_DIALOG_1"),
      texturePath = "Icon/Quest/8505_22_A.dds",
      texturePathClear = "Icon/Quest/8505_22_A_Gray.dds",
      startGroupNo = 8505,
      startQuestNo = 22,
      clearQuestGroupNo = 8505,
      clearQuestNo = 24,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_05_21_DIALOG_2"),
      texturePath = "Icon/Quest/8505_22_B.dds",
      texturePathClear = "Icon/Quest/8505_22_B_Gray.dds",
      startGroupNo = 8505,
      startQuestNo = 25,
      clearQuestGroupNo = 8505,
      clearQuestNo = 27,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_12_11] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_DIALOG_1"),
      texturePath = "Icon/Quest/8512_11_A.dds",
      texturePathClear = "Icon/Quest/8512_11_A_Gray.dds",
      startGroupNo = 8512,
      startQuestNo = 12,
      clearQuestGroupNo = 8512,
      clearQuestNo = 18,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_12_11_DIALOG_2"),
      texturePath = "Icon/Quest/8512_11_B.dds",
      texturePathClear = "Icon/Quest/8512_11_B_Gray.dds",
      startGroupNo = 8512,
      startQuestNo = 19,
      clearQuestGroupNo = 8512,
      clearQuestNo = 25,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_13_11] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_DIALOG_1"),
      texturePath = "Icon/Quest/8513_11_A.dds",
      texturePathClear = "Icon/Quest/8513_11_A_Gray.dds",
      startGroupNo = 8513,
      startQuestNo = 12,
      clearQuestGroupNo = 8513,
      clearQuestNo = 17,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_13_11_DIALOG_2"),
      texturePath = "Icon/Quest/8513_11_B.dds",
      texturePathClear = "Icon/Quest/8513_11_B_Gray.dds",
      startGroupNo = 8513,
      startQuestNo = 18,
      clearQuestGroupNo = 8513,
      clearQuestNo = 22,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_06_19] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_DIALOG_1"),
      texturePath = "Icon/Quest/8506_19_A.dds",
      texturePathClear = "Icon/Quest/8506_19_A_Gray.dds",
      startGroupNo = 8506,
      startQuestNo = 20,
      clearQuestGroupNo = 8506,
      clearQuestNo = 24,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_06_19_DIALOG_2"),
      texturePath = "Icon/Quest/8506_19_B.dds",
      texturePathClear = "Icon/Quest/8506_19_B_Gray.dds",
      startGroupNo = 8506,
      startQuestNo = 25,
      clearQuestGroupNo = 8506,
      clearQuestNo = 29,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_04_20] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_DIALOG_1"),
      texturePath = "Icon/Quest/8504_20_A.dds",
      texturePathClear = "Icon/Quest/8504_20_A_Gray.dds",
      startGroupNo = 8504,
      startQuestNo = 21,
      clearQuestGroupNo = 8504,
      clearQuestNo = 24,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_04_20_DIALOG_2"),
      texturePath = "Icon/Quest/8504_20_B.dds",
      texturePathClear = "Icon/Quest/8504_20_B_Gray.dds",
      startGroupNo = 8504,
      startQuestNo = 25,
      clearQuestGroupNo = 8504,
      clearQuestNo = 30,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_GabDol_01] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol_DIALOG_1"),
      texturePath = "Icon/Quest/questbranch_MorningSub_Smile.dds",
      texturePathClear = "Icon/Quest/questbranch_MorningSub_Smile_Clear.dds",
      startGroupNo = 8809,
      startQuestNo = 5,
      clearQuestGroupNo = 8809,
      clearQuestNo = 7,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_Morning_Gabdol_DIALOG_2"),
      texturePath = "Icon/Quest/questbranch_MorningSub_Catch.dds",
      texturePathClear = "Icon/Quest/questbranch_MorningSub_Catch_Clear.dds",
      startGroupNo = 8809,
      startQuestNo = 8,
      clearQuestGroupNo = 8809,
      clearQuestNo = 9,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.RoseWar] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar_DIALOG_1"),
      texturePath = "Icon/Quest/Questbranch_RoseWar_Kama.dds",
      texturePathClear = "Icon/Quest/Questbranch_RoseWar_Kama_Gray.dds",
      startGroupNo = 21606,
      startQuestNo = 1,
      clearQuestGroupNo = 21606,
      clearQuestNo = 8,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_RoseWar_DIALOG_2"),
      texturePath = "Icon/Quest/Questbranch_RoseWar_Odyl.dds",
      texturePathClear = "Icon/Quest/Questbranch_RoseWar_Odyl_Gray.dds",
      startGroupNo = 21607,
      startQuestNo = 1,
      clearQuestGroupNo = 21607,
      clearQuestNo = 8,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = false
  },
  [_questType.blackStar_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3408,
      startQuestNo = 32,
      clearQuestGroupNo = 3408,
      clearQuestNo = 32,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3417,
      startQuestNo = 6,
      clearQuestGroupNo = 3417,
      clearQuestNo = 5,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarArmor_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3505,
      startQuestNo = 33,
      clearQuestGroupNo = 3505,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3505,
      startQuestNo = 34,
      clearQuestGroupNo = 3505,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarAwaken_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3517,
      startQuestNo = 33,
      clearQuestGroupNo = 3517,
      clearQuestNo = 18,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIPAWA_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3517,
      startQuestNo = 34,
      clearQuestGroupNo = 3517,
      clearQuestNo = 18,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarBoots_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3433,
      startQuestNo = 33,
      clearQuestGroupNo = 3433,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3433,
      startQuestNo = 34,
      clearQuestGroupNo = 3433,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarHelm_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3508,
      startQuestNo = 33,
      clearQuestGroupNo = 3508,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3508,
      startQuestNo = 34,
      clearQuestGroupNo = 3508,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarGlove_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3514,
      startQuestNo = 33,
      clearQuestGroupNo = 3514,
      clearQuestNo = 12,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3514,
      startQuestNo = 34,
      clearQuestGroupNo = 3514,
      clearQuestNo = 12,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.blackStarSubHand_improve] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_3408_9.dds",
      texturePathClear = "Icon/Quest/questBranch_3408_9_clear.dds",
      startGroupNo = 3441,
      startQuestNo = 33,
      clearQuestGroupNo = 3441,
      clearQuestNo = 21,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_BLACKSTAREQUIP_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_3417_1.dds",
      texturePathClear = "Icon/Quest/questBranch_3417_1_clear.dds",
      startGroupNo = 3441,
      startQuestNo = 34,
      clearQuestGroupNo = 3441,
      clearQuestNo = 21,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.storyReboot_SerenCalph_NorthCamp] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_1"),
      texturePath = "Icon/Quest/questBreanch_Serendia1_1.dds",
      texturePathClear = "Icon/Quest/questBreanch_Serendia1_1_Gray.dds",
      startGroupNo = 21131,
      startQuestNo = 1,
      clearQuestGroupNo = 21131,
      clearQuestNo = 2,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_2"),
      texturePath = "Icon/Quest/questBreanch_Serendia1_2.dds",
      texturePathClear = "Icon/Quest/questBreanch_Serendia1_2_Gray.dds",
      startGroupNo = 21132,
      startQuestNo = 1,
      clearQuestGroupNo = 21132,
      clearQuestNo = 2,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.storyReboot_SerenCalph_Fogan] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_3"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_3"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_3"),
      texturePath = "Icon/Quest/questBreanch_Serendia2_1.dds",
      texturePathClear = "Icon/Quest/questBreanch_Serendia2_1_Gray.dds",
      startGroupNo = 21133,
      startQuestNo = 1,
      clearQuestGroupNo = 21133,
      clearQuestNo = 5,
      spanSizeX = -330,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_4"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_4"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_4"),
      texturePath = "Icon/Quest/questBreanch_Serendia2_2.dds",
      texturePathClear = "Icon/Quest/questBreanch_Serendia2_2_Gray.dds",
      startGroupNo = 21134,
      startQuestNo = 1,
      clearQuestGroupNo = 21134,
      clearQuestNo = 4,
      spanSizeX = 0,
      branchcleared = false
    },
    [2] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_4C"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_4C"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_4C"),
      texturePath = "Icon/Quest/questBreanch_Serendia2_3.dds",
      texturePathClear = "Icon/Quest/questBreanch_Serendia2_3_Gray.dds",
      startGroupNo = 21141,
      startQuestNo = 1,
      clearQuestGroupNo = 21141,
      clearQuestNo = 5,
      spanSizeX = 330,
      branchcleared = false
    },
    ["_branchCount"] = 3,
    ["_contentConsole"] = true
  },
  [_questType.storyReboot_SerenCalph_Harpy] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_5"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_5"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_5"),
      texturePath = "Icon/Quest/questBreanch_Calpheon1_1.dds",
      texturePathClear = "Icon/Quest/questBreanch_Calpheon1_1_Gray.dds",
      startGroupNo = 21137,
      startQuestNo = 1,
      clearQuestGroupNo = 21137,
      clearQuestNo = 3,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_6"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_6"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_6"),
      texturePath = "Icon/Quest/questBreanch_Calpheon1_2.dds",
      texturePathClear = "Icon/Quest/questBreanch_Calpheon1_2_Gray.dds",
      startGroupNo = 21138,
      startQuestNo = 1,
      clearQuestGroupNo = 21138,
      clearQuestNo = 3,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.storyReboot_SerenCalph_Troll] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_7"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_7"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_7"),
      texturePath = "Icon/Quest/questBreanch_Calpheon2_1.dds",
      texturePathClear = "Icon/Quest/questBreanch_Calpheon2_1_Gray.dds",
      startGroupNo = 21142,
      startQuestNo = 1,
      clearQuestGroupNo = 21142,
      clearQuestNo = 1,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_8"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DESC_8"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_SERCAL_DIALOG_8"),
      texturePath = "Icon/Quest/questBreanch_Calpheon2_2.dds",
      texturePathClear = "Icon/Quest/questBreanch_Calpheon2_2_Gray.dds",
      startGroupNo = 21142,
      startQuestNo = 5,
      clearQuestGroupNo = 21142,
      clearQuestNo = 5,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Media_After] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_mediaAfter_A.dds",
      texturePathClear = "Icon/Quest/questBranch_mediaAfter_A_clear.dds",
      startGroupNo = 21145,
      startQuestNo = 1,
      clearQuestGroupNo = 21145,
      clearQuestNo = 1,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MEDIA_AFTER_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_mediaAfter_B.dds",
      texturePathClear = "Icon/Quest/questBranch_mediaAfter_B_clear.dds",
      startGroupNo = 21145,
      startQuestNo = 2,
      clearQuestGroupNo = 21145,
      clearQuestNo = 2,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8532_23] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8532_23_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8532_23_A_clear.dds",
      startGroupNo = 8532,
      startQuestNo = 24,
      clearQuestGroupNo = 8532,
      clearQuestNo = 30,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8532_23_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8532_23_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8532_23_B_clear.dds",
      startGroupNo = 8532,
      startQuestNo = 27,
      clearQuestGroupNo = 8532,
      clearQuestNo = 30,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8534_18] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8534_18_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8534_18_A_clear.dds",
      startGroupNo = 8534,
      startQuestNo = 19,
      clearQuestGroupNo = 8534,
      clearQuestNo = 22,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8534_18_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8534_18_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8534_18_B_clear.dds",
      startGroupNo = 8534,
      startQuestNo = 23,
      clearQuestGroupNo = 8534,
      clearQuestNo = 26,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8536_18] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8536_18_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8536_18_A_clear.dds",
      startGroupNo = 8536,
      startQuestNo = 19,
      clearQuestGroupNo = 8536,
      clearQuestNo = 23,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8536_18_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8536_18_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8536_18_B_clear.dds",
      startGroupNo = 8536,
      startQuestNo = 24,
      clearQuestGroupNo = 8536,
      clearQuestNo = 28,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8533_26] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8533_26_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8533_26_A_clear.dds",
      startGroupNo = 8533,
      startQuestNo = 27,
      clearQuestGroupNo = 8533,
      clearQuestNo = 33,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8533_26_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8533_26_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8533_26_B_clear.dds",
      startGroupNo = 8533,
      startQuestNo = 34,
      clearQuestGroupNo = 8533,
      clearQuestNo = 37,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8529_15] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8529_15_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8529_15_A_clear.dds",
      startGroupNo = 8529,
      startQuestNo = 16,
      clearQuestGroupNo = 8529,
      clearQuestNo = 22,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8529_15_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8529_15_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8529_15_B_clear.dds",
      startGroupNo = 8529,
      startQuestNo = 23,
      clearQuestGroupNo = 8529,
      clearQuestNo = 25,
      clearQuestNo = 9,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8531_27] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8531_27_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8531_27_A_clear.dds",
      startGroupNo = 8531,
      startQuestNo = 28,
      clearQuestGroupNo = 8531,
      clearQuestNo = 31,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8531_27_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8531_27_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8531_27_B_clear.dds",
      startGroupNo = 8531,
      startQuestNo = 32,
      clearQuestGroupNo = 8531,
      clearQuestNo = 35,
      clearQuestNo = 9,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8530_20] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8530_20_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8530_20_A_clear.dds",
      startGroupNo = 8530,
      startQuestNo = 21,
      clearQuestGroupNo = 8530,
      clearQuestNo = 26,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8530_20_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8530_20_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8530_20_B_clear.dds",
      startGroupNo = 8530,
      startQuestNo = 27,
      clearQuestGroupNo = 8530,
      clearQuestNo = 31,
      clearQuestNo = 9,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  },
  [_questType.Morning_8535_22] = {
    [0] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_1"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_DESC_1"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_DIALOG_1"),
      texturePath = "Icon/Quest/questBranch_8535_22_A.dds",
      texturePathClear = "Icon/Quest/questBranch_8535_22_A_clear.dds",
      startGroupNo = 8535,
      startQuestNo = 23,
      clearQuestGroupNo = 8535,
      clearQuestNo = 30,
      spanSizeX = -175,
      branchcleared = false
    },
    [1] = {
      questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_2"),
      bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_DESC_2"),
      bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_8535_22_DIALOG_2"),
      texturePath = "Icon/Quest/questBranch_8535_22_B.dds",
      texturePathClear = "Icon/Quest/questBranch_8535_22_B_clear.dds",
      startGroupNo = 8535,
      startQuestNo = 31,
      clearQuestGroupNo = 8535,
      clearQuestNo = 39,
      clearQuestNo = 9,
      spanSizeX = 175,
      branchcleared = false
    },
    ["_branchCount"] = 2,
    ["_contentConsole"] = true
  }
}
local questBranch = {
  _ui = {
    _stc_BranchMiddleGroup = UI.getChildControl(Panel_Window_QuestBranch, "Static_QuestBranchMiddleGroup"),
    _stc_BranchBottomGroup = UI.getChildControl(Panel_Window_QuestBranch, "Static_QuestBranchBottomGroup"),
    _stc_BranchTitle = UI.getChildControl(Panel_Window_QuestBranch, "Static_BranchDeco"),
    _radiobtn = {},
    _radioImg = {},
    _radioTxt = {},
    _radioCount = {},
    _radioBubble = {}
  },
  _selectedQuestBranch = nil,
  _selectedQuestType = 0,
  _originalPanelSizeY = 700,
  _originalPanelPosY = 150,
  _questTypeCount = 0,
  _questTypeIndexTable = {},
  _currentBranchCount = nil,
  _currentBranchIndex = 0,
  _maxRadioCount = 3,
  _savePanelSizeY = Panel_Window_QuestBranch:GetSizeY()
}
function questBranch:init()
  if true == _ContentsOption_CH_BranchQuest then
    questData[_questType.calpheon] = nil
    questData[_questType.calpheon] = {
      [0] = {
        questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_2"),
        bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DESC_2"),
        bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DIALOG_2"),
        texturePath = "Icon/Quest/questBranch_21201_1.dds",
        texturePathClear = "Icon/Quest/questBranch_21201_1_clear.dds",
        startGroupNo = 21201,
        startQuestNo = 1,
        clearQuestGroupNo = 21100,
        clearQuestNo = 5,
        clearQuestGroupNo_2 = 21101,
        clearQuestNo_2 = 4,
        spanSizeX = -175,
        branchcleared = false
      },
      [1] = {
        questTitle = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_3"),
        bottomDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DESC_3"),
        bottomDialog = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_CALPHEON_DIALOG_3"),
        texturePath = "Icon/Quest/questBranch_21301_1.dds",
        texturePathClear = "Icon/Quest/questBranch_21301_1_clear.dds",
        startGroupNo = 21301,
        startQuestNo = 1,
        clearQuestGroupNo = 21101,
        clearQuestNo = 8,
        clearQuestGroupNo_2 = nil,
        clearQuestNo_2 = nil,
        spanSizeX = 175,
        branchcleared = false
      },
      ["_branchCount"] = 2,
      ["_completeQuestGroupNo"] = 21108,
      ["_completeQuestNo"] = 1,
      ["_contentConsole"] = true
    }
  end
  local count = 0
  for k, v in pairs(questData) do
    if false == isGameServiceTypeConsole() then
      questBranch._questTypeIndexTable[count] = k
      count = count + 1
    elseif true == questData[k]._contentConsole then
      questBranch._questTypeIndexTable[count] = k
      count = count + 1
    end
  end
  questBranch._questTypeCount = count
  self._ui._txt_bottomDesc = UI.getChildControl(self._ui._stc_BranchMiddleGroup, "StaticText_BranchBottomDesc")
  self._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._frame_dialog = UI.getChildControl(self._ui._stc_BranchMiddleGroup, "Frame_Desc")
  self._ui._frame_1_content = UI.getChildControl(self._ui._frame_dialog, "Frame_1_Content")
  self._ui._frame_scroll = UI.getChildControl(self._ui._frame_dialog, "Frame_1_VerticalScroll")
  self._ui._frame_ctrlButton = UI.getChildControl(self._ui._frame_scroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui._stc_ctrlButton_Console = UI.getChildControl(self._ui._frame_ctrlButton, "Static_CtrlButton_Console")
  self._ui._txt_bottomDialog = UI.getChildControl(self._ui._frame_1_content, "StaticText_BranchBottomDialog")
  self._ui._txt_bottomDialog:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_bottomDialog:SetAutoResize(true)
  self._ui._btn_cancel = UI.getChildControl(self._ui._stc_BranchBottomGroup, "Button_Cancel")
  self._ui._btn_selectBranch = UI.getChildControl(self._ui._stc_BranchBottomGroup, "Button_SelectBranch")
  self._ui._stc_keyGuide_selectBranch = UI.getChildControl(self._ui._stc_BranchBottomGroup, "StaticText_SelectBranch")
  self._ui._stc_keyGuide_leftShoulder = UI.getChildControl(self._ui._stc_BranchBottomGroup, "Static_LB")
  self._ui._stc_keyGuide_rightShoulder = UI.getChildControl(self._ui._stc_BranchBottomGroup, "Static_RB")
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._stc_keyGuide_selectBranch:SetShow(false)
    self._ui._stc_keyGuide_leftShoulder:SetShow(false)
    self._ui._stc_keyGuide_rightShoulder:SetShow(false)
    self._ui._frame_ctrlButton:SetShow(true)
  else
    self._ui._btn_cancel:SetShow(false)
    self._ui._btn_selectBranch:SetShow(false)
    self._ui._stc_keyGuide_selectBranch:SetShow(true)
    self._ui._stc_keyGuide_leftShoulder:SetShow(true)
    self._ui._stc_keyGuide_rightShoulder:SetShow(true)
    self._currentBranchIndex = 0
    self._ui._frame_ctrlButton:SetShow(true)
    self._ui._frame_ctrlButton:ReleaseTexture()
    self._ui._frame_ctrlButton:ChangeTextureInfoNameAsync("")
    self._ui._stc_ctrlButton_Console:SetShow(true)
  end
  self._ui._radio = UI.getChildControl(self._ui._stc_BranchMiddleGroup, "Radiobutton_Branch_Templete")
  self._ui._radio:SetShow(false)
  self._selectedTab = nil
  self._prevSelectedTab = 0
  self._isPlayEffect = {}
  for index = 0, self._maxRadioCount do
    self._ui._radiobtn[index] = UI.cloneControl(self._ui._radio, self._ui._stc_BranchMiddleGroup, "QuestBranch_Radio_" .. index)
    self._ui._radioImg[index] = UI.getChildControl(self._ui._radiobtn[index], "Static_Branch_Img_Templete")
    self._ui._radioTxt[index] = UI.getChildControl(self._ui._radiobtn[index], "StaticText_Branch_Title_Templete")
    self._ui._radioCount[index] = UI.getChildControl(self._ui._radiobtn[index], "StaticText_Number_Icon")
    self._ui._radioBubble[index] = UI.getChildControl(self._ui._radiobtn[index], "StaticText_SimpleBranch_Desc")
    self._ui._radioTxt[index]:SetTextMode(__eTextMode_AutoWrap)
    self._ui._radiobtn[index]:SetShow(false)
    self._ui._radioBubble[index]:SetShow(false)
    self._isPlayEffect[index] = false
  end
  self._ui._txt_bottomDesc:SetPosY(self._ui._radiobtn[0]:GetPosY() + self._ui._radiobtn[0]:GetSizeY() + 10)
  self._ui._frame_dialog:SetPosY(self._ui._txt_bottomDesc:GetPosY() + self._ui._txt_bottomDesc:GetSizeY() + 10)
  self:checkQuestBranch()
  self:resizePanel()
  self:registEventHandler()
end
function questBranch:registEventHandler()
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_questBranch_Close()")
    self._ui._btn_selectBranch:addInputEvent("Mouse_LUp", "InputMLUp_questBranch_ApplyBtn()")
    for index = 0, self._maxRadioCount do
      self._ui._radiobtn[index]:addInputEvent("Mouse_LUp", "InputMLUp_questBranch_SelectedBtn(" .. index .. ")")
      self._ui._radiobtn[index]:addInputEvent("Mouse_LDClick", "InputMLDClick_questBranch_SelectAndApply(" .. index .. ")")
      self._ui._radioCount[index]:addInputEvent("Mouse_On", "HandleEventOnOut_QuestBranch_ShowCountTooltip(true," .. index .. ")")
      self._ui._radioCount[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_QuestBranch_ShowCountTooltip(false)")
    end
  else
    Panel_Window_QuestBranch:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_QuestBranch_PadControl(true)")
    Panel_Window_QuestBranch:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_QuestBranch_PadControl(false)")
    Panel_Window_QuestBranch:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLUp_questBranch_ApplyBtn()")
    Panel_Window_QuestBranch:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEventUp_QuestBranch_MoveScroll(true)")
    Panel_Window_QuestBranch:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEventUp_QuestBranch_MoveScroll(false)")
  end
  registerEvent("FromClient_UpdateQuestList", "PaGlobal_questBranch_IsQuestBranch")
  registerEvent("onScreenResize", "PaGlobal_questBranch_ResizePanel")
  registerEvent("FromClient_FindedLeafQuest", "PaGlobal_FromClient_FindedLeafQuest")
  registerEvent("FromClient_EndSequenceTutorial", "FromClient_RouteBranch_EndSequenceTutorial")
end
function questBranch:open()
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    return
  end
  self._currentBranchCount = questData[self._selectedQuestType]._branchCount
  self:resizePanel()
  self:settingControl()
  self:OpenShowAni()
  if true == _ContentsGroup_UsePadSnapping then
    close_WindowPanelList()
    InputMLUp_questBranch_SelectedBtn(0)
    self._ui._frame_scroll:SetControlTop()
    self._ui._frame_dialog:UpdateContentScroll()
    self._ui._frame_dialog:UpdateContentPos()
  end
  _panel:SetShow(true)
end
function questBranch:close()
  _panel:SetShow(false)
end
function questBranch:resizePanel()
  local screenX, screenY
  screenX = getScreenSizeX()
  screenY = getScreenSizeY()
  local consoleGabY = 0
  if true == _ContentsGroup_UsePadSnapping then
    consoleGabY = 20
  end
  if screenY <= self._originalPanelSizeY + 20 then
    _panel:SetPosY(30 - consoleGabY)
    _panel:SetSize(screenX, self._savePanelSizeY + consoleGabY)
  elseif screenY <= self._originalPanelSizeY + 170 then
    _panel:SetPosY(self._originalPanelPosY * 0.2 - consoleGabY)
    _panel:SetSize(screenX, self._savePanelSizeY + consoleGabY)
  else
    _panel:SetPosY(150 - consoleGabY)
    _panel:SetSize(screenX, self._savePanelSizeY + consoleGabY)
  end
  for index = 0, self._maxRadioCount do
    self._ui._radiobtn[index]:ComputePos()
  end
  self._ui._txt_bottomDesc:ComputePos()
  self._ui._txt_bottomDialog:ComputePos()
  self._ui._btn_cancel:ComputePos()
  self._ui._btn_selectBranch:ComputePos()
  self._ui._stc_BranchTitle:ComputePos()
  self._ui._stc_BranchMiddleGroup:ComputePos()
  self._ui._stc_BranchBottomGroup:ComputePos()
  _panel:ComputePos()
end
function questBranch:checkQuestBranch()
  for typeindex = 0, self._questTypeCount - 1 do
    local questType = questBranch._questTypeIndexTable[typeindex]
    if nil == questType then
      UI.ASSERT_NAME(false, "questType\236\157\180 \237\133\140\236\157\180\235\184\148\236\151\144 \236\151\134\236\156\188\235\169\180 \236\149\136 \235\144\156\235\139\164.", "\236\154\176\236\160\149\235\172\180")
      return
    end
    if nil == isClearedQuestList[questType] or nil == questData[questType] then
      return
    end
    local groupNo = isClearedQuestList[questType].questGroupNo
    local questNo = isClearedQuestList[questType].questNo
    local isOpen = true
    if true == questList_isClearQuest(groupNo, questNo) and true == questBranch:checkAdditionalCondition(questType) then
      for branchindex = 0, questData[questType]._branchCount - 1 do
        questBranch:checkRebootStroySerendiaCalpheon(questType)
        local acceptGroupNo = questData[questType][branchindex].startGroupNo
        local acceptQuestNo = questData[questType][branchindex].startQuestNo
        if false == questList_isAcceptableQuest(acceptGroupNo, acceptQuestNo) then
          isOpen = false
          break
        end
      end
      if true == isOpen then
        if false == _ContentsGroup_UsePadSnapping then
          self._ui._btn_selectBranch:SetSpanSize(0, self._ui._btn_selectBranch:GetSpanSize().y)
          self._ui._btn_cancel:SetShow(false)
        end
        self._selectedQuestType = questType
        self._currentBranchIndex = 0
        if _questType.seasonQuick == questType and _questType.rebalenos_seasonQuick == questType then
          PaGlobalFunc_DialogMain_All_Close(nil, nil, nil, true)
        end
        if true == _panel:GetShow() then
          self._currentBranchCount = questData[self._selectedQuestType]._branchCount
          self:resizePanel()
          self:settingControl()
          if true == _ContentsGroup_UsePadSnapping then
            close_WindowPanelList()
            InputMLUp_questBranch_SelectedBtn(0)
            self._ui._frame_scroll:SetControlTop()
            self._ui._frame_dialog:UpdateContentScroll()
            self._ui._frame_dialog:UpdateContentPos()
          end
          break
        end
        self:open()
        break
      elseif _ContentsGroup_ProjectAbyssOne == true then
        local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
        if currentMapKey == ToClient_GetAbyssOneBaseMapKey() then
          PaGlobal_questBranch_Close()
        end
      end
    end
  end
end
function questBranch:settingControl()
  for index = 0, self._currentBranchCount - 1 do
    self._ui._radiobtn[index]:SetShow(true)
    self._ui._radioBubble[index]:SetShow(false)
    self._ui._radioImg[index]:ChangeTextureInfoNameAsync(questData[self._selectedQuestType][index].texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._radioImg[index], 0, 0, 280, 380)
    self._ui._radioImg[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._radioImg[index]:setRenderTexture(self._ui._radioImg[index]:getBaseTexture())
    if nil ~= self._ui._radioCount[index] then
      self._ui._radioCount[index]:SetShow(false)
      if true == _ContentsGroup_BranchQuestCountCheck then
        local groupNo = questData[self._selectedQuestType][index].startGroupNo
        local questNo = questData[self._selectedQuestType][index].startQuestNo
        if nil ~= groupNo and nil ~= questNo then
          local clearAndProgressCount = ToClient_GetBranchQuestProgressAndClearedCount(groupNo, questNo)
          if clearAndProgressCount > 0 then
            self._ui._radioCount[index]:SetText(tostring(clearAndProgressCount))
            self._ui._radioCount[index]:SetShow(true)
          end
        end
      end
    end
    self._ui._radioTxt[index]:SetText(questData[self._selectedQuestType][index].questTitle)
    local SpanX = questData[self._selectedQuestType][index].spanSizeX
    local SpanY = self._ui._radiobtn[index]:GetSpanSize().y
    self._ui._radiobtn[index]:SetSpanSize(SpanX, SpanY)
    if self._selectedQuestType == _questType.rebalenos_seasonQuick and index == 1 then
      self._ui._radioBubble[index]:SetShow(false)
    end
  end
  self._ui._frame_scroll:SetShow(false)
end
function questBranch:resetRadiobutton()
  if nil == self._currentBranchCount then
    return
  end
  for index = 0, self._currentBranchCount - 1 do
    self._ui._radiobtn[index]:SetCheck(false)
    self._ui._radiobtn[index]:SetShow(false)
    self._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTBRANCH_SELECTBRANCH"))
    self._ui._txt_bottomDialog:SetText("")
    if true == questBranch._isPlayEffect[index] then
      questBranch._ui._radioImg[index]:EraseAllEffect()
    end
  end
end
function questBranch:checkClearQuest()
  for branchindex = 0, questData[self._selectedQuestType]._branchCount - 1 do
    local groupNo = questData[self._selectedQuestType][branchindex].clearQuestGroupNo
    local questNo = questData[self._selectedQuestType][branchindex].clearQuestNo
    if true == questList_isClearQuest(groupNo, questNo) then
      local groupNo_second = questData[self._selectedQuestType][branchindex].clearQuestGroupNo_2
      local questNo_second = questData[self._selectedQuestType][branchindex].clearQuestNo_2
      if nil ~= groupNo_second and nil ~= questNo_second and true == questList_isClearQuest(groupNo_second, questNo_second) then
        questData[self._selectedQuestType][branchindex].branchcleared = true
        self._ui._radiobtn[branchindex]:SetIgnore(true)
      end
    end
  end
end
function questBranch:checkLeafQuestCleared()
  local isBtnShow
  for typeindex = 0, self._questTypeCount - 1 do
    local questType = questBranch._questTypeIndexTable[typeindex]
    if nil == questType then
      UI.ASSERT_NAME(false, "questType\236\157\180 \237\133\140\236\157\180\235\184\148\236\151\144 \236\151\134\236\156\188\235\169\180 \236\149\136 \235\144\156\235\139\164.", "\236\154\176\236\160\149\235\172\180")
      return
    end
    if nil == questData[questType] then
      return
    end
    isBtnShow = true
    local groupNo = questData[questType]._completeQuestGroupNo
    local questNo = questData[questType]._completeQuestNo
    if true == questList_isClearQuest(groupNo, questNo) then
      for branchindex = 0, questData[questType]._branchCount - 1 do
        local startGroupNo = questData[questType][branchindex].startGroupNo
        local startQuestNo = questData[questType][branchindex].startQuestNo
        local completeGroupNo = questData[questType][branchindex].clearQuestGroupNo
        local completeQuestNo = questData[questType][branchindex].clearQuestNo
        local isAcceptable = questList_isAcceptableQuest(startGroupNo, startQuestNo)
        local isComplete = questList_isClearQuest(completeGroupNo, completeQuestNo)
        if false == isAcceptable and false == isComplete and false == questData[questType][branchindex].branchcleared then
          isBtnShow = false
        end
      end
    else
      isBtnShow = false
    end
  end
  return isBtnShow
end
function questBranch:checkLeafQuestClearedOpen()
  for typeindex = 0, self._questTypeCount - 1 do
    local questType = questBranch._questTypeIndexTable[typeindex]
    if nil == questType then
      UI.ASSERT_NAME(false, "questType\236\157\180 \237\133\140\236\157\180\235\184\148\236\151\144 \236\151\134\236\156\188\235\169\180 \236\149\136 \235\144\156\235\139\164.", "\236\154\176\236\160\149\235\172\180")
      return
    end
    if nil == questData[questType] then
      return
    end
    local groupNo = questData[questType]._completeQuestGroupNo
    local questNo = questData[questType]._completeQuestNo
    if true == questList_isClearQuest(groupNo, questNo) then
      if false == _ContentsGroup_UsePadSnapping then
        self._ui._btn_selectBranch:SetSpanSize(-70, self._ui._btn_selectBranch:GetSpanSize().y)
        self._ui._btn_cancel:SetShow(true)
      end
      self._selectedQuestType = questType
      self:open()
    end
  end
end
function InputMLUp_questBranch_SelectedBtn(index)
  local self = questBranch
  if nil == self then
    return
  end
  self._prevSelectedTab = self._selectedTab
  self._selectedTab = index
  PaGlobal_questBranch_ShowEffect()
  self._ui._txt_bottomDesc:SetText(questData[self._selectedQuestType][index].bottomDesc)
  self._ui._txt_bottomDialog:SetText(questData[self._selectedQuestType][index].bottomDialog)
  if self._ui._frame_dialog:GetSizeY() < self._ui._txt_bottomDialog:GetTextSizeY() then
    self._ui._frame_scroll:SetShow(true)
  else
    self._ui._frame_scroll:SetShow(false)
  end
  self._ui._frame_1_content:SetSize(self._ui._frame_dialog:GetSizeX(), self._ui._txt_bottomDialog:GetTextSizeY())
  self._ui._txt_bottomDesc:SetPosY(self._ui._radiobtn[0]:GetPosY() + self._ui._radiobtn[0]:GetSizeY() + 10)
  self._ui._frame_dialog:SetPosY(self._ui._txt_bottomDesc:GetPosY() + self._ui._txt_bottomDesc:GetTextSizeY() + 10)
  self._ui._frame_scroll:SetControlTop()
  self._ui._frame_dialog:UpdateContentScroll()
  self._ui._frame_dialog:UpdateContentPos()
  if true == _ContentsGroup_UsePadSnapping then
    local control = self._ui._radioCount[index]
    if nil ~= control and true == control:GetShow() then
      local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_NUMBER_NOTION", "count", control:GetText())
      local desc = ""
      local pos = {
        x = control:GetParentPosX() + control:GetSizeX(),
        y = control:GetParentPosY()
      }
      TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
      local tooltipSizeX = Panel_Tooltip_SimpleText:GetSizeX()
      if getScreenSizeX() < pos.x + tooltipSizeX then
        TooltipSimple_Common_Pos(control:GetParentPosX() - tooltipSizeX, Panel_Tooltip_SimpleText:GetPosY())
      end
    else
      TooltipSimple_Hide()
    end
  end
end
function InputMLDClick_questBranch_SelectAndApply(index)
  InputMLUp_questBranch_SelectedBtn(index)
  InputMLUp_questBranch_ApplyBtn()
end
function PaGlobal_questBranch_ShowEffect()
  if true == questBranch._isPlayEffect[questBranch._prevSelectedTab] then
    questBranch._ui._radioImg[questBranch._prevSelectedTab]:EraseAllEffect()
    questBranch._isPlayEffect[questBranch._prevSelectedTab] = false
  end
  questBranch._ui._radioImg[questBranch._selectedTab]:AddEffect("fUI_MainQuestChoice_01A", true, 0, 0)
  questBranch._isPlayEffect[questBranch._selectedTab] = true
end
function InputMLUp_questBranch_ApplyBtn()
  local self = questBranch
  if nil == self then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    return
  end
  if nil == self._selectedTab then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_ACK"))
  else
    if true == _ContentsGroup_UsePadSnapping then
      _AudioPostEvent_SystemUiForXBOX(0, 1)
    end
    PaGlobal_questBranch_MessageBox()
  end
end
function PaGlobalFunc_QuestBranch_PadControl(isLeft)
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    return
  end
  local self = questBranch
  local prevBranchIndex = self._currentBranchIndex
  if true == isLeft then
    self._currentBranchIndex = prevBranchIndex - 1
    if self._currentBranchIndex < 0 then
      self._currentBranchIndex = 0
    end
  else
    self._currentBranchIndex = prevBranchIndex + 1
    if self._currentBranchCount <= self._currentBranchIndex then
      self._currentBranchIndex = self._currentBranchCount - 1
    end
  end
  _AudioPostEvent_SystemUiForXBOX(0, 0)
  InputMLUp_questBranch_SelectedBtn(self._currentBranchIndex)
end
function HandleRSticEventUp_QuestBranch_MoveScroll(isUp)
  if nil == Panel_Window_QuestBranch or false == Panel_Window_QuestBranch:GetShow() then
    return
  end
  if nil == questBranch._ui._frame_scroll then
    return
  end
  if true == isUp then
    questBranch._ui._frame_scroll:ControlButtonUp()
  elseif false == isUp then
    questBranch._ui._frame_scroll:ControlButtonDown()
  end
  questBranch._ui._frame_dialog:UpdateContentPos()
  questBranch._ui._frame_dialog:UpdateContentScroll()
end
function HandleEventOnOut_QuestBranch_ShowCountTooltip(isShow, index)
  if false == isShow or nil == index then
    TooltipSimple_Hide()
    return
  end
  local control = questBranch._ui._radioCount[index]
  if nil == control then
    return
  end
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_NUMBER_NOTION", "count", control:GetText())
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_FromClient_FindedLeafQuest(groupNo, questNo)
  local self = questBranch
  if nil == self then
    return
  end
end
function PaGlobal_questBranch_ResizePanel()
  local self = questBranch
  if nil == self then
    return
  end
  self:resizePanel()
end
function PaGlobal_questBranch_MessageBox()
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MESSAGEBOX_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTBRANCH_MESSAGEBOX_TITLE"),
    content = messageContent,
    functionYes = PaGlobal_questBranch_SetQuestBranch,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_questBranch_IsLeafCleared()
  local self = questBranch
  if nil == self then
    return
  end
  return false
end
function PaGlobal_questBranch_IsQuestBranch()
  local self = questBranch
  if nil == self then
    return
  end
  self:checkQuestBranch()
end
function PaGlobal_questBranch_SetQuestBranch()
  local self = questBranch
  if nil == self then
    return
  end
  local groupNo = questData[self._selectedQuestType][self._selectedTab].startGroupNo
  local questNo = questData[self._selectedQuestType][self._selectedTab].startQuestNo
  ToClient_AcceptQuest(groupNo, questNo)
  PaGlobal_questBranch_Close()
end
function questBranch:OpenShowAni()
  local aniInfo1 = _panel:addScaleAnimation(0.3, 0.45, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.1)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = _panel:GetSizeX() / 2
  aniInfo1.AxisY = _panel:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = _panel:addScaleAnimation(0.45, 0.6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = _panel:GetSizeX() / 2
  aniInfo2.AxisY = _panel:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  local aniInfo3 = _panel:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo8 = _panel:addColorAnimation(0.3, 0.33, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo8:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(3)
  aniInfo8:SetEndIntensity(1)
  aniInfo8.IsChangeChild = true
end
function questBranch:CloseHideAni()
  local aniInfo1 = _panel:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_questBranch_Open(index)
  local self = questBranch
  if nil == self then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_selectBranch:SetSpanSize(-70, self._ui._btn_selectBranch:GetSpanSize().y)
    self._ui._btn_cancel:SetShow(true)
  end
  self._selectedQuestType = index
  self:open()
end
function PaGlobal_questBranch_Close()
  local self = questBranch
  if nil == self then
    return
  end
  TooltipSimple_Hide()
  self._isClickedBranchButton = false
  self._selectedTab = nil
  self:resetRadiobutton()
  self:CloseHideAni()
  self:close()
end
function PaGlobal_questBranch_Init()
  local self = questBranch
  if nil == self then
    return
  end
  self:init()
end
function questBranch:checkRebootStroySerendiaCalpheon(questType)
  if questType == nil then
    return
  end
  if _ContentsGroup_RebootStroySerendiaCalpheon == true then
    return
  end
  if _questType.rebalenos_completeQuick_1 == questType or _questType.rebalenos_completeQuick_2 == questType then
    questData[questType][0].startGroupNo = 21125
    questData[questType][0].startQuestNo = 111
    questData[questType][0].clearQuestGroupNo = 21125
    questData[questType][0].clearQuestNo = 96
  end
end
function questBranch:checkAdditionalCondition(questType)
  if nil ~= questType and nil ~= getSelfPlayer() then
    if _questType.seasonQuick == questType or _questType.rebalenos_seasonQuick == questType then
      if true == questList_isClearQuest(40022, 2) or true == ToClient_isProgressingQuest(40022, 2) then
        return false
      end
    elseif (_questType.rebalenos_completeQuick_1 == questType or _questType.rebalenos_completeQuick_2 == questType) and (true == questList_isClearQuest(40022, 1) or true == ToClient_isProgressingQuest(40022, 1)) then
      return false
    end
  end
  return true
end
function questBranch:additionalFunctionByType()
  if nil == self._selectedQuestType then
    return
  end
  if _questType.seasonQuick == self._selectedQuestType then
  end
end
function FromClient_RouteBranch_EndSequenceTutorial()
  if false == _ContentsGroup_NewSequenceTutorial then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local characterLevel = selfPlayer:get():getLevel()
  if characterLevel > 1 then
    return
  end
  if _ContentsGroup_SelectStartPosition == true then
    PaGlobalFunc_StartBranch_All_TutorialCompleteOpen()
    return
  end
  if PaGlobal_GameoptionTutorial_All_RevertGraphic ~= nil then
    PaGlobal_GameoptionTutorial_All_RevertGraphic()
  end
  ToClient_NewSequenceEndTutorialTeleport(__eQuestTutorialBranch_0)
end
registerEvent("FromClient_luaLoadCompleteLateUdpate", "PaGlobal_questBranch_Init")
