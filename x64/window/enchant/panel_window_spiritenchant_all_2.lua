function PaGlobal_SpiritEnchant_All:enchantTabOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  self:clearEnchantSlot()
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  if true == _ContentsGroup_EnchantRenewer then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBgOld:SetShow(false)
    self._ui_enchant.stc_infoAreaOld:SetShow(false)
    self._ui_enchant.stc_infoArea:SetShow(true)
    self._ui_enchant.stc_imageArea:SetShow(true)
    self._ui_enchant.stc_imageAreaOld:SetShow(false)
    self._ui_enchant.stc_imageOld:SetShow(false)
    self._ui_enchant.stc_infoAreaOld:SetShow(false)
    self._ui_enchant.stc_infoArea:SetShow(true)
    self._ui_enchant.stc_noticeBarOld:SetShow(false)
  end
  self._ui_enchant.stc_image:SetShow(true)
  self._ui_enchant.stc_topBg:SetShow(true)
  self._ui_enchant.stc_lightStoneImage:SetShow(false)
  self._ui_enchant.stc_lightStoneTopBg:SetShow(false)
  self._ui_enchant.stc_image2:SetShow(false)
  self._ui_enchant.stc_wingTop:SetShow(false)
  self._ui_enchant.stc_wingBottom:SetShow(false)
  self._ui_enchant.stc_buttonArea:SetShow(true)
  self._ui_enchant.radio_enchantNormal:SetShow(false)
  self._ui_enchant.radio_enchantPerfect:SetShow(false)
  self._ui_enchant.chk_enchantForce:SetShow(false)
  if true == self._isContents_Enable then
    self._ui_enchant.chk_enchantCron:SetShow(true)
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
  else
    self._ui_enchant.chk_enchantCron:SetShow(false)
  end
  self._ui_enchant.chk_enchantDefenceFail:SetShow(false)
  self._ui_enchant.chk_skipAni:SetShow(true)
  self._ui_pc.btn_enchantGo:SetShow(false == self._isConsole)
  self._ui_enchant.txt_subTitle:SetShow(true)
  self._ui_enchant.txt_subTitleValue:SetShow(true)
  self._ui_enchant.txt_valks:SetShow(true)
  self._ui_enchant.txt_valksValue:SetShow(true)
  self._ui_enchant.txt_plus:SetShow(true)
  self._ui_enchant.txt_plusValue:SetShow(true)
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMaxSizeY)
  self._ui_enchant.stc_bg:ComputePos()
  self._ui_enchant.stc_wingsInfo[1].count:SetShow(false)
  self._ui_enchant.stc_wingsInfo[3].count:SetShow(false)
  self._ui_enchant.radio_enchantNormal:SetCheck(true)
  self._ui_enchant.radio_enchantPerfect:SetCheck(false)
  self._ui_enchant.chk_enchantForce:SetCheck(false)
  self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
  ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
  self._ui_enchant.stc_line:SetShow(true)
  self._ui_enchant.txt_enchantRate:SetShow(false)
  self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
  self._ui_enchant.txt_enchantDesc:ComputePos()
  self._ui_enchant.txt_enchantDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_enchantDesc:SetShow(false)
  self._ui_enchant.txt_enchantDesc:SetText("")
  self._ui_enchant.stc_noticeBar:SetShow(true)
  self._ui_enchant.stc_noticeBar:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETEQUIPMENT"))
  self._ui_enchant.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_enchant.txt_plusValue:SetText("+ " .. failCount)
  self._ui_enchant.txt_subTitleValue:SetText("+ " .. failCount + valksCount + bonusCount)
  self:setText_NumOfCron(0, 0)
  self._isMaterialSlotMonotone = false
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()")
  else
    self._ui_pc.btn_enchantGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()")
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  self._randomEffectNum = 0
  if self._isGroupEnchantPartyMember == true then
    FGlobal_Enchant_SetGroupEnchantModePartyMember()
    Inventory_SetFunctor(nil, nil, nil, nil)
    Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForGroupEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  end
end
function PaGlobal_SpiritEnchant_All:clearEnchantSlot()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == _ContentsGroup_EnchantLightStone then
    self._ui_enchant.stc_image:SetShow(true)
    self._ui_enchant.stc_topBg:SetShow(true)
    self._ui_enchant.stc_lightStoneImage:SetShow(false)
    self._ui_enchant.stc_lightStoneTopBg:SetShow(false)
    self._ui.txt_titleBg:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RADIOBTNTITLE_1"))
    self._ui_enchant.txt_subTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADDITIONALSTACK_TOTAL"))
  end
  if PaGlobal_SpiritEnchant_All._isGroupEnchantPartyMember == true then
    ToClient_RequestGroupEnchantItemSetCancel()
  end
  self:clearItemSlot(self._slotEquip.slot)
  self:clearItemSlot(self._slotMateiralInfo[1])
  self:clearItemSlot(self._slotMateiralInfo[2])
  self:clearItemSlot(self._slotMateiralInfo[3])
  self:setAsEnchantButton()
  self._ui_enchant.radio_enchantNormal:SetIgnore(false)
  self._ui_enchant.radio_enchantPerfect:SetIgnore(false)
  self._ui_enchant.chk_enchantForce:SetIgnore(false)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  if true == self._isContents_Enable then
    self._ui_enchant.chk_enchantCron:SetShow(true)
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.chk_enchantCron:SetCheck(false)
  else
    self._ui_enchant.chk_enchantCron:SetShow(false)
  end
  self._ui_enchant.chk_enchantDefenceFail:SetShow(false)
  self._grantItemWhereType = nil
  self._grantItemSlotNo = nil
  self._enchantInfo:ToClient_clearData()
  self._ui_enchant.txt_enchantRate:SetShow(false)
  self._isLastEnchant = false
  self._ui_enchant.txt_maxEncahnt:SetShow(false)
  self:BlablaShow(false)
  self._ui_enchant.stc_tubalaExchangeBg:SetShow(false)
  self._ui_enchant.stc_StackInfo:SetShow(true)
  self:clearItemSlot(self._slotTubala)
  self._tubalaItemKey = nil
  self._naruItemWhereType = nil
  self._naruItemSlotNo = nil
  local static_txt = UI.getChildControl(self._ui_enchant.stc_equipSlot, "StaticText_1")
  static_txt:SetShow(false)
  self._ui_enchant.stc_blackSpiritCount:SetShow(false)
end
function PaGlobal_SpiritEnchant_All:clearLightStoneEnchantSlot()
  if _ContentsGroup_EnchantLightStone == false then
    return
  end
  self:clearEnchantSlot()
  self:init_EnchantFrame()
  self._isLastEnchant = false
  self._isMaterialSlotMonotone = false
  self._isMaxStackEnchant = false
  self._isAdventureEnchant = false
  self._grantItemSlotNo = nil
  self._grantItemWhereType = nil
  self._ui_enchant.stc_image:SetShow(false)
  self._ui_enchant.stc_topBg:SetShow(false)
  self._ui_enchant.stc_lightStoneImage:SetShow(true)
  self._ui_enchant.stc_lightStoneTopBg:SetShow(true)
  self._ui.txt_titleBg:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIGHTSTONE_ENCHANT_TITLE"))
  self._ui_enchant.txt_subTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIGHTSTONE_STACK_SUBTITLE"))
  for ii = LightStoneControlType.Main, LightStoneControlType.Cron do
    local control = self._ui_enchant.lightStoneControlList[ii]
    self:clearItemSlot(control.slot)
    if nil ~= control.count then
      control.count:SetText("")
    end
    control.empty:SetShow(true)
  end
  self._ui_enchant.txt_lightStoneEnchantRate:SetShow(false)
  ToClient_clearLightStoneEnchantInfo()
end
function PaGlobal_SpiritEnchant_All:init_EnchantFrame()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_enchant.stc_buttonArea:SetShow(true)
  self._ui_enchant.radio_enchantNormal:SetShow(false)
  self._ui_enchant.radio_enchantPerfect:SetShow(false)
  self._ui_enchant.chk_enchantForce:SetShow(false)
  if true == self._isContents_Enable then
    self._ui_enchant.chk_enchantCron:SetShow(true)
  else
    self._ui_enchant.chk_enchantCron:SetShow(false)
  end
  self._ui_enchant.txt_enchantDesc:SetShow(true)
  self._ui_enchant.txt_enchantDesc:SetText("")
  self._ui_enchant.chk_skipAni:SetShow(true)
  self._ui_pc.btn_enchantGo:SetShow(false == self._isConsole)
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
  self._ui_enchant.stc_bg:ComputePos()
  self:BlablaShow(false)
  self._isWaitingServer = false
end
function PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  local rate = ToClient_getEnchantSuccessRate(self._ui_enchant.chk_enchantForce:IsCheck(), self._ui_enchant.radio_enchantPerfect:IsCheck(), __eEnchantFailCountSlotNo_Undefined, 0, 0, self._isSafeLowProtectorItem)
  if -1 ~= rate then
    local enchantPercentString = ""
    if _ContentsGroup_ViewRate == true then
      enchantPercentString = rate / CppDefine.e100Percent * 100
    else
      enchantPercentString = string.format("%.2f", rate / CppDefine.e100Percent * 100)
    end
    self._ui_enchant.txt_enchantRate:SetShow(true)
    self._ui_enchant.txt_enchantRate:SetText(enchantPercentString .. "%")
    self._currentEnchantRate = rate / CppDefine.e100Percent * 100
  else
    self._ui_enchant.txt_enchantRate:SetShow(false)
  end
  if self._isAdventureEnchant == true then
    local enchantPercentString = ""
    if _ContentsGroup_ViewRate == true then
      enchantPercentString = 1000000 / CppDefine.e100Percent * 100
    else
      enchantPercentString = string.format("%.2f", 1000000 / CppDefine.e100Percent * 100)
    end
    self._ui_enchant.txt_enchantRate:SetShow(true)
    self._ui_enchant.txt_enchantRate:SetText(enchantPercentString .. "%")
    self._currentEnchantRate = rate / CppDefine.e100Percent * 100
  end
end
function PaGlobal_SpiritEnchant_All:setEnchantFailCount()
  if nil == self._enchantInfo then
    self._enchantInfo = getEnchantInformation()
    self._enchantInfo:ToClient_clearData()
  end
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusStackCount = self._enchantInfo:ToClient_getBonusStackCount()
  local failCountUpRate = Int64toInt32(self._enchantInfo:ToClient_getFailCountUpRate())
  self._ui_enchant.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_enchant.txt_plusValue:SetText("+ " .. failCount)
  self._ui_enchant.txt_subTitleValue:SetText("+ " .. failCount + valksCount + bonusStackCount)
  if nil ~= PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate then
    PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
  end
  if true == Panel_OtherUser_AdditionalRate_All:GetShow() then
    PaGlobalFunc_OtherUser_TriedStack_Open()
  end
