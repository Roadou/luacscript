function PaGlobalFunc_SpiritEnchant_All_Open()
  PaGlobal_SpiritEnchant_All:prepareOpen()
end
function PaGlobalFunc_SpiritEnchant_All_Close()
  if true == Panel_Window_EnchantStackConfirm_All:GetShow() and nil ~= Panel_Window_EnchantStackConfirm_All then
    PaGlobalFunc_EnchantStackConfirm_All_Close()
    return
  end
  if PaGlobalFunc_BeginnerEnchantGuide_IsShow() == true then
    PaGlobalFunc_BeginnerEnchantGuide_Close()
    return
  end
  if true == _ContentsGroup_UsePadSnapping and true == _ContentsGroup_EnchantRenewer and nil ~= Panel_Window_AddStack_All and true == Panel_Window_AddStack_All:GetShow() then
    PaGlobal_AddStack_All_closeByStep()
    return
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  if _ContentsGroup_SpiritGroupEnchant == true and ToClient_IsGroupEnchantAble() == true and PaGlobal_PartyEnchant._isAnimating == true then
    return
  end
  local selfIsPartyLeader = RequestParty_isLeader()
  if _ContentsGroup_SpiritGroupEnchant == true and selfIsPartyLeader == true and ToClient_IsGroupEnchantAble() == true then
    local doExit = function()
      ToClient_RequestGroupEnchantCancel()
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_CLOSE"),
      functionYes = doExit,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    local selfPlayer = getSelfPlayer()
    local isDead
    if nil ~= selfPlayer then
      isDead = selfPlayer:isDead()
    end
    if isDead == true then
      ToClient_RequestGroupEnchantCancel()
    else
      MessageBox.showMessageBox(messageBoxData)
    end
  else
    if _ContentsGroup_SpiritGroupEnchant == true and ToClient_IsGroupEnchantAble() == true then
      ToClient_RequestGroupEnchantItemSetCancel()
    end
    if _ContentsGroup_SpiritGroupEnchant == true then
      PaGlobalFunc_PartyEnchant_Close()
    end
    PaGlobal_SpiritEnchant_All:prepareClose()
    HandleEventLUp_DialogMain_All_BackClick()
  end
end
function HandleEventLUp_SpiritEnchant_All_MainTabSelect(tabIdx)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if nil == tabIdx or true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if true == _ContentsGroup_EnchantLightStone then
    PaGlobal_SpiritEnchant_All._ui.txt_titleBg:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RADIOBTNTITLE_1"))
  end
  PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  PaGlobal_SpiritEnchant_All:mainTabCheck(PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[tabIdx], PaGlobal_SpiritEnchant_All._ui.stc_selectBar)
  PaGlobal_SpiritEnchant_All._currentMainTab = tabIdx
  PaGlobal_SpiritEnchant_All._ui_enchant.stc_tubalaExchangeBg:SetShow(false)
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(false)
    PaGlobal_SpiritEnchant_All:enchantTabOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isEnchantAniSkip)
    if true == _ContentsGroup_FamilyStack then
      local slotSize = ToClient_GetFailCountSlotSize()
      if nil ~= slotSize and slotSize > 0 then
        PaGlobalFunc_StackStorage_All_Open()
      else
        PaGlobalFunc_StackStorage_All_Close()
      end
    end
    local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
    ToClient_RequestSpiritEnchantRecord(isCheckCron, 5)
    local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
    ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_EnchantTabClick)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(false)
    if true == _ContentsGroup_EnchantRenewer then
      PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBgOld:SetShow(false)
    end
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(true)
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(false)
    PaGlobal_SpiritEnchant_All:caphrasOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isCaphrasAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  end
  if true == _ContentsGroup_EnchantRenewer and nil ~= PaGloabl_AddStack_All_close then
    PaGloabl_AddStack_All_close()
  end
  if true == PaGlobal_SpiritEnchant_All._isConsole then
    PaGlobalFunc_SpiritEnchant_All_ShowRstickKeyGuide(false)
  end
  PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
  PaGlobal_SpiritEnchant_All:resizePanel()
  PaGlobalFunc_OtherUser_TriedStack_Close()
  PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:SetShow(false)
  PaGlobal_SpiritEnchant_All:showGuaranteeEnchantBG(false)
