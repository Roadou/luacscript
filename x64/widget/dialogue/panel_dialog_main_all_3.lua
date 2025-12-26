function FromClient_DialogFunctionClick_Contents_Shop()
  local targetWindowList
  local count = 0
  local dialogData = ToClient_GetCurrentDialogData()
  local shopType = dialogData:getShopType()
  local isMessageBox = PaGlobal_DialogMain_All:shopTypeMessage(shopType)
  if true == isMessageBox then
    return
  end
  if nil ~= Panel_Dialog_NPCShop_All then
    if true == _ContentsGroup_NewUI_Inventory_All then
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory_All}
    else
      targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory}
    end
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory_All}
  else
    targetWindowList = {Panel_Window_NpcShop, Panel_Window_Inventory}
  end
  count = 2
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
  if Panel_NodeWarMenu ~= nil then
    FGlobal_NodeWarMenuClose()
  end
end
function FromClient_DialogFunctionClick_Contents_Skill()
  local targetWindowList
  local count = 0
  if ToClient_isConsole() == false then
    count = 1
    if _ContentsGroup_ShowOtherClassSkill == true then
      targetWindowList = {Panel_Window_SkillGroup_All}
    elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
      targetWindowList = {Panel_Window_Skill}
    else
      targetWindowList = {Panel_Window_SkillGroup}
    end
  end
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobal_SkillGroup_All:setDialog(true)
      PaGlobalFunc_SkillGroup_All_Open()
    else
      PaGlobal_SkillGroup:setDialog(true)
      HandleMLUp_SkillWindow_OpenForLearn()
    end
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  elseif ToClient_isConsole() == false then
    if HandleMLUp_SkillWindow_OpenForLearn ~= nil then
      HandleMLUp_SkillWindow_OpenForLearn()
    end
  elseif true == ToClient_LearnSkillCameraIsShowable() then
    PaGlobalFunc_Skill_Open(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  end
end
function FromClient_DialogFunctionClick_Contents_Guild()
  PaGlobal_CreateClan_All_Open()
end
function FromClient_DialogFunctionClick_Contents_Enchant()
  if _ContentsGroup_EnchantRemaster == true then
    PaGlobalFunc_EnchantMain_All_Open()
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
    audioPostEvent_SystemUi(1, 44)
    _AudioPostEvent_SystemUiForXBOX(1, 44)
    return
  end
  PaGlobalFunc_SpiritEnchant_All_Open()
  PaGlobalFunc_DialogMain_All_ShowToggle(false)
  audioPostEvent_SystemUi(1, 44)
  _AudioPostEvent_SystemUiForXBOX(1, 44)
end
function FromClient_DialogFunctionClick_Contents_Socket()
  if _ContentsGroup_JewelPreset == true then
    PaGlobalFunc_JewelPreset_Open()
    PaGlobalFunc_JewelInven_Close()
  else
    PaGlobalFunc_Socket_All_Open()
  end
  audioPostEvent_SystemUi(1, 44)
  _AudioPostEvent_SystemUiForXBOX(1, 44)
end
function FromClient_DialogFunctionClick_Contents_LordMenu()
  PaGlobalFunc_LordMenu_All_Open()
end
function FromClient_DialogFunctionClick_Contents_Extract()
  PaGlobal_Extraction_All_Open()
end
function FromClient_DialogFunctionClick_Contents_TerritorySupply()
  npcShop_requestList(CppEnums.ContentsType.Contents_TerritorySupply)
end
function FromClient_DialogFunctionClick_Contents_GuildShop()
  local targetWindowList
  local count = 0
  count = 2
  if true == _ContentsGroup_NewUI_Inventory_All then
    targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory_All}
  else
    targetWindowList = {Panel_Dialog_NPCShop_All, Panel_Window_Inventory}
  end
  PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  npcShop_requestList(CppEnums.ContentsType.Contents_GuildShop)
end
function FromClient_DialogFunctionClick_Contents_SupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_SupplyShop)
end
function FromClient_DialogFunctionClick_Contents_FishSupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_FishSupplyShop)
end
function FromClient_DialogFunctionClick_Contents_GuildSupplyShop()
  npcShop_requestList(CppEnums.ContentsType.Contents_GuildSupplyShop)
