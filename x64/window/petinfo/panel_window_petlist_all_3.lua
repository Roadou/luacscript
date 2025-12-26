function HandleEventScroll_PetList_EraseAllEffect()
  if PaGlobal_PetList_All._petLeaderNo == nil then
    return
  end
  local control = PaGlobal_PetList_All._ui.list2_Pet:GetContentByKey(PaGlobal_PetList_All._petLeaderNo)
  if control ~= nil then
    local bg = UI.getChildControl(control, "Template_Static_ListContentBG")
    bg:EraseAllEffect()
    PaGlobal_PetList_All._petLeaderNo = nil
  end
end
function HandleEventLUp_PetList_Exchange_All()
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  Panel_Window_PetList_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_PetList_All:GetSizeX() / 2 - Panel_Window_PetFusion_All:GetSizeX() / 2)
  PaGlobal_PetFusion_Open_All()
  PaGlobal_PetList_All:setIgnoreAllSealBtns(true)
  PaGlobal_PetList_All:SetPetList()
end
function HandleEventLUp_PetList_FeedItem_All(index)
  if nil == Panel_Window_PetList_All then
    return
  end
  local gapSizeX = PaGlobal_PetList_All._ui.stc_FeedingIconSlot:GetSizeX() + 5
  PaGlobal_PetList_All._selectItemIndex = index
  PaGlobal_PetList_All._ui.stc_SelectedFeedingItemIcon:SetShow(true)
  PaGlobal_PetList_All._ui.stc_SelectedFeedingItemIcon:SetPosX(PaGlobal_PetList_All._ui.stc_FeedingIconSlot:GetPosX() + gapSizeX * index)
end
function HandleEventLUp_PetList_SealAllPet_All()
  if nil == Panel_Window_PetList_All then
    return
  end
  if Panel_Window_PetFusion_All:GetShow() then
    return
  end
  PaGlobal_PetList_All:closePopUP()
  PaGlobal_PetList_All:sealAllPet()
end
function HandleEventLUp_PetList_Seal_All(petNoStr, index)
  if nil == Panel_Window_PetList_All then
    return
  end
  if Panel_Window_PetRegister_All:GetShow() == true then
    PaGlobal_PetRegister_All:prepareClose()
  end
  PaGlobal_PetList_All:sealPet(petNoStr, index)
  if PaGlobal_PetList_All._isConsole then
    PaGlobal_PetList_All:closePopUP()
  end
end
function HandleEventLUp_PetList_ChangeFilter_All()
  PaGlobal_PetList_All:SetPetList()
