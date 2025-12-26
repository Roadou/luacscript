function HandleEventOnOut_WorkerRandomSelect_All_SimpleTooltips(tipType, isShow)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_DESC")
    control = PaGlobal_WorkerRandomSelect_All._ui._rdo_WareMoney
  end
  if isShow == true then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_WorkerRandomSelect_All_OnScreenResize()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  PaGlobal_WorkerRandomSelect_All:onScreenResize()
end
function HandleEventLUp_WorkerRandomSelect_All_Close(isDialogClose)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isConsole then
    if true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
      HandleEventLUp_WorkerRandomSelectOption_All_Close()
      return
    end
  elseif true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    HandleEventLUp_WorkerRandomSelectOption_All_CloseForConsole()
    return
  end
  if _ContentsGroup_UseCharacterWp == true and Panel_Window_UseCharacterWp_All:IsShow() == true then
    PaGlobalFunc_UseCharacterWp_All_Close()
  end
  PaGlobal_WorkerRandomSelect_All:prepareClose()
end
function HandleEventLUp_WorkerRandomSelect_All_ForceClose()
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
  end
  HandleEventLUp_WorkerRandomSelectOption_All_Close()
  HandleEventLUp_WorkerRandomSelect_All_Close()
end
function HandleEventLUp_WorkerRandomSelect_WorkerReSelect()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local pcPosition = getSelfPlayer():get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local region = regionInfo:get()
  local regionPlantKey = regionInfo:getPlantKeyByWaypointKey()
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  if waitWorkerCount == maxWorkerCount then
    local buyCash = function()
      PaGlobalFunc_EasyBuy_Open(16, getCurrentWaypointKey())
    end
    if isGameTypeKorea() and false == isGameServiceTypeConsole() and _ContentsGroup_EasyBuy then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"),
        functionYes = buyCash,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
    return
  end
  local wp = getSelfPlayer():getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local wpCharacterString = wp
  if _ContentsGroup_UseCharacterWp == true then
    wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect_Question") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_NOWWP", "getWp", wpCharacterString)
  local Worker_RequestShopList = function()
    if nil ~= getSelfPlayer() then
      local wp = getSelfPlayer():getWp()
      if _ContentsGroup_UseCharacterWp == true then
        wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
      end
      local isReselectAble = wp < 5
      if isReselectAble then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
        PaGlobal_WorkerRandomSelect_All:prepareClose()
      else
        npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
        if isReselectAble then
          if true == PaGlobal_WorkerRandomSelect_All._isConsole then
            Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
            Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
          else
            PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(false)
            PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(true)
            PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(false)
            PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(true)
          end
        elseif true == PaGlobal_WorkerRandomSelect_All._isConsole then
          Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
          Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
        else
          PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(true)
          PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(false)
          PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(true)
          PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(false)
        end
      end
      if true == PaGlobal_WorkerRandomSelect_All._isConsole then
        PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(not isReselectAble)
        PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(not isReselectAble)
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerRandomSelect_All._keyGuides, PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
    content = contentString,
    functionYes = Worker_RequestShopList,
    functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_WorkerRandomSelect_WorkerSelect()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == getSelfPlayer() or nil == PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx or nil == PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64 then
    return
  end
  if false == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    PaGlobal_WorkerRandomSelect_All:clearData()
  end
  local selfPlayer = getSelfPlayer()
  local myInvenMoney64 = selfPlayer:get():getMoneyInventory():getMoney_s64()
  local workeridx = PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx
  local workerPrice64 = PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64
  local function Worker_RequestDoBuy()
    local fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
    npcShop_doBuy(workeridx, 1, fromWhereType, 0, false)
    if false == PaGlobal_WorkerRandomSelect_All._isConsole then
      Panel_MyHouseNavi_Update(true)
    end
    PaGlobal_WorkerRandomSelect_All._currentWorkerinfo = {}
    PaGlobal_WorkerRandomSelect_All:prepareClose()
  end
  if myInvenMoney64 < workerPrice64 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEMANAGEMENT_ACK_MAKEBOOK"))
  else
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ"),
      content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ_Question"),
      functionYes = Worker_RequestDoBuy,
      functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_EventRandomShopShow_Worker(shopType, slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if 7 == shopType then
    if true == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
      PaGlobalFunc_WorkerRandomSelect_All_CheckCondition(slotNo)
    else
      PaGlobal_WorkerRandomSelect_All:prepareOpen()
      PaGlobal_WorkerRandomSelect_All:update(slotNo)
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_SetConfig(grade, count)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == grade or nil == count then
    return
  end
  Panel_Window_WorkerRandomSelect_All:RegisterUpdateFunc("PaGlobalFunc_WorkerRandomSelect_All_UpdatePerFrameFunc")
  PaGlobal_WorkerRandomSelect_All._config._workerGrade = grade
  PaGlobal_WorkerRandomSelect_All._config._repetitionCount = count
  PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = true
  if _ContentsGroup_WorkerImprovement == true then
    local characterIndex = 0
    if _ContentsGroup_UseCharacterWp == true then
      characterIndex = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
    end
    ToClient_GetRandomNpcWorkerAtRegion(PaGlobal_WorkerRandomSelect_All._selectedRegionKeyRaw, characterIndex)
  else
    npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
  end
  PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(false)
  if true == PaGlobal_WorkerRandomSelect_All._isConsole then
    PaGlobal_WorkerRandomSelect_All:switchKeyGuide(true)
  end
  PaGlobal_WorkerRandomSelect_All._ui._btn_HireWorker_PC:SetMonoTone(false)
  PaGlobal_WorkerRandomSelect_All._ui._btn_HireWorker_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_BTN_WORKERSELECT"))
end
function PaGlobalFunc_WorkerRandomSelect_All_CheckCondition(slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  local sellCount = npcShop_getBuyCount()
  local CurrentGradeFilter = PaGlobal_WorkerRandomSelect_All._config._workerGrade
  for index = 0, sellCount - 1 do
    local itemwrapper = npcShop_getItemBuy(index)
    local shopItem = itemwrapper:get()
    if slotNo == shopItem.shopSlotNo then
      local plantWorkerSS = itemwrapper:getPlantWorkerStaticStatus()
      local efficiency = plantWorkerSS:getEfficiency(2, ItemExchangeKey(0))
      local plantWorkerGrade = plantWorkerSS:getCharacterStaticStatus()._gradeType:get()
      local isFindWorker = false
      if 0 == CurrentGradeFilter then
        if 1 == plantWorkerGrade or 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 1 == CurrentGradeFilter then
        if 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 2 == CurrentGradeFilter then
        if 3 == plantWorkerGrade or 4 == plantWorkerGrade then
          isFindWorker = true
        end
      elseif 3 == CurrentGradeFilter and 4 == plantWorkerGrade then
        isFindWorker = true
      end
      local self = PaGlobal_WorkerRandomSelect_All
      if nil ~= plantWorkerSS then
        PaGlobal_WorkerRandomSelect_All:updateWp()
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo = {}
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx = shopItem.shopSlotNo
        PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64 = shopItem.price_s64
        local workerName = getWorkerName(plantWorkerSS)
        local workerNameByGrade = PaGlobal_WorkerRandomSelect_All:setNameByGrade(workerName, plantWorkerGrade)
        local workerIconPath = getWorkerIcon(plantWorkerSS)
        self:animateWorkerImage()
        self._ui._stc_WorkerImage[self._nextIndex]:ChangeTextureInfoNameAsync(workerIconPath)
        self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(self._gradePath)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTierBg[self._nextIndex], self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
        self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_WorkerTierBg[self._nextIndex]:setRenderTexture(self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture())
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerActionPoint:SetText(plantWorkerSS._actionPoint)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerLuck:SetText(plantWorkerSS._luck / 10000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerMoveSpeed:SetText(plantWorkerSS._moveSpeed / 100)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerSpeed:SetText(efficiency / 1000000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee:SetText(makeDotMoney(shopItem.price_s64))
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerName:SetText(workerNameByGrade)
        local workerFeeText = PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee
        local workerIcon = PaGlobal_WorkerRandomSelect_All._ui._icon_WorkerHireFee
        workerIcon:SetPosX(workerFeeText:GetPosX() + workerFeeText:GetSizeX() - workerFeeText:GetTextSizeX() - workerIcon:GetSizeX() - 5)
        PaGlobal_WorkerRandomSelect_All._config._repetitionCount = PaGlobal_WorkerRandomSelect_All._config._repetitionCount - 1
        PaGlobal_WorkerRandomSelect_All._Count = PaGlobal_WorkerRandomSelect_All._Count + 1
        if true == isFindWorker then
          PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = true
          PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = false
          PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(true)
          if true == PaGlobal_WorkerRandomSelect_All._isConsole then
            ToClient_padSnapResetControl()
            ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
            PaGlobal_WorkerRandomSelect_All:switchKeyGuide(false)
          end
          return
        else
          PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = false
        end
      end
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_UpdatePerFrameFunc(delta)
  if nil == Panel_Window_WorkerRandomSelect_All or false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  if true == PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition or false == PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart then
    return
  end
  PaGlobal_WorkerRandomSelect_All:SetBlockBg(true)
  if nil == PaGlobal_WorkerRandomSelect_All._delta_Time then
    PaGlobal_WorkerRandomSelect_All._delta_Time = 0
  end
  PaGlobal_WorkerRandomSelect_All._delta_Time = PaGlobal_WorkerRandomSelect_All._delta_Time + delta
  if PaGlobal_WorkerRandomSelect_All._delta_Time >= PaGlobal_WorkerRandomSelect_All._REFRESH_RATE then
    PaGlobal_WorkerRandomSelect_All._delta_Time = 0
    if 0 >= PaGlobal_WorkerRandomSelect_All._config._repetitionCount then
      PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition = true
      PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart = false
      PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(true)
      Panel_Window_WorkerRandomSelect_All:ClearUpdateLuaFunc()
      PaGlobal_WorkerRandomSelect_All:switchKeyGuide(false)
      PaGlobal_WorkerRandomSelect_All:SetBlockBg(false)
    elseif _ContentsGroup_WorkerImprovement == true then
      local characterIndex = 0
      if _ContentsGroup_UseCharacterWp == true then
        characterIndex = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
      end
      ToClient_GetRandomNpcWorkerAtRegion(PaGlobal_WorkerRandomSelect_All._selectedRegionKeyRaw, characterIndex)
    else
      npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_TempClose(isShow)
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  Panel_Window_WorkerRandomSelect_All:SetShow(isShow)
  if _ContentsGroup_WorkerImprovement == true and isShow == true then
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return
    end
    local currentRegionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
    if currentRegionInfoWrapper == nil then
      return
    end
    local treeElement = self._ui._list2_region:getElementManager():getByKey(toInt64(0, currentRegionInfoWrapper:getTerritoryKeyRaw()), false)
    if treeElement ~= nil then
      treeElement:setIsOpen(false)
    end
    local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, currentRegionInfoWrapper:getTerritoryKeyRaw()))
    if uiContent ~= nil then
      ToClient_padSnapChangeToTarget(uiContent)
    end
    if treeElement ~= nil then
      treeElement:setIsOpen(true)
    end
  end
  if self._isConsole == true then
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel()
  if false == PaGlobal_WorkerRandomSelect_All._isConsole then
    return
  else
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
  end
end
function PaGlobal_WorkerRandomSelect_All_SetSelectedRegionKey(regionKey)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  self._selectedRegionKeyRaw = regionKey
end
function FromClient_GetRandomNpcWorkerAtRegion(regionKey, characterKey)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._selectedRegionKeyRaw ~= regionKey:get() then
    _PA_ASSERT_NAME(false, "\236\132\160\237\131\157\237\149\156 \236\167\128\236\151\173\234\179\188 \236\132\160\237\131\157\235\144\156 \236\157\188\234\190\188\236\157\152 \236\167\128\236\151\173\236\157\180 \235\139\164\235\166\133\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
  end
  if self._isContinueSelectWorkerStart == true then
    PaGlobalFunc_WorkerRandomSelect_All_CheckConditionAtRegion(regionKey, characterKey)
    return
  end
  self:updateWorkerInfoAtRegion(regionKey, characterKey)
  if _ContentsGroup_UseCharacterWp == true then
    PaGlobalFunc_UseCharacterWp_All_UpdateWpList()
  end
end
function HandleEventLUp_WorkerRandomSelect_WorkerSelectAtRegion()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._isCurrectWorkerCondition == false or self._isContinueSelectWorkerStart == true then
    self:clearData()
    return
  end
  if self._selectedCharacterKey == nil or self._selectedRegionKeyRaw == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local plantWorkerSelectSS = ToClient_GetPlantWorkerSelectStaticStatus(self._selectedRegionKeyRaw, self._selectedCharacterKey)
  if plantWorkerSelectSS == nil then
    return
  end
  local myInvenMoney64 = selfPlayer:get():getMoneyInventory():getMoney_s64()
  local workerPrice64 = plantWorkerSelectSS:getPrice()
  local function Worker_RequestDoBuy()
    if self._selectedRegionKeyRaw == nil or self._selectedCharacterKey == nil then
      return
    end
    ToClient_RegistNpcWorkerAtRegion(self._selectedRegionKeyRaw, self._selectedCharacterKey)
    if false == self._isConsole then
      Panel_MyHouseNavi_Update(true)
    end
  end
  if myInvenMoney64 < workerPrice64 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEMANAGEMENT_ACK_MAKEBOOK"))
  else
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ"),
      content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Employ_Question"),
      functionYes = Worker_RequestDoBuy,
      functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._isCurrectWorkerCondition == false or self._isContinueSelectWorkerStart == true then
    self:clearData()
    return
  end
  if self._selectedRegionKeyRaw == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local regionKeyRaw = self._selectedRegionKeyRaw
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if regionInfoWrapper == nil then
    return
  end
  local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
  if regionPlantKey == nil then
    return
  end
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  local waypointKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  if waitWorkerCount == maxWorkerCount then
    local function buyCash()
      if PaGlobalFunc_EasyBuy_Open ~= nil and waypointKey ~= nil then
        PaGlobalFunc_EasyBuy_Open(16, waypointKey)
      end
    end
    if isGameServiceTypeConsole() == false and _ContentsGroup_EasyBuy then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"),
        functionYes = buyCash,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
    return
  end
  local wp = getSelfPlayer():getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local wpCharacterString = wp
  if _ContentsGroup_UseCharacterWp == true then
    wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect_Question") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_NOWWP", "getWp", wpCharacterString)
  local function Worker_RequestShopList()
    local wp = getSelfPlayer():getWp()
    if _ContentsGroup_UseCharacterWp == true then
      wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
    end
    local isReselectAble = wp < 5
    if isReselectAble then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
      self:prepareClose()
    else
      local characterIndex = 0
      if _ContentsGroup_UseCharacterWp == true then
        characterIndex = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
      end
      ToClient_GetRandomNpcWorkerAtRegion(self._selectedRegionKeyRaw, characterIndex)
    end
    if self._isConsole == true then
      self._ui._stc_KeyGuide_X_With_RT:SetShow(not isReselectAble)
      self._ui._stc_KeyGuide_X:SetShow(not isReselectAble)
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
    content = contentString,
    functionYes = Worker_RequestShopList,
    functionCancel = PaGlobalFunc_WorkerRandomSelect_All_SetSnapToThisPanel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_WorkerRandomSelect_All_CheckConditionAtRegion(regionKey, characterKey)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if Panel_Window_WorkerRandomSelect_All == nil or Panel_Window_WorkerRandomSelect_All:GetShow() == false then
    return
  end
  self._selectedCharacterKey = characterKey
  local plantWorkerSS = ToClient_GetPlantWorkerStaticStatus(characterKey)
  if plantWorkerSS == nil then
    return
  end
  local CurrentGradeFilter = PaGlobal_WorkerRandomSelect_All._config._workerGrade
  local efficiency = plantWorkerSS:getEfficiency(2, ItemExchangeKey(0))
  local plantWorkerGrade = plantWorkerSS:getCharacterStaticStatus()._gradeType:get()
  local isFindWorker = false
  if CurrentGradeFilter == 0 then
    if 1 == plantWorkerGrade or 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
      isFindWorker = true
    end
  elseif CurrentGradeFilter == 1 then
    if 2 == plantWorkerGrade or 3 == plantWorkerGrade or 4 == plantWorkerGrade then
      isFindWorker = true
    end
  elseif CurrentGradeFilter == 2 then
    if 3 == plantWorkerGrade or 4 == plantWorkerGrade then
      isFindWorker = true
    end
  elseif CurrentGradeFilter == 3 and 4 == plantWorkerGrade then
    isFindWorker = true
  end
  self._config._repetitionCount = self._config._repetitionCount - 1
  self._Count = self._Count + 1
  local regionKeyRaw = regionKey:get()
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if regionInfoWrapper == nil then
    return
  end
  local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
  if regionPlantKey == nil then
    return
  end
  local plantWorkerSS = ToClient_GetPlantWorkerStaticStatus(characterKey)
  if plantWorkerSS == nil then
    return
  end
  local plantWorkerSelectSS = ToClient_GetPlantWorkerSelectStaticStatus(regionKeyRaw, characterKey)
  if plantWorkerSelectSS == nil then
    return
  end
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  local hierableWorkerCount = maxWorkerCount - waitWorkerCount
  local buyPrice_s64 = plantWorkerSelectSS:getPrice()
  self._ui._txt_WorkerEmployCount:SetText(hierableWorkerCount)
  self._ui._txt_WorkerHireFee:SetText(makeDotMoney(buyPrice_s64))
  self:updateMoney()
  self:updateWp()
  local workerName = getWorkerName(plantWorkerSS) .. "(" .. regionInfoWrapper:getAreaName() .. ")"
  local workerNameByGrade = self:setNameByGrade(workerName, plantWorkerGrade)
  local workerIconPath = getWorkerIcon(plantWorkerSS)
  self:animateWorkerImage()
  self._ui._stc_WorkerImage[self._nextIndex]:ChangeTextureInfoNameAsync(workerIconPath)
  self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(self._gradePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTierBg[self._nextIndex], self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
  self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_WorkerTierBg[self._nextIndex]:setRenderTexture(self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture())
  self._ui._txt_WorkerActionPoint:SetText(plantWorkerSS._actionPoint)
  self._ui._txt_WokrerLuck:SetText(plantWorkerSS._luck / 10000)
  self._ui._txt_WokrerMoveSpeed:SetText(plantWorkerSS._moveSpeed / 100)
  self._ui._txt_WorkerSpeed:SetText(efficiency / 1000000)
  self._ui._txt_WorkerName:SetText(workerNameByGrade)
  UI.setLimitTextAndAddTooltip(self._ui._txt_WorkerName, self._ui._txt_WorkerName:GetText(), "")
  local workerFeeText = self._ui._txt_WorkerHireFee
  local workerIcon = self._ui._icon_WorkerHireFee
  workerIcon:SetPosX(workerFeeText:GetPosX() + workerFeeText:GetSizeX() - workerFeeText:GetTextSizeX() - workerIcon:GetSizeX() - 5)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local isReselectAble = wp >= 5
  if isReselectAble == false then
    if self._isConsole == true then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    else
      self._ui._btn_OtherWorker_PC:SetEnable(false)
      self._ui._btn_OtherWorker_PC:SetMonoTone(true)
      self._ui._btn_Continuation_PC:SetEnable(false)
      self._ui._btn_Continuation_PC:SetMonoTone(true)
    end
  elseif self._isConsole == true then
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()")
  else
    self._ui._btn_OtherWorker_PC:SetEnable(true)
    self._ui._btn_OtherWorker_PC:SetMonoTone(false)
    self._ui._btn_Continuation_PC:SetEnable(true)
    self._ui._btn_Continuation_PC:SetMonoTone(false)
  end
  if isFindWorker == true then
    self._isCurrectWorkerCondition = true
    self._isContinueSelectWorkerStart = false
    self:setButtonWhilePerFrame(true)
    if self._isConsole == true then
      self:switchKeyGuide(false)
    end
    self:SetBlockBg(false)
    return
  else
    self._isCurrectWorkerCondition = false
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_OpenRegionSelect()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  self:setRegionData()
  self:prepareOpen()
end
function PaGlobalFunc_WorkerRandomSelect_All_UpdateRegionList(contents, key)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
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
    territoryButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerRandomSelect_All_SelectTerritory(" .. idx .. ")")
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
    local npcWorkerCharacterKey = regionInfoWrapper:getNpcWorkerCharacterKey()
    if npcCheckActiveCondition(npcWorkerCharacterKey:get()) == true then
      townButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerRandomSelect_All_SelectTown(" .. regionKeyRaw .. ")")
      townButton:SetText(regionInfoWrapper:getAreaName() .. " (" .. waitWorkerCount .. "/" .. maxWorkerCount .. ")")
    else
      townButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorkerRandomSelect_All_CantSelectTown(" .. regionKeyRaw .. ")")
      townButton:SetText(regionInfoWrapper:getAreaName() .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_NO_EXPLORER") .. ")")
      UI.setLimitTextAndAddTooltip(townButton, townButton:GetText(), "")
    end
    townButton:SetShow(true)
    territoryButton:SetShow(false)
    townButton:SetCheck(regionKeyRaw == self._selectedRegionKeyRaw)
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_SelectTerritory(territoryKeyRaw)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  for index = 0, #self._territoryContentsOption do
    if self._territoryContentsOption[index] == true and territoryKeyRaw == index then
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
function PaGlobalFunc_WorkerRandomSelect_All_SelectTown(regionKeyRaw)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._isCurrectWorkerCondition == false or self._isContinueSelectWorkerStart == true then
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
  self._selectedRegionKeyRawTemp = regionKeyRaw
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  local waypointKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local regionName = regionInfoWrapper:getAreaName()
  if waitWorkerCount == maxWorkerCount then
    local function buyCash()
      if PaGlobalFunc_EasyBuy_Open ~= nil and waypointKey ~= nil then
        PaGlobalFunc_EasyBuy_Open(16, waypointKey)
      end
    end
    if isGameServiceTypeConsole() == false and _ContentsGroup_EasyBuy then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"), PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"), buyCash, nil, nil)
    else
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"), PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"), nil, nil, MessageBox_Empty_function)
    end
    PaGlobalFunc_WorkerRandomSelect_All_NotSelectTown()
    return
  end
  if wp < 5 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
    PaGlobalFunc_WorkerRandomSelect_All_NotSelectTown()
    return
  end
  local wpCharacterString = wp
  if _ContentsGroup_UseCharacterWp == true then
    wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKER_EMPLOY_SELECT_TOWN", "townName", regionName, "wp", wpCharacterString),
    functionYes = PaGlobalFunc_WorkerRandomSelect_All_SelectTownConfirm,
    functionNo = PaGlobalFunc_WorkerRandomSelect_All_NotSelectTown,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobalFunc_WorkerRandomSelect_All_SelectTownConfirm()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._selectedRegionKeyRawTemp == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerNotRegionSelected"))
    return
  end
  self._selectedRegionKeyRaw = self._selectedRegionKeyRawTemp
  local characterIndex = 0
  if _ContentsGroup_UseCharacterWp == true then
    characterIndex = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
  end
  ToClient_GetRandomNpcWorkerAtRegion(self._selectedRegionKeyRaw, characterIndex)
