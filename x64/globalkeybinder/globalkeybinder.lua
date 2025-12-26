local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
local fastPinDelta = 0
function PaGlobal_GlobalKeyBinder.Process_GameMode()
  DragManager:clearInfo()
  if nil ~= Panel_UIControl and Panel_UIControl:IsShow() then
    Panel_UIControl_SetShow(false)
    Panel_Menu_ShowToggle()
  end
  if ToClient_isConsole() == false and false == _ContentsGroup_RemasterUI_Party and Panel_PartyOption:GetShow() then
    PartyOption_Hide()
  end
  if ToClient_isConsole() == true then
    if true == ToClient_isCameraControlModeForConsole() then
      return
    end
    local isVisitHousePS = false
    if nil ~= PaGlobalFunc_Interaction_HouseList_IsVisitHousePS then
      isVisitHousePS = PaGlobalFunc_Interaction_HouseList_IsVisitHousePS()
    end
    local isVisitMansion = false
    local houseWrapper = housing_getHouseholdActor_CurrentPosition()
    if nil ~= houseWrapper then
      isVisitMansion = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isMansionLand()
    end
    local isVisitMyHouse = nil ~= PaGlobalFunc_HousingName_isMyHouse and true == PaGlobalFunc_HousingName_isMyHouse()
    local canUseInstallationMode = false == isVisitHousePS and false == ToClient_isPS() and false == isVisitMansion or true == isVisitMyHouse
    if true == _ContentsGroup_NewUI_InstallMode_All then
      if false == PaGlobal_HouseName_All_GetShowPanel() then
        return
      end
      if isPadUp(__eJoyPadInputType_DPad_Up) and true == canUseInstallationMode then
        HandleEventLUp_HouseName_All_InstallationMode()
      end
      if isPadUp(__eJoyPadInputType_DPad_Down) then
        HandleEventLUp_HouseName_All_ShowInven()
      end
      if isPadUp(__eJoyPadInputType_DPad_Left) then
        HandleEventLUp_HouseName_All_SetUnderwearToggle()
      end
      if isPadUp(__eJoyPadInputType_DPad_Right) then
        HandleEventLUp_HouseName_All_SetPetToggle()
        HandleEventLUp_HouseName_All_SetMaidToggle()
      end
    else
      if false == PaGlobalFunc_HousingName_GetShow() then
        return
      end
      if isPadUp(__eJoyPadInputType_DPad_Up) and true == canUseInstallationMode then
        PaGlobalFunc_HousingName_InstallationMode()
      end
      if isPadUp(__eJoyPadInputType_DPad_Down) then
        PaGlobalFunc_HousingName_ShowInven()
      end
      if isPadUp(__eJoyPadInputType_DPad_Left) then
        PaGlobalFunc_HousingName_ToggleHideWear()
      end
      if isPadUp(__eJoyPadInputType_DPad_Right) then
        PaGlobalFunc_HousingName_ToggleHideMadeAndPet()
      end
    end
  elseif true == _ContentsGroup_UsePadSnapping then
    if true == ToClient_isCameraControlModeForConsole() then
      return
    end
    if true == _ContentsGroup_NewUI_InstallMode_All then
      if false == PaGlobal_HouseName_All_GetShowPanel() then
        return
      end
      if isPadUp(__eJoyPadInputType_DPad_Up) then
        local isVisitMansion = ToClient_VisitHouseIsMansionLand()
        local isMyHouse = nil ~= PaGlobal_HouseName_All_IsVisitMyHouse and true == PaGlobal_HouseName_All_IsVisitMyHouse()
        if true == isMyHouse or false == isVisitMansion then
          HandleEventLUp_HouseName_All_InstallationMode()
        end
      end
      if isPadUp(__eJoyPadInputType_DPad_Down) then
        HandleEventLUp_HouseName_All_ShowInven()
      end
      if isPadUp(__eJoyPadInputType_DPad_Left) then
        HandleEventLUp_HouseName_All_SetUnderwearToggle()
      end
      if isPadUp(__eJoyPadInputType_DPad_Right) then
        HandleEventLUp_HouseName_All_SetPetToggle()
        HandleEventLUp_HouseName_All_SetMaidToggle()
      end
    end
  elseif true == _ContentsGroup_BackSpaceClearQuestGuide and true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and nil ~= HandleEventBackSpaceUp_CheckedQuest_ShowClearQuestNavi then
    HandleEventBackSpaceUp_CheckedQuest_ShowClearQuestNavi()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Housing(deltaTime)
  if ToClient_isConsole() == false then
    if true == _ContentsGroup_NewUI_InstallMode_All then
      if Panel_House_InstallationMode_VillageTent:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        VillageTent_Close()
        return
      elseif PaGlobal_FarmInfo_All_GetShowPanel() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_FarmInfo_All_Close()
        return
      end
      if false == _ContentsGroup_UsePadSnapping then
        if PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() and housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == ToClient_IsRemoteInstallMode() then
          PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
          return
        elseif PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() and not housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == ToClient_IsRemoteInstallMode() then
          PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
          return
        elseif PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() and true == PaGlobal_House_InstallationMode_ObjectControl_All_IsConfirmStep() and isKeyUpFor(VCK.KeyCode_SPACE) then
          if ToClient_isNeedHousingDetailMode() == false or PaGlobalFunc_InstallationMode_IsDetailMode == nil then
            PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
            return
          elseif PaGlobalFunc_InstallationMode_IsDetailMode() == false then
            PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
            return
          end
        elseif not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
          Panel_Housing_CancelModeFromKeyBinder()
          return
        end
        for key = VCK.KeyCode_1, VCK.KeyCode_8 do
          local keyNumber = key - VCK.KeyCode_1 + 1
          if keyNumber >= 1 and keyNumber <= 8 and true == isKeyDown_Once(key) then
            PaGlobal_Farm_InstallationList_All_HotKeyInstall(keyNumber)
          end
        end
      elseif PaGlobal_House_Installation_All_GetPanelShow() and PaGlobal_House_Installation_All_CanGetInput() then
        if PaGlobal_House_Installation_All_IsConfirm() and isPadUp(__eJoyPadInputType_A) then
          PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
          return
        end
        if PaGlobal_House_Installation_All_IsCanMove() and isPadUp(__eJoyPadInputType_Y) then
          PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
          return
        end
        if PaGlobal_House_Installation_All_IsCanDelete() and isPadUp(__eJoyPadInputType_X) then
          PaGlobal_House_InstallationMode_ObjectControl_All_ObjectDelete()
          return
        end
      end
      if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        Panel_Housing_CancelModeFromKeyBinder()
        return
      end
    elseif Panel_House_InstallationMode_VillageTent:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      VillageTent_Close()
      return
    elseif Panel_Housing_FarmInfo_New:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PAHousing_FarmInfo_Close()
      return
    elseif Panel_House_InstallationMode_ObjectControl:GetShow() and housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_HouseInstallationControl_Move()
      return
    elseif Panel_House_InstallationMode_ObjectControl:GetShow() and not housing_isBuildMode() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_HouseInstallationControl_Close()
      return
    elseif Panel_House_InstallationMode_ObjectControl:GetShow() and not housing_isBuildMode() and true == FGlobal_HouseInstallationControl_IsConfirmStep() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      FGlobal_HouseInstallationControl_Confirm()
      return
    elseif not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_Housing_CancelModeFromKeyBinder()
      return
    end
  end
  if ToClient_isConsole() == true then
    if true == _ContentsGroup_NewUI_InstallMode_All then
      if PaGlobal_FarmInfo_All_GetShowPanel() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_FarmInfo_All_Close()
        return
      end
      if PaGlobal_House_Installation_All_GetPanelShow() then
        if PaGlobal_House_Installation_All_CanGetInput() then
          if PaGlobal_House_Installation_All_IsConfirm() and isPadUp(__eJoyPadInputType_A) then
            PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
            return
          end
          if PaGlobal_House_Installation_All_IsCanMove() and isPadUp(__eJoyPadInputType_Y) then
            PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
            return
          end
          if PaGlobal_House_Installation_All_IsCanDelete() and isPadUp(__eJoyPadInputType_X) then
            PaGlobal_House_InstallationMode_ObjectControl_All_ObjectDelete()
            return
          end
          if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
            if PaGlobalFunc_VillageTentPopup_GetShow() then
              PaGlobalFunc_VillageTent_Close()
              return
            end
            Panel_Housing_CancelModeFromKeyBinder()
            return
          end
        end
        if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
          Panel_Housing_CancelModeFromKeyBinder()
          return
        end
      end
    else
      if true == PaGlobalFunc_InstallationMode_PlantInfo_GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobalFunc_InstallationMode_PlantInfo_Exit()
        return
      end
      if PaGlobalFunc_InstallationMode_House_GetShow() then
        if PaGlobalFunc_InstallationMode_Manager_CanGetInput() then
          if PaGlobalFunc_InstallationMode_Manager_CanGetConfirm() and isPadUp(__eJoyPadInputType_A) then
            PaGlobalFunc_InstallationMode_House_ClickConfirm()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetMove() and isPadUp(__eJoyPadInputType_Y) then
            PaGlobalFunc_InstallationMode_House_ClickMove()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetDelete() and isPadUp(__eJoyPadInputType_X) then
            PaGlobalFunc_InstallationMode_House_ClickDelete()
            return
          end
          if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
            PaGlobalFunc_InstallationMode_House_ClickCancel()
            return
          end
        end
        if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
          Panel_Housing_CancelModeFromKeyBinder()
          return
        end
      end
      if PaGlobalFunc_InstallationMode_Item_GetShow() then
        if PaGlobalFunc_InstallationMode_Manager_CanGetInput() then
          if PaGlobalFunc_InstallationMode_Manager_CanGetConfirm() and isPadUp(__eJoyPadInputType_A) then
            PaGlobalFunc_InstallationMode_Item_ClickConfirm()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetMove() and isPadUp(__eJoyPadInputType_Y) then
            PaGlobalFunc_InstallationMode_Item_ClickMove()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetDelete() and isPadUp(__eJoyPadInputType_X) then
            PaGlobalFunc_InstallationMode_Item_ClickDelete()
            return
          end
          if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
            if PaGlobalFunc_VillageTentPopup_GetShow() then
              PaGlobalFunc_VillageTent_Close()
              return
            end
            Panel_Housing_CancelModeFromKeyBinder()
            return
          end
        end
        if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
          Panel_Housing_CancelModeFromKeyBinder()
          return
        end
      end
      if PaGlobalFunc_InstallationMode_Farm_GetShow() then
        if PaGlobalFunc_InstallationMode_Manager_CanGetInput() then
          if PaGlobalFunc_InstallationMode_Manager_CanGetConfirm() and isPadUp(__eJoyPadInputType_A) then
            PaGlobalFunc_InstallationMode_Farm_ClickConfirm()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetMove() and isPadUp(__eJoyPadInputType_Y) then
            PaGlobalFunc_InstallationMode_Farm_ClickMove()
            return
          end
          if PaGlobalFunc_InstallationMode_Manager_CanGetDelete() and isPadUp(__eJoyPadInputType_X) then
            PaGlobalFunc_InstallationMode_Farm_ClickDelete()
            return
          end
          if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
            Panel_Housing_CancelModeFromKeyBinder()
            return
          end
        end
        if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
          Panel_Housing_CancelModeFromKeyBinder()
          return
        end
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Mental(deltaTime)
  if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_MentalKnowledge)) then
    if false == _ContentsGroup_RenewUI_Knowledge then
      Panel_Knowledge_Hide()
    else
      PaGlobalFunc_Window_Knowledge_Exit()
    end
  end
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
    PaGlobalFunc_TotalSearch_Open()
    return
  end
  if (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_MBACK_BUTTON) == true or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) == true) and PaGlobal_Knowledge_StoryBack ~= nil then
    PaGlobal_Knowledge_StoryBack()
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_MFRONT_BUTTON) == true and PaGlobal_Knowledge_StoryFront ~= nil then
    PaGlobal_Knowledge_StoryFront()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_MentalGame(deltaTime)
  if ToClient_isConsole() == false then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LEFT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_A) then
      HandleEventLDown_MentalGame_All_CardRotation(true)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RIGHT) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_D) then
      HandleEventLDown_MentalGame_All_CardRotation(false)
    end
    if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_MentalGame_All_Close()
      SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
    end
  elseif false == getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PaGlobalFunc_MentalGame_All_Close()
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  end
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
      if nil ~= Panel_EndingCredit_All and Panel_EndingCredit_All:GetShow() == true then
        return
      end
      if nil ~= Panel_CreateGuild and Panel_CreateGuild:GetShow() then
        return
      end
      if nil ~= Panel_GuildHouse_Auction_All and Panel_GuildHouse_Auction_All:GetShow() then
        return
      end
      if Panel_DetectPlayer:GetShow() then
        return
      end
      if nil ~= Panel_Atoraxion_Enter and true == Panel_Atoraxion_Enter:GetShow() then
        return
      end
      if nil ~= Panel_Atoraxion_Select and true == Panel_Atoraxion_Select:GetShow() then
        return
      end
      if nil ~= Panel_Window_Guide_All and true == Panel_Window_Guide_All:GetShow() then
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
        if ACT.ActionInputType_CrouchOrSkill == PaGlobal_DialogMain_All._HOTKEY[idx].key and keyCustom_IsUp_Action_WithoutPad(ACT.ActionInputType_CrouchOrSkill) == true then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_MoveFront == PaGlobal_DialogMain_All._HOTKEY[idx].key and keyCustom_IsUp_Action_WithoutPad(ACT.ActionInputType_MoveFront) == true then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_GrabOrGuard == PaGlobal_DialogMain_All._HOTKEY[idx].key and keyCustom_IsUp_Action_WithoutPad(ACT.ActionInputType_GrabOrGuard) == true then
          HandleEventKeyUp_DialogMain_All_HotKeyClick(idx)
          return
        elseif ACT.ActionInputType_MoveLeft == PaGlobal_DialogMain_All._HOTKEY[idx].key and keyCustom_IsUp_Action_WithoutPad(ACT.ActionInputType_MoveLeft) == true then
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
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) then
    PaGlobalFunc_TotalSearch_Open()
    return
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
  if PaGlobal_Guild_Create_All_checkedGuildEditUI(GetFocusEdit()) then
    if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_Guild_Create_All_Close()
    end
    return
  end
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All ~= nil and Panel_Widget_Enchant_Main_All:GetShow() == true and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Inventory) then
    HandleEventLUp_EnchantMain_Inventory()
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and ToClient_isConsole() == false and nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
    HandleEventEnter_DialogQuest_All_SelectConfirmReward()
    audioPostEvent_SystemUi(0, 0)
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    return
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if nil ~= Panel_EndingCredit_All and Panel_EndingCredit_All:GetShow() == true then
      PaGlobal_EndingCredit:messageBoxOpen()
      return
    end
    if Panel_ContentsTutorial_All ~= nil and Panel_ContentsTutorial_All:GetShow() == true then
      PaGlobalFunc_ContentsTutorial_All_CancleTutorial()
      return
    end
    if Panel_ProductNote ~= nil and Panel_ProductNote:GetShow() == true and Panel_ProductNote:IsUISubApp() == false then
      Panel_ProductNote_ShowToggle()
      return
    end
    if nil ~= Panel_Window_TotalSearch and true == PaGlobalFunc_TotalSearch_GetShow() then
      PaGlobalFunc_TotalSearch_Close()
      return
    end
    if true == _ContentsGroup_UsePadSnapping and true == Panel_Popup_MoveItem:GetShow() then
      PopupMoveItem_Close()
      return
    end
    if true == _ContentsGroup_UsePadSnapping and true == Panel_Widget_Knowledge:GetShow() then
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
      if true == Panel_Window_Socket_All:GetShow() then
        HandleEventPadB_Socket_All_Back()
        return
      end
      if true == Panel_Window_Improvement_All:GetShow() then
        HandleEventPressB_Improvement_All_Back()
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
      if true == Panel_Window_Improvement_All:GetShow() then
        if _ContentsGroup_UsePadSnapping == true then
          HandleEventPressB_Improvement_All_Back()
        else
          PaGlobalFunc_Improvement_All_Close()
        end
        return
      end
      if true == Panel_Window_Socket_All:GetShow() then
        if _ContentsGroup_UsePadSnapping == true then
          HandleEventPadB_Socket_All_Back()
        else
          PaGlobalFunc_Socket_All_Close()
        end
        return
      end
      if Panel_Window_JewelPreset_All:GetShow() == true or Panel_Window_JewelPreset_Inven_All:GetShow() == true then
        PaGlobalFunc_JewelPreset_CloseWithESC()
        return
      end
    end
    if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All ~= nil and Panel_Widget_Enchant_Main_All:GetShow() == true then
      if Panel_Window_EnchantStackConfirm_All ~= nil and Panel_Window_EnchantStackConfirm_All:GetShow() == true then
        PaGlobalFunc_EnchantStackConfirm_All_Close()
        return
      end
      if nil ~= Panel_OtherUser_AdditionalRate_All and true == Panel_OtherUser_AdditionalRate_All:GetShow() then
        PaGlobalFunc_OtherUser_TriedStack_Close()
        return
      end
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
    if ToClient_isConsole() == true and true == PaGlobalFunc_DetectPlayer_GetShow() then
      PaGlobalFunc_DetectPlayer_Exit()
      return
    end
    if nil ~= PaGlobalFunc_Dialog_SkillSpecialize_GetShow and true == PaGlobalFunc_Dialog_SkillSpecialize_GetShow() then
      PaGlobalFunc_Dialog_SkillSpecialize_Close(true)
      return
    end
    if nil ~= Panel_Window_BlackSpiritAdventure and Panel_Window_BlackSpiritAdventure:GetShow() then
      FGlobal_BlackSpiritAdventure_Close_CheckUiSub()
    end
    if Panel_PartyContentRecurit ~= nil and Panel_PartyContentRecurit:GetShow() == true then
      PaGlobalFunc_PartyContentsRecruit_Close()
      return
    end
    if nil ~= PaGlobalFunc_LordMenu_GetShow and true == PaGlobalFunc_LordMenu_GetShow() then
      HandleEventLUp_LordMenu_All_Close()
      return
    end
    if nil == Panel_WebControl then
      UI.ASSERT_NAME(false, "Panel_WebControl\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\234\185\128\236\157\152\236\167\132")
      return
    elseif true == Panel_WebControl:GetShow() then
      Panel_WebHelper_ShowToggle()
      return
    end
    if nil ~= Panel_GuildHouse_Auction_Bid_All and true == Panel_GuildHouse_Auction_Bid_All:GetShow() then
      PaGlobal_GuildHouse_Auction_Bid_All_Close()
      return
    end
    if nil ~= Panel_GuildHouse_Auction_Detail_All and true == Panel_GuildHouse_Auction_Detail_All:GetShow() then
      PaGlobal_GuildHouse_Auction_Detail_All_Close()
      return
    end
    if nil ~= Panel_Guild_Create_All and true == Panel_Guild_Create_All:GetShow() then
      PaGlobal_Guild_Create_All_Close()
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
    if Panel_Window_RewardMarket_All ~= nil and Panel_Window_RewardMarket_All:GetShow() == true then
      PaGlobalFunc_RewardMarket_Close()
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
    if ToClient_isConsole() == false then
      if PaGlobal_VehicleInfo_All_GetPanelShow() == true then
        PaGlobal_VehicleInfo_All_Close()
      end
    elseif nil ~= PaGlobalFunc_ServantInfo_Exit then
      PaGlobalFunc_ServantInfo_Exit()
    end
    if nil ~= Panel_Window_ServantInventory then
      ServantInventory_Close()
    end
    return
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Inventory) then
    local isAuctionState = false
    isAuctionState = PaGlobalFunc_DialogMain_All_GetAuctionState()
    if true == isAuctionState then
      local isInvenOpen = false
      if true == _ContentsGroup_NewUI_Inventory_All then
        isInvenOpen = Panel_Window_Inventory_All:IsShow()
      else
        isInvenOpen = Panel_Window_Inventory:IsShow()
      end
      if isInvenOpen == false then
        InventoryWindow_Show()
        Inventory_SetFunctor(nil, nil, nil, nil)
        return
      end
      if Panel_Window_Inventory ~= nil or Panel_Window_Inventory_All ~= nil then
        InventoryWindow_Close()
        return
      end
    end
  end
  if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Chat) then
    if ToClient_IsGroupEnchantAble() == true or PaGlobal_SpiritEnchant_All._isEndGroupEnchant == true then
      ChatInput_Show()
      ChatInput_ChangeChatType_Immediately(CppEnums.ChatType.Party)
    end
    return
  end
  if false == _ContentsGroup_RenewUI_SearchMode then
    local panel
    if true == _ContentsGroup_NewUI_DialogSearch_All then
      panel = Panel_Widget_Dialog_Search_All
    else
      panel = Panel_Dialog_Search
    end
    if nil ~= panel and true == panel:GetShow() then
      if isKeyPressed(VCK.KeyCode_A) then
        searchView_PushLeft()
      elseif isKeyPressed(VCK.KeyCode_S) then
        searchView_PushBottom()
      elseif isKeyPressed(VCK.KeyCode_D) then
        searchView_PushRight()
      elseif isKeyPressed(VCK.KeyCode_W) then
        searchView_PushTop()
      elseif isKeyPressed(VCK.KeyCode_Q) then
        searchView_ZoomIn()
      elseif isKeyPressed(VCK.KeyCode_E) then
        searchView_ZoomOut()
      end
      searchView_CheckDistance()
    end
  elseif PaGlobalFunc_SearchMode_IsSearchMode() then
    if isPadPressed(__eJoyPadInputType_RightStick_Left) then
      searchView_PushLeft()
    end
    if isPadPressed(__eJoyPadInputType_RightStick_Right) then
      searchView_PushRight()
    end
    if isPadPressed(__eJoyPadInputType_LeftTrigger) and isPadPressed(__eJoyPadInputType_RightStick_Up) then
      searchView_ZoomIn()
    elseif isPadPressed(__eJoyPadInputType_RightStick_Up) then
      searchView_PushTop()
    end
    if isPadPressed(__eJoyPadInputType_LeftTrigger) and isPadPressed(__eJoyPadInputType_RightStick_Down) then
      searchView_ZoomOut()
    elseif isPadPressed(__eJoyPadInputType_RightStick_Down) then
      searchView_PushBottom()
    end
    searchView_CheckDistance()
  end
  if PaGlobalFunc_ItemMarketRegistItem_GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    FGlobal_ItemMarketRegistItem_RegistDO()
  end
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_EnterAbyssOne(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Trade(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and nil ~= Panel_Dialog_Trade_Function_All then
    HandleEventLUp_TradeFunction_All_Close()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_WorldMap(deltaTime)
  if false == _ContentsGroup_RenewUI_WorldMap then
    if FGlobal_IsFadeOutState() then
      return
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if false == FGlobal_WorldMapWindowEscape() then
        return
      end
    elseif FGlobal_AskCloseWorldMap() then
      FGlobal_PopCloseWorldMap()
    elseif _ContentsGroup_WorldmapButtonShortcuts == true and ToClient_CheckAndRunWorldmapButtonShortcut() == true then
      return
    elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Chat) then
      if false == _ContentsGroup_RenewUI_Chatting then
        if not PaGlobalFunc_ItemMarket_GetShow() then
          ChatInput_Show()
          return
        else
          return
        end
      end
    elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_WorldMap) then
      FGlobal_CloseWorldmapForLuaKeyHandling()
      return
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      BtnEvent_InMyPosition()
      return
    elseif isKeyPressed(VCK.KeyCode_MENU) then
      for ii = VCK.KeyCode_0, VCK.KeyCode_9 do
        local key = ii - VCK.KeyCode_0
        if isKeyDown_Once(ii) then
          ToClient_SetWorldMapQuickScreenPosition(key)
          UpdateBtn_WorldMapCameraSaveSlotMonoTone(key)
          return
        end
      end
    end
    for ii = VCK.KeyCode_0, VCK.KeyCode_9 do
      local key = ii - VCK.KeyCode_0
      if isKeyDown_Once(ii) then
        HandleEventLUp_Btn_CameraSaveSlot(key)
        return
      end
    end
    if FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
      FGlobal_HandleClicked_ItemMarketBackPage()
    end
    if (isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_CBT and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_ProductionNote) then
      if nil ~= Panel_ProductNote then
        Panel_ProductNote_ShowToggle()
      end
      return
    end
    if true == isKeyPressed(VCK.KeyCode_MENU) and true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_OEM_3) and nil ~= PaGlobal_Ping_All_Open then
      PaGlobal_Ping_All_Open(false)
      ToClient_showWorldmapKeyGuide(false)
    end
    if CommonWindowFunction(__eUiInputType_PositionNotify, Process_UIMode_CommonWindow_PingTypeSelect) then
      return
    end
    if CommonWindowFunction(__eUiInputType_PingType_Attack, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Attack) then
      return
    end
    if CommonWindowFunction(__eUiInputType_PingType_Move, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Move) then
      return
    end
    if CommonWindowFunction(__eUiInputType_PingType_Reader, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Help) then
      return
    end
    if CommonWindowFunction(__eUiInputType_PingType_Caution, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Dangerous) then
      return
    end
    if nil == Panel_Widget_Ping_All or false == Panel_Widget_Ping_All:GetShow() then
      if isKeyPressed(VCK.KeyCode_CONTROL) then
        ToClient_showWorldmapKeyGuide(true)
      elseif isKeyPressed(VCK.KeyCode_SHIFT) then
        ToClient_showWorldmapKeyGuide(true)
      elseif isKeyPressed(VCK.KeyCode_MENU) then
        ToClient_showWorldmapKeyGuide(true)
      else
        ToClient_showWorldmapKeyGuide(false)
      end
    end
    if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
      PaGlobalFunc_TotalSearch_Open()
      return
    end
    if ToClient_SelfPlayerIsGM() then
      if isKeyDown_Once(VCK.KeyCode_F1) then
        ToClient_RequestSiegeObserverInfo()
      elseif isKeyDown_Once(VCK.KeyCode_F2) then
        PaGlobal_Worldmap_Grand_GuildColorList_Toggle()
      elseif isKeyDown_Once(VCK.KeyCode_F3) then
        ToClient_ClearObserverGuildMemberList()
      elseif isKeyDown_Once(VCK.KeyCode_F4) then
        if nil ~= PaGlobalFunc_WorldmapGrand_ToggleButtonByObserver then
          PaGlobalFunc_WorldmapGrand_ToggleButtonByObserver()
        end
        if nil ~= PaGlobalFunc_WorldmapMain_ToggleButtonByObserver then
          PaGlobalFunc_WorldmapMain_ToggleButtonByObserver()
        end
      end
    end
  else
    if PaGlobalFunc_WorldMap_GetIsFadeOut() then
      return
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if PaGlobalFunc_ItemMarketBidDesc_GetShow() then
        Panel_ItemMarket_BidDesc_Hide()
        return
      end
      if PaGlobalFunc_ItemMarket_GetShow() and PaGlobalFunc_ItemMarket_IsUISubApp() == false then
        FGolbal_ItemMarketNew_Close()
        return
      end
      if PaGlobalFunc_ItemMarketItemSet_GetShow() then
        FGlobal_ItemMarketItemSet_Close()
        return
      end
      if nil ~= Panel_MovieWorldMapGuide_Web and Panel_MovieWorldMapGuide_Web:GetShow() then
        PaGlobal_MovieGuide_Weblist:Close()
        return
      end
      if nil ~= PaGlobalFunc_QuestInfo_All_GetShow and true == PaGlobalFunc_QuestInfo_All_GetShow() then
        PaGlobalFunc_QuestInfo_All_Close()
        return
      end
      if Panel_MorningLand_MyReward_All ~= nil and Panel_MorningLand_MyReward_All:GetShow() == true then
        PaGlobalFunc_MorningMyReward_Close()
        return
      end
      if Panel_MorningLand_BossRanking ~= nil and Panel_MorningLand_BossRanking:GetShow() == true then
        PaGlobalFunc_MorningBossRank_Close()
        return
      end
      if Panel_MorningLand_ConquestHistory ~= nil and Panel_MorningLand_ConquestHistory:GetShow() == true then
        PaGlobal_MorningLand_ConquestHistory_All_Close()
        return
      end
      if Panel_Window_MorningLand_Boss_All ~= nil and Panel_Window_MorningLand_Boss_All:GetShow() == true then
        PaGlobal_MorningLand_Boss_All_Close()
        return
      end
      if _ContentsGroup_WorldMapFamilyCharacterManagement == true and PaGlobalFunc_WorldMap_CheckEsapceWorldMap() == false then
        return
      end
      PaGlobalFunc_WorldMap_WindowEscape()
    elseif PaGlobalFunc_WorldMap_GetIsClose() then
      PaGlobalFunc_WorldMap_PopClose()
    elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_WorldMap) then
      PaGlobalFunc_WorldMap_CloseForLuaKeyHandling()
      return
    end
    if FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
      FGlobal_HandleClicked_ItemMarketBackPage()
    end
    if (isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_CBT and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_ProductionNote) then
      if nil ~= Panel_ProductNote then
        Panel_ProductNote_ShowToggle()
      end
      return
    end
    if nil ~= Panel_WorldMap_StableList and nil ~= PaGlobalFunc_WorldMapStableList_IsYPressTooltipShow and true == PaGlobalFunc_WorldMapStableList_IsYPressTooltipShow() and false == isPadPressed(__eJoyPadInputType_Y) then
      HandleEventPadDown_WorldMap_StableList_YPressTooltipToggle(false)
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_WorldMapSearch(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ClearFocusEdit()
    if ToClient_WorldMapIsShow() then
      SetUIMode(Defines.UIMode.eUIMode_WorldMap)
    else
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Stable(deltaTime)
  if _ContentsGroup_FantasyHorse == true and Panel_Widget_Servant_FantasySkin_Complete_All:GetShow() == true then
    return
  end
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) then
    PaGlobalFunc_TotalSearch_Open()
    return
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_ContentsTutorial_All ~= nil and Panel_ContentsTutorial_All:GetShow() == true then
      PaGlobalFunc_ContentsTutorial_All_CancleTutorial()
      return
    end
    if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
      PaGlobalFunc_TotalSearch_Close()
      return
    end
    if __eServantTypeVehicle == stable_getServantType() then
      if Panel_IngameCashShop_EasyPayment:IsShow() then
        PaGlobalFunc_EasyBuy_Close()
      elseif nil ~= Panel_Dialog_ServantSwiftTraining_All and true == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
        PaGlobalFunc_ServantSwiftTraining_All_Close()
      elseif nil ~= Panel_Dialog_Servant_FantasySelect_All and true == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
        PaGlobalFunc_Servant_FantasySelect_All_Close()
      elseif nil ~= Panel_Dialog_ServantExchange_Fantasy_All and true == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
        PaGlobalFunc_ServantExchange_Fantasy_All_Close()
      elseif nil ~= Panel_Dialog_ServantFunction_All and true == Panel_Dialog_ServantFunction_All:GetShow() then
        PaGlobalFunc_ServantFunction_All_Close()
      elseif _ContentsGroup_HorseSimulator == true and Panel_Dialog_ServantSimulator ~= nil and Panel_Dialog_ServantSimulator:GetShow() == true then
        if Panel_Dialog_ServantSimulatorSubView ~= nil and Panel_Dialog_ServantSimulatorSubView:GetShow() == true then
          PaGlobalFunc_ServantSimulatorSubView_Close()
          return
        end
        PaGlobalFunc_ServantFunction_All_Close()
      end
    elseif __eServantTypeShip == stable_getServantType() then
      if Panel_Window_Barter_Refresh ~= nil and Panel_Window_Barter_Refresh:GetShow() == true then
        PaGlobal_BarterInfoRefresh:close()
        return
      end
      if Panel_Window_Barter_Search ~= nil and Panel_Window_Barter_Search:GetShow() == true then
        if MarketPlace ~= nil and MarketPlace:GetShow() == true then
          MarketPlace:close()
          return
        end
        if Panel_Window_MarketPlace_WalletInventory ~= nil and Panel_Window_MarketPlace_WalletInventory:GetShow() == true or Panel_Window_MarketPlace_MyInventory ~= nil and Panel_Window_MarketPlace_MyInventory:GetShow() == true then
          PaGlobalFunc_MarketPlace_CloseAllCheck()
          return false
        end
      end
      if nil ~= Panel_Window_ExpirienceWiki_All and true == Panel_Window_ExpirienceWiki_All:GetShow() and nil ~= PaGlobal_ExpirienceWiki_All_Close_FromESC then
        PaGlobal_ExpirienceWiki_All_Close_FromESC()
        return
      end
      if nil ~= Panel_Dialog_ServantExtension_All_Tree and true == Panel_Dialog_ServantExtension_All_Tree:GetShow() then
        PaGlobal_ServantUpgrade_Tree_Close()
        return
      end
      if nil ~= Panel_Window_ServantUpgrade and true == Panel_Window_ServantUpgrade:GetShow() then
        PaGlobal_ServantUpgrade_Close()
        return
      end
      if nil ~= Panel_Window_SailorRestore_All and true == Panel_Window_SailorRestore_All:GetShow() then
        PaGlobal_SailorRestore_All:prepareClose()
        return
      end
      if nil ~= Panel_Window_Sailor_Onboard_All and true == Panel_Window_Sailor_Onboard_All:GetShow() then
        PaGlobal_SailorOnBoard_All:prepareClose()
        return
      end
      if nil ~= Panel_Dialog_ServantFunction_All then
        PaGlobalFunc_ServantFunction_All_Close()
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_MiniGame(deltaTime)
  local MiniGame_FillGauge_Mouse = Panel_FillGauge:IsShow()
  if true == _ContentsGroup_UsePadSnapping then
    if nil ~= Panel_Pearlshop_Category and true == Panel_Pearlshop_Category:GetShow() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
      InGameShop_CloseActual()
      return
    end
    if true == MessageBoxGetShow() and true == MessageBox_GetPadState() and isPadPressed(__eJoyPadInputType_A) then
      MessageBox_SetPadState(false)
      MessageBox.keyProcessEnter()
      return
    end
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    close_WindowPanelList()
    if nil ~= PaGlobalFunc_DailyStamp_GetShowPanel and PaGlobalFunc_DailyStamp_GetShowPanel() then
      DailStamp_Hide()
      return
    end
    if nil ~= Panel_Window_DailyStamp_All and true == Panel_Window_DailyStamp_All:GetShow() then
      PaGlobalFunc_DailyStamp_All_Close()
      return
    end
    if nil ~= Panel_Window_DailyChallenge and Panel_Window_DailyChallenge:GetShow() then
      PaGlobalFunc_DailyChallenge_Close()
      TooltipSimple_Hide()
      return
    end
  end
  if MiniGame_FillGauge_Mouse then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_LBUTTON) then
      FillGauge_UpdateGauge(deltaTime, true)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RBUTTON) then
      FillGauge_UpdateGauge(deltaTime, false)
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_DeadMessage(deltaTime)
  if ToClient_isConsole() == false then
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if FGlobal_WorldMapWindowEscape ~= nil and FGlobal_WorldMapWindowEscape() == false then
        return
      end
      if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() and nil ~= Panel_ProductNote_ShowToggle then
        Panel_ProductNote_ShowToggle()
        return
      end
      if true == _ContentsGroup_WikiNoToURL then
        if nil ~= Panel_Window_ExpirienceWiki_All and true == Panel_Window_ExpirienceWiki_All:GetShow() and nil ~= PaGlobal_ExpirienceWiki_All_Close_FromESC then
          PaGlobal_ExpirienceWiki_All_Close_FromESC()
          return
        end
      elseif nil ~= Panel_WebControl and true == Panel_WebControl:GetShow() and nil ~= FGlobal_WebHelper_ForceClose then
        FGlobal_WebHelper_ForceClose()
        return
      end
    end
    if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Chat) then
      ChatInput_Show()
      return
    end
    if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_WorldMap) then
      FGlobal_CloseWorldmapForLuaKeyHandling()
      return
    end
    if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Guild) then
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil ~= guildWrapper then
        local guildGrade = guildWrapper:getGuildGrade()
        if 0 == guildGrade then
          if false == Panel_Window_ClanList_All:IsShow() then
            audioPostEvent_SystemUi(1, 36)
            _AudioPostEvent_SystemUiForXBOX(1, 36)
            PaGlobal_ClanList_All_Open()
          else
            audioPostEvent_SystemUi(1, 31)
            _AudioPostEvent_SystemUiForXBOX(1, 31)
            PaGlobal_ClanList_All_Close()
          end
        elseif nil ~= Panel_GuildMain_All then
          if false == Panel_GuildMain_All:GetShow() then
            if false == Panel_Window_DeadMessage_All:GetShow() then
              audioPostEvent_SystemUi(1, 36)
              _AudioPostEvent_SystemUiForXBOX(1, 36)
              PaGlobalFunc_GuildMain_All_Open()
            end
          else
            audioPostEvent_SystemUi(1, 31)
            _AudioPostEvent_SystemUiForXBOX(1, 31)
            PaGlobalFunc_GuildMain_All_Close()
          end
        else
          local isPanelGuildShow = false
          if nil == PaGlobal_GuildPanelLoad_GetShowPanelGuildMain then
            isPanelGuildShow = Panel_Window_Guild:IsShow()
          else
            isPanelGuildShow = PaGlobal_GuildPanelLoad_GetShowPanelGuildMain()
          end
          if false == isPanelGuildShow then
            if false == Panel_Window_DeadMessage_All:GetShow() then
              audioPostEvent_SystemUi(1, 36)
              _AudioPostEvent_SystemUiForXBOX(1, 36)
              GuildManager:Show()
            end
          else
            audioPostEvent_SystemUi(1, 31)
            _AudioPostEvent_SystemUiForXBOX(1, 31)
            GuildManager:Hide()
          end
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
      end
      if true == Panel_Window_DeadMessage_All:GetShow() then
        if nil ~= Panel_GuildMain_All then
          PaGlobalFunc_GuildMain_All_Close()
        else
          GuildManager:Hide()
        end
      end
    end
  elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Chat) then
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Cash_Revival_BuyItem_All ~= nil and Panel_Cash_Revival_BuyItem_All:GetShow() == true then
      PaGlobal_Cash_Revival_BuyItem_All_Close()
      return
    end
    if Panel_Window_BeginnerEnchantGuide_All ~= nil and Panel_Window_BeginnerEnchantGuide_All:GetShow() == true then
      PaGlobalFunc_BeginnerEnchantGuide_Close()
      return
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_PreventMoveNSkill(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Movie(deltaTime)
  if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) == true or isPadDown(__eJoyPadInputType_Start) == true) then
    if check_ShowWindow() then
      close_WindowPanelList()
      return
    elseif Panel_UIControl:IsShow() then
      Panel_UIControl_SetShow(false)
      Panel_Menu_ShowToggle()
      return
    else
      Panel_UIControl_SetShow(true)
      Panel_Menu_ShowToggle()
      return
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_GameExit(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if ToClient_isConsole() == false then
      if true == Panel_Window_DeliveryForGameExit:GetShow() then
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
      elseif true == Panel_Window_TrayConfirm_All:GetShow() then
        PaGlobalFunc_ExitTrayConfirm_All_Close()
      else
        PaGlobal_GameExit_All_ShowToggle(false)
      end
    else
      if true == Panel_Window_DeliveryForGameExit:GetShow() then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_Repair(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if ToClient_isConsole() == true then
      if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
        PaGlobal_Endurance_Recovery_All_Close()
      elseif nil ~= Panel_Dialog_Repair_Function_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
        if nil ~= Panel_Window_Inventory and true == PaGlobalFunc_InventoryInfo_GetShow() then
          PaGlobalFunc_InventoryInfo_Close()
        else
          PaGlobalFunc_RepairFunc_All_Close()
        end
      end
    else
      local repairClose = function()
        PaGlobalFunc_RepairFunc_All_Close()
      end
      if nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
        PaGlobal_Endurance_Recovery_All_Close()
      else
        repairClose()
      end
    end
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ActionPad_XBOX(deltaTime)
  local isEnd = false
  local inputType
  if true == _ContentsGroup_NewUI_GameOption_All then
    inputType = PaGlobal_GameOption_All:GetKeyCustomInputType()
  else
    inputType = PaGlobal_Option:GetKeyCustomInputType()
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
  local updateAvailable = false
  if isPadUp(__eJoyPadInputType_A) or isPadUp(__eJoyPadInputType_B) or isPadUp(__eJoyPadInputType_X) or isPadUp(__eJoyPadInputType_Y) or isPadUp(__eJoyPadInputType_RightTrigger) or isPadUp(__eJoyPadInputType_LeftTrigger) or isPadUp(__eJoyPadInputType_RightShoulder) or isPadUp(__eJoyPadInputType_LeftShoulder) then
    updateAvailable = true
  end
  if isPadUp(__eJoyPadInputType_Start) then
    isEnd = true
  elseif true == updateAvailable and keyCustom_CheckAndSet_ActionPad(inputType) then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    if true == _ContentsGroup_NewUI_GameOption_All then
      PaGlobal_GameOption_All:CompleteKeyCustomMode()
      PaGlobal_GameOption_All._confirmKeyCustomizing = true
    else
      PaGlobal_Option:CompleteKeyCustomMode()
      PaGlobal_Option._confirmKeyCustomizing = true
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_PopupItem()
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PaGlobal_UseItem_All_Close()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Extraction(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if nil ~= Panel_Window_Extraction_Costume_All and Panel_Window_Extraction_Costume_All:GetShow() then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_Costume_All_Close()
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
    elseif _ContentsGroup_JewelPreset == false and nil ~= Panel_Window_Extraction_Crystal_All and Panel_Window_Extraction_Crystal_All:GetShow() then
      PaGlobal_Extraction_Crystal_All_Close()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_System_All_Close()
    elseif _ContentsGroup_JewelPreset == true and nil ~= Panel_Window_JewelPreset_Inven_All and Panel_Window_JewelPreset_Inven_All:GetShow() then
      PaGlobalFunc_JewelPreset_CloseWithESC()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_System_All_Close()
    elseif nil ~= Panel_Window_Extraction_EnchantStone_All and Panel_Window_Extraction_EnchantStone_All:GetShow() then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
    elseif nil ~= Panel_Window_Extraction_System_All and true == Panel_Window_Extraction_System_All:GetShow() then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
    elseif nil ~= Panel_Window_Extraction_Caphras_All and Panel_Window_Extraction_Caphras_All:GetShow() then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_System_All_Close()
      PaGlobal_Extraction_Blackstone_All_Close()
      PaGlobal_Extraction_Caphras_All_Close()
    elseif nil ~= Panel_Window_Extraction_Artifacts_All and Panel_Window_Extraction_Artifacts_All:GetShow() then
      PaGlobal_Extraction_Artifacts_All_Close()
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_Close(false)
      else
        EquipmentWindow_Close()
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
      PaGlobal_Extraction_Caphras_All_Close()
      PaGlobal_Extraction_System_All_Close()
    else
      PaGlobal_Extraction_All_Close()
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameCustomize(deltaTime)
  if false == _ContentsGroup_RenewUI_Customization then
    if true == _ContentsGroup_RgbUIPick and nil ~= Panel_Window_ColorPalette_All and true == Panel_Window_ColorPalette_All:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_ColorPalette_All_Close()
      return
    end
    if Panel_CustomizationMain:IsShow() and Panel_CustomizationMain:GetAlpha() == 1 then
      if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
        if MessageBox.isPopUp() then
          MessageBox.keyProcessEscape()
        elseif Panel_CustomizingAlbum:GetShow() then
          CustomizingAlbum_Close()
        elseif Panel_FileExplorer:GetShow() then
          closeExplorer()
        elseif Panel_Cash_Customization_BuyItem:GetShow() then
          CashCumaBuy_Close()
        elseif nil ~= Panel_CreateRandomFaceBoneForDEV and true == Panel_CreateRandomFaceBoneForDEV:GetShow() and nil ~= HandleClicked_CreateFaceBoneForDev_ClosePanel then
          HandleClicked_CreateFaceBoneForDev_ClosePanel()
        else
          IngameCustomize_Hide()
        end
      end
    elseif not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      IngameCustomize_CancelIntroAction()
      if Panel_Cash_Customization_BuyItem:GetShow() then
        CashCumaBuy_Close()
      end
    end
    if Panel_CustomizationStatic:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) and not Panel_FileExplorer:GetShow() and not Panel_CustomizingAlbum:GetShow() then
      FGlobal_TakeScreenShotByHotKey()
    end
    if Panel_Widget_ScreenShotFrame:GetShow() then
      if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
        local screenShotFrame_Close = function()
          FGlobal_ScreenShotFrame_Close()
        end
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
          content = messageBoxMemo,
          functionYes = screenShotFrame_Close,
          functionNo = MessageBox_Empty_function,
          exitButton = true,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
        return
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ADD) then
        ScreenShotFrameSize_Increase()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SUBTRACT) then
        ScreenShotFrameSize_Decrease()
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
        FGlobal_TakeAScreenShot()
      end
    end
  else
    if true == PaGlobalFunc_Customization_GetShow() then
      if true == _ContentsGroup_RgbUIPick and nil ~= Panel_Window_ColorPalette_All and true == Panel_Window_ColorPalette_All:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_ColorPalette_All_Close()
        return
      end
      if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
        PaGlobalFunc_Customization_Back()
      end
    end
    if Panel_Widget_ScreenShotFrame:GetShow() then
      if not getEscHandle() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F4)) then
        local screenShotFrame_Close = function()
          FGlobal_ScreenShotFrame_Close()
        end
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
          content = messageBoxMemo,
          functionYes = screenShotFrame_Close,
          functionNo = MessageBox_Empty_function,
          exitButton = true,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
        return
      end
      if false == _ContentsGroup_RenewUI then
        if isPadUp(__eJoyPadInputType_RightShoulder) then
          ScreenShotFrameSize_Increase()
        elseif isPadUp(__eJoyPadInputType_RightTrigger) then
          ScreenShotFrameSize_Decrease()
        elseif isPadUp(__eJoyPadInputType_Y) then
          FGlobal_TakeAScreenShot()
        end
      end
    end
  end