end
function HandleEventLUp_PetList_RegistPCRoomPet_All()
  function registPcRoomPet()
    ToClient_requestPetForPcRoomRegister()
    PaGlobal_PetList_All._ui_pc.btn_RegistPCRoom:SetShow(false)
    PaGlobal_PetList_All._ui_pc.stc_FilterBG:SetShow(true)
  end
  local memoTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_Function_Alert")
  local memoContent = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PETLIST_ALL_PCROOM_MESSAGEBOX_DESC")
  local messageBoxData = {
    title = memoTitle,
    content = memoContent,
    functionYes = registPcRoomPet,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventMouseOn_PetList_Show_RegistPCRoomPetTooltip_All()
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLIST_REGISTEPCROOMMAIDBUTTON")
  local dese = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PETLIST_ALL_PCROOM_REGISTER_DESC")
  TooltipSimple_Show(PaGlobal_PetList_All._ui_pc.btn_RegistPCRoom, name, dese)
end
function HandleEventMouseOn_PetList_Show_SimpleTooltip_All(isShow, tipType, param)
  if nil == Panel_Window_PetList_All or not Panel_Window_PetList_All:GetShow() then
    return
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_PetList_All:simpleTooltip(tipType, param)
end
function HandleEventLUp_PetList_GroupClear_All()
  if true == PaGlobal_PetList_All._isConsole and false == PaGlobal_PetList_All._ui_console._btn_AllSealConsole[1]:GetShow() then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_GROUPCLEAR_ALERT"),
    functionYes = PaGlobal_PetList_GroupClear_All,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if true == PaGlobal_PetList_All._isConsole then
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBox.showMessageBox(messageBoxData, nil, nil, false)
  end
end
function HandleEventLUp_PetList_UseFeedItemToAll_All()
  if PaGlobal_PetList_All._selectItemIndex < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_SELECTFOODALERT"))
    return
  end
  ToClient_Pet_UseFeedItemFullAll(PaGlobal_PetList_All._selectItemIndex)
  HandleEventLUp_PetList_FeedItem_All(PaGlobal_PetList_All._selectItemIndex)
end
function HandleEventLUp_PetList_UseFeedItem_One_All()
  if PaGlobal_PetList_All._selectItemIndex < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_SELECTFOODALERT"))
    return
  end
  local petData = ToClient_getPetUnsealedDataByIndex(PaGlobal_PetList_All._feedingPetIndex)
  local petNo = petData:getPcPetNo()
  ToClient_Pet_UseFeedItemByIndex(PaGlobal_PetList_All._selectItemIndex, petNo)
end
function HandleEventLUp_PetList_UseFeedItem_Full_All()
  if PaGlobal_PetList_All._selectItemIndex < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLISTNEW_SELECTFOODALERT"))
    return
  end
  local petData = ToClient_getPetUnsealedDataByIndex(PaGlobal_PetList_All._feedingPetIndex)
  local petNo = petData:getPcPetNo()
  ToClient_Pet_UseFeedItemFullByIndex(PaGlobal_PetList_All._selectItemIndex, petNo)
end
function HandleEventLUp_PetList_FeedUI_Close_All()
  PaGlobal_PetList_All:showFeedUi(-1)
end
function HandleEventLUp_PetList_FeedUI_Show_All(index)
  PaGlobal_PetList_All:closePopUP()
  if 0 >= ToClient_Pet_GetFeedItemCount() then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_PET_FOOD_EMPTY"))
    return
  end
  PaGlobal_PetList_All._isFeedToAll = false
  PaGlobal_PetList_All:showFeedUi(index)
end
function HandleEventLUp_PetList_ChangeSkillUI_Show_All(petNoStr)
  PaGlobal_PetSkill_Change_Open_All(petNoStr)
  PaGlobal_PetList_All:closePopUP()
end
function HandleEventMouseOn_PetList_FeedItem_ShowTooltip(index, isFeedToAll)
  local itemWrapper = ToClient_Pet_GetFeedItemByIndex(index)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil ~= itemSSW then
    Panel_Tooltip_Item_SetPosition(index, PaGlobal_PetList_All._feedSlot[index].icon, "petList")
    if false == PaGlobal_PetList_All._isConsole then
      if isFeedToAll then
        Panel_Tooltip_Item_Show(itemSSW, PaGlobal_PetList_All._feedSlot[index].icon, true)
      else
        Panel_Tooltip_Item_Show(itemSSW, Panel_Window_PetList_All, true)
      end
    else
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_PetList_All._feedSlot[index].icon, true)
    end
  end
end
function HandleEventLup_PetUpgradePopup()
  function updatePetUpdateGuide()
    local fiveTierPetGuideNeverShowFlag = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiFiveTierPetGuideNeverShowFlag)
    local isConditionQuestClear = questList_isClearQuest(893, 2)
    if fiveTierPetGuideNeverShowFlag == true or isConditionQuestClear == true then
      PaGlobal_PetList_All._ui.btn_Guide:SetShow(false)
    else
      PaGlobal_PetList_All._ui.btn_Guide:SetShow(true)
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_POPUP_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_UPDATE_PETLEADER_DESC"),
    functionYes = updatePetUpdateGuide,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, nil, 6)
end
function HandleEventMouseOn_PetList_FeedItem_HideTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_PetList_SetOrder_ToOne_All(orderType, index)
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil ~= pcPetData then
    PaGlobal_PetList_All:orderPet(orderType, index)
  end
end
function HandleEventRUp_PetList_SetOrder_ToAll_All(orderType, index)
  local selectedPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == selectedPetData then
    return
  end
  local selectedPetNo_s64 = selectedPetData:getPcPetNo()
  local currentState
  if 0 == orderType then
    currentState = PaGlobal_PetList_All._petOrderList._follow[tostring(selectedPetNo_s64)]
  elseif 1 == orderType then
    currentState = PaGlobal_PetList_All._petOrderList._find[tostring(selectedPetNo_s64)]
  else
    currentState = PaGlobal_PetList_All._petOrderList._getItem[tostring(selectedPetNo_s64)]
  end
  local unsealPetCount = ToClient_getPetUnsealedList()
  for pIndex = 0, unsealPetCount - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(pIndex)
    if nil ~= pcPetData then
      local petNo_s64 = pcPetData:getPcPetNo()
      if 0 == orderType then
        if currentState == PaGlobal_PetList_All._petOrderList._follow[tostring(petNo_s64)] then
          PaGlobal_PetList_All:orderPet(orderType, pIndex)
        end
      elseif 1 == orderType then
        if currentState == PaGlobal_PetList_All._petOrderList._find[tostring(petNo_s64)] then
          PaGlobal_PetList_All:orderPet(orderType, pIndex)
        end
      elseif 2 == orderType and currentState == PaGlobal_PetList_All._petOrderList._getItem[tostring(petNo_s64)] then
        PaGlobal_PetList_All:orderPet(orderType, pIndex)
      end
    end
  end