end
function PaGlobalFunc_WorkerRandomSelect_All_NotSelectTown()
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._selectedRegionKeyRawTemp ~= nil then
    local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, self._separatorNumber + self._selectedRegionKeyRawTemp))
    if uiContent ~= nil then
      UI.getChildControl(uiContent, "RadioButton_Town"):SetCheck(false)
    end
  end
  if self._selectedRegionKeyRaw ~= nil then
    local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, self._separatorNumber + self._selectedRegionKeyRaw))
    if uiContent ~= nil then
      UI.getChildControl(uiContent, "RadioButton_Town"):SetCheck(true)
    end
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_CantSelectTown(regionKeyRaw)
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if regionKeyRaw == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerNotRegionSelected"))
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  local regionName = regionInfoWrapper:getAreaName()
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKER_KNOWLEDGE_NONE", "townName", regionName))
  self._selectedRegionKeyRawTemp = regionKeyRaw
  PaGlobalFunc_WorkerRandomSelect_All_NotSelectTown()
end
function PaGlobalFunc_WorkerRandomSelect_All_NotifyBuyCashItemForMe()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  if Panel_Window_WorkerRandomSelect_All ~= nil and Panel_Window_WorkerRandomSelect_All:GetShow() == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  PaGlobalFunc_EasyBuy_Close()
  HandleEventLUp_WorkerRandomSelect_All_Close(true)
