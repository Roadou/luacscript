function PaGlobalFunc_RenewDropItem_Open()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  self._isWorldMapOpen = false
  self:prepareOpen()
end
function PaGlobalFunc_RenewDropItem_Close()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if self._isConsole == true and self._isWorldMapOpen == true then
    if PaGlobalFunc_ServantTransferList_All_GetShow == nil then
      return
    end
    if PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap == nil then
      return
    end
    PaGlobalFunc_WorldMap_SetIsTownMode(false)
    PaGlobalFunc_WorldMap_RingMenu_Open()
    PaGlobalFunc_WorldMap_BottomMenu_Open()
    PaGlobalFunc_WorldMap_TopMenu_Open()
    if PaGlobalFunc_RenewDropItem_GetShow() == true then
      WorldMapPopupManager:pop()
    end
  end
  self:prepareClose()
end
function PaGlobalFunc_RenewDropItem_GetShow()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return false
  end
  return Panel_Window_DropItem_All:GetShow()
end
function PaGlobalFunc_RenewDropItem_OnCreateHuntingGroundListContent(content, key)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or content == nil or key == nil then
    return
  end
  self:createHuntingGroundListContent(content, key)
end
function PaGlobalFunc_RenewDropItem_SortHuntingGroundList(sortOption)
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if self._currentMainCategoryKey == nil or self._currentSubCategoryKey == nil then
    return
  end
  if sortOption == nil or sortOption == __eDropUIRegionSortOpion_Name_Count then
    return
  end
  ToClient_sortDropUIRegionMap(sortOption)
  HandleEventLUp_RenewDropItem_SubCategoryButton(self._currentMainCategoryKey:get(), self._currentSubCategoryKey:get())
end
function PaGlobalFunc_RenewDropItem_SearchByConsole(str)
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  self._ui._edt_searchEditBox:SetEditText(str)
  self:doSearch(self._eSEARCH_TYPE.TEXT)
end
function PaGlobalFunc_RenewDropItem_Search()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  self:doSearch(self._eSEARCH_TYPE.TEXT)
end
function PaGlobalFunc_RenewDropItem_ClearSearchResult()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if self._currentMainCategoryKey == nil or self._currentSubCategoryKey == nil then
    return
  end
  self:clearSearchResult()
  HandleEventLUp_RenewDropItem_SubCategoryButton(self._currentMainCategoryKey:get(), self._currentSubCategoryKey:get())
end
function PaGlobalFunc_RenewDropItem_MoveMainCategory(isRight)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isRight == nil then
    return
  end
  if self._currentMainCategoryKey == nil then
    return
  end
  if self._mainCategoryDataList == nil then
    return
  end
  local currentIndex
  local min = 999
  local max = -999
  for index, value in pairs(self._mainCategoryDataList) do
    if value ~= nil then
      if self._currentMainCategoryKey:get() == value._key:get() then
        currentIndex = index
      end
      min = math.min(index, min)
      max = math.max(index, max)
    end
  end
  if currentIndex == nil then
    return
  end
  local nextIndex = currentIndex
  if isRight == true then
    nextIndex = nextIndex + 1
  else
    nextIndex = nextIndex - 1
  end
  if max < nextIndex then
    nextIndex = min
  elseif min > nextIndex then
    nextIndex = max
  end
  local nextMainCategoryData = self._mainCategoryDataList[nextIndex]
  if nextMainCategoryData ~= nil then
    self:changeMainCategory(nextMainCategoryData._key)
  end
end
function PaGlobalFunc_RenewDropItem_MoveSubCategory(isRight)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isRight == nil then
    return
  end
  if self._currentMainCategoryKey == nil or self._currentSubCategoryKey == nil then
    return
  end
  if self._subCategoryDataList == nil then
    return
  end
  local currentIndex
  local min = 999
  local max = -999
  for index, value in pairs(self._subCategoryDataList) do
    if value ~= nil and value._key ~= nil then
      if self._currentSubCategoryKey:get() == value._key:get() then
        currentIndex = index
      end
      min = math.min(index, min)
      max = math.max(index, max)
    end
  end
  if currentIndex == nil then
    return
  end
  local nextIndex = currentIndex
  if isRight == true then
    nextIndex = nextIndex + 1
  else
    nextIndex = nextIndex - 1
  end
  if max < nextIndex then
    nextIndex = min
  elseif min > nextIndex then
    nextIndex = max
  end
  local nextSubCategoryData = self._subCategoryDataList[nextIndex]
  if nextSubCategoryData ~= nil then
    self:changeSubCategory(self._currentMainCategoryKey, nextSubCategoryData._key)
  end
