function HandleEventLUp_MenuRemake_HeadMenu(headermenuIndex)
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:headMenu_select(headermenuIndex)
end
function HandleEventLUp_MenuRemake_Menu(menuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:menu_select(menuIndex)
end
function HandleEventLUp_MenuRemake_subMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:submenu_select(submenuIndex)
end
function HandleEventRUp_MenuRemake_setSubMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setToggle(submenuIndex)
end
function HandleEventLUp_Menu_RecentSubMenuFixed()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuFixed()
  if true == ToClient_isConsole() then
    ToClient_saveUserCache()
  end
end
function HandleEventLUp_Menu_RecentSubMenuUnFixed()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuUnFixed()
  if true == ToClient_isConsole() then
    ToClient_saveUserCache()
  end
end
function HandleEventLUp_Menu_RecentSubMenuDeleted()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuDelete(PaGlobal_Menu_Remake._recentSubMenuIdx)
  PaGlobal_Menu_Remake:updateRecentMenu()
  if true == ToClient_isConsole() then
    ToClient_saveUserCache()
  end
end
function HandleEventPadOnOut_Menu_RecentSubMenuOn(isOn)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if true == isOn then
    PaGlobal_Menu_Remake._nowMenuMode = "recentmenu"
  end
end
function HandleEventLUp_MenuRemake_searchText()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:selected_searchText()
end
function HandleEventPad_MenuRemake_searchText(str)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._ui.edit_searchTxt:SetEditText(str)
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:searchingMenu()
end
function HandleEventLUp_MenuRemake_ChangeCustomizeMode()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:menuCustomize_toggle()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake:headMenu_toggle(1)
    PaGlobal_Menu_Remake:AlignkeyGuide()
  end
end
function HandleEventLUp_MenuRemake_ChangeOpenWay()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    if true == PaGlobal_Menu_Remake._isCustomizeMode then
      return
    end
    if true == ToClient_isConsole() then
      local leftSecond = getLeftSecond_TTime64(PaGlobal_Menu_Remake._consoleChangeOptionTime)
      if leftSecond > toInt64(0, 0) then
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CANCHANGEOPTION_COOLTIME", "sec", tostring(leftSecond)))
        return
      else
        local cooltime = toInt64(0, 10)
        PaGlobal_Menu_Remake._consoleChangeOptionTime = getServerUtc64() + cooltime
      end
    end
    PaGlobal_Menu_Remake._nowMenuMode = "changeWay"
  end
  PaGlobal_Menu_Remake:setMenuOpenWay()
end
function HandleEventLUp_MenuRemake_Commit()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and false == PaGlobal_Menu_Remake._isCustomizeMode then
    return
  end
  PaGlobal_Menu_Remake:headmenuCustomize_confirm()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake:headMenu_toggle(1)
    PaGlobal_Menu_Remake:AlignkeyGuide()
  end
  if PaGlobal_Menu_Remake._isLeft == (0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay)) then
    PaGlobal_Menu_Remake:prepareOpen()
  end
end
function HandleEventLUp_MenuRemake_Cancel()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:headmenuCustomize_cancel()
end
function HandleEventLUp_MenuRemake_SearchingMenu(searchMenuIndex)
  PaGlobal_Menu_Remake:searchMenu_select(searchMenuIndex)
end
function HandleEventOn_MenuRemake_SearchingMenu(searchMenuIndex)
  PaGlobal_Menu_Remake:searchMenu_toggle(searchMenuIndex, true)
end
function HandleEventOn_MenuRemake_ChangeUi()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showChangeUiToolTip()
end
function HandleEventOn_MenuRemake_ChangeOpenWay()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showOpenWayToolTip()
end
function HandleEventOn_MenuRemake_ChangeCustomizeMode()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showCustomizeToolTip()
end
function HandleEventOn_MenuRemake_HeadMenu(headermenuIndex)
  if nil == headermenuIndex then
    return
  end
  PaGlobal_Menu_Remake:headMenu_toggle(headermenuIndex)
