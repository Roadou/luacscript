function PaGlobalFunc_OceanSiegeResult_All_Close()
  local self = PaGlobal_Window_OceanSiegeResult_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_OceanSiegeResult_All_ReqestNewestSiegeHistory()
  local self = PaGlobal_Window_OceanSiegeResult_All
  if self == nil then
    return
  end
  self._requestSiegeHistory = true
  ToClient_reqestNewestSiegeHistory()
end
function FromClient_UpdateOceanSiegeResult()
  local self = PaGlobal_Window_OceanSiegeResult_All
  if self == nil then
    return
  end
  if self._requestSiegeHistory == false then
    return
  end
  self._requestSiegeHistory = false
  PaGlobalFunc_OceanSiegeResult_All_Open()
end
function PaGlobalFunc_OceanSiegeResult_All_Open(isRecord, historyIndex)
  local self = PaGlobal_Window_OceanSiegeResult_All
  if self == nil then
    return
  end
  self:prepareOpen(isRecord, historyIndex)
end
function PaGlobalFunc_OceanSiegeResult_All_RewardItemTooltip(isShow, historyIndex)
  local self = PaGlobal_Window_OceanSiegeResult_All
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
