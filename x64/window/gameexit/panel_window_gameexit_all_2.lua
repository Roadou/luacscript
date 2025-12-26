function HandleEventOnOut_GameExit_All_ClassTooltip(isShow, classType, index)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = NewClassData.newClass_String[classType]._classType2String
  control = PaGlobal_GameExit_All._basic._txt_levelPool[index]
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GameExit_All_SimpleTooltip(isShow, index, tipType, defaultCount, valksCount, familyCount)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    local isValksItemCheck
    if PaGlobal_GameExit_All._isValksContensOption then
      isValksItemCheck = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP", "defaultCount", tostring(defaultCount), "valksCount", tostring(valksCount), "familyCount", tostring(familyCount))
    else
      isValksItemCheck = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENCHANTCOUNT_TOOLTIP_ADDCOUNT_NONE", "defaultCount", tostring(defaultCount))
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NORMALSTACK_TOOLTIP_DESC") .. isValksItemCheck
    if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._basic._txt_enchantFailCountPool[index]
    elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._all._txt_enchantFailCountPool[index]
    end
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARWP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
    if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._basic._txt_energyPool[index]
    elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
      control = PaGlobal_GameExit_All._all._txt_energyPool[index]
    end
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_TRAYWINDOW")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TOOLTIP_TRAYFORBLACKDESERT_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    control = PaGlobal_GameExit_All._ui._pc._btn_tray
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEvent_GameExit_All_UpdateSlot(startIdx)
  if true == PaGlobal_GameExit_All._isConsole and true == Panel_Window_SimpleInventory:GetShow() then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  TooltipSimple_Hide()
  PaGlobal_GameExit_All:updateCharacterSlot(startIdx)
end
function HandleEventLUp_GameExit_All_ChangeAccount()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_CHANGEACCOUNT_MSGBOX")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameExit_All_ChangeAccount_MessageBoxConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function HandleEventLUp_GameExit_All_Move()
  if _ContentsGroup_WorldMapFamilyCharacterManagement == true then
    return
  end
  if true == ToClient_IsInstanceField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  FGlobal_DeliveryForGameExit_Show(true)