end
function PaGlobal_SpiritEnchant_All:didsetEnchantTarget(isMonotone, isRadioClick)
  if nil == self._grantItemWhereType or nil == self._grantItemSlotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  local needCountForPerfectEnchant_s64 = self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64()
  local cur_MaxEndura = self._enchantInfo:ToClient_getCurMaxEndura()
  local dec_MaxEndura = self._enchantInfo:ToClient_getDecMaxEndura()
  self._strForEnchantInfo._notChecked = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType)
  PaGlobal_SpiritEnchant_All:setProtectorItems()
  if needCountForPerfectEnchant_s64 > toInt64(0, 0) then
    self._ui_enchant.chk_enchantForce:SetShow(true)
    self._isShow_forceEnchant = true
    self._ui_enchant.chk_enchantForce:ComputePos()
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._forcedChecked = enduranceDesc .. self:getStr_PerfectEnchantInfo(needCountForPerfectEnchant_s64, self._enchantInfo:ToClient_getDecMaxEnduraPerfect())
    if true == self._ui_enchant.chk_enchantForce:IsCheck() then
      self._ui_enchant.radio_enchantPerfect:SetCheck(false)
      self._ui_enchant.radio_enchantNormal:SetCheck(false)
    end
  else
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._isShow_forceEnchant = false
  end
  if 0 == self._enchantInfo:ToClient_checkIsValidDifficultEnchant() then
    self._ui_enchant.radio_enchantPerfect:SetShow(true)
    self._ui_enchant.radio_enchantNormal:SetShow(true)
    self._isShow_perfectEnchant = true
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self._isShow_cronEnchant = false
    self._ui_enchant.chk_enchantDefenceFail:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    self._ui_enchant.stc_wingBottom:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].count:SetShow(false)
    self._isShow_defenceFailEnchant = false
    self:setText_EnchantInfo()
  else
    self._ui_enchant.radio_enchantPerfect:SetShow(false)
    self._ui_enchant.radio_enchantNormal:SetShow(false)
    self._isShow_perfectEnchant = false
  end
  if true == self._isSetNewPerfectItemMaterial then
    self._isShow_cronEnchant = false
    self._isShow_forceEnchant = false
    self._isShow_perfectEnchant = false
    self._isShow_defenceFailEnchant = false
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self:setText_NumOfCron(0, 0)
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._ui_enchant.radio_enchantPerfect:SetShow(false)
    self._ui_enchant.radio_enchantNormal:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    self._ui_enchant.stc_wingBottom:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].count:SetShow(false)
  end
  if true == self._isShow_forceEnchant or true == self._isShow_perfectEnchant then
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgOriSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
    self._ui_enchant.txt_enchantDesc:ComputePos()
  elseif true == self._isShow_cronEnchant or true == self._isShow_defenceFailEnchant then
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY - self._ui_enchant.stc_buttonArea:GetSizeY())
    self._ui_enchant.txt_enchantDesc:ComputePos()
  else
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
    self._ui_enchant.txt_enchantDesc:ComputePos()
  end
  if nil == isRadioClick then
    self:setCheckEnchantInfo(isMonotone)
  end
  self:setMaxStackEnchant()
  self:showGuaranteeEnchantBG(false)
  if true == self._isMaterialSlotMonotone then
    self._ui_pc.btn_enchantGo:SetMonoTone(true)
    self._isAbleEnchant = false
  end
  if self._isAdventureEnchant == true then
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._isShow_forceEnchant = false
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    self._ui_enchant.chk_enchantDefenceFail:SetIgnore(true)
    self._ui_enchant.chk_enchantDefenceFail:SetMonoTone(true, true)
    self._ui_enchant.stc_wingBottom:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].count:SetShow(false)
    self:showGuaranteeEnchantBG(true)
    self._ui_enchant.stc_blackSpiritCountBG:AddEffect("fUI_SpiritEnchant_Spirit_Success_02A_Super", false, 0, 0)
    self:setText_NumOfCron(0, 0)
  end
  if self._isSafeLowProtectorItem == true then
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._isShow_forceEnchant = false
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self:showGuaranteeEnchantBG(true)
    self:setText_NumOfCron(0, 0)
  end
  FGlobal_Enchant_SetGroupEnchantButtonMode()
  self:setButtonAlign()
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:setProtectorItems(isCancleEnchant)
  self._isSafeLowProtectorItem = false
  local itemWrapper = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  local cur_MaxEndura = self._enchantInfo:ToClient_getCurMaxEndura()
  local dec_MaxEndura = self._enchantInfo:ToClient_getDecMaxEndura()
  local protectorItemStaticWrapper = itemWrapper:getStaticStatus():getProtectorItem()
  local isSpecialEnchantItem = itemWrapper:getStaticStatus():isSpecialEnchantItem()
  local isAccessory = 4 == enchantItemClassify
  local isKarazardAccessory = itemWrapper:getStaticStatus():isKarazardAccessory() == true
  local isItemSkillOption = itemWrapper:getStaticStatus():getContentsEventType() == __eContentsType_ItemSkillOption
  if true == isSpecialEnchantItem then
    isAccessory = false
  end
  if isKarazardAccessory == true then
    isAccessory = true
  end
  local disableCronByMaterial = false
  local isMaterialSetAnable = self._isAbleEnchant
  local isCron = false
  local isDefenceFail = false
  local useCron = true
  if _ContentsGroup_UseCronToStacklessBlackStoneItemType == false then
    useCron = itemWrapper:getStaticStatus():isNeedStackLessBlackStonForEnchant() == false
  end
  if useCron == true and self._isSetNewPerfectItemMaterial == false then
    local hasProtectorItem = self._enchantInfo:ToClient_hasProtectorItemInInventory()
    if hasProtectorItem == false then
      isDefenceFail = false
      isCron = (enchantLevel > 16 or 4 == enchantItemClassify) and toInt64(0, 0) < self._enchantInfo:ToClient_getNeedCountForProtect_s64()
      if isCron == true and isMaterialSetAnable == false then
        disableCronByMaterial = true
      end
    else
      isDefenceFail = true
      isCron = false
    end
  else
    isDefenceFail = false
    isCron = false
  end
  if true == self._isContents_Enable then
    self._ui_enchant.chk_enchantCron:SetIgnore(not isCron)
    self._ui_enchant.chk_enchantCron:SetMonoTone(not isCron, not isCron)
    self._ui_enchant.chk_enchantCron:SetShow(not isDefenceFail)
  else
    self._ui_enchant.chk_enchantCron:SetShow(false)
  end
  if isCron == false then
    self._ui_enchant.chk_enchantCron:SetCheck(false)
  end
  self._ui_enchant.stc_wingTop:SetShow(isCron)
  self._ui_enchant.stc_wingsInfo[2].slot:SetShow(isCron)
  self._ui_enchant.stc_wingsInfo[2].count:SetShow(isCron)
  self._isShow_cronEnchant = isCron
  if disableCronByMaterial == true and (isCancleEnchant == nil or isCancleEnchant == false) then
    if true == self._isContents_Enable then
      self._ui_enchant.chk_enchantCron:SetIgnore(true)
      self._ui_enchant.chk_enchantCron:SetMonoTone(true)
      self._ui_enchant.chk_enchantCron:SetCheck(false)
    else
      self._ui_enchant.chk_enchantCron:SetShow(false)
    end
  end
  local isForceEnchant = self._isShow_forceEnchant == true and self._ui_enchant.chk_enchantForce:IsCheck()
  if _ContentsGroup_AdventureMode == true and self._isAdventureEnchant == true or isForceEnchant == true then
    if true == self._isContents_Enable then
      self._ui_enchant.chk_enchantCron:SetIgnore(true)
      self._ui_enchant.chk_enchantCron:SetMonoTone(true)
      self._ui_enchant.chk_enchantCron:SetCheck(false)
      self._ui_enchant.stc_wingTop:SetShow(false)
      self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
      self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    else
      self._ui_enchant.chk_enchantCron:SetShow(false)
    end
  end
  local isCronCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__eCheckCronEnchant)
  if isCronCheck ~= nil and self._ui_enchant.chk_enchantCron:IsIgnore() == false then
    self._ui_enchant.chk_enchantCron:SetCheck(isCronCheck)
    local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
    ToClient_RequestSpiritEnchantRecord(isCheckCron, 6)
  end
  if true == isCron then
    self:setText_NumOfCron(self._enchantInfo:ToClient_getCountProtecMaterial_s64(), self._enchantInfo:ToClient_getNeedCountForProtect_s64())
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._cronChecked = enduranceDesc .. self:getStr_EnchantProtectInfo(enchantType, enchantItemClassify)
  else
    self:setText_NumOfCron(0, 0)
  end
  self._ui_enchant.chk_enchantDefenceFail:SetShow(isDefenceFail)
  self._ui_enchant.chk_enchantDefenceFail:SetIgnore(not isDefenceFail)
  self._ui_enchant.chk_enchantDefenceFail:SetMonoTone(not isDefenceFail)
  self._ui_enchant.stc_wingBottom:SetShow(isDefenceFail)
  self._ui_enchant.stc_wingsInfo[3].slot:SetShow(isDefenceFail)
  self._isShow_defenceFailEnchant = isDefenceFail
  local isDefenceFailCheck = self._ui_enchant.chk_enchantDefenceFail:IsCheck()
  if true == isDefenceFail then
    local showSafeLowProtectorItem = false
    self:setItemToSlotMonoTone(self._slotMateiralInfo[3], nil, not isDefenceFailCheck)
    if nil ~= protectorItemStaticWrapper then
      self._slotMateiralInfo[3]:setItemByStaticStatus(protectorItemStaticWrapper, 1)
      if protectorItemStaticWrapper:isSafeLowProtectorItem() == true then
        showSafeLowProtectorItem = true
        if isDefenceFailCheck == true then
          self._isSafeLowProtectorItem = true
        end
      end
    end
    if self._isSafeLowProtectorItem == true then
      self._ui_enchant.stc_blackSpiritCount:SetShow(false)
    elseif itemWrapper:getSSEnchantCount() ~= 0 then
      local ssEnchantCount = itemWrapper:getSSEnchantCount()
      local currentEnchantCount = itemWrapper:getCurrentEnchantCount()
      self._ui_enchant.stc_blackSpiritCount:SetShow(true)
      self._ui_enchant.stc_blackSpiritCount:EraseAllEffect()
      self._ui_enchant.stc_blackSpiritCount:AddEffect("fUI_SpiritEnchant_Spirit_Success_01A_Super", false, 0, 0)
      if ssEnchantCount <= currentEnchantCount then
        self._isAdventureEnchant = true
        self._ui_enchant.stc_blackSpiritCount:AddEffect("fUI_SpiritEnchant_Spirit_Box_01A_Super", true, 0, 0)
      end
    end
    self._ui_enchant.chk_enchantDefenceFail:SetTextMode(__eTextMode_LimitText)
    if showSafeLowProtectorItem == true then
      if isAccessory == true then
        self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_2"))
        self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(1, true)")
      else
        self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_1"))
        self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(2, true)")
      end
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Crystal_Normal", 0)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Crystal_Over", 1)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Crystal_Select", 2)
    elseif true == isAccessory then
      if isKarazardAccessory == true then
        self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_5"))
        self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(3, true)")
      else
        self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER2"))
        self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(4, true)")
      end
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Normal", 0)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Over", 1)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Select", 2)
    else
      if isItemSkillOption == true then
        self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_4"))
        self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(5, true)")
      else
        local protectorItemKey = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCrystalProtectorItemKey()
        if protectorItemKey == 761801 then
          self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_6"))
          self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(7, true)")
        elseif protectorItemKey == 761802 then
          self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_7"))
          self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(8, true)")
        elseif protectorItemKey == 761803 then
          self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER_8"))
          self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(9, true)")
        else
          self._ui_enchant.chk_enchantDefenceFail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USEHAMMER"))
          self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(6, true)")
        end
      end
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Normal", 0)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Over", 1)
      self._ui_enchant.chk_enchantDefenceFail:ChangeTextureInfoTextureIDAsync("Combine_Etc_BlackSpirit_Stack_Btn_Hammer_Select", 2)
    end
    self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_Out", "HandleEventOn_SpiritEnchant_All_DefenceFail_SimpleTooltip_Show(0, false)")
    if isDefenceFailCheck == true then
      self._ui_enchant.chk_enchantDefenceFail:setRenderTexture(self._ui_enchant.chk_enchantDefenceFail:getClickTexture())
    else
      self._ui_enchant.chk_enchantDefenceFail:setRenderTexture(self._ui_enchant.chk_enchantDefenceFail:getBaseTexture())
    end
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._defenceFailChecked = enduranceDesc .. self:getStr_EnchantDefenceFailInfo(isAccessory, isKarazardAccessory, isItemSkillOption, self._isSafeLowProtectorItem)
  end
