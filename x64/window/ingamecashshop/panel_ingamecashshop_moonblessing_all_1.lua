function PaGlobal_IngameCashShopMoonBlessing_All:initialize()
  if self._initialize == true or Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if _ContentsGroup_PearlShopMoonBlessingUIOnOff == false then
    return
  end
  self:controlInitialize()
  self._ui._contentsGroup[self.MILEAGE_TYPE.CHARGED] = self._ui._chargeGroup.stc_bg
  self._ui._contentsGroup[self.MILEAGE_TYPE.CONSUMED] = self._ui._consumedGroup.stc_bg
  self._ui._mileageTabBtnGroup[self.MILEAGE_TYPE.CHARGED] = self._ui.rdo_charged
  self._ui._mileageTabBtnGroup[self.MILEAGE_TYPE.CONSUMED] = self._ui.rdo_consumed
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED] = {}
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED] = {}
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.MONTHLY] = self._ui._chargeGroup.rdo_montly
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.WEEKLY] = self._ui._chargeGroup.rdo_weekly
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.DAILY] = self._ui._chargeGroup.rdo_daily
  self._tabShowCnt = self._tabShowCnt + 1
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.MONTHLY] = self._ui._consumedGroup.rdo_montly
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.WEEKLY] = self._ui._consumedGroup.rdo_weekly
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.DAILY] = self._ui._consumedGroup.rdo_daily
  self._tabShowCnt = self._tabShowCnt + 1
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY] = self._ui.rdo_montly
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY] = self._ui.rdo_weekly
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY] = self._ui.rdo_daily
  self._saveSize.panelY = Panel_IngameCashShop_MoonBlessing_All:GetSizeY()
  self._saveSize.centerBgY = self._ui.stc_centerBg:GetSizeY()
  if ToClient_GetCurrentPearlObtainedTotal() ~= nil then
    self._nowObtainedPearl = ToClient_GetCurrentPearlObtainedTotal()
  end
  if ToClient_GetCurrentPearlUsedTotal() ~= nil then
    self._nowUsedPearl = ToClient_GetCurrentPearlUsedTotal()
  end
  self._isConsole = _ContentsGroup_RenewUI
  if self._isConsole == true then
    self._tabIndexForConsole[self.MILEAGE_TYPE.CHARGED] = {
      self.CHALLENGE_TYPE.DAILY,
      self.CHALLENGE_TYPE.WEEKLY,
      self.CHALLENGE_TYPE.MONTHLY
    }
    self._tabIndexForConsole[self.MILEAGE_TYPE.CONSUMED] = {
      self.CHALLENGE_TYPE.DAILY,
      self.CHALLENGE_TYPE.WEEKLY,
      self.CHALLENGE_TYPE.MONTHLY
    }
  end
  self:validate()
  self:registEventHandler()
  self:swichPlatform(self._isConsole)
  self:dayChange()
  self:update(self.MILEAGE_TYPE.CONSUMED)
  self._initialize = true
end
function PaGlobal_IngameCashShopMoonBlessing_All:controlInitialize()
  self._ui.stc_titleBg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_TopGroup")
  self._ui.stc_radioBg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_RadioGroup")
  self._ui.rdo_montly = UI.getChildControl(self._ui.stc_radioBg, "RadioButton_Monthly")
  self._ui.rdo_weekly = UI.getChildControl(self._ui.stc_radioBg, "RadioButton_Weekly")
  self._ui.rdo_daily = UI.getChildControl(self._ui.stc_radioBg, "RadioButton_Daily")
  self._ui.stc_selectLine = UI.getChildControl(self._ui.stc_radioBg, "Static_SelctLine")
  self._ui.stc_tabBg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_Tap_Btn_Group")
  self._ui.rdo_charged = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Charged")
  self._ui.rdo_consumed = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Consumed")
  self._ui.txt_nochallenge = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "StaticText_NoChallenge")
  self._ui.stc_centerBg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_Center_Bg")
  self._ui._chargeGroup.stc_bg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_Charged_Group")
  self._ui._chargeGroup.stc_rdoBg = UI.getChildControl(self._ui._chargeGroup.stc_bg, "Static_Type_Btn_Group")
  self._ui._chargeGroup.rdo_montly = UI.getChildControl(self._ui._chargeGroup.stc_rdoBg, "RadioButton_Monthly")
  self._ui._chargeGroup.rdo_weekly = UI.getChildControl(self._ui._chargeGroup.stc_rdoBg, "RadioButton_Weekly")
  self._ui._chargeGroup.rdo_daily = UI.getChildControl(self._ui._chargeGroup.stc_rdoBg, "RadioButton_Daily")
  self._ui._list2_mileage[self.MILEAGE_TYPE.CHARGED] = UI.getChildControl(self._ui._chargeGroup.stc_bg, "List2_MileageList")
  self._ui._consumedGroup.stc_bg = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_Consumed_Group")
  self._ui._consumedGroup.stc_rdoBg = UI.getChildControl(self._ui._consumedGroup.stc_bg, "Static_Type_Btn_Group")
  self._ui._consumedGroup.rdo_montly = UI.getChildControl(self._ui._consumedGroup.stc_rdoBg, "RadioButton_Monthly")
  self._ui._consumedGroup.rdo_weekly = UI.getChildControl(self._ui._consumedGroup.stc_rdoBg, "RadioButton_Weekly")
  self._ui._consumedGroup.rdo_daily = UI.getChildControl(self._ui._consumedGroup.stc_rdoBg, "RadioButton_Daily")
  self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED] = UI.getChildControl(self._ui._consumedGroup.stc_bg, "List2_MileageList")
  self._ui.txt_resetInfo = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "StaticText_ResetInfo")
  self._ui.txt_periodInfo = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "StaticText_PeriodInfo")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui_console.stc_rdoLB = UI.getChildControl(self._ui.stc_radioBg, "Static_SelectLB_C")
  self._ui_console.stc_rdoRB = UI.getChildControl(self._ui.stc_radioBg, "Static_SelectRB_C")
  self._ui_console.stc_keyGuideBG = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_KeyGuide")
  self._ui_console.stc_keyGuideX = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_XButton")
  self._ui_console.stc_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_AButton")
  self._ui_console.stc_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_BButton")
  self._ui_console.stc_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_YButton")
  self._ui._stc_resetArea = UI.getChildControl(Panel_IngameCashShop_MoonBlessing_All, "Static_Month_Repeat")
  self._ui._stc_resetDescEdge = UI.getChildControl(self._ui._stc_resetArea, "Static_DescEdge_Import")
  self._ui._stc_resetDesc = UI.getChildControl(self._ui._stc_resetDescEdge, "StaticText_Desc")
  self._ui._btn_reset = UI.getChildControl(self._ui._stc_resetDescEdge, "Button_Reset")
