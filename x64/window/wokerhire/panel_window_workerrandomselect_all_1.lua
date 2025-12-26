function PaGlobal_WorkerRandomSelect_All:initialize()
  if nil == Panel_Window_WorkerRandomSelect_All or true == PaGlobal_WorkerRandomSelect_All._initialize or nil == Panel_Window_WorkerRandomSelectOption_Grade_All then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Window_WorkerRandomSelect_All, "Static_MainTitleBar")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close_PCUI")
  self._ui._btn_Question_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Question_PCUI")
  self._ui._stc_workerPick = UI.getChildControl(Panel_Window_WorkerRandomSelect_All, "Static_WokerPick")
  self._ui._stc_ImgBg = UI.getChildControl(self._ui._stc_workerPick, "Static_ImageBg")
  self._ui._stc_WokerImg = UI.getChildControl(self._ui._stc_ImgBg, "Static_WorkerImage")
  self._ui._stc_WorkerTier = UI.getChildControl(self._ui._stc_WokerImg, "Static_Tier")
  self._ui._txt_WorkerName = UI.getChildControl(self._ui._stc_workerPick, "StaticText_WorkerType")
  self._ui._txt_WorkerSpeed = UI.getChildControl(self._ui._stc_workerPick, "StaticText_WorkSpeedValue")
  self._ui._txt_WokrerMoveSpeed = UI.getChildControl(self._ui._stc_workerPick, "StaticText_MoveSpeedValue")
  self._ui._txt_WokrerLuck = UI.getChildControl(self._ui._stc_workerPick, "StaticText_LuckValue")
  self._ui._txt_WorkerActionPoint = UI.getChildControl(self._ui._stc_workerPick, "StaticText_ActionPointValue")
  self._ui._stc_WorkerEmployBg = UI.getChildControl(self._ui._stc_workerPick, "Static_LeftEmploymentCountBg")
  self._ui._txt_WorkerEmployCount = UI.getChildControl(self._ui._stc_WorkerEmployBg, "StaticText_Value")
  self._ui._stc_CurrentEnergyBg = UI.getChildControl(self._ui._stc_workerPick, "Static_CurrentEnergyBg")
  self._ui._icon_CurrentEnergy = UI.getChildControl(self._ui._stc_CurrentEnergyBg, "Static_EnergyIcon")
  self._ui._txt_CurrentEnergy = UI.getChildControl(self._ui._stc_CurrentEnergyBg, "StaticText_Value")
  self._ui._stc_WorkerHireFeeBg = UI.getChildControl(self._ui._stc_workerPick, "Static_HireCostBg")
  self._ui._icon_WorkerHireFee = UI.getChildControl(self._ui._stc_WorkerHireFeeBg, "Static_MoneyIcon")
  self._ui._txt_WorkerHireFee = UI.getChildControl(self._ui._stc_WorkerHireFeeBg, "StaticText_Value")
  self._ui._stc_MoneyArea = UI.getChildControl(self._ui._stc_workerPick, "Static_MyMoneyArea")
  self._ui._txt_MoneyValue = UI.getChildControl(self._ui._stc_MoneyArea, "StaticText_MoneyValue")
  self._ui._btn_Continuation_PC = UI.getChildControl(self._ui._stc_workerPick, "Button_Continuation_PCUI")
  self._ui._btn_OtherWorker_PC = UI.getChildControl(self._ui._stc_workerPick, "Button_Other_PCUI")
  self._ui._btn_HireWorker_PC = UI.getChildControl(self._ui._stc_workerPick, "Button_Hire_PCUI")
  self._ui._stc_KeyGuideBg = UI.getChildControl(self._ui._stc_workerPick, "Static_BottomBG_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_X_With_RT = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_X_With_RT_ConsoleUI")
  self._ui._stc_KeyGuide_RT_With_X = UI.getChildControl(self._ui._stc_KeyGuide_X_With_RT, "StaticText_RT_With_X_ConsoleUI")
  self._ui._stc_Plus_ConsoleUI = UI.getChildControl(self._ui._stc_KeyGuide_X_With_RT, "Static_Plus_ConsoleUI")
  self._ui._list2_region = UI.getChildControl(Panel_Window_WorkerRandomSelect_All, "List2_Region")
  self._ui._stc_notSelectRegion = UI.getChildControl(Panel_Window_WorkerRandomSelect_All, "Static_NotSelectRegion")
  self._ui._stc_blockBg = UI.getChildControl(Panel_Window_WorkerRandomSelect_All, "Static_BlockBg")
  self._originPanelSpanY = Panel_Window_WorkerRandomSelect_All:GetSpanSize().y
  self._isConsole = _ContentsGroup_UsePadSnapping
  local imageBg = self._ui._stc_ImgBg
  local tierBg = self._ui._stc_WorkerTier
  local worKerImage = self._ui._stc_WokerImg
  self._ui._stc_WorkerImage[0] = UI.cloneControl(worKerImage, imageBg, "Static_WorkerImage_0")
  self._ui._stc_WorkerTierBg[0] = UI.cloneControl(tierBg, self._ui._stc_WorkerImage[0], "Static_WorkerTierBg_0")
  self._ui._stc_WorkerImage[1] = UI.cloneControl(worKerImage, imageBg, "Static_WorkerImage_1")
  self._ui._stc_WorkerTierBg[1] = UI.cloneControl(tierBg, self._ui._stc_WorkerImage[1], "Static_WorkerTierBg_1")
  self._ui._stc_WorkerImage[0]:ComputePos()
  self._ui._stc_WorkerTierBg[0]:ComputePos()
  self._ui._stc_WorkerImage[1]:ComputePos()
  self._ui._stc_WorkerTierBg[1]:ComputePos()
  self._ui._stc_WorkerImage[0]:SetShow(false)
  self._ui._stc_WorkerTierBg[0]:SetShow(false)
  self._ui._stc_WorkerImage[1]:SetShow(false)
  self._ui._stc_WorkerTierBg[1]:SetShow(false)
  imageBg:SetRectClipOnArea(float2(0, 0), float2(imageBg:GetSizeX(), imageBg:GetSizeY()))
  self._ui._list2_region:changeAnimationSpeed(10)
  self._ui._list2_region:setMinScrollBtnSize(float2(10, 50))
  self._ui._list2_region:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorkerRandomSelect_All_UpdateRegionList")
  self._ui._list2_region:createChildContent(__ePAUIList2ElementManagerType_Tree)
  self:validate()
  self:setUIControl()
  self:registerEventHandler()
  if _ContentsGroup_WorkerImprovement == true then
    local hierableRegionCount = ToClient_getWorkerHierableRegionListMaxCount()
    for index = 0, hierableRegionCount - 1 do
      local regionKey = ToClient_getWorkerHierableRegionKey(index)
      local regionInfo = getRegionInfoByRegionKey(regionKey)
      if regionInfo ~= nil then
        local regionKeyRaw = regionKey:get()
        local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
        local territoryOptionSize = #PaGlobal_WorkerRandomSelect_All._territoryContentsOption
        if territoryKeyRaw < 0 or territoryKeyRaw > territoryOptionSize then
          _PA_ASSERT_NAME(false, "\236\131\136\235\161\156\236\154\180 Territory\234\176\128 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. _territoryContentsOption\236\151\144 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
        end
        if self._territoryContentsOption[territoryKeyRaw] == true then
          local workerRegionData = {}
          workerRegionData.regionKeyRaw = regionKeyRaw
          workerRegionData.territoryKeyRaw = territoryKeyRaw
          table.insert(self._workerRegionList, workerRegionData)
        end
      end
    end
  end
end
function PaGlobal_WorkerRandomSelect_All:setUIControl()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  self._ui._stc_KeyGuideBg:SetShow(self._isConsole)
  self._ui._btn_Continuation_PC:SetShow(not self._isConsole)
  self._ui._btn_OtherWorker_PC:SetShow(not self._isConsole)
  self._ui._btn_HireWorker_PC:SetShow(not self._isConsole)
  self._ui._btn_Close_PC:SetShow(not self._isConsole)
  self._ui._btn_Question_PC:SetShow(not self._isConsole)
  local pcButtonSizeY = self._ui._btn_Continuation_PC:GetSizeY()
  local pcButtonSizeX = self._ui._btn_Continuation_PC:GetSizeY()
  local panelSizeY = Panel_Window_WorkerRandomSelect_All:GetSizeY()
  local panelSizeX = Panel_Window_WorkerRandomSelect_All:GetSizeX()
  if _ContentsGroup_WorkerImprovement == false then
    self._ui._list2_region:SetShow(false)
    self._ui._stc_notSelectRegion:SetShow(false)
    local list2Size = self._ui._list2_region:GetSizeX()
    panelSizeX = panelSizeX - list2Size
    Panel_Window_WorkerRandomSelect_All:SetSize(panelSizeX, panelSizeY)
    self._ui._stc_TitleBg:SetSize(panelSizeX, self._ui._stc_TitleBg:GetSizeY())
    self._ui._btn_Close_PC:SetPosX(self._ui._btn_Close_PC:GetPosX() - list2Size)
    self._ui._btn_Question_PC:SetPosX(self._ui._btn_Question_PC:GetPosX() - list2Size)
    self._ui._stc_workerPick:SetSize(panelSizeX, self._ui._stc_workerPick:GetSizeY())
    self._ui._stc_workerPick:SetPosX(self._ui._stc_workerPick:GetPosX() - list2Size)
    self._ui._stc_KeyGuideBg:SetSize(panelSizeX, self._ui._stc_KeyGuideBg:GetSizeY())
    self._ui._stc_KeyGuideBg:SetPosX(self._ui._stc_KeyGuideBg:GetPosX() - list2Size)
  end
  if true == self._isConsole then
    if _ContentsGroup_WorkerImprovement == false then
      Panel_Window_WorkerRandomSelect_All:SetSize(panelSizeX, panelSizeY - (pcButtonSizeY + 10))
      self._ui._stc_workerPick:SetSize(self._ui._stc_workerPick:GetSizeY(), self._ui._stc_workerPick:GetSizeY() - (pcButtonSizeY + 10))
      panelSizeY = Panel_Window_WorkerRandomSelect_All:GetSizeY()
      self._ui._stc_KeyGuideBg:SetPosY(panelSizeY - 10)
      self._ui._stc_KeyGuideBg:SetPosX(0)
    else
      Panel_Window_WorkerRandomSelect_All:SetSize(panelSizeX, panelSizeY - (pcButtonSizeY + 10))
      self._ui._stc_notSelectRegion:SetSize(self._ui._stc_notSelectRegion:GetSizeX(), self._ui._stc_notSelectRegion:GetSizeY() - (pcButtonSizeY + 10))
      self._ui._stc_workerPick:SetSize(self._ui._stc_workerPick:GetSizeY(), self._ui._stc_workerPick:GetSizeY() - (pcButtonSizeY + 10))
      self._ui._list2_region:SetSize(self._ui._list2_region:GetSizeX(), self._ui._list2_region:GetSizeY() - (pcButtonSizeY + 10))
      self._ui._list2_region:createChildContent(__ePAUIList2ElementManagerType_Tree)
      panelSizeY = Panel_Window_WorkerRandomSelect_All:GetSizeY()
      self._ui._stc_KeyGuideBg:SetPosY(panelSizeY - 10)
    end
    self._keyGuides = {
      self._ui._stc_KeyGuide_X_With_RT,
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_X,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if true == _ContentsOption_CH_Help then
    self._ui._btn_Question_PC:SetShow(false)
  end
end
function PaGlobal_WorkerRandomSelect_All:validate()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._stc_workerPick:isValidate()
  self._ui._stc_ImgBg:isValidate()
  self._ui._stc_WokerImg:isValidate()
  self._ui._txt_WorkerName:isValidate()
  self._ui._txt_WorkerSpeed:isValidate()
  self._ui._txt_WokrerMoveSpeed:isValidate()
  self._ui._txt_WokrerLuck:isValidate()
  self._ui._txt_WorkerActionPoint:isValidate()
  self._ui._stc_WorkerEmployBg:isValidate()
  self._ui._txt_WorkerEmployCount:isValidate()
  self._ui._stc_CurrentEnergyBg:isValidate()
  self._ui._icon_CurrentEnergy:isValidate()
  self._ui._txt_CurrentEnergy:isValidate()
  self._ui._stc_WorkerHireFeeBg:isValidate()
  self._ui._icon_WorkerHireFee:isValidate()
  self._ui._txt_WorkerHireFee:isValidate()
  self._ui._btn_Continuation_PC:isValidate()
  self._ui._btn_OtherWorker_PC:isValidate()
  self._ui._btn_HireWorker_PC:isValidate()
  self._ui._stc_KeyGuideBg:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_X_With_RT:isValidate()
  self._ui._stc_KeyGuide_RT_With_X:isValidate()
  self._ui._stc_Plus_ConsoleUI:isValidate()
  self._ui._stc_notSelectRegion:isValidate()
  self._ui._stc_blockBg:isValidate()
  self._initialize = true
end
function PaGlobal_WorkerRandomSelect_All:registerEventHandler()
  if nil ~= Panel_Window_WorkerRandomSelect_All and true == self._initialize then
    registerEvent("onScreenResize", "FromClient_WorkerRandomSelectOption_OnScreenResize()")
    registerEvent("FromClient_EventRandomShopShow", "FromClient_EventRandomShopShow_Worker()")
    if false == self._isConsole then
      if nil ~= Panel_Window_WorkerRandomSelectOption_All then
        self._ui._btn_Continuation_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
      end
      self._ui._btn_Continuation_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
      self._ui._btn_OtherWorker_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
      self._ui._btn_HireWorker_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelect_WorkerSelect()")
      self._ui._btn_Question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Worker\" )")
      PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question_PC, "\"Worker\"")
      self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelect_All_Close()")
    else
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelect()")
    end
    if _ContentsGroup_WorkerImprovement == true then
      registerEvent("FromClient_GetRandomNpcWorkerAtRegion", "FromClient_GetRandomNpcWorkerAtRegion()")
      registerEvent("FromClient_NotifyBuyCashItemForMe", "PaGlobalFunc_WorkerRandomSelect_All_NotifyBuyCashItemForMe()")
      registerEvent("FromClient_AppliedChangeUseType", "FromClient_WorkerRandomSelect_AppliedChangeUseType")
      registerEvent("FromClient_ResponseAddMyNpcWorker", "FromClient_ResponseAddMyNpcWorker")
      if self._isConsole == false then
        self._ui._btn_OtherWorker_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()")
        self._ui._btn_HireWorker_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerRandomSelect_WorkerSelectAtRegion()")
      else
        Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()")
        Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelectAtRegion()")
      end
    end
  end