end
function HandleEventLUp_PetList_SetPlay_ToOne_All(index)
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil ~= pcPetData then
    local petNo = pcPetData:getPcPetNo()
    local petLootingType = (pcPetData:getPetLootingType() + 1) % 3
    ToClient_requestChangePetLootingType(petNo, petLootingType)
  end
end
function HandleEventRUp_PetList_SetPlay_ToAll_All(index)
  local selectedPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == selectedPetData then
    return
  end
  local petLootingType = (selectedPetData:getPetLootingType() + 1) % 3
  local unsealPetCount = ToClient_getPetUnsealedList()
  for pIndex = 0, unsealPetCount - 1 do
    local pcPetData = ToClient_getPetUnsealedDataByIndex(pIndex)
    if nil ~= pcPetData then
      local petNo = pcPetData:getPcPetNo()
      ToClient_requestChangePetLootingType(petNo, petLootingType)
    end
  end
end
function HandleEventMouseOn_PetList_OrderTooltip_All(orderType, index)
  if nil == orderType then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_PetList_All:orderTooltip(orderType, index)
end
function HandleEventMouseOn_PetList_NameTooltip_All(isShow, index, isSealed)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_PetList_All:nameTooltip(isShow, index, isSealed)
end
function HandleEventMouseOn_PetList_BaseSkill_ShowTooltip_All(baseskillindex, typeStr)
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOut_PetList_BaseSkill_HideTooltip_All()
  Panel_SkillTooltip_Hide()
end
function HandleEventMouseOn_PetList_Show_SkillToolTip_All(skill_idx, typeStr, key)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  if nil ~= key then
    HandleEventMouseOn_PetFusion_SkillSelectOn_All(key)
  end
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOut_PetList_Hide_SkillToolTip_All(key)
  Panel_SkillTooltip_Hide()
  if nil ~= key then
    HandleEventMouseOut_PetFusion_SkillSelectOff_All(key)
  end
end
function HandleEventLUp_PetList_ChangePosition_All(isUp, index)
  ToClient_changePetListOrder(isUp, index)
  PaGlobal_PetList_All:SetPetList(true)
end
function HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(isShow, index, tipType, param)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_PetList_All:simpleTooltipBTN(index, tipType, param)
end
function HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(isShow, tipType, param, index)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  PaGlobal_PetList_All:showRestrictedPresetTooltip(tipType, param, index)
end
function HandleEventLUp_PetList_Unseal_All(petNoStr, isGroup)
  if Panel_Window_PetRegister_All:GetShow() == true then
    PaGlobal_PetRegister_All:prepareClose()
  end
  PaGlobal_PetList_All:unsealPet(petNoStr, isGroup)
  if PaGlobal_PetList_All._isConsole then
    PaGlobal_PetList_All:closePopUP()
  end
  if Panel_Window_PetSkillChange_All ~= nil and Panel_Window_PetSkillChange_All:IsShow() == true then
    PaGlobal_PetSkill_Change_Close_All()
  end
end
function HandleEventLUp_PetList_GroupUnseal_All(groupIndex)
  if _ContentsGroup_PetPresetExpansion == true then
    local currentPresetCount = ToClient_GetPetPresetCount()
    if PaGlobal_PetList_All._isConsole == true then
      groupIndex = PaGlobal_PetList_All._nowSelectGroup
    end
    if currentPresetCount < groupIndex then
      PaGlobalFunc_EasyBuy_Open(135)
      return
    end
  end
  if PaGlobal_PetList_All._isConsole == true then
    if false == PaGlobal_PetList_All._ui_console._btn_AllSealConsole[1]:GetShow() then
      return
    end
    PaGlobal_PetList_All:unsealPetGroup(PaGlobal_PetList_All._nowSelectGroup)
  else
    PaGlobal_PetList_All:unsealPetGroup(groupIndex)
  end