end
function PaGlobal_IngameCashShopMoonBlessing_All:swichPlatform(isConsole)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if self._isConsole == true then
    self._ui_pc.btn_close:SetShow(false)
    self._ui._stc_resetArea:SetShow(false)
    self._ui.txt_resetInfo:SetSpanSize(self._ui.txt_resetInfo:GetSpanSize().x, 610)
    self._ui.txt_resetInfo:ComputePos()
    self._ui.txt_periodInfo:SetSpanSize(self._ui.txt_periodInfo:GetSpanSize().x, 610)
    self._ui.txt_periodInfo:ComputePos()
    self._ui_console.stc_rdoLB:SetShow(true)
    self._ui_console.stc_rdoRB:SetShow(true)
    self._ui_console.stc_keyGuideBG:SetShow(true)
    self._ui_console.stc_keyGuideY:SetShow(true)
    self._ui_console.stc_keyGuideX:SetShow(true)
    self._ui_console.stc_keyGuideA:SetShow(true)
    self._ui_console.stc_keyGuideB:SetShow(true)
    local keyguide = {
      self._ui_console.stc_keyGuideY,
      self._ui_console.stc_keyGuideX,
      self._ui_console.stc_keyGuideA,
      self._ui_console.stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui_console.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui._stc_resetArea:SetShow(true)
    self._ui.txt_resetInfo:SetSpanSize(self._ui.txt_resetInfo:GetSpanSize().x, 650)
    self._ui.txt_resetInfo:ComputePos()
    self._ui.txt_periodInfo:SetSpanSize(self._ui.txt_periodInfo:GetSpanSize().x, 650)
    self._ui.txt_periodInfo:ComputePos()
    self._ui_console.stc_keyGuideBG:SetShow(false)
    self._ui_console.stc_keyGuideY:SetShow(false)
    self._ui_console.stc_keyGuideX:SetShow(false)
    self._ui_console.stc_keyGuideA:SetShow(false)
    self._ui_console.stc_keyGuideB:SetShow(false)
    self._ui_console.stc_rdoLB:SetShow(false)
    self._ui_console.stc_rdoRB:SetShow(false)
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:prepareOpen()
  if Panel_IngameCashShop_MoonBlessing_All == nil or _ContentsGroup_PearlShopMoonBlessingUIOnOff == false then
    return
  end
  self:open()
  self:swichPlatform(self._isConsole)
  self:update(self.MILEAGE_TYPE.CONSUMED)
  self:resize()
end
function PaGlobal_IngameCashShopMoonBlessing_All:open()
  if Panel_IngameCashShop_MoonBlessing_All == nil or _ContentsGroup_PearlShopMoonBlessingUIOnOff == false then
    return
  end
  Panel_IngameCashShop_MoonBlessing_All:SetShow(true)
end
function PaGlobal_IngameCashShopMoonBlessing_All:prepareClose()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  TooltipSimple_Hide()
  self._showPearlPrice = -1
  self._currentTabIndexForConsole = 1
  self._nowMileageInfoKey = self.MILEAGE_TYPE.CONSUMED
  self._nowTabInfoKey = self.CHALLENGE_TYPE.MONTHLY
  self:close()
end
function PaGlobal_IngameCashShopMoonBlessing_All:close()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  Panel_IngameCashShop_MoonBlessing_All:SetShow(false)
end
function PaGlobal_IngameCashShopMoonBlessing_All:update(mileageType, tabIndex)
  if Panel_IngameCashShop_MoonBlessing_All == nil or _ContentsGroup_PearlShopMoonBlessingUIOnOff == false then
    return
  end
  if mileageType == nil or mileageType == -1 or mileageType > #self._ui._mileageTabBtnGroup then
    mileageType = self.MILEAGE_TYPE.CHARGED
  end
  if tabIndex == nil or tabIndex == -1 then
    tabIndex = self._mileageDefaultType[mileageType]
    if tabIndex == nil or tabIndex == -1 then
      return
    end
  end
  self._nowMileageInfoKey = mileageType
  self._nowTabInfoKey = tabIndex
  self:refreshRewardInfo(self._nowMileageInfoKey, self._nowTabInfoKey)
  if self._mileageInfoCnt == 0 then
    return
  end
  self._nowObtainedPearl = ToClient_GetCurrentPearlObtainedTotal()
  self._nowUsedPearl = ToClient_GetCurrentPearlUsedTotal()
  self._ui._tabTypeBtnGroup[self._nowMileageInfoKey][self.CHALLENGE_TYPE.MONTHLY]:SetCheck(false)
  self._ui._tabTypeBtnGroup[self._nowMileageInfoKey][self.CHALLENGE_TYPE.WEEKLY]:SetCheck(false)
  self._ui._tabTypeBtnGroup[self._nowMileageInfoKey][self.CHALLENGE_TYPE.DAILY]:SetCheck(false)
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY]:SetCheck(false)
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY]:SetCheck(false)
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY]:SetCheck(false)
  if self._ui._tabTypeBtnGroup[self._nowMileageInfoKey][tabIndex] ~= nil then
    self._ui._tabTypeBtnGroup[self._nowMileageInfoKey][tabIndex]:SetCheck(true)
    self._ui._radioTabGroup[tabIndex]:SetCheck(true)
  end
  for ii = 0, #self._ui._mileageTabBtnGroup do
    if self._nowMileageInfoKey == ii then
      self._ui._mileageTabBtnGroup[ii]:SetCheck(true)
      self._ui._contentsGroup[ii]:SetShow(true)
    else
      self._ui._mileageTabBtnGroup[ii]:SetCheck(false)
      self._ui._contentsGroup[ii]:SetShow(false)
    end
  end
  self._mileageSlots[self._nowMileageInfoKey] = {}
  self:setBottomDesc(self._nowTabInfoKey)
  self:listUpdate()
  local targetControl = self._ui._radioTabGroup[tabIndex]
  if targetControl ~= nil then
    local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - self._ui.stc_selectLine:GetSizeX() / 2
    self._ui.stc_selectLine:SetPosX(selectBarPosX)
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:refreshRewardInfo(mileageType, challengeType)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._mileageInfo = {}
  self._mileageInfoCnt = 0
  local tempCnt = 0
  if mileageType == self.MILEAGE_TYPE.CHARGED then
    tempCnt = ToClient_GetRewardedPearlObtainedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetRewardedPearlObtainedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.REWARDED
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
    self._nowProgressKeyGroup[mileageType] = self._mileageInfoCnt
    tempCnt = ToClient_GetProgressPearlObtainedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetProgressPearlObtainedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.PROGRESS
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
    tempCnt = ToClient_GetCompletedPearlObtainedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetCompletedPearlObtainedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.COMPLETED
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
  elseif mileageType == self.MILEAGE_TYPE.CONSUMED then
    tempCnt = ToClient_GetRewardedPearlUsedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetRewardedPearlUsedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.REWARDED
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
    self._nowProgressKeyGroup[mileageType] = self._mileageInfoCnt
    tempCnt = ToClient_GetProgressPearlUsedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetProgressPearlUsedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.PROGRESS
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
    tempCnt = ToClient_GetCompletedPearlUsedCount(challengeType)
    for ii = 0, tempCnt - 1 do
      self._mileageInfo[self._mileageInfoCnt] = ToClient_GetCompletedPearlUsedAt(challengeType, ii)
      self._mileageInfo[self._mileageInfoCnt].nowStep = self.CHALLENGE_STEP.COMPLETED
      self._mileageInfoCnt = self._mileageInfoCnt + 1
    end
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:setBottomDesc(challengeType)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if self._isConsole == true then
    local resetInfoText = PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_DESC_01") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_DESC_02")
    self._ui.txt_resetInfo:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_resetInfo:SetText(resetInfoText .. [[


]])
    self._ui.txt_resetInfo:SetSize(self._ui.txt_resetInfo:GetSizeX(), self._ui.txt_resetInfo:GetTextSizeY())
    self._ui.txt_resetInfo:ComputePos()
    local periodInfoText = ""
    if self._mileageInfo[0] ~= nil then
      periodInfoText = self._mileageInfo[0]:getDesc() .. "\n"
    end
    self._ui.txt_periodInfo:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_periodInfo:SetText(periodInfoText)
    self._ui.txt_periodInfo:SetSize(self._ui.txt_periodInfo:GetSizeX(), self._ui.txt_periodInfo:GetTextSizeY())
    self._ui.txt_periodInfo:SetSpanSize(self._ui.txt_periodInfo:GetSpanSize().x, self._ui.txt_resetInfo:GetSpanSize().y + self._ui.txt_resetInfo:GetTextSizeY() + 3)
    self._ui.txt_periodInfo:ComputePos()
    Panel_IngameCashShop_MoonBlessing_All:SetSize(Panel_IngameCashShop_MoonBlessing_All:GetSizeX(), self._saveSize.panelY + self._ui.txt_resetInfo:GetTextSizeY() + self._ui.txt_periodInfo:GetTextSizeY() + 20)
    self._ui_console.stc_keyGuideBG:ComputePos()
  else
    local resetInfoText = ""
    if challengeType == self.CHALLENGE_TYPE.MONTHLY or challengeType == self.CHALLENGE_TYPE.WEEKLY or challengeType == self.CHALLENGE_TYPE.DAILY then
      resetInfoText = PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_DESC_01") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_DESC_02") .. [[


]]
    else
      UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 challengeType \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    if self._mileageInfo[0] ~= nil then
      resetInfoText = resetInfoText .. self._mileageInfo[0]:getDesc() .. "\n"
    end
    self._ui.txt_resetInfo:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_resetInfo:SetText(resetInfoText)
    self._ui.txt_resetInfo:SetSize(self._ui.txt_resetInfo:GetSizeX(), self._ui.txt_resetInfo:GetTextSizeY())
    self._ui.txt_resetInfo:ComputePos()
    local periodInfoText = self.PERIOD_INFO[challengeType]
    if challengeType == self.CHALLENGE_TYPE.MONTHLY or challengeType == self.CHALLENGE_TYPE.WEEKLY or challengeType == self.CHALLENGE_TYPE.DAILY then
      periodInfoText = periodInfoText .. [[


]]
    else
      UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 challengeType \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    periodInfoText = periodInfoText .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_MILEAGE_ALERTINFO")
    self._ui.txt_periodInfo:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_periodInfo:SetText(periodInfoText)
    self._ui.txt_periodInfo:SetSize(self._ui.txt_periodInfo:GetSizeX(), self._ui.txt_periodInfo:GetTextSizeY())
    self._ui.txt_periodInfo:SetSpanSize(self._ui.txt_periodInfo:GetSpanSize().x, self._ui.txt_resetInfo:GetSpanSize().y + self._ui.txt_resetInfo:GetTextSizeY() + 3)
    self._ui.txt_periodInfo:ComputePos()
    Panel_IngameCashShop_MoonBlessing_All:SetSize(Panel_IngameCashShop_MoonBlessing_All:GetSizeX(), self._saveSize.panelY + self._ui.txt_resetInfo:GetTextSizeY() + self._ui.txt_periodInfo:GetTextSizeY() + 20)
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:listUpdate()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._ui._list2_mileage[self._nowMileageInfoKey]:getElementManager():clearKey()
  if 0 < self._mileageInfoCnt then
    self._ui.txt_nochallenge:SetShow(false)
    for ii = 0, self._mileageInfoCnt - 1 do
      if nil ~= self._mileageInfo[ii] then
        self._mileageSlots[self._nowMileageInfoKey][ii] = {}
        self._ui._list2_mileage[self._nowMileageInfoKey]:getElementManager():pushKey(toInt64(0, ii))
      end
    end
  else
    self._ui.txt_nochallenge:SetShow(true)
  end
  self._nowConfirmKey = -1
