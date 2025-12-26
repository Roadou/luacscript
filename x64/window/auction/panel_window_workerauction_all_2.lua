function FromClient_WorkerAuction_All_ResponseWorkerAuction()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if false == Panel_Window_WorkerAuction_All:GetShow() then
    HandleEventLUp_WorkerAuction_All_Open()
  elseif PaGlobal_WorkerAuction_All._ENUMTABINDEX_MYREGISTER ~= PaGlobal_WorkerAuction_All._selectedTab then
    PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
  else
    requestMyWorkerList()
  end
  PaGlobal_WorkerAuction_All._isResponseWorkerList = true
end
function FromClient_WorkerAuction_All_ResponseMyWorkerAuction()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
end
function FromClient_WorkerAuction_All_OnScreenResize()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All:onScreenResize()
end
function HandleEventLUp_WorkerAuction_All_Open()
  if nil == Panel_Window_WorkerAuction_All or true == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  PaGlobal_WorkerAuction_All:prepareOpen()
end
function HandleEventLUp_WorkerAuction_All_Close()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  PaGlobal_WorkerAuction_All:prepareClose()
end
function PaGlobalFunc_WorkerAuction_All_SetTempShow(isShow)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if nil == isShow or true == isShow then
    isShow = true
  else
    PaGlobal_WorkerAuction_All:AudioPostEvent(50, 3)
  end
  Panel_Window_WorkerAuction_All:SetShow(isShow)
end
function FromClient_WorkerAuction_All_UpdateMoney()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All:updateMoney()
end
function HandleEventLUp_WorkerAuction_All_TabButtonClick(idx)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if PaGlobal_WorkerAuction_All._selectedTab == idx then
    return
  end
  PaGlobal_WorkerAuction_All._selectedTab = idx
  PaGlobal_WorkerAuction_All._currentPage = 1
  PaGlobal_WorkerAuction_All._maxPage = 1
  for ii = 0, #PaGlobal_WorkerAuction_All._radioTabList do
    if ii == PaGlobal_WorkerAuction_All._selectedTab then
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(true)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_SELECTED)
      local selectBarSapnX = PaGlobal_WorkerAuction_All._radioTabList[ii]:GetSpanSize().x
      local selectBarSapnY = PaGlobal_WorkerAuction_All._ui._stc_SelectBar:GetSpanSize().y
      PaGlobal_WorkerAuction_All._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
      if ii == PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST then
        if _ContentsGroup_WorkerImprovement == true then
          ToClient_requestAllWorkerList()
        else
          RequestAuctionListPage(CppEnums.AuctionType.AuctionGoods_WorkerNpc)
        end
      elseif ii == PaGlobal_WorkerAuction_All._ENUMTABINDEX_MYREGISTER then
        requestMyWorkerList()
      else
        ToClient_CheckFilterWorkerNoList(PaGlobal_WorkerAuction_All._selectedRegionKeyRaw, PaGlobal_WorkerAuction_All._selectSortType)
        PaGlobal_WorkerAuction_All:update(idx)
      end
    else
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(false)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_BASE)
    end
  end
  PaGlobal_WorkerAuction_All:AudioPostEvent(51, 7)
  PaGlobal_WorkerSkillTooltip_All_Hide()
  PaGlobalFunc_WorkerAuction_All_SetListRegionCheck()
