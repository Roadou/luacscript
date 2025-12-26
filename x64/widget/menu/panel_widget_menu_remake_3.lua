function PaGlobal_Menu_Remake:SetSubmenuHotKeyInfo()
  local _menuHotKeyTemp = {}
  _menuHotKeyTemp = {
    [1] = {
      subMenu = {}
    },
    [2] = {
      subMenu = {
        [1] = {
          func = PaGlobalFunc_NewsBanner_Open,
          isContentOpen = not isGameTypeGT(),
          index = 103
        },
        [2] = {
          func = FGlobal_Panel_WebHelper_ShowToggle,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and not _ContentsGroup_RenewUI,
          index = 1
        },
        [3] = {
          func = Panel_ProductNote_ShowToggle,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and _ContentsGroup_ProductNote,
          index = 2
        },
        [4] = {
          func = FGlobal_KeyboardHelpShow,
          isContentOpen = not _ContentsGroup_RenewUI,
          index = 58
        },
        [5] = {
          func = PaGlobalFunc_Menu_All_LifeRanker_Open,
          isContentOpen = true,
          index = 46
        },
        [6] = {
          func = GuildRank_Web_Show,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 47
        },
        [7] = {
          func = FGlobal_MonsterRanking_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMonsterRanking and not _ContentsGroup_RenewUI,
          index = 48
        },
        [8] = {
          func = PaGlobal_VolunteerRankWeb_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBattleFieldVolunteer,
          index = 49
        },
        [9] = {
          func = PaGlobal_AltarRankWeb_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAltarRankOpen and not _ContentsGroup_RenewUI and false,
          index = 84
        },
        [10] = {
          func = PaGlobalFunc_Menu_All_Copyright_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isCopyright,
          index = 29
        },
        [11] = {
          func = PaGlobalFunc_KeyGuidWindow_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 30
        },
        [12] = {
          func = PaGlobalFunc_menu_All_termsofuse_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 98
        },
        [13] = {
          func = PaGlobalFunc_Menu_All_EURA_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 99
        },
        [14] = {
          func = PaGlobalFunc_menu_All_PrivacyPolicy_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 100
        },
        [15] = {
          func = HandleEventLUp_MenuRemake_SolrareRankingOpen,
          isContentOpen = _ContentsGroup_Solare,
          index = 124
        },
        [16] = {
          func = PaGlobalFunc_MorningBossRank_Open,
          isContentOpen = _ContentsGroup_MorningLand,
          index = 134
        },
        [17] = {
          func = ToClient_RequestLoadGuildMatchRankInfo,
          isContentOpen = _ContentsGroup_GuildMatch,
          index = 143
        }
      }
    },
    [3] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_Myinfo,
          isContentOpen = true,
          index = 7
        },
        [2] = {
          func = HandleEventLUp_MenuRemake_Skill,
          isContentOpen = true,
          index = 9
        },
        [3] = {
          func = HandleEventLUp_MenuRemake_Inventory,
          isContentOpen = true,
          index = 8
        },
        [4] = {
          func = HandleEventLUp_MenuRemake_MentalKnowledge,
          isContentOpen = true,
          index = 24
        },
        [5] = {
          func = Panel_GameExit_ClickSelectCharacter,
          isContentOpen = isGameTypeNA() or isGameServiceTypeDev(),
          index = 12
        },
        [6] = {
          func = HandleEventLUp_MenuRemake_Beauty,
          isContentOpen = CppEnums.ContentsServiceType.eContentsServiceType_Commercial == getContentsServiceType() and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 63
        },
        [7] = {
          func = HandleEventLUp_MenuRemake_Dyeing,
          isContentOpen = true,
          index = 64
        },
        [8] = {
          func = PaGlobalFunc_Menu_All_ColorMix_Open,
          isContentOpen = not _ContentsGroup_RenewUI,
          index = 67
        },
        [9] = {
          func = HandleEventLUp_MenuRemake_Escape,
          isContentOpen = nil,
          index = 76
        },
        [10] = {
          func = PaGlobalFunc_CharacterTag_All_Open,
          isContentOpen = _ContentsGroup_CharacterTag,
          index = 90
        },
        [11] = {
          func = PaGlobalFunc_Menu_All_BlackSpiritSkillLock_Open,
          isContentOpen = _ContentsGroup_UsePadSnapping and _ContentsGroup_NewUI_BlackSpiritSkillLock_All,
          index = 104
        },
        [12] = {
          func = PaGlobalFunc_AppliedBuffList_Console_Open,
          isContentOpen = _ContentsGroup_UsePadSnapping,
          index = 111
        },
        [13] = {
          func = PaGlobalFunc_Artifacts_All_Open,
          isContentOpen = _ContentsGroup_ArtifactItem,
          index = 122
        },
        [14] = {
          func = PaGlobalFunc_JewelPreset_Open,
          isContentOpen = nil,
          index = 140
        },
        [15] = {
          func = PaGlobal_ReforgeStonePreset_Open,
          isContentOpen = _ContentsGroup_ReforgeStonePreset,
          index = 157
        }
      }
    },
    [4] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_Present,
          isContentOpen = true,
          index = 26,
          isUpdate = _ContentsGroup_RenewUI
        },
        [2] = {
          func = PaGlobalFunc_Menu_All_TotalReward_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isTotalReward,
          index = 27
        },
        [3] = {
          func = PaGlobalFunc_Menu_All_DailyStamp_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._joinCheckOpen,
          isConditionOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and PaGlobal_Menu_Remake._conditionGroup._isDailyStampOpen,
          index = 31,
          isUpdate = _ContentsGroup_RenewUI
        },
        [4] = {
          func = FGlobal_BlackSpiritAdventure_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBlackSpiritAdventure and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 28
        },
        [5] = {
          func = HandleEventUp_MenuRemake_Mail,
          isContentOpen = true,
          index = 73
        },
        [6] = {
          func = FGlobal_EventMarbleGame_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isEventMarbleGame,
          index = 117
        },
        [7] = {
          func = PaGlobal_Event_SpecialPass_Open,
          isContentOpen = PaGlobal_GetCurrentSpecialPass ~= nil and PaGlobal_GetCurrentSpecialPass() ~= nil,
          index = 130
        },
        [8] = {
          func = HandleEventLUp_Event_TicketShop_Refresh,
          isContentOpen = _ContentsGroup_drawEvent,
          index = 141
        },
        [9] = {
          func = PaGlobalFunc_ExchangeCoin_All_Open,
          isContentOpen = _ContentsGroup_ExchangeCoinSystem,
          index = 145
        },
        [10] = {
          func = PaGlobalFunc_EventGuide_Total_Open,
          isContentOpen = _ContentsGroup_EventGuidePage,
          index = 152
        },
        [11] = {
          func = PaGlobalFunc_SnowBoardMenu_Open,
          isContentOpen = _ContentsGroup_SnowBoardMirrorField,
          index = 158
        }
      }
    },
    [5] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_CashShop,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isPearlOpen,
          index = 14
        },
        [2] = {
          func = HandleEventLUp_MenuRemake_Market,
          isContentOpen = not _ContentsGroup_RenewUI_ItemMarketPlace_Only,
          index = 15
        },
        [3] = {
          func = PaGlobalFunc_Menu_All_MarketPlace_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMarketPlaceOpen,
          index = 68
        },
        [4] = {
          func = PaGlobalFunc_Menu_All_Masterpiece_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMasterpieceOpen,
          index = 18
        }
      }
    },
    [6] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_BlackSpirit,
          isContentOpen = true,
          index = 22
        },
        [2] = {
          func = PaGlobalFunc_Menu_All_Achievement_All_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAchievementBookshelfOpen,
          index = 16
        },
        [3] = {
          func = HandleEventLUp_MenuRemake_WorldMap,
          isContentOpen = true,
          index = 20
        },
        [4] = {
          func = PaGlobalFunc_Menu_All_DropItem_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isDropItemOpen,
          index = 3
        },
        [5] = {
          func = HandleEventLUp_MenuRemake_QuestHistory,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isQuestOpen,
          isContentOpen = true,
          index = 23
        },
        [6] = {
          func = HandleEventLUp_MenuRemake_FarmingList,
          isContentOpen = _ContentsGroup_FarmingList,
          index = 38
        },
        [7] = {
          func = HandleEventLUp_PersonalMonster_All_Open,
          isContentOpen = _ContentsGroup_NodeBoss,
          index = 25
        },
        [8] = {
          func = PaGlobalFunc_MansionRank_All_Open,
          isContentOpen = _ContentsGroup_MansionContent,
          index = 114
        },
        [9] = {
          func = PaGlobalFunc_Menu_All_HopeGauge_Open,
          isContentOpen = _ContentsGroup_HopeGauge,
          index = 116
        },
        [10] = {
          func = HandleEventLUp_MenuRemake_GrowthPass,
          isContentOpen = true == PaGlobal_Menu_Remake._contentsGroup._isGrowthPassOpen and false == ToClient_isPremiumCharacter(),
          index = 119
        },
        [11] = {
          func = PaGlobal_PersonalField_Main_All_Open,
          isContentOpen = _ContentsGroup_PersonalField,
          index = 125
        },
        [12] = {
          func = PaGlobal_Widget_HadumField_Enter_All_Open,
          isContentOpen = _ContentsGroup_HadumField,
          index = 129
        },
        [13] = {
          func = PaGlobal_MorningLand_Boss_All_Open,
          isContentOpen = _ContentsGroup_MorningLand,
          index = 132
        },
        [14] = {
          func = PaGlobal_Journal_Select_All_Open,
          isContentOpen = true,
          index = 135
        },
        [15] = {
          func = PaGlobalFunc_MonsterBuffZoneItemRepair_OpenByMenu,
          isContentOpen = _ContentsGroup_MonsterBuffZone,
          index = 139
        },
        [16] = {
          func = PaGlobal_LandscapePainting_Open,
          isContentOpen = _ContentsGroup_LandscapePainting,
          index = 153
        }
      }
    },
    [7] = {
      subMenu = {
        [1] = {
          func = PaGlobalFunc_Menu_All_FishEncyclopedia_Open,
          isContentOpen = _ContentsGroup_FishingEncyclopedia,
          index = 5
        },
        [2] = {
          func = nil,
          isContentOpen = false,
          index = 6
        },
        [3] = {
          func = HandleEventLUp_MenuRemake_Manufacture,
          isContentOpen = true,
          index = 34
        },
        [4] = {
          func = PaGlobalFunc_Menu_All_WorkerManager_Open,
          isContentOpen = true,
          index = 35
        },
        [5] = {
          func = FGlobal_HousingList_Open,
          isContentOpen = true,
          index = 36
        },
        [6] = {
          func = PaGlobalFunc_menu_All_HarvestList_Open,
          isContentOpen = true,
          index = 37
        },
        [7] = {
          func = PaGlobalFunc_Menu_All_AlchemyStone_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAlchemyStoneEnble,
          index = 79
        },
        [8] = {
          func = PaGlobal_AlchemyFigureHead_All_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAlchemyFigureHeadEnble,
          index = 80
        },
        [9] = {
          func = HandlerEventLUp_SailorManager_All_OpenByESCMenu,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isSailerOpen,
          isContentOpen = PaGlobal_Menu_Remake._isOceanCurrentOpen,
          index = 85
        },
        [10] = {
          func = PaGlobal_BarterInfoSearch_Open,
          isContentOpen = PaGlobal_Menu_Remake._isOceanCurrentOpen,
          index = 86
        },
        [11] = {
          func = FromClient_HorseRacingEnter_Open,
          isContentOpen = _ContentsGroup_InstanceHorseRacing,
          index = 110
        },
        [12] = {
          func = PaGlobal_Window_TradeWareHouse_All_OpenInMenu,
          isContentOpen = false,
          index = 133
        },
        [13] = {
          func = PaGlobal_WorldMap_StableList_Open,
          isContentOpen = _ContentsGroup_TotalStableList,
          index = 136
        },
        [14] = {
          func = PaGlobalFunc_ServantMarket_All_OpenByMenu,
          isContentOpen = _ContentsGroup_TotalStableList,
          index = 137
        },
        [15] = {
          func = PaGlobal_LifeRingMenu_All_Open,
          isContentOpen = _ContentsGroup_UsePadSnapping,
          index = 149
        },
        [16] = {
          func = PaGlobal_PalaceManagement_Map_Open,
          isContentOpen = _ContentsGroup_PalaceManagement,
          index = 150
        },
        [17] = {
          func = PaGlobalFunc_ServantSimulator_Open_ESCMenu,
          isContentOpen = _ContentsGroup_HorseSimulator,
          index = 151
        }
      }
    },
    [8] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_Localwar,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isLocalwarOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isLocalwarOpen,
          index = 39
        },
        [2] = {
          func = HandleEventLUp_MenuRemake_FreeFight,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isFreeFight,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isFreeFight,
          index = 21
        },
        [3] = {
          func = HandleEventLUp_MenuRemake_Personalbattle,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isTeamDuelOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isTeamDuelOpen,
          index = 41
        },
        [4] = {
          func = nil,
          isContentOpen = false,
          index = 42
        },
        [5] = {
          func = HandleEventLUp_MenuRemake_Competitiongame,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isContentsArsha,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isContentsArsha,
          index = 43
        },
        [6] = {
          func = HandleEventLUp_MenuRemake_Siege,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isSiegeEnable,
          index = 44
        },
        [7] = {
          func = HandleEventLUp_MenuRemake_InfinityDefence,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isInfinityDefence,
          index = 83
        },
        [8] = {
          func = HandleEventLUp_MenuRemake_ArshaApplyWeb,
          isContentOpen = _ContentsGroup_Arsha_ApplyWeb,
          index = 92
        },
        [9] = {
          func = HandleEventLUp_MenuRemake_OthilitaDungeon,
          isContentOpen = _ContentsGroup_OthilitaDungeon,
          index = 94
        },
        [10] = {
          func = HandleEventLUp_MenuRemake_ImmortalHell,
          isContentOpen = _ContentsGroup_isOepnImmortalHell or _ContentsGroup_isOpenImmortalHellForConsole,
          index = 95
        },
        [11] = {
          func = nil,
          isContentOpen = false,
          index = 113
        },
        [12] = {
          func = HandleEventLUp_MenuRemake_SolrareMatchingOpen,
          isContentOpen = _ContentsGroup_Solare,
          index = 123
        },
        [13] = {
          func = PaGlobalFunc_RoseWarMenu_Open,
          isContentOpen = _ContentsGroup_RoseWar,
          index = 138
        },
        [14] = {
          func = PaGlobalFunc_GuildMatch_OpenByMenu,
          isContentOpen = _ContentsGroup_GuildMatch,
          index = 142
        },
        [15] = {
          func = PaGlobalFunc_RoseWarTeamScoreBoard_Open,
          isContentOpen = _ContentsGroup_RoseWar,
          index = 144
        },
        [16] = {
          func = PaGlobalFunc_VillageSiegeMenu_Open,
          isContentOpen = true,
          index = 146
        },
        [17] = {
          func = PaGlobal_Edania_Contents_OpenByESC,
          isContentOpen = true,
          index = 159
        }
      }
    },
    [9] = {
      subMenu = {
        [1] = {
          func = PaGlobalFunc_Menu_All_NpcFind_Open,
          isContentOpen = true,
          index = 97
        },
        [2] = {
          func = PaGlobalFunc_Menu_All_Memo_Main_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMemoOpen and not _ContentsGroup_RenewUI,
          index = 55
        },
        [3] = {
          func = PaGlobalFunc_Menu_All_PetList_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isPetOpen,
          isContentOpen = true,
          index = 10
        },
        [4] = {
          func = HandleEventLUp_MenuRemake_Fairy,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isFairyOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isFairyOpen,
          index = 11
        },
        [5] = {
          func = PaGlobalFunc_Menu_All_MaidList_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isMaidOpen,
          isContentOpen = true == _ContentsGroup_Maid,
          index = 17
        },
        [6] = {
          func = HandleEventLUp_MenuRemake_Camp,
          isContentOpen = _ContentsGroup_isCamp,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isCampOpen,
          index = 81
        },
        [7] = {
          func = PaGlobalFunc_menu_All_siegeWarCall,
          isContentOpen = _ContentsGroup_RenewUI and PaGlobal_Menu_Remake._conditionGroup._isSiegeWarCall,
          index = 105
        },
        [8] = {
          func = PaGlobalFunc_menu_All_busterCall,
          isContentOpen = _ContentsGroup_RenewUI and PaGlobal_Menu_Remake._conditionGroup._isBusterCall,
          index = 106
        },
        [9] = {
          func = PaGlobal_menu_All_summonPartyCall,
          isContentOpen = _ContentsGroup_RenewUI and PaGlobal_Menu_Remake._conditionGroup._isSummonPartyCall,
          index = 107
        },
        [10] = {
          func = PaGlobalFunc_menu_All_returnTown,
          isContentOpen = _ContentsGroup_RenewUI and PaGlobal_Menu_Remake._conditionGroup._isReturnTown,
          index = 108
        },
        [11] = {
          func = PaGlobalFunc_menu_All_siegeWarReturnCall,
          isContentOpen = _ContentsGroup_RenewUI and PaGlobal_Menu_Remake._conditionGroup._isSiegeWarReturnCall,
          index = 109
        },
        [12] = {
          func = HandleEventLUp_MenuRemake_TotalSearchOpen,
          isContentOpen = true,
          index = 127
        },
        [13] = {
          func = HandleEventLUp_MenuRemake_ExitRelayMirrorField,
          isContentOpen = ToClient_isConsole() or ToClient_IsDevelopment(),
          index = 153
        },
        [14] = {
          func = PaGlobal_TotalPreset_Open,
          isContentOpen = _ContentsGroup_TotalPreset,
          index = 154
        },
        [15] = {
          func = PaGlobalFunc_Menu_All_BossAlert_Setting_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isBossAlert,
          isContentOpen = _ContetnsGroup_BossAlert,
          index = 156
        },
        [16] = {
          func = PaGlobal_RadioPlayerOpen,
          isContentOpen = _ContentsGroup_RadioPlayer,
          index = 155
        }
      }
    },
    [10] = {
      subMenu = {
        [1] = {
          func = PaGlobalFunc_Menu_All_Guild_Open,
          isContentOpen = true,
          index = 51
        },
        [2] = {
          func = function()
            GlobalKeyBinder_MouseKeyMap(__eUiInputType_FriendList)
          end,
          isContentOpen = true,
          index = 52
        },
        [3] = {
          func = PaGlobalFunc_Menu_All_PartyList_Show,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._partyListOpen,
          index = 53
        },
        [4] = {
          func = FGlobal_SocialAction_ShowToggle,
          isContentOpen = not _ContentsGroup_RenewUI,
          index = 13
        },
        [5] = {
          func = HandleEventLUp_MenuRemake_BeautyAlbum,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._webAlbumOpen and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 65
        },
        [6] = {
          func = FGlobal_ChattingFilterList_Open,
          isContentOpen = not _ContentsGroup_RenewUI,
          index = 54
        },
        [7] = {
          func = function()
            PaGlobal_Twitch:ShowWindow()
          end,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and false == _ContentsGroup_RenewUI and not _ContentsOption_CH_GameType,
          index = 56
        },
        [8] = {
          func = PaGlobal_Steam_Redemption,
          isContentOpen = _ContentsGroup_SteamOpen and isGameTypeASIA() == false,
          index = 32
        },
        [9] = {
          func = PaGlobal_ExpirienceWiki_Open,
          isContentOpen = _ContentsGroup_ExpirienceWiki,
          index = 77
        },
        [10] = {
          func = PaGlobal_Homepage_Open,
          isContentOpen = false == isGameTypeJapan() and not _ContentsGroup_RenewUI,
          index = 72
        },
        [11] = {
          func = ScreenshotAlbum_Open,
          isContentOpen = ToClient_IsContentsGroupOpen("213"),
          index = 19
        },
        [12] = {
          func = PaGlobal_MusicBoard_All_Open,
          isContentOpen = _ContentsGroup_InstrumentPerformance,
          index = 78
        },
        [13] = {
          func = PaGlobalFunc_ChannelChat_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isChannelChatOpen,
          index = 87
        },
        [14] = {
          func = PaGlobal_ExpirienceWiki_All_Open,
          isContentOpen = _ContentsGroup_ExpirienceWiki_All and _ContentsGroup_ExpirienceWiki_KorVersion,
          index = 88
        },
        [15] = {
          func = PaGlobalFunc_Menu_All_partySetting_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 101
        },
        [16] = {
          func = PaGlobalFunc_Menu_All_platoonSetting_Open,
          isContentOpen = _ContentsGroup_RenewUI and _ContentsGroup_LargeParty,
          index = 102
        },
        [17] = {
          func = PaGlobalFunc_menu_All_GMQuizCall,
          isContentOpen = _ContentsGroup_RenewUI and _ContentsGroup_QuizEvent and PaGlobal_Menu_Remake._conditionGroup._isGMQuizCall,
          index = 115
        },
        [18] = {
          func = HandleEventLUp_MenuRemake_YachtPvP,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isYachtPVPMode,
          index = 120
        }
      }
    },
    [11] = {
      subMenu = {
        [1] = {
          func = showGameOption,
          isContentOpen = true,
          index = 57
        },
        [2] = {
          func = FGlobal_UiSet_Open,
          isContentOpen = true,
          index = 59
        },
        [3] = {
          func = PaGlobalFunc_Menu_All_ButtonShorcurs_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isButtonShortCut and false == _ContentsGroup_UsePadSnapping,
          index = 60
        },
        [4] = {
          func = FGlobal_GameOptionOpen,
          isContentOpen = isGameTypeNA() or isGameServiceTypeDev(),
          index = 61
        },
        [5] = {
          func = PaGlobal_Panel_SaveSetting_Show,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 62
        },
        [6] = {
          func = PaGlobalFunc_Menu_All_GameExit_Open,
          isContentOpen = nil,
          index = 74
        },
        [7] = {
          func = PaGlobalFunc_Menu_All_ServerSelect_Open,
          isContentOpen = nil,
          index = 75
        },
        [8] = {
          func = PaGlobalFunc_Menu_All_RingMenuSetting_Open,
          isContentOpen = _ContentsGroup_UsePadSnapping,
          index = 82
        },
        [9] = {
          func = ToClient_OptimizeMemoryForConsole,
          isContentOpen = ToClient_isTotalGameClient(),
          index = 121
        }
      }
    },
    [12] = {
      subMenu = {
        [1] = {
          func = HandleEventLUp_MenuRemake_Notice,
          isContentOpen = isGameTypeNA() and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 40
        },
        [2] = {
          func = HandleEventLUp_MenuRemake_Update,
          isContentOpen = (isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameTypeASIA() or isGameServiceTypeDev() or isGameTypeRussia() or isGameTypeSA() or isGameTypeASIA() or _ContentsOption_CH_GameType) and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 69
        },
        [3] = {
          func = HandleEventLUp_MenuRemake_KnownIssue,
          isContentOpen = (isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeASIA() or isGameTypeID() or isGameTypeRussia() or isGameTypeTR() or isGameTypeSA() or isGameTypeASIA() or _ContentsOption_CH_GameType) and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 71
        },
        [4] = {
          func = HandleEventLUp_MenuRemake_BlackDesertLab,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBlackDesertLab and not _ContentsGroup_RenewUI,
          index = 96
        },
        [5] = {
          func = PaGlobalFunc_menu_All_Report_Open,
          isContentOpen = _ContentsGroup_NegativeUserReport or _ContentsGroup_isPS4UI,
          index = 50
        },
        [6] = {
          func = PaGlobalFunc_Restore_All_Open,
          isContentOpen = ToClient_IsContentsGroupOpen("579"),
          index = 45
        },
        [7] = {
          func = HandleEventLUp_Mail_All_QNA,
          isContentOpen = not _ContentsGroup_RenewUI,
          index = 33
        },
        [8] = {
          func = PaGlobalFunc_CouponCode_Open,
          isContentOpen = _ContentsGroup_CouponCode,
          index = 93
        },
        [9] = {
          func = PaGlobal_URL_OpenCreditPointCsCenter,
          isContentOpen = _ContentsOption_CH_GameType == true or isGameServiceTypeDev() == true,
          index = 147
        }
      }
    }
  }
  local MenuSize = ToClient_RequestEscMenuSize()
  for ii = 1, MenuSize do
    local MenuSS = ToClient_RequestEscMenuFromIndex(ii)
    if nil ~= MenuSS then
      _menuHotKeyTemp[ii].hotKey = PaGlobal_Menu_Remake:getKeyCodeFromKeyName(MenuSS:getHotKey())
      _menuHotKeyTemp[ii].title = PAGetString(MenuSS:getTitleSheetName(), MenuSS:getTitle())
      _menuHotKeyTemp[ii].ddsUrl = MenuSS:getUrl()
      _menuHotKeyTemp[ii].ddsGrid = {
        x1 = MenuSS._ddsGridx1,
        y1 = MenuSS._ddsGridy1,
        x2 = MenuSS._ddsGridx2,
        y2 = MenuSS._ddsGridy2
      }
      _menuHotKeyTemp[ii].isContentOpen = nil
      for jj = 1, MenuSS._subMenuSize do
        local SubMenuSS = ToClient_RequestEscSubMenuFromIndex(ii, jj - 1)
        if _menuHotKeyTemp[ii].subMenu[jj] ~= nil then
          if nil ~= SubMenuSS then
            _menuHotKeyTemp[ii].subMenu[jj].title = PaGlobal_Menu_Remake:getSubText(SubMenuSS)
            _menuHotKeyTemp[ii].subMenu[jj].ddsUrl = SubMenuSS:getUrl()
            _menuHotKeyTemp[ii].subMenu[jj].ddsGrid = {
              x1 = SubMenuSS._ddsGridx1,
              y1 = SubMenuSS._ddsGridy1,
              x2 = SubMenuSS._ddsGridx2,
              y2 = SubMenuSS._ddsGridy2
            }
            _menuHotKeyTemp[ii].subMenu[jj].tag = SubMenuSS:getTagType()
            _menuHotKeyTemp[ii].subMenu[jj].isShowtag = ToClient_RequestEscSubMenuIsShowTagFromIndex(ii, jj - 1)
          else
            _menuHotKeyTemp[ii].subMenu[jj].title = ""
            _menuHotKeyTemp[ii].subMenu[jj].ddsUrl = ""
            _menuHotKeyTemp[ii].subMenu[jj].ddsGrid = {
              x1 = 0,
              y1 = 0,
              x2 = 0,
              y2 = 0
            }
            _menuHotKeyTemp[ii].subMenu[jj].tag = __eSubMenuTagType_None
            _menuHotKeyTemp[ii].subMenu[jj].isShowtag = false
          end
        end
      end
    else
      _menuHotKeyTemp[ii].hotKey = PaGlobal_Menu_Remake:getKeyCodeFromKeyName("")
      _menuHotKeyTemp[ii].title = ""
      _menuHotKeyTemp[ii].ddsUrl = ""
      _menuHotKeyTemp[ii].ddsGrid = {
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0
      }
    end
  end
  PaGlobal_Menu_Remake._menuHotKey = {}
  for i = 1, #_menuHotKeyTemp do
    PaGlobal_Menu_Remake._menuHotKey[i] = {}
    PaGlobal_Menu_Remake._menuHotKey[i].hotKey = _menuHotKeyTemp[i].hotKey
    PaGlobal_Menu_Remake._menuHotKey[i].title = _menuHotKeyTemp[i].title
    PaGlobal_Menu_Remake._menuHotKey[i].subMenu = {}
    PaGlobal_Menu_Remake._menuHotKey[i].ddsUrl = _menuHotKeyTemp[i].ddsUrl
    PaGlobal_Menu_Remake._menuHotKey[i].ddsGrid = _menuHotKeyTemp[i].ddsGrid
    PaGlobal_Menu_Remake._menuHotKey[i].isContentOpen = _menuHotKeyTemp[i].isContentOpen
    PaGlobal_Menu_Remake._menuHotKey[i].isNew = false
    PaGlobal_Menu_Remake._menuHotKey[i].isHot = false
    PaGlobal_Menu_Remake._menuHotKey[i].isEvent = false
    PaGlobal_Menu_Remake._menuHotKey[i].isUpdate = false
    local subViewCnt = 0
    local subIndex = 1
    for k, v in ipairs(_menuHotKeyTemp[i].subMenu) do
      if (nil == v.isContentOpen or true == v.isContentOpen) and nil ~= v.func then
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex] = {}
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].title = v.title
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].func = v.func
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isContentOpen = v.isContentOpen
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isConditionOpen = v.isConditionOpen
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].index = v.index
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].ddsUrl = v.ddsUrl
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].ddsGrid = v.ddsGrid
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isNew = false
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isHot = false
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isEvent = false
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isUpdate = false
        if true == v.isShowtag then
          if v.tag == __eSubMenuTagType_New then
            if isGameTypeRussia() == true and (v.index == 123 or v.index == 124) then
            else
              PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isNew = true
              PaGlobal_Menu_Remake._menuHotKey[i].isNew = true
            end
          elseif v.tag == __eSubMenuTagType_Hot then
            PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isHot = true
            PaGlobal_Menu_Remake._menuHotKey[i].isHot = true
          elseif v.tag == __eSubMenuTagType_Event then
            PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isEvent = true
            PaGlobal_Menu_Remake._menuHotKey[i].isEvent = true
          elseif v.tag == __eSubMenuTagType_Update then
            PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isUpdate = true
            PaGlobal_Menu_Remake._menuHotKey[i].isUpdate = true
          end
        elseif nil ~= v.isUpdate and true == v.isUpdate then
          PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isUpdate = true
          PaGlobal_Menu_Remake._menuHotKey[i].isUpdate = true
        end
        if v.isContentOpen then
          subViewCnt = subViewCnt + 1
        end
        subIndex = subIndex + 1
      end
    end
    if 0 == subViewCnt and i ~= 1 then
      PaGlobal_Menu_Remake._menuHotKey[i].isContentOpen = false
    end
  end