end
function PaGlobal_IngameCashShopMoonBlessing_All:resetUpdate()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if self._currentTabGroupChallengeKey == 0 then
    return
  end
  local currentResetCount = ToClient_currentPearlUsedChallengeResetCount(self._currentTabGroupChallengeKey)
  local maxResetCount = ToClient_maxPearlUsedChallengeResetCount(self._currentTabGroupChallengeKey)
  local currentPossibleResetCount = maxResetCount - currentResetCount
  self._ui._stc_resetDesc:SetShow(true)
  self._ui._stc_resetDesc:SetText(PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_COUNT") .. " " .. tostring(currentPossibleResetCount))
end
function PaGlobal_IngameCashShopMoonBlessing_All:listCreate(content, key)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  local key32 = Int64toInt32(key)
  local gabX = 3
  if nil == self._mileageInfo[key32] then
    return
  end
  local stc_contentBg = UI.getChildControl(content, "List2_Content_Bg")
  local txt_title = UI.getChildControl(stc_contentBg, "StaticText_MileageTitle")
  local txt_reward = UI.getChildControl(stc_contentBg, "StaticText_RewardedText")
  local stc_reward = UI.getChildControl(stc_contentBg, "StaticText_RewardedIcon")
  local btn_reward = UI.getChildControl(stc_contentBg, "Button_Reward")
  local stc_complete = UI.getChildControl(stc_contentBg, "Static_RewardGage_Complete")
  local stc_rewardGageBg = UI.getChildControl(stc_contentBg, "Static_RewardGage_Bg")
  local progress_rewardLater = UI.getChildControl(stc_contentBg, "Progress2_RewardGage_Later")
  local progress_reward = UI.getChildControl(stc_contentBg, "Progress2_RewardGage")
  local txt_rewardValue = UI.getChildControl(stc_contentBg, "StaticText_RewardValue")
  local challengekeyType = self._mileageInfo[key32]:getKey():get()
  self._currentTabGroupChallengeKey = ToClient_getPearlUsedChallengeMainNo(challengekeyType)
  stc_rewardGageBg:SetShow(false)
  progress_rewardLater:SetShow(false)
  progress_reward:SetShow(false)
  txt_rewardValue:SetShow(false)
  btn_reward:SetShow(false)
  txt_reward:SetShow(false)
  stc_reward:SetShow(false)
  stc_complete:SetShow(false)
  txt_title:SetText(self._mileageInfo[key32]:getName())
  stc_contentBg:SetHorizonCenter()
  local itemCnt = self._mileageInfo[key32]:getBaseRewardCount()
  for ii = 0, self._maxSlotCnt - 1 do
    local itemSlotBg = UI.getChildControl(stc_contentBg, "Static_ItemSlotBg_" .. ii)
    if nil ~= itemSlotBg then
      itemSlotBg:SetPosX(30 + (itemSlotBg:GetSizeX() + gabX) * ii)
      if ii < itemCnt then
        local baseReward = self._mileageInfo[key32]:getBaseRewardAt(ii)
        if nil ~= baseReward then
          local slot = {}
          slot.empty = itemSlotBg
          SlotItem.reInclude(slot, "ItemSlot", ii, slot.empty, self._slotConfig)
          slot.icon:SetShow(true)
          local slotOption = {}
          slotOption._type = baseReward._type
          if __eRewardExp == baseReward._type then
            slotOption._exp = baseReward._experience
          elseif __eRewardSkillExp == baseReward._type then
            slotOption._exp = baseReward._skillExperience
          elseif __eRewardLifeExp == baseReward._type then
            slotOption._exp = baseReward._productExperience
          elseif __eRewardItem == baseReward._type then
            slotOption._item = baseReward:getItemEnchantKey()
            slotOption._count = baseReward._itemCount
            local selfPlayer = getSelfPlayer()
            if nil ~= selfPlayer then
              local classType = selfPlayer:getClassType()
              slotOption._isEquipable = baseReward:isEquipable(classType)
            end
          elseif __eRewardIntimacy == baseReward._type then
            slotOption._character = baseReward:getIntimacyCharacter()
            slotOption._value = baseReward._intimacyValue
          end
          self._mileageSlots[self._nowMileageInfoKey][key32][ii] = slot
          self:setCashMileageRewardShow(key32, ii, slotOption)
        end
      else
        itemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        local tempIcon = UI.getChildControl(itemSlotBg, "Static_ItemSlot")
        tempIcon:SetShow(false)
      end
    end
  end
  stc_contentBg:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
  if self._mileageInfo[key32].nowStep == self.CHALLENGE_STEP.PROGRESS then
    local nowAttainment = 0
    local x1, y1, x2, y2 = setTextureUV_Func(stc_contentBg, 256, 1, 306, 51)
    stc_contentBg:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_contentBg:setRenderTexture(stc_contentBg:getBaseTexture())
    if self._nowMileageInfoKey == self.MILEAGE_TYPE.CHARGED then
      if self._nowTabInfoKey == self.CHALLENGE_TYPE.DAILY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlObtainedDaily())
      elseif self._nowTabInfoKey == self.CHALLENGE_TYPE.WEEKLY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlObtainedWeekly())
      elseif self._nowTabInfoKey == self.CHALLENGE_TYPE.MONTHLY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlObtainedMonthly())
      end
    elseif self._nowMileageInfoKey == self.MILEAGE_TYPE.CONSUMED then
      if self._nowTabInfoKey == self.CHALLENGE_TYPE.DAILY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlUsedDaily())
      elseif self._nowTabInfoKey == self.CHALLENGE_TYPE.WEEKLY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlUsedWeekly())
      elseif self._nowTabInfoKey == self.CHALLENGE_TYPE.MONTHLY then
        nowAttainment = Int64toInt32(ToClient_GetCurrentPearlUsedMonthly())
      end
    end
    local unitPrice = Int64toInt32(ToClient_isPearlUsedChallengeUnitPrice(challengekeyType)) * self._mileageInfo[key32]:getCount()
    local nowGoal = self._mileageInfo[key32]:getCompleteParam1()
    nowAttainment = nowAttainment - unitPrice
    local isGoal = false
    local rate = math.floor(nowAttainment / nowGoal * 100)
    progress_reward:SetProgressRate(rate)
    if rate < 100 then
      txt_rewardValue:SetText(nowAttainment .. "/" .. nowGoal)
      progress_rewardLater:SetProgressRate(rate)
      if 0 < self._showPearlPrice and self.MILEAGE_TYPE.CONSUMED == self._nowMileageInfoKey then
        rate = math.floor((self._showPearlPrice + nowAttainment) / nowGoal * 100)
        progress_rewardLater:SetShow(true)
        if rate >= 100 then
          stc_complete:SetShow(true)
        end
        txt_rewardValue:SetText(nowAttainment .. " <PAColor0xFF5DFF70>(+" .. self._showPearlPrice .. ")<PAOldColor> /" .. nowGoal)
        progress_rewardLater:SetProgressRate(rate)
      else
        progress_rewardLater:SetShow(false)
      end
      txt_rewardValue:SetPosY(progress_reward:GetPosY() + progress_reward:GetSizeY() / 2 - txt_rewardValue:GetSizeY() / 2)
      progress_reward:SetShow(true)
      txt_rewardValue:SetShow(true)
      stc_rewardGageBg:SetShow(true)
      btn_reward:SetIgnore(true)
    else
      local x1, y1, x2, y2 = setTextureUV_Func(stc_contentBg, 307, 1, 357, 51)
      stc_contentBg:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_contentBg:setRenderTexture(stc_contentBg:getBaseTexture())
      btn_reward:SetShow(true)
      btn_reward:SetIgnore(false)
      btn_reward:addInputEvent("Mouse_LUp", "HandleEvent_IngameCashShopMoonBlessing_All_ApplyReward(" .. key32 .. ")")
    end
  elseif self._mileageInfo[key32].nowStep == self.CHALLENGE_STEP.REWARDED then
    local x1, y1, x2, y2 = setTextureUV_Func(stc_contentBg, 307, 1, 357, 51)
    stc_contentBg:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_contentBg:setRenderTexture(stc_contentBg:getBaseTexture())
    btn_reward:SetShow(true)
    btn_reward:SetIgnore(false)
    btn_reward:addInputEvent("Mouse_LUp", "HandleEvent_IngameCashShopMoonBlessing_All_ApplyReward(" .. key32 .. ")")
  elseif self._mileageInfo[key32].nowStep == self.CHALLENGE_STEP.COMPLETED then
    local x1, y1, x2, y2 = setTextureUV_Func(stc_contentBg, 256, 1, 306, 51)
    stc_contentBg:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_contentBg:setRenderTexture(stc_contentBg:getBaseTexture())
    stc_reward:SetShow(true)
    txt_reward:SetShow(false)
  end
  self:resetUpdate()
