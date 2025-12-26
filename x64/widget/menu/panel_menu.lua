local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_IT = CppEnums.UiInputType
local IM = CppEnums.EProcessorInputMode
local isLocalwarOpen = ToClient_IsContentsGroupOpen("43")
local isBlackSpiritAdventure = ToClient_IsContentsGroupOpen("1015")
local isBlackSpiritAdventureForPc = ToClient_IsContentsGroupOpen("1021")
local photoGalleryOpen = ToClient_IsContentsGroupOpen("213")
local remoteControlOpen = ToClient_IsContentsGroupOpen("241")
local isTradeEventOpen = ToClient_IsContentsGroupOpen("26")
local joinCheckOpen = ToClient_IsContentsGroupOpen("1025")
local isMonsterRanking = ToClient_IsContentsGroupOpen("275")
local isContentsArsha = _ContentsGroup_Arsha
local partyListOpen = ToClient_IsContentsGroupOpen("254")
local isFreeFight = ToClient_IsContentsGroupOpen("255")
local isBlackSpiritAdventure2 = ToClient_IsContentsGroupOpen("277")
local isMasterPiece = ToClient_IsContentsGroupOpen("270")
local isSiegeEnable = ToClient_IsContentsGroupOpen("21")
local isDropItemOpen = ToClient_IsContentsGroupOpen("337")
local isTeamDuelOpen = ToClient_IsContentsGroupOpen("350")
local isButtonShortCut = ToClient_IsContentsGroupOpen("351")
local isKnownIssue = isGameTypeKorea() or isGameTypeTH() or isGameTypeID() or isGameTypeASIA() or isGameTypeTaiwan()
local isBlackDesertLabOpen = (_ContentsGroup_BlackDesertLab or 0 == getServiceNationType()) and false == isGameTypeNA()
local isBossAlert = _ContetnsGroup_BossAlert
local isTestServer = isGameTypeGT()
local isMarketPlaceOpen = _ContentsGroup_RenewUI_ItemMarketPlace
local isManufacturing = _ContentsGroup_LifeStatManufacturing
local isInfinityDefence = _ContentsGroup_InfinityDefence
local isFarmingListOpen = _ContentsGroup_FarmingList
Panel_Menu:SetShow(false)
local eMenuType = {oldMenu = 1, newMenu = 2}
Panel_Menu:setGlassBackground(true)
Panel_Menu:ActiveMouseEventEffect(true)
Panel_Menu:RegisterShowEventFunc(true, "Panel_Menu_ShowAni()")
Panel_Menu:RegisterShowEventFunc(false, "Panel_Menu_HideAni()")
Panel_Menu:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "ChangeUI_Menu()")
local userConnectionType = 0
local MenuButtonId = {
  btn_HelpGuide = 1,
  btn_KeyboardHelp = 2,
  btn_Productnote = 3,
  btn_CashShop = 4,
  btn_Beauty = 5,
  btn_Dye = 6,
  btn_ColorMix = 7,
  btn_Pet = 8,
  btn_PlayerInfo = 9,
  btn_Inventory = 10,
  btn_BlackSpirit = 11,
  btn_Quest = 12,
  btn_Skill = 13,
  btn_Guild = 14,
  btn_Manufacture = 15,
  btn_FishEncyclopedia = 16,
  btn_Knowledge = 17,
  btn_WorldMap = 18,
  btn_Rescue = 19,
  btn_FriendList = 20,
  btn_Mail = 21,
  btn_Worker = 22,
  btn_Itemmarket = 23,
  btn_MarketPlace = 24,
  btn_TradeEvent = 25,
  btn_UiSetting = 26,
  btn_GuildRanker = 27,
  btn_LifeRanker = 28,
  btn_MonsterRanking = 29,
  btn_Event = 30,
  btn_DailyCheck = 31,
  btn_Notice = 32,
  btn_BlackSpritAdventure = 33,
  btn_BSAdventure2 = 34,
  btn_WebAlbum = 35,
  btn_ScreenShotAlbum = 36,
  btn_Siege = 37,
  btn_LocalWar = 38,
  btn_FreeFight = 39,
  btn_TeamDuel = 40,
  btn_ChattingFilter = 41,
  btn_Language = 42,
  btn_Channel = 43,
  btn_Competition = 44,
  btn_Steam = 45,
  btn_Update = 46,
  btn_PartyList = 47,
  btn_Twitch = 48,
  btn_SocialAction = 49,
  btn_LuxuryAuction = 50,
  btn_Copyright = 51,
  btn_Memo = 52,
  btn_DropItem = 53,
  btn_ShortCut = 54,
  btn_SaveSetting = 55,
  btn_KnownIssue = 56,
  btn_BlackDesertLab = 57,
  btn_BossAlert = 58,
  btn_Reserve_59 = 59,
  btn_CardGame = 60,
  btn_Feedback = 61,
  btn_VolunteerRank = 62,
  btn_AcheivementBookShelf = 63,
  btn_ExperienceWiki = 64,
  btn_InfinityDefence = 65,
  btn_AltarRank = 66,
  btn_SailerManager = 67,
  btn_Bater = 68,
  btn_ChannelChat = 69,
  btn_ArshaApplyWeb = 70,
  btn_Music = 71,
  btn_FarmingList = 72,
  btn_Homepage = 73,
  btn_GameOption = 74,
  btn_GameExit = 75
}
local MenuButtonTextId = {
  [MenuButtonId.btn_HelpGuide] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_HELP"),
  [MenuButtonId.btn_KeyboardHelp] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_KEY"),
  [MenuButtonId.btn_PlayerInfo] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MYINFO"),
  [MenuButtonId.btn_Inventory] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BAG"),
  [MenuButtonId.btn_Skill] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_SKILL"),
  [MenuButtonId.btn_Guild] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_GUILD"),
  [MenuButtonId.btn_WorldMap] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_WORLDMAP"),
  [MenuButtonId.btn_BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BLACKSPIRIT"),
  [MenuButtonId.btn_Quest] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_QUESTHISTORY"),
  [MenuButtonId.btn_Knowledge] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MENTALKNOWLEDGE"),
  [MenuButtonId.btn_Productnote] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_PRODUCTIONNOTE"),
  [MenuButtonId.btn_FriendList] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_FRIENDLIST"),
  [MenuButtonId.btn_Mail] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MAIL"),
  [MenuButtonId.btn_Pet] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_PET"),
  [MenuButtonId.btn_Dye] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_DYE"),
  [MenuButtonId.btn_CashShop] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_CASHSHOP"),
  [MenuButtonId.btn_Beauty] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BEAUTY"),
  [MenuButtonId.btn_GameOption] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_OPTION"),
  [MenuButtonId.btn_Language] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_LANGUAGE"),
  [MenuButtonId.btn_GameExit] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_EXIT"),
  [MenuButtonId.btn_Rescue] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_ESCAPE"),
  [MenuButtonId.btn_UiSetting] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_INTERFACEMOVE"),
  [MenuButtonId.btn_Manufacture] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_MANUFACTURE"),
  [MenuButtonId.btn_FishEncyclopedia] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_FISHENCYCLOPEDIA"),
  [MenuButtonId.btn_ColorMix] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_COLORMIX"),
  [MenuButtonId.btn_Event] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_EVENT"),
  [MenuButtonId.btn_BlackSpritAdventure] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BLACKSPIRIT_TRESURE"),
  [MenuButtonId.btn_GuildRanker] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_GUILDRANKER"),
  [MenuButtonId.btn_LifeRanker] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_LIFERANKER"),
  [MenuButtonId.btn_Siege] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_SIEGE"),
  [MenuButtonId.btn_Worker] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WORKERTITLE"),
  [MenuButtonId.btn_TradeEvent] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_COMMERCE"),
  [MenuButtonId.btn_Channel] = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
  [MenuButtonId.btn_Notice] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_NOTICE"),
  [MenuButtonId.btn_LocalWar] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_INFO"),
  [MenuButtonId.btn_FreeFight] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FREEFIGHT"),
  [MenuButtonId.btn_TeamDuel] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PERSONALBATTLE"),
  [MenuButtonId.btn_Itemmarket] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_ITEMMARKET"),
  [MenuButtonId.btn_ChattingFilter] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_CHATTING_FILTER"),
  [MenuButtonId.btn_WebAlbum] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BEAUTYALBUM"),
  [MenuButtonId.btn_DailyCheck] = PAGetString(Defines.StringSheet_GAME, "LUA_DAILYSTAMP_MSGTITLE"),
  [MenuButtonId.btn_Competition] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_COMPETITIONGAME"),
  [MenuButtonId.btn_ScreenShotAlbum] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SCREENSHOTALBUM_TITLE"),
  [MenuButtonId.btn_PartyList] = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYLIST_TITLE"),
  [MenuButtonId.btn_MonsterRanking] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MONSTERRANKING"),
  [MenuButtonId.btn_Steam] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_EXTRACTIONGAME"),
  [MenuButtonId.btn_Update] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_UPDATE"),
  [MenuButtonId.btn_BSAdventure2] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BLACKSPIRITADVANTURE2"),
  [MenuButtonId.btn_Twitch] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_TWITCH"),
  [MenuButtonId.btn_SocialAction] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_SOCIALACTION"),
  [MenuButtonId.btn_LuxuryAuction] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECEAUCTION_TITLE"),
  [MenuButtonId.btn_Memo] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MEMONAME"),
  [MenuButtonId.btn_DropItem] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_DROPITEM"),
  [MenuButtonId.btn_Copyright] = PAGetString(Defines.StringSheet_GAME, "LUA_COPYRIGHT_TITLE"),
  [MenuButtonId.btn_ShortCut] = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_SUBTITLE"),
  [MenuButtonId.btn_SaveSetting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_SAVESETTING"),
  [MenuButtonId.btn_KnownIssue] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_KNOWNISSUE_STRING"),
  [MenuButtonId.btn_BlackDesertLab] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKDESERTLAB_TITLE"),
  [MenuButtonId.btn_BossAlert] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BOSS_ALERT"),
  [MenuButtonId.btn_CardGame] = "\236\185\180\235\147\156 \234\178\140\236\158\132",
  [MenuButtonId.btn_Feedback] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FEEDBACK"),
  [MenuButtonId.btn_MarketPlace] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_TITLE"),
  [MenuButtonId.btn_Reserve_59] = "",
  [MenuButtonId.btn_VolunteerRank] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_VOLUNTEER_RANK"),
  [MenuButtonId.btn_AcheivementBookShelf] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ACHIEVEMENT_BOOKSHELF_TITLE"),
  [MenuButtonId.btn_ExperienceWiki] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPIRIENCEWIKI_TITLE"),
  [MenuButtonId.btn_InfinityDefence] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BLOODALTAR_TITLE"),
  [MenuButtonId.btn_AltarRank] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALTARRANKWEB_TITLE_FOR_ESCMENU"),
  [MenuButtonId.btn_Homepage] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_HOMEPAGE_TITLE"),
  [MenuButtonId.btn_SailerManager] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_TITLE"),
  [MenuButtonId.btn_Bater] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_TITLE"),
  [MenuButtonId.btn_ChannelChat] = PAGetString(Defines.StringSheet_GAME, "CHATTING_CHANNEL"),
  [MenuButtonId.btn_ArshaApplyWeb] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_ARSHA_APPLYWEB"),
  [MenuButtonId.btn_Music] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_COMPOSITION_NAME"),
  [MenuButtonId.btn_FarmingList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FARMINGTIMER_TITLE")
}
local MenuButtonHotKeyID = {
  [MenuButtonId.btn_HelpGuide] = keyCustom_GetString_UiKey(__eUiInputType_Help),
  [MenuButtonId.btn_KeyboardHelp] = "",
  [MenuButtonId.btn_PlayerInfo] = keyCustom_GetString_UiKey(__eUiInputType_PlayerInfo),
  [MenuButtonId.btn_Inventory] = keyCustom_GetString_UiKey(__eUiInputType_Inventory),
  [MenuButtonId.btn_Skill] = keyCustom_GetString_UiKey(__eUiInputType_Skill),
  [MenuButtonId.btn_Guild] = keyCustom_GetString_UiKey(__eUiInputType_Guild),
  [MenuButtonId.btn_WorldMap] = keyCustom_GetString_UiKey(__eUiInputType_WorldMap),
  [MenuButtonId.btn_BlackSpirit] = keyCustom_GetString_UiKey(__eUiInputType_BlackSpirit),
  [MenuButtonId.btn_Quest] = keyCustom_GetString_UiKey(__eUiInputType_QuestHistory),
  [MenuButtonId.btn_Knowledge] = keyCustom_GetString_UiKey(__eUiInputType_MentalKnowledge),
  [MenuButtonId.btn_Productnote] = keyCustom_GetString_UiKey(__eUiInputType_ProductionNote),
  [MenuButtonId.btn_FriendList] = keyCustom_GetString_UiKey(__eUiInputType_FriendList),
  [MenuButtonId.btn_Mail] = keyCustom_GetString_UiKey(__eUiInputType_Mail),
  [MenuButtonId.btn_Pet] = "",
  [MenuButtonId.btn_Dye] = keyCustom_GetString_UiKey(__eUiInputType_Dyeing),
  [MenuButtonId.btn_CashShop] = keyCustom_GetString_UiKey(__eUiInputType_CashShop),
  [MenuButtonId.btn_Beauty] = "F4",
  [MenuButtonId.btn_GameOption] = "",
  [MenuButtonId.btn_Language] = "",
  [MenuButtonId.btn_GameExit] = "",
  [MenuButtonId.btn_Rescue] = "",
  [MenuButtonId.btn_UiSetting] = "",
  [MenuButtonId.btn_Manufacture] = keyCustom_GetString_UiKey(__eUiInputType_Manufacture),
  [MenuButtonId.btn_FishEncyclopedia] = "",
  [MenuButtonId.btn_ColorMix] = "",
  [MenuButtonId.btn_Event] = "",
  [MenuButtonId.btn_BlackSpritAdventure] = "",
  [MenuButtonId.btn_GuildRanker] = "",
  [MenuButtonId.btn_LifeRanker] = ""
}
local contry = {
  kr = 0,
  jp = 1,
  ru = 2,
  cn = 3,
  tw = 4
}
local cashIconTexture = {
  [0] = {
    94,
    173,
    138,
    217
  },
  {
    232,
    357,
    276,
    401
  },
  {
    94,
    173,
    138,
    217
  },
  {
    278,
    219,
    322,
    263
  },
  {
    278,
    219,
    322,
    263
  }
}
local function cashIcon_changeButtonTexture(control, contry)
  local x1, y1, x2, y2 = setTextureUV_Func(control, cashIconTexture[contry][1], cashIconTexture[contry][2], cashIconTexture[contry][3], cashIconTexture[contry][4])
  return x1, y1, x2, y2
end
local _badges = {
  [MenuButtonId.btn_Quest] = {count = 0, isShow = false},
  [MenuButtonId.btn_BlackSpirit] = {count = 0, isShow = false},
  [MenuButtonId.btn_Skill] = {count = 0, isShow = false},
  [MenuButtonId.btn_Inventory] = {count = 0, isShow = false},
  [MenuButtonId.btn_Knowledge] = {count = 0, isShow = false},
  [MenuButtonId.btn_FriendList] = {count = 0, isShow = false}
}
local btn_Close = UI.getChildControl(Panel_Menu, "Button_Win_Close")
btn_Close:addInputEvent("Mouse_LUp", "Panel_Menu_ShowToggle()")
btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
local _checkedQuestStaticActive = UI.getChildControl(Panel_CheckedQuest, "Static_Active")
local menu_Bg = UI.getChildControl(Panel_Menu, "Static_MenuBG")
local menuIconBg = UI.getChildControl(Panel_Menu, "Static_MenuIconBG")
local menuIcon = UI.getChildControl(Panel_Menu, "StaticText_MenuIcon")
local menuBadge = UI.getChildControl(_checkedQuestStaticActive, "StaticText_Number")
local menuNew = UI.getChildControl(Panel_Menu, "Static_New")
local menuHotkey = UI.getChildControl(Panel_Menu, "StaticText_MenuHotkey")
local menuTitleBar = UI.getChildControl(Panel_Menu, "StaticText_Title")
local menuText = UI.getChildControl(Panel_Menu, "StaticText_MenuText")
local changeMenu = UI.getChildControl(Panel_Menu, "Button_UIChange")
local menuBanner = UI.getChildControl(Panel_Menu, "Button_Banner")
local bannerText = UI.getChildControl(menuBanner, "StaticText_Desc")
local stc_keyGuideBg = UI.getChildControl(Panel_Menu, "Static_KeyGuideBg")
local stc_closeKeyGuide = UI.getChildControl(stc_keyGuideBg, "StaticText_Close_ConsoleUI")
local stc_confirmKeyGuide = UI.getChildControl(stc_keyGuideBg, "StaticText_Confirm_ConsoleUI")
local stc_changeMenuKeyGuide = UI.getChildControl(stc_keyGuideBg, "StaticText_ChangeMenu_ConsoleUI")
stc_keyGuideBg:SetShow(_ContentsGroup_UsePadSnapping)
menuBanner:addInputEvent("Mouse_LUp", "ChangeUI_Menu()")
menuBanner:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ESCMENU_OLD_NOTICE_1"))
bannerText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ESCMENU_OLD_NOTICE_2"))
menuBanner:ActiveMouseEventEffect(true)
local maxButtonCount = #MenuButtonTextId
local menuButtonBG = {}
local menuButtonIcon = {}
local menuBadgePool = {}
local menuNewPool = {}
local menuTextPool = {}
local menuButtonHotkey = {}
local iconBgPosX = menuIconBg:GetPosX()
local iconBgPosY = menuIconBg:GetPosY()
local iconPosX = menuIcon:GetPosX()
local iconPosY = menuIcon:GetPosY()
local countrySizeNum = 68
local buttonTexture = {
  [MenuButtonId.btn_HelpGuide] = {
    2,
    81,
    46,
    125
  },
  [MenuButtonId.btn_KeyboardHelp] = {
    48,
    357,
    92,
    401
  },
  [MenuButtonId.btn_UiSetting] = {
    2,
    219,
    46,
    263
  },
  [MenuButtonId.btn_PlayerInfo] = {
    48,
    81,
    92,
    125
  },
  [MenuButtonId.btn_Inventory] = {
    94,
    81,
    138,
    125
  },
  [MenuButtonId.btn_Skill] = {
    140,
    81,
    184,
    125
  },
  [MenuButtonId.btn_Guild] = {
    186,
    81,
    230,
    125
  },
  [MenuButtonId.btn_WorldMap] = {
    232,
    81,
    276,
    125
  },
  [MenuButtonId.btn_BlackSpirit] = {
    2,
    127,
    46,
    171
  },
  [MenuButtonId.btn_Quest] = {
    48,
    127,
    92,
    171
  },
  [MenuButtonId.btn_Knowledge] = {
    94,
    127,
    138,
    171
  },
  [MenuButtonId.btn_Productnote] = {
    140,
    127,
    184,
    171
  },
  [MenuButtonId.btn_FriendList] = {
    186,
    127,
    230,
    171
  },
  [MenuButtonId.btn_Mail] = {
    232,
    127,
    276,
    171
  },
  [MenuButtonId.btn_Pet] = {
    2,
    173,
    46,
    217
  },
  [MenuButtonId.btn_Dye] = {
    48,
    173,
    92,
    217
  },
  [MenuButtonId.btn_CashShop] = {
    94,
    173,
    138,
    217
  },
  [MenuButtonId.btn_Beauty] = {
    140,
    173,
    184,
    217
  },
  [MenuButtonId.btn_GameOption] = {
    186,
    173,
    230,
    217
  },
  [MenuButtonId.btn_Language] = {
    140,
    449,
    184,
    493
  },
  [MenuButtonId.btn_GameExit] = {
    232,
    173,
    276,
    217
  },
  [MenuButtonId.btn_Rescue] = {
    48,
    219,
    92,
    263
  },
  [MenuButtonId.btn_Manufacture] = {
    140,
    219,
    184,
    263
  },
  [MenuButtonId.btn_FishEncyclopedia] = {
    94,
    219,
    138,
    263
  },
  [MenuButtonId.btn_ColorMix] = {
    186,
    219,
    230,
    263
  },
  [MenuButtonId.btn_Event] = {
    232,
    219,
    276,
    263
  },
  [MenuButtonId.btn_BlackSpritAdventure] = {
    186,
    449,
    230,
    493
  },
  [MenuButtonId.btn_GuildRanker] = {
    140,
    357,
    184,
    401
  },
  [MenuButtonId.btn_LifeRanker] = {
    2,
    265,
    46,
    309
  },
  [MenuButtonId.btn_Siege] = {
    2,
    357,
    46,
    401
  },
  [MenuButtonId.btn_Worker] = {
    94,
    357,
    138,
    401
  },
  [MenuButtonId.btn_TradeEvent] = {
    94,
    403,
    138,
    447
  },
  [MenuButtonId.btn_Channel] = {
    140,
    403,
    184,
    447
  },
  [MenuButtonId.btn_Notice] = {
    186,
    403,
    230,
    447
  },
  [MenuButtonId.btn_LocalWar] = {
    202,
    403,
    276,
    447
  },
  [MenuButtonId.btn_FreeFight] = {
    324,
    403,
    368,
    447
  },
  [MenuButtonId.btn_TeamDuel] = {
    370,
    357,
    414,
    401
  },
  [MenuButtonId.btn_Itemmarket] = {
    2,
    449,
    46,
    493
  },
  [MenuButtonId.btn_ChattingFilter] = {
    278,
    449,
    322,
    493
  },
  [MenuButtonId.btn_WebAlbum] = {
    278,
    403,
    322,
    447
  },
  [MenuButtonId.btn_DailyCheck] = {
    186,
    357,
    230,
    401
  },
  [MenuButtonId.btn_Competition] = {
    278,
    311,
    322,
    355
  },
  [MenuButtonId.btn_ScreenShotAlbum] = {
    278,
    265,
    322,
    309
  },
  [MenuButtonId.btn_PartyList] = {
    324,
    449,
    368,
    493
  },
  [MenuButtonId.btn_MonsterRanking] = {
    324,
    173,
    368,
    217
  },
  [MenuButtonId.btn_Steam] = {
    324,
    219,
    368,
    263
  },
  [MenuButtonId.btn_Update] = {
    324,
    357,
    368,
    401
  },
  [MenuButtonId.btn_BSAdventure2] = {
    324,
    127,
    368,
    171
  },
  [MenuButtonId.btn_Twitch] = {
    370,
    81,
    414,
    125
  },
  [MenuButtonId.btn_SocialAction] = {
    370,
    127,
    414,
    171
  },
  [MenuButtonId.btn_LuxuryAuction] = {
    370,
    173,
    414,
    217
  },
  [MenuButtonId.btn_Copyright] = {
    370,
    173,
    414,
    217
  },
  [MenuButtonId.btn_Memo] = {
    370,
    266,
    414,
    310
  },
  [MenuButtonId.btn_DropItem] = {
    370,
    311,
    414,
    355
  },
  [MenuButtonId.btn_ShortCut] = {
    370,
    403,
    414,
    447
  },
  [MenuButtonId.btn_SaveSetting] = {
    370,
    449,
    414,
    493
  },
  [MenuButtonId.btn_KnownIssue] = {
    416,
    127,
    460,
    171
  },
  [MenuButtonId.btn_BlackDesertLab] = {
    416,
    173,
    460,
    217
  },
  [MenuButtonId.btn_BossAlert] = {
    416,
    219,
    460,
    263
  },
  [MenuButtonId.btn_CardGame] = {
    416,
    219,
    460,
    263
  },
  [MenuButtonId.btn_Feedback] = {
    416,
    311,
    460,
    355
  },
  [MenuButtonId.btn_MarketPlace] = {
    2,
    449,
    46,
    493
  },
  [MenuButtonId.btn_Reserve_59] = {
    416,
    449,
    460,
    493
  },
  [MenuButtonId.btn_VolunteerRank] = {
    462,
    81,
    506,
    125
  },
  [MenuButtonId.btn_AcheivementBookShelf] = {
    462,
    127,
    506,
    171
  },
  [MenuButtonId.btn_ExperienceWiki] = {
    416,
    403,
    460,
    447
  },
  [MenuButtonId.btn_InfinityDefence] = {
    462,
    173,
    506,
    217
  },
  [MenuButtonId.btn_AltarRank] = {
    462,
    219,
    506,
    263
  },
  [MenuButtonId.btn_Homepage] = {
    462,
    265,
    506,
    309
  },
  [MenuButtonId.btn_SailerManager] = {
    462,
    357,
    506,
    401
  },
  [MenuButtonId.btn_Bater] = {
    462,
    403,
    506,
    447
  },
  [MenuButtonId.btn_ChannelChat] = {
    462,
    35,
    506,
    79
  },
  [MenuButtonId.btn_ArshaApplyWeb] = {
    462,
    449,
    506,
    493
  },
  [MenuButtonId.btn_Music] = {
    370,
    35,
    414,
    79
  },
  [MenuButtonId.btn_FarmingList] = {
    416,
    35,
    460,
    79
  }
}
local forthAniversaryKorea = isGameTypeJapan() or isGameServiceTypeDev()
if forthAniversaryKorea then
  buttonTexture[MenuButtonId.btn_BlackSpritAdventure] = {
    462,
    311,
    506,
    355
  }
end
function TargetWindow_ShowToggle(index)
  audioPostEvent_SystemUi(0, 0)
  Panel_UIControl_SetShow(false)
  if MenuButtonId.btn_GameExit == index then
    PaGlobal_GameExit_All_ShowToggle(false)
  elseif MenuButtonId.btn_Rescue == index then
    if ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_COMMON_ARLERT"))
      return
    elseif true == ToClient_getJoinGuildBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
      return
    end
    HandleClicked_RescueConfirm()
  elseif MenuButtonId.btn_GameOption == index then
    showGameOption()
  elseif MenuButtonId.btn_UiSetting == index then
    FGlobal_UiSet_Open()
  elseif MenuButtonId.btn_FriendList == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_FriendList)
  elseif MenuButtonId.btn_Mail == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
  elseif MenuButtonId.btn_Pet == index then
    PaGlobal_PetList_Toggle_All()
  elseif MenuButtonId.btn_Knowledge == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_MentalKnowledge)
  elseif MenuButtonId.btn_Productnote == index then
    Panel_ProductNote_ShowToggle()
  elseif MenuButtonId.btn_Inventory == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
  elseif MenuButtonId.btn_Skill == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
  elseif MenuButtonId.btn_BlackSpirit == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
  elseif MenuButtonId.btn_Quest == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_QuestHistory)
  elseif MenuButtonId.btn_WorldMap == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_WorldMap)
  elseif MenuButtonId.btn_PlayerInfo == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
  elseif MenuButtonId.btn_Guild == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Guild)
  elseif MenuButtonId.btn_HelpGuide == index then
    FGlobal_Panel_WebHelper_ShowToggle()
  elseif MenuButtonId.btn_Dye == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Dyeing)
  elseif MenuButtonId.btn_Beauty == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_BeautyShop)
  elseif MenuButtonId.btn_CashShop == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
  elseif MenuButtonId.btn_Manufacture == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Manufacture)
  elseif MenuButtonId.btn_FishEncyclopedia == index then
    if _ContentsGroup_FishingEncyclopedia == true then
      PaGlobalFunc_FishEncyclopedia_Renewal_All_Open()
    else
      PaGlobalFunc_FishEncyclopedia_All_Open()
    end
  elseif MenuButtonId.btn_ColorMix == index then
    if _ContentsGroup_NewUI_Dye_All then
      PaGlobal_ColorMix_All_Show()
    elseif _ContentsGroup_NewUI_Dye_Palette_All then
      PaGlobal_Dye_Palette_All_Open(false)
    else
      Panel_ColorBalance_Show()
    end
  elseif MenuButtonId.btn_Event == index then
    if true == _ContentsGroup_NewUI_EventNotify_All then
      Panel_EventNotify_All_Open(true, true)
    else
      EventNotify_Open(true, true)
    end
  elseif MenuButtonId.btn_BlackSpritAdventure == index then
    FGlobal_BlackSpiritAdventure_Open()
  elseif MenuButtonId.btn_DailyCheck == index then
    PaGlobalFunc_DailyStamp_All_Open(true)
  elseif MenuButtonId.btn_GuildRanker == index then
    GuildRank_Web_Show()
  elseif MenuButtonId.btn_LifeRanker == index then
    PaGlobal_LifeRanking_Open_All()
  elseif MenuButtonId.btn_KeyboardHelp == index then
    FGlobal_KeyboardHelpShow()
  elseif MenuButtonId.btn_Siege == index then
    PaGlobalFunc_GuildWarInfo_All_Open()
    if Panel_Menu:GetShow() then
      Panel_Menu:SetShow(false, false)
    end
  elseif MenuButtonId.btn_Worker == index then
    PaGlobalFunc_WorkerManager_All_ShowToggle()
  elseif MenuButtonId.btn_TradeEvent == index then
    if _ContentsGroup_isUsedNewTradeEventNotice then
      PaGlobalFunc_TradeEventNotice_Renewal_All_Open()
    else
      TradeEventInfo_Show()
    end
  elseif MenuButtonId.btn_Channel == index then
    if nil ~= Panel_ChannelSelect_All then
      PaGlobalFunc_ChannelSelect_All_Open()
    elseif nil ~= Panel_ChannelSelect then
      FGlobal_ChannelSelect_Show()
    end
  elseif MenuButtonId.btn_Notice == index then
    if true == _ContentsGroup_NewUI_EventNotify_All then
      Panel_EventNotify_All_Open(true, true)
    else
      EventNotify_Open(true, true)
    end
  elseif MenuButtonId.btn_LocalWar == index then
    if true == _ContentsGroup_InstanceLocalWar then
      PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
    else
      PaGlobal_LocalWarInfo_All_ESCMenuFunc()
    end
  elseif MenuButtonId.btn_FreeFight == index then
    FGlobal_FreeFight_ESCMenuFunc()
  elseif MenuButtonId.btn_TeamDuel == index then
    PaGlobal_PersonalBattle:open()
  elseif MenuButtonId.btn_Itemmarket == index then
    FGlobal_ItemMarket_Open_ForWorldMap(1, true)
    audioPostEvent_SystemUi(1, 30)
  elseif MenuButtonId.btn_Language == index then
    if isGameTypeNA() or isGameServiceTypeDev() then
      FGlobal_GameOptionOpen()
    end
  elseif MenuButtonId.btn_ChattingFilter == index then
    FGlobal_ChattingFilterList_Open()
  elseif MenuButtonId.btn_WebAlbum == index then
    ToClient_setEditableOptionTmp()
    FGlobal_CustomizingAlbum_Show(false, CppEnums.ClientSceneState.eClientSceneStateType_InGame)
  elseif MenuButtonId.btn_Competition == index then
    PaGlobaFunc_Arsha_Reservation_All_ESCMenuFunc()
  elseif MenuButtonId.btn_ScreenShotAlbum == index then
    ScreenshotAlbum_Open()
  elseif MenuButtonId.btn_PartyList == index then
    if true == ToClient_IsInstanceRandomMatching() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
      return
    end
    PaGlobalFunc_PartyList_All_Open()
  elseif MenuButtonId.btn_MonsterRanking == index then
    FGlobal_MonsterRanking_Open()
  elseif MenuButtonId.btn_Steam == index then
    PaGlobal_Steam_Redemption()
  elseif MenuButtonId.btn_Update == index then
    Panel_WebHelper_ShowToggle("Update")
  elseif MenuButtonId.btn_BSAdventure2 == index then
    FGlobal_BlackSpiritAdventure2_Open()
  elseif MenuButtonId.btn_Twitch == index then
    PaGlobal_Twitch:ShowWindow()
  elseif MenuButtonId.btn_SocialAction == index then
    FGlobal_SocialAction_ShowToggle()
  elseif MenuButtonId.btn_LuxuryAuction == index then
    PaGlobal_Masterpiece_Auction_All_ESCOpen()
  elseif MenuButtonId.btn_Copyright == index then
    PaGlobal_Copyright_ShowWindow()
  elseif MenuButtonId.btn_Memo == index then
    if false == _ContentsGroup_NewUI_Memo_All then
      PaGlobal_Memo:ListOpen()
    else
      PaGlobalFunc_Memo_Main_All_Open()
    end
  elseif MenuButtonId.btn_DropItem == index then
    PaGlobalFunc_RenewDropItem_Open()
  elseif MenuButtonId.btn_ShortCut == index then
    if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
      PaGlobalFunc_ButtonShorcuts_All_Open()
    else
      FGlobal_ButtonShortcuts_Open()
    end
  elseif MenuButtonId.btn_SaveSetting == index then
    PaGlobal_Panel_SaveSetting_Show(true)
  elseif MenuButtonId.btn_KnownIssue == index then
    Panel_WebHelper_ShowToggle("KnownIssue")
  elseif MenuButtonId.btn_BlackDesertLab == index then
    local player = getSelfPlayer()
    if nil == player then
      return
    end
    if player:get():getLevel() < 56 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEVEL_LIMITED_GLOBAL_LABS"))
      return
    end
    local gameServiceType = getGameServiceType()
    local eCountryType = CppEnums.CountryType
    if eCountryType.NONE == gameServiceType or eCountryType.DEV == gameServiceType or eCountryType.KOR_ALPHA == gameServiceType or eCountryType.KOR_REAL == gameServiceType or eCountryType.KOR_TEST == gameServiceType then
    elseif true == ToClient_isCompleteTesterSubmit() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALREADY_TESTER_SUBMIT"))
      return
    end
    PaGlobal_BlackDesertLab_Show()
  elseif MenuButtonId.btn_BossAlert == index then
    PaGlobal_BossAlert_SettingV2_All_Open()
  elseif MenuButtonId.btn_CardGame == index then
    FGlobal_CardGame_Open()
  elseif MenuButtonId.btn_Feedback == index then
    ToClient_OpenChargeWebPage(ToClient_getSuggestUrl(), false)
  elseif MenuButtonId.btn_MarketPlace == index then
    PaGlobalFunc_MarketPlace_Open()
  elseif MenuButtonId.btn_Reserve_59 == index then
  elseif MenuButtonId.btn_ExperienceWiki == index then
    PaGlobal_ExpirienceWiki_Open()
  elseif MenuButtonId.btn_VolunteerRank == index then
    PaGlobal_VolunteerRankWeb_Open()
  elseif MenuButtonId.btn_AcheivementBookShelf == index then
    PaGlobalFunc_Achievement_BookShelf_All_Open()
  elseif MenuButtonId.btn_InfinityDefence == index then
    PaGlobal_HandleClicked_BloodAltar_Open()
  elseif MenuButtonId.btn_AltarRank == index then
    PaGlobal_AltarRankWeb_Open()
  elseif MenuButtonId.btn_Homepage == index then
    PaGlobal_Homepage_Open()
  elseif MenuButtonId.btn_SailerManager == index then
    if nil ~= Panel_Window_SailorManager_All and false == Panel_Window_SailorManager_All:GetShow() then
      HandlerEventLUp_SailorManager_All_OpenByESCMenu()
    end
  elseif MenuButtonId.btn_Bater == index then
    if nil ~= Panel_Window_Barter_Search and false == Panel_Window_Barter_Search:GetShow() then
      PaGlobal_BarterInfoSearch_Open()
    end
  elseif MenuButtonId.btn_ChannelChat == index then
    PaGlobalFunc_ChannelChat_Open()
  elseif MenuButtonId.btn_ArshaApplyWeb == index then
    if nil ~= Panel_Arsha_ApplyWeb_All and false == Panel_Arsha_ApplyWeb_All:GetShow() then
      PaGlobal_ArshaApplyWeb_All_Open()
    end
  elseif MenuButtonId.btn_Music == index then
    if nil ~= Panel_Window_MusicBoard_All and false == Panel_Window_MusicBoard_All:GetShow() then
      PaGlobal_MusicBoard_All_Open()
    end
  elseif MenuButtonId.btn_FarmingList == index and true == isFarmingListOpen then
    PaGloabl_FarmingTimer_Open()
  end
  if Panel_Menu:GetShow() then
    Panel_Menu:SetShow(false, false)
  end