end
function FromClient_WorkerRandomSelect_AppliedChangeUseType(houseInfoSSWrapper)
  if Panel_Window_WorkerRandomSelect_All ~= nil and Panel_Window_WorkerRandomSelect_All:GetShow() == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  local houseKey = houseInfoSSWrapper:getHouseKey()
  local rentHouse = ToClient_GetRentHouseWrapper(houseKey)
  local currentUseType = rentHouse:getType()
  if currentUseType == 1 then
    self:updateWorkerCount()
  end
end
function FromClient_ResponseAddMyNpcWorker(characterKeyRaw, homePlantKeyRaw)
  if Panel_Window_WorkerRandomSelect_All ~= nil and Panel_Window_WorkerRandomSelect_All:GetShow() == false then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  PaGlobal_WorkerRandomSelect_All:prepareClose()
  if _ContentsGroup_UseCharacterWp == true and Panel_Window_UseCharacterWp_All:IsShow() == true then
    PaGlobalFunc_UseCharacterWp_All_Close()
  end
end
function PaGlobalFunc_WorkerRandomSelect_All_CheckCanHireWorker()
  if _ContentsGroup_WorkerImprovement == false then
    return
  end
  if Panel_Window_WorkerRandomSelect_All == nil then
    return
  end
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  if self._selectedRegionKeyRaw == 0 then
    return
  end
  local regionKeyRaw = self._selectedRegionKeyRaw
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if regionInfoWrapper == nil then
    return
  end
  local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
  if regionPlantKey == nil then
    return
  end
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  local waypointKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  if waitWorkerCount == maxWorkerCount then
    local function buyCash()
      if PaGlobalFunc_EasyBuy_Open ~= nil and waypointKey ~= nil then
        PaGlobalFunc_EasyBuy_Open(16, waypointKey)
      end
    end
    if isGameServiceTypeConsole() == false and _ContentsGroup_EasyBuy then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"),
        functionYes = buyCash,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"),
        content = PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
    return false
  end
  return true