end
function FromClient_DialogFunctionClick_Contents_MinorLordMenu()
  FGlobal_NodeWarMenuOpen()
end
function FromClient_DialogFunctionClick_Contents_Improve()
  PaGlobalFunc_Improvement_All_Open()
  audioPostEvent_SystemUi(1, 44)
  _AudioPostEvent_SystemUiForXBOX(1, 44)
end
function FromClient_DialogFunctionClick_Contents_Repair()
  PaGlobalFunc_RepairFunc_All_Open(PaGlobal_RepairFunc_All._eType._dialog)
end
function FromClient_DialogFunctionClick_Contents_Warehouse()
  PaGlobal_Warehouse_All_OpenPanelFromDialog()
  if nil ~= PaGlobal_WareHouse_All then
    PaGlobal_WareHouse_All:setInventoryItemMoveEvent(true)
  end
end
function FromClient_DialogFunctionClick_Contents_Stable()
  if isGuildStable() then
    PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), stable_getServantType())
  else
    warehouse_requestInfoFromNpc()
    if __eServantTypeVehicle == stable_getServantType() then
      PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), __eServantTypeVehicle)
    elseif __eServantTypeShip == stable_getServantType() then
      if 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(9991) then
        PaGlobal_SailorManager_All:prepareOpen()
      else
        PaGlobalFunc_ServantFunction_All_Open(isGuildStable(), __eServantTypeShip)
      end
    else
      PetFunction_Open()
      PetList_Open()
    end
  end
  show_DialogPanel()
end
function FromClient_DialogFunctionClick_Contents_Transfer()
  DeliveryInformation_OpenPanelFromDialog()
end
function FromClient_DialogFunctionClick_Contents_ItemMarket()
  if PaGlobalFunc_ItemMarket_IsUISubApp() then
    Panel_Window_ItemMarket:CloseUISubApp()
    Panel_Window_ItemMarket:SetShow(false)
  end
  if not PaGlobalFunc_ItemMarket_GetShow() then
    FGolbal_ItemMarket_Function_Open()
  else
    FGolbal_ItemMarket_Function_Close()
  end
end
function FromClient_DialogFunctionClick_Contents_NewItemMarket()
  if not PaGlobalFunc_MarketPlace_GetShow() then
    if _ContentsOption_CH_CreditPoint == true then
      PaGlobalFunc_MarketPlace_CheckCreditPoint(eCreditPointCheckOpenType.openFromNpc)
    else
      PaGlobalFunc_MarketPlace_OpenFromDialog()
    end
  else
    PaGlobalFunc_MarketPlace_CloseToDialog()
  end
end
function FromClient_DialogFunctionClick_Contents_Knowledge()
  if false == _ContentsGroup_RenewUI then
    FGlobal_KnowledgeManagementShow()
  else
    PaGlobalFunc_KnowledgeManage_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_Join()
  Panel_Join_Show()
end
function FromClient_DialogFunctionClick_Contents_NpcGift()
  PaGlobalFunc_DialogNpcGift_All_Open()
  PaGlobalFunc_DialogIntimacy_All_Open()
end
function FromClient_DialogFunctionClick_Contents_WeakenEnchant()
  PaGlobalFunc_Purification_All_Open()
end
function FromClient_DialogFunctionClick_Contents_Employee()
  local talker = dialog_getTalker()
  if nil ~= talker then
    local charSSW = getCharacterStaticStatusWarpper(talker:getCharacterKey())
    if nil ~= charSSW then
      local needItemKey = ToClient_GetEmployeeNeedItemKey(talker:getCharacterKey())
      local slotNo = ToClient_InventoryGetSlotNo(needItemKey)
      ToClient_requestRegisterEmployee(slotNo)
      ToClient_PopDialogueFlush()
    end
  end
end
function FromClient_DialogFunctionClick_Contents_HelpDesk()
  PaGlobalFunc_DialogList_All_Open()
end
function FromClient_DialogFunctionClick_Contents_SeasonReward()
  PaGlobal_SeasonReward_All_Open()