end
function PaGlobal_Menu_Remake:setMenuGrid(isMode)
  if true == isMode then
    PaGlobal_Menu_Remake._headerGrid = {
      normal = {
        x1 = 370,
        y1 = 42,
        x2 = 410,
        y2 = 82
      },
      on = {
        x1 = 411,
        y1 = 42,
        x2 = 451,
        y2 = 82
      },
      ddsUrl = "Combine/Btn/Combine_Btn_00.dds"
    }
    PaGlobal_Menu_Remake._menuGrid = {
      normal = {
        x1 = 480,
        y1 = 409,
        x2 = 510,
        y2 = 439
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      click = {
        x1 = 480,
        y1 = 471,
        x2 = 510,
        y2 = 501
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
    PaGlobal_Menu_Remake._subMenuGrid = {
      normal = {
        x1 = 460,
        y1 = 154,
        x2 = 490,
        y2 = 184
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
  else
    PaGlobal_Menu_Remake._headerGrid = {
      normal = {
        x1 = 370,
        y1 = 42,
        x2 = 410,
        y2 = 82
      },
      on = {
        x1 = 411,
        y1 = 42,
        x2 = 451,
        y2 = 82
      },
      ddsUrl = "Combine/Btn/Combine_Btn_00.dds"
    }
    PaGlobal_Menu_Remake._menuGrid = {
      normal = {
        x1 = 480,
        y1 = 409,
        x2 = 510,
        y2 = 439
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      click = {
        x1 = 480,
        y1 = 471,
        x2 = 510,
        y2 = 501
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
    PaGlobal_Menu_Remake._subMenuGrid = {
      normal = {
        x1 = 460,
        y1 = 154,
        x2 = 490,
        y2 = 184
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
  end
end
function PaGlobal_Menu_Remake:setMenuOpenWayBtn()
  if 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay) then
    local textureDDS = PaGlobal_Menu_Remake.DEFAULT_MENU_DDS
    PaGlobal_Menu_Remake._ui.btn_openway:ChangeTextureInfoNameAsync(textureDDS)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 57, 43, 78)
    PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Menu_Remake._ui.btn_openway:setRenderTexture(PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 79, 43, 100)
    PaGlobal_Menu_Remake._ui.btn_openway:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 101, 43, 122)
    PaGlobal_Menu_Remake._ui.btn_openway:getClickTexture():setUV(x1, y1, x2, y2)
  else
    local textureDDS = PaGlobal_Menu_Remake.DEFAULT_MENU_DDS
    PaGlobal_Menu_Remake._ui.btn_openway:ChangeTextureInfoNameAsync(textureDDS)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 57, 64, 78)
    PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Menu_Remake._ui.btn_openway:setRenderTexture(PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 79, 64, 100)
    PaGlobal_Menu_Remake._ui.btn_openway:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 101, 64, 122)
    PaGlobal_Menu_Remake._ui.btn_openway:getClickTexture():setUV(x1, y1, x2, y2)
  end
  PaGlobal_Menu_Remake:hideTooltip()
end
function PaGlobal_Menu_Remake:getKeyCodeFromKeyName(strKeyName)
  if strKeyName == "F1" then
    return CppEnums.VirtualKeyCode.KeyCode_F1
  elseif strKeyName == "F2" then
    return CppEnums.VirtualKeyCode.KeyCode_F2
  elseif strKeyName == "F3" then
    return CppEnums.VirtualKeyCode.KeyCode_F3
  elseif strKeyName == "F4" then
    return CppEnums.VirtualKeyCode.KeyCode_F4
  elseif strKeyName == "F5" then
    return CppEnums.VirtualKeyCode.KeyCode_F5
  elseif strKeyName == "F6" then
    return CppEnums.VirtualKeyCode.KeyCode_F6
  elseif strKeyName == "F7" then
    return CppEnums.VirtualKeyCode.KeyCode_F7
  elseif strKeyName == "F8" then
    return CppEnums.VirtualKeyCode.KeyCode_F8
  elseif strKeyName == "F9" then
    return CppEnums.VirtualKeyCode.KeyCode_F9
  elseif strKeyName == "F10" then
    return CppEnums.VirtualKeyCode.KeyCode_F10
  elseif strKeyName == "F11" then
    return CppEnums.VirtualKeyCode.KeyCode_F11
  elseif strKeyName == "F12" then
    return CppEnums.VirtualKeyCode.KeyCode_F12
  else
    return CppEnums.VirtualKeyCode.KeyCode_F1
  end
end
function PaGlobal_Menu_Remake:getSubText(subMenuSSW)
  if subMenuSSW == nil then
    return
  end
  local titleName = subMenuSSW:getTitleName()
  if "LUA_MORNING_QUESTBOARD_TITLE" == titleName then
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return ""
    end
    return PAGetStringParam1(subMenuSSW:getTitleSheetName(), titleName, "charName", selfPlayer:getName())
  end
  return PAGetString(subMenuSSW:getTitleSheetName(), titleName)
end
function PaGlobalFunc_Menu_All_PartyList_Show()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  PaGlobalFunc_PartyList_All_Open()
end
function PaGlobalFunc_Menu_All_MaidList_Open()
  PaGlobalFunc_MaidList_All_Open()
end
function PaGlobalFunc_Menu_All_DailyStamp_Open()
  PaGlobalFunc_DailyStamp_All_Open(true)
end
function PaGlobalFunc_Menu_All_WorkerManager_Open()
  PaGlobalFunc_WorkerManager_All_ShowToggle()
end
function PaGlobalFunc_Menu_All_Guild_Open()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Guild)
end
function PaGlobalFunc_Menu_All_LifeRanker_Open()
  PaGlobal_LifeRanking_Open_All()
end
function PaGlobalFunc_Menu_All_Masterpiece_Open()
  PaGlobal_Masterpiece_Auction_All_ESCOpen()
end
function PaGlobalFunc_Menu_All_BossAlert_Setting_Open()
  PaGlobal_BossAlert_SettingV2_All_Open()
end
function PaGlobalFunc_Menu_All_FishEncyclopedia_Open()
  if _ContentsGroup_FishingEncyclopedia == true then
    PaGlobalFunc_FishEncyclopedia_Renewal_All_Open()
    return
  end
  PaGlobalFunc_FishEncyclopedia_All_Open()
end
function PaGlobalFunc_Menu_All_DropItem_Open()
  PaGlobalFunc_RenewDropItem_Open()
end
function PaGlobalFunc_Menu_All_ButtonShorcurs_Open()
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    PaGlobalFunc_ButtonShorcuts_All_Open()
  else
    FGlobal_ButtonShortcuts_Open()
  end
end
function PaGlobalFunc_Menu_All_GameExit_Open()
  PaGlobal_GameExit_All_ShowToggle(false)
end
function PaGlobalFunc_Menu_All_Memo_Main_Open()
  if false == _ContentsGroup_NewUI_Memo_All then
    PaGlobal_Memo:ListOpen()
  else
    PaGlobalFunc_Memo_Main_All_Open()
  end
end
function PaGlobalFunc_Menu_All_TotalReward_Open()
  PaGlobal_TotalReward_All_Open()
end
function PaGlobalFunc_Menu_All_Achievement_All_Open()
  PaGlobalFunc_Achievement_BookShelf_All_Open()
end
function PaGlobalFunc_Menu_All_AlchemyStone_Open()
  if _ContentsGroup_AlchemyStoneRenewal == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Open()
  else
    PaGlobalFunc_AlchemyStone_All_Open()
  end
end
function PaGlobalFunc_Menu_All_RingMenuSetting_Open()
  FromClient_ConsoleQuickMenu_OpenCustomPage(2)
end
function PaGlobalFunc_Menu_All_MarketPlace_Open()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_MarketPlaceConsole_OpenByMenu()
  elseif _ContentsOption_CH_CreditPoint == true then
    PaGlobalFunc_MarketPlace_CheckCreditPoint(eCreditPointCheckOpenType.openDefault)
  else
    PaGlobalFunc_MarketPlace_Open()
  end
end
function PaGlobalFunc_Menu_All_ServerSelect_Open()
  PaGlobalFunc_ChannelSelect_All_Open()
end
function PaGlobalFunc_Menu_All_PetList_Open()
  PaGlobal_PetList_Toggle_All()
end
function PaGlobalFunc_Menu_All_NpcFind_Open()
  PaGlobal_NpcNavi_All_ShowToggle()
end
function PaGlobalFunc_Menu_All_ColorMix_Open()
  if _ContentsGroup_NewUI_Dye_All then
    PaGlobal_ColorMix_All_Show()
  elseif _ContentsGroup_NewUI_Dye_Palette_All then
    PaGlobal_Dye_Palette_All_Open(false)
  else
    Panel_ColorBalance_Show()
  end
end
function PaGlobalFunc_Menu_All_Othilita_Open()
  if true == _ContentsGroup_OthilitaDungeon then
  end
end
function PaGlobalFunc_menu_All_Report_Open()
  if true == _ContentsGroup_isPS4UI then
    PaGloabl_Report_Open()
  else
    PaGloabl_ReportAll_Open()
  end
end
function PaGlobalFunc_menu_All_HarvestList_Open()
  if true == _ContentsGroup_HarvestList_All then
    PaGlobal_HarvestList_All_Open()
  else
    FGlobal_HarvestList_Open()
  end
end
function PaGlobalFunc_Menu_All_HopeGauge_Open()
  if _ContentsGroup_UsePadSnapping == true then
    PaGlobalFunc_HopeGauge_Console_Open()
  else
    HandleEventLUp_HopeGaugeOnOff_Open()
  end
end
