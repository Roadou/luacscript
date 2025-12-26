local Type = {
  Inventory = 0,
  BlackSpirit = 1,
  WorldMap = 2,
  Skill = 3,
  Mail = 4,
  CharacterChallange = 5,
  ItemMarket = 6,
  Quest = 7,
  ServantCall = 8,
  ServantNavi = 9,
  CampActivate = 10,
  CampNavi = 11,
  HorseRaceInformation = 12,
  HorseRaceEnterOrCancel = 13,
  ResidenceList = 14,
  WorkerList = 15,
  GardenList = 16,
  PetList = 17,
  MaidList = 18,
  TagSetting = 19,
  Tag = 20,
  NpcFind = 21,
  MovieGuide = 22,
  VillageSiegeArea = 24,
  Pvp = 25,
  RingMenuSetting = 26,
  Profile = 27,
  VoiceChat = 28,
  Knowledge = 29,
  WharfNavi = 30,
  Guild = 31,
  Friend = 32,
  PearlShop = 33,
  PartySetting = 34,
  BeautyAlbum = 35,
  PhotoGallery = 36,
  ProductNote = 37,
  GuildRank = 38,
  BlackSpiritAdventure = 39,
  Manufacture = 40,
  TogglePVP = 41,
  PearInven = 42,
  Dyeing = 43,
  ToggleChatting = 44,
  GuildWarInfo = 45,
  TogglePhotoMode = 46,
  ConsoleUIOffset = 47,
  LifeRanking = 48,
  HorseInfo = 49,
  Fairy = 50,
  PersonalMonster = 51,
  GuildPing = 52,
  PartyPing = 53,
  BloodAltar = 54,
  BloodAltarRanking = 55,
  PlatoonSetting = 56,
  UseAlchemyStone = 57,
  RestoreItem = 58,
  GuildStableList = 59,
  MasterpieceAuction = 60,
  BattleGroundPvP = 61,
  ToggleWalkingMode = 62,
  News = 63,
  HotKey = 65,
  Beauty = 66,
  Escape = 67,
  BlackSpiritRage = 68,
  BuffList = 69,
  BlackSpiritSafe = 70,
  AttendanceReward = 71,
  AdventureLogBookShelf = 72,
  ItemDrop = 73,
  BossNotification = 74,
  TradeInfo = 75,
  Alchemy = 76,
  Totem = 77,
  RedBattleField = 78,
  BattleArena = 79,
  ArenaOfArsha = 80,
  PitOfTheUndying = 81,
  FindParty = 82,
  ChatGroup = 83,
  Setting = 84,
  EditUI = 85,
  Disconnect = 86,
  ServerSwitch = 87,
  OldMoonGrandPrix = 88,
  EmergencyEvade = 89,
  BarterInfo = 90,
  SeasonPass = 91,
  GrowthPass = 92,
  MajorSiegeArea = 93,
  OptiomizeMemory = 94,
  PingType = 95,
  PersonalFieldList = 96,
  TotalSearchItem = 97,
  HadumFieldEnter = 98,
  ItemAddPercentBuff = 99,
  FairyAutoBuff = 100,
  DailySpecial = 101,
  MonsterBuffZoneOff = 102,
  CrogdaloStable = 103,
  AgrisGaugeOnOff = 104,
  CollectInteractionOnOff = 105,
  MoveToWharf = 106,
  JewelPreset = 107,
  ExchangeCoinSystem = 108,
  LifeRingMenu = 109,
  EmployeeAutoFishingDiscard = 110,
  EdanaMainUI = 111,
  AdventureJournal = 112,
  LandscapePainting = 113,
  ReforgeStonePreset = 114,
  Undefined = 115
}
PaGlobal_ConsoleQuickMenu._functionTypeCount = Type.Undefined - 1
local function getTypeName(index)
  for typeName, typeIndex in pairs(Type) do
    if index == typeIndex then
      return typeName
    end
  end
  return nil
end
local ExecuteFunction = {}
function ExecuteFunction.Inventory()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
end
function ExecuteFunction.BlackSpirit()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
end
function ExecuteFunction.WorldMap()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_WorldMap)
end
function ExecuteFunction.Skill()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
end
function ExecuteFunction.Mail()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
end
function ExecuteFunction.CharacterChallange()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Present)
end
function ExecuteFunction.ItemMarket()
  if nil ~= PaGlobalFunc_Menu_All_MarketPlace_Open then
    PaGlobalFunc_Menu_All_MarketPlace_Open()
  end
end
function ExecuteFunction.Quest()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_QuestHistory)
end
function ExecuteFunction.ServantCall()
  Servant_Call(0)
end
function ExecuteFunction.ServantNavi()
  Servant_Navi(0)
end
function ExecuteFunction.CampActivate()
  PaGlobalFunc_Camp_All_Open()
end
function ExecuteFunction.HorseRaceInformation()
end
function ExecuteFunction.HorseRaceEnterOrCancel()
end
function ExecuteFunction.ResidenceList()
  PaGlobal_ResidenceList:open()
end
function ExecuteFunction.WorkerList()
  PaGlobalFunc_WorkerManager_All_Open()
end
function ExecuteFunction.GardenList()
  if true == _ContentsGroup_HarvestList_All then
    PaGlobal_HarvestList_All_Open()
  else
    PaGlobal_GardenList:open()
  end
end
function ExecuteFunction.PetList()
  PaGlobal_PetList_Toggle_All()
end
function ExecuteFunction.MaidList()
  PaGlobalFunc_MaidList_All_Open()
end
function ExecuteFunction.TagSetting()
  if nil ~= PaGlobalFunc_CharacterTag_All_Open then
    PaGlobalFunc_CharacterTag_All_Open()
  end
end
function ExecuteFunction.Tag()
  if nil ~= PaGlobalFunc_CharacterTag_All_Change then
    PaGlobalFunc_CharacterTag_All_Change()
  end
end
function ExecuteFunction.NpcFind()
  PaGlobal_NpcNavi_All_ShowToggle()
end
function ExecuteFunction.MovieGuide()
end
local toggleSiegeArea = false
local toggleMajorSiegeArea = false
function ExecuteFunction.VillageSiegeArea()
  toggleSiegeArea = not toggleSiegeArea
  ToClient_toggleVillageSiegeArea(toggleSiegeArea)
  if true == toggleSiegeArea then
    toggleMajorSiegeArea = false
    ToClient_toggleMajorSiegeArea(toggleMajorSiegeArea)
  end
end
function ExecuteFunction.MajorSiegeArea()
  toggleMajorSiegeArea = not toggleMajorSiegeArea
  ToClient_toggleMajorSiegeArea(toggleMajorSiegeArea)
  if true == toggleMajorSiegeArea then
    toggleSiegeArea = false
    ToClient_toggleVillageSiegeArea(toggleSiegeArea)
  end
end
function ExecuteFunction.GuildWarInfo()
  PaGlobalFunc_GuildWarInfo_All_Open()
end
function ExecuteFunction.Pvp()
end
function ExecuteFunction.RingMenuSetting()
  FromClient_ConsoleQuickMenu_OpenCustomPage(2)
end
function ExecuteFunction.Profile()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
end
function ExecuteFunction.VoiceChat()
  if false == ToClient_isConsole() then
    PaGlobal_VoiceChat_List_New_Open()
  else
    PaGlobalFunc_SetVoiceChat_All_Toggle()
  end
end
function ExecuteFunction.Knowledge()
  PaGlobalFunc_Window_Knowledge_Show()
end
function ExecuteFunction.WharfNavi()
  if _ContentsGroup_OceanCurrent then
    PaGlobal_ShipControl_Console_Open()
  else
    Servant_Navi(1)
  end
end
function ExecuteFunction.Guild()
  Process_UIMode_CommonWindow_Guild()
end
function ExecuteFunction.Friend()
  Process_UIMode_CommonWindow_FriendList()
end
function ExecuteFunction.PearlShop()
  Process_UIMode_CommonWindow_CashShop()
end
function ExecuteFunction.PartySetting()
  Process_UIMode_CommonWindow_PartySetting()
end
function ExecuteFunction.PlatoonSetting()
  Process_UIMode_CommonWindow_PlatoonSetting()
end
function ExecuteFunction.BeautyAlbum()
  if true == _ContentsGroup_RenewUI_BeautyAlbum then
    FGlobal_CustomizingAlbum_Show(false, CppEnums.ClientSceneState.eClientSceneStateType_InGame)
  end