end
function PaGlobal_SpiritEnchant_All:setCronEnchant()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  local cur_MaxEndura = self._enchantInfo:ToClient_getCurMaxEndura()
  local dec_MaxEndura = self._enchantInfo:ToClient_getDecMaxEndura()
  local useCron = true
  if _ContentsGroup_UseCronToStacklessBlackStoneItemType == false then
    useCron = itemWrapper:getStaticStatus():isNeedStackLessBlackStonForEnchant() == false
  end
  if (enchantLevel > 16 or 4 == enchantItemClassify) and useCron == true and toInt64(0, 0) < self._enchantInfo:ToClient_getNeedCountForProtect_s64() and false == self._isSetNewPerfectItemMaterial then
    self._ui_enchant.chk_enchantCron:SetIgnore(false)
    self._ui_enchant.chk_enchantCron:SetMonoTone(false)
    self._ui_enchant.stc_wingTop:SetShow(true)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(true)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(true)
    self._isShow_cronEnchant = true
    self:setText_NumOfCron(self._enchantInfo:ToClient_getCountProtecMaterial_s64(), self._enchantInfo:ToClient_getNeedCountForProtect_s64())
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._cronChecked = enduranceDesc .. self:getStr_EnchantProtectInfo(enchantType)
  else
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self._isShow_cronEnchant = false
    self:setText_NumOfCron(0, 0)
  end
end
function PaGlobal_SpiritEnchant_All:setProtectCronEnchant()
  self._ui_enchant.stc_wingBottom:SetShow(true)
end
function PaGlobal_SpiritEnchant_All:setButtonAlign()
  local isButtonShow = {
    self._isShow_perfectEnchant,
    self._isShow_forceEnchant
  }
  local count = 0
  for ii = 1, 3 do
    if isButtonShow[ii] then
      count = count + 1
    end
  end
  if 0 == count then
    return
  end
  if self._isShow_perfectEnchant then
    count = count + 1
  end
  local standardSizeX = (580 - 5 * (count - 1)) / count
  local standardSizeY = 0
  if false == _ContentsGroup_EnchantRenewer then
    standardSizeY = self._ui_enchant.stc_buttonArea:GetSizeY()
  else
    standardSizeY = self._ui_enchant.radio_enchantNormal:GetSizeY()
  end
  local standardPosX = self._ui_enchant.radio_enchantNormal:GetPosX()
  self._ui_enchant.radio_enchantNormal:SetSize(standardSizeX, standardSizeY)
  self._ui_enchant.radio_enchantPerfect:SetSize(standardSizeX, standardSizeY)
  self._ui_enchant.chk_enchantForce:SetSize(standardSizeX, standardSizeY)
  if self._isShow_perfectEnchant then
    self._ui_enchant.radio_enchantNormal:SetPosX(standardPosX)
    self._ui_enchant.radio_enchantPerfect:SetPosX(self._ui_enchant.radio_enchantNormal:GetPosX() + standardSizeX + 5)
    self._ui_enchant.chk_enchantForce:SetPosX(self._ui_enchant.radio_enchantPerfect:GetPosX() + standardSizeX + 5)
  elseif not self._isShow_forceEnchant then
  else
    self._ui_enchant.chk_enchantForce:SetPosX(standardPosX)
  end
end
function PaGlobal_SpiritEnchant_All:setCheckEnchantInfo(isMonotone, isReload)
  if true == isMonotone then
    return
  end
  if self._isSafeLowProtectorItem == false then
    if nil == self._materialItemSlotNo or nil == self._materialItemWhereType then
      if false == self:isLightStoneEnchant() then
        self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
      end
      return
    end
    if 0 ~= self._enchantInfo:ToClient_setEnchantSlot(self._materialItemWhereType, self._materialItemSlotNo) and true ~= isReload then
      return
    end
  end
  if nil == self._enchantInfo or nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETEQUIPMENT"))
    self._ui_enchant.txt_enchantDesc:SetText("")
    return
  end
  if true == self._isSetNewPerfectItemMaterial then
    if 0 < self._enchantInfo:ToClient_getDecMaxEnduraNewPerfect() then
      local str = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT_PENALTY", "maxEndurance", tostring(self._enchantInfo:ToClient_getDecMaxEnduraNewPerfect()), "currentEndurance", tostring(self._enchantInfo:ToClient_getCurMaxEndura()))
      self._ui_enchant.stc_noticeBar:SetText(str)
    else
      self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT"))
    end
    self._ui_enchant.txt_enchantDesc:SetText("")
    self:showEnchantDifficulty()
  else
    self:setText_EnchantInfo()
  end
  if isReload then
    return
  end
  local itemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
  self:setItemToSlot(self._slotMateiralInfo[1], self._materialItemSlotNo, itemWrapper, self._materialItemWhereType)
end
function PaGlobal_SpiritEnchant_All:setText_EnchantInfo()
  if self._isAdventureEnchant == true then
    self._ui_enchant.stc_noticeBar:SetText("")
    return
  end
  if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() then
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._forcedChecked)
  elseif true == self._isShow_cronEnchant and true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._cronChecked)
  elseif true == self._isShow_defenceFailEnchant and true == self._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._defenceFailChecked)
  else
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._notChecked)
  end
  if (nil == self._materialItemSlotNo or nil == self._materialItemWhereType or 0 == self._slotMateiralInfo[1].slotNo or __eTInventorySlotNoUndefined == self._slotMateiralInfo[1].inventoryType) and self._isSafeLowProtectorItem == false then
    self._ui_enchant.stc_noticeBar:SetText(self._ui_enchant.stc_noticeBar:GetText() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
  end
  local textSizeY = self._ui_enchant.stc_noticeBar:GetTextSizeY()
  local gabY = 10
  if self._originEnchnatNoticeBgSizeY < textSizeY + gabY then
    local addSizeY = textSizeY + gabY - self._originEnchnatNoticeBgSizeY
    self._ui_enchant.stc_noticeBar:SetSize(self._ui_enchant.stc_noticeBar:GetSizeX(), self._originEnchnatNoticeBgSizeY + addSizeY)
    self._ui_enchant.stc_noticeBar:SetPosY(self._originEnchnatNoticeBgPosY - addSizeY)
  else
    self._ui_enchant.stc_noticeBar:SetSize(self._ui_enchant.stc_noticeBar:GetSizeX(), self._originEnchnatNoticeBgSizeY)
    self._ui_enchant.stc_noticeBar:SetPosY(self._originEnchnatNoticeBgPosY)
  end
  self:setText_EnchantKindDesc()
end
function PaGlobal_SpiritEnchant_All:setText_EnchantKindDesc()
  if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() then
    self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTDESC"))
  elseif true == self._isShow_cronEnchant and true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_SAFTYENCHANTDESC"))
  elseif true == self._isShow_defenceFailEnchant and true == self._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    local itemWrapper = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSS = itemWrapper:getStaticStatus()
      if nil ~= itemSS then
        local itemClassify = itemSS:getItemClassify()
        local isSpecialEnchantItem = itemSS:isSpecialEnchantItem()
        local isKarazardAccessory = itemSS:isKarazardAccessory() == true
        local isItemSkillOption = itemSS:getContentsEventType() == __eContentsType_ItemSkillOption
        if self._isSafeLowProtectorItem == true then
          local protectorItemStaticWrapper = itemWrapper:getStaticStatus():getProtectorItem()
          local percent = 0
          if protectorItemStaticWrapper ~= nil and protectorItemStaticWrapper:isSafeLowProtectorItem() == true then
            percent = protectorItemStaticWrapper:getContentsEventParam1() / 10000
          end
          if isKarazardAccessory == true then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_SAFE_2", "param1", percent))
          elseif isItemSkillOption == true then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_SAFE_1", "param1", percent))
          elseif 4 == itemClassify and false == isSpecialEnchantItem then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_SAFE_2", "param1", percent))
          else
            self._ui_enchant.txt_enchantDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_SAFE_1", "param1", percent))
          end
        elseif isKarazardAccessory == true then
          self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE_5"))
        elseif isItemSkillOption == true then
          self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE_4"))
        elseif 4 == itemClassify and false == isSpecialEnchantItem then
          self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE2"))
        else
          local protectorItemKey = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCrystalProtectorItemKey()
          if protectorItemKey == 761801 then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE_6"))
          elseif protectorItemKey == 761802 then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE_7"))
          elseif protectorItemKey == 761803 then
            self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE_8"))
          else
            self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_SAFE"))
          end
        end
      end
    end
  elseif true == self._isShow_perfectEnchant then
    if true == self._ui_enchant.radio_enchantNormal:IsCheck() then
      self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_DESC"))
    elseif true == self._ui_enchant.radio_enchantPerfect:IsCheck() then
      self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_DESC"))
    end
  else
    self._ui_enchant.txt_enchantDesc:SetText("")
  end
  self:resizePanel()
  self:showEnchantDifficulty()
end
function PaGlobal_SpiritEnchant_All:CheckEnchantCheckbox(flag)
  if nil == flag then
    return
  end
  if 1 == flag then
    self._ui_enchant.chk_enchantCron:SetCheck(false)
    self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    if self._ui_enchant.radio_enchantPerfect:GetShow() then
      self._ui_enchant.radio_enchantPerfect:SetCheck(false)
      self._ui_enchant.radio_enchantNormal:SetCheck(false)
    end
    if false == self._ui_enchant.chk_enchantForce:IsCheck() then
      HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()
      if false == self._isEnchantPerfect then
        self._ui_enchant.radio_enchantPerfect:SetCheck(false)
        self._ui_enchant.radio_enchantNormal:SetCheck(true)
      else
        self._ui_enchant.radio_enchantPerfect:SetCheck(true)
        self._ui_enchant.radio_enchantNormal:SetCheck(false)
      end
    end
    self:setHasMaterialItem()
    self:didsetEnchantTarget(true, nil)
    self:setText_EnchantInfo()
    self:resizePanel()
  elseif 2 == flag or 3 == falg then
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    local isCronCheck = self._ui_enchant.chk_enchantCron:IsCheck()
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBoolNoSave(__eCheckCronEnchant, isCronCheck)
  end
  if true == self:isLightStoneEnchant() then
    self:updateLightStoneCronSlot()
    return false
  end
  if flag ~= 3 and (nil == self._materialItemWhereType or nil == self._materialItemSlotNo) then
    return false
  end
  self:setHasMaterialItem()
  return true
end
function PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetCheck(false)
end
function PaGlobal_SpiritEnchant_All:setText_NumOfCron(cnt, needCnt)
  local currentNeedPerfectItemSSW = getInventoryItemByType(self._enchantInfo:ToClient_getCronItemWhereType(), self._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if cnt ~= 0 and needCnt ~= 0 and cnt < needCnt then
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, true)
    self._ui_enchant.stc_wingsInfo[2].count:SetText("<PAColor0xffff7383>" .. tostring(cnt) .. "<PAOldColor>")
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true)
    self._ui_enchant.chk_enchantCron:SetCheck(false)
  elseif true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, false)
    self._ui_enchant.stc_wingsInfo[2].count:SetText("<PAColor0xFF0FBFFF>" .. tostring(cnt) .. "<PAOldColor>")
  else
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, true)
    self._ui_enchant.stc_wingsInfo[2].count:SetText(tostring(cnt))
  end
  if nil ~= currentPerfectSS then
    self._slotMateiralInfo[2]:setItemByStaticStatus(currentPerfectSS, needCnt)
  end