end
function FromClient_DialogFunctionClick_Contents_YachtDice()
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local actorKeyRaw = talker:getActorKey()
  ToClient_showMiniGameYachtDiceUI(actorKeyRaw)
end
function FromClient_DialogFunctionClick_Contents_PetUpgrade()
  if _ContentsGroup_PetLeader == false then
    return
  end
  PaGlobal_DialogPetLeader_All_Open()
end
function FromClient_DialogFunctionClick_Contents_ArtifactExchange()
  if PaGlobal_ArtifactExchange_Open ~= nil then
    PaGlobal_ArtifactExchange_Open()
  end
end
function FromClient_DialogFunctionClick_Contents_RewardMarket()
  if _ContentsGroup_RewardMarket == false then
    return
  end
  PaGlobalFunc_RewardMarket_Open()
end
function PaGloalFunc_DialogMain_All_PreClosePanel()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  local simpleCloseFuncs = {
    DetectPlayer_Close,
    InventoryWindow_Close,
    ClothInventory_Close,
    Panel_Tooltip_Item_hideTooltip,
    Panel_SkillTooltip_Hide,
    FGlobal_BuffTooltipOff,
    Interaction_Close,
    Panel_MovieTheater_LowLevel_WindowClose,
    PaGloabl_Window_Wanted_Set_Close,
    PaGlobalFunc_JewelPreset_CloseWithESC
  }
  if _ContentsGroup_ProjectAbyssOne == true then
    table.insert(simpleCloseFuncs, PaGlobalFunc_AbyssOneMenu_Close)
  end
  for index = 1, 11 do
    local func = simpleCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  local checkCloseFuncs = {
    PreClose_Improvement,
    PreClose_Skill,
    PreClose_QuestInfo,
    PreClose_ReinforceSkill,
    PreClose_GameOption,
    PreClose_ItemMarket,
    PreClose_WareHouse,
    PreClose_Shop,
    PreClose_BlackSmith,
    PreClose_DyeColor,
    PreClose_WorkerManager,
    PreClose_WorkerAuction,
    PreClose_Menu,
    PreClose_Camp,
    PreClose_SearchMode,
    PreClose_SpiritEnchant,
    PreClose_Socket,
    PreClose_KnowledgeManagement,
    PreClose_NPCGift,
    PreClose_MasterpieceAuction,
    PreClose_Dialog,
    PreClose_GameExit,
    PreClose_Exchange,
    PreClose_MarketPlace,
    PreClose_PetUpgrade
  }
  for index = 1, #checkCloseFuncs do
    local func = checkCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  if nil ~= close_WindowPanelList then
    close_WindowPanelList()
  end
end
function PaGlobalFunc_DialogMain_All_CloseWithDialog()
  local simpleCloseFuncs = {
    PaGlobalFunc_DialogQuest_All_Close,
    PaGlobalFunc_MarketPlace_WalletInven_Close,
    PaGlobalFunc_MarketPlace_MyInven_Close,
    ServantInventory_Close,
    FGlobal_RaceInfo_Hide,
    GuildServantList_Close,
    DetectPlayer_Close,
    FGlobal_BlackSpiritAdventure_Close_CheckUiSub,
    click_DeliveryForPerson_Close,
    FGlobal_NodeWarMenuClose,
    ChatInput_Close,
    InventoryWindow_Close,
    PaGloabl_Window_Wanted_Set_Close,
    PaGlobalFunc_QuestRewardItemLogManager_Clear
  }
  for index = 1, #simpleCloseFuncs do
    local func = simpleCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  local checkCloseFuncs = {
    PreClose_ReinforceSkill,
    PreClose_ItemMarket,
    PreClose_Improvement,
    PreClose_EasyBuy,
    PreClose_BlackSmith,
    PreClose_TranslationReport,
    PreClose_WareHouse,
    PreClose_CreateGuildClan,
    PreClose_Skill,
    PreClose_MonsterBar,
    PreClose_Exchange,
    PreClose_GuildHouseAuction,
    PreClose_Shop,
    PreClose_Manufacture,
    PreClose_WorkerAuction,
    PreClose_NPCGift,
    PreClose_Purification,
    PreClose_SpiritEnchant,
    PreClose_Socket,
    PreClose_MasterpieceAuction,
    PreClose_Customize,
    PreClose_TradeMarket,
    PreClose_ServantDialog,
    CloseWith_BlackSmith,
    PreClose_ServantInfo,
    PreClose_MarketPlace,
    PreClose_Knowledge,
    PreClose_Dye,
    PreClose_RandomShop,
    CloseWith_Dialog,
    PreClose_LordMenu,
    PreClose_Delivery,
    PreClose_PetUpgrade
  }
  for index = 1, #checkCloseFuncs do
    local func = checkCloseFuncs[index]
    if nil ~= func then
      func()
    end
  end
  return true