end
function HandleEventOn_MenuRemake_Menu(menuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:menu_toggle(menuIndex, true)
end
function HandleEventOn_MenuRemake_subMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:submenu_toggle(submenuIndex, true)
end
function HandleEventOut_MenuRemake_subMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:submenu_toggle(submenuIndex, false)
end
function HandleEventOut_MenuRemake_HeadMenu(headermenuIndex)
  if nil == headermenuIndex then
    return
  end
  PaGlobal_Menu_Remake:resetHeadMenuTitle(headermenuIndex)
end
function HandleEventKeyBoard_MenuRemake_KeyPushCheck()
  if nil == Panel_Widget_Menu_Remake or false == PaGlobal_Menu_Remake_GetShow() then
    return true
  end
  if _ContentsGroup_UsePadSnapping == false and PaGlobal_Menu_Remake:checkPressedHotKey() == true then
    return false
  end
  return true
end
function HandleEventKeyBoard_MenuRemake_arrowKey(keycode)
  if nil == keycode then
    return
  end
  PaGlobal_Menu_Remake:pressedArrowKey(keycode)
end
function HandleEventKeyBoard_MenuRemake_searchingMenu()
  if nil == Panel_Widget_Menu_Remake then
    return false
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:searchingMenu()
end
function HandleEventLUp_MenuRemake_Escape()
  if ToClient_IsMyselfInArena() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_COMMON_ARLERT"))
    return
  elseif true == ToClient_getJoinGuildBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
    return
  elseif true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACE_CANT_ESCESCAPE"))
    return
  elseif ToClient_IsEmergencyAvoid() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWhileEmergencyAvoid"))
    return
  end
  HandleClicked_RescueConfirm()
end
function HandleEventLUp_MenuRemake_BlackDesertLab()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if player:get():getLevel() < 56 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEVEL_LIMITED_GLOBAL_LABS"))
    return
  end
  if _ContentsGroup_GT_Copy == false and true == ToClient_isCompleteTesterSubmit() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALREADY_TESTER_SUBMIT"))
    return
  end
  PaGlobal_BlackDesertLab_Show()
end
function HandleEventLUp_MenuRemake_Market()
  FGlobal_ItemMarket_Open_ForWorldMap(1, true)
  audioPostEvent_SystemUi(1, 30)
end
function HandleEventLUp_MenuRemake_Localwar()
  if true == _ContentsGroup_InstanceLocalWar then
    PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
  else
    PaGlobal_LocalWarInfo_All_ESCMenuFunc()
  end
end
function HandleEventLUp_MenuRemake_FreeFight()
  FGlobal_FreeFight_ESCMenuFunc()
end
function HandleEventLUp_MenuRemake_Competitiongame()
  PaGlobaFunc_Arsha_Reservation_All_ESCMenuFunc()
end
function HandleEventLUp_MenuRemake_Siege()
  PaGlobalFunc_GuildWarInfo_All_Open()
end
function HandleEventLUp_MenuRemake_InfinityDefence()
  PaGlobal_HandleClicked_BloodAltar_Open()
end
function HandleEventLUp_MenuRemake_ArshaApplyWeb()
  if nil ~= Panel_Arsha_ApplyWeb_All and false == Panel_Arsha_ApplyWeb_All:GetShow() then
    PaGlobal_ArshaApplyWeb_All_Open()
  end
end
function HandleEventLUp_MenuRemake_Myinfo()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
end
function HandleEventLUp_MenuRemake_Inventory()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
end
function HandleEventLUp_MenuRemake_Skill()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
end
function HandleEventLUp_MenuRemake_Fairy()
  if true == _ContentsGroup_NewUI_Fairy_All then
    PaGlobal_FairyInfo_Open_All(false)
  else
    PaGlobal_FairyInfo_Open(false)
  end
end
function HandleEventLUp_MenuRemake_CashShop()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
end
function HandleEventLUp_MenuRemake_WorldMap()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_WorldMap)
end
function HandleEventLUp_MenuRemake_BlackSpirit()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
end
function HandleEventLUp_MenuRemake_QuestHistory()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_QuestHistory)
end
function HandleEventLUp_MenuRemake_FarmingList()
  if true == _ContentsGroup_FarmingList then
    PaGloabl_FarmingTimer_Open()
  end