end
function HandleEventLUp_SpiritEnchant_All_SubTabSelect(tabIdx)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if nil == tabIdx or true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  PaGlobal_SpiritEnchant_All:subTabCheck(PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[tabIdx], PaGlobal_SpiritEnchant_All._ui_extraction.stc_selectBar)
  PaGlobal_SpiritEnchant_All._currentSubTab = tabIdx
  if PaGlobal_SpiritEnchant_All._SUB_TAB.DARK == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageDarkPredation:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageSecretBook:SetShow(false)
    PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isDarkAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  elseif PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageDarkPredation:SetShow(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageSecretBook:SetShow(true)
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
    if true == _ContentsGroup_FailCountToItemSetting then
      PaGlobal_SpiritEnchant_All:SetFailCountToItem()
    end
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isBookAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  end
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if _ContentsGroup_SpiritGroupEnchant == true and ToClient_IsGroupEnchantAble() == true and RequestParty_isLeader() == true then
    if PaGlobal_SpiritEnchant_All._isConsole == true then
      PaGlobalFunc_SpiritEnchant_All_Close()
    end
    return
  end
  PaGlobalFunc_OtherUser_TriedStack_Close()
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearEnchantSlot()
  PaGlobal_SpiritEnchant_All:enchantTabOpen()
  if true == _ContentsGroup_EnchantRenewer then
    PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
    if nil ~= PaGloabl_AddStack_All_close then
      PaGloabl_AddStack_All_close()
    end
  end
  PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:SetShow(false)
  PaGlobal_SpiritEnchant_All:showGuaranteeEnchantBG(false)
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventRUp_SpiritEnchant_All_MaterialSlotRelease(slotPos)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._materialItemSlotNo or nil == PaGlobal_SpiritEnchant_All._materialItemWhereType then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearItemSlot(PaGlobal_SpiritEnchant_All._slotMateiralInfo[slotPos])
  PaGlobal_SpiritEnchant_All._materialItemSlotNo = nil
  PaGlobal_SpiritEnchant_All._materialItemWhereType = nil
  PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobal_SpiritEnchant_All:setHasMaterialItem()
end
function HandleEventLUp_SpiritEnchant_All_RadioCheckClick(flag)
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantNormal:IsCheck() then
    PaGlobal_SpiritEnchant_All._isEnchantPerfect = false
  elseif true == PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:IsCheck() then
    PaGlobal_SpiritEnchant_All._isEnchantPerfect = true
  end
  if nil ~= flag and false == PaGlobal_SpiritEnchant_All:CheckEnchantCheckbox(flag) then
    return
  end
  local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_RequestSpiritEnchantRecord(isCheckCron, 0)
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_CheckHammer)
  PaGlobal_SpiritEnchant_All:setHasMaterialItem()
  PaGlobal_SpiritEnchant_All:didsetEnchantTarget(true, true)
  PaGlobal_SpiritEnchant_All:setText_EnchantInfo()
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_DefenceFailClick()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if PaGlobal_SpiritEnchant_All._isGroupEnchantReady == true then
    ToClient_RequestGroupEnchantItemSetCancel()
  end
  if not PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    HandleEventLUp_SpiritEnchant_All_RadioCheckClick(3)
    return
  end
  local useDefenceFail = function()
    HandleEventLUp_SpiritEnchant_All_RadioCheckClick(3)
  end
  local cancleDefenceFail = function()
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    HandleEventLUp_SpiritEnchant_All_RadioCheckClick(3)
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil == itemWrapper then
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    HandleEventLUp_SpiritEnchant_All_RadioCheckClick(3)
    return
  end
  local itemStaticWrapper = itemWrapper:getStaticStatus()
  if nil == itemStaticWrapper then
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    HandleEventLUp_SpiritEnchant_All_RadioCheckClick(3)
    return
  end
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER")
  local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER")
  local protectorItemKey = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCrystalProtectorItemKey()
  if protectorItemKey == 761801 then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_6")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_6")
  elseif protectorItemKey == 761802 then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_7")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_7")
  elseif protectorItemKey == 761803 then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_8")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_8")
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemStaticWrapper:getItemClassify() and (itemStaticWrapper:isSpecialEnchantItem() == false or itemStaticWrapper:isKarazardAccessory() == true) then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER2")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER2")
  end
  if itemStaticWrapper:getContentsEventType() == __eContentsType_ItemSkillOption then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_4")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_4")
  end
  if itemStaticWrapper:isKarazardAccessory() == true then
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_5")
    _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_5")
  end
  local protectorItemStaticWrapper = itemStaticWrapper:getProtectorItem()
  if protectorItemStaticWrapper ~= nil and protectorItemStaticWrapper:isSafeLowProtectorItem() == true then
    local itemClassify = itemStaticWrapper:getItemClassify()
    local isSpecialEnchantItem = itemStaticWrapper:isSpecialEnchantItem()
    local isKarazardAccessory = itemStaticWrapper:isKarazardAccessory() == true
    local isItemSkillOption = itemStaticWrapper:getContentsEventType() == __eContentsType_ItemSkillOption
    if isKarazardAccessory == true then
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_2")
      _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_2")
    elseif isItemSkillOption == true then
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_1")
      _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_1")
    elseif 4 == itemClassify and false == isSpecialEnchantItem then
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_2")
      _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_2")
    else
      _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_1")
      _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_1")
    end
  end
  local messageBoxData = {
    title = _title,
    content = _content,
    functionYes = useDefenceFail,
    functionNo = cancleDefenceFail,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_SpiritEnchant_All._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()
  PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetCheck(false)
  HandleEventLUp_SpiritEnchant_All_RadioCheckClick()
end
function HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()
  if true == PaGlobal_SpiritEnchant_All:isLightStoneEnchant() then
    HandleEventLUp_SpiritEnchant_All_LightStoneEnchantApplyButton()
  else
    HandleEventLUp_SpiritEnchant_All_EnchantApplyButtonXXX()
  end
end
function HandleEventLUp_SpiritEnchant_All_EnchantApplyButtonXXX()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    if false == PaGlobal_SpiritEnchant_All._isConsole then
      PaGlobal_SpiritEnchant_All._isClickCancle = true
      PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      PaGlobal_SpiritEnchant_All:cancleEnchant()
      ToClient_StopLedDeviceAnimation(7)
    end
    return
  end
  if false == PaGlobal_SpiritEnchant_All._isAbleEnchant then
    if PaGlobal_SpiritEnchant_All._enchantFailureRv ~= 0 then
      Proc_ShowMessage_Ack(PAGetStringSymNo(PaGlobal_SpiritEnchant_All._enchantFailureRv))
    end
    return
  end
  local isForceEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:IsCheck()
  local isPerfectEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:IsCheck()
  if true == ToClient_isNeedCautionByStack(isForceEnchantCheck, isPerfectEnchantCheck) and PaGlobal_SpiritEnchant_All._isAdventureEnchant == false and PaGlobal_SpiritEnchant_All._isSafeLowProtectorItem == false then
    if nil ~= Panel_Window_EnchantStackConfirm_All then
      PaGlobalFunc_EnchantStackConfirm_All_Open(false)
    end
  else
    PaGlobal_SpiritEnchant_All:enchantApplyButton()
  end
end
function HandleEventLUp_SpiritEnchant_All_LightStoneEnchantApplyButton()
  local self = PaGlobal_SpiritEnchant_All
  if self._currentMainTab ~= self._MAIN_TAB.ENCHANT then
    return
  end
  if false == self:isLightStoneEnchant() then
    return
  end
  if true == self._isAnimating then
    if false == self._isConsole then
      self._isClickCancle = true
      self._isAbleEnchant = true
      self:cancleEnchant()
      ToClient_StopLedDeviceAnimation(7)
    end
    return
  end
  if false == self._isAbleEnchant then
    return
  end
  local isUseCron = self._ui_enchant.chk_enchantCron:IsCheck()
  if true == isUseCron and false == ToClient_isEnoughCronEnchantLightStone() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
    return
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  if false == self._ui_enchant.chk_skipAni:IsCheck() then
    self:startEnchantAnimation()
  else
    self:startLightStoneEnchant()
  end
end
function HandleEventLUp_SpiritEnchant_All_EnchantApplyWithMyStackCount()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  PaGlobal_SpiritEnchant_All:willStartEnchant()
end
function HandleEventLUp_SpiritEnchant_All_GroupEnchantReadyWithMyStackCount()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  local isProtector = function()
    if false == PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:GetShow() then
      return false
    end
    return PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  end
  PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_doEnchant(PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:IsCheck(), false, isProtector(), true)
  local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_RequestSpiritEnchantRecord(isCheckCron, 3)
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_DoEnchantParty)
end
function PaGlobal_SpiritEnchant_All_ReqMostTriedStack()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if PaGlobal_SpiritEnchant_All._enchantInfo == nil then
    return
  end
  PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:EraseAllEffect()
  PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_reqMostStackCount()
end
function HandleEventLUp_SpiritEnchant_All_OtherUserAdditionalRateOption()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if PaGlobal_SpiritEnchant_All._enchantInfo == nil then
    return
  end
  if ToClient_getGameUIManagerWrapper() == nil then
    return
  end
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eShowOtherUserEnchantAdditionalRate) == false then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
  if Panel_Window_AddStack_All:GetShow() == true or Panel_OtherUser_AdditionalRate_All:GetShow() == false or showOtherUserEnchantAdditionalRate == false then
    HandleEventLUp_SpiritEnchant_All_ShowOtherUserEnchantRateOption()
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  else
    HandleEventLUp_SpiritEnchant_All_HideOtherUserEnchantRateOption()
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function HandleEventLUp_SpiritEnchant_All_ShowOtherUserEnchantRateOption()
  PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_reqMostStackCount()
  PaGlobalFunc_OtherUser_TriedStack_Open()
  PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:EraseAllEffect()
end
function HandleEventLUp_SpiritEnchant_All_HideOtherUserEnchantRateOption()
  PaGlobalFunc_OtherUser_TriedStack_Close()
end
function PaGlobal_SpiritEnchant_All_ButtonEffect_On()
  if true == PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:GetShow() then
    PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:EraseAllEffect()
    PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:AddEffect("FUI_StackUserInfo_Button_01A", true, 0, 0)
  end
end
function HandleEventOnOut_SpiritEnchant_All_ReqMostTriedStackTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_SpiritEnchant_All_ReqGroupEnchantReadyByLeader()
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  local pcPosition = selfPlayer:get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  if regionInfo:get():isSafeZone() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_TEXT_DO_SAFEZONE"))
    return
  end
  PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_groupEnchanReady()
end
function HandleEventLUp_SpiritEnchant_All_EnchantGuide()
  PaGlobalFunc_BeginnerEnchantGuide_Open()