end
function FromClient_DialogMain_All_CloseAllPanelWhenNpcGoHome()
  if GetUIMode() == Defines.UIMode.eUIMode_Stable and nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
    PaGlobalFunc_ServantFunction_All_Close()
  end
  if nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
    PaGlobalFunc_ServantFunction_All_Close()
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Trade and nil ~= Panel_Dialog_Trade_Function_All and true == Panel_Dialog_Trade_Function_All:GetShow() then
    HandleEventLUp_TradeFunction_All_Close()
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Repair then
    PaGlobalFunc_RepairFunc_All_Close()
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Extraction then
    PaGlobal_Extraction_All_Close()
  end
  if GetUIMode() == Defines.UIMode.eUIMode_MentalGame then
    PaGlobalFunc_MentalGame_All_Close()
  end
end
function PreClose_Improvement()
  if nil ~= Panel_Window_Improvement_All and true == Panel_Window_Improvement_All:GetShow() then
    if true == PaGlobal_Improvement_All_IsImprovementing() then
      return false
    end
    PaGlobalFunc_Improvement_All_Close()
  end
  if nil ~= Panel_Window_ItemSkillOption_All and true == Panel_Window_ItemSkillOption_All:GetShow() then
    if true == PaGlobal_ItemSkillOption_All_isImprove() then
      return false
    end
    PaGlobalFunc_ItemSkillOption_All_Close()
  end
end
function PreClose_Skill()
  if _ContentsGroup_ShowOtherClassSkill == true then
    PaGlobalFunc_SkillGroup_All_CloseNotShowAni()
  end
  if ToClient_isConsole() == false and HandleMLUp_SkillWindow_Close ~= nil then
    HandleMLUp_SkillWindow_Close()
  end
  if nil ~= Panel_SkillAwaken and true == Panel_SkillAwaken:GetShow() then
    SkillAwaken_Close()
  end
  if nil ~= Panel_Window_SkillGroup and true == Panel_Window_SkillGroup:GetShow() then
    PaGlobalFunc_SkillGroup_Close()
  end
  if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
    PaGlobalFunc_SkillGroup_All_Close()
  end
end
function PreClose_ReinforceSkill()
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    if PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close ~= nil and Panel_Window_ReinforceSkill_All:GetShow() == true then
      PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()
    end
    if PaGlobalFunc_PaGlobal_SkillReinforce_All_Close ~= nil and Panel_SkillReinforce_All:GetShow() == true then
      PaGlobalFunc_PaGlobal_SkillReinforce_All_Close()
    end
  elseif false == PaGlobal_DialogMain_All._isConsole then
    if Panel_Window_ReinforceSkill:GetShow() == true then
      Panel_Window_ReinforceSkill_Close()
    end
    if Panel_SkillReinforce:GetShow() == true then
      Panel_SkillReinforce_Close()
    end
  end
end
function PreClose_QuestInfo()
  if nil ~= Panel_QuestInfo and true == Panel_QuestInfo:GetShow() then
    questInfo_TooltipShow(false)
  end
end
function PreClose_GameOption()
  if nil ~= FGlobal_Option_GetShow and true == FGlobal_Option_GetShow() then
    GameOption_Cancel()
    TooltipSimple_Hide()
  end