end
function PaGlobal_WorkerRandomSelect_All:onScreenResize()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if true == self._isConsole then
    local keyGuideSize = self._ui._stc_KeyGuideBg:GetSizeY()
    Panel_Window_WorkerRandomSelect_All:SetSpanSize(0, self._originPanelSpanY)
    Panel_Window_WorkerRandomSelect_All:SetSpanSize(Panel_Window_WorkerRandomSelect_All:GetSpanSize().x, Panel_Window_WorkerAuction_All:GetSpanSize().y - (keyGuideSize + 20))
  end
  Panel_Window_WorkerRandomSelect_All:ComputePos()
end
function PaGlobal_WorkerRandomSelect_All:prepareClose()
  if nil == Panel_Window_WorkerRandomSelect_All and false == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  if true == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    HandleEventLUp_WorkerRandomSelectOption_All_Close()
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self._selectedCharacterKey = nil
  self._selectedRegionKeyRaw = nil
  self._verticalControlPos = 0
  self._list2CurrentIndex = 0
  self._selectedTerritoryKeyRaw = nil
  if _ContentsGroup_WorkerImprovement == true then
    self:closeRegionToggle()
  end
  self:clearData()
  self:close()
end
function PaGlobal_WorkerRandomSelect_All:clearData()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  Panel_Window_WorkerRandomSelect_All:ClearUpdateLuaFunc()
  self:setButtonWhilePerFrame(true)
  self._config._workerGrade = 0
  self._config._repetitionCount = 0
  self._delta_Time = 0
  self._isCurrectWorkerCondition = true
  self._isContinueSelectWorkerStart = false
  self:SetBlockBg(false)
  if true == self._isConsole then
    self:switchKeyGuide(false)
  end
  self._nextIndex = 0