end
function HandleEventLUp_WorkerAuction_All_BuyWorker(workerIdx)
  if nil == Panel_Window_WorkerAuction_All or nil == workerIdx or workerIdx < 0 then
    return
  end
  PaGlobal_WorkerAuction_All._selectedWorker = workerIdx
  local workerInfo
  workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(workerIdx, true)
  if nil ~= workerInfo then
    PaGlobalFunc_WorkerAuction_All_SetTempShow(false)
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_BUYCONFIRM")
    local contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_BUYCONFIRM_TITLE", "level", tostring(workerInfo.level), "name", workerInfo.name, "price", makeDotMoney(workerInfo.maxPrice)) .. "<PAOldColor>"
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = PaGlobalFunc_WorkerAuction_All_BuyConfirm,
      functionCancel = PaGlobalFunc_WorkerAuction_All_SetTempShow,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobalFunc_WorkerAuction_All_BuyConfirm()
  if nil == Panel_Window_WorkerAuction_All or nil == PaGlobal_WorkerAuction_All._selectedWorker or PaGlobal_WorkerAuction_All._selectedWorker < 0 then
    return
  end
  PaGlobalFunc_WorkerAuction_All_SetTempShow(true)
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  local workerNoRaw = 0
  if _ContentsGroup_WorkerImprovement == true then
    workerNoRaw = auctionInfo:getAuctionFilteredWorkerNoByIndex(PaGlobal_WorkerAuction_All._selectedRegionKeyRaw, PaGlobal_WorkerAuction_All._selectSortType, PaGlobal_WorkerAuction_All._selectedWorker)
  else
    workerNoRaw = auctionInfo:getWorkerAuction(index)
  end
  auctionInfo:requestBuyItNowWorker(workerNoRaw, CppEnums.ItemWhereType.eMoneyInventory)
  PaGlobal_WorkerAuction_All._selectedWorker = nil