end
function ExecuteFunction.PhotoGallery()
  ScreenshotAlbum_Open()
end
function ExecuteFunction.ProductNote()
  Panel_ProductNote_ShowToggle()
end
function ExecuteFunction.GuildRank()
  GuildRank_Web_Show()
end
function ExecuteFunction.BlackSpiritAdventure()
  FGlobal_BlackSpiritAdventure_Open()
end
function ExecuteFunction.Manufacture()
  Process_UIMode_CommonWindow_Manufacture()
end
function ExecuteFunction.TogglePVP()
  if true == isGameServiceTypeConsole() then
    local selfProxy = getSelfPlayer()
    if nil ~= selfProxy and selfProxy:get():getLevel() < 50 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOLEVEL_ACK"))
      return
    end
  end
  requestTogglePvP(true)
end
function ExecuteFunction.PearInven()
  PaGlobalFunc_InventoryInfo_Open(2, false, 0, false)
end
function ExecuteFunction.Dyeing()
  if true == _ContentsGroup_NewUI_Dye_All then
    PaGlobal_Dye_All_Open()
  else
    PaGlobalFunc_Dyeing_Open()
  end
end
function ExecuteFunction.ToggleChatting()
  PaGlobalFunc_ChattingViewer_SetToggleHideOption()
end
function ExecuteFunction.TogglePhotoMode()
  ToClient_setTogglePhotoMode()
end
function ExecuteFunction.ConsoleUIOffset()
  PaGlobal_ConsoleUIOffset_Open()
end
function ExecuteFunction.LifeRanking()
  if nil ~= PaGlobal_LifeRanking_Open_All then
    PaGlobal_LifeRanking_Open_All()
  end
end
function ExecuteFunction.HorseInfo()
  PaGlobal_VehicleInfo_All_OpenHorseInfo()
end
function ExecuteFunction.Fairy()
  PaGlobal_FairyInfo_Open_All(true)
end
function ExecuteFunction.PersonalMonster()
  HandleEventLUp_PersonalMonster_All_Open()
end
function ExecuteFunction.GuildPing()
  SendPingInfo_ToConsole(true)
end
function ExecuteFunction.PartyPing()
  SendPingInfo_ToConsole(false)
end
function ExecuteFunction.BloodAltar()
end
function ExecuteFunction.BloodAltarRanking()
  PaGlobal_AltarRankWeb_Open()
end
function ExecuteFunction.UseAlchemyStone()
  if _ContentsGroup_AlchemyStoneRenewal == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Use()
  else
    PaGlobalFunc_AlchemyStone_All_Use()
  end
end
function ExecuteFunction.RestoreItem()
  PaGlobalFunc_Restore_All_Open()
end
function ExecuteFunction.GuildStableList()
  if nil ~= FGlobal_GuildServantList_Open then
    FGlobal_GuildServantList_Open()
  end
end
function ExecuteFunction.MasterpieceAuction()
  PaGlobal_Masterpiece_Auction_All_ESCOpen()
end
function ExecuteFunction.BattleGroundPvP()
  if nil ~= Panel_Arena_Battle then
    local player = getSelfPlayer()
    if nil ~= player and true == player:get():isBattleGroundDefine() then
      PaGlobal_Arena_Battle_Open()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEGROUNPVP_CANTUSEUI"))
    end
  end
end
function ExecuteFunction.ToggleWalkingMode()
  local player = getSelfPlayer()
  if nil ~= player then
    ToClient_toggleWalkingMode()
  end
end
function ExecuteFunction.News()
  if nil ~= PaGlobalFunc_NewsBanner_Open then
    PaGlobalFunc_NewsBanner_Open()
  end
end
function ExecuteFunction.HotKey()
  if true == _ContentsGroup_RenewUI then
    if nil ~= PaGlobalFunc_KeyGuidWindow_Open then
      PaGlobalFunc_KeyGuidWindow_Open()
    end
  elseif nil ~= FGlobal_KeyboardHelpShow then
    FGlobal_KeyboardHelpShow()
  end
end
function ExecuteFunction.Beauty()
  if nil ~= HandleEventLUp_MenuRemake_Beauty then
    HandleEventLUp_MenuRemake_Beauty()
  end
end
function ExecuteFunction.Escape()
  if nil ~= HandleEventLUp_MenuRemake_Escape then
    HandleEventLUp_MenuRemake_Escape()
  end
end
function ExecuteFunction.BlackSpiritRage()
  if nil ~= PaGlobalFunc_Menu_All_BlackSpiritSkillLock_Open then
    PaGlobalFunc_Menu_All_BlackSpiritSkillLock_Open()
  end
end
function ExecuteFunction.BuffList()
  if nil ~= PaGlobalFunc_AppliedBuffList_Console_Open then
    PaGlobalFunc_AppliedBuffList_Console_Open()
  end
end
function ExecuteFunction.BlackSpiritSafe()
  if nil ~= PaGlobalFunc_Menu_All_TotalReward_Open then
    PaGlobalFunc_Menu_All_TotalReward_Open()
  end
end
function ExecuteFunction.AttendanceReward()
  if false == isGameTypeGT() and 0 < ToClient_GetAttendanceInfoCount() and nil ~= PaGlobalFunc_Menu_All_DailyStamp_Open then
    PaGlobalFunc_Menu_All_DailyStamp_Open()
  end
end
function ExecuteFunction.AdventureLogBookShelf()
  if nil ~= PaGlobalFunc_Menu_All_Achievement_All_Open then
    PaGlobalFunc_Menu_All_Achievement_All_Open()
  end
end
function ExecuteFunction.ItemDrop()
  if nil ~= PaGlobalFunc_Menu_All_DropItem_Open then
    PaGlobalFunc_Menu_All_DropItem_Open()
  end
end
function ExecuteFunction.BossNotification()
  if nil ~= PaGlobalFunc_Menu_All_BossAlert_Setting_Open then
    PaGlobalFunc_Menu_All_BossAlert_Setting_Open()
  end
end
function ExecuteFunction.Alchemy()
  if nil ~= PaGlobalFunc_Menu_All_AlchemyStone_Open then
    PaGlobalFunc_Menu_All_AlchemyStone_Open()
  end
end
function ExecuteFunction.Totem()
  if nil ~= PaGlobal_AlchemyFigureHead_All_Open then
    PaGlobal_AlchemyFigureHead_All_Open()
  end
end
function ExecuteFunction.RedBattleField()
  if nil ~= HandleEventLUp_MenuRemake_Localwar then
    HandleEventLUp_MenuRemake_Localwar()
  end
end
function ExecuteFunction.BattleArena()
  if nil ~= HandleEventLUp_MenuRemake_FreeFight then
    HandleEventLUp_MenuRemake_FreeFight()
  end
end
function ExecuteFunction.ArenaOfArsha()
  if nil ~= HandleEventLUp_MenuRemake_Competitiongame then
    HandleEventLUp_MenuRemake_Competitiongame()
  end
end
function ExecuteFunction.PitOfTheUndying()
  if nil ~= HandleEventLUp_MenuRemake_ImmortalHell then
    HandleEventLUp_MenuRemake_ImmortalHell()
  end
end
function ExecuteFunction.FindParty()
  if nil ~= PaGlobalFunc_Menu_All_PartyList_Show then
    PaGlobalFunc_Menu_All_PartyList_Show()
  end
end
function ExecuteFunction.ChatGroup()
  if nil ~= PaGlobalFunc_ChannelChat_Open then
    PaGlobalFunc_ChannelChat_Open()
  end
end
function ExecuteFunction.Setting()
  if nil ~= showGameOption then
    showGameOption()
  end
end
function ExecuteFunction.EditUI()
  if nil ~= FGlobal_UiSet_Open then
    FGlobal_UiSet_Open()
  end
end
function ExecuteFunction.Disconnect()
  if nil ~= PaGlobalFunc_Menu_All_GameExit_Open then
    PaGlobalFunc_Menu_All_GameExit_Open()
  end
end
function ExecuteFunction.ServerSwitch()
  if nil ~= PaGlobalFunc_Menu_All_ServerSelect_Open then
    PaGlobalFunc_Menu_All_ServerSelect_Open()
  end
end
function ExecuteFunction.OldMoonGrandPrix()
  if nil ~= FromClient_HorseRacingEnter_Open then
    FromClient_HorseRacingEnter_Open()
  end
