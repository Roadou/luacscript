function PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildInfo()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.INFO
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildMember()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.LIST
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildQuestScale()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.GRADE
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_OpenByAllyInfo()
  PaGlobal_GuildFunctionPanel_All._openType = PaGlobal_GuildFunctionPanel_All._eOpenType.ALLYINFO
  PaGlobal_GuildFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_GuildFunctionPanel_All_Close()
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressGuildInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.leaveGuild then
    HandleEventLUp_GuildInfo_All_DismissGuild()
  elseif btnType == eFuncType.disperseGuild then
    HandleEventLUp_GuildInfo_All_DismissGuild()
  elseif btnType == eFuncType.guildMark then
    if true == ToClient_isConsole() then
      PaGlobalFunc_GuildChangeMark_All_Open()
    else
      HandleEventLUp_GuildInfo_All_ChangeGuildMark()
    end
  elseif btnType == eFuncType.guildIntro then
    if false == ToClient_isPS() then
      PaGlobalFunc_GuildIntroduce_Open()
    else
      PaGlobalFunc_GuildIntro_All_Open()
    end
  elseif btnType == eFuncType.guildNotice then
    HandleEventLUp_GuildInfo_All_SetFocusEdit()
  elseif btnType == eFuncType.declareWar then
    HandleEventLUp_GuildInfo_All_DeclareWar()
  elseif btnType == eFuncType.joinReward then
    HandleEventLUp_GuildMemberList_All_TakeSiegeReward()
  elseif btnType == eFuncType.joinMemberCount then
    HandleEventLUp_GuildInfo_All_IncreaseMember()
  elseif btnType == eFuncType.mandateMaster then
    HandleEventLUp_GuildInfo_All_GuildMasterMandateConfirmMSG()
  elseif btnType == eFuncType.guildWareHouse then
    HandleEventLUp_GuildInfo_All_RequestWareHouseOpen()
  elseif btnType == eFuncType.guildRentalWareHouse then
    HandleEventLUp_GuildInfo_All_RequestWareHouseOpen()
  elseif btnType == eFuncType.protectionIncrease then
    HandleEventLUp_GuildInfo_All_IncreaseProtectedMember()
  elseif btnType == eFuncType.payGuildTax then
    HandleEventLUp_GuildInfo_All_TaxPayment()
  elseif btnType == eFuncType.arshaAdminGet then
    HandleEventLUp_GuildInfo_All_RequestArsha()
  elseif btnType == eFuncType.lifeFund then
    HandleEventLUp_GuildInfo_All_RequestGuildWelfare()
  elseif btnType == eFuncType.setGuildMainServer then
    if nil ~= PaGlobalFunc_GuildMainServerSet_Open then
      PaGlobalFunc_GuildMainServerSet_Open()
    end
  elseif btnType == eFuncType.guildGiveaway then
    if nil ~= PaGlobal_GuildInfo_All then
      PaGlobal_GuildInfo_All:requestGiveawayList()
    end
  elseif btnType == eFuncType.editGuildColor then
    if PaGlobalFunc_GuildWarColor_All_Open ~= nil then
      PaGlobalFunc_GuildWarColor_All_Open()
    end
  elseif btnType == eFuncType.pointSetting then
    PaGlobal_GuildPointMenu_All_Open()
  elseif btnType == eFuncType.incentiveAll then
    PaGlobalFunc_GuildIncentiveOption_All_Open()
  elseif btnType == eFuncType.activityAll then
    PaGlobal_GuildActivityFunds_List_All_Open()
  elseif btnType == eFuncType.memberReload then
    ToClient_ReloadGuildMember()
  elseif btnType == eFuncType.joinRequest then
    PaGlobal_GuildJoinRequestSet:open()
  elseif btnType == eFuncType.siegeChance then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local siegeStr = ""
    local isMinorSiegeJoinable = ToClient_IsMinorSiegeJoinable(selfPlayer:getGuildNo_s64())
    if isMinorSiegeJoinable == true then
      siegeStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANBUILD_FORTRESS")
    else
      siegeStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANTBUILD_FORTRESS")
    end
    siegeStr = siegeStr .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIEGECHANCE_DESC_2024")
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = siegeStr,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  elseif btnType == eFuncType.joinMajorSiege then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local siegeStr = ""
    local isMajorSiegeJoinable = ToClient_IsMajorSiegeJoinableSiege2024()
    if isMajorSiegeJoinable == true then
      siegeStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANBUILD_FORTRESS")
    else
      siegeStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANTBUILD_FORTRESS")
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = siegeStr .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYSIEGECHANCE_DESC"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  elseif btnType == eFuncType.minorSiegeBuff then
    local dropRateTargetString
    if ToClient_IsAppliedDropRateBuffSiege2024() == true then
      local isEraseComma = true
      local addedDropTargetString = ""
      local currentApplyGroupBuffCount = ToClient_GetAppliedDropRateBuffCountSiege2024()
      for index = 0, currentApplyGroupBuffCount - 1 do
        local applyBuffGroupName = ""
        local applyBuffGroup = ToClient_GetAppliedDropRateBuffTerritoryGroupNoSiege2024(index)
        if applyBuffGroup == 0 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_0")
        elseif applyBuffGroup == 1 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_1")
        elseif applyBuffGroup == 2 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_2")
        else
          UI.ASSERT_NAME(false, "SiegeTerritoryGroupNo \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128 \235\144\152\236\151\136\236\156\188\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148!", "\235\176\149\236\157\184\234\183\160")
        end
        if applyBuffGroupName ~= "" then
          if isEraseComma == true then
            isEraseComma = false
            addedDropTargetString = addedDropTargetString .. applyBuffGroupName
          else
            addedDropTargetString = addedDropTargetString .. ", " .. applyBuffGroupName
          end
        end
      end
      if addedDropTargetString ~= "" then
        dropRateTargetString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_FORM", "name", addedDropTargetString)
      else
        dropRateTargetString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_NONE")
        UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\235\176\149\236\157\184\234\183\160")
      end
    else
      dropRateTargetString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_NONE")
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDINFO_DROPRATE_TOOLTIP_DESC", "target", dropRateTargetString),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  elseif btnType == eFuncType.selectGuildMansion then
    HandleEventLUp_GuildInfo_All_OpenSelectGuildMansion()
  elseif btnType == eFuncType.teleportGuildMansion then
    HandleEventLUp_GuildInfo_All_ShowGuildMansionTeleportMessageBox()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressMemberInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.showInfo then
    if nil ~= PaGlobalFunc_GuildMemberInfo_All_Open then
      PaGlobalFunc_GuildMemberInfo_All_Open()
    elseif nil ~= PaGlobalFunc_GuildMemberInfo_Open then
      PaGlobalFunc_GuildMemberInfo_Open()
    end
  elseif btnType == eFuncType.recvPay then
    HandleEventLUp_GuildMemberList_All_TakeFund()
  elseif btnType == eFuncType.joinReward then
    HandleEventLUp_GuildMemberList_All_TakeSiegeReward()
  elseif btnType == eFuncType.renewAgreement then
    HandlePadEventA_GuildMemberList_All_ContractClick()
  elseif btnType == eFuncType.inviteParty then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE)
  elseif btnType == eFuncType.deportation then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION)
  elseif btnType == eFuncType.appointCommander then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER)
  elseif btnType == eFuncType.cancelCommander then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT)
  elseif btnType == eFuncType.changeMaster then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER)
  elseif btnType == eFuncType.showContract then
    HandlePadEventA_GuildMemberList_All_ContractClick()
  elseif btnType == eFuncType.clanDeportation then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION)
  elseif btnType == eFuncType.voiceOption then
    PaGlobalFunc_GuildVoiceSet_All_Open()
  elseif btnType == eFuncType.funding then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PRICELIMIT)
  elseif btnType == eFuncType.protection then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER)
  elseif btnType == eFuncType.cancelProtection then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER)
  elseif btnType == eFuncType.participation then
    PaGlobalFunc_GuildMemberList_All_SetRequestParticipateAtSiege()
  elseif btnType == eFuncType.incentive then
    PaGlobalFunc_GuildIncentiveOption_All_Open()
  elseif btnType == eFuncType.appointSupply then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY)
  elseif btnType == eFuncType.inviteLargeParty then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.LARGEPARTY_INVITE)
  elseif btnType == eFuncType.payGuildTaxAllMember then
    HandleEventLUp_GuildMemberList_All_Deposit()
  elseif btnType == eFuncType.appointAdviser then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_ADVISER)
  elseif btnType == eFuncType.appointGunner then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_GUNNER)
  elseif btnType == eFuncType.activityPoint then
    HandleEventLUp_GuildMemberList_All_ApprovalClick(PaGlobal_GuildMemberList_All._selectIndex)
  elseif btnType == eFuncType.activityPointInfo then
    HandleEventLUp_GuildMemberList_All_PointDetailClick(PaGlobal_GuildMemberList_All._selectIndex)
  elseif btnType == eFuncType.appointScribe then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_SCRIBE)
  elseif btnType == eFuncType.appointChiefOfStaff then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_CHIEFOFSTAFF)
  elseif btnType == eFuncType.appointMissionOfficer then
    HandleEventLUp_GuildMemberList_All_SelectMenuButton(PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_MISSIONOFFICER)
  elseif btnType == eFuncType.changeMemberRight then
    HandleEventLUp_GuildMemberList_All_SelectMenuButtonNew(PaGlobal_GuildMemberList_All._MenuButtonTypeNew.AUTHORITY)
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_GuildFunctionPanel_All_PressQuestGradeFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.questGradeSmall then
    PaGlobal_GuildQuest_SelectCheck(0)
  elseif btnType == eFuncType.questGradeMedium then
    PaGlobal_GuildQuest_SelectCheck(1)
  elseif btnType == eFuncType.questGradeLarge then
    PaGlobal_GuildQuest_SelectCheck(2)
  elseif btnType == eFuncType.questGradeExtraLarge then
    PaGlobal_GuildQuest_SelectCheck(3)
  end
end
function HandleEventPadPress_GuildFunctionPanel_All_PressAllyInfoFunc(btnType)
  local eFuncType = PaGlobal_GuildFunctionPanel_All._eFuncType
  if btnType == eFuncType.allyNotice then
    HandleEventLUp_GuildAlliance_All_SetEditText()
  elseif btnType == eFuncType.allyMarkChange then
    if true == ToClient_isConsole() then
      PaGlobalFunc_GuildChangeMark_All_Open()
    else
      HandleEventLUp_GuildAlliance_All_MarkChange()
    end
  elseif btnType == eFuncType.allydisperse then
    HandleEventLUp_GuildAlliance_All_DisbandAlliance()
  elseif btnType == eFuncType.allyNoticeReset then
    HandleEventLUp_GuildAlliance_All_ResetNotice()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_GuildFunctionPanel_All:prepareClose()
end