end
function HandleEventMouseOn_PetList_PetPropertyTooltip_Show(skillType)
  local petPropertyText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(skillType))
  TooltipSimple_CommonShow("", petPropertyText)
  TooltipSimple_Common_Pos(getMousePosX() + 15, getMousePosY() + 15)
end
function HandleEventLUp_PetList_FeedToAll_All()
  if Panel_Window_PetFusion_All:GetShow() then
    return
  end
  if 0 >= ToClient_Pet_GetFeedItemCount() then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_PET_FOOD_EMPTY"))
    return
  end
  PaGlobal_PetList_All:closePopUP()
  PaGlobal_PetList_All:showFeedUi(-1)
  PaGlobal_PetList_All:showFeedAllUi(true)
  PaGlobal_PetList_All._isFeedToAll = true
end
function HandleEventLUp_PetList_ChangeLeader(petNoStr)
  PaGlobal_PetList_All:changePetLeader(petNoStr)
end
function HandleEventLUp_PetList_Show_ConsolePopUP_All(isUnseal, index)
  if true == Panel_Window_PetFusion_All:GetShow() then
    return
  end
  PaGlobal_PetList_All:showPopUP(isUnseal, index)
end
function HandleEventLUp_PetInfo_Open_All(petNoStr)
  PaGlobal_PetInfo_Open_All(petNoStr)
  PaGlobal_PetList_All:closePopUP()
end
function HandleEventMOn_PetList_All_SetKeyGuideA(index)
  local keyGuideA = PaGlobal_PetList_All._ui_console.stc_Popup_KeyGuideA
  keyGuideA:SetPosY(PaGlobal_PetList_All._popUpKeyGuideADefaultPosY + index * PaGlobal_PetList_All._popUpKeyGuideAGapSizeY)
end
function HandleEventDpadRight_PetList_All_PopUPBlockSnapGroupMove()
  ToClient_padSnapSetTargetGroup(PaGlobal_PetList_All._ui_console.stc_PopupBG)
  ToClient_padSnapIgnoreGroupMove()
end
function HandleEventDpadRight_PetList_All_FeedBlockSnapGroupMove()
  ToClient_padSnapSetTargetGroup(PaGlobal_PetList_All._ui.stc_FeedingBG)
  ToClient_padSnapIgnoreGroupMove()
end
function HandleEventLUp_PetList_All_ExchangeOpen_ForConsole()
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  PaGlobal_PetList_All:closePopUP()
  Panel_Window_PetList_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_PetList_All:GetSizeX() / 2 - Panel_Window_PetFusion_All:GetSizeX() / 2)
  PaGlobal_PetFusion_Open_All()
  PaGlobal_PetList_All:setIgnoreAllSealBtns(true)
  PaGlobal_PetList_All:SetPetList(true)
  ToClient_padSnapSetTargetPanel(Panel_Window_PetList_All)
  PaGlobalFunc_PetList_All_Show_AcquireBG(false)
end
function HandleEventLUp_PetList_All_GroupingOpen_ForConsole()
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  PaGlobal_PetList_All:closePopUP()
  Panel_Window_PetList_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_PetList_All:GetSizeX() / 2 - Panel_Window_PetFusion_All:GetSizeX() / 2)
  PaGlobal_PetList_All:setIgnoreAllSealBtns(true)
  PaGlobal_PetList_All:SetPetList(true)
  ToClient_padSnapSetTargetPanel(Panel_Window_PetList_All)
end
function HandleEventPadX_PetList_All()
  if PaGlobal_PetFusion_GetShow_All() then
    return
  end
  if PaGlobal_PetList_All._ui.stc_FeedingBG:GetShow() then
    HandleEventPadX_PetList_FeedItem_ShowTooltip_Toggle(PaGlobal_PetList_All._selectItemIndex)
  else
    if 0 >= ToClient_Pet_GetFeedItemCount() then
      Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_PET_FOOD_EMPTY"))
      return
    end
    HandleEventLUp_PetList_FeedToAll_All()
  end
end
function HandleEventPadY_PetList_All()
  if PaGlobal_PetList_All._ui_console.stc_Feeding_KeyGuideY:GetShow() then
    HandleEventLUp_PetList_UseFeedItem_Full_All()
  elseif false == PaGlobal_PetList_All_GetFeedShow() then
    HandleEventLUp_PetList_SealAllPet_All()
  end
