function PaGlobalFunc_BoxReward_All_Open()
  PaGlobal_BoxReward_All:prepareOpen()
end
function PaGlobalFunc_BoxReward_All_Close()
  PaGlobal_BoxReward_All:prepareClose()
end
function PaGlobalFunc_BoxReward_All_IsOpen()
  if Panel_Widget_Reward_All == nil then
    return false
  end
  return Panel_Widget_Reward_All:GetShow()
end
function HandleEventOnOut_BoxReward_ShowSlotToolTip(isShow, index)
  if Panel_Widget_Reward_All == nil then
    return false
  end
  if isShow == nil or index == nil then
    return
  end
  if isShow == false then
    if PaGlobal_BoxReward_All._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local itemKey = PaGlobal_BoxReward_All._itemKeyList[index]
  if itemKey == nil then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemWrapper == nil then
    return
  end
  local slot = PaGlobal_BoxReward_All._slots[index]
  if slot == nil then
    return
  end
  if PaGlobal_BoxReward_All._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
  else
    Panel_Tooltip_Item_Show(itemWrapper, slot.icon, true, false)
  end
end
function FromClient_BoxReward_All_Open(uiType)
  if uiType == __eBoxItemUiType_GetRareItemByBattle then
    PaGlobal_BoxReward_All._ui.txt_GetRewardMain:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_BOSSREWARD_DESC1"))
  elseif uiType == __eBoxItemUiType_GetRareItem then
    PaGlobal_BoxReward_All._ui.txt_GetRewardMain:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_BOSSREWARD_DESC2"))
  elseif uiType == __eBoxItemUiType_EventPearlBox then
    PaGlobal_BoxReward_All._ui.txt_GetRewardMain:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_BOSSREWARD_DESC3"))
  else
    return
  end
  PaGlobalFunc_BoxReward_All_Open()
end
function PaGlobalFunc_BoxReward_All_Update(deltaTime)
  PaGlobal_BoxReward_All:update(deltaTime)
end
function PaGlobalFunc_BoxReward_ScrollUpdate(isRight)
  local scrollForce = 0.3
  PaGlobal_BoxReward_All._scrollIndex = UIScroll.ScrollEvent(PaGlobal_BoxReward_All._ui.frame_SlideBg, isRight, 1, PaGlobal_BoxReward_All._rewardRootingItemCount * scrollForce, PaGlobal_BoxReward_All._scrollIndex, 1)
  PaGlobal_BoxReward_All._ui.frame:UpdateContentScroll()
  local posX = 0 - PaGlobal_BoxReward_All._ui.frame:GetSizeX() / 11 * PaGlobal_BoxReward_All._scrollIndex
  PaGlobal_BoxReward_All._ui.frame_Content:SetPosXY(posX, PaGlobal_BoxReward_All._ui.frame_Content:GetPosY())
end
function PaGlobalFunc_BoxReward_ScrollBtnUpdate()
  PaGlobal_BoxReward_All._scrollIndex = PaGlobal_BoxReward_All._ui.frame_SlideBg:GetControlPos()
  PaGlobal_BoxReward_All._ui.frame:UpdateContentScroll()
  local posX = 0 - PaGlobal_BoxReward_All._ui.frame:GetSizeX() / 11 * PaGlobal_BoxReward_All._scrollIndex
  PaGlobal_BoxReward_All._ui.frame_Content:SetPosXY(posX, PaGlobal_BoxReward_All._ui.frame_Content:GetPosY())
end