end
function Panel_Menu_ShowAni()
  Panel_Menu:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Menu, 0, 0.15)
  local aniInfo1 = Panel_Menu:addScaleAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(1.5)
  aniInfo1:SetEndScale(0.8)
  aniInfo1.AxisX = Panel_Menu:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Menu:GetSizeY() / 2
  aniInfo1.ScaleType = 0
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Menu:addScaleAnimation(0.15, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(0.8)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Menu:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Menu:GetSizeY() / 2
  aniInfo2.ScaleType = 0
  aniInfo2.IsChangeChild = true
  for index = 1, maxButtonCount do
    GameMenu_ChangeButtonTexture(index)
  end
end
function Panel_Menu_HideAni()
  Panel_Menu:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Menu, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function GameMenu_Init()
  local posIndex = 1
  for index = 1, maxButtonCount do
    local tempBg = UI.createControl(__ePAUIControl_Static, menu_Bg, "Static_MenuBg_" .. index)
    CopyBaseProperty(menuIconBg, tempBg)
    menuButtonBG[index] = tempBg
    menuButtonBG[index]:SetShow(true)
    menuButtonBG[index]:ResetVertexAni()
    local tempIcon = UI.createControl(__ePAUIControl_StaticText, menuButtonBG[index], "StaticText_MenuIcon_" .. index)
    CopyBaseProperty(menuIcon, tempIcon)
    menuButtonIcon[index] = tempIcon
    menuButtonIcon[index]:SetShow(true)
    local tempHotkeyIcon = UI.createControl(__ePAUIControl_StaticText, menuButtonBG[index], "StaticText_MenuHotKey_" .. index)
    CopyBaseProperty(menuHotkey, tempHotkeyIcon)
    menuButtonHotkey[index] = tempHotkeyIcon
    menuButtonHotkey[index]:SetShow(true)
    local buttonHotKeyId = ""
    if nil ~= MenuButtonHotKeyID[index] then
      buttonHotKeyId = MenuButtonHotKeyID[index]
    end
    menuButtonHotkey[index]:SetText(buttonHotKeyId)
    menuButtonHotkey[index]:ComputePos()
    local badgeIcon = UI.createControl(__ePAUIControl_StaticText, menuButtonBG[index], "StaticText_MenuBadge_" .. index)
    CopyBaseProperty(menuBadge, badgeIcon)
    badgeIcon:SetPosX(tempBg:GetSizeX() - badgeIcon:GetSizeX() - 43)
    badgeIcon:SetPosY(5)
    menuBadgePool[index] = badgeIcon
    menuBadgePool[index]:SetShow(false)
    local newIcon = UI.createControl(__ePAUIControl_Static, menuButtonBG[index], "StaticText_MenuNew_" .. index)
    CopyBaseProperty(menuNew, newIcon)
    newIcon:SetPosX(tempBg:GetSizeX() - newIcon:GetSizeX() - 38)
    newIcon:SetPosY(2)
    newIcon:SetIgnore(true)
    menuNewPool[index] = newIcon
    menuNewPool[index]:SetShow(false)
    local tempText = UI.createControl(__ePAUIControl_StaticText, menuButtonBG[index], "StaticText_MenuText_" .. index)
    CopyBaseProperty(menuText, tempText)
    tempText:SetTextMode(__eTextMode_AutoWrap)
    menuTextPool[index] = tempText
    menuTextPool[index]:SetShow(true)
    if isGameTypeNA() then
      menuButtonIcon[index]:SetSize(44, 44)
      menuTextPool[index]:SetSize(70, menuTextPool[index]:GetSizeY())
      menuTextPool[index]:SetSpanSize(0, 55)
    elseif 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
      menuButtonIcon[index]:SetSize(44, 44)
      menuButtonIcon[index]:SetTextVerticalTop()
      menuButtonIcon[index]:SetSpanSize(menuButtonIcon[index]:GetSpanSize().x, 12)
      menuTextPool[index]:SetSize(80, menuTextPool[index]:GetSizeY())
      menuTextPool[index]:SetSpanSize(0, 60)
    else
      menuButtonIcon[index]:SetSize(44, 44)
      menuButtonIcon[index]:SetTextVerticalTop()
      menuTextPool[index]:SetSize(64, menuTextPool[index]:GetSizeY())
      menuButtonIcon[index]:SetTextSpan(0, 42)
    end
    menuTextPool[index]:SetText(MenuButtonTextId[index])
    if MenuButtonId.btn_BlackDesertLab == index and (isGameServiceTypeKor() or isGameServiceTypeDev()) then
      menuTextPool[index]:SetText("\234\178\128\236\157\128\236\130\172\235\167\137\n\236\151\176\234\181\172\236\134\140")
    end
    if MenuButtonId.btn_BossAlert == index and _ContetnsGroup_BossAlert then
      menuTextPool[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BUTTON_BOSSALERT_TITLE"))
    end
    GameMenu_ChangeButtonTexture(index)
  end
  FGlobal_MenuType_Check()
  menuIconBg:SetIgnore(true)
end
function GameMenu_CheckEnAble(buttonType)
  local returnValue = false
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local playerLevel = selfPlayer:get():getLevel()
  if isGameTypeKorea() then
    if buttonType == MenuButtonId.btn_Notice then
      returnValue = false
    else
      returnValue = true
    end
  elseif isGameTypeJapan() then
    if buttonType == MenuButtonId.btn_Notice then
      returnValue = false
    else
      returnValue = true
    end
  elseif isGameTypeRussia() then
    if buttonType == MenuButtonId.btn_HelpGuide or buttonType == MenuButtonId.btn_Notice then
      returnValue = false
    else
      returnValue = true
    end
    if buttonType == MenuButtonId.btn_Event then
      returnValue = true
    end
    if getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT or getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_OBT then
      if buttonType == MenuButtonId.btn_Dye then
        returnValue = false
      else
        returnValue = true
      end
    end
  elseif isGameTypeNA() then
    if buttonType == MenuButtonId.btn_Event then
      returnValue = false
    else
      returnValue = true
    end
  elseif isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KR2) then
    returnValue = true
  elseif isGameTypeTaiwan() then
    if buttonType == MenuButtonId.btn_Notice then
      returnValue = false
    else
      returnValue = true
    end
  else
    returnValue = true
  end
  if buttonType == MenuButtonId.btn_LocalWar then
    returnValue = PaGlobal_Menu_IsOpenConetents(isLocalwarOpen)
  end
  if buttonType == MenuButtonId.btn_FreeFight then
    returnValue = PaGlobal_Menu_IsOpenConetents(isFreeFight)
  end
  if buttonType == MenuButtonId.btn_TeamDuel then
    returnValue = false
  end
  if buttonType == MenuButtonId.btn_CashShop or buttonType == MenuButtonId.btn_Beauty then
    if getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_Commercial then
      returnValue = false
    else
      returnValue = true
    end
  end
  if buttonType == MenuButtonId.btn_TradeEvent then
    returnValue = false
  end
  if buttonType == MenuButtonId.btn_Language then
    if isGameTypeNA() or isGameServiceTypeDev() then
      returnValue = true
    else
      returnValue = false
    end
  end
  if buttonType == MenuButtonId.btn_ChattingFilter then
    returnValue = true
  end
  if buttonType == MenuButtonId.btn_WebAlbum then
    if _ContentsGroup_webAlbumOpen or isGameServiceTypeDev() then
      returnValue = true
    else
      returnValue = false
    end
  end
  if buttonType == MenuButtonId.btn_BlackSpritAdventure then
    returnValue = PaGlobal_Menu_IsOpenConetents(isBlackSpiritAdventure)
  end
  if buttonType == MenuButtonId.btn_DailyCheck then
    if joinCheckOpen then
      returnValue = true
    else
      returnValue = false
    end
  end
  if buttonType == MenuButtonId.btn_Competition then
    returnValue = PaGlobal_Menu_IsOpenConetents(isContentsArsha)
  end
  if buttonType == MenuButtonId.btn_Steam then
    returnValue = _ContentsGroup_SteamOpen and isGameTypeASIA() == false
  end
  if buttonType == MenuButtonId.btn_Update then
    if isGameTypeKorea() or isGameTypeTR() or isGameTypeTaiwan() or isGameTypeID() or isGameTypeTH() or isGameTypeASIA() or isGameServiceTypeDev() then
      returnValue = true
    else
      returnValue = false
    end
  end
  if buttonType == MenuButtonId.btn_ScreenShotAlbum then
    returnValue = photoGalleryOpen
  end
  if buttonType == MenuButtonId.btn_PartyList then
    returnValue = partyListOpen
  end
  if buttonType == MenuButtonId.btn_MonsterRanking then
    if isMonsterRanking then
      returnValue = true
    else
      returnValue = false
    end
  end
  if buttonType == MenuButtonId.btn_Twitch then
    returnValue = false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_Copyright then
    returnValue = isGameServiceTypeDev() and false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_LuxuryAuction then
    returnValue = isMasterPiece
  end
  if buttonType == MenuButtonId.btn_BSAdventure2 then
    returnValue = isBlackSpiritAdventure2
  end
  if (buttonType == MenuButtonId.btn_HelpGuide or buttonType == MenuButtonId.btn_Productnote or buttonType == MenuButtonId.btn_Event or buttonType == MenuButtonId.btn_Notice) and isGameTypeCH() then
    returnValue = false
  end
  if buttonType == MenuButtonId.btn_Notice then
    if isGameTypeTR() or isGameTypeTH() or isGameTypeASIA() or isGameTypeID() then
      returnValue = false
    elseif isGameServiceTypeDev() then
      returnValue = true
    end
  end
  if buttonType == MenuButtonId.btn_Siege then
    returnValue = false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_Memo then
    returnValue = _ContentsGroup_isMemoOpen
  end
  if buttonType == MenuButtonId.btn_DropItem then
    returnValue = PaGlobal_Menu_IsOpenConetents(isDropItemOpen)
  end
  if buttonType == MenuButtonId.btn_ShortCut then
    returnValue = isButtonShortCut
  end
  if buttonType == MenuButtonId.btn_KnownIssue then
    returnValue = isKnownIssue
  end
  if buttonType == MenuButtonId.btn_BlackDesertLab then
    returnValue = isBlackDesertLabOpen
  end
  if buttonType == MenuButtonId.btn_BossAlert then
    returnValue = PaGlobal_Menu_IsOpenConetents(isBossAlert)
  end
  if buttonType == MenuButtonId.btn_CardGame then
    returnValue = isGameServiceTypeDev()
  end
  if buttonType == MenuButtonId.btn_Feedback then
    returnValue = isTestServer
  end
  if buttonType == MenuButtonId.btn_MarketPlace then
    returnValue = isMarketPlaceOpen and false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_Itemmarket then
    returnValue = false == _ContentsGroup_RenewUI_ItemMarketPlace_Only and false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_Skill then
    returnValue = PaGlobal_Menu_IsOpenConetents(true)
  end
  if buttonType == MenuButtonId.btn_Worker then
    returnValue = PaGlobal_Menu_IsOpenConetents(true)
  end
  if buttonType == MenuButtonId.btn_Reserve_59 then
    returnValue = false
  end
  if buttonType == MenuButtonId.btn_ExperienceWiki then
    returnValue = _ContentsGroup_ExpirienceWiki
  end
  if buttonType == MenuButtonId.btn_VolunteerRank then
    returnValue = _ContentsGroup_BattleFieldVolunteer
  end
  if buttonType == MenuButtonId.btn_AltarRank then
    returnValue = _ContentsGroup_Altar and false
  end
  if buttonType == MenuButtonId.btn_Homepage then
    returnValue = false == isGameTypeJapan() and false == isGameTypeCH()
  end
  if buttonType == MenuButtonId.btn_SailerManager then
    returnValue = _ContentsGroup_Sailor
  end
  if buttonType == MenuButtonId.btn_Bater then
    returnValue = _ContentsGroup_Barter
  end
  if buttonType == MenuButtonId.btn_ArshaApplyWeb then
    returnValue = _ContentsGroup_Arsha_ApplyWeb and true == isGameTypeRussia()
  end
  if buttonType == MenuButtonId.btn_Music then
    returnValue = _ContentsGroup_InstrumentPerformance
  end
  if buttonType == MenuButtonId.btn_AcheivementBookShelf then
    returnValue = PaGlobal_Menu_IsOpenConetents(_ContentsGroup_AchievementQuest)
  end
  if buttonType == MenuButtonId.btn_Manufacture then
    returnValue = PaGlobal_Menu_IsOpenConetents(isManufacturing)
  end
  if buttonType == MenuButtonId.btn_BlackSpirit then
    returnValue = PaGlobal_Menu_IsOpenConetents(true)
  end
  if buttonType == MenuButtonId.btn_Guild then
    returnValue = PaGlobal_Menu_IsOpenConetents(true)
  end
  if buttonType == MenuButtonId.btn_Quest then
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      returnValue = false
    else
      returnValue = PaGlobal_Menu_IsOpenConetents(true)
    end
  end
  if buttonType == MenuButtonId.btn_FarmingList then
    returnValue = PaGlobal_Menu_IsOpenConetents(isFarmingListOpen)
  end
  if buttonType == MenuButtonId.btn_InfinityDefence then
    returnValue = isInfinityDefence and false
  end
  if buttonType == MenuButtonId.btn_ChannelChat then
    returnValue = _ContentsGroup_ChannelChat
  end
  if isTestServer and (buttonType == MenuButtonId.btn_HelpGuide or buttonType == MenuButtonId.btn_Productnote or buttonType == MenuButtonId.btn_Beauty or buttonType == MenuButtonId.btn_GuildRanker or buttonType == MenuButtonId.btn_Event or buttonType == MenuButtonId.btn_Notice or buttonType == MenuButtonId.btn_BlackSpritAdventure or buttonType == MenuButtonId.btn_BSAdventure2 or buttonType == MenuButtonId.btn_WebAlbum or buttonType == MenuButtonId.btn_ScreenShotAlbum or buttonType == MenuButtonId.btn_Steam or buttonType == MenuButtonId.btn_Update or buttonType == MenuButtonId.btn_Twitch or buttonType == MenuButtonId.btn_Copyright or buttonType == MenuButtonId.btn_KnownIssue or buttonType == MenuButtonId.btn_SaveSetting or buttonType == MenuButtonId.btn_CashShop) then
    returnValue = false
  end
  return returnValue
end
function GameMenu_ChangeButtonTexture(index)
  menuButtonIcon[index]:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/Menu/Menu_01.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if index == MenuButtonId.btn_CashShop then
    if 0 == getGameServiceType() or 1 == getGameServiceType() or 2 == getGameServiceType() or 3 == getGameServiceType() or 4 == getGameServiceType() then
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.kr)
    elseif 5 == getGameServiceType() or 6 == getGameServiceType() then
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.jp)
    elseif 7 == getGameServiceType() or 8 == getGameServiceType() then
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.ru)
    elseif 9 == getGameServiceType() or 10 == getGameServiceType() then
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.cn)
    elseif isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeASIA() or isGameTypeID() then
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.tw)
    else
      x1, y1, x2, y2 = cashIcon_changeButtonTexture(menuButtonIcon[index], contry.kr)
    end
  elseif index == MenuButtonId.btn_LocalWar then
    if 0 == ToClient_GetMyTeamNoRedBattleField() then
      x1, y1, x2, y2 = setTextureUV_Func(menuButtonIcon[index], 232, 403, 276, 447)
      menuTextPool[MenuButtonId.btn_LocalWar]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_INFO"))
    else
      x1, y1, x2, y2 = setTextureUV_Func(menuButtonIcon[index], 232, 449, 276, 493)
      menuTextPool[MenuButtonId.btn_LocalWar]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_GETOUT"))
    end
  elseif index == MenuButtonId.btn_Steam then
    if true == _ContentsGroup_SteamOpen then
      x1, y1, x2, y2 = setTextureUV_Func(menuButtonIcon[index], 370, 219, 414, 263)
    elseif isGameTypeNA() or isGameServiceTypeDev() then
      x1, y1, x2, y2 = setTextureUV_Func(menuButtonIcon[index], 324, 219, 368, 263)
    end
  else
    x1, y1, x2, y2 = setTextureUV_Func(menuButtonIcon[index], buttonTexture[index][1], buttonTexture[index][2], buttonTexture[index][3], buttonTexture[index][4])
  end
  menuButtonIcon[index]:getBaseTexture():setUV(x1, y1, x2, y2)
  menuButtonIcon[index]:setRenderTexture(menuButtonIcon[index]:getBaseTexture())
  if index == MenuButtonId.btn_BlackSpritAdventure and forthAniversaryKorea then
    menuButtonBG[index]:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/Menu/Menu_01.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    x1, y1, x2, y2 = setTextureUV_Func(menuButtonBG[index], 239, 3, 307, 71)
    menuButtonBG[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    menuButtonBG[index]:setRenderTexture(menuButtonBG[index]:getBaseTexture())
  end
end
function HandleOn_SlotBg(index)
  GameMenu_ResetVertexAni()
  if nil ~= index then
    menuButtonBG[index]:SetVertexAniRun("Ani_Color_New", true)
  end
end
function GameMenu_ResetVertexAni()
  for i = 1, maxButtonCount do
    if GameMenu_CheckEnAble(i) then
      menuButtonBG[i]:ResetVertexAni()
      menuButtonBG[i]:SetVertexAniRun("Ani_Color_Reset", true)
    end
  end
end
function mainUI_Badges_Count()
  if true == _badges[MenuButtonId.btn_Quest].isShow then
    _badges[MenuButtonId.btn_Quest].count = _badges[MenuButtonId.btn_Quest].count + 1
  end
  if true == _badges[MenuButtonId.btn_BlackSpirit].isShow then
    _badges[MenuButtonId.btn_BlackSpirit].count = _badges[MenuButtonId.btn_BlackSpirit].count + 1
  end
  if true == _badges[MenuButtonId.btn_Skill].isShow then
    _badges[MenuButtonId.btn_Skill].count = _badges[MenuButtonId.btn_Skill].count + 1
  end
  if true == _badges[MenuButtonId.btn_FriendList].isShow then
    _badges[MenuButtonId.btn_FriendList].count = _badges[MenuButtonId.btn_FriendList].count + 1
  end
  menuBadgePool[MenuButtonId.btn_Quest]:SetText(_badges[MenuButtonId.btn_Quest].count)
  menuBadgePool[MenuButtonId.btn_BlackSpirit]:SetText(_badges[MenuButtonId.btn_BlackSpirit].count)
  menuBadgePool[MenuButtonId.btn_Skill]:SetText(_badges[MenuButtonId.btn_Skill].count)
  menuBadgePool[MenuButtonId.btn_FriendList]:SetText(_badges[MenuButtonId.btn_FriendList].count)
end
function UIMain_ItemUpdate()
  if nil == Panel_Menu or false == Panel_Menu:GetShow() then
    return
  end
  local newItemCount = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    newItemCount = PaGlobalFunc_Inventory_All_GetFirstItemCount()
  elseif true == _ContentsGroup_RenewUI_InventoryEquip then
    newItemCount = PaGlobalFunc_Inventory_GetFirstItemCount()
  else
    newItemCount = Inventory_GetFirstItemCount()
  end
  if not menuBadgePool[MenuButtonId.btn_Inventory]:GetShow() and 0 ~= newItemCount then
    menuBadgePool[MenuButtonId.btn_Inventory]:SetShow(true)
  end
  menuBadgePool[MenuButtonId.btn_Inventory]:SetText(newItemCount)
end
function UIMain_ItemUpdateRemove()
  menuBadgePool[MenuButtonId.btn_Inventory]:SetText(0)
  menuBadgePool[MenuButtonId.btn_Inventory]:SetShow(false)
end
function UIMain_FriendListUpdate()
  if false == _badges[MenuButtonId.btn_FriendList].isShow then
    _badges[MenuButtonId.btn_FriendList].isShow = true
    menuBadgePool[MenuButtonId.btn_FriendList]:SetShow(true)
    mainUI_Badges_Count()
  end
end
function UIMain_FriendListUpdateRemove()
  _badges[MenuButtonId.btn_FriendList].isShow = false
  _badges[MenuButtonId.btn_FriendList].count = 0
  menuBadgePool[MenuButtonId.btn_FriendList]:SetShow(false)
  mainUI_Badges_Count()
end
local knowledgePoint = 0
function UIMain_KnowledgeUpdate()
  knowledgePoint = knowledgePoint + 1
  if 0 ~= knowledgePoint then
    if knowledgePoint > 1 then
      return
    end
    menuBadgePool[MenuButtonId.btn_Knowledge]:SetShow(true)
    menuBadgePool[MenuButtonId.btn_Knowledge]:SetText("N")
  end
end
function UIMain_KnowledgeUpdateRemove()
  knowledgePoint = 0
  menuBadgePool[MenuButtonId.btn_Knowledge]:SetShow(false)
end
function UI_MAIN_checkSkillLearnable()
  local isLearnable = false
  if _ContentsGroup_ShowOtherClassSkill == true then
    isLearnable = PaGlobalFunc_SkillGroup_All_PlayerLearnableSkill()
  else
    isLearnable = SkillWindow_PlayerLearnableSkill()
  end
  if isLearnable then
    menuBadgePool[MenuButtonId.btn_Skill]:SetShow(true)
    menuBadgePool[MenuButtonId.btn_Skill]:SetText("N")
  end
end
function UIMain_SkillPointUpdateRemove()
  menuBadgePool[MenuButtonId.btn_Skill]:SetShow(false)
end
function Panel_Menu_ShowToggle()
  if _ContentsGroup_Menu_Xbox then
    PaGlobal_Menu_Remake_ShowToggle()
    return
  end
  if isGameTypeGT() == true then
    PaGlobal_Menu_Remake_ShowToggle()
    return
  end
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENUOPENALERT_INDEAD"))
    return
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    return
  end
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  if GetUIMode() == Defines.UIMode.eUIMode_Gacha_Roulette then
    return
  end
  local currentMenuType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuType)
  if eMenuType.oldMenu == currentMenuType then
    if Panel_Menu:IsShow() == true then
      Panel_Menu_Close()
      return false
    elseif nil ~= PaGloablFunc_MiniGameFind_GetShow and true == PaGloablFunc_MiniGameFind_GetShow() then
      return false
    else
      _Panel_Menu_OpenLimit()
      Panel_Menu:SetPosX(scrSizeX - scrSizeX * 0.5 - Panel_Menu:GetSizeX() * 0.5)
      Panel_Menu:SetPosY(scrSizeY - scrSizeY * 0.5 - Panel_Menu:GetSizeY() * 0.5)
      Panel_Menu:SetShow(true, true)
      Panel_Menu:SetDragAll(true)
      Panel_Menu:SetIgnore(false)
      audioPostEvent_SystemUi(1, 37)
      UIMain_ItemUpdate()
      return true
    end
  else
    PaGlobal_Menu_Remake_ShowToggle()
    return
  end
  return false
