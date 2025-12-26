function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Open()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:prepareOpen()
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:prepareClose()
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_GetShow()
  if nil == Panel_IngameCashShop_MoonBlessing_Renew_All then
    return false
  end
  return Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow()
end
function HandleEventLUp_IngameCashShopMoonBlessing_Renew_All_Close()
  PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
end
function HandleEventLUp_IngameCashShopMoonBlessing_Renew_All_Open()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageDefaultKey)
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:prepareOpen()
end
function HandleEvent_IngameCashShopMoonBlessing_Renew_All_ShowToolTip(contentIndex, slotIndex, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_IngameCashShop_MoonBlessing_Renew_All then
    return
  end
  local self = PaGlobal_IngameCashShopMoonBlessing_Renew_All
  local uiSlot = self._mileageSlots[self._nowMileageInfoKey][contentIndex][slotIndex]
  local slotIcon = uiSlot.icon
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(uiSlot._item))
  local name = itemStatic:getName()
  local desc = itemStatic:getDescription()
  if true == isShow then
    TooltipSimple_Show(slotIcon, name, desc)
  end
end
function HandleEvent_IngameCashShopMoonBlessing_Renew_All_ApplyReward(itemKey)
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:dayChange()
    return
  end
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageInfo[itemKey] == nil then
    return
  end
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All.CHALLENGE_STEP.REWARDED ~= PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageStepInfo[itemKey] then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowConfirmKey = itemKey
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_MILEAGE_CONFIRM_MESSAGE"),
    functionYes = PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_ConfirmReward,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_ConfirmReward()
  local itemKey = PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowConfirmKey
  if nil == PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageInfo[itemKey] then
    return
  end
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All.CHALLENGE_STEP.REWARDED ~= PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageStepInfo[itemKey] then
    return
  end
  ToClient_RequestMoonblessingReward(PaGlobal_IngameCashShopMoonBlessing_Renew_All._mileageInfo[itemKey]:getKey())
end
function HandleEvent_IngameCashShopMoonBlessing_Renew_All_MoveTab(moveDir)
  if nil == Panel_IngameCashShop_MoonBlessing_Renew_All or false == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:moveTab(moveDir)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_OnResize()
  if nil == Panel_IngameCashShop_MoonBlessing_Renew_All then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:resize()
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_InventoryUpdate()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowObtainedPearl ~= ToClient_GetCurrentPearlObtainedTotal() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All.MILEAGE_TYPE.CHARGED)
  elseif PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowUsedPearl ~= ToClient_GetCurrentMoonblessingPearlUsed() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All.MILEAGE_TYPE.CONSUMED)
  end
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_NotifyCompleteBuyProduct()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All._showPearlPrice = -1
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowUsedPearl ~= ToClient_GetCurrentMoonblessingPearlUsed() then
    if PaGlobal_IngameCashShopMoonBlessing_Renew_All.MILEAGE_TYPE.CONSUMED == PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowMileageInfoKey then
      PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowMileageInfoKey, PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowTabInfoKey)
    else
      PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All.MILEAGE_TYPE.CONSUMED)
    end
  else
    return
  end
  if true == PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
  end
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_UpdatePearlMileage()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:dayChange()
  end
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_SelectRandomItem()
  PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_ChallengeReward_UpdateText()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowMileageInfoKey, PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowTabInfoKey)
end
function FromClient_IngameCashShopMoonBlessing_Renew_All_AttendanceTimer()
  if PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:dayChange()
  end
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Update(mileageType)
  if nil == mileageType then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(mileageType)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Type_Update(tabIndex)
  if nil == tabIndex then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(PaGlobal_IngameCashShopMoonBlessing_Renew_All._nowMileageInfoKey, tabIndex)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_ListCreate(content, key)
  if nil == Panel_IngameCashShop_MoonBlessing_Renew_All then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_Renew_All:listCreate(content, key)
end
function PaGlobal_MoonBlessingRenew_IsOpenCheck()
  local self = PaGlobal_IngameCashShopMoonBlessing_Renew_All
  if _ContentsGroup_PearlShopMoonBlessingRenew == false then
    return false
  end
  local tempCnt = 0
  tempCnt = tempCnt + ToClient_GetMoonBlessingRewardCount(__eMoonBlessingRewardType_Rewarded)
  tempCnt = tempCnt + ToClient_GetMoonBlessingRewardCount(__eMoonBlessingRewardType_Progress)
  tempCnt = tempCnt + ToClient_GetMoonBlessingRewardCount(__eMoonBlessingRewardType_Complete)
  if tempCnt > 0 then
    return true
  end
  return false
end
function PaGlobal_MoonBlessing_ChangeConsumePearl(pearlValue)
  if false == PaGlobal_IngameCashShopMoonBlessing_Renew_All._isConsole then
    PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_OnResize()
  end
  local self = PaGlobal_IngameCashShopMoonBlessing_Renew_All
  self._showPearlPrice = Int64toInt32(pearlValue)
  if self.MILEAGE_TYPE.CONSUMED == self._nowMileageInfoKey then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(self._nowMileageInfoKey, self._nowTabInfoKey)
  else
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:update(self.MILEAGE_TYPE.CONSUMED)
  end
  if self._mileageInfoCnt == 0 then
    return
  end
  if false == PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_GetShow() then
    PaGlobal_IngameCashShopMoonBlessing_Renew_All:prepareOpen()
  end
  if self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED] == nil then
    return
  end
  local moveKey = self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED]:getIndexByKey(toInt64(0, self._nowProgressKeyGroup[self.MILEAGE_TYPE.CONSUMED]))
  self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED]:moveIndex(moveKey)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_CheckMileageRewarded()
  local totalCnt = 0
  if Defines.UIMode.eUIMode_ItemMarket == GetUIMode() then
    return totalCnt
  end
  totalCnt = PaGlobal_IngameCashShopMoonBlessing_Renew_All:checkMileageRewarded()
  return totalCnt
end
function HandleEventLUp_ShowMessage_RequestMoonBlessingPearlUsedReset()
  local self = PaGlobal_IngameCashShopMoonBlessing_Renew_All
  local currentResetCount = ToClient_GetCurrentMoonblessingResetCount()
  local maxResetCount = ToClient_GetCurrentMoonblessingMaxResetCount()
  local currentPossibleResetCount = maxResetCount - currentResetCount
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT"),
    content = PAGetString(Defines.StringSheet_GAME, "MOON_BLESSING_RESET_COUNT") .. " " .. tostring(currentPossibleResetCount),
    functionYes = HandleEventLUp_RequestMoonBlessingPearlUsedReset,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_RequestMoonBlessingPearlUsedReset()
  ToClient_ResetMoonBlessingReward()
end
function FromClient_ResetMoonBlessingSuccessNotify()
  PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Update(PaGlobal_IngameCashShopMoonBlessing_Renew_All.MILEAGE_TYPE.CONSUMED)
  PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Open()
end