end
function ExecuteFunction.EmergencyEvade()
  ToClient_UseEmergencyEvade()
end
function ExecuteFunction.BarterInfo()
  if nil ~= PaGlobal_BarterInfoSearch_Open then
    PaGlobal_BarterInfoSearch_Open()
  end
end
function ExecuteFunction.SeasonPass()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:isSeasonCharacter() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoOnlyUseSeasonCharacter"))
    return
  end
  if nil ~= PaGlobalFunc_SeasonPassAndRoadMap_Open then
    PaGlobalFunc_SeasonPassAndRoadMap_Open()
  end
end
function ExecuteFunction.GrowthPass()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:isSeasonCharacter() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseSeasonCharacter"))
    return
  end
  if true == _ContentsGroup_GrowthPass then
    PaGlobalFunc_GrowthPass_Open()
  end
end
function ExecuteFunction.OptiomizeMemory()
  ToClient_OptimizeMemoryForConsole()
end
function ExecuteFunction.PingType()
  if nil ~= Panel_Widget_Ping_All and nil ~= PaGlobal_Ping_All_Open then
    PaGlobal_Ping_All_Open(false)
  end
end
function ExecuteFunction.PersonalFieldList()
  if nil ~= Panel_Window_PersonalField_Main and nil ~= PaGlobal_PersonalField_Main_All_Open then
    PaGlobal_PersonalField_Main_All_Open()
  end
end
function ExecuteFunction.TotalSearchItem()
  if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_Open ~= nil then
    PaGlobalFunc_TotalSearch_Open()
  end
end
function ExecuteFunction.HadumFieldEnter()
  if PaGlobal_Widget_HadumField_Enter_All_Open ~= nil then
    PaGlobal_Widget_HadumField_Enter_All_Open(false)
  end
end
function ExecuteFunction.ItemAddPercentBuff()
  if PaGlobalFunc_Menu_All_HopeGauge_Open ~= nil then
    PaGlobalFunc_Menu_All_HopeGauge_Open()
  end
end
function ExecuteFunction.FairyAutoBuff()
  if PaGlobalFunc_AutoUseBuffItem_Open ~= nil then
    PaGlobalFunc_AutoUseBuffItem_Open()
  end
end
function ExecuteFunction.DailySpecial()
  if PaGlobal_Event_SpecialPass_Open ~= nil then
    PaGlobal_Event_SpecialPass_Open(__eSpecialPassContentType_Daily)
  end
end
function ExecuteFunction.MonsterBuffZoneOff()
  if _ContentsGroup_MonsterBuffZone == false then
    return
  end
  if HandleEventLUp_MonsterBuffZone_Deactive ~= nil then
    HandleEventLUp_MonsterBuffZone_Deactive()
  end
end
function ExecuteFunction.CrogdaloStable()
  if _ContentsGroup_Crogdalo == false then
    return
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  PaGlobalFunc_CrogdaloStable_ShowToggle()
end
function ExecuteFunction.MoveToWharf()
  ToClient_MoveWharfNpc()
end
function ExecuteFunction.JewelPreset()
  PaGlobalFunc_JewelPreset_Open()
end
function ExecuteFunction.AgrisGaugeOnOff()
  if _ContentsGroup_FeverBuff == false then
    return
  end
  PaGlobal_AgrisGauge_OnOffToggle()
end
function ExecuteFunction.LandscapePainting()
  if _ContentsGroup_FeverBuff == false then
    return
  end
  ToClient_requestToggleLandScapePaintingTotalSwitch()
end
function ExecuteFunction.ReforgeStonePreset()
  if _ContentsGroup_FeverBuff == false then
    return
  end
  PaGlobal_ReforgeStonePreset_Open()
end
function ExecuteFunction.CollectInteractionOnOff()
  setShowCollectInteractionUI(ToClient_getGameOptionControllerWrapper():getShowCollectInteractionUI() == false)
end
function ExecuteFunction.ExchangeCoinSystem()
  if _ContentsGroup_ExchangeCoinSystem == true and PaGlobal_ExchangeCoin_All ~= nil then
    PaGlobalFunc_ExchangeCoin_All_Open()
  end
end
function ExecuteFunction.LifeRingMenu()
  PaGlobal_LifeRingMenu_All_Open()
end
function ExecuteFunction.EmployeeAutoFishingDiscard()
  PaGloabl_SailorAutoFishingDiscard_All_SetFishDiscardListConsole()
end
function ExecuteFunction.EdanaMainUI()
  if PaGlobal_Edania_Contents_OpenByESC ~= nil then
    PaGlobal_Edania_Contents_OpenByESC()
  end
end
function ExecuteFunction.AdventureJournal()
  PaGlobal_Journal_Select_All_Open()
