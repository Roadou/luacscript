function PaGlobal_FishCompetitionMyReward_Open()
  if Panel_Window_FishCompetitionMyReward == nil then
    return
  end
  PaGlobal_FishCompetitionMyReward:prepareOpen()
end
function PaGlobal_FishCompetitionMyReward_Close()
  if Panel_Window_FishCompetitionMyReward == nil or Panel_Window_FishCompetitionMyReward:GetShow() == false then
    return
  end
  PaGlobal_FishCompetitionMyReward:prepareClose()
end
function PaGlobal_FishCompetitionMyReward_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_FishCompetitionMyReward:createContent(content, key)
end
function HandleEventLUp_FishCompetitionMyReward_Tooltip(index, isHide, isTitleItem)
  if PaGlobal_FishCompetitionMyReward._isConsole == false then
    if isHide == true then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
  elseif _ContentsGroup_RenewUI == true then
    if true == Panel_Widget_Tooltip_Renew:GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
  elseif Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local myReward = ToClient_GetFishCompetitionMyReward(index)
  local itemKey = __eItemKeyUndefined
  if isTitleItem == true then
    itemKey = myReward:getRewardTitleKey()
  else
    itemKey = myReward:getRewardItemKey()
  end
  if itemKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemSSW == nil then
    return
  end
  if _ContentsGroup_RenewUI == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FishCompetitionMyReward, true, false)
  end
end
function FromClient_UpdateFishCompetitionMyReward()
  PaGlobal_FishCompetitionMyReward:update()
end
function PaGlobal_FishCompetitionMyReward_ReceiveReward()
  ToClient_RequestFishCompetitionReceiveReward()
end