end
function PaGlobal_SpiritEnchant_All:setAsEnchantButton()
  if false == self._isConsole then
    self._ui_pc.btn_enchantGo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
  else
    self._ui_console.stc_enchantGoY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
    self._ui_console.stc_enchantGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  if true == self._isAnimating then
    return false
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return false
  end
  local rv = false
  if true == _ContentsGroup_EnchantLightStone then
    if true == itemWrapper:isLightStone() then
      rv = self:setLightStoneEnchantTarget(slotNo, itemWrapper, inventoryType)
    else
      rv = self:setEnchantTargetXXX(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
    end
  else
    rv = self:setEnchantTargetXXX(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  end
  return rv
end
function PaGlobal_SpiritEnchant_All:setEnchantTargetXXX(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  self:clearEnchantSlot()
  self:init_EnchantFrame()
  self._isLastEnchant = false
  self._isMaterialSlotMonotone = false
  self._isMaxStackEnchant = false
  self._isAdventureEnchant = false
  local resultItemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local itemSSW, enchantLevel
  if nil ~= resultItemWrapper then
    itemSSW = resultItemWrapper:getStaticStatus()
    enchantLevel = itemSSW:get()._key:getEnchantLevel()
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  if 0 ~= self._enchantInfo:ToClient_setEnchantSlot(inventoryType, slotNo) then
    self._isAbleEnchant = false
    self._ui_pc.btn_enchantGo:SetMonoTone(true)
    return false
  end
  self:setItemToSlot(self._slotEquip.slot, slotNo, itemWrapper, inventoryType, enchantLevel)
  self._grantItemSlotNo = slotNo
  self._grantItemWhereType = inventoryType
  if _ContentsGroup_AdventureMode == true then
    self._ui_enchant.stc_blackSpiritCount:SetShow(false)
    if resultItemWrapper:getSSEnchantCount() ~= 0 then
      local ssEnchantCount = resultItemWrapper:getSSEnchantCount()
      local currentEnchantCount = resultItemWrapper:getCurrentEnchantCount()
      self._ui_enchant.stc_blackSpiritCount:SetShow(true)
      self._ui_enchant.stc_blackSpiritCount:EraseAllEffect()
      self._ui_enchant.stc_blackSpiritCount:AddEffect("fUI_SpiritEnchant_Spirit_Success_01A_Super", false, 0, 0)
      self._ui_enchant.progress2_1:SetProgressRate(currentEnchantCount / ssEnchantCount * 100)
      self._ui_enchant.progress2_1:SetIgnore(false)
      self._ui_enchant.txt_count:SetText(tostring(currentEnchantCount) .. " / " .. tostring(ssEnchantCount))
      if ssEnchantCount <= currentEnchantCount then
        self._isAdventureEnchant = true
        self._ui_enchant.stc_blackSpiritCount:AddEffect("fUI_SpiritEnchant_Spirit_Box_01A_Super", true, 0, 0)
      end
    end
  end
  local canReq = self._enchantInfo:ToClient_hasMostStackCount()
  self._ui_enchant.btn_showTriedStack:SetShow(canReq)
  if canReq == true and ToClient_getGameUIManagerWrapper() ~= nil then
    if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eShowOtherUserEnchantAdditionalRate) == false then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    end
    local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
    if self._isGroupEnchantPartyMember == true or self._isLeaderGroupEnchantMode == true then
      showOtherUserEnchantAdditionalRate = false
    end
    if showOtherUserEnchantAdditionalRate == true then
      PaGlobal_SpiritEnchant_All_ReqMostTriedStack()
      if true == PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:GetShow() then
        PaGlobal_SpiritEnchant_All._ui_enchant.btn_showTriedStack:EraseAllEffect()
      end
    else
      PaGlobal_SpiritEnchant_All_ButtonEffect_On()
    end
  end
  local function ResetMaterial()
    self._grantItemSlotNo = slotNo
    self._grantItemWhereType = inventoryType
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isSetNewPerfectItemMaterial = false
    self:clearItemSlot(self._slotMateiralInfo[1])
    self:clearItemSlot(self._slotMateiralInfo[2])
    self:clearItemSlot(self._slotMateiralInfo[3])
    self:didsetEnchantTarget(true, nil)
    Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  end
  if nil ~= resultType and 0 == resultType then
    if 15 == enchantLevel then
      ResetMaterial()
      return true
    end
    if 18 == enchantLevel and __eSeasonItemTypeUseSeasonCharacter == itemSSW:getSeasonItemType() then
      ResetMaterial()
      return true
    end
  end
  local equipType = itemWrapper:getStaticStatus():getItemClassify()
  local currentItemSSW = itemWrapper:getStaticStatus()
  local currentEnchantLevel = currentItemSSW:get()._key:getEnchantLevel()
  local isMaterialInit = false
  local isStackMaterial = false
  local materialItemWrapper
  if nil ~= self._materialItemWhereType and nil ~= self._materialItemSlotNo then
    materialItemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
  end
  if nil ~= materialItemWrapper then
    isStackMaterial = materialItemWrapper:getStaticStatus():isStackable()
  else
    isMonotone = true
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == equipType and false == isStackMaterial then
    isMonotone = true
  end
  if true == isMonotone then
    self._prevMaterialSlotNo = nil
    self._currMaterialSlotNo = nil
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isSetNewPerfectItemMaterial = false
    self:setHasMaterialItem()
  end
  self:didsetEnchantTarget(isMonotone, nil)
  self:showEnchantDifficulty()
  self:BlablaShow(false)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  if true == _ContentsGroup_EnchantRenewer then
    if nil ~= PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate then
      PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
    end
    if nil ~= PaGloabl_AddStack_All_close then
      PaGloabl_AddStack_All_close()
    end
  end
  return true
end
function PaGlobal_SpiritEnchant_All:setLightStoneEnchantTarget(slotNo, itemWrapper, inventoryType)
  if false == _ContentsGroup_EnchantLightStone then
    return false
  end
  if false == itemWrapper:isLightStone() then
    return false
  end
  self:clearLightStoneEnchantSlot()
  local rv = ToClient_setLightStoneEnchantInfo(__eLightStoneEnchantInfo_MainItem, inventoryType, slotNo)
  if 0 ~= rv then
    return false
  end
  local control = self._ui_enchant.lightStoneControlList[LightStoneControlType.Main]
  self:setItemToSlot(control.slot, slotNo, itemWrapper, inventoryType)
  control.empty:SetShow(false)
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_SETLIGHTSTONE_1"))
  self:updateLightStoneCronSlot()
  self:updateLightStoneEnchantRate()
  PaGlobal_SpiritEnchant_All_SetAdditionalEnchantRate()
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  return true
end
function PaGlobal_SpiritEnchant_All:BlablaShow(isShow)
  if true == isShow then
    HandleEventLUp_SpiritEnchant_All_RandomBlabla()
  end
  self._ui_enchant.stc_blablaBg:SetShow(isShow)
  self._ui_enchant.txt_blablaText:SetShow(false)
end
function PaGlobal_SpiritEnchant_All:setHasMaterialItem()
  if nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    return
  end
  local inventoryType = self._enchantInfo:ToClient_getNeedItemWhereType()
  local slotNo = self._enchantInfo:ToClient_getNeedItemSlotNo()
  if nil ~= self._prevMaterialSlotNo and nil ~= self._currMaterialSlotNo and self._currMaterialSlotNo ~= self._prevMaterialSlotNo then
    self._prevMaterialSlotNo = nil
    self._currMaterialSlotNo = nil
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isMaterialSlotMonotone = false
    self:setNeedEnchantMaterial()
    self:setProtectorItems()
    return
  end
  self._prevMaterialSlotNo = slotNo
  local itemWrapper2 = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
  if itemWrapper2 ~= nil then
    local protectorItemStaticWrapper = itemWrapper2:getStaticStatus():getProtectorItem()
    if protectorItemStaticWrapper ~= nil and self._ui_enchant.chk_enchantDefenceFail:IsCheck() == true and protectorItemStaticWrapper:isSafeLowProtectorItem() == true then
      itemWrapper = nil
      self._materialItemSlotNo = nil
      self._materialItemWhereType = nil
    end
  end
  if nil ~= self._materialItemSlotNo then
    slotNo = self._materialItemSlotNo
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  self._isMaterialSlotMonotone = false
  if itemWrapper == nil or self._isSafeLowProtectorItem == true then
    local enchantItemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= enchantItemWrapper then
      local itemSSW = enchantItemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local enchantAble = true
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if itemSSW:isSpecialAccessory() == true then
          if enchantLevel == 10 then
            enchantAble = false
          end
        elseif 5 == enchantLevel then
          enchantAble = false
        end
      elseif 20 == enchantLevel then
        enchantAble = false
      end
      if true == enchantAble then
        local needItemCount = enchantItemWrapper:getNeedEnchantItem(false)
        self._materialNeedCount = Int64toInt32(needItemCount)
      else
        self:BlablaShow(false)
      end
    end
    self:setNeedEnchantMaterial()
    self:setProtectorItems()
    if self._isSafeLowProtectorItem == true then
      self._isAbleEnchant = true
      self._ui_pc.btn_enchantGo:SetMonoTone(false)
      self._ui_pc.btn_enchantGo:SetIgnore(false)
      self:didsetEnchantTarget(false)
      self:setCheckEnchantInfo(false)
    end
    return
  end
  self:setMaterialItem(slotNo, itemWrapper, inventoryType)
  if PaGlobal_SpiritEnchant_All._isGroupEnchantReady == true then
    ToClient_RequestGroupEnchantItemSetCancel()
    return
  end
end
function PaGlobal_SpiritEnchant_All:setNeedEnchantMaterial()
  if nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    return
  end
  self:setItemToSlotMonoTone(self._slotMateiralInfo[1], self._enchantInfo:ToClient_getNeedItemStaticInformation(), true)
  local needCountForPerfectEnchant_s64 = self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64()
  if self._isShow_forceEnchant and self._ui_enchant.chk_enchantForce:IsCheck() and needCountForPerfectEnchant_s64 > toInt64(0, 0) then
    self._slotMateiralInfo[1]:setItemByStaticStatus(self._enchantInfo:ToClient_getNeedItemStaticInformation(), self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64())
  else
    self._slotMateiralInfo[1]:setItemByStaticStatus(self._enchantInfo:ToClient_getNeedItemStaticInformation(), self._materialNeedCount)
  end
  self._ui_enchant.stc_noticeBar:SetShow(true)
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._enchantInfo:materialClearData()
end
function PaGlobal_SpiritEnchant_All:setMaterialItem(slotNo, itemWrapper, inventoryType)
  if true == self._isAnimating then
    return
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return
  end
  self:setNeedEnchantMaterial()
  self:clearItemSlot(self._slotMateiralInfo[1])
  if slotNo == self._enchantInfo:ToClient_getNeedNewPerfectItemSlotNo() and inventoryType == self._enchantInfo:ToClient_getNeedNewPerfectItemWhereType() then
    self._isSetNewPerfectItemMaterial = true
  else
    self._isSetNewPerfectItemMaterial = false
  end
  self:setItemToSlot(self._slotMateiralInfo[1], slotNo, itemWrapper, inventoryType)
  if self._materialNeedCount > Int64toInt32(itemWrapper:get():getCount_s64()) then
    self:setProtectorItems()
    return
  end
  self._isAbleEnchant = true
  self._materialItemSlotNo = slotNo
  self._materialItemWhereType = inventoryType
  self._ui_pc.btn_enchantGo:SetMonoTone(false)
  self._ui_pc.btn_enchantGo:SetIgnore(false)
  self:setProtectorItems()
  self:didsetEnchantTarget(false)
  self:setCheckEnchantInfo(false)
end
function PaGlobal_SpiritEnchant_All:getStr_EnchantInfo(curMaxEndura, decEndura, enchantType, isChecked)
  local str = ""
  if enchantType == self._enum_EnchantType._safe then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT")
  else
    if true == self._isShow_perfectEnchant and true == self._ui_enchant.radio_enchantPerfect:IsCheck() then
      decEndura = decEndura * 0.8
    end
    local itemWrapper = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == ToClient_IsDeadGodEquip(itemSSW:get()._key:getItemKey())
      if false == isAccessory and 25 ~= enchantLevel then
        str = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_0", "maxEndurance", tostring(decEndura), "currentEndurance", tostring(curMaxEndura))
      end
      if nil == isChecked then
        if enchantType == self._enum_EnchantType._downAndBroken then
          if "" == str then
            str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1")
          else
            str = str .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1")
          end
        elseif enchantType == self._enum_EnchantType._broken then
          str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1")
        end
        if enchantType == self._enum_EnchantType._gradedown or enchantType == self._enum_EnchantType._downAndBroken then
          if "" == str then
            str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3")
          else
            str = str .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3")
          end
        end
      end
      if 25 == enchantLevel then
        str = ""
      end
    end
  end
  return str
end
function PaGlobal_SpiritEnchant_All:getStr_EnchantProtectInfo(enchantType, equipType)
  if enchantType == self._enum_EnchantType._broken or enchantType == self._enum_EnchantType._downAndBroken then
    if CppEnums.ItemClassifyType.eItemClassify_Accessory == equipType then
      return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
    else
      return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
    end
  else
    return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
  end
end
function PaGlobal_SpiritEnchant_All:getStr_EnchantDefenceFailInfo(isAccessory, isKarazardAccessory, isItemSkillOption, isSafeLowProtectorItem)
  local str = ""
  if isSafeLowProtectorItem == true then
    if isAccessory == true then
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_PENALTY_2")
    else
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_PENALTY_1")
    end
  elseif true == isAccessory then
    if isKarazardAccessory == true then
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_5")
    else
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY3")
    end
  elseif isItemSkillOption == true then
    str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_4")
  else
    local protectorItemKey = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCrystalProtectorItemKey()
    if protectorItemKey == 761801 then
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_6")
    elseif protectorItemKey == 761802 then
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_7")
    elseif protectorItemKey == 761803 then
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_8")
    else
      str = "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY")
    end
  end
  return str
end
function PaGlobal_SpiritEnchant_All:getStr_PerfectEnchantInfo(needCount, decEndura)
  local needItemWrapper = self._enchantInfo:ToClient_getNeedItemStaticInformation()
  local needItemName = ""
  if nil ~= needItemWrapper then
    needItemName = needItemWrapper:getName()
  end
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    if enchantLevel > 14 then
      return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT") .. "\n" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_PERFECTE_PANALTY", "ItemName", tostring(needItemName), "count", tostring(needCount), "endurance", tostring(decEndura))
    end
  end
  return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT") .. "\n" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_PERFECTE_PANALTY", "ItemName", tostring(needItemName), "count", tostring(needCount), "endurance", tostring(decEndura))