end
function PaGlobal_IngameCashShopMoonBlessing_All:setCashMileageRewardShow(contentIndex, slotIndex, reward)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  local uiSlot = self._mileageSlots[self._nowMileageInfoKey][contentIndex][slotIndex]
  if nil ~= uiSlot then
    if __eRewardExp == reward._type then
      uiSlot.count:SetText("")
      uiSlot.icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    elseif __eRewardSkillExp == reward._type then
      uiSlot.count:SetText("")
      uiSlot.icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds")
    elseif __eRewardLifeExp == reward._type then
      uiSlot.count:SetText("")
      uiSlot.icon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    elseif __eRewardItem == reward._type then
      local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
      if nil ~= itemStatic then
        uiSlot:setItemByStaticStatus(itemStatic, reward._count)
        uiSlot._item = reward._item
      end
      if true == self._isConsole then
        uiSlot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEvent_IngameCashShopMoonBlessing_All_ShowToolTip(" .. contentIndex .. "," .. slotIndex .. ",true)")
      else
        uiSlot.icon:addInputEvent("Mouse_On", "HandleEvent_IngameCashShopMoonBlessing_All_ShowToolTip(" .. contentIndex .. "," .. slotIndex .. ",true)")
      end
      uiSlot.icon:addInputEvent("Mouse_Out", "HandleEvent_IngameCashShopMoonBlessing_All_ShowToolTip(" .. contentIndex .. "," .. slotIndex .. ",false)")
    elseif __eRewardIntimacy == reward._type then
      uiSlot.count:SetText("")
      uiSlot.icon:ChangeTextureInfoNameAsync("Icon/New_Icon/00000000_Special_Contributiveness.dds")
    else
      if true == self._isConsole then
        uiSlot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      else
        uiSlot.icon:addInputEvent("Mouse_On", "")
      end
      uiSlot.icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:dayChange()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._nowTabShowCnt = self._tabShowCnt
  self:challengeBtnGroupCheck(self.MILEAGE_TYPE.CHARGED)
  self:challengeBtnGroupCheck(self.MILEAGE_TYPE.CONSUMED)
  if self._nowTabShowCnt < 2 then
    self._ui.stc_tabBg:SetShow(false)
    if Panel_IngameCashShop_MoonBlessing_All:GetSizeY() ~= self._saveSize.panelY - self._ui.stc_tabBg:GetSizeY() then
      Panel_IngameCashShop_MoonBlessing_All:SetSize(Panel_IngameCashShop_MoonBlessing_All:GetSizeX(), self._saveSize.panelY - self._ui.stc_tabBg:GetSizeY())
      self:childComputePos()
    end
  else
    self._ui.stc_tabBg:SetShow(true)
    Panel_IngameCashShop_MoonBlessing_All:SetSize(Panel_IngameCashShop_MoonBlessing_All:GetSizeX(), self._saveSize.panelY)
    if Panel_IngameCashShop_MoonBlessing_All:GetSizeY() ~= self._saveSize.panelY then
      Panel_IngameCashShop_MoonBlessing_All:SetSize(Panel_IngameCashShop_MoonBlessing_All:GetSizeX(), self._saveSize.panelY)
      self:childComputePos()
    end
  end
  self._ui.txt_resetInfo:SetText("")
  self:update(self._nowMileageInfoKey, self._nowTabInfoKey)
