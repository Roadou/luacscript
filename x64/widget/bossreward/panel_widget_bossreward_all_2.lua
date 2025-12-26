function PaGlobalFunc_BossReward_Open()
  PaGlobal_BossReward:prepareOpen()
end
function PaGlobalFunc_BossReward_Close()
  PaGlobal_BossReward:prepareClose()
end
function HandleEventLUp_GetBossReward()
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  PaGlobal_BossReward:changeToGetRewardUI()
end
function PaGlobalFunc_BossReward_IsOpen()
  if Panel_Widget_BossLooting == nil then
    return false
  end
  return Panel_Widget_BossLooting:GetShow()
end
function HandleEventOnOut_BossReward_ShowSlotToolTip(isShow, index)
  if Panel_Widget_BossReward == nil or Panel_Widget_BossLooting == nil then
    return
  end
  if isShow == nil or index == nil then
    return
  end
  if isShow == false then
    if PaGlobal_BossReward._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local itemKey = PaGlobal_BossReward._itemKeyList[index]
  if itemKey == nil then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemWrapper == nil then
    return
  end
  local slot = PaGlobal_BossReward._slots[index]
  if slot == nil then
    return
  end
  if PaGlobal_BossReward._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
  else
    Panel_Tooltip_Item_Show(itemWrapper, slot.icon, true, false)
  end
end
function PaGlobalFunc_Finish_WorldBossItemLooting()
  ToClient_FinishWorldBossItemLooting()
end
