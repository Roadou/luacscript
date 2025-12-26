function PaGlobal_EncyclopediaNotice_Open()
  if Panel_Window_EncyclopediaNotice == nil then
    return
  end
  PaGlobal_EncyclopediaNotice:prepareOpen()
end
function PaGlobal_EncyclopediaNotice_Close()
  if Panel_Window_EncyclopediaNotice == nil or Panel_Window_EncyclopediaNotice:GetShow() == false then
    return
  end
  PaGlobal_EncyclopediaNotice:prepareClose()
end
function PaGlobal_EncyclopediaNotice_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_EncyclopediaNotice:createContent(content, key)
end
function FromClient_UpdateEncyclopediaNotice()
  PaGlobal_EncyclopediaNotice:update()
end
function HandleEventLUp_EncyclopediaNotice_Tooltip(index, isHide)
  if PaGlobal_EncyclopediaNotice._isConsole == false then
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
  local notice = ToClient_GetEncyclopediaNotice(index)
  if notice == nil then
    return
  end
  local encyclopedia = ToClient_GetFishEncyclopediaByKey(notice:getKey())
  if encyclopedia == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(encyclopedia:getItemKey()))
  if itemSSW == nil then
    return
  end
  if _ContentsGroup_RenewUI == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_EncyclopediaNotice, true, false)
  end
end