end
function PaGlobalFunc_WorkerRandomSelect_All_SelectCharacterWp()
  local self = PaGlobal_WorkerRandomSelect_All
  if self == nil then
    return
  end
  PaGlobal_WorkerRandomSelect_All:updateWp()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local notSelectRegionText = UI.getChildControl(self._ui._stc_notSelectRegion, "StaticText_NotSelectRegion")
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local wpCharacterString = wp
  if _ContentsGroup_UseCharacterWp == true then
    wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
  end
  notSelectRegionText:SetTextMode(__eTextMode_AutoWrap)
  notSelectRegionText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKER_SELECT_TO_TOWN", "wp", wpCharacterString))
  local isReselectAble = wp >= 5
  if isReselectAble == true then
    if self._isConsole == true then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
      if _ContentsGroup_WorkerImprovement == true then
        Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()")
      end
    else
      PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(true)
      PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(false)
      PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(true)
      PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(false)
    end
  elseif self._isConsole == true then
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  else
    PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(false)
    PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(true)
    PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(false)
    PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(true)
  end
  if self._isConsole == true then
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(isReselectAble and self._selectedRegionKeyRaw ~= nil)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(isReselectAble and self._selectedRegionKeyRaw ~= nil)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerRandomSelect_All._keyGuides, PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
