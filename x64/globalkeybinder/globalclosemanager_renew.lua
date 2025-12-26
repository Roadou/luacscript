local closeTypeBitSet = {
  none = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_CantClose
  }),
  attacked = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape,
    Defines.CloseType.eCloseType_Attacked
  }),
  attackedOnly = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Attacked
  }),
  default = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }),
  forceOnly = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Force
  }),
  escapeOnly = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_EscapeOnly
  })
}
local _isAllClose = false
function addCloseExceptionList()
  if nil ~= PaGlobalFunc_GetDamagePanel_Count then
    for index = 1, PaGlobalFunc_GetDamagePanel_Count() do
      if nil ~= PaGlobalFunc_GetDamagePanel(index) then
        table.insert(panel_exceptionList, PaGlobalFunc_GetDamagePanel(index))
      end
    end
  end
end
function closeExceptionListInitialize()
  for index, panel in pairs(PaGlobal_panelExceptionList) do
    if nil ~= panel then
      panel:RegisterCloseLuaFunc(closeTypeBitSet.none, "")
    end
  end
  panel_exceptionList = nil
  PaGlobal_panelExceptionList = nil
end
function registerCloseLuaEvent(panel, closeFlag, closeFunc)
  if nil == panel or nil == closeFlag or nil == closeFunc then
    return
  end
  panel:RegisterCloseLuaFunc(closeFlag, closeFunc)
