function PaGlobal_ArtifactExchange_Open()
  PaGlobal_ArtifactsExchange:prepareOpen()
end
function PaGlobal_ArtifactExchange_Close()
  if Panel_Window_Artifacts_Exchange_LOG_All:GetShow() == false then
    PaGlobal_ArtifactsExchange:prepareClose()
  end
end
function PaGlobal_ArtifactExchange_GetShow()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return false
  end
  return Panel_Window_Artifacts_Exchange_All:GetShow()
end
function HandleEventLUp_SelectTab(isExchange)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  PaGlobal_ArtifactsExchange:selectTab(isExchange)
end
function PaGlobalFunc_ArtifactExchange_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:get():isLightStone() == true and ToClient_isLockItem(itemWrapper:getItemNoRaw()) == false then
    local find = false
    for idx, value in pairs(PaGlobal_ArtifactsExchange._exchangeAddedSlotNo) do
      if slotNo == value then
        find = true
      end
    end
    if find == false then
      return false
    end
  end
  return true
end
function PaGlobalFunc_ArtifactExchange_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_ArtifactsExchange
  if self == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  PaGlobal_ArtifactsExchange:insertExchangeItem(itemSSW, slotNo, inventoryType)
end
function PaGlobalFunc_ArtifactPurify_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  for idx, value in pairs(PaGlobal_ArtifactsExchange._purifyItemKeyList) do
    if value == nil then
      return true
    end
    local find = false
    if itemSSW:get()._key:getItemKey() == value then
      find = true
    end
    if find == true then
      return false
    end
  end
  return true
end
function PaGlobalFunc_ArtifactPurify_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_ArtifactsExchange
  if self == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  PaGlobal_ArtifactsExchange:selectPurifyCount(slotNo, itemWrapper, inventoryType)
end
function HandleEventOnOut_ArtifactExchange_ShowSlotToolTip(index, isShow)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if isShow == nil or index == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_FloatingTooltip_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local slot = PaGlobal_ArtifactsExchange._exchangeSlots[index]
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(slot.inventoryType, slot.slotNo)
  if itemWrapper == nil then
    return
  end
  if ToClient_isConsole() == true then
    if itemWrapper ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, slot.icon)
    end
  else
    Panel_Tooltip_Item_Show(itemWrapper, slot.icon, false, true)
  end
end
function HandleEventRUp_deleteFromExchangeSlot(index)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  if index == nil then
    return
  end
  local slot = PaGlobal_ArtifactsExchange._exchangeSlots[index]
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  PaGlobal_ArtifactsExchange:popExchangeSlot(index)
end
function HandleEventLUp_PushAllLightStone()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer():get()
  local inventorySize = selfPlayerWrapper:getInventorySlotCount(false)
  local availableCount = PaGlobal_ArtifactsExchange._exchangeSlotMaxCount - #PaGlobal_ArtifactsExchange._exchangeAddedSlotNo
  for slotNo = 0, inventorySize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil and itemSSW:get():isLightStone() == true and ToClient_isLockItem(itemWrapper:getItemNoRaw()) == false then
        local find = false
        for idx, value in pairs(PaGlobal_ArtifactsExchange._exchangeAddedSlotNo) do
          if slotNo == value then
            find = true
          end
        end
        if find == false then
          PaGlobal_ArtifactsExchange:insertExchangeItem(itemSSW, slotNo, CppEnums.ItemWhereType.eInventory)
          availableCount = availableCount - 1
        end
        if availableCount == 0 then
          return
        end
      end
    end
  end
  PaGlobal_ArtifactsExchange:changeExchangeRewardSlot()
end
function HandleEventLUp_Exchange()
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  if #PaGlobal_ArtifactsExchange._exchangeAddedSlotNo < 3 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInvalidLightStoneChangeCount"))
    return
  end
  PaGlobal_ArtifactsExchangeLog_Open()
end
function PaGlobalFunc_ArtifactExchange_Excute()
  if PaGlobal_ArtifactsExchange._ui.chk_ExchangeSkipAni:IsCheck() == false then
    PaGlobal_ArtifactsExchange._ui.stc_ExchangeEffect:AddEffect("fUI_Exchange_Stone_01B", false, 0, -42)
    audioPostEvent_SystemUi(10, 4)
  end
  PaGlobal_ArtifactsExchange._aniStart = true
  PaGlobal_ArtifactsExchange._isExchange = true
  PaGlobal_ArtifactsExchange._ui.chk_ExchangeSkipAni:SetIgnore(true)
  PaGlobal_ArtifactsExchange._ui.btn_PutInAll:SetIgnore(true)
  PaGlobal_ArtifactsExchange._ui.btn_Exchange:SetIgnore(true)
end
function HandleEventOnOut_ArtifactPurify_ShowSlotToolTip(isShow)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_FloatingTooltip_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local slot = PaGlobal_ArtifactsExchange._purifySlot
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(slot.inventoryType, slot.slotNo)
  if itemWrapper == nil then
    return
  end
  if ToClient_isConsole() == true then
    if itemWrapper ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, slot.icon)
    end
  else
    Panel_Tooltip_Item_Show(itemWrapper, slot.icon, false, true)
  end