end
function PaGlobalFunc_RenewDropItem_SetFocusSearchEditBox()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  SetFocusEdit(self._ui._edt_searchEditBox)
end
function PaGlobalFunc_RenewDropItem_ShowSnappedItemTooltip()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  local isRealConsole = self._isConsole == true and ToClient_isConsole() == true
  if self._lastSnapItemInfo._huntingGroundKeyRaw == nil or self._lastSnapItemInfo._dropItemIndex == nil or self._lastSnapItemInfo._iconIndex == nil then
    if isRealConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(self._lastSnapItemInfo._huntingGroundKeyRaw)
  local huntingGroundSSW = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  if huntingGroundSSW == nil then
    return
  end
  local itemSSW = huntingGroundSSW:getDropItemStaticStatusWrapper(self._lastSnapItemInfo._dropItemIndex)
  if itemSSW == nil then
    return
  end
  if isRealConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  elseif itemSSW:isEquipable() == true then
    Panel_Tooltip_Item_Show(itemSSW, self._dropEquipableItemIconList[self._lastSnapItemInfo._iconIndex].itemSlot.icon, true, false)
  else
    Panel_Tooltip_Item_Show(itemSSW, self._dropEtcItemIconList[self._lastSnapItemInfo._iconIndex].itemSlot.icon, true, false)
  end
end
function PaGlobalFunc_RenewDropItem_FindCurrentHuntingGroundWay()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if self._currentHuntingGroundKey == nil then
    return
  end
  HandleEventLUp_RenewDropItem_FindHuntingGroundNavigation(self._currentHuntingGroundKey:get())
end
function HandleEventLUp_RenewDropItem_SortFilterComboBoxItem()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  local currentFilterIndex = self._ui._cbx_sortOption:GetSelectIndex()
  PaGlobalFunc_RenewDropItem_SortHuntingGroundList(currentFilterIndex)
end
function HandleEventLUp_RenewDropItem_SortFilterComboBox()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  self._ui._cbx_sortOption:ToggleListbox()
  if self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui._cbx_sortOption)
  end