end
function PaGlobal_ConsoleQuickMenu:initialize()
end
PaGlobal_ConsoleQuickMenu._functionTypeList = {}
PaGlobal_ConsoleQuickMenu._functionTypeList._ExecuteFunction = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = ExecuteFunction.Inventory,
    [Type.BlackSpirit] = ExecuteFunction.BlackSpirit,
    [Type.WorldMap] = ExecuteFunction.WorldMap,
    [Type.Skill] = ExecuteFunction.Skill,
    [Type.Mail] = ExecuteFunction.Mail,
    [Type.CharacterChallange] = ExecuteFunction.CharacterChallange,
    [Type.ItemMarket] = ExecuteFunction.ItemMarket,
    [Type.Quest] = ExecuteFunction.Quest,
    [Type.ServantCall] = ExecuteFunction.ServantCall,
    [Type.ServantNavi] = ExecuteFunction.ServantNavi,
    [Type.CampActivate] = ExecuteFunction.CampActivate,
    [Type.CampNavi] = ExecuteFunction.CampNavi,
    [Type.HorseRaceInformation] = ExecuteFunction.HorseRaceInformation,
    [Type.HorseRaceEnterOrCancel] = ExecuteFunction.HorseRaceEnterOrCancel,
    [Type.ResidenceList] = ExecuteFunction.ResidenceList,
    [Type.WorkerList] = ExecuteFunction.WorkerList,
    [Type.GardenList] = ExecuteFunction.GardenList,
    [Type.PetList] = ExecuteFunction.PetList,
    [Type.MaidList] = ExecuteFunction.MaidList,
    [Type.TagSetting] = ExecuteFunction.TagSetting,
    [Type.Tag] = ExecuteFunction.Tag,
    [Type.NpcFind] = ExecuteFunction.NpcFind,
    [Type.MovieGuide] = ExecuteFunction.MovieGuide,
    [Type.VillageSiegeArea] = ExecuteFunction.VillageSiegeArea,
    [Type.Pvp] = ExecuteFunction.Pvp,
    [Type.RingMenuSetting] = ExecuteFunction.RingMenuSetting,
    [Type.Profile] = ExecuteFunction.Profile,
    [Type.VoiceChat] = ExecuteFunction.VoiceChat,
    [Type.Knowledge] = ExecuteFunction.Knowledge,
    [Type.WharfNavi] = ExecuteFunction.WharfNavi,
    [Type.Guild] = ExecuteFunction.Guild,
    [Type.Friend] = ExecuteFunction.Friend,
    [Type.PearlShop] = ExecuteFunction.PearlShop,
    [Type.PartySetting] = ExecuteFunction.PartySetting,
    [Type.BeautyAlbum] = ExecuteFunction.BeautyAlbum,
    [Type.PhotoGallery] = ExecuteFunction.PhotoGallery,
    [Type.ProductNote] = ExecuteFunction.ProductNote,
    [Type.GuildRank] = ExecuteFunction.GuildRank,
    [Type.BlackSpiritAdventure] = ExecuteFunction.BlackSpiritAdventure,
    [Type.Manufacture] = ExecuteFunction.Manufacture,
    [Type.TogglePVP] = ExecuteFunction.TogglePVP,
    [Type.PearInven] = ExecuteFunction.PearInven,
    [Type.Dyeing] = ExecuteFunction.Dyeing,
    [Type.ToggleChatting] = ExecuteFunction.ToggleChatting,
    [Type.GuildWarInfo] = ExecuteFunction.GuildWarInfo,
    [Type.TogglePhotoMode] = ExecuteFunction.TogglePhotoMode,
    [Type.ConsoleUIOffset] = ExecuteFunction.ConsoleUIOffset,
    [Type.LifeRanking] = ExecuteFunction.LifeRanking,
    [Type.HorseInfo] = ExecuteFunction.HorseInfo,
    [Type.Fairy] = ExecuteFunction.Fairy,
    [Type.PersonalMonster] = ExecuteFunction.PersonalMonster,
    [Type.GuildPing] = ExecuteFunction.GuildPing,
    [Type.PartyPing] = ExecuteFunction.PartyPing,
    [Type.BloodAltar] = ExecuteFunction.BloodAltar,
    [Type.BloodAltarRanking] = ExecuteFunction.BloodAltarRanking,
    [Type.PlatoonSetting] = ExecuteFunction.PlatoonSetting,
    [Type.UseAlchemyStone] = ExecuteFunction.UseAlchemyStone,
    [Type.RestoreItem] = ExecuteFunction.RestoreItem,
    [Type.GuildStableList] = ExecuteFunction.GuildStableList,
    [Type.MasterpieceAuction] = ExecuteFunction.MasterpieceAuction,
    [Type.BattleGroundPvP] = ExecuteFunction.BattleGroundPvP,
    [Type.ToggleWalkingMode] = ExecuteFunction.ToggleWalkingMode,
    [Type.News] = ExecuteFunction.News,
    [Type.HotKey] = ExecuteFunction.HotKey,
    [Type.Beauty] = ExecuteFunction.Beauty,
    [Type.Escape] = ExecuteFunction.Escape,
    [Type.BlackSpiritRage] = ExecuteFunction.BlackSpiritRage,
    [Type.BuffList] = ExecuteFunction.BuffList,
    [Type.BlackSpiritSafe] = ExecuteFunction.BlackSpiritSafe,
    [Type.AttendanceReward] = ExecuteFunction.AttendanceReward,
    [Type.ExchangeCoinSystem] = ExecuteFunction.ExchangeCoinSystem,
    [Type.AdventureLogBookShelf] = ExecuteFunction.AdventureLogBookShelf,
    [Type.ItemDrop] = ExecuteFunction.ItemDrop,
    [Type.BossNotification] = ExecuteFunction.BossNotification,
    [Type.TradeInfo] = ExecuteFunction.TradeInfo,
    [Type.Alchemy] = ExecuteFunction.Alchemy,
    [Type.Totem] = ExecuteFunction.Totem,
    [Type.LifeRingMenu] = ExecuteFunction.LifeRingMenu,
    [Type.RedBattleField] = ExecuteFunction.RedBattleField,
    [Type.BattleArena] = ExecuteFunction.BattleArena,
    [Type.ArenaOfArsha] = ExecuteFunction.ArenaOfArsha,
    [Type.PitOfTheUndying] = ExecuteFunction.PitOfTheUndying,
    [Type.FindParty] = ExecuteFunction.FindParty,
    [Type.ChatGroup] = ExecuteFunction.ChatGroup,
    [Type.Setting] = ExecuteFunction.Setting,
    [Type.EditUI] = ExecuteFunction.EditUI,
    [Type.Disconnect] = ExecuteFunction.Disconnect,
    [Type.ServerSwitch] = ExecuteFunction.ServerSwitch,
    [Type.OldMoonGrandPrix] = ExecuteFunction.OldMoonGrandPrix,
    [Type.EmergencyEvade] = ExecuteFunction.EmergencyEvade,
    [Type.BarterInfo] = ExecuteFunction.BarterInfo,
    [Type.SeasonPass] = ExecuteFunction.SeasonPass,
    [Type.GrowthPass] = ExecuteFunction.GrowthPass,
    [Type.MajorSiegeArea] = ExecuteFunction.MajorSiegeArea,
    [Type.OptiomizeMemory] = ExecuteFunction.OptiomizeMemory,
    [Type.PingType] = ExecuteFunction.PingType,
    [Type.PersonalFieldList] = ExecuteFunction.PersonalFieldList,
    [Type.TotalSearchItem] = ExecuteFunction.TotalSearchItem,
    [Type.HadumFieldEnter] = ExecuteFunction.HadumFieldEnter,
    [Type.ItemAddPercentBuff] = ExecuteFunction.ItemAddPercentBuff,
    [Type.FairyAutoBuff] = ExecuteFunction.FairyAutoBuff,
    [Type.DailySpecial] = ExecuteFunction.DailySpecial,
    [Type.MonsterBuffZoneOff] = ExecuteFunction.MonsterBuffZoneOff,
    [Type.CrogdaloStable] = ExecuteFunction.CrogdaloStable,
    [Type.AgrisGaugeOnOff] = ExecuteFunction.AgrisGaugeOnOff,
    [Type.CollectInteractionOnOff] = ExecuteFunction.CollectInteractionOnOff,
    [Type.MoveToWharf] = ExecuteFunction.MoveToWharf,
    [Type.JewelPreset] = ExecuteFunction.JewelPreset,
    [Type.EmployeeAutoFishingDiscard] = ExecuteFunction.EmployeeAutoFishingDiscard,
    [Type.EdanaMainUI] = ExecuteFunction.EdanaMainUI,
    [Type.AdventureJournal] = ExecuteFunction.AdventureJournal,
    [Type.LandscapePainting] = ExecuteFunction.LandscapePainting,
    [Type.ReforgeStonePreset] = ExecuteFunction.ReforgeStonePreset
  }
}
PaGlobal_ConsoleQuickMenu._functionTypeList._CheckAbyssOneExecute = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = true,
    [Type.BlackSpirit] = true,
    [Type.Skill] = true,
    [Type.Quest] = true,
    [Type.RingMenuSetting] = true
  }
}
PaGlobal_ConsoleQuickMenu._functionTypeList._CheckSequencePlayerControlExecute = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = true,
    [Type.UseAlchemyStone] = true
  }
}
PaGlobal_ConsoleQuickMenu._functionTypeList._icon = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 1,
      _y1 = 292,
      _x2 = 51,
      _y2 = 342
    },
    [Type.BlackSpirit] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 1,
      _y1 = 190,
      _x2 = 51,
      _y2 = 240
    },
    [Type.WorldMap] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 52,
      _y1 = 343,
      _x2 = 102,
      _y2 = 393
    },
    [Type.Skill] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 1,
      _y1 = 241,
      _x2 = 51,
      _y2 = 291
    },
    [Type.Mail] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 52,
      _y1 = 292,
      _x2 = 102,
      _y2 = 342
    },
    [Type.CharacterChallange] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 52,
      _y1 = 190,
      _x2 = 102,
      _y2 = 240
    },
    [Type.ItemMarket] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 1,
      _y1 = 343,
      _x2 = 51,
      _y2 = 393
    },
    [Type.Quest] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 52,
      _y1 = 241,
      _x2 = 102,
      _y2 = 291
    },
    [Type.ServantCall] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 103,
      _y1 = 190,
      _x2 = 153,
      _y2 = 240
    },
    [Type.ServantNavi] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 103,
      _y1 = 241,
      _x2 = 153,
      _y2 = 291
    },
    [Type.CampActivate] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 52,
      _y1 = 445,
      _x2 = 102,
      _y2 = 495
    },
    [Type.CampNavi] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 103,
      _y1 = 445,
      _x2 = 153,
      _y2 = 495
    },
    [Type.HorseRaceInformation] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 154,
      _y1 = 241,
      _x2 = 204,
      _y2 = 291
    },
    [Type.HorseRaceEnterOrCancel] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 154,
      _y1 = 190,
      _x2 = 204,
      _y2 = 240
    },
    [Type.ResidenceList] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 205,
      _y1 = 394,
      _x2 = 255,
      _y2 = 444
    },
    [Type.WorkerList] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 205,
      _y1 = 190,
      _x2 = 255,
      _y2 = 240
    },
    [Type.GardenList] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 205,
      _y1 = 241,
      _x2 = 255,
      _y2 = 291
    },
    [Type.PetList] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 205,
      _y1 = 292,
      _x2 = 255,
      _y2 = 342
    },
    [Type.MaidList] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 154,
      _y1 = 292,
      _x2 = 204,
      _y2 = 342
    },
    [Type.TagSetting] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 308,
      _x2 = 51,
      _y2 = 358
    },
    [Type.Tag] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 257,
      _x2 = 255,
      _y2 = 307
    },
    [Type.NpcFind] = {
      _path = "Renewal/Function/Console_Function_RingMenu.dds",
      _x1 = 934,
      _y1 = 603,
      _x2 = 984,
      _y2 = 653
    },
    [Type.MovieGuide] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 154,
      _y1 = 394,
      _x2 = 204,
      _y2 = 444
    },
    [Type.VillageSiegeArea] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 256,
      _y1 = 241,
      _x2 = 306,
      _y2 = 291
    },
    [Type.Pvp] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 154,
      _y1 = 445,
      _x2 = 204,
      _y2 = 495
    },
    [Type.RingMenuSetting] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 205,
      _y1 = 445,
      _x2 = 255,
      _y2 = 495
    },
    [Type.Profile] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 307,
      _y1 = 292,
      _x2 = 357,
      _y2 = 342
    },
    [Type.VoiceChat] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 256,
      _y1 = 190,
      _x2 = 306,
      _y2 = 240
    },
    [Type.Knowledge] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 256,
      _y1 = 343,
      _x2 = 306,
      _y2 = 393
    },
    [Type.WharfNavi] = {
      _path = "Renewal/Function/Console_Function_RingMenu_01.dds",
      _x1 = 103,
      _y1 = 292,
      _x2 = 153,
      _y2 = 342
    },
    [Type.Guild] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 307,
      _y1 = 190,
      _x2 = 357,
      _y2 = 240
    },
    [Type.Friend] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 256,
      _y1 = 292,
      _x2 = 306,
      _y2 = 342
    },
    [Type.PearlShop] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 307,
      _y1 = 241,
      _x2 = 357,
      _y2 = 291
    },
    [Type.PartySetting] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 307,
      _y1 = 343,
      _x2 = 357,
      _y2 = 393
    },
    [Type.BeautyAlbum] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 358,
      _y1 = 292,
      _x2 = 408,
      _y2 = 342
    },
    [Type.PhotoGallery] = {
      _path = "Renewal/Button/Console_Btn_ESCMenu.dds",
      _x1 = 2,
      _y1 = 250,
      _x2 = 62,
      _y2 = 310
    },
    [Type.ProductNote] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 156,
      _y1 = 53,
      _x2 = 206,
      _y2 = 103
    },
    [Type.GuildRank] = {
      _path = "Renewal/Button/Console_Btn_ESCMenu.dds",
      _x1 = 436,
      _y1 = 250,
      _x2 = 496,
      _y2 = 310
    },
    [Type.BlackSpiritAdventure] = {
      _path = "Renewal/Button/Console_Btn_ESCMenu.dds",
      _x1 = 126,
      _y1 = 436,
      _x2 = 186,
      _y2 = 496
    },
    [Type.Manufacture] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 358,
      _y1 = 241,
      _x2 = 408,
      _y2 = 291
    },
    [Type.TogglePVP] = {
      _path = "Renewal/Function/Console_Function_RingMenu.dds",
      _x1 = 1087,
      _y1 = 654,
      _x2 = 1137,
      _y2 = 704
    },
    [Type.PearInven] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 358,
      _y1 = 190,
      _x2 = 408,
      _y2 = 240
    },
    [Type.Dyeing] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 358,
      _y1 = 343,
      _x2 = 408,
      _y2 = 393
    },
    [Type.ToggleChatting] = {
      _path = "Renewal/Function/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 1,
      _x2 = 51,
      _y2 = 51
    },
    [Type.GuildWarInfo] = {
      _path = "Renewal/UI_Icon/XboxConsole_Icon_Title.dds",
      _x1 = 116,
      _y1 = 344,
      _x2 = 171,
      _y2 = 399
    },
    [Type.TogglePhotoMode] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 53,
      _y1 = 1,
      _x2 = 103,
      _y2 = 51
    },
    [Type.ConsoleUIOffset] = {
      _path = "Renewal/Function/Console_Function_RingMenu_02.dds",
      _x1 = 105,
      _y1 = 1,
      _x2 = 155,
      _y2 = 51
    },
    [Type.LifeRanking] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 207,
      _y1 = 53,
      _x2 = 257,
      _y2 = 103
    },
    [Type.HorseInfo] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 156,
      _y1 = 1,
      _x2 = 206,
      _y2 = 51
    },
    [Type.Fairy] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 257,
      _x2 = 102,
      _y2 = 307
    },
    [Type.PersonalMonster] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 257,
      _x2 = 153,
      _y2 = 307
    },
    [Type.GuildPing] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 309,
      _y1 = 1,
      _x2 = 359,
      _y2 = 51
    },
    [Type.PartyPing] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 258,
      _y1 = 1,
      _x2 = 308,
      _y2 = 51
    },
    [Type.BloodAltar] = {
      _path = "Renewal/UI_Icon/Console_ESCMenuIcon.dds",
      _x1 = 285,
      _y1 = 287,
      _x2 = 342,
      _y2 = 342
    },
    [Type.BloodAltarRanking] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 257,
      _x2 = 204,
      _y2 = 307
    },
    [Type.PlatoonSetting] = {
      _path = "Renewal/UI_Icon/XboxConsole_Icon_Title.dds",
      _x1 = 457,
      _y1 = 344,
      _x2 = 512,
      _y2 = 399
    },
    [Type.UseAlchemyStone] = {
      _path = "Renewal/UI_Icon/XboxConsole_Icon_Title.dds",
      _x1 = 457,
      _y1 = 2,
      _x2 = 512,
      _y2 = 57
    },
    [Type.RestoreItem] = {
      _path = "Renewal/Function/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 52,
      _x2 = 51,
      _y2 = 102
    },
    [Type.GuildStableList] = {
      _path = "Renewal/Button/Console_Btn_Main.dds",
      _x1 = 105,
      _y1 = 53,
      _x2 = 156,
      _y2 = 104
    },
    [Type.MasterpieceAuction] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 206,
      _x2 = 153,
      _y2 = 256
    },
    [Type.BattleGroundPvP] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 155,
      _x2 = 357,
      _y2 = 205
    },
    [Type.ToggleWalkingMode] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 52,
      _x2 = 153,
      _y2 = 102
    },
    [Type.News] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 104,
      _x2 = 306,
      _y2 = 154
    },
    [Type.HotKey] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 257,
      _x2 = 306,
      _y2 = 307
    },
    [Type.Beauty] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 309,
      _y1 = 53,
      _x2 = 359,
      _y2 = 103
    },
    [Type.Escape] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 104,
      _x2 = 51,
      _y2 = 154
    },
    [Type.BlackSpiritRage] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 104,
      _x2 = 102,
      _y2 = 154
    },
    [Type.BuffList] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 257,
      _x2 = 357,
      _y2 = 307
    },
    [Type.BlackSpiritSafe] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 104,
      _x2 = 204,
      _y2 = 154
    },
    [Type.AttendanceReward] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 104,
      _x2 = 255,
      _y2 = 154
    },
    [Type.ExchangeCoinSystem] = {
      _path = "Combine/Icon/Combine_Title_Icon_00.dds",
      _x1 = 116,
      _y1 = 116,
      _x2 = 171,
      _y2 = 171
    },
    [Type.AdventureLogBookShelf] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 104,
      _x2 = 357,
      _y2 = 154
    },
    [Type.ItemDrop] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 155,
      _x2 = 51,
      _y2 = 205
    },
    [Type.BossNotification] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 155,
      _x2 = 102,
      _y2 = 205
    },
    [Type.TradeInfo] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 155,
      _x2 = 153,
      _y2 = 205
    },
    [Type.Alchemy] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 155,
      _x2 = 204,
      _y2 = 205
    },
    [Type.Totem] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 155,
      _x2 = 255,
      _y2 = 205
    },
    [Type.LifeRingMenu] = {
      _path = "Combine/Icon/Combine_Title_Icon_01.dds",
      _x1 = 114,
      _y1 = 450,
      _x2 = 169,
      _y2 = 505
    },
    [Type.RedBattleField] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 155,
      _x2 = 306,
      _y2 = 205
    },
    [Type.BattleArena] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 155,
      _x2 = 357,
      _y2 = 205
    },
    [Type.ArenaOfArsha] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 206,
      _x2 = 51,
      _y2 = 256
    },
    [Type.PitOfTheUndying] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 206,
      _x2 = 102,
      _y2 = 256
    },
    [Type.FindParty] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 1,
      _y1 = 394,
      _x2 = 51,
      _y2 = 444
    },
    [Type.ChatGroup] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 206,
      _x2 = 204,
      _y2 = 256
    },
    [Type.Setting] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 206,
      _x2 = 255,
      _y2 = 256
    },
    [Type.EditUI] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 206,
      _x2 = 306,
      _y2 = 256
    },
    [Type.Disconnect] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 206,
      _x2 = 357,
      _y2 = 256
    },
    [Type.ServerSwitch] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 257,
      _x2 = 51,
      _y2 = 307
    },
    [Type.OldMoonGrandPrix] = {
      _path = "Combine/Icon/Combine_Title_Icon_01.dds",
      _x1 = 506,
      _y1 = 58,
      _x2 = 561,
      _y2 = 113
    },
    [Type.EmergencyEvade] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 308,
      _x2 = 102,
      _y2 = 358
    },
    [Type.BarterInfo] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 308,
      _x2 = 153,
      _y2 = 358
    },
    [Type.SeasonPass] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 308,
      _x2 = 204,
      _y2 = 358
    },
    [Type.GrowthPass] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 308,
      _x2 = 255,
      _y2 = 358
    },
    [Type.MajorSiegeArea] = {
      _path = "Combine/Console/Console_Function_RingMenu_01.dds",
      _x1 = 256,
      _y1 = 241,
      _x2 = 306,
      _y2 = 291
    },
    [Type.OptiomizeMemory] = {
      _path = "Renewal/Function/Console_Function_RingMenu_02.dds",
      _x1 = 105,
      _y1 = 52,
      _x2 = 155,
      _y2 = 102
    },
    [Type.PingType] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 359,
      _x2 = 51,
      _y2 = 409
    },
    [Type.PersonalFieldList] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 359,
      _x2 = 102,
      _y2 = 409
    },
    [Type.TotalSearchItem] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 359,
      _x2 = 204,
      _y2 = 409
    },
    [Type.HadumFieldEnter] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 205,
      _y1 = 359,
      _x2 = 255,
      _y2 = 409
    },
    [Type.ItemAddPercentBuff] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 359,
      _x2 = 153,
      _y2 = 409
    },
    [Type.FairyAutoBuff] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 359,
      _x2 = 306,
      _y2 = 409
    },
    [Type.DailySpecial] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 307,
      _y1 = 359,
      _x2 = 357,
      _y2 = 409
    },
    [Type.MonsterBuffZoneOff] = {
      _path = "Combine/Icon/Combine_Title_Icon_01.dds",
      _x1 = 450,
      _y1 = 338,
      _x2 = 505,
      _y2 = 393
    },
    [Type.CrogdaloStable] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 358,
      _y1 = 308,
      _x2 = 408,
      _y2 = 358
    },
    [Type.AgrisGaugeOnOff] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 360,
      _y1 = 53,
      _x2 = 410,
      _y2 = 103
    },
    [Type.CollectInteractionOnOff] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 358,
      _y1 = 206,
      _x2 = 408,
      _y2 = 256
    },
    [Type.MoveToWharf] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 358,
      _y1 = 359,
      _x2 = 408,
      _y2 = 409
    },
    [Type.JewelPreset] = {
      _path = "Combine/Icon/Combine_Title_Icon_01.dds",
      _x1 = 562,
      _y1 = 282,
      _x2 = 617,
      _y2 = 337
    },
    [Type.EmployeeAutoFishingDiscard] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 1,
      _y1 = 410,
      _x2 = 51,
      _y2 = 460
    },
    [Type.EdanaMainUI] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 52,
      _y1 = 410,
      _x2 = 102,
      _y2 = 460
    },
    [Type.AdventureJournal] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 154,
      _y1 = 410,
      _x2 = 204,
      _y2 = 460
    },
    [Type.LandscapePainting] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 103,
      _y1 = 410,
      _x2 = 153,
      _y2 = 460
    },
    [Type.ReforgeStonePreset] = {
      _path = "Combine/Console/Console_Function_RingMenu_02.dds",
      _x1 = 256,
      _y1 = 410,
      _x2 = 306,
      _y2 = 460
    }
  }
}
if true == ToClient_isConsole() and false == ToClient_isXBox() then
  PaGlobal_ConsoleQuickMenu._functionTypeList._icon[__eQuickMenuDataType_Function][Type.HotKey] = {
    _path = "Combine/Console/#PS#Console_Function_RingMenu_02.dds",
    _x1 = 256,
    _y1 = 257,
    _x2 = 306,
    _y2 = 307
  }
