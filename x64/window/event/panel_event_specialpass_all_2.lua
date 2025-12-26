function PaGlobal_Event_SpecialPass_Open(passType)
  PaGlobal_SpecialPass._totalRewardOpenFlag = false
  if passType == nil then
    passType = PaGlobal_GetCurrentSpecialPass()
  end
  PaGlobal_SpecialPass:prepareOpen(passType)
end
function PaGlobal_Event_SpecialPass_Close()
  PaGlobal_SpecialPass:prepareClose()
end
function PaGlobal_GetSpecialPassKey(passType)
  if Panel_Event_SpecialPass_All == nil then
    return false
  end
  return ToClient_GetCurrentSpecialPassKey(passType)
end
function PaGlobal_GetCurrentSpecialPass()
  if Panel_Event_SpecialPass_All == nil then
    return nil
  end
  if PaGlobal_GetSpecialPassKey(__eSpecialPassContentType_Daily) ~= 0 then
    return __eSpecialPassContentType_Daily
  elseif PaGlobal_GetSpecialPassKey(__eSpecialPassContentType_Solare) ~= 0 then
    return __eSpecialPassContentType_Solare
  end
  return nil
end
function HandleEventOnOut_RewardItem_ShowSlotToolTip(passKey, isShow, isPassItem, idx)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if isShow == nil or idx == nil or isPassItem == nil then
    return
  end
  if isShow == false then
    if PaGlobal_SpecialPass._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local itemEnchantKey = ToClient_GetSpecialPassItemEnchantKey(passKey, isPassItem, idx)
  if itemEnchantKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    return
  end
  local slotBG = PaGlobal_SpecialPass._itemList[idx]
  if slotBG == nil then
    return
  end
  local itemBG
  if isPassItem == true then
    itemBG = UI.getChildControl(slotBG, "Static_ItemIcon_Special_BG")
  else
    itemBG = UI.getChildControl(slotBG, "Static_ItemIcon_Basic_BG")
  end
  if itemBG == nil then
    return
  end
  local control = UI.getChildControl(itemBG, "Static_IconSlot")
  if control == nil then
    return
  end
  if PaGlobal_JewelInven._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true, false)
  end
end
function HandleEventLUp_GetBasicReward(passKey, idx)
  if Panel_Event_SpecialPass_All == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  ToClient_RequestSpecialPassReward(passKey, false, idx)
end
function HandleEventLUp_GetPassReward(passKey, idx)
  if Panel_Event_SpecialPass_All == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  ToClient_RequestSpecialPassReward(passKey, true, idx)
end
function HandleEventLUp_ShowSpecialPassPearlShop(passType)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if PaGlobal_SpecialPass._ui.btn_PearlShop:GetShow() == false then
    return
  end
  if isGameServiceTypeConsole() == true then
    PaGlobal_Event_SpecialPass_Close()
    HandleEventLUp_MenuRemake_CashShop()
  elseif passType == __eSpecialPassContentType_Daily then
    PaGlobalFunc_EasyBuy_Open(92)
  elseif passType == __eSpecialPassContentType_Solare then
    PaGlobalFunc_EasyBuy_Open(138)
  end
end
function HandleEventLUp_OpenTotalReward()
  if PaGlobal_TotalReward_All_Open ~= nil then
    PaGlobal_TotalReward_All_Open()
    PaGlobal_SpecialPass._totalRewardOpenFlag = true
    PaGlobal_Event_SpecialPass_Close()
  end
end
function HandleEventLUp_ChangeSpecialPassType()
  PaGlobal_SpecialPass:updateItemSlotBG()
  PaGlobal_SpecialPass:updateItemSlots()
end
function PaGlobal_CheckifCloseByTotalReward()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  return PaGlobal_SpecialPass._totalRewardOpenFlag
end
function HandleEventLUp_SpecialPass_OpenRateViewByLink()
  PaGlobalFunc_Util_OpenRateView(PaGlobal_Event_SpecialPass_Close)
end
function HandleEventOnOut_SpecialPass_ChangeRateViewButtonText(isOn)
  if isOn == true then
    PaGlobal_SpecialPass._ui.txt_RateView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK_ON"))
  else
    PaGlobal_SpecialPass._ui.txt_RateView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK"))
  end
end
function HandleEventLUp_ToggleSpeicalPassType(passType)
  PaGlobal_SpecialPass:toggleSpecialPassType(passType)
end