end
function PaGlobal_SpiritEnchant_All:enchantApplyButton()
  local goEnchant = function()
    PaGlobal_SpiritEnchant_All:willStartEnchant()
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
  if self._isAdventureEnchant == true then
    goEnchant()
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
function PaGlobal_SpiritEnchant_All:cancleEnchant()
  self._isAnimating = false
  if nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(false)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(false)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(false)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(false)
  end
  if true == self:isLightStoneEnchant() then
    self:removeLightStoneEnchantEffect()
    self._ui_enchant.chk_enchantCron:SetIgnore(false)
  else
    self:removeEnchantEffect()
  end
  self:setAsEnchantButton()
  self._ui_enchant.radio_enchantNormal:SetIgnore(false)
  self._ui_enchant.radio_enchantPerfect:SetIgnore(false)
  self._ui_enchant.chk_enchantForce:SetIgnore(false)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  if nil ~= self._grantItemWhereType and nil ~= self._grantItemSlotNo then
    local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil ~= itemSSW then
        local enchantLevel = itemSSW:get()._key:getEnchantLevel()
        self:setItemEnchantLevelEffect(self._slotEquip.slot, itemWrapper, enchantLevel)
        self:setProtectorItems(true)
      end
    end
  end
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  ToClient_BlackspiritEnchantCancel()
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_EnchantCancel)
end
function PaGlobal_SpiritEnchant_All:removeEnchantEffect()
  if nil ~= self._slotEquip.slot then
    self._slotEquip.slot.icon:EraseAllEffect()
  end
  if nil ~= self._slotMateiralInfo[1] then
    self._slotMateiralInfo[1].icon:EraseAllEffect()
  end
  if nil ~= self._slotMateiralInfo[2] then
    self._slotMateiralInfo[2].icon:EraseAllEffect()
  end
  if nil ~= self._slotMateiralInfo[3] then
    self._slotMateiralInfo[3].icon:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_wingTop then
    self._ui_enchant.stc_wingTop:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_wingBottom then
    self._ui_enchant.stc_wingBottom:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_blackSpiritCountBG then
    self._ui_enchant.stc_blackSpiritCountBG:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_blackSpiritCount then
    self._ui_enchant.stc_blackSpiritCount:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_iamge then
    self._ui_enchant.stc_image:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_equipSlot then
    self._ui_enchant.stc_equipSlot:EraseAllEffect()
  end
  if true == self._isClickCancle then
    self._ui_enchant.stc_image:EraseAllEffect()
    self._isClickCancle = false
  end
end
function PaGlobal_SpiritEnchant_All:removeLightStoneEnchantEffect()
  for ii = LightStoneControlType.Main, LightStoneControlType.Cron do
    local control = self._ui_enchant.lightStoneControlList[ii]
    control.parent:EraseAllEffect()
    control.slot.icon:EraseAllEffect()
  end
  self._ui_enchant.stc_lightStoneImage:EraseAllEffect()
  self._isClickCancle = false