end
PaGlobal_ConsoleQuickMenu._functionTypeList._ToggleData = {
  [__eQuickMenuDataType_Function] = {
    [Type.AgrisGaugeOnOff] = function()
      if getSelfPlayer():get():getIsUseFeverSkill() == true then
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_FEVERPOINT_OFF"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 360,
          _y1 = 53,
          _x2 = 410,
          _y2 = 103
        }
      else
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_FEVERPOINT_ON"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 358,
          _y1 = 155,
          _x2 = 408,
          _y2 = 205
        }
      end
    end,
    [Type.CollectInteractionOnOff] = function()
      if ToClient_getGameOptionControllerWrapper():getShowCollectInteractionUI() == true then
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_COLLECTINTERACTION_OFF"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 358,
          _y1 = 206,
          _x2 = 408,
          _y2 = 256
        }
      else
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_COLLECTINTERACTION_ON"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 358,
          _y1 = 257,
          _x2 = 408,
          _y2 = 307
        }
      end
    end,
    [Type.LandscapePainting] = function()
      if ToClient_getLandScapePaintingTotalSwitch() == true then
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_LANDSCAPEPAINTING_OFF"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 103,
          _y1 = 410,
          _x2 = 153,
          _y2 = 460
        }
      else
        return {
          _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_LANDSCAPEPAINTING_ON"),
          _path = "Combine/Console/Console_Function_RingMenu_02.dds",
          _x1 = 205,
          _y1 = 410,
          _x2 = 255,
          _y2 = 460
        }
      end
    end
  }
}
PaGlobal_ConsoleQuickMenu._functionTypeList._name = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BAG"),
    [Type.BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BLACKSPIRIT"),
    [Type.WorldMap] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_WORLDMAP"),
    [Type.Skill] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_SKILL"),
    [Type.Mail] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MAIL"),
    [Type.CharacterChallange] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_DAILYCHALLENGE_TITLE"),
    [Type.ItemMarket] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_ITEMMARKET"),
    [Type.Quest] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_QUESTHISTORY"),
    [Type.ServantCall] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_CALLMOUNT"),
    [Type.ServantNavi] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_FINDMOUNT"),
    [Type.CampActivate] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_TITLE"),
    [Type.CampNavi] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_FINDCAMP"),
    [Type.HorseRaceInformation] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_AlertHorseRace"),
    [Type.HorseRaceEnterOrCancel] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_REGISTER_BTN"),
    [Type.ResidenceList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSINGLIST_STCTXT_TITLE"),
    [Type.WorkerList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_UiWorker"),
    [Type.GardenList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HARVESTLIST_TITLE"),
    [Type.PetList] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_PET"),
    [Type.MaidList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_TITLE"),
    [Type.TagSetting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_TITLE"),
    [Type.Tag] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SETTING_TAG"),
    [Type.NpcFind] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NPCNAVI_NPCNAVITEXT"),
    [Type.MovieGuide] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MOVIEGUIDE_TITLE"),
    [Type.VillageSiegeArea] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_TOGGLESIEGEAREAGUIDE"),
    [Type.Pvp] = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_13"),
    [Type.RingMenuSetting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_RINGMENUSETTING"),
    [Type.Profile] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MYINFO"),
    [Type.VoiceChat] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_GAME_VOICECHAT"),
    [Type.Knowledge] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MENTALKNOWLEDGE"),
    [Type.WharfNavi] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_FINDSHIP"),
    [Type.Guild] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_GUILD"),
    [Type.Friend] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_FRIENDLIST"),
    [Type.PearlShop] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_CASHSHOP"),
    [Type.PartySetting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TITLE"),
    [Type.BeautyAlbum] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BEAUTYALBUM"),
    [Type.PhotoGallery] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SCREENSHOTALBUM_TITLE"),
    [Type.ProductNote] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRODUCTNOTE_TITLE"),
    [Type.GuildRank] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_GUILDRANKER"),
    [Type.BlackSpiritAdventure] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BLACKSPIRIT_TRESURE"),
    [Type.Manufacture] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_MANUFACTURE"),
    [Type.TogglePVP] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_TOGGLEPVP"),
    [Type.PearInven] = PAGetString(Defines.StringSheet_RESOURCE, "UI_INVENTORY_BTN_CASHINVENTORY"),
    [Type.Dyeing] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_DYE"),
    [Type.ToggleChatting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_TOGGLECHATTING"),
    [Type.GuildWarInfo] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BTN_SIEGE"),
    [Type.TogglePhotoMode] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_TOGGLEPHOTOMODE"),
    [Type.ConsoleUIOffset] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CONSOLEUIOFFSET"),
    [Type.LifeRanking] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERANKING_TITLE"),
    [Type.HorseInfo] = PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_TITLE"),
    [Type.Fairy] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_INFO_TITLE"),
    [Type.PersonalMonster] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALMONSTER_TITLE"),
    [Type.GuildPing] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RINGMENU_GUILDPING"),
    [Type.PartyPing] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RINGMENU_PARTYPING"),
    [Type.BloodAltar] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BLOODALTAR_TITLE"),
    [Type.BloodAltarRanking] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALTARRANKWEB_TITLE"),
    [Type.PlatoonSetting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LARGEPARTYSETTING_TITLE"),
    [Type.UseAlchemyStone] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_INTERFACE_ACTION_U"),
    [Type.RestoreItem] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_RECOVERYITEM_TITLE"),
    [Type.GuildStableList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSERVANTLIST_TITLE"),
    [Type.MasterpieceAuction] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECEAUCTION_TITLE"),
    [Type.BattleGroundPvP] = PAGetString(Defines.StringSheet_GAME, "LUA_1ON1ARENA_TOOLTIP_NAME"),
    [Type.ToggleWalkingMode] = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_43"),
    [Type.News] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_NEWS_TITLE"),
    [Type.HotKey] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_KEYGUIDE_TITLE"),
    [Type.Beauty] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BEAUTY"),
    [Type.Escape] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ESCAPE"),
    [Type.BlackSpiritRage] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKSPIRITLOCK_TITLE"),
    [Type.BuffList] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BUFF"),
    [Type.BlackSpiritSafe] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TOTAL_REWARD"),
    [Type.AttendanceReward] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DAILYSTAMP"),
    [Type.ExchangeCoinSystem] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXCHANGECOIN_TITLE"),
    [Type.AdventureLogBookShelf] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ACHIEVEMENT_BOOKSHELF"),
    [Type.ItemDrop] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DROPITEM"),
    [Type.BossNotification] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BOSS_ALERT"),
    [Type.TradeInfo] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TRADEMARKET"),
    [Type.Alchemy] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_TITLE"),
    [Type.Totem] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_TOTEMBUTTON"),
    [Type.LifeRingMenu] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_LIFERINGMENU"),
    [Type.RedBattleField] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_LOCALWAR"),
    [Type.BattleArena] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FREEFIGHT"),
    [Type.ArenaOfArsha] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_COMPETITION"),
    [Type.PitOfTheUndying] = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
    [Type.FindParty] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FIND_PARTY"),
    [Type.ChatGroup] = PAGetString(Defines.StringSheet_GAME, "CHATTING_CHANNEL"),
    [Type.Setting] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_OPTION"),
    [Type.EditUI] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_INTERFACE_EDIT"),
    [Type.Disconnect] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_GAMEEND"),
    [Type.ServerSwitch] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_CHANGESERVER"),
    [Type.OldMoonGrandPrix] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSERACING_TITLE"),
    [Type.EmergencyEvade] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_ActionServantOrder4"),
    [Type.BarterInfo] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_TITLE"),
    [Type.SeasonPass] = PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITPASS_TOOLTIP_TITLE"),
    [Type.GrowthPass] = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_GROWTHPASS_TITLE"),
    [Type.MajorSiegeArea] = PAGetString(Defines.StringSheet_GAME, "LUA_MAJORSEIGE_CONSOLEAREABUTTON"),
    [Type.OptiomizeMemory] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MEMORY_TITLE"),
    [Type.PingType] = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_GUILD_PINGTYPE_SELECT"),
    [Type.PersonalFieldList] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_TITLE"),
    [Type.TotalSearchItem] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TITLE"),
    [Type.HadumFieldEnter] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELVIA_ENTER_TITLE"),
    [Type.ItemAddPercentBuff] = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    [Type.FairyAutoBuff] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_AUTOBUFF_TITLE"),
    [Type.DailySpecial] = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALREWARD_CATEGORY_23"),
    [Type.MonsterBuffZoneOff] = PAGetString(Defines.StringSheet_GAME, "LUA_DEKIA_SUMMONOFF_MSGTITLE"),
    [Type.CrogdaloStable] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_TREASURETOOLTIP"),
    [Type.AgrisGaugeOnOff] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_FEVERPOINT_TITLE"),
    [Type.CollectInteractionOnOff] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_COLLECTINTERACTION_TITLE"),
    [Type.MoveToWharf] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_UiMoveToWharf"),
    [Type.JewelPreset] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_SOCKET_TITLE"),
    [Type.EmployeeAutoFishingDiscard] = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_REMOVEGRADE_SELECT"),
    [Type.EdanaMainUI] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_RINGMENUEDANIA"),
    [Type.AdventureJournal] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_TITLE", "charName", "[" .. getSelfPlayer():getName() .. "]"),
    [Type.LandscapePainting] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CONSOLE_LANDSCAPEPAINTING_TITLE"),
    [Type.ReforgeStonePreset] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_PRESETTITLE")
  }
}
PaGlobal_ConsoleQuickMenu._functionTypeList._ContentOption = {
  [__eQuickMenuDataType_Function] = {
    [Type.Inventory] = true,
    [Type.BlackSpirit] = true,
    [Type.WorldMap] = true,
    [Type.Skill] = true,
    [Type.Mail] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.CharacterChallange] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ItemMarket] = ToClient_HardCoreChannelWithContensOption() == false and (true == _ContentsGroup_RenewUI or _ContentsGroup_RenewUI_ItemMarketPlace),
    [Type.Quest] = true,
    [Type.ServantCall] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ServantNavi] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.CampActivate] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.CampNavi] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.HorseRaceInformation] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.HorseRaceEnterOrCancel] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ResidenceList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.WorkerList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.GardenList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PetList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MaidList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.TagSetting] = _ContentsGroup_CharacterTag and _ContentsGroup_UsePadSnapping and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Tag] = _ContentsGroup_CharacterTag and _ContentsGroup_UsePadSnapping and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.NpcFind] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MovieGuide] = false,
    [Type.VillageSiegeArea] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Pvp] = false,
    [Type.RingMenuSetting] = true,
    [Type.Profile] = true,
    [Type.VoiceChat] = not _ContentsGroup_isPS4UI and _ContentsOption_CH_VoiceChat ~= true and not ToClient_isXBoxSeries() and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Knowledge] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.WharfNavi] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Guild] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Friend] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PearlShop] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PartySetting] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BeautyAlbum] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PhotoGallery] = false,
    [Type.ProductNote] = _ContentsGroup_ProductNote and false == isGameTypeGT(),
    [Type.GuildRank] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BlackSpiritAdventure] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Manufacture] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.TogglePVP] = true,
    [Type.PearInven] = true,
    [Type.Dyeing] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ToggleChatting] = _ContentsGroup_RenewUI,
    [Type.GuildWarInfo] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.TogglePhotoMode] = _ContentsGroup_RenewUI and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ConsoleUIOffset] = _ContentsGroup_ConsoleUIResize,
    [Type.LifeRanking] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.HorseInfo] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Fairy] = _ContentsGroup_isFairy and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PersonalMonster] = _ContentsGroup_Console_PersonalMonster and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.GuildPing] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PartyPing] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BloodAltar] = false,
    [Type.BloodAltarRanking] = _ContentsGroup_Console_BloodAltarRanking and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PlatoonSetting] = _ContentsGroup_LargeParty and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.UseAlchemyStone] = _ContentsGroup_AlchemyStone and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.RestoreItem] = _ContentsGroup_RestoreItem and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.GuildStableList] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MasterpieceAuction] = _ContenstGroup_MasterpieceAuction and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BattleGroundPvP] = _ContentsGroup_BattleGroundPvP and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ToggleWalkingMode] = true,
    [Type.News] = _ContentsGroup_RenewUI,
    [Type.HotKey] = _ContentsGroup_RenewUI,
    [Type.Beauty] = CppEnums.ContentsServiceType.eContentsServiceType_Commercial == getContentsServiceType() and false == isGameTypeGT() and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Escape] = false,
    [Type.BlackSpiritRage] = _ContentsGroup_NewUI_BlackSpiritSkillLock_All and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BuffList] = _ContentsGroup_UsePadSnapping,
    [Type.BlackSpiritSafe] = _ContentsGroup_TotalReward and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.AttendanceReward] = ToClient_IsContentsGroupOpen("1025") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ExchangeCoinSystem] = _ContentsGroup_ExchangeCoinSystem and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.AdventureLogBookShelf] = _ContentsGroup_AchievementQuest and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ItemDrop] = ToClient_IsContentsGroupOpen("337") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BossNotification] = _ContetnsGroup_BossAlert and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.TradeInfo] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Alchemy] = ToClient_IsContentsGroupOpen("35") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Totem] = ToClient_IsContentsGroupOpen("44") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.LifeRingMenu] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.RedBattleField] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.BattleArena] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ArenaOfArsha] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PitOfTheUndying] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.FindParty] = ToClient_IsContentsGroupOpen("254") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ChatGroup] = ToClient_IsContentsGroupOpen("600") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.Setting] = true,
    [Type.EditUI] = true,
    [Type.Disconnect] = false,
    [Type.ServerSwitch] = false,
    [Type.OldMoonGrandPrix] = false and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.EmergencyEvade] = true,
    [Type.BarterInfo] = ToClient_IsContentsGroupOpen("504") and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.SeasonPass] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.GrowthPass] = _ContentsGroup_GrowthPass and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MajorSiegeArea] = _ContentsGroup_ShowMajorSiegeArea and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.OptiomizeMemory] = ToClient_isTotalGameClient(),
    [Type.PingType] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.PersonalFieldList] = _ContentsGroup_PersonalField and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.TotalSearchItem] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.HadumFieldEnter] = _ContentsGroup_HadumField and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ItemAddPercentBuff] = _ContentsGroup_HopeGauge and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.FairyAutoBuff] = _ContentsGroup_ForthTierFairyFiftyLevel and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.DailySpecial] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MonsterBuffZoneOff] = _ContentsGroup_MonsterBuffZone and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.CrogdaloStable] = _ContentsGroup_Crogdalo and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.AgrisGaugeOnOff] = _ContentsGroup_FeverBuff and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.CollectInteractionOnOff] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.MoveToWharf] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.JewelPreset] = ToClient_HardCoreChannelWithContensOption() == false,
    [Type.EmployeeAutoFishingDiscard] = _ContentsGroup_EmployeeAutoFishingDiscard == true,
    [Type.EdanaMainUI] = true,
    [Type.AdventureJournal] = true,
    [Type.LandscapePainting] = _ContentsGroup_LandscapePainting and ToClient_HardCoreChannelWithContensOption() == false,
    [Type.ReforgeStonePreset] = _ContentsGroup_ReforgeStonePreset and ToClient_HardCoreChannelWithContensOption() == false
  }
}
function varify()
  for type, index in pairs(Type) do
    local func = PaGlobal_ConsoleQuickMenu._functionTypeList._ExecuteFunction[__eQuickMenuDataType_Function]
    local icon = PaGlobal_ConsoleQuickMenu._functionTypeList._icon[__eQuickMenuDataType_Function]
    local name = PaGlobal_ConsoleQuickMenu._functionTypeList._name[__eQuickMenuDataType_Function]
    _PA_ASSERT(func, "\235\167\129\235\169\148\235\137\180\236\151\144 \235\169\148\235\137\180\237\131\128\236\158\133 Function \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. type : " .. tostring(type))
    _PA_ASSERT(icon, "\235\167\129\235\169\148\235\137\180\236\151\144 \235\169\148\235\137\180\237\131\128\236\158\133 icon \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. type : " .. tostring(type))
    _PA_ASSERT(name, "\235\167\129\235\169\148\235\137\180\236\151\144 \235\169\148\235\137\180\237\131\128\236\158\133 name \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. type : " .. tostring(type))
  end