end
function HandleEventLUp_SpiritEnchant_All_ReqGroupEnchant()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if PaGlobal_SpiritEnchant_All._enchantInfo == nil then
    return
  end
  if PaGlobal_SpiritEnchant_All._isGroupEnchantReady == true then
    ToClient_RequestGroupEnchantItemSetCancel()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck() then
    if PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_setPreventDownGradeItem() ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
      return
    end
  elseif true == PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:GetShow() and true == PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    if PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_setProtectorItem() ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
      return
    end
  else
    PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_clearPreventDownGradeItem()
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  local isProtector = function()
    if false == PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:GetShow() then
      return false
    end
    return PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  end
  local isForceEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:IsCheck()
  local isPerfectEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:IsCheck()
  if true == ToClient_isNeedCautionByStack(isForceEnchantCheck, isPerfectEnchantCheck) and PaGlobal_SpiritEnchant_All._isSafeLowProtectorItem == false then
    if nil ~= Panel_Window_EnchantStackConfirm_All then
      PaGlobalFunc_EnchantStackConfirm_All_Open(true)
    end
  else
    do
      local self = PaGlobal_SpiritEnchant_All
      local function goEnchant()
        local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
        ToClient_RequestSpiritEnchantRecord(isCheckCron, 3)
        local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
        ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_DoEnchantParty)
        PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_doEnchant(PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:IsCheck(), false, isProtector(), true)
      end
      local function cancleEnchant()
        self._isAbleEnchant = true
      end
      local function resumeEnchant()
        local enchantAlert = false
        local failCount = self._enchantInfo:ToClient_getFailCount()
        local valksCount = self._enchantInfo:ToClient_getValksCount()
        local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
        if nil == itemWrapper then
          return
        end
        local itemSSW = itemWrapper:getStaticStatus()
        local isCronKey = itemSSW:getCronKey()
        local enchantLevel = itemSSW:get()._key:getEnchantLevel()
        local enchantType = self._enchantInfo:ToClient_getEnchantType()
        local isStacklessBlackStone = itemSSW:isNeedStackLessBlackStonForEnchant()
        local checkStacklessBlackStone = true
        if _ContentsGroup_UseCronToStacklessBlackStoneItemType == false then
          checkStacklessBlackStone = isStacklessBlackStone == false
        end
        self._isAbleEnchant = false
        if 0 == failCount + valksCount and checkStacklessBlackStone == true then
          if nil ~= self._grantItemWhereType and nil ~= self._grantItemSlotNo then
            if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
              if enchantLevel > 0 then
                enchantAlert = true
              end
            elseif enchantLevel > 15 and enchantType ~= self._enum_EnchantType._safe then
              enchantAlert = true
            end
          end
          if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() or true == self._isSetNewPerfectItemMaterial then
            enchantAlert = false
          end
          if 30 < self._currentEnchantRate then
            enchantAlert = false
          end
          if isStacklessBlackStone == true then
            enchantAlert = false
          end
          if true == enchantAlert then
            local _title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE")
            local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGEDESC")
            local messageBoxData = {
              title = _title,
              content = _content,
              functionYes = goEnchant,
              functionNo = cancleEnchant,
              priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
            }
            if false == self._isConsole then
              MessageBox.showMessageBox(messageBoxData, nil, false, false)
            else
              MessageBox.showMessageBox(messageBoxData, nil, false, true)
            end
          else
            goEnchant()
          end
        elseif 0 < itemWrapper:getCronEnchantFailCount() and enchantLevel > 17 and false == self._isSetNewPerfectItemMaterial and 0 ~= isCronKey then
          local _title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE")
          local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_CRON_ENERGY_WARNING_DESC_CAPHRAS")
          local messageBoxData = {
            title = _title,
            content = _content,
            functionApply = goEnchant,
            functionCancel = cancleEnchant,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          if false == self._isConsole then
            MessageBox.showMessageBox(messageBoxData, nil, false, false)
          else
            MessageBox.showMessageBox(messageBoxData, nil, false, true)
          end
        else
          goEnchant()
        end
      end
      local itemWrap = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
      if nil == itemWrap then
        return
      end
      if true == itemWrap:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) then
        local _title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE")
        local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_COPYITEM_MESSAGEDESC")
        local messageBoxData = {
          title = _title,
          content = _content,
          functionYes = resumeEnchant,
          functionNo = cancleEnchant,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        if false == self._isConsole then
          MessageBox.showMessageBox(messageBoxData, nil, false, false)
        else
          MessageBox.showMessageBox(messageBoxData, nil, false, true)
        end
        return
      end
      resumeEnchant()
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotEquip.slot.empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._slotEquip.slot.inventoryType, PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo)
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    if PaGlobal_SpiritEnchant_All._isLastEnchant then
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotEquip.slot.icon, false, true, nil)
    else
      Panel_Tooltip_Item_Show_GeneralNormal(0, "Enchant", true)
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].empty then
    return
  end
  local needSSW
  if nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
    needSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._materialItemWhereType, PaGlobal_SpiritEnchant_All._materialItemSlotNo)
    if nil == needSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].icon, false, true, nil)
    end
  else
    needSSW = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getNeedItemStaticInformation()
    if nil == needSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].icon, true, false)
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].empty then
    return
  end
  local currentNeedPerfectItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronItemWhereType(), PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if nil == currentPerfectSS then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(currentPerfectSS, PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].icon, true, false)
  end
end
function HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[3].empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local protectorItemStaticWrapper = itemWrapper:getStaticStatus():getProtectorItem()
  if nil == protectorItemStaticWrapper then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(protectorItemStaticWrapper, PaGlobal_SpiritEnchant_All._slotMateiralInfo[3].icon, true, false)
  end
end
function HandleEventLUp_SpiritEnchant_All_RandomBlabla()
  local self = PaGlobal_SpiritEnchant_All
  local index = math.random(#self._blablaDesc)
  self._ui_enchant.txt_blablaText:SetText(self._blablaDesc[index])
  self._ui_enchant.txt_blablaText:SetSize(self._ui_enchant.txt_blablaText:GetSizeX(), self._ui_enchant.txt_blablaText:GetTextSizeY() + 40)
  self._ui_enchant.txt_blablaText:ComputePos()
  self._ui_enchant.txt_blablaText:SetShow(true)
end
function HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearCaphrasSlot()
  PaGlobal_SpiritEnchant_All:caphrasOpen()
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_SelectCaphrasStone()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._enchantInfo then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return
  end
  local slotNo = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCaphRasSlotNo()
  local inventoryType = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCaphRasItemWhereType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil ~= itemWrapper then
    PaGlobal_SpiritEnchant_All_RClickCaphrasItem(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
  end
end
function HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(isShow, isResult, isPromotion)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  if true == isResult and true == isPromotion then
    local nextEnchantItemSSW = PaGlobal_SpiritEnchant_All:getNextEnchantItemSSW(itemWrapper)
    if nil == nextEnchantItemSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(nextEnchantItemSSW, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, true, false, nil)
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, false, true, nil)
  end
end
function HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.empty then
    return
  end
  local needSSW = ToClient_getPromotionEnchantItem()
  if nil == needSSW then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.icon, true, false)
  end
end
function HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if false == _ContentsGroup_FamilyStack then
    return
  end
  local control = PaGlobal_SpiritEnchant_All._ui_enchant.btn_stackChange
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_DESC")
  local slotSize = ToClient_GetFailCountSlotSize()
  if 0 == slotSize then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_UNLOCK_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_SpiritEnchant_All_StackSaveTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  local control = PaGlobal_SpiritEnchant_All._ui_enchant.stc_StackSave
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_TOOLTIP_STACKEXTRACTION_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_TOOLTIP_STACKEXTRACTION_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
    return
  end
  PaGlobal_SpiritEnchant_All:caphrasEnchantApplyButton()
end
function PaGlobal_SpiritEnchant_All_InvenFilerCaphrasItem(slotNo, notUse_itemWrappers, whereType)
  local caphrasItemWrapper = getInventoryItemByType(whereType, slotNo)
  local protectItemSSW = ToClient_getPromotionEnchantItem()
  if nil ~= caphrasItemWrapper then
    local itemSSW = caphrasItemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    if protectItemSSW:getName() == itemName then
      return false
    end
  end
  return true
end
function PaGlobal_SpiritEnchant_All_RClickCaphrasItem(slotNo, itemWrapper, Count, inventoryType)
  if PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0)
    end
    return
  end
  PaGlobal_SpiritEnchant_All._isLastEnchant = false
  Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), 0, PaGlobal_SpiritEnchant_All_SetCaphrasItemCount)
end
function PaGlobal_SpiritEnchant_All_SetCaphrasItemCount(inputNumber)
  PaGlobal_SpiritEnchant_All:clearItemSlot(PaGlobal_SpiritEnchant_All._slotMaterial_Caphras)
  PaGlobal_SpiritEnchant_All:setCaphrasEnchantMaterial(false, inputNumber)