end
function PaGlobal_IngameCashShopMoonBlessing_All:challengeBtnGroupCheck(mileageType)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:SetPosX(0)
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:SetPosX(0)
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:SetPosX(0)
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:SetCheck(false)
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:SetCheck(false)
  self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:SetCheck(false)
  self._typeBtnCnt = 0
  local tempMonthly = self:checkChallengeCnt(mileageType, self.CHALLENGE_TYPE.MONTHLY)
  local tempWeekly = self:checkChallengeCnt(mileageType, self.CHALLENGE_TYPE.WEEKLY)
  local tempDaily = self:checkChallengeCnt(mileageType, self.CHALLENGE_TYPE.DAILY)
  local tabShowCount = 0
  self._mileageDefaultType[mileageType] = -1
  if tempMonthly > 0 then
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:SetPosX((self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:GetSizeX() + 5) * self._typeBtnCnt)
    self._typeBtnCnt = self._typeBtnCnt + 1
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:SetShow(true)
    if -1 == self._mileageDefaultType[mileageType] then
      self._mileageDefaultType[mileageType] = self.CHALLENGE_TYPE.MONTHLY
    end
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY]:SetShow(true)
    tabShowCount = tabShowCount + 1
  else
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.MONTHLY]:SetShow(false)
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY]:SetShow(false)
  end
  if tempWeekly > 0 then
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:SetPosX((self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:GetSizeX() + 5) * self._typeBtnCnt)
    self._typeBtnCnt = self._typeBtnCnt + 1
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:SetShow(true)
    if -1 == self._mileageDefaultType[mileageType] then
      self._mileageDefaultType[mileageType] = self.CHALLENGE_TYPE.WEEKLY
    end
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY]:SetShow(true)
    tabShowCount = tabShowCount + 1
  else
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.WEEKLY]:SetShow(false)
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY]:SetShow(false)
  end
  if tempDaily > 0 then
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:SetPosX((self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:GetSizeX() + 5) * self._typeBtnCnt)
    self._typeBtnCnt = self._typeBtnCnt + 1
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:SetShow(true)
    if -1 == self._mileageDefaultType[mileageType] then
      self._mileageDefaultType[mileageType] = self.CHALLENGE_TYPE.DAILY
    end
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY]:SetShow(true)
    tabShowCount = tabShowCount + 1
  else
    self._ui._tabTypeBtnGroup[mileageType][self.CHALLENGE_TYPE.DAILY]:SetShow(false)
    self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY]:SetShow(false)
  end
  local tabButtonList = Array.new()
  tabButtonList:push_back(self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY])
  tabButtonList:push_back(self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY])
  tabButtonList:push_back(self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY])
  local tabButtonSizeX = self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY]:GetSizeX()
  local termX = (self._ui.stc_radioBg:GetSizeX() - tabButtonSizeX * tabShowCount) / (tabShowCount + 1)
  local spanX = termX
  for key, value in pairs(tabButtonList) do
    if value ~= nil and value:GetShow() == true then
      value:SetSpanSize(spanX, value:GetSpanSize().y)
      value:ComputePos()
      spanX = spanX + termX + value:GetSizeX()
    end
  end
  local totalChallengeCnt = tempMonthly + tempWeekly + tempDaily
  if totalChallengeCnt < 1 then
    if self._ui._mileageTabBtnGroup[mileageType] ~= nil then
      self._ui._mileageTabBtnGroup[mileageType]:SetShow(false)
    end
    self._nowTabShowCnt = self._nowTabShowCnt - 1
  else
    self._mileageDefaultKey = mileageType
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:checkChallengeCnt(mileageType, challengeType)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return 0
  end
  local tempCnt = 0
  local tempBtn = self._ui._tabTypeBtnGroup[mileageType][challengeType]
  if self.MILEAGE_TYPE.CHARGED == mileageType then
    tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(challengeType)
    tempCnt = tempCnt + ToClient_GetProgressPearlObtainedCount(challengeType)
    tempCnt = tempCnt + ToClient_GetCompletedPearlObtainedCount(challengeType)
  elseif self.MILEAGE_TYPE.CONSUMED == mileageType then
    tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(challengeType)
    tempCnt = tempCnt + ToClient_GetProgressPearlUsedCount(challengeType)
    tempCnt = tempCnt + ToClient_GetCompletedPearlUsedCount(challengeType)
  end
  return tempCnt