end
function HandleEventOn_GameExit_All_SlotMouseOver(idx)
  if PaGlobal_GameExit_All._prevClickIndex ~= idx and false == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All._basic._btn_invenPool[PaGlobal_GameExit_All._prevClickIndex]:SetShow(false)
    PaGlobal_GameExit_All._basic._btn_change_pcPool[PaGlobal_GameExit_All._prevClickIndex]:SetShow(false)
    PaGlobal_GameExit_All._basic._stc_picturePool[PaGlobal_GameExit_All._prevClickIndex]:ResetVertexAni()
    PaGlobal_GameExit_All._basic._stc_picturePool[PaGlobal_GameExit_All._prevClickIndex]:SetAlpha(1)
  end
  if idx ~= PaGlobal_GameExit_All._nowPlayCharaterSlotNo and false == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetShow(true)
    local characterData = getCharacterDataByIndex(PaGlobal_GameExit_All._photoIndex + 1 + idx, PaGlobal_GameExit_All._playerCreateType)
    if nil == characterData then
      return
    end
    local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
    if true == _ContentsGroup_SeasonContents then
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetIgnore(false)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetMonoTone(false, false)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetShow(true)
    else
      local isPreSeasonContent = true == _ContentsGroup_PreSeason and true == isSeasonCharacter
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetIgnore(isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetMonoTone(isPreSeasonContent, isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetIgnore(isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_invenPool[idx]:SetMonoTone(isPreSeasonContent, isPreSeasonContent)
      PaGlobal_GameExit_All._basic._btn_change_pcPool[idx]:SetShow(true)
    end
  end
  if ToClient_isConsole() == true then
    PaGlobal_GameExit_All._basic._stc_picturePool[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeCharacter(" .. idx .. ")")
  end
  PaGlobal_GameExit_All._basic._stc_picturePool[idx]:ResetVertexAni()
  PaGlobal_GameExit_All._basic._stc_picturePool[idx]:SetVertexAniRun("Ani_Color_New", true)
  PaGlobal_GameExit_All._prevClickIndex = idx
end
function HandleEventLDClick_GameExit_All_ChangeCharacter_slot(uiCount, idx)
  if true == _ContentsGroup_RenewUI then
    return
  end
  if true == PaGlobal_GameExit_All._basic._btn_change_pcPool[uiCount]:GetShow() then
    HandleEventLUp_GameExit_All_ChangeCharacter(idx)
  elseif true == PaGlobal_GameExit_All._basic._btn_move_pcPool[uiCount]:GetShow() then
    HandleEventLUp_GameExit_All_Move()
    return
  end
end
function HandleEventLUp_GameExit_All_ChangeCharacter(index)
  if nil == index and PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    index = PaGlobal_GameExit_All._selectCharacterIdx
  end
  if ToClient_isConsole() == true and ToClient_isPremiumCharacter() == true and ToClient_IsInstanceField() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  local characterData = getCharacterDataByIndex(index, PaGlobal_GameExit_All._playerCreateType)
  if nil == characterData then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfCharacterNo = selfPlayerWrapper:getCharacterNo_64()
  if _ContentsGroup_CharacterTag == true and ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64) == true and ToClient_IsDuelCharacterByCharacterNo(selfCharacterNo) == true and nil ~= selfPlayerWrapper then
    local selfPlayer = selfPlayerWrapper:get()
    if nil ~= selfPlayer then
      local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
      if nil ~= regionInfo and true == regionInfo:isPrison() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_TAG"))
        return
      end
      if true == ToClient_IsInstanceField() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
        return
      end
      if (true == _ContentsGroup_isOepnImmortalHell or true == _ContentsGroup_isOpenImmortalHellForConsole) and nil ~= regionInfo and nil ~= regionInfo:get() and true == regionInfo:get():isPVEArenaZone() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
        return
      end
      if true == selfPlayer:isCompetitionDefined() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
        return
      end
    end
  end
  PaGlobal_GameExit_All._changeIndex = index
  local characterData = getCharacterDataByIndex(index, PaGlobal_GameExit_All._playerCreateType)
  if nil == characterData then
    return
  end
  local classType = getCharacterClassType(characterData)
  local char_Name = getCharacterName(characterData)
  if ToClient_IsCustomizeOnlyClass(classType) then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  if ToClient_isHardCoreChannel() == true and characterData._playerCreateType ~= __ePlayerCreateHardCore and ToClient_SelfPlayerIsGM() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantEnterToHardCoreServer"))
    return
  end
  if true == _ContentsGroup_NewSequenceTutorial and characterData._level == 1 then
    local isTutorialComplete = ToClient_NewSequenceTutorialComplete(index)
    if isTutorialComplete == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_CHARACTERSELECT_TUTORIAL"))
      return
    end
  end
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  if true == _ContentsGroup_SeasonContents then
    local isSeasonChannel = ToClient_isSeasonChannel()
    if false == isSeasonCharacter and true == isSeasonChannel then
      if true == _ContentsGroup_SwapCharacterAndMoveServer then
        if nil ~= Panel_ChannelSelect_All then
          PaGlobal_ChannelSelect_All._isWithCharacterSwap = true
          PaGlobalFunc_ChannelSelect_All_Open()
          return
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_SEASON_ALERT"))
        return
      end
    end
  elseif true == _ContentsGroup_PreSeason and true == isSeasonCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  if ToClient_CheckFamilyCharacterLevel(10) == false then
    NotifyDisplay(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DONT_CHAGECHARACTER", "iLevel", 10))
    return
  end
  local removeTime = getCharacterDataRemoveTime(index, PaGlobal_GameExit_All._playerCreateType)
  if nil ~= removeTime then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_CHARACTER_DELETE"))
    return
  end
  local usabelSlotCount = getUsableCharacterSlotCount()
  if index >= usabelSlotCount then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_CLOSE_CHARACTER_SLOT"))
    return
  end
  if true == ToClient_CheckDuelCharacterInPrison(index) then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_PRISON_CANT_LOGIN"))
    return
  end
  local contentString = ""
  if Defines.s64_const.s64_m1 ~= characterData._lastTicketNoByRegion then
    contentString = PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_WAIT") .. "\n"
  end
  if ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
  if CppEnums.PcWorkType.ePcWorkType_Empty ~= characterData._pcWorkingType then
    if CppEnums.PcWorkType.ePcWorkType_ReadBook == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_WORKING_NOW_READ_BOOK")
    elseif CppEnums.PcWorkType.ePcWorkType_RepairItem == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_REPAIR_NOW_CHANGE_Q")
    elseif CppEnums.PcWorkType.ePcWorkType_Relax == characterData._pcWorkingType then
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_REST_NOW_CHANGE_Q")
    else
      contentString = contentString .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_WORKING_NOW_CHANGE_Q")
    end
  end
  local serverUtc64 = getServerUtc64()
  if characterData._arrivalRegionOrWaypointKey ~= 0 and serverUtc64 < characterData._arrivalTime then
    contentString = PAGetString(Defines.StringSheet_GAME, "Lua_deliveryPerson_SelectPcDelivery") .. "\n"
  end
  if nil ~= contentString then
    if ToClient_SelfPlayerCheckAction("READ_BOOK") then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      contentString = contentString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ALL_CHARACTER_CHANGE_QUESTION", "characterName", char_Name)
      local messageboxData = {
        title = "",
        content = contentString,
        functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  elseif ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_CharChangeConfirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    PaGlobal_GameExit_All_CharChangeConfirm()
  end
end
function HandleEventOnOut_GameExit_All_DuelCharInfo(isShow, charDataIdx, startIdx)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOnOut_GameExit_All_DuelCharInfo isShow nil", "\236\178\156\235\167\140\234\184\176")
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(charDataIdx, PaGlobal_GameExit_All._playerCreateType)
  if nil == characterData then
    return
  end
  if ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64) == false then
    return
  end
  local duelCharacterName = ""
  local duelCharacterCount = ToClient_GetMyDuelCharacterCount()
  if duelCharacterCount <= 0 then
    return
  end
  for idx = 0, duelCharacterCount - 1 do
    local duelCharacterData = ToClient_GetDuelCharacterDataByIndex(idx)
    if duelCharacterData ~= nil and characterData._characterNo_s64 ~= duelCharacterData._characterNo_s64 then
      if duelCharacterName == "" then
        duelCharacterName = tostring(getCharacterName(duelCharacterData))
      else
        duelCharacterName = duelCharacterName .. ", " .. tostring(getCharacterName(duelCharacterData))
      end
    end
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_NAME")
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_DESC", "Charactername", duelCharacterName)
  local control
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._basic._stc_duelCharIconPool[charDataIdx - startIdx]
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._all._stc_duelCharIconPool[charDataIdx]
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GameExit_All_ServantInfoTooltip(isShow, charDataIdx, uiIdx, servantIdx)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOnOut_GameExit_All_ServantInfoTooltip isShow nil", "\236\178\156\235\167\140\234\184\176")
  if false == isShow then
    TooltipSimple_Hide()
    return
  else
    UI.ASSERT_NAME(nil ~= charDataIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip charDataIdx nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= uiIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip uiIdx nil", "\236\178\156\235\167\140\234\184\176")
    UI.ASSERT_NAME(nil ~= servantIdx, "HandleEventOnOut_GameExit_All_ServantInfoTooltip servantIdx nil", "\236\178\156\235\167\140\234\184\176")
  end
  local characterData = getCharacterDataByIndex(charDataIdx, PaGlobal_GameExit_All._playerCreateType)
  if nil == characterData then
    return
  end
  local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, servantIdx)
  if nil == briefServantInfo then
    return
  end
  local name = briefServantInfo:getName()
  local desc = PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  local control
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._basic._txt_servantIconPool[uiIdx][servantIdx]
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._all._txt_servantIconPool[uiIdx][servantIdx]
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLUp_GameExit_All_SimpleInventory(index)
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    PaGlobal_SimpleInventory:requestSimpleInventory(index)
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    PaGlobal_SimpleInventory:requestSimpleInventory(PaGlobal_GameExit_All._selectCharacterIdx)
  end
end
function HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(isShow, idx, uiCount)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control
  if nil == idx then
    idx = PaGlobal_GameExit_All._selectCharacterIdx
    control = PaGlobal_GameExit_All._ui._charInfo._btn_inven_pc
  else
    control = PaGlobal_GameExit_All._basic._btn_invenPool[uiCount]
  end
  local characterData = getCharacterDataByIndex(idx, PaGlobal_GameExit_All._playerCreateType)
  if nil == characterData then
    return
  end
  local char_Name = getCharacterName(characterData)
  local title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SIMPLEINVEN_TITLE", "name", char_Name)
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SIMPLEINVEN_DESC", "name", char_Name)
  TooltipSimple_Show(control, title, desc, false)
end
function HandleEventOnOut_GameExit_All_ShowChangeModeTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_GameExit_All._ui._charInfo._chk_changeModeToggle
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_CHANGE_NAME_BTN")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_CHANGE_DESC_BTN")
  TooltipSimple_Show(control, title, desc, false)
end
function HandleEventOnOut_GameExit_All_ShowPushModeTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_GameExit_All._ui._charInfo._chk_pushModeToggle
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_PUSH_NAME_BTN")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_PUSH_DESC_BTN")
  TooltipSimple_Show(control, title, desc, false)
end
function HandleEventOnOut_GameExit_All_ShowExchangeResetTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_GameExit_All._ui._charInfo._btn_orderReset
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_CHANGE_RESET_NAME_BTN")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHARACTERSORT_CHANGE_RESET_DESC_BTN")
  TooltipSimple_Show(control, title, desc, false)
end
function HandleEventOn_GameExit_All_ShowCharacterCountTooltip()
  local haveCharacterCount = getCharacterDataCount(PaGlobal_GameExit_All._playerCreateType)
  local limitCharacterCount = getCharacterSlotLimit(PaGlobal_GameExit_All._playerCreateType)
  local maxCharacterCount = getCharacterSlotMaxCount(PaGlobal_GameExit_All._playerCreateType)
  local name = "\234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176\236\136\152"
  local desc = ""
  if limitCharacterCount == maxCharacterCount then
    if haveCharacterCount == limitCharacterCount then
      desc = "\237\152\132\236\158\172 \235\179\180\236\156\160\236\164\145\236\157\184 \236\186\144\235\166\173\237\132\176\235\138\148 <PAColor0xFFFFEEA0>" .. haveCharacterCount .. "\235\170\133<PAOldColor> \236\158\133\235\139\136\235\139\164. \235\141\148 \236\157\180\236\131\129 \236\186\144\235\166\173\237\132\176\235\165\188 \237\153\149\236\158\165\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164."
    else
      desc = "\237\152\132\236\158\172 \235\179\180\236\156\160\236\164\145\236\157\184 \236\186\144\235\166\173\237\132\176\235\138\148 <PAColor0xFFFFEEA0>" .. haveCharacterCount .. "\235\170\133<PAOldColor> \236\158\133\235\139\136\235\139\164.\n<PAColor0xFFFFEEA0>" .. limitCharacterCount - haveCharacterCount .. "\235\170\133<PAOldColor>\236\157\152 \236\186\144\235\166\173\237\132\176\235\165\188 \236\182\148\234\176\128\235\161\156 \236\131\157\236\132\177\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
    end
  elseif haveCharacterCount == limitCharacterCount then
    desc = "\237\152\132\236\158\172 \235\179\180\236\156\160\236\164\145\236\157\184 \236\186\144\235\166\173\237\132\176\235\138\148 <PAColor0xFFFFEEA0>" .. haveCharacterCount .. "\235\170\133<PAOldColor> \236\158\133\235\139\136\235\139\164.\n<PAColor0xFFFFEEA0>" .. maxCharacterCount - limitCharacterCount .. "\234\176\156<PAOldColor>\236\157\152 \236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175\236\157\132 \237\153\149\236\158\165\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
  else
    desc = "\237\152\132\236\158\172 \235\179\180\236\156\160\236\164\145\236\157\184 \236\186\144\235\166\173\237\132\176\235\138\148 <PAColor0xFFFFEEA0>" .. haveCharacterCount .. "\235\170\133<PAOldColor> \236\158\133\235\139\136\235\139\164.\n<PAColor0xFFFFEEA0>" .. limitCharacterCount - haveCharacterCount .. "\235\170\133<PAOldColor>\236\157\152 \236\186\144\235\166\173\237\132\176\235\165\188 \236\182\148\234\176\128\235\161\156 \236\131\157\236\132\177\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.\n\235\152\144\237\149\156 <PAColor0xFFFFEEA0>" .. maxCharacterCount - limitCharacterCount .. "\234\176\156<PAOldColor>\236\157\152 \236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175\236\157\132 \237\153\149\236\158\165\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
  end
  local control = PaGlobal_GameExit_All._ui._charInfo._stc_countGuide
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOut_GameExit_All_ShowCharacterCountTooltip()
  TooltipSimple_Hide()
end
function HandleEventOnOut_GameExit_All_BuySlotText(isShow, index)
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    return
  end
  PaGlobal_GameExit_All._all._txt_descPool[index]:SetShow(isShow)
end
function HandleEventOn_GameExit_All_BuySlot(index, isShow)
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    return
  end
  PaGlobal_GameExit_All._basic._txt_descPool[index]:SetShow(isShow)
end
function HandleEventLUp_GameExit_All_BuySlot()
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() == true then
    return
  end
  PaGlobalFunc_EasyBuy_Open(91)
end
function HandleEventLUp_GameExit_All_CharacterSelect()
  if ToClient_SelfPlayerCheckAction("READ_BOOK") then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_READBOOK_WARNNING")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_GoToCharacterSelect,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local contentStr = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_BACK_TO_CHARACTERSELECT_Q")
    local messageboxData = {
      title = "",
      content = contentStr,
      functionYes = PaGlobal_GameExit_All_GoToCharacterSelect,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
      exitButton = true
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_GameExit_All_Tray()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TRAYBLACKDESERT_ACK"))
  ToClient_CheckTrayIcon()
  PaGlobal_GameExit_All:prepareClose(true)
end
function HandleEventLUp_GameExit_All_Close()
  PaGlobal_GameExit_All:prepareClose(true)
end
function HandleEventLUp_GameExit_All_SelectCharacter_all(index, isCurrentCharaceter)
  PaGlobal_GameExit_All:selectCharacter_all(index)
  if true == PaGlobal_GameExit_All._isConsole then
    PaGlobal_GameExit_All:updateKeyGuide(false, isCurrentCharaceter, index)
  end
end
function HandleEventLUp_GameExit_All_ExchangeCharacter_on(index)
  PaGlobal_GameExit_All:exchangeCharacter_on(index)
end
function HandleEventLUp_GameExit_All_ExchangeCharacter_all(index)
  PaGlobal_GameExit_All:exchangeCharacter_all(index)
end
function HandleEventLUp_GameExit_All_ExchangeCharacter_start()
  PaGlobal_GameExit_All:exchangeCharacter_start()
end
function HandleEventLDClick_GameExit_All_ChangeCharacter_all(idx)
  if true == _ContentsGroup_RenewUI then
    return
  end
  if -1 == PaGlobal_GameExit_All._selectCharacterIdx then
    return
  end
  if true == PaGlobal_GameExit_All._ui._charInfo._btn_move_pc:GetShow() then
    HandleEventLUp_GameExit_All_Move()
    return
  elseif true == PaGlobal_GameExit_All._ui._charInfo._btn_change_pc:GetShow() then
    HandleEventLUp_GameExit_All_ChangeCharacter()
    return
  end
end
function HandleEventOn_GameExit_All_UpdateKeyGuide(isNormalButton, isCurrentCharaceter, uiCount)
  PaGlobal_GameExit_All._nowSnapSlotNo = uiCount
  PaGlobal_GameExit_All:updateKeyGuide(isNormalButton, isCurrentCharaceter, uiCount)
end
function HandleEventLUp_GameExit_All_GameExit()
  if _ContentsGroup_RenewUI == true then
    _AudioPostEvent_SystemUiForXBOX(8, 14)
    local titleText = PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_DISCONNECT")
    local messageBoxData = {
      title = titleText,
      content = messageBoxMemo,
      functionYes = PaGlobal_GameExit_All_ExitButton,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_ExitConfirm_All_Open()
  end
end
function HandleEventLUp_GameExit_All_ServerChange()
  PaGlobalFunc_ChannelSelect_All_Open()
end
function HandleEventLUp_GameExit_All_ForFacePhoto()
  PaGlobal_GameExit_All._isExitPhoto = true
  PaGlobal_GameExit_All_Close(true)
  IsGameExitPhoto(true)
  IngameCustomize_Show()
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    characterSlot_Index(PaGlobal_GameExit_All._photoIndex)
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    characterSlot_Index(PaGlobal_GameExit_All._selectCharacterIdx)
  end
end
function HandleEventLUp_GameExit_All_listToggle()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  TooltipSimple_Hide()
  if PaGlobal_GameExit_All._isConsole then
    local chkListToggle = PaGlobal_GameExit_All._ui._pc._chk_listToggle
    chkListToggle:SetCheck(not chkListToggle:IsCheck())
  end
  PaGlobal_GameExit_All:updateListToggle()
end
function HandleEventOn_GameExit_All_listToggleTooltip()
  local name = ""
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_VIEWALL_TOOLTIP_DESC")
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_VIEWDETAIL_TOOLTIP_DESC")
  end
  local control = PaGlobal_GameExit_All._ui._pc._chk_listToggle
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOut_GameExit_All_listToogleTooltipHide()
  TooltipSimple_Hide()
end
function HandleEventLUp_GameExit_All_TrayConfirm()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    return
  end
  if PaGlobal_GameExit_All._ui._tray._chk_tray:IsCheck() then
    ToClient_CheckTrayIcon()
  else
    ToClient_UnCheckTrayIcon()
  end
  Panel_ExitConfirm_Old:SetShow(false)
end
function HandleEventLUp_GameExit_All_TrayCancel()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    return
  end
  PaGlobal_ExitConfirm_All_Close()
  Panel_Tooltip_Item_hideTooltip()
  Panel_ExitConfirm_Old:SetShow(false)
end
function HandleEventLUp_GameExit_All_SeasonIconTooltip(idx, isGridSlot)
  if nil == idx or nil == isGridSlot then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if true == isGridSlot then
    if nil ~= PaGlobal_GameExit_All._all._stc_seasonIconPool[idx] then
      control = PaGlobal_GameExit_All._all._stc_seasonIconPool[idx]
    end
  elseif nil ~= PaGlobal_GameExit_All._basic._stc_seasonIconPool[idx] then
    control = PaGlobal_GameExit_All._basic._stc_seasonIconPool[idx]
  end
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_SEASONCHARACTER")
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, nil)
end
function FromClient_GameExit_All_WindowClose()
  PaGlobal_GameExit_All:showToggle()
end
function FromClient_GameExit_All_RecentJournalUpdate()
  PaGlobal_GameExit_All:updateRecentJournal()
end
function FromClient_GameExit_All_OnScreenResize()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:ComputePos()
end
function FromClient_GameExit_All_VariedChracterSlotCount()
  if Panel_Window_GameExit_All:GetShow() == false then
    return
  end
  if PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    PaGlobal_GameExit_All:updateAllList()
  end
  FromClient_GameExit_All_UpdateSlot()
end
function FromClient_GameExit_All_UpdateSlot()
  PaGlobal_GameExit_All:updateCharacterSlot(PaGlobal_GameExit_All._photoIndex + 1)
  PaGlobal_GameExit_All:updateCharacterSlot_all()
end
function FromClient_UnsealServantListLoadComplete()
  if Panel_Window_GameExit_All:GetShow() == false then
    return
  end
  PaGlobal_GameExit_All:updateCharacterSlot_all()
end
function FromClient_GameExit_All_TrayIconMessageBox()
  if true == _ContentsGroup_NewUI_TrayConfirm_All then
    PaGlobalFunc_ExitTrayConfirm_All_TrayOpen()
  else
    PaGlobal_GameExit_All._ui._tray._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITCONFIRM_TITLE"))
    PaGlobal_GameExit_All._ui._tray._txt_contentsString:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK2"))
    Panel_ExitConfirm_Old:SetShow(true)
  end
end
function PaGlobal_GameExit_All_ShowAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_GameExit_All)
  audioPostEvent_SystemUi(1, 0)
