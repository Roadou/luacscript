function PaGlobal_ExplorePoint_UsingInfo:initialize()
  if self._initialize == true then
    return
  end
  self._isPadMode = _ContentsGroup_UsePadSnapping
  self._isConsole = self._isPadMode and ToClient_isConsole()
  self._sortArray[self._SEARCHTYPE.HOUSE] = {}
  self._sortArray[self._SEARCHTYPE.NODE] = {}
  self._sortArray[self._SEARCHTYPE.ITEM] = {}
  self:initialize_titleArea()
  self:initialize_radioButtonGroup()
  self:initialize_searchResultArea()
  self:initialize_bottomArea()
  self:setDefaultValue()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_titleArea()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_ExplorePoint_UsingInfo, "Static_TitleArea")
  local btn_close = UI.getChildControl(titleArea, "Button_Close")
  if self._isPadMode == true then
    btn_close:SetShow(false)
  else
    btn_close:SetShow(true)
    btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExplorePoint_UsingInfo_Close()")
  end
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_bottomArea()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  self._ui._stc_bottomArea = UI.getChildControl(Panel_Window_ExplorePoint_UsingInfo, "Static_BottomArea")
  self._ui._txt_usingPoint = UI.getChildControl(self._ui._stc_bottomArea, "StaticText_UsingPoint")
  self._ui._txt_totalPoint = UI.getChildControl(self._ui._stc_bottomArea, "StaticText_TotalPoint")
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_radioButtonGroup()
  local stc_radioButtonGroup = UI.getChildControl(Panel_Window_ExplorePoint_UsingInfo, "Static_RadioButtonGroup")
  self._ui._stc_selectBar = UI.getChildControl(stc_radioButtonGroup, "Static_SelectLine")
  self._ui._radioTabs[self._SEARCHTYPE.ITEM] = UI.getChildControl(stc_radioButtonGroup, "RadioButton_Tab_Item")
  self._ui._radioTabs[self._SEARCHTYPE.HOUSE] = UI.getChildControl(stc_radioButtonGroup, "RadioButton_Tab_House")
  self._ui._radioTabs[self._SEARCHTYPE.NODE] = UI.getChildControl(stc_radioButtonGroup, "RadioButton_Tab_Node")
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_searchResultArea()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  self._ui._searchedResultList = UI.getChildControl(Panel_Window_ExplorePoint_UsingInfo, "List2_SearchedResultList")
  self._ui._stc_emptyResult = UI.getChildControl(self._ui._searchedResultList, "StaticText_SearchNoResult")
  self:initialize_itemContent()
  self:initialize_houseContent()
  self:initialize_nodeContent()
  self._ui._searchedResultList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ExplorePoint_UsingInfo_CreateContent")
  self._ui._searchedResultList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_itemContent()
  local content = UI.getChildControl(self._ui._searchedResultList, "List2_2_Content")
  local subContent = UI.getChildControl(content, "SubContent_Item")
  local itemSlotBg = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local searchItemSlot = {}
  SlotItem.new(searchItemSlot, "SearchResult_ItemSlot_", 0, itemSlotBg, self._slotConfig)
  searchItemSlot:createChild()
  searchItemSlot:clearItem()
  searchItemSlot.icon:SetPosX(0)
  searchItemSlot.icon:SetPosY(0)
  searchItemSlot.icon:SetShow(false)
  searchItemSlot.border:SetSize(44, 44)
  local searchSilverSlot = {}
  SlotItem.new(searchSilverSlot, "SearchResult_SilverSlot_", 0, itemSlotBg, self._silverSlotConfig)
  searchSilverSlot:createChild()
  searchSilverSlot:clearItem()
  searchSilverSlot.icon:SetPosX(0)
  searchSilverSlot.icon:SetPosY(0)
  searchSilverSlot.icon:SetShow(false)
  searchSilverSlot.border:SetSize(44, 44)
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_houseContent()
end
function PaGlobal_ExplorePoint_UsingInfo:initialize_nodeContent()
end
function PaGlobal_ExplorePoint_UsingInfo:searchItemList()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  ToClient_DoExplorePointUsingItemSearch()
  local itemCount = ToClient_getUserBaseExplorePointItemSearchResultCount()
  local temp = {}
  local temp2 = {}
  self._itemType = {}
  local itemTypeIndex = 0
  for index = 0, itemCount - 1 do
    local searchResultData = ToClient_getUserBaseExploreITemSearchResultWrapper(index)
    if searchResultData == nil then
      return
    end
    local searchItemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
    if searchItemSSW == nil then
      return
    end
    local enchantLevel = searchItemSSW:get()._key:getEnchantLevel()
    local itemName = searchResultData:getItemName()
    if searchItemSSW:getItemType() == 1 and enchantLevel > 15 then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
    elseif enchantLevel > 0 and CppEnums.ItemClassifyType.eItemClassify_Accessory == searchItemSSW:getItemClassify() and (searchItemSSW:isSpecialEnchantItem() == false or searchItemSSW:isSpecialAccessory() == true) then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
    end
    local resultText
    local searchWhereType = searchResultData:getSearchWhereType()
    temp[index] = searchWhereType
    if itemTypeIndex > 0 then
      local iCheck = false
      for iIndex = 0, itemTypeIndex - 1 do
        if self._itemType[iIndex] == temp[index] then
          iCheck = true
        end
      end
      if false == iCheck then
        self._itemType[itemTypeIndex] = temp[index]
        temp2[itemTypeIndex] = index
        itemTypeIndex = itemTypeIndex + 1
      end
    else
      self._itemType[itemTypeIndex] = temp[index]
      temp2[itemTypeIndex] = index
      itemTypeIndex = itemTypeIndex + 1
    end
  end
  local sortString = {}
  local sIndex = 0
  for index = 0, itemCount - 1 do
    local nodeCheck = false
    if 0 == sIndex then
      sortString[sIndex] = {}
      sortString[sIndex][0] = index
      sIndex = sIndex + 1
    else
      for ii = 0, sIndex - 1 do
        for jj = 0, #sortString[ii] do
          if temp[index] == temp[sortString[ii][jj]] then
            sortString[ii][#sortString[ii] + 1] = index
            nodeCheck = true
            break
          end
        end
      end
      if false == nodeCheck then
        sortString[sIndex] = {}
        sortString[sIndex][0] = index
        sIndex = sIndex + 1
      end
    end
  end
  self._sortArray[self._SEARCHTYPE.ITEM] = {}
  local _index = 0
  local itemTypeIndex = 0
  if next(sortString) ~= nil then
    for index = 0, #sortString do
      for _, value in pairs(sortString[index]) do
        for jj = itemTypeIndex, #self._itemType do
          if temp[value] == self._itemType[jj] then
            self._sortArray[self._SEARCHTYPE.ITEM][_index] = 1000 + temp2[itemTypeIndex]
            itemTypeIndex = itemTypeIndex + 1
            _index = _index + 1
          end
        end
        self._sortArray[self._SEARCHTYPE.ITEM][_index] = value
        _index = _index + 1
      end
    end
  end
  self._searchResultCount[self._SEARCHTYPE.ITEM] = itemCount + itemTypeIndex
end
function PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  local houseCount = ToClient_GetMyHouseCount()
  local temp = {}
  self._houseType = {}
  local houseTypeIndex = 0
  for index = 0, houseCount - 1 do
    local searchResultData = ToClient_GetRentHouseByIndex(index)
    if searchResultData == nil then
      return
    end
    local houseStaticWrapper = searchResultData:getStaticStatus()
    local houseName = houseStaticWrapper:getName()
    local isMansion = houseStaticWrapper:isMansion()
    if isMansion == true then
      temp[index] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPLOREPOINT_USINGINFO_GREATHOUSE")
      if houseTypeIndex > 0 then
        local hCheck = false
        for hIndex = 0, houseTypeIndex - 1 do
          if self._houseType[hIndex] == temp[index] then
            hCheck = true
          end
        end
        if false == hCheck then
          self._houseType[houseTypeIndex] = temp[index]
          houseTypeIndex = houseTypeIndex + 1
        end
      else
        self._houseType[houseTypeIndex] = temp[index]
        houseTypeIndex = houseTypeIndex + 1
      end
    else
      temp[index] = houseStaticWrapper:getAffiliatedTownName()
      if houseTypeIndex > 0 then
        local hCheck = false
        for hIndex = 0, houseTypeIndex - 1 do
          if self._houseType[hIndex] == temp[index] then
            hCheck = true
          end
        end
        if false == hCheck then
          self._houseType[houseTypeIndex] = temp[index]
          houseTypeIndex = houseTypeIndex + 1
        end
      else
        self._houseType[houseTypeIndex] = temp[index]
        houseTypeIndex = houseTypeIndex + 1
      end
    end
  end
  local sortString = {}
  local sIndex = 0
  for index = 0, houseCount - 1 do
    local houseCheck = false
    if 0 == sIndex then
      sortString[sIndex] = {}
      sortString[sIndex][0] = index
      sIndex = sIndex + 1
    else
      for ii = 0, sIndex - 1 do
        for jj = 0, #sortString[ii] do
          if temp[index] == temp[sortString[ii][jj]] then
            sortString[ii][#sortString[ii] + 1] = index
            houseCheck = true
            break
          end
        end
      end
      if false == houseCheck then
        sortString[sIndex] = {}
        sortString[sIndex][0] = index
        sIndex = sIndex + 1
      end
    end
  end
  self._sortArray[self._SEARCHTYPE.HOUSE] = {}
  local _index = 0
  local houseTypeIndex = 0
  if next(sortString) ~= nil then
    for index = 0, #sortString do
      for _, value in pairs(sortString[index]) do
        for jj = houseTypeIndex, #self._houseType do
          if temp[value] == self._houseType[jj] then
            self._sortArray[self._SEARCHTYPE.HOUSE][_index] = 1000 + houseTypeIndex
            houseTypeIndex = houseTypeIndex + 1
            _index = _index + 1
          end
        end
        self._sortArray[self._SEARCHTYPE.HOUSE][_index] = value
        _index = _index + 1
      end
    end
  end
  self._searchResultCount[self._SEARCHTYPE.HOUSE] = houseCount + houseTypeIndex
end
function PaGlobal_ExplorePoint_UsingInfo:searchNodeList()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  ToClient_DoPurchasedNodeSearch()
  local nodeCount = ToClient_getPurchasedNodesCount()
  local temp = {}
  for index = 0, nodeCount - 1 do
    local searchResultData = ToClient_getPurchasedExplorationNode(index)
    if searchResultData == nil then
      return
    end
    local nodeStaticStatus = searchResultData:getStaticStatus()
    local regionInfo = nodeStaticStatus:getRegion()
    local regionKeyRaw = regionInfo._regionKey:get()
    local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
    if nil == regionInfoWrapper then
      return
    end
    temp[index] = {
      _territoryKeyRaw,
      _territoryName,
      _index,
      _nodeName,
      _regionKey
    }
    temp[index]._territoryName = regionInfoWrapper:getTerritoryName()
    temp[index]._territoryKeyRaw = regionInfoWrapper:getTerritoryKeyRaw()
    temp[index]._index = index
    if false == nodeStaticStatus._isMainNode then
      local parentNode = searchResultData:getLinkedNodeIndexZero()
      local parentNodeStatic = parentNode:getStaticStatus()
      local parentNodeName = parentNodeStatic:getName()
      local parentNodeRegionInfo = parentNodeStatic:getRegion()
      local pRegionInfoWrapper = getRegionInfoWrapper(parentNodeRegionInfo._regionKey:get())
      temp[index]._nodeName = parentNodeName .. " - " .. nodeStaticStatus:getName()
      temp[index]._regionKey = pRegionInfoWrapper:getRegionKey() + regionInfoWrapper:getRegionKey() / 10000
    else
      temp[index]._nodeName = nodeStaticStatus:getName()
      temp[index]._regionKey = regionInfoWrapper:getRegionKey()
    end
  end
  if ToClient_GetPalaceManageContentUsed() == true then
    local regionKeyRaw = Toclient_getPalaceManageRegionKeyRaw()
    local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
    temp[nodeCount] = {
      _territoryKeyRaw,
      _territoryName,
      _index,
      _nodeName,
      _regionKey
    }
    temp[nodeCount]._territoryName = regionInfoWrapper:getTerritoryName()
    temp[nodeCount]._territoryKeyRaw = regionInfoWrapper:getTerritoryKeyRaw()
    temp[nodeCount]._index = nodeCount
    temp[nodeCount]._nodeName = regionInfoWrapper:getAreaName()
    temp[nodeCount]._regionKey = regionInfoWrapper:getRegionKey()
    nodeCount = nodeCount + 1
  end
  local regionSort = function(a, b)
    return a._regionKey < b._regionKey
  end
  local territorySort = function(a, b)
    return a._territoryKeyRaw < b._territoryKeyRaw
  end
  table.sort(temp, territorySort)
  local temp1 = {}
  local index = 0
  local territoryMaxCount = __eTerritoryMaxCount
  for index = 0, territoryMaxCount - 1 do
    temp1[index] = {}
  end
  for index = 0, nodeCount - 1 do
    for tIndex = 0, territoryMaxCount - 1 do
      if temp[index]._territoryKeyRaw == tIndex then
        table.insert(temp1[tIndex], temp[index])
      end
    end
  end
  for index = 0, territoryMaxCount - 1 do
    if nil ~= temp1[index] then
      table.sort(temp1[index], regionSort)
    end
  end
  local _index = 0
  for index = 0, #temp1 do
    if nil ~= temp1[index] then
      for _, value in pairs(temp1[index]) do
        temp[_index] = value
        _index = _index + 1
      end
    end
  end
  local defaultTerritoryKey = -1
  local newIndex = 0
  for index = 0, nodeCount - 1 do
    if defaultTerritoryKey < 1000 + temp[index]._territoryKeyRaw then
      self._sortArray[self._SEARCHTYPE.NODE][newIndex] = 1000 + temp[index]._territoryKeyRaw
      defaultTerritoryKey = 1000 + temp[index]._territoryKeyRaw
      newIndex = newIndex + 1
      self._sortArray[self._SEARCHTYPE.NODE][newIndex] = temp[index]._index
    else
      self._sortArray[self._SEARCHTYPE.NODE][newIndex] = temp[index]._index
    end
    newIndex = newIndex + 1
  end
  self._searchResultCount[self._SEARCHTYPE.NODE] = newIndex
end
function PaGlobal_ExplorePoint_UsingInfo:setDefaultValue()
  self._searchResultCount = {
    [self._SEARCHTYPE.ITEM] = 0,
    [self._SEARCHTYPE.HOUSE] = 0,
    [self._SEARCHTYPE.NODE] = 0
  }
  self:setSearchType(self._SEARCHTYPE.HOUSE)
  local explorePoint = ToClient_getExplorePoint()
  if nil == explorePoint then
    return
  end
  local calcUsingPoint = ToClient_getItemTotalExplorePoint() + ToClient_getHouseTotalExplorePoint() + ToClient_getNodeTotalExplorePoint()
  if ToClient_GetPalaceManageContentUsed() == true then
    calcUsingPoint = calcUsingPoint + ToClient_GetPalaceManageExplorationPoint()
  end
  local remainedPoint = explorePoint:getRemainedPoint()
  local aquiredPoint = explorePoint:getAquiredPoint()
  local realUsingPoint = aquiredPoint - remainedPoint
  local mistakePoint = realUsingPoint - calcUsingPoint
  if mistakePoint >= 10 then
    self._ui._txt_totalPoint:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_TOTALPOINT_BOX", "leftPoint", remainedPoint, "totalPoint", aquiredPoint))
    self._ui._txt_totalPoint:addInputEvent("Mouse_On", "HandleEventOnOut_ExplorePoint_UsingInfo_MistakePointToolTip(true)")
    self._ui._txt_totalPoint:addInputEvent("Mouse_Out", "HandleEventOnOut_ExplorePoint_UsingInfo_MistakePointToolTip(false)")
  else
    self._ui._txt_totalPoint:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_TOTALPOINT", "leftPoint", remainedPoint, "totalPoint", aquiredPoint))
    self._ui._txt_totalPoint:addInputEvent("Mouse_On", "")
    self._ui._txt_totalPoint:addInputEvent("Mouse_Out", "")
  end
  self._ui._txt_totalPoint:SetSize(self._ui._txt_totalPoint:GetTextSizeX(), self._ui._txt_totalPoint:GetSizeY())
  self._ui._txt_totalPoint:ComputePos()
end
function PaGlobal_ExplorePoint_UsingInfo:registEventHandler()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  for index = 1, self._SEARCHTYPE.COUNT - 1 do
    self._ui._radioTabs[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ExplorePoint_UsingInfo_SetSearchType(" .. index .. ")")
  end
end
function PaGlobal_ExplorePoint_UsingInfo:setSearchType(searchType)
  self._currentSearchType = searchType
  for index = 1, self._SEARCHTYPE.COUNT - 1 do
    self._ui._radioTabs[index]:SetCheck(false)
  end
  self._ui._radioTabs[searchType]:SetCheck(true)
  local targetControl = self._ui._radioTabs[self._currentSearchType]
  local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2
  self._ui._stc_selectBar:SetPosX(selectBarPosX)
  if self._SEARCHTYPE.HOUSE == searchType then
    PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
    self._ui._txt_usingPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_HOUSEPOINT", "point", ToClient_getHouseTotalExplorePoint()))
  elseif self._SEARCHTYPE.NODE == searchType then
    PaGlobal_ExplorePoint_UsingInfo:searchNodeList()
    local nodeExpPoint = ToClient_getNodeTotalExplorePoint()
    if ToClient_GetPalaceManageContentUsed() == true then
      nodeExpPoint = nodeExpPoint + ToClient_GetPalaceManageExplorationPoint()
    end
    self._ui._txt_usingPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_NODEPOINT", "point", nodeExpPoint))
  elseif self._SEARCHTYPE.ITEM == searchType then
    PaGlobal_ExplorePoint_UsingInfo:searchItemList()
    self._ui._txt_usingPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_ITEMPOINT", "point", ToClient_getItemTotalExplorePoint()))
  end
  self:updateList(false)
end
function PaGlobal_ExplorePoint_UsingInfo:updateList(keepPositionAfterUpdate)
  local currentScrollIndex = self._ui._searchedResultList:getCurrenttoIndex()
  local currentControlPos = self._ui._searchedResultList:GetVScroll():GetControlPos()
  local listManager = self._ui._searchedResultList:getElementManager()
  listManager:clearKey()
  for index = 0, self._searchResultCount[self._currentSearchType] - 1 do
    if self._currentSearchType == self._SEARCHTYPE.HOUSE then
      if self._sortArray[self._currentSearchType][index] >= 1000 then
        listManager:pushKey(toInt64(0, self._sortArray[self._currentSearchType][index]))
      else
        local rentHouseSSW = ToClient_GetRentHouseByIndex(self._sortArray[self._currentSearchType][index])
        if rentHouseSSW == nil then
          return
        end
        local houseSSW = rentHouseSSW:getStaticStatus()
        if houseSSW == nil then
          return
        end
        if houseSSW:isMansion() == true then
          if houseSSW:isMansionLand() == true then
            listManager:pushKey(toInt64(0, self._sortArray[self._currentSearchType][index]))
          end
        else
          listManager:pushKey(toInt64(0, self._sortArray[self._currentSearchType][index]))
        end
      end
    else
      listManager:pushKey(toInt64(0, self._sortArray[self._currentSearchType][index]))
    end
  end
  if self._searchResultCount[self._currentSearchType] == 0 then
    self._ui._stc_emptyResult:SetShow(true)
  else
    self._ui._stc_emptyResult:SetShow(false)
  end
  if keepPositionAfterUpdate == true then
    self._ui._searchedResultList:setCurrenttoIndex(currentScrollIndex)
    self._ui._searchedResultList:GetVScroll():SetControlPos(currentControlPos)
  end
end
function PaGlobal_ExplorePoint_UsingInfo:prepareClose()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  PaGlobal_ExplorePoint_UsingInfo:close()
end
function PaGlobal_ExplorePoint_UsingInfo:close()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  Panel_Window_ExplorePoint_UsingInfo:SetShow(false)
end
function PaGlobal_ExplorePoint_UsingInfo:prepareOpen()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  self:recalcPanelPosition()
  PaGlobal_ExplorePoint_UsingInfo:setDefaultValue()
  PaGlobal_ExplorePoint_UsingInfo:searchHouseList()
  PaGlobal_ExplorePoint_UsingInfo:updateList(false)
  PaGlobal_ExplorePoint_UsingInfo:open()
end
function PaGlobal_ExplorePoint_UsingInfo:open()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  Panel_Window_ExplorePoint_UsingInfo:SetShow(true)
end
function PaGlobal_ExplorePoint_UsingInfo:validate()
  if Panel_Window_ExplorePoint_UsingInfo == nil then
    return
  end
  self._ui._stc_emptyResult:isValidate()
  self._ui._searchedResultList:isValidate()
end
function PaGlobal_ExplorePoint_UsingInfo:recalcPanelPosition()
  local panel = Panel_Window_ExplorePoint_UsingInfo
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = 0
  local calcPosY = 0
  calcPosX = screenCenterX - panelSizeX / 2
  calcPosY = screenCenterY - panelSizeY / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_ExplorePoint_UsingInfo:createContent(content, key)
  self:hideAllSubContent(content)
  if self._currentSearchType == self._SEARCHTYPE.ITEM then
    self:createItemContent(content, key)
  elseif self._currentSearchType == self._SEARCHTYPE.HOUSE then
    self:createHouseContent(content, key)
  elseif self._currentSearchType == self._SEARCHTYPE.NODE then
    self:createNodeContent(content, key)
  end
end
function PaGlobal_ExplorePoint_UsingInfo:hideAllSubContent(content)
  UI.getChildControl(content, "SubContent_Item"):SetShow(false)
  UI.getChildControl(content, "SubContent_House"):SetShow(false)
  UI.getChildControl(content, "SubContent_Node"):SetShow(false)
end
function PaGlobal_ExplorePoint_UsingInfo:createItemContent(content, key)
  if Panel_Window_ExplorePoint_UsingInfo == nil or content == nil or key == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  subContent:SetShow(true)
  local stc_bg = UI.getChildControl(subContent, "Static_Bg")
  local stc_itemSlotBg = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local stc_itemName = UI.getChildControl(subContent, "StaticText_ItemName")
  local stc_itemLocate = UI.getChildControl(subContent, "StaticText_Locate")
  local txt_explorePoint = UI.getChildControl(subContent, "StaticText_ContributePoint")
  local resultString = function(index)
    local searchResultData = ToClient_getUserBaseExploreITemSearchResultWrapper(index)
    if nil == searchResultData then
      return
    end
    local searchWhereType = searchResultData:getSearchWhereType()
    local resultText
    if searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventory then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventory then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_PEARL", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyEquipment then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_EQUIP_MY", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_FamilyInventory then
      resultText = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_FAMILLY")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherInventory then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherCashInventory then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_PEARL", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherEquipment then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_EQUIP", "character", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_WareHouse then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_WAREHOUSE", "region", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MarketWallet then
      resultText = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_MARKET")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventoryBag then
      local splitWhere = string.split(searchResultData:getWhereName(), ";")
      resultText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_BAG", "itemname", splitWhere[2], "character", splitWhere[1])
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventoryBag then
      local splitWhere = string.split(searchResultData:getWhereName(), ";")
      resultText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_PEARL_BAG", "itemname", splitWhere[2], "character", splitWhere[1])
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_BlackSpiritBag then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_BLACKBAG", "groupName", searchResultData:getWhereName())
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_JewelBag then
      resultText = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CRYSTALBTN_TOOLTIPNAME")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MoneyInventoryForUser then
      resultText = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_NewbieInventory then
      resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NEWBIEINVEN_TITLE")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_InstalledPersonalTent then
      resultText = PAGetString(Defines.StringSheet_GAME, "LUA_USINGEXPLOREPOINT_TENT")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_EnchantInventory then
      resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_ValksAdvice then
      resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_VALKSLIST")
    elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MaidActorEquipment then
      resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_MAIDACTOR_EQUIP", "character", searchResultData:getWhereName())
    else
      UI.ASSERT_NAME(false, "searchWhereType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \236\131\136\235\161\156\236\154\180 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\235\139\164\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
      return
    end
    return resultText
  end
  local index = Int64toInt32(key)
  if index >= 1000 then
    stc_bg:SetShow(false)
    stc_itemSlotBg:SetShow(false)
    stc_itemName:SetShow(false)
    stc_itemLocate:SetShow(true)
    txt_explorePoint:SetShow(false)
    stc_itemLocate:SetText(resultString(index - 1000))
    return
  end
  stc_bg:SetShow(true)
  stc_itemSlotBg:SetShow(true)
  stc_itemName:SetShow(true)
  stc_itemLocate:SetShow(false)
  txt_explorePoint:SetShow(true)
  local searchResultData = ToClient_getUserBaseExploreITemSearchResultWrapper(index)
  if searchResultData == nil then
    return
  end
  local searchItemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if searchItemSSW == nil then
    return
  end
  local itemSlotIcon = UI.getChildControl(stc_itemSlotBg, "Static_SearchResult_ItemSlot_")
  local silverSlotIcon = UI.getChildControl(stc_itemSlotBg, "Static_SearchResult_SilverSlot_")
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "SearchResult_ItemSlot_", 0, stc_itemSlotBg, self._slotConfig)
  itemSlot:clearItem()
  local isSealed = searchResultData:getItemIsSealed()
  local isVested = searchResultData:getItemIsVested()
  local isTradeAble = requestIsRegisterItemForItemMarket(searchResultData:getItemKey())
  if isVested == true or isTradeAble == false then
    isSealed = false
  end
  itemSlot:setItemByStaticStatus(searchItemSSW, searchResultData:getItemCount(), nil, nil, nil, nil, nil, nil, nil, nil, isSealed, nil, nil, true)
  itemSlotIcon:SetShow(true)
  silverSlotIcon:SetShow(false)
  itemSlot.border:SetSize(30, 30)
  itemSlot.icon:SetSize(28, 28)
  itemSlot.classEquipBG:SetPosXY(2, 15)
  itemSlot.count:SetPosXY(-9, 14)
  if self._isPadMode == false then
    itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_ExplorePoint_UsingInfo_SearchItem(true," .. tostring(key) .. ")")
    itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_ExplorePoint_UsingInfo_SearchItem(false," .. tostring(key) .. ")")
  else
    subContent:addInputEvent("Mouse_On", "HandleEventLOnOut_ExplorePoint_UsingInfo_SearchItem(true," .. tostring(key) .. ")")
    subContent:addInputEvent("Mouse_Out", "HandleEventLOnOut_ExplorePoint_UsingInfo_SearchItem(false," .. tostring(key) .. ")")
  end
  local itemGrade = searchItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  stc_itemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  stc_itemName:setLineCountByLimitAutoWrap(1)
  local enchantLevel = searchItemSSW:get()._key:getEnchantLevel()
  local itemName = searchResultData:getItemName()
  if searchItemSSW:getItemType() == 1 and enchantLevel > 15 then
    itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
  elseif enchantLevel > 0 and CppEnums.ItemClassifyType.eItemClassify_Accessory == searchItemSSW:getItemClassify() and (searchItemSSW:isSpecialEnchantItem() == false or searchItemSSW:isSpecialAccessory() == true) then
    itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
  end
  stc_itemName:SetText(itemName)
  stc_itemName:SetFontColor(itemGradeColor)
  local resultInt = searchItemSSW:getNeedExplorePoint() * Int64toInt32(searchResultData:getItemCount())
  txt_explorePoint:SetText(resultInt)
end
function PaGlobal_ExplorePoint_UsingInfo:createHouseContent(content, key)
  if Panel_Window_ExplorePoint_UsingInfo == nil or content == nil or key == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_House")
  subContent:SetShow(true)
  local stc_bg = UI.getChildControl(subContent, "Static_Bg")
  local stc_houseIcon = UI.getChildControl(subContent, "Static_HouseIcon")
  local stc_houseName = UI.getChildControl(subContent, "StaticText_HouseName")
  local txt_townName = UI.getChildControl(subContent, "StaticText_TownName")
  local txt_explorePoint = UI.getChildControl(subContent, "StaticText_ContributePoint")
  local index = Int64toInt32(key)
  if index >= 1000 then
    txt_townName:SetText(self._houseType[index - 1000])
    stc_bg:SetShow(false)
    stc_houseIcon:SetShow(false)
    stc_houseName:SetShow(false)
    txt_townName:SetShow(true)
    txt_explorePoint:SetShow(false)
    return
  end
  local searchResultData = ToClient_GetRentHouseByIndex(index)
  if searchResultData == nil then
    return
  end
  stc_bg:SetShow(true)
  stc_houseIcon:SetShow(true)
  stc_houseName:SetShow(true)
  txt_townName:SetShow(false)
  txt_explorePoint:SetShow(true)
  local houseStaticWrapper = searchResultData:getStaticStatus()
  local path = CppEnums.HouseIconType_SelectTexture.path
  local textureTarget = CppEnums.HouseIconType_SelectTexture[searchResultData:getIconType()]
  if textureTarget ~= nil then
    HouseProgressSection_SetBaseTextureUV(stc_houseIcon, path, textureTarget.x1, textureTarget.y1, textureTarget.x2, textureTarget.y2)
  else
    local emptyHouse = CppEnums.HouseIconType_SelectTexture[CppEnums.eHouseIconType.Count]
    HouseProgressSection_SetBaseTextureUV(stc_houseIcon, path, emptyHouse.x1, emptyHouse.y1, emptyHouse.x2, emptyHouse.y2)
  end
  if searchResultData:getUsingRecipeName() ~= nil then
    stc_houseName:SetText(houseStaticWrapper:getName() .. "(" .. searchResultData:getUsingRecipeName() .. ")")
  else
    stc_houseName:SetText(houseStaticWrapper:getName())
  end
  if houseStaticWrapper:isMansionLand() then
    txt_explorePoint:SetText(ToClient_getNeenPointMansion(houseStaticWrapper:getHouseKey()))
  else
    txt_explorePoint:SetText(houseStaticWrapper:getNeedExplorePoint())
  end
end
function PaGlobal_ExplorePoint_UsingInfo:createNodeContent(content, key)
  if Panel_Window_ExplorePoint_UsingInfo == nil or content == nil or key == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Node")
  subContent:SetShow(true)
  local stc_bg = UI.getChildControl(subContent, "Static_Bg")
  local stc_nodeIcon = UI.getChildControl(subContent, "Static_NodeIcon")
  local stc_nodeName = UI.getChildControl(subContent, "StaticText_NodeName")
  local txt_territoryName = UI.getChildControl(subContent, "StaticText_TerritoryName")
  local txt_explorePoint = UI.getChildControl(subContent, "StaticText_ContributePoint")
  local index = Int64toInt32(key)
  if index >= 1000 then
    stc_bg:SetShow(false)
    stc_nodeIcon:SetShow(false)
    stc_nodeName:SetShow(false)
    txt_territoryName:SetShow(true)
    txt_territoryName:SetText(getTerritoryInfoWrapper(index - 1000):getTerritoryName())
    txt_explorePoint:SetShow(false)
    return
  end
  stc_bg:SetShow(true)
  stc_nodeIcon:SetShow(true)
  stc_nodeName:SetShow(true)
  txt_territoryName:SetShow(false)
  txt_explorePoint:SetShow(true)
  local searchResultData, nodeStaticStatus
  local isRoyalCraftWorks = false
  local nodeCount = ToClient_getPurchasedNodesCount()
  if nodeCount == index then
    isRoyalCraftWorks = true
    local regionKeyRaw = Toclient_getPalaceManageRegionKeyRaw()
    local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
    if regionInfoWrapper == nil then
      return
    end
    nodeStaticStatus = regionInfoWrapper:getExplorationStaticStatusWrapper():get()
  else
    searchResultData = ToClient_getPurchasedExplorationNode(index)
    if searchResultData == nil then
      return
    end
    nodeStaticStatus = searchResultData:getStaticStatus()
  end
  if nodeStaticStatus == nil then
    return
  end
  local nodetype = nodeStaticStatus._nodeType
  if nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Normal then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Strongpoint")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_City then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Gate")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Viliage then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Gate")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Gate then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Gate")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Farm then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Farm")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Trade then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Trade")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Collect then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Gathering")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Quarry then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Quarry")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Dangerous then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_DangerArea")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Logging then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Felling")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Finance then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Exchange")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_FishTrap then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_FishTrap")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_MinorFinance then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_MinorExchange")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_MonopolyFarm then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_MonopolyFarm")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  elseif nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Craft then
    stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Production_complete")
    stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
  else
    if nodetype == CppEnums.ExplorationNodeType.eExplorationNodeType_Excavation then
      stc_nodeIcon:ChangeTextureInfoTextureIDAsync("Combine_Strongpoint_Icon_Production_Impossibility")
      stc_nodeIcon:setRenderTexture(stc_nodeIcon:getBaseTexture())
    else
    end
  end
  local regionInfo = nodeStaticStatus:getRegion()
  local regionKeyRaw = regionInfo._regionKey:get()
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  stc_nodeName:SetTextMode(__eTextMode_Limit_AutoWrap)
  stc_nodeName:setLineCountByLimitAutoWrap(1)
  if isRoyalCraftWorks == true then
    stc_nodeName:SetSize(410, stc_nodeName:GetSizeY())
    stc_nodeName:SetText(nodeStaticStatus:getName())
    stc_nodeIcon:SetPosX(10)
    stc_nodeName:SetPosX(55)
    stc_nodeName:SetText(nodeStaticStatus:getName() .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_TITLE"))
    if ToClient_GetPalaceManageContentUsed() == true then
      txt_explorePoint:SetText(ToClient_GetPalaceManageExplorationPoint())
    else
      txt_explorePoint:SetText("-")
    end
    return
  end
  if nodeStaticStatus._isMainNode == true then
    stc_nodeName:SetSize(410, stc_nodeName:GetSizeY())
    stc_nodeName:SetText(nodeStaticStatus:getName())
    stc_nodeIcon:SetPosX(10)
    stc_nodeName:SetPosX(55)
  else
    local parentNode = searchResultData:getLinkedNodeIndexZero()
    local parentNodeStatic = parentNode:getStaticStatus()
    stc_nodeName:SetSize(370, stc_nodeName:GetSizeY())
    stc_nodeName:SetText(parentNodeStatic:getName() .. " - " .. nodeStaticStatus:getName())
    stc_nodeIcon:SetPosX(50)
    stc_nodeName:SetPosX(95)
  end
  txt_explorePoint:SetText(nodeStaticStatus._needPoint)
end
function PaGlobal_ExplorePoint_UsingInfo:recalcPanelPosition()
  local panel = Panel_Window_ExplorePoint_UsingInfo
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = 0
  local calcPosY = 0
  calcPosX = screenCenterX - panelSizeX / 2
  calcPosY = screenCenterY - panelSizeY / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