end
function PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute(datatype, functionType)
  if _ContentsGroup_ProjectAbyssOne == false then
    return true
  end
  if ToClient_isInAbyssOne() == false then
    return true
  end
  if datatype == nil or functionType == nil then
    return false
  end
  if datatype == __eQuickMenuDataType_Item then
    return false
  end
  if datatype == __eQuickMenuDataType_SocialAction or datatype == __eQuickMenuDataType_Skill or datatype == __eQuickMenuDataType_GuildSkill then
    return true
  end
  local dataTypeCheckList = PaGlobal_ConsoleQuickMenu._functionTypeList._CheckAbyssOneExecute[datatype]
  if dataTypeCheckList == nil then
    return false
  end
  local checkAbyssOneExecute = dataTypeCheckList[functionType]
  if checkAbyssOneExecute == nil then
    return false
  end
  return checkAbyssOneExecute
end
function PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute(dataType, functionType)
  if dataType == nil or functionType == nil then
    return false
  end
  if dataType == __eQuickMenuDataType_Item then
    return true
  elseif dataType == __eQuickMenuDataType_Skill then
    return true
  elseif dataType == __eQuickMenuDataType_Function then
    local useFunctionList = PaGlobal_ConsoleQuickMenu._functionTypeList._CheckSequencePlayerControlExecute[__eQuickMenuDataType_Function]
    if useFunctionList == nil then
      return false
    end
    local isUseFunctionType = useFunctionList[functionType]
    if isUseFunctionType == nil or isUseFunctionType == false then
      return false
    end
    return true
  else
    return false
  end