end
function PaGlobal_GameExit_All_HideAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_GameExit_All:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  ButtonFacePhoto_ToolTip(false)
  audioPostEvent_SystemUi(1, 1)
end
function PaGlobal_GameExit_All_SetChallengeScroll(isUp)
  UIScroll.SetButtonSize(PaGlobal_GameExit_All._ui._scroll_frame, PaGlobal_GameExit_All._ui._frame_contents:GetSizeY(), PaGlobal_GameExit_All._ui._frame_todayMyChallenge:GetSizeY())
  local scrollBtnSizeY = PaGlobal_GameExit_All._ui._scroll_frame:GetControlButton():GetSizeY() * 0.5 / 100
  if true == isUp then
    scrollBtnSizeY = scrollBtnSizeY * -1
  end
  local scrollPosY = PaGlobal_GameExit_All._ui._scroll_frame:GetControlPos()
  PaGlobal_GameExit_All._ui._scroll_frame:SetControlPos(scrollPosY + scrollBtnSizeY)
  if scrollPosY + scrollBtnSizeY <= 0 then
    PaGlobal_GameExit_All._ui._scroll_frame:SetControlTop()
  elseif scrollPosY + scrollBtnSizeY >= 1 then
    PaGlobal_GameExit_All._ui._scroll_frame:SetControlBottom()
  end
  PaGlobal_GameExit_All._ui._frame_todayMyChallenge:UpdateContentScroll()
  PaGlobal_GameExit_All._ui._frame_todayMyChallenge:UpdateContentPos()