end
function PaGlobal_WorkerRandomSelect_All:prepareOpen()
  if nil == Panel_Window_WorkerRandomSelect_All or true == Panel_Window_WorkerRandomSelect_All:GetShow() then
    return
  end
  self:clearData()
  self:isAuctionOpen()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  if _ContentsGroup_WorkerImprovement == true then
    if self._selectedRegionKeyRaw == nil then
      local selfPlayer = getSelfPlayer()
      if selfPlayer == nil then
        return
      end
      local wp = selfPlayer:getWp()
      if _ContentsGroup_UseCharacterWp == true then
        wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
      end
      self._ui._stc_notSelectRegion:SetShow(true)
      local notSelectRegionText = UI.getChildControl(self._ui._stc_notSelectRegion, "StaticText_NotSelectRegion")
      local wpCharacterString = wp
      if _ContentsGroup_UseCharacterWp == true then
        wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
      end
      notSelectRegionText:SetTextMode(__eTextMode_AutoWrap)
      notSelectRegionText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKER_SELECT_TO_TOWN", "wp", wpCharacterString))
      if self._isConsole == true then
        self._ui._stc_KeyGuide_X:SetShow(false)
        self._ui._stc_KeyGuide_Y:SetShow(false)
        self._ui._stc_KeyGuide_X_With_RT:SetShow(false)
      end
    else
      self._ui._stc_notSelectRegion:SetShow(false)
    end
    local verticalScroll = UI.getChildControl(self._ui._list2_region, "List2_1_VerticalScroll")
    self._ui._list2_region:moveIndex(self._list2CurrentIndex)
    verticalScroll:SetControlPos(self._verticalControlPos)
    self:SetBlockBg(false)
  end
  self:onScreenResize()
  if _ContentsGroup_UseCharacterWp == true and PaGlobalFunc_UseCharacterWp_All_Open ~= nil then
    PaGlobalFunc_UseCharacterWp_All_Open(PaGlobal_UseCharacterWp_All._openType._workerRandomSelect)
  end
  self:open()
  if _ContentsGroup_WorkerImprovement == true and self._isConsole == true and self._selectedRegionKeyRaw == nil then
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
    ToClient_padSnapChangeToTarget(self._ui._stc_notSelectRegion)
  end