end
function HandleEventPadX_PetList_FeedItem_ShowTooltip_Toggle(index)
  if true == _ContentsGroup_RenewUI_Tooltip and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  elseif nil ~= Panel_Tooltup_Item_isShow and true == Panel_Tooltup_Item_isShow() then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = ToClient_Pet_GetFeedItemByIndex(index)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
  elseif PaGlobal_PetList_All._isFeedToAll then
    Panel_Tooltip_Item_Show(itemSSW, PaGlobal_PetList_All._feedSlot[index].icon, true)
  else
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_PetList_All, true)
  end
end
function FromClient_PetList_PetUpdate_All()
  if nil ~= Panel_Widget_PetControl_All then
    PaGlobal_PetControl_PetIconUpdate_All()
  end
  if nil == Panel_Window_PetList_All or not Panel_Window_PetList_All:GetShow() then
    return
  end
  PaGlobal_PetList_All:SetPetList(true)
end
function FromClient_PetList_UpdatePetPreset(presetKey)
  if PaGlobal_PetList_All == nil then
    return
  end
  PaGlobal_PetList_All:registerShortCutEvent()
  PaGlobal_TotalPreset_UpdatePreset()
  if PaGlobal_PetList_GetShow_All() == false then
    return
  end
  PaGlobal_PetList_All:updatePetPreset(presetKey)
end
function FromClient_PetList_UpdatePetPresetAll()
  if PaGlobal_PetList_All == nil then
    return
  end
  PaGlobal_PetList_All:registerShortCutEvent()
  if PaGlobal_PetList_GetShow_All() == false then
    return
  end
  PaGlobal_PetList_All:updatePetPresetAll()
end
function FromClient_PetList_SealPetUpdate_All(petNo_s64)
  if nil ~= Panel_Widget_PetControl_All then
    PaGlobal_PetControl_PetIconUpdate_All()
  end
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  if nil == Panel_Window_PetList_All or not Panel_Window_PetList_All:GetShow() then
    return
  end
  local isLeader = ToClient_isLeaderPet(petNo_s64)
  if isLeader == true then
    PaGlobal_PetList_All:updateListSize(isLeader, false)
  end
  PaGlobal_PetList_All:SetPetList(true)
end
function FromClient_PetList_UnsealPetUpdate_All(petNo_s64)
  if nil ~= Panel_Widget_PetControl_All then
    PaGlobal_PetControl_PetIconUpdate_All()
  end
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  if nil == Panel_Window_PetList_All or not Panel_Window_PetList_All:GetShow() then
    return
  end
  local isLeader = ToClient_isLeaderPet(petNo_s64)
  if isLeader == true then
    PaGlobal_PetList_All._showLeaderEffect = true
    PaGlobal_PetList_All:updateListSize(isLeader, false)
  end
  PaGlobal_PetList_All:SetPetList(true)
end
function FromClient_PetList_UpdateFeedUi_All()
  if nil == Panel_Window_PetList_All or not Panel_Window_PetList_All:GetShow() then
    return
  end
  PaGlobal_PetList_All:updateFeedUi(PaGlobal_PetList_All._isFeedToAll)
end
function FromClient_PetList_All_RefreshPcRoomState()
  local isPcRoom = false
  local temporaryInformation = getTemporaryInformationWrapper()
  if nil ~= temporaryInformation and true == temporaryInformation:isPremiumPcRoom() and true == _ContentsGroup_PcRoomPet then
    isPcRoom = true
  end
  PaGlobal_PetList_All:UpdateUIByChangedPcRoomState(isPcRoom)
end
function FromClient_PetList_ChangePetLeader(petNo)
  pcPetData = ToClient_getPetSealedDataByPetNo(petNo)
  if pcPetData ~= nil then
    PaGlobal_PetList_All._petLeaderNo = petNo
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETLEADER_MSG_CONFIRM", "name", pcPetData:getName()))
    FromClient_PetList_PetUpdate_All()
    local control = PaGlobal_PetList_All._ui.list2_Pet:GetContentByKey(petNo)
    if control ~= nil then
      local bg = UI.getChildControl(control, "Template_Static_IconPetBG")
      if bg ~= nil then
        bg:AddEffect("fUI_InGame_Pet_Out_04A", false, 200, -4)
      end
    end
  end
end
function FromClient_PetList_PetSkillChange()
  if Panel_Window_PetList_All == nil or Panel_Window_PetList_All:GetShow() == false then
    return
  end
  PaGlobal_PetList_All:updatePetList()