end
function HandleEventLUp_MenuRemake_MentalKnowledge()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_MentalKnowledge)
end
function HandleEventLUp_MenuRemake_Present()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Present)
end
function HandleEventLUp_MenuRemake_Mail()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
end
function HandleEventLUp_MenuRemake_Manufacture()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Manufacture)
end
function HandleEventLUp_MenuRemake_Personalbattle()
  PaGlobal_PersonalBattle:open()
end
function HandleEventLUp_MenuRemake_Beauty()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_BeautyShop)
end
function HandleEventLUp_MenuRemake_Dyeing()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Dyeing)
end
function HandleEventLUp_MenuRemake_BeautyAlbum()
  ToClient_setEditableOptionTmp()
  FGlobal_CustomizingAlbum_Show(false, CppEnums.ClientSceneState.eClientSceneStateType_InGame)
end
function HandleEventLUp_MenuRemake_Notice()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    PaGlobal_Expirience_All._isNoticeTapOpen = true
    PaGlobal_ExpirienceWiki_All_Open()
  else
    EventNotify_Open(true, true)
  end
end
function HandleEventLUp_MenuRemake_Update()
  Panel_WebHelper_ShowToggle("Update")
end
function HandleEventLUp_MenuRemake_Event()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    Panel_EventNotify_All_Open(true, true)
  else
    EventNotify_Open(true, true)
  end
end
function HandleEventLUp_MenuRemake_KnownIssue()
  Panel_WebHelper_ShowToggle("KnownIssue")
end
function HandleEventLUp_MenuRemake_Camp()
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_Camp_All_Open()
  else
    PaGlobal_Camp:open()
  end
end
function HandleEventLUp_MenuRemake_OthilitaDungeon()
  if true == _ContentsGroup_OthilitaDungeon then
    HandleEventLUp_Widget_ThornCastle_Enter_Open()
  end
end
function HandleEventUp_MenuRemake_Mail()
  if true == _ContentsGroup_NewUI_Mail_All then
    PaGlobal_Window_Mail_All_WithRewardOpen(ToClient_isConsole())
  end
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
end
function HandleEventLUp_MenuRemake_ImmortalHell()
  if true == _ContentsGroup_isOepnImmortalHell or true == _ContentsGroup_isOpenImmortalHellForConsole then
    local selfProxy = getSelfPlayer()
    if nil == selfProxy then
      return true
    end
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if nil == regionInfo then
      return true
    end
    local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
    if true == isPVEArenaZone then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGOUT"),
        functionYes = ToClient_RequestLeaveImmortalHell,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      local EnterImmortalHell = function()
        ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_ImmortalHellTeleport, 0)
      end
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGDESC"),
        functionYes = EnterImmortalHell,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function FromClient_Menu_Remake_OnScreenResize()
  PaGlobal_Menu_Remake:resizeMenu()
end
function PaGlobalFunc_menu_All_termsofuse_Open()
  PaGlobal_PrivacyPolicy_Open(1, false)
end
function PaGlobalFunc_menu_All_PrivacyPolicy_Open()
  PaGlobal_PrivacyPolicy_Open(0, false)
end
function PaGlobalFunc_Menu_All_EURA_Open()
  PaGlobal_Copyright:open(1)
end
function PaGlobalFunc_Menu_All_Copyright_Open()
  if true == _ContentsGroup_RenewUI then
    PaGlobal_Copyright:open(0)
  else
    PaGlobal_Copyright_ShowWindow()
  end