end
function HandleEventLUp_SpiritEnchant_All_DarkPredationApplyButton()
  PaGlobal_SpiritEnchant_All:darkPredationApplyButton()
end
function HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearDarkSlot()
  PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
end
function HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(isShow)
  if false == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotDarkItem.empty then
    return
  end
  local getItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(getItemSSW, PaGlobal_SpiritEnchant_All._slotDarkItem.icon, false, true)
  end
end
function HandleEventRUp_SpiritEnchant_All_BookItemRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearBookSlot()
  PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
end
function HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(controlType, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if 1 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotBookItem.empty then
      return
    end
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotBookItem.icon, false, true, nil, nil, nil)
    end
  elseif 2 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotValksItem.empty then
      return
    end
    local failCount = getSelfPlayer():get():getEnchantFailCount()
    local itemFailCount = failCount
    local balksItemItemKey
    if itemFailCount > 100 then
      balksItemItemKey = itemFailCount + 288900
    else
      balksItemItemKey = itemFailCount + 17799
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(balksItemItemKey))
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SpiritEnchant_All._slotValksItem.icon, true, false, nil, nil, nil)
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_FailCountToItemToolTip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemkey = PaGlobal_SpiritEnchant_All._failCountToItemKeyEx
  if nil == itemkey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemkey))
  if nil ~= itemSSW then
    Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SpiritEnchant_All._slotBookItem.icon, true, false, nil, nil, nil)
  end
end
function HandleEventLUp_SpiritEnchant_All_BookExtractionApplyButton()
  PaGlobal_SpiritEnchant_All:bookExtractionApplyButton()
end
function HandleEventOnOut_SpiritEnchant_All_GuaranteeStackTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if PaGlobal_SpiritEnchant_All._ui_enchant.progress2_1 == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ANVILOFANCIENT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ANVILOFANCIENT_TOOLTIP_DESC")
  TooltipSimple_Show(PaGlobal_SpiritEnchant_All._ui_enchant.progress2_1, name, desc)
end
function HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()
  HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()
  HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_DarkPredationApplyButton()
  PaGlobal_SpiritEnchant_All:darkPredationApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_BookExtractionApplyButton()
  PaGlobal_SpiritEnchant_All:bookExtractionApplyButton()
end
function HandlePadEventLBRB_SpiritEnchant_All_MainMoveTab(isLeft)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if _ContentsGroup_SpiritGroupEnchant == true then
    local groupEnchantMode = PaGlobal_SpiritEnchant_All._isLeaderGroupEnchantMode or PaGlobal_SpiritEnchant_All._isGroupEnchantPartyMember
    if groupEnchantMode == true then
      return
    end
  end
  local ableTabIdx = {}
  local ableIdx = 0
  local curIdx = 0
  for index = 1, #PaGlobal_SpiritEnchant_All._ui.btn_mainRadio do
    if true == PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[index]:GetShow() then
      if PaGlobal_SpiritEnchant_All._currentMainTab == index then
        curIdx = ableIdx
      end
      ableTabIdx[ableIdx] = index
      ableIdx = ableIdx + 1
    end
  end
  if nil ~= PaGlobalFunc_SpiritEnchant_All_GetItemWrapper() or true == PaGlobal_SpiritEnchant_All._isLastEnchant then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
      if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
        HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()
      elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
        HandleEventRUp_SpiritEnchant_All_BookItemRelease()
      end
    end
  end
  if true == isLeft then
    if PaGlobal_SpiritEnchant_All._currentMainTab == ableTabIdx[0] then
      curIdx = ableIdx
    end
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(ableTabIdx[curIdx - 1])
  else
    if PaGlobal_SpiritEnchant_All._currentMainTab == ableTabIdx[ableIdx - 1] then
      curIdx = -1
    end
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(ableTabIdx[curIdx + 1])
  end
end
function HandlePadEventLTRT_SpiritEnchant_All_SubMoveTab(isLeft)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
    return
  end
  if true == isLeft then
    if PaGlobal_SpiritEnchant_All._currentSubTab == 1 then
      PaGlobal_SpiritEnchant_All._currentSubTab = #PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio + 1
    end
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab - 1)
  else
    if PaGlobal_SpiritEnchant_All._currentSubTab == #PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio then
      PaGlobal_SpiritEnchant_All._currentSubTab = 0
    end
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab + 1)
  end
end
function HandlePadEventB_SpiritEnchant_All_OnPadB()
  if nil ~= Panel_Window_EnchantStackConfirm_All and true == Panel_Window_EnchantStackConfirm_All:GetShow() then
    PaGlobalFunc_EnchantStackConfirm_All_Close()
    return false
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      PaGlobal_SpiritEnchant_All._isClickCancle = true
      PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      PaGlobal_SpiritEnchant_All:cancleEnchant()
      ToClient_StopLedDeviceAnimation(7)
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      if true == PaGlobal_SpiritEnchant_All._isPossiblePromotion then
        PaGlobal_SpiritEnchant_All:cancleCaphrasPromotion()
      else
        PaGlobal_SpiritEnchant_All:cancleCaphrasEnchant()
      end
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
      if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
        PaGlobal_SpiritEnchant_All:cancleDarkPredation()
      elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
        PaGlobal_SpiritEnchant_All:cancleBookExtraction()
      end
    end
    return false
  end
  if nil ~= PaGlobalFunc_SpiritEnchant_All_GetItemWrapper() or true == PaGlobal_SpiritEnchant_All._isLastEnchant then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
      return false
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()
      return false
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
      if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
        HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()
      elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
        HandleEventRUp_SpiritEnchant_All_BookItemRelease()
      end
      return false
    end
  end
  PaGlobalFunc_SpiritEnchant_All_Close()
  return true
end
function HandlePadEventX_SpiritEnchant_All_EquipSlotTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotEquip.slot.empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._slotEquip.slot.inventoryType, PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo)
  if nil == itemWrapper then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_MaterialTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].empty then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  local needSSW
  if nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
    needSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._materialItemWhereType, PaGlobal_SpiritEnchant_All._materialItemSlotNo)
    if nil == needSSW then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  else
    needSSW = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getNeedItemStaticInformation()
    if nil == needSSW then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  end
end
function HandlePadEventX_SpiritEnchant_All_SubMaterialTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].empty then
    return
  end
  local currentNeedPerfectItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronItemWhereType(), PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if nil == currentPerfectSS then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, currentPerfectSS, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_DefenceMaterialTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[3].empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local protectorItemStaticWrapper = itemWrapper:getStaticStatus():getProtectorItem()
  if nil == protectorItemStaticWrapper then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, protectorItemStaticWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_CaphrasEquipSlotTooltip(isResult, isPromotion)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  if true == isResult and true == isPromotion then
    local nextEnchantItemSSW = PaGlobal_SpiritEnchant_All:getNextEnchantItemSSW(itemWrapper)
    if nil == nextEnchantItemSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(nextEnchantItemSSW, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, true, false, nil)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, nextEnchantItemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
    end
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_CaphrasMaterialSlotTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.empty then
    return
  end
  local needSSW = ToClient_getPromotionEnchantItem()
  if nil == needSSW then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_DarkPredationTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotDarkItem.empty then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  local getItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getItemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_BookExtractionTooltip(controlType)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  if 1 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotBookItem.empty then
      return
    end
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  elseif 2 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotValksItem.empty then
      return
    end
    local failCount = getSelfPlayer():get():getEnchantFailCount()
    local itemFailCount = failCount
    local balksItemItemKey
    if itemFailCount > 100 then
      balksItemItemKey = itemFailCount + 288900
    else
      balksItemItemKey = itemFailCount + 17799
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(balksItemItemKey))
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  end
end
function FromClient_SpiritEnchant_All_OnScreenResize()
  PaGlobal_SpiritEnchant_All:resize()