end
function FromClient_UsePetSkillChangeItem()
  if Panel_Window_PetList_All == nil then
    return
  end
  PaGlobal_PetList_Show_All()
end
function PaGlobal_PetList_GetShow_All()
  if nil ~= Panel_Window_PetList_All then
    return Panel_Window_PetList_All:GetShow()
  end
end
function PaGlobal_PetList_Toggle_All()
  if Panel_Window_PetList_All:GetShow() then
    PaGlobal_PetList_All:prepareClose()
    audioPostEvent_SystemUi(1, 1)
    _AudioPostEvent_SystemUiForXBOX(1, 1)
  else
    PaGlobal_PetList_All:prepareOpen()
    audioPostEvent_SystemUi(1, 40)
    _AudioPostEvent_SystemUiForXBOX(1, 40)
  end
  PaGlobal_PetList_All:setIgnoreAllSealBtns(false)
end
function PaGlobalFunc_PetList_ShowByRegisterPet()
  PaGlobal_PetList_Show_All()
  PaGlobal_PetList_All._ui.list2_Pet:moveBottomIndex()
end
function PaGlobal_PetList_Show_All()
  PaGlobal_PetList_All:prepareOpen()
  audioPostEvent_SystemUi(1, 40)
  _AudioPostEvent_SystemUiForXBOX(1, 40)
  PaGlobal_PetList_All:setIgnoreAllSealBtns(false)
end
function PaGlobal_PetList_Close_All()
  if nil == Panel_Window_PetList_All then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  if nil ~= Panel_Window_PetSkillChange_All and Panel_Window_PetSkillChange_All:GetShow() == true then
    PaGlobal_PetSkill_Change_Close_All()
    return
  end
  PaGlobal_PetList_All:prepareClose()
end
function PaGlobal_PetList_ListCreate_All(control, key)
  if nil == Panel_Window_PetList_All then
    return
  end
  PaGlobal_PetList_All:createContents(control, key)
end
function PaGlobal_PetList_isUnSealPet_All(petNo_s64)
  local unsealPetCount = ToClient_getPetUnsealedList()
  if unsealPetCount > 0 then
    for index = 0, unsealPetCount - 1 do
      local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
      if nil ~= pcPetData and petNo_s64 == pcPetData:getPcPetNo() then
        return true
      end
    end
  end
  return false
end
function PaGlobal_PetList_UpdateControlIconInfo_All(petNo64, followAndWait, isFind, isGetItem)
  if false == PaGlobal_PetList_isUnSealPet_All(petNo64) then
    return
  end
  if followAndWait then
    ToClient_callHandlerToPetNo("handlePetFollowMaster", petNo64)
  else
    ToClient_callHandlerToPetNo("handlePetWaitMaster", petNo64)
  end
  if isFind then
    ToClient_callHandlerToPetNo("handlePetFindThatOn", petNo64)
  else
    ToClient_callHandlerToPetNo("handlePetFindThatOff", petNo64)
  end
  if isGetItem then
    ToClient_callHandlerToPetNo("handlePetGetItemOn", petNo64)
  else
    ToClient_callHandlerToPetNo("handlePetGetItemOff", petNo64)
  end
  PaGlobal_PetList_All._petOrderList._follow[tostring(petNo64)] = followAndWait
  PaGlobal_PetList_All._petOrderList._find[tostring(petNo64)] = isFind
  PaGlobal_PetList_All._petOrderList._getItem[tostring(petNo64)] = isGetItem
end
function PaGlobal_PetList_UpdateControl_All(petNo64)
  PaGlobal_PetList_All:initUnsealPetOrderInfo(petNo64)
  PaGlobal_PetList_UpdateControlIconInfo_All(petNo64, PaGlobal_PetList_All._petOrderList._follow[tostring(petNo64)], PaGlobal_PetList_All._petOrderList._find[tostring(petNo64)], PaGlobal_PetList_All._petOrderList._getItem[tostring(petNo64)])
end
function PaGlobal_PetList_GroupClear_All()
  if _ContentsGroup_PetPresetExpansion == true then
    ToClient_ClearPetPresetInfoAll()
  else
    for index = 1, PaGlobal_PetList_All._GroupCount do
      PaGlobal_PetList_All._checkUnSealGroupList[index] = {}
    end
    PaGlobal_PetList_All:savePetGroupList()
    PaGlobal_PetList_All:SetPetList()
  end