end
function PaGlobalFunc_Menu_All_partySetting_Open()
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Normal)
end
function PaGlobalFunc_Menu_All_platoonSetting_Open()
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Large)
end
function PaGlobalFunc_Menu_All_BlackSpiritSkillLock_Open()
  PaGlobalFunc_BlackSpiritSkillLock_All_Open(3)
end
function PaGlobalFunc_Menu_All_AddRecentMenuBlackSpiritAdventure()
  local mainIndex, subIndex = PaGlobal_Menu_Remake:findMainIndex(28)
  PaGlobal_Menu_Remake:addRecentMenu(mainIndex, subIndex, false)
  PaGlobal_Menu_Remake:setRecentMenuInfo()
end
function PaGlobalFunc_menu_All_busterCall()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetGuildBustCallPos())
  if nil == regionInfoWrapper then
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetGuildBustCallTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_CONSOLE", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME"),
    content = descStr,
    functionYes = PaGlobalFunc_menu_All_BusterCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobalFunc_menu_All_BusterCallConfirm()
  ToClient_RequestTeleportGuildBustCall()
end
function PaGlobalFunc_menu_All_BusterCallCheck()
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetGuildBustCallTime()))
  return leftTime > 0
end
function PaGlobalFunc_menu_All_siegeWarCall()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportToSiegeTentPos())
  if nil == regionInfoWrapper then
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetTeleportToSiegeTentTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_CONSOLE", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME"),
    content = descStr,
    functionYes = PaGlobal_menu_All_SiegeWarCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_menu_All_SiegeWarCallConfirm()
  ToClient_RequestTeleportToSiegeTentCall()
end
function PaGlobalFunc_menu_All_SiegeWarCallCheck()
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetTeleportToSiegeTentTime()))
  if leftTime <= 0 then
    return false
  end
  local minorSiegeWrapper = ToClient_GetCurrentMinorSiegeWrapper()
  if nil ~= minorSiegeWrapper and false == minorSiegeWrapper:isSiegeBeing() then
    return false
  end
  return true
end
function PaGlobalFunc_menu_All_GMQuizCall()
  if false == _ContentsGroup_QuizEvent then
    return
  end
  ToClient_RequestQuizGameJoinOrUnJoin(true)
end
function PaGlobalFunc_menu_All_GMQuizCallCheck()
  if true == ToClient_IsJoinQuizGame() then
    return true
  end
  local remainTime = ToClient_GetRemainQuizBustCallTime()
  if remainTime < 0 then
    return true
  end
  return false
end
function PaGlobalFunc_menu_All_siegeWarReturnCall()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportFromSiegeTentPos())
  if nil == regionInfoWrapper then
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetTeleportFromSiegeTentTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_CONSOLE", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARRETURN_TOOLTIP_NAME"),
    content = descStr,
    functionYes = PaGlobal_menu_All_SiegeWarReturnCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_menu_All_SiegeWarReturnCallConfirm()
  ToClient_RequestTeleportFromSiegeTentReturn()
end
function PaGlobalFunc_menu_All_SiegeWarReturnCallCheck()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportFromSiegeTentPos())
  if nil == regionInfoWrapper then
    return false
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetTeleportFromSiegeTentTime()
  local leftTime = 0
  if nil ~= usableTime64 then
    leftTime = Int64toInt32(getLeftSecond_TTime64(usableTime64))
  end
  if leftTime <= 0 then
    return false
  end
  return true