end
local prevPressControl
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameCashShop(delataTime)
  if GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_CashShop) then
    PaGlobal_InGameCashShop_CheckClose()
    Panel_Tooltip_Item_hideTooltip()
  end
  if true == _ContentsGroup_PearlShopMileage and nil ~= PaGlobal_CashMileage_IsOpenCheck and true == PaGlobal_CashMileage_IsOpenCheck() and isPadPressed(__eJoyPadInputType_RightTrigger) and isPadPressed(__eJoyPadInputType_Y) then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_Open()
  end
  if true == _ContentsGroup_PearlShopMoonBlessingRenew and nil ~= PaGlobal_MoonBlessingRenew_IsOpenCheck and true == PaGlobal_MoonBlessingRenew_IsOpenCheck() and isPadPressed(__eJoyPadInputType_RightTrigger) and isPadPressed(__eJoyPadInputType_Y) then
    PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Open()
  end
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
    PaGlobalFunc_TotalSearch_Open()
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_WebCashPayment ~= nil and Panel_WebCashPayment:GetShow() == true then
      FGlobal_WebCashPayment_ForceClose()
      return
    end
    if Panel_Window_PearlBox_Purchase_All ~= nil and Panel_Window_PearlBox_Purchase_All:GetShow() == true then
      FGlobal_Window_PearlBox_Purchase_All_ForceClose()
      return
    end
    if Panel_Window_WebPurchaseConfirm_All ~= nil and Panel_Window_WebPurchaseConfirm_All:GetShow() == true then
      PaGlobalFunc_WebPurchaseConfirm_All_Close()
      return
    end
    if ToClient_isConsole() == true then
      if PaGlobalFunc_WebControl_GetShow() then
        PaGlobalFunc_WebControl_Close()
      elseif PaGlobal_IngameCashShop_DescGetShow() then
        PaGlobal_IngameCashShop_DescClose()
      elseif PaGlobalFunc_PearlShopProductBuyCheckShow() then
        PaGlobalFunc_PearlShopProductBuyBack()
      elseif nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
        PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
      elseif nil ~= Panel_IngameCashShop_MoonBlessing_Renew_All and true == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
        PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
      elseif nil ~= Panel_IngameCashShop_GuildGiveaway_All and true == Panel_IngameCashShop_GuildGiveaway_All:GetShow() then
        PaGlobal_IngameCashshop_GuildGiveaway_Close()
      elseif PaGlobalFunc_PearlShopProductInfoCheckShow() then
        PaGlobalFunc_PearlShopProductInfoBack()
      elseif PaGlobalFunc_PearlShopCheckShow() then
        PaGlobalFunc_PearlShopBack()
      elseif PaGlobalFunc_PearlShopCategoryCheckShow() then
        PaGlobalFunc_PearlShopCategoryBack()
      end
    elseif true == PaGlobal_IsOpenSelectBoxContents() then
      PaGlobal_CloseSelectBoxPanel()
    elseif nil ~= Panel_Window_Inventory and Panel_Window_Inventory:IsShow() and not Panel_Window_Inventory:IsUISubApp() then
      InventoryWindow_Close()
    elseif nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:IsShow() and not Panel_Window_Inventory_All:IsUISubApp() then
      InventoryWindow_Close()
    elseif Panel_IngameCashShop_BuyOrGift:GetShow() then
      InGameShopBuy_Close()
    elseif Panel_IngameCashShop_GoodsDetailInfo:GetShow() then
      InGameShopDetailInfo_Close()
      Panel_Tooltip_Item_hideTooltip()
    elseif nil ~= Panel_IngameCashShop_Desc and true == Panel_IngameCashShop_Desc:GetShow() and true == _ContentsGroup_RefundCashProduct then
      PaGlobal_IngameCashShop_DescClose()
    elseif nil ~= Panel_IngameCashSHop_ReturnBack and true == Panel_IngameCashSHop_ReturnBack:GetShow() and true == _ContentsGroup_RefundCashProduct then
      PaGlobal_IngameCashSHop_ReturnBack_Close()
    elseif Panel_QnAWebLink:GetShow() then
      FGlobal_QnAWebLink_Close()
    elseif Panel_IngameCashShop_MakePaymentsFromCart:GetShow() then
      FGlobal_IngameCashShop_MakePaymentsFromCart_Close()
    elseif Panel_IngameCashShop_HowUsePearlShop:GetShow() then
      Panel_IngameCashShop_HowUsePearlShop_Close()
    elseif Panel_IngameCashShop_Coupon:GetShow() then
      IngameCashShopCoupon_Close()
    elseif Panel_IngameCashShop_EventCart:GetShow() then
      IngameCashShopEventCart_Close()
    elseif nil ~= PaGlobalFunc_CashMileage_GetShow and true == PaGlobalFunc_CashMileage_GetShow() then
      PaGlobal_CashMileage_Close()
    elseif nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
      PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
    elseif nil ~= Panel_IngameCashShop_MoonBlessing_Renew_All and true == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
      PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
    elseif nil ~= Panel_IngameCashShop_GuildGiveaway_All and true == Panel_IngameCashShop_GuildGiveaway_All:GetShow() then
      PaGlobal_IngameCashshop_GuildGiveaway_Close()
    elseif getGameDanceEditor():isShow() then
      getGameDanceEditor():hide()
    elseif Panel_Window_RecommandGoods_PopUp:GetShow() then
      PaGlobal_Recommend_PopUp:Close()
    elseif nil ~= Panel_ScreenShot_SNS and true == Panel_ScreenShot_SNS:GetShow() then
      if nil ~= Panel_ScreenShotAlbum_FullScreen and true == Panel_ScreenShotAlbum_FullScreen:GetShow() then
        ScreenshotAlbum_FullScreen_Close()
      else
        PaGlobal_ScreenShotSNS_Close()
      end
    elseif Panel_Window_ExpirienceWiki_All ~= nil and Panel_Window_ExpirienceWiki_All:GetShow() == true then
      if PaGlobal_ExpirienceWiki_All_Close_FromESC ~= nil then
        PaGlobal_ExpirienceWiki_All_Close_FromESC()
      end
    else
      PaGlobal_InGameCashShop_CheckClose()
    end
    if true == ToClient_WorldMapIsShow() then
      SetUIMode(Defines.UIMode.eUIMode_WorldMap)
    end
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and FGlobal_InGameShop_IsSelectedSearchName() then
    InGameShop_Search()
  end
  if FGlobal_InGameShop_IsSelectedSearchName() then
    local pressControl = getPressControl()
    if nil == pressControl then
      pressControl = prevPressControl
    end
    local searchEdit = FGlobal_InGameCashShop_GetSearchEdit()
    prevPressControl = pressControl
    if nil == pressControl or pressControl:GetKey() ~= searchEdit:GetKey() then
      ClearFocusEdit()
    else
      return
    end
  end
  if not Panel_IngameCashShop_BuyOrGift:GetShow() and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Inventory) then
    if nil ~= Panel_Window_Inventory and Panel_Window_Inventory:IsShow() then
      InventoryWindow_Close()
    elseif nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:IsShow() then
      if Panel_Window_Inventory_All:IsUISubApp() == false then
        InventoryWindow_Close()
      end
    else
      FGlobal_InGameShop_OpenInventory()
    end
  end
  PaGlobalFunc_ClothInventory_All_Close()
  if nil ~= Panel_Window_ChangeItem_All and Panel_Window_ChangeItem_All:GetShow() then
    PaGlobalFunc_ChangeItem_All_Close()
  end
  if nil ~= Panel_Window_ChangeItem_Renew and Panel_Window_ChangeItem_Renew:GetShow() then
    PaGlobalFunc_ChangeItem_Close()
  end
  if nil ~= Panel_Window_CarveSeal_All and Panel_Window_CarveSeal_All:GetShow() then
    PaGloabl_CaveSeal_All_Close()
  end
  if nil ~= Panel_Window_Warehouse and Panel_Window_Warehouse:GetShow() then
    PaGlobal_Warehouse_All_Close()
  end
  if nil ~= Panel_Window_Guild_Renew and Panel_Window_Guild_Renew:GetShow() then
    PaGlobalFunc_GuildMain_Close()
  end
  if nil ~= Panel_Window_Manufacture and Panel_Window_Manufacture:GetShow() then
    PaGlobalFunc_ManufactureClose()
  end
  if nil ~= Panel_Window_Manufacture_All and Panel_Window_Manufacture_All:GetShow() then
    PaGlobalFunc_Manufacture_All_Close()
  end
  if nil ~= Panel_Window_AlchemyStone_All and Panel_Window_AlchemyStone_All:GetShow() then
    if _ContentsGroup_AlchemyStoneRenewal == true then
      PaGlobalFunc_AlchemyStone_Renewal_All_Close()
    else
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  end
  if nil ~= Panel_AlchemyFigureHead_All and Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_PearlShop_CameraInput()
    if nil ~= PaGlobalFunc_Camp_All_CloseAll then
      PaGlobalFunc_Camp_All_CloseAll()
    end
    if nil ~= Panel_Window_PetList_Renew and Panel_Window_PetList_Renew:GetShow() then
      FGlobal_PetList_Close()
    end
    if nil ~= Panel_Window_DailyStamp_All and true == Panel_Window_DailyStamp_All:GetShow() then
      PaGlobalFunc_DailyStamp_All_Close()
      Panel_Tooltip_Item_hideTooltip()
      TooltipSimple_Hide()
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Dye(delataTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Dyeing) then
    if true == _ContentsGroup_RgbUIPickForItem and nil ~= Panel_Window_ColorPalette_All and true == Panel_Window_ColorPalette_All:IsShow() then
      PaGlobal_ColorPalette_All_Close()
      return
    end
    if true == _ContentsGroup_RenewUI_Dyeing then
      if _ContentsGroup_NewUI_Dye_All then
        PaGlobal_Dye_All_OnPadB()
      else
        PaGlobalFunc_Dyeing_OnPadB()
      end
    elseif _ContentsGroup_NewUI_Dye_All then
      PaGlobal_Dye_All_Close()
    else
      FGlobal_Panel_DyeReNew_Hide()
    end
  end
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
    PaGlobalFunc_TotalSearch_Open()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SkillWindow(delataTime)
  if ToClient_LearnSkillCameraIsShow() == true then
    if _ContentsGroup_ShowOtherClassSkill == true then
      if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == false then
        PaGlobalFunc_SkillGroup_All_Open()
        ToClient_LearnSkillCameraHide()
      end
    elseif Panel_Window_SkillGroup ~= nil and Panel_Window_SkillGroup:GetShow() == false and HandleMLUp_SkillWindow_OpenForLearn ~= nil then
      HandleMLUp_SkillWindow_OpenForLearn()
      ToClient_LearnSkillCameraHide()
    end
  end
  local isKeyDownEscape = false
  if _ContentsGroup_UsePadSnapping == true then
    isKeyDownEscape = isPadDown(__eJoyPadInputType_Start) or isKeyDown_Once(VCK.KeyCode_ESCAPE)
  else
    isKeyDownEscape = isKeyDown_Once(VCK.KeyCode_ESCAPE)
  end
  if not getEscHandle() and isKeyDownEscape == true or GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Skill) then
    if false == _ContentsGroup_UISkillGroupTreeLayOut then
      if ToClient_isConsole() == true then
        audioPostEvent_SystemUi(1, 23)
        _AudioPostEvent_SystemUiForXBOX(1, 17)
        PaGlobalFunc_Skill_Close()
      end
    elseif not getEscHandle() and isKeyDownEscape == true then
      if true == _ContentsGroup_SkillPreset then
        if nil ~= Panel_Window_SkillPresetMemo and true == Panel_Window_SkillPresetMemo:GetShow() then
          PaGlobalFunc_SkillPresetMemo_Close()
          return
        end
        if nil ~= Panel_Window_SkillPreset and true == Panel_Window_SkillPreset:GetShow() then
          PaGlobal_SkillPreset_Close()
          return
        end
      end
      if _ContentsGroup_ShowOtherClassSkill == true then
        PaGlobalFunc_SkillGroup_All_Close()
      else
        PaGlobalFunc_SkillGroup_Close()
      end
    else
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
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    if true == Panel_Window_SkillGroup_Controller:GetShow() then
      if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
        PaGlobal_SkillGroup_Controller:HandleEventLUp_PlaySkill()
      end
      if _ContentsGroup_ShowOtherClassSkill == true then
        if PaGlobalFunc_SkillGroup_All_KeyBoardTabEvent() == true then
          return
        end
      elseif PaGlobalFunc_SkillGroup_KeyBoardTabEvent() == true then
        return
      end
      if true == _ContentsGroup_UsePadSnapping and isPadPressed(__eJoyPadInputType_LeftTrigger) then
        if isPadPressed(__eJoyPadInputType_RightStick_Up) then
          if nil ~= PaGlobal_SkillGroup_Controller_ScrollEffectDesc then
            PaGlobal_SkillGroup_Controller_ScrollEffectDesc(true)
          end
        elseif isPadPressed(__eJoyPadInputType_RightStick_Down) and nil ~= PaGlobal_SkillGroup_Controller_ScrollEffectDesc then
          PaGlobal_SkillGroup_Controller_ScrollEffectDesc(false)
        end
      end
    end
    if false == _ContentsGroup_UsePadSnapping then
      if isUseNewQuickSlot() then
        local ii
        local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
        local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
        for ii = quickSlot1, quickSlot20 do
          if keyCustom_IsDownOnce_Action(ii) then
            HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
            return
          end
        end
      else
        local ii
        local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
        local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
        for ii = quickSlot1, quickSlot10 do
          if keyCustom_IsDownOnce_Action(ii) then
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
  if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false and isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
    PaGlobalFunc_TotalSearch_Open()
    return
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_ItemMarket(delataTime)
  if (true == _ContentsGroup_RenewUI_ItemMarketPlace or true == _ContentsGroup_RenewUI) and not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if nil ~= PaGlobal_MarKetPlace_BuyProductInCashShop_GetShow and true == PaGlobal_MarKetPlace_BuyProductInCashShop_GetShow() then
      PaGlobal_MarKetPlace_BuyProductInCashShop_Close()
      return
    end
    if true == PaGlobalFunc_OTPConfirm_All_GetShow() then
      PaGlobalFunc_OTPConfirm_All_Close()
      return
    end
    if nil ~= Panel_Window_MarketPlace_TutorialSelect and true == Panel_Window_MarketPlace_TutorialSelect:GetShow() then
      PaGlobal_MarketPlaceTutorialSelect:prepareClose()
      return
    end
    if true == PaGlobal_MarketPlaceSelectList_GetShow() then
      PaGlobal_MarketPlaceSelectList_Cancel()
      return
    end
    if true == PaGlobalFunc_MarketPlaceSell_GetShow() then
      PaGlobal_MarketPlaceSell_Cancel()
      return
    end
    if true == PaGlobalFunc_MarketPlaceBuy_GetShow() then
      PaGlobal_MarketPlaceBuy_Cancel()
      return
    end
    if false == _ContentsGroup_RenewUI and true == PaGlobal_MarketPlacePriceList_GetShow() then
      PaGlobal_MarketPlacePriceList_Cancel()
      return
    end
    if true == PaGlobalFunc_MarketWallet_GetShow() and false == _ContentsGroup_RenewUI then
      PaGlobalFunc_MarketWallet_Close()
      return
    end
    if true == Panel_Window_ItemMarket_Favorite:GetShow() then
      FGlobal_ItemMarket_FavoriteItem_Close()
      return
    end
    if false == _ContentsGroup_UsePadSnapping and true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and true == PaGlobalFunc_SubWallet_IsShow() then
      PaGlobalFunc_SubWallet_Close()
      return
    end
    if true == PaGlobalFunc_MarketPlace_GetShow() then
      if true == _ContentsGroup_RenewUI then
        PaGlobalFunc_MarketPlace_Function_Close()
      else
        PaGlobalFunc_MarketPlace_Close()
      end
      return
    end
    if true == PaGlobalFunc_MarketPlace_Function_GetShow() then
      PaGlobalFunc_MarketPlace_Function_Close()
      return
    end
  end
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if Panel_Window_ItemMarket_ItemSet:GetShow() then
      FGlobal_ItemMarketItemSet_Close()
    elseif Panel_Window_ItemMarket_RegistItem:GetShow() then
      FGlobal_ItemMarketRegistItem_Close()
    elseif Panel_ItemMarket_PreBid_Manager:GetShow() then
      FGlobal_ItemMarketPreBid_Manager_Close()
    elseif Panel_ItemMarket_PreBid:GetShow() then
      FGlobal_ItemMarketPreBid_Close()
    elseif Panel_ItemMarket_AlarmList:GetShow() then
      FGlobal_ItemMarketAlarmList_Close()
    elseif Panel_ItemMarket_BidDesc:GetShow() then
      Panel_ItemMarket_BidDesc_Hide()
    elseif Panel_Window_ItemMarket:GetShow() and not Panel_Window_ItemMarket:IsUISubApp() then
      if Panel_Window_ItemMarket_BuyConfirm:GetShow() then
        FGlobal_ItemMarket_BuyConfirm_Close()
      else
        FGolbal_ItemMarketNew_Close()
        InventoryWindow_Close()
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetShow(false)
        else
          Equipment_SetShow(false)
        end
        if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
          PaGlobalFunc_ClothInventory_All_Close()
        else
          ClothInventory_Close()
        end
      end
    else
      FGolbal_ItemMarket_Function_Close()
    end
    if ToClient_CheckExistSummonMaid() and Panel_Window_ItemMarket:GetShow() == false then
      ToClient_CallHandlerMaid("_maidLogOut")
    end
  end
  if FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
    FGlobal_HandleClicked_ItemMarketBackPage()
  end
  if Panel_Window_ItemMarket_BuyConfirm:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    HandleClicked_ItemMarket_BuyItem()
  end
  if Panel_Window_ItemMarket:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    FGolbal_ItemMarketNew_Search()
  end
  if Panel_ItemMarket_PreBid:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    if 0 == FGlobal_ItemMarketPreBid_Check_OpenType() then
      FGlobal_ItemMarketPreBid_Confirm()
    else
      FGlobal_ItemMarketPreBid_Close()
    end
  end
  if Panel_Window_ItemMarket_RegistItem:GetShow() and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
    if true == Panel_IngameCashShop_Password:GetShow() then
      PayMentPassword_Confirm()
    else
      FGlobal_ItemMarketRegistItem_RegistDO()
    end
  end
  if getInputMode() ~= IM.eProcessorInputMode_ChattingInputMode and Panel_Window_ItemMarket:GetShow() and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Inventory) then
    local isInvenOpen = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenOpen = Panel_Window_Inventory_All:IsShow()
    else
      isInvenOpen = Panel_Window_Inventory:IsShow()
    end
    if true == isInvenOpen then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(false)
      else
        Equipment_SetShow(false)
      end
      if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
        PaGlobalFunc_ClothInventory_All_Close()
      else
        ClothInventory_Close()
      end
    else
      FGlobal_ItemmarketNew_OpenInventory()
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(true)
      else
        Equipment_SetShow(true)
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_ProductNote(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_ProductNote_ShowToggle()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_QnAWebLink(deltaTime)
  if not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == Panel_QnAWebLink_ShowToggle() then
    CheckChattingInput()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_TradeGame(deltaTime)
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    if nil ~= Panel_Dialog_Trade_BiddingGame_All then
      if true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
        HandleEventLup_TradeBiddingGame_All_Close()
      end
    elseif nil ~= Panel_TradeGame and true == Panel_TradeGame:GetShow() then
      Fglobal_TradeGame_Close()
    end
    return
  end
  if nil ~= Panel_Dialog_Trade_BiddingGame_All and true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    PaGlobalFunc_TradeBiddingGame_All_MovePlateByPerFrame(deltaTime)
  elseif nil ~= Panel_TradeGame and true == Panel_TradeGame:GetShow() then
    global_Update_TradeGame(deltaTime)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SequencePlayerControlMode(deltaTime)
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
  if ChatInput_Show ~= nil and GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_Chat) then
    ChatInput_Show()
    return
  end
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) and PaGloabl_Looting_All_GetShowPanel() then
    if true == _ContentsGroup_NewUI_Looting then
      HandleEventLUp_Looting_All_LootAll(false)
    else
      Panel_Looting_buttonLootAll_Mouse_Click(false)
    end
    Panel_Tooltip_Item_hideTooltip()
    if nil ~= QuestInfoData then
      QuestInfoData.questDescHideWindow()
    end
  end
  fastPinDelta = fastPinDelta + deltaTime
  if fastPinDelta > 10 then
    fastPinDelta = 10
  end
  if CommonWindowFunction(__eUiInputType_Inventory, Process_UIMode_CommonWindow_Inventory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PositionNotify, Process_UIMode_CommonWindow_PositionNotify, fastPinDelta) then
    return
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_B) then
    requestBlackSpritSkill()
    return
  end
  if isKeyPressed(VCK.KeyCode_MENU) == true and isKeyPressed(VCK.KeyCode_SHIFT) == true then
    local ii
    for ii = VCK.KeyCode_0, VCK.KeyCode_9 do
      local key = ii - VCK.KeyCode_0 - 1
      if key < 0 then
        key = VCK.KeyCode_9 - VCK.KeyCode_0
      end
      if isKeyDown_Once(ii) == true and ToClient_getMacroChatMessage(key) ~= "" then
        ToClient_executeChatMacro(key)
        return
      end
    end
  end
  if true == _ContentsGroup_NewCloseManager then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SequenceMode(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_FieldWalkingCameraMode(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_RoseWar(deltaTime)
  if PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill ~= nil and PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill() == true then
    return
  end
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if _ContentsGroup_NewCloseManager == true then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_RoseWarMenu(deltaTime)
  if PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill ~= nil and PaGlobalFunc_RoseWarTeamSkillManager_isUsingSkill() == true then
    return
  end
  if _ContentsGroup_NewCloseManager == true then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_CutSceneMode(deltaTime)
  if ToClient_cutsceneIsPlay() then
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
            local partyLeaderSkip = PaGlobalFunc_CutSceneScript_IsOnlyPartyLeaderSkipAble()
            if skipWrapper == nil and isForceSkip == false or partyLeaderSkip == false then
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
      if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) and false == ToClient_IsEnterSequence() then
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "CUTSCENE_EXIT_MESSAGEBOX_MEMO")
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
          content = messageBoxMemo,
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_UiSetting(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_UiSet_Close()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Gacha_Roulette(deltaTime)
  if true == _ContentsGroup_UsePadSnapping then
    if isPadUp(__eJoyPadInputType_A) then
      HandleEventPadPress_RandomBoxSelect_All_OnPressSpace()
    elseif isPadUp(__eJoyPadInputType_B) then
      HandleEventLUp_RandomBoxSelect_All_OnPressEscape()
    end
  else
    if nil ~= ItemBoxGoXXX and true == ItemBoxGoXXX() then
      HandleEventLUp_RandomBoxSelect_All_OnPressSpace()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      HandleEventLUp_RandomBoxSelect_All_OnPressSpace()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleEventLUp_RandomBoxSelect_All_OnPressEscape()
    end
  end
  return
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_EventNotify(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and nil ~= EventNotifyContent_Close then
    EventNotifyContent_Close()
    CheckChattingInput()
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_ScreenShotMode(delataTime)
  if MessageBox.isPopUp() then
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    local screenShotFrame_Close = function()
      FGlobal_ScreenShotFrame_Close()
    end
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_CONTENT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SCREENSHOTFRAME_MSGBOX_TITLE"),
      content = messageBoxMemo,
      functionYes = screenShotFrame_Close,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
    setUiInputProcessed(VCK.KeyCode_SPACE)
    FGlobal_TakeAScreenShot()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ADD) then
    ScreenShotFrameSize_Increase()
  elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SUBTRACT) then
    ScreenShotFrameSize_Decrease()
  end
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    if isPadUp(__eJoyPadInputType_RightShoulder) then
      ScreenShotFrameSize_Increase()
    elseif isPadUp(__eJoyPadInputType_RightTrigger) then
      ScreenShotFrameSize_Decrease()
    end
  end
  return
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_InGameDance(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_KeyCustom_ButtonShortcuts(deltaTime)
  local isEnd = false
  local clickedAlt = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU)
  local clickedShift = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT)
  local refresh, remove, register, curId
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    refresh = PaGlobalFunc_ButtonShorcuts_All_UiRefreshByGlobalKeyBinder
    remove = PaGlobalFunc_ButtonShorcuts_All_RemoveByGlobalKeyBinder
    register = PaGlobalFunc_ButtonShorcuts_All_Register
    curId = PaGlobal_ButtonShortcuts_All._curId
  else
    refresh = PaGlobalFunc_ButtonShortcuts_UiRefresh
    remove = PaGlobalFunc_ButtonShortcuts_Remove
    register = PaGlobalFunc_ButtonShortcuts_Register
    curId = PaGlobal_ButtonShortcuts._curId
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    refresh(curId)
    isEnd = true
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_DELETE) then
    remove()
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    return
  end
  if false == clickedAlt then
    return
  end
  local VirtualKeyCode = keyCustom_GetVirtualKey()
  if VirtualKeyCode > 0 then
    isEnd = true
  end
  if isEnd then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
    register(VirtualKeyCode, clickedAlt, clickedShift)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UiModeNotInput()
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if not _ContentsGroup_RenewUI_Alchemy then
      PaGlobalFunc_Alchemy_All_Close()
    end
    if nil ~= Panel_Window_Composition_All and true == Panel_Window_Composition_All:GetShow() then
      PaGlobal_Composition_All_Close()
    end
    if true == _ContentsGroup_PersonalField and nil ~= PaGlobal_Widget_PersonalField_Enter_All_Close and nil ~= Panel_Widget_PersonalField_Enter and true == Panel_Widget_PersonalField_Enter:GetShow() then
      PaGlobal_Widget_PersonalField_Enter_All_Close()
      return
    end
    if Panel_PartyContentRecurit ~= nil and Panel_PartyContentRecurit:GetShow() == true then
      PaGlobalFunc_PartyContentsRecruit_Close()
      return
    end
    if _ContentsGroup_HadumField == true and Panel_Widget_HadumField_Enter ~= nil and Panel_Widget_HadumField_Enter:GetShow() == true and PaGlobal_Widget_HadumField_Enter_All_Close ~= nil then
      PaGlobal_Widget_HadumField_Enter_All_Close()
      return
    end
    if ToClient_HardCoreChannelWithContensOption() == true and PaGlobal_HardCoreResult_GetShow() == true then
      PaGlobal_HardCoreResult_Close()
      return
    end
  end
  if _ContentsGroup_HadumField == true and Panel_Widget_HadumField_Enter ~= nil and Panel_Widget_HadumField_Enter:GetShow() == true and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) and PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave ~= nil then
    PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave()
    return
  end
  if nil ~= Panel_Window_Composition_All and true == Panel_Window_Composition_All:GetShow() and CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if true == isMoviePlayMode() then
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_ChattingMacro()
  if false == isKeyPressed(VCK.KeyCode_MENU) then
    return false
  end
  if false == isKeyPressed(VCK.KeyCode_SHIFT) then
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
function PaGlobal_GlobalKeyBinder.Process_UIMode_SkillkeyBinder(deltaTime)
  if isUseNewQuickSlot() then
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
    for ii = quickSlot1, quickSlot20 do
      if keyCustom_IsDownOnce_Action(ii) then
        HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
        return
      end
    end
  else
    local ii
    local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
    local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
    for ii = quickSlot1, quickSlot10 do
      if keyCustom_IsDownOnce_Action(ii) then
        QuickSlot_Click(tostring(ii - quickSlot1))
        return
      end
    end
  end