end
function PreClose_ItemMarket()
  if nil ~= PaGlobalFunc_ItemMarketFunction_GetShow and true == PaGlobalFunc_ItemMarketFunction_GetShow() then
    FGolbal_ItemMarket_Function_Close()
    if nil ~= PaGlobalFunc_ItemMarketRegistItem_GetShow and true == PaGlobalFunc_ItemMarketRegistItem_GetShow() then
      FGlobal_ItemMarketRegistItem_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarketBuyConfirm_GetShow and true == PaGlobalFunc_ItemMarketBuyConfirm_GetShow() then
      FGlobal_ItemMarket_BuyConfirm_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarketItemSet_GetShow and true == PaGlobalFunc_ItemMarketItemSet_GetShow() then
      FGlobal_ItemMarketItemSet_Close()
    end
    if nil ~= PaGlobalFunc_ItemMarket_GetShow and true == PaGlobalFunc_ItemMarket_GetShow() then
      FGolbal_ItemMarketNew_Close()
      if true == MessageBoxPanelNilCheck() and true == MessageBoxGetShow() then
        messageBox_NoButtonUp()
      end
    end
  end
end
function PreClose_MarketPlace()
  if true == _ContentsGroup_RenewUI_ItemMarketPlace then
    if nil ~= PaGlobalFunc_MarketPlace_GetShow and true == PaGlobalFunc_MarketPlace_GetShow() or nil ~= PaGlobalFunc_MarketWallet_GetShow and true == PaGlobalFunc_MarketWallet_GetShow() then
      PaGlobalFunc_MarketPlace_CloseAllCheck()
    end
    if nil ~= PaGlobalFunc_MarketPlace_Function_GetShow and true == PaGlobalFunc_MarketPlace_Function_GetShow() then
      PaGlobalFunc_MarketPlace_Function_Close()
    end
  end
end
function PreClose_WareHouse()
  if nil ~= Panel_Window_Warehouse and true == Panel_Window_Warehouse:GetShow() then
    if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
      PaGlobalFunc_TotalSearch_Close()
    else
      PaGlobal_Warehouse_All_Close()
    end
  end
  if nil ~= Panel_Window_CargoSell and true == Panel_Window_CargoSell:GetShow() and true == _ContentsGroup_CargoSell then
    PaGlobal_CargoSell_Close()
  end
end
function PreClose_Shop()
  if nil ~= Panel_Dialog_NPCShop_All and true == Panel_Dialog_NPCShop_All:GetShow() then
    HandleEventLUp_NPCShop_ALL_Close(false)
  end
end
function PreClose_BlackSmith()
  if nil ~= Panel_Window_Extraction_Caphras_All and Panel_Window_Extraction_Caphras_All:GetShow() then
    PaGlobal_Extraction_Caphras_All_Close()
  end
  if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    PaGlobal_Endurance_Recovery_All_Close()
  end
  if nil ~= Panel_Window_Extraction_Result and true == Panel_Window_Extraction_Result:GetShow() then
    PaGlobal_ExtractionResult:setHide()
  end
  if nil ~= Panel_Window_Extraction_All and true == Panel_Window_Extraction_All:IsShow() then
    PaGlobal_Extraction_All_Close()
  end
end
function PreClose_DyeColor()
  if _ContentsGroup_NewUI_Dye_All then
    if Panel_Window_ColorMix_All ~= nil and Panel_Window_ColorMix_All:GetShow() then
      PaGlobal_ColorMix_All_Clsoe()
    end
  elseif _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and true == Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_ColorBalance and true == Panel_ColorBalance:GetShow() then
    Panel_ColorBalance_Close()
  end
end
function PreClose_WorkerManager()
  if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
    PaGlobalFunc_WorkerManager_All_Close()
  end
end
function PreClose_WorkerAuction()
  if nil ~= Panel_Window_WorkerAuction_All then
    HandleEventLUp_WorkerAuction_All_Close()
  else
    if nil ~= Panel_Worker_Auction and true == Panel_Worker_Auction:GetShow() then
      WorkerAuction_Close()
      Panel_Window_WorkerRandomSelect:SetShow(false)
    end
    if nil ~= Panel_WorkerResist_Auction and nil ~= Panel_WorkerList_Auction then
      Panel_WorkerResist_Auction:SetShow(false)
      Panel_WorkerList_Auction:SetShow(false)
    end
  end
  if nil ~= Panel_Window_WorkerRandomSelect_All then
    HandleEventLUp_WorkerRandomSelect_All_ForceClose()
  end