end
function PaGlobal_GameExit_All_ShowToggle(isAttacked)
  PaGlobal_GameExit_All:showToggle(isAttacked)
end
function PaGlobal_GameExit_All_GetWorkTypeString(workingType)
  local workingText
  if CppEnums.PcWorkType.ePcWorkType_Empty == workingType then
    workingText = ""
  elseif CppEnums.PcWorkType.ePcWorkType_Play == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_PLAY")
  elseif CppEnums.PcWorkType.ePcWorkType_RepairItem == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_REPAIRITEM")
  elseif CppEnums.PcWorkType.ePcWorkType_Relax == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_RELEX")
  elseif CppEnums.PcWorkType.ePcWorkType_ReadBook == workingType then
    workingText = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_READBOOK")
  else
    _PA_ASSERT(false, "\236\186\144\235\166\173\237\132\176 \236\158\145\236\151\133 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128 \235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. Panel_Window_GameExit_All_2.lua \235\143\132 \236\182\148\234\176\128\237\149\180 \236\163\188\236\150\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
    workingText = "unKnown"
  end
  return workingText
end
function PaGlobal_GameExit_All_CharChangeConfirm()
  if ToClient_IsEmergencyAvoid() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWhileEmergencyAvoid"))
    return
  end
  if nil ~= Panel_Widget_EscapeBar_All and Panel_Widget_EscapeBar_All:GetShow() then
    ToClient_StopPreCoolTime()
  end
  PaGlobal_GameExit_ALL_SaveCurrentData()
  if PAGlobal_CloseRadioPlayer ~= nil then
    PAGlobal_CloseRadioPlayer()
  end
  local rv = swapCharacter_Select(PaGlobal_GameExit_All._changeIndex, true)
  if false == rv then
    return
  end
  if _ContentsGroup_WorldMapFamilyCharacterManagement == true and ToClient_WorldMapIsShow() == true then
    if _ContentsGroup_RenewUI_WorldMap == true then
      PaGlobalFunc_WorldMap_PopClose()
    else
      FGlobal_PopCloseWorldMapActual()
    end
  end
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._swapCharacter
  PaGlobal_GameExit_All:setShowHideBottomButton()
  if ToClient_isOpenOptimizeLogin() == true then
    HandleEventLUp_GameExit_All_Close()
    return
  end
  local isTagchange = false
  if true == _ContentsGroup_CharacterTag then
    isTagchange = PaGlobalFunc_CharacterTag_All_IsTagChange()
  end
  if true == isTagchange then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CHANGING")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  if true == PaGlobal_GameExit_All._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      isLoading = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_GameExit_ALL_SaveCurrentData()
  getSelfPlayer():saveCurrentDataForGameExit()
  ToClient_SaveUiInfo(false)
  ToClient_SaveCameraPos()
end
function PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  UI.ASSERT_NAME(nil ~= briefServantInfo, "PaGlobalFunc_GameExit_All_ServantInfoText briefServantInfo nil", "\236\178\156\235\167\140\234\184\176")
  local servantKind = briefServantInfo:getServantKind()
  local servantCharacterKeyRaw = briefServantInfo:getServantCharacterKeyRaw()
  local strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_" .. servantKind)
  if 31053 == servantCharacterKeyRaw then
    strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_15_1")
  end
  if 2 == servantKind then
    local servantSubKind = briefServantInfo:getServantKindSub()
    if 2 == servantSubKind then
      strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_2_2")
    end
  end
  local isFantasyHorse = PaGlobal_CheckFantasyHorse(servantCharacterKeyRaw)
  local strText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_KIND", "kind", strKind)
  if false == isFantasyHorse then
    if CppEnums.ServantKind.Type_Horse == servantKind and true == briefServantInfo:isMale() then
      strText = strText .. "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GENDER_MALE") .. ")"
    elseif CppEnums.ServantKind.Type_Horse == servantKind and false == briefServantInfo:isMale() then
      strText = strText .. "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GENDER_FEMALE") .. ")"
    end
  end
  local level = briefServantInfo:getLevel()
  if level > 0 then
    strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_LEVEL", "level", level)
  end
  if CppEnums.ServantKind.Type_Horse == servantKind or CppEnums.ServantKind.Type_RaceHorse == servantKind then
    local tier = briefServantInfo:getTier()
    if tier > 0 then
      local tierName = ToClient_GetDisplayTierName(servantCharacterKeyRaw)
      strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_TIER", "tier", tierName)
    end
  end
  return strText
