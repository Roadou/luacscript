local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
isRecordMode = false
isLuaLoadingComplete = false
function loadLogoUI_XB()
  basicLoadUI("UI_Data/UI_Lobby/UI_Logo.xml", "Panel_Logo", UIGroup.PAGameUIGroup_Windows)
  runLua("UI_Data/Script/Panel_Logo.lua")
  loadXboxLoadingUI()
end
function loadXboxLoadingUI()
  loadUI("UI_Data/UI_Loading/UI_Loading_Progress_Xbox.XML", "Panel_Loading_Xbox", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_Loading_Xbox.lua")
end
function loadXboxUI()
  loadPadBlackBackgroundEffect()
  basicLoadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/UI_Lobby/UI_Logo_Xbox.xml", "Panel_LogoXbox", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Panel_LogoXbox.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
end
function loadLoginUI_XB()
  loadPadBlackBackgroundEffect()
  basicLoadUI("UI_Data/Window/Policy/Panel_Window_Policy.XML", "Panel_Window_Policy", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_TermsofGameUse.XML", "Panel_TermsofGameUse", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/UI_Lobby/Console/Panel_Lobby_UserSetting.XML", "Panel_Lobby_UserSetting", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_MainCitadelSelect.XML", "Panel_Worldmap_MainCitadelSelect", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_Login_All.xml", "Panel_Lobby_Login_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/UI_Lobby/UI_Login_Password_All.XML", "Panel_Login_Password_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_Login_Nickname_All.XML", "Panel_Login_Nickname_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/UI_Lobby/Console/Panel_Lobby_Nickname_Renew.XML", "Panel_Login_Nickname_Renew", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/HelpMessage/Panel_HelpMessage.xml", "Panel_HelpMessage", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset.XML", "Panel_Window_ConsoleUIOffset", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Copyright/Console/Panel_Window_Copyright_Renew.XML", "Panel_Window_Copyright", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy_PS.XML", "Panel_Window_PrivacyPolicy", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_VillageWar_All.XML", "Panel_Worldmap_NodeTooltip_VillageWar_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  runLua("UI_Data/Script/Window/Policy/Panel_Window_Policy.lua")
  runLua("UI_Data/Script/Panel_TermsofGameUse.lua")
  runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_Login_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Login_Password_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Login_Nickname_All.lua")
  runLua("UI_Data/Script/Window/FirstLogin/Panel_Lobby_UserSetting.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/HelpMessage/Panel_HelpMessage.lua")
  runLua("UI_Data/Script/Window/Copyright/Console/Panel_Window_Copyright.lua")
  runLua("UI_Data/Script/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy.lua")
  preLoadGameOptionUI()
  loadGameOptionUI()
  loadPadSnapTargetEffect()
end
function loadServerSelectUI_XB()
  loadPadBlackBackgroundEffect()
  basicLoadUI("UI_Data/UI_Lobby/UI_ServerSelect_All.xml", "Panel_Lobby_ServerSelect_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Popup/UI_Popup_Hadum_Warning.xml", "Panel_Popup_Hadum_Warning", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/WebHelper/Console/Panel_WebControl_Renew.XML", "Panel_WebControl_Renew", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_ServerSelect_All.lua")
  runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/Window/WebHelper/Console/Panel_WebControl_Renew.lua")
  basicLoadUI("UI_Data/Window/Policy/Panel_Window_Policy.XML", "Panel_Window_Policy", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy_PS.XML", "Panel_Window_PrivacyPolicy", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy.lua")
  loadPadSnapTargetEffect()
end
function loadLoadingUI_XB()
  if ToClient_isActorAnimationLoadingFlag() == true then
    return
  end
  loadPadBlackBackgroundEffect()
  loadUI("UI_Data/UI_Loading/UI_Loading_Progress.xml", "Panel_Loading", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  runLua("UI_Data/Script/Panel_Loading.lua")
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_WarInfoMessage.XML", "Panel_WarInfoMessage", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWarKillingScore.XML", "Panel_TerritoryWarKillingScore", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/HouseInfo/Panel_WolrdHouseInfo.XML", "Panel_WolrdHouseInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  loadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_InstanceField.lua")
end
function loadLobbyUI_XB()
  loadPadBlackBackgroundEffect()
  basicLoadUI("UI_Data/UI_Lobby/UI_Startl.xml", "Panel_Start", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_CharacterSelect_All.xml", "Panel_CharacterSelect_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/Console/Panel_Lobby_SelectClass_Renew.xml", "Panel_Lobby_ClassSelect_Renew", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_CharacterCreate.xml", "Panel_CharacterCreate", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    basicLoadUI("UI_Data/Window/Season/Panel_Window_SeasonBanner_CharacterCreate.xml", "Panel_Window_SeasonBanner", UIGroup.PAGameUIGroup_Alert)
  end
  basicLoadUI("UI_Data/Window/Season/Panel_Window_Season_Character_Create.XML", "Panel_Window_Season_Character_Create", UIGroup.PAGameUIGroup_Alert)
  if true == _ContentsGroup_SelectStartPosition then
    basicLoadUI("UI_Data/Window/Quest/Panel_Window_StartBranch.XML", "Panel_Window_StartBranch", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/FirstLogin/Panel_FirstLogin.XML", "Panel_FirstLogin", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/NoticeAlert/NoticeAlert.XML", "Panel_NoticeAlert", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/Panel_IME.XML", "Panel_IME", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/DataProgress/Panel_DataProgress.XML", "Panel_DataProgress", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  runLua("UI_Data/Script/Common/Common_UIMode.lua")
  preloadCustomizationUI_XB()
  loadCustomizationUI_XB()
  basicLoadUI("UI_Data/Widget/NakMessage/Console/Panel_Widget_NakMessage_Renew.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_CharacterSelect_All.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_ClassSelect_Renew.lua")
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonBanner.lua")
  end
  runLua("UI_Data/Script/Window/Season/Panel_Window_Season_Character_Create.lua")
  if true == _ContentsGroup_SelectStartPosition then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_InstanceField.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Window/FirstLogin/Panel_FirstLogin.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/NoticeAlert.lua")
  runLua("UI_Data/Script/Panel_Ime.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_DataProgress.lua")
  basicLoadUI("UI_Data/Window/Mercenary/Panel_Window_RedDesert.XML", "Panel_Window_RedDesert", UIGroup.PAGameUIGroup_Windows)
  runLua("UI_Data/Script/Window/Mercenary/Panel_Window_RedDesert.lua")
  basicLoadUI("UI_Data/Widget/KeyGuide/Panel_ConsoleKeyGuide.xml", "Panel_ConsoleLobbyKeyGuide", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize,
    RenderMode.eRenderMode_Dialog,
    Defines.RenderMode.eRenderMode_customScreenShot
  }))
  runLua("UI_Data/Script/Widget/ConsoleKeyGuide/Panel_ConsoleLobbyKeyGuide.lua")
  loadUI("UI_Data/UI_Loading/UI_Loading_Progress_Xbox.XML", "Panel_Loading_Xbox", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_Loading_Xbox.lua")
  loadPadSnapTargetEffect()
end
function preLoadGameUI_XB()
  loadUI("UI_Data/Window/BlackBackground/Panel_Global_BlackBackGround.xml", "Panel_Global_BlackBackGround", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/UIcontrol/Panel_OnlyPerframeUsed.XML", "Panel_OnlyPerframeUsed", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/UIcontrol/Panel_CommonGameScreenUI_Console.XML", "Panel_CommonGameScreenUI_Console", UIGroup.PAGameUIGroup_MiniGameUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Movie/UI_IntroMovie.xml", "Panel_IntroMovie", UIGroup.PAGameUIGroup_Movie)
  loadUI("UI_Data/Window/Movie/UI_DialogMovie.xml", "Panel_DialogMovie", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Video
  }))
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieStroyIndun.XML", "Panel_MovieStroyIndun", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Panel_IME.XML", "Panel_IME", UIGroup.PAGameUIGroup_ModalDialog)
  loadUI("UI_Data/Window/WebHelper/Panel_WebControl.XML", "Panel_WebControl", UIGroup.PAGameUIGroup_DeadMessage, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_WebCashPayment.XML", "Panel_WebCashPayment", UIGroup.PAGameUIGroup_DeadMessage, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.XML", "Panel_Window_PearlBox_Purchase_All", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Console/Panel_WebControl_Renew.XML", "Panel_WebControl_Renew", UIGroup.PAGameUIGroup_DeadMessage, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/HelpMessage/Panel_HelpMessage.xml", "Panel_HelpMessage", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/Damage/CounterAttack.XML", "Panel_CounterAttack", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/GlobalManual/Console/Panel_Global_Manual_Renew.xml", "Panel_Global_Manual", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_NewUI_Fishing_All then
    basicLoadUI("UI_Data/Widget/Fishing/Panel_Widget_Fishing_All.xml", "Panel_Widget_Fishing_All", UIGroup.PAGameUIGroup_MiniGameUI)
  else
    basicLoadUI("UI_Data/Widget/Fishing/Console/Panel_Fishing_Renew.xml", "Panel_Fishing", UIGroup.PAGameUIGroup_MiniGameUI)
  end
  if true == _ContentsGroup_IceFishingGame then
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_IceFishing_All.XML", "Panel_MiniGame_IceFishing_All", Defines.UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningSlaughter_All.xml", "Panel_MiniGame_MorningSlaughter_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningSyringe_All.xml", "Panel_MiniGame_MorningSyringe_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningLeather_All.xml", "Panel_MiniGame_MorningLeather_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningMining_All.xml", "Panel_MiniGame_MorningMining_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningLogging_All.xml", "Panel_MiniGame_MorningLogging_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningHomi_All.xml", "Panel_MiniGame_MorningHomi_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  if _ContentsGroup_ImprovedGalleyShip == true then
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_GalleyPaddle_All.XML", "Panel_MiniGame_GalleyPaddle_All", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_GuildWarInfo_All.XML", "Panel_GuildWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_Window_GuildWarInfoSmall_All.XML", "Panel_GuildWarInfoSmall_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_GuildWarScore_All.XML", "Panel_GuildWarScore_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_All.XML", "Panel_GuildHouse_Auction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_Detail_All.XML", "Panel_GuildHouse_Auction_Detail_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_Bid_All.XML", "Panel_GuildHouse_Auction_Bid_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Auction/Panel_Masterpiece_Auction_All.XML", "Panel_Masterpiece_Auction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Auction/Panel_Masterpiece_Auction_Bid_All.XML", "Panel_Masterpiece_Auction_Bid_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_All.xml", "Panel_CharacterInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Basic_All.xml", "Panel_CharacterInfoBasic_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Life_All.xml", "Panel_CharacterInfoLife_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Title_All.xml", "Panel_CharacterInfoTitle_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_History_All.xml", "Panel_CharacterInfoHistory_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_FootPrint_All.xml", "Panel_CharacterInfoFootPrint_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Challenge_All.xml", "Panel_CharacterInfoChallenge_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_CashBuff_All.xml", "Panel_CharacterInfoCashBuff_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_BuffDetailBoard == true then
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_BuffDetail_All.xml", "Panel_CharacterInfo_BuffDetail", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/LifeRanking/Panel_LifeRanking_All.xml", "Panel_LifeRanking_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Recommand/Console/Panel_Window_Recommand_Renew.xml", "Panel_RecommandName_Renew", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Atoraxion/Panel_Window_Atoraxion_Enter_All.XML", "Panel_Atoraxion_Enter", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/WeaponChange/Panel_Widget_WeaponChange.XML", "Panel_Atoraxion_WeaponChange", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_Atoraxxion_Clear.XML", "Panel_Atoraxion_NakClear", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/Region/Region_Atoraxxion.XML", "Panel_Atoraxion_RegionChange", UIGroup.PAGameUIGroup_SimpleTooltip)
  loadUI("UI_Data/Window/Atoraxion/Panel_Window_Atoraxion_Select_All.XML", "Panel_Atoraxion_Select", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guide/Panel_Window_Guide_All.XML", "Panel_Window_Guide_All", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_AtoraxionSea then
    basicLoadUI("UI_Data/Window/Movie/UI_AtoraxionMovie.xml", "Panel_AtoraxionMovie", UIGroup.PAGameUIGroup_IntroMovie)
  end
  if true == _ContentsGroup_InstanceFreeBatttleField then
    basicLoadUI("UI_Data/Window/InstanceField/Panel_PlayBattle_All.XML", "Panel_FreeBattleField_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_DragonPalace then
    basicLoadUI("UI_Data/Window/InstanceField/Panel_DragonPalace_Match_All.XML", "Panel_DragonPalace_Match_All", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_RedBattleFieldMatching == true then
    basicLoadUI("UI_Data/Window/LocalWar/Panel_LocalWarInfo_All.xml", "Panel_LocalWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  elseif true == _ContentsGroup_InstanceLocalWar then
    basicLoadUI("UI_Data/Window/LocalWar/Panel_LocalWarInfo_All_New.xml", "Panel_LocalWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/LocalWar/Console/Panel_Window_LocalWarRule_Renew.xml", "Panel_LocalWarRule", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CompetitionGame/Panel_CompetitionGame.XML", "Panel_CompetitionGame", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_All.XML", "Panel_Window_Solrare_Matching", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_MatchConfirm_All.XML", "Panel_Popup_Solare_MatchConfirm", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_SolareRank_All.XML", "Panel_Solrare_Ranking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_OtherInfo.XML", "Panel_Solrare_OtherInfo", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Finding_Match_All.XML", "Panel_Window_Solare_Finding_Match", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Equip_Set_BlackBG.XML", "Panel_Solrare_EquipPresetBlockBg", UIGroup.PAGameUIGroup_WorldMap)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Equip_Set.XML", "Panel_Solrare_EquipPresetList", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_CrystalConfirm_All.XML", "Panel_Popup_Solare_CrystalConfirm_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_BuyEquipment_All.XML", "Panel_Popup_Solare_BuyEquipment_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Custom_All.XML", "Panel_Window_Solrare_CustomMatching", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Custom_Invite_All.XML", "Panel_Window_Solrare_CustomMatching_Invite", UIGroup.PAGameUIGroup_WorldMap_Popups)
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_Hud.XML", "Panel_Widget_Solare_Hud", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_PlayerStatus.XML", "Panel_Widget_Solare_PlayerStatus", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_Countdown.XML", "Panel_Widget_Solare_Countdown", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Match_Score_3on3_All.XML", "Panel_Window_Solrare_RoundNotice", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay,
    RenderMode.eRenderMode_InstanceContentsCeremony
  }))
  basicLoadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_WaitOther.XML", "Panel_Widget_Solare_WaitOther", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_TierUpgrade.XML", "Panel_Widget_Solare_TierUpgrade", UIGroup.PAGameUIGroup_Interaction + 1)
  if _ContentsGroup_SolareReplay == true then
    basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_ReplayList.XML", "Panel_Window_Solrare_ReplayList", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb.XML", "Panel_Window_InstanceContentsReplayDownloadWeb", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All.XML", "Panel_Window_Arsha_Reservation_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All.XML", "Panel_Widget_Arsha_Hud_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_Func_All.XML", "Panel_Window_Arsha_Func_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaPvPSubMenu_All.XML", "Panel_Window_ArshaPvPSubMenu_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaInviteList_All.XML", "Panel_Window_Arsha_InviteList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaTeamNameChange_All.XML", "Panel_Window_Arsha_TeamNameChange_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChangeControl_All.XML", "Panel_Window_Arsha_TeamChangeControl_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Widget_Arsha_Party_All.XML", "Panel_Widget_Arsha_Party_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaSelectMember_All.XML", "Panel_Window_ArshaSelectMember_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_FuncList_All.XML", "Panel_Window_Arsha_FuncList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Looting/UI_Window_Looting.XML", "Panel_Looting", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingEject_Renew.XML", "Panel_Window_DyeingEject_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingMenu_Renew.XML", "Panel_Window_DyeingMenu_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingPalette_Renew.XML", "Panel_Window_DyeingPalette_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingPartList_Renew.XML", "Panel_Window_DyeingPartList_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingRegister_Renew.XML", "Panel_Window_DyeingRegister_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingTake_Renew.XML", "Panel_Window_DyeingTake_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/Dye/Console/Panel_Window_DyeingMain_Renew.XML", "Panel_Window_DyeingMain_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Dye
  }))
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_StatNew_All.xml", "Panel_Window_StatNew_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_StatDetail_All.xml", "Panel_Window_StatDetail_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Inventory/Panel_Window_Inventory_AutoSortFunction.XML", "Panel_Window_Inventory_AutoSortFunction", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Inventory/Panel_Window_InventoryEquip_All.xml", "Panel_Window_Inventory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Inventory/Panel_Window_InventoryEquip_Detail_All.xml", "Panel_Window_Inventory_Detail", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Inventory/Console/Panel_Window_MultiButtonPopup.xml", "Panel_Window_MultiButtonPopup", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    loadUI("UI_Data/Window/Equipment/Panel_Window_Season_Equiptment_Upgrade_All.xml", "Panel_Window_Season_Equiptment_Upgrade_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_AccessoryStepUp == true then
    loadUI("UI_Data/Window/Equipment/Panel_Window_Accessory_StepUp_All.XML", "Panel_Window_Accessory_StepUp_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/NakMessage/Panel_Widget_Nak_AccessoryStepUp_All.XML", "Panel_Widget_Nak_AccessoryStepUp_All", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/Inventory/Console/Panel_Window_CannonInven_Renew.xml", "Panel_Window_Inventory_Cannon", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Inventory/UI_Inventory_SkillCooltime_Effect_Item_Slot.XML", "Panel_Inventory_CoolTime_Effect_Item_Slot", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Popup/Console/Panel_Popup_Inventory_renew.XML", "Panel_Popup_MoveItem", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/MessageBox/UI_Win_UseItem_All.xml", "Panel_UseItem_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm.xml", "Panel_ImperialSupply_Horse_Confirm", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_SeasonItem.XML", "Panel_Window_MessageBox_SeasonItem_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All.XML", "Panel_Widget_LifeRingMenu_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/Buff/UI_BuffList_All.XML", "Panel_AppliedBuffList_Console", UIGroup.PAGameUIGroup_SkillAndBuff)
  if true == _ContentsGroup_ArtifactItem then
    basicLoadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_All.XML", "Panel_Window_Artifacts_All", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_CrystalTooltip.XML", "Panel_Equipment_Crystal_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_ArtifactsTooltip.XML", "Panel_Equipment_Artifacts_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/ExtendExpiration/Console/Panel_ExtendExpiration_Renew.XML", "Panel_ExtendExpiration_Renew", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_RestoreItem then
    basicLoadUI("UI_Data/Window/Inventory/Panel_Window_Restore_All.XML", "Panel_Window_Restore_All", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/LordMenu/Panel_Window_LordMenu_All.XML", "Panel_Window_LordMenu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_VillageWar_All.XML", "Panel_Worldmap_NodeTooltip_VillageWar_All", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/NodeWarMenu/Console/Panel_NodeWarMenu_Main_Renew.XML", "Panel_NodeWarMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_MainCitadelSelect.XML", "Panel_Worldmap_MainCitadelSelect", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    loadUI("UI_Data/Window/Skill/Console/Panel_Window_Skill_Renew.XML", "Panel_Window_Skill", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_ShowCharacter_All.xml", "Panel_Window_SkillGroup_Controller", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_SkillQuickSlot_All.xml", "Panel_Window_SkillGroup_QuickSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Skill_Play_SelectType_All.xml", "Panel_Window_SkillGroup_SelectType", UIGroup.PAGameUIGroup_AlertPost, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    if _ContentsGroup_ShowOtherClassSkill == true then
      loadUI("UI_Data/Window/Skill/Panel_Window_SkillGroup_All.xml", "Panel_Window_SkillGroup_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Skill/Panel_Window_Skill_ShowAllClasses_All.xml", "Panel_Window_Skill_ShowAllClasses_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
    else
      loadUI("UI_Data/Window/Skill/Panel_Skill_Play_Main_All.xml", "Panel_Window_SkillGroup", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
    end
  end
  if true == _ContentsGroup_SkillFilter then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_Filter_All.xml", "Panel_Window_SkillFilter_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_SkillPreset then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_PresetSave_All.XML", "Panel_Window_SkillPreset", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skil_PresetMemo_All.XML", "Panel_Window_SkillPresetMemo", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    loadUI("UI_Data/Window/Skill/UI_Window_ReinforceSkill_All.xml", "Panel_Window_ReinforceSkill_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/UI_Window_SkillReinforce_All.xml", "Panel_SkillReinforce_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_SkillWindow
    }))
  else
    loadUI("UI_Data/Window/SkillAwaken/Panel_SkillAwaken_ResultOption.xml", "Panel_SkillAwaken_ResultOption", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_ALLRENDER())
    loadUI("UI_Data/Window/SkillAwaken/Console/Panel_SkillAwaken_ResultOption_Renew.XML", "Panel_SkillAwaken_ResultOption_Renew", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_ALLRENDER())
    loadUI("UI_Data/Widget/Dialogue/Console/Panel_Dialog_SkillSpecialize.xml", "Panel_Dialog_SkillSpecialize", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All.xml", "Panel_Window_BlackSpiritSkillLock_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/DailyStamp/Panel_Window_DailyStamp_All.XML", "Panel_Window_DailyStamp_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/DailyStamp/Panel_Daily_Reward_Notice_All.XML", "Panel_Daily_Reward_Notice_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  if true == _ContentsGroup_BlackSpiritAdventure then
    basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_BlackSpiritAdventure.XML", "Panel_Window_BlackSpiritAdventure", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_EventMarbleGame then
    basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_EventMarbleGame.XML", "Panel_Window_EventMarbleGame", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Copyright/Console/Panel_Window_Copyright_Renew.XML", "Panel_Window_Copyright", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy_PS.XML", "Panel_Window_PrivacyPolicy", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Policy/Panel_Window_Policy.XML", "Panel_Window_Policy", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Quest/UI_Window_Quest_Option.XML", "Panel_Window_Quest_New_Option", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Quest/UI_Window_QuestInfo_ALL.XML", "Panel_Window_QuestInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Quest/Console/UI_Window_Quest_ALL_Old.xml", "Panel_Window_Quest_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Quest/UI_Window_FavorQuest_ALL.xml", "Panel_Window_QuestTypeSet_All", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_FeverQuest and true == _ContentsGroup_WorldmapFeverQuest then
    loadUI("UI_Data/Window/Quest/UI_Widget_RandonQuestInfo_All.XML", "Panel_Widget_RandomQuestInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  basicLoadUI("UI_Data/Window/MessageBox/Panel_MessageBoxElvia.XML", "Panel_Window_MessageBoxElvia_All", UIGroup.PAGameUIGroup_FadeScreen)
  basicLoadUI("UI_Data/Widget/Popup/UI_Popup_Hadum_Warning_Quest.XML", "Panel_Popup_Hadum_Warning_Quest", UIGroup.PAGameUIGroup_Alert)
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_NPCShop_All.xml", "Panel_Dialog_NPCShop_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelectOption_All.XML", "Panel_Window_WorkerRandomSelectOption_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelect_All.XML", "Panel_Window_WorkerRandomSelect_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelectOption_Grade_All.XML", "Panel_Window_WorkerRandomSelectOption_Grade_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Console/Panel_Dialog_WorkerContract.XML", "Panel_Dialog_WorkerContract", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/RandomShop/Panel_Window_RandomShop_All.XML", "Panel_Window_RandomShop_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Inventory/Panel_Window_ClothInventory_All.XML", "Panel_Window_ClothInventory_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Inventory/Panel_Window_ClothInventory_Renew_All.XML", "Panel_Window_ClothInventory_Renew_All", UIGroup.PAGameUIGroup_Window_Progress)
  if _ContentsGroup_StaticSlot == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All.xml", "Panel_Window_NewbieInventory_StaticSlot_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  else
    loadUI("UI_Data/Window/Inventory/Panel_Window_NewbieInventory_All.xml", "Panel_Window_NewbieInventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_OneButtonBuff == true then
    basicLoadUI("UI_Data/Window/AutoBuff/Panel_Window_AutoBuff.XML", "Panel_Window_AutoBuff", UIGroup.PAGameUIGroup_Window_Progress)
  end
  loadUI("UI_Data/Widget/Roadmap/Panel_Widget_RoadMap.XML", "Panel_Window_BeginnerRoadmap", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Tooltip_BlackspiritPass.XML", "Panel_Window_BlackspiritPassTooltip", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Tooltip_BlackSpiritPass_Quest.XML", "Panel_Widget_Tooltip_BlackSpiritPass_Quest", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Season_Graduation_All.XML", "Panel_Season_Graduation_All", UIGroup.PAGameUIGroup_Siege, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Season_Graduation_MSG.XML", "Panel_Season_Graduation_MSG", UIGroup.PAGameUIGroup_WorldBossLooting, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_StackExtraction_All.XML", "Panel_Window_StackExtraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_OtherUser_AdditionalRate_All.XML", "Panel_OtherUser_AdditionalRate_All", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_EnchantStackConfirm_All.XML", "Panel_Window_EnchantStackConfirm_All", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemBox/Panel_Window_MessageBox_Edit_All.XML", "Panel_Window_MessageBox_Edit_All", UIGroup.PAGameUIGroup_SimpleTooltip + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_SpiritGroupEnchant then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member1_All.XML", "Panel_Widget_PartyEnchant_Member1_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member2_All.XML", "Panel_Widget_PartyEnchant_Member2_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member3_All.XML", "Panel_Widget_PartyEnchant_Member3_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member4_All.XML", "Panel_Widget_PartyEnchant_Member4_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_BubbleText_All.XML", "Panel_Widget_PartyEnchant_BubbleText", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_EnchantRemaster then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_Enchant_Main_All.XML", "Panel_Widget_Enchant_Main_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_Equip_All.XML", "Panel_Window_Enchant_Equip_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_Material_Select_All.XML", "Panel_Window_Enchant_Material_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_ProtectDecrease_All.XML", "Panel_Window_EnchantProtector_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_DarkStack_All.XML", "Panel_Window_EnchantStack_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_StackExtraction_All.XML", "Panel_Window_Enchant_StackExtraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_EnchantMessage_All.XML", "Panel_Window_EnchantMessage_All", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Inventory/Panel_Window_EnchantInventory_All.XML", "Panel_Window_EnchantInventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Enchant_Console_KeyGuide_All.XML", "Panel_Enchant_Console_KeyGuide", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_ValksList_All.XML", "Panel_Window_ValksList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_EnchantRenewer then
    loadUI("UI_Data/Window/Enchant/Panel_Window_AddStack_All.XML", "Panel_Window_AddStack_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/MarketPlace/Panel_Window_OTPConfirm_All.XML", "Panel_Window_OTPConfirm_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All.XML", "Panel_Window_BeginnerEnchantGuide_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_FamilyStack then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_StackStorage_All.XML", "Panel_Widget_StackStorage_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Enchant/UI_Window_Improvement_All.XML", "Panel_Window_Improvement_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Socket/UI_Win_Enchant_Socket_All.XML", "Panel_Window_Socket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_HarvestList_All then
    loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_TentInfo_All.XML", "Panel_Worldmap_TentInfo_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    basicLoadUI("UI_Data/Widget/Housing/Panel_HarvestList_All.XML", "Panel_HarvestList_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Widget/Housing/Console/Panel_Window_GardenList.XML", "Panel_Window_GardenList", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Housing/Console/Panel_Window_GardenInformation.XML", "Panel_Window_GardenInformation", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Housing/Console/Panel_Window_ResidenceList.XML", "Panel_Window_ResidenceList", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Housing/Console/Panel_Window_GardenWorkerManagement.XML", "Panel_Window_GardenWorkerManagement", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Servant/UI_TopIcon_Servant.XML", "Panel_Window_Servant", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Servant_Renew.XML", "Panel_Widget_Servant_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Wharf_Renew.XML", "Panel_Widget_Wharf_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Pet_Renew.XML", "Panel_Widget_Pet_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Garden_Renew.XML", "Panel_Widget_GardenIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_Renew.XML", "Panel_Widget_FairyIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_AutoUseBuffItem_Renew.XML", "Panel_Widget_FairyAutoUseBuffItemIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Summon_Renew.XML", "Panel_Widget_SummonIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Maid_Renew.XML", "Panel_Widget_MaidIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_GuildServant_Renew.XML", "Panel_Widget_GuildServantIcon_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/Console/Panel_Widget_HorseMp_Renew.XML", "Panel_HorseMp", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/Console/Panel_Widget_HorseHp_Renew.XML", "Panel_HorseHp", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/UI_Horse_SubMP.XML", "Panel_HorseSubMp_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/Panel_Widget_ServantSummonBoss.XML", "Panel_Widget_ServantSummonBoss", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_VehicleInfo_All.xml", "Panel_Window_VehicleInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_LinkedSkill_All.XML", "Panel_Window_LinkedSkill_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_GuildServantList_All.XML", "Panel_GuildStableList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_GuildeServant_RevivalList.xml", "Panel_GuildServant_RevivalList", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Console/Panel_Cannon_Renew.XML", "Panel_Cannon_Renew", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Window/WareHouse/Panel_Window_WareHouse_All.XML", "Panel_Window_Warehouse", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Inventory/Panel_Window_TotalSearch.XML", "Panel_Window_TotalSearch", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo.XML", "Panel_Window_ExplorePoint_UsingInfo", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if true == _ContentsGroup_CargoSell then
    loadUI("UI_Data/Window/Servant/Panel_Window_Cargo_Sell.XML", "Panel_Window_CargoSell", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/Delivery/Panel_Window_Delivery_All.XML", "Panel_Window_Delivery_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WareHouse/Panel_Window_GuildWareHouse_UseLog_All.XML", "Panel_Window_GuildWareHouseHistory", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guild/Panel_Window_Guild_QuestInfo.XML", "Panel_GuildQuestInfo_All", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WareHouse/Panel_Window_WareHouse_UseLog_All.XML", "Panel_Window_WareHouseHistory", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Delivery/UI_Window_Delivery_InformationView.XML", "Panel_Window_Delivery_InformationView", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Delivery/UI_Window_Carriage_Information.XML", "Panel_Window_Delivery_CarriageInformation", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WareHouse/Console/Panel_Window_WareHouse_FunctionPanel_All.XML", "Panel_WareHouseFunctionPanel_All", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  if _ContentsGroup_Crogdalo == true then
    loadUI("UI_Data/Widget/ServantIcon/Panel_Widget_KrogStable.XML", "Panel_Window_CrogdaloStable", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All.XML", "Panel_Dialog_ServantFunction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantInfo_All.XML", "Panel_Dialog_ServantInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantList_All.XML", "Panel_Dialog_ServantList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All.XML", "Panel_Dialog_ServantLookChange_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All.XML", "Panel_Dialog_ServantRegist_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All.XML", "Panel_Dialog_ServantTransferList_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExchange_All.XML", "Panel_Dialog_ServantExchange_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantMarket_All.XML", "Panel_Dialog_ServantMarket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All.XML", "Panel_Dialog_ServantNameRegist_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All.XML", "Panel_Dialog_ServantExchange_Fantasy_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All.XML", "Panel_Dialog_Servant_FantasySelect_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Window_SimpleStableList_All.XML", "Panel_Window_SimpleStableList_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_FantasyHorse == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All.XML", "Panel_Dialog_ServantFantasySkin", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All.XML", "Panel_Widget_Servant_FantasySkin_Complete_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantLvUpMessageBox_All.XML", "Panel_Dialog_ServantLvUpMessageBox_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantRental_All.XML", "Panel_Dialog_ServantMarket_Rental_Mating_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All.XML", "Panel_Dialog_ServantCarriageLink_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSkillManagement_All.XML", "Panel_Dialog_ServantSkillManagement_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Window_ServantRateDesc.XML", "Panel_Window_ServantRateDesc", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_PremiumLookChange.XML", "Panel_Dialog_Servant_PremiumLookChange", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSwiftTraining_All.XML", "Panel_Dialog_ServantSwiftTraining_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSwiftResult_All.XML", "Panel_Dialog_ServantSwiftResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All.XML", "Panel_Dialog_ServantOnlyList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_HorseSimulator == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSimulator.XML", "Panel_Dialog_ServantSimulator", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView.XML", "Panel_Dialog_ServantSimulatorSubView", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_LifeSimulator == true then
    loadUI("UI_Data/Window/Alchemy/Panel_Alchemy_RateViewList_All.XML", "Panel_Alchemy_RateViewList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_ServantLevelDown == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All.XML", "Panel_Dialog_HorseLevelDecrease_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetRegister_All.XML", "Panel_Window_PetRegister_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetListNew_All.XML", "Panel_Window_PetList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetInfo_All.XML", "Panel_Window_PetInfo_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetLookChange_All.XML", "Panel_Window_PetLookChange_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetComposeNew_All.XML", "Panel_Window_PetFusion_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_PetCommand_All.XML", "Panel_Window_PetCommand_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetSkillChange_All.XML", "Panel_Window_PetSkillChange_All", UIGroup.PAGameUIGroup_Window_Progress_Child)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_GroupEdit_All.XML", "Panel_Window_GroupEdit_All", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_PetSkillPercent then
    basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetSkill_Percent_All.XML", "Panel_Window_PetSkill_Percent_All", UIGroup.PAGameUIGroup_HouseInfo)
  end
  if true == _ContentsGroup_isFairy then
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyRegister_ALL.XML", "Panel_Window_FairyRegister_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyChoiseTheReset_ALL.XML", "Panel_Window_FairyChoiceTheReset_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySetting_ALL.XML", "Panel_Window_FairySetting_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyGrowth_ALL.XML", "Panel_Window_FairyGrowth_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Fairyinfo_ALL.XML", "Panel_FairyInfo_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkill_ALL.XML", "Panel_Window_FairySkill_All", UIGroup.PAGameUIGroup_Window_Progress)
    if _ContentsGroup_FairyTierUpgradeAndRebirth then
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyTierUpgrade_ALL.XML", "Panel_Window_FairyTierUpgrade_All", UIGroup.PAGameUIGroup_Window_Progress)
    end
    if _ContentsGroup_FairyChangeSkill then
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyChangeSkill_All.XML", "Panel_Window_FairyChangeSkill_All", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkillChange_Viewhelp_ALL.XML", "Panel_FairySkillChange_Viewhelp", UIGroup.PAGameUIGroup_Window_Progress)
    end
    if _ContentsGroup_FairyLookChange == true then
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkinChange_All.XML", "Panel_Window_FairySkinChange_All", UIGroup.PAGameUIGroup_Windows)
    end
  end
  basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidList_All.XML", "Panel_Window_MaidList_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_MaidActorSystem == true then
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorList_All.XML", "Panel_Window_MaidActorList_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorRegist_All.XML", "Panel_Window_MaidActorRegist_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorChangeCloth_All.XML", "Panel_Window_MaidActorChangeCloth_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_ChangeMaidActorName_All.XML", "Panel_Window_ChangeMaidActorName_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Camp/Panel_Icon_Camp.XML", "Panel_Icon_Camp", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_All.XML", "Panel_Window_Camp_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_Warehouse_All.XML", "Panel_Window_CampWarehouse_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Camp/Panel_Window_CampRegister.XML", "Panel_Window_CampRegister", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_VillaBuff_All.xml", "Panel_Window_BuildingBuff_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Duel/Panel_Icon_Duel.XML", "Panel_Icon_Duel", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Exchange/UI_Window_Exchange.XML", "Panel_Window_Exchange", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Exchange/Panel_Window_ExchangeNumber_All.XML", "Panel_Window_NumberPad_All", UIGroup.PAGameUIGroup_SimpleTooltip + 2, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_RoseWar,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_IngameCustomize,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/FadeScreen/UI_Fade_Screen.XML", "Panel_Fade_Screen", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Window/FadeScreen/Panel_FullScreenFade.XML", "Panel_FullScreenFade", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  if false == _ContentsGroup_NewUI_Mail_All then
    basicLoadUI("UI_Data/Window/Mail/Console/Panel_Window_Mail_Renew.xml", "Panel_Window_Mail_Renew", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Mail/Console/Panel_Window_MailDetail_Renew.xml", "Panel_Window_MailDetail_Renew", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Mail/Panel_Window_Mail_All.xml", "Panel_Window_Mail_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Mail/Panel_Window_MailDetail_All.xml", "Panel_Window_MailDetail_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Mail/Console/Panel_Widget_NewMailAlarm_Renew.xml", "Panel_Widget_NewMailAlarm_Renew", UIGroup.PAGameUIGroup_ModalDialog)
  if _ContentsGroup_FishingEncyclopedia == true then
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All_New.XML", "Panel_Window_FishEncyclopedia_Renewal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_FishSize_Update.XML", "Panel_Window_EncyclopediaNotice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  else
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All.XML", "Panel_Window_FishEncyclopedia_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if _ContentsGroup_FishCompetition == true then
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEvent_All.XML", "Panel_Window_FishCompetition", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEventMyReward_All.XML", "Panel_Window_FishCompetitionMyReward", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEventReward_All.XML", "Panel_Window_FishCompetitionRewardInfo", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/Worldmap/Panel_HouseIcon.XML", "Panel_HouseIcon", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_town_manageWorker.XML", "Panel_manageWorker", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_Working_Progress.XML", "Panel_Working_Progress", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_TentInfo.XML", "Panel_Worldmap_TentInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_TradeNpcItemInfo.XML", "Panel_TradeNpcItemInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_Console.XML", "Panel_Worldmap_Console", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeInfo_Console.XML", "Panel_Worldmap_NodeInfo_Console", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_CraftTooltip.XML", "Panel_Worldmap_CraftTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_Finance.XML", "Panel_Worldmap_Finance", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseManagement.XML", "Panel_Worldmap_HouseManagement", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_GuildHouseManagement.XML", "Panel_Worldmap_GuildHouseManagement", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_BuyHouse.XML", "Panel_Worldmap_BuyHouse", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_RingMenu_Renew.XML", "Panel_Worldmap_RingMenu", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_TopMenu_Renew.XML", "Panel_Worldmap_TopMenu", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_BottomMenu_Renew.XML", "Panel_Worldmap_BottomMenu", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeInfo_Renew.XML", "Panel_Worldmap_NodeInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeManagement_Renew.XML", "Panel_Worldmap_NodeManagement", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_RightMenu_Renew.XML", "Panel_Worldmap_RightMenu", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_StableList_Renew.XML", "Panel_Worldmap_Stable", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseFilter_Renew.XML", "Panel_Worldmap_HouseFilter", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeProduct_Renew.XML", "Panel_Worldmap_NodeProduct", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseCraft_Renew.XML", "Panel_Worldmap_HouseCraft", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseCraftMassiveProduction_Renew.XML", "Panel_Worldmap_HouseCraftLarge", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_TerritoryTooltip_Renew.XML", "Panel_Worldmap_TerritoryTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeSiegeTooltip_Renew.XML", "Panel_Worldmap_NodeSiegeTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_SellBuyCondition.XML", "Panel_Worldmap_SellBuyCondition", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_Worldmap_WarFilter_Renew.XML", "Panel_Worldmap_WarFilter_Renew", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_Territory.XML", "Panel_Worldmap_Territory", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_QuestInfo_All.XML", "Panel_QuestInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_WorldMap_Tooltip.XML", "Panel_WorldMap_Tooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/WorldMap/UI_New_Worldmap_PartyMemberTail.XML", "Panel_WorldMap_PartyMemberTail", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/WorldMap/UI_New_Worldmap_PartyMemberIcon.XML", "Panel_WorldMap_PartyMemberIcon", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_All.XML", "Panel_WorldMap_NodeTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_WarInfomation_Renew.XML", "Panel_Window_InstallationMode_WarInformation_Renew", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Panel_WorldMap_StableList.XML", "Panel_WorldMap_StableList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if true == _ContentsGroup_WorldMapNodeNavigation then
    loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NodeCal.XML", "Panel_Worldmap_NodeCal", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  end
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NodeLevel.XML", "Panel_Worldmap_NodeLevel", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Exchange/Panel_Window_UseCharacterWp_all.XML", "Panel_Window_UseCharacterWp_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_FamilyCharacter_Pin_All.XML", "Panel_Worldmap_FamilyCharacter_Pin_All", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_FamilyCharacter_List_All.XML", "Panel_Worldmap_FamilyCharacter_List_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/ChangeName/Panel_Window_ChangeCharacterMemo_All.XML", "Panel_Window_FamilyCharacterChangeMemo_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Widget/WarInfoMessage/Panel_WarInfoMessage.XML", "Panel_WarInfoMessage", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWarKillingScore.XML", "Panel_TerritoryWarKillingScore", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  basicLoadUI("UI_Data/Widget/Alert/Panel_Alert_Message.XML", "Panel_Alert_Message", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft.XML", "Worldmap_Grand_GuildCraft", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft_ChangeWorker.XML", "Worldmap_Grand_GuildCraft_ChangeWorker", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ClanList_All.XML", "Panel_Window_ClanList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Cover_All.XML", "Panel_GuildMain_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Main_All.XML", "Panel_GuildInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Warfare_All.XML", "Panel_GuildWarfare_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_WarfareNew_All.XML", "Panel_GuildWarfareNew_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_History_All.XML", "Panel_Guild_History_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_BossSummon_All.XML", "Panel_Guild_BossSummon_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_GoToWar_All.XML", "Panel_GuildDeclareWar_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Introduce_All.XML", "Panel_GuildIntroduce_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Deposit_All.XML", "Panel_GuildDeposit_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_AttributeReport_All.XML", "Panel_GuildAttributeReport_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ActivityFunds_List_All.XML", "Panel_Window_GuildActivityFunds_List_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ActivityFunds_Option_All.XML", "Panel_Window_GuildActivityFunds_Option_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_DocumentManagement_All.XML", "Panel_Window_GuildDocumentManagement_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_IncentiveOption_All.XML", "Panel_Window_GuildIncentiveSetting_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MemberPointDetail_All.XML", "Panel_Window_GuildMemberPointDetail_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_PointOption_All.XML", "Panel_Window_GuildPointOption_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_PointMenu_All.XML", "Panel_Window_GuildPointMenu_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildPresent_All.XML", "Panel_Window_GuildPresent", UIGroup.PAGameUIGroup_GameMenu)
  if true == ToClient_isPS() then
    basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildIntro_All.XML", "Panel_GuildIntro_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_GuildQuestAndSkillImprove == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_QuestList_All.XML", "Panel_GuildQuestList_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Quest_All.XML", "Panel_GuildQuest_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Manufacture_All.XML", "Panel_Guild_Manufacture_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ManufactureInfo_All.XML", "Panel_Guild_ManufactureSelect_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AllianceMain_All.XML", "Panel_GuildAlliance_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AlianceList_All.XML", "Panel_GuildAllianceList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AllianceInvite_All.XML", "Panel_GuildAllianceInvite_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Skill_All.XML", "Panel_GuildSkill_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MemberList_All.XML", "Panel_GuildMemeberList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildMatch_All.XML", "Panel_GuildMatch_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_GuildMatch == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatchScore_All.XML", "Panel_Window_GuildMatchScore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatch_GameRecord.XML", "Panel_Window_GuildMatch_GameRecord", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Widget_GuildMatch_Countdown.XML", "Panel_Widget_GuildMatch_Countdown", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatch_Rank.XML", "Panel_Window_GuildMatch_Rank", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_KillCombo.XML", "Panel_NakMessage_KillCombo", UIGroup.PAGameUIGroup_Widget)
  end
  if true == _ContentsGroup_Guild_JoinRequest then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_RequestList_All.XML", "Panel_GuildJoinRequestList_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Volunteer_All.XML", "Panel_GuildVolunteerList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Max_Incentive_All.XML", "Panel_GuildIncentive_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Incentive_All.XML", "Panel_GuildIncentiveOption_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_FunctionPanel_All.XML", "Panel_GuildFunctionPanel_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MarkSelect_All.XML", "Panel_GuildChangeMark_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildVoiceSet_All.XML", "Panel_GuildVoiceSet_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_UseGuildFunds_All.XML", "Panel_GuildUseFund_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_AgreementGuild_All.XML", "Panel_GuildAgreement_Console_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_Guild_SignOption_All.XML", "Panel_GuildAgreementOption_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildMemberInfo_All.XML", "Panel_Guild_MemberInfo_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildReceivePay_All.XML", "Panel_GuildReceivePay_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_SetGuildHouse_All.XML", "Panel_SelectGuildMansion_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildWarfareDesc_Renew.XML", "Panel_Window_GuildWarfareDesc_Renew", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildAlliance_Invitation.XML", "Panel_GuildAlliance_Invitation", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Guild/Panel_CreateClan_All.XML", "Panel_CreateClan_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guild/Panel_Guild_Create_All.XML", "Panel_Guild_Create_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_GuildAuthoritySeparation == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Authorization_All.XML", "Panel_Guild_Authorization_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  loadUI("UI_Data/Widget/QuestList/Console/Panel_GuildQuest_Renew.XML", "Panel_Widget_GuildQuest", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if ToClient_isPS() then
    basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_GuildIntro_Renew.XML", "Panel_Window_Guild_Introduction_Renew", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Window_Clan_Renew.XML", "Panel_Window_Clan_Renew", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_Guild_JoinRequest then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_NoneGuild_All.XML", "Panel_Guild_NoneGuild", UIGroup.PAGameUIGroup_Window_Progress)
    if true == _ContentsGroup_NewGuildNone then
      basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_IntroduceMySelf.XML", "Panel_Guild_IntroduceMySelf", UIGroup.PAGameUIGroup_Alert)
    end
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_ApplyJoinList_All.XML", "Panel_Guild_ApplyJoinList", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_JoinRequestSet_All.XML", "Panel_Guild_JoinRequestSet", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_NoneJoinMember.XML", "Panel_Guild_NoneJoinMember", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_GuildServerWar then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MainServerSet_All.XML", "Panel_Guild_MainServerSet_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_ChoiseTheMoney.XML", "Panel_Guild_ChoiseTheMoney", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Window/Guild/Panel_CreateClan.XML", "Panel_CreateClan", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_ClanToGuild.XML", "Panel_ClanToGuild", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_AgreementGuild.XML", "Panel_AgreementGuild", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_AgreementGuild_Master.XML", "Panel_AgreementGuild_Master", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildIncentive.XML", "Panel_GuildIncentive", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Guild_Incentive_Foundation_Renew.XML", "Panel_Guild_Incentive_SetFund", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Guild_Incentive_Renew.XML", "Panel_Guild_Incentive_MemberList", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Console/Panel_Guild_Incentive_Tier_Renew.XML", "Panel_Guild_Incentive_Tier", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_NewGuildNone then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_SimpleInvite.XML", "Panel_Window_Guild_SimpleInvite", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_Widget_GuildInvite_Alert.XML", "Panel_GuildInvite_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_InviteList.XML", "Panel_Guild_InviteList", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_ClanList.XML", "Panel_ClanList", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Journal.XML", "Panel_Guild_Journal", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Rank.XML", "Panel_Guild_Rank", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildRank_Web.XML", "Panel_GuildRank_Web", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildWebInfo.XML", "Panel_GuildWebInfo", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildWatchingMode.XML", "Panel_GuildBattleWatchingMode", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_GuildWar.XML", "Panel_Widget_GuildWarAlert_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/c_Option/Console/Panel_Window_OptionMain_Renew.XML", "Panel_Window_Option_Main", UIGroup.PAGameUIGroup_Windows)
  if ToClient_isXBox() then
    basicLoadUI("UI_Data/Window/KeyboardHelp/console/Panel_Window_KeyGuide.XML", "Panel_Window_KeyGuide", UIGroup.PAGameUIGroup_Windows)
  elseif ToClient_isPS5() == true then
    basicLoadUI("UI_Data/Window/KeyboardHelp/console/Panel_Window_KeyGuide_PS5.XML", "Panel_Window_KeyGuide", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/KeyboardHelp/console/Panel_Window_KeyGuide_PS.XML", "Panel_Window_KeyGuide", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Option/Panel_SetShortCut.XML", "Panel_SetShortCut", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_UISetting,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/MessageBox/Console/Panel_MessageBox_Loading.XML", "Panel_MessageBox_Loading", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Knowledge/Console/Panel_Window_Knowledge_Renew.XML", "Panel_Window_Knowledge_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/MentalKnowledge/Console/Panel_MentalGame_Center.XML", "Panel_MentalGame_Center", UIGroup.PAGameUIGroup_Movie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Left_All.XML", "Panel_MentalGameLeft_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Right_List_All.XML", "Panel_MentalGameRight_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Select_All.XML", "Panel_MentalGameSelect_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Tooltip_All.XML", "Panel_MentalGameTooltip_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Widget/Damage/UI_Damage.XML", "Panel_Damage", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/QuestList/Field_QuestIcon.XML", "Panel_fieldQuest", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_Endurance.XML", "Panel_Endurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_HorseEndurance.XML", "Panel_HorseEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_CarriageEndurance.XML", "Panel_CarriageEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_ShipEndurance.XML", "Panel_ShipEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_SailShipEndurance.XML", "Panel_SailShipEndurance", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/Repair/Panel_Dialog_Repair_Function_All.XML", "Panel_Dialog_Repair_Function_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Repair/Panel_Window_SetupRepair_All.XML", "Panel_Window_SetupRepair_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Endurance_Recovery_All.XML", "Panel_Window_Endurance_Recovery_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Repair/Panel_FixEquip.XML", "Panel_FixEquip", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Repair/Panel_LuckyRepair_Result.XML", "Panel_LuckyRepair_Result", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Crystal_All.XML", "Panel_Window_Extraction_Crystal_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Costume_All.XML", "Panel_Window_Extraction_Costume_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_System_All.XML", "Panel_Window_Extraction_System_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Blackstone_All.XML", "Panel_Window_Extraction_EnchantStone_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Caphras_All.XML", "Panel_Window_Extraction_Caphras_All", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All.XML", "Panel_Window_Extraction_Artifacts_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Extraction/UI_Window_Extraction_Result.XML", "Panel_Window_Extraction_Result", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Extraction/Panel_Window_Extraction_Function_All.XML", "Panel_Window_Extraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/UI_Window_SpiritEnchant_Extraction.XML", "Panel_EnchantExtraction", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Arena/Panel_Arena_Battle.XML", "Panel_Arena_Battle", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Arena/Panel_Window_Arena_Waiting.XML", "Panel_Arena_Waiting", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_CharacterTag_ALL.XML", "Panel_CharacterTag_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_Icon_CharacterTag.XML", "Panel_Icon_CharacterTag", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/MainStatus/UI_SelfPlayer_Main_Slot_User_Bar.XML", "Panel_MainStatus_User_Bar", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MainStatus/Console/Panel_Widget_MainStatus_Renew.XML", "Panel_SelfPlayerExpGage", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_FamilyBuff_New.XML", "Panel_PersonalIcon_Left", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_MainStatus_New.XML", "Panel_MainStatus_Remaster", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Console/Panel_Widget_CastingBar_Renew.XML", "Panel_Casting_Bar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_EscapeBar_All.XML", "Panel_Widget_EscapeBar_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow
  }))
  basicLoadUI("UI_Data/Widget/MainStatus/PvpMode_Button.XML", "Panel_PvpMode", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/MainStatus/Panel_Adrenallin.XML", "Panel_Adrenallin", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Console/Panel_Widget_GuardGauge_Renew.XML", "Panel_GuardGauge", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_AutoTraining.XML", "Panel_AutoTraining", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/RightTopIcons/Console/Panel_Widget_FunctionButton_Renew.XML", "Panel_Widget_FunctionButton_Renew", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Window/DropItem/Panel_Window_DropItem_All_Renew.XML", "Panel_Window_DropItem_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All.XML", "Panel_Window_DropItem_ImageTooltip_All", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/MovieGuide/Panel_MovieGuide.XML", "Panel_MovieGuide", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_FeverBuff then
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_AgrisGauge.XML", "Panel_Widget_AgrisGauge", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip.XML", "Panel_Widget_AgrisGaugeTooltip", UIGroup.PAGameUIGroup_SimpleTooltip)
  end
  if _ContentsGroup_LandscapePainting then
    basicLoadUI("UI_Data/Window/DropItem/Panel_Window_LandscapePaintingDrop_All.XML", "Panel_Window_LandscapePaintingDrop", UIGroup.PAGameUIGroup_Interaction)
  end
  if _ContentsGroup_PalaceManagement then
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_All.XML", "Panel_Window_PalaceManagement_Map", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_PalaceManagement_Tooltip.XML", "Panel_Window_PalaceManagement_Tooltip", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_Node_All.XML", "Panel_Window_PalaceManagement_Node", UIGroup.PAGameUIGroup_Windows + 2, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_WorkManager.XML", "Panel_Window_PalaceManagement_WorkManager", UIGroup.PAGameUIGroup_Windows + 3, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if true == _ContentsGroup_HopeGauge then
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_HopeGauge.XML", "Panel_Widget_HopeGauge", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff_Renew.XML", "Panel_Widget_HopeGaugeOnOff", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/MainStatus/Console/Panel_HopeGauge_Console.XML", "Panel_Widget_HopeGauge_Console", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_ImportantKnowledge.XML", "Panel_ImportantKnowledge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_Knowledge_Main.XML", "Panel_NewKnowledge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_NormalKnowledge.XML", "Panel_NormalKnowledge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/NewEquip/Console/Panel_NewEquip_Console.XML", "Panel_NewEquip", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/NakMessage/Console/Panel_Widget_NakMessage_Renew.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/NakMessage/NakMessage_Renewel.XML", "Panel_NakMessage_Renewel", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessage_MSG_SEQUENCE.XML", "Panel_NakMessage_Sequence", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Widget_Chatting_Renew.XML", "Panel_Widget_Chatting_Renew", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_ChattingHistory_Renew.XML", "Panel_Window_ChattingHistory_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Widget_ChattingViewer_Renew.XML", "Panel_Widget_ChattingViewer_Renew", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_Chatting_BlockList.XML", "Panel_Chatting_BlockList", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_Chatting_FunctionList.XML", "Panel_Chatting_FunctionList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Important_Notice.XML", "Panel_Important_Notice", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/UI_Window_ChatOption.XML", "Panel_ChatOption", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/UI_Window_Chatting_Input.XML", "Panel_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SniperGame
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Filter.XML", "Panel_Chatting_Filter", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Macro.XML", "Panel_Chatting_Macro", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SocialMenu.XML", "Panel_Chat_SocialMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SubMenu.XML", "Panel_Chat_SubMenu", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Color.XML", "Panel_Chatting_Color", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Chatting/Panel_Window_Join_ChannelChat.XML", "Panel_Window_ChannelChat", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Chatting/Panel_Window_ChannelChat_Wait.XML", "Panel_Widget_ChannelChat_Loading", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Report/Panel_Window_Chat_Report_All.XML", "Panel_Window_Chat_Report_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTips.XML", "Panel_GameTips", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTipsMask.XML", "Panel_GameTipMask", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/GameTips/UI_Window_GameTips.XML", "Panel_Window_GameTips", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Widget/NoticeAlert/NoticeAlert.XML", "Panel_NoticeAlert", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/UI_Panel_QuickSlot.XML", "Panel_QuickSlot", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/QuickSlot/Panel_NewQuickSlot.XML", "Panel_NewQuickSlot", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_0.XML", "Panel_NewQuickSlot_0", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_1.XML", "Panel_NewQuickSlot_1", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_2.XML", "Panel_NewQuickSlot_2", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_3.XML", "Panel_NewQuickSlot_3", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_4.XML", "Panel_NewQuickSlot_4", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_5.XML", "Panel_NewQuickSlot_5", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_6.XML", "Panel_NewQuickSlot_6", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_7.XML", "Panel_NewQuickSlot_7", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_8.XML", "Panel_NewQuickSlot_8", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_9.XML", "Panel_NewQuickSlot_9", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_10.XML", "Panel_NewQuickSlot_10", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_11.XML", "Panel_NewQuickSlot_11", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_12.XML", "Panel_NewQuickSlot_12", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_13.XML", "Panel_NewQuickSlot_13", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_14.XML", "Panel_NewQuickSlot_14", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_15.XML", "Panel_NewQuickSlot_15", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_16.XML", "Panel_NewQuickSlot_16", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_17.XML", "Panel_NewQuickSlot_17", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_18.XML", "Panel_NewQuickSlot_18", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_19.XML", "Panel_NewQuickSlot_19", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_QuickView.XML", "Panel_SkillCooltime", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/Panel_SkillCoolTimeQuickSlot.XML", "Panel_SkillCoolTimeQuickSlot", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Stamina/Console/Panel_Widget_Stamina_Renew.XML", "Panel_Stamina", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Stamina/CannonGauge.XML", "Panel_CannonGauge", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Stamina/Panel_Widget_Stamina_Auto.XML", "Panel_Stamina_Auto", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Housing/UI_Panel_Housing.XML", "Panel_Housing", UIGroup.PAGameUIGroup_Housing)
  if true == _ContentsGroup_NewUI_InstallMode_All then
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_All.XML", "Panel_House_InstallationMode_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_List_All.XML", "Panel_House_InstallationMode_List_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_ObjectControl_All.XML", "Panel_House_InstallationMode_ObjectControl_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_SeedList_All.XML", "Panel_House_InstallationMode_SeedList_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Widget/Housing/Panel_Housing_FarmInfo_All.XML", "Panel_Housing_FarmInfo_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_WarInfomation_All.XML", "Panel_House_InstallationMode_WarInfomation_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Widget/Housing/Panel_House_Name_All.XML", "Panel_House_Name_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_War_All.XML", "Panel_House_InstallationMode_War_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
  else
    loadUI("UI_Data/Widget/Housing/Console/Panel_Widget_HousingName_Renew.XML", "Panel_HouseName", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_HousePoint_Renew.XML", "Panel_Window_InstallationMode_HousePoint", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_PlantInfo_Renew.XML", "Panel_House_InstallationMode_PlantInfo", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_HouseInfo_Renew.XML", "Panel_House_InstallationMode", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_FarmInfo_Renew.XML", "Panel_House_InstallationMode_Farm", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_Item_Renew.XML", "Panel_House_InstallationMode_Item", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_ObjectControl.XML", "Panel_House_InstallationMode_ObjectControl", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_WarInfomation.XML", "Panel_House_WarInformation", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_Cart_New.XML", "Panel_House_InstallationMode_Cart", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
  end
  loadUI("UI_Data/Window/Worldmap_Grand/Console/Panel_WorldMap_WarInfo_Renew.xml", "Panel_WorldMap_WarInfo_Renew", UIGroup.PAGameUIGroup_MainUI, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Console/Panel_Worldmap_NodeWarInfo_Renew.XML", "Panel_Worldmap_NodeWarInfo_Renew", UIGroup.PAGameUIGroup_MainUI, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/ChangeName/Panel_Window_ChangeNickname_All.XML", "Panel_Change_Nickname_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/ChangeName/Panel_NameSwapExchange.XML", "Panel_ExchangeNickname", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Housing/Console/Panel_Window_InstallationMode_VillageTentPopUp_Renew.XML", "Panel_Window_InstallationMode_VillageTentPopUp_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_HouseInstallation
  }))
  basicLoadUI("UI_Data/Widget/ProgressBar/Console/Panel_Widget_CollectBar_Renew.XML", "Panel_Collect_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/Console/Panel_Widget_ProductBar_Renew.XML", "Panel_Product_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/Console/Panel_Widget_EnchantBar_Renew.XML", "Panel_Enchant_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/Dialogue/UI_Npc_Dialog_Scene.xml", "Panel_Dialog_Scene", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Console/Panel_Dialog_DetectPlayer.xml", "Panel_DetectPlayer", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Console/Panel_Window_KnowledgeManage_Renew.XML", "Panel_Window_KnowledgeManage_Renew", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Exchange_Item.xml", "Panel_Exchange_Item", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Intimacy_All.xml", "Panel_Npc_Intimacy_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_ButtonList_All.XML", "Panel_Dialog_List_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Exchange_All.XML", "Panel_Dialog_Exchange_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Quest_Reward_All.xml", "Panel_Dialog_Quest_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Interest_Knowledge_All.XML", "Panel_Interest_Knowledge_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Dialog_All.xml", "Panel_Npc_Dialog_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_PetLeader_All.xml", "Panel_Dialog_PetLeader_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_PetLeader_List_All.xml", "Panel_Dialog_PetLeader_List_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_HorseWithoutOwner.XML", "Panel_Dialog_HorseWithoutOwner_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Dialog_Itemtake_ALL.xml", "Panel_Dialogue_Itemtake_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/ItemLog/Panel_Widget_QuestRewardItem.xml", "Panel_Widget_QuestRewardItem", UIGroup.PAGameUIGroup_Window_Progress - 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_NpcGift_All.xml", "Panel_Dialog_NpcGift_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/QuestList/NewQuest.XML", "Panel_NewQuest", UIGroup.PAGameUIGroup_Chatting)
  loadUI("UI_Data/Widget/Menu/Panel_Menu.XML", "Panel_Menu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_UISetting
  }))
  basicLoadUI("UI_Data/Widget/SkillLog/Panel_Widget_SkillLog.XML", "Panel_Widget_SkillLog", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/ItemLog/Panel_Widget_ItemLog_Renew.XML", "Panel_Widget_ItemLog_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/LvUpMessage/UI_Levelup_Reward.XML", "Panel_Levelup_Reward", UIGroup.PAGameUIGroup_Chatting)
  basicLoadUI("UI_Data/Widget/Acquire/Acquire.XML", "Panel_Acquire", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SkillWindow
  }))
  loadUI("UI_Data/Widget/Acquire/Acquire_QuestDirect.XML", "Panel_QuestDirect", UIGroup.PAGameUIGroup_Chatting, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_customScreenShot
  }))
  loadUI("UI_Data/Widget/AlertArea/Panel_Widget_QuestAlert.XML", "Panel_Widget_QuestAlert", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/EnemyGauge/Console/Panel_Widget_EnemyGauge_Renew.XML", "Panel_Monster_Bar", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SniperGame,
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Region/Region.XML", "Panel_Region", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/Alert/Panel_Widget_LocalQuestAlert.xml", "Panel_Widget_LocalQuestAlert", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_isUsedNewCharacterInfo == false then
    basicLoadUI("UI_Data/Widget/PotencialUp/UI_Potencial_Up.xml", "Panel_Potencial_Up", UIGroup.PAGameUIGroup_Chatting)
  else
    basicLoadUI("UI_Data/Widget/PotencialUp/UI_Potencial_Up_New.xml", "Panel_Potencial_Up", UIGroup.PAGameUIGroup_Chatting)
  end
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_WhereUseTargetItem.XML", "Panel_WhereUseItemDirection", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/Party/Panel_Widget_Party_All.xml", "Panel_Widget_Party_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Party/Panel_Widget_Raid_All.xml", "Panel_Widget_Raid_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Party/Console/Panel_Window_PartyInvite.XML", "Panel_Window_PartyInvite", UIGroup.PAGameUIGroup_InstanceMission)
  basicLoadUI("UI_Data/Window/Party/Console/Panel_Window_PartySetting.XML", "Panel_Window_PartySetting", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/QuestList/ProgressGuildQuest.XML", "Panel_Current_Guild_Quest", UIGroup.PAGameUIGroup_Dialog)
  loadUI("UI_Data/Widget/QuestList/Panel_CheckedQuest.XML", "Panel_CheckedQuest", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/QuestList/Console/Panel_MainQuest_Renew.XML", "Panel_MainQuest", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/QuestList/Console/Panel_LatestQuest_Renew.XML", "Panel_LatestQuest", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if ToClient_HardCoreChannelWithContensOption() == true then
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_HardCore_All.xml", "Panel_CharacterInfo_HardCore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_HardCore_Basic_All.xml", "Panel_CharacterInfoBasic_HardCore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Menu_HardCore.XML", "Panel_Menu_HardCore", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_Quest_Hardcore.XML", "Panel_Widget_Quest_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_LeftTime_HardCore.XML", "Panel_Widget_LeftTime_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_Hardcore_Result_All.XML", "Panel_Window_Hardcore_Result", UIGroup.PAGameUIGroup_WorldMap_Contents)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_Compass_Hardcore.XML", "Panel_Widget_Compass_Hardcore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_HardcoreRanking.XML", "Panel_Window_HardcoreRanking", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_Quest_HardCore.XML", "Panel_Window_Quest_HardCore", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore.XML", "Panel_Widget_EnemyAlert_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter.XML", "Panel_Widget_HardCoreBlackField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  end
  basicLoadUI("UI_Data/Window/Quest/Panel_Window_QuestBranch.xml", "Panel_Window_QuestBranch", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_TotalReward then
    basicLoadUI("UI_Data/Window/RewardList/Panel_Window_TotalReward_All.xml", "Panel_Window_TotalReward_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/RewardList/Panel_Window_TotalRewardHistory_All.xml", "Panel_Window_TotalRewardHistory_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Radar/Radar.XML", "Panel_Radar", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Radar/RadarTimeBarNumber.XML", "Panel_TimeBarNumber", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Radar/RadarTimeBar.XML", "Panel_TimeBar", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Radar/Radar_NightAlert.XML", "Panel_Radar_NightAlert", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_FrameLoop_Widget.XML", "Panel_FrameLoop_Widget", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/NpcNavigation/Panel_Window_NpcNavigation_All.XML", "Panel_NpcNavi_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/NpcNavigation/UI_Tooltip_NpcNavigation_All.XML", "Panel_Tooltip_NpcNavigation_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/NaviPath/Panel_NaviPath.XML", "Panel_NaviPath", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/TownNpcNavi/Panel_Widget_TownNpcNavi.XML", "Panel_Widget_TownNpcNavi", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/VoiceChat/Panel_SetVoiceChat_All.XML", "Panel_Window_SetVoiceChat_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Voice/Console/Panel_Widget_NowVoice.XML", "Panel_Widget_Voice", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  if _ContentsGroup_CombineBag == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_CombiInventory_All.xml", "Panel_Window_CombineBag", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  basicLoadUI("UI_Data/Widget/Bubble/Bubble.XML", "Panel_Bubble", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/Interaction/Console/Panel_Widget_Interaction_Renew.XML", "Panel_Widget_PanelInteraction_Renew", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Interaction/Console/Panel_Window_HouseList_Renew.XML", "Panel_Interaction_HouseList", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_HouseRank.XML", "Panel_Interaction_HouseRank", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_House.XML", "Panel_Interaction_House", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Widget/Interaction/Panel_WatchingCommand.XML", "Panel_WatchingMode", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill.XML", "Panel_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLearning.XML", "Panel_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_BlackSpirit.XML", "Panel_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLinkTooltip.XML", "Panel_Tooltip_Skill_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_All.XML", "Panel_Tooltip_SkillGroup", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_forLearning_All.XML", "Panel_Tooltip_SkillGroup_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_BlackSpirit_All.XML", "Panel_Tooltip_SkillGroup_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_forLinkTooltip_All.XML", "Panel_Tooltip_SkillGroup_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_NextLevel_All.XML", "Panel_Tooltip_Skill_NextLevel_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item.XML", "Panel_Tooltip_Item", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItem.XML", "Panel_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItemClick.XML", "Panel_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_equipped.XML", "Panel_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Guild_Introduce.XML", "Panel_Tooltip_Guild_Introduce", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Common.XML", "Panel_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Worker.XML", "Panel_Worker_Tooltip", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Tooltip/Console/Panel_Widget_Tooltip_CraftWork.XML", "Panel_Tooltip_Work", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Tooltip/Console/Panel_Widget_Tooltip_Renew.XML", "Panel_Widget_Tooltip_Renew", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Widget/Tooltip/Console/Panel_Widget_FloatingTooltip_Renew.XML", "Panel_Widget_FloatingTooltip_Renew", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  basicLoadUI("UI_Data/Widget/Interaction/Console/Panel_Widget_UserInfo_Renew.XML", "Panel_Introduction", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect.XML", "Panel_CoolTime_Effect", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Slot.XML", "Panel_CoolTime_Effect_Slot", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item.XML", "Panel_CoolTime_Effect_Item", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item_Slot.XML", "Panel_CoolTime_Effect_Item_Slot", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/DeadMessage/Panel_DeadMessage_All.XML", "Panel_Window_DeadMessage_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/DeadMessage/Panel_Cash_Revival_BuyItem_ALL.XML", "Panel_Cash_Revival_BuyItem_All", UIGroup.PAGameUIGroup_FadeScreen)
  basicLoadUI("UI_Data/Window/DeadMessage/DangerAlert.XML", "Panel_Danger", UIGroup.PAGameUIGroup_ScreenEffect)
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All.XML", "Panel_Dialog_Trade_PriceRate_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_BiddingGame_All.XML", "Panel_Dialog_Trade_BiddingGame_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_MarketItemList_All.XML", "Panel_Dialog_Trade_MarketItemList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All.XML", "Panel_Dialog_Trade_Tooltip_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_MyBasket_All.XML", "Panel_Dialog_Trade_MyBasket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_Function_All.XML", "Panel_Dialog_Trade_Function_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All.XML", "Panel_Worldmap_Trade_MarketItemList_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All.XML", "Panel_Dialog_Trade_NoLink_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/UI_Win_Npc_TradeEventNotice_Renewal_All.xml", "Panel_Window_TradeEventNotice_Renewal_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Alchemy/Panel_Window_Alchemy_All.xml", "Panel_Window_Alchemy_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Alchemy/Panel_RecentCook_New.xml", "Panel_RecentCook", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_Friend_All.XML", "Panel_FriendList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_AddFriend_All.XML", "Panel_FriendList_Add_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Friend_Messanger_All.XML", "Panel_Friend_Messanger_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_FriendRequest_All.XML", "Panel_Friend_RequestList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_Friend_ChangeGroupName_All.XML", "Panel_Friend_GroupRename_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Alchemy/Panel_Manufacture_All.xml", "Panel_Window_Manufacture_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Alchemy/Console/Panel_Manufacture_Notify_Renew.XML", "Panel_Manufacture_Notify", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Alchemy/Console/Panel_Window_Knowledge.xml", "Panel_Widget_Knowledge", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/FieldViewMode/UI_FieldViewMode.xml", "Panel_FieldViewMode", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_UISetting
  }))
  loadUI("UI_Data/Window/GameExit/Panel_ChannelSelect_All.XML", "Panel_ChannelSelect_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/GameExit/Console/Panel_Window_ExitConfirm.XML", "Panel_Window_GameExit_Confirm", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/GameExit/Panel_Window_GameExit_All.xml", "Panel_Window_GameExit_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/Inventory/Panel_Window_SubInventory_All.XML", "Panel_Window_SimpleInventory", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Inventory/Panel_Window_SimpleInventory_SearchResult.XML", "Panel_Window_SimpleInventory_SearchResult", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/GameExit/Panel_Window_ExitConfirm_Reboot.xml", "Panel_ExitConfirm", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/DeadMessage/UI_NoAccessibleArea_Alert.xml", "Panel_NoAceessArea_Alert", UIGroup.PAGameUIGroup_ScreenEffect)
  loadUI("UI_Data/Window/ProductNote/Console/Panel_Window_ProductNode_Renew.XML", "Panel_ProductNote", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ProductNote/Console/Panel_Window_PnSearch.XML", "Panel_ProductNote_Search", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/KeyboardHelp/Panel_KeyboardHelp.XML", "Panel_KeyboardHelp", UIGroup.PAGameUIGroup_DeadMessage, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/LevelupGuide/Panel_LevelupGuide.XML", "Panel_LevelupGuide", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/QnAWebLink/Panel_QnAWebLink.XML", "Panel_QnAWebLink", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Timing_All.xml", "Panel_MiniGame_Timing_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Trained_All.xml", "Panel_MiniGame_Horse_Trained_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Skill_Trainning_All.xml", "Panel_Minigame_GradientY_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Wagon_All.xml", "Panel_Minigame_Gradient_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Rhythm_All.xml", "Panel_MiniGame_Rhythm_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Rhythm_Drum_All.xml", "Panel_MiniGame_Rhythm_Drum_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_PowerControl_All.xml", "Panel_MiniGame_PowerControl_All", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_NewUI_Fishing_All then
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Command_All.xml", "Panel_MiniGame_Command_All", UIGroup.PAGameUIGroup_MiniGameUpUI)
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_SinGauge_All.xml", "Panel_MiniGame_SinGauge_All", UIGroup.PAGameUIGroup_MiniGameUpUI)
    basicLoadUI("UI_Data/Widget/PowerGauge/Panel_Widget_PowerGauge_All.XML", "Panel_Widget_PowerGauge_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Widget/MiniGame/Console/MiniGame_SinGauge_Renew.xml", "Panel_SinGauge", UIGroup.PAGameUIGroup_MiniGameUI)
    basicLoadUI("UI_Data/Widget/MiniGame/Console/MiniGame_Command_Renew.xml", "Panel_Command", UIGroup.PAGameUIGroup_MiniGameUI)
    basicLoadUI("UI_Data/Widget/PowerGauge/Console/Panel_PowerGauge_Renew.XML", "Panel_PowerGauge", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if true == _ContentsGroup_NewUI_Jaksal_All then
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Jaksal_All.xml", "Panel_MiniGame_Jaksal_All", UIGroup.PAGameUIGroup_MainUI)
  else
    basicLoadUI("UI_Data/Widget/MiniGame/Console/MiniGame_Jaksal_Renew.xml", "Panel_MiniGame_Jaksal", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_FillGauge.xml", "Panel_FillGauge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Steal.xml", "Panel_MiniGame_Steal", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/Minagame_SteeringGear.xml", "Panel_SteeringWheel", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Hammer_New.xml", "Panel_Hammer_New", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Find_All.xml", "Panel_MiniGame_Find_All", Defines.UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_ResultMessage.xml", "Panel_MiniGame_MiniGameResult", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_MiniGame_YachtDice then
    loadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_YachtDice.XML", "Panel_Window_MiniGame_YachtDice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_Minigame_YachtDice_Result.XML", "Panel_Widget_MiniGame_YachtDice_Result", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck.XML", "Panel_Widget_MiniGame_Tooltip_MyDeck", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_Tooltip.XML", "Panel_Widget_MiniGame_Tooltip", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Notice.XML", "Panel_Widget_MiniGame_YachtDice_Notice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    basicLoadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_YachtDice_PVP_Invite.XML", "Panel_Window_MiniGame_YachtDice_PVP_Invite", Defines.UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_MiniGame_YachtDice_Match == true then
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm.XML", "Panel_Widget_MiniGame_YachtDice_MatchConfirm", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch.XML", "Panel_Widget_MiniGame_YachtDice_FindingMatch", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_RewardMarket == true then
    loadUI("UI_Data/Window/Dialog/Panel_Window_RewardMarket_All.XML", "Panel_Window_RewardMarket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Actor/UI_Actor_DummyCharacter_CC.XML", "Panel_Actor_DummyCharacter_CC", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_LocalWarOccupation_Gauge.XML", "Panel_LocalWar_OccupationGauge", UIGroup.PAGameUIGroup_MiniGameUI)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWarOccupation_Gauge_Big.XML", "Panel_LocalWar_CurrentOccupationGauge", UIGroup.PAGameUIGroup_MiniGameUI)
  basicLoadUI("UI_Data/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI.XML", "Panel_Widget_Tutorial_GuideUI", UIGroup.PAGameUIGroup_Tutorial)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_Tutorial.XML", "Panel_Window_MessageBox_Tutorial", UIGroup.PAGameUIGroup_Tutorial)
  basicLoadUI("UI_Data/Widget/BossInstance/Panel_Widget_BossInstance_Dummy.XML", "Panel_Widget_BossInstance_Dummy", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/SkillCommand/UI_SkillCommand.xml", "Panel_SkillCommand", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Menu/Panel_Combo_Guide.xml", "Panel_Combo_Guide", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/SkillCommand/UI_SkillCommand_Cutscene.xml", "Panel_SkillCommand_Cutscene", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Widget/Console/Panel_Widger_Camera_Mode.xml", "Panel_Widget_CameraMode_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if ToClient_IsDevelopment() then
    basicLoadUI("UI_Data/Widget/SkillCommand/UI_ComboCommand.xml", "Panel_ComboCommand", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/Console/UI_Widget_NextCombo.xml", "Panel_ConsoleCombo", UIGroup.PAGameUIGroup_MainUI)
  end
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    loadUI("UI_Data/Widget/Search/Panel_Widget_Dialog_Search_All.xml", "Panel_Widget_Dialog_Search_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Widget/Search/UI_Dialog_Search.xml", "Panel_Dialog_Search", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_Movie_KeyViewer.xml", "Panel_Movie_KeyViewer", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/Tutorial/Console/Panel_Tutorial_Renew.XML", "Panel_Tutorial_Renew", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Tutorial
  }))
  loadUI("UI_Data/Widget/Tutorial/UI_Masking_Tutorial_Quest.XML", "Panel_Masking_Tutorial", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Tutorial
  }))
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_ArousalTutorial.xml", "Panel_ArousalTutorial", UIGroup.PAGameUIGroup_Alert)
  loadUI("UI_Data/Window/HouseInfo/Panel_HouseControl_Main.XML", "Panel_HouseControl", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/BreathGauge/Panel_BreathGauge.XML", "Panel_BreathGauge", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Delivery/UI_Window_Delivery_Person.XML", "Panel_Window_DeliveryForPerson", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Delivery/UI_Window_Delivery_GameExit.XML", "Panel_Window_DeliveryForGameExit", UIGroup.PAGameUIGroup_GameMenu)
  loadUI("UI_Data/Widget/Dialogue/Console/Panel_AskKnowledge_Renew.XML", "Panel_AskKnowledge", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Cutscene/Console/Panel_CutsceneMovie_Renew.XML", "Panel_Cutscene", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceMain.XML", "Panel_SequenceMain", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SubTitle.XML", "Panel_Sequence_SubTitle", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceNotifier.XML", "Panel_SequenceNotifier", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_LetterBox.XML", "Panel_Sequence_LetterBox", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkip.XML", "Panel_SequenceSkip", UIGroup.PAGameUIGroup_MainUIFront, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkipPopUp.XML", "Panel_SequenceSkipPopUp", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkipEscPopUp.XML", "Panel_SequenceSkipEscPopUp", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_DeadMessage.XML", "Panel_Sequence_DeadMessage", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_R_SkipMessageBox.XML", "Panel_Sequence_R_SkipMessageBox", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_TitleTexture.XML", "Panel_Sequence_TitleTexture", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_KeyGuide.XML", "Panel_Sequence_KeyGuide", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SkillCommandGuide.XML", "Panel_Sequence_SkillCommandGuide", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SkillTutorial.XML", "Panel_Sequence_SkillTutorial", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_HpMpBar_Remaster_forCutscene.XML", "Panel_Sequence_HpMpBar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Widget/Stamina/Stamina_forCutscene.XML", "Panel_Sequence_Stamina", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_Adrenallin_Remaster_forCutscene.XML", "Panel_Sequence_Adrenallin", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_HouseHold_New.XML", "Panel_Copy_HouseHold", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Installation_New.XML", "Panel_Copy_Installation", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Monster_New.XML", "Panel_Copy_Monster", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Npc_New.XML", "Panel_Copy_Npc", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_OtherPlayer_New.XML", "Panel_Copy_OtherPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_SelfPlayer_New.XML", "Panel_Copy_SelfPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Vehicle_New.XML", "Panel_Copy_Vehicle", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Maid_New.XML", "Panel_Copy_MaidActor", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_ActionStatus.XML", "Panel_CharacterActionStatus", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_Solare_Buff.XML", "Panel_Actor_SolareBuffStateUI", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_BubbleBox.XML", "Panel_Copy_BubbleBox", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/HumanRelation/HumanRelation.XML", "Panel_Copy_HumanRelation", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/HumanRelation/HumanRelationIcon.XML", "Panel_Copy_HumanRelationIcon", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_WaitComment.XML", "Panel_Copy_WaitComment", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/NaviPath/Panel_NaviPath.XML", "Panel_Copy_NaviPath", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_Renew.XML", "Panel_PearlShop", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_Category_Renew.XML", "Panel_Pearlshop_Category", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_ProductInfo_Renew.XML", "Panel_PearlShop_ProductInfo", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_ProductBuy_Renew.XML", "Panel_PearlShop_ProductBuy", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_DisplayController.XML", "Panel_PearlShop_DisplayController", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Console/Panel_PearlShop_CouponBook_Renew.XML", "Panel_PearlShop_Coupon", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  if _ContentsGroup_RefundCashProduct == true then
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack.XML", "Panel_IngameCashSHop_ReturnBack", UIGroup.PAGameUIGroup_Siege, SETRENDERMODE_BITSET_INGAMECASHSHOP())
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Desc.XML", "Panel_IngameCashShop_Desc", UIGroup.PAGameUIGroup_HouseInfo, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  end
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop.XML", "Panel_IngameCashShop", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_GoodsTooltip.XML", "Panel_IngameCashShop_GoodsTooltip", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_GoodsDetailInfo.XML", "Panel_IngameCashShop_GoodsDetailInfo", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_SetEquip.XML", "Panel_IngameCashShop_SetEquip", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Controller.XML", "Panel_IngameCashShop_Controller", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_BuyOrGift.XML", "Panel_IngameCashShop_BuyOrGift", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Password.XML", "Panel_IngameCashShop_Password", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_NewCart.XML", "Panel_IngameCashShop_NewCart", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_ChargeDaumCash.XML", "Panel_IngameCashShop_ChargeDaumCash", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_TermsofDaumCash.XML", "Panel_IngameCashShop_TermsofDaumCash", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MakePaymentsFromCart.XML", "Panel_IngameCashShop_MakePaymentsFromCart", UIGroup.PAGameUIGroup_Siege, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_BuyPearlBox.XML", "Panel_IngameCashShop_BuyPearlBox", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_HowUsePearlShop.XML", "Panel_IngameCashShop_HowUsePearlShop", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Coupon.XML", "Panel_IngameCashShop_Coupon", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_CategorySale.XML", "Panel_IngameCashShop_EventCart", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment.XML", "Panel_IngameCashShop_EasyPayment", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/IngameCashShop/Panel_Window_StampCoupon.XML", "Panel_Window_StampCoupon", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods.XML", "Panel_Window_RecommandGoods", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods_PopUp.XML", "Panel_Window_RecommandGoods_PopUp", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/Cash_Customization/Panel_Cash_Customization.XML", "Panel_Cash_Customization", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/Cash_Customization/Panel_Cash_Customization_BuyItem.XML", "Panel_Cash_Customization_BuyItem", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_IngameCustomize
  }))
  if true == _ContentsGroup_PearlShopMileage then
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All.XML", "Panel_IngameCashShop_MoonBlessing_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  end
  if _ContentsGroup_PearlShopMoonBlessingRenew == true then
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_Renew_All.XML", "Panel_IngameCashShop_MoonBlessing_Renew_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace then
    loadUI("UI_Data/Window/ItemMarket/Console/Panel_Window_MarketPlaceWallet_Renew.XML", "Panel_Window_MarketPlaceWallet", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Console/Panel_Window_MarketPlace_SellConfirm_Renew.XML", "Panel_Window_MarketPlace_SellConfirm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Console/Panel_Window_MarketPlace_BuyConfirm_Renew.XML", "Panel_Window_MarketPlace_BuyConfirm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Console/Panel_Window_MarketPlaceFilter_Renew.XML", "Panel_Window_MarketPlace_Filter", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_Function.XML", "Panel_Window_ItemMarket_Function", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarketNew.XML", "Panel_Window_ItemMarket", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_Favorite.XML", "Panel_Window_ItemMarket_Favorite", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_BidDesc.XML", "Panel_ItemMarket_BidDesc", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_ItemSet.XML", "Panel_Window_ItemMarket_ItemSet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_RegistItem.XML", "Panel_Window_ItemMarket_RegistItem", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm.XML", "Panel_Window_ItemMarket_BuyConfirm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm_Secure.XML", "Panel_Window_ItemMarket_BuyConfirmSecure", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_AlarmList.XML", "Panel_ItemMarket_AlarmList", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Alarm.XML", "Panel_ItemMarket_Alarm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_PreBid.XML", "Panel_ItemMarket_PreBid", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_PreBid_Manager.XML", "Panel_ItemMarket_PreBid_Manager", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Password.XML", "Panel_ItemMarket_Password", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_AlarmList_New.XML", "Panel_Window_ItemMarketAlarmList_New", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_NewAlarm.XML", "Panel_ItemMarket_NewAlarm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_RClickMenu.XML", "Panel_Window_ItemMarket_RClickMenu", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_Function.XML", "Panel_Window_MarketPlace_Function", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MarketPlace/Console/Panel_Window_MarketPlace_BuyManagement_Renew.XML", "Panel_Window_MarketPlace_BuyManagement", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MarketPlace/Console/Panel_Window_MarketPlace_SellManagement_Renew.XML", "Panel_Window_MarketPlace_SellManagement", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MarketPlace/Console/Panel_Window_MarketPlace_Main_Renew.XML", "Panel_Window_MarketPlace_Main", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MarketPlace/Console/Panel_Window_MarketPlace_SelectList_Renew.XML", "Panel_Window_MarketPlace_SelectList", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BossAlert/Panel_BossAlert_SettingV2.XML", "Panel_BossAlert_SettingV2", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BossAlert/Panel_BossAlertV2.XML", "Panel_BossAlertV2", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/RandomBoxSelect/Panel_Window_RandomBoxSelect_All.XML", "Panel_RandomBoxSelect_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/Gacha_Roulette/Console/Panel_Gacha_Roulette_Renew.XML", "Panel_Gacha_Roulette", UIGroup.PAGameUIGroup_Chatting)
  basicLoadUI("UI_Data/Widget/KeyGuide/Panel_WidgetUIKeyguide.XML", "Panel_WidgetUIKeyguide", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Window/PcRoomNotify/Panel_PcRoomNotify.XML", "Panel_PcRoomNotify", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/EventNotify/Console/Panel_Window_NewsBanner.XML", "Panel_NewsBanner", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_NewUI_EventNotify_All then
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotify_All.XML", "Panel_EventNotify_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotifyContent_All.XML", "Panel_EventNotifyContent_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_EventGuidePage == true then
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventGuide_Total.XML", "Panel_EventGuide_Total", UIGroup.PAGameUIGroup_Windows)
  end
  preloadCustomizationUI_XB()
  basicLoadUI("UI_Data/Window/CarveSeal/Panel_Window_CarveSeal_All.XML", "Panel_Window_CarveSeal_All", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_DeleteMaxEnchanterName then
    basicLoadUI("UI_Data/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName.XML", "Panel_DeleteMaxEnchanterName", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/ClearVested/Panel_ClearVested.XML", "Panel_ClearVested", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/UI_Setting/Console/Panel_Window_UIModify_All_Console.XML", "Panel_Window_UIModify_All_Console", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_UISetting
  }))
  basicLoadUI("UI_Data/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset.XML", "Panel_Window_ConsoleUIOffset", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/WorkerManager/Panel_Window_WorkerManager_New_All.XML", "Panel_Window_WorkerManager_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WorkerManager/UI_WorkerChangeSkill_All.XML", "Panel_Window_WorkerManagerChangeSkill_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WorkerManager/UI_WorkerRestoreAll_All.XML", "Panel_Window_WorkerManagerRestore_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Worker_All.XML", "Panel_Widget_WorkerManagerTooltip_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Window/ChangeName/Panel_Window_WorkerName_All.XML", "Panel_Window_WorkerManagerChangeName_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Auction/Panel_Window_WorkerAuction_All.XML", "Panel_Window_WorkerAuction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Tooltip/Panel_Widget_WorkerSkillTooltip_All.XML", "Panel_Widget_WorkerSkillTooltip_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_EXPExchange_ALL.XML", "Panel_Window_ExchangeExp_All", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_NewUI_TransferLifeExp_All then
    basicLoadUI("UI_Data/Window/TransferLifeExperience/Panel_Widow_TransferLifeExperience_All.XML", "Panel_TransferLifeExperience_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/TransferLifeExperience/Panel_TransferLifeExperience.XML", "Panel_TransferLifeExperience", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/ChangeItem/Console/Panel_Window_ChangeItem_Renew.XML", "Panel_Window_ChangeItem_Renew", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_NewUI_ChangeItem_All then
    basicLoadUI("UI_Data/Window/ChangeItem/Panel_Window_ChangeItem_All.XML", "Panel_Window_ChangeItem_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/ChangeItem/Panel_ChangeWeapon.XML", "Panel_ChangeWeapon", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Party/Panel_MatchResult.XML", "Panel_MatchResult", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_RaceTimeAttack.XML", "Panel_RaceTimeAttack", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_RaceFinishTime.XML", "Panel_RaceFinishTime", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Party/Panel_RaceResult.XML", "Panel_RaceResult", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_AlchemyStoneRenewal == true then
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStone_Renewal_All.XML", "Panel_Window_AlchemyStone_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStoneEvolve_All.XML", "Panel_Window_AlchemyStoneEvolve_All", UIGroup.PAGameUIGroup_Window_Progress_Child)
  else
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStone_All.XML", "Panel_Window_AlchemyStone_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyFigureHead_All.XML", "Panel_AlchemyFigureHead_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/RallyRanking/Panel_RallyRanking.XML", "Panel_RallyRanking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWar.XML", "Panel_LocalWar", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWarTeam_All.XML", "Panel_LocalWarTeam", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Join/Panel_Window_Join.XML", "Panel_Join", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Console/Panel_TerritoryWar_Caution_Renew.XML", "Panel_TerritoryWar_Caution_Renew", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/ItemWarp/Panel_ItemWarp_All.XML", "Panel_ItemWarp_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  if _ContentsGroup_Telescope == true then
    basicLoadUI("UI_Data/Window/Scope/Panel_Window_Scope_All.XML", "Panel_Window_Scope_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  end
  basicLoadUI("UI_Data/Window/GoldenTreasureBox/Panel_TreasureBox_All.XML", "Panel_GoldenTreasureBox_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/ScreenShot_WebAlbum/Panel_ScreenShot_WebAlbum.XML", "Panel_ScreenShotAlbum", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/ScreenShot_WebAlbum/Panel_ScreenShotAlbum_FullScreen.XML", "Panel_ScreenShotAlbum_FullScreen", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Broadcast/Panel_Broadcast.xml", "Panel_Broadcast", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/CashShopAlert/UI_Widget_CashShopAlert.xml", "Panel_CashShopAlert", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart.xml", "Panel_ActionMessage", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart_New.xml", "Panel_ActionMessage_New", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_RescueShip.xml", "Panel_RescueShip", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_SummonGamos.xml", "Panel_SummonGamos", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_SummonKatsvariak.xml", "Panel_SummonKatsvariak", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_TamingBubble.xml", "Panel_TamingBubble", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Window/SeasonTexture/Panel_SeasonTexture.xml", "Panel_SeasonTexture", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/BossWave/Panel_Widget_BossWave.xml", "Panel_BossWave", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Party/Panel_Window_FindParty_All.xml", "Panel_PartyList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Party/Console/Panel_Window_FindParty_RecruitePS_Renew.xml", "Panel_PartyRecruite", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Party/Panel_Window_FindParty_Guild_All.xml", "Panel_GuildPartyList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_ServantResurrection.xml", "Panel_ServantResurrection", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/TimeAttack/Panel_TimeAttack.xml", "Panel_TimeAttack", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/MonsterRanking/Panel_MonsterRanking.xml", "Panel_Window_MonsterRanking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_BlackSpiritAdventure2.xml", "Panel_Window_BlackSpiritAdventure_2", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement.XML", "Panel_Window_Achievement", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement_BookShelf_All.XML", "Panel_Window_Achievement_BookShelf_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_ChallengeAlert.xml", "Panel_Widget_ChallengeAlert", UIGroup.PAGameUIGroup_MapRegion)
  if _ContentsGroup_MorningLand == true then
    basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement_Morningland.XML", "Panel_Window_Achievement_MorningLand", UIGroup.PAGameUIGroup_Windows)
  end
  if true == isGameServiceTypeTurkey() then
    basicLoadUI("UI_Data/Window/TurkeyIME/Panel_TurkeyIME.XML", "Panel_TurkeyIME", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_isMemoOpen then
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Sticky.xml", "Panel_Memo_Sticky", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Main.xml", "Panel_Memo_List", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    loadUI("UI_Data/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All.xml", "Panel_Window_ButtonShortcuts_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_UISetting
    }))
  else
    loadUI("UI_Data/Window/ButtonShortcuts/Panel_ButtonShortcuts.xml", "Panel_ButtonShortcuts", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_UISetting
    }))
  end
  loadUI("UI_Data/Window/TranslationReport/Panel_Window_TranslationReport.XML", "Panel_TranslationReport", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/TranslationReport/Panel_Window_TranslationText.XML", "Panel_Window_TranslationText", UIGroup.PAGameUIGroup_Windows)
  if true == ToClient_isPS() then
    basicLoadUI("UI_Data/Window/Report/Panel_Window_Report.XML", "Panel_Window_Report", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Under18/Panel_Message_Under18.xml", "Panel_Message_Under18", UIGroup.PAGameUIGroup_FadeScreen)
  loadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenu.xml", "Panel_QuickMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_Edit.xml", "Panel_QuickMenuCustom", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_RightRing.xml", "Panel_QuickMenuCustom_RightRing", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/Menu/Console/Panel_Widget_QuickMenu.xml", "Panel_Widget_QuickMenu", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_NpcGift.xml", "Panel_NpcGift", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Console/Panel_Dialog_NpcGift_Renew.xml", "Panel_Dialog_NpcGift_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/KeyGuide/Panel_ConsoleKeyGuide.xml", "Panel_ConsoleKeyGuide", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize,
    RenderMode.eRenderMode_Dialog,
    Defines.RenderMode.eRenderMode_customScreenShot,
    Defines.RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/KeyGuide/Panel_WorldmapKeyGuide.xml", "Panel_WorldmapKeyGuide", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/BlackDesertLab/Panel_Window_BlackDesertLab.xml", "Panel_Window_BlackDesertLab", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All.XML", "Panel_MacroCheckQuiz_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MacroCheckQuiz/Panel_Window_QuizNumpad_All.XML", "Panel_MacroCheckQuizPad_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Purification/Panel_Purification_All.XML", "Panel_Purification_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BossAlert/Panel_BossAlert_SettingV2_All.XML", "Panel_BossAlert_SettingV2_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_Console_PersonalMonster then
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonster_All.xml", "Panel_PersonalMonster_All", UIGroup.PAGameUIGroup_Windows)
    loadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo_All.xml", "Panel_PersonalMonsterInfo_All", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage_All.xml", "Panel_PersonalMonsterMessage_All", UIGroup.PAGameUIGroup_ModalDialog)
  end
  if _ContentsGroup_bloodAltar_renewal == true then
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Window_BloodAltar_All.XML", "Panel_Window_BloodAltar_All", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Widget_BloodAltarGauge_All.XML", "Panel_Widget_BloodAltarGauge_All", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Window_BloodAltar_Retry_All.XML", "Panel_Window_BloodAltar_Retry_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/BloodAltar/Panel_Widget_BloodAltar_RandomMatch.XML", "Panel_Widget_BloodAltar_RandomMatch", UIGroup.PAGameUIGroup_MapRegion)
  basicLoadUI("UI_Data/Window/Rank/Panel_Window_AltarRank.xml", "Panel_AltarRank_Web", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_CardGame then
    basicLoadUI("UI_Data/Window/CardGame/Panel_Window_CardGame.xml", "Panel_Window_CardGame", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Menu/Panel_Widget_Menu_Remake.XML", "Panel_Widget_Menu_Remake", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PreOrder/Panel_Window_PreOrder.xml", "Panel_Window_PreOrder", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_RenewUI then
    loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  end
  if _ContentsGroup_UsingPMAPI == true then
    basicLoadUI("UI_Data/Window/AccountLinking/Console/Panel_Window_AccountLinking_Web.xml", "Panel_Window_AccountLinking_Web", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/AccountLinking/Console/Panel_Window_AccountLinking_Renew.xml", "Panel_Window_AccountLinking_Renew", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Common/Panel_Window_Invitation_All.XML", "Panel_Window_Invitation_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Common/Panel_Window_LetterScroll_All.XML", "Panel_Window_LetterScroll_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/KillLog/Panel_Widget_KillLog.XML", "Panel_Widget_KillLog", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/PowerSave/Panel_Window_PowerSave_All.XML", "Panel_Window_PowerSave_All", UIGroup.PAGameUIGroup_Movie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_PowerSave
  }))
  basicLoadUI("UI_Data/Widget/AccesoryQuest/Panel_Widget_AccesoryQuest.xml", "Panel_Widget_AccesoryQuest", UIGroup.PAGameUIGroup_Widget)
  if true == _ContentsGroup_OceanCurrent then
    loadUI("UI_Data/Window/Servant/Panel_Window_ShipEquipManagement_ALL.XML", "Panel_Window_ShipEquipManagement_ALL", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/Servant/UI_ShipSpeedGauge_ALL.XML", "Panel_Widget_ShipSpeedGauge", UIGroup.PAGameUIGroup_ScreenEffect)
    basicLoadUI("UI_Data/Window/Servant/Panel_Widget_OceanWind.XML", "Panel_Widget_OceanWind", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Servant/Panel_Widget_OceanCurrent.XML", "Panel_Widget_OceanCurrent", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Window/Servant/Panel_Window_ShipInfo_ALL.XML", "Panel_Window_ShipInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_Servant.XML", "Panel_Tooltip_Skill_Servant", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_ShipCannon_Left.XML", "Panel_Widget_ShipCannon_Left", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_ShipCannon_Right.XML", "Panel_Widget_ShipCannon_Right", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_SailControl.XML", "Panel_Widget_SailControl", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Common/Panel_Window_ItemFilter_All.XML", "Panel_Window_ItemFilter_All", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    basicLoadUI("UI_Data/Window/Servant/Panel_Window_ShipControll_Console.XML", "Panel_Window_ShipControl", UIGroup.PAGameUIGroup_Windows)
    if _ContentsGroup_ImprovedGalleyShip == true then
      basicLoadUI("UI_Data/Window/Servant/Panel_Widget_GalleyBoost.XML", "Panel_Widget_GalleyBoost", UIGroup.PAGameUIGroup_Widget)
      basicLoadUI("UI_Data/Window/Servant/Panel_Widget_GalleyMember.XML", "Panel_Widget_GalleyMember", UIGroup.PAGameUIGroup_Widget)
    end
    if _ContentsGroup_EmployeePresetJob == true then
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorPresetManager_All.XML", "Panel_Window_SailorPresetManager_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorManager_GroupPreset_All.XML", "Panel_Window_SailorPresetGroup_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Servant/Panel_Window_ShipInfo_Renewal_ALL.XML", "Panel_Window_ShipInfo_Renewal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All.XML", "Panel_Window_SailorPreset_NameEdit_All", UIGroup.PAGameUIGroup_Window_Progress_Child, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      if _ContentsGroup_EmployeeAutoFishingDiscard == true then
        loadUI("UI_Data/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard.XML", "Panel_Widget_Sailor_AutoFishingDiscard", UIGroup.PAGameUIGroup_ScreenEffect, PAUIRenderModeBitSet({
          RenderMode.eRenderMode_Default
        }))
      end
    end
  end
  if _ContentsGroup_MorningLand == true then
    if _ContentsGroup_MorningLand2 == true then
      loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_QuestBoard2_All.XML", "Panel_MorningLand_QuestBoard_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
    else
      loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_QuestBoard_All.XML", "Panel_MorningLand_QuestBoard_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
    end
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_Boss_All.XML", "Panel_Window_MorningLand_Boss_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_DetailReward_All.XML", "Panel_MorningLand_DatailReward", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_MyReward_All.XML", "Panel_MorningLand_MyReward_All", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_BossRanking_All.XML", "Panel_MorningLand_BossRanking", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_ConquestHistory_All.XML", "Panel_MorningLand_ConquestHistory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_Scenario_All.XML", "Panel_MorningLand_Scenario_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/MorningLand/Panel_Widget_ConquestGiveUp_All.XML", "Panel_MorningLand_ConquestGiveUp", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/AlertArea/Panel_Widget_QuestBoardAlert.XML", "Panel_MorningLand_QuestBoardAlert_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if true == _ContentsGroup_SeasonContents then
    basicLoadUI("UI_Data/Window/Season/Panel_Season_CharacterTag.XML", "Panel_Window_ChangeSeasonCharacter_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_GrowthPass then
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass.XML", "Panel_Window_GrowthPass", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass_Info.XML", "Panel_Window_GrowthPass_Info", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass_PointShop.XML", "Panel_Window_GrowthPass_PointShop", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Widget/Awakening_Succession/Panel_Widget_Awakening_Succession_Select_All.XML", "Panel_Widget_Awakening_Succession_Select_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if _ContentsGroup_LightStoneBag == true then
    loadUI("UI_Data/Window/Inventory/UI_Window_Inventory_Artifacts.XML", "Panel_Window_LightStoneBag", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Inventory/UI_Window_Inventory_Artifacts_PresetList.XML", "Panel_Window_ArtifactPreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_ExchangeCoinSystem == true then
    loadUI("UI_Data/Window/Exchange/Panel_ExchangeCoin_All.XML", "Panel_ExchangeCoin_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  basicLoadUI("UI_Data/Widget/RightTopIcons/Console/Panel_Widget_FunctionButton_Console.XML", "Panel_Widget_FunctionButton_Console", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/Season/Panel_Window_SeasonReward.XML", "Panel_Window_SeasonReward_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_Sailor then
    loadUI("UI_Data/Window/Sailor/Panel_Window_Sailor_Onboard_All.XML", "Panel_Window_Sailor_Onboard_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Sailor/Panel_Window_SailorManager_All.XML", "Panel_Window_SailorManager_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Sailor/Panel_Window_SailorRestore_All.XML", "Panel_Window_SailorRestore_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_NeedForHire_Item_All.xml", "Panel_Widget_EmployeeHireItem_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_BlackSpirit
    }))
  end
  loadUI("UI_Data/Window/Inventory/Panel_Window_AutoMove_Set.XML", "Panel_Window_ItemMoveSet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_Barter then
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter.XML", "Panel_Window_Barter", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Search.XML", "Panel_Window_Barter_Search", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Refresh_All.XML", "Panel_Window_Barter_Refresh", UIGroup.PAGameUIGroup_Window_Progress + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Search_SpecialInfo.XML", "Panel_Window_Barter_Search_Special", UIGroup.PAGameUIGroup_Window_Progress + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Widget/GreatSea/Panel_Widget_Anchorage_ALL.XML", "Panel_Widget_Anchorage", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_All.XML", "Panel_Window_ServantUpgrade", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_All_Tree.XML", "Panel_Dialog_ServantExtension_All_Tree", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_Additional_All.XML", "Panel_Window_ServantUpgradeInfo", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_BarterInfo.XML", "Panel_Worldmap_BarterInfo", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_WORLDMAP())
    loadUI("UI_Data/Window/Servant/Panel_Window_CargoLoading_ALL.XML", "Panel_Window_CargoLoading_ALL", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Widget/Research/Panel_Widget_Research_ProgressBar.XML", "Panel_Widget_GreatSeaEvent_ProgressBar", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Widget/Research/Panel_Widget_Research_Resurt.XML", "Panel_Widget_GreatSeaEvent", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Widget/Research/Panel_Widget_seafaringResearch_Resurt.XML", "Panel_Widget_SeafaringResearch", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    basicLoadUI("UI_Data/Widget/GreatSea/Panel_Widget_OnOffShip.XML", "Panel_Widget_OnOffShip", UIGroup.PAGameUIGroup_Widget)
  end
  if true == _ContentsGroup_NewSequenceTutorial then
    loadUI("UI_Data/Widget/Production/Tutorial/Panel_Widget_NewTutorial_Quest.XML", "Panel_SequenceTutorial_Quest", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production,
      RenderMode.eRenderMode_CutScene
    }))
  end
  if true == _ContentsGroup_SelectBox then
    loadUI("UI_Data/Window/ItemBox/Panel_Window_Itembox_Select.XML", "Panel_Window_SelectBox", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_InGameCashShop
    }))
  end
  basicLoadUI("UI_Data/Window/ItemBox/Panel_Window_MessageBox_ForReward_All.XML", "Panel_Window_MessageBox_ForReward", UIGroup.PAGameUIGroup_SimpleTooltip + 1)
  if true == _ContentsGroup_RenewalLifeGradeUpUI then
    basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_Life.XML", "Panel_NakMessage_Life", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  end
  if true == _ContentsGroup_DuelCharacterCopyEquip then
    basicLoadUI("UI_Data/Window/Inventory/UI_Window_Equip_CharacterTag_ItemCopy.XML", "Panel_Window_Equip_CharacterTag_ItemCopy", UIGroup.PAGameUIGroup_GameMenu)
    basicLoadUI("UI_Data/Window/Inventory/UI_Window_DescBox_ItemCopy.XML", "Panel_Window_DescBox_ItemCopy", UIGroup.PAGameUIGroup_GameMenu)
  end
  basicLoadUI("UI_Data/Widget/SiegeWar/Panel_SiegeWar_AngerGage.XML", "Panel_SiegeWar_AngerGage", UIGroup.PAGameUIGroup_Widget)
  if true == _ContentsGroup_FairySkillChangeRateView then
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyRateDesc.XML", "Panel_Window_FairyRateDesc", UIGroup.PAGameUIGroup_Alert)
  end
  loadUI("UI_Data/Widget/Dialogue/Panel_Widget_BlackSpirit_SkillSelect.xml", "Panel_Widget_BlackSpirit_SkillSelect", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Invite/Panel_Window_Invite_All.XML", "Panel_Window_Invite_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz_GM.XML", "Panel_Event_QuizGM", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz.XML", "Panel_Event_Quiz", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_QuizEvent == true then
    basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz_Minimal.XML", "Panel_Event_Quiz_Minimal", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_All.XML", "Panel_Event_TicketShop", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_Unboxing_Progress.XML", "Panel_Event_TicketShop_Unboxing", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_Nak.XML", "Panel_Event_TicketShop_Nak", UIGroup.PAGameUIGroup_Alert)
  loadUI("UI_Data/Window/Cutscene/Panel_Window_CutSceneSkip.XML", "Panel_Window_CutSceneSkip", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_Widget_CutScene_CC.XML", "Panel_Window_CutSceneScript", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_CutScene_Esc_Skip.XML", "Panel_Window_CutSceneEscSkip", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_Siege.XML", "Panel_House_InstallationMode_Siege_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_HouseInstallation
  }))
  basicLoadUI("UI_Data/Window/Mansion/Panel_Window_Mansion_Contract.XML", "Panel_Window_Mansion_Contract_All", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_SnowAntLabyrinth then
    loadUI("UI_Data/Widget/NakMessage/NakMessage_Erethea.xml", "Panel_NakMessage_Erether_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  loadUI("UI_Data/Window/Movie/UI_ImageSlider.xml", "Panel_ImageSlider_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/NakMessage/Panel_Widget_NakMessageChoice_All.XML", "Panel_Widget_NakMessageChoice_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Ping/Panel_Widget_Ping.XML", "Panel_Widget_Ping_All", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Widget_PersonalField_Mini.XML", "Panel_Widget_PersonalField_Mini", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Window_PersonalField_Main.XML", "Panel_Window_PersonalField_Main", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Widget_PersonalField_Enter.XML", "Panel_Widget_PersonalField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  if true == _ContentsGroup_SelectStartPosition then
    basicLoadUI("UI_Data/Window/Quest/Panel_Window_StartBranch.XML", "Panel_Window_StartBranch", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Arsha/Panel_Window_Arsha_ApplyWeb_forConsole.XML", "Panel_Window_Arsha_ApplyWeb_forConsole", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_RecoveryElephant.XML", "Panel_RecoveryElephant", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/MainStatus/Panel_ClassResource.XML", "Panel_ClassResource", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Color/Panel_War_Color.XML", "Panel_GuildWar_Color", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Color/Panel_War_Color_List.XML", "Panel_GuildWar_ColorList", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Arbitration.XML", "Panel_Window_Guild_Arbitration", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/EnterElvia/Panel_Widget_EnterElvia.XML", "Panel_Widget_HadumField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_Process_All.XML", "Panel_Chat_Process_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Widget/AbyssOne/NakMessage_WareHouse_Clear.XML", "NakMessage_Warehouse_Clear", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/Quest/Panel_Window_AbyssOne_Help.XML", "Panel_AbyssOne_Help", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_MagnusEasyTeleport == true then
    basicLoadUI("UI_Data/Window/AbyssOne/Panel_Window_MagnusEasyTeleportMap.XML", "Panel_Window_MagnusEasyTeleportMap", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Widget/NakMessage/Panel_Widget_Nak_AbyssOne_Skill.XML", "Panel_Widget_Nak_AbyssOneSkill", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_ArtifactItem == true then
    loadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_Exchange_All.xml", "Panel_Window_Artifacts_Exchange_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_Exchange_LOG_All.xml", "Panel_Window_Artifacts_Exchange_LOG_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Boss_InstanceEnter_Effect.XML", "Panel_Widget_GuildBossField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_BossLooting.XML", "Panel_Widget_BossLooting", UIGroup.PAGameUIGroup_WorldBossLooting)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_BossReward.XML", "Panel_Widget_BossReward", UIGroup.PAGameUIGroup_WorldBossLooting)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_Reward.XML", "Panel_Widget_Reward_All", UIGroup.PAGameUIGroup_WorldBossLooting)
  basicLoadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Servant_All.XML", "Panel_Widget_Tooltip_Servant_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_SkillWindow
  }))
  basicLoadUI("UI_Data/Window/Common/Panel_Window_Bromide.XML", "Panel_Window_Bromide_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  if _ContentsGroup_JewelPreset == true then
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_Inven_All.XML", "Panel_Window_JewelPreset_Inven_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_All.XML", "Panel_Window_JewelPreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_Tooltip_All.XML", "Panel_Window_JewelPreset_Tooltip_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_CrystalSet_All.XML", "Panel_Window_MessageBox_CrystalSet_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  end
  loadUI("UI_Data/Window/Inventory/UI_Window_TrashBox_Popup_All.XML", "Panel_Window_TrashBoxConfirm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if _ContentsGroup_PearlBoxWebBuy == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_WebPurchaseConfirm_All.XML", "Panel_Window_WebPurchaseConfirm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_SpecialPass_All.XML", "Panel_Event_SpecialPass_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_MonsterBuffZone == true then
    loadUI("UI_Data/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone.XML", "Panel_Window_MonsterBuffZone", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair.XML", "Panel_Window_MonsterBuffZoneItemRepair", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/Siege/Panel_Window_VillageSiegeMenu_All.XML", "Panel_Window_VillageSiegeMenu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Siege/Panel_Window_SiegeResult_All.XML", "Panel_Window_SiegeResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Siege/Panel_Window_OceanSiegeResult_All.XML", "Panel_Window_OceanSiegeResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Siege/Panel_Widget_VillageSiegeState_All.XML", "Panel_Widget_VillageSiegeState_All", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All.XML", "Panel_TimeLog_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Tutorial/Console/Panel_Window_FantasyHorseGuide_Console.XML", "Panel_Window_FantasyHorseGuide_Console", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_MorningLandTierGo == true then
    loadUI("UI_Data/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All.XML", "Panel_MorningLandSuccessMsg_All", UIGroup.PAGameUIGroup_MainUIFront, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  if _ContentsGroup_ItemSkillOption == true then
    loadUI("UI_Data/Window/Enchant/Panel_Window_ItemSkillOption_All.XML", "Panel_Window_ItemSkillOption_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Dialog_MakeGoonwang_All.XML", "Panel_Window_MakeGoonWang", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_MorningLandTierParty == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_MorningBoss_All.XML", "Panel_Window_MessageBoxForSequence_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/AutoMove/Panel_Window_AutoMove_Result.XML", "Panel_AutoMove_Result_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Tooltip/Panel_Window_CharacterStat_All.XML", "Panel_Window_CharacterStat_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_RedBattleFieldMatching == true then
    basicLoadUI("UI_Data/Widget/LocalWar/Panel_Widget_LocalWar_Match_All.XML", "Panel_Widget_LocalWar_Match_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWar_Match_Confirm_All.XML", "Panel_LocalWar_Match_Confirm_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_Notation_Ability_All.XML", "Panel_Notation_Ability", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/Edania/Panel_Window_Edania_Contents_All.XML", "Panel_Window_Edania_Contents_All", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_PVP_HUD.XML", "Panel_Window_Edania_PVP_HUD", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Widget_Edania_Countdown.XML", "Panel_Widget_Edania_Countdown", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_PVP_Challenger.XML", "Panel_Window_Edania_PVP_Challenger", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_Join.XML", "Panel_Window_Edania_Join", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Window/Edania/Panel_Window_Edania_Worldmap_Castle.XML", "Panel_Window_Edania_Worldmap_Castle", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if _ContentsGroup_TotalPreset == true then
    loadUI("UI_Data/Window/PresetTotal/Panel_Window_PresetTotal_All.XML", "Panel_Window_PresetTotal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/PresetTotal/Panel_Window_PresetTotalMemo_All.XML", "Panel_Window_TotalPresetMemo", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    loadUI("UI_Data/Window/Enchant/Panel_Window_ReforgeStonePreset_All.XML", "Panel_Window_ReforgeStonePreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All.XML", "Panel_Window_ReforgePresetNameEdit_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_All.XML", "Panel_Window_Journal_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Select_All.XML", "Panel_Window_Journal_Select_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Page_All.XML", "Panel_Window_Journal_Page_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Book_All.XML", "Panel_Window_Journal_Book_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if _ContentsGroup_SnowBoardMirrorField == true then
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All.XML", "Panel_Window_SnowBoard_Menu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Result_All.XML", "Panel_Window_SnowBoard_Result_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All.XML", "Panel_Window_SnowBoard_Hud_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard.XML", "Panel_Window_MessageBox_SnowBoard", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
  end
  if _ContentsGroup_LootingItemRecord == true then
    basicLoadUI("UI_Data/Window/Looting/Panel_Window_LootingItemReport_Main_All.XML", "Panel_Window_LootingItemReport_Main_All", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Common/Panel_Widget_Common_Countdown.XML", "Panel_Widget_Common_Countdown", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  if _ContentsGroup_OlviaAcademy == true then
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Main_All.XML", "Panel_Window_OlviaAcademy_Main_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Pass_All.XML", "Panel_Window_OlviaAcademy_Pass_All", UIGroup.PAGameUIGroup_Windows)
  end
end
function loadGameUI_XB()
  runLua("UI_Data/Script/Window/BlackBackground/Panel_Global_BlackBackground.lua")
  runLua("UI_Data/Script/Panel_Ime.lua")
  runLua("UI_Data/Script/Tutorial/Panel_WebControl.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_WebCashPayment.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.lua")
  if _ContentsGroup_CouponCode == true then
    runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode.lua")
    runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode_Input.lua")
  end
  runLua("UI_Data/Script/Widget/ConsoleKeyGuide/UIKeyGuide/Panel_WidgetUIKeyguide.lua")
  runLua("UI_Data/Script/DragManager.lua")
  runLua("UI_Data/Script/Fullsizemode.lua")
  runLua("UI_Data/Script/global_fromActionChart_LuaEvent.lua")
  runLua("UI_Data/Script/Widget/GlobalManual/Console/Panel_Global_Manual_Renew.lua")
  if true == _ContentsGroup_NewUI_Fishing_All then
    runLua("UI_Data/Script/Widget/Fishing/Panel_Widget_Fishing_All.lua")
  else
    runLua("UI_Data/Script/Widget/Fishing/Console/Panel_Fishing_Renew.lua")
  end
  if true == _ContentsGroup_IceFishingGame then
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_IceFishing_All.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningSlaughter_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningSyringe_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningLeather_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningMining_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningLogging_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningHomi_All.lua")
  if _ContentsGroup_ImprovedGalleyShip == true then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GalleyPaddle_All.lua")
  end
  if true == _ContentsGroup_EnhanceHunt then
    if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
      runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All.lua")
      runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_All.lua")
      runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Result_All.lua")
      runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Control_All.lua")
    elseif false == ToClient_isConsole() then
      runLua("UI_Data/Script/Widget/MiniGame/MiniGame_SniperReload.lua")
      runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame.lua")
      runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame_Result.lua")
      runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame_Control.lua")
    end
  else
  end
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All.lua")
  else
    runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_ButtonShortcuts.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_Reconnect.lua")
  runLua("UI_Data/Script/NpcWorker/workerLuaWrapper.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar_GlobalValue.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfo_All.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfoSmall_All.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/PAnel_GuildWarScore_All.lua")
  runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_GuildWarAlert_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildWareHouseHistory.lua")
  runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouseHistory.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_TerritoryAuthority_Auction.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Window_WorkerAuction_All.lua")
  runLua("UI_Data/Script/Widget/Tooltip/Panel_WorkerSkillTooltip_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Detail_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Bid_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_Bid_All.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_NodeTooltip_VillageWar_All.lua")
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_Change_Nickname_All.lua")
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_ExchangeNickname.lua")
  runLua("UI_Data/Script/Common/Common_UIMode.lua")
  runLua("UI_Data/Script/Common/Common_BlackSpirit.lua")
  runLua("UI_Data/Script/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All.lua")
  runLua("UI_Data/Script/Common/Common_Web.lua")
  runLua("UI_Data/Script/Window/WebHelper/Console/Panel_WebControl_Renew.lua")
  runLua("UI_Data/Script/Window/LordMenu/Panel_Window_LordMenu_All.lua")
  runLua("UI_Data/Script/Window/NodeWarMenu/Console/Panel_NodeWarMenu_Renew.lua")
  runLua("UI_Data/Script/Widget/FieldViewMode/FieldViewMode.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Widget_Chatting_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_ChattingHistory_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Widget_ChattingViewer_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_Chatting_BlockList.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_Chatting_FunctionList.lua")
  runLua("UI_Data/Script/Widget/Chatting/Notice/Panel_Important_Notice.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_ChatOption.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Filter.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Macro.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_SocialAction.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Color.lua")
  runLua("UI_Data/Script/Widget/Chatting/CreateChattingContent.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading.lua")
  runLua("UI_Data/Script/Window/Report/Panel_Window_Chat_Report_All.lua")
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  else
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SkillGroup.lua")
  end
  if true == _ContentsGroup_SkillFilter then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillFilter_All.lua")
  end
  if true == _ContentsGroup_SkillPreset then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPreset.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPresetMemo.lua")
  end
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Item.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Guild_Introduce.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Common.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Worker.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Work.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Console/Panel_Widget_Tooltip_Renew.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Console/Panel_Widget_FloatingTooltip_Renew.lua")
  runLua("UI_Data/Script/Widget/Introduction/Panel_Introduction_Renew.lua")
  runLua("UI_Data/Script/Widget/Menu/Panel_Menu.lua")
  runLua("UI_Data/Script/Widget/SkillLog/Widget_SkillLog.lua")
  runLua("UI_Data/Script/Widget/itemLog/Panel_Widget_ItemLog_Renew.lua")
  runLua("UI_Data/Script/Widget/KillLog/Panel_Widget_KillLog.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_Sequence.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage_Renewel.lua")
  runLua("UI_Data/Script/Widget/Stamina/Console/Panel_Widget_Stamina_Renew.lua")
  runLua("UI_Data/Script/Widget/Stamina/Panel_Widget_Stamina_Auto_All.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire_QuestDirect.lua")
  runLua("UI_Data/Script/Widget/Region/Region.lua")
  runLua("UI_Data/Script/Widget/Acquire/Alert_QuestDirect.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_SpiritEnchant_All.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStackConfirm_All.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_OtherUser_AdditionalRate_All.lua")
  if true == _ContentsGroup_EnchantRemaster then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_Enchant_Main_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Equip_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Material_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantProtector_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStack_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_StackExtraction_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantMessage_All.lua")
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_EnchantInventory_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Enchant_Console_KeyGuide_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ValksList_All.lua")
  end
  if true == _ContentsGroup_EnchantRenewer then
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_AddStack_All.lua")
  end
  runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_Edit_All.lua")
  if true == _ContentsGroup_SpiritGroupEnchant then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_PartyEnchant_Member_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_PartyEnchant_BubbleText_All.lua")
  end
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_OTPConfirm_All.lua")
  if true == _ContentsGroup_FamilyStack then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_StackStorage_All.lua")
  end
  runLua("UI_Data/Script/Window/Enchant/Panel_Improvement_All.lua")
  runLua("UI_Data/Script/Window/Socket/Panel_Window_Socket_All.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_Window_DeadMessage_All.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_Cash_Revival_BuyItem_All.lua")
  runLua("UI_Data/Script/Window/Looting/Panel_Looting.lua")
  runLua("UI_Data/Script/Widget/PotencialUp/Panel_Potencial_Up_New.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Basic_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Life_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Title_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_History_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FootPrint_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Challenge_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_CashBuff_All.lua")
  if _ContentsGroup_BuffDetailBoard == true then
    runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_BuffDetail_All.lua")
  end
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_Inventory_AutoSortFunction.lua")
  runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Renew.lua")
  runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Detail_Renew.lua")
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Season_Equipment_Upgrade_All.lua")
  end
  runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_MultiButtonPopup.lua")
  if _ContentsGroup_StaticSlot == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All.lua")
  else
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_All.lua")
  end
  runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_CannonInven_Renew.lua")
  runLua("UI_Data/Script/Widget/Popup/Console/Panel_Popup_MoveItem_renew.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_CrystalTooltip.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_ArtifactsTooltip.lua")
  if _ContentsGroup_AccessoryStepUp == true then
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Accessory_StepUp_All.lua")
    runLua("UI_Data/Script/Widget/NakMessage/Panel_Widget_Nak_AccessoryStepUp_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_UseItem_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_SeasonItem_All.lua")
  if true == _ContentsGroup_RestoreItem then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All.lua")
  end
  runLua("UI_Data/Script/Window/ExtendExpiration/Console/Panel_ExtendExpiration_Renew.lua")
  runLua("UI_Data/Script/Widget/UIcontrolBar/Panel_WhereUseItemDirection.lua")
  runLua("UI_Data/Script/Window/LifeRanking/Panel_LifeRanking_All.lua")
  if true == _ContentsGroup_InstanceFreeBatttleField then
    runLua("UI_Data/Script/Window/InstanceField/Panel_FreeBattleField_All.lua")
  end
  if true == _ContentsGroup_DragonPalace then
    runLua("UI_Data/Script/Window/InstanceField/Panel_DragonPalace_Match_All.lua")
  end
  if _ContentsGroup_RedBattleFieldMatching == true then
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All.lua")
  elseif true == _ContentsGroup_InstanceLocalWar then
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New.lua")
  end
  runLua("UI_Data/Script/Window/LocalWar/Console/Panel_Window_LocalWarRule_Renew.lua")
  runLua("UI_Data/Script/Window/CompetitionGame/Panel_CompetitionGame.lua")
  if _ContentsGroup_CombineBag == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Combine.lua")
  end
  runLua("UI_Data/Script/Window/Match/Panel_MatchingSystem.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Matching.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_MatchConfirm.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Ranking.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_EquipPresetList.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_OtherInfo.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Hud.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_PlayerStatus.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Match_Score.lua")
  if _ContentsGroup_SolareReplay == true then
    runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_ReplayList.lua")
    runLua("UI_Data/Script/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb.lua")
  end
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_Invite.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Func_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_InviteList_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamNameChange_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChange_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_SelectMember_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Party_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_FuncList_All.lua")
  if true == _ContentsGroup_BatchSummonMonsterByItem then
    loadUI("UI_Data/Widget/Party/Panel_Widget_Old_Ruins_Raid_All.XML", "Panel_BatchSummonMonster", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  runLua("UI_Data/Script/Window/Recommand/Console/Panel_RecommandName_Renew.lua")
  runLua("UI_Data/Script/Window/Steam/Panel_Window_Steam.lua")
  runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_DailyStamp_All.lua")
  runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_Daily_Reward_Notice_All.lua")
  if true == _ContentsGroup_BlackSpiritAdventure then
    runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_BlackSpiritAdventure.lua")
  end
  if true == _ContentsGroup_EventMarbleGame then
    runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_EventMarbleGame.lua")
  end
  runLua("UI_Data/Script/Window/Copyright/Console/Panel_Window_Copyright.lua")
  runLua("UI_Data/Script/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy.lua")
  runLua("UI_Data/Script/Window/Policy/Panel_Window_Policy.lua")
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    runLua("UI_Data/Script/Window/Skill/Console/Panel_Window_Skill_Renew.lua")
  else
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Controller.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Succession.lua")
    if _ContentsGroup_ShowOtherClassSkill == true then
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_All.lua")
      runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_ShowAllClasses_All.lua")
    else
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup.lua")
    end
  end
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Alarm_All.XML", "Panel_ItemMarket_Alarm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_ReinforceSkill_All.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Reinforce_All.lua")
  else
    runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_SkillSpecialize_Renew.lua")
  end
  if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All.lua")
  end
  runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouse_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_TotalSearch.lua")
  runLua("UI_Data/Script/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo.lua")
  if true == _ContentsGroup_CargoSell then
    runLua("UI_Data/Script/Window/Servant/Panel_Window_CargoSell.lua")
  end
  if _ContentsGroup_Crogdalo == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_CrogdaloStable.lua")
  end
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantInfo_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_PremiumLookChange.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSwiftTraining_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantMarket_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantMarket_Rental_Mating_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSkillManagement_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_ServantRateDesc.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSwiftResult_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferBackwordList_All.lua")
  if _ContentsGroup_HorseSimulator == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulator.lua")
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView.lua")
  end
  if _ContentsGroup_FantasyHorse == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All.lua")
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All.lua")
  end
  if _ContentsGroup_ServantLevelDown == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All.lua")
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLvUpMessageBox_All.lua")
  end
  runLua("UI_Data/Script/Window/Servant/Panel_Window_Servant.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopWidgetIconManager.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Servant.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Wharf.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Pet.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Garden.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Camp.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_AutoUseBuffItem.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Summon.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Maid.lua")
  runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_GuildServant.lua")
  runLua("UI_Data/Script/Window/Servant/Console/Servant_Info_Manager_Renew.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_VehicleInfo_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_LinkedSkill_All.lua")
  runLua("UI_Data/Script/Window/Servant/Console/Panel_Widget_HorseMp_Renew.lua")
  runLua("UI_Data/Script/Window/Servant/Console/Panel_Widget_HorseHp_Renew.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_HorseSubMp_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_GuildStableList_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_GuildServant_RevivalList.lua")
  if _ContentsGroup_LifeSimulator == true then
    runLua("UI_Data/Script/Window/Alchemy/Panel_Alchemy_RateViewList.lua")
  end
  if true == _ContentsGroup_BatchSummonMonsterByItem then
    runLua("UI_Data/Script/Widget/Party/Panel_BatchSummonMonster.lua")
  end
  if true == _ContentsGroup_HarvestList_All then
    runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_TentInfo_All.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_HarvestList_All.lua")
  else
    runLua("UI_Data/Script/Widget/Housing/Console/Panel_Window_GardenList_Renew.lua")
    runLua("UI_Data/Script/Widget/Housing/Console/Panel_Window_GardenInformation_Renew.lua")
  end
  runLua("UI_Data/Script/Widget/Housing/Console/Panel_Window_GardenWorkerManagement_Renew.lua")
  runLua("UI_Data/Script/Widget/Housing/Console/Panel_Window_ResidenceList_Renew.lua")
  runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidList_All.lua")
  if _ContentsGroup_MaidActorSystem == true then
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorList_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorRegist_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorChangeCloth_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_ChangeMaidActorName_All.lua")
  end
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_CharacterTag_All.lua")
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Icon_CharacterTag.lua")
  if true == _ContentsGroup_DuelCharacterCopyEquip then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Equip_CharacterTag_ItemCopy_All.lua")
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_DescBox_ItemCopy_All.lua")
  end
  runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_All.lua")
  runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampWarehouse_All.lua")
  runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampRegister.lua")
  runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All.lua")
  runLua("UI_Data/Script/Widget/PvP/PvP_Battle.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatNew_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatDetail_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetRegister_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetList_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetInfo_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetLookChange_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetFusion_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetCommand_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetGroup_Edit_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkillChange_All.lua")
  if true == _ContentsGroup_PetSkillPercent then
    runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkill_Percent_All.lua")
  end
  if true == _ContentsGroup_isFairy then
    runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All.lua")
    if true == _ContentsGroup_FairyLookChange then
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkinChange_All.lua")
    end
  end
  runLua("UI_Data/Script/Window/Servant/Console/Panel_Cannon_Renew.lua")
  runLua("UI_Data/Script/Widget/QuestList/Panel_NewQuest.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_QuickSlot.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_NewQuickSlot.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_SkillCooltime.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_SkillcoolTimeQuickSlot.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_MainStatus_Remaster.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_MainStatus_User_Bar.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_SelfPlayerExpGage.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_GuardGauge.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_PersonalIcon_Left_Remaster.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_PersonalIcon_SetVoiceChat_All.lua")
  runLua("UI_Data/Script/Widget/Voice/Console/Panel_Widget_VoiceChat.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Console/Panel_Widget_FunctionButton_Renew.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPass.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackSpiritPassQuest.lua")
  runLua("UI_Data/Script/Window/BeginnerRoadMap/Panel_Window_BeginnerRoadMap.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_Tooltip_NpcNavigation_All.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_PersonalIcon_AutoTraining2.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_PersonalIcon_AutoTraining_Alarm.lua")
  runLua("UI_Data/Script/Window/DropItem/Panel_Window_RenewDropItem_All.lua")
  runLua("UI_Data/Script/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/NoticeAlert.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/InstanceNoticeAlert.lua")
  runLua("UI_Data/Script/Widget/Damage/UI_Lua_Damage.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterNameTag.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_BubbleBox.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_WaitComment.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Navigation.lua")
  runLua("UI_Data/Script/Widget/HumanRelations/HumanRelations.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_SolareBuffStateUI.lua")
  runLua("UI_Data/Script/Widget/NewEquip/Panel_NewEquip.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterActionStatus.lua")
  if _ContentsGroup_FeverBuff then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGauge.lua")
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip.lua")
  end
  if _ContentsGroup_LandscapePainting then
    runLua("UI_Data/Script/Window/DropItem/Panel_Window_LandscapePaintingDrop_All.lua")
  end
  if _ContentsGroup_PalaceManagement then
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_All.lua")
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Node_All.lua")
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Worker_All.lua")
  end
  if true == _ContentsGroup_HopeGauge then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGauge.lua")
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff.lua")
    runLua("UI_Data/Script/Widget/MainStatus/Console/Panel_Widget_HopeGauge_Console.lua")
  end
  runLua("UI_Data/Script/Window/Keypad/Panel_Window_NumberPad_All.lua")
  runLua("UI_Data/Script/Window/Keypad/Panel_Window_UseCharacterWp_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Scene.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Console/Panel_Dialog_DetectPlayer_Renew.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Console/Panel_Window_KnowledgeManage_Renew.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ButtonType.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Exchange_Item.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Main_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Intimacy_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_InterestKnowledge_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Quest_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialogue_Itemtake_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ExchangeList_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/DialogKeybinderManager_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_List_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_HorseWithoutOwner_All.lua")
  runLua("UI_Data/Script/Widget/ItemLog/Panel_Widget_QuestRewardItem.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NpcGift_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NPCShop_All.lua")
  runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelect_All.lua")
  runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelectOption_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Console/Panel_Dialog_WorkerContract.lua")
  runLua("UI_Data/Script/Window/RandomShop/Panel_Window_RandomShop_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_Renew_All.lua")
  if _ContentsGroup_OneButtonBuff == true then
    runLua("UI_Data/Script/Window/AutoBuff/Panel_Window_AutoUseBuffItem.lua")
  end
  runLua("UI_Data/Script/Widget/HelpMessage/Panel_HelpMessage.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalKnowledge_Base.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalGame_All.lua")
  runLua("UI_Data/Script/Window/Knowledge/Panel_Window_Knowledge_Renew.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_IntroMovie_Console.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_DialogMovie.lua")
  if false == _ContentsGroup_Tutorial_Renewal then
    runLua("UI_Data/Script/Tutorial/Tutorial_Manager.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_EventList.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Console/Panel_Tutorial_UiBlackSpirit_Renew.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Console/Panel_Tutorial_UiHeadlineMessage_Renew.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Console/Panel_Tutorial_UiMasking_Renew.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Console/Panel_Tutorial_UiManager_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase1_BasicMove_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase2_BasicControl_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase3_InteractionSupplyBox_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase4_InventoryAndQuickSlot_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase5_CallBlackSpirit_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_Warrior_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_Sorcerer_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_Giant_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_WizardWomen_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_Wizard_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase_BasicSkill_Ranger_Renew.lua")
    runLua("UI_Data/Script/Tutorial/Console/Tutorial_Phase7_FindRequestTarget_Renew.lua")
  else
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Panel_Tutorial_UiBlackSpirit_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiGuideButton_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiHeadlineMessage_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiMasking_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UISmallBlackSpirit.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Panel_Tutorial_UiManager_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Manager.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_EventList.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase8_BaiscMove_Renew.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Giant_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Warrior_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Sorcerer_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_WizardWomen_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Wizard_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Ranger_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Combattant_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_DarkElf_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_BladeMaster_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase_BasicSkill_Ran_ConsoleRenewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Console/Tutorial_Phase7_EquipNewItem_ConsoleRenewal.lua")
  end
  runLua("UI_Data/Script/Widget/Alert/Panel_Widget_LocalQuestAlert.lua")
  runLua("UI_Data/Script/Widget/QuestList/Panel_LatestQuest.lua")
  runLua("UI_Data/Script/Widget/QuestList/Console/Panel_MainQuest_Renew.lua")
  runLua("UI_Data/Script/Widget/QuestList/Panel_CheckedQuest.lua")
  if _ContentsGroup_HardCoreChannel == true then
    runLua("UI_Data/Script/Window/HardCore/HardCoreChannel_UIController.lua")
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    runLua("UI_Data/Script/Widget/HardCore/Panel_HardCoreMenu.lua")
    runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_All.lua")
    runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_Basic_All.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Quest_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_LeftTime_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Result_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Compass_Hardcore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Ranking_Hardcore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Window_Quest_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter_All.lua")
  end
  runLua("UI_Data/Script/Widget/Party/Panel_Widget_Party_All_New.lua")
  runLua("UI_Data/Script/Widget/Party/Panel_Widget_Raid_All.lua")
  runLua("UI_Data/Script/Window/Party/Console/Panel_Window_PartyInvite_Renew.lua")
  runLua("UI_Data/Script/Window/Party/Console/Panel_Window_PartySetting_Renew.lua")
  runLua("UI_Data/Script/Widget/Buff/Panel_AppliedBuffList.lua")
  runLua("UI_Data/Script/Widget/Buff/Panel_AppliedBuffList_Console.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_All.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_InformationView_New.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_CarriageInformation_New.lua")
  if _ContentsGroup_FishingEncyclopedia == true then
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_Renewal_All.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_EncyclopediaNotice.lua")
  else
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All.lua")
  end
  if _ContentsGroup_FishCompetition == true then
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetition.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionMyReward.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionRewardInfo.lua")
  end
  if true == _ContentsGroup_LocalWarOccupation and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWarOccupation_Gauge.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_Window_ClanList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMain_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_History_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeclareWar_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIntroduce_All.lua")
  if true == ToClient_isPS() then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIntro_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfare_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfareNew_All.lua")
  if _ContentsGroup_GuildQuestAndSkillImprove == true then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestList_All.lua")
  else
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuest_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Manufacture_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_ManufactureSelect_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAlliance_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceInvite_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildSkill_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_All.lua")
  if _ContentsGroup_GuildMatch == true then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Score_All.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_GameRecord.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_CountDown.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Rank.lua")
    runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_KillCombo.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeposit_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildAttributeReport_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_List_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_Option_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildDocumentManagement_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildIncentiveSetting_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMemberPointDetail_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointOption_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointMenu_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_SelectGuildMansion_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildPresent_All.lua")
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildJoinRequest_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildVolunteerList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentive_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentiveOption_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildFunctionPanel_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildChangeMark_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildVoiceSet_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAgreement_Console_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAgreementOption_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildUseFunds_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildReceivePay_All.lua")
  runLua("UI_Data/Script/Window/Guild/Console/Panel_Window_GuildWarfareDesc_Renew.lua")
  runLua("UI_Data/Script/Window/Guild/Console/Panel_Guild_InvitationGuildAlliance_Renew.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_CreateClan_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Guild_Create_All.lua")
  if _ContentsGroup_GuildAuthoritySeparation == true then
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_Authorization_All.lua")
  end
  if true == _ContentsGroup_GuildServerWar then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildMainServerSet.lua")
  end
  if true == _ContentsGroup_NewGuildNone then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_SimpleInvite.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_GuildInvite_Alert.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_InviteList.lua")
  end
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_NoneGuild.lua")
    if true == _ContentsGroup_NewGuildNone then
      runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildIntroduceMySelf_All.lua")
    end
  else
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_NoneJoinMember.lua")
  end
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestSet.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildApplyJoinList.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Console/Panel_Window_Clan_Renew.lua")
  runLua("UI_Data/Script/Widget/QuestList/Console/Panel_Widget_GuildQuest.lua")
  runLua("UI_Data/Script/Widget/QuestList/Console/Panel_Widget_LatestQuest.lua")
  if ToClient_isPS() then
    runLua("UI_Data/Script/Window/Guild/Console/Panel_Window_Guild_Introduction_Renew.lua")
  end
  runLua("UI_Data/Script/Widget/LevelUpMessage/Panel_Levelup_Reward.lua")
  runLua("UI_Data/Script/Widget/FadeScreen/Panel_Fade_Screen.lua")
  runLua("UI_Data/Script/Widget/FadeScreen/Panel_FullScreenFade.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_Renew.lua")
  runLua("UI_Data/Script/Widget/Interaction/Console/Panel_Interaction_HouseList_Renew.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_HouseRank.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_WatchingMode.lua")
  runLua("UI_Data/Script/Widget/Housing/Panel_Housing.lua")
  if true == _ContentsGroup_NewUI_InstallMode_All then
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_List_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_SeedList_All.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_Housing_FarmInfo_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_WarInfomation_All.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_House_Name_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_War_All.lua")
  else
    runLua("UI_Data/Script/Widget/Housing/Console/Panel_Widget_HousingName_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_PlantInfo_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_Manager_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_House_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_HousePoint_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_Item_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_FarmInfo_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_WarInfomation_Renew.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Cart_New.lua")
  end
  runLua("UI_Data/Script/Window/Housing/Console/Panel_Window_InstallationMode_VillageTentPopUp_Renew.lua")
  runLua("UI_Data/Script/Widget/Housing/AlertInstallation.lua")
  runLua("UI_Data/Script/Widget/ProgressBar/Console/Panel_Widget_ProgressBar_Renew.lua")
  runLua("UI_Data/Script/Widget/EnemyGauge/Console/Panel_Widget_MonsterBar_Renew.lua")
  runLua("UI_Data/Script/Window/Exchange/Panel_ExchangeWithPC.lua")
  if _ContentsGroup_3DMiniMapOpen then
    runLua("UI_Data/Script/Window/WorldMap/WorldMiniMap.lua")
    runLua("UI_Data/Script/Window/WorldMap/WorldMiniMapPin.lua")
  end
  runLua("UI_Data/Script/Widget/Radar/Radar_Background.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar_Pin.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Function_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MarketitemList_ALL.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MyBasket_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_BiddingGame_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_TradeEventNotice_Renewal_All.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Alchemy_All.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_RecentCook_New.lua")
  runLua("UI_Data/Script/Window/Alchemy/Console/Panel_Alchemy_Knowledge.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_Notify_All.lua")
  runLua("UI_Data/Script/Window/Friend/Panel_FriendList_All.lua")
  if false == _ContentsGroup_NewUI_Mail_All then
    runLua("UI_Data/Script/Window/Mail/Console/Panel_Window_Mail_Renew.lua")
    runLua("UI_Data/Script/Window/Mail/Console/Panel_Window_MailDetail_Renew.lua")
  else
    runLua("UI_Data/Script/Window/Mail/Panel_Window_Mail_All.lua")
    runLua("UI_Data/Script/Window/Mail/Panel_Window_MailDetail_All.lua")
  end
  runLua("UI_Data/Script/Window/Mail/Console/Panel_Widget_NewMailAlarm_Renew.lua")
  runLua("UI_Data/Script/Window/Option/GameOptionHeader_Renew.lua")
  runLua("UI_Data/Script/Window/Option/GameOptionMain_Renew.lua")
  runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
  runLua("UI_Data/Script/Window/Option/Panel_Option_Main_Renew.lua")
  runLua("UI_Data/Script/Window/Option/Panel_SetShortCut.lua")
  runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote_Renew.lua")
  runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote_Search_Renew.lua")
  runLua("UI_Data/Script/Window/KeyboardHelp/Panel_Window_KeyboardHelp.lua")
  runLua("UI_Data/Script/Window/LevelupGuide/Panel_LevelupGuide.lua")
  runLua("UI_Data/Script/Window/QnAWebLink/Panel_QnAWebLink.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingPalette_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingPartList_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingRegister_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingTake_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingEject_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingMenu_Renew.lua")
  runLua("UI_Data/Script/Window/Dye/Console/Panel_Window_DyeingMain_Renew.lua")
  if false == _ContentsGroup_RenewUI then
    runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips.lua")
    runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips_Frame.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Main.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Timing_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_HerbMachine_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Buoy_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_BattleGauge_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GradientY_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Gradient_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_Drum_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_PowerControl_All.lua")
  if true == _ContentsGroup_NewUI_Fishing_All then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Command_All.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SinGauge_All.lua")
    runLua("UI_Data/Script/Widget/PowerGauge/Panel_Widget_PowerGauge_All.lua")
  else
    runLua("UI_Data/Script/Widget/MiniGame/Console/MiniGame_SinGauge_Renew.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Console/MiniGame_Command_Renew.lua")
    runLua("UI_Data/Script/Widget/PowerGauge/Console/Panel_PowerGauge_Renew.lua")
  end
  if true == _ContentsGroup_NewUI_Jaksal_All then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Jaksal_All.lua")
  else
    runLua("UI_Data/Script/Widget/MiniGame/Console/MiniGame_Jaksal_Renew.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_FillGauge.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Steal.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_SteeringGear.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Hammer.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Clear.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Find_All.lua")
  if true == _ContentsGroup_MiniGame_YachtDice then
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Notice.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Invite.lua")
  end
  if _ContentsGroup_MiniGame_YachtDice_Match == true then
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch.lua")
  end
  if _ContentsGroup_RewardMarket == true then
    runLua("UI_Data/Script/Window/Dialog/Panel_Window_RewardMarket_All.lua")
  end
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_DummyCharacter_CC.lua")
  runLua("UI_Data/Script/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_Tutorial.lua")
  runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_BossInstance_Dummy.lua")
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    runLua("UI_Data/Script/Widget/Search/Panel_Widget_DialogSearch_All.lua")
  else
    runLua("UI_Data/Script/Widget/Search/Panel_Dialog_Search.lua")
  end
  runLua("UI_Data/Script/Window/GameExit/Panel_ChannelSelect_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_GameExit_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitConfirm_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_SearchResult.lua")
  runLua("UI_Data/Script/Window/GameExit/Console/Panel_Window_GameExit_Confirm_Renew.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_NoAccessArea_Alert.lua")
  runLua("UI_Data/Script/Widget/Enduarance/Enduarance.lua")
  runLua("UI_Data/Script/Widget/BreathGauge/Panel_BreathGauge.lua")
  runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All.lua")
  runLua("UI_Data/Script/Window/Repair/Panel_Window_SetupRepair_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Endurance_Recovery_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Costume_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Crystal_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_System_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Blackstone_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Caphras_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All.lua")
  runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_Result.lua")
  runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_All.lua")
  if _ContentsGroup_CouponCode == true then
    basicLoadUI("UI_Data/Window/InWeb/Panel_Window_CouponCode.XML", "Panel_Window_CouponCode", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/InWeb/Panel_Window_CouponCode_Input.XML", "Panel_Window_CouponCode_Input", UIGroup.PAGameUIGroup_Windows)
  end
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_Enter.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_WeaponChange.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_NakClear.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_RegionChange.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_MapSelecter.lua")
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss) and true == _ContentsGroup_AtoraxionSea then
    runLua("UI_Data/Script/Window/Movie/Panel_AtoraxionMovie.lua")
  end
  runLua("UI_Data/Script/Widget/Arena/Panel_Arena_Battle.lua")
  runLua("UI_Data/Script/Widget/Arena/Panel_Window_Arena_Waiting.lua")
  runLua("UI_Data/Script/Tutorial/TutorialMain.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/ArousalTutorial_Manager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiManager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiBlackSpirit.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiHeadlineMessage.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiKeyButton.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_Person.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_GameExit.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestInfo_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All.lua")
  if true == _ContentsGroup_FeverQuest and true == _ContentsGroup_WorldmapFeverQuest then
    runLua("UI_Data/Script/Window/Quest/Panel_Widget_RandomQuestInfo_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxElvia_All.lua")
  runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_Quest.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestBranch.lua")
  if true == _ContentsGroup_TotalReward then
    runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalReward_All.lua")
    runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalRewardHistory_All.lua")
  end
  runLua("UI_Data/Script/Widget/Dialogue/Console/Panel_AskKnowledge_Renew.lua")
  runLua("UI_Data/Script/Widget/NaviPath/NaviPath.lua")
  runLua("UI_Data/Script/Widget/TownNpcNavi/Panel_Widget_TownNpcNavi.lua")
  runLua("UI_Data/Script/CutScene.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceMain.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_LetterBox.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SubTitle.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceNotifier.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkip.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkipPopUp.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkipEscPopUp.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_DeadMessage.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_R_SkipMessageBox.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_TitleTexture.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_KeyGuide.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SkillCommandGuide.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_HpMpBar.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Stamina.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Adrenallin.lua")
  runLua("UI_Data/Script/Widget/InGameCustomize/InGameCustomize.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Cart.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MakePaymentsFromCart.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GoodsTooltip.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GoodsDetailInfo.lua")
  if true == _ContentsGroup_PearlShopMileage then
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All.lua")
  end
  if _ContentsGroup_PearlShopMoonBlessingRenew == true then
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_Renew_All.lua")
  end
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_SetEquip.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyOrGift.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_PaymentPassword.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_ChargeDaumCash.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_TermsofDaumCash.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyPearlBox.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_HowUsePearlShop.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Coupon.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EventCart.lua")
  runLua("UI_Data/Script/Widget/CashShopAlert/Recommend_Manager.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods_PopUp.lua")
  runLua("UI_Data/Script/Widget/WarInfoMessage/Panel_WarInfoMessage.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_PearlShop.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_Pearlshop_Category.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_Pearlshop_ProductInfo.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_PearlShop_ProductBuy.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_PearlShop_DisplayController.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Console/Panel_PearlShop_Coupon.lua")
  if _ContentsGroup_RefundCashProduct == true then
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack.lua")
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Desc.lua")
  end
  runLua("UI_Data/Script/Widget/Coupon/Coupon.lua")
  runLua("UI_Data/Script/Window/Cash_Customization/Panel_Cash_Customization.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Function.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_ItemSet.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarketNew.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Favorite.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_RegistItem.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_AlarmList.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Alarm.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_PreBid.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_PreBid_Manager.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Password.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Alarm_New.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_NewAlarm.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_ItemMarket_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Wallet_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Function_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_WalletManager_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Main_ConsoleAssist.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_MyInventory_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_WalletInventory_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Sell_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Buy_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Filter_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_SelectList_Renew.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Console/Panel_Window_MarketPlace_Main_Renew.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Common_ItemMarketFunction.lua")
  runLua("UI_Data/Script/Window/BossAlert/Panel_BossAlert_Setting.lua")
  runLua("UI_Data/Script/Window/BossAlert/Panel_BossAlert_Alarm.lua")
  runLua("UI_Data/Script/Widget/Gacha_Roulette/Panel_Gacha_Roulette_All.lua")
  runLua("UI_Data/Script/Widget/PowerGauge/CannonGuage.lua")
  runLua("UI_Data/Script/Window/PcRoomNotify/Panel_PcRoomNotify.lua")
  runLua("UI_Data/Script/Window/EventNotify/Console/Panel_NewsBanner.lua")
  if true == _ContentsGroup_NewUI_EventNotify_All then
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotify_All.lua")
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotifyContent_All.lua")
  end
  if _ContentsGroup_EventGuidePage == true then
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventGuide_Total.lua")
  end
  runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_CarveSeal_All.lua")
  if true == _ContentsGroup_DeleteMaxEnchanterName then
    runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName.lua")
  end
  runLua("UI_Data/Script/Window/ClearVested/Panel_ClearVested.lua")
  runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_UIModify_All_Console.lua")
  runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_Alarm_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeSkill_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Restore_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Tooltip_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeName_All.lua")
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_ExchangeExp_All.lua")
  if true == _ContentsGroup_NewUI_TransferLifeExp_All then
    runLua("UI_Data/Script/Window/TransferLifeExperience/Panel_TransferLifeExperience_All.lua")
  else
    runLua("UI_Data/Script/Window/TransferLifeExperience/Panel_TransferLifeExperience.lua")
  end
  runLua("UI_Data/Script/Window/ChangeItem/Console/Panel_Window_ChangeItem_Renew.lua")
  if true == _ContentsGroup_NewUI_ChangeItem_All then
    runLua("UI_Data/Script/Window/ChangeItem/Panel_Window_ChangeItem_All.lua")
  else
    runLua("UI_Data/Script/Window/ChangeItem/Panel_ChangeWeapon.lua")
  end
  if _ContentsGroup_AlchemyStoneRenewal == true then
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_Renewal_All.lua")
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStoneEvolve_All.lua")
  else
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_All.lua")
  end
  if true == _ContentsGroup_ArtifactItem then
    runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_All.lua")
  end
  runLua("UI_Data/Script/Window/Alchemy/Panel_AlchemyFigureHead_All.lua")
  runLua("UI_Data/Script/Window/RallyRanking/Panel_RallyRanking.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWar.lua")
  runLua("UI_Data/Script/Window/Join/Panel_Window_Join.lua")
  runLua("UI_Data/Script/Widget/WarInfoMessage/Console/Panel_TerritoryWar_Caution_Renew.lua")
  runLua("UI_Data/Script/Widget/Alert/Alert_Message.lua")
  runLua("UI_Data/Script/Widget/Alert/Alert_Message_Control.lua")
  runLua("UI_Data/Script/Window/Item/Panel_Itemwarp_All.lua")
  runLua("UI_Data/Script/Window/Item/ConnectUi.lua")
  if _ContentsGroup_Telescope == true then
    runLua("UI_Data/Script/Window/Item/Panel_Window_Telescope_All.lua")
  end
  runLua("UI_Data/Script/Window/GoldenTreasureBox/Panel_TreasureBox_All.lua")
  runLua("UI_Data/Script/Widget/ScreenshotMode/Panel_ScreenShot_WebAlbum.lua")
  runLua("UI_Data/Script/Widget/ScreenshotMode/Panel_ScreenShotAlbum_FullScreen.lua")
  runLua("UI_Data/Script/Widget/QuestList/Panel_CheckedQuest_Option.lua")
  runLua("UI_Data/Script/Window/Broadcast/Panel_Broadcast.lua")
  runLua("UI_Data/Script/Widget/CashShopAlert/Panel_CashShopAlert.lua")
  runLua("UI_Data/Script/SeasonTexture_Window.lua")
  if true == _ContentsGroup_SeasonContents then
    runLua("UI_Data/Script/Window/Season/Panel_Window_ChangeSeasonCharacter_All.lua")
  end
  if true == _ContentsGroup_GrowthPass then
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass.lua")
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_Info.lua")
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_PointShop.lua")
  end
  runLua("UI_Data/Script/Widget/Awakening_Succession/Panel_Awakening_Succession.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Renewal/Console/Panel_Widget_FunctionButton_Console.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonReward_All.lua")
  runLua("UI_Data/Script/Widget/NakMessage/ActionMessage.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_RescueShipBubble.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonGamos.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/Panel_SummonKatsvariak.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_TamingBubble.lua")
  runLua("UI_Data/Script/Widget/BossWave/Panel_BossWave.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_PartyList_All.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_PartyRecruite_All.lua")
  runLua("UI_Data/Script/Window/Party/Console/Panel_Window_FindPartyRecruite_Renew.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_GuildPartyList_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantResurrection.lua")
  runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_BlackSpiritAdventure2.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All.lua")
  runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_ChallengeAlert.lua")
  if _ContentsGroup_MorningLand == true then
    runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_MorningLand.lua")
  end
  if _ContentsGroup_LightStoneBag == true then
    runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_LightStoneBag.lua")
    runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_ArtifactPreset_All.lua")
  end
  runLua("UI_Data/Script/AutoQuest/AutoFrameCheckManager.lua")
  runLua("UI_Data/Script/Widget/TimeAttack/TimeAttack.lua")
  runLua("UI_Data/Script/Window/MonsterRanking/Panel_Window_MonsterRanking.lua")
  runLua("UI_Data/Script/ReconnectAction/HorseRiding.lua")
  runLua("UI_Data/Script/Window/Under18/Panel_Window_Under18.lua")
  runLua("UI_Data/Script/Widget/ConsoleKeyGuide/Panel_ConsoleKeyGuide.lua")
  runLua("UI_Data/Script/Widget/ConsoleKeyGuide/Panel_ConsoleWorldMapKeyGuide.lua")
  runLua("UI_Data/Script/Widget/Camera/Panel_Widget_Camera_Mode_All.lua")
  runLua("UI_Data/Script/Window/BlackDesertLab/Panel_Window_BlackDesertLab.lua")
  runLua("UI_Data/Script/Panel_OnlyPerframeUsed.lua")
  runLua("UI_Data/Script/Panel_CommonGameScreenUI_Console.lua")
  loadCustomizationUI_XB()
  runLua("UI_Data/Script/QASupport/QASupportMain.lua")
  runLua("UI_Data/Script/QASupport/QADontSpawn.lua")
  runLua("UI_Data/Script/QASupport/QASupportDamageWriter.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupportMain.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupport_All.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupport_Command.lua")
  runLua("UI_Data/Script/Window/TranslationReport/Panel_TranslationReport.lua")
  runLua("UI_Data/Script/Window/TranslationReport/Panel_Window_TranslationText.lua")
  if true == ToClient_isPS() then
    runLua("UI_Data/Script/Window/Report/Panel_Window_Report.lua")
  end
  if true == isGameServiceTypeTurkey() then
    runLua("UI_Data/Script/Window/TurkeyIME/Panel_TurkeyIME.lua")
  end
  if true == _ContentsGroup_isMemoOpen then
    runLua("UI_Data/Script/Window/Memo/Panel_Memo_Main.lua")
    runLua("UI_Data/Script/Window/Memo/Panel_Memo_Sticky.lua")
  end
  runLua("UI_Data/Script/Window/RecommendEngine/Panel_RecommendEngine_Main.lua")
  ToClient_loadQuickMenuPanel(Panel_QuickMenu)
  runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenu.lua")
  runLua("UI_Data/Script/Widget/Menu/Console/ConsoleQuickMenu.lua")
  runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenuSetting.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_NpcGift.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Console/Panel_Dialog_NpcGift_Renew.lua")
  runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All.lua")
  runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_NumPad_All.lua")
  runLua("UI_Data/Script/Window/Purification/Panel_Window_Purification_All.lua")
  if _ContentsGroup_CardGame then
    runLua("UI_Data/Script/Window/CardGame/Panel_Window_CardGame.lua")
  end
  runLua("UI_Data/Script/Widget/Menu/Panel_Widget_Menu_Remake.lua")
  runLua("UI_Data/Script/Window/PreOrder/Panel_Window_PreOrder.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Common_MainStatus_Console.lua")
  runLua("UI_Data/Script/Window/KeyboardHelp/console/Panel_Window_KeyGuide.lua")
  if _ContentsGroup_UsingPMAPI == true then
    runLua("UI_Data/Script/Window/AccountLinking/Console/Panel_Window_AccountLinking_Web.lua")
  else
    runLua("UI_Data/Script/Window/AccountLinking/Console/Panel_Window_AccountLinking_Renew.lua")
  end
  runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
  runLua("UI_Data/Script/Window/StoryInstanceDungeon/Panel_Window_StoryInstanceDungeon.lua")
  runLua("UI_Data/Script/Window/BossAlert/Panel_BossAlert_SettingV2_All.lua")
  if true == _ContentsGroup_Console_PersonalMonster then
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonster_All.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo_All.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage_All.lua")
  end
  if _ContentsGroup_bloodAltar_renewal == true then
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltar_All.lua")
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Widget_BloodAltarGauge_All.lua")
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltarRetry_All.lua")
  end
  runLua("UI_Data/Script/Widget/BloodAltar/Panel_Widget_BloodAltarJoin.lua")
  runLua("UI_Data/Script/Window/Rank/Panel_Window_AltarRank.lua")
  runLua("UI_Data/Script/Window/PowerSave/Panel_Window_PowerSave_All.lua")
  runLua("UI_Data/Script/Widget/AccesoryQuest/Panel_Widget_AccesoryQuest.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ItemMoveSet.lua")
  if true == _ContentsGroup_OceanCurrent then
    runLua("UI_Data/Script/Window/Servant/ShipEquipManagement/Panel_Window_ShipEquipManagement_ALL.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_OceanGuide.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill_Servant.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_ShipSpeedGauge_All.lua")
    runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon.lua")
    runLua("UI_Data/Script/Window/Common/Panel_Window_ItemFilter_All.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_SailControl.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipControl_Console.lua")
    runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_BarterInfo.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyBoost.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyMember.lua")
    if _ContentsGroup_EmployeePresetJob == true then
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetManager_All.lua")
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetGroup_All.lua")
      runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_Renewal_All.lua")
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All.lua")
      if _ContentsGroup_EmployeeAutoFishingDiscard == true then
        runLua("UI_Data/Script/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard.lua")
      end
    end
  end
  if _ContentsGroup_MorningLand == true then
    if _ContentsGroup_MorningLand2 == true then
      runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard2_All.lua")
    else
      runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard_All.lua")
    end
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_Boss_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_Ranking_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_ConquestHistory_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_Scenario_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_DetailReward_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_MyReward_All.lua")
    runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_ConquestGiveUp_All.lua")
    runLua("UI_Data/Script/Widget/AlertArea/Panel_MorningLand_QuestBoardAlert_All.lua")
  end
  if true == _ContentsGroup_Sailor then
    runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All.lua")
    runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Employee_HireItem_All.lua")
  end
  if true == _ContentsGroup_Barter then
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_Barter.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoRefresh.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_Special.lua")
    runLua("UI_Data/Script/Widget/GreatSea/Panel_Window_Anchor.lua")
    runLua("UI_Data/Script/Window/Servant/CargoLoading/Panel_Window_CargoLoading_ALL.lua")
    runLua("UI_Data/Script/Widget/GreatSea/Panel_Widget_GreatSeaEvent.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgradeInfo.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade_Tree.lua")
    runLua("UI_Data/Script/Widget/GreatSea/Panel_Widget_OnOffShip_All.lua")
  end
  if true == _ContentsGroup_SelectBox then
    runLua("UI_Data/Script/Window/ItemBox/Panel_Window_SelectBox.lua")
  end
  runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_ForReward.lua")
  if _ContentsGroup_NewCloseManager then
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_ExceptionList.lua")
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_Renew.lua")
  else
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager.lua")
  end
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderUiInputType.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderManager.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinder.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_Invitation_All.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_LetterScroll_All.lua")
  if true == _ContentsGroup_RenewalLifeGradeUpUI then
    runLua("UI_Data/Script/Widget/NakMessage/NakMessage_Life.lua")
  end
  runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_AngerGage.lua")
  if true == _ContentsGroup_FairySkillChangeRateView then
    runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyRateDesc.lua", "Panel_Window_FairyRateDesc")
  end
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneSkip.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneScript.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutScene_ESC_Skip.lua")
  runLua("UI_Data/Script/Widget/BlackSpirit_SkillSelect/Panel_Widget_BlackSpirit_SkillSelect.lua")
  runLua("UI_Data/Script/Widget/SkillCommand/UI_Widget_SkillCommand.lua")
  runLua("UI_Data/Script/Widget/SkillCommand/UI_Widget_SkillCommand_Cutscene.lua")
  runLua("UI_Data/Script/Window/Invite/Panel_Window_Invite_All.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_QuizGM_All.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_All.lua")
  if _ContentsGroup_QuizEvent == true then
    runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_Minimal_All.lua")
  end
  runLua("UI_Data/Script/Window/Event/Panel_Event_TicketShop_All.lua")
  runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Siege_All.lua")
  runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionContract_All.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_ImageSlider_All.lua")
  runLua("UI_Data/Script/Widget/Ping/Panel_Widget_Ping_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Window_PersonalField_Main_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_Enter_All.lua")
  if true == _ContentsGroup_SelectStartPosition then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All.lua")
  end
  runLua("UI_Data/Script/Window/Arsha/Panel_Window_Arsha_ApplyWeb_forConsole.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_RecoveryElephant.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_ClassResource.lua")
  runLua("UI_Data/Script/Window/Color/Panel_GuildWar_Color_All.lua")
  runLua("UI_Data/Script/Window/Color/Panel_GuildWar_ColorList_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_Arbitration.lua")
  runLua("UI_Data/Script/Widget/EnterElvia/Panel_Widget_HadumField_Enter_All.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chat_Process_All.lua")
  runLua("UI_Data/Script/Window/WareHouse/NakMessage_Warehouse_Clear_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_AbyssOne_Help.lua")
  if _ContentsGroup_MagnusEasyTeleport == true then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_MagnusEasyTeleportMap.lua")
  end
  runLua("UI_Data/Script/Widget/NakMessage/AbyssOne_SKill_NakMessage.lua")
  if _ContentsGroup_ArtifactItem == true then
    runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_All.lua")
  end
  runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_Log_All.lua")
  runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_GuildBossField_Enter_All.lua")
  runLua("UI_Data/Script/Window/Guide/Panel_Window_ContentsGuide.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Servant_All.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_Bromide_All.lua")
  if _ContentsGroup_JewelPreset == true then
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelPreset_All.lua")
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelInven_All.lua")
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelTooltip_All.lua")
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_CrystalSet_All.lua")
  end
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_TrashBoxConfirm_All.lua")
  if _ContentsGroup_PearlBoxWebBuy == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_WebPurchaseConfirm_All.lua")
  end
  runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BossReward_All.lua")
  runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BoxReward_All.lua")
  runLua("UI_Data/Script/Window/FieldWalkingCamera/Panel_FieldWalkingCamera.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_SpecialPass_All.lua")
  if _ContentsGroup_MonsterBuffZone == true then
    runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone.lua")
    runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair.lua")
  end
  runLua("UI_Data/Script/Window/Siege/Panel_Window_VillageSiegeMenu_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Window_SiegeResult_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Window_OceanSiegeResult_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Widget_VillageSiegeState_All.lua")
  if _ContentsGroup_ExchangeCoinSystem == true then
    runLua("UI_Data/Script/Window/Exchange/Panel_ExchangeCoin_All.lua")
  end
  runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All.lua")
  runLua("UI_Data/Script/Window/Tutorial/Console/Panel_Window_FantasyHorseGuide_Console.lua")
  if _ContentsGroup_MorningLandTierGo == true then
    runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All.lua")
  end
  if _ContentsGroup_ItemSkillOption == true then
    runLua("UI_Data/Script/Window/Enchant/Panel_ItemSkillOption_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_MakeGoonWang_All.lua")
  end
  if _ContentsGroup_MorningLandTierParty == true then
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxForSequence_All.lua")
  end
  runLua("UI_Data/Script/Window/AutoMove/Panel_AutoMove_Result_All.lua")
  runLua("UI_Data/Script/Widget/Tooltip/Panel_Window_CharacterStat_All.lua")
  if _ContentsGroup_RedBattleFieldMatching == true then
    runLua("UI_Data/Script/Widget/LocalWar/Panel_Widget_LocalWar_Match_All.lua")
    runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWar_Match_Confirm_All.lua")
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Notation_Ability_All.lua")
  end
  if _ContentsGroup_TotalPreset == true then
    runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotal_All.lua")
    runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotalMemo.lua")
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgeStonePreset_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All.lua")
  end
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Select_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Page_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Book_All.lua")
  if _ContentsGroup_SnowBoardMirrorField == true then
    runLua("UI_Data/Script/Window/SnowBoard/SnowBoardMain.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Result_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard.lua")
  end
  if _ContentsGroup_LootingItemRecord == true then
    runLua("UI_Data/Script/Window/Looting/Panel_Window_LootingItemReport_Main_All.lua")
  end
  runLua("UI_Data/Script/Window/Common/Panel_Widget_Common_Countdown.lua")
  isLuaLoadingComplete = true
end
function preloadCustomizationUI_XB()
  loadUI("UI_Data/Customization/Console/Panel_Customizing.xml", "Panel_Customizing", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_BodyPose.xml", "Panel_Customizing_BodyPose", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_BodyShape.xml", "Panel_Customizing_BodyShape", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_Skin.xml", "Panel_Customizing_Skin", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_FaceShape.xml", "Panel_Customizing_FaceShape", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_HairShape.xml", "Panel_Customizing_HairShape", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_Mesh.xml", "Panel_Customizing_Mesh", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_InputName.xml", "Panel_Customizing_InputName", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_ShowOutfit.xml", "Panel_Customizing_ShowOutfit", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_ShowPose.xml", "Panel_Customizing_ShowPose", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_Voice.xml", "Panel_Customizing_Voice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_CommonDecoration.xml", "Panel_Customizing_CommonDecoration", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/Console/Panel_Customizing_KeyGuide.xml", "Panel_Customizing_KeyGuide", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  basicLoadUI("UI_Data/UI_Lobby/UI_Startl.xml", "Panel_Start", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Customization/UI_Customization_Message.xml", "Panel_CustomizationMessage", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/FileExplorer/FileExplorer.XML", "Panel_FileExplorer", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/CustomizingAlbum/Console/Panel_Window_CustomizingAlbum_Renew.xml", "Panel_CustomizingAlbum", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Widget/ScreenShotMode/Panel_Widget_ScreenShotFrame.xml", "Panel_Widget_ScreenShotFrame", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_customScreenShot,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_RgbUIPick or true == _ContentsGroup_RgbUIPickForItem then
    loadUI("UI_Data/Window/ColorPalette/Panel_Window_ColorPalette.XML", "Panel_Window_ColorPalette_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_IngameCustomize
    }))
  end
end
function loadCustomizationUI_XB()
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Main_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Common_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Decoration_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_HairShape_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Mesh_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_CustomizaingHandle_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_PaletteHandle_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_FaceBone_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_BodyBone_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_BodyPose_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Skin_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_Voice_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_ShowPose_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_ShowCloth_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_InputName_Renew.lua")
  runLua("UI_Data/Script/Customization/Console/Panel_Customization_KeyGuide.lua")
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer.lua")
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer_GuildInfo.lua")
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer_Customization.lua")
  runLua("UI_Data/Script/Customization/Panel_Customization_WebAlbum_Renew.lua")
  runLua("UI_Data/Script/Widget/CustomScreenShot/CustomScreenShot_Renew.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  if true == _ContentsGroup_RgbUIPick or true == _ContentsGroup_RgbUIPickForItem then
    runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All.lua")
  end
end
function loadPadSnapTargetEffect()
  loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
end
function loadPadBlackBackgroundEffect()
  loadUI("UI_Data/Window/BlackBackground/Panel_Global_BlackBackGround.xml", "Panel_Global_BlackBackGround", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Window/BlackBackground/Panel_Global_BlackBackground.lua")
end
function loadWorldMapUI_XB()
  ToClient_initializeWorldMap("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_Base.XML")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_RingMenu_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_TopMenu_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_BottomMenu_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_Main_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_SellBuyCondition_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseManagement_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_GuildHouseManagement_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeInfo_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeManagement_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_RightMenu_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_Stable_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseFilter_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeProduct_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseCraft_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_HouseCraft_Large_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_TerritoryTooltip.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_NodeSiegeTooltip_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_StableList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Console/Panel_Worldmap_WarFilter_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_ActorTooltip.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Console/Panel_Worldmap_NodeWarInfo_Renew.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Console/Panel_WorldMap_WarInfo_Renew.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PopupManager.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_HouseHold.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Knowledge.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Town_WorkerManage.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Working_Progress.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Delivery.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WroldMap_TradeNpcItemInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_TradeNpcList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Tent.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PinGuide.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_QuestTooltip.lua")
  if true == _ContentsGroup_WorldMapNodeNavigation then
    runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_NodeNavigation.lua")
  end
  if true == _ContentsGroup_NewSequenceTutorial then
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SequenceTutorial.lua")
  end
  runLua("UI_Data/Script/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft_ChangeWorker.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Worldmap_Grand_NodeLevel.lua")
  runLua("UI_Data/Script/Window/WareHouse/Console/Panel_WareHouseFunctionPanel_All.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyChracterPin.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyCharacterList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyCharacterChangeMemo.lua")
  ToClient_postInitializeWorldmapConsole()
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Contents_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Hud_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Edania_CountDown_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Challenger_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Join_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Worldmap_Castle_All.lua")
  if _ContentsGroup_OlviaAcademy == true then
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Main_All.lua")
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Pass_All.lua")
  end
end
PaGlobal_SetLoadUIFunc(loadLogoUI_XB, LOADUI_TYPE.logoUI)
PaGlobal_SetLoadUIFunc(loadLoginUI_XB, LOADUI_TYPE.loginUI)
PaGlobal_SetLoadUIFunc(loadServerSelectUI_XB, LOADUI_TYPE.serverSelectUI)
PaGlobal_SetLoadUIFunc(loadLoadingUI_XB, LOADUI_TYPE.loadingUI)
PaGlobal_SetLoadUIFunc(loadLobbyUI_XB, LOADUI_TYPE.lobbyUI)
PaGlobal_SetLoadUIFunc(preLoadGameUI_XB, LOADUI_TYPE.preLoadGameUI)
PaGlobal_SetLoadUIFunc(loadGameUI_XB, LOADUI_TYPE.GameUI)
PaGlobal_SetLoadUIFunc(loadWorldMapUI_XB, LOADUI_TYPE.WorldMapUI)
function reloadUI_XB_SwapCharacter()
  if _ContentsGroup_ShowOtherClassSkill == true then
    loadUI("UI_Data/Window/Skill/Panel_Window_SkillGroup_All.xml", "Panel_Window_SkillGroup_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_All.lua")
    FromClient_SkillGroup_All_Init()
  else
    loadUI("UI_Data/Window/Skill/Panel_Skill_Play_Main_All.xml", "Panel_Window_SkillGroup", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup.lua")
    FromClient_SkillGroupInit()
  end
end
PaGlobal_SetReloadUIFunc(reloadUI_XB_SwapCharacter, __eUIReloadEventType_SwapCharacter)
