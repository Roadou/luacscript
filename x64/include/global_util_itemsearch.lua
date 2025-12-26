function PaGlobalFunc_ShowSearchItemPanel(index, isOpen, searchType, control)
  if isOpen == true then
    local SearchingItemWrapper = ToClient_GetSearchingItemInfoByIndex(index, tonumber(searchType))
    if SearchingItemWrapper == nil then
      return
    end
    local itemEnchantKey = SearchingItemWrapper:getKey()
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if itemSSW == nil then
      return
    end
    if control == nil then
      return
    end
    Panel_Tooltip_Item_Show_ForSearch(itemSSW, true, false, control)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_SearchItemByName(chatMessage, chatMessageLength, itemSearchType)
  local filterText = string.sub(chatMessage, 1, chatMessageLength)
  ToClient_SerachItemListByName(filterText, itemSearchType)
end