end
function PaGlobal_GlobalKeyBinder.Process_Normal(deltaTime)
  if true == _ContentsGroup_RenewUI and nil ~= Panel_Window_PowerSave_All and true == Panel_Window_PowerSave_All:GetShow() then
    if isPadPressed(__eJoyPadInputType_LeftShoulder) and isPadPressed(__eJoyPadInputType_RightShoulder) then
      PaGlobalFunc_PowerSave_All_Awake()
      return true
    end
    return true
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Tutorial then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      if PaGlobal_ContentsTutorial_All._ui._stc_messageBox:GetShow() == true then
        PaGlobalFunc_ContentsTutorial_All_Close()
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_ContentsTutorial_All_CancleTutorial()
    end
    return true
  end
  if MessageBox.isPopUp() then
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
  elseif false == _ContentsGroup_UsePadSnapping and nil ~= Panel_Window_MessageBoxElvia_All and true == Panel_Window_MessageBoxElvia_All:GetShow() then
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      PaGlobalFunc_Window_MessageBoxElvia_All_Close()
      return true
    end
  elseif false == _ContentsGroup_UsePadSnapping and nil ~= Panel_Popup_Hadum_Warning_Quest and true == PaGlobal_HadumWarning_Quest_IsShow() then
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      PaGlobal_HadumWarning_Quest_Close()
      return true
    end
  elseif false == _ContentsGroup_UsePadSnapping and Panel_ExitConfirm:GetShow() == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobal_ExitConfirm_All_GameExitSuccess()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_ExitConfirm:SetShow(false)
      Panel_Tooltip_Item_hideTooltip()
    end
    return true
  elseif ToClient_isConsole() == false and Panel_ExitConfirm_Old:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      HandleEventLUp_GameExit_All_TrayConfirm()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_ExitConfirm_Old:SetShow(false)
      Panel_Tooltip_Item_hideTooltip()
    end
    return true
  elseif ToClient_isConsole() == false and Panel_Window_TrayConfirm_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      HandleEventLUp_ExitTrayConfirm_All_Confirm()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_ExitTrayConfirm_All_Close()
      Panel_Tooltip_Item_hideTooltip()
    end
    return true
  elseif Panel_NumberPad_IsPopUp() then
    if true == _ContentsGroup_UsePadSnapping then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) then
        HandleEventLUp_NumberPad_All_AllButton_Click(0)
        setUiInputProcessed(VCK.KeyCode_F)
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) or isPadDown(__eJoyPadInputType_Y) then
        HandleEventLUp_NumberPad_All_ConfirmButton_Click()
        setUiInputProcessed(VCK.KeyCode_RETURN)
        setUiInputProcessed(VCK.KeyCode_SPACE)
        keyCustom_KeyProcessed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
      elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        HandleEventLUp_NumberPad_All_CancelButton_Click()
      end
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) then
      HandleEventLUp_NumberPad_All_AllButton_Click(0)
      setUiInputProcessed(VCK.KeyCode_F)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) or keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
      HandleEventLUp_NumberPad_All_ConfirmButton_Click()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      keyCustom_KeyProcessed_Action(CppEnums.ActionInputType.ActionInputType_Interaction)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleEventLUp_NumberPad_All_CancelButton_Click()
    end
    PaGlobal_NumberPad_All_NumberKey_Input()
    return true
  elseif Panel_Sequence_R_SkipMessageBox:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) or isPadDown(__eJoyPadInputType_A) then
      PaGlobalFunc_Sequence_R_SkipMessageBox_DoSkip()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Sequence_R_SkipMessageBox_Close()
    end
    return true
  elseif Panel_SequenceSkipEscPopUp:GetShow() then
    if (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) and ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_BlackTemple) == false then
      returnSequenceSkip()
    elseif isPadDown(__eJoyPadInputType_A) then
      returnSequenceSkip()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      keepGogingSequenceByKeyBinder()
    end
    return true
  elseif _ContentsGroup_UsePadSnapping == false and Panel_Window_CutSceneSkip:GetShow() == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      PaGlobalFunc_CutSceneSkip_DoSkip()
    end
    return true
  elseif Panel_Chatting_Macro:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Chatting_Macro_ShowToggle()
      FGlobal_Chatting_Macro_SetCHK(false)
      CheckChattingInput()
      return true
    end
  elseif Panel_Chat_SocialMenu:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_Chatting_Input:GetShow() then
        ChatInput_CancelAction()
        ChatInput_CancelMessage()
        ChatInput_Close()
        PaGlobal_AddFriend_All_Close()
      else
        if _ContentsGroup_RenewUI == false then
          FGlobal_SocialAction_SetCHK(false)
        end
        FGlobal_SocialAction_ShowToggle()
        CheckChattingInput()
      end
      return true
    end
  elseif nil ~= Panel_GuildIncentive and Panel_GuildIncentive:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and not FGlobal_CheckSaveGuildMoneyUiEdit(GetFocusEdit()) then
      FGlobal_SaveGuildMoney_Send()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_GuildIncentive_Close()
      return true
    end
    FGlobal_GuildDeposit_InputCheck()
    return true
  elseif nil ~= Panel_GuildDeposit_All and Panel_GuildDeposit_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) and not PaGlobal_GuildDeposit_All_CheckUiEdit(GetFocusEdit()) then
      InputMLUp_Deposit_Send()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_GuildDeposit_All_Close()
      return true
    end
    PaGlobal_GuildDeposit_All_InputCheck()
    return true
  elseif GlobalKeyBinder_CheckCustomKeyPressed(__eUiInputType_AlchemyStone) and false == isKeyPressed(VCK.KeyCode_CONTROL) then
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
  elseif nil ~= Panel_EventNotifyContent and Panel_EventNotifyContent:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleClicked_EventNotifyContent_Close()
      return true
    end
  elseif _ContentsGroup_NewUI_EventNotify_All and nil ~= Panel_EventNotifyContent_All and Panel_EventNotifyContent_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and not PaGlobal_EventNotifyContent_All_IsUISubApp() then
      PaGlobal_EventNotifyContent_All_Close()
      return true
    end
  elseif nil ~= Panel_EventNotify and Panel_EventNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if true == _ContentsGroup_NewUI_EventNotify_All then
        PaGloabl_EventNotify_All_Close()
      else
        FGlobal_EventNotifyClose()
      end
      return true
    end
  elseif Panel_PcRoomNotify:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PcRoomNotifyClose()
      return true
    end
  elseif Panel_Introduction:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Introcution_TooltipHide()
      return true
    end
  elseif nil ~= Panel_SaveFreeSet and Panel_SaveFreeSet:GetShow() or nil ~= Panel_Window_SavePreset_All and Panel_Window_SavePreset_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      HandleClicked_UiSet_ConfirmSetting()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_SaveSetting:GetShow() then
        PaGlobal_Panel_SaveSetting_Hide()
        return true
      else
        PaGlobal_UiSet_FreeSet_Close()
        return true
      end
    end
  elseif nil ~= Panel_UI_Setting and Panel_UI_Setting:IsUse() or nil ~= Panel_Window_UIModify_All and Panel_Window_UIModify_All:IsUse() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      UiSet_FreeSet_Open()
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_SaveSetting:GetShow() then
        PaGlobal_Panel_SaveSetting_Hide()
        return true
      else
        FGlobal_UiSet_Close()
        return true
      end
    end
  elseif MessageBoxCheckGetShow() then
    if (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) and false == _ContentsGroup_UsePadSnapping then
      MessageBoxCheck.keyProcessEnter()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      MessageBoxCheck.keyProcessEscape()
      return true
    end
  elseif Panel_Window_MessageBox_CrystalSet_All ~= nil and Panel_Window_MessageBox_CrystalSet_All:IsShow() == true then
    if _ContentsGroup_UsePadSnapping == false and (GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)) then
      PaGlobalFunc_MessageBox_CrystalSet_All_ClickYes()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    end
  elseif nil ~= getSelfPlayer() and getSelfPlayer():get():isShowWaitComment() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      EventSelfPlayerWaitCommentClose()
      return true
    end
  elseif nil ~= Panel_RandomBoxSelect and true == Panel_RandomBoxSelect:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_RandomRoulette_Close()
      return true
    end
  elseif Panel_IngameCashShop_EasyPayment:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      if Panel_IngameCashShop_BuyOrGift:GetShow() then
        InGameShopBuy_Close()
        return true
      end
      PaGlobalFunc_EasyBuy_Close()
      return true
    end
  elseif Panel_Window_StampCoupon:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PearlStamp_Close()
      return true
    end
  elseif nil ~= Panel_Window_MacroCheckQuizKeyPad and true == Panel_Window_MacroCheckQuizKeyPad:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_MacroCheckQuizkeyPadClose()
      return true
    end
  elseif nil ~= Panel_MacroCheckQuizPad_All and true == Panel_MacroCheckQuizPad_All:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_MacroCheckNumPad_All_Close()
      return true
    end
  elseif nil ~= Panel_Levelup_Info and true == Panel_Levelup_Info:GetShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and false == PaGlobal_LevelupInfo._isFoldCheck then
      PaGlobal_LevelupInfo_ForceLeftClose()
      return true
    end
  elseif nil ~= Panel_Window_MarketPlace_Main and true == Panel_Window_MarketPlace_Main:GetShow() then
    if false == _ContentsGroup_UsePadSnapping and true == PaGlobal_TutorialPhase_IsTutorial() then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        PaGlobal_TutorialPhase_MarketPlace_EscapeClose(PaGlobalFunc_MarketPlace_Close)
        return true
      end
      if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_R) and true == PaGlobal_TutorialPhase_MarketPlace_IsInputKeycode() and false == Panel_Window_MarketPlace_BuyManagement:GetShow() and false == Panel_Window_MarketPlace_SellManagement:GetShow() then
        PaGlobal_TutorialPhase_MarketPlace:requestNext()
        return true
      end
    end
    if false == _ContentsGroup_RenewUI and true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == PaGlobalFunc_ItemMarket_SearchIsFocused() and nil ~= Panel_Chatting_Input and false == Panel_Chatting_Input:GetShow() then
      PaGlobalFunc_ItemMarket_BackPage()
    end
  elseif true == Panel_Window_MessageBox_ForReward:GetShow() then
    local pcKey = GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE)
    if pcKey and not _ContentsGroup_UsePadSnapping then
      PaGlobal_MessageBox_ForReward:apply()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    end
  elseif Panel_Window_MessageBoxForSequence_All ~= nil and PaGlobalFunc_MessageBoxForSequence_All_IsOpen ~= nil and PaGlobalFunc_MessageBoxForSequence_All_IsOpen() == true then
    if isKeyDown_Once(VCK.KeyCode_RETURN) == true then
      PaGlobalFunc_MessageBoxForSequence_All_Enter()
      return true
    elseif isKeyDown_Once(VCK.KeyCode_ESCAPE) == true then
      PaGlobalFunc_MessageBoxForSequence_All_Refuse()
      return true
    end
  end
  if nil ~= Panel_Window_MarketPlace_BuyManagement and true == Panel_Window_MarketPlace_BuyManagement:GetShow() and false == _ContentsGroup_UsePadSnapping and true == PaGlobal_TutorialPhase_IsTutorial() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_TutorialPhase_MarketPlace_EscapeClose(PaGlobal_MarketPlaceBuy_Cancel)
      return true
    end
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_R) and true == PaGlobal_TutorialPhase_MarketPlace_IsInputKeycode() then
      PaGlobal_TutorialPhase_MarketPlace:requestNext()
      return true
    end
  else
  end
  if nil ~= Panel_Window_MarketPlace_SellManagement and true == Panel_Window_MarketPlace_SellManagement:GetShow() and false == _ContentsGroup_UsePadSnapping and true == PaGlobal_TutorialPhase_IsTutorial() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_TutorialPhase_MarketPlace_EscapeClose(PaGlobal_MarketPlaceSell_Cancel)
      return true
    end
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_R) and true == PaGlobal_TutorialPhase_MarketPlace_IsInputKeycode() then
      PaGlobal_TutorialPhase_MarketPlace:requestNext()
      return true
    end
  else
  end
  if nil ~= Panel_Window_MarketPlace_MyInventory and true == Panel_Window_MarketPlace_MyInventory:GetShow() and false == _ContentsGroup_UsePadSnapping and true == PaGlobal_TutorialPhase_IsTutorial() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_TutorialPhase_MarketPlace_EscapeClose(PaGlobalFunc_MarketWallet_Close)
      return true
    end
    if true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_R) and true == PaGlobal_TutorialPhase_MarketPlace_IsInputKeycode() then
      PaGlobal_TutorialPhase_MarketPlace:requestNext()
      return true
    end
  end
  if ToClient_isConsole() == false and Panel_Party_ItemList:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    Panel_Party_ItemList_Close()
    return true
  end
  if true == _ContentsGroup_InstanceLocalWar then
    if Panel_LocalWarInfo_All ~= nil and Panel_LocalWarInfo_All:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_LocalWarInfo_All_New_Close()
      return true
    end
  elseif Panel_LocalWarInfo_All ~= nil and Panel_LocalWarInfo_All:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PaGlobal_LocalWarInfo_All_Close()
    return true
  end
  if nil ~= Panel_SavageDefenceShop and Panel_SavageDefenceShop:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    SavageDefenceShop_CloseByKey()
    return true
  end
  if PaGlobalFunc_ItemMarketAlarmList_GetShow() and not PaGlobalFunc_ItemMarketAlarmList_IsUISubApp() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ItemMarket_AlarmList_Close()
    return true
  end
  if nil ~= Panel_Purification_All then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and true == Panel_Purification_All:GetShow() then
      HandleEventLUp_Purification_All_Close()
      return true
    end
  elseif nil ~= Panel_Purification and true == Panel_Purification:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PuriManager:Close()
    return true
  end
  if _ContentsGroup_RenewUI and Panel_Chatting_Input:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ChatInput_Close()
    return true
  end
  if ToClient_isConsole() == false and Panel_Window_PetInfo_All:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PaGlobal_PetInfo_Close_All()
    return true
  end
  if nil ~= Panel_Window_GuildWarInfo and Panel_Window_GuildWarInfo:IsShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    FGlobal_GuildWarInfo_renew_Close()
    return true
  end
  if true ~= _ContentsGroup_RenewUI_Customization or PaGlobalFunc_Customization_GetShow() or not GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or Panel_CustomizingAlbum:GetShow() then
  end
  if nil ~= Panel_Window_EnchantStackConfirm_All and true == Panel_Window_EnchantStackConfirm_All:GetShow() then
    PaGlobalFunc_EnchantStackConfirm_All_PressKey()
  end
  if nil ~= Panel_Window_MessageBox_Edit_All and true == Panel_Window_MessageBox_Edit_All:GetShow() then
    PaGlobalFunc_MessageBox_Edit_All_PressKey()
  end
  if true == _ContentsGroup_NewUI_GameOption_All then
    PaGlobal_GameOption_All._confirmKeyCustomizing = false
  elseif nil ~= Panel_Window_Option_Main then
    PaGlobal_Option._confirmKeyCustomizing = false
  end
  if nil ~= Panel_UseItem_All and Panel_UseItem_All:IsShow() then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_SPACE) then
      HandleEventLUp_UseItem_All_UseItem()
      setUiInputProcessed(VCK.KeyCode_RETURN)
      setUiInputProcessed(VCK.KeyCode_SPACE)
      return true
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_UseItem_All_Close()
      return true
    end
  end
  if nil ~= Panel_Dialog_ServantMarket_All and true == Panel_Dialog_ServantMarket_All:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    PaGlobalFunc_ServantFunction_All_Close()
    return true
  end
  if nil ~= Panel_WorldMap_StableList and true == Panel_WorldMap_StableList:GetShow() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if _ContentsGroup_UsePadSnapping == true and ToClient_WorldMapIsShow() == true then
      PaGlobalFunc_WorldMap_StableList_Close()
    else
      PaGlobal_WorldMap_StableList_Close()
    end
    return true
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    if _ContentsGroup_UseCharacterWp == true then
      if PaGlobalFunc_UseCharacterWp_All_CanCloseByEsc ~= nil and PaGlobalFunc_UseCharacterWp_All_CanCloseByEsc() == true then
        PaGlobalFunc_UseCharacterWp_All_Close()
        return true
      end
    elseif Panel_Worldmap_NodeLevel ~= nil and Panel_Worldmap_NodeLevel:GetShow() == true then
      PaGlobalFunc_WorldMap_Grand_NodeLevel_Close()
      return true
    end
  end
  if Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true and (isKeyDown_Once(VCK.KeyCode_RETURN) == true or isKeyDown_Once(VCK.KeyCode_SPACE) == true) and false == _ContentsGroup_UsePadSnapping then
    HandleEventLUp_ClickAutoMove()
    return true
  end
  if Panel_Window_FishEncyclopedia_Renewal_All ~= nil and Panel_Window_FishEncyclopedia_Renewal_All:GetShow() == true and isKeyDown_Once(VCK.KeyCode_RETURN) == true and false == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_FishEncyclopedia_Renewal_All_SearchFishListByKeyword()
    return true
  end
  FGlobal_QASupportDamageWriter_Update()
  return false