end
function _Panel_Menu_OpenLimit()
  if nil == getSelfPlayer() then
    return
  end
  local playerLevel = getSelfPlayer():get():getLevel()
  for index = 1, maxButtonCount do
    menuButtonBG[index]:SetShow(false)
  end
  local columnCount = 0
  local columnCountByRaw = 7
  local rowCount = 0
  local posIndex = 1
  if nil ~= getSelfPlayer() then
    for index = 1, maxButtonCount do
      if GameMenu_CheckEnAble(index) and nil ~= menuButtonBG[index] and nil ~= menuButtonIcon[index] and nil ~= menuButtonHotkey[index] then
        menuButtonBG[index]:SetEnable(true)
        menuButtonBG[index]:SetMonoTone(false)
        menuButtonIcon[index]:SetEnable(true)
        menuButtonIcon[index]:SetMonoTone(false)
        menuButtonHotkey[index]:SetEnable(true)
        menuButtonHotkey[index]:SetMonoTone(false)
        menuButtonBG[index]:SetSize(68, 68)
        if isGameTypeNA() then
          menuButtonBG[index]:SetSize(83, 83)
          countrySizeNum = 83
        elseif 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
          menuButtonBG[index]:SetSize(90, 90)
          countrySizeNum = 90
        else
          menuButtonBG[index]:SetSize(68, 68)
          countrySizeNum = 68
        end
        menuButtonBG[index]:SetShow(true)
        menuButtonBG[index]:SetPosX(iconBgPosX + menuButtonBG[index]:GetSizeX() * columnCount)
        menuButtonBG[index]:SetPosY(iconBgPosY + menuButtonBG[index]:GetSizeY() * rowCount)
        menuButtonBG[index]:addInputEvent("Mouse_LUp", "TargetWindow_ShowToggle(" .. index .. ")")
        menuButtonBG[index]:addInputEvent("Mouse_On", "HandleOn_SlotBg(" .. index .. ")")
        menuButtonBG[index]:addInputEvent("Mouse_Out", "HandleOn_SlotBg()")
        if 0 == posIndex % columnCountByRaw then
          columnCount = 0
          rowCount = rowCount + 1
        else
          columnCount = columnCount + 1
        end
        posIndex = posIndex + 1
      end
    end
    local totalRaw = math.ceil((posIndex - 1) / columnCountByRaw)
    local buttonSizeX = menuButtonBG[2]:GetSizeX()
    local buttonGapX = 7
    local bgSizeX = buttonSizeX * columnCountByRaw
    if true == menuBanner:GetShow() then
      menuBanner:SetSize(bgSizeX, 70)
      menuBanner:ComputePos()
      menu_Bg:SetSize(bgSizeX + 10, countrySizeNum * totalRaw + 90)
    else
      menu_Bg:SetSize(bgSizeX + 10, countrySizeNum * totalRaw + 10)
    end
    Panel_Menu:SetSize(menu_Bg:GetSizeX() + 10, menu_Bg:GetSizeY() + 105)
    menuTitleBar:SetSize(menu_Bg:GetSizeX(), menuTitleBar:GetSizeY())
    menu_Bg:ComputePos()
    menuTitleBar:ComputePos()
    changeMenu:ComputePos()
    changeMenu:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  local curChannelData = getCurrentChannelServerData()
  if GameMenu_CheckEnAble(MenuButtonId.btn_Siege) then
    menuButtonBG[MenuButtonId.btn_Siege]:SetEnable(true)
    menuButtonBG[MenuButtonId.btn_Siege]:SetMonoTone(false)
    menuButtonIcon[MenuButtonId.btn_Siege]:SetEnable(true)
    menuButtonIcon[MenuButtonId.btn_Siege]:SetMonoTone(false)
    menuButtonHotkey[MenuButtonId.btn_Siege]:SetEnable(true)
    menuButtonHotkey[MenuButtonId.btn_Siege]:SetMonoTone(false)
  end
  local dailyCheckTabCount = ToClient_GetAttendanceInfoCount()
  if dailyCheckTabCount > 0 then
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetEnable(true)
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetMonoTone(false)
  else
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetEnable(false)
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetMonoTone(true)
  end
  if ToClient_IsConferenceMode() then
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_DailyCheck]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_CashShop]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_CashShop]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_Productnote]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_Productnote]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_TradeEvent]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_TradeEvent]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_GuildRanker]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_GuildRanker]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_LifeRanker]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_LifeRanker]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_BlackSpritAdventure]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_BlackSpritAdventure]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_Event]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_Event]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_ScreenShotAlbum]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_ScreenShotAlbum]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_WebAlbum]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_WebAlbum]:SetMonoTone(true)
    menuButtonBG[MenuButtonId.btn_WebAlbum]:SetIgnore(true)
    menuButtonBG[MenuButtonId.btn_WebAlbum]:SetMonoTone(true)
  end