end
function PaGlobal_IngameCashShopMoonBlessing_All:childComputePos()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._ui.stc_centerBg:ComputePos()
  self._ui.stc_tabBg:ComputePos()
  for k, v in pairs(self._ui._contentsGroup) do
    v:ComputePos()
  end
  self._ui.txt_nochallenge:ComputePos()
  self._ui.txt_resetInfo:ComputePos()
end
function PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  local tempCnt = 0
  tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.MONTHLY)
  tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.DAILY)
  tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.WEEKLY)
  tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.MONTHLY)
  tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.WEEKLY)
  tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.DAILY)
  PaGlobalFunc_IngameCashShopSetEquip_MileageBtnEffect(tempCnt)
  PaGlobal_InGameCashShop_SetCheckMoonBlessing(tempCnt)
end
function PaGlobal_IngameCashShopMoonBlessing_All:registEventHandler()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_IngameCashShopMoonBlessing_All_OnResize")
  registerEvent("FromClient_InventoryUpdate", "FromClient_IngameCashShopMoonBlessing_All_InventoryUpdate")
  registerEvent("FromClient_NotifyCompleteBuyProduct", "FromClient_IngameCashShopMoonBlessing_All_NotifyCompleteBuyProduct")
  registerEvent("FromClient_UpdatePearlMileage", "FromClient_IngameCashShopMoonBlessing_All_UpdatePearlMileage")
  registerEvent("FromClient_SelectRandomItem", "FromClient_IngameCashShopMoonBlessing_All_SelectRandomItem")
  registerEvent("FromClient_ChallengeReward_UpdateText", "FromClient_IngameCashShopMoonBlessing_All_ChallengeReward_UpdateText")
  registerEvent("FromClient_AttendanceTimer", "FromClient_IngameCashShopMoonBlessing_All_AttendanceTimer")
  registerEvent("FromClient_PearlUsedResetSuccessNotify", "FromClient_PearlUsedResetSuccessNotify")
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_IngameCashShopMoonBlessing_All_Close()")
  self._ui.rdo_charged:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Update(" .. self.MILEAGE_TYPE.CHARGED .. ")")
  self._ui.rdo_consumed:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Update(" .. self.MILEAGE_TYPE.CONSUMED .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.MONTHLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.MONTHLY .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.WEEKLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.WEEKLY .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CHARGED][self.CHALLENGE_TYPE.DAILY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.DAILY .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.MONTHLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.MONTHLY .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.WEEKLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.WEEKLY .. ")")
  self._ui._tabTypeBtnGroup[self.MILEAGE_TYPE.CONSUMED][self.CHALLENGE_TYPE.DAILY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.DAILY .. ")")
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.MONTHLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.MONTHLY .. ")")
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.WEEKLY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.WEEKLY .. ")")
  self._ui._radioTabGroup[self.CHALLENGE_TYPE.DAILY]:addInputEvent("Mouse_LUp", "PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(" .. self.CHALLENGE_TYPE.DAILY .. ")")
  for ii = 0, #self._ui._list2_mileage do
    self._ui._list2_mileage[ii]:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_IngameCashShopMoonBlessing_All_ListCreate")
    self._ui._list2_mileage[ii]:createChildContent(__ePAUIList2ElementManagerType_List)
    self._ui._list2_mileage[ii]:ComputePos()
  end
  if self._isConsole == true then
    Panel_IngameCashShop_MoonBlessing_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEvent_IngameCashShopMoonBlessing_All_MoveTab(-1)")
    Panel_IngameCashShop_MoonBlessing_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEvent_IngameCashShopMoonBlessing_All_MoveTab(1)")
    Panel_IngameCashShop_MoonBlessing_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ShowMessage_RequestPearlUsedReset()")
  end
  self._ui._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_RequestPearlUsedReset()")
