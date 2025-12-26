function PaGlobalFunc_ExplorePoint_UsingInfo_Close()
  PaGlobal_ExplorePoint_UsingInfo:prepareClose()
end
function PaGlobalFunc_ExplorePoint_UsingInfo_Open()
  if _ContentsGroup_UsePadSnapping == true then
    return
  end
  PaGlobal_ExplorePoint_UsingInfo:prepareOpen()
end
function PaGlobalFunc_ExplorePoint_UsingInfo_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_ExplorePoint_UsingInfo:createContent(content, key)
end
function HandleEventLUp_ExplorePoint_UsingInfo_SetSearchType(searchType)
  if nil == Panel_Window_ExplorePoint_UsingInfo then
    return
  end
  PaGlobal_ExplorePoint_UsingInfo:setSearchType(searchType)
end
function HandleEventLOnOut_ExplorePoint_UsingInfo_SearchItem(isShow, s64_key)
  local self = PaGlobal_ExplorePoint_UsingInfo
  if self == nil or isShow == nil or s64_key == nil then
    return
  end
  local index = Int64toInt32(s64_key)
  local searchResultData = ToClient_getUserBaseExploreITemSearchResultWrapper(index)
  if searchResultData == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if itemSSW == nil then
    return
  end
  local content = self._ui._searchedResultList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  if isShow == false then
    self._lastMouseOnListIndex = nil
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if self._isPadMode == true then
    self._lastMouseOnListIndex = Int64toInt32(s64_key)
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, Panel_Window_ExplorePoint_UsingInfo, true, false)
end
function HandleEventOnOut_ExplorePoint_UsingInfo_MistakePointToolTip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if PaGlobal_ExplorePoint_UsingInfo == nil then
    return
  end
  TooltipSimple_Show(PaGlobal_ExplorePoint_UsingInfo._ui._txt_totalPoint, "", PAGetString(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_TOTALPOINT_TOOLTIP"))
end