end
function PaGlobal_GlobalKeyBinder.Process_ChattingInputMode()
  uiEdit = GetFocusEdit()
  if nil == uiEdit then
    return false
  end
  if WaitComment_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      settingWaitCommentConfirm()
    end
    return true
  elseif FGlobal_CheckEditBox_IngameCashShop_NewCart(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EscapeEditBox_IngameCashShop_NewCart(false)
    end
    return true
  elseif FGlobal_CheckEditBox_IngameCashShop(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_EscapeEditBox_IngameCashShop()
    end
    return true
  elseif FGlobal_CheckEditBox_PetCompose(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) or GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobal_EscapeEditBox_PetCompose_All(false)
    end
    return true
  elseif nil ~= NpcNavi_CheckCurrentUiEdit and NpcNavi_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_NpcNavi_All_ReturnKeyEvent(false)
    end
    return true
  elseif ChatInput_CheckCurrentUiEdit(uiEdit) then
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
      PaGlobal_AddFriend_All_Close()
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
      if isKeyPressed(VCK.KeyCode_SHIFT) == false then
        QASupport_Automation_EnterFunc(2)
      end
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
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_DOWN) then
      QASupport_Automation_PressDownKey(uiEdit)
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_UP) then
      QASupport_Automation_PressUpKey(uiEdit)
    end
    return true
  elseif PaGlobal_AddFriend_All_CheckCurrentUiEdit_All(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    end
    return true
  elseif nil ~= PaGlobal_Invite_All_CheckCurrentUiEdit_All and PaGlobal_Invite_All_CheckCurrentUiEdit_All(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    end
    return true
  elseif FriendMessanger_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      friend_killFocusMessangerByKey()
      PaGlobalFunc_FriendInfoList_All_KillFocusMessangerByKey()
    end
    return true
  elseif PaGlobalFunc_GuildIncentive_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_GuildIncentive_All_ClearFocusEdit()
    end
    return true
  elseif PaGlobalFunc_GuildInfo_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleEventLUp_GuildInfo_All_SaveNoticeText()
    end
    return true
  elseif nil ~= FGlobal_CheckArshaPvpUiEdit and FGlobal_CheckArshaPvpUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaPvPClearFocusEdit()
    end
    return true
  elseif nil ~= FGlobal_CheckArshaNameUiEdit_A and FGlobal_CheckArshaNameUiEdit_A(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaNameClearFocusEdit_A()
    end
    return true
  elseif nil ~= FGlobal_CheckArshaNameUiEdit_B and FGlobal_CheckArshaNameUiEdit_B(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ArshaNameClearFocusEdit_B()
    end
    return true
  elseif nil ~= PaGlobalFunc_Arsha_Func_All_InviteMemberUiEdit and PaGlobalFunc_Arsha_Func_All_InviteMemberUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Arsha_Func_All_ClearFocusEdit()
    end
    return true
  elseif nil ~= PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_A and PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_A(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Arsha_TeamNameChange_All_ClearFocusEdit()
    end
    return true
  elseif nil ~= PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_B and PaGlobalFunc_Arsha_TeamNameChange_All_UiEdit_B(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Arsha_TeamNameChange_All_ClearFocusEdit()
    end
    return true
  elseif FGlobal_ChattingFilter_UiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_ChattingFilter_ClearFocusEdit()
    end
    return true
  elseif nil ~= FGlobal_CheckPartyListUiEdit and FGlobal_CheckPartyListUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PartyListClearFocusEdit()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      FGlobal_PartyListClearFocusEdit()
      HandleClicked_PartyList_DoSearch()
    end
    return true
  elseif nil ~= PaGlobalFunc_PartyList_All_CheckUiEdit and PaGlobalFunc_PartyList_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_PartyList_All_ClearFocusEdit()
    end
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobalFunc_PartyList_All_ClearFocusEdit()
      HandleEventLUp_PartyList_All_DoSearch()
    end
    return true
  elseif nil ~= FGlobal_CheckPartyListRecruiteUiEdit and FGlobal_CheckPartyListRecruiteUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_PartyListClearFocusEdit()
    end
    return true
  elseif nil ~= PaGlobalFunc_PartyRecruite_All_CheckUiEdit and PaGlobalFunc_PartyRecruite_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_PartyList_All_ClearFocusEdit()
    end
    return true
  elseif nil ~= FGlobal_Alchemy_CheckEditBox and FGlobal_Alchemy_CheckEditBox(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      FGlobal_Alchemy_ClearEditFocus()
    end
    return true
  elseif nil ~= PaGlobal_Alchemy_All_CheckEditBox and PaGlobal_Alchemy_All_CheckEditBox(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_Alchemy_All_ClearEditFocus()
    end
    return true
  elseif nil ~= FGlobal_Memo_CheckUiEdit and FGlobal_Memo_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobal_Memo:Save()
    end
    return true
  elseif nil ~= PaGlobalFunc_Memo_Main_All_CheckUiEdit and PaGlobalFunc_Memo_Main_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_Memo_Main_All_Save()
    end
    return true
  elseif true == _ContentsGroup_isNewOption and true == FGlobal_Option_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      if true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All:ClickedSearchOption()
      else
        PaGlobal_Option:ClickedSeachOption()
      end
    end
    return true
  elseif false == _ContentsGroup_NewUI_ButtonShortcuts_All and true == FGlobal_ButtonShortcuts_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobal_ButtonShortcuts:ClickedSearch()
    end
    return true
  elseif true == _ContentsGroup_NewUI_ButtonShortcuts_All and true == PaGlobalFunc_ButtonShortcuts_All_CheckUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      HandleEventLUp_ButtonShortcuts_All_ApplySearch()
    end
    return true
  elseif true == PaGlobalFunc_MessageBox_Edit_All_CheckUiEdit(uiEdit) then
    if isPadUp(__eJoyPadInputType_A) then
      HandleEventLUp_MessageBox_Edit_All_isValidateText()
      return true
    end
  elseif PaGlobalFunc_SolareCustom_CheckUiEdit ~= nil and PaGlobalFunc_SolareCustom_CheckUiEdit(uiEdit) == true then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      ClearFocusEdit()
    elseif GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
      PaGlobalFunc_SolareCustom_PressedEnter()
    end
    return true
  end
  if false == _ContentsGroup_RenewUI_Knowledge and Panel_Knowledge_CheckCurrentUiEdit(uiEdit) then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      Panel_Knowledge_OutInputMode(false)
    end
    return true
  else
  end
  if _ContentsGroup_RenewUI == true or _ContentsGroup_UsePadSnapping == true then
    if nil ~= PaGlobalFunc_CharacterInfo_All_CheckIntroduceUiEdit and PaGlobalFunc_CharacterInfo_All_CheckIntroduceUiEdit(uiEdit) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      HandleEventLUp_CharInfoBasic_All_SetIntroduceText()
      UI.ClearFocusEdit()
      return true
    end
  elseif _ContentsGroup_isUsedNewCharacterInfo == false then
    if FGlobal_CheckMyIntroduceUiEdit(uiEdit) and nil ~= Panel_Window_CharInfo_BasicStatus then
      if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
        FGlobal_MyIntroduceClearFocusEdit()
      end
      return true
    end
  elseif nil ~= FGlobal_UI_CharacterInfo_Basic_Global_CheckIntroduceUiEdit and FGlobal_UI_CharacterInfo_Basic_Global_CheckIntroduceUiEdit(uiEdit) and nil ~= Panel_Window_CharInfo_Status then
    if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
      UI.ClearFocusEdit()
    end
    return true
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    ClearFocusEdit()
  end
  return false
end
function CommonWindowFunction(uiInputType, Function, param)
  if true == GlobalKeyBinder_CheckCustomKeyPressed(uiInputType) then
    if ToClient_isConsole() == true or ToClient_IsDevelopment() == true then
      ToClient_UIDebugInfoCollection(uiInputType)
    end
    Function(param)
    return true
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_CommonWindow(deltaTime)
  if true == _ContentsGroup_NewUI_LevelupInfo_All and not getEscHandle() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and nil ~= PaGlobalFunc_Levelup_Info_All_Hide and true == PaGlobalFunc_Levelup_Info_All_Hide() then
    return
  end
  if ToClient_isSimpleBuildMode() == true and isKeyDown_Once(VCK.KeyCode_ESCAPE) == true then
    return
  end
  if nil ~= HandleEventKeyBoard_MenuRemake_KeyPushCheck and false == HandleEventKeyBoard_MenuRemake_KeyPushCheck() then
    return
  end
  if Panel_Event_Termian_Welcom_All ~= nil and Panel_Event_Termian_Welcom_All:GetShow() == true and PaGlobalFunc_Event_Termian_Welcom_All_Close ~= nil and isKeyDown_Once(VCK.KeyCode_RETURN) == true then
    PaGlobalFunc_Event_Termian_Welcom_All_Close()
    return
  end
  if nil ~= Panel_Widget_BetterEquipment and nil ~= Input_BetterEquipment_EquipKeyUp then
    if false == _ContentsGroup_UsePadSnapping then
      if true == keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
        Input_BetterEquipment_EquipKeyUp()
      end
    elseif true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI and true == isPadUp(__eJoyPadInputType_Y) then
      Input_BetterEquipment_EquipKeyUp()
    end
  end
  if true == isKeyPressed(VCK.KeyCode_MENU) and true == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_OEM_3) and nil ~= PaGlobal_Ping_All_Open then
    PaGlobal_Ping_All_Open(false)
    return
  end
  if PaGlobalFunc_MessageBoxForSequence_All_IsOpen ~= nil and PaGlobalFunc_MessageBoxForSequence_All_IsOpen() == true and isKeyDown_Once(VCK.KeyCode_RETURN) == true and PaGlobalFunc_MessageBoxForSequence_All_Enter ~= nil then
    PaGlobalFunc_MessageBoxForSequence_All_Enter()
    return
  end
  if nil ~= Panel_Window_StartBranch and true == Panel_Window_StartBranch:GetShow() then
    return
  end
  if CommonWindowFunction(__eUiInputType_MentalKnowledge, Process_UIMode_CommonWindow_MentalKnowledge) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PositionNotify, Process_UIMode_CommonWindow_PositionNotify, fastPinDelta) then
    return
  end
  if CommonWindowFunction(__eUiInputType_CashShop, Process_UIMode_CommonWindow_CashShop) then
    return
  end
  if (PaGlobalFunc_BossReward_IsOpen == nil or PaGlobalFunc_BossReward_IsOpen() == false) and CommonWindowFunction(__eUiInputType_BlackSpirit, Process_UIMode_CommonWindow_BlackSpirit) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Help, FGlobal_Panel_WebHelper_ShowToggle) then
    return
  end
  if CommonWindowFunction(__eUiInputType_ProductionNote, Process_UIMode_CommonWindow_ProductionNote) then
    return
  end
  if CommonWindowFunction(__eUiInputType_ExpirienceWiki, Process_UIMode_CommonWindow_ExpirienceWiki) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PlayerInfo, Process_UIMode_CommonWindow_PlayerInfo) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Skill, Process_UIMode_CommonWindow_Skill) then
    return
  end
  if CommonWindowFunction(__eUiInputType_ChatTabNext, moveChatTab, true) then
    return
  end
  if CommonWindowFunction(__eUiInputType_ChatTabPrev, moveChatTab, false) then
    return
  end
  if CommonWindowFunction(__eUIInputType_PossessionByBlackSpirit, Process_UIMode_CommonWindow_PossessionByBlackSpirit) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Inventory, Process_UIMode_CommonWindow_Inventory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Dyeing, Process_UIMode_CommonWindow_Dyeing) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Present, Process_UIMode_CommonWindow_Present) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Manufacture, Process_UIMode_CommonWindow_Manufacture) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Guild, Process_UIMode_CommonWindow_Guild) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Mail, Process_UIMode_CommonWindow_Mail) then
    return
  end
  if CommonWindowFunction(__eUiInputType_FriendList, Process_UIMode_CommonWindow_FriendList) then
    return
  end
  if CommonWindowFunction(__eUiInputType_QuestHistory, Process_UIMode_CommonWindow_QuestHistory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_BeautyShop, Process_UIMode_CommonWindow_BeautyShop) then
    return
  end
  if CommonWindowFunction(__eUiInputType_WorldMap, Process_UIMode_CommonWindow_WorldMap) then
    return
  end
  if CommonWindowFunction(__eUiInputType_House, Process_UIMode_CommonWindow_House) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Worker, Process_UIMode_CommonWindow_WorkerManager) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Pet, PaGlobal_PetList_Toggle_All) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Maid, Process_UIMode_CommonWindow_Maid) then
    return
  end
  if CommonWindowFunction(__eUiInputType_Servant, Servant_Call, 0) then
    return
  end
  if CommonWindowFunction(__eUiInputType_GuildServant, FGlobal_GuildServantList_Open) then
    return
  end
  if CommonWindowFunction(__eUiInputType_DeleteNavigation, Process_UIMode_CommonWindow_DeleteNavigation) then
    return
  end
  if CommonWindowFunction(__eUiInputType_QuestJournal, Process_UIMode_CommonWindow_AdventureBook) then
    return
  end
  if CommonWindowFunction(__eUiInputType_BlackGift, Process_UIMode_CommonWindow_BlackGift) then
    return
  end
  if CommonWindowFunction(__eUiInputType_CallServantWater, Process_UIMode_CommonWindow_CallServantWater) then
    return
  end
  if true == _ContentsGroup_Barter and CommonWindowFunction(__eUiInputType_BarterInfo, Process_UIMode_CommonWindow_BarterInfo) then
    return
  end
  if true == _ContentsGroup_FamilyInventory and CommonWindowFunction(__eUiInputType_FamilyInventory, Process_UIMode_CommonWindow_FamilyInvenory) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PingType_Attack, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Attack) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PingType_Move, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Move) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PingType_Reader, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Help) then
    return
  end
  if CommonWindowFunction(__eUiInputType_PingType_Caution, Process_UIMode_CommonWindow_SetPingType, __eNotifyPingTypeBDO_Dangerous) then
    return
  end
  if CommonWindowFunction(__eUiInputType_MoveToWharf, Process_UIMode_CommonWindow_MoveToWharf) then
    return
  end
  fastPinDelta = fastPinDelta + deltaTime
  if fastPinDelta > 10 then
    fastPinDelta = 10
  end
  if isKeyPressed(VCK.KeyCode_SHIFT) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_OEM_7) then
    if FGlobal_ChatInput_CheckReply() then
      ChatInput_Show()
      ChatInput_CheckInstantCommand()
      FGlobal_ChatInput_Reply(true)
      ChatInput_ChangeChatType_Immediately(4)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTINGINPUT_NONEREPLYTARGET"))
    end
    return
  end
  if isKeyPressed(VCK.KeyCode_CONTROL) == true and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_F) == true then
    if PaGlobalFunc_Quest_All_SetFocusEdit ~= nil and PaGlobalFunc_Quest_All_GetShow() == true then
      PaGlobalFunc_Quest_All_SetFocusEdit()
      return
    end
    if PaGlobalFunc_FishEncyclopedia_Renewal_SetFocusEdit ~= nil and PaGlobalFunc_FishEncyclopedia_GetShow() == true then
      PaGlobalFunc_FishEncyclopedia_Renewal_SetFocusEdit()
      return
    end
    if PaGlobalFunc_TotalSearch_UseShortCutKey ~= nil and PaGlobalFunc_TotalSearch_UseShortCutKey() == true and Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == false then
      PaGlobalFunc_TotalSearch_Open()
      return
    end
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
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) and PaGloabl_Looting_All_GetShowPanel() then
    if true == _ContentsGroup_NewUI_Looting then
      HandleEventLUp_Looting_All_LootAll(false)
    else
      Panel_Looting_buttonLootAll_Mouse_Click(false)
    end
    Panel_Tooltip_Item_hideTooltip()
    if nil ~= QuestInfoData then
      QuestInfoData.questDescHideWindow()
    end
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_C) then
    if not isPvpEnable() then
      if true == _ContentsGroup_UsePadSnapping then
        local selfProxy = getSelfPlayer()
        if nil ~= selfProxy and selfProxy:get():getLevel() < 50 then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOLEVEL_ACK"))
          return
        end
      end
      return
    else
      PaGlobalFunc_MainStatus_RequestTogglePvP()
      return
    end
  end
  if nil ~= FGlobal_isOpenItemMarketBackPage and FGlobal_isOpenItemMarketBackPage() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_BACK) and false == FGlobal_isItemMarketBuyConfirm() then
    FGlobal_HandleClicked_ItemMarketBackPage()
  end
  if isKeyPressed(VCK.KeyCode_MENU) and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_B) then
    requestBlackSpritSkill()
    return
  end
  local isWeaponChange = false
  if true == _ContentsGroup_UsePadSnapping then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer and nil == ToClient_getSnappedControl() then
      isWeaponChange = keyCustom_IsDownOnce_Action(__eActionInputType_Interaction) and nil == interaction_getInteractable() and 0 == selfPlayer:get():getRideVehicleActorKeyRaw()
    end
  else
    isWeaponChange = keyCustom_IsDownOnce_Action(__eActionInputType_ServantOrder3)
  end
  if true == isWeaponChange then
    local itemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
    local skillType = ToClient_GetSelfPlayerSkillType()
    if nil == itemWrapper and skillType == __eSkillTypeParam_Awaken then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEmptyAwakenWeaponEquipSlot"))
    end
  end
  if _ContentsGroup_UsePadSnapping == false and PaGlobal_LifeRingMenu_All_Open ~= nil then
    PaGlobal_LifeRingMenu_All_Open()
  end
  if true == _ContentsGroup_NewCloseManager then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_CheckEscape()
  if true == getEscHandle() or false == GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    return
  end
  if selfPlayerIsFreeCamStateInCompetitionArea() then
    selfPlayerCloseFreecam()
    return
  end
  if ToClient_WorldMapIsShow() then
    FGlobal_WorldMapWindowEscape()
    return
  end
  if nil ~= Panel_EventNotify and Panel_EventNotify:GetShow() then
    FGlobal_NpcNavi_Hide()
    if true == _ContentsGroup_NewUI_EventNotify_All then
      PaGloabl_EventNotify_All_Close()
    else
      EventNotify_Close()
    end
    return
  end
  if nil ~= PaGlobalFunc_DailyStamp_GetShowPanel and PaGlobalFunc_DailyStamp_GetShowPanel() then
    DailStamp_Hide()
    Panel_Tooltip_Item_hideTooltip()
    TooltipSimple_Hide()
    return
  end
  if nil ~= Panel_Window_DailyStamp_All and true == Panel_Window_DailyStamp_All:GetShow() then
    PaGlobalFunc_DailyStamp_All_Close()
    Panel_Tooltip_Item_hideTooltip()
    TooltipSimple_Hide()
    return
  end
  if nil ~= Panel_Window_DailyChallenge and Panel_Window_DailyChallenge:GetShow() then
    PaGlobalFunc_DailyChallenge_Close()
    TooltipSimple_Hide()
    return
  end
  if nil ~= Panel_Window_ArshaTeamNameChange and Panel_Window_ArshaTeamNameChange:GetShow() then
    FGlobal_TeamNameChangeControl_Close()
    return
  end
  if nil ~= Panel_Window_ArshaInviteList and Panel_Window_ArshaInviteList:GetShow() then
    FGlobal_ArshaPvP_InviteList_Close()
    return
  end
  if nil ~= Panel_Window_Arsha and Panel_Window_Arsha:GetShow() then
    FGlobal_ArshaPvP_Close()
    return
  end
  if Panel_WatchingMode:GetShow() then
    return
  end
  if Panel_ScreenShotAlbum_FullScreen:GetShow() then
    ScreenshotAlbum_FullScreen_Close()
    return
  end
  if Panel_ScreenShotAlbum:GetShow() then
    ScreenshotAlbum_Close()
    return
  end
  if nil ~= Panel_Window_BlackSpiritAdventure then
    if Panel_Window_BlackSpiritAdventure:GetShow() and not Panel_Window_BlackSpiritAdventure:IsUISubApp() then
      BlackSpiritAd_Hide()
      return
    end
    if nil ~= Panel_Window_BlackSpiritAdventureVerPC and Panel_Window_BlackSpiritAdventureVerPC:GetShow() and not Panel_Window_BlackSpiritAdventure:IsUISubApp() then
      Panel_Window_BlackSpiritAdventureVerPC:SetShow(false, false)
      return
    end
  end
  if Panel_Window_BlackSpiritAdventure_2:GetShow() then
    BlackSpirit2_Hide()
    return
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    if nil ~= Panel_Window_ClothInventory_All and Panel_Window_ClothInventory_All:GetShow() then
      PaGlobalFunc_ClothInventory_All_Close()
      return
    end
    if PaGlobalFunc_ClothInventory_Renew_All_GetShow ~= nil and PaGlobalFunc_ClothInventory_Renew_All_GetShow:GetShow() == true then
      Panel_Window_ClothInventory_Renew_All()
      return
    end
  elseif nil ~= Panel_Window_ClothInventory and Panel_Window_ClothInventory:GetShow() then
    ClothInventory_Close()
    return
  end
  if nil ~= Panel_Masterpiece_Auction_Bid_All and true == Panel_Masterpiece_Auction_Bid_All then
    PaGlobal_Masterpiece_Auction_Bid_All_Close()
    return
  end
  if nil ~= Panel_Masterpiece_Auction_All and true == Panel_Masterpiece_Auction_All:GetShow() and nil ~= FGlobal_MasterPieceAuction_IsOpenEscMenu and FGlobal_MasterPieceAuction_IsOpenEscMenu() then
    PaGlobal_Masterpiece_Auction_All_Close()
    return
  end
  if Panel_MovieGuide_Web:GetShow() then
    if Panel_MovieGuide_Weblist:GetShow() then
      PaGlobal_MovieGuide_Weblist:Close()
      return
    else
      PaGlobal_MovieGuide_Web:Close()
      return
    end
  end
  if Panel_MovieGuide_Weblist:GetShow() then
    PaGlobal_MovieGuide_Weblist:Close()
    return
  end
  if true == _ContentsGroup_NewUI_QuestOption_All then
    if true == PaGlobal_Quest_Option_All_GetShow() then
      PaGlobal_Quest_Option_All_Close()
      return
    end
  elseif true == FGlobal_CheckedQuestQptionGetShow() then
    FGlobal_CheckedQuestOptionClose()
    return
  end
  if ToClient_isConsole() == false then
    if true == Panel_MovieSkillGuide_Web:GetShow() then
      if true == Panel_MovieSkillGuide_Weblist:GetShow() then
        PaGlobal_MovieSkillGuide_Weblist:Close()
        return
      else
        PaGlobal_MovieSkillGuide_Web:Close()
        return
      end
    end
    if true == Panel_MovieSkillGuide_Weblist:GetShow() then
      PaGlobal_MovieSkillGuide_Weblist:Close()
      return
    end
  elseif true == PaGlobalFunc_Skill_GetShow() then
    PaGlobalFunc_Skill_Close()
    return
  end
  if Panel_SaveSetting:IsShow() then
    PaGlobal_Panel_SaveSetting_Hide()
    return
  end
  if _ContentsGroup_HarvestList_All then
    if nil ~= Panel_HarvestList_All and true == Panel_HarvestList_All:GetShow() then
      PaGlobal_HarvestList_All_Close()
      return
    end
  elseif nil ~= Panel_HarvestList and true == Panel_HarvestList:GetShow() then
    HarvestList_Close()
    return
  end
  if ToClient_isConsole() == false and nil ~= Panel_PartyRecruite and Panel_PartyRecruite:GetShow() then
    PartyListRecruite_Close()
    return
  end
  if Panel_ServantResurrection:GetShow() then
    Panel_ServantResurrection_Close()
    return
  end
  if Panel_Window_Camp:GetShow() then
    if ToClient_isConsole() == true then
      if true == PaGlobalFunc_Dialog_NPCShop_GetShow() then
        PaGlobalFunc_Dialog_NPCShop_Close()
      else
        PaGlobal_Camp:close()
      end
    elseif nil ~= Panel_Window_NpcShop and true == Panel_Window_NpcShop:GetShow() then
      NpcShop_WindowClose()
    else
      PaGlobal_Camp:close()
    end
    return
  end
  if Panel_Window_CampRegister:GetShow() then
    FGlobal_CampRegister_Close()
    return
  end
  if Panel_Window_MonsterRanking:GetShow() then
    FGlobal_MonsterRanking_Close()
    return
  end
  if true == _ContentsGroup_ChatOption_All then
    if nil ~= Panel_Window_ChatOption_All and Panel_Window_ChatOption_All:GetShow() then
      PaGlobalFunc_ChatOption_All_Close()
      return
    end
  elseif nil ~= Panel_ChatOption and Panel_ChatOption:GetShow() then
    ChattingOption_Close()
    return
  end
  if Panel_Window_BuildingBuff:GetShow() then
    PaGlobal_BuildingBuff:close()
    return
  end
  if true == Panel_Window_PersonalBattle:GetShow() then
    PaGlobal_PersonalBattle:close()
    return
  end
  if true == _ContentsGroup_NewUI_Memo_All then
    if Panel_Window_Memo_Main_All:GetShow() then
      PaGlobalFunc_Memo_Main_All_Close()
      return
    end
  elseif Panel_Memo_List:GetShow() then
    PaGlobal_Memo:ListClose()
    return
  end
  if true == _ContentsGroup_RenewUI and true == Panel_Window_CharacterInfo_Renew:GetShow() then
    PaGlobalFunc_Window_CharacterInfo_Close()
    return
  end
  if Panel_CustomizingAlbum:GetShow() == true then
    CustomizingAlbum_Close()
  end
  local checkShowWindow = check_ShowWindow()
  if checkShowWindow then
    close_WindowPanelList()
    FGlobal_NpcNavi_Hide()
    return
  end
  if checkShowWindow and FGlobal_NpcNavi_IsShowCheck() then
    close_WindowPanelList()
    FGlobal_NpcNavi_Hide()
    return
  elseif not checkShowWindow and FGlobal_NpcNavi_IsShowCheck() then
    FGlobal_NpcNavi_Hide()
    return
  elseif checkShowWindow and not FGlobal_NpcNavi_IsShowCheck() then
    close_WindowPanelList()
    return
  else
    Panel_Menu_ShowToggle()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Arsha_Replay(deltaTime)
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if isKeyDown_Once(VCK.KeyCode_P) then
    ArshaReplayWidget_PlayOrPauseReplay(true)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_8) then
    ArshaReplayWidget_ClickRightOrLeftButton(-1)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_9) then
    ArshaReplayWidget_ClickRightOrLeftButton(1)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_EQUAL) then
    ArshaReplayWidget_SetPlayRate(true)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_MINUS) then
    ArshaReplayWidget_SetPlayRate(false)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_ESCAPE) then
    if Panel_Window_ReplayController_All:GetShow() == true then
      PaGlobal_ReplayController_Close()
    else
      ArshaReplayWidget_ToggleShowReplayUI()
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_1) then
    ArshaReplayWidget_PlayBookMarkHotKey(1)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_2) then
    ArshaReplayWidget_PlayBookMarkHotKey(2)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_3) then
    ArshaReplayWidget_PlayBookMarkHotKey(3)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_4) then
    ArshaReplayWidget_PlayBookMarkHotKey(4)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_5) then
    ArshaReplayWidget_PlayBookMarkHotKey(5)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_6) then
    ArshaReplayWidget_PlayBookMarkHotKey(6)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_7) then
    ArshaReplayWidget_PlayBookMarkHotKey(7)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_8) then
    ArshaReplayWidget_PlayBookMarkHotKey(8)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_9) then
    ArshaReplayWidget_PlayBookMarkHotKey(9)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_10) then
    ArshaReplayWidget_PlayBookMarkHotKey(10)
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_GroupCamera(deltaTime)
  if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) and true == ToClient_IsSkipAbleGroupCameraCutScene() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "CUTSCENE_EXIT_MESSAGEBOX_MEMO")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxMemo,
      functionYes = ToClient_stopCutSceneCamera,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    PaGlobalFunc_CutScene_HideKeyGuide()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_ProductionModify(deltaTime)
  if true == Panel_Window_CutSceneSkip:GetShow() then
    local self = PaGlobal_CutSceneSkip
    if true == _ContentsGroup_UsePadSnapping then
      if true == isPadDown(__eJoyPadInputType_A) then
        self:doSkip()
      else
        if true == isPadDown(__eJoyPadInputType_B) then
          self:prepareClose()
        else
        end
      end
    elseif true == isKeyDown_Once(VCK.KeyCode_RETURN) or true == isKeyDown_Once(VCK.KeyCode_SPACE) or true == isPadDown(__eJoyPadInputType_A) then
      self:doSkip()
    else
      if true == isKeyDown_Once(VCK.KeyCode_ESCAPE) or true == isPadDown(__eJoyPadInputType_B) then
        self:prepareClose()
      else
      end
    end
  else
    if true == Panel_Window_CutSceneScript:GetShow() then
      local self = PaGlobal_CutSceneScript
      if self._skipState.Press_Any_Key == self._currentSkipState then
        if true == self:isKeyDown_OnceESC() then
          self._ui._stc_skipAnno:SetShow(false)
          self._ui._txt_cancleAnno:SetShow(true)
          self._currentSkipState = self._skipState.Press_ESC_Key
        elseif true == self:isKeyDown_Once() then
          self._ui._stc_skipAnno:SetShow(true)
          self._ui._txt_cancleAnno:SetShow(false)
          self._currentSkipState = self._skipState.Press_R_Key
        end
      elseif self._skipState.Press_R_Key == self._currentSkipState then
        local isPressed = false
        if true == _ContentsGroup_UsePadSnapping then
          isPressed = isPadPressed(__eJoyPadInputType_Y)
        else
          isPressed = isKeyPressed(VCK.KeyCode_R)
        end
        if true == isPressed then
          self._ui._stc_skipAnno:SetShow(false)
          self._ui._txt_cancleAnno:SetShow(false)
          self._ui._stc_ESCkeyPress:SetShow(false)
          self._ui._stc_RkeyPress:SetShow(true)
          self._keyPressTime = self._keyPressTime + deltaTime
          self._ui._pg_keyPressTime:SetProgressRate(self._keyPressTime * 100 / self._keyPressMaxTime)
          if self._keyPressMaxTime <= self._keyPressTime then
            PaGlobal_CutSceneSkip:prepareOpen()
            self._currentSkipState = self._skipState.End
            self._ui._stc_RkeyPress:SetShow(false)
          end
        else
          self._keyPressTime = 0
          self._ui._stc_skipAnno:SetShow(true)
          self._ui._txt_cancleAnno:SetShow(false)
          self._ui._stc_RkeyPress:SetShow(false)
        end
      else
        if self._skipState.Press_ESC_Key == self._currentSkipState then
          local isPressed = false
          if true == _ContentsGroup_UsePadSnapping then
            isPressed = isPadPressed(__eJoyPadInputType_Start)
          else
            isPressed = isKeyPressed(VCK.KeyCode_ESCAPE)
          end
          if true == isPressed then
            self._ui._stc_skipAnno:SetShow(false)
            self._ui._txt_cancleAnno:SetShow(false)
            self._ui._stc_RkeyPress:SetShow(false)
            self._ui._stc_ESCkeyPress:SetShow(true)
            self._keyPressTime = self._keyPressTime + deltaTime
            self._ui._pg_keyPressTime:SetProgressRate(self._keyPressTime * 100 / self._keyPressMaxTime)
            if self._keyPressMaxTime <= self._keyPressTime then
              self:cancleSequence()
              self._currentSkipState = self._skipState.End
              self._ui._stc_ESCkeyPress:SetShow(false)
            end
          else
            self._keyPressTime = 0
            self._ui._stc_skipAnno:SetShow(false)
            self._ui._txt_cancleAnno:SetShow(true)
            self._ui._stc_RkeyPress:SetShow(false)
            self._ui._stc_ESCkeyPress:SetShow(false)
          end
        else
        end
      end
    else
    end
  end
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_8) then
    if true == ToClient_IsPlayingReplay() then
      ArshaReplayWidget_ClickRightOrLeftButton(-1)
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_9) then
    if true == ToClient_IsPlayingReplay() then
      ArshaReplayWidget_ClickRightOrLeftButton(1)
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_EQUAL) then
    if true == ToClient_IsPlayingReplay() then
      ArshaReplayWidget_SetPlayRate(true)
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_OEM_MINUS) then
    if true == ToClient_IsPlayingReplay() then
      ArshaReplayWidget_SetPlayRate(false)
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_ESCAPE) then
    if true == ToClient_IsPlayingReplay() then
      ArshaReplayWidget_ToggleShowReplayUI()
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_O) then
    local isOpen = PaGlobal_ProductionModify_isOpen()
    if nil == isOpen then
      return
    end
    if true == isOpen then
      PaGlobal_ProductionModify_Close()
    else
      PaGlobal_ProductionModify_Open()
    end
    return
  end
  if isKeyDown_Once(VCK.KeyCode_L) then
    ToClient_toggleCameraManagerShortCutList()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_ConsoleQuickMenu(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_Default(deltaTime)
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SiegeInstallMode(deltaTime)
  if CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if ToClient_isSimpleBuildMode() == true then
    return
  end
  if PaGlobal_House_InstallationSiege_All_CheckKeyBinder ~= nil then
    PaGlobal_House_InstallationSiege_All_CheckKeyBinder()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Tutorial(deltaTime)
  if Panel_ContentsTutorial_All ~= nil and Panel_ContentsTutorial_All:GetShow() == true then
    if isKeyDown_Once(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_ContentsTutorial_All_CancleTutorial()
    end
    if PaGlobal_ContentsTutorial_All._ui._stc_messageBox:GetShow() == true and isKeyDown_Once(VCK.KeyCode_RETURN) then
      PaGlobalFunc_ContentsTutorial_All_Close()
    end
    return
  end
  local tutorialWrapper = ToClient_getProgressingTutorialWrapper()
  if nil == tutorialWrapper then
    return
  end
  local isUpdate = true
  local isNotInput = tutorialWrapper:isNotInput()
  if true == isNotInput then
    local downKey = PaGlobal_Widget_Tutorial_GuideUI:isKeyDown_Once()
    if nil ~= downKey then
      isUpdate = tutorialWrapper:isAllowKey(downKey)
    else
      isUpdate = false
    end
  end
  if true == isUpdate then
    PaGlobal_GlobalKeyBinder.Process_UIMode_CommonWindow(deltaTime)
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_DrawEvent(deltaTime)
  if PaGlobal_Event_TicketShop == nil then
    return
  end
  if isKeyDown_Once(VCK.KeyCode_RETURN) == true or isKeyDown_Once(VCK.KeyCode_SPACE) == true then
    if PaGlobal_Event_TicketShop._ui._stc_unboxingResult ~= nil and PaGlobal_Event_TicketShop._ui._stc_unboxingResult:GetShow() == true then
      PaGlobal_Event_TicketShop_Unboxing_Result_Close()
      return
    end
    PaGlobal_Event_TicketShop_DrawConfirm()
    return
  end
  if isKeyDown_Once(VCK.KeyCode_ESCAPE) == true then
    PaGlobal_Event_TicketShop_Unboxing_Result_Close()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_EnterMorningLandPartyBoss(deltaTime)
  if PaGlobalFunc_MessageBoxForSequence_All_IsOpen ~= nil and PaGlobalFunc_MessageBoxForSequence_All_IsOpen() == true and isKeyDown_Once(VCK.KeyCode_RETURN) == true and PaGlobalFunc_MessageBoxForSequence_All_Enter ~= nil then
    PaGlobalFunc_MessageBoxForSequence_All_Enter()
    return
  end
  if true == _ContentsGroup_NewCloseManager then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_Replay(deltaTime)
  if ToClient_IsDevelopment() == true and CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if isKeyDown_Once(VCK.KeyCode_O) then
    ReplayInMirrorField_ToggleGuideUI()
    return
  end
  if isKeyDown_Once(VCK.KeyCode_P) then
    ReplayInMirrorField_PlayOrPauseReplay(true)
    return
  end
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_MoveLeft) then
    ReplayInMirrorField_ClickRightOrLeftButton(-1)
    return
  end
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_MoveRight) then
    ReplayInMirrorField_ClickRightOrLeftButton(1)
    return
  end
  if isKeyDown_Once(VCK.KeyCode_ESCAPE) then
    ReplayInMirrorField_StopReplay()
    return
  end