end
function FromClient_ConsoleQuickMenu_ExecuteFunctionType(datatype, functionType)
  if __eQuickMenuDataType_Function ~= datatype then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode ~= Defines.UIMode.eUIMode_Default and currentUIMode ~= Defines.UIMode.eUIMode_SequencePlayerControl then
    return
  end
  if currentUIMode == Defines.UIMode.eUIMode_SequencePlayerControl and ToClient_isPlayingSequence() == false then
    return
  end
  if _ContentsGroup_ProjectAbyssOne == true and PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute(datatype, functionType) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if currentUIMode == Defines.UIMode.eUIMode_SequencePlayerControl and ToClient_isPlayingSequence() == true and PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute(datatype, functionType) == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  local executeFunc = PaGlobal_ConsoleQuickMenu._functionTypeList._ExecuteFunction[datatype][functionType]
  if nil == executeFunc then
    _PA_LOG("\237\155\132\236\167\132", "[ConsoleQuickMenu] QuickMenu.functionType \236\151\144 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\156\188\235\169\180 PaGlobal_ConsoleQuickMenu._functionTypeList._ExecuteFunction \236\151\144 \236\182\148\234\176\128\237\149\180 \236\163\188\236\132\184\236\154\148  ")
    return
  end
  executeFunc()