end
function PaGlobal_menu_All_summonPartyCall()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local descStr = ""
  local partyLeaderName = ToClient_GetCharacterNameUseCompass()
  local usableTime64 = ToClient_GetLeftUsableTeleportCompassTime()
  if partyActorKey == playerActorKey then
    descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPASS_DESC_1", "remainTime", convertStringFromDatetime(usableTime64))
  else
    descStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WIDGET_COMPASS_MESSAGEBOXDESC", "partyName", partyLeaderName, "partyName1", partyLeaderName, "remainTime", convertStringFromDatetime(usableTime64))
  end
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMPASS_NAME"),
    content = descStr,
    functionYes = PaGlobal_menu_All_SummonPartyCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_menu_All_SummonPartyCallConfirm()
  local leftTime_s64 = ToClient_GetLeftUsableTeleportCompassTime()
  local leftTime = Int64toInt32(leftTime_s64)
  if leftTime > 0 then
    if IsSelfPlayerWaitAction() then
      ToClient_RequestTeleportPosUseCompass()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    end
  end
end
function PaGlobalFunc_menu_All_SummonPartyCallCheck()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local playerActorKey = selfPlayer:getActorKey()
  if partyActorKey == playerActorKey then
    return false
  else
    local partyMemeberCnt = RequestParty_getPartyMemberCount()
    if partyMemeberCnt > 0 then
      local leftTime = Int64toInt32(ToClient_GetLeftUsableTeleportCompassTime())
      return leftTime > 0
    end
  end
  return false
end
function PaGlobalFunc_menu_All_returnTown()
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  local regionName = ""
  if nil ~= regionInfo then
    regionName = regionInfo:getAreaName()
  end
  local returnTownRegionKey = ToClient_GetReturnStoneTownRegionKey()
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RETURNSTONE_DESC", "regionName", regionName, "remainTime", convertStringFromDatetime(usableTime64))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RETURNSTONE_NAME"),
    content = descStr,
    functionYes = PaGlobalFunc_menu_All_ReturnTownConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobalFunc_menu_All_ReturnTownConfirm()
  local remainTime_s64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(remainTime_s64)
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  if remainTime > 0 then
    if IsSelfPlayerWaitAction() then
      ToClient_RequestTeleportPosUseReturnStone()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    end
  end
end
function PaGlobalFunc_menu_All_ReturnTownCheck()
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(usableTime64)
  return remainTime > 0
