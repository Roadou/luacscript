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
  registerCloseLuaEvent(Panel_ChatOption, closeTypeBitSet.default, "PanelCloseFunc_ChatOption()")
  registerCloseLuaEvent(Panel_Window_ChatOption_All, closeTypeBitSet.default, "PanelCloseFunc_ChatOption_All()")
  registerCloseLuaEvent(Panel_Chatting_Input, closeTypeBitSet.default, "PanelCloseFunc_ChattingInput()")
  registerCloseLuaEvent(Panel_Window_ChannelChat, closeTypeBitSet.default, "PanelCloseFunc_ChannelChat()")
  registerCloseLuaEvent(Panel_Widget_ChannelChat_Loading, closeTypeBitSet.default, "PanelCloseFunc_ChannelChatLoading()")
  registerCloseLuaEvent(Panel_Window_GameTips, closeTypeBitSet.default, "PanelCloseFunc_GameTips()")
  registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.default, "PanelCloseFunc_MessageBox()")
  if ToClient_isConsole() == true then
    registerCloseLuaEvent(Panel_Dialogue_Itemtake, closeTypeBitSet.default, "PaGlobalFunc_Dialog_ItemTake_Close()")
    registerCloseLuaEvent(Panel_NewKnowledge, closeTypeBitSet.default, "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()")
  else
    registerCloseLuaEvent(Panel_Dialogue_Itemtake, closeTypeBitSet.default, "click_noDialogButton()")
    registerCloseLuaEvent(Panel_NewKnowledge, closeTypeBitSet.default, "Panel_ImportantKnowledge_HideAni()")
  end
  registerCloseLuaEvent(Panel_Dialogue_Itemtake_All, closeTypeBitSet.default, "HandleEventLUp_Dialogue_Itemtake_All_ClickNo()")
  registerCloseLuaEvent(Panel_Tooltip_Item_chattingLinkedItem, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()")
  registerCloseLuaEvent(Panel_ExitConfirm, closeTypeBitSet.default, "HandleEventLUp_ExitConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Window_TrayConfirm_All, closeTypeBitSet.default, "PaGlobalFunc_ExitTrayConfirm_All_Close()")
  registerCloseLuaEvent(Panel_Chatting_Color, closeTypeBitSet.default, "ChattingColor_Hide()")
  registerCloseLuaEvent(Panel_Window_Chatting_Color_All, closeTypeBitSet.default, "PaGlobalFunc_ChattingColor_All_Close()")
  registerCloseLuaEvent(Panel_Tooltip_Item_chattingLinkedItemClick, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()")
  registerCloseLuaEvent(Panel_Event_TicketShop, closeTypeBitSet.default, "PaGlobal_Event_TicketShop_Close()")
  registerCloseLuaEvent(Panel_Event_TicketShop_Unboxing, closeTypeBitSet.default, "PaGlobal_Event_TicketShop_Unboxing_Close()")
  registerCloseLuaEvent(Panel_WebControl, closeTypeBitSet.default, "PanelCloseFunc_WebControl()")
  registerCloseLuaEvent(Panel_WebCashPayment, closeTypeBitSet.default, "FGlobal_WebCashPayment_ForceClose()")
  registerCloseLuaEvent(Panel_Window_PearlBox_Purchase_All, closeTypeBitSet.default, "FGlobal_Window_PearlBox_Purchase_All_ForceClose()")
  registerCloseLuaEvent(Panel_LevelupGuide, closeTypeBitSet.default, "HandleClicked_LevelupGuide_Close()")
  registerCloseLuaEvent(Panel_ProductNote, closeTypeBitSet.default, "PanelCloseFunc_ProductNote()")
  registerCloseLuaEvent(Panel_KeyboardHelp, closeTypeBitSet.default, "PanelCloseFunc_KeyboardHelp()")
  registerCloseLuaEvent(Panel_Window_ExpirienceWiki_All, closeTypeBitSet.default, "PaGlobal_ExpirienceWiki_All_Close_FromESC()")
  if true == _ContentsGroup_UsePadSnapping then
    registerCloseLuaEvent(Panel_Win_System, closeTypeBitSet.attacked, "PanelCloseFunc_MessageBox()")
  else
    registerCloseLuaEvent(Panel_Win_System, closeTypeBitSet.attacked, "MessageBox_Empty_function()")
    registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.attacked, "MessageBox_Empty_function()")
  end
  registerCloseLuaEvent(Panel_Window_MessageBox_All, closeTypeBitSet.attacked, "PanelCloseFunc_MessageBox()")
  registerCloseLuaEvent(Panel_ChatOption, closeTypeBitSet.attacked, "ChattingOption_Close()")
  registerCloseLuaEvent(Panel_Window_ChatOption_All, closeTypeBitSet.attacked, "PaGlobalFunc_ChatOption_All_Close()")
  registerCloseLuaEvent(Panel_Window_GameExit_All, closeTypeBitSet.attacked, "PaGlobal_GameExit_CloseAll()")
  registerCloseLuaEvent(Panel_Chat_Emoticon, closeTypeBitSet.default, "PaGlobalFunc_ChatEmoticon_Close()")
  registerCloseLuaEvent(Panel_Chatting_Filter, closeTypeBitSet.default, "FGlobal_ChattingFilterList_Close()")
  registerCloseLuaEvent(Panel_Chat_SocialMenu, closeTypeBitSet.default, "FGlobal_SocialAction_ShowToggle()")
  registerCloseLuaEvent(Panel_ExchangeNickname, closeTypeBitSet.default, "FGlobal_Exchange_Close()")
  registerCloseLuaEvent(Panel_Dialog_NPCShop_All, closeTypeBitSet.default, "HandleEventLUp_NPCShop_ALL_Close()")
  registerCloseLuaEvent(Panel_Change_Nickname_All, closeTypeBitSet.default, "HandleEventLUp_ChangeNickNameAll_Close()")
  registerCloseLuaEvent(Panel_Window_NumberPad_All, closeTypeBitSet.default, "PanelCloseFunc_ExchangeNumber()")
  registerCloseLuaEvent(Panel_Window_cOption, closeTypeBitSet.default, "PanelCloseFunc_Option()")
  registerCloseLuaEvent(Panel_Window_GameOption_All, closeTypeBitSet.default, "PanelCloseFunc_Option()")
  registerCloseLuaEvent(Panel_Window_GameModeSettingNotice_All, closeTypeBitSet.default, "PaGlobalFunc_GameModeSettingNotice_All_Close()")
  registerCloseLuaEvent(Panel_Copyright, closeTypeBitSet.default, "PaGlobal_Copyright_Close()")
  registerCloseLuaEvent(Panel_Window_Copyright, closeTypeBitSet.default, "PaGlobal_Copyright:close()")
  registerCloseLuaEvent(Panel_AppliedBuffList_Console, closeTypeBitSet.default, "PaGlobalFunc_AppliedBuffList_Console_Close()")
  registerCloseLuaEvent(Panel_Chat_Process_All, closeTypeBitSet.escapeOnly, "PaGlobalFunc_Chat_Process_Close()")
  registerCloseLuaEvent(Panel_Window_Quest_All, closeTypeBitSet.default, "PaGlobalFunc_Quest_All_Close()")
  registerCloseLuaEvent(Panel_Window_QuestInfo_All, closeTypeBitSet.default, "PaGlobalFunc_QuestInfo_All_Close()")
  registerCloseLuaEvent(Panel_Window_QuestTypeSet_All, closeTypeBitSet.default, "PaGlobalFunc_QuestTypeSet_All_Close()")
  registerCloseLuaEvent(Panel_Window_Skill_BlackSpiritLock, closeTypeBitSet.default, "FGlobal_BlackSpiritSkillLock_Close()")
  registerCloseLuaEvent(Panel_Window_BlackSpiritSkillLock_All, closeTypeBitSet.default, "PaGlobalFunc_BlackSpiritSkillLock_All_Close()")
  registerCloseLuaEvent(Panel_SaveSetting, closeTypeBitSet.default, "PanelCloseFunc_SaveSetting()")
  registerCloseLuaEvent(Panel_DialogMovie, closeTypeBitSet.default, "PanelCloseFunc_DialogMovie()")
  registerCloseLuaEvent(Panel_MovieTheater_320, closeTypeBitSet.default, "PanelCloseFunc_MovieTheater320()")
  registerCloseLuaEvent(Panel_MovieTheater_640, closeTypeBitSet.default, "Panel_MovieTheater640_WindowClose()")
  if _ContentsGroup_UISkillGroupTreeLayOut == true then
    registerCloseLuaEvent(Panel_Window_SkillGroup_SelectType, closeTypeBitSet.default, "PanelCloseFunc_SkillSelectType()")
    if _ContentsGroup_ShowOtherClassSkill == true then
      registerCloseLuaEvent(Panel_Window_SkillGroup_All, closeTypeBitSet.default, "PaGlobalFunc_SkillGroup_All_Close()")
    else
      registerCloseLuaEvent(Panel_Window_SkillGroup, closeTypeBitSet.default, "PanelCloseFunc_Skill()")
    end
    registerCloseLuaEvent(Panel_SkillGroup_CoolTimeSlot, closeTypeBitSet.default, "PaGlobal_SkillGroup_CoolTimeSlot:close()")
    registerCloseLuaEvent(Panel_Window_SkillFilter_All, closeTypeBitSet.default, "PaGlobal_SkillFilter_Close()")
    registerCloseLuaEvent(Panel_Window_SkillPreset, closeTypeBitSet.default, "PaGlobal_SkillPreset_Close()")
    registerCloseLuaEvent(Panel_Window_SkillPresetMemo, closeTypeBitSet.default, "PaGlobalFunc_SkillPresetMemo_Close()")
  end
  registerCloseLuaEvent(Panel_QuickMenuCustom, closeTypeBitSet.default, "PanelCloseFunc_QuickMenuCustom()")
  registerCloseLuaEvent(Panel_QuickMenuCustom, closeTypeBitSet.attacked, "PaGlobalFunc_Panel_QuickMenuCustomClose()")
  registerCloseLuaEvent(Panel_Interaction_HouseList, closeTypeBitSet.default, "PanelCloseFunc_Interaction_HouseList_Close()")
  if _ContentsGroup_AlchemyStoneRenewal == true then
    registerCloseLuaEvent(Panel_Window_AlchemyStone_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStone_Renewal_All_Close()")
    registerCloseLuaEvent(Panel_Window_AlchemyStoneEvolve_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStoneEvolve_All_Close()")
  else
    registerCloseLuaEvent(Panel_Window_AlchemyStone_All, closeTypeBitSet.default, "PaGlobalFunc_AlchemyStone_All_Close()")
  end
  registerCloseLuaEvent(Panel_Window_CutSceneEscSkip, closeTypeBitSet.default, "PaGlobalFunc_CutSceneEscSkip_Close()")
  if _ContentsGroup_GuildAuthoritySeparation == true then
    registerCloseLuaEvent(Panel_Guild_Authorization_All, closeTypeBitSet.default, "PaGlobal_Guild_Authorization_All_Close()")
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    registerCloseLuaEvent(Panel_Notation_Ability, closeTypeBitSet.default, "PaGlobalFunc_NotationAbility_Close()")
  end
  registerCloseLuaEvent(Panel_Chat_SubMenu, closeTypeBitSet.default, "HandleEventLUp_ChatSubMenuClose()")
  if ToClient_isConsole() == true then
    registerCloseLuaEvent(Panel_Chatting_BlockList, closeTypeBitSet.default, "PaGlobal_Chatting_BlockList:prepareClose()")
    registerCloseLuaEvent(Panel_Chatting_FunctionList, closeTypeBitSet.default, "PaGlobal_Chatting_FunctionList:prepareClose()")
    registerCloseLuaEvent(Panel_Window_KeyGuide, closeTypeBitSet.attacked, "PaGlobalFunc_KeyGuidWindow_Close()")
    registerCloseLuaEvent(Panel_Chatting_FunctionList, closeTypeBitSet.default, "PaGlobal_Chatting_FunctionList:prepareClose()")
    registerCloseLuaEvent(Panel_Window_Chat_Report_All, closeTypeBitSet.default, "PaGlobal_Window_Chat_Report_All_Close()")
    registerCloseLuaEvent(Panel_Window_ConsoleUIOffset, closeTypeBitSet.default, "PaGlobal_ConsoleUIOffset_Close()")
    registerCloseLuaEvent(Panel_Widget_Chatting_Renew, closeTypeBitSet.default, "Input_ChattingInfo_OnPadBNotEditting()")
    registerCloseLuaEvent(Panel_Window_Option_Main, closeTypeBitSet.default, "PanelCloseFunc_RenewOption_Close()")
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
function initCloseFunction()
  _PA_LOG("\236\157\180\235\139\164\237\152\156", "initCloseFunction Start")
  CloseManager_RegisterExeptionList()
  closeExceptionListInitialize()
  registerClosePanelList()
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
  if nil ~= Panel_Widget_EscapeBar_All and Panel_Widget_EscapeBar_All:GetShow() then
    ToClient_StopPreCoolTime()
    return
  end
  PaGlobalFunc_AbyssOneMenu_ShowToggle()
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
    if TooltipSimple_Hide ~= nil then
      TooltipSimple_Hide()
      TooltipCommon_Hide()
    end
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
      Defines.UIMode.eUIMode_SiegeInstallMode
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
  RenderModeAllClose()
  ToClient_PopBlackSpiritFlush()
  if isPhotoMode() then
    audioPostEvent_SystemUi(8, 14)
    _AudioPostEvent_SystemUiForXBOX(8, 14)
  end
  if true == _ContentsGroup_NewUI_Inventory_All and nil ~= Panel_Window_Inventory_All and true == Panel_Window_Inventory_All:GetShow() then
    PaGlobalFunc_Inventory_All_Delete_No()
  end
  close_WindowMinigamePanelList()
  PanelCloseFunc_FairySkillChange(true)
  if true == _ContentsGroup_RenewUI and nil ~= PaGlobalFunc_PowerSave_All_Close then
    PaGlobalFunc_PowerSave_All_Close()
  end
  if Panel_Dialog_Trade_Function_All ~= nil and dialog_getTalkNpcKey() ~= 0 then
    PaGlobalFunc_TradeFunction_All_SetIsTrading(false)
  end
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Attacked, false)
  PaGlobalFunc_DialogMain_All_Close(false, false, true)
  if true == isForced then
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
    if true == ToClient_SelfPlayerIsGM() then
      chatting_sendMessage("", "PanelCloseFunc_MasterpieceAuction Close", CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    end
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
  if true == _ContentsGroup_UsePadSnapping then
    local isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
    if nil ~= Panel_Window_GuildWareHouseHistory and true == Panel_Window_GuildWareHouseHistory:GetShow() then
      PaGlobal_GuildWareHouseHistory:close()
      return
    end
    if false == isManufactureOpen then
      PaGlobal_Warehouse_All_Close()
    end
  else
    PaGlobal_Warehouse_All_Close()
    if nil ~= Panel_Window_GuildWareHouseHistory and true == Panel_Window_GuildWareHouseHistory:GetShow() then
      PaGlobal_GuildWareHouseHistory:close()
    end
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
  if nil ~= Panel_Window_StackExtraction_All and true == PaGlobalFunc_SpiritEnchant_All_GetIsAnimating() then
    return
  end
  if nil ~= Panel_Window_GuildWareHouseHistory and true == Panel_Window_GuildWareHouseHistory:GetShow() then
    PaGlobal_GuildWareHouseHistory:close()
    return
  end
  if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
    PaGlobalFunc_TotalSearch_Close()
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
  if nil ~= Panel_Window_Invitation_All and true == Panel_Window_Invitation_All:GetShow() then
    PaGlobal_Invitation_All_Close()
    return
  end
  if nil ~= Panel_Window_FamilyInventory_All and Panel_Window_FamilyInventory_All:GetShow() then
    PaGlobal_FamilyInvnetory_Close(true)
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
  elseif nil ~= Panel_Window_GuildWareHouseHistory and true == Panel_Window_GuildWareHouseHistory:GetShow() then
    PaGlobal_GuildWareHouseHistory:close()
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
function PanelCloseFunc_Option()
  GameOption_Cancel()
  TooltipSimple_Hide()
end