end
function PaGlobal_SpiritEnchant_All:willStartEnchant()
  if true == self._ui_enchant.chk_enchantCron:IsCheck() then
    if self._isAdventureEnchant == false and self._enchantInfo:ToClient_setPreventDownGradeItem() ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
      return
    end
  elseif true == self._ui_enchant.chk_enchantDefenceFail:GetShow() and true == self._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    if self._enchantInfo:ToClient_setProtectorItem() ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
      return
    end
  else
    self._enchantInfo:ToClient_clearPreventDownGradeItem()
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  if false == self._ui_enchant.chk_skipAni:IsCheck() then
    self:startEnchantAnimation()
  else
    self:startEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:startEnchantAnimation()
  if true == self:isLightStoneEnchant() then
    self:addLightStoneEnchantEffect()
  else
    self:addEnchantEffect()
  end
  self:setAsCancelButton()
  ToClient_BlackspiritEnchantStart()
  self._animationTimeStamp = 0
  self._isAnimating = true
  if nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(true)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(true)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(true)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(true)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(true)
  end
  ToClient_StartLedDeviceAnimation(7)
  local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_RequestSpiritEnchantRecord(isCheckCron, 1)
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_AnimationStart)
end
function PaGlobal_SpiritEnchant_All:startEnchant()
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  local function isDifficulty()
    if true == self._ui_enchant.chk_enchantForce:IsCheck() then
      return false
    end
    return self._ui_enchant.radio_enchantPerfect:IsCheck()
  end
  local function isProtector()
    if false == self._ui_enchant.chk_enchantDefenceFail:GetShow() then
      return false
    end
    return self._ui_enchant.chk_enchantDefenceFail:IsCheck()
  end
  local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_RequestSpiritEnchantRecord(isCheckCron, 2)
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_DoEnchant)
  self._enchantInfo:ToClient_doEnchant(self._ui_enchant.chk_enchantForce:IsCheck(), isDifficulty(), isProtector(), false)
  self._isWaitingServer = true
  self:cancleEnchant()
end
function PaGlobal_SpiritEnchant_All:startGroupEnchant()
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  ToClient_RequestGroupEnchantStart()
  self._isWaitingServer = true
  self:cancleEnchant()
end
function PaGlobal_SpiritEnchant_All:startLightStoneEnchant()
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  local isUseCron = self._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_requestEnchantLightStone(isUseCron)
  self._isWaitingServer = true
  self:cancleEnchant()
end
function PaGlobal_SpiritEnchant_All:addEnchantEffect()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isCronKey = itemSSW:getCronKey()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local isLastChallenge = false
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
    if enchantLevel >= 4 then
      isLastChallenge = true
    end
  elseif enchantLevel >= 19 then
    isLastChallenge = true
  end
  local audioIdx = 5
  local audioIdxB = self._audio._enchatNomal_idxB
  if true == isLastChallenge then
    local randomNum = math.random(1, 3)
    self._randomEffectNum = math.floor(randomNum)
    local randomEffect = self._enchantEffect[self._randomEffectNum]
    if nil == randomEffect then
      return
    end
    if self._isSafeLowProtectorItem == false then
      self._effectTime = randomEffect.effectTime
      self._ui_enchant.stc_image:AddEffect(randomEffect.effectName, true, 46, 3)
      self._slotMateiralInfo[1].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
    end
    audioIdxB = randomEffect.audioIndexB
  elseif self._isSafeLowProtectorItem == false then
    self._effectTime = self._originEffectTime
    self._ui_enchant.stc_image:AddEffect("fUI_SpiritEnchant_01A", true, 46, 3)
    self._slotMateiralInfo[1].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
  end
  if self._isAdventureEnchant == true then
    self._ui_enchant.stc_image:AddEffect("fUI_SpiritEnchant_01A_Super", false, 45, 3)
    self._ui_enchant.stc_equipSlot:AddEffect("fUI_SpiritEnchant_Box_Glow_01A_Super", false, 0, 0)
  end
  if true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._slotMateiralInfo[2].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
    self._ui_enchant.stc_wingTop:AddEffect("fUI_SpiritEnchant_ChroneStone_01A", true, 200, 16)
  end
  if true == self._ui_enchant.stc_wingBottom:GetShow() and true == self._ui_enchant.chk_enchantDefenceFail:IsCheck() then
    self._slotMateiralInfo[3].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
    if self._isSafeLowProtectorItem == true then
      self._ui_enchant.stc_wingBottom:AddEffect("fUI_SpiritEnchant_High_01B", true, 200, 16)
    else
      self._ui_enchant.stc_wingBottom:AddEffect("fUI_SpiritEnchant_ChroneStone_01B", true, 200, 16)
    end
  end
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  audioPostEvent_SystemUi(audioIdx, audioIdxB)
  _AudioPostEvent_SystemUiForXBOX(audioIdx, audioIdxB)
  self._startTime = self._effectTime - 1.5
end
function PaGlobal_SpiritEnchant_All:addLightStoneEnchantEffect()
  local audioIdx = 5
  local audioIdxB = self._audio._enchatNomal_idxB
  self._effectTime = self._originEffectTime
  self._startTime = self._effectTime - 1.5
  self._ui_enchant.stc_lightStoneImage:AddEffect("fUI_SpiritEnchant_01B", true, 46, 3)
  local subControl0 = self._ui_enchant.lightStoneControlList[LightStoneControlType.Sub0]
  local subControl1 = self._ui_enchant.lightStoneControlList[LightStoneControlType.Sub1]
  subControl0.slot.icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01B", true, 0, 0)
  subControl1.slot.icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01B", true, 0, 0)
  subControl1.parent:AddEffect("fUI_SpiritEnchant_ChroneStone_01B_Red", true, 248, -10)
  if true == self._ui_enchant.chk_enchantCron:IsCheck() then
    local control = self._ui_enchant.lightStoneControlList[LightStoneControlType.Cron]
    control.slot.icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01B", true, 0, 0)
    control.parent:AddEffect("fUI_SpiritEnchant_ChroneStone_01A_Red", true, 200, 16)
  end
  audioPostEvent_SystemUi(5, 36)
  _AudioPostEvent_SystemUiForXBOX(5, 36)