end
function PaGlobal_GameExit_All_GoToCharacterSelect()
  if ToClient_IsEmergencyAvoid() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantWhileEmergencyAvoid"))
    return
  end
  if nil ~= Panel_Widget_EscapeBar_All and Panel_Widget_EscapeBar_All:GetShow() then
    ToClient_StopPreCoolTime()
  end
  PaGlobal_GameExit_All_GoToCharacterSelectXXX()
end
function PaGlobal_GameExit_All_GoToCharacterSelectXXX()
  if PAGlobal_CloseRadioPlayer ~= nil then
    PAGlobal_CloseRadioPlayer()
  end
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._backCharacter
  PaGlobal_GameExit_ALL_SaveCurrentData()
  if false == sendCharacterSelect() then
    PaGlobal_GameExit_All._exitMode = -1
    return
  end
  if PaGlobal_GameExit_All._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0,
      exitButton = false,
      isTimeCount = true,
      isStartTimer = true,
      useLoadingIndicator = true
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_GameExit_All:setShowHideBottomButton()
  end
end
function PaGlobal_GameExit_All_Close(doAnimation)
  PaGlobal_GameExit_All:prepareClose(doAnimation)
end
function PaGlobal_GameExit_ALL_GameExitSuccess()
  PaGlobal_GameExit_All._exitMode = PaGlobal_GameExit_All._eExitMode._gameExit
  PaGlobal_GameExit_ALL_SaveCurrentData()
  sendBeginGameDelayExit(false)
  PaGlobal_GameExit_All:setShowHideBottomButton()