end
function PaGlobal_GlobalKeyBinder.Process_UIMode_SnowBoardInMirrorField(deltaTime)
  if Panel_Window_SnowBoard_Result_All:GetShow() and Panel_Window_SnowBoard_Result_All:IsEnable() then
    if isKeyDown_Once(VCK.KeyCode_ESCAPE) or isPadDown(__eJoyPadInputType_B) then
      PaGlobal_MessageBox_SnowBoard_Exit()
      return
    elseif isKeyDown_Once(VCK.KeyCode_RETURN) or isKeyDown_Once(VCK.KeyCode_SPACE) or isPadDown(__eJoyPadInputType_X) then
      PaGlobal_MessageBox_SnowBoard_Retry()
      return
    end
  end
  if _ContentsGroup_UsePadSnapping == false then
    if (isKeyDown_Once(VCK.KeyCode_RETURN) or isKeyDown_Once(VCK.KeyCode_SPACE)) and Panel_Window_MessageBox_SnowBoard:GetShow() then
      PaGlobal_MessageBox_SnowBoard_Retry()
      return
    end
    if isKeyDown_Once(VCK.KeyCode_ESCAPE) then
      PaGlobalFunc_SnowBoardMain_StopWithMessageBox()
    end
  elseif isPadDown(__eJoyPadInputType_B) and Panel_Window_MessageBox_SnowBoard:GetShow() == false then
    PaGlobalFunc_SnowBoardMain_StopWithMessageBox()
    return
  end
  if ToClient_IsDevelopment() == true and CommonWindowFunction(__eUiInputType_Chat, Process_UIMode_CommonWindow_Chatting) then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    if isUseNewQuickSlot() then
      local ii
      local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
      local quickSlot20 = CppEnums.ActionInputType.ActionInputType_QuickSlot20
      for ii = quickSlot1, quickSlot20 do
        if keyCustom_IsDownOnce_Action(ii) then
          HandleClicked_NewQuickSlot_Use(ii - quickSlot1)
          return
        end
      end
    else
      local ii
      local quickSlot1 = CppEnums.ActionInputType.ActionInputType_QuickSlot1
      local quickSlot10 = CppEnums.ActionInputType.ActionInputType_QuickSlot10
      for ii = quickSlot1, quickSlot10 do
        if keyCustom_IsDownOnce_Action(ii) then
          QuickSlot_Click(tostring(ii - quickSlot1))
          return
        end
      end
    end
  end
  if _ContentsGroup_UsePadSnapping == true and isPadUp(__eJoyPadInputType_DPad_Up) and Panel_Window_SnowBoard_Hud_All:GetShow() == true then
    PaGlobalFunc_SnowBoardHud_RideSnowBoard()
  end
  if CommonWindowFunction(__eUiInputType_Inventory, Process_UIMode_CommonWindow_Inventory) then
    return
  end
  if _ContentsGroup_NewCloseManager == true then
    close_escape_WindowPanelList()
  else
    Toclient_processCheckEscapeKey()
  end
end