end
function PreClose_Menu()
  if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
    Panel_Menu_Close()
  end
end
function PreClose_Camp()
  if nil ~= Panel_Window_Camp and true == Panel_Window_Camp:GetShow() then
    PaGlobal_Camp:close()
  end
end
function PreClose_SearchMode()
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    if nil ~= Panel_Widget_Dialog_Search_All and true == Panel_Widget_Dialog_Search_All:IsShow() then
      PaGlobalFunc_DialogSearch_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI_SearchMode then
    if nil ~= Panel_Dialog_Search and true == Panel_Dialog_Search:IsShow() then
      searchView_Close()
    end
  elseif true == PaGlobalFunc_SearchMode_IsSearchMode() then
    searchView_Close()
  end
end
function PreClose_SpiritEnchant()
  if nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
    PaGlobalFunc_SpiritEnchant_All_Close()
  end
end
function PreClose_Socket()
  if nil ~= Panel_Window_Socket_All and true == Panel_Window_Socket_All:GetShow() then
    PaGlobalFunc_Socket_All_Close()
  end
end
function PreClose_KnowledgeManagement()
  if nil ~= Panel_KnowledgeManagement and true == Panel_KnowledgeManagement:GetShow() then
    KnowledgeClose()
  end
end
function PreClose_NPCGift()
  if ToClient_isConsole() == true then
    if PaGlobalFunc_NpcGift_Close ~= nil then
      PaGlobalFunc_NpcGift_Close()
    end
  elseif PaGlobalFunc_DialogNpcGift_All_Close ~= nil then
    PaGlobalFunc_DialogNpcGift_All_Close()
  end
end
function PreClose_MasterpieceAuction()
  if nil ~= Panel_Masterpiece_Auction_All and true == Panel_Masterpiece_Auction_All:GetShow() then
    PaGlobal_Masterpiece_Auction_All_Close()
  end
end
function PreClose_Dialog()
  if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
    PaGlobalFunc_DialogList_All_Close()
  end
  if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
    PaGlobalFunc_DialogExchange_All_Close()
  end
end
function PreClose_GameExit()
  if nil ~= Panel_GameExit and true == Panel_GameExit:GetShow() then
    GameExit_Close()
  end
  if nil ~= Panel_Window_GameExit_All then
    Panel_Window_GameExit_All:SetShow(false)
  end
end
function PreClose_Exchange()
  if nil ~= Panel_Window_Exchange and true == Panel_Window_Exchange:GetShow() then
    ExchangePC_MessageBox_ResponseCancel()
  end
  if nil ~= Panel_Window_Exchange and true == Panel_Window_Exchange:IsShow() then
    ExchangePc_MessageBox_CloseConfirm()
  end
  if true == _ContentsGroup_Barter then
    if PaGlobal_Barter_Close ~= nil then
      PaGlobal_Barter_Close()
    end
    if Panel_Exchange_Item_Hide ~= nil then
      Panel_Exchange_Item_Hide()
    end
  end
end
function PreClose_EasyBuy()
  if nil ~= Panel_IngameCashShop_EasyPayment and true == Panel_IngameCashShop_EasyPayment:GetShow() then
    if nil ~= Panel_IngameCashShop_BuyOrGift and true == Panel_IngameCashShop_BuyOrGift:GetShow() then
      local couponOpen = nil ~= Panel_IngameCashShop_Coupon and true == Panel_IngameCashShop_Coupon:GetShow()
      InGameShopBuy_Close(couponOpen)
    end
    PaGlobalFunc_EasyBuy_Close()
  end
end
function PreClose_TranslationReport()
  if nil ~= Panel_TranslationReport and true == Panel_TranslationReport:GetShow() then
    TranslationReport_Close()
  end
end
function PreClose_CreateGuildClan()
  if nil ~= Panel_CreateClan_All and Panel_CreateClan_All:GetShow() then
    PaGlobal_CreateClan_All_Close()
  end
  if nil ~= Panel_Guild_Create_All and Panel_Guild_Create_All:GetShow() then
    PaGlobal_Guild_Create_All_Close()
  end
