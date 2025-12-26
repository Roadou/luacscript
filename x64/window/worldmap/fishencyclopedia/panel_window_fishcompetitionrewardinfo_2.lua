function PaGlobal_FishCompetitionRewardInfo_Open()
  if Panel_Window_FishCompetitionRewardInfo == nil then
    return
  end
  PaGlobal_FishCompetitionRewardInfo:prepareOpen()
end
function PaGlobal_FishCompetitionRewardInfo_Close()
  if Panel_Window_FishCompetitionRewardInfo == nil or Panel_Window_FishCompetitionRewardInfo:GetShow() == false then
    return
  end
  PaGlobal_FishCompetitionRewardInfo:prepareClose()
end
function PaGlobal_FishCompetitionRewardInfo_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_FishCompetitionRewardInfo:createContent(content, key)
end
function HandleEventLUp_FishCompetitionRewardInfo_Tooltip(index, isHide)
  if PaGlobal_FishCompetitionRewardInfo._isConsole == false then
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
  local itemKey = PaGlobal_FishCompetitionRewardInfo._rewardItemKeyList[index]
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
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FishCompetitionRewardInfo, true, false)
  end
end
function HandleEventLUp_FishCompetitionRewardInfo_Tooltip(grade, index, isHide)
  if PaGlobal_FishCompetitionRewardInfo._isConsole == false then
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
  local itemKey = PaGlobal_FishCompetitionRewardInfo._rewardItemKeyList[grade][index]
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
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FishCompetitionRewardInfo, true, false)
  end
end