end
function HandleEventRUp_deleteFromPurifySlot()
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  local slot = PaGlobal_ArtifactsExchange._purifySlot
  if slot == nil then
    return
  end
  if slot.slotNo == 0 then
    return
  end
  if slot.inventoryType == nil then
    return
  end
  PaGlobal_ArtifactsExchange:popPurifySlot()
end
function HandleEventOnOut_ArtifactExchangeReward_ShowSlotToolTip(isShow)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_FloatingTooltip_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local slot = PaGlobal_ArtifactsExchange._exchangeRewardSlot
  if slot == nil then
    return
  end
  local exchangeRewardSSW = getArtifactItemStaticStatusWrapper(true, 0, 0)
  if exchangeRewardSSW == nil then
    return
  end
  if ToClient_isConsole() == true then
    if exchangeRewardSSW ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, exchangeRewardSSW, Defines.TooltipTargetType.Item, slot.icon)
    end
  else
    Panel_Tooltip_Item_Show(exchangeRewardSSW, slot.icon, true, false)
  end
end
function PaGlobalFunc_Artifact_Purify_PushItem(count, slotNo, inventoryType)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local lightStoneType = PaGlobal_ArtifactsExchange:GetLightStoneType(itemSSW)
  if lightStoneType == nil then
    return
  end
  PaGlobal_ArtifactsExchange:insertPurifyItem(itemSSW, slotNo, inventoryType, lightStoneType, count)
end
function HandleEventOnOut_ArtifactPurifyReward_ShowSlotToolTip(isShow, lightStoneType)
  if Panel_Window_Artifacts_Exchange_All == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_FloatingTooltip_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local slot = PaGlobal_ArtifactsExchange._purifyRewardSlot
  if slot == nil then
    return
  end
  local purifyRewardSSW = getArtifactItemStaticStatusWrapper(false, lightStoneType, 1)
  if purifyRewardSSW == nil then
    return
  end
  if ToClient_isConsole() == true then
    if purifyRewardSSW ~= nil then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, purifyRewardSSW, Defines.TooltipTargetType.Item, slot.icon)
    end
  else
    Panel_Tooltip_Item_Show(purifyRewardSSW, slot.icon, true, false)
  end
end
function HandleEventLUp_Purify()
  if PaGlobal_ArtifactsExchange._aniStart == true then
    return
  end
  if PaGlobal_ArtifactsExchange._purifySlot.isEmpty == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemNeedNotExist"))
    return
  end
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, getMoneySlotNo())
  local myInvenMoney_s64 = toInt64(0, 0)
  if nil ~= moneyItemWrapper then
    myInvenMoney_s64 = moneyItemWrapper:get():getCount_s64()
  end
  if myInvenMoney_s64 < PaGlobal_ArtifactsExchange._needPurifyPrice then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMoneyIsLack"))
    return
  end
  if PaGlobal_ArtifactsExchange._ui.chk_PurifySkipAni:IsCheck() == false then
    PaGlobal_ArtifactsExchange._ui.stc_PurifyEffect:AddEffect("fUI_Exchange_Stone_01B", false, -2, -57)
    audioPostEvent_SystemUi(10, 4)
  end
  PaGlobal_ArtifactsExchange._aniStart = true
  PaGlobal_ArtifactsExchange._isExchange = false
  PaGlobal_ArtifactsExchange._ui.chk_PurifySkipAni:SetIgnore(true)
  PaGlobal_ArtifactsExchange._ui.btn_Purify:SetIgnore(true)
end
function ExchangeSlot_Scroll(isUp)
  if isUp == nil then
    local ctrlButton = UI.getChildControl(PaGlobal_ArtifactsExchange._ui.frame_VerticalScroll, "Frame_1_VerticalScroll_CtrlButton")
    if ctrlButton == nil then
      return
    end
    local standardPosY = PaGlobal_ArtifactsExchange._ui.frame_VerticalScroll:GetSizeY() * 0.25 - 10
    local posY = ctrlButton:GetPosY()
    if posY >= 0 and standardPosY > posY then
      if PaGlobal_ArtifactsExchange._scrollIndex ~= 0 then
        isUp = true
      end
    elseif PaGlobal_ArtifactsExchange._scrollIndex == 0 then
      isUp = false
    end
    if isUp == nil then
      return
    end
  end
  PaGlobal_ArtifactsExchange:updateExchangeSlot(isUp, false)
end
function ShowToolTip()
  if PaGlobal_ArtifactsExchange._isShowTooltip == true then
    PaGlobal_ArtifactsExchange._isShowTooltip = false
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobal_ArtifactsExchange._isShowTooltip = true
  end
end
function PaGlobalFunc_ClickedEvent_RateLink()
  if _ContentsOption_CH_Homepage == true then
    Panel_WebHelper_ShowToggle("PanelWindowArtifact")
    return
  end
  PaGlobalFunc_Util_OpenRateView(HandleClicked_CashShop_Close)
end