end
function FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  PaGlobal_SpiritEnchant_All:setEnchantFailCount()
  local refresh = false
  if true == PaGlobal_SpiritEnchant_All:isLightStoneEnchant() then
    PaGlobal_SpiritEnchant_All:updateLightStoneEnchantRate()
    return
  elseif nil == PaGlobal_SpiritEnchant_All._grantItemWhereType or nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    if false == PaGlobal_SpiritEnchant_All._isLastEnchant then
      PaGlobal_SpiritEnchant_All:clearEnchantSlot()
      HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
    end
    return
  else
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil ~= itemSSW and true == itemSSW:canMaxStackEnchant() then
        refresh = true
      end
    end
  end
  if true == refresh then
    PaGlobal_SpiritEnchant_All:retargetUI()
  else
    PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  end
  if true == _ContentsGroup_EnchantRenewer then
    if nil ~= PaGlobal_AddStack_All_UpdateItemCount then
      PaGloabl_AddStack_All_CloseSelectList()
      PaGlobal_AddStack_All_UpdateItemCount()
    end
    if nil ~= PaGlobal_AddStack_All_CloseValksNumberPad then
      PaGlobal_AddStack_All_CloseValksNumberPad()
    end
  end
end
function FromClient_SpiritEnchant_All_EnchantFailCountUpResult(enchantFailCount, enchantFailCountUpRate, isSuccess)
  PaGlobal_SpiritEnchant_All:updateEnchantFailCount()
  if true == isSuccess then
    PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_SUCCESS"))
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    ToClient_BlackspiritEnchantSuccess()
  else
    PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(false, PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_FAIL"))
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    audioPostEvent_SystemUi(0, 7)
    _AudioPostEvent_SystemUiForXBOX(0, 7)
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
    ToClient_BlackspiritEnchantCancel()
  end
end
function FromClient_SpiritEnchant_All_EnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo, errorMessage, isSafeLowProtectorItem)
  PaGlobal_SpiritEnchant_All:enchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo, errorMessage, isSafeLowProtectorItem)
  PaGlobal_TutorialManager:handleEnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_SpiritEnchant_All._isStart = false
end
function FromClient_SpiritEnchant_All_GroupEnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_SpiritEnchant_All._isAnimating = false
  PaGlobal_SpiritEnchant_All._isStart = false
  PaGlobal_SpiritEnchant_All._isEndGroupEnchant = true
  PaGlobal_SpiritEnchant_All:groupEnchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobalFunc_PartyEnchant_ResultShow()
end
function FromClient_SpiritEnchant_All_CaphrasUpgradeItem(mainWhereType, mainSlotNo, variedCount)
  PaGlobal_SpiritEnchant_All:didCaphrasEnchant(mainWhereType, mainSlotNo, variedCount)
  PaGlobal_SpiritEnchant_All._isStart = false
  PaGlobal_SpiritEnchant_All._isAnimating = false
end
function FromClient_SpiritEnchant_All_CaphrasPromotionItem(mainWhereType, mainSlotNo)
  PaGlobal_SpiritEnchant_All:didCaphrasPromotion(mainWhereType, mainSlotNo)
  PaGlobal_SpiritEnchant_All:checkCaphrasMaterialItem()
  PaGlobal_SpiritEnchant_All._isStart = false
  PaGlobal_SpiritEnchant_All._isAnimating = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    FromClient_Inventory_All_UpdateSlotDataByAddItem()
  elseif nil ~= Inventory_updateSlotDatabyAddItem then
    Inventory_updateSlotDatabyAddItem()
  end
