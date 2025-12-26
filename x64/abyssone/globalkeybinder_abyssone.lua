local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
local fastPinDelta = 0
function CommonWindowFunction(uiInputType, Function, param)
  if true == GlobalKeyBinder_CheckCustomKeyPressed(uiInputType) then
    Function(param)
    return true
  end
  return false
end
function PaGlobal_GlobalKeyBinder.Process_GameMode()
end
function PaGlobal_GlobalKeyBinder.Process_Normal(deltaTime)
  if MessageBox.isPopUp() == true then
    local pcKey = GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)
    if pcKey and not _ContentsGroup_UsePadSnapping then
      MessageBox.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBox.keyProcessEscape()
      return true
    end
  elseif _ContentsGroup_UsePadSnapping == true and PaGlobalFunc_AbyssOneMenu_GetShow() == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_AbyssOneMenu_ShowToggle()
      return true
    end
  elseif Panel_Chatting_Macro:GetShow() == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Chatting_Macro_ShowToggle()
      FGlobal_Chatting_Macro_SetCHK(false)
      CheckChattingInput()
      return true
    end
  elseif Panel_SequenceSkipEscPopUp:GetShow() then
    if (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) or isPadDown(__eJoyPadInputType_A)) and ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_BlackTemple) == false then
      returnSequenceSkip()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      keepGogingSequenceByKeyBinder()
    end
    return true
  elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_AlchemyStone) == true and isKeyPressed(VCK.KeyCode_CONTROL) == false then
    local alchemyUseFunc = PaGlobalFunc_AlchemyStone_All_Use
    if _ContentsGroup_AlchemyStoneRenewal == true then
      alchemyUseFunc = PaGlobalFunc_AlchemyStone_Renewal_All_Use
    end
    local inputMode = getInputMode()
    if inputMode == IM.eProcessorInputMode_GameMode then
      alchemyUseFunc()
      return true
    elseif (inputMode == IM.eProcessorInputMode_UiMode or inputMode == IM.eProcessorInputMode_UiControlMode) and UIMode.eUIMode_Default == GetUIMode() then
      alchemyUseFunc()
      return true
    end
  else
    if true == Panel_Window_CutSceneSkip:GetShow() then
      local self = PaGlobal_CutSceneSkip
      if true == _ContentsGroup_UsePadSnapping then
        if true == isPadDown(__eJoyPadInputType_A) then
          self:doSkip()
        else
          if true == isPadDown(__eJoyPadInputType_B) then
          else
          end
        end
      elseif true == isKeyDown_Once(VCK.KeyCode_RETURN) or true == isKeyDown_Once(VCK.KeyCode_SPACE) or true == isPadDown(__eJoyPadInputType_A) then
        self:doSkip()
      elseif true == isKeyDown_Once(VCK.KeyCode_ESCAPE) or true == isPadDown(__eJoyPadInputType_B) then
      end
    else
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_CommonWindow(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_ProductNote ~= nil and Panel_ProductNote:GetShow() == true and Panel_ProductNote:IsUISubApp() == false then
      Panel_ProductNote_ShowToggle()
      return
    end
    if PaGlobal_ExpirienceWiki_GetShow ~= nil and PaGlobal_ExpirienceWiki_GetShow() == true then
      InputMLUp_ExpirienceWiki_All_Close()
      return
    end
    if PaGlobal_Copyright_GetShow ~= nil and PaGlobal_Copyright_GetShow() == true then
      PaGlobal_Copyright_Close()
      return
    end
    if _ContentsGroup_NewUI_GameOption_All == true and Panel_Window_GameOption_All ~= nil and Panel_Window_GameOption_All:GetShow() == true or _ContentsGroup_isNewOption == true and Panel_Window_cOption ~= nil and Panel_Window_cOption:GetShow() == true then
      GameOption_Cancel()
      return
    end
    if PaGlobal_Panel_SaveSetting_GetShow ~= nil and PaGlobal_Panel_SaveSetting_GetShow() == true then
      PaGlobal_Panel_SaveSetting_Hide()
      return
    end
    if _ContentsGroup_UISkillGroupTreeLayOut == true and Panel_Window_SkillGroup ~= nil and Panel_Window_SkillGroup:GetShow() == true then
      PaGlobal_SkillGroup:close()
      return
    end
    if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
      PaGlobal_SkillGroup_All:close()
      return
    end
    if PaGlobalFunc_Quest_All_GetShow() == true then
      PaGlobalFunc_Quest_All_Close()
      return
    end
    if PaGlobalFunc_ChatOption_All_GetShow ~= nil and PaGlobalFunc_ChatOption_All_GetShow() == true then
      PaGlobalFunc_ChatOption_All_Close()
      return
    end
    if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true then
      if PaGlobalFunc_BlackSpiritSkillLock_All_GetShow() == true then
        PaGlobalFunc_BlackSpiritSkillLock_All_Close()
        return
      end
    elseif FGlobal_BlackSpiritSkillLock_GetShow() == true then
      FGlobal_BlackSpiritSkillLock_Close()
      return
    end
    if PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_GetShow() == true then
      PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Close()
      return
    end
    if FGlobal_GameTips_GetShow ~= nil and FGlobal_GameTips_GetShow() == true then
      GameTipsHide()
      return
    end
  end
  if CommonWindowFunction(__eUiInputType_BlackSpirit, Process_UIMode_CommonWindow_BlackSpirit) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Inventory, Process_UIMode_CommonWindow_Inventory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_QuestHistory, Process_UIMode_CommonWindow_QuestHistory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Skill, Process_UIMode_CommonWindow_Skill) then
    return
  end
  if Panel_Interaction ~= nil and Panel_Interaction:IsShow() == true or Panel_Widget_PanelInteraction_Renew ~= nil and Panel_Widget_PanelInteraction_Renew:IsShow() == true then
    local keyCode
    if _ContentsGroup_UsePadSnapping and (isPadInputIn() or true == ToClient_IsRemoteControlMode()) then
      keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode_Xbox(deltaTime)
    else
      keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode()
    end
    if nil ~= keyCode then
      Interaction_ExecuteByKeyMapping(keyCode)
    end
  elseif UI_Character_InterActionGathering_All ~= nil and UI_Character_InterActionGathering_All:GetShow() == true then
    local keyCode
    if _ContentsGroup_UsePadSnapping == true and (isPadInputIn() == true or ToClient_IsRemoteControlMode() == true) then
      keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode_Xbox(deltaTime)
    else
      keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode()
    end
    if keyCode ~= nil then
      PaGlobal_InteractionGathering_All_ButtonPushed(keyCode, nil)
    end
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_B) then
    requestBlackSpritSkill()
    return
  end
  if true == _ContentsGroup_NewCloseManager then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_ChattingInputMode()
  uiEdit = GetFocusEdit()
  if nil == uiEdit then
    return false
  end
  if ChatInput_CheckCurrentUiEdit(uiEdit) then
    if true == _ContentsGroup_RenewUI_Chatting then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        Input_ChattingInfo_OnPadB()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) then
        PaGlobalFunc_ChattingInfo_CheckRemoveLinkedItem()
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      if true == ToClient_isConsole() then
        if true == _ContentsGroup_RenewUI_Chatting then
          PaGlobalFunc_ChattingInfo_PressedEnter()
        else
          ChatInput_PressedEnter()
        end
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
      if ToClient_isComposition() then
        return
      end
      if true == ToClient_isConsole() then
      else
        ChatInput_PressedUp()
      end
    elseif isKeyPressed(VCK.KeyCode_MENU) then
      ChatInput_CheckReservedKey()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_TAB) then
      if isGameTypeKorea() then
        ChatInput_ChangeTypeByTab()
      end
      ChatInput_ChangeInputFocus()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if ToClient_isComposition() then
        return
      end
      ChatInput_CancelAction()
      ChatInput_CancelMessage()
      ChatInput_Close()
      ClearFocusEdit()
      if PaGlobal_AddFriend_All_Close ~= nil then
        sddPaGlobal_AddFriend_All_Close()
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      ChatInput_CheckInstantCommand()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) or isKeyPressed(VCK.KeyCode_BACK) then
      ChatInput_CheckRemoveLinkedItem()
      ChatInput_CheckRemoveLinkedQuest()
    elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_ChatTabNext) then
      moveChatTab(true)
    elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_ChatTabPrev) then
      moveChatTab(false)
    end
  elseif PaGlobal_Chat_Process_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
      PaGlobal_Chat_Process_PressArrowUp()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_DOWN) then
      PaGlobal_Chat_Process_PressArrowDown()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and isKeyPressed(VCK.KeyCode_SHIFT) == false then
      PaGlobalFunc_Chat_Process_EnterFunc()
    end
    return true
  elseif QASupport_AutomationPanel_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      QASupport_Automation_EnterFunc(2)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RIGHT) then
      QASupport_Automation_PressRightKey(uiEdit)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LEFT) then
      QASupport_Automation_PressLeftKey(uiEdit)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_TAB) then
      if isKeyPressed(VCK.KeyCode_SHIFT) == true then
        QASupport_Automation_PressLeftKey(uiEdit)
      else
        QASupport_Automation_PressRightKey(uiEdit)
      end
    end
    return true
  elseif FGlobal_Option_CheckUiEdit(uiEdit) == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      if _ContentsGroup_NewUI_GameOption_All == true then
        PaGlobal_GameOption_All:ClickedSearchOption()
      else
        PaGlobal_Option:ClickedSeachOption()
      end
    end
    return true
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if FGlobal_SocialAction_GetShow() == true then
      FGlobal_SocialAction_ShowToggle()
      return
    end
    ClearFocusEdit()
  end
  return false
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_NpcDialog(deltaTime)
  if ToClient_isConsole() == false then
    if nil ~= HandleEventKeyBoard_DialogManager_All_KeyPushCheck and true == HandleEventKeyBoard_DialogManager_All_KeyPushCheck() then
      return
    end
    if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
      if nil ~= PaGlobalFunc_NPCShop_ALL_GetShow then
        if true == PaGlobalFunc_NPCShop_ALL_GetShow() then
          return
        end
      elseif nil ~= Panel_Window_NpcShop and true == Panel_Window_NpcShop:GetShow() then
        return
      end
      if nil ~= Panel_CreateGuild and Panel_CreateGuild:GetShow() then
        return
      end
      if nil ~= Panel_GuildHouse_Auction_All and Panel_GuildHouse_Auction_All:GetShow() then
        return
      end
      if Panel_DetectPlayer ~= nil and Panel_DetectPlayer:GetShow() then
        return
      end
      if nil ~= Panel_Atoraxion_Enter and true == Panel_Atoraxion_Enter:GetShow() then
        return
      end
      if nil ~= Panel_Atoraxion_Select and true == Panel_Atoraxion_Select:GetShow() then
        return
      end
      if nil ~= Panel_BatchSummonMonster and true == Panel_BatchSummonMonster:GetShow() then
        return
      end
      local btn_continue = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Continue")
      local btn_next = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Next")
      if true == PaGlobalFunc_DialogMain_All_GetShowNextBtn() then
        HandleEventLUp_DialogMain_All_NextClick()
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      elseif true == PaGlobalFunc_DialogMain_All_GetShowContinueBtn() then
        HandleEventLUp_DialogMain_All_ContinueClick()
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      elseif nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
        HandleEventEnter_DialogQuest_All_SelectConfirmReward()
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      elseif true == PaGlobalFunc_DialogKeyManager_All_IsShowSpaceBarIcon() and nil ~= PaGlobal_DialogKeyManager_All._targetPanel and true == PaGlobal_DialogKeyManager_All._targetPanel:GetShow() then
        if true == HandleEventKeyBoard_DialogManager_All_KeyPushCheck() then
          audioPostEvent_SystemUi(0, 0)
          _AudioPostEvent_SystemUiForXBOX(50, 1)
        end
      elseif true == PaGlobalFunc_DialogMain_All_IsDialogNewMainQuest() and true == PaGlobalFunc_DialogMain_All_IsFuncBtnSpaceShow() then
        HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._dialogIndex.MAINQUEST)
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      elseif true == PaGlobalFunc_DialogMain_All_IsDialogNewQuest() and true == PaGlobalFunc_DialogMain_All_IsFuncBtnSpaceShow() then
        HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._dialogIndex.QUEST)
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      elseif true == PaGlobalFunc_DialogMain_All_IsDialogTalk() and true == PaGlobalFunc_DialogMain_All_IsFuncBtnSpaceShow() then
        HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._dialogIndex.TALK)
        audioPostEvent_SystemUi(0, 0)
        _AudioPostEvent_SystemUiForXBOX(50, 1)
      end
      return
    end
    if false == PaGlobalFunc_DialogMain_IsSearchMode() then
      local ACT = CppEnums.ActionInputType
      for idx = 0, #PaGlobal_DialogMain_All._HOTKEY do
        if ACT.ActionInputType_CrouchOrSkill == PaGlobal_DialogMain_All._HOTKEY[idx].key and true == keyCustom_IsUp_Action(ACT.ActionInputType_CrouchOrSkill) then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_MoveFront == PaGlobal_DialogMain_All._HOTKEY[idx].key and true == keyCustom_IsUp_Action(ACT.ActionInputType_MoveFront) then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_GrabOrGuard == PaGlobal_DialogMain_All._HOTKEY[idx].key and true == keyCustom_IsUp_Action(ACT.ActionInputType_GrabOrGuard) then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_MoveLeft == PaGlobal_DialogMain_All._HOTKEY[idx].key and true == keyCustom_IsUp_Action(ACT.ActionInputType_MoveLeft) then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        end
        if nil ~= PaGlobal_DialogMain_All._HOTKEY[idx].key and false == PaGlobal_DialogMain_All._HOTKEY[idx].isActionKey and true == isKeyUpFor(PaGlobal_DialogMain_All._HOTKEY[idx].key) then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        end
      end
    end
  end
  if false == _ContentsGroup_UsePadSnapping then
    if true == isKeyDown_Once(VCK.KeyCode_TAB) then
      HandleEventLUp_DialogMain_All_CheckVoiceAutoContinue(true)
    end
  elseif true == isPadDown(__eJoyPadInputType_X) then
    HandleEventLUp_DialogMain_All_CheckVoiceAutoContinue(true)
  end
  if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == _ContentsGroup_RenewUI and true == HandleEventKeyBoard_DialogMain_All_BackSpaceClick() then
    HandleEventLUp_DialogMain_All_BackClick()
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and ToClient_isConsole() == false and nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
    HandleEventEnter_DialogQuest_All_SelectConfirmReward()
    audioPostEvent_SystemUi(0, 0)
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    return
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_ProductNote ~= nil and Panel_ProductNote:GetShow() == true and Panel_ProductNote:IsUISubApp() == false then
      Panel_ProductNote_ShowToggle()
      return
    end
    if _ContentsGroup_UsePadSnapping == true and Panel_Popup_MoveItem ~= nil and Panel_Popup_MoveItem:GetShow() == true then
      PopupMoveItem_Close()
      return
    end
    if _ContentsGroup_UsePadSnapping == true and Panel_Widget_Knowledge ~= nil and Panel_Widget_Knowledge:GetShow() == true then
      PaGlobalFunc_AlchemyKnowledgeClose()
      return
    end
    if nil ~= Panel_Masterpiece_Auction_Bid_All and true == Panel_Masterpiece_Auction_Bid_All:GetShow() then
      PaGlobal_Masterpiece_Auction_Bid_All_Close()
      return
    end
    if nil ~= Panel_Masterpiece_Auction_All and Panel_Masterpiece_Auction_All:GetShow() then
      PaGlobal_Masterpiece_Auction_All_Close()
      return
    end
    if nil ~= PaGlobalFunc_ServantInventory_GetShow and true == PaGlobalFunc_ServantInventory_GetShow() and true == Panel_Window_Warehouse:GetShow() then
      ServantInventory_Close()
      return
    end
    if ToClient_isConsole() == true then
      if nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
        HandlePadEventB_SpiritEnchant_All_OnPadB()
        return
      end
      if Panel_Window_Socket_All ~= nil and Panel_Window_Socket_All:GetShow() == true then
        PaGlobalFunc_Socket_All_Close()
        return
      end
      if Panel_Window_Improvement_All ~= nil and true == Panel_Window_Improvement_All:GetShow() then
        PaGlobalFunc_Improvement_All_Close()
        return
      end
    else
      if nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() and false == PaGlobalFunc_SpiritEnchant_All_GetIsAnimating() then
        if _ContentsGroup_UsePadSnapping == true then
          HandlePadEventB_SpiritEnchant_All_OnPadB()
        else
          PaGlobalFunc_SpiritEnchant_All_Close()
        end
        return
      end
      if Panel_Window_Improvement_All ~= nil and true == Panel_Window_Improvement_All:GetShow() then
        PaGlobalFunc_Improvement_All_Close()
        return
      end
    end
    if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All ~= nil and Panel_Widget_Enchant_Main_All:GetShow() == true then
      if nil ~= Panel_Window_Enchant_Material_All and true == Panel_Window_Enchant_Material_All:GetShow() then
        PaGlobalFunc_EnchantMaterial_All_Close()
        return
      end
      if nil ~= Panel_Window_EnchantProtector_All and true == Panel_Window_EnchantProtector_All:GetShow() then
        PaGlobalFunc_EnchantProtector_All_Close()
        return
      end
      if nil ~= Panel_Window_EnchantStack_All and true == Panel_Window_EnchantStack_All:GetShow() then
        PaGlobalFunc_EnchantStack_All_Close()
        return
      end
      if nil ~= Panel_Window_Enchant_StackExtraction_All and true == Panel_Window_Enchant_StackExtraction_All:GetShow() then
        PaGlobalFunc_StackExtraction_All_Close()
        return
      end
      if _ContentsGroup_NewUI_Inventory_All == true then
        if Panel_Window_Inventory_All:GetShow() == true then
          PaGlobalFunc_Inventory_All_SetShow(false)
          return
        end
      elseif Panel_Window_Inventory:GetShow() == true then
        PaGlobalFunc_InventoryInfo_Close()
        return
      end
      if nil ~= Panel_Widget_Enchant_Main_All and true == Panel_Widget_Enchant_Main_All:GetShow() then
        PaGlobalFunc_EnchantMain_All_Close()
        return
      end
    end
    if nil ~= Panel_Window_WorkerAuction_All and true == Panel_Window_WorkerAuction_All:GetShow() then
      HandleEventLUp_WorkerAuction_All_Close()
      return
    end
    if nil ~= Panel_Window_WorkerRandomSelect_All and (true == Panel_Window_WorkerRandomSelect_All:GetShow() or true == Panel_Window_WorkerRandomSelectOption_All:GetShow()) then
      HandleEventLUp_WorkerRandomSelect_All_Close()
      return
    end
    if ToClient_isConsole() == true then
      if nil ~= Panel_Dialog_RandomWorker and true == Panel_Dialog_RandomWorker:GetShow() then
        FGlobalFunc_Close_RandomWorker()
        return
      end
      if nil ~= Panel_Dialog_WorkerContract and true == Panel_Dialog_WorkerContract:GetShow() then
        FGlobalFunc_Cancel_WorkerContract()
        return
      end
    end
    if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
      PaGlobalFunc_TotalSearch_Close()
      return
    elseif Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true then
      PaGlobal_AutoMove_Result_All:prepareClose()
      return
    elseif Panel_Window_WareHouseHistory ~= nil and Panel_Window_WareHouseHistory:GetShow() == true then
      PaGlobal_WareHouseHistory:close()
      return
    elseif Panel_WareHouseFunctionPanel_All ~= nil and Panel_WareHouseFunctionPanel_All:GetShow() == true then
      PaGlobalFunc_WareHouseFunctionPanel_All_Close()
      return
    elseif Panel_Window_Warehouse ~= nil and Panel_Window_Warehouse:GetShow() == true then
      PaGlobal_Warehouse_All_Close()
      return
    end
    if nil ~= PaGlobalFunc_NPCShop_ALL_GetShow then
      if true == PaGlobalFunc_NPCShop_ALL_GetShow() then
        HandleEventLUp_NPCShop_ALL_Close()
        return
      end
    elseif ToClient_isConsole() == true and true == PaGlobalFunc_Dialog_NPCShop_GetShow() then
      PaGlobalFunc_Dialog_NPCShop_Close()
      return
    end
    if nil ~= PaGlobalFunc_KnowledgeManage_GetShow and true == PaGlobalFunc_KnowledgeManage_GetShow() then
      PaGlobalFunc_KnowledgeManage_Close()
      return
    end
    if ToClient_isConsole() == true and PaGlobalFunc_DetectPlayer_GetShow ~= nil and true == PaGlobalFunc_DetectPlayer_GetShow() then
      PaGlobalFunc_DetectPlayer_Exit()
      return
    end
    if nil ~= PaGlobalFunc_Dialog_SkillSpecialize_GetShow and true == PaGlobalFunc_Dialog_SkillSpecialize_GetShow() then
      PaGlobalFunc_Dialog_SkillSpecialize_Close(true)
      return
    end
    if nil ~= Panel_Window_BlackSpiritAdventure and Panel_Window_BlackSpiritAdventure:GetShow() then
      BlackSpiritAd_Hide()
      return
    end
    if nil ~= PaGlobalFunc_LordMenu_GetShow and true == PaGlobalFunc_LordMenu_GetShow() then
      HandleEventLUp_LordMenu_All_Close()
      return
    end
    if nil ~= Panel_WebControl and true == Panel_WebControl:GetShow() then
      Panel_WebHelper_ShowToggle()
      return
    end
    if ToClient_isConsole() == true or _ContentsGroup_UsePadSnapping == true then
      if true == HandlePadEventB_DailogQuest_All_OnPadB() then
        PaGlobalFunc_DialogQuest_All_Refuse()
        return
      end
    elseif nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
      PaGlobalFunc_DialogMain_All_Close()
      return
    end
    if _ContentsGroup_UsePadSnapping and nil ~= Panel_AskKnowledge and Panel_AskKnowledge:GetShow() then
      PaCloseFunc_AskKnowlege_Close()
      return
    end
    if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
      PaGlobalFunc_DialogExchange_All_Close()
      return
    end
    if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
      PaGlobalFunc_DialogList_All_Close()
      return
    end
    if nil ~= Panel_SkillReinforce_All and true == Panel_SkillReinforce_All:GetShow() then
      HandleEventLUp_PaGlobal_SkillReinforce_All_Exit()
      return
    end
    if nil ~= Panel_Window_ItemMoveSet and true == Panel_Window_ItemMoveSet:GetShow() then
      PaGlobal_ItemMoveSet:prepareClose(true)
      return
    end
    if nil ~= Panel_Window_MiniGame_YachtDice and true == Panel_Window_MiniGame_YachtDice:GetShow() then
      PaGlobalFunc_MiniGame_YachtDice_Close()
      return
    end
    if check_ShowWindow() then
      close_WindowPanelList()
      if nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
        PaGlobalFunc_DialogMain_All_Close()
      end
    elseif nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
      PaGlobalFunc_DialogMain_All_Close()
    end
    if ToClient_isConsole() == false and PaGlobal_VehicleInfo_All_Close ~= nil then
      PaGlobal_VehicleInfo_All_Close()
    elseif nil ~= PaGlobalFunc_ServantInfo_Exit then
      PaGlobalFunc_ServantInfo_Exit()
    end
    if nil ~= Panel_Window_ServantInventory then
      ServantInventory_Close()
    end
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_GameExit(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if ToClient_isConsole() == false then
      if Panel_Window_DeliveryForGameExit ~= nil and true == Panel_Window_DeliveryForGameExit:GetShow() then
        FGlobal_DeliveryForGameExit_Show(false)
        return
      elseif Panel_WebControl_Renew ~= nil then
        if Panel_WebControl_Renew:GetShow() == true and PaGlobalFunc_WebControl_Close ~= nil then
          PaGlobalFunc_WebControl_Close()
          return
        end
      elseif nil ~= Panel_Event_100Day and true == Panel_Event_100Day:GetShow() then
        FGlobal_Event_100Day_Close()
      elseif nil ~= Panel_ChannelSelect and true == Panel_ChannelSelect:GetShow() then
        FGlobal_ChannelSelect_Hide()
      elseif nil ~= Panel_ChannelSelect_All and true == Panel_ChannelSelect_All:GetShow() then
        PaGlobalFunc_ChannelSelect_All_Close()
      elseif Panel_Window_TrayConfirm_All ~= nil and true == Panel_Window_TrayConfirm_All:GetShow() then
        PaGlobalFunc_ExitTrayConfirm_All_Close()
      else
        PaGlobal_GameExit_All_ShowToggle(false)
      end
    else
      if Panel_Window_DeliveryForGameExit ~= nil and true == Panel_Window_DeliveryForGameExit:GetShow() then
        FGlobal_DeliveryForGameExit_Show(false)
        return
      end
      if Panel_WebControl_Renew ~= nil and Panel_WebControl_Renew:GetShow() == true and PaGlobalFunc_WebControl_Close ~= nil then
        PaGlobalFunc_WebControl_Close()
        return
      end
      if nil ~= Panel_ChannelSelect_All then
        PaGlobalFunc_ChannelSelect_All_Close()
      end
      if nil ~= Panel_Window_GameExit_All then
        HandleEventLUp_GameExit_All_Close()
        return
      elseif true == _ContentsGroup_RenewUI and true == PaGlobalFunc_GameExit_GetShow() then
        PaGlobalFunc_GameExit_SetShow(false, false)
      end
      if true == PaGlobalFunc_GameExitCharMove_GetShow() then
        PaGlobalFunc_GameExitCharMove_SetShow(false, false)
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SkillWindow(delataTime)
  if _ContentsGroup_UISkillGroupTreeLayOut == false then
    return
  end
  if getEscHandle() == false and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) == true then
    if _ContentsGroup_SkillPreset == true then
      if Panel_Window_SkillPresetMemo ~= nil and Panel_Window_SkillPresetMemo:GetShow() == true then
        PaGlobalFunc_SkillPresetMemo_Close()
        return
      end
      if Panel_Window_SkillPreset ~= nil and Panel_Window_SkillPreset:GetShow() == true then
        PaGlobal_SkillPreset_Close()
        return
      end
    end
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobalFunc_SkillGroup_All_Close()
    else
      PaGlobalFunc_SkillGroup_Close()
    end
  elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Skill) == true then
    if true == _ContentsGroup_SkillPreset and nil ~= Panel_Window_SkillPreset and true == Panel_Window_SkillPreset:GetShow() then
      PaGlobal_SkillPreset_Close()
      return
    end
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobalFunc_SkillGroup_All_HotKeyToggle()
    else
      PaGlobalFunc_SkillGroup_HotKeyToggle()
    end
  end
  if Panel_Window_SkillGroup_Controller ~= nil and Panel_Window_SkillGroup_Controller:GetShow() == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) == true then
      PaGlobal_SkillGroup_Controller:HandleEventLUp_PlaySkill()
    end
    if _ContentsGroup_ShowOtherClassSkill == true then
      if PaGlobalFunc_SkillGroup_All_KeyBoardTabEvent() == true then
        return
      end
    elseif PaGlobalFunc_SkillGroup_KeyBoardTabEvent() == true then
      return
    end
    if _ContentsGroup_UsePadSnapping == true and isPadPressed(__eJoyPadInputType_LeftTrigger) == true then
      if isPadPressed(__eJoyPadInputType_RightStick_Up) == true then
        if PaGlobal_SkillGroup_Controller_ScrollEffectDesc ~= nil then
          PaGlobal_SkillGroup_Controller_ScrollEffectDesc(true)
        end
      elseif isPadPressed(__eJoyPadInputType_RightStick_Down) == true and PaGlobal_SkillGroup_Controller_ScrollEffectDesc ~= nil then
        PaGlobal_SkillGroup_Controller_ScrollEffectDesc(false)
      end
    end
  end
  if _ContentsGroup_UsePadSnapping == false then
    if isUseNewQuickSlot() == true then
      local ii
      local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
      local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
      for ii = quickSlot1, quickSlot20 do
        if keyCustom_IsDownOnce_Action(ii) == true then
          HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
          return
        end
      end
    else
      local ii
      local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
      local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
      for ii = quickSlot1, quickSlot10 do
        if keyCustom_IsDownOnce_Action(ii) == true then
          QuickSlot_Click(tostring(ii - quickSlot1))
          return
        end
      end
    end
  end
  if _ContentsGroup_ShowOtherClassSkill == true then
    if PaGlobalFunc_SkillGroup_All_KeyBoardMoveLevel() == true then
      return
    end
  elseif PaGlobalFunc_SkillGroup_KeyBoardMoveLevel() == true then
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SkillkeyBinder(deltaTime)
  if isUseNewQuickSlot() == true then
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
    for ii = quickSlot1, quickSlot20 do
      if keyCustom_IsDownOnce_Action(ii) == true then
        HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
        return
      end
    end
  else
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
    for ii = quickSlot1, quickSlot10 do
      if keyCustom_IsDownOnce_Action(ii) == true then
        QuickSlot_Click(tostring(ii - quickSlot1))
        return
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_ChattingMacro()
  if isKeyPressed(VCK.KeyCode_MENU) == false then
    return false
  end
  if isKeyPressed(VCK.KeyCode_SHIFT) == false then
    return false
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    return false
  end
  local ii
  for ii = VCK.KeyCode_0, VCK.KeyCode_9 do
    local key = ii - VCK.KeyCode_0 - 1
    if key < 0 then
      key = VCK.KeyCode_9 - VCK.KeyCode_0
    end
    if isKeyDown_Once(ii) == true then
      if Panel_Chat_Process_All:GetShow() == true then
        PaGlobal_Chat_Process_UseMacro(ii - VCK.KeyCode_0)
        return true
      end
      if ToClient_getMacroChatMessage(key) ~= "" then
        ToClient_executeChatMacro(key)
        return true
      end
    end
  end
  return false
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_NpcSimpleDialog(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if nil ~= Panel_Dialog_SimpleDesc_All and true == Panel_Dialog_SimpleDesc_All:GetShow() then
      PaGlobal_Dialog_SimpleDesc_All_Close()
      PaGlobal_Dialog_Simple_All_Close()
      return
    end
    if nil ~= Panel_Dialog_Simple_All and true == Panel_Dialog_Simple_All:GetShow() then
      PaGlobal_Dialog_Simple_All_Close()
      return
    end
  elseif keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
    PaGlobal_Dialog_Simple_Interaction()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SequenceMode(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_CutSceneMode(deltaTime)
  if ToClient_cutsceneIsPlay() == true then
    if not MessageBox.isPopUp() then
      if true == ToClient_IsEnterSequence() and true == Panel_Window_CutSceneScript:GetShow() then
        local self = PaGlobal_CutSceneScript
        if true == self._ui._txt_dontSkip:GetShow() then
          self._showDontSkipTime = self._showDontSkipTime + deltaTime
        end
        if self._showDontSkipMaxTime < self._showDontSkipTime then
          self._showDontSkipTime = 0
          self._ui._txt_dontSkip:SetShow(false)
        end
        if self._enableDistanceCheckNakMaxTime < self._enableDistanceCheckNakTime then
          self._enableDistanceCheckNakTime = 0
          if PaGlobalFunc_Cutscene_SetEnableDistanceCheckNak ~= nil then
            PaGlobalFunc_Cutscene_SetEnableDistanceCheckNak(true)
          end
        elseif PaGlobalFunc_Cutscene_IsEnableDistanceCheckNak ~= nil and PaGlobalFunc_Cutscene_IsEnableDistanceCheckNak() == false then
          self._enableDistanceCheckNakTime = self._enableDistanceCheckNakTime + deltaTime
        end
        local isPressedSkipKeyFrame = false
        isPressedSkipKeyFrame = keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Dash)
        if isPressedSkipKeyFrame == true then
          ToClient_cutsceneSkipNextKeyFrame()
        end
        local isKeyDown_OnceESC = self:isKeyDown_OnceESC()
        local isKeyDown_OnceAny = self:isKeyDown_Once()
        local isPressedSkip = false
        local isPressedESC = false
        if _ContentsGroup_UsePadSnapping == true then
          isPressedSkip = isPadPressed(__eJoyPadInputType_Y)
          isPressedESC = isPadPressed(__eJoyPadInputType_Start)
        else
          isPressedSkip = keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
          if isPressedSkip == false then
            isPressedSkip = isPadPressed(__eJoyPadInputType_Y)
          end
          isPressedESC = keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Esc)
          if isPressedESC == false then
            isPressedESC = isKeyPressed(VCK.KeyCode_ESCAPE)
          end
        end
        if _ContentsGroup_UsePadSnapping == true then
          self._ui._stc_Rkey_console:SetShow(false)
          self._ui._stc_ESCkey_console:SetShow(false)
        else
          self._ui._stc_Rkey_pc:SetShow(false)
          self._ui._stc_ESCkey_pc:SetShow(false)
        end
        self._ui._stc_cancleAnno:SetShow(false)
        if self._skipState.Press_Any_Key == self._currentSkipState then
          self._ui._pg_keyPressTime:SetCurrentControlPos(0)
          self._ui._pg_keyPressTime:SetProgressRate(0)
          if isKeyDown_OnceESC == true then
            if _ContentsGroup_UsePadSnapping == true then
              self._ui._stc_ESCkey_console:SetShow(true)
            else
              self._ui._stc_ESCkey_pc:SetShow(true)
            end
            self._ui._stc_skipAnno:SetShow(false)
            self._currentSkipState = self._skipState.Press_ESC_Key
          elseif isKeyDown_OnceAny == true then
            local isForceSkip = ToClient_isForceSequenceSkip()
            local skipWrapper = ToClient_sequenceSkipWrapper()
            if skipWrapper == nil and isForceSkip == false then
              self._ui._stc_keyPress:SetShow(false)
              self._ui._txt_dontSkip:SetShow(true)
            else
              if _ContentsGroup_UsePadSnapping == true then
                self._ui._stc_Rkey_console:SetShow(true)
              else
                self._ui._stc_Rkey_pc:SetShow(true)
              end
              self._currentSkipState = self._skipState.Press_R_Key
            end
          end
        elseif self._skipState.Press_R_Key == self._currentSkipState then
          if isPressedSkip == true then
            self._ui._stc_keyPress:SetShow(true)
            self._ui._stc_skipAnno:SetShow(false)
            if true == _ContentsGroup_UsePadSnapping then
              self._ui._stc_Rkey_console:SetShow(true)
            else
              self._ui._stc_Rkey_pc:SetShow(true)
            end
            self._keyPressTime = self._keyPressTime + deltaTime
            self._ui._pg_keyPressTime:SetProgressRate(self._keyPressTime * 100 / self._keyPressMaxTime)
            if self._keyPressMaxTime <= self._keyPressTime then
              PaGlobal_CutSceneSkip_Open()
              self._currentSkipState = self._skipState.End
              self._ui._stc_keyPress:SetShow(false)
            end
          else
            self._keyPressTime = 0
            self._ui._pg_keyPressTime:SetCurrentControlPos(0)
            self._ui._pg_keyPressTime:SetProgressRate(0)
            self._ui._stc_keyPress:SetShow(false)
            if isKeyDown_OnceESC == true then
              self._ui._txt_dontSkip:SetShow(false)
              self._ui._stc_skipAnno:SetShow(false)
              self._ui._stc_cancleAnno:SetShow(false)
              if true == _ContentsGroup_UsePadSnapping then
                self._ui._stc_Rkey_console:SetShow(false)
                self._ui._stc_ESCkey_console:SetShow(true)
              else
                self._ui._stc_Rkey_pc:SetShow(false)
                self._ui._stc_ESCkey_pc:SetShow(true)
              end
              self._currentSkipState = self._skipState.Press_ESC_Key
            else
              self._ui._stc_skipAnno:SetShow(true)
              self._currentSkipState = self._skipState.Press_Any_Key
            end
          end
        elseif self._skipState.Press_ESC_Key == self._currentSkipState then
          self._ui._txt_dontSkip:SetShow(false)
          self._ui._stc_skipAnno:SetShow(false)
          if isPressedESC == true then
            self._ui._stc_cancleAnno:SetShow(true)
            self._ui._stc_keyPress:SetShow(true)
            if _ContentsGroup_UsePadSnapping == true then
              self._ui._stc_ESCkey_console:SetShow(true)
            else
              self._ui._stc_ESCkey_pc:SetShow(true)
            end
            self._keyPressTime = self._keyPressTime + deltaTime
            self._ui._pg_keyPressTime:SetProgressRate(self._keyPressTime * 100 / self._keyPressMaxTime)
            if self._keyPressMaxTime <= self._keyPressTime then
              self:cancleSequence()
              self._currentSkipState = self._skipState.End
              self._ui._stc_keyPress:SetShow(false)
            end
          else
            self._keyPressTime = 0
            self._ui._pg_keyPressTime:SetCurrentControlPos(0)
            self._ui._pg_keyPressTime:SetProgressRate(0)
            self._ui._stc_keyPress:SetShow(false)
            if isKeyDown_OnceAny == true then
              self._currentSkipState = self._skipState.Press_R_Key
            else
              self._currentSkipState = self._skipState.Press_Any_Key
            end
          end
        end
      end
      if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true and false == ToClient_IsEnterSequence() then
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
          content = PAGetString(Defines.StringSheet_GAME, "CUTSCENE_EXIT_MESSAGEBOX_MEMO"),
          functionYes = ToClient_CutsceneStop,
          functionNo = PaGlobalFunc_CutScene_ShowKeyGuide,
          exitButton = true,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
        PaGlobalFunc_CutScene_HideKeyGuide()
      end
    end
    if nil ~= Panel_MovieTheater_LowLevel_WindowClose then
      Panel_MovieTheater_LowLevel_WindowClose()
    end
    if Panel_Interaction ~= nil and Panel_Interaction:IsShow() == true or Panel_Widget_PanelInteraction_Renew ~= nil and Panel_Widget_PanelInteraction_Renew:IsShow() == true then
      local keyCode
      if _ContentsGroup_UsePadSnapping and (isPadInputIn() or true == ToClient_IsRemoteControlMode()) then
        keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode_Xbox(deltaTime)
      else
        keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode()
      end
      if nil ~= keyCode then
        Interaction_ExecuteByKeyMapping(keyCode)
      end
    elseif UI_Character_InterActionGathering_All ~= nil and UI_Character_InterActionGathering_All:GetShow() == true then
      local keyCode
      if _ContentsGroup_UsePadSnapping == true and (isPadInputIn() == true or ToClient_IsRemoteControlMode() == true) then
        keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode_Xbox(deltaTime)
      else
        keyCode = FGlobal_Interaction_CheckAndGetPressedKeyCode()
      end
      if keyCode ~= nil then
        PaGlobal_InteractionGathering_All_ButtonPushed(keyCode, nil)
      end
    end
  end
  if nil ~= Panel_ImageSlider_All and true == Panel_ImageSlider_All:GetShow() and true == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "ARTWORK_EXIT_MESSAGEBOX_MEMO"),
      functionYes = PaGlobalFunc_ImageCutScene_All_Close,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionKey(deltaTime)
  local isEnd = false
  local inputType
  if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
    inputType = PaGlobal_GameOption_All:GetKeyCustomInputType()
  elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Action_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionKey(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionKey(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      return
    elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Key()
    KeyCustom_Action_KeyButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPad(deltaTime)
  local isEnd = false
  local inputType
  if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
    inputType = PaGlobal_GameOption_All:GetKeyCustomInputType()
  elseif nil ~= PaGlobal_Option and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  elseif nil ~= Panel_Window_Option_Main and Panel_Window_Option_Main:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Action_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_DISAVAILABLE_REGISTER"))
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
    else
      PaGlobal_Option:CompleteKeyCustomMode()
    end
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPad(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPad(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
    else
      PaGlobal_Option:CompleteKeyCustomMode()
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_UiKey(deltaTime)
  local isEnd = false
  local inputType
  if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
    inputType = PaGlobal_GameOption_All:GetKeyCustomInputType()
  elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Ui_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_DISAVAILABLE_REGISTER"))
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
    else
      PaGlobal_Option:CompleteKeyCustomMode()
    end
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_UiKey(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_UiKey(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      return
    elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Ui_UpdateButtonText_Key()
    KeyCustom_Ui_KeyButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_UiPad(deltaTime)
  local isEnd = false
  local inputType
  if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
    inputType = PaGlobal_GameOption_All:GetKeyCustomInputType()
  elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
    inputType = PaGlobal_Option:GetKeyCustomInputType()
  else
    inputType = KeyCustom_Ui_GetInputType()
  end
  if nil == inputType or inputType < 0 then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_DISAVAILABLE_REGISTER"))
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
    else
      PaGlobal_Option:CompleteKeyCustomMode()
    end
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_UiPad(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_UiPad(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      return
    elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Ui_UpdateButtonText_Pad()
    KeyCustom_Ui_PadButtonCheckReset(inputType)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPadFunc1(deltaTime)
  local isEnd = false
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPadFunc1(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPadFunc1(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      return
    elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(0)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPadFunc2(deltaTime)
  local isEnd = false
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    keyCustom_Clear_ActionPadFunc2(inputType)
    isEnd = true
  elseif keyCustom_CheckAndSet_ActionPadFunc2(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All and true == PaGlobal_GameOption_All:isOpen() then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      return
    elseif true == _ContentsGroup_isNewOption and true == PaGlobal_Option:isOpen() then
      PaGlobal_Option:CompleteKeyCustomMode()
      return
    end
    KeyCustom_Action_UpdateButtonText_Pad()
    KeyCustom_Action_FuncPadButtonCheckReset(1)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_QuickMenu(delataTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_SkillPresetMemo ~= nil and Panel_Window_SkillPresetMemo:GetShow() == true then
      PaGlobalFunc_SkillPresetMemo_Close()
      return
    else
      FGlobal_ConsoleQuickMenuSetting_Close()
    end
  end
end