end
function PaGlobal_SpiritEnchant_All:enchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo, errorRv, isSafeLowProtectorItem)
  self._isWaitingServer = false
  if resultType == self._enum_EnchantResult._error then
    self._enchantFailureRv = errorRv
    ToClient_BlackspiritEnchantCancel()
    return
  end
  self._enchantFailureRv = 0
  self:showEnchantResultEffect(resultType)
  self:clearEnchantSlot()
  if false == self:setEnchantTarget(mainSlotNo, getInventoryItemByType(mainWhereType, mainSlotNo), mainWhereType, resultType, false) then
    local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
    local finalEnchantStr = ""
    self._isLastEnchant = false
    if true == _ContentsGroup_Caphras then
      finalEnchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FINALENCHANT")
    end
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if itemSSW:isSpecialAccessory() == true then
          if enchantLevel == 10 then
            self._ui_enchant.txt_enchantDesc:SetText("")
            self._isLastEnchant = true
          end
        elseif enchantLevel > 6 then
          if enchantLevel == 10 then
            self._ui_enchant.txt_enchantDesc:SetText("")
            self._isLastEnchant = true
          end
        elseif enchantLevel == 5 then
          self._ui_enchant.txt_enchantDesc:SetText("")
          self._isLastEnchant = true
        end
      elseif enchantLevel > 21 then
        if enchantLevel == 25 then
          self._ui_enchant.txt_enchantDesc:SetText(finalEnchantStr)
          self._isLastEnchant = true
        end
      elseif enchantLevel == 20 then
        local nextEnchantItemKey = ItemEnchantKey(itemSSW:get()._key:getItemKey(), enchantLevel + 1)
        local nextitemSSW = getItemEnchantStaticStatus(nextEnchantItemKey)
        if nextitemSSW == nil then
          self._ui_enchant.txt_enchantDesc:SetText(finalEnchantStr)
          self._isLastEnchant = true
        end
      end
      if false == itemWrapper:checkToUpgradeItem() then
        self._ui_enchant.txt_enchantDesc:SetText("")
      end
    end
    if true == self._isLastEnchant then
      self:setItemToSlot(self._slotEquip.slot, mainSlotNo, itemWrapper, mainWhereType)
      self._materialItemWhereType = nil
      self._materialItemSlotNo = nil
      self:clearItemSlot(self._slotMateiralInfo[2])
      self:clearItemSlot(self._slotMateiralInfo[3])
      self._ui_enchant.stc_wingTop:SetShow(false)
      self:showGuaranteeEnchantBG(false)
      Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
    else
      self:clearEnchantSlot()
      PaGlobal_SpiritEnchant_All:enchantTabOpen()
    end
  end
  local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
  if itemWrapper ~= nil and isSafeLowProtectorItem == true and self._isLastEnchant == false then
    local protectorItemStaticWrapper = itemWrapper:getStaticStatus():getProtectorItem()
    if protectorItemStaticWrapper ~= nil then
      if protectorItemStaticWrapper:isSafeLowProtectorItem() == false then
        self:clearEnchantSlot()
        PaGlobal_SpiritEnchant_All:enchantTabOpen()
      end
    else
      self:clearEnchantSlot()
      PaGlobal_SpiritEnchant_All:enchantTabOpen()
    end
  end
  if nil ~= self._prevMaterialSlotNo then
    self._currMaterialSlotNo = self._enchantInfo:ToClient_getNeedItemSlotNo()
  end
  self:setHasMaterialItem()
  self:showEnchantResultText(resultType, mainSlotNo, mainWhereType)
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:groupEnchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  self._isWaitingServer = false
  if resultType == self._enum_EnchantResult._error then
    ToClient_BlackspiritEnchantCancel()
    return
  end
  self:showEnchantResultEffect(resultType)
  self:clearEnchantSlot()
  if false == self:setEnchantTarget(mainSlotNo, getInventoryItemByType(mainWhereType, mainSlotNo), mainWhereType, resultType, false) then
    local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
    local finalEnchantStr = ""
    self._isLastEnchant = false
    if true == _ContentsGroup_Caphras then
      finalEnchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FINALENCHANT")
    end
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if itemSSW:isSpecialAccessory() == true then
          if enchantLevel == 10 then
            self._ui_enchant.txt_enchantDesc:SetText("")
            self._isLastEnchant = true
          end
        elseif enchantLevel > 6 then
          if enchantLevel == 10 then
            self._ui_enchant.txt_enchantDesc:SetText("")
            self._isLastEnchant = true
          end
        elseif enchantLevel == 5 then
          self._ui_enchant.txt_enchantDesc:SetText("")
          self._isLastEnchant = true
        end
      elseif enchantLevel > 21 then
        if enchantLevel == 25 then
          self._ui_enchant.txt_enchantDesc:SetText(finalEnchantStr)
          self._isLastEnchant = true
        end
      elseif enchantLevel == 20 then
        local nextEnchantItemKey = ItemEnchantKey(itemSSW:get()._key:getItemKey(), enchantLevel + 1)
        local nextitemSSW = getItemEnchantStaticStatus(nextEnchantItemKey)
        if nextitemSSW == nil then
          self._ui_enchant.txt_enchantDesc:SetText(finalEnchantStr)
          self._isLastEnchant = true
        end
      end
      if false == itemWrapper:checkToUpgradeItem() then
        self._ui_enchant.txt_enchantDesc:SetText("")
      end
    end
    if true == self._isLastEnchant then
      self:setItemToSlot(self._slotEquip.slot, mainSlotNo, itemWrapper, mainWhereType)
      self._materialItemWhereType = nil
      self._materialItemSlotNo = nil
      self:clearItemSlot(self._slotMateiralInfo[2])
      self:clearItemSlot(self._slotMateiralInfo[3])
      self._ui_enchant.stc_wingTop:SetShow(false)
      Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
    else
      self:clearEnchantSlot()
      PaGlobal_SpiritEnchant_All:enchantTabOpen()
    end
  end
  if nil ~= self._prevMaterialSlotNo then
    self._currMaterialSlotNo = self._enchantInfo:ToClient_getNeedItemSlotNo()
  end
  self:setHasMaterialItem()
  self:showEnchantResultText(resultType, mainSlotNo, mainWhereType)
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:showEnchantResultEffect(resultType)
  if resultType == self._enum_EnchantResult._success then
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    render_setChromaticBlur(40, 1)
    render_setPointBlur(0.05, 0.045)
    render_setColorBypass(0.85, 0.08)
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
    self:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_SUCCESSENCHANT"))
    ToClient_BlackspiritEnchantSuccess()
  else
    audioPostEvent_SystemUi(0, 7)
    _AudioPostEvent_SystemUiForXBOX(0, 7)
    if resultType == self._enum_EnchantResult._broken then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._gradedown then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._fail then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._failAndPrevent then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    end
    self:showEnchantResultNakMessage(false, PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_FAILENCHANT"))
    ToClient_BlackspiritEnchantCancel()
  end
  self:didsetEnchantTarget(false)
end
function PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(resultType, msg)
  if nil == resultType or nil == msg then
    return
  end
  self._nakAniTimeStamp = 0
  self._isNakAnimating = true
  self._ui_enchant.stc_resultNak:SetShow(true)
  self._ui_enchant.stc_resultNak:SetText(msg)
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY + self._ui_extraction.stc_subTabBg:GetSizeY())
  end
  if true == resultType then
    self._ui_enchant.stc_resultNak:ChangeTextureInfoNameAsync("combine/frame/combine_frame_noticebar_quest.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui_enchant.stc_resultNak, 0, 0, 210, 110)
    self._ui_enchant.stc_resultNak:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui_enchant.stc_resultNak:setRenderTexture(self._ui_enchant.stc_resultNak:getBaseTexture())
    self._ui_enchant.stc_resultNak:SetFontColor(Defines.Color.C_FFFFEDD4)
  else
    self._ui_enchant.stc_resultNak:ChangeTextureInfoNameAsync("combine/frame/combine_frame_noticebar_quest.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui_enchant.stc_resultNak, 0, 111, 210, 221)
    self._ui_enchant.stc_resultNak:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui_enchant.stc_resultNak:setRenderTexture(self._ui_enchant.stc_resultNak:getBaseTexture())
    self._ui_enchant.stc_resultNak:SetFontColor(Defines.Color.C_FFE0E0E0)
  end
  self._ui_enchant.stc_resultNak:ResetAndClearVertexAni()
  local startAniInfo = self._ui_enchant.stc_resultNak:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  startAniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  startAniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  startAniInfo.IsChangeChild = true
  local endAniInfo = self._ui_enchant.stc_resultNak:addColorAnimation(self._nakElapsedTime - 0.15, self._nakElapsedTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  endAniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  endAniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  endAniInfo.IsChangeChild = true
end
function PaGlobal_SpiritEnchant_All:stopEnchantResultNakMessage()
  self._ui_enchant.stc_resultNak:SetShow(false)
end
function PaGlobal_SpiritEnchant_All:showEnchantResultText(resultType, mainSlotNo, mainWhereType)
  self._ui_enchant.stc_noticeBar:SetShow(true)
  if resultType == self._enum_EnchantResult._success then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_0"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("UI_QustComplete01", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._fail then
    local resultMsg = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_1")
    local curEndurance = self._enchantInfo:ToClient_getCurMaxEndura()
    local currentEnduranceMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_RESULT_ENDURANCE", "curEndurance", curEndurance)
    self._ui_enchant.stc_noticeBar:SetText(resultMsg .. " " .. currentEnduranceMsg)
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._broken then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_2"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._gradedown then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_3"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._failAndPrevent then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_4"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  end
  self:showSuccessEffectByResult(resultType, mainSlotNo, mainWhereType)
end
function PaGlobal_SpiritEnchant_All:showSuccessEffectByResult(resultType, mainSlotNo, mainWhereType)
  if resultType == self._enum_EnchantResult._success then
    local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if 5 == enchantLevel then
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01C", false, 1.7, -4)
        elseif 4 == enchantLevel then
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01B", false, 1.7, -4)
        else
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01A", true, 1.7, -4)
        end
      elseif 20 == enchantLevel then
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01C", false, 1.7, -4)
      elseif 19 == enchantLevel then
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01B", false, 1.7, -4)
      else
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01A", true, 1.7, -4)
      end
    end
  else
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
  end
  if nil ~= self._materialItemWhereType and nil ~= self._materialItemSlotNo then
    local itemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
    if nil ~= itemWrapper and self._materialNeedCount <= Int64toInt32(itemWrapper:get():getCount_s64()) and false == self._isMaterialSlotMonotone then
      self._ui_pc.btn_enchantGo:SetMonoTone(false)
      self._ui_pc.btn_enchantGo:SetIgnore(false)
      if 0 == self._enchantInfo:ToClient_getCurMaxEndura() then
        self._isAbleEnchant = false
        self._ui_pc.btn_enchantGo:SetMonoTone(true)
        self._ui_pc.btn_enchantGo:SetIgnore(true)
      elseif true ~= self._isConsole then
        self._isAbleEnchant = true
      end
    else
      self._ui_pc.btn_enchantGo:SetMonoTone(true)
      self._ui_pc.btn_enchantGo:SetIgnore(true)
    end
  end
end
function PaGlobal_SpiritEnchant_All:setCheckFunc(ButtonName, isOn)
  if true == isRealServiceMode() then
    return false
  end
  if nil == Panel_Window_StackExtraction_All then
    return false
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return false
  end
  if "Cron" == ButtonName then
    if true == isOn and false == self._ui_enchant.chk_enchantCron:IsIgnore() and true == self._isShow_cronEnchant then
      self._ui_enchant.chk_enchantCron:SetCheck(isOn)
    elseif false == isOn then
      self._ui_enchant.chk_enchantCron:SetCheck(isOn)
    else
      return false
    end
  elseif "SkipAni" == ButtonName then
    self._ui_enchant.chk_skipAni:SetCheck(isOn)
  else
    self._ui_enchant.chk_enchantForce:SetCheck(inOn)
  end
  return true
end
function PaGlobal_SpiritEnchant_All:getCronCount()
  if true == isRealServiceMode() then
    return -1
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return -1
  end
  if toInt64(0, 0) <= enchantInfo:ToClient_getNeedCountForProtect_s64() then
    return Int64toInt32(enchantInfo:ToClient_getNeedCountForProtect_s64())
  end
  return -1
end
function PaGlobal_SpiritEnchant_All:getPerfectCount()
  if true == isRealServiceMode() then
    return -1
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return -1
  end
  if toInt64(0, 0) <= enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64() then
    return Int64toInt32(enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64())
  end
  return -1
end
function PaGlobal_SpiritEnchant_All:setMaxStackEnchant()
  if false == _ContentsGroup_MaxStackEnchant then
    self._ui_enchant.txt_maxEncahnt:SetShow(false)
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_On", "")
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_Out", "")
    return
  end
  local isSetMaxStackEncahnt = false
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    self._ui_enchant.txt_maxEncahnt:SetShow(false)
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_On", "")
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_Out", "")
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isMaxStackEnchant = false
  if nil ~= itemSSW then
    local maxStackCount = itemSSW:getMaxStackEnchant()
    if maxStackCount > 0 then
      self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_MaxStack(" .. tostring(maxStackCount) .. ")")
      self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_Out", "HandleEventOut_SpiritEnchant_All_MaxStack()")
      self._ui_enchant.txt_maxEncahnt:SetShow(true)
      local rate = ToClient_getEnchantSuccessRate(self._ui_enchant.chk_enchantForce:IsCheck(), self._ui_enchant.radio_enchantPerfect:IsCheck(), __eEnchantFailCountSlotNo_Undefined, 0, 0, false)
      if CppDefine.e100Percent == rate then
        isMaxStackEnchant = true
        self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT"))
        self._ui_enchant.txt_enchantDesc:SetText("")
      end
    end
  end
  if true == isMaxStackEnchant then
    self._isShow_cronEnchant = false
    self._isShow_forceEnchant = false
    self._isShow_perfectEnchant = false
    self._isShow_defenceFailEnchant = false
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self:setText_NumOfCron(0, 0)
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._ui_enchant.radio_enchantPerfect:SetShow(false)
    self._ui_enchant.radio_enchantNormal:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetShow(false)
    self._ui_enchant.chk_enchantDefenceFail:SetCheck(false)
    ToClient_SpiritEnchantRecord_SetCheckHammer(false, __eSpiritEnchantRecordHammerType_ResetUI)
    self._ui_enchant.stc_wingBottom:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[3].count:SetShow(false)
    self._isMaxStackEnchant = true
  else
    self._ui_enchant.txt_maxEncahnt:SetShow(false)
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_On", "")
    self._ui_enchant.txt_maxEncahnt:addInputEvent("Mouse_Out", "")
    self._isMaxStackEnchant = false
  end
end
function PaGlobal_SpiritEnchant_All:retargetUI()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  self:setEnchantTarget(self._grantItemSlotNo, itemWrapper, self._grantItemWhereType, nil, true)
end
function PaGlobal_SpiritEnchant_All:isLightStoneEnchant()
  if false == _ContentsGroup_EnchantLightStone then
    return false
  end
  return self._ui_enchant.stc_lightStoneImage:GetShow()
end
function PaGlobal_SpiritEnchant_All:isGroupEnchant()
  if false == _ContentsGroup_SpiritGroupEnchant then
    return false
  end
  return ToClient_IsGroupEnchantAble()
end
function FromClinet_responseEnchantLightStone(itemEnchantKeyRaw, itemWhereType, result)
  local self = PaGlobal_SpiritEnchant_All
  self._isWaitingServer = false
  self._isStart = false
  FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
  if __eLightStoneEnchantResult_Success == result then
    self:lightStoneEnchantSuccess(itemEnchantKeyRaw, itemWhereType)
  else
    self:lightStoneEnchantFail(itemEnchantKeyRaw, itemWhereType, result)
  end
end
function PaGlobal_SpiritEnchant_All:getAdditionalRate()
  local rate = 0
  if true == self:isLightStoneEnchant() then
    rate = self:getLightStoneAdditionalRate()
  else
    rate = self:getAdditionalRateXXX()
  end
  return rate
end
function PaGlobal_SpiritEnchant_All:getAdditionalRateXXX()
  local failCount = self._enchantInfo:ToClient_getFailCount() * -1
  local valksCount = self._enchantInfo:ToClient_getValksCount() * -1
  local currentRate = ToClient_getEnchantSuccessRate(false, false, __eEnchantFailCountSlotNo_Undefined, 0, 0, false)
  local addedRate = ToClient_getEnchantSuccessRate(false, false, __eEnchantFailCountSlotNo_Undefined, failCount, valksCount, false)
  return currentRate - addedRate
end
function PaGlobal_SpiritEnchant_All:getLightStoneAdditionalRate()
  local enchantWrapper = ToClient_getLightStoneEnchantGroupStaticStatusWrapper()
  if nil == enchantWrapper then
    return 0
  end
  local currentPct = enchantWrapper:calculatedSuccessPercent(0)
  local enchantFailCount = getSelfPlayer():get():getEnchantFailCount()
  local enchantValuePackCount = getSelfPlayer():get():getEnchantValuePackCount()
  local sumStack = enchantFailCount + enchantValuePackCount
  local realPct = enchantWrapper:calculatedSuccessPercent(sumStack)
  return realPct - currentPct
end
function PaGlobal_SpiritEnchant_All:updateLightStoneCronSlot()
  local cronKey = ToClient_getCronItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(cronKey)
  if nil == itemSSW then
    return
  end
  local enchantWrapper = ToClient_getLightStoneEnchantGroupStaticStatusWrapper()
  if nil == enchantWrapper then
    return false
  end
  local needCount = enchantWrapper:getNeedCronCount()
  local control = self._ui_enchant.lightStoneControlList[LightStoneControlType.Cron]
  control.empty:SetShow(false)
  local myCronCount = ToClient_getSelfPlayerCronItemCount()
  local isMonotone = false
  local txt_cronCount = ""
  local isUseCron = self._ui_enchant.chk_enchantCron:IsCheck()
  if needCount > myCronCount then
    isMonotone = true
    txt_cronCount = "<PAColor0xffff7383>" .. tostring(myCronCount) .. "<PAOldColor>"
  elseif true == isUseCron then
    isMonotone = false
    txt_cronCount = "<PAColor0xFF0FBFFF>" .. tostring(myCronCount) .. "<PAOldColor>"
  else
    isMonotone = true
    txt_cronCount = tostring(myCronCount)
  end
  control.count:SetText(txt_cronCount)
  control.count:SetShow(true)
  self:setItemToSlotMonoTone(control.slot, nil, isMonotone)
  control.slot:setItemByStaticStatus(itemSSW, needCount)
  local isComplete = ToClient_isSetCompleteEnchantLightStoneInfo()
  if true == isComplete then
    self:updateLightStoneCronDesc()
  end
end
function PaGlobal_SpiritEnchant_All:updateLightStoneCronDesc()
  local enchantWrapper = ToClient_getLightStoneEnchantGroupStaticStatusWrapper()
  if nil == enchantWrapper then
    return
  end
  local isUseCron = self._ui_enchant.chk_enchantCron:IsCheck()
  local txt_notiBar = ""
  local txt_desc = ""
  local protectedPct = enchantWrapper:getProtectedCronPecent()
  local downGradePct = (CppDefine.e100Percent - protectedPct) / CppDefine.e1Percent
  if true == isUseCron then
    if 0 == downGradePct then
      txt_notiBar = PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_3")
    else
      txt_notiBar = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_4", "CronRate", downGradePct) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_3")
      txt_desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_SAFTYENCHANTDESC", "CronRate", downGradePct)
    end
  else
    txt_notiBar = PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_PENALTY_1")
  end
  self._ui_enchant.stc_noticeBar:SetText(txt_notiBar)
  self._ui_enchant.txt_enchantDesc:SetText(txt_desc)
  self._ui_enchant.txt_enchantDesc:SetShow(downGradePct > 0)
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:updateLightStoneEnchantRate()
  local enchantWrapper = ToClient_getLightStoneEnchantGroupStaticStatusWrapper()
  if nil == enchantWrapper then
    return
  end
  local enchantFailCount = getSelfPlayer():get():getEnchantFailCount()
  local enchantValuePackCount = getSelfPlayer():get():getEnchantValuePackCount()
  local sumStack = enchantFailCount + enchantValuePackCount
  local successPct = enchantWrapper:calculatedSuccessPercent(sumStack)
  local successPctString = string.format("%.2f%%", successPct * 100 / CppDefine.e100Percent)
  self._ui_enchant.txt_lightStoneEnchantRate:SetText(successPctString)
  self._ui_enchant.txt_lightStoneEnchantRate:SetShow(true)
end
function PaGlobal_SpiritEnchant_All:showLightStoneTooltip(controlType)
  local control = self._ui_enchant.lightStoneControlList[controlType]
  if nil == control then
    return
  end
  local itemSSW
  if LightStoneControlType.Cron == controlType then
    local key = ToClient_getCronItemEnchantKey()
    itemSSW = getItemEnchantStaticStatus(key)
  else
    local index
    if LightStoneControlType.Main == controlType then
      index = __eLightStoneEnchantInfo_MainItem
    elseif LightStoneControlType.Sub0 == controlType then
      index = __eLightStoneEnchantInfo_SubItem0
    elseif LightStoneControlType.Sub1 == controlType then
      index = __eLightStoneEnchantInfo_SubItem1
    else
      return
    end
    local infoWrapper = ToClient_getLightStoneItemInfoWrapper(index)
    if nil == infoWrapper then
      return
    end
    local key = infoWrapper:getItemEnchantKey()
    itemSSW = getItemEnchantStaticStatus(key)
  end
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, control.slot.icon, true, false, nil)
end
function PaGlobal_SpiritEnchant_All:hideLightStoneTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_SpiritEnchant_All:lightStoneEnchantSuccess(itemEnchantKeyRaw, itemWhereType)
  local key = ItemEnchantKey(itemEnchantKeyRaw)
  UI.ASSERT_NAME(key:isDefined(), "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
  local slotNo = ToClient_InventoryGetSlotNoByType(itemWhereType, key)
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if false == self:setLightStoneEnchantTarget(slotNo, itemWrapper, itemWhereType) then
    self:clearLightStoneEnchantSlot()
    UI.ASSERT_NAME(false, "\234\180\145\235\170\133\236\132\157 \234\176\149\237\153\148 \236\132\177\234\179\181 \237\149\152\236\152\128\236\156\188\235\130\152, \234\178\176\234\179\188\235\165\188 UI\236\151\144 \236\133\139\237\140\133\237\149\152\236\167\128 \235\170\187\237\149\168.", "\235\176\149\234\183\156\235\130\152")
  end
  audioPostEvent_SystemUi(5, 37)
  _AudioPostEvent_SystemUiForXBOX(5, 37)
  render_setChromaticBlur(40, 1)
  render_setPointBlur(0.05, 0.045)
  render_setColorBypass(0.85, 0.08)
  local slot = self._ui_enchant.lightStoneControlList[LightStoneControlType.Main].slot
  slot.icon:AddEffect("fUI_SpiritEnchant_Success_02A", true, 0, 0)
  self:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_SUCCESSENCHANT"))
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_RESULT_0"))
  ToClient_BlackspiritEnchantSuccess()
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:lightStoneEnchantFail(itemEnchantKeyRaw, itemWhereType, result)
  local txt_notiBar = ""
  local txt_effectName = ""
  if __eLightStoneEnchantResult_Fail_Broken == result then
    txt_notiBar = PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_RESULT_1")
    txt_effectName = "fUI_SpiritEnchant_Fail_01A"
  elseif __eLightStoneEnchantResult_Fail_DownGrade == result then
    txt_notiBar = PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_RESULT_2")
    txt_effectName = "fUI_SpiritEnchant_Fail_01A"
  elseif __eLightStoneEnchantResult_Fail_Protect == result then
    txt_notiBar = PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_RESULT_3")
    txt_effectName = "fUI_SpiritEnchant_Fail_01A"
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  local key = ItemEnchantKey(itemEnchantKeyRaw)
  if true == key:isDefined() then
    local slotNo = ToClient_InventoryGetSlotNoByType(itemWhereType, key)
    local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
    if false == self:setLightStoneEnchantTarget(slotNo, itemWrapper, itemWhereType) then
      self:clearLightStoneEnchantSlot()
      UI.ASSERT_NAME(false, "\234\180\145\235\170\133\236\132\157 \234\176\149\237\153\148 \236\132\177\234\179\181 \237\149\152\236\152\128\236\156\188\235\130\152, \234\178\176\234\179\188\235\165\188 UI\236\151\144 \236\133\139\237\140\133\237\149\152\236\167\128 \235\170\187\237\149\168.", "\235\176\149\234\183\156\235\130\152")
    end
  else
    self:clearLightStoneEnchantSlot()
    Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantLightStoneMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  end
  audioPostEvent_SystemUi(5, 38)
  _AudioPostEvent_SystemUiForXBOX(5, 38)
  local slot = self._ui_enchant.lightStoneControlList[LightStoneControlType.Main].slot
  slot.icon:AddEffect(txt_effectName, true, 0, 0)
  self:showEnchantResultNakMessage(false, PAGetString(Defines.StringSheet_GAME, "LUA_LIGHTSTONE_ENCHANT_FAILENCHANT"))
  self._ui_enchant.stc_noticeBar:SetText(txt_notiBar)
  ToClient_BlackspiritEnchantCancel()
  self:resizePanel()
end
function FromClient_ReceivedTriedStackInfo(count)
  if ToClient_getGameUIManagerWrapper() == nil then
    return
  end
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eShowOtherUserEnchantAdditionalRate) == false then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
  if showOtherUserEnchantAdditionalRate == true then
    PaGlobalFunc_OtherUser_TriedStack_Open()
  end
end