end
function PaGlobal_GameExit_All_GetIsExitPhoto()
  return PaGlobal_GameExit_All._isExitPhoto
end
function PaGlobal_GameExit_All_UpdateSlot(startIdx)
  PaGlobal_GameExit_All:updateCharacterSlot(startIdx)
end
function PaGlobal_GameExit_All_ChangeCharacter(index)
  HandleEventLUp_GameExit_All_ChangeCharacter(index)
end
function PaGlobal_GameExit_All_ExitButton()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  getSelfPlayer():updateNavigationInformation("")
  getSelfPlayer():saveCurrentDataForGameExit()
  ToClient_SaveUiInfo(false)
  ToClient_SaveCameraPos()
  sendBeginGameDelayExit(false)
  if true == PaGlobal_GameExit_All._isConsole then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0,
      exitButton = false,
      isTimeCount = true,
      isStartTimer = true,
      useLoadingIndicator = true
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_GameExit_All_ChangeAccount_MessageBoxConfirm()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  ToClient_ChangeAccount()
end
function PaGlobal_GameExit_ALL_ShowAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_GameExit_All)
end
function PaGlobal_GameExit_ALL_HideAni()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local gameExitHideAni = Panel_Window_GameExit_All:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  gameExitHideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  gameExitHideAni:SetEndColor(Defines.Color.C_00FFFFFF)
  gameExitHideAni:SetStartIntensity(3)
  gameExitHideAni:SetEndIntensity(1)
  gameExitHideAni.IsChangeChild = true
  gameExitHideAni:SetHideAtEnd(true)
  gameExitHideAni:SetDisableWhileAni(true)