end
function PaGlobal_WorkerRandomSelect_All:isAuctionOpen()
  if false == _ContentsGroup_NewUI_XXX then
    if false == PaGlobal_WorkerRandomSelect_All._isConsole and nil ~= Panel_Worker_Auction and true == Panel_Worker_Auction:GetShow() then
      WorkerAuction_Close()
    end
  elseif nil ~= Panel_Window_WorkerAuction_All and true == Panel_Window_WorkerAuction_All:GetShow() then
    HandleEventLUp_WorkerAuction_All_Close()
  end
end
function PaGlobal_WorkerRandomSelect_All:open()
  if nil ~= Panel_Window_WorkerRandomSelect_All then
    Panel_Window_WorkerRandomSelect_All:SetShow(true)
  end
end
function PaGlobal_WorkerRandomSelect_All:close()
  if nil ~= Panel_Window_WorkerRandomSelect_All then
    Panel_Window_WorkerRandomSelect_All:SetShow(false)
  end
end
function PaGlobal_WorkerRandomSelect_All:update(slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == slotNo or slotNo < 0 then
    PaGlobal_WorkerRandomSelect_All:close()
    return
  end
  PaGlobal_WorkerRandomSelect_All:setWorkerInfo(slotNo)
  PaGlobal_WorkerRandomSelect_All:updateMoney()
  if true == self._isConsole then
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
  end
end
function PaGlobal_WorkerRandomSelect_All:animateWorkerImage()
  self._ui._stc_WokerImg:SetShow(false)
  self._ui._stc_WorkerTier:SetShow(false)
  self._ui._stc_WorkerImage[0]:SetShow(true)
  self._ui._stc_WorkerImage[1]:SetShow(true)
  self._ui._stc_WorkerTierBg[0]:SetShow(true)
  self._ui._stc_WorkerTierBg[1]:SetShow(true)
  local beforeIndex = self._nextIndex
  self._nextIndex = (beforeIndex + 1) % 2
  local moveAni1 = self._ui._stc_WorkerImage[beforeIndex]:addMoveAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni1:SetStartPosition(1, 1)
  moveAni1:SetEndPosition(self._ui._stc_WorkerImage[beforeIndex]:GetSizeX() * -1, 1)
  local moveAni2 = self._ui._stc_WorkerImage[self._nextIndex]:addMoveAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni2:SetStartPosition(self._ui._stc_WorkerImage[self._nextIndex]:GetSizeX(), 1)
  moveAni2:SetEndPosition(1, 1)
end
function PaGlobal_WorkerRandomSelect_All:setWorkerInfo(slotNo)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  local sellCount = npcShop_getBuyCount()
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local pcPosition = selfPlayer:get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local regionPlantKey = regionInfo:getPlantKeyByWaypointKey()
  if nil == regionPlantKey then
    return
  end
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
  for index = 0, sellCount - 1 do
    local itemwrapper = npcShop_getItemBuy(index)
    local shopItem = itemwrapper:get()
    if slotNo == shopItem.shopSlotNo then
      PaGlobal_WorkerRandomSelect_All._currentWorkerinfo = {}
      PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerIdx = shopItem.shopSlotNo
      PaGlobal_WorkerRandomSelect_All._currentWorkerinfo._workerPrice64 = shopItem.price_s64
      local plantWorkerSS = itemwrapper:getPlantWorkerStaticStatus()
      local efficiency = plantWorkerSS:getEfficiency(2, ItemExchangeKey(0))
      local plantWorkerGrade = plantWorkerSS:getCharacterStaticStatus()._gradeType:get()
      local workerName = getWorkerName(plantWorkerSS)
      local workerNameByGrade = PaGlobal_WorkerRandomSelect_All:setNameByGrade(workerName, plantWorkerGrade)
      if nil ~= plantWorkerSS then
        local workerIconPath = getWorkerIcon(plantWorkerSS)
        PaGlobal_WorkerRandomSelect_All._ui._stc_WokerImg:ChangeTextureInfoNameAsync(workerIconPath)
        PaGlobal_WorkerRandomSelect_All._ui._stc_WokerImg:SetShow(true)
        PaGlobal_WorkerRandomSelect_All._ui._stc_WorkerTier:ChangeTextureInfoNameAsync(self._gradePath)
        PaGlobal_WorkerRandomSelect_All._ui._stc_WorkerTier:SetShow(true)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTier, self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
        self._ui._stc_WorkerTier:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_WorkerTier:setRenderTexture(self._ui._stc_WorkerTier:getBaseTexture())
        self._ui._stc_WorkerImage[0]:SetShow(false)
        self._ui._stc_WorkerImage[1]:SetShow(false)
        self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(self._gradePath)
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTierBg[self._nextIndex], self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
        self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._stc_WorkerTierBg[self._nextIndex]:setRenderTexture(self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture())
        self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(workerIconPath)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerActionPoint:SetText(plantWorkerSS._actionPoint)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerLuck:SetText(plantWorkerSS._luck / 10000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WokrerMoveSpeed:SetText(plantWorkerSS._moveSpeed / 100)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerSpeed:SetText(efficiency / 1000000)
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee:SetText(makeDotMoney(shopItem.price_s64))
        PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerName:SetText(workerNameByGrade)
      end
      local workerFeeText = PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerHireFee
      local workerIcon = PaGlobal_WorkerRandomSelect_All._ui._icon_WorkerHireFee
      workerIcon:SetPosX(workerFeeText:GetPosX() + workerFeeText:GetSizeX() - workerFeeText:GetTextSizeX() - workerIcon:GetSizeX() - 5)
      PaGlobal_WorkerRandomSelect_All._ui._txt_WorkerEmployCount:SetText(maxWorkerCount - waitWorkerCount)
      break
    end
  end
  PaGlobal_WorkerRandomSelect_All:updateWp()
  local isReselectAble = wp < 10
  if isReselectAble then
    if true == self._isConsole then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    else
      PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetEnable(false)
      PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC:SetMonoTone(true)
      PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetEnable(false)
      PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC:SetMonoTone(true)
    end
  elseif true == self._isConsole then
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
  if true == self._isConsole then
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(not isReselectAble)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(not isReselectAble)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerRandomSelect_All._keyGuides, PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WorkerRandomSelect_All:setNameByGrade(name, plantWorkerGrade)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if CppEnums.CharacterGradeType.CharacterGradeType_Normal == plantWorkerGrade then
    return "<PAColor0xFFB9C2DC>" .. name .. "<PAOldColor>"
  elseif CppEnums.CharacterGradeType.CharacterGradeType_Elite == plantWorkerGrade then
    return "<PAColor0xFF83A543>" .. name .. "<PAOldColor>"
  elseif CppEnums.CharacterGradeType.CharacterGradeType_Hero == plantWorkerGrade then
    return "<PAColor0xFF438DCC>" .. name .. "<PAOldColor>"
  elseif CppEnums.CharacterGradeType.CharacterGradeType_Legend == plantWorkerGrade then
    return "<PAColor0xFFF5BA3A>" .. name .. "<PAOldColor>"
  elseif CppEnums.CharacterGradeType.CharacterGradeType_Boss == plantWorkerGrade then
    return "<PAColor0xFFD05D48>" .. name .. "<PAOldColor>"
  elseif CppEnums.CharacterGradeType.CharacterGradeType_Assistant == plantWorkerGrade then
    return "<PAColor0xFFB9C2DC>" .. name .. "<PAOldColor>"
  else
    return "<PAColor0xFFB9C2DC>" .. name .. "<PAOldColor>"
  end
end
function PaGlobal_WorkerRandomSelect_All:updateMoney()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  PaGlobal_WorkerRandomSelect_All._ui._txt_MoneyValue:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
end
function PaGlobal_WorkerRandomSelect_All:updateWp()
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil ~= getSelfPlayer() then
    local selfPlayer = getSelfPlayer()
    local wp = selfPlayer:getWp()
    if _ContentsGroup_UseCharacterWp == true then
      wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
    end
    if wp < 0 then
      wp = 0
    end
    local HIRECOST = PaGlobal_WorkerRandomSelect_All._HIRECOST
    local wpIcon = PaGlobal_WorkerRandomSelect_All._ui._icon_CurrentEnergy
    local wpText = PaGlobal_WorkerRandomSelect_All._ui._txt_CurrentEnergy
    if _ContentsGroup_WorkerImprovement == true then
      wpText:SetText(wp)
    else
      wpText:SetText(wp - HIRECOST)
    end
    wpIcon:SetPosX(wpText:GetPosX() + wpText:GetSizeX() - wpText:GetTextSizeX() - wpIcon:GetSizeX() - 5)
  end
end
function PaGlobal_WorkerRandomSelect_All:switchKeyGuide(isStop)
  if false == self._isConsole then
    return
  end
  if true == isStop then
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_ALL_SELECTINGSTOP"))
  else
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
  end
end
function PaGlobal_WorkerRandomSelect_All:setButtonWhilePerFrame(value)
  if nil == Panel_Window_WorkerRandomSelect_All then
    return
  end
  if nil == value then
    value = true
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  if false == PaGlobal_WorkerRandomSelect_All._isConsole then
    local otherSelectBtn = PaGlobal_WorkerRandomSelect_All._ui._btn_OtherWorker_PC
    local ContinuationBtn = PaGlobal_WorkerRandomSelect_All._ui._btn_Continuation_PC
    if true == value and wp >= 5 then
      otherSelectBtn:SetEnable(true)
      otherSelectBtn:SetMonoTone(false)
      ContinuationBtn:SetEnable(true)
      ContinuationBtn:SetMonoTone(false)
    else
      otherSelectBtn:SetEnable(false)
      otherSelectBtn:SetMonoTone(true)
      ContinuationBtn:SetEnable(false)
      ContinuationBtn:SetMonoTone(true)
    end
  elseif true == value then
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelect()")
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_Y:SetShow(true)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_A:SetShow(true)
    if _ContentsGroup_WorkerImprovement == true then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelectAtRegion()")
    end
    if wp >= 5 then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_WorkerRandomSelectOption_All_Open()")
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelect()")
      PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(true)
      PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(true)
      if _ContentsGroup_WorkerImprovement == true then
        Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WorkerRandomSelect_WorkerReSelectAtRegion()")
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerRandomSelect_All._keyGuides, PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X_With_RT:SetShow(false)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_Y:SetShow(false)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_X:SetShow(false)
    PaGlobal_WorkerRandomSelect_All._ui._stc_KeyGuide_A:SetShow(false)
  end
end
function PaGlobal_WorkerRandomSelect_All:updateWorkerInfoAtRegion(regionKey, characterKey)
  if Panel_Window_WorkerRandomSelect_All == nil then
    return
  end
  self._selectedCharacterKey = characterKey
  self:setWorkerInfoAtRegion(regionKey, characterKey)
  if self._isConsole == true then
    ToClient_padSnapSetTargetPanel(Panel_Window_WorkerRandomSelect_All)
  end
  if self._selectedRegionKeyRaw == nil then
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return
    end
    local wp = selfPlayer:getWp()
    if _ContentsGroup_UseCharacterWp == true then
      wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
    end
    self._ui._stc_notSelectRegion:SetShow(true)
    local notSelectRegionText = UI.getChildControl(self._ui._stc_notSelectRegion, "StaticText_NotSelectRegion")
    notSelectRegionText:SetTextMode(__eTextMode_AutoWrap)
    local wpCharacterString = wp
    if _ContentsGroup_UseCharacterWp == true then
      wpCharacterString = wp .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
    end
    notSelectRegionText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKER_SELECT_TO_TOWN", "wp", wpCharacterString))
  else
    self._ui._stc_notSelectRegion:SetShow(false)
    self._ui._btn_HireWorker_PC:SetMonoTone(false)
    self._ui._btn_HireWorker_PC:SetIgnore(false)
    self._ui._btn_HireWorker_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRANDOMSELECT_BTN_WORKERSELECT"))
  end
end
function PaGlobal_WorkerRandomSelect_All:setWorkerInfoAtRegion(regionKey, characterKey)
  if Panel_Window_WorkerRandomSelect_All == nil then
    return
  end
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
  local efficiency = plantWorkerSS:getEfficiency(2, ItemExchangeKey(0))
  local plantWorkerGrade = plantWorkerSS:getCharacterStaticStatus()._gradeType:get()
  local workerName = getWorkerName(plantWorkerSS) .. "(" .. regionInfoWrapper:getAreaName() .. ")"
  local workerNameByGrade = self:setNameByGrade(workerName, plantWorkerGrade)
  local workerIconPath = getWorkerIcon(plantWorkerSS)
  self._ui._stc_WokerImg:ChangeTextureInfoNameAsync(workerIconPath)
  self._ui._stc_WokerImg:SetShow(true)
  self._ui._stc_WorkerImage[0]:SetShow(false)
  self._ui._stc_WorkerImage[1]:SetShow(false)
  self._ui._stc_WorkerTier:ChangeTextureInfoNameAsync(self._gradePath)
  self._ui._stc_WorkerTier:SetShow(true)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTier, self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
  self._ui._stc_WorkerTier:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_WorkerTier:setRenderTexture(self._ui._stc_WorkerTier:getBaseTexture())
  self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(self._gradePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_WorkerTierBg[self._nextIndex], self._grade[plantWorkerGrade][1], self._grade[plantWorkerGrade][2], self._grade[plantWorkerGrade][3], self._grade[plantWorkerGrade][4])
  self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_WorkerTierBg[self._nextIndex]:setRenderTexture(self._ui._stc_WorkerTierBg[self._nextIndex]:getBaseTexture())
  self._ui._stc_WorkerTierBg[self._nextIndex]:ChangeTextureInfoNameAsync(workerIconPath)
  self._ui._txt_WorkerActionPoint:SetText(plantWorkerSS._actionPoint)
  self._ui._txt_WokrerLuck:SetText(plantWorkerSS._luck / 10000)
  self._ui._txt_WokrerMoveSpeed:SetText(plantWorkerSS._moveSpeed / 100)
  self._ui._txt_WorkerSpeed:SetText(efficiency / 1000000)
  self._ui._txt_WorkerHireFee:SetText(makeDotMoney(buyPrice_s64))
  self._ui._txt_WorkerName:SetText(workerNameByGrade)
  UI.setLimitTextAndAddTooltip(self._ui._txt_WorkerName, self._ui._txt_WorkerName:GetText(), "")
  local workerFeeText = self._ui._txt_WorkerHireFee
  self._ui._icon_WorkerHireFee:SetPosX(workerFeeText:GetPosX() + workerFeeText:GetSizeX() - workerFeeText:GetTextSizeX() - self._ui._icon_WorkerHireFee:GetSizeX() - 5)
  PaGlobal_WorkerRandomSelect_All:updateWp()
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
  if self._isConsole == true then
    if _ContentsGroup_WorkerImprovement == true then
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelectAtRegion()")
    else
      Panel_Window_WorkerRandomSelect_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WorkerRandomSelect_WorkerSelect()")
    end
    self._ui._stc_KeyGuide_Y:SetShow(true)
    self._ui._stc_KeyGuide_X_With_RT:SetShow(isReselectAble)
    self._ui._stc_KeyGuide_X:SetShow(isReselectAble)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WorkerRandomSelect_All:setRegionData()
  if Panel_Window_WorkerRandomSelect_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  local currentRegionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if currentRegionInfoWrapper == nil then
    return
  end
  local currentTerritoryKeyRaw = currentRegionInfoWrapper:getTerritoryKeyRaw()
  local currentRegionKeyRaw = currentRegionInfoWrapper:getRegionKey()
  if self._selectedRegionKeyRaw ~= nil then
    local selectedRegionInfoWrapper = getRegionInfoWrapper(self._selectedRegionKeyRaw)
    if selectedRegionInfoWrapper == nil then
      return
    end
    currentTerritoryKeyRaw = selectedRegionInfoWrapper:getTerritoryKeyRaw()
    currentRegionKeyRaw = selectedRegionInfoWrapper:getRegionKey()
  end
  local currentTerritoryRegionTotalCount = 0
  local regionPositionValue = 0
  local territoryList = {}
  self._ui._list2_region:getElementManager():clearKey()
  for idx = 1, #self._workerRegionList do
    local workerRegionData = self._workerRegionList[idx]
    local treeElement = self._ui._list2_region:getElementManager():getByKey(toInt64(0, workerRegionData.territoryKeyRaw), false)
    if treeElement == nil then
      treeElement = self._ui._list2_region:getElementManager():getMainElement():createChild(toInt64(0, workerRegionData.territoryKeyRaw))
      table.insert(territoryList, workerRegionData.territoryKeyRaw)
    end
    treeElement:createChild(toInt64(0, workerRegionData.regionKeyRaw + self._separatorNumber))
    if workerRegionData.territoryKeyRaw == currentTerritoryKeyRaw then
      currentTerritoryRegionTotalCount = currentTerritoryRegionTotalCount + 1
      if workerRegionData.regionKeyRaw == currentRegionKeyRaw then
        regionPositionValue = currentTerritoryRegionTotalCount
      end
    end
  end
  for idx = 1, #territoryList do
    if territoryList[idx] ~= nil and territoryList[idx] ~= currentTerritoryKeyRaw then
      self._ui._list2_region:getElementManager():toggle(territoryList[idx])
    end
  end
  local totalCount = #territoryList + currentTerritoryRegionTotalCount
  local controlPos = currentTerritoryKeyRaw + regionPositionValue
  self._verticalControlPos = controlPos / totalCount
  self._list2CurrentIndex = currentTerritoryKeyRaw
end
function PaGlobal_WorkerRandomSelect_All:SetBlockBg(isBlock)
  if self._ui._stc_blockBg ~= nil then
    if isBlock == true then
      self._ui._stc_blockBg:SetShow(true)
      self._ui._stc_blockBg:SetIgnore(false)
      if _ContentsGroup_UseCharacterWp == true and PaGlobal_UseCharacterWp_All._ui._stc_blockBg ~= nil then
        PaGlobal_UseCharacterWp_All._ui._stc_blockBg:SetShow(true)
        PaGlobal_UseCharacterWp_All._ui._stc_blockBg:SetIgnore(false)
      end
    else
      self._ui._stc_blockBg:SetShow(false)
      self._ui._stc_blockBg:SetIgnore(true)
      if _ContentsGroup_UseCharacterWp == true and PaGlobal_UseCharacterWp_All._ui._stc_blockBg ~= nil then
        PaGlobal_UseCharacterWp_All._ui._stc_blockBg:SetShow(false)
        PaGlobal_UseCharacterWp_All._ui._stc_blockBg:SetIgnore(true)
      end
    end
  end
end
function PaGlobal_WorkerRandomSelect_All:closeRegionToggle()
  for idx = 0, #self._territoryContentsOption do
    if self._territoryContentsOption[idx] == true then
      local treeElement = self._ui._list2_region:getElementManager():getByKey(toInt64(0, idx), false)
      if treeElement ~= nil then
        treeElement:setIsOpen(false)
      end
    end
  end
  for idx = 0, #self._territoryContentsOption do
    if self._territoryContentsOption[idx] == true then
      local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, idx))
      if uiContent ~= nil then
        UI.getChildControl(uiContent, "RadioButton_Territory"):SetCheck(false)
      end
    end
  end
end
function PaGlobal_WorkerRandomSelect_All:updateWorkerCount()
  if self._selectedRegionKeyRaw ~= nil then
    local regionInfoWrapper = getRegionInfoWrapper(self._selectedRegionKeyRaw)
    if regionInfoWrapper == nil then
      return
    end
    local regionPlantKey = regionInfoWrapper:getPlantKeyByWaypointKey()
    if regionPlantKey == nil then
      return
    end
    local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
    local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
    local hierableWorkerCount = maxWorkerCount - waitWorkerCount
    self._ui._txt_WorkerEmployCount:SetText(hierableWorkerCount)
  end
  self._ui._list2_region:getElementManager():clearKey()
  self:setRegionData()
  local verticalScroll = UI.getChildControl(self._ui._list2_region, "List2_1_VerticalScroll")
  self._ui._list2_region:moveIndex(self._list2CurrentIndex)
  verticalScroll:SetControlPos(self._verticalControlPos)
end