end
function HandleEventLUp_WorkerAuction_All_RegistWorker(workerIdx)
  if nil == Panel_Window_WorkerAuction_All or nil == workerIdx or workerIdx < 0 then
    return
  end
  local listCount = 0
  if _ContentsGroup_WorkerImprovement == true then
    listCount = ToClient_getMyNpcWorkerCount()
  elseif nil ~= PaGlobal_WorkerAuction_All._plantKey then
    listCount = ToClient_getPlantWaitWorkerListCount(PaGlobal_WorkerAuction_All._plantKey, 0)
  end
  if listCount <= 0 then
    if _ContentsGroup_WorkerImprovement == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_ONOTHER_TOWN_NO_WORKER"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_NOWORKER"))
    end
    return
  end
  PaGlobal_WorkerAuction_All._selectedWorker = workerIdx
  local workerInfo
  workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(workerIdx, false)
  if nil ~= workerInfo then
    do
      local transferType = 0
      local function requestRegist()
        PaGlobalFunc_WorkerAuction_All_SetTempShow(true)
        ToClient_requestRegisterNpcWorkerAuction(workerInfo.workerNo, transferType, workerInfo.maxPrice)
        PaGlobal_WorkerAuction_All._selectedWorker = nil
      end
      local titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_NAMING_INPUT_TITLE")
      local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_WORKERRESIST_AUCTION_DESC", "per", tostring(PaGlobal_WorkerAuction_All._config._REGIST_WORKER_FEE))
      local messageboxData = {
        title = titleString,
        content = contentString,
        functionYes = requestRegist,
        functionCancel = PaGlobalFunc_WorkerAuction_All_SetTempShow,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      PaGlobalFunc_WorkerAuction_All_SetTempShow(false)
      MessageBox.showMessageBox(messageboxData)
    end
  end
end
function HandleEventLUp_WorkerAuction_All_CancelRegistWorker(workerIdx)
  if nil == Panel_Window_WorkerAuction_All or nil == workerIdx or workerIdx < 0 then
    return
  end
  PaGlobal_WorkerAuction_All._selectedWorker = workerIdx
  local workerInfo
  workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(workerIdx, true)
  if nil ~= workerInfo then
    local function CancelRegistered_Worker()
      PaGlobalFunc_WorkerAuction_All_SetTempShow(true)
      ToClient_requestCancelRegisterMyWorkerAuction(workerInfo.workerNo)
      PaGlobal_WorkerAuction_All._selectedWorker = nil
    end
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANCELCONFIRM")
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANCELCONFIRM_TITLE", "level", workerInfo.level, "name", workerInfo.name) .. "<PAOldColor>"
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = CancelRegistered_Worker,
      functionCancel = PaGlobalFunc_WorkerAuction_All_SetTempShow,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    PaGlobalFunc_WorkerAuction_All_SetTempShow(false)
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_WorkerAuction_All_ReceiveMoney(workerIdx)
  if nil == Panel_Window_WorkerAuction_All or nil == workerIdx or workerIdx < 0 then
    return
  end
  local workerInfo
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(workerIdx, true)
  if nil == workerInfo then
    return
  end
  auctionInfo:requestPopWorkerPrice(workerInfo.workerNo, CppEnums.ItemWhereType.eMoneyInventory)
end
function PaGlobalFunc_WorkerAuction_All_ChangeTabByPad(idx)
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() or false == PaGlobal_WorkerAuction_All._isConsole then
    return
  end
  local resultTab = PaGlobal_WorkerAuction_All._selectedTab + idx
  if resultTab <= -1 then
    resultTab = 2
  elseif resultTab >= 3 then
    resultTab = 0
  else
    HandleEventLUp_WorkerAuction_All_TabButtonClick(resultTab)
    return
  end
  HandleEventLUp_WorkerAuction_All_TabButtonClick(resultTab)
end
function HandleEventLUp_WorkerAuction_All_ChangePage(changeValue)
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  if PaGlobal_WorkerAuction_All._selectedTab ~= PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST and PaGlobal_WorkerAuction_All._maxPage <= 1 then
    return
  end
  local pageIndex = PaGlobal_WorkerAuction_All._currentPage + changeValue
  if pageIndex < 1 then
    pageIndex = 1
  end
  if PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST == PaGlobal_WorkerAuction_All._selectedTab then
    if pageIndex < PaGlobal_WorkerAuction_All._currentPage then
      if _ContentsGroup_WorkerImprovement == true then
        PaGlobal_WorkerAuction_All._currentPage = pageIndex
        PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
        return
      elseif PaGlobal_WorkerAuction_All._isResponseWorkerList == true then
        PaGlobal_WorkerAuction_All._isResponseWorkerList = false
        RequestAuctionPrevPage()
      else
        return
      end
    elseif pageIndex > PaGlobal_WorkerAuction_All._currentPage then
      local haveNextPage = true
      if _ContentsGroup_WorkerImprovement == true then
        local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
        local listCount = auctionInfo:getAuctionFilteredWorkerNoListCount(PaGlobal_WorkerAuction_All._selectedRegionKeyRaw, PaGlobal_WorkerAuction_All._selectSortType)
        haveNextPage = listCount >= pageIndex * PaGlobal_WorkerAuction_All._config._maxSlotCount - (PaGlobal_WorkerAuction_All._config._maxSlotCount - 1)
        if haveNextPage == true then
          PaGlobal_WorkerAuction_All._currentPage = pageIndex
          PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
        end
        return
      else
        haveNextPage = 4 <= RequestGetAuctionInfo():getWorkerAuctionCount()
        if haveNextPage == true and PaGlobal_WorkerAuction_All._isResponseWorkerList == true then
          PaGlobal_WorkerAuction_All._isResponseWorkerList = false
          RequestAuctionNextPage()
        else
          return
        end
      end
    end
  elseif pageIndex >= PaGlobal_WorkerAuction_All._maxPage then
    pageIndex = PaGlobal_WorkerAuction_All._maxPage
  end
  if PaGlobal_WorkerAuction_All._currentPage == pageIndex then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  PaGlobal_WorkerAuction_All._currentPage = pageIndex
  PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
  ToClient_padSnapResetControl()
end
function HandleEventOnOut_WorkerAuction_All_ChangePage(isShow, slotidx, iconIdx, WorkerIdx, isRegisteredMyWorkerList)
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  if true == isShow then
    local slot = PaGlobal_WorkerAuction_All._slotList[slotidx]
    local workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(WorkerIdx, isRegisteredMyWorkerList)
    if nil ~= workerInfo then
      local skillSSW = workerInfo.workerWrapperLua:getSkillSSW(iconIdx - 1)
      local uiControl = slot.icon[iconIdx]
      local name = skillSSW:getName()
      local desc = skillSSW:getDescription()
      TooltipSimple_Show(uiControl, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc(slotidx, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local slot = PaGlobal_WorkerAuction_All._slotList[slotidx]
  if slot == nil then
    _PA_ASSERT(false, "HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc, slot \236\157\180 nil \236\158\133\235\139\136\235\139\164!")
    return
  end
  TooltipSimple_Show(slot.lv40SkillIcon, PAGetString(Defines.StringSheet_GAME, "LUA_40_WORKERSKILL_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_40_WORKERSKILL_TOOLTIP_ON"))
end
function FromClient_WorkerAuction_All_RegisterDone()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_REGISTCOMPLETE"))
  if _ContentsGroup_WorkerImprovement == true then
    PaGlobal_WorkerAuction_All:updateMyWorkerList(false)
  else
    RequestAuctionListPage(CppEnums.AuctionType.AuctionGoods_WorkerNpc)
  end
end
function FromClient_WorkerAuction_All_ReceiveMoneyDone()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_RECEIVE_PRICE"))
  requestMyWorkerList()
end
function FromClient_WorkerAuction_All_CancelRegistDone()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_COMPLETE_CANCELREGIST"))
  requestMyWorkerList()
end
function FromClient_WorkerAuction_All_BuyWorkerDone()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_BUYCOMPLETE"))
  if _ContentsGroup_WorkerImprovement == true then
    ToClient_requestAllWorkerList()
    PaGlobal_WorkerAuction_All._selectedRegionKeyRaw = 0
    PaGlobal_WorkerAuction_All:updateWorkerCount()
  else
    RequestAuctionListPage(CppEnums.AuctionType.AuctionGoods_WorkerNpc)
  end
end
function PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()
  if true == Panel_Widget_WorkerSkillTooltip_All:GetShow() then
    PaGlobal_WorkerSkillTooltip_All_Hide()
  end
end
function PaGlobalFunc_WorkerAuction_All_UpdateRegionList(contents, key)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  local idx = Int64toInt32(key)
  local territoryButton = UI.getChildControl(contents, "RadioButton_Territory")
  local territoryIcon = UI.getChildControl(territoryButton, "Static_Territory_Icon")
  local townButton = UI.getChildControl(contents, "RadioButton_Town")
  local count = UI.getChildControl(contents, "StaticText_Capacity")
  territoryButton:SetTextMode(__eTextMode_AutoWrap)
  territoryButton:SetPosX(5)
  townButton:SetTextMode(__eTextMode_AutoWrap)
  townButton:SetPosX(6)
  townButton:SetShow(false)
  count:SetShow(false)
  territoryIcon:SetShow(false)
  if idx < 100 then
    local territoryName = ToClient_getTerritoryNameByTerritoryKey(idx)
    territoryButton:SetText(territoryName)
    territoryButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerAuction_All_SelectTerritory(" .. idx .. ")")
    if PaGlobal_WareHouse_All ~= nil then
      territoryIcon:SetShow(true)
      PaGlobal_WareHouse_All:setTerritoryIcon(territoryIcon, idx)
    end
    territoryButton:SetShow(true)
    townButton:SetShow(false)
  else
    local regionKeyRaw = idx - self._separatorNumber
    local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
    if regionInfoWrapper == nil then
      return
    end
    local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
    local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
    local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
    townButton:SetText(regionInfoWrapper:getAreaName() .. " (" .. waitWorkerCount .. "/" .. maxWorkerCount .. ")")
    townButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerAuction_All_SelectTown(" .. regionKeyRaw .. ")")
    townButton:SetShow(true)
    territoryButton:SetShow(false)
    local selfPlayer = getSelfPlayer()
    local currentRegionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
    if currentRegionInfoWrapper == nil then
      return
    end
    townButton:SetCheck(regionKey == self._selectedRegionKeyRaw)
  end
end
function PaGlobalFunc_WorkerAuction_All_SelectTerritory(territoryKeyRaw)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  for index = 0, #PaGlobal_WorkerRandomSelect_All._territoryContentsOption do
    if PaGlobal_WorkerRandomSelect_All._territoryContentsOption[index] == true and territoryKeyRaw == index then
      local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, territoryKeyRaw))
      if uiContent ~= nil then
        UI.getChildControl(uiContent, "RadioButton_Territory"):SetCheck(self._selectedTerritoryKeyRaw == territoryKeyRaw)
      end
      self._ui._list2_region:getElementManager():toggle(toInt64(0, territoryKeyRaw))
      if self._selectedTerritoryKeyRaw == territoryKeyRaw then
        self._selectedTerritoryKeyRaw = nil
        if self._isConsole == true then
          ToClient_padSnapChangeToTarget(uiContent)
        end
        do return end
        break
      end
      self._selectedTerritoryKeyRaw = territoryKeyRaw
      do
        local heightIndex = self._ui._list2_region:getIndexByKey(toInt64(0, territoryKeyRaw))
        if self._isConsole == false then
          self._ui._list2_region:moveIndex(heightIndex)
        end
      end
      break
    end
  end
  self._ui._list2_region:getElementManager():refillKeyList()
end
function PaGlobalFunc_WorkerAuction_All_SelectTown(regionKeyRaw)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if regionKeyRaw == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerNotRegionSelected"))
    return
  end
  self._selectedRegionKeyRaw = regionKeyRaw
  self._currentPage = 1
  if self._selectedTab == self._ENUMTABINDEX_REGISTER then
    ToClient_CheckFilterWorkerNoList(self._selectedRegionKeyRaw, self._selectSortType)
  end
  self:update(self._selectedTab)
end
function HandleEventLUp_WorkerAuction_All_ComboSort()
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._ui._combo_Sort:ToggleListbox()
end
function HandleEventLUp_WorkerAuction_All_SetComboSort()
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  if self._selectSortType == self._ui._combo_Sort:GetSelectIndex() then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._selectSortType = self._ui._combo_Sort:GetSelectIndex()
  self._currentPage = 1
  if self._selectedTab == self._ENUMTABINDEX_REGISTER then
    ToClient_CheckFilterWorkerNoList(self._selectedRegionKeyRaw, self._selectSortType)
  end
  self:update(self._selectedTab)
end
function HandleEventLUp_WorkerAuction_All_ResetRegionSelect()
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  self._selectedRegionKeyRaw = 0
  self._currentPage = 1
  if self._selectedTab == self._ENUMTABINDEX_REGISTER then
    ToClient_CheckFilterWorkerNoList(self._selectedRegionKeyRaw, self._selectSortType)
  end
  self:update(self._selectedTab)
  self:setRegionData()
end
function PaGlobalFunc_WorkerAuction_All_getFilterWorkerNoByIndex(index)
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return 0
  end
  if self._selectedRegionKeyRaw == nil or self._selectSortType == nil then
    return 0
  end
  return ToClient_GetFilteredWorkerNoByIndex(self._selectedRegionKeyRaw, self._selectSortType, index)
end
function FromClient_ResponseAllWorkerList()
  if Panel_Window_WorkerAuction_All == nil then
    return
  end
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  if Panel_Window_WorkerAuction_All:GetShow() == false then
    HandleEventLUp_WorkerAuction_All_Open()
  elseif self._ENUMTABINDEX_MYREGISTER ~= self._selectedTab then
    self:update(self._selectedTab)
  else
    requestMyWorkerList()
  end
end
function PaGlobalFunc_WorkerAuction_All_SetListRegionCheck()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  if Panel_Window_WorkerAuction_All == nil then
    return
  end
  local self = PaGlobal_WorkerAuction_All
  if self == nil then
    return
  end
  local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, self._selectedRegionKeyRaw + self._separatorNumber))
  if uiContent ~= nil then
    UI.getChildControl(uiContent, "RadioButton_Town"):SetCheck(true)
  end
end