end
function Panel_Menu_Close()
  local currentMenuType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuType)
  if eMenuType.newMenu == currentMenuType then
    PaGlobal_Menu_Remake_Close()
    return
  end
  Panel_Menu:SetShow(false, true)
  Panel_Menu:SetDragAll(false)
  Panel_Menu:SetIgnore(true)
end
function HandleClicked_RescueConfirm()
  if nil ~= Panel_Widget_EscapeBar_All and Panel_Widget_EscapeBar_All:GetShow() then
    ToClient_StopPreCoolTime()
  end
  audioPostEvent_SystemUi(1, 41)
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MSGBOX_RESCUE")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = RescueExecute,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function RescueExecute()
  ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_Escape, 0)
end
function panelMenu_OnScreenResize()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local gabY = 10
  Panel_Menu:SetPosX(scrSizeX - scrSizeX / 2 - Panel_Menu:GetSizeX() / 2)
  Panel_Menu:SetPosY(scrSizeY - scrSizeY / 2 - Panel_Menu:GetSizeY() / 2)
  Panel_Menu:ComputePos()
  local keyGuidelist = {
    stc_closeKeyGuide,
    stc_confirmKeyGuide,
    stc_changeMenuKeyGuide
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuidelist, stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function FGlobal_GetGameExitIndex()
  local exitIndex = MenuButtonId.btn_GameExit
  return exitIndex
end
function ChangeUI_Menu()
  Panel_Menu_Close()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMenuType, eMenuType.newMenu, CppEnums.VariableStorageType.eVariableStorageType_User)
  Panel_Menu_ShowToggle()