end
function PaGlobalFunc_menu_All_SwitchHeaderMenu(isUp)
  if true == isUp then
    PaGlobal_Menu_Remake._startHeaderIndex = PaGlobal_Menu_Remake._startHeaderIndex + 1
  else
    PaGlobal_Menu_Remake._startHeaderIndex = PaGlobal_Menu_Remake._startHeaderIndex - 1
  end
  if PaGlobal_Menu_Remake._MAX_HEADERINDEX < PaGlobal_Menu_Remake._startHeaderIndex then
    PaGlobal_Menu_Remake._startHeaderIndex = 0
  elseif PaGlobal_Menu_Remake._startHeaderIndex < 0 then
    PaGlobal_Menu_Remake._startHeaderIndex = PaGlobal_Menu_Remake._MAX_HEADERINDEX
  end
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    uiManagerWrapper:setLuaCacheDataListNumber(__eMenuHeaderPage, PaGlobal_Menu_Remake._startHeaderIndex, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  PaGlobal_Menu_Remake:setHeaderHotKey()
end
function PaGlobalFunc_menu_All_OpenSeasonPass()
  PaGlobal_Menu_Remake:prepareClose()
  if nil ~= PaGlobalFunc_SeasonPassAndRoadMap_Open then
    PaGlobalFunc_SeasonPassAndRoadMap_Open()
  end
end
function HandleEventLUp_MenuRemake_YachtPvP()
  PaGlobal_Menu_Remake:prepareClose()
  if true == _ContentsGroup_MiniGame_YachtDice and nil ~= Panel_Window_MiniGame_YachtDice_PVP_Invite then
    PaGlobalFunc_MiniGameYacht_Invite_Open(nil)
  end
end
function HandleEventLUp_MenuRemake_GrowthPass()
  PaGlobal_Menu_Remake:prepareClose()
  if true == _ContentsGroup_GrowthPass then
    PaGlobalFunc_GrowthPass_Open()
  end
end
function HandleEventLUp_MenuRemake_ShowNakDisabledMenu()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_DISABLEDSUBMENU"))
end
function HandleEventLUp_MenuRemake_SolrareMatchingOpen()
  if _ContentsGroup_Solare == false then
    return
  end
  if ToClient_isPlayingSolareCustomMatch() == true then
    PaGlobalFunc_SolareCustom_Open()
  else
    PaGlobalFunc_SolareMain_Open()
  end
end
function HandleEventLUp_MenuRemake_SolrareRankingOpen()
  if _ContentsGroup_Solare == false then
    return
  end
  PaGlobalFunc_SolareRanking_Open()
end
function HandleEventLUp_MenuRemake_TubalaCupOpen()
  PaGlobal_Arsha_ApplyWeb_ForConsole_Open()
end
function HandleEventLUp_MenuRemake_TotalSearchOpen()
  if PaGlobalFunc_TotalSearch_Open ~= nil then
    PaGlobalFunc_TotalSearch_Open()
  end
end
function PaGlobal_HandleClicked_DragonDungeonHardVersion()
  local doJoin_dragonDungeon = function()
    ToClient_InstanceContentsJoin(__eInstanceContentsType_DragonDungeon, 0, __eInstanceDragonDungeon_HardVersionMapKey)
  end
  local doLeave_dragonDungeon = function()
    ToClient_UnJoinInstanceFieldForAll()
  end
  if ToClient_isInInstanceField(__eInstanceContentsType_DragonDungeon) == false then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    if selfPlayer:getLevel() < 56 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEVEL_LIMITED_GLOBAL_LABS"))
      return
    end
    if selfPlayer:hasParty() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MSG_ABYSSONE_ENTER_PARTY"))
      return
    end
    local hp = selfPlayer:getHp()
    local maxhp = selfPlayer:getMaxHp()
    if hp ~= maxhp then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
      return
    end
    if IsSelfPlayerWaitAction() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
      return
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ERETHEA_LIMBO"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_ERETHEA_LIMBO_JOIN_DESC"),
      functionYes = doJoin_dragonDungeon,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ERETHEA_LIMBO"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_ERETHEA_LIMBO_LEAVE_DESC"),
      functionYes = doLeave_dragonDungeon,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function TooltipSimple_Show_MenuRemake(subMenuIndex)
  if Panel_Widget_Menu_Remake == nil then
    return
  end
  PaGlobal_Menu_Remake:submenu_toggle(subMenuIndex, true)
  local control = PaGlobal_Menu_Remake._subMenuHotKeyGroup[subMenuIndex].radiobtn
  local title = PaGlobal_Menu_Remake._subMenuHotKeyGroup[subMenuIndex].title:GetText()
  TooltipSimple_Show(control, title, nil)
end
function TooltipSimple_Hide_MenuRemake(subMenuIndex)
  if Panel_Widget_Menu_Remake == nil then
    return
  end
  PaGlobal_Menu_Remake:submenu_toggle(subMenuIndex, false)
  TooltipSimple_Hide()
end
function HandleEventLUp_MenuRemake_ExitRelayMirrorField()
  if Panel_Widget_PersonalField_Mini == nil then
    return
  end
  local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
  if isEnterPersonalRelayField == false then
    return
  end
  if PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) == false then
    return
  end
  local leavePersonalRelayField = function()
    if PaGlobal_Widget_PersonalField_All_CheckChangeState(false, true) == false then
      return
    end
    ToClient_LeavePersonalRelayField()
    if Panel_Window_PersonalField_Main ~= nil and Panel_Window_PersonalField_Main:GetShow() == true and PaGlobal_PersonalField_Main_All_Close ~= nil then
      PaGlobal_PersonalField_Main_All_Close()
    end
  end
  local messageBoxData
  messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALRELAYFIELD_EXIT_MSG"),
    functionYes = leavePersonalRelayField,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if messageBoxData ~= nil then
    MessageBox.showMessageBox(messageBoxData)
  end
end