end
function registerClosePanelList()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    registerCloseLuaEvent(Panel_EventNotify_All, closeTypeBitSet.default, "PanelCloseFunc_EventNotify()")
  else
    registerCloseLuaEvent(Panel_EventNotify, closeTypeBitSet.default, "PanelCloseFunc_EventNotify()")
  end
  registerCloseLuaEvent(Panel_NewsBanner, closeTypeBitSet.default, "PaGlobalFunc_NewsBanner_Close()")
  if _ContentsGroup_EventGuidePage == true then
    registerCloseLuaEvent(Panel_EventGuide_Total, closeTypeBitSet.default, "PaGlobalFunc_EventGuide_Total_Close()")
  end
  if false == _ContentsGroup_PanelReload_Develop or true == _ContentsGroup_RenewUI then
    registerCloseLuaEvent(Panel_Window_ServantInventory, closeTypeBitSet.default, "ServantInventory_Close()")
    registerCloseLuaEvent(Panel_Guild_GetGuildMemberBonus, closeTypeBitSet.default, "FGlobal_GetGuildMemberBonus_Hide()")
    registerCloseLuaEvent(Panel_Window_Guild, closeTypeBitSet.default, "PanelCloseFunc_Guild()")
    registerCloseLuaEvent(Panel_Window_CharInfo_Status, closeTypeBitSet.default, "PanelEscapeFunc_CharacterInfo_Close()")
    if true == _ContentsGroup_Guild_JoinRequest then
      registerCloseLuaEvent(Panel_Guild_NoneGuild, closeTypeBitSet.default, "PaGlobal_Guild_NoneGuild:close()")
      if true == _ContentsGroup_NewGuildNone then
        registerCloseLuaEvent(Panel_Guild_IntroduceMySelf, closeTypeBitSet.default, "PaGlobal_GuildIntroduceMySelf_Close")
      end
    else
      registerCloseLuaEvent(Panel_Guild_NoneJoinMember, closeTypeBitSet.default, "PaGlobal_Guild_NoneJoinMember:Close()")
    end
    registerCloseLuaEvent(Panel_Guild_ChoiseTheMoney, closeTypeBitSet.default, "PaGlobal_Guild_ChoiseTheMoney:Hide()")
    registerCloseLuaEvent(Panel_GuildIncentive, closeTypeBitSet.default, "PanelCloseFunc_GuildIncentive()")
    registerCloseLuaEvent(Panel_RandomBoxSelect, closeTypeBitSet.attacked, "FGlobal_Gacha_Roulette_Close()")
    registerCloseLuaEvent(MiniGame_SniperReload, PAUIRenderModeBitSet({
      Defines.CloseType.eCloseType_Attacked
    }), "PaGlobalFunc_SniperGame_EndSniperGame()")
    registerCloseLuaEvent(Panel_SniperGame, PAUIRenderModeBitSet({
      Defines.CloseType.eCloseType_Attacked
    }), "PaGlobalFunc_SniperGame_EndSniperGame()")
    registerCloseLuaEvent(Panel_SniperGame_Result, PAUIRenderModeBitSet({
      Defines.CloseType.eCloseType_Attacked
    }), "PaGlobalFunc_SniperGame_EndSniperGame()")
  end
  registerCloseLuaEvent(Panel_Gacha_Roulette, closeTypeBitSet.attacked, "PaGlobalFunc_RandomRoulette_Close()")
  registerCloseLuaEvent(Panel_Window_DailyStamp, closeTypeBitSet.default, "PanelCloseFunc_DailyStamp()")
  registerCloseLuaEvent(Panel_Window_ArshaTeamNameChange, closeTypeBitSet.default, "PanelCloseFunc_ArshaTeamNameChange()")
  registerCloseLuaEvent(Panel_Window_ArshaInviteList, closeTypeBitSet.default, "PanelCloseFunc_ArshaInviteList()")
  registerCloseLuaEvent(Panel_Window_Arsha, closeTypeBitSet.default, "PanelCloseFunc_Arsha()")
  registerCloseLuaEvent(Panel_ScreenShotAlbum_FullScreen, closeTypeBitSet.default, "PanelCloseFunc_ScreenShotAlbumFullScreen()")
  registerCloseLuaEvent(Panel_ScreenShotAlbum, closeTypeBitSet.default, "PanelCloseFunc_ScreenShotAlbum()")
  registerCloseLuaEvent(Panel_Window_BlackSpiritAdventure, closeTypeBitSet.default, "PanelCloseFunc_BlackSpiritAdventure()")
  registerCloseLuaEvent(Panel_Window_BlackSpiritAdventure_2, closeTypeBitSet.default, "PanelCloseFunc_BlackSpiritAdventure2()")
  registerCloseLuaEvent(Panel_Window_BlackSpiritAdventureVerPC, closeTypeBitSet.default, "PanelCloseFunc_BlackSpiritAdventureVerPC()")
  registerCloseLuaEvent(Panel_Window_EventMarbleGame, closeTypeBitSet.default, "PanelCloseFunc_EventMarbleGame()")
  registerCloseLuaEvent(Panel_Window_ClothInventory, closeTypeBitSet.default, "PanelCloseFunc_ClothInventory()")
  registerCloseLuaEvent(Panel_Window_MasterpieceAuction, closeTypeBitSet.default, "PanelCloseFunc_MasterpieceAuction()")
  registerCloseLuaEvent(Panel_Masterpiece_Auction_All, closeTypeBitSet.default, "PanelCloseFunc_MasterpieceAuction()")
  registerCloseLuaEvent(Panel_MovieGuide_Web, closeTypeBitSet.default, "PanelCloseFunc_MovieGuideWeb()")
  registerCloseLuaEvent(Panel_MovieGuide_Weblist, closeTypeBitSet.default, "PanelCloseFunc_MovieGuideWebList()")
  registerCloseLuaEvent(Panel_MovieSkillGuide_Web, closeTypeBitSet.default, "PanelCloseFunc_MovieSkillGuideWeblist()")
  registerCloseLuaEvent(Panel_MovieSkillGuide_Weblist, closeTypeBitSet.default, "PanelCloseFunc_MovieSkillGuide()")
  registerCloseLuaEvent(Panel_Window_Quest_New_Option, closeTypeBitSet.default, "PanelCloseFunc_CheckedQuestQption()")
  registerCloseLuaEvent(Panel_SaveSetting, closeTypeBitSet.default, "PanelCloseFunc_SaveSetting()")
  if _ContentsGroup_HarvestList_All then
    registerCloseLuaEvent(Panel_HarvestList_All, closeTypeBitSet.default, "PaGlobal_HarvestList_All_Close()")
  else
    registerCloseLuaEvent(Panel_HarvestList, closeTypeBitSet.default, "PanelCloseFunc_HarvestList()")
  end
  registerCloseLuaEvent(Panel_PartyRecruite, closeTypeBitSet.default, "PanelCloseFunc_PartyRecruite()")
  registerCloseLuaEvent(Panel_ServantResurrection, closeTypeBitSet.default, "PanelCloseFunc_ServantResurrection()")
  registerCloseLuaEvent(Panel_Dialog_NPCShop, closeTypeBitSet.default, "PanelCloseFunc_DialogNPCShopRenew()")
  registerCloseLuaEvent(Panel_Window_NpcShop, closeTypeBitSet.default, "PanelCloseFunc_DialogNPCShop()")
  registerCloseLuaEvent(Panel_Window_Camp, closeTypeBitSet.default, "PanelCloseFunc_Camp()")
  registerCloseLuaEvent(Panel_Window_CampRegister, closeTypeBitSet.default, "PanelCloseFunc_CampRegister()")
  registerCloseLuaEvent(Panel_Window_MonsterRanking, closeTypeBitSet.default, "PanelCloseFunc_MonsterRanking()")
  registerCloseLuaEvent(Panel_ChatOption, closeTypeBitSet.default, "PanelCloseFunc_ChatOption()")
  registerCloseLuaEvent(Panel_Window_ChatOption_All, closeTypeBitSet.default, "PanelCloseFunc_ChatOption_All()")
  registerCloseLuaEvent(Panel_Window_BuildingBuff, closeTypeBitSet.default, "PanelCloseFunc_BuildingBuff()")
  registerCloseLuaEvent(Panel_Window_BuildingBuff_All, closeTypeBitSet.default, "PanelCloseFunc_BuildingBuff_All()")
  registerCloseLuaEvent(Panel_Window_PersonalBattle, closeTypeBitSet.default, "PanelCloseFunc_PersonalBattle()")
  registerCloseLuaEvent(Panel_Memo_List, closeTypeBitSet.default, "PanelCloseFunc_Memo()")
  registerCloseLuaEvent(Panel_Window_Memo_Main_All, closeTypeBitSet.default, "PanelCloseFunc_Memo_Main_All()")
  registerCloseLuaEvent(Panel_CustomizingAlbum, closeTypeBitSet.default, "PanelCloseFunc_CustomizingAlbum()")
  registerCloseLuaEvent(Panel_IntroMovie, closeTypeBitSet.default, "PanelCloseFunc_IntroMovie()")
  registerCloseLuaEvent(Panel_DialogMovie, closeTypeBitSet.default, "PanelCloseFunc_DialogMovie()")
  registerCloseLuaEvent(Panel_Chatting_Input, closeTypeBitSet.default, "PanelCloseFunc_ChattingInput()")
  registerCloseLuaEvent(Panel_ButtonShortcuts, closeTypeBitSet.default, "PanelCloseFunc_ButtonShortcuts()")
  registerCloseLuaEvent(Panel_TranslationReport, closeTypeBitSet.default, "PanelCloseFunc_TranslationReport()")
  registerCloseLuaEvent(Panel_ProductNote, closeTypeBitSet.default, "PanelCloseFunc_ProductNote()")
  registerCloseLuaEvent(Panel_ProductNote_Search, closeTypeBitSet.default, "PaGlobalFunc_ProductNote_Search_Close()")
  registerCloseLuaEvent(Panel_KeyboardHelp, closeTypeBitSet.default, "PanelCloseFunc_KeyboardHelp()")
  registerCloseLuaEvent(Panel_WebControl, closeTypeBitSet.default, "PanelCloseFunc_WebControl()")
  registerCloseLuaEvent(Panel_WebCashPayment, closeTypeBitSet.default, "FGlobal_WebCashPayment_ForceClose()")
  registerCloseLuaEvent(Panel_Window_ChannelChat, closeTypeBitSet.default, "PanelCloseFunc_ChannelChat()")
  registerCloseLuaEvent(Panel_Widget_ChannelChat_Loading, closeTypeBitSet.default, "PanelCloseFunc_ChannelChatLoading()")
  registerCloseLuaEvent(Panel_Window_PearlBox_Purchase_All, closeTypeBitSet.default, "FGlobal_Window_PearlBox_Purchase_All_ForceClose()")
  if _ContentsGroup_NewUI_Dye_All then
    registerCloseLuaEvent(Panel_Window_Palette_All, closeTypeBitSet.default, "PaGlobal_Palette_All_Close()")
    registerCloseLuaEvent(Panel_Widget_CharacterController_All, closeTypeBitSet.attackedOnly, "PaGlobal_Dye_All_Close()")
    registerCloseLuaEvent(Panel_Window_ColorMix_All, closeTypeBitSet.default, "PaGlobal_ColorMix_All_Clsoe()")
  else
    if _ContentsGroup_NewUI_Dye_Palette_All then
      registerCloseLuaEvent(Panel_Window_Dye_Palette_All, closeTypeBitSet.default, "PaGlobal_Dye_Palette_All_Close()")
      registerCloseLuaEvent(Panel_DyePalette, closeTypeBitSet.default, "PanelCloseFunc_DyePalette()")
      registerCloseLuaEvent(Panel_ColorBalance, closeTypeBitSet.default, "Panel_ColorBalance_Close()")
    end
    registerCloseLuaEvent(Panel_DyeNew_CharacterController, closeTypeBitSet.attackedOnly, "FGlobal_Panel_DyeReNew_Hide()")
  end
  if true == _ContentsGroup_FarmingList then
    registerCloseLuaEvent(Panel_Widget_FarmingTimerReport_All, closeTypeBitSet.default, "PaGloabl_FarmingTimerReport_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Warehouse, closeTypeBitSet.default, "PanelCloseFunc_Warehouse()")
  registerCloseLuaEvent(Panel_Window_GuildWareHouseHistory, closeTypeBitSet.default, "PaGlobalFunc_GuildWareHouseHistory_Close()")
  registerCloseLuaEvent(Panel_Window_CargoSell, closeTypeBitSet.default, "PaGlobal_CargoSell_Close()")
  registerCloseLuaEvent(Panel_SetVoiceChat, closeTypeBitSet.default, "PanelCloseFunc_SetVoiceChat()")
  registerCloseLuaEvent(Panel_Window_VoiceChat, closeTypeBitSet.default, "PanelCloseFunc_VoiceChat()")
  registerCloseLuaEvent(Panel_WorkerChangeSkill, closeTypeBitSet.default, "PanelCloseFunc_WorkerChangeSkill()")
  registerCloseLuaEvent(Panel_FileExplorer, closeTypeBitSet.default, "PanelCloseFunc_FileExplorer()")
  registerCloseLuaEvent(Panel_WorkerManager, closeTypeBitSet.default, "PanelCloseFunc_WorkerManager()")
  registerCloseLuaEvent(Panel_WorkerRestoreAll, closeTypeBitSet.default, "PanelCloseFunc_WorkerRestoreAll()")
  registerCloseLuaEvent(Panel_Worker_Auction, closeTypeBitSet.default, "PanelCloseFunc_WorkerAuction()")
  registerCloseLuaEvent(Panel_WorkerResist_Auction, closeTypeBitSet.default, "PanelCloseFunc_WorkerResistAuction()")
  registerCloseLuaEvent(Panel_WorkerList_Auction, closeTypeBitSet.default, "PanelCloseFunc_WorkerListAuction()")
  registerCloseLuaEvent(Panel_Window_Exchange, closeTypeBitSet.default, "PanelCloseFunc_Exchange()")
  registerCloseLuaEvent(Panel_TransferLifeExperience, closeTypeBitSet.default, "PanelCloseFunc_TransferLifeExperience()")
  registerCloseLuaEvent(Panel_SetShortCut, closeTypeBitSet.default, "PanelCloseFunc_SetShortCut()")
  registerCloseLuaEvent(Panel_Window_Manufacture, closeTypeBitSet.default, "PanelCloseFunc_Manufacture()")
  registerCloseLuaEvent(Panel_Window_Alchemy, closeTypeBitSet.default, "PanelCloseFunc_Alchemy()")
  registerCloseLuaEvent(Panel_Window_Inventory, closeTypeBitSet.default, "PanelCloseFunc_Inventory()")
  registerCloseLuaEvent(Panel_Window_Exchange_Number, closeTypeBitSet.default, "PanelCloseFunc_ExchangeNumber()")
  registerCloseLuaEvent(Panel_Window_cOption, closeTypeBitSet.default, "PanelCloseFunc_Option()")
  registerCloseLuaEvent(Panel_Window_GameOption_All, closeTypeBitSet.default, "PanelCloseFunc_Option()")
  registerCloseLuaEvent(Panel_Window_GameModeSettingNotice_All, closeTypeBitSet.default, "PaGlobalFunc_GameModeSettingNotice_All_Close()")
  registerCloseLuaEvent(Panel_Window_CarveSeal_All, closeTypeBitSet.default, "PanelCloseFunc_CarveSeal_All()")
  registerCloseLuaEvent(Panel_CarveSeal, closeTypeBitSet.default, "PanelCloseFunc_CarveSeal()")
  registerCloseLuaEvent(Panel_ResetSeal, closeTypeBitSet.default, "HandleClicked_ResetSealCancelButton()")
  if true == _ContentsGroup_DeleteMaxEnchanterName then
    registerCloseLuaEvent(Panel_DeleteMaxEnchanterName, closeTypeBitSet.default, "PaGlobal_DeleteMaxEnchanterName_Close()")
  end
  registerCloseLuaEvent(Panel_GuildWebInfo, closeTypeBitSet.default, "PanelCloseFunc_GuildWebInfo()")
  registerCloseLuaEvent(Panel_GuildRank_Web, closeTypeBitSet.default, "PanelCloseFunc_GuildRankWeb()")
  registerCloseLuaEvent(Panel_Guild_Rank, closeTypeBitSet.default, "PanelCloseFunc_GuildRank()")
  registerCloseLuaEvent(Panel_ChangeWeapon, closeTypeBitSet.default, "PanelCloseFunc_ChangeWeapon()")
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    registerCloseLuaEvent(Panel_SkillReinforce_All, closeTypeBitSet.default, "PanelCloseFunc_SkillReinforce_All()")
  else
    registerCloseLuaEvent(Panel_SkillReinforce, closeTypeBitSet.default, "PanelCloseFunc_SkillReinforce()")
  end
  registerCloseLuaEvent(Panel_FriendList, closeTypeBitSet.default, "PanelCloseFunc_FriendList()")
  registerCloseLuaEvent(Panel_CheckedQuestInfo, closeTypeBitSet.default, "PanelCloseFunc_CheckedQuest()")
  registerCloseLuaEvent(Panel_Window_Quest_New, closeTypeBitSet.default, "PanelCloseFunc_Quest()")
  registerCloseLuaEvent(Panel_Window_QuestInfo, closeTypeBitSet.default, "PanelCloseFunc_QuestRenew()")
  registerCloseLuaEvent(Panel_AgreementGuild_Master, closeTypeBitSet.default, "PanelCloseFunc_AgreementGuildMaster()")
  registerCloseLuaEvent(Panel_AgreementGuild, closeTypeBitSet.default, "PanelCloseFunc_AgreementGuild()")
  registerCloseLuaEvent(Panel_Window_Guild_SimpleInvite, closeTypeBitSet.default, "PaGlobal_Guild_SimpleInvite_Close()")
  registerCloseLuaEvent(Panel_Guild_InviteList, closeTypeBitSet.default, "PaGlobal_Guild_InviteList_Close()")
  registerCloseLuaEvent(Panel_GuildDuel, closeTypeBitSet.default, "PanelCloseFunc_GuildDuel()")
  registerCloseLuaEvent(Panel_Window_GameTips, closeTypeBitSet.default, "PanelCloseFunc_GameTips()")
  registerCloseLuaEvent(Panel_Event_100Day, closeTypeBitSet.default, "PanelCloseFunc_Event100Day()")
  registerCloseLuaEvent(Panel_Worker_Tooltip, closeTypeBitSet.default, "PanelCloseFunc_WorkerTooltip()")
  registerCloseLuaEvent(Panel_ChangeItem, closeTypeBitSet.default, "PanelCloseFunc_ChangeItem()")
  registerCloseLuaEvent(Panel_MovieGuide, closeTypeBitSet.default, "PanelCloseFunc_MovieGuide()")
  registerCloseLuaEvent(Panel_Window_ItemMarket, closeTypeBitSet.default, "PanelCloseFunc_ItemMarket()")
  registerCloseLuaEvent(Panel_AlchemyFigureHead, closeTypeBitSet.default, "PanelCloseFunc_AlchemyFigureHead()")
  registerCloseLuaEvent(Panel_AlchemyFigureHead_All, closeTypeBitSet.default, "PaGlobal_AlchemyFigureHead_All_Close()")
  if _ContentsGroup_LightStoneBag == true then
    registerCloseLuaEvent(Panel_Window_LightStoneBag, closeTypeBitSet.default, "PaGlobalFunc_LightStoneBag_Close()")
  end
  if _ContentsGroup_CombineBag == true then
    registerCloseLuaEvent(Panel_Window_CombineBag, closeTypeBitSet.default, "PaGlobalFunc_CombineBag_Close()")
  end
  if _ContentsGroup_ExchangeCoinSystem == true then
    registerCloseLuaEvent(Panel_ExchangeCoin_All, closeTypeBitSet.default, "PaGlobalFunc_ExchangeCoin_All_Close()")
  end
  registerCloseLuaEvent(Panel_MovieTheater_320, closeTypeBitSet.default, "PanelCloseFunc_MovieTheater320()")
  registerCloseLuaEvent(Panel_CharacterTag, closeTypeBitSet.default, "PanelCloseFunc_CharacterTag()")
  registerCloseLuaEvent(Panel_FairyInfo, closeTypeBitSet.default, "PanelCloseFunc_FairyInfo()")
  registerCloseLuaEvent(Panel_Window_FairySetting, closeTypeBitSet.default, "PanelCloseFunc_FairySetting()")
  registerCloseLuaEvent(Panel_Window_FairyUpgrade, closeTypeBitSet.default, "PanelCloseFunc_FairyUpgrade()")
  registerCloseLuaEvent(Panel_Window_FaIryTierUpgrade, closeTypeBitSet.default, "PaGlobalFunc_fairySkill_Close()")
  registerCloseLuaEvent(Panel_Win_System, closeTypeBitSet.default, "PanelCloseFunc_MessageBox()")
  registerCloseLuaEvent(Panel_Win_Check, closeTypeBitSet.default, "PanelCloseFunc_MessageBoxCheck()")
  registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.default, "PanelCloseFunc_MessageBox()")
  registerCloseLuaEvent(Panel_LifeRanking, closeTypeBitSet.default, "PanelCloseFunc_LifeRanking()")
  registerCloseLuaEvent(Panel_LifeRanking_All, closeTypeBitSet.default, "PanelCloseFunc_LifeRanking()")
  registerCloseLuaEvent(Panel_ChannelSelect, closeTypeBitSet.default, "PanelCloseFunc_ChannelSelect()")
  registerCloseLuaEvent(Panel_Window_MentalGame, closeTypeBitSet.default, "PanelCloseFunc_MentalGameClose()")
  registerCloseLuaEvent(Panel_Dialog_SkillSpecialize, closeTypeBitSet.default, "PaGlobalFunc_Dialog_SkillSpecialize_OnPadB()")
  registerCloseLuaEvent(Panel_QuickMenuCustom, closeTypeBitSet.default, "PanelCloseFunc_QuickMenuCustom()")
  registerCloseLuaEvent(Panel_Console_Window_GuildAgreement, closeTypeBitSet.default, "PanelCloseFunc_GuildAgreementClose()")
  registerCloseLuaEvent(Panel_Console_Window_SignOption, closeTypeBitSet.default, "PanelCloseFunc_GuildSignOption()")
  registerCloseLuaEvent(Panel_Window_CharacterInfo_Renew, closeTypeBitSet.default, "PaGlobalFunc_Window_CharacterInfo_Close()")
  registerCloseLuaEvent(Panel_Window_Knowledge_Renew, closeTypeBitSet.default, "PaGlobalFunc_Window_Knowledge_GOBackStep()")
  registerCloseLuaEvent(Panel_Window_Menu_Renew, closeTypeBitSet.default, "PanelCloseFunc_MenuRenew()")
  registerCloseLuaEvent(Panel_Console_Window_GuildCreate, closeTypeBitSet.default, "PanelCloseFunc_GuildCreate()")
  registerCloseLuaEvent(Panel_Console_Dialog_GuildPopup, closeTypeBitSet.default, "PanelCloseFunc_GuildPopup_Close()")
  registerCloseLuaEvent(Panel_Knowledge_Main, closeTypeBitSet.default, "Panel_Knowledge_Hide()")
  registerCloseLuaEvent(Panel_IngameCashShop_GoodsTooltip, closeTypeBitSet.default, "FGlobal_CashShop_GoodsTooltipInfo_Close()")
  registerCloseLuaEvent(Panel_Widget_Chatting_Renew, closeTypeBitSet.default, "Input_ChattingInfo_OnPadBNotEditting()")
  registerCloseLuaEvent(Panel_Chatting_BlockList, closeTypeBitSet.default, "PaGlobal_Chatting_BlockList:prepareClose()")
  registerCloseLuaEvent(Panel_Chatting_FunctionList, closeTypeBitSet.default, "PaGlobal_Chatting_FunctionList:prepareClose()")
  registerCloseLuaEvent(Panel_Window_Chat_Report_All, closeTypeBitSet.default, "PaGlobal_Window_Chat_Report_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_NpcGift_Renew, closeTypeBitSet.default, "PanelCloseFunc_NpcGift_Close()")
  registerCloseLuaEvent(Panel_Customizing_BodyShape, closeTypeBitSet.default, "PanelCloseFunc_Customization_BodyShape_Close()")
  registerCloseLuaEvent(Panel_Customizing_BodyPose, closeTypeBitSet.default, "PanelCloseFunc_Customization_BodyPose_Close()")
  registerCloseLuaEvent(Panel_Customizing_CommonDecoration, closeTypeBitSet.default, "PanelCloseFunc_Customization_Deco_Close()")
  registerCloseLuaEvent(Panel_Customizing_FaceShape, closeTypeBitSet.default, "PanelCloseFunc_Customization_FaceShape_Close()")
  registerCloseLuaEvent(Panel_Customizing_HairShape, closeTypeBitSet.default, "PanelCloseFunc_Customization_HairShape_Close()")
  registerCloseLuaEvent(Panel_Customizing_InputName, closeTypeBitSet.default, "PanelCloseFunc_Customization_InputName_Close()")
  registerCloseLuaEvent(Panel_Customizing_Mesh, closeTypeBitSet.default, "PanelCloseFunc_Customization_Mesh_Close()")
  registerCloseLuaEvent(Panel_Customizing_ShowOutfit, closeTypeBitSet.default, "PanelCloseFunc_Customization_ShowOutfit_Close()")
  registerCloseLuaEvent(Panel_Customizing_ShowPose, closeTypeBitSet.default, "PanelCloseFunc_Customization_ShowPose_Close()")
  registerCloseLuaEvent(Panel_Customizing_Skin, closeTypeBitSet.default, "PanelCloseFunc_Customization_Skin_Close()")
  registerCloseLuaEvent(Panel_Customizing_Voice, closeTypeBitSet.default, "PanelCloseFunc_Customization_Voice_Close()")
  registerCloseLuaEvent(Panel_Window_Mail_Renew, closeTypeBitSet.default, "PanelCloseFunc_MailRenew_Close()")
  registerCloseLuaEvent(Panel_Window_PetRegister_All, closeTypeBitSet.default, "PaGlobal_PetRegister_All_Close()")
  registerCloseLuaEvent(Panel_Window_PetList_All, closeTypeBitSet.default, "PaGlobal_PetList_Close_All()")
  registerCloseLuaEvent(Panel_Window_PetInfo_All, closeTypeBitSet.default, "PaGlobal_PetInfo_Close_All()")
  registerCloseLuaEvent(Panel_Window_PetLookChange_All, closeTypeBitSet.default, "PaGlobal_PetLookChange_Close_All()")
  registerCloseLuaEvent(Panel_Window_PetFusion_All, closeTypeBitSet.default, "PaGlobal_PetFusion_Close_All()")
  registerCloseLuaEvent(Panel_Window_PetCommand_All, closeTypeBitSet.default, "PaGlobal_PetCommad_All_Close()")
  registerCloseLuaEvent(Panel_Window_PetRegister_Renew, closeTypeBitSet.default, "PaGlobalFunc_PetRegister_Cancle()")
  registerCloseLuaEvent(Panel_Window_PetList_Renew, closeTypeBitSet.default, "PanelCloseFunc_PetList_Close()")
  registerCloseLuaEvent(Panel_Window_PetFood_Renew, closeTypeBitSet.default, "FGlobal_PetFeedClose()")
  registerCloseLuaEvent(Panel_Window_PetCommand_Renew, closeTypeBitSet.default, "FGlobal_PetCommand_Close()")
  registerCloseLuaEvent(Panel_Window_PetExchange_Renew, closeTypeBitSet.attacked, "PanelCloseFunc_PetExchange_Close()")
  registerCloseLuaEvent(Panel_Window_PetInfo_Renew, closeTypeBitSet.default, "PaGlobalFunc_PetInfo_Close()")
  registerCloseLuaEvent(Panel_Window_PetLookChange_Renew, closeTypeBitSet.default, "PaGlobalFunc_PetLookChange_Close()")
  registerCloseLuaEvent(Panel_Window_PetExchange_Skill_Renew, closeTypeBitSet.default, "PaGlobalFunc_PetExchangeSkill_Close()")
  registerCloseLuaEvent(Panel_Window_PartyInvite, closeTypeBitSet.default, "PaGlobalFunc_PartyInvite_Exit()")
  registerCloseLuaEvent(Panel_Window_PartySetting, closeTypeBitSet.default, "PaGlobalFunc_PartySetting_Exit()")
  registerCloseLuaEvent(Panel_PartyList, closeTypeBitSet.default, "PanelCloseFunc_FindParty_Close()")
  registerCloseLuaEvent(Panel_Worldmap_NodeInfo, closeTypeBitSet.default, "PanelCloseFunc_WorldMap_NodeInfo_Close()")
  registerCloseLuaEvent(Panel_Worldmap_NodeManagement, closeTypeBitSet.default, "PanelCloseFunc_WorldMap_NodeManagement_Close()")
  registerCloseLuaEvent(Panel_WorldMap_StableList, closeTypeBitSet.default, "PaGlobal_WorldMap_StableList_Close()")
  registerCloseLuaEvent(Panel_Worldmap_NodeLevel, closeTypeBitSet.default, "PaGlobalFunc_WorldMap_Grand_NodeLevel_Close()")
  registerCloseLuaEvent(Panel_Window_VehicleInfo_All, closeTypeBitSet.default, "PanelCloseFunc_ServantInfo_Horse_Close()")
  registerCloseLuaEvent(Panel_Window_ServantInfo, closeTypeBitSet.default, "PanelCloseFunc_ServantInfo_Horse_Close()")
  registerCloseLuaEvent(Panel_CarriageInfo, closeTypeBitSet.default, "PanelCloseFunc_ServantInfo_Carriage_Close()")
  registerCloseLuaEvent(Panel_ShipInfo, closeTypeBitSet.default, "PanelCloseFunc_ServantInfo_Ship_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_Renew, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_Filter_Renew, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_Filter_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_ChangeSkill_Renew, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_ChangeSkill_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_Restore_Renew, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_Restore_Close()")
  registerCloseLuaEvent(Panel_Resurrection_ItemSelect, closeTypeBitSet.default, "PaGlobalFunc_ResurrerectionItem_Close()")
  registerCloseLuaEvent(Panel_ServerSelect_Renew, closeTypeBitSet.default, "PaGlobalFunc_ServerSelect_Close()")
  registerCloseLuaEvent(Panel_Window_MarketPlaceWallet, closeTypeBitSet.default, "PanelCloseFunc_MarketWallet_Close()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_SellConfirm, closeTypeBitSet.default, "PaGlobal_MarketPlaceSell_Cancel()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_BuyConfirm, closeTypeBitSet.default, "PaGlobal_MarketPlaceBuy_Cancel()")
  registerCloseLuaEvent(Panel_Window_OTPConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_OTPConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Window_Option_Main, closeTypeBitSet.default, "PanelCloseFunc_RenewOption_Close()")
  registerCloseLuaEvent(Panel_Interaction_HouseList, closeTypeBitSet.default, "PanelCloseFunc_Interaction_HouseList_Close()")
  registerCloseLuaEvent(Panel_PartyOption, closeTypeBitSet.default, "PaGlobalFunc_PartyOption_Close()")
  registerCloseLuaEvent(Panel_Alchemy, closeTypeBitSet.default, "PanelCloseFunc_Alchemy()")
  registerCloseLuaEvent(Panel_Widget_Knowledge, closeTypeBitSet.default, "PaGlobalFunc_AlchemyKnowledgeClose()")
  registerCloseLuaEvent(Panel_AskKnowledge, closeTypeBitSet.default, "PaCloseFunc_AskKnowlege_Close()")
  registerCloseLuaEvent(Panel_Window_Extraction_Caphras, closeTypeBitSet.default, "PaGlobal_ExtractionCaphras_Close()")
  registerCloseLuaEvent(Panel_Window_Extraction_Caphras_All, closeTypeBitSet.default, "PaGlobal_Extraction_Caphras_All_Close()")
  registerCloseLuaEvent(Panel_Window_ExtractionSystem, closeTypeBitSet.default, "PaGlobal_ExtractionSystem_ForceClose()")
  registerCloseLuaEvent(Panel_Window_Extraction_System_All, closeTypeBitSet.default, "PaGlobal_Extraction_System_All_Close()")
  registerCloseLuaEvent(Panel_Window_DailyStamp_Renew, closeTypeBitSet.default, "PaGlobalFunc_DailyStamp_Close()")
  registerCloseLuaEvent(Panel_Window_ConsoleUIOffset, closeTypeBitSet.default, "PaGlobal_ConsoleUIOffset_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_ReceivePay, closeTypeBitSet.default, "PaGlobalFunc_GuildReceivePay_Close()")
  registerCloseLuaEvent(Panel_Window_BeginnerRoadmap, closeTypeBitSet.default, "PaGlobalFunc_SeasonPassAndRoadMap_Close()")
  if ToClient_isConsole() == true then
    registerCloseLuaEvent(Panel_Window_StableList, closeTypeBitSet.default, "PaGlobalFunc_StableList_Close()")
    registerCloseLuaEvent(Panel_Window_StableInfo, closeTypeBitSet.default, "PaGlobalFunc_StableInfo_Close()")
    registerCloseLuaEvent(Panel_Window_StableMating, closeTypeBitSet.default, "PaGlobalFunc_StableMating_Close()")
    registerCloseLuaEvent(Panel_Window_StableRegister, closeTypeBitSet.default, "PaGlobalFunc_StableRegister_Close()")
    registerCloseLuaEvent(Panel_Window_WharfList, closeTypeBitSet.default, "PaGlobalFunc_WharfList_Close()")
    registerCloseLuaEvent(Panel_Window_WharfInfo, closeTypeBitSet.default, "PaGlobalFunc_WharfInfo_Close()")
    registerCloseLuaEvent(Panel_Window_WharfRegister, closeTypeBitSet.default, "PaGlobalFunc_WharfRegister_Close()")
    registerCloseLuaEvent(Panel_Window_WharfFunction, closeTypeBitSet.attacked, "PaGlobalFunc_WharfFunction_Close()")
  else
    registerCloseLuaEvent(Panel_Window_StableList, closeTypeBitSet.default, "StableList_Close()")
    registerCloseLuaEvent(Panel_Window_StableInfo, closeTypeBitSet.default, "StableInfo_Close()")
    registerCloseLuaEvent(Panel_Window_StableEquipInfo, closeTypeBitSet.default, "StableEquipInfo_Close()")
    registerCloseLuaEvent(Panel_Window_StableShop, closeTypeBitSet.default, "StableShop_WindowClose()")
    registerCloseLuaEvent(Panel_Window_StableMating, closeTypeBitSet.default, "StableMating_Close()")
    registerCloseLuaEvent(Panel_Window_StableRegister, closeTypeBitSet.default, "StableRegister_Close()")
    registerCloseLuaEvent(Panel_Window_StableStallion, closeTypeBitSet.default, "PaGlobaFunc_StableStallion_Close()")
    registerCloseLuaEvent(Panel_Window_WharfList, closeTypeBitSet.default, "WharfList_Close()")
    registerCloseLuaEvent(Panel_Window_WharfInfo, closeTypeBitSet.default, "WharfInfo_Close()")
    registerCloseLuaEvent(Panel_Window_WharfRegister, closeTypeBitSet.default, "WharfRegister_Close()")
    registerCloseLuaEvent(Panel_Window_WharfFunction, closeTypeBitSet.attacked, "WharfFunction_Close()")
  end
  if ToClient_isConsole() == true then
    registerCloseLuaEvent(Panel_Dialogue_Itemtake, closeTypeBitSet.default, "PaGlobalFunc_Dialog_ItemTake_Close()")
    registerCloseLuaEvent(Panel_NewKnowledge, closeTypeBitSet.default, "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()")
  else
    registerCloseLuaEvent(Panel_Dialogue_Itemtake, closeTypeBitSet.default, "click_noDialogButton()")
    registerCloseLuaEvent(Panel_NewKnowledge, closeTypeBitSet.default, "Panel_ImportantKnowledge_HideAni()")
  end
  registerCloseLuaEvent(Panel_Dialogue_Itemtake_All, closeTypeBitSet.default, "HandleEventLUp_Dialogue_Itemtake_All_ClickNo()")
  registerCloseLuaEvent(Panel_RecentCook, closeTypeBitSet.default, "PaGlobal_RecentCook:closePanel()")
  registerCloseLuaEvent(Panel_Window_Delivery_All, closeTypeBitSet.default, "PaGlobal_Delivery_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_Delivery_CarriageInformation, closeTypeBitSet.default, "DeliveryCarriageInformationWindow_Close()")
  registerCloseLuaEvent(Panel_Servant_Market_Input, closeTypeBitSet.default, "StableMarketInput_Close()")
  registerCloseLuaEvent(Panel_Window_MailDetail_All, closeTypeBitSet.default, "PaGlobal_Window_MailDetail_All_Close()")
  registerCloseLuaEvent(Panel_CreateClan, closeTypeBitSet.default, "CreateClan_Close()")
  registerCloseLuaEvent(Panel_CreateGuild, closeTypeBitSet.default, "CreateClan_Close()")
  registerCloseLuaEvent(Panel_CreateClan_All, closeTypeBitSet.default, "PaGlobal_CreateClan_All_Close()")
  registerCloseLuaEvent(Panel_Scroll, closeTypeBitSet.default, "UIScrollButton.Close()")
  registerCloseLuaEvent(Panel_SkillAwaken, closeTypeBitSet.default, "SkillAwaken_Close()")
  registerCloseLuaEvent(Panel_Popup_MoveItem, closeTypeBitSet.default, "PopupMoveItem_Close()")
  registerCloseLuaEvent(Panel_LordMenu, closeTypeBitSet.default, "LordMenu_Hide()")
  registerCloseLuaEvent(Panel_EnableSkill, closeTypeBitSet.default, "PanelCloseFunc_Skill()")
  registerCloseLuaEvent(Panel_HelpMessage, closeTypeBitSet.default, "HelpMessageQuestion_Out()")
  registerCloseLuaEvent(Panel_Window_Quest_History, closeTypeBitSet.default, "FGlobal_QuestHistoryClose()")
  registerCloseLuaEvent(Panel_Housing_FarmInfo_New, closeTypeBitSet.default, "PAHousing_FarmInfo_Close()")
  registerCloseLuaEvent(Panel_Housing_FarmInfo_All, closeTypeBitSet.default, "PaGlobal_FarmInfo_All_Close()")
  registerCloseLuaEvent(Panel_ClanList, closeTypeBitSet.default, "_ClanList_Close()")
  registerCloseLuaEvent(Panel_ClearVested, closeTypeBitSet.default, "FromClient_HideWindow()")
  registerCloseLuaEvent(Panel_Window_SkillGuide, closeTypeBitSet.default, "Panel_Window_SkillGuide_Close()")
  registerCloseLuaEvent(Panel_MovieTheater_640, closeTypeBitSet.default, "Panel_MovieTheater640_WindowClose()")
  registerCloseLuaEvent(Panel_MovieTheater_SkillGuide_640, closeTypeBitSet.default, "Panel_MovieTheater_SkillGuide_640_JustClose()")
  registerCloseLuaEvent(Panel_NewKnowledge, closeTypeBitSet.default, "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()")
  registerCloseLuaEvent(Panel_QuestInfo, closeTypeBitSet.default, "PanelCloseFunc_QuestInfo_Close()")
  registerCloseLuaEvent(Panel_FishEncyclopedia, closeTypeBitSet.default, "FGlobal_FishEncyclopedia_Close()")
  registerCloseLuaEvent(Panel_Tooltip_Item_chattingLinkedItem, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()")
  registerCloseLuaEvent(Panel_HousingList, closeTypeBitSet.default, "HousingList_Close()")
  registerCloseLuaEvent(Panel_Interaction_FriendHouseList, closeTypeBitSet.default, "FriendHouseRank_Close()")
  registerCloseLuaEvent(Panel_GuildWarScore, closeTypeBitSet.default, "Panel_GuildWarScore_Close()")
  registerCloseLuaEvent(Panel_KnowledgeManagement, closeTypeBitSet.default, "KnowledgeClose()")
  registerCloseLuaEvent(Panel_Window_StableMix, closeTypeBitSet.default, "StableMix_Close()")
  registerCloseLuaEvent(Panel_Window_PetCompose, closeTypeBitSet.default, "Panel_Window_PetCompose_Close()")
  registerCloseLuaEvent(Panel_Window_MaidList, closeTypeBitSet.default, "MaidList_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerRandomSelect, closeTypeBitSet.default, "workerRandomSelectHide()")
  registerCloseLuaEvent(Panel_Window_UnknownRandomSelect, closeTypeBitSet.default, "randomSelectHide()")
  registerCloseLuaEvent(Panel_NodeWarMenu, closeTypeBitSet.default, "FGlobal_NodeWarMenuClose()")
  registerCloseLuaEvent(Panel_RallyRanking, closeTypeBitSet.default, "FGlobal_RallyRanking_Close()")
  registerCloseLuaEvent(Panel_Manufacture, closeTypeBitSet.default, "Manufacture_Close()")
  registerCloseLuaEvent(Panel_EnchantExtraction, closeTypeBitSet.default, "Panel_EnchantExtraction_Close()")
  registerCloseLuaEvent(Panel_Join, closeTypeBitSet.default, "Panel_Join_Close()")
  registerCloseLuaEvent(Panel_Window_PetMarket, closeTypeBitSet.default, "PetMarket_Close()")
  registerCloseLuaEvent(Panel_Window_PetMarketRegist, closeTypeBitSet.default, "PetMarketRegist_Close()")
  registerCloseLuaEvent(Panel_Window_GuildStable_List, closeTypeBitSet.default, "GuildStableList_Close()")
  registerCloseLuaEvent(Panel_Window_GuildStable_Info, closeTypeBitSet.default, "GuildStableInfo_Close()")
  registerCloseLuaEvent(Panel_Window_GuildStableRegister, closeTypeBitSet.default, "GuildStableRegister_Close()")
  registerCloseLuaEvent(Panel_GuildStableList_All, closeTypeBitSet.default, "PaGlobal_GuildStableList_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildPresent, closeTypeBitSet.default, "PaGlobal_GuildPresent_All_Close()")
  registerCloseLuaEvent(Panel_ExitConfirm, closeTypeBitSet.default, "HandleEventLUp_ExitConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Window_TrayConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_ExitTrayConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Party_ItemList, closeTypeBitSet.default, "Panel_Party_ItemList_Close()")
  registerCloseLuaEvent(Panel_Harvest_WorkManager, closeTypeBitSet.default, "FGlobal_Harvest_WorkManager_Close()")
  registerCloseLuaEvent(Panel_Chatting_Color, closeTypeBitSet.default, "ChattingColor_Hide()")
  registerCloseLuaEvent(Panel_Window_Chatting_Color_All, closeTypeBitSet.default, "PaGlobalFunc_ChattingColor_All_Close()")
  registerCloseLuaEvent(Panel_WorkerShipInfo, closeTypeBitSet.default, "WorkerShipInfo_Close()")
  if false == _ContentsGroup_NewUI_ItemWarp_All then
    registerCloseLuaEvent(Panel_ItemWarp, closeTypeBitSet.default, "Panel_ItemWarp_Close()")
  else
    registerCloseLuaEvent(Panel_ItemWarp_All, closeTypeBitSet.default, "Panel_ItemWarp_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Scope_All, closeTypeBitSet.default, "PaGlobal_Telescope_All_Close()")
  registerCloseLuaEvent(Panel_Tooltip_Item_chattingLinkedItemClick, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()")
  registerCloseLuaEvent(Panel_GoldenTreasureBox, closeTypeBitSet.default, "Panel_GoldenTreasureBox_Close()")
  registerCloseLuaEvent(Panel_GuildHouse_Auction, closeTypeBitSet.default, "FGlobal_GuildHouseAuctionWindow_Hide()")
  registerCloseLuaEvent(Panel_GuildHouse_Auction_All, closeTypeBitSet.default, "PaGlobal_GuildHouse_Auction_All_Close()")
  registerCloseLuaEvent(Panel_Guild_Create_All, closeTypeBitSet.default, "PaGlobal_CreateClan_All_Close()")
  registerCloseLuaEvent(Panel_GuildReceivePay_All, closeTypeBitSet.default, "PaGlobal_GuildReceivePay_All_Close()")
  if _ContentsGroup_GuildAuthoritySeparation == true then
    registerCloseLuaEvent(Panel_Guild_Authorization_All, closeTypeBitSet.default, "PaGlobal_Guild_Authorization_All_Close()")
  end
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    registerCloseLuaEvent(Panel_Window_ReinforceSkill_All, closeTypeBitSet.default, "PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()")
  else
    registerCloseLuaEvent(Panel_Window_ReinforceSkill, closeTypeBitSet.default, "Panel_Window_ReinforceSkill_Close()")
  end
  registerCloseLuaEvent(Panel_Guild_Incentive_Foundation, closeTypeBitSet.default, "Panel_Guild_Incentive_Foundation_Close()")
  registerCloseLuaEvent(Panel_CompetitionGame_JoinDesc, closeTypeBitSet.default, "PaGlobalFunc_CompetitionGame_JoinDesc_Close()")
  registerCloseLuaEvent(Panel_CompetitionGame_GuildReservation, closeTypeBitSet.default, "PanelCloseFunc_CompetitionGame()")
  registerCloseLuaEvent(Panel_IngameCashShop_Coupon, closeTypeBitSet.default, "IngameCashShopCoupon_Close( true )")
  registerCloseLuaEvent(Panel_PearlShop_Coupon, closeTypeBitSet.default, "PaGlobal_PearlShopCoupon_Close()")
  registerCloseLuaEvent(Panel_GuildServant_RevivalList, closeTypeBitSet.default, "PaGlobal_GuildServant_RevivalList:close()")
  registerCloseLuaEvent(Panel_Copyright, closeTypeBitSet.default, "PaGlobal_Copyright_Close()")
  registerCloseLuaEvent(Panel_Window_Copyright, closeTypeBitSet.default, "PaGlobal_Copyright:close()")
  registerCloseLuaEvent(Panel_Window_PrivacyPolicy, closeTypeBitSet.default, "PaGlobal_PrivacyPolicy_close()")
  registerCloseLuaEvent(Panel_Window_DropItem, closeTypeBitSet.default, "PaGlobal_WorldDropItem:Close()")
  registerCloseLuaEvent(Panel_Window_DropItem_All, closeTypeBitSet.default, "PaGlobalFunc_RenewDropItem_Close()")
  registerCloseLuaEvent(Panel_SkillCoolTimeSlot, closeTypeBitSet.default, "PaGlobal_Window_Skill_CoolTimeSlot:closeFunc()")
  registerCloseLuaEvent(Panel_SkillGroup_CoolTimeSlot, closeTypeBitSet.default, "PaGlobal_SkillGroup_CoolTimeSlot:close()")
  registerCloseLuaEvent(Panel_Window_SkillFilter_All, closeTypeBitSet.default, "PaGlobal_SkillFilter_Close()")
  registerCloseLuaEvent(Panel_PetRestoreAll, closeTypeBitSet.default, "PanelCloseFunc_PetRestoreAll_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_EventCart, closeTypeBitSet.default, "IngameCashShopEventCart_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_BuyHistory, closeTypeBitSet.default, "PaGlobal_CashShopBuyHistory_Close()")
  registerCloseLuaEvent(Panel_Window_RecommandGoods_PopUp, closeTypeBitSet.default, "PaGlobal_Recommend_PopUp:Close()")
  registerCloseLuaEvent(Panel_Npc_Quest_Reward, closeTypeBitSet.default, "PanelCloseFunc_QuestReward_Close()")
  registerCloseLuaEvent(Panel_Equipment, closeTypeBitSet.default, "PanelCloseFunc_Equip_Close()")
  registerCloseLuaEvent(Panel_Window_Mail_All, closeTypeBitSet.default, "PaGlobal_Window_Mail_All_Close()")
  registerCloseLuaEvent(Panel_Window_Option, closeTypeBitSet.default, "PanelCloseFunc_WindowOption()")
  registerCloseLuaEvent(Panel_Window_Socket, closeTypeBitSet.default, "Socket_WindowClose()")
  registerCloseLuaEvent(Panel_SkillAwaken, closeTypeBitSet.default, "SkillAwaken_Close()")
  registerCloseLuaEvent(Panel_Improvement, closeTypeBitSet.default, "Panel_Improvement_Hide()")
  registerCloseLuaEvent(Panel_ItemMarket_AlarmList, closeTypeBitSet.default, "HandleClicked_ItemMarketAlarmList_Close()")
  registerCloseLuaEvent(Panel_GuildWarInfo, closeTypeBitSet.default, "Panel_GuildWarInfo_Hide()")
  registerCloseLuaEvent(Panel_TradeInfo_Renew, closeTypeBitSet.default, "PaGlobal_TradeInformation:Close()")
  registerCloseLuaEvent(Panel_TradeEventNotice_Renewal, closeTypeBitSet.default, "PaGlobal_TradeEventNotice_Renewal:Close()")
  registerCloseLuaEvent(Panel_Window_TradeEventNotice_Renewal_All, closeTypeBitSet.default, "PaGlobalFunc_TradeEventNotice_Renewal_All_Close()")
  registerCloseLuaEvent(Panel_TradeMarket_EventInfo, closeTypeBitSet.default, "TradeEventInfo_Close()")
  registerCloseLuaEvent(Panel_LevelupGuide, closeTypeBitSet.default, "HandleClicked_LevelupGuide_Close()")
  registerCloseLuaEvent(Panel_NpcNavi, closeTypeBitSet.default, "FGlobal_NpcNavi_Hide()")
  registerCloseLuaEvent(Panel_Tooltip_NpcNavigation, closeTypeBitSet.default, "FGlobal_NpcNavi_Hide()")
  registerCloseLuaEvent(Panel_NpcNavi_All, closeTypeBitSet.default, "FGlobal_NpcNavi_Hide()")
  registerCloseLuaEvent(Panel_Tooltip_NpcNavigation_All, closeTypeBitSet.default, "FGlobal_NpcNavi_Hide()")
  registerCloseLuaEvent(Panel_Window_Policy, closeTypeBitSet.default, "PaGlobal_Policy_Close()")
  registerCloseLuaEvent(Panel_Window_MailDetail_Renew, closeTypeBitSet.default, "PaGlobal_MailDetail_Close()")
  registerCloseLuaEvent(Panel_Window_BlackDesertLab, closeTypeBitSet.default, "PaGlobal_BlackDesertLab_Close()")
  registerCloseLuaEvent(Panel_BossAlert_SettingV2, closeTypeBitSet.default, "PaGlobal_BossAlertSet_Hide()")
  registerCloseLuaEvent(Panel_BossAlert_SettingV2_All, closeTypeBitSet.default, "PaGlobal_BossAlert_SettingV2_All_Close()")
  registerCloseLuaEvent(Panel_Window_LinkServantInfo, closeTypeBitSet.default, "PaGlobalFunc_LinkHorseInfo_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_MemberFunction, closeTypeBitSet.default, "PaGlobalFunc_GuildMemberFunction_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_MemberInfo, closeTypeBitSet.default, "PaGlobalFunc_GuildMemberInfo_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_QuestInfo, closeTypeBitSet.default, "PaGlobalFunc_GuildQuestInfo_Close()")
  registerCloseLuaEvent(Panel_Window_GuildMark, closeTypeBitSet.default, "InputMLUp_GuildMark_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_WarDeclare, closeTypeBitSet.default, "PaGlobalFunc_WarDeclare_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_SkillInfo, closeTypeBitSet.default, "PaGlobalFunc_GuildSkillInfo_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_Introduction, closeTypeBitSet.default, "PaGlobalFunc_GuildIntro_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_Introduction_Renew, closeTypeBitSet.default, "PaGlobalFunc_GuildIntroduction_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_VoiceSet, closeTypeBitSet.default, "PaGlobalFunc_GuildVoiceSet_Close()")
  registerCloseLuaEvent(Panel_Window_GuildWarInfo, closeTypeBitSet.default, "PanelCloseFunc_GuildWarInfo_Close()")
  registerCloseLuaEvent(Panel_House_InstallationMode_PlantInfo, closeTypeBitSet.default, "PaGlobalFunc_InstallationMode_PlantInfo_Close()")
  registerCloseLuaEvent(Panel_Window_Clan_Renew, closeTypeBitSet.default, "PaGlobalFunc_ClanRenew_Close()")
  registerCloseLuaEvent(Panel_Introduction, closeTypeBitSet.default, "FGlobal_Introcution_TooltipHide()")
  registerCloseLuaEvent(Panel_LocalWarRule, closeTypeBitSet.default, "PaGlobalFunc_LocalWarRule_Close()")
  registerCloseLuaEvent(Panel_Window_GuildWarInfo_Renew, closeTypeBitSet.default, "PaGlobalFunc_GuildWarInfo_Close()")
  registerCloseLuaEvent(Panel_Window_GuildWarInfoDetail_Renew, closeTypeBitSet.default, "PaGlobalFunc_GuildWarInfoDetail_Close()")
  registerCloseLuaEvent(Panel_Window_GuildWarfareDesc_Renew, closeTypeBitSet.default, "PaGlobal_GuildWarfareDesc_Close()")
  registerCloseLuaEvent(Panel_Window_Enchant_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_Enchant_Close()")
  registerCloseLuaEvent(Panel_Window_Socket_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_Socket_Close()")
  registerCloseLuaEvent(Panel_Window_Improvement_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_Improvement_Close()")
  registerCloseLuaEvent(Panel_Window_MonsterRanking, closeTypeBitSet.default, "FGlobal_MonsterRanking_Close()")
  registerCloseLuaEvent(Panel_KeyboardHelp, closeTypeBitSet.default, "PaGlobalFunc_KeyboardHelpClose()")
  registerCloseLuaEvent(Panel_ChannelSelect, closeTypeBitSet.default, "FGlobal_ChannelSelect_Hide()")
  registerCloseLuaEvent(Panel_Window_Skill, closeTypeBitSet.default, "PanelCloseFunc_Skill()")
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    registerCloseLuaEvent(Panel_Window_SkillGroup_SelectType, closeTypeBitSet.default, "PanelCloseFunc_SkillSelectType()")
    if _ContentsGroup_ShowOtherClassSkill == true then
      registerCloseLuaEvent(Panel_Window_SkillGroup_All, closeTypeBitSet.default, "PaGlobalFunc_SkillGroup_All_Close()")
    else
      registerCloseLuaEvent(Panel_Window_SkillGroup, closeTypeBitSet.default, "PanelCloseFunc_Skill()")
    end
  end
  registerCloseLuaEvent(Panel_Window_Inventory_Cannon, closeTypeBitSet.default, "PaGlobalFunc_CannonInven_Close()")
  registerCloseLuaEvent(Panel_Window_StableFunction, closeTypeBitSet.attacked, "PanelCloseFunc_StableFunction_Close()")
  registerCloseLuaEvent(Panel_Repair_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_RepairInfo_Close()")
  registerCloseLuaEvent(Panel_FixMaxEndurance_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_CloseFixMaxEnduranceInfo()")
  registerCloseLuaEvent(Panel_FixEquip, closeTypeBitSet.attacked, "PaGlobalFunc_FixEquip_Close()")
  registerCloseLuaEvent(Panel_Window_Endurance_Recovery_All, closeTypeBitSet.attacked, "PaGlobal_Endurance_Recovery_All_Close()")
  registerCloseLuaEvent(Panel_Window_ItemMarket_RegistItem, closeTypeBitSet.default, "PanelCloseFunc_ItemMarketRegistItem()")
  registerCloseLuaEvent(Panel_Window_ItemMarket_BuyConfirm, closeTypeBitSet.default, "FGlobal_ItemMarket_BuyConfirm_Close()")
  registerCloseLuaEvent(Panel_Window_ItemMarket_ItemSet, closeTypeBitSet.default, "FGlobal_ItemMarketItemSet_Close()")
  registerCloseLuaEvent(Panel_Window_Repair, closeTypeBitSet.attackedOnly, "PaGlobalFunc_FixEquip_Close()")
  registerCloseLuaEvent(Panel_Window_ItemMarket_Function, closeTypeBitSet.attackedOnly, "FGolbal_ItemMarket_Function_Close()")
  registerCloseLuaEvent(Panel_CustomizationMain, closeTypeBitSet.attackedOnly, "IngameCustomize_Hide()")
  registerCloseLuaEvent(Panel_Window_LordMenu_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_LordMenu_Close()")
  registerCloseLuaEvent(Panel_PcRoomNotify, closeTypeBitSet.attacked, "PcRoomNotify_Close()")
  registerCloseLuaEvent(Panel_Window_GuildWharfFunction, closeTypeBitSet.attacked, "GuildWharfFunction_Close()")
  registerCloseLuaEvent(Panel_Npc_Trade_Market, closeTypeBitSet.attacked, "closeNpcTrade_Basket()")
  if true == _ContentsGroup_UsePadSnapping then
    registerCloseLuaEvent(Panel_Win_System, closeTypeBitSet.attacked, "PanelCloseFunc_MessageBox()")
  else
    registerCloseLuaEvent(Panel_Win_System, closeTypeBitSet.attacked, "MessageBox_Empty_function()")
    registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.attacked, "MessageBox_Empty_function()")
  end
  registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.attacked, "PanelCloseFunc_MessageBox()")
  registerCloseLuaEvent(Panel_Window_GardenList, closeTypeBitSet.attacked, "PaGlobal_GardenList:close()")
  registerCloseLuaEvent(Panel_Window_GardenInformation, closeTypeBitSet.attacked, "PaGlobal_GardenInformation:close()")
  registerCloseLuaEvent(Panel_Window_GardenWorkerManagement, closeTypeBitSet.attacked, "PaGlobal_GardenWorkerManagement:prepareClose()")
  registerCloseLuaEvent(Panel_Window_ResidenceList, closeTypeBitSet.attacked, "PaGlobal_ResidenceList:close()")
  registerCloseLuaEvent(Panel_ChatOption, closeTypeBitSet.attacked, "ChattingOption_Close()")
  registerCloseLuaEvent(Panel_Window_ChatOption_All, closeTypeBitSet.attacked, "PaGlobalFunc_ChatOption_All_Close()")
  registerCloseLuaEvent(Panel_RecommandName, closeTypeBitSet.attacked, "FGlobal_SendMailForHelpClose()")
  registerCloseLuaEvent(Panel_SetShortCut, closeTypeBitSet.attacked, "FGlobal_NewShortCut_Close()")
  registerCloseLuaEvent(Panel_Window_Quest_New_Option, closeTypeBitSet.attacked, "FGlobal_CheckedQuestOptionClose()")
  registerCloseLuaEvent(Panel_QuickMenuCustom, closeTypeBitSet.attacked, "PaGlobalFunc_Panel_QuickMenuCustomClose()")
  registerCloseLuaEvent(Panel_Window_VoiceChat, closeTypeBitSet.attacked, "PaGlobalFunc_VoiceChat_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_GuildMain_Close()")
  registerCloseLuaEvent(Panel_Window_GameExit_All, closeTypeBitSet.attacked, "PaGlobal_GameExit_CloseAll()")
  registerCloseLuaEvent(Panel_Window_GameExit_CharMove, closeTypeBitSet.attacked, "PaGlobalFunc_GameExitCharMove_SetShow(false, false)")
  registerCloseLuaEvent(Panel_Window_GameExit, closeTypeBitSet.attacked, "PaGlobalFunc_GameExit_SetShow(false, false)")
  registerCloseLuaEvent(Panel_ServerSelect_Renew, closeTypeBitSet.attacked, "PaGlobalFunc_ServerSelect_Close()")
  registerCloseLuaEvent(Panel_AgreementGuild, closeTypeBitSet.attacked, "FGlobal_AgreementGuild_Close()")
  registerCloseLuaEvent(Panel_Window_GuildStableFunction, closeTypeBitSet.attacked, "GuildStableFunction_Close()")
  registerCloseLuaEvent(Panel_GuildAlliance_Invitation, closeTypeBitSet.attacked, "FGlobal_InvitationGuildAlliance_Close()")
  if true == _ContentsGroup_InstanceLocalWar then
    registerCloseLuaEvent(Panel_LocalWarInfo_All, closeTypeBitSet.default, "PaGlobal_LocalWarInfo_All_New_Close()")
  else
    registerCloseLuaEvent(Panel_LocalWarInfo_All, closeTypeBitSet.default, "PaGlobal_LocalWarInfo_All_Close()")
  end
  registerCloseLuaEvent(Panel_GuildList_SetAttendanceWar, closeTypeBitSet.default, "HandleClicked_SetAttendanceWar_Cancel()")
  registerCloseLuaEvent(Panel_Window_DetectUser, closeTypeBitSet.default, "PaGlobalFunc_DetectUser_Close()")
  registerCloseLuaEvent(Panel_Stable_PromoteMarket, closeTypeBitSet.default, "PaGlobalFunc_ServantRentPromoteMarketClose()")
  registerCloseLuaEvent(Panel_Chat_Emoticon, closeTypeBitSet.default, "PaGlobalFunc_ChatEmoticon_Close()")
  registerCloseLuaEvent(Panel_Window_ChattingHistory_Renew, closeTypeBitSet.default, "PaGlobalFunc_ChattingHistory_Close()")
  registerCloseLuaEvent(Panel_DetectUserButton, closeTypeBitSet.default, "PaGlobalFunc_DetectUserButton_Close()")
  registerCloseLuaEvent(Panel_Window_GuildFunding_Renew, closeTypeBitSet.default, "PaGlobalFunc_GuildFunding_Close()")
  registerCloseLuaEvent(Panel_Chatting_Filter, closeTypeBitSet.default, "FGlobal_ChattingFilterList_Close()")
  registerCloseLuaEvent(Panel_Window_ItemMarketAlarmList_New, closeTypeBitSet.default, "PaGlobalFunc_ItemMArketAlarmListClose()")
  registerCloseLuaEvent(Panel_Chat_SocialMenu, closeTypeBitSet.default, "FGlobal_SocialAction_ShowToggle()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_Main, closeTypeBitSet.default, "PaGlobalFunc_MarketPlace_CloseAllCheck(true)")
  registerCloseLuaEvent(Panel_Window_MarketPlace_Function, closeTypeBitSet.default, "PaGlobalFunc_MarketPlace_Function_Close()")
  registerCloseLuaEvent(Panel_Window_Barter, closeTypeBitSet.default, "PaGlobal_Barter_Close()")
  registerCloseLuaEvent(Panel_Window_Barter_Refresh, closeTypeBitSet.default, "PaGlobal_BarterInfoSearch_Refresh_Close()")
  registerCloseLuaEvent(Panel_Window_Barter_Search_Special, closeTypeBitSet.default, "PaGlobal_BarterInfoSearch_Special_Close()")
  registerCloseLuaEvent(Panel_Window_Barter_Search, closeTypeBitSet.default, "HandlePadBOrEscEvent_BarterInfoSearch_Close()")
  registerCloseLuaEvent(Panel_Widget_BlackSpirit_SkillSelect, closeTypeBitSet.attacked, "PaGloabl_BlackSpiritSkillSelect_Close()")
  if true == _ContentsGroup_UsePadSnapping then
    registerCloseLuaEvent(Panel_Widget_Anchorage, closeTypeBitSet.default, "PaGlobal_Anchor:prepareClose()")
  end
  registerCloseLuaEvent(Panel_Worldmap_WaypointPreset, closeTypeBitSet.default, "PaGlobal_Worldmap_Grand_WaypointPreset_Close()")
  registerCloseLuaEvent(Panel_Worldmap_WaypointOption, closeTypeBitSet.default, "PaGlobal_Worldmap_Grand_WaypointOption_Close()")
  if true == _ContentsGroup_WorldMapNodeNavigation then
    registerCloseLuaEvent(Panel_Worldmap_NodeCal, closeTypeBitSet.default, "PaGlobal_Worldmap_Grand_NodeNavigation_Close()")
  end
  registerCloseLuaEvent(Panel_FriendList_All, closeTypeBitSet.default, "PanelCloseFunc_FriendList()")
  registerCloseLuaEvent(Panel_FriendList_Add, closeTypeBitSet.default, "PaGlobal_FriendListAdd_Close()")
  registerCloseLuaEvent(Panel_FriendInfoList_All, closeTypeBitSet.default, "PanelCloseFunc_FriendInfoList()")
  registerCloseLuaEvent(Panel_Window_MaidList_Renew, closeTypeBitSet.default, "PaGlobalFunc_MaidList_OnPadB()")
  registerCloseLuaEvent(Panel_Window_ChangeName_Renew, closeTypeBitSet.default, "ChangeNickname_Close()")
  registerCloseLuaEvent(Panel_ExchangeNickname, closeTypeBitSet.default, "FGlobal_Exchange_Close()")
  registerCloseLuaEvent(Panel_RecommandName_Renew, closeTypeBitSet.default, "FGlobal_SendMailForHelpClose()")
  registerCloseLuaEvent(Panel_Window_Skill_BlackSpiritLock, closeTypeBitSet.default, "FGlobal_BlackSpiritSkillLock_Close()")
  registerCloseLuaEvent(Panel_MovieStroyIndun, closeTypeBitSet.default, "PaGlobalFunc_StroyInstanceDungeon_Exit()")
  registerCloseLuaEvent(Panel_Window_KnowledgeManage_Renew, closeTypeBitSet.default, "PaGlobalFunc_KnowledgeManage_Close()")
  registerCloseLuaEvent(Panel_GuildQuest_Reward, closeTypeBitSet.default, "PaGlobalFunc_GuildQuest_Reward_ShowToggle()")
  registerCloseLuaEvent(Panel_Window_KeyGuide, closeTypeBitSet.attacked, "PaGlobalFunc_KeyGuidWindow_Close()")
  registerCloseLuaEvent(Panel_Dialog_RandomWorker, closeTypeBitSet.default, "FGlobalFunc_Close_RandomWorker()")
  registerCloseLuaEvent(Panel_Window_ChangeItem_Renew, closeTypeBitSet.default, "PaGlobalFunc_ChangeItem_Close()")
  if _ContentsGroup_UsingPMAPI == true then
    registerCloseLuaEvent(Panel_Window_AccountLinking_Web, closeTypeBitSet.default, "PaGlobalFunc_AccountLinking_Web_Close()")
  else
    registerCloseLuaEvent(Panel_Window_AccountLinking_Renew, closeTypeBitSet.default, "PaGlobalFunc_AccountLinking_Close()")
  end
  registerCloseLuaEvent(Panel_Window_UIEggTest, closeTypeBitSet.default, "PaGlobal_UIEggTest_Close()")
  registerCloseLuaEvent(Panel_Guild_DailyPay, closeTypeBitSet.default, "FGlobal_GetDailyPay_Hide()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_MyInventory, closeTypeBitSet.default, "PaGlobalFunc_MarketWallet_Close()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_WalletInventory, closeTypeBitSet.default, "PaGlobalFunc_MarketWallet_Close()")
  registerCloseLuaEvent(Panel_Dialge_RewardSelect, closeTypeBitSet.attackedOnly, "PaGlobalFunc_Reward_Select_Exit()")
  registerCloseLuaEvent(Panel_Window_Banner, closeTypeBitSet.cantclose, "PaGlobal_Banner_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_BuyOrGift, closeTypeBitSet.attacked, "InGameShopBuy_Close()")
  registerCloseLuaEvent(Panel_Window_Achievement, closeTypeBitSet.default, "PaGlobalFunc_Achievement_Close()")
  registerCloseLuaEvent(Panel_Window_Achievement_MorningLand, closeTypeBitSet.default, "PaGlobalFunc_Achievement_MorningLand_Close()")
  registerCloseLuaEvent(Panel_Window_Achievement_BookShelf, closeTypeBitSet.default, "PaGlobal_Achievement_BookShelf_Close()")
  registerCloseLuaEvent(Panel_Window_Achievement_BookShelf_All, closeTypeBitSet.default, "PaGlobalFunc_Achievement_BookShelf_All_Close()")
  registerCloseLuaEvent(Panel_Manufacture_GrindMortar, closeTypeBitSet.default, "FGlobal_Manufacture_GrindMortar_Close()")
  registerCloseLuaEvent(Panel_AgreementVolunteer_Master, closeTypeBitSet.default, "FGlobal_AgreementVolunteer_Master_Close()")
  registerCloseLuaEvent(Panel_AgreementVolunteer, closeTypeBitSet.default, "FGlobal_AgreementVolunteer_Close()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_SelectList, closeTypeBitSet.default, "PaGlobal_MarketPlaceSelectList_Cancel()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_SellManagement, closeTypeBitSet.default, "PaGlobal_MarketPlaceSell_Cancel()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_BuyManagement, closeTypeBitSet.default, "PaGlobal_MarketPlaceBuy_Cancel()")
  registerCloseLuaEvent(Panel_Window_OTPConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_OTPConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Window_PersonalMonster, closeTypeBitSet.default, "PaGlobal_PersonalMonster_Close()")
  registerCloseLuaEvent(Panel_Window_GuildRegistSoldier, closeTypeBitSet.default, "PaGlobalFunc_GuildRegistSoldier_Close()")
  registerCloseLuaEvent(Panel_Window_ExpirienceWiki, closeTypeBitSet.default, "PaGlobal_ExpirienceWiki_Close()")
  registerCloseLuaEvent(Panel_Window_ExpirienceWiki_All, closeTypeBitSet.default, "PaGlobal_ExpirienceWiki_All_Close_FromESC()")
  registerCloseLuaEvent(Panel_Widget_ContentUnlock, closeTypeBitSet.default, "PaGlobalFunc_ContentUnlock_Close()")
  registerCloseLuaEvent(Panel_Window_VolunteerRankWeb, closeTypeBitSet.default, "PaGlobal_VolunteerRankWeb_Close()")
  registerCloseLuaEvent(Panel_AltarRank_Web, closeTypeBitSet.default, "PaGlobal_AltarRankWeb_Close()")
  registerCloseLuaEvent(Panel_Window_TotalReward, closeTypeBitSet.default, "PaGlobal_TotalReward_Close()")
  registerCloseLuaEvent(Panel_Widget_Menu_Remake, closeTypeBitSet.default, "PaGlobal_Menu_Remake_Close()")
  registerCloseLuaEvent(Panel_Menu, closeTypeBitSet.default, "Panel_Menu_Close()")
  registerCloseLuaEvent(Panel_Guild_Incentive_SetFund, closeTypeBitSet.default, "PaGlobal_GuildIncentive:prepareClose()")
  registerCloseLuaEvent(Panel_Guild_Incentive_MemberList, closeTypeBitSet.default, "PaGlobal_GuildIncentive:prepareClose()")
  registerCloseLuaEvent(Panel_Guild_Incentive_Tier, closeTypeBitSet.default, "PaGlobal_GuildIncentiveTier_Close()")
  registerCloseLuaEvent(Panel_EnchantExtraction_Renew, closeTypeBitSet.default, "Panel_EnchantExtraction_Renew_Close()")
  registerCloseLuaEvent(Panel_Purification_Renew, closeTypeBitSet.default, "PaGlobal_Purification_Close()")
  registerCloseLuaEvent(Panel_WebControl_Renew, closeTypeBitSet.default, "PaGlobalFunc_WebControl_Close()")
  registerCloseLuaEvent(Panel_UnknownShop, closeTypeBitSet.default, "PaGlobal_UnknownShop:prepareClose()")
  registerCloseLuaEvent(Panel_Window_MarketPlace_TutorialSelect, closeTypeBitSet.default, "PaGlobal_MarketPlaceTutorialSelect:prepareClose()")
  registerCloseLuaEvent(Panel_Dialog_NPCShop_All, closeTypeBitSet.default, "HandleEventLUp_NPCShop_ALL_Close()")
  registerCloseLuaEvent(Panel_Window_MaidList_All, closeTypeBitSet.default, "PaGlobalFunc_MaidList_All_Close()")
  registerCloseLuaEvent(Panel_PartyList_All, closeTypeBitSet.default, "PaGlobalFunc_PartyList_All_Close()")
  registerCloseLuaEvent(Panel_PartyRecruite_All, closeTypeBitSet.default, "PaGlobalFunc_PartyRecruite_All_Close()")
  registerCloseLuaEvent(Panel_GuildPartyList_All, closeTypeBitSet.default, "PaGlobalFunc_GuildPartyList_All_Close()")
  registerCloseLuaEvent(Panel_Window_DailyStamp_All, closeTypeBitSet.default, "PaGlobalFunc_DailyStamp_All_Close()")
  registerCloseLuaEvent(Panel_Daily_Reward_Notice_All, closeTypeBitSet.default, "PaGlobalFunc_Daily_Reward_Notice_All_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_All_Close()")
  registerCloseLuaEvent(Panel_Purification_All, closeTypeBitSet.default, "HandleEventLUp_Purification_All_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerAuction_All, closeTypeBitSet.default, "HandleEventLUp_WorkerAuction_All_Close()")
  registerCloseLuaEvent(Panel_Window_Report, closeTypeBitSet.default, "PaGloabl_Report_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerRandomSelect_All, closeTypeBitSet.default, "HandleEventLUp_WorkerRandomSelect_All_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerRandomSelectOption_All, closeTypeBitSet.default, "HandleEventLUp_WorkerRandomSelectOption_All_CloseForConsole()")
  registerCloseLuaEvent(Panel_Window_RandomShop_All, closeTypeBitSet.default, "PaGlobalFunc_RandomShop_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_Trade_PriceRate_All, closeTypeBitSet.attacked, "HandleEventLUp_TradePriceRate_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_Trade_Function_All, closeTypeBitSet.attacked, "HandleEventLUp_TradeFunction_All_Close()")
  registerCloseLuaEvent(Panel_Worldmap_Trade_MarketItemList_All, closeTypeBitSet.attacked, "PaGlobalFunc_WorldMapItemList_All_Close()")
  registerCloseLuaEvent(Panel_Window_LordMenu_All, closeTypeBitSet.attacked, "HandleEventLUp_LordMenu_All_Close()")
  registerCloseLuaEvent(Panel_Window_Improvement_All, closeTypeBitSet.default, "PaGlobalFunc_Improvement_All_Close()")
  registerCloseLuaEvent(Panel_Window_Sailor_Onboard_All, closeTypeBitSet.attacked, "PaGlobal_SailorManager_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_SailorManager_All, closeTypeBitSet.attacked, "PaGlobal_SailorManager_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_SailorRestore_All, closeTypeBitSet.attacked, "PaGlobal_SailorManager_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_SailorPresetManager_All, closeTypeBitSet.attacked, "PaGlobalFunc_SailorPresetManager_All_Close()")
  registerCloseLuaEvent(Panel_Window_SailorPresetGroup_All, closeTypeBitSet.attacked, "PaGlobalFunc_SailorPresetGroup_All_Close()")
  registerCloseLuaEvent(Panel_Window_SailorPreset_NameEdit_All, closeTypeBitSet.attacked, "PaGlobalFunc_SailorPreset_NameEdit_All_Close()")
  registerCloseLuaEvent(Panel_Widget_Sailor_AutoFishingDiscard, closeTypeBitSet.attacked, "PaGloabl_SailorAutoFishingDiscard_All_Close()")
  registerCloseLuaEvent(Panel_Window_ShipInfo_All, closeTypeBitSet.attacked, "PaGlobal_ShipInfo_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_ShipInfo_Renewal_All, closeTypeBitSet.attacked, "PaGlobal_ShipInfo_Renewal_All:prepareClose()")
  registerCloseLuaEvent(Panel_Dialog_NpcGift_All, closeTypeBitSet.default, "PaGlobalFunc_DialogNpcGift_All_Close()")
  registerCloseLuaEvent(Panel_Window_Socket_All, closeTypeBitSet.default, "PaGlobalFunc_Socket_All_Close()")
  registerCloseLuaEvent(Panel_Window_Camp_All, closeTypeBitSet.default, "PaGlobalFunc_Camp_All_Close()")
  registerCloseLuaEvent(Panel_Window_CampWarehouse_All, closeTypeBitSet.default, "PaGlobalFunc_CampWarehouse_All_Close()")
  registerCloseLuaEvent(Panel_Window_ShipEquipManagement_ALL, closeTypeBitSet.default, "HandleEventMLUp_ShipEquipManagement_Close()")
  registerCloseLuaEvent(Panel_Window_CargoLoading_ALL, closeTypeBitSet.default, "HandleEventMLUp_CargoLoading_Close()")
  registerCloseLuaEvent(Panel_Window_ItemFilter_All, closeTypeBitSet.default, "HandleEventMLUp_ItemFilter_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantExtension_All_Tree, closeTypeBitSet.default, "PaGlobal_ServantUpgrade_Tree_Close()")
  registerCloseLuaEvent(Panel_Window_ServantUpgrade, closeTypeBitSet.default, "PanelCloseFunc_ServantUpgrade()")
  registerCloseLuaEvent(Panel_Dialog_ServantSwiftTraining_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantSwiftTraining_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantFunction_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantFunction_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantTransferList_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantTransferList_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantExchange_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantExchange_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantExchange_Fantasy_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantExchange_Fantasy_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_Servant_FantasySelect_All, closeTypeBitSet.attacked, "PaGlobalFunc_Servant_FantasySelect_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantMarket_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantMarket_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantNameRegist_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantNameRegist_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantMarket_Rental_Mating_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantMarket_Rental_Mating_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantCarriageLink_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantCarriageLink_All_Close()")
  registerCloseLuaEvent(Panel_Dialog_ServantSkillManagement_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantSkillManagement_All_Close()")
  registerCloseLuaEvent(Panel_Window_SimpleStableList_All, closeTypeBitSet.attacked, "PaGlobalFunc_ServantTransferBackwardList_All_Close()")
  if _ContentsGroup_HorseSimulator == true then
    registerCloseLuaEvent(Panel_Dialog_ServantSimulator, closeTypeBitSet.attacked, "PaGlobalFunc_ServantSimulator_Close()")
    registerCloseLuaEvent(Panel_Dialog_ServantSimulatorSubView, closeTypeBitSet.attacked, "PaGlobalFunc_ServantSimulatorSubView_Close()")
  end
  registerCloseLuaEvent(Panel_Window_StackExtraction_All, closeTypeBitSet.default, "PaGlobalFunc_SpiritEnchant_All_Close()")
  if true == _ContentsGroup_EnchantRemaster then
    registerCloseLuaEvent(Panel_Widget_Enchant_Main_All, closeTypeBitSet.attacked, "PaGlobalFunc_EnchantMain_All_Close()")
    registerCloseLuaEvent(Panel_Window_Enchant_Equip_All, closeTypeBitSet.default, "PaGlobalFunc_EnchantEquip_All_Close()")
    registerCloseLuaEvent(Panel_Window_Enchant_Material_All, closeTypeBitSet.default, "PaGlobalFunc_EnchantMaterial_All_Close()")
    registerCloseLuaEvent(Panel_Window_EnchantProtector_All, closeTypeBitSet.default, "PaGlobalFunc_EnchantProtector_All_Close()")
    registerCloseLuaEvent(Panel_Window_EnchantStack_All, closeTypeBitSet.default, "PaGlobalFunc_EnchantStack_All_Close()")
    registerCloseLuaEvent(Panel_Window_Enchant_StackExtraction_All, closeTypeBitSet.default, "PaGlobalFunc_StackExtraction_All_Close()")
    registerCloseLuaEvent(Panel_Window_EnchantMessage_All, closeTypeBitSet.default, "PaGlobalFunc_EnchantMessage_All_Close()")
    registerCloseLuaEvent(Panel_Window_ValksList_All, closeTypeBitSet.default, "PaGlobalFunc_ValksList_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Report_All, closeTypeBitSet.default, "PaGloabl_ReportAll_Close()")
  registerCloseLuaEvent(Panel_Dialog_Repair_Function_All, closeTypeBitSet.attackedOnly, "PaGlobalFunc_FixEquip_Close()")
  if _ContentsGroup_FishingEncyclopedia == true then
    registerCloseLuaEvent(Panel_Window_FishEncyclopedia_Renewal_All, closeTypeBitSet.default, "PaGlobalFunc_FishEncyclopedia_Renewal_All_Close()")
    registerCloseLuaEvent(Panel_Window_EncyclopediaNotice, closeTypeBitSet.default, "PaGlobal_EncyclopediaNotice_Close()")
  else
    registerCloseLuaEvent(Panel_Window_FishEncyclopedia_All, closeTypeBitSet.default, "PaGlobalFunc_FishEncyclopedia_All_Close()")
  end
  if _ContentsGroup_FishCompetition == true then
    registerCloseLuaEvent(Panel_Window_FishCompetition, closeTypeBitSet.default, "PaGlobal_FishCompetition_Close()")
  end
  registerCloseLuaEvent(Panel_Window_FishCompetitionMyReward, closeTypeBitSet.default, "PaGlobal_FishCompetitionMyReward_Close()")
  registerCloseLuaEvent(Panel_Window_FishCompetitionRewardInfo, closeTypeBitSet.default, "PaGlobal_FishCompetitionRewardInfo_Close()")
  registerCloseLuaEvent(Panel_Change_Nickname_All, closeTypeBitSet.default, "HandleEventLUp_ChangeNickNameAll_Close()")
  registerCloseLuaEvent(Panel_TransferLifeExperience_All, closeTypeBitSet.default, "HandleEventLUp_TransferLifeExp_All_Close()")
  registerCloseLuaEvent(Panel_Window_TotalReward_All, closeTypeBitSet.default, "PaGlobal_TotalReward_All_Close()")
  registerCloseLuaEvent(Panel_Window_BeginnerEnchantGuide_All, closeTypeBitSet.default, "PaGlobalFunc_BeginnerEnchantGuide_Close()")
  registerCloseLuaEvent(Panel_Window_FairyRegister_All, closeTypeBitSet.default, "PaGlobal_FairyRegister_Close_All()")
  registerCloseLuaEvent(Panel_Window_FairySkill_All, closeTypeBitSet.default, "PaGlobalFunc_FairySkill_Close_All()")
  registerCloseLuaEvent(Panel_FairyInfo_All, closeTypeBitSet.default, "PaGlobal_FairyInfo_Close_All()")
  registerCloseLuaEvent(Panel_Window_FairySetting_All, closeTypeBitSet.default, "PaGlobal_FairySetting_Close_All()")
  registerCloseLuaEvent(Panel_Window_FairyGrowth_All, closeTypeBitSet.default, "PaGlobal_FairyGrowth_All:prepareClose()")
  registerCloseLuaEvent(Panel_Window_FairyTierUpgrade_All, closeTypeBitSet.default, "PaGlobal_FairyTierUpgrade_Close_All()")
  registerCloseLuaEvent(Panel_Window_FairyChoiceTheReset_All, closeTypeBitSet.default, "PaGlobal_FairyChoiceTheReset_Close_All()")
  registerCloseLuaEvent(Panel_Window_FairyChangeSkill_All, closeTypeBitSet.default, "PaGlobal_FairyChangeSkill_Close_All(false)")
  registerCloseLuaEvent(Panel_FairySkillChange_Viewhelp, closeTypeBitSet.default, "PaGlobal_FairyChangeSkill_Viewhelper_Close_All()")
  registerCloseLuaEvent(Panel_Window_ChangeItem_All, closeTypeBitSet.default, "PaGlobalFunc_ChangeItem_All_Close()")
  registerCloseLuaEvent(Panel_PersonalMonster_All, closeTypeBitSet.default, "HandleEventLUp_PersonalMonster_All_Close()")
  registerCloseLuaEvent(Panel_Window_SetVoiceChat_All, closeTypeBitSet.default, "PaGlobalFunc_SetVoiceChat_All_Close()")
  registerCloseLuaEvent(Panel_Window_ButtonShortcuts_All, closeTypeBitSet.default, "PaGlobalFunc_ButtonShorcuts_All_Close()")
  registerCloseLuaEvent(Panel_Window_BlackSpiritSkillLock_All, closeTypeBitSet.default, "PaGlobalFunc_BlackSpiritSkillLock_All_Close()")
  registerCloseLuaEvent(Panel_Window_Restore_All, closeTypeBitSet.default, "PaGloabl_Restore_All_Close()")
  registerCloseLuaEvent(Panel_Window_BloodAltar_Retry_All, closeTypeBitSet.default, "PaGlobalFunc_BloodAlterMinor_RetryClose()")
  registerCloseLuaEvent(Panel_Window_BloodAltar_All, closeTypeBitSet.default, "PaGlobalFunc_BloodAlterMinor_Close()")
  registerCloseLuaEvent(Panel_CharacterInfo_All, closeTypeBitSet.default, "PaGlobalFunc_ChracterInfo_All_Close()")
  registerCloseLuaEvent(Panel_VoiceChat_Setting_New, closeTypeBitSet.default, "PaGlobal_VoiceChat_Setting_New_Close()")
  registerCloseLuaEvent(Panel_VoiceChat_List_New, closeTypeBitSet.default, "PaGlobal_VoiceChat_List_New_Close()")
  registerCloseLuaEvent(Panel_Window_ClothInventory_All, closeTypeBitSet.default, "PaGlobalFunc_ClothInventory_All_Close()")
  registerCloseLuaEvent(Panel_Window_ClothInventory_Renew_All, closeTypeBitSet.default, "PaGlobalFunc_ClothInventory_Renew_All_Close()")
  registerCloseLuaEvent(Panel_Window_FairySkinChange_All, closeTypeBitSet.default, "PaGlobal_FairySkinChange_Close_All()")
  if _ContentsGroup_AlchemyStoneRenewal == true then
    registerCloseLuaEvent(Panel_Window_AlchemyStone_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStone_Renewal_All_Close()")
    registerCloseLuaEvent(Panel_Window_AlchemyStoneEvolve_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStoneEvolve_All_Close()")
  else
    registerCloseLuaEvent(Panel_Window_AlchemyStone_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStone_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Composition_All, closeTypeBitSet.default, "PaGlobal_Composition_All_Close()")
  registerCloseLuaEvent(Panel_Window_Inventory_Detail, closeTypeBitSet.default, "PaGlobal_InventoryEquip_Detail_Renew_Close()")
  registerCloseLuaEvent(Panel_Window_Achievement_BookShelf_All, closeTypeBitSet.default, "PaGlobalFunc_Achievement_BookShelf_All_Close()")
  registerCloseLuaEvent(Panel_Arsha_ApplyWeb_All, closeTypeBitSet.default, "PaGlobal_ArshaApplyWeb_All_Close()")
  registerCloseLuaEvent(Panel_Window_MusicBoard_All, closeTypeBitSet.default, "PaGlobal_MusicBoard_All_Close()")
  registerCloseLuaEvent(Panel_Window_MusicSetting_All, closeTypeBitSet.default, "PaGlobal_MusicSetting_All_Close()")
  registerCloseLuaEvent(Panel_RandomBoxSelect_All, closeTypeBitSet.attacked, "PaGlobalFunc_RandomRoulette_Close()")
  registerCloseLuaEvent(Panel_Window_NumberPad_All, closeTypeBitSet.default, "PanelCloseFunc_ExchangeNumber()")
  registerCloseLuaEvent(Panel_GoldenTreasureBox_All, closeTypeBitSet.default, "PaGlobalFunc_GoldenBox_All_Close()")
  registerCloseLuaEvent(Panel_Window_Manufacture_All, closeTypeBitSet.default, "PanelCloseFunc_Manufacture()")
  registerCloseLuaEvent(Panel_Window_Alchemy_All, closeTypeBitSet.default, "PanelCloseFunc_Alchemy()")
  registerCloseLuaEvent(Panel_Window_WorkerManager_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManager_All_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManagerChangeSkill_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManagerChangeSkill_All_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManagerRestore_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManagerRestore_All_Close()")
  registerCloseLuaEvent(Panel_Widget_WorkerManagerTooltip_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManagerTooltip_All_Close()")
  registerCloseLuaEvent(Panel_Window_MusicAlbum_All, closeTypeBitSet.default, "PaGlobal_MusicAlbum_All_Close()")
  registerCloseLuaEvent(Panel_Window_MusicShare_All, closeTypeBitSet.default, "PaGlobal_MusicShare_All_Close()")
  registerCloseLuaEvent(Panel_Window_LinkedSkill_All, closeTypeBitSet.default, "PaGlobal_LinkedSkill_All_Close()")
  registerCloseLuaEvent(Panel_Window_LetterScroll_All, closeTypeBitSet.default, "PaGlobal_LetterScroll_All_Close()")
  registerCloseLuaEvent(Panel_Window_Picture, closeTypeBitSet.default, "PaGlobal_Picture_Close()")
  registerCloseLuaEvent(Panel_Window_ColorPalette_All, closeTypeBitSet.default, "PaGlobal_ColorPalette_All_Close()")
  registerCloseLuaEvent(Panel_Window_Invitation_All, closeTypeBitSet.default, "PaGlobal_Invitation_All_Close()")
  registerCloseLuaEvent(Panel_Window_Quest_All, closeTypeBitSet.default, "PaGlobalFunc_Quest_All_Close()")
  registerCloseLuaEvent(Panel_Window_QuestInfo_All, closeTypeBitSet.default, "PaGlobalFunc_QuestInfo_All_Close()")
  registerCloseLuaEvent(Panel_Window_QuestTypeSet_All, closeTypeBitSet.default, "PaGlobalFunc_QuestTypeSet_All_Close()")
  registerCloseLuaEvent(Panel_Popup_Hadum_Warning_Quest, closeTypeBitSet.default, "PaGlobal_HadumWarning_Quest_Close()")
  registerCloseLuaEvent(Panel_Widget_RandomQuestInfo_All, closeTypeBitSet.default, "PaGlobalFunc_RandomQuestInfo_All_Close()")
  registerCloseLuaEvent(Panel_GuildMain_All, closeTypeBitSet.default, "PaGlobalFunc_GuildMain_All_Close()")
  registerCloseLuaEvent(Panel_GuildDeclareWar_All, closeTypeBitSet.default, "PaGlobalFunc_GuildDeclareWar_Close()")
  registerCloseLuaEvent(Panel_GuildIntroduce_All, closeTypeBitSet.default, "PaGlobalFunc_GuildIntroduce_Close()")
  registerCloseLuaEvent(Panel_Guild_NoneGuild, closeTypeBitSet.default, "PaGlobal_Guild_NoneGuild:checkApplyListClose()")
  registerCloseLuaEvent(Panel_Guild_IntroduceMySelf, closeTypeBitSet.default, "PaGlobal_GuildIntroduceMySelf_Close()")
  registerCloseLuaEvent(Panel_Guild_NoneJoinMember, closeTypeBitSet.default, "PaGlobal_Guild_NoneJoinMember:Close()")
  registerCloseLuaEvent(Panel_GuildQuestInfo_All, closeTypeBitSet.default, "PaGlobal_GuildQuestInfo_Close_All()")
  registerCloseLuaEvent(Panel_Guild_ManufactureSelect_All, closeTypeBitSet.default, "PaGlobalFunc_Guild_ManufactureSelect_All_Close()")
  registerCloseLuaEvent(Panel_GuildIncentive_All, closeTypeBitSet.default, "PaGlobalFunc_GuildIncentive_All_Close()")
  registerCloseLuaEvent(Panel_GuildIncentiveOption_All, closeTypeBitSet.default, "PaGlobalFunc_GuildIncentiveOption_All_Close()")
  registerCloseLuaEvent(Panel_GuildDeposit_All, closeTypeBitSet.default, "PaGlobal_GuildDeposit_All_Close()")
  if _ContentsGroup_RenewUI == false then
    registerCloseLuaEvent(Panel_Window_CouponCode, closeTypeBitSet.default, "PaGlobalFunc_CouponCode_Close()")
  else
    registerCloseLuaEvent(Panel_Window_CouponCode, closeTypeBitSet.default, "PaGlobalFunc_CouponCode_CloseWebModal()")
  end
  registerCloseLuaEvent(Panel_ChannelSelect_All, closeTypeBitSet.default, "PaGlobalFunc_ChannelSelect_All_Close()")
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    registerCloseLuaEvent(Panel_Window_Season_Equiptment_Upgrade_All, closeTypeBitSet.default, "PaGlobal_SeasonEquipment_Upgrade_Close()")
  end
  if _ContentsGroup_AccessoryStepUp == true then
    registerCloseLuaEvent(Panel_Window_Accessory_StepUp_All, closeTypeBitSet.default, "PaGlobal_Window_Accessory_StepUp_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Equipment_All, closeTypeBitSet.default, "PanelCloseFunc_Equip_Close()")
  registerCloseLuaEvent(Panel_Window_Inventory_All, closeTypeBitSet.default, "PanelCloseFunc_Inventory()")
  registerCloseLuaEvent(Panel_Window_TrashBoxConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_TrashBoxConfirm_All_Close()")
  registerCloseLuaEvent(Panel_GuildWarInfo_All, closeTypeBitSet.default, "PaGlobalFunc_GuildWarInfo_All_Close()")
  registerCloseLuaEvent(Panel_GuildWarInfoSmall_All, closeTypeBitSet.default, "PaGlobalFunc_GuildWarInfoSmall_All_Close()")
  registerCloseLuaEvent(Panel_GuildWarScore_All, closeTypeBitSet.default, "PaGlobalFunc_GuildWarScore_All_Close()")
  registerCloseLuaEvent(Panel_GuildRegistSoldier_All, closeTypeBitSet.default, "HandleEventLUp_Guild_RegistSolider_All_Close()")
  registerCloseLuaEvent(Panel_GuildWebInfo_All, closeTypeBitSet.default, "PaGlobalFunc_GuildWebInfo_All_Close()")
  registerCloseLuaEvent(Panel_GuildUseFund_All, closeTypeBitSet.default, "PaGlobalFunc_GuildUseFund_All_Close()")
  registerCloseLuaEvent(Panel_SelectGuildMansion_All, closeTypeBitSet.default, "PaGlobalFunc_SelectGuildMansion_All_Close()")
  registerCloseLuaEvent(Panel_GuildIntro_All, closeTypeBitSet.default, "PaGlobalFunc_GuildIntro_All_Close()")
  registerCloseLuaEvent(Panel_GuildVoiceSet_All, closeTypeBitSet.default, "PaGlobalFunc_GuildVoiceSet_All_Close()")
  registerCloseLuaEvent(Panel_Guild_MemberInfo_All, closeTypeBitSet.default, "PaGlobalFunc_GuildMemberInfo_All_Close()")
  registerCloseLuaEvent(Panel_GuildAgreement_Console_All, closeTypeBitSet.default, "PaGlobal_GuildAgreement_Console_All_Close()")
  registerCloseLuaEvent(Panel_GuildAgreementOption_All, closeTypeBitSet.default, "PaGlobalFunc_GuildAgreement_Option_All_Close()")
  registerCloseLuaEvent(Panel_GuildAttributeReport_All, closeTypeBitSet.default, "PaGlobal_GuildAttributeReport_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildActivityFunds_List_All, closeTypeBitSet.default, "PaGlobal_GuildActivityFunds_List_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildActivityFunds_Option_All, closeTypeBitSet.default, "PaGlobal_GuildActivityFunds_Option_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildDocumentManagement_All, closeTypeBitSet.default, "PaGlobal_GuildDocumentManagement_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildIncentiveSetting_All, closeTypeBitSet.default, "PaGlobal_GuildIncentiveSetting_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildMemberPointDetail_All, closeTypeBitSet.default, "PaGlobal_GuildMemberPointDetail_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildPointOption_All, closeTypeBitSet.default, "PaGlobal_GuildPointOption_All_Close()")
  registerCloseLuaEvent(Panel_Window_GuildPointMenu_All, closeTypeBitSet.default, "PaGlobal_GuildPointMenu_All_Close()")
  registerCloseLuaEvent(Panel_Window_ClanList_All, closeTypeBitSet.default, "PaGlobal_ClanList_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_Find_All, closeTypeBitSet.default, "HandleEventLUp_Minigame_Find_All_AskGameClose()")
  if true == _ContentsGroup_GrowthPass then
    registerCloseLuaEvent(Panel_Window_GrowthPass, closeTypeBitSet.default, "PaGlobalFunc_GrowthPass_Close()")
    registerCloseLuaEvent(Panel_Window_GrowthPass_Info, closeTypeBitSet.default, "PaGlobalFunc_GrowPath_Info_Close()")
    registerCloseLuaEvent(Panel_Window_GrowthPass_PointShop, closeTypeBitSet.default, "PaGlobalFunc_GrowPath_PointShop_Close()")
  end
  registerCloseLuaEvent(Panel_Widget_Ship_Control, closeTypeBitSet.default, "PaGlobalFunc_Ship_Control_All_Close()")
  registerCloseLuaEvent(Panel_Widget_Tooltip_Item_LinkedItem_All, closeTypeBitSet.default, "PaGlobalFunc_Tooltip_Item_LinkedItem_All_Close()")
  registerCloseLuaEvent(Panel_Widget_Tooltip_Item_LinkedClickItem_All, closeTypeBitSet.default, "PaGlobalFunc_Tooltip_Item_LinkedClickItem_All_Close()")
  registerCloseLuaEvent(Panel_Widget_Tooltip_Skill_Servant_All, closeTypeBitSet.default, "PaGlobal_Tooltip_Skill_Servant_All_Close()")
  registerCloseLuaEvent(Panel_Widget_Tooltip_Actor_All, closeTypeBitSet.default, "PaGlobal_Tooltip_Actor_All_Close()")
  registerCloseLuaEvent(Panel_Window_Arsha_FuncList_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_FuncList_All_Close()")
  registerCloseLuaEvent(Panel_Window_Arsha_Reservation_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_Reservation_All_Close()")
  registerCloseLuaEvent(Panel_Window_Arsha_Func_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_Func_All_Close()")
  registerCloseLuaEvent(Panel_Window_ArshaPvPSubMenu_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()")
  registerCloseLuaEvent(Panel_Window_Arsha_InviteList_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_InviteList_All_Close()")
  registerCloseLuaEvent(Panel_Window_Arsha_TeamNameChange_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_TeamNameChange_All_Close()")
  registerCloseLuaEvent(Panel_Window_Arsha_TeamChangeControl_All, closeTypeBitSet.default, "PaGlobalFunc_Arsha_TeamChange_All_Close()")
  registerCloseLuaEvent(Panel_Window_ShipControl, closeTypeBitSet.default, "PaGlobal_ShipControl_Console_Close()")
  registerCloseLuaEvent(Panel_Window_SkillPreset, closeTypeBitSet.default, "PaGlobal_SkillPreset_Close()")
  registerCloseLuaEvent(Panel_Window_SkillPresetMemo, closeTypeBitSet.default, "PaGlobalFunc_SkillPresetMemo_Close()")
  registerCloseLuaEvent(Panel_Widget_StackStorage_All, closeTypeBitSet.default, "PaGlobalFunc_StackStorage_All_Close()")
  registerCloseLuaEvent(Panel_CharacterTag_All, closeTypeBitSet.default, "PaGlobalFunc_CharacterTag_All_Close()")
  registerCloseLuaEvent(Panel_Window_SeasonReward_All, closeTypeBitSet.default, "PaGlobal_SeasonReward_All_Close()")
  registerCloseLuaEvent(Panel_Window_Quest_Option_All, closeTypeBitSet.attacked, "PaGlobal_Quest_Option_All_Close()")
  registerCloseLuaEvent(Panel_Window_MyInstruments_All, closeTypeBitSet.attacked, "PaGlobal_MyInstruments_All_Close()")
  registerCloseLuaEvent(Panel_Window_SelectInstruments_All, closeTypeBitSet.attacked, "PaGloabl_SelectInstruments_All_Close()")
  registerCloseLuaEvent(Panel_FreeBattleField_All, closeTypeBitSet.attacked, "PaGlobalFunc_FreeBaettleField_All_Close()")
  registerCloseLuaEvent(Panel_DragonPalace_Match_All, closeTypeBitSet.attacked, "PaGlobalFunc_DragonPalace_Match_All_Close()")
  registerCloseLuaEvent(Panel_Arena_Waiting, closeTypeBitSet.default, "PaGlobal_Arena_Waiting_Close()")
  registerCloseLuaEvent(Panel_Widget_ThornCastle_Enter, closeTypeBitSet.default, "HandleEventLUp_Widget_ThornCastle_Enter_Cancel()")
  registerCloseLuaEvent(Panel_Widget_ThornCastle_Map, closeTypeBitSet.default, "PaGlobal_Widget_ThornCastle_Map_Toggle()")
  registerCloseLuaEvent(Panel_ThornCastle_Shop, closeTypeBitSet.default, "PaGlobal_ThornCastle_NpcShop_All_Close()")
  registerCloseLuaEvent(Panel_Window_Equip_CharacterTag_ItemCopy, closeTypeBitSet.default, "PaGlobal_Equip_CharacterTag_ItemCopy_Close(true)")
  registerCloseLuaEvent(Panel_HorseRacing_Enter, closeTypeBitSet.default, "HandleEventLUp_HorseRacingEnter_Close()")
  registerCloseLuaEvent(Panel_HorseRacing_Waiting, closeTypeBitSet.default, "FromClient_HorseRacingWaiting_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_MoonBlessing_All, closeTypeBitSet.default, "PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_MoonBlessing_Renew_All, closeTypeBitSet.default, "PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()")
  registerCloseLuaEvent(Panel_Timer_Set, closeTypeBitSet.attacked, "PaGlobalFunc_Window_Timer_Close()")
  registerCloseLuaEvent(Panel_Window_FamilyInventory_All, closeTypeBitSet.default, "PaGlobalFunc_FamilyInventory_Close()")
  if _ContentsGroup_StaticSlot == true then
    registerCloseLuaEvent(Panel_Window_NewbieInventory_StaticSlot_All, closeTypeBitSet.default, "PaGlobalFunc_NewbieInventory_Close()")
  else
    registerCloseLuaEvent(Panel_Window_NewbieInventory_All, closeTypeBitSet.default, "PaGlobalFunc_NewbieInventory_Close()")
  end
  registerCloseLuaEvent(Panel_Window_EnchantInventory_All, closeTypeBitSet.default, "PaGlobal_EnchantInventory_Close(true)")
  registerCloseLuaEvent(Panel_Widget_HopeGauge, closeTypeBitSet.default, "PaGlobal_HopeGauge_Close()")
  registerCloseLuaEvent(Panel_Window_Description, closeTypeBitSet.attacked, "PaGlobalFunc_Window_Description_Close()")
  registerCloseLuaEvent(Panel_WorldMap_BookMark, closeTypeBitSet.default, "PaGlobalFunc_WorldMap_BookMark_Close()")
  registerCloseLuaEvent(Panel_Widget_BossInstance_Dummy, closeTypeBitSet.default, "PaGlobal_BossInstance_Esc()")
  registerCloseLuaEvent(Panel_IngameCashShop_GuildGiveaway_All, closeTypeBitSet.default, "PaGlobal_IngameCashshop_GuildGiveaway_Close()")
  registerCloseLuaEvent(Panel_Window_ExpirationPeriodItem, closeTypeBitSet.default, "PaGlobal_ExpirationPeriodItem:prepareClose()")
  registerCloseLuaEvent(Panel_Guild_MainServerSet_All, closeTypeBitSet.default, "PaGlobalFunc_GuildMainServerSet_Close()")
  registerCloseLuaEvent(Panel_AppliedBuffList_Console, closeTypeBitSet.default, "PaGlobalFunc_AppliedBuffList_Console_Close()")
  if true == _ContentsGroup_GuildReward then
    registerCloseLuaEvent(Panel_GuildReward_All, closeTypeBitSet.default, "PaGlobal_GuildReward_All_Close()")
  end
  registerCloseLuaEvent(Panel_Guild_MiningFuel_All, closeTypeBitSet.default, "PaGlobal_MiningFuel_All_Close()")
  registerCloseLuaEvent(Panel_GuildWar_Color, closeTypeBitSet.default, "PaGlobalFunc_GuildWarColor_All_Close()")
  registerCloseLuaEvent(Panel_GuildWar_ColorList, closeTypeBitSet.default, "PaGlobalFunc_GuildWarColorList_All_Close()")
  if true == _ContentsGroup_FairySkillChangeRateView then
    registerCloseLuaEvent(Panel_Window_FairyRateDesc, closeTypeBitSet.default, "PaGlobal_Window_FairyRateDesc_Close()")
  end
  registerCloseLuaEvent(Panel_Dialog_Servant_PremiumLookChange, closeTypeBitSet.default, "PaGlobalFunc_Servant_PremiumSkillRate_Close()")
  registerCloseLuaEvent(Panel_Window_WorkerManagerChangeName_All, closeTypeBitSet.default, "PaGlobalFunc_WorkerManagerChangeName_All_Close()")
  registerCloseLuaEvent(Panel_Window_FamilyCharacterChangeMemo_All, closeTypeBitSet.default, "PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()")
  registerCloseLuaEvent(Panel_Window_ServantRateDesc, closeTypeBitSet.default, "PaGlobal_Window_ServantRateDesc_Close()")
  registerCloseLuaEvent(Panel_Atoraxion_Enter, closeTypeBitSet.default, "PaGlobalFunc_Atoraxion_Enter_Close()")
  registerCloseLuaEvent(Panel_Atoraxion_Select, closeTypeBitSet.attacked, "PaGlobalFunc_Atoraxion_MapSelecter_Close()")
  registerCloseLuaEvent(Panel_Window_Guide_All, closeTypeBitSet.attacked, "PaGlobalFunc_Contents_Guide_Close()")
  registerCloseLuaEvent(Panel_AtoraxionMovie, closeTypeBitSet.default, "PaGlobalFunc_AtoraxionMovie_Close()")
  registerCloseLuaEvent(Panel_Window_SelectBox, closeTypeBitSet.default, "PaGlobal_SelectBox:prepareClose()")
  registerCloseLuaEvent(Panel_Window_MessageBox_ForReward, closeTypeBitSet.default, "PaGlobal_MessageBox_ForReward:prepareClose()")
  registerCloseLuaEvent(Panel_Window_MessageBox_Edit_All, closeTypeBitSet.default, "PaGlobalFunc_MessageBox_Edit_All_Close()")
  registerCloseLuaEvent(Panel_Window_ItemMoveSet, closeTypeBitSet.default, "PaGlobal_ItemMoveSet:prepareClose(true)")
  registerCloseLuaEvent(Panel_RentInstanceField_List, closeTypeBitSet.default, "PaGlobal_RentInstanceField_List:prepareClose()")
  registerCloseLuaEvent(Panel_RentInstanceField_Option, closeTypeBitSet.default, "PaGlobal_RentInstanceField_Option:prepareClose()")
  registerCloseLuaEvent(Panel_Window_Invite_All, closeTypeBitSet.default, "PaGlobalFunc_Invite_All_Close()")
  registerCloseLuaEvent(Panel_Event_QuizGM, closeTypeBitSet.default, "PaGlobal_Event_QuizGM_Close()")
  registerCloseLuaEvent(Panel_Event_Quiz, closeTypeBitSet.default, "PaGloabl_Event_Quiz_Close()")
  registerCloseLuaEvent(Panel_Event_Quiz_Minimal, closeTypeBitSet.default, "PaGloabl_Event_Quiz_Minimal_OXQuizExit()")
  registerCloseLuaEvent(Panel_Window_Warcall_Castle, closeTypeBitSet.default, "PaGlobal_Warcall_Castle_Close()")
  registerCloseLuaEvent(Panel_Widget_GoldenBell, closeTypeBitSet.default, "PaGlobalFunc_Widget_GoldenBell_Close()")
  if true == _ContentsGroup_RenewUI then
    registerCloseLuaEvent(Panel_ExtendExpiration_Renew, closeTypeBitSet.default, "PaGlobalFunc_ExtendExpiration_Renew_Close()")
  end
  registerCloseLuaEvent(Panel_Window_StatNew_All, closeTypeBitSet.default, "PaGlobal_CharacterStatNew_Close()")
  registerCloseLuaEvent(Panel_Window_StatDetail_All, closeTypeBitSet.default, "PaGlobal_CharacterStatDetail_All_Close()")
  if true == _ContentsGroup_MiniGame_YachtDice then
    registerCloseLuaEvent(Panel_Window_MiniGame_YachtDice, closeTypeBitSet.default, "PaGlobalFunc_MiniGame_YachtDice_Close()")
    registerCloseLuaEvent(Panel_Widget_MiniGame_YachtDice_Result, closeTypeBitSet.default, "PaGlobalFunc_MiniGame_YachtDice_Result_Close()")
    registerCloseLuaEvent(Panel_Window_MiniGame_YachtDice_PVP_Invite, closeTypeBitSet.default, "PaGlobalFunc_MiniGameYacht_Invite_Close()")
    registerCloseLuaEvent(Panel_Widget_MiniGame_YachtDice_Notice, closeTypeBitSet.default, "PaGlobalFunc_MiniGameYacht_Notice_Close(true)")
  end
  if _ContentsGroup_RewardMarket == true then
    registerCloseLuaEvent(Panel_Window_RewardMarket_All, closeTypeBitSet.default, "PaGlobalFunc_RewardMarket_Close()")
  end
  if true == ToClient_IsDevelopment() then
    registerCloseLuaEvent(Panel_Window_DamageLog, closeTypeBitSet.default, "PaGlobal_DamageLog:prepareClose()")
    registerCloseLuaEvent(Panel_Window_DamageLog_Detail, closeTypeBitSet.default, "PaGlobal_DamageLog_Detail:prepareClose()")
  end
  registerCloseLuaEvent(Panel_Window_MessageBoxElvia_All, closeTypeBitSet.default, "PaGlobalFunc_Window_MessageBoxElvia_All_Close()")
  registerCloseLuaEvent(Panel_Window_ChangeSeasonCharacter_All, closeTypeBitSet.default, "PaGlobal_ChangeSeasonCharacter_All_Close()")
  registerCloseLuaEvent(Panel_Window_MansionRank_All, closeTypeBitSet.default, "PaGlobalFunc_MansionRank_All_Close()")
  registerCloseLuaEvent(Panel_Window_SimpleInventory_SearchResult, closeTypeBitSet.default, "PaGlobal_SimpleInventory_SearchResult:prepareClose()")
  registerCloseLuaEvent(Panel_Window_AddStack_All, closeTypeBitSet.default, "PaGloabl_AddStack_All_close()")
  registerCloseLuaEvent(Panel_Window_Mansion_Contract_All, closeTypeBitSet.default, "PaGlobal_MansionContract_Close()")
  registerCloseLuaEvent(Panel_House_InstallationMode_Siege_All, closeTypeBitSet.default, "PaGlobal_House_InstallationSiege_All_Close()")
  if true == _ContentsGroup_BatchSummonMonsterByItem then
    registerCloseLuaEvent(Panel_BatchSummonMonster, closeTypeBitSet.default, "PaGlobalFunc_BatchSummonMonster_Close()")
  end
  registerCloseLuaEvent(Panel_Window_MessageBox_SeasonItem_All, closeTypeBitSet.default, "PaGlobalFunc_MessageBox_SeasonItem_All_Close()")
  if true == _ContentsGroup_PetSkillPercent then
    registerCloseLuaEvent(Panel_Window_PetSkill_Percent_All, closeTypeBitSet.default, "HandleEventLUp_PetSkill_Percent_All_Close()")
  end
  registerCloseLuaEvent(Panel_ImageSlider_All, closeTypeBitSet.default, "PaGlobalFunc_ImageCutScene_All_Close()")
  registerCloseLuaEvent(Panel_Window_ExchangeExp_All, closeTypeBitSet.default, "PaGlobal_ExchangeExp_All_Close()")
  if true == _ContentsGroup_ArtifactItem then
    registerCloseLuaEvent(Panel_Window_Artifacts_All, closeTypeBitSet.default, "PaGlobalFunc_Artifacts_All_Close()")
  end
  registerCloseLuaEvent(Panel_LocalWarTeam_SetVoiceChat_All, closeTypeBitSet.default, "PaGlobal_LocalWarVoiceChat_Close()")
  registerCloseLuaEvent(Panel_Event_TicketShop, closeTypeBitSet.default, "PaGlobal_Event_TicketShop_Close()")
  registerCloseLuaEvent(Panel_Event_TicketShop_Unboxing, closeTypeBitSet.default, "PaGlobal_Event_TicketShop_Unboxing_Close()")
  registerCloseLuaEvent(Panel_Window_Solrare_Matching, closeTypeBitSet.default, "PaGlobalFunc_Solrare_Matching_Close()")
  registerCloseLuaEvent(Panel_Solrare_OtherInfo, closeTypeBitSet.default, "PaGlobalFunc_Solrare_OtherInfo_Close()")
  registerCloseLuaEvent(Panel_Solrare_Ranking, closeTypeBitSet.default, "PaGlobalFunc_Solrare_Ranking_Close()")
  registerCloseLuaEvent(Panel_Solrare_EquipPresetList, closeTypeBitSet.default, "PaGlobalFunc_PaGlobal_Solare_EquipPreset_Close()")
  registerCloseLuaEvent(Panel_Window_Solrare_CustomMatching, closeTypeBitSet.default, "PaGlobalFunc_SolareCustom_Close()")
  registerCloseLuaEvent(Panel_Window_Solrare_CustomMatching_Invite, closeTypeBitSet.default, "PaGlobalFunc_SolareCustomInvite_Close()")
  if _ContentsGroup_SolareReplay == true then
    registerCloseLuaEvent(Panel_Window_Solrare_ReplayList, closeTypeBitSet.default, "PaGlobalFunc_SolareReplayList_Close()")
    registerCloseLuaEvent(Panel_Window_InstanceContentsReplayDownloadWeb, closeTypeBitSet.default, "PaGlobalFunc_InstanceContentsReplayDownloadWeb_Close()")
  end
  registerCloseLuaEvent(Panel_ScreenShot_SNS, closeTypeBitSet.default, "PaGlobal_ScreenShotSNS_Close()")
  registerCloseLuaEvent(Panel_Window_PersonalField_Main, closeTypeBitSet.default, "PaGlobal_PersonalField_Main_All_Close()")
  registerCloseLuaEvent(Panel_Widget_PersonalField_Enter, closeTypeBitSet.default, "PaGlobal_Widget_PersonalField_Enter_All_Close()")
  registerCloseLuaEvent(Panel_Window_SetupRepair_All, closeTypeBitSet.default, "PaGloabl_SetupRepair_All_Close()")
  if _ContentsGroup_RenewUI == true then
    registerCloseLuaEvent(Panel_Window_Arsha_ApplyWeb_forConsole, closeTypeBitSet.default, "PaGlobal_Arsha_ApplyWeb_ForConsole_Close()")
  end
  registerCloseLuaEvent(Panel_Window_TotalSearch, closeTypeBitSet.default, "PaGlobalFunc_TotalSearch_Close()")
  registerCloseLuaEvent(Panel_Window_ExplorePoint_UsingInfo, closeTypeBitSet.default, "PaGlobalFunc_ExplorePoint_UsingInfo_Close()")
  if _ContentsGroup_OneButtonBuff == true then
    registerCloseLuaEvent(Panel_Window_AutoBuff, closeTypeBitSet.default, "PaGlobalFunc_AutoUseBuffItem_Close()")
  end
  registerCloseLuaEvent(Panel_Window_CouponCode_Input, closeTypeBitSet.default, "PaGlobalFunc_Couponcode_Input_Close()")
  registerCloseLuaEvent(Panel_Window_Guild_Arbitration, closeTypeBitSet.default, "PaGlobalFunc_Guild_Arbitration_Close()")
  registerCloseLuaEvent(Panel_RecoveryElephant, closeTypeBitSet.default, "PaGlobalFunc_RecoveryElephant_Close()")
  registerCloseLuaEvent(Panel_Widget_HadumField_Enter, closeTypeBitSet.default, "PaGlobal_Widget_HadumField_Enter_All_Close()")
  registerCloseLuaEvent(Panel_IngameCashShop_Desc, closeTypeBitSet.default, "PaGlobal_IngameCashShop_DescClose()")
  registerCloseLuaEvent(Panel_Chat_Process_All, closeTypeBitSet.escapeOnly, "PaGlobalFunc_Chat_Process_Close()")
  registerCloseLuaEvent(QASupport_AutomationPanel, closeTypeBitSet.escapeOnly, "QASupport_AutomationPanel_Close()")
  if _ContentsGroup_ArtifactItem == true then
    registerCloseLuaEvent(Panel_Window_Artifacts_Exchange_All, closeTypeBitSet.default, "PaGlobal_ArtifactExchange_Close()")
  end
  registerCloseLuaEvent(Panel_Window_ReplayController_All, closeTypeBitSet.default, "PaGlobal_ReplayController_Close()")
  registerCloseLuaEvent(Panel_PartyContentRecurit, closeTypeBitSet.default, "PaGlobalFunc_PartyContentsRecruit_Close()")
  registerCloseLuaEvent(Panel_Event_SpecialPass_All, closeTypeBitSet.default, "PaGlobal_Event_SpecialPass_Close()")
  registerCloseLuaEvent(Panel_Widget_BossReward, closeTypeBitSet.default, "PaGlobalFunc_BossReward_Close()")
  registerCloseLuaEvent(Panel_Widget_Reward_All, closeTypeBitSet.default, "PaGlobalFunc_BoxReward_All_Close()")
  if _ContentsGroup_JewelPreset == true then
    registerCloseLuaEvent(Panel_Window_JewelPreset_Inven_All, closeTypeBitSet.default, "PaGlobalFunc_JewelPreset_CloseWithESC()")
    registerCloseLuaEvent(Panel_Window_JewelPreset_All, closeTypeBitSet.default, "PaGlobalFunc_JewelPreset_CloseWithESC()")
    registerCloseLuaEvent(Panel_Window_MessageBox_CrystalSet_All, closeTypeBitSet.default, "PaGlobalFunc_MessageBox_CrystalSet_All_Close()")
  end
  registerCloseLuaEvent(Panel_Widget_HopeGauge_Console, closeTypeBitSet.default, "PaGlobalFunc_HopeGauge_Console_Close()")
  registerCloseLuaEvent(Panel_Window_CutSceneEscSkip, closeTypeBitSet.default, "PaGlobalFunc_CutSceneEscSkip_Close()")
  registerCloseLuaEvent(Panel_Widget_Tooltip_Servant_All, closeTypeBitSet.default, "PaGlobal_Tooltip_Servant_All_Close()")
  registerCloseLuaEvent(Panel_Window_Bromide_All, closeTypeBitSet.default, "PaGlobalFunc_Bromide_All_Close()")
  if _ContentsGroup_MorningLand == true then
    registerCloseLuaEvent(Panel_MorningLand_MyReward_All, closeTypeBitSet.default, "PaGlobalFunc_MorningMyReward_Close()")
    registerCloseLuaEvent(Panel_MorningLand_DatailReward, closeTypeBitSet.default, "PaGlobalFunc_MorningLand_DetailReward_Close()")
    registerCloseLuaEvent(Panel_MorningLand_ConquestHistory, closeTypeBitSet.default, "PaGlobal_MorningLand_ConquestHistory_All_Close()")
    registerCloseLuaEvent(Panel_MorningLand_QuestBoard_All, closeTypeBitSet.default, "PaGlobal_MorningLand_QuestBoard_All_Close()")
    registerCloseLuaEvent(Panel_MorningLand_Scenario_All, closeTypeBitSet.default, "PaGlobal_MorningLand_Scenario_All_Close()")
    registerCloseLuaEvent(Panel_MorningLand_BossRanking, closeTypeBitSet.default, "PaGlobalFunc_MorningBossRank_Close()")
    registerCloseLuaEvent(Panel_Window_MorningLand_Boss_All, closeTypeBitSet.default, "PaGlobal_MorningLand_Boss_All_Close()")
  end
  registerCloseLuaEvent(Panel_MiniGame_MorningSlaughter_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningSlaughter_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_MorningSyringe_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningSyringe_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_MorningLeather_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningLeather_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_MorningMining_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningMining_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_MorningLogging_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningLogging_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_MorningHomi_All, closeTypeBitSet.default, "PaGlobal_MiniGame_MorningHomi_All_Close()")
  registerCloseLuaEvent(Panel_MiniGame_SniperShotResult_All, closeTypeBitSet.default, "PaGlobal_MiniGame_SniperShotResult_All_Close()")
  if ToClient_IsDevelopment() == true then
    registerCloseLuaEvent(Panel_JobInfoCreate, closeTypeBitSet.default, "PaGlobal_JobInfoCreate:prepareClose()")
    registerCloseLuaEvent(Panel_JobInfoFunc, closeTypeBitSet.default, "PaGlobal_JobInfoFunc:prepareClose()")
  end
  registerCloseLuaEvent(Panel_OtherUser_AdditionalRate_All, closeTypeBitSet.default, "PaGlobalFunc_OtherUser_TriedStack_Close()")
  if _ContentsGroup_RoseWar == true then
    registerCloseLuaEvent(Panel_RoseWar_Main, closeTypeBitSet.default, "PaGlobalFunc_RoseWarMain_Close()")
    registerCloseLuaEvent(Panel_RoseWar_MiniMap, closeTypeBitSet.default, "PaGlobalFunc_RoseWarMain_Close()")
    registerCloseLuaEvent(Panel_RoseWar_Mission, closeTypeBitSet.default, "PaGlobalFunc_RoseWarMission_Close()")
    registerCloseLuaEvent(Panel_RoseWar_MiniMapPartyList, closeTypeBitSet.default, "PaGlobalFunc_RoseWarMiniMapPartyList_Close()")
    registerCloseLuaEvent(Panel_RoseWar_Menu, closeTypeBitSet.default, "PaGlobalFunc_RoseWarMenu_Close()")
    registerCloseLuaEvent(Panel_RoseWar_EditParty, closeTypeBitSet.default, "PaGlobalFunc_RoseWarEditParty_Close()")
    registerCloseLuaEvent(Panel_RoseWar_PartyList, closeTypeBitSet.default, "PaGlobalFunc_RoseWarPartyList_Close()")
    registerCloseLuaEvent(Panel_RoseWar_ScoreBoard, closeTypeBitSet.default, "PaGlobalFunc_RoseWarScoreBoard_Close()")
    registerCloseLuaEvent(Panel_RoseWar_TeamScoreBoard, closeTypeBitSet.default, "PaGlobalFunc_RoseWarTeamScoreBoard_Close()")
  end
  if _ContentsGroup_Crogdalo == true and _ContentsGroup_UsePadSnapping == true then
    registerCloseLuaEvent(Panel_Window_CrogdaloStable, closeTypeBitSet.default, "PaGlobalFunc_CrogdaloStable_Close()")
  end
  registerCloseLuaEvent(Panel_Window_VillageSiegeMenu_All, closeTypeBitSet.default, "PaGlobalFunc_VillageSiegeMenu_Close()")
  registerCloseLuaEvent(Panel_Window_SiegeResult_All, closeTypeBitSet.default, "PaGlobalFunc_SiegeResult_All_Close()")
  registerCloseLuaEvent(Panel_Window_OceanSiegeResult_All, closeTypeBitSet.default, "PaGlobalFunc_OceanSiegeResult_All_Close()")
  registerCloseLuaEvent(Panel_Window_MonsterBuffZoneItemRepair, closeTypeBitSet.default, "PaGlobalFunc_MonsterBuffZoneItemRepair_Close()")
  registerCloseLuaEvent(Panel_Window_FantasyHorseGuide_Console, closeTypeBitSet.default, "PaGlobalFunc_FantasyHorseGuide_Console_Close()")
  registerCloseLuaEvent(Panel_Season_Graduation_All, closeTypeBitSet.default, "HandleEventLUp_BlackspiritPass_GraduateHide()")
  registerCloseLuaEvent(Panel_AsiaChampionship_Agreement_All, "PaGlobal_AsiaChampionshop_Agreement_Close()")
  registerCloseLuaEvent(Panel_Window_GroupEdit_All, closeTypeBitSet.default, "PaGlobalFunc_PetGroupEdit_Close()")
  registerCloseLuaEvent(Panel_AutoMove_Result_All, closeTypeBitSet.default, "PaGlobal_AutoMove_Result_All:close()")
  if _ContentsGroup_GuildMatch == true then
    registerCloseLuaEvent(Panel_Window_GuildMatch_GameRecord, closeTypeBitSet.default, "PaGlobalFunc_GuildMatchGameRecord_Close()")
    registerCloseLuaEvent(Panel_Window_GuildMatch_Rank, closeTypeBitSet.default, "PaGlobalFunc_GuildMatchRank_Close()")
  end
  registerCloseLuaEvent(Panel_Window_MagnusEasyTeleportMap, closeTypeBitSet.default, "HandleEventLUp_MagnusEasyTeleportMap_Close()")
  registerCloseLuaEvent(Panel_Window_Artifacts_Exchange_LOG_All, closeTypeBitSet.default, "PaGlobal_ArtifactsExchangeLog_Close()")
  if _ContentsGroup_LifeSimulator == true then
    registerCloseLuaEvent(Panel_Alchemy_RateViewList, closeTypeBitSet.default, "PaGloabl_Alchemy_RateViewList_Close(false)")
  end
  if _ContentsGroup_UsePadSnapping == true then
    registerCloseLuaEvent(Panel_Widget_LifeRingMenu_All, closeTypeBitSet.default, "PaGlobal_LifeRingMenu_All_Close()")
  end
  if _ContentsGroup_ItemSkillOption == true then
    registerCloseLuaEvent(Panel_Window_ItemSkillOption_All, closeTypeBitSet.default, "PaGlobalFunc_ItemSkillOption_All_Close()")
    registerCloseLuaEvent(Panel_Window_MakeGoonWang, closeTypeBitSet.default, "PaGlobalFunc_MakeGoonWang_Close()")
  end
  if _ContentsGroup_MorningLandTierParty == true then
    registerCloseLuaEvent(Panel_Window_MessageBoxForSequence_All, closeTypeBitSet.default, "PaGlobalFunc_MessageBoxForSequence_All_Refuse()")
  end
  if _ContentsGroup_LandscapePainting then
    registerCloseLuaEvent(Panel_Window_LandscapePaintingDrop, closeTypeBitSet.default, "PaGlobal_LandscapePainting_Close()")
  end
  if _ContentsGroup_PalaceManagement then
    registerCloseLuaEvent(Panel_Window_PalaceManagement_Tooltip, closeTypeBitSet.default, "PaGlobal_PalaceManagement_Tooltip_Close()")
    registerCloseLuaEvent(Panel_Window_PalaceManagement_WorkManager, closeTypeBitSet.default, "PaGlobal_PalaceManagement_Worker_Close()")
    registerCloseLuaEvent(Panel_Window_PalaceManagement_Node, closeTypeBitSet.default, "PaGlobal_PalaceManagement_Node_Close()")
    registerCloseLuaEvent(Panel_Window_PalaceManagement_Map, closeTypeBitSet.default, "PaGlobal_PalaceManagement_Map_Close()")
  end
  if _ContentsGroup_ServantLevelDown == true then
    registerCloseLuaEvent(Panel_Dialog_HorseLevelDecrease_All, closeTypeBitSet.attacked, "PaGlobal_Dialog_HorseLevelDecrease_All_Close()")
  end
  if _ContentsGroup_HardCoreChannel == true then
    registerCloseLuaEvent(Panel_Menu_HardCore, closeTypeBitSet.default, "PaGlobal_HardCoreMenu_Close()")
    registerCloseLuaEvent(Panel_CharacterInfo_HardCore_All, closeTypeBitSet.default, "PaGlobal_CharacterInfo_HardCore_Close()")
    registerCloseLuaEvent(Panel_Window_Hardcore_Result, closeTypeBitSet.default, "PaGlobal_HardCoreResult_Close()")
    registerCloseLuaEvent(Panel_Window_HardcoreRanking, closeTypeBitSet.default, "PaGlobal_HardCoreRanking_Close()")
    registerCloseLuaEvent(Panel_Window_Quest_HardCore, closeTypeBitSet.default, "PaGlobal_HardCoreQuestDetails_Close()")
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    registerCloseLuaEvent(Panel_Notation_Ability, closeTypeBitSet.default, "PaGlobalFunc_NotationAbility_Close()")
  end
  registerCloseLuaEvent(Panel_Chat_SubMenu, closeTypeBitSet.default, "HandleEventLUp_ChatSubMenuClose()")
  if _ContentsGroup_FishingCamp == true then
    registerCloseLuaEvent(Panel_Window_FishingCamp, closeTypeBitSet.default, "PaGlobal_FishingCamp_Close()")
  end
  if _ContentsGroup_PearlBoxWebBuy == true then
    registerCloseLuaEvent(Panel_Window_WebPurchaseConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_WebPurchaseConfirm_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Edania_Contents_All, closeTypeBitSet.default, "PaGlobal_Edania_Contents_Close()")
  if _ContentsGroup_TotalPreset == true then
    registerCloseLuaEvent(Panel_Window_PresetTotal_All, closeTypeBitSet.default, "PaGlobal_TotalPreset_Close()")
    registerCloseLuaEvent(Panel_Window_TotalPresetMemo, closeTypeBitSet.default, "PaGlobalFunc_TotalPresetMemo_Close()")
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    registerCloseLuaEvent(Panel_Window_ReforgeStonePreset_All, closeTypeBitSet.default, "PaGlobal_ReforgeStonePreset_Close()")
    registerCloseLuaEvent(Panel_Window_ReforgePresetNameEdit_All, closeTypeBitSet.default, "PaGlobalFunc_ReforgePresetNameEdit_Close()")
  end
  registerCloseLuaEvent(Panel_Window_Journal_All, closeTypeBitSet.default, "PaGlobal_Journal_All_Close()")
  registerCloseLuaEvent(Panel_Window_Journal_Select_All, closeTypeBitSet.default, "PaGlobal_Journal_Select_All_Close()")
  registerCloseLuaEvent(Panel_Window_Journal_Page_All, closeTypeBitSet.default, "PaGlobal_Journal_Page_All_Close()")
  registerCloseLuaEvent(Panel_Window_Journal_Book_All, closeTypeBitSet.default, "PaGlobal_Journal_Book_All_Close()")
  registerCloseLuaEvent(Panel_AbyssOne_Help, closeTypeBitSet.default, "PaGlobal_AbyssOneJoinGuide:prepareClose()")
  if _ContentsGroup_MaidActorSystem == true then
    registerCloseLuaEvent(Panel_Window_MaidActorList_All, closeTypeBitSet.default, "PaGlobalFunc_MaidActorList_Close()")
    registerCloseLuaEvent(Panel_Window_MaidActorRegist_All, closeTypeBitSet.default, "PaGlobalFunc_MaidActorRegist_Close()")
    registerCloseLuaEvent(Panel_Window_MaidActorChangeCloth_All, closeTypeBitSet.default, "PaGlobalFunc_MaidActorChangeCloth_Close()")
    registerCloseLuaEvent(Panel_Window_ChangeMaidActorName_All, closeTypeBitSet.default, "PaGlobalFunc_ChangeMaidActorName_Close()")
  end
  if _ContentsGroup_WorldMapKnowledgeIcon == true then
    registerCloseLuaEvent(Panel_Worldmap_KnowledgeList, closeTypeBitSet.default, "PaGlobal_WorldMap_KnowledgeListClose()")
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    registerCloseLuaEvent(Panel_Dialog_ServantLvUpMessageBox_All, closeTypeBitSet.default, "PaGlobal_ServantLvUpMessageBox_All_Close()")
  end
  if _ContentsGroup_SnowBoardMirrorField == true then
    registerCloseLuaEvent(Panel_Window_SnowBoard_Menu_All, closeTypeBitSet.default, "PaGlobalFunc_SnowBoardMenu_Close()")
    registerCloseLuaEvent(Panel_Window_SnowBoard_Result_All, closeTypeBitSet.default, "PaGlobalFunc_SnowBoardFieldResult_Close()")
  end
  registerCloseLuaEvent(Panel_Widget_Common_Countdown, closeTypeBitSet.none, "PaGlobal_Common_CountDown_Close()")
  if _ContentsGroup_LootingItemRecord == true then
    registerCloseLuaEvent(Panel_Window_LootingItemReport_Main_All, closeTypeBitSet.default, "PaGloabl_Window_LootingItemReport_Main_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_MessageBox_SnowBoard, closeTypeBitSet.default, "PaGlobal_MessageBox_SnowBoard_Close()")
  if _ContentsGroup_OlviaAcademy == true then
    registerCloseLuaEvent(Panel_Window_OlviaAcademy_Invitation, closeTypeBitSet.default, "PaGlobal_OlviaAcademy_Invitation_Close()")
    registerCloseLuaEvent(Panel_Window_OlviaAcademy_Main_All, closeTypeBitSet.default, "PaGlobalFunc_OlviaAcademy_Main_Close()")
    registerCloseLuaEvent(Panel_Window_OlviaAcademy_Pass_All, closeTypeBitSet.default, "PaGlobalFunc_OlviaAcademy_Pass_Close()")
  end
  if _ContentsGroup_WorldmapButtonShortcuts == true then
    registerCloseLuaEvent(Panel_Window_WorldmapButtonShortcuts_All, closeTypeBitSet.default, "PaGlobalFunc_WorldmapButtonShorcuts_All_Close()")
  end
end
function PaGlobalFunc_KeyboardHelpClose()
  Panel_KeyboardHelp:SetShow(false)
end
function PaGlobalFunc_Panel_QuickMenuCustomClose()
  if true == _ContentsGroup_UsePadSnapping then
    FGlobal_ConsoleQuickMenuSetting_Close()
  end
end
function PaGlobalFunc_GameExitClose()
  GameExitShowToggle(true)
  FGlobal_ChannelSelect_Hide()
  Panel_GameExit_sendGameDelayExitCancel()
end
function PaGlobal_GameExit_CloseAll()
  PaGlobal_GameExit_All_ShowToggle(true)
  PaGlobalFunc_ChannelSelect_All_Close()
end
local panel_MinigameList = {
  Panel_Minigame_Gradient,
  Panel_SinGauge,
  Panel_Command,
  Panel_RhythmGame,
  Panel_BattleGauge,
  Panel_FillGauge,
  Panel_MiniGame_Gradient_Y,
  Panel_MiniGame_Timing,
  Panel_MiniGame_Drag,
  Panel_MiniGame_PowerControl,
  Panel_RhythmGame_ForAction,
  Panel_MiniGame_Steal,
  Panel_MiniGame_Jaksal,
  Panel_RhythmGame_Drum,
  MiniGame_SniperReload
}
registerEvent("FromClient_luaLoadComplete", "initCloseFunction")
registerEvent("FromClinet_ExecuteEnterAbyssOne", "FromClinet_ExecuteEnterAbyssOne")
registerEvent("FromClinet_FailedEnterAbyssOne", "FromClinet_FailedEnterAbyssOne")
registerEvent("FromClinet_AllCloseFullScreenUI", "FromClinet_AllCloseFullScreenUI")
function initCloseFunction()
  CloseManager_RegisterExeptionList()
  closeExceptionListInitialize()
  registerClosePanelList()
end
function FromClinet_AllCloseFullScreenUI()
  IngameCustomize_Hide()
  close_WindowPanelList()
  close_force_WindowPanelList()
  if ToClient_WorldMapIsShow() == true and nil ~= FGlobal_PopCloseWorldMap then
    FGlobal_PopCloseWorldMap()
  end
  InGameShop_Close()
  if PaGlobal_Dye_All_CloseActual ~= nil then
    PaGlobal_Dye_All_CloseActual()
  end
  if nil ~= PaGlobalFunc_DialogMain_All_Close then
    PaGlobalFunc_DialogMain_All_Close()
  end
end
function FromClinet_ExecuteEnterAbyssOne()
  IngameCustomize_Hide()
  close_WindowPanelList()
  close_force_WindowPanelList()
  if ToClient_WorldMapIsShow() == true then
    if nil ~= FGlobal_PopCloseWorldMap then
      FGlobal_PopCloseWorldMap()
    elseif PaGlobalFunc_WorldMap_PopClose ~= nil then
      PaGlobalFunc_WorldMap_PopClose()
    end
  end
  InGameShop_Close()
  SetUIMode(Defines.UIMode.eUIMode_EnterAbyssOne)
end
function FromClinet_FailedEnterAbyssOne()
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function checkAllPanelSetCloseFunction()
  local result = Toclient_checkCloseEventSet()
  if true ~= result then
    UI.ASSERT(false, " \237\140\168\235\132\144\236\151\144 ,close \237\149\168\236\136\152\234\176\128 \236\133\139\237\140\133\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164 !! close \234\176\128 \236\160\149\236\131\129\236\158\145\235\143\153\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164 ")
    UI.ASSERT(false, " \237\149\180\235\139\185 \237\140\168\235\132\144\236\157\132 globalCloseManager_Renew.lua \236\152\136\236\153\184 \235\166\172\236\138\164\237\138\184\236\151\144 \236\182\148\234\176\128\237\149\152\234\177\176\235\130\152 close \237\149\168\236\136\152\235\165\188 \235\147\177\235\161\157\237\149\180\236\163\188\236\132\184\236\154\148 ")
  end
  _PA_LOG("\236\157\180\235\139\164\237\152\156", "\236\156\160\237\154\168\236\132\177 \234\178\128\236\130\172 \235\129\157")
end
function FromClient_EscapeEtcClose()
  if Panel_Tooltip_Item ~= nil then
    Panel_Tooltip_Item_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  end
  if nil ~= Panel_SkillTooltip_Hide then
    Panel_SkillTooltip_Hide()
  end
  if FGlobal_BuffTooltipOff ~= nil then
    FGlobal_BuffTooltipOff()
  end
  if TooltipSimple_Hide ~= nil then
    TooltipSimple_Hide()
  end
  if TooltipCommon_Hide ~= nil then
    TooltipCommon_Hide()
  end
  if Panel_LowLevelGuide_Value_IsCheckMoviePlay == 1 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindWay()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 2 then
    FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 3 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 4 then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 99 then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
  end
end
function FromClient_OpenOption()
  if true == isObserverMode() then
    return
  end
  if true == _ContentsGroup_RenewUI and nil ~= Panel_Widget_AccesoryQuest and true == Panel_Widget_AccesoryQuest:GetShow() and true == PaGlobalFunc_AccesoryQuest_IsSatisfied() then
    Input_AccesoryQuest_ApplyReward()
    return
  end
  if true == _ContentsGroup_InstanceHorseRacing and nil ~= Panel_HorseRacing_Score and true == Panel_HorseRacing_Score:GetShow() and __eHorseRacing_Result == ToClient_getHorseRacingState() and true == _ContentsGroup_UsePadSnapping and nil ~= HandleEventLUp_HorseRacing_Score_Exit then
    HandleEventLUp_HorseRacing_Score_Exit()
    return
  end
  if _ContentsGroup_UsePadSnapping == true and ToClient_isPlayingSequence() == true then
    return
  end
  if nil ~= Panel_Widget_EscapeBar_All and Panel_Widget_EscapeBar_All:GetShow() then
    ToClient_StopPreCoolTime()
    return
  end
  if isFirstFieldEnterMode() == true then
    return
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    PaGlobal_HardCoreMenu_Toggle()
    return
  end
  if false == _ContentsGroup_RenewUI and nil ~= Panel_Menu_ShowToggle then
    Panel_Menu_ShowToggle()
  elseif nil ~= Panel_Window_Menu_ShowToggle then
    Panel_Window_Menu_ShowToggle()
  elseif Panel_Widget_Menu_Remake ~= nil then
    PaGlobal_Menu_Remake_ShowToggle()
  end
end
function FromClient_CancelByAttacked(isForced)
  close_attacked_WindowPanelList(isForced)
end
function check_ShowWindow()
  _isAllClose = false
  return ToClient_isShownClosePanel()
end
function close_WindowPanelList()
  _isAllClose = true
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Escape, false)
end
function close_force_WindowPanelList()
  _isAllClose = true
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Force, true)
end
function close_escape_WindowPanelList()
  _isAllClose = false
  Toclient_processCheckEscapeKey()
  if true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    if true == _ContentsGroup_UsePadSnapping then
      local selfPlayer = getSelfPlayer()
      local isDead
      if nil ~= selfPlayer then
        isDead = selfPlayer:isDead()
      else
        return
      end
    end
    TooltipSimple_Hide()
    TooltipCommon_Hide()
  end
end
function close_WindowMinigamePanelList()
  for _, loopPanel in ipairs(panel_MinigameList) do
    if nil ~= loopPanel then
      loopPanel:SetShow(false, false)
    end
  end
end
function close_attacked_WindowPanelList(isForced)
  if false == _ContentsGroup_RenewUI_Chatting and false == AllowChangeInputMode() then
    return
  end
  local currentUiMode = GetUIMode()
  if nil ~= Panel_Window_NumberPad_All and true == Panel_Window_NumberPad_All:GetShow() and Defines.UIMode.eUIMode_Default == currentUiMode and nil ~= GameOption_GetHideWindow and false == GameOption_GetHideWindow() then
    return
  end
  if true ~= isForced and nil ~= PaGlobal_GameOption_All_isHideFullUiByAttacked and false == PaGlobal_GameOption_All_isHideFullUiByAttacked() then
    local bHide = true
    local checkFullUiMode = {
      Defines.UIMode.eUIMode_Housing,
      Defines.UIMode.eUIMode_Mental,
      Defines.UIMode.eUIMode_MentalGame,
      Defines.UIMode.eUIMode_NpcDialog,
      Defines.UIMode.eUIMode_NpcDialog_Dummy,
      Defines.UIMode.eUIMode_Trade,
      Defines.UIMode.eUIMode_WorldMap,
      Defines.UIMode.eUIMode_Stable,
      Defines.UIMode.eUIMode_Repair,
      Defines.UIMode.eUIMode_Extraction,
      Defines.UIMode.eUIMode_InGameCustomize,
      Defines.UIMode.eUIMode_InGameCashShop,
      Defines.UIMode.eUIMode_DyeNew,
      Defines.UIMode.eUIMode_ItemMarket,
      Defines.UIMode.eUIMode_TradeGame,
      Defines.UIMode.eUIMode_Cutscene,
      Defines.UIMode.eUIMode_Sequence,
      Defines.UIMode.eUIMode_SkillWindow,
      Defines.UIMode.eUIMode_SiegeInstallMode,
      Defines.UIMode.eUIMode_RoseWar
    }
    for k, v in ipairs(checkFullUiMode) do
      if currentUiMode == v then
        bHide = false
        break
      end
    end
    if false == bHide then
      return
    end
  end
  _isAllClose = true
  if PaGlobal_Ping_All ~= nil and Panel_Widget_Ping_All ~= nil then
    PaGlobal_Ping_All:prepareClose()
  end
  RenderModeAllClose()
  ToClient_PopBlackSpiritFlush()
  if isPhotoMode() then
    audioPostEvent_SystemUi(8, 14)
    _AudioPostEvent_SystemUiForXBOX(8, 14)
  end
  if true == _ContentsGroup_NewUI_InstallMode_All then
    PaGlobal_House_Installation_All_ByAttackedClose()
  else
    HandleClicked_HouseInstallation_Exit_ByAttacked()
  end
  if true == _ContentsGroup_NewUI_Inventory_All and nil ~= Panel_Window_Inventory_All and true == Panel_Window_Inventory_All:GetShow() then
    PaGlobalFunc_Inventory_All_Delete_No()
  end
  close_WindowMinigamePanelList()
  PanelCloseFunc_FairySkillChange(true)
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_PowerSave_All_Close()
  end
  if true == _ContentsGroup_SkillPreset then
    PaGlobal_SkillPreset_Close()
  end
  if 0 ~= dialog_getTalkNpcKey() then
    PaGlobalFunc_TradeFunction_All_SetIsTrading(false)
  end
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Attacked, false)
  PaGlobalFunc_DialogMain_All_Close(false, false, true)
  if GameOption_GetHideWindow() or true == isForced then
    ResetKeyCustombyAttacked()
    close_WindowPanelList()
  end
end
function PaGlobalFunc_CloseManager_GetisAllClose()
  return _isAllClose
end
function getCurrentCloseType()
  return Toclient_getCurrentCloseType()
end
initCloseFunction()
registerEvent("FromClient_luaLoadCompleteLateUdpate", "checkAllPanelSetCloseFunction")
registerEvent("FromClient_EscapeEtcClose", "FromClient_EscapeEtcClose")
registerEvent("FromClient_OpenOption", "FromClient_OpenOption")
registerEvent("progressEventCancelByAttacked", "FromClient_CancelByAttacked")
function PaCloseFunc_AskKnowlege_Close()
  Panel_AskKnowledge:SetShow(false)
end
function PanelCloseFunc_PetFusion_Close()
  PaGlobalFunc_PetFusion_Close()
end
function PanelCloseFunc_Interaction_HouseList_Close()
  PaGlobalFunc_Interaction_HouseList_Close()
end
function PanelCloseFunc_LocalWarInfo_Close()
  if ToClient_isConsole() == false then
    FGlobal_LocalWarInfo_Close()
  else
    PaGlobalFunc_LocalWarInfo_Exit()
  end
end
function PanelCloseFunc_RenewOption_Close()
  PaGlobal_Option:ClickedCancelOption()
  PaGlobal_Option:Close()
end
function PanelCloseFunc_FindParty_Close()
  if ToClient_isConsole() == false then
    FGlobal_PartyList_ShowToggle()
  else
    PaGlobalFunc_FindParty_Exit()
  end
end
function PanelCloseFunc_MarketWallet_Close()
  PaGlobalFunc_MarketWallet_Close()
end
function PanelCloseFunc_MarketPlace_Close()
  FGolbal_ItemMarketNew_Close()
end
function PanelCloseFunc_ServantInfo_Horse_Close()
  PaGlobal_VehicleInfo_All_Close()
end
function PanelCloseFunc_ServantInfo_Carriage_Close()
  if ToClient_isConsole() == false then
    CarriageInfo_Close()
  else
    PaGlobalFunc_CarriageInfo_Exit()
  end
end
function PanelCloseFunc_ServantInfo_Ship_Close()
  if ToClient_isConsole() == false then
    ShipInfo_Close()
  else
    PaGlobalFunc_ShipInfo_Exit()
  end
end
function PanelCloseFunc_WorldMap_NodeManagement_Close()
  PaGlobalFunc_WorldMap_NodeManagement_Close()
end
function PanelCloseFunc_WorldMap_NodeInfo_Close()
  PaGlobalFunc_WorldMap_NodeInfo_Close()
end
function PanelCloseFunc_ImprovementInfo_Discard()
  PaGlobalFunc_ImprovementInfo_Discard()
end
function PanelCloseFunc_PanelDelivery_Close()
  DeliveryRequestWindow_Close()
end
function PanelCloseFunc_PetList_Close()
  FGlobal_PetList_Close()
end
function PanelCloseFunc_MailRenew_Close()
  Mail_Close()
end
function PanelCloseFunc_NpcGift_Close()
  PaGlobalFunc_NpcGift_Close()
end
function PanelCloseFunc_Customization_BodyShape_Close()
  PaGlobalFunc_Customization_BodyBone_Close()
end
function PanelCloseFunc_Customization_BodyPose_Close()
  PaGlobalFunc_Customization_BodyPose_Close()
end
function PanelCloseFunc_Customization_Deco_Close()
  PaGlobalFunc_Customization_Deco_Close()
end
function PanelCloseFunc_Customization_FaceShape_Close()
  PaGlobalFunc_Customization_FaceBone_Close()
end
function PanelCloseFunc_Customization_HairShape_Close()
  PaGlobalFunc_Customization_HairShape_Close()
end
function PanelCloseFunc_Customization_InputName_Close()
  PaGlobalFunc_Customization_InputName_Close()
end
function PanelCloseFunc_Customization_Mesh_Close()
  PaGlobalFunc_Customization_Mesh_Close()
end
function PanelCloseFunc_Customization_ShowOutfit_Close()
  PaGlobalFunc_Customization_ShowCloth_Close()
end
function PanelCloseFunc_Customization_ShowPose_Close()
  PaGlobalFunc_Customization_ShowPose_Close()
end
function PanelCloseFunc_Customization_Skin_Close()
  PaGlobalFunc_Customization_Skin_Close()
end
function PanelCloseFunc_Customization_Voice_Close()
  PaGlobalFunc_Customization_Voice_Close()
end
function PanelCloseFunc_GuildPopup_Close()
  PaGlobalFunc_GuildPopup_Close()
end
function PanelCloseFunc_GuildCreate()
  PaGlobalFunc_GuildCreate_Close()
end
function PanelCloseFunc_MenuRenew()
  _AudioPostEvent_SystemUiForXBOX(53, 37)
  Panel_Window_Menu_Close()
end
function PanelCloseFunc_GuildSignOption()
  if true == PaGlobalFunc_AgreementGuild_SignOption_GetShow() then
    PaGlobalFunc_AgreementGuild_SignOption_SetShow(false, false)
  end
end
function PanelCloseFunc_QuickMenuCustom()
  FGlobal_ConsoleQuickMenuSetting_Close()
end
function PanelCloseFunc_GuildAgreementClose()
  Panel_Console_Window_GuildAgreement:SetShow(false, false)
end
function PanelCloseFunc_MentalGameClose()
  if true == PaGlobalFunc_MentalGame_Open() then
    PaGlobalFunc_MentalGame_Close()
  end
end
function PanelCloseFunc_VoiceChat()
  if true == PaGlobalFunc_VoiceChat_GetShow() then
    FGlobal_SetVoiceChat_Toggle()
  end
end
function PanelCloseFunc_ChannelSelect()
  Panel_ChannelSelect:SetShow(false, true)
end
function PanelCloseFunc_MiniGameFind()
  if nil ~= PaGloablFunc_MiniGameFind_GetShow and true == PaGloablFunc_MiniGameFind_GetShow() then
    PaGlobal_MiniGame_Find:askGameClose()
  end
end
function PanelCloseFunc_EventNotify()
  FGlobal_NpcNavi_Hide()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    PaGloabl_EventNotify_All_Close()
  else
    EventNotify_Close()
  end
end
function PanelCloseFunc_DailyStamp()
  DailStamp_Hide()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
end
function PanelCloseFunc_ArshaTeamNameChange()
  FGlobal_TeamNameChangeControl_Close()
end
function PanelCloseFunc_ArshaInviteList()
  FGlobal_ArshaPvP_InviteList_Close()
end
function PanelCloseFunc_Arsha()
  FGlobal_ArshaPvP_Close()
end
function PanelCloseFunc_ServantUpgrade()
  PaGlobal_ServantUpgrade_Close()
end
function PanelCloseFunc_ScreenShotAlbumFullScreen()
  ScreenshotAlbum_FullScreen_Close()
end
function PanelCloseFunc_ScreenShotAlbum()
  ScreenshotAlbum_Close()
end
function PanelCloseFunc_BlackSpiritAdventure()
  BlackSpiritAd_Hide()
end
function PanelCloseFunc_BlackSpiritAdventure2()
  BlackSpirit2_Hide()
end
function PanelCloseFunc_BlackSpiritAdventureVerPC()
  if Panel_Window_BlackSpiritAdventure:IsUISubApp() then
    return
  end
  Panel_Window_BlackSpiritAdventureVerPC:SetShow(false, false)
end
function PanelCloseFunc_EventMarbleGame()
  EventMarbleGameAd_Hide()
end
function PanelCloseFunc_ClothInventory()
  if nil ~= ClothInventory_Close then
    ClothInventory_Close()
  end
end
function PanelCloseFunc_MasterpieceAuction()
  if nil ~= Panel_Masterpiece_Auction_All then
    PaGlobal_Masterpiece_Auction_All_Close()
    return
  end
end
function PanelCloseFunc_MovieGuideWeb()
  PaGlobal_MovieGuide_Web:Close()
end
function PanelCloseFunc_MovieGuideWebList()
  PaGlobal_MovieGuide_Weblist:Close()
end
function PanelCloseFunc_MovieSkillGuideWeblist()
  PaGlobal_MovieSkillGuide_Web:Close()
end
function PanelCloseFunc_MovieSkillGuide()
  PaGlobal_MovieSkillGuide_Weblist:Close()
end
function PanelCloseFunc_BeginnerRoadmap()
  if PaGlobal_BlackspiritPass_GetShow ~= nil and PaGlobal_BlackspiritPass_GetShow() == true then
    PaGlobal_BlackspiritPass_Close()
  elseif PaGlobalFunc_SeasonPassAndRoadMap_GetShow ~= nil and PaGlobalFunc_SeasonPassAndRoadMap_GetShow() == true then
    PaGlobalFunc_SeasonPassAndRoadMap_Close()
  end
end
function PanelCloseFunc_CheckedQuestQption()
  FGlobal_CheckedQuestOptionClose()
end
function PanelCloseFunc_SkillSelectType()
  if true == Panel_Window_SkillGroup_SelectType:GetShow() and nil ~= PaGlobalFunc_SkillGroup_SelectType_Close then
    PaGlobalFunc_SkillGroup_SelectType_Close()
  end
end
function PanelCloseFunc_Skill()
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    if Panel_Window_SkillGroup ~= nil and Panel_Window_SkillGroup:GetShow() == true then
      PaGlobal_SkillGroup:close()
    end
    if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
      PaGlobalFunc_SkillGroup_All_Close()
    end
  else
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobalFunc_SkillGroup_All_CloseNotShowAni()
    elseif ToClient_isConsole() == false then
      HandleMLUp_SkillWindow_Close()
    else
      PaGlobalFunc_Skill_Close()
    end
    if Panel_EnableSkill:GetShow() then
      FGlobal_EnableSkillCloseFunc()
    end
  end
end
function PanelCloseFunc_SaveSetting()
  PaGlobal_Panel_SaveSetting_Hide()
end
function PanelCloseFunc_HarvestList()
  HarvestList_Close()
end
function PanelCloseFunc_PartyRecruite()
  if ToClient_isConsole() == true then
    PaGlobalFunc_FindPartyRecruite_Exit()
  else
    PartyListRecruite_Close()
  end
end
function PanelCloseFunc_ServantResurrection()
  Panel_ServantResurrection_Close()
end
function PanelCloseFunc_DialogNPCShopRenew()
  PaGlobalFunc_Dialog_NPCShop_Close()
end
function PanelCloseFunc_DialogNPCShop()
  NpcShop_WindowClose()
end
function PanelCloseFunc_Camp()
  PaGlobal_Camp:close()
end
function PanelCloseFunc_CampRegister()
  FGlobal_CampRegister_Close()
end
function PanelCloseFunc_MonsterRanking()
  FGlobal_MonsterRanking_Close()
end
function PanelCloseFunc_ChatOption()
  ChattingOption_Close()
end
function PanelCloseFunc_ChatOption_All()
  PaGlobalFunc_ChatOption_All_Close()
end
function PanelCloseFunc_BuildingBuff()
  PaGlobal_BuildingBuff:close()
end
function PanelCloseFunc_BuildingBuff_All()
  PaGlobalFunc_BuildingBuff_All_Close()
end
function PanelCloseFunc_PersonalBattle()
  PaGlobal_PersonalBattle:close()
end
function PanelCloseFunc_Memo()
  PaGlobal_Memo:ListClose()
end
function PanelCloseFunc_Memo_Main_All()
  PaGlobalFunc_Memo_Main_All_Close()
end
function PanelCloseFunc_CustomizingAlbum()
  CustomizingAlbum_Close(_isAllClose)
end
function PanelCloseFunc_IntroMovie()
  CloseIntroMovie()
end
function PanelCloseFunc_DialogMovie()
  CloseDialogMovie()
end
function PanelCloseFunc_ChattingInput()
  ChatInput_Close()
end
function PanelCloseFunc_ButtonShortcuts()
  PaGlobal_ButtonShortcuts:Close()
end
function PanelCloseFunc_TranslationReport()
  TranslationReport_Close()
end
function PanelCloseFunc_ProductNote()
  if true == _ContentsGroup_RenewUI and nil ~= Panel_ProductNote_Search and true == Panel_ProductNote_Search:GetShow() then
    PaGlobalFunc_ProductNote_Search_Close()
    return
  end
  Panel_ProductNote_ShowToggle()
end
function PanelCloseFunc_KeyboardHelp()
  FGlobal_KeyboardHelpShow()
end
function PanelCloseFunc_WebControl()
  FGlobal_WebHelper_ForceClose()
end
function PanelCloseFunc_ChannelChat()
  PaGlobalFunc_ChannelChat_Close()
end
function PanelCloseFunc_ChannelChatLoading()
  PaGlobalFunc_ChannelChat_Loading_Close()
end
function PanelCloseFunc_Warehouse()
  _PA_LOG("\236\181\156\237\149\156\236\167\132", "PanelCloseFunc_Warehouse ")
  if true == _ContentsGroup_UsePadSnapping then
    local isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
    if Panel_WareHouseFunctionPanel_All ~= nil and Panel_WareHouseFunctionPanel_All:GetShow() == true then
      PaGlobalFunc_WareHouseFunctionPanel_All_Close()
      return
    end
    if false == isManufactureOpen then
      PaGlobal_Warehouse_All_Close()
    end
  else
    PaGlobal_Warehouse_All_Close()
  end
end
function PanelCloseFunc_SetVoiceChat()
  FGlobal_SetVoiceChat_Close()
end
function PanelCloseFunc_WorkerChangeSkill()
  FGlobal_workerChangeSkill_Close()
end
function PanelCloseFunc_FileExplorer()
  closeExplorer()
end
function PanelCloseFunc_WorkerManager()
  workerManager_Close()
  FGlobal_HideWorkerTooltip()
end
function PanelCloseFunc_WorkerRestoreAll()
  workerRestoreAll_Close()
end
function PanelCloseFunc_WorkerAuction()
  WorkerAuction_Close()
end
function PanelCloseFunc_WorkerResistAuction()
  FGlobal_ResistWorkerToAuction_Close()
end
function PanelCloseFunc_WorkerListAuction()
  MyworkerList_Close()
end
function PanelCloseFunc_Exchange()
  Panel_ExchangePC_BtnClose_Mouse_Click()
end
function PanelCloseFunc_TransferLifeExperience()
  FGlobal_TransferLife_Close()
end
function PanelCloseFunc_DyePalette()
  FGlobal_DyePalette_Close()
end
function PanelCloseFunc_SetShortCut()
  FGlobal_NewShortCut_Close()
end
function PanelCloseFunc_Alchemy()
  if _ContentsGroup_RenewUI_Alchemy then
    PaGlobal_Alchemy_All_AlchemyBack()
  else
    PaGlobalFunc_Alchemy_All_Close()
  end
end
function PanelCloseFunc_Manufacture()
  if true == _ContentsGroup_RenewUI then
    PaGlobal_Manufacture_All_ManufactureBack()
  else
    PaGlobalFunc_Manufacture_All_Close()
  end
end
function PanelCloseFunc_Inventory()
  if Panel_Window_Manufacture_All:GetShow() then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_Manufacture_All_ManufactureBack()
    else
      PaGlobalFunc_Manufacture_All_Close()
    end
    return
  end
  if Panel_Window_Alchemy_All:GetShow() then
    if true == _ContentsGroup_RenewUI then
      PaGlobal_Alchemy_All_AlchemyBack()
    else
      PaGlobalFunc_Alchemy_All_Close()
    end
    return
  end
  if _ContentsGroup_AlchemyStoneRenewal == true and Panel_Window_AlchemyStone_All ~= nil and Panel_Window_AlchemyStone_All:GetShow() == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Close()
    return
  end
  if Panel_Window_Artifacts_Exchange_LOG_All:GetShow() == true then
    return
  end
  if nil ~= Panel_Window_StackExtraction_All and true == PaGlobalFunc_SpiritEnchant_All_GetIsAnimating() then
    return
  end
  if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
    PaGlobalFunc_TotalSearch_Close()
    return
  end
  if Panel_Window_ExplorePoint_UsingInfo ~= nil and Panel_Window_ExplorePoint_UsingInfo:GetShow() == true then
    PaGlobalFunc_ExplorePoint_UsingInfo_Close()
    return
  end
  if Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true then
    PaGlobal_AutoMove_Result_All:prepareClose()
    return
  end
  if Panel_Window_WareHouseHistory ~= nil and Panel_Window_WareHouseHistory:GetShow() == true then
    PaGlobal_WareHouseHistory:close()
    return
  end
  if Panel_WareHouseFunctionPanel_All ~= nil and Panel_WareHouseFunctionPanel_All:GetShow() == true then
    PaGlobalFunc_WareHouseFunctionPanel_All_Close()
    return
  end
  if nil ~= Panel_Window_Invitation_All and true == Panel_Window_Invitation_All:GetShow() then
    PaGlobal_Invitation_All_Close()
    return
  end
  if nil ~= Panel_Window_FamilyInventory_All and Panel_Window_FamilyInventory_All:GetShow() then
    PaGlobal_FamilyInvnetory_Close(true)
    return
  end
  if nil ~= Panel_Window_EnchantInventory_All and Panel_Window_EnchantInventory_All:GetShow() then
    PaGlobal_EnchantInventory_Close(true)
    return
  end
  if nil ~= Panel_Window_ItemMoveSet and true == Panel_Window_ItemMoveSet:GetShow() then
    return
  end
  InventoryWindow_Close()
  if PaGlobalFunc_SequenceSkip_SetInventoryCloseFlag ~= nil then
    PaGlobalFunc_SequenceSkip_SetInventoryCloseFlag()
  end
  if true == _ContentsGroup_NewUI_Equipment_All then
    if nil ~= Panel_Window_Equipment_All and Panel_Window_Equipment_All:GetShow() then
      PaGlobalFunc_Equipment_All_SetShow(false)
    end
  elseif nil ~= Panel_Equipment and Panel_Equipment:GetShow() then
    Equipment_SetShow(false)
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    PaGlobalFunc_ClothInventory_All_Close()
  elseif nil ~= ClothInventory_Close and Panel_Window_ClothInventory:GetShow() then
    ClothInventory_Close()
  end
  if PaGlobal_WareHouse_All_GetShow() then
    PaGlobal_Warehouse_All_Close()
  end
end
function PanelCloseFunc_ExchangeNumber()
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
end
function PanelCloseFunc_Option()
  GameOption_Cancel()
  TooltipSimple_Hide()
end
function PanelCloseFunc_CarveSeal()
  FromClient_SealWindowHide()
end
function PanelCloseFunc_CarveSeal_All()
  PaGloabl_CaveSeal_All_Close()
end
function PanelCloseFunc_GuildWebInfo()
  FGlobal_GuildWebInfoClose()
end
function PanelCloseFunc_GuildRankWeb()
  GuildRank_Web_Close()
end
function PanelCloseFunc_GuildRank()
  FGlobal_guildRanking_Close()
end
function PanelCloseFunc_ChangeWeapon()
  WeaponChange_Close()
end
function PanelCloseFunc_SkillReinforce()
  Panel_SkillReinforce_Close()
end
function PanelCloseFunc_SkillReinforce_All()
  PaGlobalFunc_PaGlobal_SkillReinforce_All_Close()
end
function PanelCloseFunc_Looting()
end
function PanelCloseFunc_FriendList()
  if nil ~= Panel_FriendList_Add_All and true == Panel_FriendList_Add_All:GetShow() then
    PaGlobal_AddFriend_All_Close()
    return
  end
  if nil ~= Panel_Friend_GroupRename_All and true == Panel_Friend_GroupRename_All:GetShow() then
    PaGlobal_Friend_GroupRename_All_Close()
    return
  end
  if nil ~= Panel_Friend_RequestList_All and true == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Close()
    return
  end
  if nil ~= Panel_FriendList_All and true == Panel_FriendList_All:GetShow() then
    PaGlobal_FriendList_All_Close()
  end
end
function PanelCloseFunc_FriendInfoList()
  if nil ~= Panel_FriendList_Add_All and true == Panel_FriendList_Add_All:GetShow() then
    PaGlobal_AddFriend_All_Close()
    return
  end
  if nil ~= Panel_Friend_GroupRename_All and true == Panel_Friend_GroupRename_All:GetShow() then
    PaGlobal_Friend_GroupRename_All_Close()
    return
  end
  if nil ~= Panel_Friend_RequestList_All and true == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Close()
    return
  end
  if nil ~= Panel_FriendInfoList_All and true == Panel_FriendInfoList_All:GetShow() then
    PaGlobal_FriendInfoList_All_Close()
  end
end
function PanelCloseFunc_CheckedQuest()
  FGlobal_QuestInfoDetail_Close()
end
function PanelCloseFunc_Quest()
  Panel_Window_QuestNew_Show(false)
end
function PanelCloseFunc_QuestRenew()
  PaGlobalFunc_Quest_SetShow(false)
end
function PanelCloseFunc_DeliveryRequest()
  DeliveryRequestWindow_Close()
end
function PanelCloseFunc_Guild()
  if nil ~= Panel_Guild_ManufactureSelect and Panel_Guild_ManufactureSelect:GetShow() then
    PaGlobal_Guild_ManufactureSelect:close()
  elseif nil ~= Panel_Guild_ManufactureSelect_All and Panel_Guild_ManufactureSelect_All:GetShow() then
    PaGlobalFunc_Guild_ManufactureSelect_All_Close()
  elseif nil ~= Panel_Window_Warehouse and true == Panel_Window_Warehouse:GetShow() then
    PaGlobal_Warehouse_All_Close()
  elseif nil ~= Panel_Guild_JoinRequestSet and true == Panel_Guild_JoinRequestSet:GetShow() then
    PaGlobal_GuildJoinRequestSet:close()
  else
    GuildManager:Hide()
    audioPostEvent_SystemUi(1, 31)
    _AudioPostEvent_SystemUiForXBOX(1, 31)
  end
end
function PanelCloseFunc_AgreementGuildMaster()
  agreementGuild_Master_Close()
end
function PanelCloseFunc_AgreementGuild()
  CheckChattingInput()
  audioPostEvent_SystemUi(1, 31)
  _AudioPostEvent_SystemUiForXBOX(1, 31)
  FGlobal_AgreementGuild_Close()
end
function PanelCloseFunc_GuildIncentive()
  FGlobal_GuildIncentive_Close()
end
function PanelCloseFunc_GuildDuel()
  FGlobal_GuildDuel_Close()
end
function PanelCloseFunc_GameTips()
  if false == _ContentsGroup_RenewUI then
    FGlobal_GameTipsHide()
  end
end
function PanelCloseFunc_PetInfoNew()
  TooltipSimple_Hide()
end
function PanelCloseFunc_Event100Day()
  FGlobal_Event_100Day_Close()
end
function PanelCloseFunc_WorkerTooltip()
  FGlobal_HideWorkerTooltip()
end
function PanelCloseFunc_ChangeItem()
  ItemChange_Close()
end
function PanelCloseFunc_MovieGuide()
  Panel_MovieGuide_ShowToggle()
end
function PanelCloseFunc_ItemMarket()
  FGolbal_ItemMarketNew_Close()
end
function PanelCloseFunc_ItemMarketRegistItem()
  FGlobal_ItemMarketRegistItem_Close()
end
function PanelCloseFunc_AlchemyFigureHead()
  FGlobal_AlchemyFigureHead_Close()
end
local isComboMovieClosedCount = 0
function PanelCloseFunc_MovieTheater320()
  if Panel_MovieTheater_320:IsShow() == false then
    value_Panel_MovieTheater_320_IsCheckedShow = false
  end
  if value_Panel_MovieTheater_320_IsCheckedShow == true then
    isComboMovieClosedCount = isComboMovieClosedCount + 1
    if isComboMovieClosedCount >= 3 then
      Panel_MovieTheater320_MessageBox()
      Panel_MovieTheater_MessageBox:SetShow(true)
    else
      Panel_MovieTheater320_ResetMessageBox()
      Panel_MovieTheater320_JustClose()
    end
  end
end
function PanelCloseFunc_CharacterTag()
  PaGlobal_CharacterTag_Close()
end
function PanelCloseFunc_FairyInfo()
  PaGlobal_FairyInfo_Close()
end
function PanelCloseFunc_FairySetting()
  PaGlobal_FairySetting_Close()
end
function PanelCloseFunc_FairyUpgrade()
  PaGlobal_FairyInfo_Close()
end
function PanelCloseFunc_FairySkillChange(isAttack)
  if nil ~= Panel_Window_FairyChangeSkill_All then
    PaGlobal_FairyChangeSkill_Close_All(isAttack)
  end
end
function PanelCloseFunc_LifeRanking()
  if _ContentsGroup_RenewUI then
    PaGlobal_LifeRanking_Close_All()
    return
  end
  PaGlobal_LifeRanking_Close_All()
end
function PanelCloseFunc_MessageBox()
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() and (Defines.UIMode.eUIMode_Default == GetUIMode() or Defines.UIMode.eUIMode_Repair == GetUIMode()) and nil ~= GameOption_GetHideWindow and false == GameOption_GetHideWindow() then
    return
  end
  messageBox_CloseButtonUp()
end
function PanelCloseFunc_MessageBoxCheck()
  messageBoxCheck_CloseButtonUp()
end
function PanelCloseFunc_Delivery_Information_Close()
  Panel_Window_Delivery_Information:SetShow(false)
end
function PanelCloseFunc_QuestInfo_Close()
  Panel_QuestInfo:SetShow(false)
end
function PanelCloseFunc_PetRestoreAll_Close()
  Panel_PetRestoreAll:SetShow(false)
end
function PanelCloseFunc_QuestReward_Close()
  FGlobal_ShowRewardList(false, 0)
end
function PanelCloseFunc_Equip_Close()
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == isInvenOpen then
    PanelCloseFunc_Inventory()
  elseif true == _ContentsGroup_NewUI_Equipment_All then
    PaGlobalFunc_Equipment_All_SetShow(false)
  else
    Equipment_SetShow(false)
  end
end
function PanelCloseFunc_GuildWarInfo_Close()
  Panel_Window_GuildWarInfo:SetShow(false)
end
function PanelCloseFunc_StableFunction_Close()
  if ToClient_isConsole() == false then
    StableFunction_Close()
  else
    StableFunction_Close()
  end
end
function PanelCloseFunc_PetExchange_Close()
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() then
    PaGlobalFunc_PetExchange_Close_Global()
  else
    PaGlobalFunc_PetExchange_Close()
  end
end
function PaGlobalFunc_FixEquip_Close()
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() then
    if nil ~= GameOption_GetHideWindow and false == GameOption_GetHideWindow() then
      return
    end
    PaGlobalFunc_RepairFunc_All_Close()
    SetUIMode(Defines.UIMode.eUIMode_Default)
  else
    PaGlobalFunc_RepairFunc_All_Close()
  end
end
function PanelEscapeFunc_CharacterInfo_Close()
  PaGlobal_CharacterInfo:hideWindow()
end
function PanelCloseFunc_WindowOption()
  Panel_Window_Option:SetShow(false)
end
function PanelCloseFunc_CompetitionGame()
  if PaGlobalFunc_Arsha_Reservation_All_GetShow() then
    PaGlobalFunc_Arsha_Reservation_All_Close()
  end
  if true == Panel_CompetitionGame_GuildReservation:GetShow() then
    FGlobal_Panel_CompetitionGame_GuildReservation_Close()
  end
end
function PaGlobalFunc_Enchant_Close()
  Panel_Window_Enchant_Renew:SetShow(false)
end
function PaGlobalFunc_Socket_Close()
  Panel_Window_Socket_Renew:SetShow(false)
end
function PaGlobalFunc_Improvement_Close()
  Panel_Window_Improvement_Renew:SetShow(false)
end
function PaGlobalFunc_ItemMArketAlarmListClose()
  if not PaGlobalFunc_ItemMarketAlarmList_IsUISubApp() then
    ItemMarket_AlarmList_Close()
  end
end
function PaGlobalFunc_BloodAlterMinor_Close()
  if true ~= _ContentsGroup_UsePadSnapping and true == Panel_Window_BloodAltar_All:GetShow() then
    return
  end
  PaGlobal_HandleClicked_BloodAltar_Open()
end
function PaGlobalFunc_BloodAlterMinor_RetryClose()
  if true ~= _ContentsGroup_UsePadSnapping and true == Panel_Window_BloodAltar_Retry_All:GetShow() then
    return
  end
  PaGlobalFunc_BlooaAltarRetry_RetryCheck(false)
end
function PaGlobalFunc_RandomRoulette_Close()
  HandleEventLUp_RandomBoxSelect_All_Close()
end
function close_UISubAppPanelList()
end
function PaGlobalFunc_FamilyInventory_Close()
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    PaGlobal_FamilyInvnetory_Close(true)
  else
    PaGlobal_FamilyInvnetory_Close(false)
    InventoryWindow_Close()
  end
end
function PaGlobalFunc_CombineBag_IsShow()
  if Panel_Window_CombineBag == nil then
    return false
  end
  if PaGlobal_CombineBag == nil then
    return false
  end
  return Panel_Window_CombineBag:GetShow()
end