end
function PaGlobal_PetList_GroupSealCheck_All(petNoStr, groupIndex)
  PaGlobal_PetList_All:checkPetGroupList()
  local groupCount = 0
  for key, value in pairs(PaGlobal_PetList_All._checkUnSealGroupList[groupIndex]) do
    if true == value then
      groupCount = groupCount + 1
    end
  end
  if nil == PaGlobal_PetList_All._checkUnSealGroupList[groupIndex][petNoStr] or false == PaGlobal_PetList_All._checkUnSealGroupList[groupIndex][petNoStr] then
    if groupCount >= PaGlobal_PetList_All._maxUnsealCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_UNABLE_CHECKGROUP"))
      PaGlobal_PetList_All:SetPetList(true)
      return
    end
    PaGlobal_PetList_All._checkUnSealGroupList[groupIndex][petNoStr] = true
  else
    PaGlobal_PetList_All._checkUnSealGroupList[groupIndex][petNoStr] = false
  end
  PaGlobal_PetList_All:savePetGroupList(petNoStr, groupIndex)
  if true == PaGlobal_PetList_All._isConsole then
    PaGlobal_PetList_All._ui.list2_Pet:requestUpdateVisible()
    PaGlobal_PetList_All:closePopUP()
    for idx = 1, PaGlobal_PetList_All._maxPresetCount do
      if nil ~= PaGlobal_PetList_All._ui_console._btn_AllSealConsole[idx] then
        PaGlobal_PetList_All._ui_console._btn_AllSealConsole[idx]:SetCheck(idx == PaGlobal_PetList_All._nowSelectGroup)
      end
    end
  end
end
function PaGlobal_PetList_GetSkillTypeString_All(skillType)
  local paramText = ""
  if 1 == skillType then
    paramText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_ITEMGETTIME", "itemGetTime", string.format("%.1f", math.floor(skillParam:getParam(0) / 10) / 100))
  elseif 2 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDGATHER")
  elseif 3 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPK")
  elseif 4 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPLACE")
  elseif 5 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MOBAGGRO")
  elseif 6 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDRAREMONSTER")
  elseif 7 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REDUCEAUTOFISHINGTIME")
  elseif 8 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REGISTILL")
  elseif 9 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_AUTOGETHERING")
  elseif 10 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_GETHERINGINCREASE")
  elseif 11 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_HPRECOVERY")
  elseif 12 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MPRECOVERY")
  elseif 13 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDLOSTNORMALITEM")
  elseif 14 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDLOSTSPECIALITEM")
  end
  return paramText
end
function PaGlobal_PetList_CheckFusionButtonPcRoomPet_All(petNo_s64)
  local sealPetCount = ToClient_getPetSealedList()
  for index = 0, sealPetCount do
    local petData = ToClient_getPetSealedDataByIndex(index)
    if nil ~= petData and true == petData:getPetStaticStatus():isOnlyPcRoom() and petNo_s64 == petData._petNo then
      return false
    end
  end
  return true
end
function FGlobal_CheckEditBox_PetCompose(uiEditBox)
  return nil ~= uiEditBox and nil ~= PaGlobal_PetFusion_GetPetEditName_All() and uiEditBox:GetKey() == PaGlobal_PetFusion_GetPetEditName_All():GetKey()
end
function PaGlobal_PetList_AllUnSeal_ForQA()
  for index = 0, PaGlobal_PetList_All._maxUnsealCount - 1 do
    local unSealPetInfo = ToClient_getPetUnsealedList()
    local PetUnSealData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= PetUnSealData then
      local unsealPetNo_s64 = PetUnSealData:getPcPetNo()
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_ALLUNSEAL"))
      PaGlobal_PetList_All:unsealPet(tostring(unsealPetNo_s64), true)
    end
  end
end
function PaGlobal_PetList_ReverseAllUnSeal_ForQA()
  local sealPetCount = ToClient_getPetSealedList()
  local unSealPetCount = ToClient_getPetUnsealedList()
  local enableUnSealCount = 5 - unSealPetCount
  if 0 == sealPetCount then
    return
  end
  for petIndex = 0, enableUnSealCount - 1 do
    local petLastIndex = sealPetCount - 1 - petIndex
    local petData = ToClient_getPetSealedDataByIndex(petLastIndex)
    local petNo_s64 = petData._petNo
    PaGlobal_PetList_All:unsealPet(tostring(petNo_s64), true)
  end
end
function PaGlobal_PetList_All_GetFeedShow()
  return PaGlobal_PetList_All._ui.stc_FeedingBG:GetShow()