end
function PaGlobal_IngameCashShopMoonBlessing_All:validate()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_radioBg:isValidate()
  self._ui.rdo_montly:isValidate()
  self._ui.rdo_weekly:isValidate()
  self._ui.rdo_daily:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.stc_tabBg:isValidate()
  self._ui.rdo_charged:isValidate()
  self._ui.rdo_consumed:isValidate()
  self._ui.txt_nochallenge:isValidate()
  self._ui.stc_centerBg:isValidate()
  self._ui._chargeGroup.stc_bg:isValidate()
  self._ui._chargeGroup.stc_rdoBg:isValidate()
  self._ui._chargeGroup.rdo_montly:isValidate()
  self._ui._chargeGroup.rdo_weekly:isValidate()
  self._ui._chargeGroup.rdo_daily:isValidate()
  self._ui._list2_mileage[self.MILEAGE_TYPE.CHARGED]:isValidate()
  self._ui._consumedGroup.stc_bg:isValidate()
  self._ui._consumedGroup.stc_rdoBg:isValidate()
  self._ui._consumedGroup.rdo_montly:isValidate()
  self._ui._consumedGroup.rdo_weekly:isValidate()
  self._ui._consumedGroup.rdo_daily:isValidate()
  self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED]:isValidate()
  self._ui.txt_resetInfo:isValidate()
  self._ui.txt_periodInfo:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_console.stc_rdoLB:isValidate()
  self._ui_console.stc_rdoRB:isValidate()