end
function FGlobal_MenuType_Check()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  local currentMenuType = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuType)
  if 0 == currentMenuType then
    if 2 == userType then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMenuType, eMenuType.newMenu, CppEnums.VariableStorageType.eVariableStorageType_User)
    else
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMenuType, eMenuType.newMenu, CppEnums.VariableStorageType.eVariableStorageType_User)
    end
  end
end
function PaGlobal_Menu_IsOpenConetents(contentsOption)
  local stackWeight = 0
  if true == contentsOption then
    stackWeight = stackWeight + 10
  end
  if 10 == stackWeight then
    return true
  else
    return false
  end
end
function FromClient_NotOpenedBattleRoyale(SymNo)
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxMemo = PAGetStringSymNo(SymNo)
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_FreeFight_ESCMenuFunc()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local player = getSelfPlayer():get()
  local maxHp = player:getMaxHp()
  local playerHp = player:getHp()
  if nil == player then
    return
  end
  if player:getLevel() < 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FREEFIGHTALERT"))
    return
  end
  if true == player:isCompetitionDefined() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if false == _ContentsGroup_InstanceFreeBatttleField then
    if true == curChannelData._isSiegeChannel then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BATTLEGROURND"))
      return
    end
    if true == ToClient_isPremiumCharacter() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_CANNOT_EXIT"))
      return
    end
  end
  if ToClient_IsJoinPvpBattleGround() then
    local FunctionYesUnJoinPvpBattle = function()
      ToClient_UnJoinPvpBattleGround()
    end
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_UNJOIN")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = FunctionYesUnJoinPvpBattle,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  elseif maxHp == playerHp then
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
      return
    end
    audioPostEvent_SystemUi(1, 18)
    local FunctionYesJoinPvpBattle = function()
      ToClient_JoinPvpBattleGround(0)
    end
    if true == _ContentsGroup_InstanceFreeBatttleField then
      PaGlobalFunc_FreeBaettleField_All_Open()
    else
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_JOIN")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = FunctionYesJoinPvpBattle,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_CHECKHP"))
  end
end
GameMenu_Init()
registerEvent("FromClient_NotOpenedBattleRoyale", "FromClient_NotOpenedBattleRoyale")
registerEvent("onScreenResize", "panelMenu_OnScreenResize")
registerEvent("FromClient_InventoryUpdate", "UIMain_ItemUpdate")
changeMenu:addInputEvent("Mouse_LUp", "ChangeUI_Menu()")