end
function FromClient_SpiritEnchant_All_FailCountUpdate()
  PaGlobal_SpiritEnchant_All:darkPredationResult()
  if true == _ContentsGroup_EnchantRenewer then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
    end
  else
    PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItemAck()
  audioPostEvent_SystemUi(5, 61)
  _AudioPostEvent_SystemUiForXBOX(5, 61)
  PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_5"))
  if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.NORMAL or PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    PaGlobal_SpiritEnchant_All:setEnchantFailCount()
    PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCountAck()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_6"))
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.NORMAL or PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    PaGlobal_SpiritEnchant_All:setEnchantFailCount()
    PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCount(fromWhereType, fromSlotNo)
  local function doItemUse()
    ToClient_ConvertEnchantFailItemToCount(fromWhereType, fromSlotNo, 1)
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if failCount > 0 then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_VALKS_NOUSE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_3", "failCount", failCount, "itemName", itemWrapper:getStaticStatus():getName())
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
      content = messageBoxMemo,
      functionYes = doItemUse,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItem(fromWhereType, fromSlotNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if nil == failCount or failCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANNOT_ENCHANT_EXTRACTION"))
    return
  end
  PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
end
function PaGlobalFunc_SpiritEnchant_All_ClearEnchantSlot()
  PaGlobal_SpiritEnchant_All:clearEnchantSlot()
end
function PaGlobalFunc_SpiritEnchant_All_IsDarkPredation()
  if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
    return true
  end
  return false
end
function PaGlobalFunc_SpiritEnchant_All_GetTargetItem()
  return PaGlobal_SpiritEnchant_All._slotEquip
end
function PaGlobalFunc_SpiritEnchant_All_UpdateFuncNakAnimation(deltaTime)
  if false == PaGlobal_SpiritEnchant_All._isNakAnimating then
    return
  end
  PaGlobal_SpiritEnchant_All._nakAniTimeStamp = PaGlobal_SpiritEnchant_All._nakAniTimeStamp + deltaTime
  if PaGlobal_SpiritEnchant_All._nakElapsedTime <= PaGlobal_SpiritEnchant_All._nakAniTimeStamp then
    PaGlobal_SpiritEnchant_All._isNakAnimating = false
    PaGlobal_SpiritEnchant_All:stopEnchantResultNakMessage()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      PaGlobal_SpiritEnchant_All:setCheckEnchantInfo(false, true)
    end
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemWhereType and nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if PaGlobal_SpiritEnchant_All._isConsole or CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() or enchantLevel >= 17 then
    if PaGlobal_SpiritEnchant_All._nakAniTimeStamp > 0.7 and false == PaGlobal_SpiritEnchant_All._isAnimating then
      if PaGlobal_SpiritEnchant_All._isSafeLowProtectorItem == true and PaGlobal_SpiritEnchant_All._materialItemWhereType == nil and PaGlobal_SpiritEnchant_All._materialItemSlotNo == nil then
        PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      elseif nil ~= PaGlobal_SpiritEnchant_All._materialItemWhereType and nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
        PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      else
        PaGlobal_SpiritEnchant_All._isAbleEnchant = false
      end
    else
      PaGlobal_SpiritEnchant_All._isAbleEnchant = false
    end
  end
end
function PaGlobalFunc_SpiritEnchant_All_UpdateFuncCheckAni(deltaTime)
  PaGlobalFunc_SpiritEnchant_All_UpdateFuncNakAnimation(deltaTime)
  PaGlobal_StackExtraction_All_UpdatePerFrame(deltaTime)
  if false == PaGlobal_SpiritEnchant_All._isAnimating or nil == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local isEnchant = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      return true
    end
    return false
  end
  local isCaphrasEnchant = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      return true
    end
    return false
  end
  local isDarkPredation = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
      return true
    end
    return false
  end
  local isBookExtraction = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
      return true
    end
    return false
  end
  PaGlobal_SpiritEnchant_All._animationTimeStamp = PaGlobal_SpiritEnchant_All._animationTimeStamp + deltaTime
  if PaGlobal_SpiritEnchant_All._startTime <= PaGlobal_SpiritEnchant_All._animationTimeStamp and false == PaGlobal_SpiritEnchant_All._isStart then
    if true == isEnchant() then
      if true == PaGlobal_SpiritEnchant_All:isGroupEnchant() then
        local selfIsPartyLeader = RequestParty_isLeader()
        if selfIsPartyLeader == true then
          PaGlobal_SpiritEnchant_All:startGroupEnchant()
        end
      elseif true == PaGlobal_SpiritEnchant_All:isLightStoneEnchant() then
        PaGlobal_SpiritEnchant_All:startLightStoneEnchant()
      else
        PaGlobal_SpiritEnchant_All:startEnchant()
      end
    elseif true == isCaphrasEnchant() then
      if true == PaGlobal_SpiritEnchant_All._isPossiblePromotion then
        PaGlobal_SpiritEnchant_All:startPromotionEnchant()
      else
        PaGlobal_SpiritEnchant_All:startCaphrasEnchant()
      end
    elseif true == isDarkPredation() then
      PaGlobal_SpiritEnchant_All:startdarkPredationItem()
    elseif true == isBookExtraction() then
      PaGlobal_SpiritEnchant_All:startBookExtraction()
    end
    PaGlobal_SpiritEnchant_All._isStart = true
  elseif PaGlobal_SpiritEnchant_All._effectTime <= PaGlobal_SpiritEnchant_All._animationTimeStamp then
    PaGlobal_SpiritEnchant_All._isAnimating = false
    if true == isDarkPredation() then
      PaGlobal_SpiritEnchant_All:setAsDarkPredationButton()
      PaGlobal_SpiritEnchant_All:clearDarkSlot()
      PaGlobal_SpiritEnchant_All._isStart = false
    elseif true == isCaphrasEnchant() then
      PaGlobal_SpiritEnchant_All._isStart = false
    elseif true == isBookExtraction() then
      PaGlobal_SpiritEnchant_All:setAsBookExtractionButton()
      PaGlobal_SpiritEnchant_All:clearBookSlot()
      PaGlobal_SpiritEnchant_All._isStart = false
    end
    if nil ~= Panel_Npc_Dialog_All then
      Panel_Npc_Dialog_All:SetIgnoreChild(false)
    elseif nil ~= Panel_Npc_Dialog then
      Panel_Npc_Dialog:SetIgnoreChild(false)
    end
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetIgnore(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetIgnore(false)
    for i = 1, #PaGlobal_SpiritEnchant_All._ui.btn_mainRadio do
      PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[i]:SetIgnore(false)
    end
  else
    PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantNormal:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetIgnore(true)
  end
end
function PaGlobal_StackExtraction_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  PaGlobal_SpiritEnchant_All._familyStackDeltaTime = PaGlobal_SpiritEnchant_All._familyStackDeltaTime + deltaTime
  if PaGlobal_SpiritEnchant_All._familyStackDeltaTime < 1 then
    return
  end
  PaGlobal_SpiritEnchant_All._familyStackDeltaTime = 0
  local coolTime = ToClient_GetRemainSwapEnchantStackSlotCoolTime()
  if coolTime <= toInt64(0, 0) then
    PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetShow(false)
    return
  end
  local expirationTimeString = convertStringFromDatetimeType2(coolTime)
  PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetShow(true)
  PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetText(expirationTimeString)
end
function PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if _ContentsGroup_EnchantRemaster == true then
    return ToClient_GetCurrentEnchantTarget()
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemWhereType or nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return nil
  end
  return (getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo))
end
function PaGlobalFunc_SpiritEnchant_All_SetItemEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  PaGlobal_SpiritEnchant_All:setEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
end
function PaGlobalFunc_SpiritEnchant_All_SetMaterialItem(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setMaterialItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_SetItemCaphrasTarget(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setCaphrasTarget(slotNo, itemWrapper, inventoryType, true, false)
end
function PaGlobalFunc_SpiritEnchant_All_SetItemDarkPredation(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setDarkPredationItem(slotNo, itemWrapper, inventoryType)
end
function PaGlboalFunc_SpiritEnchant_All_SetItemBookExtraction(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setBookExtractionItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_CloseForEnchant()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  PaGlobalFunc_SpiritEnchant_All_Close()
end
function PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  if true == _ContentsGroup_EnchantLightStone and true == itemWrapper:isLightStone() then
    local lightStoneGrade = itemWrapper:getLightStoneGrade()
    if lightStoneGrade < __eLightStoneEnchantMinGrade or lightStoneGrade >= __eLightStoneEnchantMaxGrade then
      return true
    else
      return false
    end
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  return false == itemWrapper:checkToEnchantItem(false)
end
function PaGlobalFunc_SpiritEnchant_All_FilterForGroupEnchantTarget(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if isDuplicatedForDuel == true then
    return true
  end
  if _ContentsGroup_EnchantLightStone == true and itemWrapper:isLightStone() == true then
    local lightStoneGrade = itemWrapper:getLightStoneGrade()
    if lightStoneGrade < __eLightStoneEnchantMinGrade or lightStoneGrade >= __eLightStoneEnchantMaxGrade then
      return true
    end
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) == true then
    return true
  end
  if itemWrapper:checkToEnchantItem(false) == false then
    return true
  end
  local itemEnchantKey = itemWrapper:getStaticStatus():get()._key
  return not ToClient_CheckGroupEnchantLeaderReadyItem(itemEnchantKey)
end
function PaGlobalFunc_SpiritEnchant_All_FilterForCaphrasEquipItem(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  return false == itemWrapper:checkToUpgradeItem() and false == itemWrapper:isPossibleCronPromotion()
end
function PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  local returnValue = true
  if true == ToClient_Inventory_AvailFeedItem(whereType, slotNo) then
    returnValue = false
  else
    returnValue = true
  end
  return returnValue
end
function PaGlobalFunc_SpiritEnchant_All_FilterForBookExtraction(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailCountToItem == itemSSW:get():getContentsEventType() then
    local maxEnchantParam = itemSSW:getContentsEventParam1()
    return failCount > maxEnchantParam
  else
    return true
  end
end
function PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem(slotNo, itemWrapper, count, inventoryType)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == itemWrapper then
    return
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0)
    end
    return
  end
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemEnchantTarget(slotNo, itemWrapper, inventoryType, nil, true)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == PaGlobal_SpiritEnchant_All._currentMainTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemCaphrasTarget(slotNo, itemWrapper, inventoryType)
  elseif PaGlobal_SpiritEnchant_All._SUB_TAB.DARK == PaGlobal_SpiritEnchant_All._currentSubTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemDarkPredation(slotNo, itemWrapper, inventoryType)
  else
    PaGlboalFunc_SpiritEnchant_All_SetItemBookExtraction(slotNo, itemWrapper, inventoryType)
  end
end
function PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  if itemWrapper:checkToValksItem() then
    return false
  end
  if CppEnums.ItemWhereType.eCashInventory == whereType then
    return true
  end
  local returnValue = true
  if slotNo == getEnchantInformation():ToClient_getNeedNewPerfectItemSlotNo() then
    returnValue = false
  elseif slotNo ~= getEnchantInformation():ToClient_getNeedItemSlotNo() then
    returnValue = true
  else
    returnValue = false
    if PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo == slotNo and CppEnums.ItemWhereType.eInventory ~= whereType then
      returnValue = true
    end
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    returnValue = true
  end
  return returnValue
end
function PaGlobalFunc_SpiritEnchant_All_FilterForEnchantLightStoneMaterial(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  if false == itemWrapper:isLightStone() then
    return true
  end
  local lightStoneGrade = itemWrapper:getLightStoneGrade()
  if lightStoneGrade < __eLightStoneEnchantMinGrade or lightStoneGrade >= __eLightStoneEnchantMaxGrade then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  local lightStoneMainWrapper = ToClient_getLightStoneItemInfoWrapper(__eLightStoneEnchantInfo_MainItem)
  if nil ~= lightStoneMainWrapper and true == lightStoneMainWrapper:getItemEnchantKey():isDefined() then
    if lightStoneMainWrapper:getSlotNo() == slotNo then
      return true
    end
    if lightStoneMainWrapper:getGrade() ~= lightStoneGrade then
      return true
    end
  end
  for ii = __eLightStoneEnchantInfo_SubItem0, __eLightStoneEnchantInfo_ItemCount - 1 do
    local lightStoneWrapper = ToClient_getLightStoneItemInfoWrapper(ii)
    if nil ~= lightStoneWrapper and lightStoneWrapper:getSlotNo() == slotNo then
      return true
    end
  end
  return false
end
function PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial(slotNo, itemWrapper, Count, inventoryType)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == slotNo or nil == inventoryType or nil == itemWrapper then
    return
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    end
    return
  end
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT ~= PaGlobal_SpiritEnchant_All._currentMainTab then
    return
  end
  PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobalFunc_SpiritEnchant_All_SetMaterialItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_RClickForEnchantLightStoneMaterial(slotNo, itemWrapper, Count, inventoryType)
  local self = PaGlobal_SpiritEnchant_All
  if true == self._isAnimating then
    return
  end
  if nil == slotNo or nil == inventoryType or nil == itemWrapper then
    return
  end
  if true == itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    end
    return
  elseif true == itemWrapper:isLightStone() then
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  local toIndex
  local emptyIndex = ToClient_getEmptyIndexEnchantLightStone()
  if __eLightStoneEnchantInfo_MainItem == emptyIndex then
    self:setLightStoneEnchantTarget(slotNo, itemWrapper, inventoryType)
    return
  elseif __eLightStoneEnchantInfo_SubItem0 == emptyIndex then
    toIndex = LightStoneControlType.Sub0
  elseif __eLightStoneEnchantInfo_SubItem1 == emptyIndex then
    toIndex = LightStoneControlType.Sub1
  else
    return
  end
  local rv = ToClient_setLightStoneEnchantInfo(emptyIndex, inventoryType, slotNo)
  if 0 ~= rv then
    return
  end
  local control = self._ui_enchant.lightStoneControlList[toIndex]
  self:setItemToSlot(control.slot, slotNo, itemWrapper, inventoryType)
  control.empty:SetShow(false)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  local isComplete = ToClient_isSetCompleteEnchantLightStoneInfo()
  if true == isComplete then
    self._ui_enchant.chk_enchantCron:SetIgnore(false)
    self._ui_enchant.chk_enchantCron:SetMonoTone(false, false)
    self._ui_pc.btn_enchantGo:SetMonoTone(false)
    self._isAbleEnchant = true
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_1"))
    self:updateLightStoneCronDesc()
  else
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_SETLIGHTSTONE_2"))
  end
end
function PaGlobalFunc_SpiritEnchant_All_GetIsAnimating()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  return PaGlobal_SpiritEnchant_All._isAnimating
end
function FromClient_SpiritEnchant_All_FamilyStack_Update()
  FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
end
function PaGlobalFunc_SpiritEnchant_All_StackChangeEffect()
  if false == _ContentsGroup_EnchantRenewer then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_stackChangeEffect:EraseAllEffect()
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_stackChangeEffect:AddEffect("fUI_StackChange_Change_01A", false, 0, 0)
  elseif nil ~= PaGloabl_AddStack_All_close then
    PaGloabl_AddStack_All_close()
  end
end
function PaGlobalFunc_SpiritEnchant_All_ShowRstickKeyGuide(isShow)
  PaGlobal_SpiritEnchant_All._ui_console.stc_rstick:SetShow(isShow)
  PaGlobal_SpiritEnchant_All._ui_console.stc_keyguideBg:ComputePos()
  local tempBtnGroup = {
    PaGlobal_SpiritEnchant_All._ui_console.stc_rstick,
    PaGlobal_SpiritEnchant_All._ui_console.stc_select,
    PaGlobal_SpiritEnchant_All._ui_console.stc_detail,
    PaGlobal_SpiritEnchant_All._ui_console.stc_cancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_SpiritEnchant_All._ui_console.stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function HandleEventOn_SpiritEnchant_All_MaxStack(maxStackCount)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_MAXSTACK_DESC", "stack", tostring(maxStackCount))
  TooltipSimple_Show(PaGlobal_SpiritEnchant_All._ui_enchant.txt_maxEncahnt, "", descStr)
end
function HandleEventOut_SpiritEnchant_All_MaxStack()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  TooltipSimple_Hide()
end
function PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  local rate = PaGlobal_SpiritEnchant_All:getAdditionalRate()
  PaGlobal_SpiritEnchant_All._ui_enchant.stc_AdditionalRate_Value:SetText("+" .. string.format("%.2f", rate / CppDefine.e100Percent * 100) .. "%")
end
function HandleEventLUp_SpiritEnchant_All_SaveStack()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  HandleEventLUp_SpiritEnchant_All_MainTabSelect(PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION)
  HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK)
end
function HandleEventOn_SpiritEnchant_All_TubalaItemTooltip_Show()
  if Panel_Window_StackExtraction_All == nil then
    return
  end
  if PaGlobal_SpiritEnchant_All._tubalaItemKey == nil then
    return
  end
  local tubalaItemSSW = getItemEnchantStaticStatus(PaGlobal_SpiritEnchant_All._tubalaItemKey)
  if tubalaItemSSW == nil then
    return
  end
  if PaGlobal_SpiritEnchant_All._isConsole == true and ToClient_isConsole() == true then
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, tubalaItemSSW, Defines.TooltipTargetType.Item, PaGlobal_SpiritEnchant_All._slotTubala.icon)
  else
    Panel_Tooltip_Item_Show(tubalaItemSSW, PaGlobal_SpiritEnchant_All._slotTubala.icon, true, false, nil, nil, nil)
  end
end
function HandleEventOut_SpiritEnchant_All_TubalaItemTooltip_Hide()
  if PaGlobal_SpiritEnchant_All._isConsole == true and ToClient_isConsole() == true then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandlePadEventX_SpiritEnchant_All_ShowTubalaItemTooltip()
  if Panel_Window_StackExtraction_All == nil then
    return
  end
  if PaGlobal_SpiritEnchant_All._tubalaItemKey == nil then
    return
  end
  if PaGlobal_SpiritEnchant_All._isConsole == false then
    return
  end
  local tubalaItemSSW = getItemEnchantStaticStatus(PaGlobal_SpiritEnchant_All._tubalaItemKey)
  if tubalaItemSSW == nil then
    return
  end
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local invenPosX = 0
  if _ContentsGroup_NewUI_Inventory_All == true then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, tubalaItemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function PaGlobal_SpiritEnchant_All_SetDarkPredationValue(rate, value)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer or false == _ContentsGroup_EatStackEnchant then
    return
  end
  PaGlobal_SpiritEnchant_All._darkPredationRate = rate
  PaGlobal_SpiritEnchant_All._darkPredationValue = value
end
function FGlobal_Enchant_SetTargetItem()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  local self = PaGlobal_SpiritEnchant_All
  if self._isConsole == true then
    return false
  end
  if self._currentMainTab == self._MAIN_TAB.ENCHANT then
    if self._slotEquip.slot.empty == false then
      return true
    end
  elseif self._currentMainTab == self._MAIN_TAB.CARPHRAS then
    if self._slotEquip_Caphras.empty == false then
      return true
    end
  elseif self._currentMainTab == self._MAIN_TAB.EXTRACTION then
    if self._currentSubTab == self._SUB_TAB.DARK then
      if self._slotDarkItem.empty == false then
        return true
      end
    elseif self._currentSubTab == self._SUB_TAB.BOOK and self._slotBookItem.empty == false then
      return true
    end
  end
  return false
end
function FromClient_StrartGroupEnchantAni()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  if Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local self = PaGlobal_SpiritEnchant_All
  if self._isLeaderGroupEnchantMode == true then
    self._ui_pc.btn_groupEnchantReady:SetShow(false)
    self._ui_pc.btn_groupEnchantGo:SetShow(false)
    self:resizePanel()
  end
  if self._isGroupEnchantPartyMember == true then
    self._ui_pc.btn_groupEnchantReady:SetShow(false)
    self:resizePanel()
  end
  self:startEnchantAnimation()
  PaGlobalFunc_PartyEnchant_StartEffect()
end
function FGlobal_Enchant_SetGroupEnchantMode()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  local self = PaGlobal_SpiritEnchant_All
  if self._isLeaderGroupEnchantMode == true then
    return
  end
  self._ui_enchant.chk_skipAni:SetShow(false)
  if self._isConsole == true then
    self._ui_console.stc_enchantGoY:SetShow(false)
    self._ui_pc.btn_enchantGo:SetShow(false)
    self._ui_pc.chk_inventoryOpen:SetShow(true)
    self._ui_pc.chk_inventoryOpen:SetCheck(true)
    self._ui_pc.btn_groupEnchantReady:SetShow(true)
    self._ui_pc.btn_groupEnchantGo:SetShow(false)
    Panel_Window_Inventory:SetPosX(Panel_Window_StackExtraction_All:GetPosX() + Panel_Window_Inventory:GetSizeX() + Panel_Window_StackExtraction_All:GetSizeX() + 10)
  else
    self._ui_pc.btn_enchantGo:SetShow(false)
    self._ui_pc.chk_inventoryOpen:SetShow(true)
    self._ui_pc.chk_inventoryOpen:SetCheck(true)
    self._ui_pc.btn_groupEnchantReady:SetShow(true)
    self._ui_pc.btn_groupEnchantGo:SetShow(false)
    Panel_Window_Inventory_All:SetPosX(Panel_Window_StackExtraction_All:GetPosX() + Panel_Window_StackExtraction_All:GetSizeX() + 10)
    Panel_Window_Inventory_All:SetPosY(Panel_Window_StackExtraction_All:GetPosY())
  end
  PaGlobalFunc_OtherUser_TriedStack_Close()
  self._ui_enchant.chk_enchantForce:SetShow(false)
  self._isLeaderGroupEnchantMode = true
  self._ui_enchant.btn_groupEnchant:SetShow(not self._isLeaderGroupEnchantMode)
  self._ui.btn_mainRadio[1]:SetIgnore(true)
  self._ui.btn_mainRadio[2]:SetShow(false)
  self._ui.btn_mainRadio[3]:SetShow(false)
  self._ui_enchant.stc_StackSave:SetIgnore(true)
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function FGlobal_Enchant_SetGroupEnchantModePartyMember()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  local self = PaGlobal_SpiritEnchant_All
  if ToClient_IsGroupEnchantAble() == false then
    return
  end
  PaGlobalFunc_OtherUser_TriedStack_Close()
  self._ui_enchant.chk_skipAni:SetShow(false)
  if self._isConsole == true then
    self._ui_console.stc_enchantGoY:SetShow(false)
    self._ui_pc.btn_enchantGo:SetShow(false)
    self._ui_pc.chk_inventoryOpen:SetShow(true)
    self._ui_pc.chk_inventoryOpen:SetCheck(true)
    self._ui_pc.btn_groupEnchantReady:SetShow(true)
    self._ui_pc.btn_groupEnchantGo:SetShow(false)
    Panel_Window_Inventory:SetPosX(Panel_Window_StackExtraction_All:GetPosX() + Panel_Window_Inventory:GetSizeX() + Panel_Window_StackExtraction_All:GetSizeX() + 10)
  else
    self._ui_pc.btn_enchantGo:SetShow(false)
    self._ui_pc.chk_inventoryOpen:SetShow(true)
    self._ui_pc.chk_inventoryOpen:SetCheck(true)
    self._ui_pc.btn_groupEnchantReady:SetShow(true)
    self._ui_pc.btn_groupEnchantGo:SetShow(false)
    Panel_Window_Inventory_All:SetPosX(Panel_Window_StackExtraction_All:GetPosX() + Panel_Window_StackExtraction_All:GetSizeX() + 10)
    Panel_Window_Inventory_All:SetPosY(Panel_Window_StackExtraction_All:GetPosY())
  end
  self._ui_enchant.chk_enchantForce:SetShow(false)
  self._ui.btn_mainRadio[1]:SetIgnore(true)
  self._ui.btn_mainRadio[2]:SetShow(false)
  self._ui.btn_mainRadio[3]:SetShow(false)
  self._ui_enchant.stc_StackSave:SetIgnore(true)
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_GroupEnchantInventoryToggle()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  local self = PaGlobal_SpiritEnchant_All
  local targetPanel
  if self._isConsole == true then
    targetPanel = Panel_Window_Inventory
  else
    targetPanel = Panel_Window_Inventory_All
  end
  if targetPanel:GetShow() == true then
    targetPanel:SetShow(false)
    self._ui_pc.chk_inventoryOpen:SetCheck(false)
  else
    targetPanel:SetShow(true)
    self._ui_pc.chk_inventoryOpen:SetCheck(true)
  end
end
function HandleEventLUp_SpiritEnchant_All_GroupEnchantReadyToggle(isReady, isMaster)
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  if ToClient_IsGroupEnchantAble() == false then
    return
  end
  local self = PaGlobal_SpiritEnchant_All
  if isMaster == true then
    if self._isLeaderGroupEnchantMode == true then
      if isReady == true then
        PaGlobal_SpiritEnchant_All._ui_pc.btn_groupEnchantGo:SetShow(true)
        PaGlobal_SpiritEnchant_All:resizePanel()
      else
        PaGlobal_SpiritEnchant_All._ui_pc.btn_groupEnchantGo:SetShow(false)
        PaGlobal_SpiritEnchant_All:resizePanel()
      end
      self._isGroupEnchantReady = isReady
    end
  else
    self._isGroupEnchantReady = isReady
  end
  if self._isGroupEnchantReady == true then
    self._ui_pc.btn_groupEnchantReady:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_READYCANCLE"))
  else
    self._ui_pc.btn_groupEnchantReady:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_READY"))
  end
end
function FGlobal_Enchant_SetGroupEnchantButtonMode()
  if nil == PaGlobal_SpiritEnchant_All then
    return false
  end
  local self = PaGlobal_SpiritEnchant_All
  if ToClient_IsGroupEnchantAble() == false then
    return
  end
  local groupEnchantMode = self._isLeaderGroupEnchantMode or self._isGroupEnchantPartyMember
  if groupEnchantMode == false then
    return
  end
  self._ui_pc.btn_enchantGo:SetShow(false)
  self._ui_enchant.chk_skipAni:SetShow(false)
  self._ui_enchant.chk_enchantForce:SetShow(false)
  self._ui_pc.btn_groupEnchantReady:SetShow(true)
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_ReqGroupEnchantAniStart()
  local doGroupEnchant = function()
    ToClient_RequestGroupEnchantAniStart()
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._slotEquip.slot.inventoryType, PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo)
  if nil == itemWrapper then
    return
  end
  local itemStaticStatus = getItemEnchantStaticStatus(itemWrapper:get():getKey())
  if nil == itemStaticStatus then
    return
  end
  local enchantLevel = itemStaticStatus:get()._key:getEnchantLevel()
  local itemName = itemStaticStatus:getName()
  if enchantLevel > 0 then
    if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemStaticStatus:getItemClassify() and (itemStaticStatus:isSpecialEnchantItem() == false or itemStaticStatus:isSpecialAccessory() == true) then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemStaticStatus:getName()
    elseif 1 == itemStaticStatus:getItemType() and enchantLevel > 15 then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemStaticStatus:getName()
    end
  end
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemStaticStatus)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_CONFIRM", "ITEMNAME", strItemName),
    functionYes = doGroupEnchant,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_OtherUser_TiredStack_ConsoleShow(isShow)
  if true == isShow then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleClicked_ValksStack()")
  else
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandlePadEventLTRT_SpiritEnchant_All_SubMoveTab(true)")
  end
end
function HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(index, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name
  if index == 1 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_2")
  elseif index == 2 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_1")
  elseif index == 3 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_5")
  elseif index == 4 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER2")
  elseif index == 5 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_4")
  elseif index == 6 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER")
  elseif index == 7 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_6")
  elseif index == 8 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_7")
  elseif index == 9 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_8")
  end
  TooltipSimple_Show(PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail, name, nil)
end