end
function PaGlobal_PetList_All_TempClose()
  PaGlobal_PetList_All:closePopUP()
  PaGlobal_PetList_All:close()
end
function PaGlobal_PetList_All_TempOpen()
  PaGlobal_PetList_All:open()
end
function PaGlobal_PetList_All_SetGroupIndexForConsole(isUp)
  if false == Panel_Window_PetList_All:GetShow() or false == PaGlobal_PetList_All._ui_console._btn_AllSealConsole[1]:GetShow() then
    return
  end
  local presetCount = ToClient_GetPetPresetCount()
  if PaGlobal_PetList_All._isConsoleService == false then
    presetCount = presetCount + 1
  end
  local maxSelectCount = math.min(presetCount, PaGlobal_PetList_All._maxPresetCount)
  if true == isUp then
    PaGlobal_PetList_All._nowSelectGroup = PaGlobal_PetList_All._nowSelectGroup + 1
    if maxSelectCount < PaGlobal_PetList_All._nowSelectGroup then
      PaGlobal_PetList_All._nowSelectGroup = 1
    end
  else
    PaGlobal_PetList_All._nowSelectGroup = PaGlobal_PetList_All._nowSelectGroup - 1
    if 1 > PaGlobal_PetList_All._nowSelectGroup then
      PaGlobal_PetList_All._nowSelectGroup = maxSelectCount
    end
  end
  for idx = 1, maxSelectCount do
    if nil ~= PaGlobal_PetList_All._ui_console._btn_AllSealConsole[idx] then
      PaGlobal_PetList_All._ui_console._btn_AllSealConsole[idx]:SetCheck(idx == PaGlobal_PetList_All._nowSelectGroup)
    end
  end
end
function HandleEventLUp_PetList_ShowNearStable()
  local player = getSelfPlayer()
  if player == nil then
    return
  end
  local selfPlayer = player:get()
  if selfPlayer == nil then
    return
  end
  local position = player:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(CppEnums.SpawnType.eSpawnType_Stable, position)
  if nearNpcInfo == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNavigationCantFindPath"))
    return
  end
  local isSpawnNearNpc = nearNpcInfo:isTimeSpawn()
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  if isSpawnNearNpc == false then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION", "npcName", tostring(CppEnums.SpawnTypeString[CppEnums.SpawnType.eSpawnType_Stable])))
  TooltipSimple_Hide()
  PaGlobal_PetList_All:prepareClose()
end
function HandleEventLUp_PetList_OpenMarketPlace()
  TooltipSimple_Hide()
  PaGlobal_PetList_All:prepareClose()
  if PaGlobalFunc_MarketPlace_Open ~= nil then
    PaGlobalFunc_MarketPlace_Open()
  end
end
function PaGlobalFunc_PetList_All_Show_AcquireBG(isShow)
  if PaGlobal_PetList_All._ui.stc_AcquireBG == nil then
    return
  end
  if isShow == false then
    PaGlobal_PetList_All._ui.stc_AcquireBG:SetShow(false)
  elseif ToClient_Pet_GetFeedItemCount() == 0 then
    PaGlobal_PetList_All._ui.stc_AcquireBG:SetShow(true)
    PaGlobal_PetList_All:resizeAcquireBG()
  end
end
function HandleEventMouseOn_PetList_Show_StableTooltip(isShow)
  if isShow == nil then
    return
  end
  if PaGlobal_PetList_All._ui.btn_BuyStable == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_BUYSTABLE")
  TooltipSimple_Show(PaGlobal_PetList_All._ui.btn_BuyStable, desc, nil, false)
end
function HandleEventMouseOn_PetList_Show_MarketTooltip(isShow)
  if isShow == nil then
    return
  end
  if PaGlobal_PetList_All._ui.btn_BuyMarket == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETLISTNEW_BUYMARKET")
  TooltipSimple_Show(PaGlobal_PetList_All._ui.btn_BuyMarket, desc, nil, false)
end
function HandleEventLUp_PetList_ChangeName(petNoStr, petIconPath)
  if Panel_Window_PetList_All == nil then
    return
  end
  if Panel_Window_PetRegister_All == nil then
    return
  end
  PaGlobal_PetList_All:closePopUP()
  PaGlobal_PetRegister_All._selectPetNo = petNoStr
  PaGlobal_PetRegister_All._selectPetIconPath = petIconPath
  ToClient_checkNameChangeItemExist(__ePetType_Normal)
end