end
function HandleEventLUp_RenewDropItem_MainCategoryButton(mainCategoryKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or mainCategoryKeyRaw == nil then
    return
  end
  self:clearSearchResult()
  local mainCategoryKey = DropUIMainCategoryKey(mainCategoryKeyRaw)
  self:onClickedMainCategoryButton(mainCategoryKey)
end
function HandleEventOnOut_RenewDropItem_MainCategoryButton(isShow, mainCategoryKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or mainCategoryKeyRaw == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local targetControl, name, desc
  for key, value in pairs(self._mainCategoryDataList) do
    if value ~= nil and value._key:get() == mainCategoryKeyRaw then
      targetControl = value._buttonControl
      break
    end
  end
  if targetControl == nil then
    return
  end
  local currentMainCategoryKey = DropUIMainCategoryKey(mainCategoryKeyRaw)
  local currentMainCategorySSW = ToClient_getDropUIMainCategoryStaticStatusWrapper(currentMainCategoryKey)
  if currentMainCategorySSW ~= nil then
    name = currentMainCategorySSW:getTerritoryName()
  else
    local allMainCategoryKey = ToClient_getDropUIAllMainCategoryKey()
    if allMainCategoryKey:get() == mainCategoryKeyRaw then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_CATEGORY_ALL")
    end
  end
  if name == nil or name == "" then
    return
  end
  TooltipSimple_Show(targetControl, name, desc)
end
function HandleEventOnOut_RenewDropItem_SubCategoryButton(isShow, mainCategoryKeyRaw, index)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or index == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local subCategoryDataIndex = index + 1
  local targetControl = self._subCategoryDataList[subCategoryDataIndex]._filterIcon
  local name, desc
  if targetControl == nil then
    return
  end
  if index == 0 then
    subCategoryKey = ToClient_getDropUIAllSubCategoryKey()
  else
    subCategoryKey = ToClient_getDropUISubCategoryKey(mainCategoryKeyRaw, index)
  end
  local subCategorySS = ToClient_getDropUISubCategoryStaticStatusWrapper(subCategoryKey)
  if subCategorySS ~= nil then
    name = subCategorySS:getCategoryName()
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_CATEGORY_ALL")
  end
  if name == nil or name == "" then
    return
  end
  TooltipSimple_Show(targetControl, name, desc)
end
function HandleEventLUp_RenewDropItem_SubCategoryButton(mainCategoryKeyRaw, subCategoryKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or mainCategoryKeyRaw == nil or subCategoryKeyRaw == nil then
    return
  end
  self:clearSearchResult()
  local mainCategoryKey = DropUIMainCategoryKey(mainCategoryKeyRaw)
  local subCategoryKey = DropUISubCategoryKey(subCategoryKeyRaw)
  self:onClickedSubCategoryButton(mainCategoryKey, subCategoryKey)
end
function HandleEventLUp_RenewDropItem_HuntingGroundButton(huntingGroundKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or huntingGroundKeyRaw == nil then
    return
  end
  self:selectHuntingGroundListContentByKey(huntingGroundKeyRaw, false)
end
function HandleEventDPadRight_RenewDropItem_HuntingGroundButton()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if self._isResetPadSnap == false then
    return
  end
  local snapTarget
  if self._dropEquipableItemIconList ~= nil then
    for key, value in pairs(self._dropEquipableItemIconList) do
      if value ~= nil and value.boxControl ~= nil and value.boxControl:GetShow() == true then
        snapTarget = value.boxControl
        break
      end
    end
  end
  if snapTarget == nil and self._dropEtcItemIconList ~= nil then
    for key, value in pairs(self._dropEtcItemIconList) do
      if value ~= nil and value.boxControl ~= nil and value.boxControl:GetShow() == true then
        snapTarget = value.boxControl
        break
      end
    end
  end
  if snapTarget ~= nil then
    ToClient_padSnapChangeToTarget(snapTarget)
    ToClient_padSnapResetControl()
    self._isResetPadSnap = false
  end
end
function HandleEventOnOut_RenewDropItem_DropItemIcon(isShow, huntingGroundKeyRaw, index, iconIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil then
    return
  end
  if self._isConsole == true then
    local stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Tooltip_Console")
    if isShow == true then
      self._lastSnapItemInfo._huntingGroundKeyRaw = huntingGroundKeyRaw
      self._lastSnapItemInfo._dropItemIndex = index
      self._lastSnapItemInfo._iconIndex = iconIndex
      stc_keyGuide_X:SetShow(true)
    else
      self._lastSnapItemInfo._huntingGroundKeyRaw = nil
      self._lastSnapItemInfo._dropItemIndex = nil
      self._lastSnapItemInfo._iconIndex = nil
      stc_keyGuide_X:SetShow(false)
      local isRealShow = true
      if self._isConsole == true and ToClient_isConsole() == true then
        if PaGlobalFunc_TooltipInfo_GetShow() == true then
          isRealShow = false
        end
      elseif Panel_Tooltup_Item_isShow() == true then
        isRealShow = false
      end
      if isRealShow == false then
        if self._isConsole == true and ToClient_isConsole() == true then
          PaGlobalFunc_TooltipInfo_Close()
        else
          Panel_Tooltip_Item_hideTooltip()
        end
      end
    end
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if huntingGroundKeyRaw == nil or index == nil then
    return
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  local huntingGroundSSW = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  if huntingGroundSSW == nil then
    return
  end
  local itemSSW = huntingGroundSSW:getDropItemStaticStatusWrapper(index)
  if itemSSW == nil then
    return
  end
  if itemSSW:isEquipable() == true then
    Panel_Tooltip_Item_Show(itemSSW, self._dropEquipableItemIconList[iconIndex].itemSlot.icon, true, false)
  else
    Panel_Tooltip_Item_Show(itemSSW, self._dropEtcItemIconList[iconIndex].itemSlot.icon, true, false)
  end
end
function HandleEventOnOut_RenewDropItem_DropItemIconForConsole(isShow, huntingGroundKeyRaw, index, iconIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil then
    return
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  local huntingGroundSSW = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  if huntingGroundSSW == nil then
    return
  end
  local itemSSW = huntingGroundSSW:getDropItemStaticStatusWrapper(index)
  if itemSSW == nil then
    return
  end
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif Panel_Tooltup_Item_isShow() == true then
    isShow = false
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_FloatingTooltip_Close()
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    if itemSSW:isEquipable() == true then
      Panel_Tooltip_Item_Show(itemSSW, self._dropEquipableItemIconList[iconIndex].itemSlot.icon, true, false)
    else
      Panel_Tooltip_Item_Show(itemSSW, self._dropEtcItemIconList[iconIndex].itemSlot.icon, true, false)
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEventOnOut_RenewDropItem_TagDetailInfo(isShow, tagIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or tagIndex == nil then
    return
  end
  if isShow == false then
    PaGlobalFunc_DropItemImageToolTip_Close()
    return
  end
  if self._currentHuntingGroundKey == nil then
    return
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    return
  end
  local tagKey = currentHuntingGroundSS:getTagKeyByIndex(tagIndex)
  local tagSSW = ToClient_getDropUITagStaticStatusWrapper(tagKey)
  if tagSSW == nil then
    return
  end
  local targetControl = self._tagIconList[tagIndex]
  if targetControl == nil then
    return
  end
  if targetControl.tagControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_TOOLTIP_TAG_TITLE")
  local desc = tagSSW:getTagTooltipDescString()
  local guideTextureId = tagSSW:getTagGuideTextureId()
  if desc == nil or desc == "" or guideTextureId == nil or guideTextureId == "" then
    return
  end
  PaGlobalFunc_DropItemImageToolTip_Open(name, desc, guideTextureId)
end
function HandleEventOnOut_RenewDropItem_TagInfo(isShow, tagIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or tagIndex == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if self._currentHuntingGroundKey == nil then
    return
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    return
  end
  local tagKey = currentHuntingGroundSS:getTagKeyByIndex(tagIndex)
  local tagSSW = ToClient_getDropUITagStaticStatusWrapper(tagKey)
  if tagSSW == nil then
    return
  end
  local targetControl = self._tagIconList[tagIndex]
  if targetControl == nil then
    return
  end
  if targetControl.tagControl == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEMUI_TOOLTIP_TAG_TITLE")
  local desc = tagSSW:getTagTooltipDescString()
  if desc == nil or desc == "" then
    return
  end
  TooltipSimple_Show(targetControl.tagControl, name, desc)
end
function HandleEventLUp_RenewDropItem_TagInfo(tagIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or tagIndex == nil then
    return
  end
  if self._currentHuntingGroundKey == nil then
    return
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    return
  end
  local tagKey = currentHuntingGroundSS:getTagKeyByIndex(tagIndex)
  local tagSSW = ToClient_getDropUITagStaticStatusWrapper(tagKey)
  if tagSSW == nil then
    return
  end
  self:doSearch(self._eSEARCH_TYPE.TAG, tagKey)
end
function HandleEventLUp_RenewDropItem_OpenAdventureNote(huntingGroundKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or huntingGroundKeyRaw == nil then
    return
  end
  if self._isWorldMapOpen == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_ALERT_WORLDMAP"))
    return
  end
  local key = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  local urlSSW = ToClient_getDropUIHuntingGroundURLStaticStatusWrapper(key)
  if urlSSW == nil then
    return
  end
  local noteLink = urlSSW:getUrl()
  if noteLink == nil or noteLink == "" then
    return
  end
  InputMLUp_ExpirienceWiki_All_Close()
  PaGlobal_ExpirienceWiki_All_SetDirectLink(noteLink)
  PaGlobal_ExpirienceWiki_All_Open()
end
function HandleEventLUp_RenewDropItem_FindHuntingGroundNavigation(huntingGroundKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or huntingGroundKeyRaw == nil then
    return
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  local huntingGroundSSW = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  if huntingGroundSSW == nil then
    return
  end
  local drawNaviKey = -1
  if huntingGroundSSW:isHaveNaviPosition() == true then
    local pos3D = huntingGroundSSW:getNaviPosition()
    ToClient_DeleteNaviGuideByGroup(0)
    drawNaviKey = ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), false, false)
  elseif huntingGroundSSW:isHaveRegionInfo() == true then
    local firstRegionKeyRaw = huntingGroundSSW:getRegionKeyRawByIndex(0)
    local regionInfo = getRegionInfoWrapper(firstRegionKeyRaw)
    if regionInfo == nil then
      return
    end
    if regionInfo:hasBaseWaypoint() == true then
      local pos3D = regionInfo:getPosition()
      ToClient_DeleteNaviGuideByGroup(0)
      drawNaviKey = ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), false, false)
    end
  else
    return
  end
  if drawNaviKey ~= -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
  end
end
function HandleEventLUp_RenewDropItem_KnowledgeTheme(themeKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or themeKeyRaw == nil then
    return
  end
  if self._isWorldMapOpen == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_ALERT_WORLDMAP"))
    return
  end
  if Process_UIMode_CommonWindow_MentalKnowledge == nil then
    return
  end
  Process_UIMode_CommonWindow_MentalKnowledge()
  local huntingGroundThemeKey = MentalThemeKey(themeKeyRaw)
  local themeSSW = ToClient_getMentalThemeStaticStatusWrapper(huntingGroundThemeKey)
  if themeSSW == nil then
    return
  end
  local isFindRootTheme = false
  local themeKeyArray = Array.new()
  local maxLoopCount = 10
  for index = 0, maxLoopCount - 1 do
    local parentThemeKey = themeSSW:getParentThemeKey()
    themeSSW = ToClient_getMentalThemeStaticStatusWrapper(parentThemeKey)
    if themeSSW == nil then
      isFindRootTheme = true
      break
    elseif _ContentsGroup_RenewUI_Knowledge == false then
      themeKeyArray:push_back(-parentThemeKey:get())
    else
      themeKeyArray:push_back(parentThemeKey:get())
    end
  end
  if isFindRootTheme == false then
    UI.ASSERT_NAME(false, "\236\167\128\236\139\157 \237\133\140\235\167\136\236\157\152 \236\181\156\236\131\129\236\156\132 \235\182\128\235\170\168\235\165\188 \236\176\190\236\167\128 \235\170\187\237\150\136\235\139\164. maxLoopCount\235\165\188 \235\141\148 \236\152\172\235\160\164\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local revertThemeKeyArray = Array.new()
  local themeKeyCount = #themeKeyArray
  for index = 0, themeKeyCount - 1 do
    revertThemeKeyArray:push_back(themeKeyArray[themeKeyCount - index])
  end
  if _ContentsGroup_RenewUI_Knowledge == false then
    revertThemeKeyArray:push_back(-huntingGroundThemeKey:get())
  else
    revertThemeKeyArray:push_back(huntingGroundThemeKey:get())
  end
  if _ContentsGroup_RenewUI_Knowledge == false then
    PaGlobal_Knowledge_SetSelectList(revertThemeKeyArray)
  else
    PaGlobalFunc_Window_Knowledge_SetSelectList(revertThemeKeyArray)
  end
end
function HandleEventLOnOut_RenewDropItem_DropRate(isShow, waypointKey)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or waypointKey == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local selfplayerActorProxyWrapper = getSelfPlayer()
  if selfplayerActorProxyWrapper == nil then
    return
  end
  local guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildNo_s64()
  if selfplayerActorProxyWrapper:isGuildAllianceMember() == true then
    guildNoOrAllianceNo = selfplayerActorProxyWrapper:getGuildAllianceNo_s64()
  end
  local nodName = ToClient_GetNodeNameByWaypointKey(waypointKey)
  if nodName == "" then
    nodName = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOTHING")
  end
  local nodeLevel = ToClient_GetNodeLevel(waypointKey)
  local minorSiegeRegionKey = ToClient_GetSiegeRegionKeyRawByWaypointKey(waypointKey)
  local regionKey = ToClient_GetRegionKeyRawByWaypointKey(waypointKey)
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(minorSiegeRegionKey)
  local currentNodeBuffPercent = ToClient_getNodeIncreaseItemDropPercent() * nodeLevel
  currentNodeBuffPercent = currentNodeBuffPercent / 10000
  if ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(minorSiegeRegionKey) == true then
    currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
  elseif ToClient_IsAppliedDropRateBuffSiege2024ByRegionKey(regionKey) == true then
    currentNodeBuffPercent = currentNodeBuffPercent * ToClient_getNodeIncreaseItemDropOccupyMinorSiegePercent() / 1000000
  end
  local control = self._ui._txt_dropRate
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_REGIONLEVELTOOLTIP_NAME")
  local desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_DROPITEM_REGIONLEVELTOOLTIP_DESC", "regionName", nodName, "level", nodeLevel, "percent", tostring(currentNodeBuffPercent))
  if ToClient_IsNodePurchased(waypointKey) == false then
    desc = desc .. "\n" .. "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_TXT_PERMISSION") .. "<PAOldColor>"
  end
  if control == nil or desc == nil or desc == "" then
    return
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLOnOut_RenewDropItem_Title(isShow, huntingGroundDropTitleIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or huntingGroundDropTitleIndex == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    return
  end
  local titleSSW = currentHuntingGroundSS:getDropTitleStaticStatusWrapper(huntingGroundDropTitleIndex)
  if titleSSW == nil then
    return
  end
  local control = self._dropTitleIconList[huntingGroundDropTitleIndex].buttonControl
  local name = ""
  local desc = titleSSW:getDescription()
  if control == nil or desc == nil or desc == "" then
    return
  end
  TooltipSimple_Show(control, name, desc, false)
end
function HandleEventLUp_RenewDropItem_Title(titleKeyRaw, titleCategory)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or titleKeyRaw == nil or titleCategory == nil then
    return
  end
  if self._isWorldMapOpen == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_ALERT_WORLDMAP"))
    return
  end
  if PaGlobalFunc_ChracterInfo_All_Link_Title == nil then
    return
  end
  PaGlobalFunc_ChracterInfo_All_Link_Title(titleKeyRaw, titleCategory)
end
function HandleEventLUp_RenewDropItem_RepeatQuest(groupNo, questNo)
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  if HandleClicked_QuestWidget_FindTarget == nil then
    return
  end
  local questSSW = questList_getQuestStatic(groupNo, questNo)
  if questSSW == nil then
    return
  end
  HandleClicked_QuestWidget_FindTarget(groupNo, questNo, 99, false)
end
function HandleEventOnOut_RenewDropItem_RepeatQuest(isShow, repeatQuestIconIndex)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or isShow == nil or repeatQuestIconIndex == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local currentHuntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(self._currentHuntingGroundKey)
  if currentHuntingGroundSS == nil then
    return
  end
  if self._dropRepeatQuestIconList[repeatQuestIconIndex].boxControl == nil then
    return
  end
  local control = self._dropRepeatQuestIconList[repeatQuestIconIndex].boxControl
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_ACCEPTCONDITION")
  local desc = currentHuntingGroundSS:getRepeatQuestAcceptConditionText(repeatQuestIconIndex)
  if desc == nil or desc == "" then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_RenewDropItem_OnResizePanel()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  self:recalcPanelPosition()
end
function FromClient_RenewDropItem_OnClearQuest()
  local self = PaGlobal_RenewDropItem_All
  if self == nil then
    return
  end
  self:updateHuntingGroundDetailInfo(false)
end
function FromClient_RenewDropItem_WorldMapMonsterIconMouseOn(worldMapIcon)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or worldMapIcon == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_DROPITEMUI_WORLDMAP")
  local desc
  TooltipSimple_Show(worldMapIcon, name, desc)
  if PaGlobalFunc_WorldMap_RingMenu_OnOutWorldMapMonsterInfo ~= nil then
    PaGlobalFunc_WorldMap_RingMenu_OnOutWorldMapMonsterInfo(true)
  end
end
function FromClient_RenewDropItem_WorldMapMonsterIconMouseOut(worldMapIcon)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or worldMapIcon == nil then
    return
  end
  TooltipSimple_Hide()
  if PaGlobalFunc_WorldMap_RingMenu_OnOutWorldMapMonsterInfo ~= nil then
    PaGlobalFunc_WorldMap_RingMenu_OnOutWorldMapMonsterInfo(false)
  end
end
function FromClient_RenewDropItem_WorldMapMonsterIconMouseLClick(worldMapIcon, huntingGroundKeyRaw)
  local self = PaGlobal_RenewDropItem_All
  if self == nil or worldMapIcon == nil or huntingGroundKeyRaw == nil then
    return
  end
  if self._isConsole == true then
    if PaGlobalFunc_WorldMap_TopMenu_GetShow() == false then
      return
    end
    if PaGlobalFunc_WorldMap_GetIsTownMode() == true then
      return
    end
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_DropItem_All, true)
    PaGlobalFunc_WorldMap_SetIsTownMode(false)
    PaGlobalFunc_WorldMap_RingMenu_Close()
    PaGlobalFunc_WorldMap_BottomMenu_Close()
    PaGlobalFunc_WorldMap_RightMenu_Close()
    PaGlobalFunc_WorldMap_TopMenu_Close()
  end
  local huntingGroundKey = DropUIHuntingGroundInfoKey(huntingGroundKeyRaw)
  local huntingGroundSSW = ToClient_getDropUIHuntingGroundStaticStatusWrapper(huntingGroundKey)
  if huntingGroundSSW == nil then
    return
  end
  local mainCategoryKey = huntingGroundSSW:getMainCategoryKey()
  local subCategoryKey
  if 0 < huntingGroundSSW:getSubCategoryCount() then
    subCategoryKey = huntingGroundSSW:getSubCategoryKeyByIndex(0)
  end
  TooltipSimple_Hide()
  self._isWorldMapOpen = true
  self:prepareOpen(mainCategoryKey, subCategoryKey, huntingGroundKey)
end
function FromClient_RenewDropItem_QuestBackEndLoadComplete(s32_questNoRaw)
  if Panel_Window_DropItem_All == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if Panel_Window_DropItem_All:GetShow() == false then
    return
  end
  if PaGlobal_RenewDropItem_All:isExistLoadingDataAnyOne() == false then
    return
  end
  local needUpdate = false
  for index = 1, #PaGlobal_RenewDropItem_All._questLoadingDataList do
    local value = PaGlobal_RenewDropItem_All._questLoadingDataList[index]
    if value ~= nil and value._questNoRaw == s32_questNoRaw then
      needUpdate = true
      table.remove(PaGlobal_RenewDropItem_All._questLoadingDataList, index)
      break
    end
  end
  if needUpdate == false then
    return
  end
  PaGlobal_RenewDropItem_All:updateHuntingGroundDetailInfo(false)
  return
end
function HandleEventLUp_RenewDropItem_ClickDetailInfo()
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    PaGlobalFunc_NotationAbility_ChangeViewTypeByCheckButton(PaGlobal_RenewDropItem_All._ui._chk_detailInfo)
  end
  PaGlobal_RenewDropItem_All:updateHuntingGroundDetailInfo(false)
  HandleEventOnOff_RenewDropItem_ClickDetailInfo(true)
end
function HandleEventOnOff_RenewDropItem_ClickDetailInfo(isOn)
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_RenewDropItem_All._ui._chk_detailInfo
    local name = ""
    local desc = ""
    if control:IsCheck() == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_EQUIPSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_DD")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_RECOMMAND_MONSTERATT_SUM")
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_RenewDropItem_NotationSetting()
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  PaGlobalFunc_NotationAbility_ToggleShow(Panel_Window_DropItem_All)
end
function HandleEventOnOff_RenewDropItem_NotationSetting(isOn)
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_RenewDropItem_All._ui._btn_notationSetting
    local childControl = UI.getChildControl(control, "Static_Icon")
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NOTATION_ABILITY_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    if _ContentsGroup_UsePadSnapping == true then
      desc = nil
    end
    TooltipSimple_Show(control, name, desc, childControl)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOff_RenewDropItem_APTooltip(isOn, index)
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  if PaGlobal_RenewDropItem_All._ui._chk_detailInfo:IsCheck() == false then
    TooltipSimple_Hide()
    return
  end
  if isOn == true then
    local lastValue = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NOTATION_ABILITY_TOTAL")
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_MAIN_WEAPON_DMG") .. "(" .. lastValue .. ")"
    local desc = ""
    if index == 1 then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_AWAKEN_WEAPON_DMG") .. "(" .. lastValue .. ")"
    elseif index == 2 then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEPOINT_REDUCEDAMAGEPOINT") .. "(" .. lastValue .. ")"
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOff_RenewDropItem_RecommandAPTooltip(isOn, index)
  if PaGlobal_RenewDropItem_All == nil then
    return
  end
  if true == PaGlobal_RenewDropItem_All._ui._chk_detailInfo:IsCheck() then
    if 1 == index then
      local control = PaGlobal_RenewDropItem_All._ui._txt_needAP
      local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_MYTOTALSTATSINFO_ATT")
      local desc = ""
      TooltipSimple_Show(control, name, desc)
    elseif 2 == index then
      local control = PaGlobal_RenewDropItem_All._ui._txt_needDP
      local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_MYTOTALSTATSINFO_DEF")
      local desc = ""
      TooltipSimple_Show(control, name, desc)
    else
      TooltipSimple_Hide()
    end
  elseif 1 == index then
    local control = PaGlobal_RenewDropItem_All._ui._txt_needAP
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_MYVIEWSTATSINFO_ATT")
    local desc = ""
    TooltipSimple_Show(control, name, desc)
  elseif 2 == index then
    local control = PaGlobal_RenewDropItem_All._ui._txt_needDP
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_MYVIEWSTATSINFO_DEF")
    local desc = ""
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
