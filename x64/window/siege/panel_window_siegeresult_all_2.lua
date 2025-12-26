function PaGlobalFunc_SiegeResult_All_Close()
  if PaGlobal_Window_SiegeResult_All == nil then
    return
  end
  PaGlobal_Window_SiegeResult_All:prepareClose()
end
function PaGlobalFunc_SiegeResult_All_ReqestNewestSiegeHistory()
  if PaGlobal_Window_SiegeResult_All == nil then
    return
  end
  PaGlobal_Window_SiegeResult_All._requestSiegeHistory = true
  ToClient_reqestNewestSiegeHistory()
end
function FromClient_UpdateSiegeResult()
  if PaGlobal_Window_SiegeResult_All._requestSiegeHistory == false then
    return
  end
  PaGlobal_Window_SiegeResult_All._requestSiegeHistory = false
  PaGlobalFunc_SiegeResult_All_Open()
end
function PaGlobalFunc_SiegeResult_All_Open(isRecord, historyIndex)
  if PaGlobal_Window_SiegeResult_All == nil then
    return
  end
  PaGlobal_Window_SiegeResult_All:prepareOpen(isRecord, historyIndex)
end
function PaGlobalFunc_SiegeResult_All_RewardItemTooltip(isShow, historyIndex)
  local self = PaGlobal_Window_SiegeResult_All
  if self == nil then
    return
  end
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
  if siegeHistoryWrapper == nil then
    return
  end
  local rewardItemEnchantKey = siegeHistoryWrapper:getRewardItemEnchantKey()
  if rewardItemEnchantKey ~= nil and rewardItemEnchantKey:getItemKey() ~= 0 then
    local rewardItemWarpper = getItemEnchantStaticStatus(rewardItemEnchantKey)
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, rewardItemWarpper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    else
      Panel_Tooltip_Item_Show(rewardItemWarpper, self._ui._rewardItemSlot.base.icon, true, false)
    end
  end
end