end
function FromClient_GameExit_All_QuestBackEndLoadComplete(s32_questNoRaw)
  if Panel_Window_GameExit_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if Panel_Window_GameExit_All:GetShow() == false then
    return
  end
  if PaGlobal_GameExit_All:isExistLoadingDataAnyOne() == false then
    return
  end
  local updateTargetUiIndex
  for index = 1, #PaGlobal_GameExit_All._questLoadingDataList do
    local value = PaGlobal_GameExit_All._questLoadingDataList[index]
    if value ~= nil and value._questNoRaw == s32_questNoRaw then
      updateTargetUiIndex = value._uiIndex
      table.remove(PaGlobal_GameExit_All._questLoadingDataList, index)
      break
    end
  end
  if updateTargetUiIndex == nil then
    return
  end
  if updateTargetUiIndex == 0 then
    PaGlobal_GameExit_All:updateLastCompleteQuest_0()
  elseif updateTargetUiIndex == 1 then
    PaGlobal_GameExit_All:updateLastCompleteQuest_1()
  end
  return
end
function HandleEventRSUp_GameExit_All_ServantInfoToolTipForConsole(uiCount, charDataIdx)
  local characterData = getCharacterDataByIndex(charDataIdx, PaGlobal_GameExit_All._playerCreateType)
  if characterData == nil then
    return
  end
  local eServantIdx = 0
  local briefServantInfo
  for eServantIdx = PaGlobal_GameExit_All._eServantView.vehicle, PaGlobal_GameExit_All._eServantView.max do
    if PaGlobal_GameExit_All._vewingServantTooltipVehicleType == nil then
      if briefServantInfo == nil then
        briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, eServantIdx)
      end
    else
      if briefServantInfo == nil and eServantIdx > PaGlobal_GameExit_All._vewingServantTooltipVehicleType then
        briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, eServantIdx)
      end
      if eServantIdx < PaGlobal_GameExit_All._vewingServantTooltipVehicleType then
        briefServantInfo = nil
        break
      end
    end
    if briefServantInfo ~= nill then
      PaGlobal_GameExit_All._vewingServantTooltipVehicleType = eServantIdx
      break
    end
  end
  if briefServantInfo == nil then
    PaGlobal_GameExit_All._vewingServantTooltipVehicleType = nil
    TooltipSimple_Hide()
    return
  end
  local name = briefServantInfo:getName()
  local desc = PaGlobalFunc_GameExit_All_ServantInfoText(briefServantInfo)
  local control
  if PaGlobal_GameExit_All._eType._basic == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._basic._txt_servantIconPool[uiCount][eServantIdx]
  elseif PaGlobal_GameExit_All._eType._all == PaGlobal_GameExit_All._eViewType then
    control = PaGlobal_GameExit_All._all._txt_servantIconPool[uiCount][eServantIdx]
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLUp_GameExit_All_ChangeModeToggle()
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    return
  end
  if PaGlobal_GameExit_All._isConsole == true then
    PaGlobal_GameExit_All._ui._charInfo._chk_changeModeToggle:SetCheck(not PaGlobal_GameExit_All._ui._charInfo._chk_changeModeToggle:IsCheck())
  end
  PaGlobal_GameExit_All._ui._charInfo._chk_pushModeToggle:SetCheck(false)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  TooltipSimple_Hide()
  PaGlobal_GameExit_All:updateChangeModeToggle()
end
function HandleEventLUp_GameExit_All_PushModeToggle()
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    return
  end
  if PaGlobal_GameExit_All._isConsole == true then
    PaGlobal_GameExit_All._ui._charInfo._chk_pushModeToggle:SetCheck(not PaGlobal_GameExit_All._ui._charInfo._chk_pushModeToggle:IsCheck())
  end
  PaGlobal_GameExit_All._ui._charInfo._chk_changeModeToggle:SetCheck(false)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  TooltipSimple_Hide()
  PaGlobal_GameExit_All:updateChangeModeToggle()
end
function HandleEventLUp_GameExit_All_ExchangeCharacter_reset()
  PaGlobal_GameExit_All:exchangeCharacter_reset()
end