end
function PreClose_MonsterBar()
  if true == isMonsterBarShow then
    Panel_Monster_Bar:SetShow(true, false)
    isMonsterBarShow = false
  end
end
function PreClose_GuildHouseAuction()
  if nil ~= Panel_GuildHouse_Auction_All and Panel_GuildHouse_Auction_All:GetShow() then
    PaGlobal_GuildHouse_Auction_All_Close()
  end
  if nil ~= Panel_GuildHouse_Auction_Detail_All and Panel_GuildHouse_Auction_Detail_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Detail_All_Close()
  end
  if nil ~= Panel_GuildHouse_Auction_Bid_All and Panel_GuildHouse_Auction_Bid_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Bid_All_Close()
  end
end
function PreClose_Manufacture()
  if ToClient_isConsole() == false and PaGlobalFunc_Manufacture_All_Close ~= nil then
    PaGlobalFunc_Manufacture_All_Close()
  end
end
function PreClose_Purification()
  if nil ~= Panel_Purification_All then
    HandleEventLUp_Purification_All_Close()
  elseif nil ~= Panel_Purification_Renew or nil ~= Panel_Purification then
    PaGlobal_Purification_Close()
  end
end
function PreClose_Customize()
  if nil ~= getCustomizingManager and true == getCustomizingManager():isShow() then
    HandleClicked_CloseIngameCustomization()
  end
  if nil ~= Panel_CustomizationMain and true == Panel_CustomizationMain:GetShow() then
    IngameCustomize_Hide()
  end
end
function PreClose_TradeMarket()
  if nil ~= Panel_Dialog_Trade_Function_All and true == Panel_Dialog_Trade_Function_All:GetShow() then
    HandleEventLUp_TradePriceRate_All_Close()
    HandleEventLUp_TradeFunction_All_Close()
  end
end
function PreClose_ServantDialog()
  if nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
    PaGlobalFunc_ServantFunction_All_Close()
  end
  if nil ~= Panel_Window_GuildWharfFunction and true == Panel_Window_GuildWharfFunction:GetShow() then
    GuildWharfFunction_Close()
  end
end
function PreClose_ServantInfo()
  if PaGlobal_VehicleInfo_All_Close ~= nil then
    PaGlobal_VehicleInfo_All_Close()
  end
end
function PreClose_Knowledge()
  if nil ~= Panel_Knowledge_Main and true == Panel_Knowledge_Main:GetShow() then
    Panel_Knowledge_Hide()
  end
end
function PreClose_Dye()
  if _ContentsGroup_NewUI_Dye_All then
    if nil ~= Panel_Widget_CharacterController_All and true == Panel_Widget_CharacterController_All:GetShow() then
      PaGlobal_Dye_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI_Dyeing and nil ~= Panel_DyeNew_CharacterController and true == Panel_DyeNew_CharacterController:GetShow() then
    FGlobal_Panel_DyeReNew_Hide()
  end
end
function PreClose_RandomShop()
  if PaGlobalFunc_RandomShop_All_Close ~= nil then
    PaGlobalFunc_RandomShop_All_Close()
  end
end
function PreClose_LordMenu()
  if nil ~= Panel_Window_LordMenu_All then
    HandleEventLUp_LordMenu_All_Close()
  end
end
function PreClose_Delivery()
  if Panel_Window_Delivery_All ~= nil then
    Panel_Window_Delivery_All:SetShow(false)
  end
end
function PreClose_PetUpgrade()
  if PaGlobal_DialogPetLeader_All_Close ~= nil then
    PaGlobal_DialogPetLeader_All_Close()
  end
end
function CloseWith_BlackSmith()
  if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    PaGlobalFunc_RepairFunc_All_Close()
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function CloseWith_Dialog()
  if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
    PaGlobalFunc_DialogList_All_Close(false)
  end
  if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
    PaGlobalFunc_DialogExchange_All_Close(false)
  end
end
function FromClient_DialogFunctionClick_OpenUI(type)
  if type == 0 then
    PaGlobalFunc_MakeGoonWang_Open()
  elseif type == 1 then
    PaGlobal_EndingCredit_Open()
  end
end