end
function PaGlobal_IngameCashShopMoonBlessing_All:resize()
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if Panel_IngameCashShop_Coupon ~= nil and Panel_IngameCashShop_Coupon:GetShow() == true then
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(Panel_IngameCashShop_Coupon:GetPosX() + Panel_IngameCashShop_Coupon:GetSizeX())
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(getScreenSizeY() / 2 - Panel_IngameCashShop_MoonBlessing_All:GetSizeY() / 2)
  elseif Panel_IngameCashShop_BuyOrGift:GetShow() == true then
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(Panel_IngameCashShop_BuyOrGift:GetPosX() + Panel_IngameCashShop_BuyOrGift:GetSizeX())
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(getScreenSizeY() / 2 - Panel_IngameCashShop_MoonBlessing_All:GetSizeY() / 2)
  elseif Panel_IngameCashShop_MakePaymentsFromCart:GetShow() == true then
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(Panel_IngameCashShop_MakePaymentsFromCart:GetPosX() + Panel_IngameCashShop_MakePaymentsFromCart:GetSizeX())
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(getScreenSizeY() / 2 - Panel_IngameCashShop_MoonBlessing_All:GetSizeY() / 2)
  elseif self._isConsole == true and Panel_PearlShop_ProductBuy ~= nil and Panel_PearlShop_ProductBuy:GetShow() == true then
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(Panel_PearlShop_ProductBuy:GetPosX() + Panel_PearlShop_ProductBuy:GetSizeX())
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(Panel_PearlShop_ProductBuy:GetPosY())
  elseif self._isConsole == true then
    local gap = (getScreenSizeY() - Panel_IngameCashShop_MoonBlessing_All:GetSizeY()) * 0.5
    Panel_IngameCashShop_MoonBlessing_All:SetSpanSize(Panel_IngameCashShop_MoonBlessing_All:GetSpanSize().x, gap)
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(getScreenSizeX() - Panel_IngameCashShop_MoonBlessing_All:GetSizeX() - 150)
  else
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(getScreenSizeX() - Panel_IngameCashShop_MoonBlessing_All:GetSizeX() - 150)
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(getScreenSizeY() / 2 - Panel_IngameCashShop_MoonBlessing_All:GetSizeY() / 2)
  end
  if self._isConsole == false and getScreenSizeX() - Panel_IngameCashShop_MoonBlessing_All:GetSizeX() < Panel_IngameCashShop_MoonBlessing_All:GetPosX() then
    Panel_IngameCashShop_MoonBlessing_All:SetPosX(getScreenSizeX() - Panel_IngameCashShop_MoonBlessing_All:GetSizeX() - 150)
    Panel_IngameCashShop_MoonBlessing_All:SetPosY(getScreenSizeY() / 2 - Panel_IngameCashShop_MoonBlessing_All:GetSizeY() / 2)
  end
end
function PaGlobal_IngameCashShopMoonBlessing_All:moveTab(moveDir)
  if Panel_IngameCashShop_MoonBlessing_All == nil then
    return
  end
  if self._tabIndexForConsole == nil then
    return
  end
  local tabKeyList = self._tabIndexForConsole[self._nowMileageInfoKey]
  if tabKeyList == nil then
    return
  end
  local nextIndex = 0
  local maxIndex = #tabKeyList
  for idx = 1, maxIndex do
    nextIndex = self._currentTabIndexForConsole + moveDir
    if nextIndex <= 0 then
      nextIndex = maxIndex
    elseif maxIndex < nextIndex then
      nextIndex = 1
    end
    local nextTabKey = tabKeyList[nextIndex]
    if nextTabKey == nil then
      return
    end
    self._currentTabIndexForConsole = nextIndex
    self:update(self._nowMileageInfoKey, nextTabKey)
    if self._mileageInfoCnt ~= 0 then
      break
    end
  end
end