end
registerEvent("FromClient_ConsoleQuickMenu_ExecuteFunctionType", "FromClient_ConsoleQuickMenu_ExecuteFunctionType")
registerEvent("FromClient_CompleteOptimizeMemory", "FromClient_CompleteOptimizeMemory_QuickMenu")
function PaGlobal_ConsoleQuickMenu:widgetOpen(invisibleOnly)
  ToClient_setAvailableInputWidget(true)
  if true == _ContentsGroup_RenewUI then
    if 0 ~= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleQuickMenu, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      Panel_Widget_QuickMenu:SetShow(true)
    else
      Panel_Widget_QuickMenu:SetShow(false)
      return
    end
  elseif true == _ContentsGroup_UsePadSnapping then
    Panel_Widget_QuickMenu:SetShow(true)
  end
  PaGlobal_ConsoleQuickMenu._widgetForceClose = false
  PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(true)
end
function PaGlobal_ConsoleQuickMenu:widgetClose(invisibleOnly)
  PaGlobal_ConsoleQuickMenu._widgetForceClose = true
  PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(false)
  if true == invisibleOnly then
    return
  end
  ToClient_setAvailableInputWidget(false)
end
function FromClient_CompleteOptimizeMemory_QuickMenu()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MEMORY_POPUP_DESC"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ConsoleQuickMenu:setDefaultSetting()
  ToClient_setDefaultQuickMenu()
end
